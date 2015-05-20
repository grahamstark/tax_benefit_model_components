with Model_Types;

package Model.Parameter_System is

   use Model_Types;
   
   type Loan_Plan_Type is ( plan_1, plan_2 );


--  £18,370 £5,161 £2,575 £4,640 £1,412
--  £25,000 £3,347 £3,477 £5,542 £2,314
--  £30,000 £2,099 £4,101 £6,166 £2,938
--  £34,000 £1,142 £4,579 £6,644 £3,416
--  £40,000 £734 £4,783 £6,848 £3,620
--  £45,000 £393 £4,954 £7,019 £3,791
--  £50,020 £50 £5,125 £7,190 £3,962
   type Student_Support_Type is (
      assembly_learning_grant, maintenance_loan_london, maintenance_loan_away, maintenance_loan_home );

--     type Assembly_Learning_Grant_System is
--        maximum_support : Amount := 5_161.00;
--        income_end_threshold : Amount := 50_020.00;
--        income_start_threshold : Amount := 18_371.00;
--        withdrawal_rate := 0.50;
--  The maximum amount of support available is £5,161 per year.
--  How much you get depends on your household income, and will
--  be calculated by your LA when you make your application for
--  help. The table on page 13 is a guide to how much grant/loan
--  you could get:
--  If your household income is over £50,020 you will not
--  be eligible to receive any living costs grant (Assembly
--  Learning Grant).
--  Household Income (See Note below)
--  £18,370 or less: Full £5,161 grant
--  Between £18,371 and £50,020: Partial grant
--  Over £50,020: No grant

   type Student_Loan_And_Grant_System(
      plan_type             : Loan_Plan_Type;
      num_maintenance_bands : Positive;
      num_algfe_bands       : Positive ) is record
      -- use pre-calculated income-tax income
      grant_income_limits      : Vector( 1 .. num_maintenance_bands );
      assembly_learning_grant  : Vector( 1 .. num_maintenance_bands );
      maintenance_loan_london  : Vector( 1 .. num_maintenance_bands );
      maintenance_loan_away    : Vector( 1 .. num_maintenance_bands );
      maintenance_loan_home    : Vector( 1 .. num_maintenance_bands );
      tuition_fee_loan         : Amount;
      tuition_fee_grant        : Amount;
      ema                      : Amount;
      ema_income_limit         : Amount;
      ema_income_limit_w_kids  : Amount;
      algfe                    : Vector( 1 .. num_algfe_bands );
      algfe_income_limit       : Vector( 1 .. num_algfe_bands );
      higher_education_bursary : Amount := 0.0; 
      average_accommodation_costs_out_of_term_time : Amount := 0.0;
      -- plus some stuff about higher interest above 41k
      case plan_type is
      when plan_1 =>
         minimum_income_threshold : Amount := 16_365.00;
      when plan_2 =>
         income_limit : Amount := 21_000.00;
         payment_rate : Rate := 0.09;
      end case;
   end record;


   type Foster_Payment_System is record
      age_limits : Age_Limit_Array( 1 .. 4 ); -- NOTE 4 in England
      minimum_amounts      : Amount_Array( 1 .. 4 );
      childs_contributions : Amount_Array( 1 .. 4 );
   end record;

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
      earned_income       : Incomes_Set;
      unearned_income           : Incomes_Set;

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

   type Social_Care_Costs is record
      current_system  : Admin_Activity_Array;
      when_i_am_ready : Admin_Activity_Array;
   end record;
   
   type Child_Benefit_System is record
      first_child : Amount;
      additional_children : Amount;
      guardians_allowance : Amount;
   end record;
   
   type Indirect_Taxes is record
      vat : Rate;
   end record;

   type Complete_System(
      plan_type             : Loan_Plan_Type;
      num_maintenance_bands : Positive;
      num_algfe_bands       : Positive ) is record
      cb : Child_Benefit_System;
      it : Income_Tax_System;
      ni : National_Insurance_System;
      uc : Universal_Credit_System;
      sl : Student_Loan_And_Grant_System( plan_type, num_maintenance_bands, num_algfe_bands );
      fp : Foster_Payment_System;
      sc : Social_Care_Costs;
      indir : Indirect_Taxes;
    end record;

end  Model.Parameter_System;
