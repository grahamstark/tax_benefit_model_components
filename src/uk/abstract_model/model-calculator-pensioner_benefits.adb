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
   
   function Is_At_Pension_Age( 
      pers : mah.Person'Class; 
      sys  : Pension_System ) return Boolean is
   begin
      return ( pers.gender = male and pers.age >= sys.age_men ) or 
             ( pers.gender = female and pers.age >= sys.age_women );
   end Is_At_Pension_Age;


   procedure Calculate_State_Pension( 
      sys      : Pension_System; 
      bu       : mah.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class ) is
      pids : Sernum_Set := bu.Get_Pids( start_age => 60, end_age=>Age_Range'Last );
   begin
      -- FIXME add a contribution ratio like taxben used to have
      -- FIXME Child additions, spouse additions
      -- contributions ???
      for pid of pids loop
         declare
            pers : mah.Person'Class renames bu.Find_Person( pid );
         begin
            if Is_At_Pension_Age( pers, sys ) then
                  res.Set( pid, retirement_pension, sys.class_a );
            end if;
         end;
      end loop;
  end Calculate_State_Pension;
      
  procedure Calculate_Guaranteed_Pension_Credit(
      gpcsys   : Guaranteed_Credit_System;
      pensys   : Pension_System; 
      bu       : mah.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class ) is
      is_couple    : Boolean := bu.Is_Couple;
      income       : Amount := 0.0;
      num_carers   : Person_Count := 0;
      num_disabled : Person_Count := 0;
      additional_amounts : Amount := 0.0;
      mig                : Amount := 0.0;
      standard_guarantee : Amount;
      gpc : Amount;
      has_non_dependent_adult : Boolean := False; -- FIXME we have to look at all other BUs for this, too.
      pids : Sernum_Set := bu.Get_Pids( start_age => 18, end_age=>Age_Range'Last );
      heads_pid : Sernum_Value := Utils.Get_Head_Of_Benefit_Unit( bu );
   begin
      if( not Test_Ages( bu, pensys.age_men, pensys.age_women ))then
         return;
      end if;
      if is_couple then
         standard_guarantee := gpcsys.couple;
      else
         standard_guarantee := gpcsys.single;
      end if;
      for pid of pids loop
         declare
            pers   : mah.Person'Class renames bu.Find_Person( pid );
            incset : Incomes_Set := 
               Utils.Which_Incomes_Received( pers.Get_Incomes, res.Get( pid ));
         begin
            if not incset.Intersection( Utils.DISAB_SET ).Is_Empty then
               num_disabled := num_disabled + 1;
            end if;
            if not incset.Intersection( Utils.CARE_SET ).Is_Empty then
               num_carers := num_carers + 1;
            end if;
         end;
      end loop;
      if( num_disabled >= 2 ) then
         additional_amounts := gpcsys.severe_disability_couple;
      elsif( num_disabled = 1 )then
         additional_amounts := gpcsys.severe_disability_single;
      end if;
      if( num_carers >= 1 )then
         additional_amounts := additional_amounts + gpcsys.carer_single;
      end if;
      mig := standard_guarantee + additional_amounts;
      Assert( mig > 0.0, "MIG Must be positive; was " & Format( mig ));
      
      Log( "GPC: MIG", mig );
      Log( "GPC: Additional Amounts", additional_amounts );
      Log( "GPC: Standard Guarantee", standard_guarantee );
      
      income := Utils.Calculate_Incomes( 
         bu, 
         res, 
         gpcsys.incomes );
      Log( "GPC: Income", income );
      Assert( income >= 0.0, " income must be non-negative " & Format( income ));
      -- FIXME not person 1? bu.head_id ??
      gpc := Amount'Max( 0.0, mig - income );
      res.Set( heads_pid, pension_credit, gpc ); 
      Log( "GPC: amount = ", gpc );
   end Calculate_Guaranteed_Pension_Credit;
  
   procedure Calculate_Savings_Credit(
      sys      : Savings_Credit_System; 
      bu       : mah.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class ) is

      qualifying_income : Amount := 0.0;
      threshold         : Amount := 0.0;
      income            : Amount := 0.0;
      maximum           : Amount := 0.0;
      excess_income     : Amount := 0.0;
      credit            : Amount := 0.0;
      income_over_mig   : Amount := 0.0;
      is_couple         : constant Boolean := bu.Is_Couple;
      pids : Sernum_Set := bu.Get_Pids;
      heads_pid : Sernum_Value := Utils.Get_Head_Of_Benefit_Unit( bu );
   begin
      if( not Test_Ages( bu, 60, 60 ))then
         return;
      end if;
      qualifying_income := Utils.Calculate_Incomes( 
         bu, 
         res, 
         sys.qualifying_incomes );
      income := Utils.Calculate_Incomes( 
         bu, 
         res, 
         sys.incomes );
         
      if is_couple then
         maximum := sys.maximum_couple;
         threshold := sys.threshold_couple;
      else
         maximum := sys.maximum_single;
         threshold := sys.threshold_single;
      end if;
      excess_income := Amount'Max( 0.0, qualifying_income - threshold );
      Log( "qualifying income " & qualifying_income'Img );
      Log( "threshold " & threshold'Img );
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
        
      res.Set( heads_pid, pension_credit, credit, add );
      
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
      bu        : mah.Benefit_Unit'Class;
      age_men   : Age_Range;
      age_women : Age_Range ) return Boolean is 
      pids : Sernum_Set := bu.Get_Pids;
   begin
      for pid of pids loop
         declare 
            pers : mah.Person'Class := bu.Find_Person( pid );
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
