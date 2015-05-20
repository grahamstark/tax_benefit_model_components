with Model_Types;
with Ada.Assertions;
with Ada.Exceptions;
with Model.Calculator.Direct_Tax;
with Ada.Text_IO;

package body Model.Calculator.Universal_Benefit is
   use Model_Types;
   use Ada.Assertions;
   use Ada.Text_IO;

  ex : Exception;
  
   procedure Calculate_Child_Benefit(
     sys           : Child_Benefit_System;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out Benefit_Unit_Result ) is
     num_children : Person_Count := 0;
   begin
      for i in 2 .. bu.Get_Num_People loop
         declare
           pers : Model.Abstract_Household.Person'Class renames bu.Get_Person( i );
           age  : Age_Range := pers.Age;
           educ : Education_Type := pers.Education_Status;
         begin
            if pers.Family_Relationship in child .. foster_child then
               if( age <= 18 ) or ( age <= 21 and educ in school .. further_education )then
                  num_children := num_children + 1;
               end if;
            end if;
         end;
        -- FIXME we can't just assign to 1st person, really
        res.pers( 1 ).incomes( child_benefit ) := res.pers( 1 ).incomes( child_benefit ) + sys.first_child; 
        if( num_children > 1 )then
           res.pers( 1 ).incomes( child_benefit ) := res.pers( 1 ).incomes( child_benefit ) +
             sys.additional_children * Amount( num_children - 1 );
        end if;
      end loop;
   end Calculate_Child_Benefit;

   --
   -- FIXME change this so the household is sent, and benefit units are arranged as needed
   -- internally. 
   -- FIXME add something to optionally count/not count foster children
   procedure Calculate_Universal_Benefit(
     sys           : Universal_Credit_System;
     tenure        : Tenure_Type;
     housing_costs : Housing_Array;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out Benefit_Unit_Result ) is
     num_children                : constant Person_Count := 
        bu.Get_Num_People( 0, 18, child, other_relationship, 2 );
     num_adults                  : constant Person_Count := Age_Range'Max( 1,
        bu.Get_Num_People( 16, Age_Range'Last, head, civil_partner ) +
        bu.Get_Num_People( 19, 99, foster_child, other_relationship, 1 ));
     num_people                  : constant Person_Count := bu.Get_Num_People;
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
     head                        : Model.Abstract_Household.Person'Class :=
        bu.Get_Person( 1 );
     payment                     : Amount := 0.0;
  begin
     Put_Line( "p1 " & head.Age'Img & " relationship " & head.Family_Relationship'Img );
     if( bu.Get_Num_People > 1 )then
        Put_Line( "p2 " & bu.Get_Person( 2 ).Age'Img & " relationship " & bu.Get_Person( 2 ).Family_Relationship'Img );
     end if;
     if head.Age >= 65 or head.employment = in_education then
        Put_Line( "Calculate_Universal_Benefit; returning" );
        return;
        -- "should be on pension credit" ); -- FIXME that's not right        
     end if;
     Assert( num_people > 0 and ( num_people = ( num_adults + num_children )),
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
           spouse : Model.Abstract_Household.Person'Class := bu.Get_Person( 2 );
        begin
           -- assert is adult somehow
           if( head.Age < 25 and spouse.Age < 25 )then
              standard_allowance := sys.allowances.joint_claimants_both_aged_under_25;
           else
              standard_allowance := sys.allowances.joint_claimants_either_aged_25_or_over;
           end if;
        end;
      when others =>
        Ada.Exceptions.Raise_Exception( ex'Identity, "> 2 adults in BU " & num_adults'Img );
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
            res.housing_allowance := sys.one_bedroom_in_shared_accommodation_rate;
         else
            res.housing_allowance := housing_costs( rent );
         end if;
      end if;
      -- end if;
      -- TODO NDDs, bedroom limits ...
      Add_To_Map( res.intermed, "Universal Credit::child_element ", child_element );
      Add_To_Map( res.intermed, "Universal Credit::housing_allowance ", res.housing_allowance );
      Add_To_Map( res.intermed, "Universal Credit::standard_allowance ", standard_allowance );
      total_allowance :=
          standard_allowance +
          child_element +
          additional_child_element +
          res.housing_allowance +
          capability_for_work_element;
      Add_To_Map( res.intermed, "Universal Credit::total_allowance ", total_allowance );

      -- you are single and claim housing costs and you:
      --
      -- are not responsible for a child or qualifying young person - £111 a month
      -- are responsible for one or more children or qualifying young persons - £263 a month
      -- have a limited capability to work - £192 a month
      if( res.housing_allowance = 0.0 )then
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
      Add_To_Map( res.intermed, "Universal Credit::disregard ", disregard );
      -- FIXME this has to be wrong
      for pno in 1 .. bu.Get_Num_People loop
         declare
           incomes : constant Incomes_List :=
         	Model.Calculator.Direct_Tax.Combine_Incomes( bu.Get_Person( pno ).Get_Incomes, res.pers( pno ).incomes );
           -- not right, should just be paye and NI
           earn : constant Amount :=
               Amount'Max( 0.0,
                  T_Incomes.Sum(
                     incomes, sys.earned_income ) - incomes( income_tax ) - incomes( national_insurance ));
           unearn : constant Amount := T_Incomes.Sum( incomes, sys.unearned_income );
         begin
           Add_To_Map( res.intermed, "Universal Credit::wages " & pno'Img, incomes( wages ));
           Add_To_Map( res.intermed, "Universal Credit::earnings person " & pno'Img, earn );
           Add_To_Map( res.intermed, "Universal Credit::unearned  person " & pno'Img, unearn );
           earned_income := earned_income + earn;
           unearned_income := unearned_income + unearn;
         end;
      end loop;
      earned_income := Amount'Max( 0.0, earned_income - disregard );
      Add_To_Map( res.intermed, "Universal Credit::total earnings after disgregard", earned_income );
      Add_To_Map( res.intermed, "Universal Credit::total unearned", unearned_income );
      payment := Amount'Max( 0.0, total_allowance - unearned_income - sys.withdrawal_rate * earned_income );
      Add_To_Map( res.intermed, "Universal Credit::total_payment", payment );
      payment := Amount'Min( payment, maximum_benefit );
      res.pers( 1 ).incomes( housing_benefit ) := Amount'Min( payment, res.housing_allowance );
      res.pers( 1 ).incomes( tax_credits ) := payment - res.pers( 1 ).incomes( housing_benefit );
  end Calculate_Universal_Benefit;

end Model.Calculator.Universal_Benefit;
