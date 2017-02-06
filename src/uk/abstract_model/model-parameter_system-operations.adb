package body Model.Parameter_System.Operations is

   procedure Monthly_To_Weekly( a : in out Amount ) is
   begin
      a := a / WEEKS_PER_MONTH;
   end Monthly_To_Weekly;
   
   procedure Annual_To_Weekly( a : in out Amount ) is
   begin
      a := a / WEEKS_PER_YEAR;
   end Annual_To_Weekly;
   
   procedure To_Level( a : in out Amount ) is
   begin
      a := a/100.0;
   end To_Level;
   
   procedure To_Weekly( ni_sys : in out National_Insurance_System ) is
      rb : Rate_And_Band;
   begin

      -- --
      -- -- construct NI out rates from in plus rebate
      -- --
      -- ni_sys.employee_out_rates := ni_sys.employee_in_rates;
      -- rb := ni_sys.employee_in_rates.Get_Rate_And_Band( Which => 1 );
      -- rb.rate := Amount'Max( 0.0, rb.rate - sys.employees_contracted_out_rebate );
      -- ni_sys.employee_in_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>True );
      -- 
      -- ni_sys.employee_out_rates := ni_sys.employee_in_rates;
      -- rb := ni_sys.employee_in_rates.Get_Rate_And_Band( Which => 1 );
      -- rb.rate := Amount'Max( 0.0, rb.rate - sys.employees_contracted_out_rebate );
      -- ni_sys.employee_in_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>True );
      -- 
      ni_sys.employee_in_rates.To_Levels;
      ni_sys.employee_out_rates.To_Levels;
      
      ni_sys.employer_in_rates.To_Levels;
      ni_sys.employer_out_rates.To_Levels;
      ni_sys.employer_out_rates.To_Levels;
      --
      -- inject a zero band into employees NI, at the level of the primary threshold      
      --
      rb.rate := 0.0;
      rb.band := ni_sys.primary_threshold;
      ni_sys.employee_in_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>False );
      ni_sys.employee_out_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>False );
      
      --
      -- this is because employer NI works differently, with a single
      -- secondary_threshold applied to all jobs - so we reduce the band by that amount
      -- only really matters for (e.g.) young person's rate
      -- since otherwise it's presently a flat rate
      --
      rb := ni_sys.employer_in_rates.Get_Rate_And_Band( Which => 1 );
      rb.band := Amount'Max( 0.0, rb.band - ni_sys.secondary_threshold );
      ni_sys.employer_in_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>True );
      rb := ni_sys.employer_out_rates.Get_Rate_And_Band( Which => 1 );
      rb.band := Amount'Max( 0.0, rb.band - ni_sys.secondary_threshold );
      ni_sys.employer_out_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>True );
      

      --
      -- add lpr to class 4 
      rb := ni_sys.class_4_rates.Get_Rate_And_Band( Which => 1 );
      rb.band := Amount'Max( 0.0, rb.band - ni_sys.class_4_lower_profit_limit );
      ni_sys.class_4_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>True );
      
      ni_sys.class_4_rates.Annual_To_Weekly;
      ni_sys.class_4_rates.To_Levels;
      A2W( ni_sys.class_2_exemption);
      A2W( ni_sys.class_4_lower_profit_limit );
      
      
      
      -- rb.band := ni_sys.secondary_threshold;
      -- ni_sys.employer_in_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>False );
      -- ni_sys.employer_out_rates.Set_Rate_And_Band( RB => rb, Pos => 1, replace=>False );
      
   end To_Weekly;
   
   procedure To_Weekly( it_sys : in out Income_Tax_System ) is
   begin
      it_sys.non_savings_income_rates.Annual_To_Weekly;
      it_sys.savings_income_rates.Annual_To_Weekly; 
      it_sys.dividend_income_rates.Annual_To_Weekly;
      it_sys.non_savings_income_rates.To_Levels;
      it_sys.savings_income_rates.To_Levels; 
      it_sys.dividend_income_rates.To_Levels;
      A2W( it_sys.personal_allowance );
   end To_Weekly; 
   
   procedure To_Weekly( sys : in out Complete_System ) is
   begin
      To_Weekly( sys.ni );
      To_Weekly( sys.it );      
      -- IT/NI annual
      
      
      -- UC monthly
      M2W( sys.benefits.universal_credit.disregards.single_with_housing_no_children );
      M2W( sys.benefits.universal_credit.disregards.single_with_housing_with_children );
      M2W( sys.benefits.universal_credit.disregards.single_with_housing_limited_work_capacity );
      M2W( sys.benefits.universal_credit.disregards.single_no_housing_no_children );
      M2W( sys.benefits.universal_credit.disregards.single_no_housing_with_children );
      M2W( sys.benefits.universal_credit.disregards.single_no_housing_limited_work_capacity );
      M2W( sys.benefits.universal_credit.disregards.couple_with_housing_no_children );
      M2W( sys.benefits.universal_credit.disregards.couple_with_housing_with_children );
      M2W( sys.benefits.universal_credit.disregards.couple_with_housing_limited_work_capacity );
      M2W( sys.benefits.universal_credit.disregards.couple_no_housing_no_children );
      M2W( sys.benefits.universal_credit.disregards.couple_no_housing_with_children );
      M2W( sys.benefits.universal_credit.disregards.couple_no_housing_limited_work_capacity );

      M2W( sys.benefits.universal_credit.allowances.single_claimant_aged_under_25 );
      M2W( sys.benefits.universal_credit.allowances.single_claimant_aged_25_or_over );
      M2W( sys.benefits.universal_credit.allowances.joint_claimants_both_aged_under_25 );
      M2W( sys.benefits.universal_credit.allowances.joint_claimants_either_aged_25_or_over );
      M2W( sys.benefits.universal_credit.allowances.first_child_or_qualifying_young_person );
      M2W( sys.benefits.universal_credit.allowances.second_and_each_subsequent_child_or_qualifying_young_person );

      M2W( sys.benefits.universal_credit.limited_capability_for_work );
      M2W( sys.benefits.universal_credit.limited_capability_for_work_and_work_related_activity );
      M2W( sys.benefits.universal_credit.caring_for_a_severely_disabled_person_for_at_least_35_hours_a_week );
      M2W( sys.benefits.universal_credit.maximum_childcare_award_families );
      M2W( sys.benefits.universal_credit.maximum_childcare_award_lone_parents );
      M2W( sys.benefits.universal_credit.maximum_payment_families );
      M2W( sys.benefits.universal_credit.maximum_payment_singles  );
      M2W( sys.benefits.universal_credit.one_bedroom_in_shared_accommodation_rate );
      --
      -- withdrawal, generosity as percentages
      --
      To_Level( sys.benefits.universal_credit.childcare_costs_percent );
      To_Level( sys.benefits.universal_credit.withdrawal_rate );
      To_Level( sys.benefits.attendance_allowance.test_generosity );
      To_Level( sys.benefits.dla.care.test_generosity );
      To_Level( sys.benefits.dla.mobility.test_generosity );
      -- 
      -- rest is weekly
      --
   end To_Weekly;
   
   procedure Uprate( p : in out Pension_System; v : Rate ) is
   begin
      Uprate( p.class_a, v, UPRATE_ROUND_UP );
   end Uprate;
   
   procedure Uprate( p : in out Guaranteed_Credit_System; v : Rate ) is
   begin
      Uprate( p.single, v, UPRATE_ROUND_UP );
      Uprate( p.couple, v, UPRATE_ROUND_UP );
      Uprate( p.carer_single, v, UPRATE_ROUND_UP );
      Uprate( p.severe_disability_single, v, UPRATE_ROUND_UP );
      Uprate( p.severe_disability_couple, v, UPRATE_ROUND_UP );
   end Uprate;
   
   procedure Uprate( p : in out Savings_Credit_System; v : Rate ) is
   begin
      Uprate( p.threshold_single, v, UPRATE_ROUND_UP );
      Uprate( p.threshold_couple, v, UPRATE_ROUND_UP );
      Uprate( p.maximum_single, v, UPRATE_ROUND_UP );
      Uprate( p.maximum_couple, v, UPRATE_ROUND_UP );
  end Uprate;
  
   procedure Uprate( p : in out Pension_Credit_System; v : Rate ) is
   begin
      Uprate( p.guaranteed_credit, v );
      Uprate( p.savings_credit, v );
   end Uprate;
   
   procedure Uprate( p : in out Complete_System; v : Rate ) is
   begin
      null; -- Uprate( p.pension, v );
      
   end Uprate;
   
end Model.Parameter_System.Operations;