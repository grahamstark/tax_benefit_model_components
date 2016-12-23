with Ada.Assertions;
with Ada.Text_IO;

package body Model.Parameter_System.Defaults is

   use Ada.Assertions;
   use Ada.Text_IO;
   
   function Get_Expenses return Expenses_Included is
      ex : Expenses_Included;
   begin
      ex( health_insurance ) := 1.0;
      ex( alimony_and_child_support_paid ) := 0.0;
      ex( care_insurance ) := 0.0;
      ex( trade_unions_etc ) := 1.0;
      ex( friendly_societies ) := 1.0; 
      ex( work_expenses ) := 1.0; -- FIXME se only??
      ex( repayments ) := 1.0;
      ex( pension_contributions ) := 1.0;
      return ex;
   end Get_Expenses;
   
   --
   -- FIXME this ignores disregards !!!!!!!!
   --
   function Get_Default_Incomes( 
      which : Income_List_Type;
      itype : Benefit_Incomes_Type := both ) return Incomes_Included is
      inc : Incomes_Included := ( others => 0.0 );
   begin
      if itype = both or itype = unearned then
         case which is
            when guaranteed_pension_credit | savings_credit | universal_credit | housing_benefit | council_tax_benefit =>    
               inc( pension_credit ) := 0.0;
               inc( incapacity_benefit ) := 1.0;
               inc( tax_credits ) := 1.0;
               inc( jobseekers_allowance ) := 1.0;
               inc( severe_disablement_allowance ) := 1.0;
               inc( maternity_allowance ) := 1.0;
               inc( other_income ) := 1.0;
            when savings_credit_qualifying_income =>
               inc( pension_credit ) := 0.0;
               inc( incapacity_benefit ) := 0.0;
               inc( tax_credits ) := 0.0;
               inc( jobseekers_allowance ) := 0.0;
               inc( severe_disablement_allowance ) := 0.0;
               inc( maternity_allowance ) := 0.0;
               inc( other_income ) := 0.0;
         end case;
         inc( retirement_pension ) := 1.0;
         inc( attendance_allowance ) := 0.0;
         inc( private_pensions ) := 1.0;
         inc( invalid_care_allowance ) := 1.0;
         inc( other_pensions ) := 1.0;
         inc( disabled_living_allowance ) := 0.0;
         inc( sickness_benefits ) := 1.0;
         inc( child_benefit ) := 0.0;
         inc( housing_benefit ) := 1.0;
         inc( council_tax_benefit ) := 1.0;
         inc( other_benefits ) := 1.0;
               
         inc( student_grants ) := 1.0;
         inc( foster_care_payments ) := 1.0;
         inc( student_grants ) := 1.0;
         inc( student_loans ) := 1.0;
   
         inc( property ) := 1.0;
         inc( private_pensions ) := 1.0;
         -- inc( national_savings ) := 1.0;
         -- inc( dividends ) := 1.0;
         -- inc( bank_interest ) := 1.0;
         -- inc( building_society ) := 1.0;
      end if;
      if itype = both or itype = earned then      
         inc( wages ) := 1.0;
         inc( self_employment ) := 1.0;
      end if;
      -- if which = care_means_test then
      inc( income_tax ) := 0.0;
      inc( national_insurance ) := 0.0;
      -- end if;
      return inc;
   end Get_Default_Incomes;
   
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
         rb.rate := non_savings( i );
         sys.non_savings_income_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := savings( i );
         sys.savings_income_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := dividends( i );
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
         rb.rate := employee_in_rates( i );
         sys.employee_in_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := employee_out_rates( i );
         sys.employee_out_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := employer_in_rates( i );
         sys.employer_in_rates.Set_Rate_And_Band( rb, i );

         rb.band := bands( i );
         rb.rate := employer_out_rates( i );
         sys.employer_out_rates.Set_Rate_And_Band( rb, i );
      end loop;
   end Set_Rates_And_Bands_NI;
   
   function Vectors_To_RB( rates : Vector; bands : Vector ) return Rates_And_Bands is
      rb : Rate_And_Band;
      rbs : Rates_And_Bands;
   begin
      for r in rates'Range loop
         rb.rate := rates( r );
         rb.band := bands( r );
         rbs.Set_Rate_And_Band( rb, r );
      end loop;
      return rbs;
   end Vectors_To_RB;
   
   function Get_National_Insurance_System( year : Year_Number ) return National_Insurance_System is
      sys : National_Insurance_System;
      subtype V4 is Vector( 1 .. 4 );
      subtype V2 is Vector( 1 .. 2 );
   begin
      
      case year is
        when 2007   =>
            declare
               employee_in_rates  : V4 := ( 0.0, 0.0, 11.0, 1.0 );
               employee_out_rates : V4 := ( 0.0, 0.0, 9.4, 1.0 ); -- 2 1.6-rebate
               employer_in_rates  : V4 := ( 0.0, 0.0, 12.80, 12.8 );
               employer_out_rates : V4 := ( 0.0, 0.0, 9.1, 9.1 );
               bands              : V4 := ( 4_524.0, 5_225.0, 34_840.0, 999_999_999_99_99.99 );
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
               bands              : V4 := ( 5_564.0, 7_605.0, 42_475.0, 999_999_999_99_99.99 );
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
               bands              : V4 := ( 5_668.0, 7_755.0, 41_450.0, 999_999_999_99_99.99 );
            begin
               Set_Rates_And_Bands_NI(
                  sys,
                  bands,
                  employee_in_rates,
                  employee_out_rates,
                  employer_in_rates,
                  employer_out_rates );
            end;
        when 2015   => -- WEEKLY!!!!
            declare
               employee_in_rates  : V4 := ( 0.0, 0.0, 12.0, 2.0 );
               employee_out_rates : V4 := ( 0.0, 0.0, 10.6, 2.0 ); -- 2 1.6-rebate
               employer_in_rates  : V4 := ( 0.0, 0.0, 13.80, 13.8 );
               employer_out_rates : V4 := ( 0.0, 0.0, 10.4, 10.4 );
               bands              : V4 := ( 111.0, 153.0, 805.00, 999_999_999_99_99.99 );
            begin
               Set_Rates_And_Bands_NI(
                  sys,
                  bands,
                  employee_in_rates,
                  employee_out_rates,
                  employer_in_rates,
                  employer_out_rates );
            end;
        when 2016   => -- WEEKLY!!!!
            declare
               employee_in_rates  : V4 := ( 0.0, 0.0, 12.0, 2.0 );
               employee_out_rates : V4 := ( 0.0, 0.0, 10.6, 2.0 ); -- 2 1.6-rebate
               employer_in_rates  : V4 := ( 0.0, 0.0, 13.80, 13.8 );
               employer_out_rates : V4 := ( 0.0, 0.0, 10.4, 10.4 );
               bands              : V4 := ( 111.0, 153.0, 805.00, 999_999_999_99_99.99 );
            begin
               Set_Rates_And_Bands_NI(
                  sys,
                  bands,
                  employee_in_rates,
                  employee_out_rates,
                  employer_in_rates,
                  employer_out_rates );
            end;
        when 2017 => 
            declare
               employee_in_rates  : V2 := ( 12.0, 2.0 );
               employee_out_rates : V2 := ( 10.6, 2.0 );
               employer_in_rates  : V2 := ( 13.80, 13.8 );
               employer_out_rates : V2 := ( 10.4, 10.4 );
               class_4_bands      : V2 := ( 43_000.0, 999_999_999_99_99.99 );
               bands              : V2 := ( 805.00, 999_999_999_99_99.99 );
            begin
               sys.class_1_lower_earnings_limit := 112.00;
               sys.contracting_out_abolished  := False; --   : Boolean := false;
               sys.class_1_rebate := 0.0;--               : Rate   := 0.0; -- a percentage 
               sys.primary_threshold := 155.0; --            : Amount := 0.0;
               sys.secondary_threshold := 156.0; --          : Amount := 0.0;     
      
      
               sys.class_2_exemption := 5965.0; -- PA           : Amount := 0.0;
               sys.class_2_rate := 2.80; -- per weel                 : Amount := 0.0;
      
               sys.class_4_lower_profit_limit    := 8060.0;
               sys.class_4_rates := Vectors_To_RB( 
                  ( 9.0, 2.0 ),
                  ( 805.00,999_999_999_99_99.99 ));
                  
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
      sys.non_savings_income := ( others => 0.0 );
      sys.savings_income := ( others => 0.0 );
      sys.dividends_income := ( others => 0.0 );
      
      sys.non_savings_income( wages ) := 1.0;
      sys.non_savings_income( self_employment ) := 1.0;
      sys.non_savings_income( private_pensions ) := 1.0;
      sys.non_savings_income( retirement_pension ) := 1.0;
      sys.non_savings_income( other_pensions ) := 1.0;
      sys.non_savings_income( property ) := 1.0;
      sys.non_savings_income( royalties ) := 1.0;
      -- FIXME taxable benefits
      -- national_savings,
      sys.savings_income( bank_interest ) := 1.0;
      sys.savings_income( building_society ) := 1.0;
      -- sys.savings_income( stocks_shares ) := 1.0;
      sys.savings_income( peps ) := 1.0;
      sys.savings_income( other_investment_income ) := 1.0;
      -- isa,
      sys.dividends_income( dividends ) := 1.0;

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
               bands              : V3 := ( 2_230.0, 34_600.0, 999_999_999_99_99.99);
            begin
               sys.personal_allowance := 5_225.0;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when 2012   =>
            declare
               non_savings_income : V4 := ( 20.0, 20.0, 40.0, 50.0 );
               savings_income     : V4 := ( 10.0, 20.0, 40.0, 50.0 );
               dividends_income   : V4 := ( 10.0, 10.0, 32.50, 32.50 );
               bands              : V4 := ( 2_710.0, 34_370.0, 150_000.0, 999_999_999_99_99.99);
            begin
               sys.personal_allowance := 8_105.00;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when 2013   =>
            declare
               non_savings_income : V4 := ( 20.0, 20.0, 40.0, 45.0 );
               savings_income     : V4 := ( 10.0, 20.0, 40.0, 45.0 );
               dividends_income   : V4 := ( 10.0, 10.0, 32.50, 32.50 );
               bands              : V4 := ( 2_790.0, 32_010.0, 150_000.0, 999_999_999_99_99.99);
            begin
               sys.personal_allowance := 9_440.00;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when 2015   =>
            declare
               non_savings_income : V4 := ( 20.0, 20.0, 40.0, 45.0 );
               savings_income     : V4 := ( 10.0, 20.0, 40.0, 45.0 );
               dividends_income   : V4 := ( 10.0, 10.0, 32.50, 32.50 );
               bands              : V4 := ( 4_905.0, 31_785.0, 150_000.0, 999_999_999_99_99.99);
            begin
               sys.personal_allowance := 10_600.00;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when 2016 =>
            declare
               non_savings_income : V4 := ( 20.0, 20.0, 40.0, 45.0 );
               savings_income     : V4 := ( 10.0, 20.0, 40.0, 45.0 );
               dividends_income   : V4 := ( 10.0, 10.0, 32.50, 32.50 );
               bands              : V4 := ( 4_905.0, 31_785.0, 150_000.0, 999_999_999_99_99.99);
            begin
               sys.personal_allowance := 10_600.00;
               Set_Rates_And_Bands( sys, bands, non_savings_income, savings_income, dividends_income );
            end;
        when others => null;
      end case;
      return sys;
   end Get_Income_Tax_System;

   function Get_Universal_Credit_System( year : Year_Number ) return Universal_Credit_System is
      uc : Universal_Credit_System;
   begin
      -- uc.earned_income.Insert( wages );
      -- uc.earned_income.Insert( self_employment );
      -- FIXME: these need to be 1,-1 vectors really and we need to break down income tax
      -- into PAYE, rest (etc) parts.
      -- FIXME taxable benefits
      -- national_savings,
      uc.earned_income := Get_Default_Incomes( universal_credit, earned );
      uc.unearned_income := Get_Default_Incomes( universal_credit, unearned );
      -- uc.unearned_income.Insert( building_society );
      -- uc.unearned_income.Insert( stocks_shares );
      -- uc.unearned_income.Insert( peps );
      -- uc.unearned_income.Insert( other_investment_income );
      -- uc.unearned_income.Insert( private_pensions );
      -- uc.unearned_income.Insert( retirement_pension );
      -- uc.unearned_income.Insert( other_pensions );
      -- uc.unearned_income.Insert( property );
      -- uc.unearned_income.Insert( royalties );
      -- -- isa,
      -- uc.unearned_income.Insert( dividends );
      -- basic state retirement pension
      -- FIXME  CAPITAL/all taxable benefits/Income Tax Split/
      case year is
         when 2013 =>
            uc.allowances.single_claimant_aged_under_25 :=  247.04;
            uc.allowances.single_claimant_aged_25_or_over :=  311.55;
            uc.allowances.joint_claimants_both_aged_under_25 :=  387.42;
            uc.allowances.joint_claimants_either_aged_25_or_over :=  489.06;
            uc.allowances.first_child_or_qualifying_young_person :=  272.08;
            uc.allowances.second_and_each_subsequent_child_or_qualifying_young_person :=  226.67;

            uc.disregards.single_with_housing_no_children :=  111.0;
            uc.disregards.single_with_housing_with_children :=  263.0;
            uc.disregards.single_with_housing_limited_work_capacity :=  192.0;

            uc.disregards.single_no_housing_no_children :=  111.0;
            uc.disregards.single_no_housing_with_children :=  734.0;
            uc.disregards.single_no_housing_limited_work_capacity :=  647.0;

            uc.disregards.couple_with_housing_no_children :=  111.0;
            uc.disregards.couple_with_housing_with_children :=  222.0;
            uc.disregards.couple_with_housing_limited_work_capacity :=  192.0;

            uc.disregards.couple_no_housing_no_children :=  111.0;
            uc.disregards.couple_no_housing_with_children :=  536.0;
            uc.disregards.couple_no_housing_limited_work_capacity :=  647.0;

            uc.one_bedroom_in_shared_accommodation_rate := 234.37; 
            -- straight unweighted average over all wales councils; 
            -- see http://wales.gov.uk/topics/housingandcommunity/housing/private/renting/rentofficers/publications/lha13/?lang=en
            uc.withdrawal_rate :=  65.0;
            uc.limited_capability_for_work :=  123.62;
            uc.limited_capability_for_work_and_work_related_activity :=  303.66;
            uc.caring_for_a_severely_disabled_person_for_at_least_35_hours_a_week :=  144.70;
            uc.childcare_costs_percent :=  70.0;
            uc.maximum_childcare_award_families :=  500.0;
            uc.maximum_childcare_award_lone_parents :=  350.0;
            uc.maximum_payment_families :=   500.0;
            uc.maximum_payment_singles  :=   350.0;
            uc.maximum_number_of_children  :=   Child_Count'Last;
         when 2015 => -- from Hoc Briefing note SN07054
            uc.allowances.single_claimant_aged_under_25 :=  251.77;
            uc.allowances.single_claimant_aged_25_or_over :=  317.82;
            uc.allowances.joint_claimants_both_aged_under_25 :=  395.20;
            uc.allowances.joint_claimants_either_aged_25_or_over :=  498.89;
            uc.allowances.first_child_or_qualifying_young_person :=  277.08;
            uc.allowances.second_and_each_subsequent_child_or_qualifying_young_person :=  231.67;

            uc.disregards.single_with_housing_no_children :=  111.0;
            uc.disregards.single_with_housing_with_children :=  263.0;
            uc.disregards.single_with_housing_limited_work_capacity :=  192.0;

            uc.disregards.single_no_housing_no_children :=  111.0;
            uc.disregards.single_no_housing_with_children :=  734.0;
            uc.disregards.single_no_housing_limited_work_capacity :=  647.0;

            uc.disregards.couple_with_housing_no_children :=  111.0;
            uc.disregards.couple_with_housing_with_children :=  222.0;
            uc.disregards.couple_with_housing_limited_work_capacity :=  192.0;

            uc.disregards.couple_no_housing_no_children :=  111.0;
            uc.disregards.couple_no_housing_with_children :=  536.0;
            uc.disregards.couple_no_housing_limited_work_capacity :=  647.0;

            uc.one_bedroom_in_shared_accommodation_rate := 234.37;
            -- FIXME!!!
            -- straight unweighted average over all wales councils; 
            -- see http://wales.gov.uk/topics/housingandcommunity/housing/private/renting/rentofficers/publications/lha13/?lang=en
            uc.withdrawal_rate :=  65.0;
            -- DON
            uc.limited_capability_for_work :=  126.11;
            uc.limited_capability_for_work_and_work_related_activity :=  315.60;
            uc.caring_for_a_severely_disabled_person_for_at_least_35_hours_a_week :=  150.30;
            uc.childcare_costs_percent :=  70.0;
            uc.maximum_childcare_award_families :=  2_000.0;
            -- FIXME what are these numbers???
            uc.maximum_childcare_award_lone_parents :=  350.0/12.0;
            uc.maximum_payment_families :=   2_000.0;
            uc.maximum_payment_singles  :=   350.0/12.0;
            uc.maximum_number_of_children  :=   Child_Count'Last;
         when others => null;
      end case;
      return uc;
   end Get_Universal_Credit_System;

   function Get_Child_Benefit_System( year : Year_Number ) return Child_Benefit_System is
     sys : Child_Benefit_System;
   begin
      case year is
         when 2013 =>
           sys.first_child := 20.30;
           sys.additional_children := 13.40;
           sys.guardians_allowance := 15.90;
         when 2015 =>
           sys.first_child := 20.50;
           sys.additional_children := 13.55;
           sys.guardians_allowance := 16.35;
         when others => null;
      end case;
      return sys;
   end Get_Child_Benefit_System;

   function Get_Indirect_Taxes( year : Year_Number ) return Indirect_Taxes is
      indir : Indirect_Taxes;
   begin
      case year is
         when 2013 .. 2015 => 
            indir.vat := 0.20;
         when others => null;
      end case;
      return indir;
   end  Get_Indirect_Taxes;
   
   function Get_AA( year : Year_Number ) return Attendance_Allowance_System is
      aa : Attendance_Allowance_System;
   begin
      case year is
         when 2015 =>
            aa.low_age         := 65;
            aa.high_age        := Age_Range'Last;
            aa.benefit_rate    := ( high => 81.3, low=> 54.45, nil=> 0.0 );
            aa.test_generosity := 100.0;
            aa.preserve_for_existing_claimants := True;
         when others => null;
      end case;
      return aa;
   end Get_AA;
   
   
   function Get_DLA( year : Year_Number ) return Disability_Living_Allowance_System is
      dla : Disability_Living_Allowance_System;
   begin
      case year is
      when 2015 =>
         dla.mobility.low_age         := 0;
         dla.mobility.high_age        := 64;
         dla.mobility.benefit_rate    := ( low => 21.55, high=>56.75, nil=> 0.0 );
         dla.mobility.test_generosity := 100.0;
         dla.mobility.preserve_for_existing_claimants := True;
         dla.care.low_age             := 0;
         dla.care.high_age            := 64;
         dla.care.benefit_rate        := ( high=>81.30, middle=>54.45, low=>21.55, nil=> 0.0 );
         dla.care.test_generosity     := 100.0;
         dla.care.preserve_for_existing_claimants := True;
      when others => null;
      end case;
      return dla;
   end Get_DLA;
   
   function Get_Pension_Credit( year : Year_Number ) return Pension_Credit_System is
      pension_credit : Pension_Credit_System;
   begin
      pension_credit.savings_credit.qualifying_incomes := Get_Default_Incomes( 
         which => savings_credit_qualifying_income,
         itype => both );
      pension_credit.savings_credit.incomes := Get_Default_Incomes( 
         which => savings_credit,
         itype => both );
      pension_credit.guaranteed_credit.incomes := Get_Default_Incomes( 
         which => guaranteed_pension_credit,
         itype => both ); 
         
      case year is
      when 2015 =>
         pension_credit.guaranteed_credit.single := 148.35;
         pension_credit.guaranteed_credit.couple := 226.50;
         pension_credit.guaranteed_credit.carer_single := 34.20;
         pension_credit.guaranteed_credit.preserve_for_existing_claimants := False;
         pension_credit.guaranteed_credit.severe_disability_couple := 61.10*2.0;
         pension_credit.guaranteed_credit.severe_disability_single := 61.10;
         pension_credit.savings_credit.maximum_couple := 20.70;
         pension_credit.savings_credit.maximum_single := 16.80;
         pension_credit.savings_credit.preserve_for_existing_claimants := False;
         pension_credit.savings_credit.threshold_couple := 192.00;
         pension_credit.savings_credit.threshold_single := 120.35;
         pension_credit.savings_credit.withdrawal_rate := 40.0;
      when others => null;
      end case;
      return pension_credit;
   end Get_Pension_Credit;
   
   function Get_State_Pension( year : Year_Number ) return Pension_System is
      state_pension : Pension_System;
   begin
      case year is
      when 2015 =>
         state_pension.age_men      := 65;
         state_pension.age_women    := 61;
         state_pension.citizens_pension := False;
         state_pension.class_a      := 113.10;
         state_pension.preserve_for_existing_claimants := False;
      when others => null;
      end case;
      return state_pension;
   end Get_State_Pension;
   
   function Get_Complete_System( year : Year_Number ) return Complete_System is
      sys : Complete_System;
   begin
      sys.benefits.child_benefit := Get_Child_Benefit_System( year );
      sys.benefits.universal_credit := Get_Universal_Credit_System( year );
      sys.benefits.state_pension := Get_State_Pension( year );
      sys.benefits.attendance_allowance := Get_AA( year );
      sys.benefits.pension_credit := Get_Pension_Credit( year );
      sys.benefits.dla := Get_DLA( year );
      sys.it := Get_Income_Tax_System( year );
      sys.ni := Get_National_Insurance_System( year );
      sys.indir := Get_Indirect_Taxes( year );
      return sys;
   end Get_Complete_System;
      
end Model.Parameter_System.Defaults;
