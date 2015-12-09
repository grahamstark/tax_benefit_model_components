with Ada.Assertions;
with Ada.Exceptions;
with Model.Calculator.Direct_Tax;
with Ada.Text_IO;
with GNATColl.Traces;
with Model.Calculator.Utils;

package body Model.Calculator.Universal_Credit is
   use Ada.Assertions;
   use Ada.Text_IO;

   ex : Exception;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.CALCULATOR.Universal_Credit" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   procedure Log( s : String; m : Amount ) is
   begin
      GNATColl.Traces.Trace( log_trace, s & " = " & Format( m ));
   end Log;

   procedure Calculate_Child_Benefit(
     sys           : Child_Benefit_System;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out mar.Benefit_Unit_Result'Class ) is
     num_children : Person_Count := 0;
     pids    : constant Sernum_Set := bu.Get_Pids;
   begin
      for pid of pids loop
         declare
           pers : Model.Abstract_Household.Person'Class renames bu.Find_Person( pid );
           age  : Age_Range := pers.Age;
         begin
            if pers.Family_Relationship in child .. foster_child then
               if( age <= 18 ) or ( age <= 21 and pers.Employment = in_education )then
                  num_children := num_children + 1;
               end if;
            end if;
         end;
      end loop;
      if num_children > 0 then
         declare
            bpno : constant Sernum_Value := Utils.Get_Benefit_Unit_Carer( bu );
         begin
            res.Set( bpno, child_benefit, sys.first_child ); 
            if( num_children > 1 )then
              res.Set( bpno, 
                       child_benefit, 
                       sys.additional_children * Amount( num_children - 1 ), add );
            end if;
         end;
      end if;
   end Calculate_Child_Benefit;

   --
   -- FIXME change this so the household is sent, and benefit units are arranged as needed
   -- internally. 
   -- FIXME add something to optionally count/not count foster children
   procedure Calculate_Universal_Credit(
     sys           : Universal_Credit_System;
     tenure        : Broad_Tenure_Type;
     housing_costs : Housing_Array;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out mar.Benefit_Unit_Result'Class ) is
        
     pids          : constant Sernum_Set := bu.Get_Pids;
     child_pids    : constant Sernum_Set := 
        bu.Get_Pids( 0, 18, child, other_relationship ); -- FIXME this is wrong for children >16 not in education
     adult_pids    : constant Sernum_Set := pids.Difference( child_pids );
     
     num_people                  : constant Person_Count := Person_Count( pids.Length );
     num_adults                  : constant Person_Count := Person_Count( adult_pids.Length );
     num_children                : constant Person_Count := 
        Child_Count'Min( Person_Count( child_pids.Length ), sys.maximum_number_of_children );
     maximum_benefit             : constant Amount :=
        ( if num_people = 1 then sys.maximum_payment_singles
          else sys.maximum_payment_families );
     earned_income               : Amount := 0.0;
     unearned_income             : Amount := 0.0;
     total_allowance             : Amount := 0.0;
     disregard                   : Amount := 0.0;
     standard_allowance          : Amount := 0.0;
     child_element               : Amount := 0.0;
     additional_child_element    : Amount := 0.0; -- TODO
     -- housing_allowance           : Amount  := 0.0;
     capability_for_work_element : Amount := 0.0; -- TODO
     head_pid                    : constant Sernum_Value := 
        Utils.Get_Head_Of_Benefit_Unit( bu );
     head                        : Model.Abstract_Household.Person'Class :=
        bu.Find_Person( head_pid );
     payment                     : Amount := 0.0;
  begin
     Log( "p1 " & head.Age'Img & " relationship " & head.Family_Relationship'Img );
     if head.Age >= 65 or head.employment = in_education then
        Log( "Calculate_Universal_Credit; returning" );
        return;
        -- "should be on pension credit" ); -- FIXME that's not right        
     end if;
     Assert( num_people > 0 and 
        ( num_people = ( num_adults + num_children ) or num_children = sys.maximum_number_of_children ),
        "num people mismatch people " & num_people'Img &
        " adults " & num_adults'Img &
        " children " & num_children'Img );
     case num_adults is
        when 1 =>
           if head.Age < 25 then
              standard_allowance := sys.allowances.single_claimant_aged_under_25;
           else
              standard_allowance := sys.allowances.single_claimant_aged_25_or_over;
           end if;
     when 2 =>
        declare
           sppid : Sernum_Value := Utils.Get_Spouse_Of_Head( bu, head_pid );
           spouse : Model.Abstract_Household.Person'Class := bu.Find_Person( sppid );
        begin
           Log( "p2 " & bu.Find_Person( sppid ).Age'Img & " relationship " & bu.Find_Person( sppid ).Family_Relationship'Img );
           -- assert is adult somehow
           if( head.Age < 25 and spouse.Age < 25 )then
              standard_allowance := sys.allowances.joint_claimants_both_aged_under_25;
           else
              standard_allowance := sys.allowances.joint_claimants_either_aged_25_or_over;
           end if;
        end;
      when others =>
         Log( "Universal Credit BUG !!! > 2 adults in BU " & num_adults'Img );
         -- Ada.Exceptions.Raise_Exception( ex'Identity, "> 2 adults in BU " & num_adults'Img );
      end case;
      if( num_children > 0 )then
        child_element := sys.allowances.first_child_or_qualifying_young_person +
            sys.allowances.second_and_each_subsequent_child_or_qualifying_young_person * Amount( Child_Count'Max( 0, num_children-1 ));
      end if;
     -- TODO carer, Capability for work elements, Childcare costs element,
     -- Additional amount for disabled child or qualifying young person
     -- Housing : todo Mortgages     
      if( tenure in Rented ) then
         if( bu.Get_Benefit_Unit_Type = secondary ) or ( num_adults = 1 and head.Age in 22 .. 35 and num_children = 0 ) then -- FIXME: this is WRONG 22 and under and *formerly Fostered* which 
            res.Set( head_pid, housing_allowance, sys.one_bedroom_in_shared_accommodation_rate );
         else
            res.Set( head_pid, housing_allowance, housing_costs( rent ));
         end if;
      end if;
      -- end if;
      -- TODO NDDs, bedroom limits ...
      Log( "Universal Credit::child_element ", child_element );
      Log( "Universal Credit::housing_allowance ", res.Get( housing_allowance ));
      Log( "Universal Credit::standard_allowance ", standard_allowance );
      total_allowance :=
          standard_allowance +
          child_element +
          additional_child_element +
          res.Get( housing_allowance ) +
          capability_for_work_element;
      Log( "Universal Credit::total_allowance ", total_allowance );

      -- you are single and claim housing costs and you:
      --
      -- are not responsible for a child or qualifying young person - £111 a month
      -- are responsible for one or more children or qualifying young persons - £263 a month
      -- have a limited capability to work - £192 a month
      if( res.Get( housing_allowance ) = 0.0 )then
         if( num_adults = 1 )then
            if( num_children = 0 )then
               disregard := sys.disregards.single_no_housing_no_children;
            else
               disregard := sys.disregards.single_no_housing_with_children;
            end if;
            -- TODO single_no_housing_limited_work_capacity : Amount := 647.0*12.0;
         else
            if( num_children = 0 )then
               disregard := sys.disregards.couple_no_housing_no_children;
            else
               disregard := sys.disregards.couple_no_housing_with_children;
            end if;
            -- couple_no_housing_limited_work_capacity : Amount := 647.0*12.0;
         end if;
      else
         if( num_adults = 1 )then
            if( num_children = 0 )then
               disregard := sys.disregards.single_with_housing_no_children;
            else
               disregard := sys.disregards.single_with_housing_with_children;
            end if;
            -- TODO single_no_housing_limited_work_capacity : Amount := 647.0*12.0;
         else
            if( num_children = 0 )then
               disregard := sys.disregards.couple_with_housing_no_children;
            else
               disregard := sys.disregards.couple_with_housing_with_children;
            end if;
	    -- TODO couple_no_housing_limited_work_capacity : Amount := 647.0*12.0;
         end if;
      end if;
      Log("Universal Credit::disregard ", disregard );
      -- FIXME this has to be wrong
      for pid of pids loop
         declare
           incomes : constant Incomes_List :=
         	Utils.Combine_Incomes( 
         	   bu.Find_Person( pid ).Get_Incomes, res.Get( pid ));
           -- not right, should just be paye and NI
           earn : constant Amount :=
               Amount'Max( 0.0,
                  T_Incomes.Sum(
                     incomes, sys.earned_income ) - incomes( income_tax ) - incomes( national_insurance ));
           unearn : constant Amount := T_Incomes.Sum( incomes, sys.unearned_income );
         begin
           Log( "Universal Credit::wages " & pid'Img, incomes( wages ));
           Log( "Universal Credit::earnings person " & pid'Img, earn );
           Log( "Universal Credit::unearned  person " & pid'Img, unearn );
           earned_income := earned_income + earn;
           unearned_income := unearned_income + unearn;
         end;
      end loop;
      earned_income := Amount'Max( 0.0, earned_income - disregard );
      Log( "Universal Credit::total earnings after disgregard", earned_income );
      Log( "Universal Credit::total unearned", unearned_income );
      payment := Amount'Max( 0.0, total_allowance - unearned_income - sys.withdrawal_rate * earned_income );
      Log( "Universal Credit::total_payment", payment );
      payment := Amount'Min( payment, maximum_benefit );
      res.Set( head_pid, housing_benefit, 
         Amount'Min( payment, res.Get( housing_allowance )));
      res.Set( head_pid, tax_credits, 
         payment - res.Get( head_pid ).Get( housing_benefit ));
  end Calculate_Universal_Credit;

end Model.Calculator.Universal_Credit;
