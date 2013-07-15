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

--
--  $Author: graham_s $
--  $Date: 2009-01-19 20:37:18 +0000 (Mon, 19 Jan 2009) $
--  $Revision: 6618 $
--
pragma License( Modified_GPL );

with T_Utils;
-- with T_Utils.Conditional_Amount_Calculator;
with Base_Model_Types;
with Ada.Calendar;

package ZA.Model_Types is
  
   subtype Simulation_Year_Range is Ada.Calendar.Year_Number range 2009 .. 2009;
   
   type System_Number is new Natural range 0 .. 2;
   subtype System_Range is System_Number range 1 .. 2;

   type Poverty_Type is ( extreme_poverty, poverty, mild_poverty, not_in_poverty );
   function Pretty_Print( p : Poverty_Type ) return String;
  
   type Age_Group_Type is (  
      age_00_to_04_years,
      age_05_to_09_years,
      age_10_to_14_years,
      age_15_to_19_years,
      age_20_to_24_years,
      age_25_to_29_years,
      age_30_to_34_years,
      age_35_to_39_years,
      age_40_to_44_years,
      age_45_to_49_years,
      age_50_to_54_years,
      age_55_to_59_years,
      age_60_to_64_years,
      age_65_to_69_years,
      age_70_to_74_years,
      age_75_to_79_years,
      age_80_to_84_years,
      age_85_plus,
      unspecified );
      
   function Pretty_Print( i : Age_Group_Type ) return String;
   
   type Expenses_Conditional_Type is ( is_disabled, is_blind );
   
   type Personal_Expenses_Type is ( 
      travel_to_work, 
      health_spending, 
      health_insurance, 
      pension_contributions, 
      annuity_funds_contributions );
   function Pretty_Print( i : Personal_Expenses_Type ) return String;
   
   type Gender_Type is (  
      male,
      female,
      unspecified );      
   function Pretty_Print( i : Gender_Type ) return String;
   package Gender_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Gender_Type );
   subtype Gender_Array is Gender_Package.Amount_Array;  

   
   type Education_Level is (  
      no_schooling,
      grade_r_or_0,
      grade_1_or_sub_a,
      grade_2_or_sub_b,
      grade_3_or_standard_1,
      grade_4_or_standard_2,
      grade_5_or_standard_3,
      grade_6_or_standard_4,
      grade_7_or_standard_5,
      grade_8_or_standard_6_or_form_1,
      grade_9_or_standard_7_or_form_2,
      grade_10_or_standard_8_or_form_3,
      grade_11_or_standard_9_or_form_4,
      grade_12_or_standard_10_or_form_5_or_matric,
      ntc_l,
      ntc_ii,
      ntc_iii,
      diploma_or_certificate_with_less_than_grade_12_or_std_10,
      diploma_with_less_than_grade_12_or_std_10,
      certificate_with_grade_12_or_std_10,
      diploma_with_grade_12_or_std_10,
      bachelors_degree,
      bachelors_degree_and_diploma,
      honours_degree,
      higher_degree_masters_doctorate,
      other_education,
      dont_know_or_unspecified );
   function Pretty_Print( i : Education_Level ) return String;

   type Dwelling_Type is (  
      boarding_school_or_university_hostel,
      old_age_home,
      frail_care_centre,
      home_for_the_disabled,
      initiation_school,
      prison,
      retirement_village,
      hospital_or_medical_facility_or_clinic,
      private_house,
      other_dwelling_type,
      unspecified );
   function Pretty_Print( i : Dwelling_Type ) return String;
   
   type Population_Group is (  
      african_or_black,
      coloured,
      indian_or_asian,
      white,
      other_population_group );
      
   function Pretty_Print( i : Population_Group ) return String;
   package Population_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Population_Group );
   subtype Population_Array is Population_Package.Amount_Array;  
   
   type Province_Type is (  
      western_cape,
      eastern_cape,
      northern_cape,
      free_state,
      kwazulu_natal,
      north_west,
      gauteng,
      mpumalanga,
      limpopo );
   function Pretty_Print( i : Province_Type ) return String;
   
   package Province_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Province_Type );
   subtype Province_Array is Province_Package.Amount_Array;  
  
   type Settlement_Type is (  
      urban,
      rural );
   function Pretty_Print( i : Settlement_Type ) return String;
   package Settlement_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Settlement_Type );
   subtype Settlement_Array is Settlement_Package.Amount_Array;  
   
   type Main_Dwelling_Type is (  
      dwelling_or_brick_structure_on_a_separate_stand_or_yard_or_on_farm,
      traditional_dwelling_or_hut_or_structure_made_of_traditional_material,
      flat_or_apartment_in_a_block_of_flats,
      town_or_cluster_or_semi_detached_house_simplex_duplex_or_triplex,
      unit_in_retirement_village,
      dwelling_or_flat_or_room_in_backyard,
      informal_dwelling_or_shack_in_backyard,
      informal_dwelling_or_shack_not_in_backyard_eg_in_an_informal_or_squatter_settlement_or_on_farm,
      room_or_flatlet_or_a_larger_dwelling_or_servants_quarters_or_granny_flat,
      caravan_or_tent,
      workers_hostel,
      family_unit_formerly_workers_hostel,
      other_dwelling_type,
      unspecified );
   function Pretty_Print( i : Main_Dwelling_Type ) return String;

   type Ownership_Type is (  
      owns,
      does_not_own_but_has_access_to,
      neither_owns_nor_has_access,
      unspecified );
   function Pretty_Print( i : Ownership_Type ) return String;
   
   type Tenure_Type is (  
      owned_and_fully_paid_off,
      owned_but_not_yet_fully_paid_off_eg_with_a_mortgage,
      rented_as_part_of_employment_contract_of_household_member,
      rented_not_as_part_of_employment_contract_of_household_member,
      occupied_rent_free_as_part_of_employment_contract_of_household_member,
      occupied_rent_free_not_as_part_of_employment_contract_of_household_member,
      occupied_as_a_boarder_or_lodger,
      other_tenure_type,
      unspecified );
   package Tenure_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Tenure_Type );
   subtype Tenure_Array is Tenure_Package.Amount_Array;
      
   function Pretty_Print( i : Tenure_Type ) return String;
   
   type Consumption_Type is ( --  IES Tertiary list  
      bread_and_cereals,
      meat,
      fish,
      milk_cheese_and_eggs,
      oils_and_fats,
      fruits,
      vegetables,
      sugar_jam_honey_chocolate_and_confectionery,
      food_products_nec,
      coffee_tea_and_cocoa,
      mineral_waters_soft_drinks_fruit_and_vegetable_juices,
      unclassified_food_items,
      spirits,
      wine,
      beer,
      tobacco,
      clothing_materials,
      garments,
      other_articles_of_clothing_and_clothing_accessories,
      cleaning_repair_and_hire_of_clothing,
      shoes_and_other_footwear,
      repair_and_hire_of_foowear,
      actual_rentals_paid_by_tenants,
      imputed_rentals_of_owner_occupiers,
      materials_for_maintenance_and_repair_of_the_dwelling,
      service_of_the_maintenance_and_repair_of_the_dwelling,
      water_and_electricity,
      water_supply,
      refuse_collection,
      sewarage_collection,
      other_services_relating_to_the_dwelling,
      electricity,
      gas,
      liquid_fuels,
      solid_fuels,
      furniture_and_furnishings,
      carpets_and_other_floor_covering,
      repair_of_furniture_furnishings_and_floor_covering,
      household_textile,
      major_household_appliances_wheter_or_no_aelectriccal,
      small_electrical_household_appliance,
      repair_of_household_appliance,
      glassware_tableware_and_household_utensils,
      major_tools_and_equipment,
      small_tools_and_miscellaneous_accessories,
      non_durable_household_goods,
      domestics_services_and_household_arcticles,
      pharmaceutical_products,
      other_medical_products,
      therapeutic_appliances_and_equipment,
      medical_services,
      dental_services,
      paramedic_services,
      hospital_services,
      motor_cars,
      motor_cycles,
      bicycles,
      animal_drawn_vehicle,
      spare_parts_and_accessories,
      fuels_and_lubricants,
      maintenance_and_repairs_of_personal_transport_equipment,
      other_services_in_respect_of_personal_transport_equipment,
      passenger_transport_by_railway,
      passenger_transport_by_road,
      passenger_transport_by_air,
      passenger_transport_by_sea_and_inland_waterway,
      other_puchased_transport_services,
      cost_for_other_modes_of_transport,
      postal_services,
      telephone_and_telefax_equipment,
      telephone_and_telefax_services,
      equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures,
      photographic_and_cinematographic_equipment_and_optical_instruments,
      information_processing_equipment,
      recording_meedia,
      major_durables_for_outdoor_recreation,
      musical_instrument_and_major_durables_for_outdoor_recreation,
      maintenance_and_repair_of_other_major_durables_for_recreation_and_culture,
      games_toys_and_hobbies,
      equipment_for_sport_camping_and_open_air_recreation,
      gardens_plants_and_flowers,
      pets_and_related_products,
      veterinary_and_other_services,
      recreational_and_sporting_services,
      cultural_services,
      games_of_chances,
      books,
      newspaper_and_periodicals,
      miscellaneous_printed_matter,
      stationery_and_drawing_materials,
      package_holidays,
      pre_primary_and_primary_education,
      scondary_education,
      tertiary_education,
      education_not_definable_by_level,
      beverages_in_restaurants_cafes_canteens_and_the_likes,
      meals_in_restaurants_cafes_canteens_and_the_likes,
      accommodation_services,
      hairdressing_salons_and_personal_grooming_astablishment,
      elecrtical_appliances_for_personal_care,
      other_appliances_articles_and_products_for_personal_care,
      jewellery_clocks_and_watches,
      other_personal_effects,
      social_protection_services,
      insurance_connected_with_the_dwelling,
      insurance_connected_with_the_health,
      insurance_connected_with_the_transport,
      other_insurance,
      financial_services_nec,
      other_services,
      consumption_unclassified_diary_items,
      consumption_others_expenditures,
      in_kind_consumption,
      income_from_salaries_and_wages,
      income_from_self_employment_and_business,
      income_from_property,
      income_from_royalties,
      income_interest_received,
      income_from_dividends,
      income_from_other_dividends,
      income_from_pension_from_previous_employment,
      income_from_annuities_from_own_investment,
      income_from_social_pensions,
      income_from_alimony_palimony_and_other_allowances,
      other_income_from_individuals,
      other_income,
      income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling,
      in_kind_income_from_free_water,
      in_kind_income_from_free_sanitation,
      in_kind_income_from_free_electricity,
      in_kind_income_from_estimated_value_of_private_use_of_company_vehicle,
      in_kind_income_from_value_of_discounted_fares_for_educational_purposes,
      in_kind_income_from_value_of_discounted_fares_for_non_educational_purposes,
      in_kind_income_from_schools_and_other_edu_inst_publice_grant,
      in_kind_income_from_schools_and_other_edu_inst_privat_grant,
      in_kind_income_from_library_fees_fines_grant,
      in_kind_income_from_library_services_grant,
      in_kind_income_from_textbooks_for_public_institutions_grant,
      in_kind_income_from_textbooks_for_private_institutions_grant,
      in_kind_income_from_stationery_public_grant,
      in_kind_income_from_stationery_private_grant,
      in_kind_income_from_other_specify_public_grant,
      in_kind_income_from_other_specify_private_grant,
      in_kind_income_from_pre_primary_primary_education_and_vocational_training_grants_public_and_private,
      in_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private,
      in_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public,
      in_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant,
      in_kind_income_from_universities_boarding_fees_in_public_institution_grant,
      in_kind_income_from_schools_boarding_fees_in_private_institutions_grant,
      in_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant,
      in_kind_income_from_universities_boarding_fees_in_private_institution_grant,
      in_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant,
      savings_from_improvements_additions_and_alterations,
      savings_from_services_for_improvements_additions_and_alterations,
      savings_from_security_structures,
      savings_from_building_materials_not_included_in_q813,
      savings_from_labour_and_material_for_improvements_additions_and_alterations,
      savings_from_cost_of_other_dewlling,
      savings_from_capital_payments,
      savings_from_monthly_capital_payments,
      savings_from_other_payments,
      savings_from_purchase_and_levy_of_timeshare,
      savings_from_life_and_endownment_policies,
      savings_from_life_insurance_covering_mortgage_debt,
      savings_from_repayment_on_loans_and_overdrafts,
      savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution,
      savings_from_contributions_to_a_stokvel,
      savings_from_listed_company_shares,
      savings_from_unlisted_company_shares,
      savings_from_unit_trusts,
      savings_from_investment_plans,
      savings_from_offshore,
      savings_from_other_investments,
      savings_from_deposits_into_savings,
      savings_from_wthdrawals_from_savings,
      taxes_site_income_tax,
      taxes_paye_income_tax,
      taxes_according_to_assessment_income_tax,
      taxes_amnesty_tax,
      taxes_unemployment_insurance_fund_uif,
      transfer_toothers,
      debts_bond_loan_from_the_bank,
      debts_other_loans,
      debts_motor_vehicle_loan_from_the_bank,
      debts_bank_overdraft,
      debts_other_bank_loans,
      debts_furniture_and_appliances_amount_oustanding,
      debts_retail_stores,
      debts_loans_from_friends_and_family,
      debts_loans_from_money_lenders,
      debts_arreas_on_municipal_bills,
      loss_expenditure_incurred_in_obtaining_income,
      -- gks: dup imputed_rentals_of_owner_occupiers,
      panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party,
      interest_on_mortgage_bonds,
      subsidy_on_payment_of_mortgage,
      imputed_cost_for_home_production,
      other_products_not_consumption );
   
   subtype Consumption_Range is Consumption_Type range
      bread_and_cereals .. consumption_others_expenditures;
   subtype Food_Range is Consumption_Range range 
      bread_and_cereals .. unclassified_food_items;
      
   function Pretty_Print( i : Consumption_Type ) return String;    
  
   type Poverty_State is ( in_poverty, not_in_poverty );
   function Pretty_Print( i : Poverty_State ) return String;    
   
   type Personal_Incomes_Type is (
      salaries_and_wages,
      self_employment_and_business_income,
      property_income,
      royalties,
      interest_received,
      dividends,
      private_pensions,
      annuities,
      alimony_palimony_and_other_allowances,
      income_from_other_individuals,
      other_income,
      in_kind_water_sanitation_electricity,
      in_kind_company_vehicle_or_discounted_fares,
      in_kind_education,
      in_kind_child_care,
      disability_grants,
      old_age_pensions,
      family_allowances,
      -- social_pensions,
      other_state_benefits,
      -- paye_income_tax,
      site_income_tax,
      employers_uif,
      employees_uif );
   subtype Gross_Personal_Incomes_Range is 
      Personal_Incomes_Type range salaries_and_wages .. other_income; 
   subtype Personal_Taxes_Range is 
      Personal_Incomes_Type range site_income_tax .. employees_uif; 
   subtype Personal_State_Benefits_Range is 
      Personal_Incomes_Type range disability_grants .. other_state_benefits; 
   subtype In_Kind_Personal_Incomes_Range is 
      Personal_Incomes_Type range in_kind_water_sanitation_electricity .. in_kind_child_care; 
   subtype Calculated_Incomes is 
      Personal_Incomes_Type range disability_grants .. employees_uif;
   
   package Income_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Personal_Incomes_Type );
   subtype Income_Array is Income_Package.Amount_Array;  
   subtype Included_Income_Array is Income_Package.Rate_Array;  
   subtype Calculated_Incomes_Array is 
      Income_Package.Abs_Amount_Array( Calculated_Incomes );
   subtype Benefits_Array is 
      Income_Package.Abs_Amount_Array( Personal_State_Benefits_Range );
   
   function Calculate_Income( 
      incomes : Income_Array; 
      propns  : Included_Income_Array ) return Amount;
   
   package Consumption_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Consumption_Type );
   --
   -- FIXME better names than consumption, expenditure
   --
   subtype Consumption_Array is Consumption_Package.Amount_Array;
   subtype Included_Consumption_Array is Consumption_Package.Rate_Array;
   
   subtype Expenditure_Array is 
      Consumption_Package.Abs_Amount_Array( Consumption_Range ); 
   subtype Expenditure_Rate_Array is 
      Consumption_Package.Abs_Rate_Array( Consumption_Range );
   
   function Pretty_Print( i : Personal_Incomes_Type ) return String;
   
   type Person_Count is new Natural range 0 .. 24;
   subtype Person_Range is Person_Count range 1 .. Person_Count'Last;
   type Family_Unit_Count is 
      new Natural range 0 .. 24;
   subtype Family_Unit_Range is 
      Family_Unit_Count range 1 .. Family_Unit_Count'Last;
   
   -- subtype Age_Range is Natural range 0 .. 150;
   --
   -- Assumed max of 24 hours a day for 30 days a month
   --
   subtype Hours_Of_Work_Per_Month is Natural range 0 .. ( 24*30 );
   
   package Expenses_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Personal_Expenses_Type );
      
--   package Conditional_Expenses is new 
--      Expenses_Package.Conditional_Amount_Calculator( 
--         Conditional=>Expenses_Conditional_Type );
   
   subtype Personal_Expenses_Array is Expenses_Package.Amount_Array;  
   subtype Allowable_Expenses_Array is Expenses_Package.Rate_Array;  
     
   function Calculate_Expenses( 
      expenses : Personal_Expenses_Array; 
      propns : Allowable_Expenses_Array  ) return Amount;

end ZA.Model_Types;
