package body Model.Parameter_System.Operations is

   procedure Monthly_To_Weekly( a : in out Amount ) is
   begin
      a := a / WEEKS_PER_MONTH;
   end Monthly_To_Weekly;
   
   procedure Annual_To_Weekly( a : in out Amount ) is
   begin
      a := a / WEEKS_PER_YEAR;
   end Annual_To_Weekly;
   
   procedure To_Weekly( sys : in out Complete_System ) is
   begin
      -- IT/NI annual
      sys.ni.employee_in_rates.To_Levels;
      sys.ni.employee_out_rates.To_Levels;
      sys.ni.employer_in_rates.To_Levels;
      sys.ni.employer_out_rates.To_Levels;
      
      A2W( sys.ni.class_2_exemption );
      A2W( sys.ni.class_4_lower_profit_limit );
      sys.ni.class_4_rates.Annual_To_Weekly;
      
      sys.it.non_savings_income_rates.Annual_To_Weekly;
      sys.it.savings_income_rates.Annual_To_Weekly; 
      sys.it.dividend_income_rates.Annual_To_Weekly;
      sys.it.non_savings_income_rates.To_Levels;
      sys.it.savings_income_rates.To_Levels; 
      sys.it.dividend_income_rates.To_Levels;
      A2W( sys.it.personal_allowance );
      
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