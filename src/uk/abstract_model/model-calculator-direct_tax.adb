with Model_Types;
with Ada.Assertions;

package body Model.Calculator.Direct_Tax is
   use Model_Types;
   use Ada.Assertions;
   
   function Get_Net_Income(
      pers  : Model.Abstract_Household.Person'Class;
      res   : Model.Results.Personal_Result ) return Amount is
      pinc : constant Incomes_List := pers.Get_Incomes;
      cinc : constant Incomes_List := res.incomes;
      net : Amount := 0.0;
   begin
      for i in Non_Calculated_Incomes_Range loop
         Inc( net, pinc( i ));
      end loop;
      for i in income_tax .. repayments loop
         Dec( net, cinc( i ));
      end loop;
      for i in education_allowances .. tax_credits  loop
         Inc( net, cinc( i ));
      end loop;
      Dec( net, res.childs_contributions );
      Inc( net, res.student_accommodation_costs );
      return net;
   end Get_Net_Income;

   procedure Make_Household_Taxable_Income(
      hh  : Model.Abstract_Household.Household'Class;
      res : in out Model.Results.Household_Result ) is
      i : Amount := 0.0;
   begin
      res.total_taxable_income := 0.0;
      res.num_benefit_units := hh.Get_Num_Benefit_Units; 
      for buno in 1 .. res.num_benefit_units loop
         res.bus( buno ).total_taxable_income := 0.0;
         declare
            bu : Model.Abstract_Household.Benefit_Unit'Class renames hh.Get_Benefit_Unit( buno );
         begin
            res.bus( buno ).num_people := bu.Get_Num_People;
            for pno in 1 .. res.bus( buno ).num_people loop
               res.total_taxable_income := res.total_taxable_income + res.bus( buno ).pers( pno ).total_taxable_income;
               res.bus( buno ).total_taxable_income := res.bus( buno ).total_taxable_income + res.bus( buno ).pers( pno ).total_taxable_income;
            end loop;
         end;
      end loop;
   end Make_Household_Taxable_Income;

   procedure Make_Household_Net_Income(
      hh  : Model.Abstract_Household.Household'Class;
      res : in out Model.Results.Household_Result ) is
      i : Amount := 0.0;
   begin
      res.net_income := 0.0;
      res.num_benefit_units := hh.Get_Num_Benefit_Units; 
      for buno in 1 .. res.num_benefit_units loop
         res.bus( buno ).net_income := 0.0;
         declare
            bu : Model.Abstract_Household.Benefit_Unit'Class renames hh.Get_Benefit_Unit( buno );
         begin
            res.bus( buno ).num_people := bu.Get_Num_People;
            for pno in 1 .. res.bus( buno ).num_people loop
               res.bus( buno ).pers( pno ).net_income := Get_Net_Income(
                  bu.Get_Person( pno ),
                  res.bus( buno ).pers( pno ));
               res.net_income := res.net_income + res.bus( buno ).pers( pno ).net_income;
               res.bus( buno ).net_income := res.bus( buno ).net_income + res.bus( buno ).pers( pno ).net_income;
            end loop;
         end;
      end loop;
   end Make_Household_Net_Income;

   procedure Apply_Allowance(
      income : in out Amount; allowance : in out Amount ) is
      original_income : constant Amount := income;
   begin
      Assert( allowance >= 0.0,
         "We allowed a negative allowance here " & Format( allowance ));
      income := Amount'Max( income - allowance, 0.0 );
      allowance := Amount'Max( 0.0, allowance - original_income );
   end Apply_Allowance;

   function Combine_Incomes(
      non_calculated : Incomes_List;
      calculated : Incomes_List ) return Incomes_List is
      il : Incomes_List;
   begin
     for i in Incomes_List'Range loop
        if( i in Calculated_Incomes_Range )then
           il( i ) := calculated( i );
        else
           il( i ) := non_calculated( i );
        end if;
     end loop;
     return il;
   end Combine_Incomes;

   function Get_Dividend_Credit_Rate( dividends_income_rates : Rates_And_Bands ) return Rate is
   begin
      return dividends_income_rates.Get_Rate_And_Band( 1 ).rate;
   end  Get_Dividend_Credit_Rate;

   procedure Calculate_Income_Tax(
      sys : Income_Tax_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out Model.Results.Personal_Result ) is
   use type Incomes_Set;
      incomes                : constant Incomes_List :=
         Combine_Incomes( ad.Get_Incomes, res.incomes );
      all_incomes            : constant Incomes_Set :=
         sys.non_savings_income or
         sys.savings_income or
         sys.dividends_income;
      total_income        : constant Amount := T_Incomes.Sum( incomes, all_incomes );
      reliefs             : constant Amount := 0.0;
      net_income          : constant Amount := total_income - reliefs;
      non_savings_income  : Amount := T_Incomes.Sum( incomes, sys.non_savings_income );
      savings_income      : Amount := T_Incomes.Sum( incomes, sys.savings_income );
      dividends_income    : Amount := T_Incomes.Sum( incomes, sys.dividends_income );
      non_savings_tax     : Tax_Result;
      savings_tax         : Tax_Result;
      dividends_tax       : Tax_Result;
      dividend_credit_rate : constant Rate := Get_Dividend_Credit_Rate( sys.dividend_income_rates );
      dividend_credit      : constant Amount := dividend_credit_rate * incomes( dividends );
      allowance            : Amount := sys.personal_allowance;
   begin
      Add_To_Map( res.intermed, "non_savings_income ", non_savings_income );
      Add_To_Map( res.intermed, "savings_income ", savings_income );
      Add_To_Map( res.intermed, "dividends_income ", dividends_income );
      Add_To_Map( res.intermed, "dividend_credit_rate ", dividend_credit_rate );
      Add_To_Map( res.intermed, "dividend credit ", dividend_credit );
      res.total_taxable_income := total_income;
      Apply_Allowance( non_savings_income, allowance );
      Apply_Allowance( savings_income, allowance );
      Apply_Allowance( dividends_income, allowance );
      non_savings_tax := UK_Tax_Utils.Calc_Tax_Due(
         sys.non_savings_income_rates, non_savings_income );
      declare
         savings_rates : Rates_And_Bands := sys.savings_income_rates;
      begin
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
      Add_To_Map( res.intermed, "non_savings_tax ", non_savings_tax.due );
      Add_To_Map( res.intermed, "savings_tax ", savings_tax.due );
      Add_To_Map( res.intermed, "dividends_tax ", dividends_tax.due );
      -- step 6 various reliefs we're ignoring here (married couple ... )
      -- step 7 To the Step 6 figure, add certain other amounts of tax,
      -- such as the pensions annual allowance charge (Chapter 3).
      res.incomes( income_tax ) := non_savings_tax.due + savings_tax.due + dividends_tax.due;
      res.incomes( income_tax ) := Amount'Max( 0.0, res.incomes( income_tax ) - dividend_credit );
   end Calculate_Income_Tax;

   procedure Calculate_National_Insurance(
      sys : National_Insurance_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out Personal_Result ) is
      earnings : constant Amount := ad.Get_Income( wages );
   begin
      if( ad.Is_Contracted_In_To_Serps )then
            res.incomes( national_insurance ) := UK_Tax_Utils.Calc_Tax_Due(
                sys.employee_in_rates, earnings ).due;
            res.employers_ni := UK_Tax_Utils.Calc_Tax_Due(
                sys.employer_in_rates, earnings ).due;
      else
            res.incomes( national_insurance ) := UK_Tax_Utils.Calc_Tax_Due(
                sys.employee_out_rates, earnings ).due;
            res.employers_ni := UK_Tax_Utils.Calc_Tax_Due(
                sys.employer_out_rates, earnings ).due;
      end if;
   end Calculate_National_Insurance;
   

end Model.Calculator.Direct_Tax;
