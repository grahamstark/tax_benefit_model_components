with T_Utils;
with Base_Model_Types;
with Ada.Calendar;

package Standard_UK_Enums is

   use Base_Model_Types;
   use Ada.Calendar;
   
   subtype Decile_Number is Positive range 1 .. 10;
   type Deciles_Array is array( Decile_Number ) of Amount;
   
   type Head_Or_Spouse is ( neither, head, spouse );
   subtype Head_Or_Spouse_Id is Head_Or_Spouse range head .. spouse;

   type Income_Tax_Income_Types is (
      non_savings_income,
      savings_income,
      dividend_income );
   
   type Broad_Qualification_Type is ( 
      no_qualification,
      gcse, 
      btec_etc,
      a_level,
      other_higher_ed,
      degree,
      other_qualification );
   
   type Broad_Tenure_Type is ( 
      social_rented, 
      private_rented, 
      shared_ownership, 
      mortgaged,
      owned_outright,
      other );

   subtype Rented is Broad_Tenure_Type range  social_rented .. shared_ownership;  
      
   type Expenses_Type is ( 
      health_insurance,
      alimony_and_child_support_paid,
      care_insurance,
      trade_unions_etc,
      friendly_societies, 
      work_expenses,
      repayments,
      pension_contributions
      );

   package T_Expenses is new T_Utils(
      T             => Expenses_Type,
      Rate_Type     => Base_Model_Types.Rate,
      Amount_Type   => Base_Model_Types.Amount,
      Counter_Type  => Base_Model_Types.Counter_Type );

   subtype Expenses_List is T_Expenses.Amount_Array;
   subtype Expenses_Included is T_Expenses.Rate_Array;
   subtype Expenses_Set is T_Expenses.Set;
   
   type Broad_Calculated_Type is (
      taxable_income,
      gross_income,
      net_income,
      equivalence_scale, 
      income_for_tax_credits,
      marginal_rate,
      housing_allowance,
      minimum_income_guarantee,
      employers_ni );
      
   package T_Broad_Calculated is new T_Utils(
      T             => Broad_Calculated_Type,
      Rate_Type     => Base_Model_Types.Rate,
      Amount_Type   => Base_Model_Types.Amount,
      Counter_Type  => Base_Model_Types.Counter_Type );

   subtype Broad_Calculated_List is T_Broad_Calculated.Amount_Array;
   subtype Broad_Calculated_Set is T_Broad_Calculated.Set;
       
   
   type Broad_Incomes_Type is (
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
      bonds_and_gilts,
      other_income,
      other_investment_income,
      sickness_benefits,
      
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
      T             => Broad_Incomes_Type,
      Rate_Type     => Base_Model_Types.Rate,
      Amount_Type   => Base_Model_Types.Amount,
      Counter_Type  => Base_Model_Types.Counter_Type );

   subtype Incomes_List is T_Incomes.Amount_Array;
   subtype Incomes_Included is T_Incomes.Rate_Array;
   subtype Incomes_Set is T_Incomes.Set;

   type Primary_Or_Secondary  is ( primary, secondary );
   subtype Calculated_Incomes_Range is Broad_Incomes_Type range income_tax .. tax_credits;
   subtype Non_Calculated_Incomes_Range is Broad_Incomes_Type range wages .. other_investment_income;
   subtype Direct_Taxes_Range is  Broad_Incomes_Type range income_tax .. national_insurance;
   subtype Benefits_Range is  Broad_Incomes_Type range disabled_living_allowance .. tax_credits;
   subtype Work_Hours_Range is Natural range 0 .. 150;

   type Broad_Employment_Status is ( 
      full_time, 
      part_time, 
      unemployed, 
      in_education, 
      inactive, 
      retired );
      
   type Gender_Type is ( 
      male, 
      female );
      
   type Gender_Type_Array is array( Gender_Type ) of Amount;    
      
   type Relationship_Type is ( 
      head, 
      spouse, 
      civil_partner, 
      child, 
      foster_child, 
      other_relationship );
   --
   -- derived from dataset: frs table: househol
   -- Region_Type uses variable gvtregn
   --
   type Region_Type is (
      north_east,
      north_west,
      yorks_and_the_humber,
      east_midlands,
      west_midlands,
      east_of_england,
      london,
      south_east,
      south_west,
      scotland,
      wales,
      northern_ireland );
      
  subtype English_Region is Region_Type range north_east .. south_west;

  --
   -- derived from dataset: frs table: adult
   -- Marital_Status_Type uses variable marital
   --
   type Marital_Status_Type is (
      married_or_civil_partnership,
      cohabiting,
      single,
      widowed,
      separated,
      divorced_or_civil_partnership_dissolved );
 
  type Marital_Status_Type_Array is array( Marital_Status_Type ) of Amount;    
      
  type Age_Band_Type is (
      age_0_15, 
      age_16_18, 
      age_19_21, 
      age_22_39, 
      age_40_44,
      age_45_49, 
      age_50_54, 
      age_55_59, 
      age_60_64,     
      age_65_69,
      age_70_74, 
      age_75_79, 
      age_80_84, 
      age_85_89, 
      age_90_and_over );

   subtype Adult_Age_Band is Age_Band_Type range age_16_18 .. Age_Band_Type'Last;
   
   --
   -- derived from dataset: frs table: househol
   -- Council_Tax_Band_Type uses variable ctband
   --
   type Council_Tax_Band_Type is (
      band_a,
      band_b,
      band_c,
      band_d,
      band_e,
      band_f,
      band_g,
      band_h,
      band_i,
      na,
      household_not_valued_separately );
      
   --
   -- derived from dataset: frs table: adult
   -- Ethnic_Group_Type uses variable ethgr3
   --
   type Ethnic_Group_Type is (
      white,
      mixed_or_multiple_ethnic_groups,
      asian_or_asian_british,
      black_or_african_or_caribbean_or_black_british,
      other_ethnic_group );

   type Aggregation_Level is ( individual_level, benefit_unit_level, household_level );
   
   
end Standard_UK_Enums;
