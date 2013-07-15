--
--  $Author: graham_s $
--  $Date: 2009-01-19 20:37:18 +0000 (Mon, 19 Jan 2009) $
--  $Revision: 6618 $
--
pragma License( Modified_GPL );

with T_Utils;
with Base_Model_Types;

package FRS_Enums is

--
-- For most of these enums we declare a T_Utils package as the simplest way to get sets and arrays 
-- of these types. Note that some are commented out because the 32-bit version of Gnat 2008 on Linux runs out 
-- of memory if all of them are in. 
-- 
   use Base_Model_Types;

   type Acorn is (
      missing,
      no_population_data_available,
      thriving_wealthy_suburbs_large_detached_houses,
      thriving_villages_with_wealthy_commuters,
      thriving_mature_affluent_home_owning_areas,
      thriving_affluent_suburbs_older_families,
      thriving_mature_well_off_suburbs,
      thriving_agricultural_villages_home_based_workers,
      thriving_hol_retreats_oldr_people_home_based_workers,
      thriving_home_owning_areas_well_off_older_residents,
      thriving_private_flats_elderly_people,
      expanding_affluent_working_families_with_mortgages,
      expanding_affluent_wrkng_cpls_with_mortgs_new_homes,
      expanding_transient_wrkfrcs_livng_at_their_place_of_wrk,
      expanding_home_owning_family_areas,
      expanding_home_owning_family_areas_older_children,
      expanding_families_with_mortgages_younger_children,
      rising_well_off_town_and_city_areas,
      rising_flats_and_mortgs_singles_and_young_wrkng_couples,
      rising_furnshed_flats_and_bedsits_ynger_single_people,
      rising_aprtmnts_yng_professional_singles_and_couples,
      rising_gentrified_multi_ethnic_areas,
      rising_prosperous_enclaves_highly_qualified_exectivs,
      rising_academic_cntrs_studnts_and_young_professionals,
      rising_affluent_city_centre_areas_tenements_and_flats,
      rising_partially_gentrified_multi_ethnic_areas,
      rising_converted_flats_and_bedsits_single_people,
      settling_mature_established_home_owning_areas,
      settling_rural_areas_mixed_occupations,
      settling_established_home_owning_areas,
      settling_hme_owng_areas_council_tenants_retired_pple,
      settling_estblshd_home_owning_areas_skilled_workers,
      settling_home_owners_in_oldr_proprts_younger_wrkrs,
      settling_home_owning_areas_with_skilled_workers,
      aspiring_council_areas_some_new_home_owners,
      aspiring_mature_home_owning_areas_skilled_workers,
      aspiring_low_rise_estates_oldr_wrkrs_new_home_ownrs,
      aspiring_home_ownng_multi_ethnic_areas_young_famils,
      aspiring_multi_occupied_town_cntrs_mixed_occupations,
      aspiring_multi_ethnic_areas_white_collar_workers,
      striving_home_ownrs_small_councl_flats_singl_pensnrs,
      striving_council_areas_older_people_health_problems,
      striving_better_off_council_areas_new_home_owners,
      striving_concil_areas_yng_famles_sme_new_hme_oners,
      striving_council_areas_yng_famls_many_lone_parents,
      striving_multi_occupied_terraces_multi_ethnic_areas,
      striving_low_rise_council_housing_less_well_off_famls,
      striving_council_areas_residents_with_health_problems,
      striving_estates_with_high_unemployment,
      striving_council_flats_elderly_people_health_problems,
      striving_council_flats_very_high_unemploymnt_singles,
      striving_council_areas_high_unemploymnt_one_parents,
      striving_council_flats_greatst_hrdshp_many_lone_parnts,
      striving_multi_ethnic_large_families_overcrowding,
      striving_multi_ethnic_severe_unemplymnt_lone_parents,
      striving_multi_ethnic_high_unemploymnt_overcrowding,
      area_where_code_not_yet_assigned
   );

   function Pretty_Print( i : Acorn ) return String;
   function convert_acorn( i : integer ) return Acorn;

   type Adult_Employment_Status is (
      missing,
      self_employed,
      full_time_employee,
      part_time_employee,
      ft_employee_temporarily_sick,
      pt_employee_temporarily_sick,
      industrial_action,
      unemployed,
      work_related_govt_training,
      retired,
      unoccupied_under_retirement_age,
      temporarily_sick,
      long_term_sick,
      students_in_non_advanced_fe,
      unpaid_family_workers
   );

   -- package Adult_Employment_Status_Package is new T_Utils( 
      -- Rate_Type    => Rate, 
      -- Amount_Type  => Amount, 
      -- Counter_Type => Counter_Type, 
      -- T            => Adult_Employment_Status );         
   
   function Pretty_Print( i : Adult_Employment_Status ) return String;
   function convert_adult_employment_status( i : integer ) return Adult_Employment_Status;
   
   --
   -- This is the census classification, NOT from the FRS 
   --
   type Census_Age_Group is (
      age_0_4,
      age_5_15,
      age_16_29,
      age_33_44,
      age_45_59,
      age_60_74,
      age_75_and_over );
      
   package Census_Age_Group_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Census_Age_Group );         
   function Pretty_Print( i : Census_Age_Group ) return String;
   function Map_From_Age( age : Natural ) return Census_Age_Group;
   
   
   type Age_Group is (
      missing,
      vage_16_to_24,
      vage_25_to_34,
      vage_35_to_44,
      vage_45_to_54,
      vage_55_to_59,
      vage_60_to_64,
      vage_65_to_74,
      vage_75_to_84,
      vage_85_or_over
   );
   
   package Age_Group_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Age_Group );         
   function Pretty_Print( i : Age_Group ) return String;
   function convert_age_group( i : integer ) return Age_Group;

   type Aggregated_Ethnic_Group is (
      missing,
      white,
      mixed,
      asian_or_asian_british,
      black_or_black_british,
      chinese_or_other_ethnic_group
   );

   package Aggregated_Ethnic_Group_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Aggregated_Ethnic_Group );         
   function Pretty_Print( i : Aggregated_Ethnic_Group ) return String;
   function convert_aggregated_ethnic_group( i : integer ) return Aggregated_Ethnic_Group;

   type Benefit_Types is (
      missing,
      dla_self_care,
      dla_mobility,
      child_benefit,
      pension_credit,
      retirement_pension_opp,
      widows_pension_bereavement_allowance,
      widowed_mothers_widowed_parents_allowance,
      war_disablement_pension,
      war_widows_widowers_pension,
      severe_disability_allowance,
      disabled_persons_tax_credit,
      attendence_allowance,
      invalid_care_allowance,
      jobseekers_allowance,
      industrial_injury_disablement_benefit,
      incapacity_benefit,
      working_families_tax_credit,
      income_support,
      new_deal,
      maternity_allowance,
      maternity_grant_from_social_fund,
      funeral_grant_from_social_fund,
      community_care_grant_from_social_fund,
      back_to_work_bonus_received,
      back_to_work_bonus_accrued,
      any_other_ni_or_state_benefit,
      trade_union_sick_strike_pay,
      friendly_society_benefits,
      private_sickness_scheme_benefits,
      accident_insurance_scheme_benefits,
      hospital_savings_scheme_benefits,
      government_training_allowances,
      guardians_allowance,
      social_fund_loan_budgeting,
      social_fund_loan_crisis,
      working_families_tax_credit_lump_sum,
      future_dla_self_care,
      future_dla_mobility,
      future_attendance_allowance,
      disabled_persons_tax_credit_lump_sum,
      child_maintenance_bonus,
      lone_parent_benefit_run_on,
      widows_payment,
      unemployment_redundancy_insurance,
      winter_fuel_payments,
      dwp_direct_payments_isa,
      dwp_direct_payments_jsa,
      hb_only_or_separately,
      ctb_only_or_separately,
      hb_ctb_paid_together,
      permanent_health_insurance,
      any_other_sickness_insurance,
      critical_illness_cover,
      working_tax_credit,
      child_tax_credit,
      working_tax_credit_lump_sum,
      child_tax_credit_lump_sum
   );

   package Benefit_Types_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Benefit_Types );         
   function Pretty_Print( i : Benefit_Types ) return String;
   function convert_benefit_types( i : integer ) return Benefit_Types;

   type Benefit_Unit_Economic_Status is (
      missing,
      self_employed,
      v1_or_2_adults_in_f_t_employed_work,
      v2_adults_one_in_f_t_other_p_t,
      v2_adults_one_f_t_as_employee_other_not,
      v1_or_2_adults_at_least_1_in_p_t_work,
      v1_or_2_adults_head_or_spouse_aged_60plus,
      v1_or_2_adults_hd_or_sp_unemployed,
      v1_or_2_adults_hd_or_sp_sick_lt_pen_age,
      any_other_category
   );

   package Benefit_Unit_Economic_Status_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Benefit_Unit_Economic_Status );         
   function Pretty_Print( i : Benefit_Unit_Economic_Status ) return String;
   function convert_benefit_unit_economic_status( i : integer ) return Benefit_Unit_Economic_Status;

   type Benefit_Unit_Type is (
      missing,
      any_other_category,
      pensioner_couple,
      pensioner_single,
      couple_with_children,
      couple_without_children,
      lone_parent,
      single_without_children
   );

   package Benefit_Unit_Type_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Benefit_Unit_Type );         
   function Pretty_Print( i : Benefit_Unit_Type ) return String;
   function convert_benefit_unit_type( i : integer ) return Benefit_Unit_Type;

   type BU_Disabled_Indicator is (
      missing,
      v1_person_in_bu_blind,
      v2_people_in_bu_blind,
      v1_person_in_bu_disabled,
      v2_people_in_bu_disabled,
      v1_person_blind_and_1_person_disabled,
      no_one_blind_or_disabled
   );

   package BU_Disabled_Indicator_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => BU_Disabled_Indicator );         
   function Pretty_Print( i : BU_Disabled_Indicator ) return String;
   function convert_bu_disabled_indicator( i : integer ) return BU_Disabled_Indicator;

   type Employment_Status is (
      missing,
      self_employed,
      full_time_employee,
      part_time_employee,
      ft_employee_temporarily_sick,
      pt_employee_temporarily_sick,
      industrial_action,
      unemployed,
      work_related_govt_training,
      retired,
      unoccupied_under_retirement_age,
      temporarily_sick,
      long_term_sick,
      students_in_non_advanced_fe,
      unpaid_family_workers
   );
   
   package Employment_Status_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Employment_Status );         

   function Pretty_Print( i : Employment_Status ) return String;
   function convert_employment_status( i : integer ) return Employment_Status;

   type Ethnic_Group is (
      missing,
      white_british,
      any_other_white_background,
      mixed_white_and_black_caribbean,
      mixed_white_and_black_african,
      mixed_white_and_asian,
      any_other_mixed_background,
      asian_or_asian_british_indian,
      asian_or_asian_british_pakistani,
      asian_or_asian_british_bangladeshi,
      any_other_asian_asian_british_background,
      black_or_black_british_caribbean,
      black_or_black_british_african,
      any_other_black_black_british_background,
      chinese,
      any_other
   );

   package Ethnic_Group_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Ethnic_Group );         
   function Pretty_Print( i : Ethnic_Group ) return String;
   function Convert_Ethnic_Group( i : integer ) return Ethnic_Group;

   type HBAI_Benefit_Unit_Type is (
      missing,
      any_other_category,
      pensioner_couple,
      pensioner_single,
      couple_with_children,
      couple_without_children,
      lone_parent,
      single_without_children
   );

   package HBAI_Benefit_Unit_Type_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => HBAI_Benefit_Unit_Type );         
   function Pretty_Print( i : HBAI_Benefit_Unit_Type ) return String;
   function convert_hbai_benefit_unit_type( i : integer ) return HBAI_Benefit_Unit_Type;

   type Household_Composition is (
      missing,
      one_male_adult_no_children_over_pension_age,
      one_female_adult_no_children_over_pension_age,
      one_male_adult_no_children_under_pension_age,
      one_female_adult_no_children_under_pension_age,
      two_adults_no_children_both_over_pension_age,
      two_adults_no_children_one_over_pension_age,
      two_adults_no_children_both_under_pension_age,
      three_or_more_adults_no_children,
      one_adult_one_child,
      one_adult_two_children,
      one_adult_three_or_more_children,
      two_adults_one_child,
      two_adults_two_children,
      two_adults_three_or_more_children,
      three_or_more_adults_one_child,
      three_or_more_adults_two_children,
      three_or_more_adults_three_or_more_chidren
   );

   package Household_Composition_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Household_Composition );         
   function Pretty_Print( i : Household_Composition ) return String;
   function convert_household_composition( i : integer ) return Household_Composition;

   type Household_Income_Band is (
      missing,
      vunder_100_a_week,
      v100_and_less_than_200,
      v200_and_less_than_300,
      v300_and_less_than_400,
      v400_and_less_than_500,
      v500_and_less_than_600,
      v600_and_less_than_700,
      v700_and_less_than_800,
      v800_and_less_than_900,
      v900_and_less_than_1000,
      vabove_1000
   );

   -- package Household_Income_Band_Package is new T_Utils( 
      -- Rate_Type    => Rate, 
      -- Amount_Type  => Amount, 
      -- Counter_Type => Counter_Type, 
      -- T            => Household_Income_Band );         
   function Pretty_Print( i : Household_Income_Band ) return String;
   function convert_household_income_band( i : integer ) return Household_Income_Band;

   type ILO_Employment_Status is (
      missing,
      full_time_employee,
      part_time_employee,
      full_time_self_employed,
      part_time_self_employed,
      unemployed,
      retired,
      student,
      looking_after_family_home,
      permanently_sick_disabled,
      temporarily_sick_injured,
      other_inactive
   );

   package ILO_Employment_Status_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => ILO_Employment_Status );         
   function Pretty_Print( i : ILO_Employment_Status ) return String;
   function convert_ilo_employment_status( i : integer ) return ILO_Employment_Status;

   type Marital_Status is (
      missing,
      married,
      cohabiting,
      single,
      widowed,
      separated,
      divorced,
      same_sex_couple
   );

   package Marital_Status_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Marital_Status );         
   function Pretty_Print( i : Marital_Status ) return String;
   function convert_marital_status( i : integer ) return Marital_Status;

   type Non_Dependency_Class is (
      missing,
      boarder,
      lodger,
      vaged_18plus_working_full_time,
      vaged_18plus_on_yts_jobskills,
      vaged_18_24_on_is,
      vaged_25plus_on_is,
      student,
      vothers_18plus,
      vaged_16_17
   );

   -- package Non_Dependency_Class_Package is new T_Utils( 
      -- Rate_Type    => Rate, 
      -- Amount_Type  => Amount, 
      -- Counter_Type => Counter_Type, 
      -- T            => Non_Dependency_Class );         
   function Pretty_Print( i : Non_Dependency_Class ) return String;
   function convert_non_dependency_class( i : integer ) return Non_Dependency_Class;

   type Old_Region is (
      missing,
      north_east,
      north_west,
      merseyside,
      yorks_and_humberside,
      east_midlands,
      west_midlands,
      eastern,
      london,
      south_east,
      south_west,
      wales,
      scotland,
      northern_ireland
   );

   -- package Old_Region_Package is new T_Utils( 
      -- Rate_Type    => Rate, 
      -- Amount_Type  => Amount, 
      -- Counter_Type => Counter_Type, 
      -- T            => Old_Region );         
   function Pretty_Print( i : Old_Region ) return String;
   function convert_old_region( i : integer ) return Old_Region;

   type Pension_Types is (
      missing,
      basic_pension,
      basic_increment,
      graduated_pension,
      age_addition,
      increase_of_pension_for_an_adult,
      increase_of_pension_for_children,
      invalidity_addition,
      attendance_allowance,
      additonl_pension_before_contracted_out_dedct,
      contracted_out_deduction,
      add_pension_after_contracted_out_deduct,
      additional_pension_increments,
      upgrading_of_contracted_out_increments,
      care_component_high,
      care_component_middle,
      care_component_low,
      mobility_component_high,
      mobility_component_low,
      pension_credit_guaranteed_element_amt,
      pension_credit_savings_element_amt
   );

   -- package Pension_Types_Package is new T_Utils( 
      -- Rate_Type    => Rate, 
      -- Amount_Type  => Amount, 
      -- Counter_Type => Counter_Type, 
      -- T            => Pension_Types );         
   function Pretty_Print( i : Pension_Types ) return String;
   function convert_pension_types( i : integer ) return Pension_Types;

   type Regional_Stratifier is (
      missing,
      north_east_met,
      north_east_non_met,
      north_west_met,
      north_west_non_met,
      merseyside,
      yorks_and_humberside_met,
      yorks_and_humberside_non_met,
      east_midlands,
      west_midlands_met,
      west_midlands_non_met,
      eastern_outer_metropolitan,
      eastern_other,
      london_north_east,
      london_north_west,
      london_south_east,
      london_south_west,
      south_east_outer_met,
      south_east_other,
      south_west,
      glamorgan_gwent,
      clwyd_gwynedd_dyfed_powys,
      highland_grampian_tayside,
      fife_central_lothian,
      glasgow,
      strathclyde_ex_glasgow,
      borders_dumfries_and_galloway,
      north_of_the_caledonian_canal,
      northern_ireland
   );

   package Regional_Stratifier_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Regional_Stratifier );         
   function Pretty_Print( i : Regional_Stratifier ) return String;
   function convert_regional_stratifier( i : integer ) return Regional_Stratifier;

   type Relationship_To_Head_Of_Household is (
      missing,
      spouse,
      cohabitee,
      son_daughter_incl_adopted,
      step_son_daughter,
      foster_child,
      son_in_law_daughter_in_law,
      parent,
      step_parent,
      foster_parent,
      parent_in_law,
      brother_sister_incl_adopted,
      step_brother_sister,
      foster_brother_sister,
      brother_sister_in_law,
      grand_child,
      grand_parent,
      other_relative,
      other_non_relative
   );

   package Relationship_To_Head_Of_Household_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Relationship_To_Head_Of_Household );         
   function Pretty_Print( i : Relationship_To_Head_Of_Household ) return String;
   function convert_relationship_to_head_of_household( i : integer ) return Relationship_To_Head_Of_Household;

   type Standard_Region is (
      missing,
      north_east,
      north_west_and_merseyside,
      yorks_and_humberside,
      east_midlands,
      west_midlands,
      eastern,
      london,
      south_east,
      south_west,
      wales,
      scotland,
      northern_ireland
   );

   package Standard_Region_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Standard_Region );         
   function Pretty_Print( i : Standard_Region ) return String;
   function convert_standard_region( i : integer ) return Standard_Region;

   type Tenure_Type is (
      missing,
      owns_it_outright,
      buying_with_the_help_of_a_mortgage,
      part_own_part_rent,
      rents,
      rent_free,
      squatting
   );

   package Tenure_Type_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Tenure_Type );         
   function Pretty_Print( i : Tenure_Type ) return String;
   function convert_tenure_type( i : integer ) return Tenure_Type;

   type Gender is (
      missing,
      male,
      female
   );

   package Gender_Package is new T_Utils( 
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Gender );         
   function Pretty_Print( i : Gender ) return String;
   function convert_gender( i : integer ) return Gender;

   --
   -- The agg group is actually missing in the data, so: 
   --
   function Make_Aggregated_Ethnic_Group_From_Ethnic_Group( group : Ethnic_Group ) return Aggregated_Ethnic_Group;

end FRS_Enums;
