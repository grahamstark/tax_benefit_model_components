with Standard_UK_Enums;

package Model.Parameter_System is

   type Income_Tax_System is record
     non_savings_income_rates : Rates_And_Bands;
     savings_income_rates     : Rates_And_Bands;
     dividend_income_rates    : Rates_And_Bands;
     personal_allowance       : Amount;
     non_savings_income       : Incomes_Set;
     savings_income           : Incomes_Set;
     dividends_income         : Incomes_Set;
     --
     -- stuff
   end record;

   type NI_Class is ( class_1, class_1a, class_1b, class_2, class_4 );

   type National_Insurance_System is record
     employee_in_rates  : Rates_And_Bands;
     employee_out_rates : Rates_And_Bands;
     employer_in_rates  : Rates_And_Bands;
     employer_out_rates : Rates_And_Bands;
   end record;


   -- disregards
   type Universal_Credit_Disregards is record
      -- you are single and claim housing costs and you:
      --
      -- are not responsible for a child or qualifying young person - £111 a month
      -- are responsible for one or more children or qualifying young persons - £263 a month
      -- have a limited capability to work - £192 a month
      single_with_housing_no_children : Amount := 111.0*12.0;
      single_with_housing_with_children : Amount := 263.0*12.0;
      single_with_housing_limited_work_capacity : Amount := 192.0*12.0;


      -- you are single and do not claim housing costs and you:
      -- are not responsible for a child or qualifying young person - £111 a month
      -- are responsible for one or more children or qualifying young persons - £734 a month
      -- have a limited capability to work - £647 a month
      single_no_housing_no_children : Amount := 111.0*12.0;
      single_no_housing_with_children : Amount := 734.0*12.0;
      single_no_housing_limited_work_capacity : Amount := 647.0*12.0;


      -- you have a partner and you claim housing costs and:
      -- neither of you are responsible for a child or qualifying young person - £111 a month
      -- you are responsible for one or more children or qualifying young persons - £222 a month
      -- one or both of you have limited capability to work - £192 a month
      couple_with_housing_no_children : Amount := 111.0*12.0;
      couple_with_housing_with_children : Amount := 222.0*12.0;
      couple_with_housing_limited_work_capacity : Amount := 192.0*12.0;

      -- you have a partner and you do not claim housing costs and:
      -- neither of you are responsible for a child or qualifying young person - £111
      -- you are responsible for one or more children or qualifying young persons - £536 a month
      -- one or both of you have limited capability to work - £647 a month
      couple_no_housing_no_children : Amount := 111.0*12.0;
      couple_no_housing_with_children : Amount := 536.0*12.0;
      couple_no_housing_limited_work_capacity : Amount := 647.0*12.0;
   end record;

   type Universal_Credit_Allowances is record
      -- standard allowance
      single_claimant_aged_under_25 : Amount := 246.81 * 12.0;
      single_claimant_aged_25_or_over : Amount := 311.55 * 12.0;
      joint_claimants_both_aged_under_25 : Amount := 387.42 * 12.0;
      joint_claimants_either_aged_25_or_over : Amount := 489.06 * 12.0;
      -- child element
      first_child_or_qualifying_young_person : Amount := 272.08 * 12.0;
      second_and_each_subsequent_child_or_qualifying_young_person : Amount := 226.67*12.0;
   end record;

   type Universal_Credit_System is record
      earned_income    : Incomes_Set;
      unearned_income  : Incomes_Set;

      allowances : Universal_Credit_Allowances;
      disregards : Universal_Credit_Disregards;

      withdrawal_rate : Rate := 65.0/100.0;

      -- additional amount for disabled child or qualifying young person
      -- capability for work elements
      limited_capability_for_work : Amount := 123.62 * 12.0;
      limited_capability_for_work_and_work_related_activity : Amount := 303.66 * 12.0;
      -- carer element
      caring_for_a_severely_disabled_person_for_at_least_35_hours_a_week : Amount := 144.70 * 12.0;
      -- childcare costs element

      -- 70% of relevant childcare costs up to:

      childcare_costs_percent : Rate := 70.0/100.0;
      maximum_childcare_award_families : Amount := 500.0*52.0;
      maximum_childcare_award_lone_parents : Amount := 350.0*52.0;

      maximum_payment_families : Amount :=  500.0*52.0;
      maximum_payment_singles  : Amount :=  350.0*52.0;

      -- maximum_award £500 a week for families / £350 a

      -- housing costs element
      -- For Cardiff, 1 bedroom shared rate, from
      -- https://lha-direct.voa.gov.uk/BedRoomCalculator.aspx
      one_bedroom_in_shared_accommodation_rate : Amount := 55.96*52.0;
     --can cover:

   --- eligible rent payments

   -- certain service charges


   -- mortgage interest. there is a qualifying period of three months before you can be paid this element. you will not be paid a housing element if you are in paid work.
   end record;

   type Child_Benefit_System is record
      first_child : Amount;
      additional_children : Amount;
      guardians_allowance : Amount;
   end record;
   
   type Indirect_Taxes is record
      vat : Rate;
   end record;
   
   type Attendance_Allowance_System is record
      low_age         : Age_Range;
      high_age        : Age_Range;
      benefit_rate    : High_Low_Array;
      test_generosity : Rate;
      preserve_for_existing_claimants : Boolean;
   end record;
   
   type DLA_Mobility_System is record
      low_age         : Age_Range;
      high_age        : Age_Range;
      benefit_rate    :  High_Low_Array := ( others => 0.0 );
      test_generosity : Rate;
      preserve_for_existing_claimants : Boolean;
   end record;
   
   type DLA_Care_System is record
      low_age                         : Age_Range;
      high_age                        : Age_Range;
      benefit_rate                    : High_Middle_Low_Array := ( others => 0.0 );
      test_generosity                 : Rate;
      preserve_for_existing_claimants : Boolean;
   end record;
   
   type Disability_Living_Allowance_System is record
      dont_pay_for_residential_claimants : Boolean := False;
      mobility                           : DLA_Mobility_System;
      care                               : DLA_Care_System;      
      preserve_for_existing_claimants    : Boolean;
   end record;
   
   type Pension_System is record
      age_men   : Age_Range;
      age_women : Age_Range;
      citizens_pension  : Boolean := False;
      class_a : Amount;
      preserve_for_existing_claimants : Boolean;
   end record;
   
   type Guaranteed_Credit_System is record
      single : Amount;
      couple : Amount;
      carer_single : Amount;
      severe_disability_single : Amount;
      severe_disability_couple : Amount;
      incomes : Included_Incomes_Array;
      earnings_disregard : Amount;
      benefit_disregard  : Amount; -- need a list of benefits this applies to
      preserve_for_existing_claimants : Boolean;
   end record;
   
  type Savings_Credit_System is record
      threshold_single : Amount;
      threshold_couple : Amount;
      maximum_single : Amount;
      maximum_couple : Amount;
      withdrawal_rate : Rate;
      incomes : Included_Incomes_Array  := Get_Default_Incomes( savings_credit );
      qualifying_incomes : Included_Incomes_Array  := Get_Default_Incomes( savings_credit_qualifying_income );
      earnings_disregard : Amount;
      benefit_disregard  : Amount;
      preserve_for_existing_claimants : Boolean;
   end record;
  
   type Pension_Credit_System is record
      guaranteed_credit : Guaranteed_Credit_System;
      savings_credit : Savings_Credit_System;
   end record;
   
   type Complete_System is tagged record
      cb : Child_Benefit_System;
      it : Income_Tax_System;
      ni : National_Insurance_System;
      uc : Universal_Credit_System;
      indir : Indirect_Taxes;
      
    end record;

end  Model.Parameter_System;
