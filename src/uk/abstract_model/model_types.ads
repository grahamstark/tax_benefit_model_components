with T_Utils;
with Base_Model_Types;
with Ada.Calendar;

package Model_Types is

   use Base_Model_Types;
   use Ada.Calendar;

   type Income_Tax_Income_Types is (
      non_savings_income,
      savings_income,
      dividend_income );
   
   type Qualification_Type is ( 
      no_qualification,
      gcse, 
      btec_etc,
      a_level,
      other_higher_ed,
      degree,
      other_qualification );
   
   type Tenure_Type is ( 
      social_rented, 
      private_rented, 
      shared_ownership, 
      mortgaged,
      owned_outright,
      other );

   subtype Rented is Tenure_Type range  social_rented .. shared_ownership;  
      
   type Incomes_Type is (
      wages,
      self_employment,
      private_pensions,
      national_savings,
      bank_interest,
      building_society,
      stocks_shares,
      peps,
      isa,
      dividends,
      property,
      royalties,
      other_income,
      other_investment_income,

      income_tax,
      national_insurance,
      local_taxes,
      repayments,
      
      education_allowances,
      foster_care_payments,
      student_grants,
      student_loans,
      
      disabled_living_allowance,
      child_benefit,
      pension_credit,
      retirement_pension,
      other_pensions,
      severe_disablement_allowance,
      attendance_allowance,
      invalid_care_allowance,
      jobseekers_allowance,
      incapacity_benefit,
      income_support_jsa,
      maternity_allowance,
      other_benefits,
      winter_fuel_payments,
      housing_benefit,
      council_tax_benefit,
      tax_credits );

   type Housing_Cost_Type is ( 
      rent, 
      mortgage, 
      local_tax ); -- ... and so on
      
   type Housing_Array is array( Housing_Cost_Type ) of Amount;

   package T_Incomes is new T_Utils(
      T             => Incomes_Type,
      Rate_Type     => Base_Model_Types.Rate,
      Amount_Type   => Base_Model_Types.Amount,
      Counter_Type  => Base_Model_Types.Counter_Type );

   subtype Incomes_List is T_Incomes.Amount_Array;
   subtype Incomes_Set is T_Incomes.Set;

   type Primary_Or_Secondary  is ( primary, secondary );
   subtype Calculated_Incomes_Range is Incomes_Type range income_tax .. tax_credits;
   subtype Non_Calculated_Incomes_Range is Incomes_Type range wages .. other_investment_income;
   subtype Direct_Taxes_Range is Incomes_Type range income_tax .. national_insurance;
   subtype Benefits_Range is Incomes_Type range disabled_living_allowance .. tax_credits;
   subtype Work_Hours_Range is Natural range 0 .. 150;

   type Education_Type is ( 
      not_in_education, 
      school, 
      apprentice, 
      further_education, 
      higher_education );
      
   type Employment_Status is ( 
      full_time, 
      part_time, 
      unemployed, 
      in_education, 
      inactive, 
      retired );
      
   type Gender_Type is ( 
      male, 
      female );
      
   type Relationship_Type is ( 
      head, 
      spouse, 
      civil_partner, 
      child, 
      foster_child, 
      other_relationship );

   type Budget_Type is ( 
      -- household_budget, 
      -- individual, 
      childrens_services, 
      local_authority, 
      welsh_government, 
      uk_government );
   type Budget_Array is array( Budget_Type ) of Amount;
   type Budget_By_Year is array( Year_Number range <> ) of Budget_Array;
      
   type Admin_Activity_Type is ( 
      initial_review, 
      maintenance, 
      placement_ceases, 
      bi_annual_review );

   type Practitioner_Type is ( 
      personal_advisor, 
      team_manager, 
      adminstrator );
      
   type Activity_Times is array( Admin_Activity_Type, Practitioner_Type ) of Amount;
   type Admin_Activity_Array is array( Admin_Activity_Type ) of Amount;

   type Practioner_Costs is array( Practitioner_Type ) of Amount;

   type Education_Maintenance_Type_Wales is (
      ema,
      alg_fe,
      tuition_fee_grants,
      assembly_learning_grants,
      maintenance_loans,
      tuition_fee_loans,
      care_leavers_bursary ); -- disabled

   type Maintenance_Array is array( Education_Maintenance_Type_Wales ) of Amount;

end Model_Types;
