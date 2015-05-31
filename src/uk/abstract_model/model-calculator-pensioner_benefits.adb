with Ada.Assertions;
with GNATColl.Traces;
with Model.Calculator.Utils;

package body Model.Calculator.Pensioner_Benefits is

   use Ada.Assertions;
   
   log_trace : GNATColl.Traces.Trace_Handle := 
      GNATColl.Traces.Create( "MODEL.CALCULATOR.PENSIONER_BENEFITS" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   procedure Log( s : String; m : Amount ) is
   begin
      GNATColl.Traces.Trace( log_trace, s & " = " & Format( m ));
   end Log;
   

   procedure Calculate_State_Pension( 
      sys      : Pension_System; 
      bu       : Model.Abstract_Household.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class ) is
   begin
      -- FIXME add a contribution ratio like taxben used to have
      -- FIXME Child additions, spouse additions
      -- contributions ???
      for pno in 1 .. bu.Get_Num_People loop
         declare
            pers : Model.Abstract_Household.Person'Class renames bu.Get_Person( pno );
         begin
            if( pers.gender = male and pers.age >= sys.age_men ) or 
              ( pers.gender = female and pers.age >= sys.age_women )then
                  res.Set( pno, retirement_pension, sys.class_a );
            end if;
         end;
      end loop;
  end Calculate_State_Pension;
      
  procedure Calculate_Guaranteed_Pension_Credit(
      gpcsys   : Guaranteed_Credit_System;
      pensys   : Pension_System; 
      bu       : Model.Abstract_Household.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class ) is
      is_couple    : Boolean := bu.Is_Couple;
      income       : Amount := 0.0;
      num_carers   : Person_Count := 0;
      num_disabled : Person_Count := 0;
      additional_amounts : Amount := 0.0;
      mig                : Amount := 0.0;
      standard_guarantee : Amount;
      has_non_dependent_adult : Boolean := False; -- FIXME we have to look at all other BUs for this, too.
   begin
      if( not Test_Ages( bu, pensys.age_men, pensys.age_women ))then
         return;
      end if;
      if( is_couple )then
         standard_guarantee := gpcsys.couple;
      else
         standard_guarantee := gpcsys.single;
      end if;
      for adno in 1 .. bu.num_adults loop
         null;   
         
      end loop;
      -- TODO
      Log( "GPC: MIG", mig );
      Log( "GPC: Additional Amounts", additional_amounts );
      Log( "GPC: Standard Guarantee", standard_guarantee );
      Log( "GPC: Income", income );
      Log( "GPC: amount = ", res.Get( 1, pension_credit ));
   end Calculate_Guaranteed_Pension_Credit;
  
   procedure Calculate_Savings_Credit(
      sys      : Savings_Credit_System; 
      bu       : Model.Abstract_Household.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class ) is

      qualifying_income : Amount := 0.0;
      threshold         : Amount := 0.0;
      income            : Amount := 0.0;
      maximum           : Amount := 0.0;
      excess_income     : Amount := 0.0;
      credit            : Amount := 0.0;
      income_over_mig   : Amount := 0.0;
      is_couple         : constant Boolean := bu.Is_Couple;
   begin
      if( not Test_Ages( bu, 60, 60 ))then
         return;
      end if;
      qualifying_income := Utils.Calculate_Incomes( 
         bu, 
         res, 
         sys.qualifying_incomes );
      if( is_couple )then
         maximum := sys.maximum_couple;
         threshold := sys.threshold_couple;
      else
         maximum := sys.maximum_single;
         threshold := sys.threshold_single;
      end if;
      excess_income := Amount'Max( 0.0, qualifying_income - threshold );
      if( excess_income <= 0.0 )then
         credit := 0.0;
      else
         excess_income := excess_income * sys.withdrawal_rate/100.0;
         if( excess_income < maximum )then
            credit := excess_income;
         else
            income_over_mig := Amount'Max( 0.0, income - res.Get( minimum_income_guarantee ));
            credit := maximum - (( 1.0 - sys.withdrawal_rate/100.0 ) * income_over_mig );
         end if;
         credit := Amount'Min( credit, maximum );
         credit := Amount'Max( 0.0, credit );
      end if;
        
      res.Set( 1, pension_credit, credit, add );
      
      Log( "CS: Excess Income", excess_income );
      Log( "CS: Maximum", maximum );
      Log( "CS: Income", income );
      Log( "CS: Qualifying Income", qualifying_income );
      Log( "CS: Threshold", threshold );
      Log( "CS: Income over MIG ", income_over_mig );
      Log( "CS: Withdrawal Rate ", sys.withdrawal_rate );
      Log( "CS: Savings Credit", credit );
   end Calculate_Savings_Credit; 
      
   function Test_Ages( 
      bu        : Model.Abstract_Household.Benefit_Unit'Class;
      age_men   : Age_Range;
      age_women : Age_Range ) return Boolean is 
   begin
      for pno in 1 .. bu.Get_Num_People loop
         declare 
            pers : Model.Abstract_Household.Person'Class := bu.Get_Person( pno );
         begin
            if( pers.gender = male and pers.age > age_men ) or 
              ( pers.gender = female and pers.age > age_women ) then
                  return True;
            end if;
         end;
      end loop;
      return False;
   end Test_Ages;
   
end Model.Calculator.Pensioner_Benefits;
