with Ada.Assertions;
with GNATColl.Traces;
with Model.Calculator.Utils;
with Model.Calculator.Pensioner_Benefits;

package body Model.Calculator.Direct_Tax is
   
   use Ada.Assertions;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.CALCULATOR.DIRECT_TAX" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   procedure Log( s : String; m : Amount ) is
   begin
      GNATColl.Traces.Trace( log_trace, s & " = " & Format( m ));
   end Log;
   
   use GNATColl.Traces;
   
   function Get_Net_Income(
      pers  : Model.Abstract_Household.Person'Class;
      res   : mar.Personal_Result'Class ) return Amount is
      pinc : constant Incomes_List := pers.Get_Incomes;
      net : Amount := 0.0;
   begin
      for i in Non_Calculated_Incomes_Range loop
         Inc( net, pinc( i ));
      end loop;
      for i in income_tax .. repayments loop
         Dec( net, res.Get( i ));
      end loop;
      for i in education_allowances .. tax_credits  loop
         Inc( net, res.Get( i ));
      end loop;
      -- Dec( net, res.childs_contributions );
      -- Inc( net, res.student_accommodation_costs );
      return net;
   end Get_Net_Income;
-- 
   -- procedure Accumulate_To_HHld_Level(
      -- hh    : Model.Abstract_Household.Household'Class;
      -- res   : in out mar.Household_Result'Class;
      -- which : Broad_Calculated_Type ) is
      -- inc : Amount := 0.0;
   -- begin
      -- for buno in 1 .. hh.Get_Num_Benefit_Units loop
         -- declare
            -- bu : Model.Abstract_Household.Benefit_Unit'Class renames hh.Get_Benefit_Unit( buno );
         -- begin
            -- for pno in 1 .. bu.Get_Num_People loop
               -- inc := res.Get( buno ).Get( pno ).Get( which );
               -- res.Set( which, inc, add );
            -- end loop;
         -- end;
      -- end loop;
   -- end Accumulate_To_HHld_Level;
   --
   
   function Calculate_Class_2_NICs( 
      ni_sys  : National_Insurance_System;
      profits : Amount ) return Amount is
   begin
      return ( if profits < ni_sys.class_2_exemption then 0.0 else ni_sys.class_2_rate ); 
   end Calculate_Class_2_NICs;
   
   function Calculate_Class_4_NICs( 
      ni_sys  : National_Insurance_System;
      profits : Amount ) return Amount is
        taxable_profits : constant Amount := profits - ni_sys.class_4_lower_profit_limit;
   begin
      if taxable_profits <= 0.0 then
         return 0.0;
      end if;
      return UK_Tax_Utils.Calc_Tax_Due(
            ni_sys.class_4_rates, taxable_profits ).due;
   end Calculate_Class_4_NICs;
   
   function Calculate_Employers_NICs(
      ni_sys                 : National_Insurance_System;
      earnings               : Amount_Array;
      is_contracted_out      : Boolean;
      other_taxable_benefits : Amount;
      rebate                 : Amount )return Amount is
      total_earn : Amount := 0.0;
      ni_due     : Amount;
      rbs        : constant Rates_And_Bands := 
         ( if is_contracted_out and not ni_sys.contracting_out_abolished then
            ni_sys.employer_out_rates else ni_sys.employer_in_rates );
   begin
      for earn of earnings loop
         Inc( total_earn, Amount'Max( 0.0, earn - ni_sys.secondary_threshold ));
      end loop;
      Inc( total_earn, other_taxable_benefits );
      ni_due := UK_Tax_Utils.Calc_Tax_Due( rbs, total_earn ).due;
      return Amount'Max( ni_due - rebate, 0.0 );
   end Calculate_Employers_NICs;
   
   function Calculate_Class_1_NICs( 
      ni_sys            : National_Insurance_System;
      earnings          : Amount_Array;
      is_contracted_out : Boolean ) return Amount is
      class_1_nics : Amount := 0.0;
      rebate       : Amount := 0.0;
      is_over_lel  : constant Boolean := (for some earn of earnings => earn > ni_sys.class_1_lower_earnings_limit );
      is_cont_out  : constant Boolean := is_contracted_out and not ni_sys.contracting_out_abolished;
      rbs          : constant Rates_And_Bands := 
         ( if is_contracted_out and not ni_sys.contracting_out_abolished then
            ni_sys.employer_out_rates else ni_sys.employer_in_rates );
   begin
      if not is_over_lel then
         return 0.0;
      end if;
      Trace( log_trace, "is_over_lel=" & is_over_lel'Img & " is_cont_out " & is_cont_out'Img );
      for earn of earnings loop
         Trace( log_trace, " earn " & Format( earn ));
         Inc( class_1_nics, UK_Tax_Utils.Calc_Tax_Due( rbs, earn ).due );
         if is_cont_out then
            if earn > ni_sys.class_1_lower_earnings_limit and earn < ni_sys.primary_threshold then
               Inc( rebate, ni_sys.class_1_rebate * ( ni_sys.primary_threshold - earn ));
            end if;
         end if;
      end loop;
      return class_1_nics - rebate;
   end Calculate_Class_1_NICs;
   
   function Calculate_Maximum_NICs(
      ni_sys            : National_Insurance_System;
      earnings          : Amount_Array;
      profits           : Amount;
      is_contracted_out : Boolean ) return Amount is
      income : Amount := 0.0;
      rbs    : constant Rates_And_Bands := 
         ( if is_contracted_out and not ni_sys.contracting_out_abolished then
            ni_sys.employer_out_rates else ni_sys.employer_in_rates );
      
   begin
      for earn of earnings loop
         Inc( income, earn );
      end loop;
      Inc( income, Amount'Max( 0.0, profits - ni_sys.primary_threshold ));
      Inc( income, ni_sys.primary_threshold );
      return UK_Tax_Utils.Calc_Tax_Due( rbs, income ).due;
   end Calculate_Maximum_NICs; 
    
   procedure Calculate_National_Insurance(
      ni_sys  : National_Insurance_System;
      pen_sys : Pension_System; -- to feed in pension age       
      ad      : Model.Abstract_Household.Person'Class;
      res     : in out mar.Personal_Result'Class ) is
      profits  : constant Amount :=  ad.Get_Income( self_employment );
      earnings : constant Amount_Array := ad.Get_Earnings;
      ni       : Amount := 0.0;
      maximum_ni : Amount;
      empl_ni  : Amount;
      rebate   : Amount := 0.0;
      is_contracted_out : constant Boolean := not ad.Is_Contracted_In_To_Serps;
   begin
      if ad.age < 16 or Pensioner_Benefits.Is_At_Pension_Age( ad, pen_sys )then
         return;
      end if;
      Trace( log_trace, "at start of NI; earnings.length = " & earnings'Length'Img & " pid= " & ad.pid'Img );
      maximum_ni := Calculate_Maximum_NICS( ni_sys, earnings, profits, is_contracted_out );
      Trace( log_trace, "maximum ni " & Format( maximum_ni ));
      if earnings'Length > 1 or ( earnings'Length = 1 and earnings( 1 ) > 0.0 ) then
         ni := Calculate_Class_1_NICs( ni_sys, earnings, is_contracted_out );
         Trace( log_trace, "class1 ni=" & Format( ni ));
         if ni < 0.0 then
            rebate := -ni;
         end if;
         empl_ni := Calculate_Employers_NICs( ni_sys, earnings, is_contracted_out, 0.0, rebate );
         if( ni < 0.0 )then
            empl_ni := Amount'Max( 0.0, empl_ni - ni );
            ni := 0.0;
         end if;
      end if;
      if profits > 0.0 then
         Inc( ni, Calculate_Class_4_NICs( ni_sys, profits ));    
         Inc( ni, Calculate_Class_2_NICs( ni_sys, profits ));    
      end if;
      ni := Amount'Min( maximum_ni, ni );
      res.Set( national_insurance, ni );
      res.Set( employers_ni, empl_ni );
   end Calculate_National_Insurance;
   
   procedure Apply_Allowance(
      income    : in out Amount; 
      allowance : in out Amount ) is
      original_income : constant Amount := income;
   begin
      Assert( allowance >= 0.0,
         "We allowed a negative allowance here " & Format( allowance ));
      income := Amount'Max( income - allowance, 0.0 );
      allowance := Amount'Max( 0.0, allowance - original_income );
   end Apply_Allowance;

   function Get_Dividend_Credit_Rate( dividends_income_rates : Rates_And_Bands ) return Rate is
   begin
      return dividends_income_rates.Get_Rate_And_Band( 1 ).rate;
   end  Get_Dividend_Credit_Rate;

   procedure Calculate_Income_Tax(
      sys : Income_Tax_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out mar.Personal_Result'Class ) is
   use type Incomes_Set;
   use T_Incomes;
      incomes                : constant Incomes_List :=
         Utils.Combine_Incomes( ad.Get_Incomes, res );
         -- Incomes_Included
      all_incomes            : constant Incomes_Included := 
         sys.non_savings_income +
         sys.savings_income +
         sys.dividends_income;
         
      total_income         : constant Amount := T_Incomes.Sum( incomes, all_incomes );
      reliefs              : constant Amount := 0.0; -- FIXME
      net_income           : constant Amount := total_income - reliefs;
      non_savings_income   : Amount := T_Incomes.Sum( incomes, sys.non_savings_income );
      savings_income       : Amount := T_Incomes.Sum( incomes, sys.savings_income );
      dividends_income     : Amount := T_Incomes.Sum( incomes, sys.dividends_income );
      non_savings_tax      : Tax_Result;
      savings_tax          : Tax_Result;
      dividends_tax        : Tax_Result;
      dividend_credit_rate : constant Rate := Get_Dividend_Credit_Rate( sys.dividend_income_rates );
      dividend_credit      : constant Amount := dividend_credit_rate * incomes( dividends );
      allowance            : Amount := sys.personal_allowance;
      income_tax_amount    : Amount;
   begin
      --
      --
      --
      Log( "incomes components " & To_String( incomes ));
      Log( "Total Income ",  total_income );
      Log( "allowance ", allowance );
      Log( "savings_income ", savings_income );
      Log( "dividends_income ", dividends_income );
      Log( "dividend_credit_rate ", dividend_credit_rate );
      Log( "dividend credit ", dividend_credit );
      res.Set( taxable_income, total_income );
      Apply_Allowance( non_savings_income, allowance );
      Apply_Allowance( savings_income, allowance );
      Apply_Allowance( dividends_income, allowance );
      non_savings_tax := UK_Tax_Utils.Calc_Tax_Due(
         sys.non_savings_income_rates, non_savings_income );
      declare
         savings_rates : Rates_And_Bands := sys.savings_income_rates;
      begin
         -- Log( "sys.savings_rates.Length=" & savings_rates.Length'Img );
         Remove_Up_To( savings_rates, non_savings_income );
         savings_tax := UK_Tax_Utils.Calc_Tax_Due(
            savings_rates, savings_income );
      end;
      declare
         dividend_rates : Rates_And_Bands := sys.dividend_income_rates;
      begin
         Remove_Up_To( dividend_rates, non_savings_income+savings_income );
         dividends_tax := UK_Tax_Utils.Calc_Tax_Due(
            dividend_rates, dividends_income );
      end;
      Log("non_savings_tax ", non_savings_tax.due );
      Log("savings_tax ", savings_tax.due );
      Log("dividends_tax ", dividends_tax.due );
      -- step 6 various reliefs we're ignoring here (married couple ... )
      -- step 7 To the Step 6 figure, add certain other amounts of tax,
      -- such as the pensions annual allowance charge (Chapter 3).
      income_tax_amount := non_savings_tax.due + savings_tax.due + dividends_tax.due;
      res.Set( income_tax, Amount'Max( 0.0, income_tax_amount - dividend_credit ));
   end Calculate_Income_Tax;
   
   
   
-- 
   -- procedure Calculate_National_Insurance(
      -- ni_sys  : National_Insurance_System;
      -- pen_sys : Pension_System; -- to feed in pension age       
      -- ad      : Model.Abstract_Household.Person'Class;
      -- res     : in out mar.Personal_Result'Class ) is
      -- earnings : constant Amount := ad.Get_Income( wages );
   -- begin
      -- if( ad.gender = male and ad.age < pen_sys.age_men ) or 
        -- ( ad.gender = female and ad.age < pen_sys.age_women )then
-- 
         -- if( ad.Is_Contracted_In_To_Serps )then
               -- res.Set( national_insurance, 
                  -- UK_Tax_Utils.Calc_Tax_Due(
                     -- ni_sys.employee_in_rates, earnings ).due );
               -- res.Set( employers_ni, 
                  -- UK_Tax_Utils.Calc_Tax_Due(
                     -- ni_sys.employer_in_rates, earnings ).due );
         -- else
               -- res.Set( national_insurance, 
                  -- UK_Tax_Utils.Calc_Tax_Due(
                     -- ni_sys.employee_out_rates, earnings ).due );
               -- res.Set( employers_ni, 
                  -- UK_Tax_Utils.Calc_Tax_Due(
                     -- ni_sys.employer_out_rates, earnings ).due );
         -- end if;
      -- end if;
   -- end Calculate_National_Insurance;
 -- 
end Model.Calculator.Direct_Tax;
