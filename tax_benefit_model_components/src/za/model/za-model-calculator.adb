--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

with Ada.Assertions;
with Indirect_Tax_Utils;
with Ada.Text_IO;
with ZA.Model.Takeup;

package body ZA.Model.Calculator is

   use Ada.Assertions;
   use ZA.Model.Takeup;
   
   function Get_Personal_Allowance_Sum( pa : Per_Person_Allowance; num_people : Person_Count ) return Amount is
      sum : Amount := 0.0;
   begin
      for pno in 1 .. num_people loop
         sum := sum + pa( pno );
      end loop;
      return sum;
   end Get_Personal_Allowance_Sum;
   
   function Get_Taxable_Income( 
      incomes                 : Income_Array; 
      taxable_items           : Included_Income_Array; 
      employers_contributions : Personal_Expenses_Array;
      taxable_contributions   : Allowable_Expenses_Array;
      deductables             : Personal_Expenses_Array;
      allowable_deductions    : Allowable_Expenses_Array ) return Amount is
      income : constant Amount := 
         Calculate_Income( incomes, taxable_items );
      in_kind_expenses : constant Amount :=
         Calculate_Expenses( employers_contributions, taxable_contributions ); 
      deductions : constant Amount :=     
         Calculate_Expenses( deductables, allowable_deductions );
      taxable : constant Amount := 
         Amount'Max( 0.0, income + in_kind_expenses - deductions );
   begin
      log( income_tax, "Get_Taxable_Income; deductions " & Format( deductions ));
      log( income_tax, "Get_Taxable_Income; in_kind expenses " & Format( in_kind_expenses ));
      log( income_tax, "Get_Taxable_Income; income " & Format( income ));
      log( income_tax, "Get_Taxable_Income; taxable_income " & Format( taxable ));
      return taxable; 
   end Get_Taxable_Income;
   
   procedure Calculate_Pension_Allowances(
      pers           : in Person_Rec;
      params         : in Income_Tax_Rec;
      settings       : in Run_Settings;
      result         : in out Personal_Result ) is
      
      ALLOWABLE_EXPENSES    : constant Allowable_Expenses_Array :=
         ( others=>0.0 );
      TAXABLE_IN_KIND       : constant Allowable_Expenses_Array :=
         ( others => 0.0 ); -- FIXME think about this & check
      taxable_income  : constant Amount := Get_Taxable_Income(
                  result.income,
                  params.taxable_income,
                  pers.in_kind_and_from_employer_expenses,
                  TAXABLE_IN_KIND,
                  result.deductions,
                  ALLOWABLE_EXPENSES
               );
      pension_contribution_max : constant Amount := 
         Amount'Max( 
            params.pension_income_limitation_rate * taxable_income,
            params.pension_contribution_limit );
      pension_contribution : constant Amount := 
         pers.expenses( pension_contributions ) +
         pers.in_kind_and_from_employer_expenses( pension_contributions );
      annuity_contributions : constant Amount := 
         pers.expenses( annuity_funds_contributions ) +
         pers.in_kind_and_from_employer_expenses( annuity_funds_contributions );
      annuity_max : Amount;   
   begin
      result.deductions( pension_contributions ) := 
         Amount'Min( pension_contribution_max, pension_contribution );
      annuity_max := Amount'Max(
         params.pension_contribution_limit,
         params.annuity_contribution_limit - 
            result.deductions( pension_contributions ));
      annuity_max := Amount'Max( 
         annuity_max,
         params.annuity_income_limitation_rate * taxable_income );   
      result.deductions( annuity_funds_contributions ) := 
         Amount'Min( annuity_max, annuity_contributions );
      log( income_tax, "Calculate_Pension_Allowances Pension  pension_contribution_max " & Format( pension_contribution_max ));
      log( income_tax, "Calculate_Pension_Allowances Pension  taxable income " & Format( taxable_income ));
   end Calculate_Pension_Allowances;
   
   
   procedure Calculate_Health_Allowances( 
      pers           : in Person_Rec;
      family         : in Family_Unit_Rec;
      params         : in Income_Tax_Rec;
      settings       : in Run_Settings;
      result         : in out Personal_Result ) is
      ALLOWABLE_EXPENSES    : constant Allowable_Expenses_Array :=
         ( health_insurance => 0.0, health_spending=> 0.0, others=>1.0 );
      TAXABLE_IN_KIND       : constant Allowable_Expenses_Array :=
         ( others => 0.0 ); -- FIXME think about this & check
      total_health_spending : constant Amount := 
         pers.in_kind_and_from_employer_expenses( health_insurance ) +
         pers.in_kind_and_from_employer_expenses( health_spending ) +         
         pers.expenses( health_insurance ) +
         pers.expenses( health_spending ); 
         amount_allowable_as_deduction   : Amount := 0.0;
   begin
      if( family.age_of_oldest_person >= params.health_age_limit ) or
        ( family.has_disabled_member and params.health_allow_all_for_disabled ) then
        amount_allowable_as_deduction := total_health_spending;
         log( income_tax, 
            "is disabled or over 64; returning with result.deductions( health_insurance ) = " &
            Format( amount_allowable_as_deduction ));
      else
         declare
            emp_excess                      : Amount := 0.0; 
            capped_amount                   : Amount := 0.0;
            employers_cont_in_gross         : Amount := 0.0;
            additional_capping              : Amount := 0.0;
            amount_subject_to_limitation    : Amount := 0.0;
            income_before_medical_deduction : Amount := 0.0;
            calculated_limitation           : Amount := 0.0;
            capped_amount_deduction         : Amount := 0.0;
            taxable_income                  : Amount := 0.0;
         begin
            capped_amount  := 
               Get_Personal_Allowance_Sum( 
                  params.health_capped_amount_per_person, family.num_people );
            emp_excess := 
               pers.in_kind_and_from_employer_expenses( health_insurance ) - 
                     capped_amount;
         
            if( emp_excess > 0.0 ) then
               employers_cont_in_gross := emp_excess;   
               capped_amount_deduction := 0.0;
               capped_amount := 0.0;
            else
               capped_amount_deduction := -1.0*emp_excess;
            end if;
            amount_subject_to_limitation :=  
               employers_cont_in_gross +
               pers.expenses( health_insurance ) +
               pers.expenses( health_spending ) - 
               capped_amount_deduction;         
            amount_subject_to_limitation := 
               Amount'Max( amount_subject_to_limitation, 0.0 );
            taxable_income := Get_Taxable_Income(
                  result.income_less_exemptions,
                  params.taxable_income,
                  pers.in_kind_and_from_employer_expenses,
                  TAXABLE_IN_KIND,
                  result.deductions,
                  ALLOWABLE_EXPENSES
               );

            income_before_medical_deduction :=
               taxable_income +
               employers_cont_in_gross - 
               additional_capping -
               capped_amount;
            calculated_limitation := params.health_income_limitation_rate * 
               income_before_medical_deduction;  
            amount_allowable_as_deduction := 
                      amount_subject_to_limitation - 
                      calculated_limitation + 
                      capped_amount_deduction;
            
            amount_allowable_as_deduction := Amount'Max( 0.0,  amount_allowable_as_deduction );
            amount_allowable_as_deduction := 
               Amount'Min( total_health_spending, amount_allowable_as_deduction ); 
            -- result.income_tax.intermediate.health := hr;
            log( income_tax, "Calculate_Health_Allowances #1 " & 
               "total_health_spending = " & Format( total_health_spending )  &
               "capped_amount = " & Format( capped_amount )  &
               "employers_cont_in_gross = " & Format( employers_cont_in_gross ) & 
               "taxable income for health calc purposes " & Format( taxable_income ));
            log( income_tax, "Calculate_Health_Allowances #2 " &
               "additional_capping = " & Format( additional_capping )  &
               "amount_subject_to_limitation = " & Format( amount_subject_to_limitation )  &
               "income_before_medical_deduction = " & Format( income_before_medical_deduction )  &
               "calculated_limitation = " & Format( calculated_limitation )  &
               "amount_allowable_as_deduction = " & Format( amount_allowable_as_deduction ));
         end;
         result.deductions( health_insurance ) := amount_allowable_as_deduction;
      end if;
   end Calculate_Health_Allowances;
   
   procedure Calculate_SITE(
      pers           : in Person_Rec;
      family         : in Family_Unit_Rec;
      params         : in Income_Tax_Rec; 
      settings       : in Run_Settings;
      rebate         : in Amount;
      result         : in out Personal_Result ) is
      taxable_income : Amount;
      tresult        : Tax_Result;
      ALLOWABLE_EXPENSES    : constant Allowable_Expenses_Array :=
         ( others=>1.0 );
      TAXABLE_IN_KIND       : constant Allowable_Expenses_Array :=
         ( others => 1.0 ); -- FIXME think about this & check
      interest_exemption : Amount;
   begin
      --
      -- disregared income
      -- FIXME argh!!! married in community of property!! nothing we can do. 
      -- FIXME foreign interest
      if( pers.age < params.age_limit( pers.gender ))then
        interest_exemption := params.interest_exemption;
      else
        interest_exemption := params.age_interest_exemption;
      end if;
      result.income_less_exemptions( interest_received ) := 
         Amount'Max( 0.0, 
            result.income( interest_received ) - interest_exemption );
      --
      -- allowances (1) everything from travel to work
      --
      result.deductions( travel_to_work ) := pers.expenses( travel_to_work ) +
         pers.in_kind_and_from_employer_expenses( travel_to_work );
      Calculate_Pension_Allowances( pers, params, settings, result );
      Calculate_Health_Allowances( pers, family, params, settings, result );
      
      taxable_income := Get_Taxable_Income( 
               result.income_less_exemptions,
               params.taxable_income,
               pers.in_kind_and_from_employer_expenses,
               TAXABLE_IN_KIND,
               result.deductions,
               ALLOWABLE_EXPENSES
            );
      log( income_tax, "Calculate_SITE  taxable_income = " & Format( taxable_income ));
      tresult := Calc_Tax_Due( params.rbs, taxable_income );
      tresult.due := Amount'Max( 0.0, tresult.due - rebate );
      result.income( site_income_tax ) := tresult.due;
   end Calculate_SITE;
   
   procedure Apply_Means_Test( 
      eligible_amount : in out Amount;
      family          : Family_Unit_Rec;
      results         : in out Family_Result;
      params          : Means_Tested_Benefit ) is
      income : Amount := 0.0;      
      threshold       : Amount;
   begin
      if( family.num_adults = 2 ) then
         threshold := params.income_threshold_couple;
      else 
         threshold := params.income_threshold_single;
      end if;
      for pno in 1 .. family.num_people loop
         income := income + Calculate_Income( results.person( pno ).income, params.incomes_list );
      end loop;
      if( income > threshold ) then
         if( params.withdrawal_rate = Rate'Last ) then
            eligible_amount := 0.0;
         else
            eligible_amount := Amount'Max( 
               0.0, eligible_amount - ( income * params.withdrawal_rate ));
         end if;
      end if;
   end Apply_Means_Test;

   procedure Calculate_Grant_For_Older_Persons( 
      family   : in Family_Unit_Rec;
      params   : in Grant_For_Older_Persons_Rec;
      settings : in Run_Settings;
      results  : in out Family_Result ) is
      amount_payable : Amount := 0.0;
      num_eligible : Natural := 0;
      eligible : array( Person_Range ) of Boolean := ( Others=>False );
   begin
      for pno in 1 .. family.num_adults loop
         if( family.person( pno ).age >= params.min_age( family.person( pno ).gender ))then
            amount_payable := amount_payable + params.amount_payable;
            num_eligible := num_eligible + 1;
            eligible( pno ) := True;
         end if;
      end loop;
      
      Apply_Means_Test( amount_payable, family, results, Means_Tested_Benefit( params ));
      --
      --  this attempts to get the client count roughly right
      --
      if( amount_payable > 0.0 ) then
         if( settings.case_takes_up( old_age_pensions )) then
            if( num_eligible = 2 ) then
               results.person( 1 ).income( old_age_pensions ) := 
                  amount_payable / 2.0;
               results.person( 2 ).income( old_age_pensions ) := 
                  amount_payable / 2.0;
            else
               for pno in 1 .. family.num_adults loop
                  if( eligible( pno )) then
                        results.person( pno ).income( old_age_pensions ) := amount_payable;
                  end if;
               end loop;
            end if;
         end if;
      end if;
   end Calculate_Grant_For_Older_Persons;
   
   procedure Calculate_Disability_Grant( 
      family   : in Family_Unit_Rec;
      params   : in Disability_Grant_Rec;
      settings : in Run_Settings;
      results  : in out Family_Result ) is
      amount_payable : Amount := 0.0;
      eligible : array( Person_Range ) of Boolean := ( Others=>False );
      num_eligible : Natural := 0;
   begin
      for pno in 1 .. family.num_people loop
         if( family.person( pno ).age <= params.max_age( family.person( pno ).gender )) and 
           ( family.person( pno ).age >= params.min_age( family.person( pno ).gender )) and
           ( family.person( pno ).is_disabled_or_blind ) then
            amount_payable := amount_payable + params.amount_payable;
            num_eligible := num_eligible + 1;
            eligible( pno ) := true;
         end if;
      end loop;
      
      Apply_Means_Test( amount_payable, family, results, Means_Tested_Benefit( params ));
      --
      -- get client count right (ish)
      --
      if( amount_payable > 0.0 ) then
         if( settings.case_takes_up( disability_grants )) then
            for pno in 1 .. family.num_people loop
               if( eligible( pno ) ) then
                  results.person( pno ).income( disability_grants ) := 
                     amount_payable/Amount(num_eligible);
               end if;
            end loop;
         end if;
      end if;
   end Calculate_Disability_Grant;
   
   procedure Calculate_Child_Support_Grant( 
      family   : Family_Unit_Rec;
      params   : Child_Support_Grant_Rec;
      settings : in Run_Settings;
      results  : in out Family_Result ) is
      amount_payable : Amount := 0.0;
      eligible : array( Person_Range ) of Boolean := ( Others=>False );
      num_eligible : Natural := 0;
   begin
      for pno in 1 .. family.num_people loop
         if( family.person( pno ).age <= params.max_age( family.person( pno ).gender )) then
            amount_payable := amount_payable + params.amount_payable;
            num_eligible := num_eligible + 1;
            eligible( pno ) := true;
         end if;
      end loop;
      
      Apply_Means_Test( amount_payable, family, results, Means_Tested_Benefit( params ));
      --
      -- get client count right (ish)
      --
      if( amount_payable > 0.0 ) then
         if( settings.case_takes_up( family_allowances )) then
            for pno in 1 .. family.num_people loop
               if( eligible( pno ) ) then
                  results.person( pno ).income( family_allowances ) := 
                     amount_payable/Amount( num_eligible);
               end if;
            end loop;
         end if;
      end if;
   end Calculate_Child_Support_Grant;
   
   procedure Calculate_Care_Dependency_Grant( 
      family   : Family_Unit_Rec;
      params   : Care_Dependency_Grant_Rec;
      settings : in Run_Settings;
      results  : in out Family_Result ) is
      amount_payable : Amount := 0.0;
      eligible : array( Person_Range ) of Boolean := ( Others=>False );
      num_eligible : Natural := 0;
   begin
      for pno in 1 .. family.num_people loop
         if( family.person( pno ).age <= params.max_age( family.person( pno ).gender )) and
           ( family.person( pno ).age >= params.min_age( family.person( pno ).gender )) and
           ( family.person( pno ).is_disabled_or_blind ) then
            amount_payable := amount_payable + params.amount_payable;
            num_eligible := num_eligible + 1;
            eligible( pno ) := true;
         end if;
      end loop;
      
      Apply_Means_Test( amount_payable, family, results, Means_Tested_Benefit( params ));
      --
      -- get client count right (ish)
      --
      if( amount_payable > 0.0 ) then
         if( settings.case_takes_up( other_state_benefits )) then
            for pno in 1 .. family.num_people loop
               if( eligible( pno ) ) then
                  --
                  -- FIXME: note we have no actual slot for this since we're basing
                  -- this on COICOP level 2 codes (sort of)
                  -- 
                  results.person( pno ).income( other_state_benefits ) := 
                  results.person( pno ).income( other_state_benefits ) +
                     amount_payable/Amount(num_eligible);
               end if;
            end loop;
         end if;
      end if;
   end Calculate_Care_Dependency_Grant;

   function Calculate_UIF(
      pers          : Person_Rec;
      income_so_far : Income_Array;
      params        : One_UIF_Rec; 
      settings      : Run_Settings ) return Amount is
      taxable_income : Amount := Calculate_Income( income_so_far, params.income );
      tresult        : Tax_Result;      
   begin
      tresult.due := 0.0;
      if( pers.age <= params.max_age( pers.gender )) then
         tresult := Calc_Tax_Due( params.rbs, taxable_income );
      end if;
      return tresult.due;
   end Calculate_UIF;

   --
   -- fixme extend this to extreme/mild poverty
   --
   procedure Calculate_Poverty_State(
      hh       : in Household; 
      params   : in Parameters; 
      settings : in Run_Settings;
      results  : in out Household_Result ) is
      income : Amount;
      line   : Amount;
   begin
      if( settings.poverty.deduct_indirect_taxes )then
         income := results.net_income;
      else
         income := results.disposable_income;
      end if;
      --
      -- FIXME this is a mess and we only get away with it since the kids
      -- and adult poverty lines are the same
      -- 
      results.poverty_line := 
         Amount( hh.info.num_people - hh.info.num_children_under_16 ) * settings.poverty.poverty_line_per_adult +
         Amount( hh.info.num_children_under_16 ) * settings.poverty.poverty_line_per_child;
      if(  results.poverty_line >= income )then
         results.poverty_gap := results.poverty_line - income;
         results.poverty := in_poverty;
      end if;
   end Calculate_Poverty_State;
   
   
   procedure Calculate_Income_Tax(
      pers           : in Person_Rec; 
      family         : Family_Unit_Rec;
      params         : in Income_Tax_Rec; 
      settings       : in Run_Settings;
      result         : in out Personal_Result ) is
      tresult        : Tax_Result;  
      -- intermed      : Intermediate_Tax_Results;
      rebate           : Amount := 0.0;
      paye_threshold   : Amount := 0.0;
      taxable_income   : Amount := 0.0;
      threshold_income : Amount := 0.0;
   begin
     rebate := params.rebate;
     threshold_income := 
         Calculate_Income( result.income, params.threshold_income );
      if( pers.age < params.age_limit( pers.gender ))then
        paye_threshold := params.threshold;
      else
        paye_threshold := params.age_threshold;
        rebate := rebate + params.age_rebate;
      end if;
      log( income_tax, "Calculate_Income_Tax; threshold income = " & Format( threshold_income ) & 
         " paye_threshold " & Format( paye_threshold ));
      Calculate_SITE( pers, family, params, settings, rebate, result );
      
   end Calculate_Income_Tax;
   
   package Indir_Package is new Indirect_Tax_Utils( TU => Consumption_Package );

   procedure Calculate_Indirect( 
      hh       : in Household; 
      params   : in Indirect_Tax_Rec; 
      settings : in Run_Settings;
      result   : in out Household_Result ) is
      use Consumption_Package;
      consumption : Expenditure_Array := hh.info.consumption( Consumption_Range );
   begin
      consumption := consumption * params.proportion_vatable;
      Indir_Package.Calc_Indir_Tax_Components( 
         consumption,
         params.selling_price,
         params.vat,
         params.advalorem,
         params.specific,
         result.vat,
         result.ad_valorem,
         result.specific );
   end Calculate_Indirect;
   
   function Calculate( 
      hh       : in Household; 
      params   : in Parameters; 
      settings : in Run_Settings ) return Household_Result is
   use Ada.Text_IO;
      result : Household_Result;
   begin
      --
      -- block copy incomes from people to the results record
      -- this is what's used from now on
      --
      result.num_families := hh.info.num_families;
      result.num_people := hh.info.num_people;
      for fno in 1 .. hh.info.num_families loop
         result.family( fno ).num_people := hh.family( fno ).num_people;
         for pno in 1 .. hh.family( fno ).num_people loop
            result.family( fno ).person( pno ).income := 
               hh.family( fno ).person( pno ).income;
            for i in Calculated_Incomes loop
               result.family( fno ).person( pno ).income( i ) := 0.0;
            end loop;
            result.family( fno ).person( pno ).income_less_exemptions :=
               result.family( fno ).person( pno ).income;
         end loop;
      end loop;
      
      each_family:
      for fno in 1 .. hh.info.num_families loop
         each_member:
         for pno in 1 .. hh.family( fno ).num_people loop
            
            result.family( fno ).person( pno ).income( employers_uif ) := 
               Calculate_UIF( 
                  hh.family( fno ).person( pno ), 
                  result.family( fno ).person( pno ).income,
                  params.uif.employers,
                  settings );
            result.family( fno ).person( pno ).income( employees_uif ) := 
               Calculate_UIF( 
                  hh.family( fno ).person( pno ), 
                  result.family( fno ).person( pno ).income,
                  params.uif.employees,
                  settings );
            --
            -- hack: FIXME income tax uses income_less_exemptions so store calculations
            -- so far here.
            -- Better moved to income tax routine?
            --
            result.family( fno ).person( pno ).income_less_exemptions( employees_uif ) := 
               result.family( fno ).person( pno ).income( employees_uif );
            result.family( fno ).person( pno ).income_less_exemptions( employers_uif ) := 
               result.family( fno ).person( pno ).income( employers_uif );
               
            Calculate_Income_Tax( 
               hh.family( fno ).person( pno ), 
               hh.family( fno ),
               params.income_tax,
               settings,
               result.family( fno ).person( pno ));
            log( driver, "FU " & fno'Img & " person " & pno'Img & " : " );
            log( driver, "employees_uif " & Format( result.family( fno ).person( pno ).income( employees_uif )));
            log( driver, " Income Tax " & Format( result.family( fno ).person( pno ).income( site_income_tax )));
         end loop each_member;
         Calculate_Disability_Grant( 
            hh.family( fno ), params.benefits.disability_grant, settings, result.family( fno ));
         Calculate_Grant_For_Older_Persons( 
            hh.family( fno ), params.benefits.grant_for_older_persons, settings, result.family( fno ));
         Calculate_Child_Support_Grant( 
            hh.family( fno ), params.benefits.child_support_grant, settings, result.family( fno ));
         Calculate_Care_Dependency_Grant( 
            hh.family( fno ), params.benefits.care_dependency_grant, settings, result.family( fno ));
      end loop each_family;
      
      Calculate_Indirect( hh, params.indirect, settings, result );
      Accumulate( hh, settings, result );
      Calculate_Poverty_State( hh, params, settings, result );
      return result;
   end Calculate;
   
   function Calculate_Marginal_Rate( 
      hh       : Household; 
      params   : Parameters; 
      settings : Run_Settings;
      income_increment : Amount;
      increment_target : Personal_Incomes_Type := salaries_and_wages;
      which_family : Family_Unit_Range := 1; 
      which_person : Person_Range := 1 ) return Household_Result is
   use Ada.Text_IO; 
      res_actual, res_with_increment : Household_Result;
      hh_copy  : Household := hh;
   begin
      Assert( income_increment /= 0.0 );
      res_actual := Calculate( hh, params, settings );
      hh_copy.family( which_family ).person( which_person ).income( increment_target ) := 
         hh_copy.family( which_family ).person( which_person ).income( increment_target ) +  
         income_increment;
      res_with_increment := Calculate( hh_copy, params, settings );
      each_family:
      for fno in 1 .. hh.info.num_families loop
         each_member:
         for pno in 1 .. hh.family( fno ).num_people loop
            res_actual.family( fno ).person( pno ).marginal_tax_rate := 100.0 * ( 1.0 - 
               (res_with_increment.family( fno ).person( pno ).disposable_income - 
                res_actual.family( fno ).person( pno ).disposable_income ) / income_increment);  
            log( marginal_rates,  "disposable income pre " & Format( res_actual.family( fno ).person( pno ).disposable_income )); 
            log( marginal_rates,  "disposable income post " & Format( res_with_increment.family( fno ).person( pno ).disposable_income )); 
            log( marginal_rates,  "marginal rate " & Format( res_actual.family( fno ).person( pno ).marginal_tax_rate ));
         end loop each_member;
      end loop each_family;
      return res_actual;
   end Calculate_Marginal_Rate;
   
end ZA.Model.Calculator;
