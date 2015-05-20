with Ada.Assertions;
with Ada.Text_IO;
with Example_Data;

package body Model.Parameter_System.Defaults is

   use Ada.Assertions;
   use Ada.Text_IO;

   procedure Set_Rates_And_Bands(
   sys   : in out Income_Tax_System;
        bands       : Vector;
        non_savings : Vector;
        savings     : Vector;
        dividends   : Vector ) is
      rb : Rate_And_Band;
   begin
      Assert( bands'Length       = non_savings'Length and
              non_savings'Length = savings'Length and
              savings'Length     = dividends'Length,
              "array size mismatch" );
      for i in bands'Range loop
         rb.band := bands( i );
         rb.rate := non_savings( i )/100.0;
         sys.non_savings_income_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := savings( i )/100.0;
         sys.savings_income_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := dividends( i )/100.0;
         sys.dividend_income_rates.Set_Rate_And_Band( rb, i );
      end loop;
   end Set_Rates_And_Bands;

   procedure Set_Rates_And_Bands_NI(
      sys                : in out National_Insurance_System;
      bands              : Vector;
      employee_in_rates  : Vector;
      employee_out_rates : Vector;
      employer_in_rates  : Vector;
      employer_out_rates : Vector ) is
      rb : Rate_And_Band;
   begin
      Assert( bands'Length = employee_in_rates'Length and
              employee_in_rates'Length = employee_out_rates'Length and
              employee_out_rates'Length = employer_in_rates'Length,
              "array size mismatch" );
      for i in bands'Range loop
         rb.band := bands( i );
         rb.rate := employee_in_rates( i )/100.0;
         sys.employee_in_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := employee_out_rates( i )/100.0;
         sys.employee_out_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := employer_in_rates( i )/100.0;
         sys.employer_in_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := employer_out_rates( i )/100.0;
         sys.employer_out_rates.Set_Rate_And_Band( rb, i );
      end loop;
   end Set_Rates_And_Bands_NI;

   function Get_National_Insurance_System( year : Year_Number ) return National_Insurance_System is
      sys : National_Insurance_System;
      subtype V4 is Vector( 1 .. 4 );
   begin
      case year is
        when 2007   =>
            declare
               employee_in_rates  : V4 := ( 0.0, 0.0, 11.0, 1.0 );
               employee_out_rates : V4 := ( 0.0, 0.0, 9.4, 1.0 ); -- 2 1.6-rebate
               employer_in_rates  : V4 := ( 0.0, 0.0, 12.80, 12.8 );
               employer_out_rates : V4 := ( 0.0, 0.0, 9.1, 9.1 );
               bands              : V4 := ( 4_524.0, 5_225.0, 34_840.0, Amount'Last );
            begin
               Set_Rates_And_Bands_NI(
                  sys,
                  bands,
                  employee_in_rates,
                  employee_out_rates,
                  employer_in_rates,
                  employer_out_rates );
            end;
        when 2012   =>
            declare
               employee_in_rates  : V4 := ( 0.0, 0.0, 12.0, 2.0 );
               employee_out_rates : V4 := ( 0.0, 0.0, 10.6, 2.0 ); -- 2 1.6-rebate
               employer_in_rates  : V4 := ( 0.0, 0.0, 13.80, 13.8 );
               employer_out_rates : V4 := ( 0.0, 0.0, 10.4, 10.4 );
               bands              : V4 := ( 5_564.0, 7_605.0, 42_475.0, Amount'Last );
            begin
               Set_Rates_And_Bands_NI(
                  sys,
                  bands,
                  employee_in_rates,
                  employee_out_rates,
                  employer_in_rates,
                  employer_out_rates );
            end;
        when 2013   =>
            declare
               employee_in_rates  : V4 := ( 0.0, 0.0, 12.0, 2.0 );
               employee_out_rates : V4 := ( 0.0, 0.0, 10.6, 2.0 ); -- 2 1.6-rebate
               employer_in_rates  : V4 := ( 0.0, 0.0, 13.80, 13.8 );
               employer_out_rates : V4 := ( 0.0, 0.0, 10.4, 10.4 );
               bands              : V4 := ( 5_668.0, 7_755.0, 41_450.0, Amount'Last );
            begin
               Set_Rates_And_Bands_NI(
                  sys,
                  bands,
                  employee_in_rates,
                  employee_out_rates,
                  employer_in_rates,
                  employer_out_rates );
            end;
        when others => null;
      end case;
      return sys;
   end Get_National_Insurance_System;

   function Get_Income_Tax_System( year : Year_Number ) return Income_Tax_System is
      sys : Income_Tax_System;
      subtype V3 is Vector( 1 .. 3 );
      subtype V4 is Vector( 1 .. 4 );
   begin
      sys.non_savings_income.Insert( wages );
      sys.non_savings_income.Insert( self_employment );
      sys.non_savings_income.Insert( private_pensions );
      sys.non_savings_income.Insert( retirement_pension );
      sys.non_savings_income.Insert( other_pensions );
      sys.non_savings_income.Insert( property );
      sys.non_savings_income.Insert( royalties );
      -- FIXME taxable benefits
      -- national_savings,
      sys.savings_income.Insert( bank_interest );
      sys.savings_income.Insert( building_society );
      sys.savings_income.Insert( stocks_shares );
      sys.savings_income.Insert( peps );
      sys.savings_income.Insert( other_investment_income );
      -- isa,
      sys.dividends_income.Insert( dividends );
      -- other_income,

--        income_tax,
--        national_insurance,
--        local_taxes,
--        disabled_living_allowance,
--        education_maintenance_allownance,
--        child_benefit,
--        pension_credit,
--        retirement_pension,
--        other_pensions,
--        severe_disablement_allowance,
--        attendance_allowance,
--        invalid_care_allowance,
--        jobseekers_allowance,
--        incapacity_benefit,
--        income_support_jsa,
--        maternity_allowance,
--        other_benefits,
--        winter_fuel_payments,
--        housing_benefit,
--        council_tax_benefit,
--        tax_credits );

      case year is
        when 2007   =>
            declare
               non_savings_income : V3 := ( 10.0, 22.0, 40.0 );
               savings_income     : V3 := ( 10.0, 20.0, 40.0 );
               dividends_income   : V3 := ( 10.0, 10.0, 32.50 );
               bands              : V3 := ( 2_230.0, 34_600.0, Amount'Last );
            begin
               sys.personal_allowance := 5_225.0;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when 2012   =>
            declare
               non_savings_income : V4 := ( 20.0, 20.0, 40.0, 50.0 );
               savings_income     : V4 := ( 10.0, 20.0, 40.0, 50.0 );
               dividends_income   : V4 := ( 10.0, 10.0, 32.50, 32.50 );
               bands              : V4 := ( 2_710.0, 34_370.0, 150_000.0, Amount'Last );
            begin
               sys.personal_allowance := 8_105.00;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when 2013   =>
            declare
               non_savings_income : V4 := ( 20.0, 20.0, 40.0, 45.0 );
               savings_income     : V4 := ( 10.0, 20.0, 40.0, 45.0 );
               dividends_income   : V4 := ( 10.0, 10.0, 32.50, 32.50 );
               bands              : V4 := ( 2_790.0, 32_010.0, 150_000.0, Amount'Last );
            begin
               sys.personal_allowance := 9_440.00;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when others => null;
      end case;
      return sys;
   end Get_Income_Tax_System;

   function Get_Universal_Credit_System( year : Year_Number ) return Universal_Credit_System is
      uc : Universal_Credit_System;
   begin
      uc.earned_income.Insert( wages );
      uc.earned_income.Insert( self_employment );
      -- FIXME: these need to be 1,-1 vectors really and we need to break down income tax
      -- into PAYE, rest (etc) parts.
      -- FIXME taxable benefits
      -- national_savings,
      uc.unearned_income.Insert( bank_interest );
      uc.unearned_income.Insert( building_society );
      uc.unearned_income.Insert( stocks_shares );
      uc.unearned_income.Insert( peps );
      uc.unearned_income.Insert( other_investment_income );
      uc.unearned_income.Insert( private_pensions );
      uc.unearned_income.Insert( retirement_pension );
      uc.unearned_income.Insert( other_pensions );
      uc.unearned_income.Insert( property );
      uc.unearned_income.Insert( royalties );
      -- isa,
      uc.unearned_income.Insert( dividends );
      -- basic state retirement pension
      -- FIXME  CAPITAL/all taxable benefits/Income Tax Split/
      case year is
         when 2013 =>
            uc.allowances.single_claimant_aged_under_25 :=  246.81 * 12.0;
            uc.allowances.single_claimant_aged_25_or_over :=  311.55 * 12.0;
            uc.allowances.joint_claimants_both_aged_under_25 :=  387.42 * 12.0;
            uc.allowances.joint_claimants_either_aged_25_or_over :=  489.06 * 12.0;
            uc.allowances.first_child_or_qualifying_young_person :=  272.08 * 12.0;
            uc.allowances.second_and_each_subsequent_child_or_qualifying_young_person :=  226.67*12.0;

            uc.disregards.single_with_housing_no_children :=  111.0*12.0;
            uc.disregards.single_with_housing_with_children :=  263.0*12.0;
            uc.disregards.single_with_housing_limited_work_capacity :=  192.0*12.0;

            uc.disregards.single_no_housing_no_children :=  111.0*12.0;
            uc.disregards.single_no_housing_with_children :=  734.0*12.0;
            uc.disregards.single_no_housing_limited_work_capacity :=  647.0*12.0;

            uc.disregards.couple_with_housing_no_children :=  111.0*12.0;
            uc.disregards.couple_with_housing_with_children :=  222.0*12.0;
            uc.disregards.couple_with_housing_limited_work_capacity :=  192.0*12.0;

            uc.disregards.couple_no_housing_no_children :=  111.0*12.0;
            uc.disregards.couple_no_housing_with_children :=  536.0*12.0;
            uc.disregards.couple_no_housing_limited_work_capacity :=  647.0*12.0;

            uc.one_bedroom_in_shared_accommodation_rate := 12.0 * 234.37; 
            -- straight unweighted average over all wales councils; 
            -- see http://wales.gov.uk/topics/housingandcommunity/housing/private/renting/rentofficers/publications/lha13/?lang=en
            uc.withdrawal_rate :=  65.0/100.0;
            uc.limited_capability_for_work :=  123.62 * 12.0;
            uc.limited_capability_for_work_and_work_related_activity :=  303.66 * 12.0;
            uc.caring_for_a_severely_disabled_person_for_at_least_35_hours_a_week :=  144.70 * 12.0;
            uc.childcare_costs_percent :=  70.0/100.0;
            uc.maximum_childcare_award_families :=  500.0*52.0;
            uc.maximum_childcare_award_lone_parents :=  350.0*52.0;
            uc.maximum_payment_families :=   500.0*52.0;
            uc.maximum_payment_singles  :=   350.0*52.0;
         when others => null;
      end case;
      return uc;
   end Get_Universal_Credit_System;

   function Get_Child_Benefit_System( year : Year_Number ) return Child_Benefit_System is
     sys : Child_Benefit_System;
   begin
      case year is
         when 2013 =>
           sys.first_child := 20.30*52.0;
           sys.additional_children := 13.40*52.0;
           sys.guardians_allowance := 15.90*52.0;
         when others => null;
      end case;
      return sys;
   end Get_Child_Benefit_System;

   function Get_Student_Loan_And_Grant_System(
      year                  : Year_Number;
      plan_type             : Loan_Plan_Type;
      num_maintenance_bands : Positive;
      num_algfe_bands       : Positive ) return Student_Loan_And_Grant_System is
      sys : Student_Loan_And_Grant_System( plan_type, num_maintenance_bands, num_algfe_bands );
   begin
      case year is
         when 2013 =>
            sys.income_limit:= 21_000.00;
            sys.payment_rate := 0.09;
            Put_Line( "sys.grant_income_limits'Length " & sys.grant_income_limits'Length'Img );
            sys.grant_income_limits := ( 1=>18_370.0, 2=>25_000.0, 3=>30_000.0, 4=>34_000.0, 5=>40_000.0, 6=>45_000.0, 7=>50_020.0 );
            sys.assembly_learning_grant := ( 5_161.0, 3_347.0, 2_099.0, 1_142.0, 734.0, 393.0, 50.0 );
            sys.maintenance_loan_away := ( 2_575.0, 3_477.0, 4_101.0, 4_579.0, 4_783.0, 4_954.0, 5_125.0 );
            sys.maintenance_loan_london := ( 4_640.0, 5_542.0, 6_166.0, 6_644.0, 6_848.0, 7_019.0, 7_190.0 );
            sys.maintenance_loan_home := ( 1_412.0, 2_314.0, 2_938.0, 3_416.0, 3_620.0, 3_791.0, 3_962.0 );
            sys.tuition_fee_loan := 3_575.0;
            sys.tuition_fee_grant := 5_425.0;
            sys.ema := 30.0*52.0;
            sys.ema_income_limit := 20_817.0;
            sys.ema_income_limit_w_kids := 23_077.00;
            sys.algfe := ( 1_500.0, 750.0, 450.0 );
            sys.algfe_income_limit := ( 6120.0, 12_236.00, 18_370.00 );
            sys.higher_education_bursary := 2_000.0;
            -- per week 1 room average in wales * 22 weeks away from course
            sys.average_accommodation_costs_out_of_term_time := Example_Data.ONE_BEDROOM_FLAT_SOCIAL_HOUSING*22.0;
         when others => null;
      end case;
       return sys;
      -- plus some stuff about higher interest above 41k
   end Get_Student_Loan_And_Grant_System;

   function Get_Foster_Payment_System( year : Year_Number ) return Foster_Payment_System is
      fcs : Foster_Payment_System;
   begin
      case year is
         when 2013 =>
            
            -- over 18s from Table 7.1: Payments to staying put providers DFE
            -- rest from http://www.fostering.net/news/2011/fostering-allowances-launched-wales#.UnGn4XiMw8E
            fcs.age_limits := ( 4, 15, 18, 21 );
            fcs.minimum_amounts := ( 149.00*52.0, 136.00*52.0, 170.00*52.00, 200.00*52.00 );
            fcs.childs_contributions := ( 0.0, 0.0, 0.0, 100.00*52.00 );
         when others => null; -- note these are actuall published to 2016
      end case;
      return fcs;
   end  Get_Foster_Payment_System;

   function Get_Social_Care_Costs( year : Year_Number ) return Social_Care_Costs is
      sc : Social_Care_Costs;
   begin
      case year is
         when 2013 => 
            sc.when_i_am_ready := ( 
               initial_review       => 816.0,
               maintenance          => 120.0*52.0,
               placement_ceases     => 775.0,
               bi_annual_review     => 446.0 );
            sc.current_system := (
               initial_review       => 321.0,
               maintenance          => 321.0*52.0,
               placement_ceases     => 373.0,
               bi_annual_review     => 556.0 );
         when others => null;
      end case;
      return sc;
   end Get_Social_Care_Costs;
   
   function Get_Indirect_Taxes( year : Year_Number ) return Indirect_Taxes is
      indir : Indirect_Taxes;
   begin
      case year is
         when 2013 => 
            indir.vat := 0.20;
         when others => null;
      end case;
      return indir;
   end  Get_Indirect_Taxes;
   
   function Get_Complete_System( year : Year_Number ) return Complete_System is
      sys : Complete_System( plan_type => plan_2, num_maintenance_bands => 7, num_algfe_bands => 3 );
   begin
      sys.cb := Get_Child_Benefit_System( year );
      sys.it := Get_Income_Tax_System( year );
      sys.ni := Get_National_Insurance_System( year );
      sys.uc := Get_Universal_Credit_System( year );
      sys.sl := Get_Student_Loan_And_Grant_System( year => year, plan_type => plan_2, num_maintenance_bands => 7, num_algfe_bands => 3 );
      sys.fp := Get_Foster_Payment_System( year );
      sys.sc := Get_Social_Care_Costs( year );
      sys.indir := Get_Indirect_Taxes( year );
      return sys;
    end Get_Complete_System;

end Model.Parameter_System.Defaults;
