package body Coicop_Definitions is

   procedure Aggregate_To( a : in out Secondary_Group_Array; which : in Coicop_Type; value : in Amount ) is
   begin
      if which in Accommodation_services_secondary_range then
            a( Accommodation_services_secondary ) := a( Accommodation_services_secondary ) + value; 
      elsif which in Actual_rentals_for_housing_secondary_range then
            a( Actual_rentals_for_housing_secondary ) := a( Actual_rentals_for_housing_secondary ) + value; 
      elsif which in Alcoholic_beverages_secondary_range then
            a( Alcoholic_beverages_secondary ) := a( Alcoholic_beverages_secondary ) + value; 
      elsif which in Audio_visual_photographic_and_information_processing_equipment_secondary_range then
            a( Audio_visual_photographic_and_information_processing_equipment_secondary ) := a( Audio_visual_photographic_and_information_processing_equipment_secondary ) + value; 
      elsif which in Catering_services_secondary_range then
            a( Catering_services_secondary ) := a( Catering_services_secondary ) + value; 
      elsif which in Clothing_secondary_range then
            a( Clothing_secondary ) := a( Clothing_secondary ) + value; 
      elsif which in Debts_arreas_on_municipal_bills_secondary_range then
            a( Debts_arreas_on_municipal_bills_secondary ) := a( Debts_arreas_on_municipal_bills_secondary ) + value; 
      elsif which in Debts_bank_overdraft_secondary_range then
            a( Debts_bank_overdraft_secondary ) := a( Debts_bank_overdraft_secondary ) + value; 
      elsif which in Debts_bond_loan_from_the_bank_and_other_loans_secondary_range then
            a( Debts_bond_loan_from_the_bank_and_other_loans_secondary ) := a( Debts_bond_loan_from_the_bank_and_other_loans_secondary ) + value; 
      elsif which in Debts_expenditure_incurred_in_obtaining_income_secondary_range then
            a( Debts_expenditure_incurred_in_obtaining_income_secondary ) := a( Debts_expenditure_incurred_in_obtaining_income_secondary ) + value; 
      elsif which in Debts_furniture_and_appliances_amount_oustanding_secondary_range then
            a( Debts_furniture_and_appliances_amount_oustanding_secondary ) := a( Debts_furniture_and_appliances_amount_oustanding_secondary ) + value; 
      elsif which in Debts_loans_from_friends_and_family_secondary_range then
            a( Debts_loans_from_friends_and_family_secondary ) := a( Debts_loans_from_friends_and_family_secondary ) + value; 
      elsif which in Debts_loans_from_money_lenders_secondary_range then
            a( Debts_loans_from_money_lenders_secondary ) := a( Debts_loans_from_money_lenders_secondary ) + value; 
      elsif which in Debts_motor_vehicle_loan_from_the_bank_secondary_range then
            a( Debts_motor_vehicle_loan_from_the_bank_secondary ) := a( Debts_motor_vehicle_loan_from_the_bank_secondary ) + value; 
      elsif which in Debts_other_bank_loans_secondary_range then
            a( Debts_other_bank_loans_secondary ) := a( Debts_other_bank_loans_secondary ) + value; 
      elsif which in Debts_retail_stores_secondary_range then
            a( Debts_retail_stores_secondary ) := a( Debts_retail_stores_secondary ) + value; 
      elsif which in Education_not_definable_by_level_secondary_range then
            a( Education_not_definable_by_level_secondary ) := a( Education_not_definable_by_level_secondary ) + value; 
      elsif which in Electricity_gas_and_other_fuels_secondary_range then
            a( Electricity_gas_and_other_fuels_secondary ) := a( Electricity_gas_and_other_fuels_secondary ) + value; 
      elsif which in Financial_services_nec_secondary_range then
            a( Financial_services_nec_secondary ) := a( Financial_services_nec_secondary ) + value; 
      elsif which in Food_secondary_range then
            a( Food_secondary ) := a( Food_secondary ) + value; 
      elsif which in Footwear_secondary_range then
            a( Footwear_secondary ) := a( Footwear_secondary ) + value; 
      elsif which in Furniture_and_furnishings_carpets_and_other_floor_covering_secondary_range then
            a( Furniture_and_furnishings_carpets_and_other_floor_covering_secondary ) := a( Furniture_and_furnishings_carpets_and_other_floor_covering_secondary ) + value; 
      elsif which in Glassware_tableware_andhousehold_utensils_secondary_range then
            a( Glassware_tableware_andhousehold_utensils_secondary ) := a( Glassware_tableware_andhousehold_utensils_secondary ) + value; 
      elsif which in Goods_and_services_for_routine_household_maintenance_secondary_range then
            a( Goods_and_services_for_routine_household_maintenance_secondary ) := a( Goods_and_services_for_routine_household_maintenance_secondary ) + value; 
      elsif which in Hospital_services_secondary_range then
            a( Hospital_services_secondary ) := a( Hospital_services_secondary ) + value; 
      elsif which in Household_appliances_secondary_range then
            a( Household_appliances_secondary ) := a( Household_appliances_secondary ) + value; 
      elsif which in Household_textiles_secondary_range then
            a( Household_textiles_secondary ) := a( Household_textiles_secondary ) + value; 
      elsif which in Imputed_cost_for_home_production_secondary_range then
            a( Imputed_cost_for_home_production_secondary ) := a( Imputed_cost_for_home_production_secondary ) + value; 
      elsif which in Imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary_range then
            a( Imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary ) := a( Imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary ) + value; 
      elsif which in Imputed_rentals_for_housing_secondary_range then
            a( Imputed_rentals_for_housing_secondary ) := a( Imputed_rentals_for_housing_secondary ) + value; 
      elsif which in Imputed_rentals_of_owner_occupiers_secondary_range then
            a( Imputed_rentals_of_owner_occupiers_secondary ) := a( Imputed_rentals_of_owner_occupiers_secondary ) + value; 
      elsif which in In_kind_consumption_secondary_range then
            a( In_kind_consumption_secondary ) := a( In_kind_consumption_secondary ) + value; 
      elsif which in In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary_range then
            a( In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary ) := a( In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary ) + value; 
      elsif which in In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_range then
            a( In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary ) := a( In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary ) + value; 
      elsif which in In_kind_income_from_free_electricity_secondary_range then
            a( In_kind_income_from_free_electricity_secondary ) := a( In_kind_income_from_free_electricity_secondary ) + value; 
      elsif which in In_kind_income_from_free_sanitation_secondary_range then
            a( In_kind_income_from_free_sanitation_secondary ) := a( In_kind_income_from_free_sanitation_secondary ) + value; 
      elsif which in In_kind_income_from_free_water_secondary_range then
            a( In_kind_income_from_free_water_secondary ) := a( In_kind_income_from_free_water_secondary ) + value; 
      elsif which in In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary_range then
            a( In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary ) := a( In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary ) + value; 
      elsif which in In_kind_income_from_schools_and_other_edu_inst_grant_secondary_range then
            a( In_kind_income_from_schools_and_other_edu_inst_grant_secondary ) := a( In_kind_income_from_schools_and_other_edu_inst_grant_secondary ) + value; 
      elsif which in In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_range then
            a( In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary ) := a( In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary ) + value; 
      elsif which in Income_from_capital_secondary_range then
            a( Income_from_capital_secondary ) := a( Income_from_capital_secondary ) + value; 
      elsif which in Income_from_individuals_secondary_range then
            a( Income_from_individuals_secondary ) := a( Income_from_individuals_secondary ) + value; 
      elsif which in Income_from_work_secondary_range then
            a( Income_from_work_secondary ) := a( Income_from_work_secondary ) + value; 
      elsif which in Insurance_secondary_range then
            a( Insurance_secondary ) := a( Insurance_secondary ) + value; 
      elsif which in Interest_on_mortgage_bonds_secondary_range then
            a( Interest_on_mortgage_bonds_secondary ) := a( Interest_on_mortgage_bonds_secondary ) + value; 
      elsif which in Maintenance_and_repair_of_the_dwelling_secondary_range then
            a( Maintenance_and_repair_of_the_dwelling_secondary ) := a( Maintenance_and_repair_of_the_dwelling_secondary ) + value; 
      elsif which in Medical_products_appliances_and_equipment_secondary_range then
            a( Medical_products_appliances_and_equipment_secondary ) := a( Medical_products_appliances_and_equipment_secondary ) + value; 
      elsif which in Newspapers_books_and_stationary_secondary_range then
            a( Newspapers_books_and_stationary_secondary ) := a( Newspapers_books_and_stationary_secondary ) + value; 
      elsif which in Non_alcoholic_beverages_secondary_range then
            a( Non_alcoholic_beverages_secondary ) := a( Non_alcoholic_beverages_secondary ) + value; 
      elsif which in Operation_of_personal_transport_equipment_secondary_range then
            a( Operation_of_personal_transport_equipment_secondary ) := a( Operation_of_personal_transport_equipment_secondary ) + value; 
      elsif which in Operational_values_of_other_modes_of_transport_secondary_range then
            a( Operational_values_of_other_modes_of_transport_secondary ) := a( Operational_values_of_other_modes_of_transport_secondary ) + value; 
      elsif which in Other_income_secondary_range then
            a( Other_income_secondary ) := a( Other_income_secondary ) + value; 
      elsif which in Other_major_durables_for_recreation_and_culture_secondary_range then
            a( Other_major_durables_for_recreation_and_culture_secondary ) := a( Other_major_durables_for_recreation_and_culture_secondary ) + value; 
      elsif which in Other_products_not_consumption_secondary_range then
            a( Other_products_not_consumption_secondary ) := a( Other_products_not_consumption_secondary ) + value; 
      elsif which in Other_recreational_items_and_equipment_garden_and_pets_secondary_range then
            a( Other_recreational_items_and_equipment_garden_and_pets_secondary ) := a( Other_recreational_items_and_equipment_garden_and_pets_secondary ) + value; 
      elsif which in Other_services_nec_secondary_range then
            a( Other_services_nec_secondary ) := a( Other_services_nec_secondary ) + value; 
      elsif which in Others_diary_secondary_range then
            a( Others_diary_secondary ) := a( Others_diary_secondary ) + value; 
      elsif which in Others_main_secondary_range then
            a( Others_main_secondary ) := a( Others_main_secondary ) + value; 
      elsif which in Out_patient_services_secondary_range then
            a( Out_patient_services_secondary ) := a( Out_patient_services_secondary ) + value; 
      elsif which in Package_holidays_secondary_range then
            a( Package_holidays_secondary ) := a( Package_holidays_secondary ) + value; 
      elsif which in Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary_range then
            a( Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary ) := a( Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary ) + value; 
      elsif which in Pensions_social_insuerance_family_allowances_secondary_range then
            a( Pensions_social_insuerance_family_allowances_secondary ) := a( Pensions_social_insuerance_family_allowances_secondary ) + value; 
      elsif which in Personal_care_secondary_range then
            a( Personal_care_secondary ) := a( Personal_care_secondary ) + value; 
      elsif which in Personal_effects_secondary_range then
            a( Personal_effects_secondary ) := a( Personal_effects_secondary ) + value; 
      elsif which in Postal_services_secondary_range then
            a( Postal_services_secondary ) := a( Postal_services_secondary ) + value; 
      elsif which in Pre_primary_and_primary_education_secondary_range then
            a( Pre_primary_and_primary_education_secondary ) := a( Pre_primary_and_primary_education_secondary ) + value; 
      elsif which in Purchase_of_vehicles_secondary_range then
            a( Purchase_of_vehicles_secondary ) := a( Purchase_of_vehicles_secondary ) + value; 
      elsif which in Recreational_and_cultural_services_secondary_range then
            a( Recreational_and_cultural_services_secondary ) := a( Recreational_and_cultural_services_secondary ) + value; 
      elsif which in Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_range then
            a( Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary ) := a( Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary ) + value; 
      elsif which in Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary_range then
            a( Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary ) := a( Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary ) + value; 
      elsif which in Savings_from_contributions_to_a_stokvel_secondary_range then
            a( Savings_from_contributions_to_a_stokvel_secondary ) := a( Savings_from_contributions_to_a_stokvel_secondary ) + value; 
      elsif which in Savings_from_deposits_and_wthdrawals_secondary_range then
            a( Savings_from_deposits_and_wthdrawals_secondary ) := a( Savings_from_deposits_and_wthdrawals_secondary ) + value; 
      elsif which in Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary_range then
            a( Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary ) := a( Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary ) + value; 
      elsif which in Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_range then
            a( Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary ) := a( Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary ) + value; 
      elsif which in Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_range then
            a( Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary ) := a( Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary ) + value; 
      elsif which in Secondary_education_secondary_range then
            a( Secondary_education_secondary ) := a( Secondary_education_secondary ) + value; 
      elsif which in Social_protection_secondary_range then
            a( Social_protection_secondary ) := a( Social_protection_secondary ) + value; 
      elsif which in Subsidy_on_payment_of_mortgage_secondary_range then
            a( Subsidy_on_payment_of_mortgage_secondary ) := a( Subsidy_on_payment_of_mortgage_secondary ) + value; 
      elsif which in Taxes_amnesty_tax_secondary_range then
            a( Taxes_amnesty_tax_secondary ) := a( Taxes_amnesty_tax_secondary ) + value; 
      elsif which in Taxes_site_paye_and_income_tax_secondary_range then
            a( Taxes_site_paye_and_income_tax_secondary ) := a( Taxes_site_paye_and_income_tax_secondary ) + value; 
      elsif which in Taxes_uif_secondary_range then
            a( Taxes_uif_secondary ) := a( Taxes_uif_secondary ) + value; 
      elsif which in Telephone_and_telefax_equipment_secondary_range then
            a( Telephone_and_telefax_equipment_secondary ) := a( Telephone_and_telefax_equipment_secondary ) + value; 
      elsif which in Telephone_and_telefax_services_secondary_range then
            a( Telephone_and_telefax_services_secondary ) := a( Telephone_and_telefax_services_secondary ) + value; 
      elsif which in Tertiary_education_secondary_range then
            a( Tertiary_education_secondary ) := a( Tertiary_education_secondary ) + value; 
      elsif which in Tobacco_secondary_range then
            a( Tobacco_secondary ) := a( Tobacco_secondary ) + value; 
      elsif which in Tools_and_equipment_for_house_and_garden_secondary_range then
            a( Tools_and_equipment_for_house_and_garden_secondary ) := a( Tools_and_equipment_for_house_and_garden_secondary ) + value; 
      elsif which in Transfers_to_others_secondary_range then
            a( Transfers_to_others_secondary ) := a( Transfers_to_others_secondary ) + value; 
      elsif which in Transport_services_secondary_range then
            a( Transport_services_secondary ) := a( Transport_services_secondary ) + value; 
      elsif which in Unclassified_food_items_secondary_range then
            a( Unclassified_food_items_secondary ) := a( Unclassified_food_items_secondary ) + value; 
      elsif which in Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_range then
            a( Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary ) := a( Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary ) + value; 
      end if;
   end Aggregate_To;
   
   function Map( a : Coicop_Type_Array ) return Main_Group_Array is
      b : Main_Group_Array := (Others=>0.0);
   begin
      for i in a'Range loop
         Aggregate_To( b, i, a( i ));
      end loop;
      return b;
   end Map;
   
   function Map( a : Coicop_Type_Array ) return Secondary_Group_Array is
      b : Secondary_Group_Array := (Others=>0.0);
   begin
      for i in a'Range loop
         Aggregate_To( b, i, a( i ));
      end loop;
      return b;
   end Map;
   
   function Map( a : Coicop_Type_Array ) return Tertiary_Group_Array is
      b : Tertiary_Group_Array := (Others=>0.0);
   begin
      for i in a'Range loop
         Aggregate_To( b, i, a( i ));
      end loop;
      return b;
   end Map;

   procedure Aggregate_To( a : in out Tertiary_Group_Array; which : in Coicop_Type; value : in Amount ) is
   begin
      if which in Accommodation_services_tertiary_range then
         a( Accommodation_services_tertiary ) := a( Accommodation_services_tertiary ) + value; 
      elsif which in Actual_rentals_paid_by_tenants_tertiary_range then
         a( Actual_rentals_paid_by_tenants_tertiary ) := a( Actual_rentals_paid_by_tenants_tertiary ) + value; 
      elsif which in Animal_drawn_vehicle_tertiary_range then
         a( Animal_drawn_vehicle_tertiary ) := a( Animal_drawn_vehicle_tertiary ) + value; 
      elsif which in Beer_tertiary_range then
         a( Beer_tertiary ) := a( Beer_tertiary ) + value; 
      elsif which in Beverages_in_restaurants_cafes_canteens_and_the_likes_tertiary_range then
         a( Beverages_in_restaurants_cafes_canteens_and_the_likes_tertiary ) := a( Beverages_in_restaurants_cafes_canteens_and_the_likes_tertiary ) + value; 
      elsif which in Bicycles_tertiary_range then
         a( Bicycles_tertiary ) := a( Bicycles_tertiary ) + value; 
      elsif which in Books_tertiary_range then
         a( Books_tertiary ) := a( Books_tertiary ) + value; 
      elsif which in Bread_and_cereals_tertiary_range then
         a( Bread_and_cereals_tertiary ) := a( Bread_and_cereals_tertiary ) + value; 
      elsif which in Carpets_and_other_floor_covering_tertiary_range then
         a( Carpets_and_other_floor_covering_tertiary ) := a( Carpets_and_other_floor_covering_tertiary ) + value; 
      elsif which in Cleaning_repair_and_hire_of_clothing_tertiary_range then
         a( Cleaning_repair_and_hire_of_clothing_tertiary ) := a( Cleaning_repair_and_hire_of_clothing_tertiary ) + value; 
      elsif which in Clothing_materials_tertiary_range then
         a( Clothing_materials_tertiary ) := a( Clothing_materials_tertiary ) + value; 
      elsif which in Coffee_tea_and_cocoa_tertiary_range then
         a( Coffee_tea_and_cocoa_tertiary ) := a( Coffee_tea_and_cocoa_tertiary ) + value; 
      elsif which in Consumption_others_expenditures_tertiary_range then
         a( Consumption_others_expenditures_tertiary ) := a( Consumption_others_expenditures_tertiary ) + value; 
      elsif which in Consumption_unclassified_diary_items_tertiary_range then
         a( Consumption_unclassified_diary_items_tertiary ) := a( Consumption_unclassified_diary_items_tertiary ) + value; 
      elsif which in Cost_for_other_modes_of_transport_tertiary_range then
         a( Cost_for_other_modes_of_transport_tertiary ) := a( Cost_for_other_modes_of_transport_tertiary ) + value; 
      elsif which in Cultural_services_tertiary_range then
         a( Cultural_services_tertiary ) := a( Cultural_services_tertiary ) + value; 
      elsif which in Debts_arreas_on_municipal_bills_tertiary_range then
         a( Debts_arreas_on_municipal_bills_tertiary ) := a( Debts_arreas_on_municipal_bills_tertiary ) + value; 
      elsif which in Debts_bank_overdraft_tertiary_range then
         a( Debts_bank_overdraft_tertiary ) := a( Debts_bank_overdraft_tertiary ) + value; 
      elsif which in Debts_bond_loan_from_the_bank_tertiary_range then
         a( Debts_bond_loan_from_the_bank_tertiary ) := a( Debts_bond_loan_from_the_bank_tertiary ) + value; 
      elsif which in Debts_furniture_and_appliances_amount_oustanding_tertiary_range then
         a( Debts_furniture_and_appliances_amount_oustanding_tertiary ) := a( Debts_furniture_and_appliances_amount_oustanding_tertiary ) + value; 
      elsif which in Debts_loans_from_friends_and_family_tertiary_range then
         a( Debts_loans_from_friends_and_family_tertiary ) := a( Debts_loans_from_friends_and_family_tertiary ) + value; 
      elsif which in Debts_loans_from_money_lenders_tertiary_range then
         a( Debts_loans_from_money_lenders_tertiary ) := a( Debts_loans_from_money_lenders_tertiary ) + value; 
      elsif which in Debts_motor_vehicle_loan_from_the_bank_tertiary_range then
         a( Debts_motor_vehicle_loan_from_the_bank_tertiary ) := a( Debts_motor_vehicle_loan_from_the_bank_tertiary ) + value; 
      elsif which in Debts_other_bank_loans_tertiary_range then
         a( Debts_other_bank_loans_tertiary ) := a( Debts_other_bank_loans_tertiary ) + value; 
      elsif which in Debts_other_loans_tertiary_range then
         a( Debts_other_loans_tertiary ) := a( Debts_other_loans_tertiary ) + value; 
      elsif which in Debts_retail_stores_tertiary_range then
         a( Debts_retail_stores_tertiary ) := a( Debts_retail_stores_tertiary ) + value; 
      elsif which in Dental_services_tertiary_range then
         a( Dental_services_tertiary ) := a( Dental_services_tertiary ) + value; 
      elsif which in Domestics_services_and_household_arcticles_tertiary_range then
         a( Domestics_services_and_household_arcticles_tertiary ) := a( Domestics_services_and_household_arcticles_tertiary ) + value; 
      elsif which in Education_not_definable_by_level_tertiary_range then
         a( Education_not_definable_by_level_tertiary ) := a( Education_not_definable_by_level_tertiary ) + value; 
      elsif which in Elecrtical_appliances_for_personal_care_tertiary_range then
         a( Elecrtical_appliances_for_personal_care_tertiary ) := a( Elecrtical_appliances_for_personal_care_tertiary ) + value; 
      elsif which in Electricity_tertiary_range then
         a( Electricity_tertiary ) := a( Electricity_tertiary ) + value; 
      elsif which in Equipment_for_sport_camping_and_open_air_recreation_tertiary_range then
         a( Equipment_for_sport_camping_and_open_air_recreation_tertiary ) := a( Equipment_for_sport_camping_and_open_air_recreation_tertiary ) + value; 
      elsif which in Equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures_tertiary_range then
         a( Equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures_tertiary ) := a( Equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures_tertiary ) + value; 
      elsif which in Financial_services_nec_tertiary_range then
         a( Financial_services_nec_tertiary ) := a( Financial_services_nec_tertiary ) + value; 
      elsif which in Fish_tertiary_range then
         a( Fish_tertiary ) := a( Fish_tertiary ) + value; 
      elsif which in Food_products_nec_tertiary_range then
         a( Food_products_nec_tertiary ) := a( Food_products_nec_tertiary ) + value; 
      elsif which in Fruits_tertiary_range then
         a( Fruits_tertiary ) := a( Fruits_tertiary ) + value; 
      elsif which in Fuels_and_lubricants_tertiary_range then
         a( Fuels_and_lubricants_tertiary ) := a( Fuels_and_lubricants_tertiary ) + value; 
      elsif which in Furniture_and_furnishings_tertiary_range then
         a( Furniture_and_furnishings_tertiary ) := a( Furniture_and_furnishings_tertiary ) + value; 
      elsif which in Games_of_chances_tertiary_range then
         a( Games_of_chances_tertiary ) := a( Games_of_chances_tertiary ) + value; 
      elsif which in Games_toys_and_hobbies_tertiary_range then
         a( Games_toys_and_hobbies_tertiary ) := a( Games_toys_and_hobbies_tertiary ) + value; 
      elsif which in Gardens_plants_and_flowers_tertiary_range then
         a( Gardens_plants_and_flowers_tertiary ) := a( Gardens_plants_and_flowers_tertiary ) + value; 
      elsif which in Garments_tertiary_range then
         a( Garments_tertiary ) := a( Garments_tertiary ) + value; 
      elsif which in Gas_tertiary_range then
         a( Gas_tertiary ) := a( Gas_tertiary ) + value; 
      elsif which in Glassware_tableware_and_household_utensils_tertiary_range then
         a( Glassware_tableware_and_household_utensils_tertiary ) := a( Glassware_tableware_and_household_utensils_tertiary ) + value; 
      elsif which in Hairdressing_salons_and_personal_grooming_astablishment_tertiary_range then
         a( Hairdressing_salons_and_personal_grooming_astablishment_tertiary ) := a( Hairdressing_salons_and_personal_grooming_astablishment_tertiary ) + value; 
      elsif which in Hospital_services_tertiary_range then
         a( Hospital_services_tertiary ) := a( Hospital_services_tertiary ) + value; 
      elsif which in Household_textile_tertiary_range then
         a( Household_textile_tertiary ) := a( Household_textile_tertiary ) + value; 
      elsif which in Imputed_cost_for_home_production_tertiary_range then
         a( Imputed_cost_for_home_production_tertiary ) := a( Imputed_cost_for_home_production_tertiary ) + value; 
      elsif which in Imputed_rentals_of_owner_occupiers_tertiary_range then
         a( Imputed_rentals_of_owner_occupiers_tertiary ) := a( Imputed_rentals_of_owner_occupiers_tertiary ) + value; 
      elsif which in In_kind_consumption_tertiary_range then
         a( In_kind_consumption_tertiary ) := a( In_kind_consumption_tertiary ) + value; 
      elsif which in In_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private_tertiary_range then
         a( In_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private_tertiary ) := a( In_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private_tertiary ) + value; 
      elsif which in In_kind_income_from_estimated_value_of_private_use_of_company_vehicle_tertiary_range then
         a( In_kind_income_from_estimated_value_of_private_use_of_company_vehicle_tertiary ) := a( In_kind_income_from_estimated_value_of_private_use_of_company_vehicle_tertiary ) + value; 
      elsif which in In_kind_income_from_free_electricity_tertiary_range then
         a( In_kind_income_from_free_electricity_tertiary ) := a( In_kind_income_from_free_electricity_tertiary ) + value; 
      elsif which in In_kind_income_from_free_sanitation_tertiary_range then
         a( In_kind_income_from_free_sanitation_tertiary ) := a( In_kind_income_from_free_sanitation_tertiary ) + value; 
      elsif which in In_kind_income_from_free_water_tertiary_range then
         a( In_kind_income_from_free_water_tertiary ) := a( In_kind_income_from_free_water_tertiary ) + value; 
      elsif which in In_kind_income_from_library_fees_fines_grant_tertiary_range then
         a( In_kind_income_from_library_fees_fines_grant_tertiary ) := a( In_kind_income_from_library_fees_fines_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_library_services_grant_tertiary_range then
         a( In_kind_income_from_library_services_grant_tertiary ) := a( In_kind_income_from_library_services_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_other_specify_private_grant_tertiary_range then
         a( In_kind_income_from_other_specify_private_grant_tertiary ) := a( In_kind_income_from_other_specify_private_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_other_specify_public_grant_tertiary_range then
         a( In_kind_income_from_other_specify_public_grant_tertiary ) := a( In_kind_income_from_other_specify_public_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_pre_primary_primary_tertiary_education_and_vocational_training_grants_public_and_private_tertiary_range then
         a( In_kind_income_from_pre_primary_primary_tertiary_education_and_vocational_training_grants_public_and_private_tertiary ) := a( In_kind_income_from_pre_primary_primary_tertiary_education_and_vocational_training_grants_public_and_private_tertiary ) + value; 
      elsif which in In_kind_income_from_schools_and_other_edu_inst_privat_grant_tertiary_range then
         a( In_kind_income_from_schools_and_other_edu_inst_privat_grant_tertiary ) := a( In_kind_income_from_schools_and_other_edu_inst_privat_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_schools_and_other_edu_inst_publice_grant_tertiary_range then
         a( In_kind_income_from_schools_and_other_edu_inst_publice_grant_tertiary ) := a( In_kind_income_from_schools_and_other_edu_inst_publice_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_schools_boarding_fees_in_private_institutions_grant_tertiary_range then
         a( In_kind_income_from_schools_boarding_fees_in_private_institutions_grant_tertiary ) := a( In_kind_income_from_schools_boarding_fees_in_private_institutions_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public_tertiary_range then
         a( In_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public_tertiary ) := a( In_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public_tertiary ) + value; 
      elsif which in In_kind_income_from_stationery_private_grant_tertiary_range then
         a( In_kind_income_from_stationery_private_grant_tertiary ) := a( In_kind_income_from_stationery_private_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_stationery_public_grant_tertiary_range then
         a( In_kind_income_from_stationery_public_grant_tertiary ) := a( In_kind_income_from_stationery_public_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_tertiary_range then
         a( In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_tertiary ) := a( In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_tertiary_range then
         a( In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_tertiary ) := a( In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_textbooks_for_private_institutions_grant_tertiary_range then
         a( In_kind_income_from_textbooks_for_private_institutions_grant_tertiary ) := a( In_kind_income_from_textbooks_for_private_institutions_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_textbooks_for_public_institutions_grant_tertiary_range then
         a( In_kind_income_from_textbooks_for_public_institutions_grant_tertiary ) := a( In_kind_income_from_textbooks_for_public_institutions_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant_tertiary_range then
         a( In_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant_tertiary ) := a( In_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_universities_boarding_fees_in_private_institution_grant_tertiary_range then
         a( In_kind_income_from_universities_boarding_fees_in_private_institution_grant_tertiary ) := a( In_kind_income_from_universities_boarding_fees_in_private_institution_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_universities_boarding_fees_in_public_institution_grant_tertiary_range then
         a( In_kind_income_from_universities_boarding_fees_in_public_institution_grant_tertiary ) := a( In_kind_income_from_universities_boarding_fees_in_public_institution_grant_tertiary ) + value; 
      elsif which in In_kind_income_from_value_of_discounted_fares_for_educational_purposes_tertiary_range then
         a( In_kind_income_from_value_of_discounted_fares_for_educational_purposes_tertiary ) := a( In_kind_income_from_value_of_discounted_fares_for_educational_purposes_tertiary ) + value; 
      elsif which in In_kind_income_from_value_of_discounted_fares_for_non_educational_purposes_tertiary_range then
         a( In_kind_income_from_value_of_discounted_fares_for_non_educational_purposes_tertiary ) := a( In_kind_income_from_value_of_discounted_fares_for_non_educational_purposes_tertiary ) + value; 
      elsif which in Income_from_alimony_palimony_and_other_allowances_tertiary_range then
         a( Income_from_alimony_palimony_and_other_allowances_tertiary ) := a( Income_from_alimony_palimony_and_other_allowances_tertiary ) + value; 
      elsif which in Income_from_annuities_from_own_investment_tertiary_range then
         a( Income_from_annuities_from_own_investment_tertiary ) := a( Income_from_annuities_from_own_investment_tertiary ) + value; 
      elsif which in Income_from_dividends_tertiary_range then
         a( Income_from_dividends_tertiary ) := a( Income_from_dividends_tertiary ) + value; 
      elsif which in Income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_tertiary_range then
         a( Income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_tertiary ) := a( Income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_tertiary ) + value; 
      elsif which in Income_from_other_dividends_tertiary_range then
         a( Income_from_other_dividends_tertiary ) := a( Income_from_other_dividends_tertiary ) + value; 
      elsif which in Income_from_pension_from_previous_employment_tertiary_range then
         a( Income_from_pension_from_previous_employment_tertiary ) := a( Income_from_pension_from_previous_employment_tertiary ) + value; 
      elsif which in Income_from_property_tertiary_range then
         a( Income_from_property_tertiary ) := a( Income_from_property_tertiary ) + value; 
      elsif which in Income_from_royalties_tertiary_range then
         a( Income_from_royalties_tertiary ) := a( Income_from_royalties_tertiary ) + value; 
      elsif which in Income_from_salaries_and_wages_tertiary_range then
         a( Income_from_salaries_and_wages_tertiary ) := a( Income_from_salaries_and_wages_tertiary ) + value; 
      elsif which in Income_from_self_employment_and_business_tertiary_range then
         a( Income_from_self_employment_and_business_tertiary ) := a( Income_from_self_employment_and_business_tertiary ) + value; 
      elsif which in Income_from_social_pensions_tertiary_range then
         a( Income_from_social_pensions_tertiary ) := a( Income_from_social_pensions_tertiary ) + value; 
      elsif which in Income_interest_received_tertiary_range then
         a( Income_interest_received_tertiary ) := a( Income_interest_received_tertiary ) + value; 
      elsif which in Information_processing_equipment_tertiary_range then
         a( Information_processing_equipment_tertiary ) := a( Information_processing_equipment_tertiary ) + value; 
      elsif which in Insurance_connected_with_the_dwelling_tertiary_range then
         a( Insurance_connected_with_the_dwelling_tertiary ) := a( Insurance_connected_with_the_dwelling_tertiary ) + value; 
      elsif which in Insurance_connected_with_the_health_tertiary_range then
         a( Insurance_connected_with_the_health_tertiary ) := a( Insurance_connected_with_the_health_tertiary ) + value; 
      elsif which in Insurance_connected_with_the_transport_tertiary_range then
         a( Insurance_connected_with_the_transport_tertiary ) := a( Insurance_connected_with_the_transport_tertiary ) + value; 
      elsif which in Interest_on_mortgage_bonds_tertiary_range then
         a( Interest_on_mortgage_bonds_tertiary ) := a( Interest_on_mortgage_bonds_tertiary ) + value; 
      elsif which in Jewellery_clocks_and_watches_tertiary_range then
         a( Jewellery_clocks_and_watches_tertiary ) := a( Jewellery_clocks_and_watches_tertiary ) + value; 
      elsif which in Liquid_fuels_tertiary_range then
         a( Liquid_fuels_tertiary ) := a( Liquid_fuels_tertiary ) + value; 
      elsif which in Loss_expenditure_incurred_in_obtaining_income_tertiary_range then
         a( Loss_expenditure_incurred_in_obtaining_income_tertiary ) := a( Loss_expenditure_incurred_in_obtaining_income_tertiary ) + value; 
      elsif which in Maintenance_and_repair_of_other_major_durables_for_recreation_and_culture_tertiary_range then
         a( Maintenance_and_repair_of_other_major_durables_for_recreation_and_culture_tertiary ) := a( Maintenance_and_repair_of_other_major_durables_for_recreation_and_culture_tertiary ) + value; 
      elsif which in Maintenance_and_repairs_of_personal_transport_equipment_tertiary_range then
         a( Maintenance_and_repairs_of_personal_transport_equipment_tertiary ) := a( Maintenance_and_repairs_of_personal_transport_equipment_tertiary ) + value; 
      elsif which in Major_durables_for_outdoor_recreation_tertiary_range then
         a( Major_durables_for_outdoor_recreation_tertiary ) := a( Major_durables_for_outdoor_recreation_tertiary ) + value; 
      elsif which in Major_household_appliances_wheter_or_no_aelectriccal_tertiary_range then
         a( Major_household_appliances_wheter_or_no_aelectriccal_tertiary ) := a( Major_household_appliances_wheter_or_no_aelectriccal_tertiary ) + value; 
      elsif which in Major_tools_and_equipment_tertiary_range then
         a( Major_tools_and_equipment_tertiary ) := a( Major_tools_and_equipment_tertiary ) + value; 
      elsif which in Materials_for_maintenance_and_repair_of_the_dwelling_tertiary_range then
         a( Materials_for_maintenance_and_repair_of_the_dwelling_tertiary ) := a( Materials_for_maintenance_and_repair_of_the_dwelling_tertiary ) + value; 
      elsif which in Meals_in_restaurants_cafes_canteens_and_the_likes_tertiary_range then
         a( Meals_in_restaurants_cafes_canteens_and_the_likes_tertiary ) := a( Meals_in_restaurants_cafes_canteens_and_the_likes_tertiary ) + value; 
      elsif which in Meat_tertiary_range then
         a( Meat_tertiary ) := a( Meat_tertiary ) + value; 
      elsif which in Medical_services_tertiary_range then
         a( Medical_services_tertiary ) := a( Medical_services_tertiary ) + value; 
      elsif which in Milk_cheese_and_eggs_tertiary_range then
         a( Milk_cheese_and_eggs_tertiary ) := a( Milk_cheese_and_eggs_tertiary ) + value; 
      elsif which in Mineral_waters_soft_drinks_fruit_and_vegetable_juices_tertiary_range then
         a( Mineral_waters_soft_drinks_fruit_and_vegetable_juices_tertiary ) := a( Mineral_waters_soft_drinks_fruit_and_vegetable_juices_tertiary ) + value; 
      elsif which in Miscellaneous_printed_matter_tertiary_range then
         a( Miscellaneous_printed_matter_tertiary ) := a( Miscellaneous_printed_matter_tertiary ) + value; 
      elsif which in Motor_cars_tertiary_range then
         a( Motor_cars_tertiary ) := a( Motor_cars_tertiary ) + value; 
      elsif which in Motor_cycles_tertiary_range then
         a( Motor_cycles_tertiary ) := a( Motor_cycles_tertiary ) + value; 
      elsif which in Musical_instrument_and_major_durables_for_outdoor_recreation_tertiary_range then
         a( Musical_instrument_and_major_durables_for_outdoor_recreation_tertiary ) := a( Musical_instrument_and_major_durables_for_outdoor_recreation_tertiary ) + value; 
      elsif which in Newspaper_and_periodicals_tertiary_range then
         a( Newspaper_and_periodicals_tertiary ) := a( Newspaper_and_periodicals_tertiary ) + value; 
      elsif which in Non_durable_household_goods_tertiary_range then
         a( Non_durable_household_goods_tertiary ) := a( Non_durable_household_goods_tertiary ) + value; 
      elsif which in Oils_and_fats_tertiary_range then
         a( Oils_and_fats_tertiary ) := a( Oils_and_fats_tertiary ) + value; 
      elsif which in Other_appliances_articles_and_products_for_personal_care_tertiary_range then
         a( Other_appliances_articles_and_products_for_personal_care_tertiary ) := a( Other_appliances_articles_and_products_for_personal_care_tertiary ) + value; 
      elsif which in Other_articles_of_clothing_and_clothing_accessories_tertiary_range then
         a( Other_articles_of_clothing_and_clothing_accessories_tertiary ) := a( Other_articles_of_clothing_and_clothing_accessories_tertiary ) + value; 
      elsif which in Other_income_from_individuals_tertiary_range then
         a( Other_income_from_individuals_tertiary ) := a( Other_income_from_individuals_tertiary ) + value; 
      elsif which in Other_income_tertiary_range then
         a( Other_income_tertiary ) := a( Other_income_tertiary ) + value; 
      elsif which in Other_insurance_tertiary_range then
         a( Other_insurance_tertiary ) := a( Other_insurance_tertiary ) + value; 
      elsif which in Other_medical_products_tertiary_range then
         a( Other_medical_products_tertiary ) := a( Other_medical_products_tertiary ) + value; 
      elsif which in Other_personal_effects_tertiary_range then
         a( Other_personal_effects_tertiary ) := a( Other_personal_effects_tertiary ) + value; 
      elsif which in Other_products_not_consumption_tertiary_range then
         a( Other_products_not_consumption_tertiary ) := a( Other_products_not_consumption_tertiary ) + value; 
      elsif which in Other_puchased_transport_services_tertiary_range then
         a( Other_puchased_transport_services_tertiary ) := a( Other_puchased_transport_services_tertiary ) + value; 
      elsif which in Other_services_in_respect_of_personal_transport_equipment_tertiary_range then
         a( Other_services_in_respect_of_personal_transport_equipment_tertiary ) := a( Other_services_in_respect_of_personal_transport_equipment_tertiary ) + value; 
      elsif which in Other_services_relating_to_the_dwelling_tertiary_range then
         a( Other_services_relating_to_the_dwelling_tertiary ) := a( Other_services_relating_to_the_dwelling_tertiary ) + value; 
      elsif which in Other_services_tertiary_range then
         a( Other_services_tertiary ) := a( Other_services_tertiary ) + value; 
      elsif which in Package_holidays_tertiary_range then
         a( Package_holidays_tertiary ) := a( Package_holidays_tertiary ) + value; 
      elsif which in Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_tertiary_range then
         a( Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_tertiary ) := a( Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_tertiary ) + value; 
      elsif which in Paramedic_services_tertiary_range then
         a( Paramedic_services_tertiary ) := a( Paramedic_services_tertiary ) + value; 
      elsif which in Passenger_transport_by_air_tertiary_range then
         a( Passenger_transport_by_air_tertiary ) := a( Passenger_transport_by_air_tertiary ) + value; 
      elsif which in Passenger_transport_by_railway_tertiary_range then
         a( Passenger_transport_by_railway_tertiary ) := a( Passenger_transport_by_railway_tertiary ) + value; 
      elsif which in Passenger_transport_by_road_tertiary_range then
         a( Passenger_transport_by_road_tertiary ) := a( Passenger_transport_by_road_tertiary ) + value; 
      elsif which in Passenger_transport_by_sea_and_inland_waterway_tertiary_range then
         a( Passenger_transport_by_sea_and_inland_waterway_tertiary ) := a( Passenger_transport_by_sea_and_inland_waterway_tertiary ) + value; 
      elsif which in Pets_and_related_products_tertiary_range then
         a( Pets_and_related_products_tertiary ) := a( Pets_and_related_products_tertiary ) + value; 
      elsif which in Pharmaceutical_products_tertiary_range then
         a( Pharmaceutical_products_tertiary ) := a( Pharmaceutical_products_tertiary ) + value; 
      elsif which in Photographic_and_cinematographic_equipment_and_optical_instruments_tertiary_range then
         a( Photographic_and_cinematographic_equipment_and_optical_instruments_tertiary ) := a( Photographic_and_cinematographic_equipment_and_optical_instruments_tertiary ) + value; 
      elsif which in Postal_services_tertiary_range then
         a( Postal_services_tertiary ) := a( Postal_services_tertiary ) + value; 
      elsif which in Pre_primary_and_primary_education_tertiary_range then
         a( Pre_primary_and_primary_education_tertiary ) := a( Pre_primary_and_primary_education_tertiary ) + value; 
      elsif which in Recording_meedia_tertiary_range then
         a( Recording_meedia_tertiary ) := a( Recording_meedia_tertiary ) + value; 
      elsif which in Recreational_and_sporting_services_tertiary_range then
         a( Recreational_and_sporting_services_tertiary ) := a( Recreational_and_sporting_services_tertiary ) + value; 
      elsif which in Refuse_collection_tertiary_range then
         a( Refuse_collection_tertiary ) := a( Refuse_collection_tertiary ) + value; 
      elsif which in Repair_and_hire_of_foowear_tertiary_range then
         a( Repair_and_hire_of_foowear_tertiary ) := a( Repair_and_hire_of_foowear_tertiary ) + value; 
      elsif which in Repair_of_furniture_furnishings_and_floor_covering_tertiary_range then
         a( Repair_of_furniture_furnishings_and_floor_covering_tertiary ) := a( Repair_of_furniture_furnishings_and_floor_covering_tertiary ) + value; 
      elsif which in Repair_of_household_appliance_tertiary_range then
         a( Repair_of_household_appliance_tertiary ) := a( Repair_of_household_appliance_tertiary ) + value; 
      elsif which in Savings_from_building_materials_not_included_in_q813_tertiary_range then
         a( Savings_from_building_materials_not_included_in_q813_tertiary ) := a( Savings_from_building_materials_not_included_in_q813_tertiary ) + value; 
      elsif which in Savings_from_capital_payments_tertiary_range then
         a( Savings_from_capital_payments_tertiary ) := a( Savings_from_capital_payments_tertiary ) + value; 
      elsif which in Savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary_range then
         a( Savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary ) := a( Savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary ) + value; 
      elsif which in Savings_from_contributions_to_a_stokvel_tertiary_range then
         a( Savings_from_contributions_to_a_stokvel_tertiary ) := a( Savings_from_contributions_to_a_stokvel_tertiary ) + value; 
      elsif which in Savings_from_cost_of_other_dewlling_tertiary_range then
         a( Savings_from_cost_of_other_dewlling_tertiary ) := a( Savings_from_cost_of_other_dewlling_tertiary ) + value; 
      elsif which in Savings_from_deposits_into_savings_tertiary_range then
         a( Savings_from_deposits_into_savings_tertiary ) := a( Savings_from_deposits_into_savings_tertiary ) + value; 
      elsif which in Savings_from_improvements_additions_and_alterations_tertiary_range then
         a( Savings_from_improvements_additions_and_alterations_tertiary ) := a( Savings_from_improvements_additions_and_alterations_tertiary ) + value; 
      elsif which in Savings_from_investment_plans_tertiary_range then
         a( Savings_from_investment_plans_tertiary ) := a( Savings_from_investment_plans_tertiary ) + value; 
      elsif which in Savings_from_labour_and_material_for_improvements_additions_and_alterations_tertiary_range then
         a( Savings_from_labour_and_material_for_improvements_additions_and_alterations_tertiary ) := a( Savings_from_labour_and_material_for_improvements_additions_and_alterations_tertiary ) + value; 
      elsif which in Savings_from_life_and_endownment_policies_tertiary_range then
         a( Savings_from_life_and_endownment_policies_tertiary ) := a( Savings_from_life_and_endownment_policies_tertiary ) + value; 
      elsif which in Savings_from_life_insurance_covering_mortgage_debt_tertiary_range then
         a( Savings_from_life_insurance_covering_mortgage_debt_tertiary ) := a( Savings_from_life_insurance_covering_mortgage_debt_tertiary ) + value; 
      elsif which in Savings_from_listed_company_shares_tertiary_range then
         a( Savings_from_listed_company_shares_tertiary ) := a( Savings_from_listed_company_shares_tertiary ) + value; 
      elsif which in Savings_from_monthly_capital_payments_tertiary_range then
         a( Savings_from_monthly_capital_payments_tertiary ) := a( Savings_from_monthly_capital_payments_tertiary ) + value; 
      elsif which in Savings_from_offshore_tertiary_range then
         a( Savings_from_offshore_tertiary ) := a( Savings_from_offshore_tertiary ) + value; 
      elsif which in Savings_from_other_investments_tertiary_range then
         a( Savings_from_other_investments_tertiary ) := a( Savings_from_other_investments_tertiary ) + value; 
      elsif which in Savings_from_other_payments_tertiary_range then
         a( Savings_from_other_payments_tertiary ) := a( Savings_from_other_payments_tertiary ) + value; 
      elsif which in Savings_from_purchase_and_levy_of_timeshare_tertiary_range then
         a( Savings_from_purchase_and_levy_of_timeshare_tertiary ) := a( Savings_from_purchase_and_levy_of_timeshare_tertiary ) + value; 
      elsif which in Savings_from_repayment_on_loans_and_overdrafts_tertiary_range then
         a( Savings_from_repayment_on_loans_and_overdrafts_tertiary ) := a( Savings_from_repayment_on_loans_and_overdrafts_tertiary ) + value; 
      elsif which in Savings_from_security_structures_tertiary_range then
         a( Savings_from_security_structures_tertiary ) := a( Savings_from_security_structures_tertiary ) + value; 
      elsif which in Savings_from_services_for_improvements_additions_and_alterations_tertiary_range then
         a( Savings_from_services_for_improvements_additions_and_alterations_tertiary ) := a( Savings_from_services_for_improvements_additions_and_alterations_tertiary ) + value; 
      elsif which in Savings_from_unit_trusts_tertiary_range then
         a( Savings_from_unit_trusts_tertiary ) := a( Savings_from_unit_trusts_tertiary ) + value; 
      elsif which in Savings_from_unlisted_company_shares_tertiary_range then
         a( Savings_from_unlisted_company_shares_tertiary ) := a( Savings_from_unlisted_company_shares_tertiary ) + value; 
      elsif which in Savings_from_wthdrawals_from_savings_tertiary_range then
         a( Savings_from_wthdrawals_from_savings_tertiary ) := a( Savings_from_wthdrawals_from_savings_tertiary ) + value; 
      elsif which in Scondary_education_tertiary_range then
         a( Scondary_education_tertiary ) := a( Scondary_education_tertiary ) + value; 
      elsif which in Service_of_the_maintenance_and_repair_of_the_dwelling_tertiary_range then
         a( Service_of_the_maintenance_and_repair_of_the_dwelling_tertiary ) := a( Service_of_the_maintenance_and_repair_of_the_dwelling_tertiary ) + value; 
      elsif which in Sewarage_collection_tertiary_range then
         a( Sewarage_collection_tertiary ) := a( Sewarage_collection_tertiary ) + value; 
      elsif which in Shoes_and_other_footwear_tertiary_range then
         a( Shoes_and_other_footwear_tertiary ) := a( Shoes_and_other_footwear_tertiary ) + value; 
      elsif which in Small_electrical_household_appliance_tertiary_range then
         a( Small_electrical_household_appliance_tertiary ) := a( Small_electrical_household_appliance_tertiary ) + value; 
      elsif which in Small_tools_and_miscellaneous_accessories_tertiary_range then
         a( Small_tools_and_miscellaneous_accessories_tertiary ) := a( Small_tools_and_miscellaneous_accessories_tertiary ) + value; 
      elsif which in Social_protection_services_tertiary_range then
         a( Social_protection_services_tertiary ) := a( Social_protection_services_tertiary ) + value; 
      elsif which in Solid_fuels_tertiary_range then
         a( Solid_fuels_tertiary ) := a( Solid_fuels_tertiary ) + value; 
      elsif which in Spare_parts_and_accessories_tertiary_range then
         a( Spare_parts_and_accessories_tertiary ) := a( Spare_parts_and_accessories_tertiary ) + value; 
      elsif which in Spirits_tertiary_range then
         a( Spirits_tertiary ) := a( Spirits_tertiary ) + value; 
      elsif which in Stationery_and_drawing_materials_tertiary_range then
         a( Stationery_and_drawing_materials_tertiary ) := a( Stationery_and_drawing_materials_tertiary ) + value; 
      elsif which in Subsidy_on_payment_of_mortgage_tertiary_range then
         a( Subsidy_on_payment_of_mortgage_tertiary ) := a( Subsidy_on_payment_of_mortgage_tertiary ) + value; 
      elsif which in Sugar_jam_honey_chocolate_and_confectionery_tertiary_range then
         a( Sugar_jam_honey_chocolate_and_confectionery_tertiary ) := a( Sugar_jam_honey_chocolate_and_confectionery_tertiary ) + value; 
      elsif which in Taxes_according_to_assessment_income_tax_tertiary_range then
         a( Taxes_according_to_assessment_income_tax_tertiary ) := a( Taxes_according_to_assessment_income_tax_tertiary ) + value; 
      elsif which in Taxes_amnesty_tax_tertiary_range then
         a( Taxes_amnesty_tax_tertiary ) := a( Taxes_amnesty_tax_tertiary ) + value; 
      elsif which in Taxes_paye_income_tax_tertiary_range then
         a( Taxes_paye_income_tax_tertiary ) := a( Taxes_paye_income_tax_tertiary ) + value; 
      elsif which in Taxes_site_income_tax_tertiary_range then
         a( Taxes_site_income_tax_tertiary ) := a( Taxes_site_income_tax_tertiary ) + value; 
      elsif which in Taxes_unemployment_insurance_fund_uif_tertiary_range then
         a( Taxes_unemployment_insurance_fund_uif_tertiary ) := a( Taxes_unemployment_insurance_fund_uif_tertiary ) + value; 
      elsif which in Telephone_and_telefax_equipment_tertiary_range then
         a( Telephone_and_telefax_equipment_tertiary ) := a( Telephone_and_telefax_equipment_tertiary ) + value; 
      elsif which in Telephone_and_telefax_services_tertiary_range then
         a( Telephone_and_telefax_services_tertiary ) := a( Telephone_and_telefax_services_tertiary ) + value; 
      elsif which in Tertiary_education_tertiary_range then
         a( Tertiary_education_tertiary ) := a( Tertiary_education_tertiary ) + value; 
      elsif which in Therapeutic_appliances_and_equipment_tertiary_range then
         a( Therapeutic_appliances_and_equipment_tertiary ) := a( Therapeutic_appliances_and_equipment_tertiary ) + value; 
      elsif which in Tobacco_tertiary_range then
         a( Tobacco_tertiary ) := a( Tobacco_tertiary ) + value; 
      elsif which in Transfer_toothers_tertiary_range then
         a( Transfer_toothers_tertiary ) := a( Transfer_toothers_tertiary ) + value; 
      elsif which in Unclassified_food_items_tertiary_range then
         a( Unclassified_food_items_tertiary ) := a( Unclassified_food_items_tertiary ) + value; 
      elsif which in Vegetables_tertiary_range then
         a( Vegetables_tertiary ) := a( Vegetables_tertiary ) + value; 
      elsif which in Veterinary_and_other_services_tertiary_range then
         a( Veterinary_and_other_services_tertiary ) := a( Veterinary_and_other_services_tertiary ) + value; 
      elsif which in Water_and_electricity_tertiary_range then
         a( Water_and_electricity_tertiary ) := a( Water_and_electricity_tertiary ) + value; 
      elsif which in Water_supply_tertiary_range then
         a( Water_supply_tertiary ) := a( Water_supply_tertiary ) + value; 
      elsif which in Wine_tertiary_range then
         a( Wine_tertiary ) := a( Wine_tertiary ) + value;    
      end if;
   end Aggregate_To;

   procedure Aggregate_To( a : in out Main_Group_Array; which : in Coicop_Type; value : in Amount ) is
   begin
      if which in Alcoholic_beverages_tobacco_and_narcotics_main_range then 
         a( Alcoholic_beverages_tobacco_and_narcotics_main ) := a( Alcoholic_beverages_tobacco_and_narcotics_main ) + value; 
      elsif which in Clothing_and_footwear_main_range then 
         a( Clothing_and_footwear_main ) := a( Clothing_and_footwear_main ) + value; 
      elsif which in Communication_main_range then 
         a( Communication_main ) := a( Communication_main ) + value; 
      elsif which in Debts_main_range then 
         a( Debts_main ) := a( Debts_main ) + value; 
      elsif which in Education_main_range then 
         a( Education_main ) := a( Education_main ) + value; 
      elsif which in Food_and_non_alcoholic_beverages_main_range then 
         a( Food_and_non_alcoholic_beverages_main ) := a( Food_and_non_alcoholic_beverages_main ) + value; 
      elsif which in Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_range then 
         a( Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main ) := a( Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main ) + value; 
      elsif which in Health_main_range then 
         a( Health_main ) := a( Health_main ) + value; 
      elsif which in Housing_water_electricity_gas_and_other_fuels_main_range then 
         a( Housing_water_electricity_gas_and_other_fuels_main ) := a( Housing_water_electricity_gas_and_other_fuels_main ) + value; 
      elsif which in In_kind_consumption_main_range then 
         a( In_kind_consumption_main ) := a( In_kind_consumption_main ) + value; 
      elsif which in Income_in_kind_main_range then 
         a( Income_in_kind_main ) := a( Income_in_kind_main ) + value; 
      elsif which in Income_main_range then 
         a( Income_main ) := a( Income_main ) + value; 
      elsif which in Loss_main_range then 
         a( Loss_main ) := a( Loss_main ) + value; 
      elsif which in Miscellaneous_goods_and_services_main_range then 
         a( Miscellaneous_goods_and_services_main ) := a( Miscellaneous_goods_and_services_main ) + value; 
      elsif which in Not_cpi_consumption_main_range then 
         a( Not_cpi_consumption_main ) := a( Not_cpi_consumption_main ) + value; 
      elsif which in Other_unclasified_expenses_main_range then 
         a( Other_unclasified_expenses_main ) := a( Other_unclasified_expenses_main ) + value; 
      elsif which in Recreation_and_culture_main_range then 
         a( Recreation_and_culture_main ) := a( Recreation_and_culture_main ) + value; 
      elsif which in Restaurants_and_hotels_main_range then 
         a( Restaurants_and_hotels_main ) := a( Restaurants_and_hotels_main ) + value; 
      elsif which in Savings_main_range then 
         a( Savings_main ) := a( Savings_main ) + value; 
      elsif which in Taxes_main_range then 
         a( Taxes_main ) := a( Taxes_main ) + value; 
      elsif which in Transfers_to_others_main_range then 
         a( Transfers_to_others_main ) := a( Transfers_to_others_main ) + value; 
      elsif which in Transport_main_range then 
         a( Transport_main ) := a( Transport_main ) + value; 
      end if;
   end Aggregate_To;

   function Pretty_Print( i : Coicop_Type ) return String is
    begin
         case i is
             when old_age_pensions => return "Old age pensions";
             when vocational_training_in_public_institutions_grant => return "Vocational training in public institutions  : Grant";
             when food_hampers => return "Food hampers";
             when value_of_repairs_on_glassware_tableware_and_household_utensils => return "Value of repairs on glassware, tableware and household utensils";
             when power_driven_garden_tools => return "Power driven garden tools";
             when cheddar_cheese => return "Cheddar cheese";
             when laptops_and_palm_tops => return "Laptops and palm tops";
             when other_expenditure => return "Other expenditure";
             when lobola_or_dowry_paid => return "Lobola/dowry paid";
             when other_jam_including_strawberry => return "Other jam, (including strawberry)";
             when tomatoes_fresh => return "Tomatoes fresh";
             when building_materials_not_included_in_q813_a_or_c_eg_for_building_purposes => return "Building materials not included in Q813 (a) or (c) (eg for building purposes)";
             when fish_cakes => return "Fish cakes";
             when vocational_training_in_public_institutions_grant_income => return "Vocational training in public institutions  : Grant Income";
             when fire_lighters => return "Fire lighters";
             when baby_food_predominantly_meat => return "Baby food Predominantly meat";
             when other_garden_equipment => return "Other garden equipment";
             when schools_boarding_fees_in_private_institutions_grant => return "Schools boarding fees in private institutions : Grant";
             when aerated_cold_drinks => return "Aerated cold drinks";
             when beef_sausage => return "Beef sausage";
             when clothing_accessories_such_as_scarves_ties_belts_gloves_etc => return "Clothing accessories such as scarves, ties, belts, gloves etc";
             when cattle => return "Cattle";
             when rented_vehicles_educational_trips => return "Rented vehicles educational trips";
             when make_up_preparations_not_shown_elsewhere_eg_lipstick_eye_shadow_etc => return "Make : up preparations, not shown elsewhere (eg lipstick, eye shadow etc)";
             when insurance_on_contents_of_dwellings => return "Insurance on contents of dwellings";
             when beef_and_veal_incl_heads_and_feet => return "Beef and veal (incl heads and feet)";
             when pre_primary_education_in_private_institutions_grant_income => return "Pre : primary education in private institutions : Grant - Income ";
             when powder_including_baby_powder_and_deodorants => return "Powder (including baby powder) and deodorants";
             when brown_sugar => return "Brown sugar";
             when toaster_waffle_pans_and_sandwich_toasters => return "Toaster, waffle pans and sandwich toasters";
             when boats_including_outboard_motors_aircrafts_go_carts => return "Boats (including outboard motors) aircrafts, go : carts";
             when strawberries => return "Strawberries";
             when tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions_grant => return "Tertiary education Education not definable by level (excluding driving and music lessons, sport etc) in private institutions : Grant";
             when train_for_attending_educational_institutions => return "Train for attending educational institutions";
             when arreas_on_municipal_bills => return "Arreas on municipal bills";
             when paraffin_stoves_and_heaters => return "Paraffin stoves and heaters";
             when insurance_on_buildings => return "Insurance on buildings";
             when other_including_bakkies_used_as_taxis_for_education_purposes => return "Other (including bakkies used as taxis) for education purposes";
             when pumpkin_butternut_fresh => return "Pumpkin (Butternut) fresh";
             when pre_primary_education_in_public_institutions_grant_income => return "Pre : primary education in public institutions : Grant - Income ";
             when other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions_income => return "Other, specify : Grant(eg junior laptops, training and adult education) for public institutions - Income ";
             when stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions => return "Stationery : Grant (for academic purposes, excluding calculators for private institutions";
             when crackers => return "Crackers";
             when glass_and_crystal_ware_tableware_including_household_or_toilet_articles_of_porcelain_ceramic_stoneware_china_etc => return "Glass and crystal ware, tableware (including household or toilet articles of porcelain, ceramic stoneware, china etc)";
             when boys_clothing => return "Boys’ clothing";
             when macaroni => return "Macaroni";
             when swimming_pool_equipment_and_repairs_of_equipment => return "Swimming pool equipment and repairs of equipment";
             when insurance_paid_for_holiday_purposes_life_luggage_medical => return "Insurance paid for holiday purposes (Life, luggage, medical)";
             when firearms_and_ammunition_for_security_services => return "Firearms and ammunition (for security services)";
             when other_transport_specify => return "Other transport, specify";
             when rent_dwelling => return "Rent dwelling";
             when marmalade => return "Marmalade";
             when dental_service_service_of_dentists_include_oral_hygienists_in_private_institutions => return "Dental service (service of dentists include oral : hygienists) in private institutions";
             when free_sanitation_income => return "Free Sanitation: Income";
             when firearms_and_ammunition => return "Firearms and ammunition";
             when powder_soup => return "Powder soup";
             when other_tea_specify => return "Other tea, specify";
             when pipe_and_cigarette_tobacco => return "Pipe and cigarette tobacco";
             when computer_certification_public_schools_grant_income => return "Computer certification public schools : Grant Income";
             when stokvel => return "Stokvel";
             when vinegar => return "Vinegar";
             when other_biscuits => return "Other biscuits";
             when other_prepared_meals_11121150 => return "Other prepared meals : 11121150";
             when dung_bought => return "Dung Bought";
             when investment_plans => return "Investment plans";
             when corn_kernels_canned => return "Corn kernels canned";
             when pre_cooked_frozen_meat => return "Pre : cooked frozen meat";
             when dining_room_furniture => return "Dining room furniture";
             when instant_yeast => return "Instant yeast";
             when avocados => return "Avocados";
             when food_mixers_processors_and_similar_accessories => return "Food mixers, processors and similar accessories";
             when mealie_meal_or_maize_flour => return "Mealie meal/Maize flour";
             when saddles => return "Saddles";
             when therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_public_institutions => return "Therapeutic appliances and equipment (like spectacles and hearing aids) in public institutions";
             when other_canned_vegetables => return "Other canned vegetables";
             when other_cheese_specify => return "Other cheese, specify";
             when lemons => return "Lemons";
             when sewing_machines_over_lockers_and_knitting_machines => return "Sewing machines, over : lockers and knitting machines";
             when labour_cost_for_making_or_knitting_ofclothing_and_repairs_or_alterations_to_clothing => return "Labour cost for making or knitting ofclothing and repairs/alterations to clothing";
             when assorted_dried_fruit => return "Assorted dried fruit";
             when royalties => return "Royalties";
             when girls_clothing => return "Girls’ clothing";
             when courier_services => return "Courier services";
             when maize => return "Maize";
             when canned_fruit_cocktail => return "Canned fruit cocktail";
             when books_excluding_those_in_1614 => return "Books (excluding those in 1614)";
             when other_eg_mampoer_home_brewed_not_from_food_service_place => return "Other (eg mampoer, home brewed) not from food service place";
             when mango => return "Mango";
             when modems => return "Modems";
             when methylated_spirits_fuel_for_lawnmowers_and_generators_and_for_heating_excluding_fuel_for_your_motor_vehicles => return "Methylated spirits, fuel for lawnmowers and generators and for heating (excluding fuel for your motor vehicles)";
             when paraffin => return "Paraffin";
             when baking_powder => return "Baking powder";
             when sprays => return "Sprays";
             when other_repair_work_paid_for_by_your_insurance_company_or_other_party => return "Other repair work Paid for by your insurance company or other party";
             when light_bulbs => return "light bulbs";
             when lotto => return "Lotto";
             when extra_large_eggs => return "Extra large eggs";
             when cash_wage_incl_transport_received_by_cook => return "Cash wage incl transport received by cook";
             when vocational_training_in_private_institutions_grant => return "Vocational training in private institutions : Grant";
             when other_prepared_meals_11121160 => return "Other prepared meals : 11121160";
             when other_frozen_vegetables => return "Other frozen vegetables";
             when cameras_video_cameras_projectors_and_flashes => return "Cameras, video cameras, projectors and flashes";
             when other_hot_drinks => return "Other hot drinks";
             when toys_and_games_video_games_including_software_games => return "Toys and games, video games (including software games)";
             when pharmacy_service_fees_in_public_institutions => return "Pharmacy service fees in public institutions";
             when car_seats_for_babies => return "Car seats for babies";
             when new_caravans_and_trailers_including_motorised_caravans => return "New caravans and trailers including motorised caravans";
             when cash_wage_incl_transport_received_by_baby_sitter => return "Cash wage incl transport received by baby sitter";
             when melon_and_ginger_jam => return "Melon and ginger jam";
             when vocational_training_in_public_institutions => return "Vocational training in public institutions";
             when medical_aid_contribution_paid_by_household_member_in_public_institution => return "Medical aid contribution Paid by household member in public institution";
             when stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions_income => return "Stationery : Grant (for academic purposes, excluding calculators for public institutions - Income ";
             when value_of_discounted_fares_for_educational_purposes_income => return "Value of discounted fares for educational purposes: Income";
             when kettles_and_percolators_coffee_makers => return "Kettles and percolators, coffee makers";
             when other_grain_products_pies_except_meat_pies_and_fruit_pies => return "Other grain products (pies except meat pies and fruit pies)";
             when canned_guavas => return "Canned guavas";
             when other_sugar_specify => return "Other sugar , specify";
             when other_pasta => return "Other pasta";
             when boys_school_uniform => return "Boys’ school uniform";
             when fire_works => return "Fire works";
             when spare_parts_maintenance_and_cleaning_materials_accessories_purchased_for_private_repair_and_installation => return "Spare parts, maintenance, and cleaning materials, accessories purchased for private repair and installation";
             when pension_from_previous_employment => return "Pension from previous employment";
             when other_including_language_classes_in_private_institutions => return "Other (including language classes) in private institutions";
             when hairdryers => return "Hairdryers";
             when services_for_maintenance_and_repair_of_dwelling_plumbers_electricians_carpenters => return "Services for maintenance and repair of dwelling (plumbers, electricians, carpenters)";
             when unclassified_expenditures_on_food => return "Unclassified expenditures on Food";
             when tribal_levies_not_for_housing => return "Tribal levies (not for housing)";
             when other_including_bakkies_used_as_taxis_for_non_education_purposes => return "Other (including bakkies used as taxis) for non : education purposes";
             when other_recreational_services => return "Other recreational services";
             when imputed_rent_on_owned_dwelling => return "Imputed rent on owned dwelling";
             when unemployment_insurance_fund_uif => return "Unemployment insurance fund (UIF)";
             when textbooks_for_public_institutions_grant_income => return "Textbooks for public institutions : Grant - Income ";
             when cash => return "Cash";
             when chutney => return "Chutney";
             when garden_and_patio_furniture => return "Garden and patio furniture";
             when mens_and_boys => return "Men's and boys";
             when coconut => return "Coconut";
             when contribution_towards_communal_provision_of_sevices => return "Contribution towards Communal Provision of sevices";
             when disposable_nappies => return "Disposable nappies";
             when panel_beating_repairs_paid_for_by_you => return "Panel : beating repairs Paid for by you";
             when other_prepared_meals_11121170 => return "Other prepared meals : 11121170";
             when dried_sausages => return "Dried sausages";
             when used_animal_drawn_vehicles => return "Used animal drawn vehicles";
             when income_from_gambling => return "Income from gambling";
             when naartjies => return "Naartjies";
             when butter_beans => return "Butter beans";
             when fruit_juices_not_from_food_service_places => return "Fruit juices not from food service places";
             when large_eggs => return "Large eggs";
             when vat_on_utilities => return "VAT on utilities";
             when material_for_clothing => return "Material for clothing";
             when frozen_mixed_seafood => return "Frozen mixed seafood";
             when universities_boarding_fees_in_private_institution_grant_income => return "Universities boarding fees in private institution : Grant Income";
             when cutlery_flatware_and_silverware_kitchen_and_domestic_utensils_non_electrical_utensils_such_as_frying_pans_saucepans_etc => return "Cutlery flatware and silverware Kitchen and domestic utensils (non : electrical utensils, such as frying pans saucepans etc)";
             when other_stone_fruit => return "Other stone fruit";
             when bouquets_and_cut_flowers_for_household_use => return "Bouquets and cut flowers for household use";
             when glucose_sweets => return "Glucose sweets";
             when chillies_fresh => return "Chillies fresh";
             when subsidy_on_payment_of_mortgage => return "Subsidy on payment of mortgage";
             when mabella => return "Mabella";
             when services_for_improvements_additions_and_alterationscarpenters_electricians_etc => return "Services for improvements, additions and alterations(carpenters, electricians etc)";
             when grinding_or_gristing_of_maize_or_wheat => return "Grinding/gristing of maize/wheat";
             when other_specify_lemon_juice => return "Other, specify (Lemon juice)";
             when livestock => return "Livestock";
             when other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions => return "Other, specify : Grant(eg junior laptops, training and adult education) for public institutions";
             when gas_stoves_and_heaters => return "Gas stoves and heaters";
             when castor_sugar => return "Castor sugar";
             when girls_footwear => return "Girls’ footwear";
             when consultations_of_traditional_healers_in_public_institutions => return "Consultations of traditional healers in public institutions";
             when green_beans_canned => return "Green beans canned";
             when improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts => return "Improvements, additions and alterations (including build : in furniture, solar energy systems, swimming pools and garden layouts)";
             when dividends_of_listed_companies => return "Dividends of Listed Companies";
             when smooth_apricot_jam => return "Smooth apricot jam";
             when sports_footwear => return "Sports footwear";
             when excursions_field_trips_in_public_institutions_grant => return "Excursions (field trips) in public institutions : Grant";
             when secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution_grant => return "Secondary education (includes out : of : school secondary education for adults and young people) in private institution  : Grant";
             when other_eg_hot_brush_vibrator_etc => return "Other (eg hot brush, vibrator, etc)";
             when repairs_to_floor_coverings => return "Repairs to floor coverings";
             when wthdrawals_from_savings => return "Wthdrawals from savings";
             when schools_boarding_fees_in_private_institutions_grant_income => return "Schools boarding fees in private institutions : Grant Income";
             when flat_rate_in_respect_of_services_and_medicine_obtained_at_hospital_or_clinic_in_private_institutions => return "Flat rate in respect of services and medicine obtained at hospital/clinic in private institutions";
             when fruit_and_vegetable_juices_combined_not_from_food_service_places => return "Fruit and vegetable juices (combined) not from food service places";
             when universities_boarding_fees_in_public_institution => return "Universities boarding fees in public institution";
             when admission_charges_other => return "admission charges : other";
             when smoked_fish => return "Smoked fish";
             when diesel_for_household_use_not_transport => return "Diesel for household use (not transport)";
             when other_prepared_meals_11121180 => return "Other prepared meals : 11121180";
             when other_grains => return "Other grains";
             when milk => return "Milk";
             when toll_fees => return "Toll fees";
             when corn_kernels_frozen => return "Corn kernels frozen";
             when income_not_elsewhere_specified => return "Income not elsewhere specified";
             when renting_of_post_boxes => return "Renting of post boxes";
             when hospital_service_fees_eg_wards_beds_and_theatre_fees_in_private_institutions => return "Hospital service fees (eg wards, beds and theatre fees) in private institutions";
             when personal_desktop_computers_excluding_laptops => return "Personal desktop computers (excluding laptops)";
             when other_specify_tropical_fruit => return "Other (specify) tropical fruit";
             when sports_clothing => return "Sports clothing";
             when baby_food_predominantly_grain => return "Baby food Predominantly grain";
             when other_footwear => return "Other footwear";
             when paw_paw => return "Paw paw";
             when medicine_purchased_with_prescription_in_private_institutions => return "Medicine purchased with prescription in private institutions";
             when electricity => return "electricity";
             when amageu => return "Amageu";
             when air_conditioner_for_cars_including_installations => return "Air conditioner for cars including installations";
             when other_sugar_products => return "Other sugar products";
             when plastic => return "Plastic";
             when television_rental => return "Television rental";
             when new_bicycles => return "New bicycles";
             when repairs_and_maintenance_services_to_recreation_entertainment_and_sports_equipment => return "Repairs and maintenance services to recreation, entertainment and sports equipment";
             when horse_shoes => return "Horse shoes";
             when free_water => return "Free Water";
             when gem_squashes_fresh => return "Gem squashes fresh";
             when value_of_discounted_fares_for_educational_purposes => return "Value of discounted fares for educational purposes";
             when primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions => return "Primary education (includes literacy programmes for students too old for primary school) in private institutions";
             when metered_cab_while_on_holiday => return "Metered cab while on holiday";
             when other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions_income => return "Other, specify : Grant (eg junior laptops, training and adult education) for private institutions - Income ";
             when secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution => return "Secondary education (includes out : of : school secondary education for adults and young people) in public institution";
             when other_floor_coverings_excluding_bathroom_and_door_mats_specify => return "Other floor coverings (excluding bathroom and door mats) specify";
             when used_bicycles => return "Used bicycles";
             when sorghum_meal_or_powder => return "Sorghum meal/powder";
             when bus => return "Bus";
             when payments_received_from_boarders_and_other_non_members => return "Payments received from boarders and other non members";
             when womens_footwear => return "Women's footwear";
             when lounge_furniture => return "Lounge furniture";
             when non_refundable_bursaries => return "Non refundable bursaries";
             when other_vetkoek_fat_cakes => return "Other (Vetkoek, Fat cakes)";
             when calculators => return "Calculators";
             when re_treaded_or_patched_tyres_and_tubes => return "Re : treaded /patched tyres and tubes";
             when curry_powder => return "Curry powder";
             when other_income_from_individuals => return "Other Income from Individuals";
             when textbooks_for_public_institutions_grant => return "Textbooks for public institutions : Grant";
             when cooking_wines_from_food_service_places => return "Cooking wines from food service places";
             when prepared_custard_eg_ultramel => return "Prepared custard (eg Ultramel)";
             when viennas => return "Viennas";
             when other_sweets => return "Other sweets";
             when other_prepared_meals_11121190 => return "Other prepared meals : 11121190";
             when herbal_tea_from_food_service_place => return "Herbal tea from food service place";
             when interest_on_mortgage_bonds => return "Interest on mortgage bonds";
             when film_development_and_photo_prints => return "Film development and photo prints";
             when repayment_on_loans_and_overdrafts => return "Repayment on loans and overdrafts";
             when butter_milk => return "Butter milk";
             when mayonnaise => return "Mayonnaise";
             when four_wheel_drive_vehicles_2 => return "Four wheel drive vehicles 2";
             when tarts => return "Tarts";
             when cauliflower_fresh => return "Cauliflower fresh";
             when motor_vehicle_loan_from_the_bank => return "Motor vehicle loan from the bank";
             when universities_boarding_fees_in_public_institution_grant_income => return "Universities boarding fees in public institution : Grant Income";
             when salt => return "Salt";
             when installation => return "Installation";
             when other_medical_products_bandages_syringes_knee_supports_etc_in_public_institutions => return "Other medical products (bandages, syringes, knee supports etc) in public institutions";
             when garden_hand_tools_such_as_spades => return "Garden hand tools (such as spades)";
             when carrots_frozen => return "Carrots frozen";
             when other_items_smoked => return "Other items smoked";
             when other_including_bakkies_used_as_taxis => return "Other  (Including bakkies used as taxis)";
             when amusement_parks => return "Amusement parks";
             when textbooks_for_private_institutions_grant_income => return "Textbooks for private institutions : Grant - Income ";
             when apricots => return "Apricots";
             when seed_plants_shrubs_and_trees_fertilizer_plant_and_pest_spray_remedies => return "Seed, plants, shrubs, and trees, fertilizer, plant and pest spray remedies";
             when frozen_shrimps => return "Frozen shrimps";
             when canned_peaches => return "Canned peaches";
             when library_fees_and_fines_for_non_academic_purposes => return "Library fees and fines (for non - academic purposes)";
             when white_sugar => return "White sugar";
             when fertilizer => return "Fertilizer";
             when two_way_radios => return "Two : way radios";
             when bread_flour => return "Bread flour";
             when lentils_dried => return "Lentils dried";
             when dates => return "Dates";
             when supporting_services_eg_parking_services_port_operators => return "Supporting services (eg parking services, port operators)";
             when meat_spread_marmite => return "Meat spread (Marmite)";
             when employer_contribution_to_pension_provident_and_annuity_funds => return "Employer contribution to pension, provident and annuity funds";
             when refrigerators => return "Refrigerators";
             when other_sauces_and_condiments_specify => return "Other sauces and condiments, specify";
             when heaters_and_air_conditioners => return "Heaters and air conditioners";
             when self_raising_meal => return "Self raising meal";
             when religious_and_traditional_ceremonies_unveiling_barmitzwah_diwali_weddings => return "Religious and traditional ceremonies (unveiling, barmitzwah, diwali weddings)";
             when fish_fingers => return "Fish fingers";
             when secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution_grant => return "Secondary education (includes out : of : school secondary education for adults and young people) in public institution : Grant";
             when medium_eggs => return "Medium eggs";
             when retail_stores_clothers_on_account_or_lay_bye_amount_outstanding => return "Retail stores (clothers on account or lay : bye) : amount outstanding";
             when foods_or_feeds => return "Foods/feeds";
             when cost_of_hire_of_shoes => return "Cost of hire of shoes";
             when tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions_grant => return "Tertiary education Education not definable by level (excluding driving and music lessons, sport etc) in public institutions : Grant";
             when textbooks_for_private_institutions_grant => return "Textbooks for private institutions : Grant";
             when mixed_vegetables_frozen => return "Mixed vegetables frozen";
             when mustard => return "Mustard";
             when plain_yogurt => return "Plain yogurt";
             when samp => return "Samp";
             when apples => return "Apples";
             when value_of_other_benefints_donations_gifts_etc => return "Value of other benefints, donations, gifts etc";
             when coffee => return "Coffee";
             when muesli => return "Muesli";
             when soya_milk => return "Soya milk";
             when rented_vehicles_other_than_educational => return "Rented vehicles other than educational";
             when gas_in_cylinders_including_gas_for_heating_purposes => return "Gas in cylinders (including gas for heating purposes)";
             when rooibos_tea_bags => return "Rooibos tea bags";
             when smooth_peach_jam => return "Smooth peach jam";
             when funeral_policies => return "Funeral policies";
             when sweet_corn_cream_style => return "Sweet corn, cream style";
             when other_loans => return "Other loans";
             when golden_syrup => return "Golden syrup";
             when onions => return "Onions";
             when candles => return "Candles";
             when bicarbonate_of_soda => return "Bicarbonate of soda";
             when medical_aid_contribution_paid_by_household_member_in_private_institution => return "Medical aid contribution Paid by household member in private institution";
             when marrow_fresh => return "Marrow fresh";
             when value_of_housing => return "Value of Housing";
             when other_meat_and_meat_products_including_meat_pies => return "Other meat and meat products (including meat pies)";
             when oranges => return "Oranges";
             when green_beans_frozen => return "Green beans frozen";
             when table_and_bathroom_linen_eg_table_cloths_and_napkins_towels_and_face_cloths => return "Table and bathroom linen (eg table cloths and napkins, towels & face cloths)";
             when stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions_income => return "Stationery : Grant (for academic purposes, excluding calculators for private institutions - Income ";
             when parts_and_upgrading_of_computers => return "Parts and upgrading of computers";
             when eggs => return "Eggs";
             when other_clothes_pegs_hangers_etc_specify => return "Other (clothes : pegs, hangers etc) specify";
             when sheep => return "Sheep";
             when deposits_into_savings => return "Deposits into savings";
             when licenses => return "Licenses";
             when maintenance_and_lubrication_services => return "Maintenance and lubrication services";
             when herbal_tea_not_from_food_service_place => return "Herbal tea not from food service place";
             when prams_and_push_carts => return "Prams and push : carts";
             when baked_beans_in_tomato_sauce => return "Baked beans in tomato sauce";
             when melon => return "Melon";
             when tee_leaves => return "Tee leaves";
             when capital_payments_including_deposit => return "Capital payments (including deposit)";
             when pumpkin_frozen => return "Pumpkin frozen";
             when infants_clothing => return "Infants’ clothing";
             when alimony_palimony_and_other_allowances => return "Alimony, palimony and other allowances";
             when cost_of_the_hire_of_clothing => return "Cost of the hire of clothing";
             when minibus_taxi_or_combi_including_30_seaters_eg_iveco_for_educational_purposes => return "Minibus taxi/combi (including 30 seaters eg Iveco) for educational purposes";
             when furniture_removals_and_transport_of_goods_not_for_business_purposes_for_non_educational_purposes => return "Furniture removals and transport of goods (not for business purposes) for non : educational purposes";
             when purchase_of_pets => return "Purchase of pets";
             when corn_chips => return "Corn chips";
             when repair_of_footwear => return "Repair of footwear";
             when sorghum_beer_traditional_from_a_food_service_place => return "Sorghum beer (traditional) from a food service place";
             when fines_fines_for_straying_livestock_excluding_traffic_fines_and_library_fines => return "Fines (fines for straying livestock), excluding traffic fines and library fines";
             when oil_and_grease => return "Oil and grease";
             when girls_school_footwear => return "Girls’ school footwear";
             when peaches => return "Peaches";
             when textbooks_for_public_institutions => return "Textbooks for public institutions";
             when professional_fees => return "Professional fees";
             when sandwiches => return "Sandwiches";
             when other_furniture => return "Other furniture";
             when table_wines_including_sparkling_wine_not_from_food_service_places => return "Table wines (including sparkling wine) not from food service places";
             when other_sausages_chicken_game_etc => return "Other sausages (chicken, game,etc)";
             when life_and_endownment_policies => return "Life and endownment policies";
             when library_fees_fines_grant_for_academic_purpose => return "Library fees fines  : Grant (for academic purpose)";
             when mineral_water_or_spring_water => return "Mineral water/spring water";
             when computer_certification_public_schools => return "Computer certification public schools";
             when raisins => return "Raisins";
             when others_expenditures_except_food => return "Others expenditures except food";
             when marie_biscuits => return "Marie biscuits";
             when charcoal => return "Charcoal";
             when contribution_to_pension_provident_and_annuity_funds => return "Contribution to pension, provident and annuity funds";
             when value_of_food_received => return "Value of food received";
             when tagged_tea_bags => return "Tagged tea bags";
             when other_dried_vegetables_specify => return "Other dried vegetables, specify";
             when cash_wage_incl_transport_received_by_clothes_washers_or_ironers => return "Cash wage incl transport received by clothes washers/ironers";
             when site_income_tax => return "SITE : income tax";
             when cherries => return "Cherries";
             when fortified_wines_sherry_port_etc_from_food_service_places => return "Fortified wines (sherry, port etc) from food service places";
             when seed => return "Seed";
             when annuities_from_own_investment => return "Annuities from own investment";
             when schools_boarding_fees_in_public_institutions_grant => return "Schools boarding fees in public institutions : Grant";
             when dried_fish => return "Dried fish";
             when lift_clubs_other => return "Lift clubs other";
             when medical_aid_contribution_contribution_by_employer_in_private_institutions_income => return "Medical aid contribution Contribution by employer in private institutions : Income";
             when television_licenses => return "Television licenses";
             when shampoo_and_conditioners => return "Shampoo and conditioners";
             when hospital_service_fees_eg_wards_beds_and_theatre_fees_in_public_institutions => return "Hospital service fees (eg wards, beds and theatre fees) in public institutions";
             when other_eg_dry_cabinets_and_safes_specify => return "Other (eg dry cabinets and safes) specify";
             when other_tuition_fees_for_private_institutions => return "Other tuition fees for private institutions";
             when donations_to_institutions => return "Donations to Institutions";
             when tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions => return "Tertiary education Education not definable by level (excluding driving and music lessons, sport etc) in private institutions";
             when cucumber_fresh => return "Cucumber fresh";
             when other_gambling => return "Other gambling";
             when beetroot => return "Beetroot";
             when polony => return "Polony";
             when garden_water_sprinkler => return "Garden water sprinkler";
             when excursions_field_trips_in_public_institutions => return "Excursions (field trips) in public institutions";
             when offshore => return "Offshore";
             when lobola_or_dowry_received => return "Lobola  or dowry received";
             when curry_and_rice => return "Curry and rice";
             when almonds => return "Almonds";
             when sorbet => return "Sorbet";
             when cake_flour => return "Cake flour";
             when donkey => return "Donkey";
             when expenditure_incurred_in_obtaining_income => return "Expenditure incurred in obtaining income";
             when vocational_training_in_private_institutions_grant_income => return "Vocational training in private institutions : Grant Income";
             when medicine_purchased_without_prescription_in_private_institutions => return "Medicine purchased without prescription in private institutions";
             when frying_pans_and_woks => return "Frying pans and woks";
             when cocoa_and_powdered_chocolate => return "Cocoa and powdered chocolate";
             when custard_powder => return "Custard powder";
             when maintenance_and_repair_of_dwelling_existing_buildings_swimming_pools_etc_including_paints_wallpaper_etc => return "Maintenance and repair of dwelling (existing buildings, swimming pools etc including paints, wallpaper etc)";
             when jumbo_eggs => return "Jumbo eggs";
             when traffic_fines => return "Traffic fines";
             when rice => return "Rice";
             when potato_chips_frozen => return "Potato chips frozen";
             when scouring_powders_pot_scourers_etc => return "Scouring powders, pot scourers, etc";
             when peas_frozen => return "Peas frozen";
             when razors_and_razor_blades => return "Razors and razor blades";
             when fax_machines_and_telephone_answering_machines_for_household_purposes => return "Fax machines and telephone answering machines for household purposes";
             when instant_pudding_powder => return "Instant pudding powder";
             when puffed_rice => return "Puffed rice";
             when other_nuts_specify => return "Other nuts, specify";
             when four_wheel_drive_vehicles => return "Four wheel drive vehicles";
             when tiles => return "Tiles";
             when fitted_carpets => return "Fitted carpets";
             when tag_less_tea_bags => return "Tag less tea bags";
             when donations_to_charity => return "Donations to Charity";
             when other_eg_energade_lucozade_ice_tea_etc => return "Other (eg Energade, Lucozade, Ice tea etc)";
             when used_motor_cycles_and_scooters => return "Used motor cycles and scooters";
             when coffee_beans => return "Coffee beans";
             when estimated_value_of_private_use_of_company_or_similar_vehicle => return "Estimated value of private use of company or similar vehicle";
             when pharmacy_service_fees_in_private_institutions => return "Pharmacy service fees in private institutions";
             when sour_milk_or_maas => return "Sour milk/maas";
             when mineral_water_or_spring_water_aerated_and_still => return "Mineral water/spring water (aerated and still)";
             when stationery_for_academic_purposes_excluding_calculators_for_private_institutions => return "Stationery (for academic purposes, excluding calculators for private institutions";
             when bond_loan_from_the_bank => return "Bond loan from the bank";
             when day_care_mothers_creches_and_playgrounds_in_private_institutions_grant_income => return "Day : care mothers, creches and playgrounds in private institutions : Grant Income";
             when other_including_language_classes_in_public_institutions_grant => return "Other (including language classes) in public institutions : Grant";
             when membership_fees => return "Membership Fees";
             when other_edible_ices_and_ice_cream_specify => return "Other edible ices and ice cream, specify";
             when infants_footwear => return "Infants’ footwear";
             when dish_cloths_wash_and_dry => return "Dish cloths (wash and dry)";
             when prepaid_electricity => return "Prepaid electricity";
             when schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat => return "Schools and other edu inst  : Grant (Expenses incurred not normally regarded as tuition, eg contributions to sports grounds) in privat";
             when pap_and_meat => return "Pap and meat";
             when skin_creams_and_lotions_including_baby_lotions_facial_cleansers_and_toners_perfumes_and_colognes => return "Skin creams and lotions (including baby lotions) Facial cleansers and toners Perfumes and colognes";
             when fruit => return "Fruit";
             when cleaning_of_clothing => return "Cleaning of clothing";
             when used_caravans_and_trailers_including_motorised_caravans => return "Used caravans and trailers including motorised caravans";
             when coal_including_anthracite => return "Coal (including anthracite)";
             when other_produce_specify => return "Other produce, specify";
             when other => return "Other";
             when excursions_field_trips_in_public_institutions_grant_income => return "Excursions (field trips) in public institutions : Grant Income";
             when musical_instruments_pianos_organs_and_other_musical_instruments => return "Musical instruments: Pianos, organs and other musical instruments";
             when boat_or_ship_educational_trips => return "Boat/ship educational trips";
             when in_cash_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children => return "In Cash Maintenance of/remittance to family members and dependants living elsewhere (including alimony/palimony paid to ex : wife/ex : husband, children)";
             when refrigerators_deep_freezers_and_refrigerator_or_deep_freeze_combinations => return "Refrigerators, deep freezers and refrigerator/deep : freeze combinations";
             when specially_made_up_clothes_eg_clothes_made_by_dressmakers_and_tailors => return "Specially made : up clothes (eg clothes made by dressmakers and tailors)";
             when aircraft_other_than_educaional => return "Aircraft other than educaional";
             when primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions_grant_income => return "Primary education (includes literacy programmes for students too old for primary school) in private institutions : Grant - Income ";
             when fine_white_pepper => return "Fine white pepper";
             when new_tyres_and_tubes => return "New tyres and tubes";
             when peaches_dried => return "Peaches dried";
             when cash_wage_incl_transport_received_by_other_domestic_worker => return "Cash wage incl transport received by other domestic worker";
             when pepper_black_corns_and_fine_black_pepper => return "Pepper, black corns and fine black pepper";
             when sale_of_vehicles_property_etc => return "Sale of vehicles,property etc";
             when preserves_specify => return "Preserves, specify";
             when garden_ornaments => return "Garden ornaments";
             when medical_analysis_laboratories_and_x_ray_service_in_public_institutions => return "Medical analysis laboratories and X : ray service in public institutions";
             when fresh_full_cream_milk => return "Fresh full cream milk";
             when evaporated_milk => return "Evaporated milk";
             when other_livestock_from_own_production => return "Other livestock from own production";
             when chicken_spice => return "Chicken spice";
             when butter => return "Butter";
             when firewood_bought => return "Firewood Bought";
             when other_including_language_classes_in_private_institutions_grant_income => return "Other (including language classes) in private institutions : Grant Income";
             when washing_machines_dishwashers_and_tumble_dryers => return "Washing machines, dishwashers and tumble dryers";
             when chewing_tobacco_and_snuff => return "Chewing tobacco and snuff";
             when cooking_wines_not_from_food_service_places => return "Cooking wines not from food service places";
             when kitchen_furniture_and_units_excluding_appliances_eg_refrigerators => return "Kitchen furniture and units (excluding appliances, eg refrigerators)";
             when payment_for_right_to_access_land => return "Payment for right to access land";
             when frozen_yogurt => return "Frozen yogurt";
             when pre_primary_education_in_public_institutions => return "Pre : primary education in public institutions";
             when other_dividends => return "Other Dividends";
             when prepared_salads => return "Prepared salads";
             when loose_carpets_and_rugs => return "Loose carpets and rugs";
             when vocational_training_in_private_institutions => return "Vocational training in private institutions";
             when grapes => return "Grapes";
             when holiday_tour_package => return "Holiday tour package";
             when chili_powder => return "Chili powder";
             when pineapple => return "Pineapple";
             when disability_grants => return "Disability grants";
             when schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public => return "Schools and other edu inst  : Grant (Expenses incurred not normally regarded as tuition, eg contributions to sports grounds) in public";
             when pop_corn_kernels => return "Pop corn kernels";
             when laundry_service_for_household_textile_and_carpets_and_nappy_services_including_launderettes => return "Laundry service for household textile and carpets and nappy services (including  launderettes)";
             when petrol_for_household_use_not_transport => return "Petrol for household use (not transport)";
             when soya_product_excluding_soy_milk => return "Soya product (excluding soy milk)";
             when white_bread => return "White bread";
             when fish_paste => return "Fish paste";
             when cottage_cheese => return "Cottage cheese";
             when ice_cubes => return "Ice cubes";
             when other_personal_care_products => return "Other personal care products";
             when pre_primary_education_in_private_institutions => return "Pre : primary education in private institutions";
             when full_cream_ice_cream => return "Full cream ice cream";
             when levy_and_other_payments => return "Levy and other payments";
             when library_fees_fines_grant_for_academic_purpose_income => return "Library fees fines  : Grant (for academic purpose) - Income ";
             when household_self_employment_and_business => return "Household self : employment and business";
             when fresh_cream => return "Fresh cream";
             when pharmacy_dispensing_fees_in_private_institutions => return "Pharmacy dispensing fees in private institutions";
             when cash_wage_incl_transport_received_by_child_minder_or_nanny => return "Cash wage incl transport received by child minder/ nanny";
             when watches_and_personal_jewellery => return "Watches and personal jewellery";
             when disks_for_photographic_and_cinematographic_use => return "Disks for photographic and cinematographic use";
             when other_postage => return "Other postage";
             when loans_from_money_lenders => return "Loans from money lenders";
             when cash_wage_incl_transport_received_by_garden_worker => return "Cash wage incl transport received by garden worker";
             when special_sports_clothes_and_shoes => return "Special sports clothes and shoes";
             when milk_plain_slabs => return "Milk, plain slabs";
             when medicine_purchased_with_prescription_in_public_institutions => return "Medicine purchased with prescription in public institutions";
             when day_care_mothers_creches_and_playgrounds_in_public_institutions => return "Day : care mothers, creches and playgrounds in public institutions";
             when prunes_dried => return "Prunes dried";
             when floor_shoe_and_furniture_polish => return "Floor shoe and furniture polish";
             when imputed_rent_on_owned_dwellingi_7pct_peryear_of_dwelling => return "Imputed rent on owned dwellingI 7% PerYear of Dwelling";
             when valet_services => return "Valet services";
             when teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_income => return "Teachers training and technical colleges, technikons boarding fees in private institutions : Grant Income";
             when interest_received => return "Interest received";
             when irons => return "Irons";
             when mixed_vegetables_fresh => return "Mixed vegetables fresh";
             when other_repair_work_paid_for_by_you => return "Other repair work Paid for by you";
             when instant_coffee => return "Instant coffee";
             when primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions_grant => return "Primary education (includes literacy programmes for students too old for primary school) in private institutions : Grant";
             when security_systems_for_cars_including_installation => return "Security systems for cars including installation";
             when bar_with_filling => return "Bar with filling";
             when rate_and_taxes => return "Rate and taxes";
             when dental_service_service_of_dentists_include_oral_hygienists_in_public_institutions => return "Dental service (service of dentists include oral : hygienists) in public institutions";
             when side_lines_and_part_time_activities => return "Side lines and part time activities";
             when tomato_sauce => return "Tomato sauce";
             when frozen_lobster => return "Frozen lobster";
             when spaghetti => return "Spaghetti";
             when other_edible_animal_fats_eg_lard => return "Other edible animal fats (eg lard)";
             when unlisted_company_shares => return "Unlisted company : shares";
             when printers_or_scanners_or_copiers => return "Printers/scanners/copiers";
             when cocoa_powder => return "Cocoa powder";
             when claims => return "Claims";
             when gouda_cheese => return "Gouda cheese";
             when computer_certification_private_schools_grant_income => return "Computer certification private schools : Grant Income";
             when coal_wood_and_anthracite_stoves => return "Coal, wood and anthracite stoves";
             when life_insurance_covering_mortgage_debt => return "Life insurance covering mortgage debt";
             when goats => return "Goats";
             when peas_dried => return "Peas dried";
             when cellular_phones => return "Cellular phones";
             when other_cost_for_other_modes_of_transport => return "Other cost for other modes of transport";
             when scissors_needles_pins => return "Scissors, needles, pins";
             when rent_for_decoder_video_equipment_and_tapes => return "Rent for decoder, video equipment and tapes";
             when calls_from_public_phones => return "Calls from public phones";
             when cash_wage_incl_transport_received_by_general_domestic_worker => return "Cash wage incl transport received by general domestic worker";
             when clear_beer_purchased_from_a_food_service_place => return "Clear beer purchased from a food service place";
             when recharging_of_rechargeable_cells_not_car_batteies => return "Recharging of rechargeable cells (not car batteies)";
             when minibus_taxi_or_combi_including_30_seaters_eg_iveco_for_non_educational_purposes => return "Minibus taxi/combi (including 30 seaters eg Iveco) for non : educational purposes";
             when fees_for_lessons_connecting_with_recreation_ebtertainment_and_sport => return "Fees for lessons connecting with recreation, ebtertainment and sport";
             when medical_aid_contribution_contribution_by_employer_in_public_institutions_income => return "Medical aid contribution Contribution by employer in public institutions : Income ";
             when canned_tuna => return "Canned tuna";
             when train_for_non_educational_institutions => return "Train for non : educational institutions";
             when other_tuition_fees_for_public_institutions_grant => return "Other tuition fees for public institutions : Grant";
             when rent_holiday_flat_or_house_caravan_etc_including_site_fees_paying_for_yourself => return "Rent: Holiday flat or house caravan, etc (including site fees) (paying for yourself)";
             when pork_incl_heads_and_feet => return "Pork (incl heads and feet)";
             when labour_and_material_for_improvements_additions_and_alterations => return "Labour and material for improvements, additions and alterations";
             when cinnamon => return "Cinnamon";
             when museums_and_zoos_etc => return "Museums and zoos etc";
             when boat_or_ship_other_than_educaional => return "Boat/ship other than educaional";
             when other_specify_berries => return "Other, specify berries";
             when table_wines_including_sparkling_wine_from_food_service_places => return "Table wines (including sparkling wine) from food service places";
             when packages => return "Packages";
             when low_fat_margarine_spread => return "Low fat margarine spread";
             when broccoli_fresh => return "Broccoli fresh";
             when green_or_red_or_yellow_pepper_fresh => return "Green/red/yellow pepper fresh";
             when medium_fat_margarine_spread => return "Medium fat margarine spread";
             when cost_of_other_dewlling => return "Cost of Other Dewlling";
             when schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public_income => return "Schools and other edu inst  : Grant (Expenses incurred not normally regarded as tuition, eg contributions to sports grounds) in public: Income";
             when whiteners_cremora_ellis_brown => return "Whiteners (Cremora, Ellis Brown)";
             when other_payments_such_as_transfer_duty_and_transfer_costs_and_registration_of_mortgage_bond => return "Other payments such as transfer duty and transfer costs and registration of  mortgage bond";
             when wheat => return "Wheat";
             when security_structures_including_fences_electronic_gates => return "Security structures (including fences, electronic gates)";
             when other_including_language_classes_in_public_institutions_grant_income => return "Other (including language classes) in public institutions : Grant Income";
             when carrots_fresh => return "Carrots fresh";
             when connection_to_the_network_for_a_landline => return "Connection to the network for a landline";
             when potato_crisps => return "Potato crisps";
             when green_mealies_fresh => return "Green mealies fresh";
             when boys_footwear => return "Boys’ footwear";
             when bubble_bath_bath_oils_and_bath_salts => return "Bubble bath, bath oils and bath salts";
             when ham => return "Ham";
             when other_dried_fruit => return "Other dried fruit";
             when girls_school_uniform => return "Girls’ school uniform";
             when lift_clubs_educational_trips => return "Lift clubs educational trips";
             when beans_dried => return "Beans dried";
             when veterinary_costs => return "Veterinary costs";
             when contributions_to_a_stokvel => return "Contributions to a stokvel";
             when batteries_new_and_used => return "Batteries (new and used)";
             when primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions_grant_income => return "Primary education (includes literacy programmes for students too old for primary school) in public institutions : Grant - Income ";
             when family_and_other_allowances => return "Family and other allowances";
             when fruit_juices_from_food_service_places => return "Fruit juices from food service places";
             when aircraft_educaional_trips => return "Aircraft educaional trips";
             when other_meat_incl_heads_and_feet => return "Other meat (incl heads and feet)";
             when repairs_and_service_charges_for_electrical_appliances => return "Repairs and service charges for electrical appliances";
             when medical_services_in_public_institutions => return "Medical services in public institutions";
             when estimated_value_of_private_use_of_company_or_similar_vehicle_income => return "Estimated value of private use of company or similar vehicle: Income";
             when medical_aid_contribution_contribution_by_employer_in_public_institutions => return "Medical aid contribution Contribution by employer in public institutions";
             when computer_certification_private_schools => return "Computer certification private schools";
             when furniture_removals_and_transport_of_goods_not_for_business_purposes_for_educational_purposes => return "Furniture removals and transport of goods (not for business purposes) for educational purposes";
             when lamb_incl_heads_and_feet => return "Lamb (incl heads and feet)";
             when potatoes => return "Potatoes";
             when tax_refunds_received => return "Tax Refunds received";
             when newspapers_daily_weekly => return "Newspapers : daily weekly";
             when soft_drinks => return "Soft drinks";
             when yellow_brick_margarine => return "Yellow brick margarine";
             when bread_rolls => return "Bread rolls";
             when used_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes => return "Used motor cars, station wagons and mini : buses (excluding vehicles for business purposes)";
             when pagers => return "Pagers";
             when knitting_wool_and_yarns => return "Knitting wool and yarns";
             when radios_including_motor_car_radios_tape_recorders_compact_disk_players_and_similar_equipment => return "Radios (including motor car radios) tape recorders, compact disk players and similar equipment)";
             when repairs_and_service_charges_for_non_electrical_appliances => return "Repairs and service charges for non electrical appliances";
             when schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public => return "Schools and other educational institutions (Expenses incurred not normally regarded as tuition, eg contributions to sports grounds) in public";
             when value_added_tax_vat_only_if_telephone_account_is_available => return "Value added tax (VAT) (only if telephone account is available)";
             when other_preserved_or_processed_fish_and_seafood => return "Other preserved or processed fish and seafood";
             when pickles => return "Pickles";
             when other_eg_horse_for_non_educational_puporses => return "Other (eg horse) for non : educational puporses";
             when other_medical_services_in_private_institutions => return "Other medical services in private institutions";
             when paye_income_tax => return "PAYE : income tax";
             when schools_boarding_fees_in_public_institutions => return "Schools boarding fees in public institutions";
             when other_specify_eg_junior_laptops_training_and_adult_education_for_public_institutions => return "Other, specify (eg junior laptops, training and adult education) for public institutions";
             when garlic_bread => return "Garlic bread";
             when fortified_wines_sherry_port_etc_not_from_food_service_places => return "Fortified wines (sherry, port etc) not from food service places";
             when day_care_mothers_creches_and_playgrounds_in_public_institutions_grant_income => return "Day : care mothers, creches and playgrounds in public institutions : Grant Income";
             when medical_aid_contribution_contribution_by_employer_in_private_institutions => return "Medical aid contribution Contribution by employer in private institutions";
             when upholstering => return "Upholstering";
             when fruit_and_vegetable_juices_combined_from_food_service_places => return "Fruit and vegetable juices (combined) from food service places";
             when cauliflower_frozen => return "Cauliflower frozen";
             when service_of_medical_auxiliaries_freelance_nurse_midwives_freelance_optometrist_physiotherapist_speech_therapist_etc_in_private_instituti => return "Service of medical auxiliaries (freelance nurse, midwives, freelance optometrist, physiotherapist, speech therapist etc) in private instituti";
             when vegetable_spread_bovril_fray_bentos => return "Vegetable spread (Bovril, Fray Bentos)";
             when rusks => return "Rusks";
             when rooibos_tea => return "Rooibos tea";
             when taystee_wheat => return "Taystee wheat";
             when boerewors => return "Boerewors";
             when condensed_milk => return "Condensed milk";
             when powdered_chocolate => return "Powdered chocolate";
             when medical_services_in_private_institutions => return "Medical services in private institutions";
             when canned_granadilla_pulp => return "Canned granadilla pulp";
             when jelly_powder => return "Jelly powder";
             when hotel_motel_and_or_or_boarding_fees_paying_for_yourself => return "Hotel, motel, and/or boarding fees (paying for yourself)";
             when other_investments => return "Other investments";
             when monthly_capital_payments => return "Monthly capital payments";
             when toilet_paper => return "Toilet paper";
             when walnuts => return "Walnuts";
             when corn_flakes => return "Corn flakes";
             when aircraft => return "Aircraft";
             when primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions_grant => return "Primary education (includes literacy programmes for students too old for primary school) in public institutions : Grant";
             when sewing_and_knitting_machines => return "Sewing and knitting machines";
             when pillows_and_cushions => return "Pillows and cushions";
             when packaging_materials_plastic_bags_and_sachets_foil_wax_paper_etc => return "Packaging materials (plastic bags and sachets, foil, wax paper, etc)";
             when excursions_field_trips_in_private_institutions => return "Excursions (field trips) in private institutions";
             when amnesty_tax => return "Amnesty tax";
             when swimming_pool_maintenance_excluding_wages_of_persons_who_maintain_pools_but_including_chemicals => return "Swimming pool maintenance (excluding wages of persons who maintain pools, but including chemicals)";
             when rented_on_holiday => return "Rented on holiday";
             when other_milk_products => return "Other milk products";
             when other_household_fuel => return "Other household fuel";
             when mutton_incl_heads_and_feet => return "Mutton (incl heads and feet)";
             when other_bread_loaves => return "Other bread loaves";
             when cigarettes => return "Cigarettes";
             when motor_car_fuel => return "Motor car fuel";
             when other_specify_eg_junior_laptops_training_and_adult_education_for_private_institutions => return "Other, specify (eg junior laptops, training and adult education) for private institutions";
             when unit_trusts => return "Unit trusts";
             when miscellaneous_printed_mattereg_road_maps_greeting_cards_posters_etc => return "Miscellaneous printed matter(eg road maps, greeting cards, posters etc)";
             when spinach_or_morogo_fresh => return "Spinach/morogo fresh";
             when other_private_modes_of_transport_animals => return "Other private modes of transport (animals)";
             when mens_footwear => return "Men's footwear";
             when security_systems_including_alarms_panic_buttons => return "Security systems (including alarms, panic buttons)";
             when bus_including_school_bus_for_non_educational_purposes => return "Bus (including school bus) for non : educational purposes";
             when bank_overdraft => return "Bank overdraft";
             when therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_private_institutions => return "Therapeutic appliances and equipment (like spectacles and hearing aids) in private institutions";
             when computer_certification_private_schools_grant => return "Computer certification private schools : Grant";
             when other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions => return "Other, specify : Grant (eg junior laptops, training and adult education) for private institutions";
             when other_eg_flavored_tea_specify => return "Other, (eg flavored tea) specify";
             when longlife_low_fat_milk => return "Longlife low fat milk";
             when fresh_or_chilled_seafood => return "Fresh or chilled seafood";
             when sorghum_beer_pre_packed_from_food_service_places => return "Sorghum beer (pre : packed) from food service places";
             when day_care_mothers_creches_and_playgrounds_in_public_institutions_grant => return "Day : care mothers, creches and playgrounds in public institutions : Grant";
             when duvets_and_duvet_covers => return "Duvets and duvet covers";
             when library_services_for_academic_purposes => return "Library services (for academic purposes)";
             when feed => return "Feed";
             when body_soap_including_sunlight_liquid_soap => return "Body soap (including Sunlight, liquid soap)";
             when listed_company_shares => return "Listed company : shares";
             when flavoured_yogurt => return "Flavoured yogurt";
             when tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions => return "Tertiary education Education not definable by level (excluding driving and music lessons, sport etc) in public institutions";
             when curtains_including_making_and_hanging_charges_and_material_for_curtains => return "Curtains (including making and hanging charges) and material for curtains";
             when sorghum_beer_traditional_not_from_a_food_service_place => return "Sorghum beer (traditional) not from a food service place";
             when workmens_compensation_funds => return "Workmen's compensation Funds";
             when mens_clothing => return "Men’s clothing";
             when pecan_nuts => return "Pecan nuts";
             when benefits_donations_and_giftes => return "Benefits, donations and giftes";
             when sweet_potatoes => return "Sweet potatoes";
             when excursions_field_trips_in_private_institutions_grant => return "Excursions (field trips) in private institutions : Grant";
             when computer_certification_public_schools_grant => return "Computer certification public schools : Grant";
             when baby_food_predominantly_vegetables => return "Baby food Predominantly vegetables";
             when repairs_and_service_charges_for_musical_instruments_sound_equipment_and_accessories => return "Repairs and service charges for musical instruments, sound equipment and accessories";
             when processingeg_grinding_milling_and_slaughtering => return "Processing(eg grinding, milling and slaughtering)";
             when licenses_and_registration_fees_including_that_of_motor_cycles => return "Licenses and registration fees (including that of motor cycles)";
             when fumigation_and_cleaning_services_including_those_of_upholstery_swimming_pool_window_cleaning_etc => return "Fumigation and cleaning services (including those of upholstery , swimming pool, window cleaning etc)";
             when canned_pilchards => return "Canned pilchards";
             when toothpaste_toothbrushes_electrical_toothbrushes => return "Toothpaste, toothbrushes, electrical toothbrushes";
             when pigs => return "Pigs";
             when repairs_of_computers_and_communication_equipment => return "Repairs of computers and communication equipment";
             when magazines_and_periodicals => return "Magazines and periodicals";
             when schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat_income => return "Schools and other edu inst  : Grant (Expenses incurred not normally regarded as tuition, eg contributions to sports grounds) in privat: Income";
             when library_services_grant_for_academic_purposes => return "Library services : Grant (for academic purposes)";
             when vegetables => return "Vegetables";
             when ground_coffee => return "Ground coffee";
             when mealie_rice => return "Mealie rice";
             when gas => return "Gas";
             when income_from_letting_of_fixed_property => return "Income from letting of fixed property";
             when other_household_textiles => return "Other household textiles";
             when medical_insurance => return "Medical insurance";
             when software_excluding_games_play_stations_etc => return "Software (excluding games, play : stations etc)";
             when telephones_cordless_telephones_motor_telephones => return "Telephones, cordless telephones, motor telephones";
             when vcds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_vcds => return "VCDs (excluding software and video games; including pre : recorded and unrecorded VCDs)";
             when vegetable_juices_from_food_service_places => return "Vegetable juices from food service places";
             when other_canned_fish => return "Other canned fish";
             when womens_and_girls => return "Women's and girls";
             when levy_on_timeshare => return "Levy on timeshare";
             when excursions_field_trips_in_private_institutions_grant_income => return "Excursions (field trips) in private institutions : Grant Income";
             when secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution_grant_income => return "Secondary education (includes out : of : school secondary education for adults and young people) in private institution  : Grant - Income ";
             when aerials_and_satellite_dishes => return "Aerials and satellite dishes";
             when day_care_mothers_creches_and_playgrounds_in_private_institutions => return "Day : care mothers, creches and playgrounds in private institutions";
             when non_hospital_service_ambulance_service_other_than_hospital_in_private_institutions => return "Non hospital service (ambulance service other than hospital) in private institutions";
             when other_meal_and_flour => return "Other meal and flour";
             when furniture_and_appliances_amount_oustanding => return "Furniture and appliances : amount oustanding";
             when other_tuition_fees_for_private_institutions_grant_income => return "Other tuition fees for private institutions : Grant Income";
             when poultry => return "Poultry";
             when vacuum_cleaners_polishers_and_carpet_cleaning_machines => return "Vacuum cleaners, polishers and carpet cleaning machines";
             when used_bakkies => return "Used bakkies";
             when water_and_electricity => return "Water and Electricity";
             when other_eg_telegrams => return "Other (eg Telegrams)";
             when hobbis => return "Hobbis";
             when compact_disks_cds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_disks => return "Compact disks :  CDs (excluding software and video games; including pre : recorded and unrecorded disks)";
             when soap_bars_and_cakes_not_toilet_soap_washing_powders_liquid_detergents_and_bleaches_dishwasher_tablets => return "Soap, (bars and cakes, not toilet soap), washing powders, liquid detergents and bleaches, dishwasher tablets";
             when other_medical_services_in_public_institutions => return "Other medical services in public institutions";
             when teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions => return "Teachers training and technical colleges, technikons boarding fees in public institutions";
             when according_to_assessment_income_tax => return "According to assessment : income tax";
             when other_such_as_towel_rails_bottle_racks_etc_specify => return "Other (such as towel rails, bottle racks, etc) Specify";
             when womens_clothing => return "Women’s clothing";
             when other_specify => return "Other , specify";
             when fresh_low_fat_milk => return "Fresh low fat milk";
             when library_fees_fines_for_academic_purpose => return "Library fees fines (for academic purpose)";
             when longlife_full_cream_milk => return "Longlife Full cream milk";
             when gravestones_and_maintenance_of_graves_excluding_unveiling => return "Gravestones and maintenance of graves (excluding unveiling)";
             when value_of_discounted_fares_for_non_educational_purposes => return "Value of discounted fares for non educational purposes";
             when paper_serviettes_or_napkins_disposable_dinner_ware_plates_tumblers_etc => return "Paper serviettes/napkins, disposable dinner ware (plates, tumblers etc)";
             when stoves_and_ovens_including_microwave_ovens => return "Stoves and ovens, including microwave ovens";
             when burger => return "Burger";
             when car_wash => return "Car wash";
             when expenses_occurred_as_owner_of_a_holiday_home_ie_after_deduction_of_income_received_from_letting => return "Expenses occurred as owner of a holiday home ie after deduction of income received from letting";
             when cooking_fat_vegetable_eg_holsum => return "Cooking fat, vegetable (eg Holsum)";
             when brooms_brushes_feather_dusters_etc => return "Brooms, brushes, feather dusters, etc";
             when other_bank_loans => return "Other bank loans";
             when new_animal_drawn_vehicles => return "New animal drawn vehicles";
             when boys_school_footwear => return "Boys’ school footwear";
             when free_electricity => return "Free Electricity";
             when purchase_of_timeshare => return "Purchase of timeshare";
             when primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions => return "Primary education (includes literacy programmes for students too old for primary school) in public institutions";
             when cloves => return "Cloves";
             when calls_including_phone_cards => return "Calls (including phone cards)";
             when pre_primary_education_in_public_institutions_grant => return "Pre : primary education in public institutions : Grant";
             when dry_cells => return "Dry cells";
             when interest_or_finance_charges => return "Interest or finance charges";
             when private_calls => return "Private calls";
             when free_water_income => return "Free Water: Income";
             when teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant => return "Teachers training and technical colleges, technikons boarding fees in public institutions : Grant";
             when other_items_from_own_production => return "Other items from own production";
             when grapefruit => return "Grapefruit";
             when other_baked_products => return "Other baked products";
             when stationery_excluding_those_for_academic_purposes => return "Stationery (excluding those for academic purposes)";
             when other_musical_instruments_sound_equipment_and_accessories => return "Other musical instruments, sound equipment and accessories";
             when mouth_wash_and_dental_floss => return "Mouth : wash and dental floss";
             when value_of_repairs_to_household_textiles => return "Value of repairs to household textiles";
             when patterns_trimming_lace_sewing_cotton_etc => return "Patterns, trimming lace, sewing cotton etc";
             when metered_cab_other_than_educaional => return "Metered cab other than educaional";
             when repairs_to_furnishings => return "Repairs to furnishings";
             when icing_sugar => return "Icing sugar";
             when bank_charges => return "Bank charges";
             when metered_cab_attending_educaional_trips => return "Metered cab attending educaional trips";
             when cigars_and_cigarillos => return "Cigars and cigarillos";
             when television_sets_decoders_video_recorders_or_dvds => return "Television sets, decoders, video recorders/DVDs";
             when other_medical_products_bandages_syringes_knee_supports_etc_in_private_institutions => return "Other medical products (bandages, syringes, knee supports etc) in private institutions";
             when edible_oils_eg_cooking_oils => return "Edible oils (eg cooking oils)";
             when purchase_of_watch_dogs => return "Purchase of watch dogs";
             when boarding_and_lodging => return "Boarding and lodging";
             when other_eg_cable_car_horse => return "Other (eg Cable car, horse)";
             when burger_and_chips => return "Burger and chips";
             when driving_lessons_driving_tests_and_driving_licenses => return "Driving lessons, driving tests and driving licenses";
             when horse => return "Horse";
             when toffees => return "Toffees";
             when other_vegetable_products_specify => return "Other, vegetable products specify";
             when spirit_coolers_cider_hooch_etc_from_a_food_service_place => return "Spirit coolers (cider, hooch etc) from a food service place";
             when goat_incl_heads_and_feet => return "Goat (incl heads and feet)";
             when white_cheese => return "White cheese";
             when biltong => return "Biltong";
             when sanitary_towels_and_tampons => return "Sanitary towels and tampons";
             when peas_tinned => return "Peas tinned";
             when day_care_mothers_creches_and_playgrounds_in_private_institutions_grant => return "Day : care mothers, creches and playgrounds in private institutions : Grant";
             when green_beans_fresh => return "Green beans fresh";
             when brown_bread => return "Brown bread";
             when other_including_language_classes_in_private_institutions_grant => return "Other (including language classes) in private institutions : Grant";
             when tissues => return "Tissues";
             when whole_wheat_bread => return "Whole wheat bread";
             when frozen_fish => return "Frozen fish";
             when universities_boarding_fees_in_public_institution_grant => return "Universities boarding fees in public institution : Grant";
             when handbags_travelling_bags_schoolbags_etc => return "Handbags, travelling bags, schoolbags etc";
             when shavers => return "Shavers";
             when meat_patties => return "Meat patties";
             when honey => return "Honey";
             when cakes => return "Cakes";
             when baby_food_predominantly_fruit => return "Baby food Predominantly fruit";
             when other_electrical_appliances_eg_electric_blankets_water_pumps_and_fans_specify => return "Other electrical appliances (eg electric blankets, water pumps and fans) specify";
             when steak_and_chops_spice => return "Steak and chops spice";
             when repairs_to_furniture => return "Repairs to furniture";
             when plums => return "Plums";
             when refuse_removel => return "Refuse removel";
             when other_baked_cereals => return "Other baked cereals";
             when clear_beer_not_purchased_from_a_food_service_place => return "Clear beer not purchased from a food service place";
             when connection_to_the_network_for_a_cellphone => return "Connection to the network for a cellphone";
             when good_and_services_received_by_virtue_of_occupation => return "good and services received by virtue of occupation";
             when loans_from_friends_and_family => return "Loans from friends and family";
             when corn_flour => return "Corn flour";
             when ordinary_tea => return "Ordinary tea";
             when gratuities_and_other_lump_sum_payments => return "Gratuities and other lump sum payments";
             when cash_wage_incl_transport_received_by_chaffeur => return "Cash wage incl transport received by chaffeur";
             when flat_rate_in_respect_of_services_and_medicine_obtained_at_hospital_or_clinic_in_public_institutions => return "Flat rate in respect of services and medicine obtained at hospital/clinic in public institutions";
             when schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat => return "Schools and other educational institutions (Expenses incurred not normally regarded as tuition, eg contributions to sports grounds) in privat";
             when other_loose_items_of_furniture_specify_eg_beanbags_mirrors => return "Other loose items of furniture, specify (eg beanbags, mirrors)";
             when imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling => return "Imputed rent income on owned dwellingI 7% PerYear of Dwelling";
             when new_motor_cycles_and_scooters => return "New motor cycles and scooters";
             when camping_equipment_tents_sleeping_bags_etc => return "Camping equipment (tents, sleeping bags etc)";
             when medicine_purchased_without_prescription_in_public_institutions => return "Medicine purchased without prescription in public institutions";
             when library_services_grant_for_academic_purposes_income => return "Library services : Grant (for academic purposes) - Income ";
             when stationery_for_academic_purposes_excluding_calculators_for_public_institutions => return "Stationery (for academic purposes, excluding calculators for public institutions";
             when spirits_such_as_brandy_whisky_gin_liqueurs => return "Spirits (such as brandy, whisky gin, liqueurs)";
             when tribal_levies_not_for_housing_in_kind => return "Tribal levies (not for housing) in kind";
             when magnetic_tapes_excl_software_and_video_games_including_pre_recorded_and_unrecorded_music_tapes => return "Magnetic tapes (excl software and video games including pre : recorded and unrecorded music tapes)";
             when value_of_discounted_fares_for_non_educational_purposes_income => return "Value of discounted fares for non educational purposes: Income";
             when aluminum_iron_steel => return "Aluminum, iron steel";
             when carry_cot_toys_etc => return "Carry : cot toys etc";
             when teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant => return "Teachers training and technical colleges, technikons boarding fees in private institutions : Grant";
             when unclassified_diary_items_except_food => return "Unclassified Diary Items except food";
             when crop_waste => return "Crop waste";
             when labour_and_material_for_maintenance_and_repair_of_dwelling => return "Labour and material for maintenance and repair of dwelling";
             when insecticides_indoor_pesticides_drain_and_toilet_cleansers_air_freshener_etc => return "Insecticides, (indoor), pesticides, drain and toilet cleansers, air freshener etc";
             when health_bars => return "Health bars";
             when parking_fees => return "Parking fees";
             when minibus_taxi_including_30_seaters_eg_iveco => return "Minibus taxi (including 30 seaters, eg Iveco)";
             when other_including_language_classes_in_public_institutions => return "Other (including language classes) in public institutions";
             when fresh_or_chilled_fish => return "Fresh or chilled fish";
             when bed_bases_and_mattresses => return "Bed bases and mattresses";
             when security_services_including_reaction_services_and_neighbourhood_watch => return "Security services (including reaction services and neighbourhood watch)";
             when funeral_expenses => return "Funeral expenses";
             when universities_boarding_fees_in_private_institution => return "Universities boarding fees in private institution";
             when free_electricity_income => return "Free Electricity: Income";
             when dry_cleaning_of_household_linen_textiles_and_carpets => return "Dry cleaning of household linen, textiles and carpets";
             when power_drills => return "Power drills";
             when other_bedroom_furniture => return "Other bedroom furniture";
             when mopane_worms => return "Mopane worms";
             when gifts_to_persons_who_are_not_members_of_this_household_excluding_cash_gifts => return "Gifts to persons who are not members of this household (excluding cash gifts)";
             when hand_tools_such_as_screwdrivers => return "Hand tools (such as screwdrivers)";
             when canned_pears => return "Canned pears";
             when train_for_when_away_from_home => return "Train for when away from home";
             when lettuce => return "Lettuce";
             when medical_analysis_laboratories_and_x_ray_service_in_private_institutions => return "Medical analysis laboratories and X : ray service in private institutions";
             when teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions => return "Teachers training and technical colleges, technikons boarding fees in private institutions";
             when secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution => return "Secondary education (includes out : of : school secondary education for adults and young people) in private institution";
             when study_desks_bookshelves_and_other_study_furniture => return "Study desks, bookshelves and other study furniture";
             when rental_cellphone => return "Rental cellphone";
             when care_eg_doggy_parlour_kennels_and_veterinary_costs => return "Care (eg doggy parlour, kennels and veterinary costs)";
             when casinos => return "Casinos";
             when package_insurance => return "Package insurance";
             when peanuts => return "Peanuts";
             when enamel => return "Enamel";
             when services_eg_ploughing_veterinary_not_for_pets => return "Services (eg ploughing, veterinary : not for pets)";
             when panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party => return "Panel : beating repairs Paid for by your insurance company or other party";
             when internet_subscription_and_other_costs => return "Internet subscription and other costs";
             when sorghum_beer_pre_packed_not_from_a_food_service_place => return "Sorghum beer (pre : packed) not from a food service place";
             when gifts_to_persons_who_are_not_members_of_this_household_excluding_cash_gifts_in_kind => return "Gifts to persons who are not members of this household (excluding cash gifts) in kind";
             when other_tuition_fees_for_public_institutions_grant_income => return "Other tuition fees for public institutions : Grant Income";
             when cheese_spread => return "Cheese spread";
             when new_bakkies => return "New bakkies";
             when hair_pieces => return "Hair pieces";
             when chicken_extract_cubes => return "Chicken extract cubes";
             when cabbage_fresh => return "Cabbage fresh";
             when pet_food_or_feeds_and_other_requisites => return "Pet food/feeds and other requisites";
             when stamps => return "Stamps";
             when insurance_for_private_transport => return "Insurance for private transport";
             when hair_care_preparations_mousse_relaxers_gels_etc => return "Hair care preparations (mousse, relaxers, gels, etc)";
             when pre_primary_education_in_private_institutions_grant => return "Pre : primary education in private institutions : Grant";
             when stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions => return "Stationery : Grant (for academic purposes, excluding calculators for public institutions";
             when smokers_reqisites => return "Smokers reqisites";
             when levy_for_sectional_title => return "Levy for sectional title";
             when household_salaries_and_wages => return "Household salaries and wages";
             when consultations_of_traditional_healers_in_private_institutions_or_work_places => return "Consultations of traditional healers in private institutions/work places";
             when poultry_incl_heads_and_feet => return "Poultry (incl heads and feet)";
             when fish_portions => return "Fish portions";
             when value_of_clothing => return "Value Of Clothing";
             when cinema_theatres_concerts_festivals => return "Cinema, theatres, concerts, festivals";
             when olive_oils => return "Olive oils";
             when guava => return "Guava";
             when milk_whole_nut_slabs => return "Milk, whole nut slabs";
             when service_of_medical_auxiliaries_freelance_nurse_midwives_freelance_optometrist_physiotherapist_speech_therapist_etc_in_public_institutio => return "Service of medical auxiliaries (freelance nurse, midwives, freelance optometrist, physiotherapist, speech therapist etc) in public institutio";
             when membership_fees_for_gymnasiums_health_sport_and_social_clubs => return "Membership fees for gymnasiums, health, sport and social clubs";
             when baby_food_predominantly_milk => return "Baby food Predominantly milk";
             when vegetable_juices_not_from_food_service_places => return "Vegetable juices not from food service places";
             when free_sanitation => return "Free Sanitation";
             when other_eg_mampoer_home_brewed_from_food_service_place => return "Other (eg mampoer, home brewed) from food service place";
             when other_eg_ornaments_paintings_and_other_works_of_art_specify => return "Other (eg ornaments, paintings and other works of art) specify";
             when artificial_sweeteners => return "Artificial sweeteners";
             when mushrooms => return "Mushrooms";
             when watermelon => return "Watermelon";
             when shaving_soap_and_cream_and_after_shave_lotions => return "Shaving soap and cream and after shave lotions";
             when atchaar => return "Atchaar";
             when other_tuition_fees_for_public_institutions => return "Other tuition fees for public institutions";
             when sheets_and_pillow_cases => return "Sheets and pillow cases";
             when sports => return "Sports";
             when bananas => return "Bananas";
             when diskettes_cds_flah_disks_and_other_consumable_goods => return "Diskettes, CDs, flah disks and other consumable goods";
             when pharmacy_dispensing_fees_in_public_institutions => return "Pharmacy dispensing fees in public institutions";
             when prepared_pop_corn => return "Prepared pop corn";
             when salad_dressing => return "Salad dressing";
             when value_of_transport => return "Value Of Transport";
             when spirit_coolers_cider_hooch_etc_not_from_a_food_service_place => return "Spirit coolers (cider, hooch etc) not from a food service place";
             when other_processed_meat_russians => return "Other processed meat ( Russians)";
             when powdered_milk => return "Powdered milk";
             when other_tuition_fees_for_private_institutions_grant => return "Other tuition fees for private institutions : Grant";
             when duvet_packs_eg_package_including_pillow_cases_and_sheets => return "Duvet packs (eg package including pillow cases and sheets)";
             when other_eg_horse_for_educational_puporses => return "Other (eg horse) for educational puporses";
             when value_added_tax_vat_on_calls_only_if_telephone_account_is_available => return "Value added tax (VAT) on calls (only if telephone account is available)";
             when hiring_of_furniture_furnishings_carpets => return "Hiring of furniture, furnishings, carpets,";
             when schools_boarding_fees_in_private_institutions => return "Schools boarding fees in private institutions";
             when spirits => return "Spirits";
             when peanut_butter => return "Peanut butter";
             when non_hospital_service_ambulance_service_other_than_hospital_in_public_institutions => return "Non hospital service (ambulance service other than hospital) in public institutions";
             when concentrates_and_drink_powders => return "Concentrates and drink powders";
             when dvds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_dvds => return "DVDs (excluding software and video games, including pre : recorded and unrecorded DVDs)";
             when in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children => return "In Kind Maintenance of/remittance to family members and dependants living elsewhere (including alimony/palimony paid to ex : wife/ex : husband, children)";
             when rooibos_tea_leaves => return "Rooibos tea leaves";
             when value_of_repairs_to_miscellaneous_items => return "Value of repairs to miscellaneous items";
             when matches => return "Matches";
             when condoms_strings_and_other_contraceptives_excluding_tablets_and_injections => return "Condoms, strings and other contraceptives, (excluding tablets and injections)";
             when other_citrus => return "Other citrus";
             when bacon => return "Bacon";
             when hobbies => return "Hobbies";
             when beef_extract_cubes => return "Beef extract cubes";
             when teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_income => return "Teachers training and technical colleges, technikons boarding fees in public institutions : Grant Income";
             when dividends_of_unlisted_companies => return "Dividends of Unlisted Companies";
             when other_chocolates_specify => return "Other, chocolates specify";
             when universities_boarding_fees_in_private_institution_grant => return "Universities boarding fees in private institution : Grant";
             when other_umbrellas_pocket_knives_sunglasses_etc_including_repairs => return "Other (umbrellas, pocket : knives, sunglasses, etc) including repairs";
             when rental_landline => return "Rental landline";
             when subscription_to_pay_tv_channels => return "Subscription to pay TV channels";
             when cheese_curls => return "Cheese curls";
             when schools_boarding_fees_in_public_institutions_grant_income => return "Schools boarding fees in public institutions : Grant Income";
             when tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions_grant_income => return "Tertiary education Education not definable by level (excluding driving and music lessons, sport etc) in private institutions : Grant Income";
             when other_food_products_specify => return "Other food products specify";
             when firewood_fetched_value => return "Firewood Fetched (value)";
             when blankets_and_travelling_rugs => return "Blankets and travelling rugs";
             when new_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes => return "New motor cars, station wagons and mini : buses (excluding vehicles for business purposes)";
             when water => return "Water";
             when tennis_rackets_and_balls_fishing_rods_etc => return "Tennis rackets and balls, fishing rods etc";
             when boat_or_ship_while_on_holiday => return "Boat/ship while on holiday";
             when hotplates => return "Hotplates";
             when other_fresh_vegetables_specify => return "Other, fresh vegetables specify";
             when textbooks_for_private_institutions => return "Textbooks for private institutions";
             when pork_sausage => return "Pork sausage";
             when secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution_grant_income => return "Secondary education (includes out : of : school secondary education for adults and young people) in public institution : Grant - Income ";
             when dung_fetched_value => return "Dung Fetched (value)";
             when bus_including_school_bus_for_educational_purposes => return "Bus (including school bus) for educational purposes";
             when tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions_grant_income => return "Tertiary education Education not definable by level (excluding driving and music lessons, sport etc) in public institutions : Grant Income";
             when canned_soup => return "Canned soup";
             when sanitation => return "Sanitation";
             when other_salt_and_spices_specify_aromat => return "Other  salt and spices, specify (Aromat)";
             when pears => return "Pears";
             when missing => return "Null or Missing";
         end case;
         return "?";
    end Pretty_Print;


     function Pretty_Print( i : Coicop ) return String is
    begin
         case i is
             when Income_coi => return "Income";
             when Loss_coi => return "Loss";
             when Taxes_coi => return "taxes";
             when In_kind_consumption_coi => return "In kind Consumption";
             when Other_products_not_consumption_coi => return "Other Products not Consumption";
             when Savings_coi => return "savings";
             when Consumption_coi => return "Consumption";
             when In_kind_income_coi => return "In kind Income";
             when Transfers_to_others_coi => return "transfers to others";
             when Debts_coi => return "Debts";
             when missing => return "Null or Missing";
         end case;
         return "?";
    end Pretty_Print;


     function Pretty_Print( i : Main_Group ) return String is
    begin
         case i is
             when Taxes_main => return "Taxes";
             when Recreation_and_culture_main => return "Recreation and culture";
             when Loss_main => return "Loss";
             when Transfers_to_others_main => return "Transfers To Others";
             when Debts_main => return "Debts";
             when Savings_main => return "Savings";
             when Income_in_kind_main => return "Income In kind";
             when Food_and_non_alcoholic_beverages_main => return "Food and non : alcoholic beverages";
             when Not_cpi_consumption_main => return "Not Cpi Consumption";
             when In_kind_consumption_main => return "In kind Consumption";
             when Clothing_and_footwear_main => return "Clothing and footwear";
             when Communication_main => return "Communication";
             when Transport_main => return "Transport";
             when Miscellaneous_goods_and_services_main => return "Miscellaneous goods and services";
             when Alcoholic_beverages_tobacco_and_narcotics_main => return "Alcoholic beverages, tobacco and narcotics";
             when Education_main => return "Education";
             when Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main => return "Furnishings, househould equipment and routine maintenance of the house";
             when Housing_water_electricity_gas_and_other_fuels_main => return "Housing, water, electricity, gas and other fuels";
             when Income_main => return "Income";
             when Other_unclasified_expenses_main => return "Other unclasified Expenses";
             when Restaurants_and_hotels_main => return "Restaurants and hotels";
             when Health_main => return "Health";
             when missing => return "Null or Missing";
         end case;
         return "?";
    end Pretty_Print;


     function Pretty_Print( i : Secondary_Group ) return String is
    begin
         case i is
             when Electricity_gas_and_other_fuels_secondary => return "Electricity, gas and other fuels";
             when In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary => return "In kind Income from computer certification, Excursions, Other (including language classes, Pre : primary,Primary, Tertiary education and Vocational training Grants";
             when Other_income_secondary => return "Other Income";
             when Package_holidays_secondary => return "Package holidays";
             when Others_main_secondary => return "Others main";
             when Other_major_durables_for_recreation_and_culture_secondary => return "Other major durables for recreation and culture";
             when Other_products_not_consumption_secondary => return "Other Products not Consumption";
             when Taxes_amnesty_tax_secondary => return "Taxes : Amnesty tax";
             when Food_secondary => return "Food";
             when Secondary_education_secondary => return "secondary education";
             when In_kind_consumption_secondary => return "In kind Consumption";
             when Household_appliances_secondary => return "Household appliances";
             when Tertiary_education_secondary => return "Tertiary education";
             when Household_textiles_secondary => return "Household textiles";
             when Imputed_rentals_for_housing_secondary => return "Imputed rentals for housing";
             when Financial_services_nec_secondary => return "Financial services n.e.c";
             when Debts_bank_overdraft_secondary => return "Debts Bank overdraft";
             when Goods_and_services_for_routine_household_maintenance_secondary => return "Goods and services for routine household maintenance";
             when Income_from_individuals_secondary => return "Income from Individuals";
             when In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary => return "In kind Income from private use of company vehicle or  discounted fares for educational and non educational purposes";
             when Debts_loans_from_money_lenders_secondary => return "Debts Loans from money lenders";
             when Debts_motor_vehicle_loan_from_the_bank_secondary => return "Debts Motor vehicle loan from the bank";
             when Postal_services_secondary => return "Postal services";
             when Personal_care_secondary => return "Personal care";
             when Debts_bond_loan_from_the_bank_and_other_loans_secondary => return "Debts Bond loan from the bank and other loans";
             when Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary => return "Savings for Improvements, Services for improvements, Security structures, Building materials and Labour and material for improvements";
             when Newspapers_books_and_stationary_secondary => return "Newspapers, books and stationary";
             when Tobacco_secondary => return "Tobacco";
             when In_kind_income_from_free_water_secondary => return "In kind Income from free Water";
             when Debts_expenditure_incurred_in_obtaining_income_secondary => return "Debts Expenditure incurred in obtaining income";
             when Taxes_uif_secondary => return "Taxes : UIF";
             when Other_recreational_items_and_equipment_garden_and_pets_secondary => return "Other  recreational items and equipment, garden and pets";
             when In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary => return "In kind Income from textbooks Others,Library services and Stationery Grants";
             when Telephone_and_telefax_equipment_secondary => return "Telephone and telefax equipment";
             when Pre_primary_and_primary_education_secondary => return "Pre : primary and primary education";
             when Alcoholic_beverages_secondary => return "Alcoholic beverages";
             when Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary => return "Water supply and miscellaneous services relating to the dwelling";
             when Pensions_social_insuerance_family_allowances_secondary => return "Pensions, Social Insuerance, Family allowances";
             when Operational_values_of_other_modes_of_transport_secondary => return "Operational values of other modes of transport";
             when Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary => return "Panel : beating repairs Paid for by your insurance company or other party";
             when Transfers_to_others_secondary => return "Transfers to others";
             when Income_from_capital_secondary => return "Income from capital";
             when Imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary => return "Imputed rent on owned dwellingI 7% Per Year of Dwelling";
             when Purchase_of_vehicles_secondary => return "Purchase of vehicles";
             when Other_services_nec_secondary => return "Other services n.e.c";
             when Glassware_tableware_andhousehold_utensils_secondary => return "Glassware, tableware andhousehold utensils";
             when Debts_arreas_on_municipal_bills_secondary => return "Debts Arreas on municipal bills";
             when Actual_rentals_for_housing_secondary => return "Actual rentals for housing";
             when Telephone_and_telefax_services_secondary => return "Telephone and telefax services";
             when Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary => return "Savings from monthly capital  and other payments, Levy on timeshare,Capital payments,Cost of Other Dewlling and Purchase of timeshare";
             when Debts_other_bank_loans_secondary => return "Debts Other bank loans";
             when Taxes_site_paye_and_income_tax_secondary => return "Taxes : SITE, PAYE and income tax";
             when Operation_of_personal_transport_equipment_secondary => return "Operation of personal transport equipment";
             when Unclassified_food_items_secondary => return "Unclassified food items";
             when Education_not_definable_by_level_secondary => return "Education not definable by level";
             when Debts_retail_stores_secondary => return "Debts Retail stores";
             when Furniture_and_furnishings_carpets_and_other_floor_covering_secondary => return "Furniture and furnishings, carpets and other floor covering";
             when Debts_loans_from_friends_and_family_secondary => return "Debts Loans from friends and family";
             when Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary => return "Savings from contribution to pension, Repayment on loans and Employer contribution to pension";
             when Medical_products_appliances_and_equipment_secondary => return "Medical products, appliances and equipment";
             when Insurance_secondary => return "Insurance";
             when Hospital_services_secondary => return "Hospital services";
             when Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary => return "Savings from listed and Unlisted company shares,Unit trusts, Investment plans, Offshore and Other investments";
             when Savings_from_contributions_to_a_stokvel_secondary => return "Savings from contributions to a stokvel";
             when Maintenance_and_repair_of_the_dwelling_secondary => return "Maintenance and repair of the dwelling";
             when Non_alcoholic_beverages_secondary => return "Non : alcoholic beverages";
             when Personal_effects_secondary => return "Personal effects";
             when Debts_furniture_and_appliances_amount_oustanding_secondary => return "Debts  Furniture and appliances : amount oustanding";
             when Catering_services_secondary => return "Catering services";
             when In_kind_income_from_schools_and_other_edu_inst_grant_secondary => return "In kind Income from schools and other edu inst  : Grant";
             when Clothing_secondary => return "Clothing";
             when In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary => return "In kind Income from day care mothers, Medical aid contribution, Schools and Universities boarding fees";
             when Others_diary_secondary => return "Others diary";
             when In_kind_income_from_free_electricity_secondary => return "In kind Income from free Electricity";
             when Footwear_secondary => return "Footwear";
             when Tools_and_equipment_for_house_and_garden_secondary => return "Tools and equipment for house and garden";
             when Social_protection_secondary => return "Social protection";
             when Transport_services_secondary => return "Transport services";
             when Subsidy_on_payment_of_mortgage_secondary => return "Subsidy on payment of mortgage";
             when Interest_on_mortgage_bonds_secondary => return "Interest on mortgage bonds";
             when Savings_from_deposits_and_wthdrawals_secondary => return "Savings from deposits and Wthdrawals";
             when Income_from_work_secondary => return "Income from work";
             when Recreational_and_cultural_services_secondary => return "Recreational and cultural services";
             when Audio_visual_photographic_and_information_processing_equipment_secondary => return "Audio : visual, photographic and information processing equipment";
             when Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary => return "Savings from life and endownment policies and Life insurance covering mortgage debt";
             when Imputed_rentals_of_owner_occupiers_secondary => return "Imputed rentals of owner : occupiers";
             when Out_patient_services_secondary => return "Out : patient services";
             when Accommodation_services_secondary => return "Accommodation services";
             when Imputed_cost_for_home_production_secondary => return "Imputed Cost for home production";
             when In_kind_income_from_free_sanitation_secondary => return "In kind Income from free Sanitation";
             when missing => return "Null or Missing";
         end case;
         return "?";
    end Pretty_Print;


     function Pretty_Print( i : Tertiary_Group ) return String is
    begin
         case i is
             when Imputed_cost_for_home_production_tertiary => return "Imputed Cost for home production";
             when In_kind_income_from_stationery_private_grant_tertiary => return "In kind Income from Stationery private : Grant";
             when Other_insurance_tertiary => return "Other insurance";
             when Stationery_and_drawing_materials_tertiary => return "Stationery and drawing materials";
             when Subsidy_on_payment_of_mortgage_tertiary => return "Subsidy on payment of mortgage";
             when Debts_bond_loan_from_the_bank_tertiary => return "Debts Bond loan from the bank";
             when Taxes_paye_income_tax_tertiary => return "Taxes : PAYE : income tax";
             when Savings_from_building_materials_not_included_in_q813_tertiary => return "Savings from Building materials not included in Q813";
             when In_kind_income_from_textbooks_for_private_institutions_grant_tertiary => return "In kind Income from Textbooks for private institutions : Grant";
             when Debts_arreas_on_municipal_bills_tertiary => return "Debts Arreas on municipal bills";
             when In_kind_income_from_estimated_value_of_private_use_of_company_vehicle_tertiary => return "In kind Income from Estimated value of private use of company vehicle";
             when Income_interest_received_tertiary => return "Income Interest received";
             when Beverages_in_restaurants_cafes_canteens_and_the_likes_tertiary => return "Beverages in restaurants , cafes, canteens and the likes";
             when Taxes_site_income_tax_tertiary => return "Taxes : SITE : income tax";
             when Water_supply_tertiary => return "Water supply";
             when Other_medical_products_tertiary => return "Other medical products";
             when Beer_tertiary => return "Beer";
             when Savings_from_capital_payments_tertiary => return "Savings from Capital payments";
             when Savings_from_improvements_additions_and_alterations_tertiary => return "Savings from Improvements, additions and alterations";
             when In_kind_income_from_library_fees_fines_grant_tertiary => return "In kind Income from library fees fines  : Grant";
             when Medical_services_tertiary => return "Medical Services";
             when Domestics_services_and_household_arcticles_tertiary => return "Domestics services and household arcticles";
             when Income_from_salaries_and_wages_tertiary => return "Income from Salaries and wages";
             when Income_from_other_dividends_tertiary => return "Income from Other Dividends";
             when Food_products_nec_tertiary => return "Food products n.e.c.";
             when Milk_cheese_and_eggs_tertiary => return "Milk, cheese and eggs";
             when Hairdressing_salons_and_personal_grooming_astablishment_tertiary => return "Hairdressing salons and personal grooming astablishment";
             when Financial_services_nec_tertiary => return "Financial services n.e.c";
             when Savings_from_deposits_into_savings_tertiary => return "Savings from Deposits into savings";
             when Savings_from_other_payments_tertiary => return "Savings from Other payments";
             when In_kind_income_from_schools_and_other_edu_inst_publice_grant_tertiary => return "In kind Income from schools and other edu inst  Publice  : Grant";
             when Information_processing_equipment_tertiary => return "Information processing equipment";
             when Meals_in_restaurants_cafes_canteens_and_the_likes_tertiary => return "Meals in restaurants , cafes, canteens and the likes";
             when Accommodation_services_tertiary => return "Accommodation services";
             when Recreational_and_sporting_services_tertiary => return "Recreational and sporting services";
             when Scondary_education_tertiary => return "Scondary education";
             when Debts_motor_vehicle_loan_from_the_bank_tertiary => return "Debts Motor vehicle loan from the bank";
             when In_kind_income_from_other_specify_public_grant_tertiary => return "In kind Income from Other, specify  public :  Grant";
             when In_kind_income_from_other_specify_private_grant_tertiary => return "In kind Income from Other, specify  private :  Grant";
             when Insurance_connected_with_the_transport_tertiary => return "Insurance connected with the transport";
             when Postal_services_tertiary => return "Postal services";
             when Jewellery_clocks_and_watches_tertiary => return "Jewellery, clocks and watches";
             when Interest_on_mortgage_bonds_tertiary => return "Interest on mortgage bonds";
             when Savings_from_unit_trusts_tertiary => return "Savings from Unit trusts";
             when Meat_tertiary => return "Meat";
             when Paramedic_services_tertiary => return "Paramedic services";
             when Savings_from_offshore_tertiary => return "Savings from Offshore";
             when Savings_from_life_insurance_covering_mortgage_debt_tertiary => return "Savings from Life insurance covering mortgage debt";
             when Income_from_pension_from_previous_employment_tertiary => return "Income from Pension from previous employment";
             when Veterinary_and_other_services_tertiary => return "Veterinary and other services";
             when Savings_from_life_and_endownment_policies_tertiary => return "Savings from Life and endownment policies";
             when Major_household_appliances_wheter_or_no_aelectriccal_tertiary => return "Major household appliances wheter or no aelectriccal";
             when Vegetables_tertiary => return "Vegetables";
             when Bread_and_cereals_tertiary => return "Bread and cerels";
             when Savings_from_security_structures_tertiary => return "Savings from Security structures";
             when In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_tertiary => return "In kind Income from Teachers training and technical colleges, technikons boarding fees in public institutions : Grant";
             when Telephone_and_telefax_services_tertiary => return "Telephone and telefax services";
             when Repair_of_household_appliance_tertiary => return "Repair of household appliance";
             when Repair_and_hire_of_foowear_tertiary => return "Repair and hire of foowear";
             when Savings_from_wthdrawals_from_savings_tertiary => return "Savings from Wthdrawals from savings";
             when Savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary => return "Savings from Contribution to pension, provident and annuity funds and Employer contribution";
             when In_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public_tertiary => return "In kind Income from Schools boarding fees in public institutions : Grant  : public";
             when In_kind_income_from_textbooks_for_public_institutions_grant_tertiary => return "In kind Income from Textbooks for public institutions : Grant";
             when In_kind_income_from_value_of_discounted_fares_for_educational_purposes_tertiary => return "In kind Income from Value of discounted fares for educational purposes";
             when Therapeutic_appliances_and_equipment_tertiary => return "Therapeutic appliances and equipment";
             when Electricity_tertiary => return "Electricity";
             when Spirits_tertiary => return "Spirits";
             when Oils_and_fats_tertiary => return "Oils and fats";
             when Savings_from_contributions_to_a_stokvel_tertiary => return "Savings from Contributions to a stokvel";
             when Savings_from_repayment_on_loans_and_overdrafts_tertiary => return "Savings from Repayment on loans and overdrafts";
             when In_kind_income_from_universities_boarding_fees_in_private_institution_grant_tertiary => return "In kind Income from Universities boarding fees in private institution : Grant";
             when Small_tools_and_miscellaneous_accessories_tertiary => return "Small tools and miscellaneous accessories";
             when Spare_parts_and_accessories_tertiary => return "Spare parts and accessories";
             when Pharmaceutical_products_tertiary => return "Pharmaceutical products";
             when Debts_retail_stores_tertiary => return "Debts Retail stores";
             when In_kind_income_from_stationery_public_grant_tertiary => return "In kind Income from Stationery public : Grant";
             when In_kind_income_from_library_services_grant_tertiary => return "In kind Income from Library services : Grant";
             when Income_from_annuities_from_own_investment_tertiary => return "Income from Annuities from own investment";
             when Passenger_transport_by_air_tertiary => return "Passenger transport by air";
             when Savings_from_purchase_and_levy_of_timeshare_tertiary => return "Savings from Purchase  and Levy  of timeshare";
             when Savings_from_labour_and_material_for_improvements_additions_and_alterations_tertiary => return "Savings from Labour and material for improvements, additions and alterations";
             when In_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private_tertiary => return "In kind Income from computer certification ,Excursions and  Other Grants Public and Private";
             when Maintenance_and_repairs_of_personal_transport_equipment_tertiary => return "Maintenance and repairs of personal transport equipment";
             when Hospital_services_tertiary => return "Hospital services";
             when Other_personal_effects_tertiary => return "Other personal effects";
             when Passenger_transport_by_sea_and_inland_waterway_tertiary => return "Passenger transport by sea and inland waterway";
             when Actual_rentals_paid_by_tenants_tertiary => return "Actual rentals paid by tenants";
             when In_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant_tertiary => return "In kind Income from Universities boarding fees in private institution  and Medical aidby employer :  Grant";
             when Motor_cycles_tertiary => return "Motor : cycles";
             when Furniture_and_furnishings_tertiary => return "Furniture and furnishings";
             when Equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures_tertiary => return "Equipment for the reception, recording and reproduction of sound and pictures";
             when Sewarage_collection_tertiary => return "Sewarage collection";
             when Tertiary_education_tertiary => return "Tertiary education";
             when Materials_for_maintenance_and_repair_of_the_dwelling_tertiary => return "Materials for maintenance and repair of the dwelling";
             when Other_services_in_respect_of_personal_transport_equipment_tertiary => return "Other services in respect of personal transport equipment";
             when Insurance_connected_with_the_health_tertiary => return "Insurance connected with the health";
             when Water_and_electricity_tertiary => return "Water and Electricity";
             when Other_puchased_transport_services_tertiary => return "Other puchased transport services";
             when Carpets_and_other_floor_covering_tertiary => return "Carpets and other floor covering";
             when Photographic_and_cinematographic_equipment_and_optical_instruments_tertiary => return "Photographic and cinematographic equipment and optical instruments";
             when Gardens_plants_and_flowers_tertiary => return "Gardens, plants and flowers";
             when Savings_from_services_for_improvements_additions_and_alterations_tertiary => return "Savings from Services for improvements, additions and alterations(";
             when Unclassified_food_items_tertiary => return "Unclassified food items";
             when Equipment_for_sport_camping_and_open_air_recreation_tertiary => return "Equipment for sport, camping and open : air recreation";
             when Non_durable_household_goods_tertiary => return "Non : durable household goods";
             when Debts_furniture_and_appliances_amount_oustanding_tertiary => return "Debts Furniture and appliances : amount oustanding";
             when Gas_tertiary => return "Gas";
             when Glassware_tableware_and_household_utensils_tertiary => return "Gkassware,tableware and household utensils";
             when Small_electrical_household_appliance_tertiary => return "Small electrical household appliance";
             when Consumption_others_expenditures_tertiary => return "Consumption Others expenditures";
             when Taxes_according_to_assessment_income_tax_tertiary => return "Taxes : According to assessment : income tax";
             when In_kind_income_from_schools_and_other_edu_inst_privat_grant_tertiary => return "In kind Income from schools and other edu inst  Privat  : Grant";
             when Other_income_tertiary => return "Other Income";
             when In_kind_consumption_tertiary => return "In kind Consumption";
             when Newspaper_and_periodicals_tertiary => return "Newspaper and periodicals";
             when Garments_tertiary => return "Garments";
             when Debts_other_loans_tertiary => return "Debts Other loans";
             when Savings_from_unlisted_company_shares_tertiary => return "Savings from Unlisted company : shares";
             when In_kind_income_from_value_of_discounted_fares_for_non_educational_purposes_tertiary => return "In kind Income from Value of discounted fares for non educational purposes";
             when Income_from_property_tertiary => return "Income from property";
             when Major_durables_for_outdoor_recreation_tertiary => return "Major durables for outdoor recreation";
             when Bicycles_tertiary => return "Bicycles";
             when Taxes_unemployment_insurance_fund_uif_tertiary => return "Taxes  : Unemployment insurance fund (UIF)";
             when Fuels_and_lubricants_tertiary => return "Fuels and lubricants";
             when Cultural_services_tertiary => return "Cultural services";
             when Mineral_waters_soft_drinks_fruit_and_vegetable_juices_tertiary => return "Mineral waters, soft drinks, fruit and vegetable juices";
             when Consumption_unclassified_diary_items_tertiary => return "Consumption Unclassified Diary Items";
             when Taxes_amnesty_tax_tertiary => return "Taxes : Amnesty tax";
             when In_kind_income_from_free_sanitation_tertiary => return "In kind Income from free Sanitation";
             when Income_from_royalties_tertiary => return "Income from Royalties";
             when Household_textile_tertiary => return "Household textile";
             when Other_appliances_articles_and_products_for_personal_care_tertiary => return "Other appliances, articles and products for personal care";
             when Telephone_and_telefax_equipment_tertiary => return "Telephone and telefax equipment";
             when Social_protection_services_tertiary => return "Social protection services";
             when Savings_from_cost_of_other_dewlling_tertiary => return "Savings from Cost of Other Dewlling";
             when Income_from_self_employment_and_business_tertiary => return "Income from Self : employment and business";
             when Fruits_tertiary => return "Fruits";
             when Coffee_tea_and_cocoa_tertiary => return "Coffee, tea and cocoa";
             when Cost_for_other_modes_of_transport_tertiary => return "cost for other modes of transport";
             when Animal_drawn_vehicle_tertiary => return "Animal drawn vehicle";
             when Solid_fuels_tertiary => return "Solid fuels";
             when Games_toys_and_hobbies_tertiary => return "Games, toys and hobbies";
             when Pre_primary_and_primary_education_tertiary => return "Pre : primary and primary education";
             when Tobacco_tertiary => return "Tobacco";
             when Clothing_materials_tertiary => return "Clothing materials";
             when Debts_bank_overdraft_tertiary => return "Debts Bank overdraft";
             when Savings_from_monthly_capital_payments_tertiary => return "Savings from Monthly capital payments";
             when Motor_cars_tertiary => return "Motor : cars";
             when Elecrtical_appliances_for_personal_care_tertiary => return "Elecrtical appliances for personal care";
             when Shoes_and_other_footwear_tertiary => return "Shoes and other footwear";
             when Dental_services_tertiary => return "Dental Services";
             when Pets_and_related_products_tertiary => return "Pets and related products";
             when Savings_from_investment_plans_tertiary => return "Savings from Investment plans";
             when In_kind_income_from_universities_boarding_fees_in_public_institution_grant_tertiary => return "In kind Income from Universities boarding fees in public institution : Grant";
             when Income_from_alimony_palimony_and_other_allowances_tertiary => return "Income from Alimony, palimony and other allowances";
             when Income_from_social_pensions_tertiary => return "Income from Social pensions";
             when Imputed_rentals_of_owner_occupiers_tertiary => return "Imputed rentals of owner : occupiers";
             when Other_articles_of_clothing_and_clothing_accessories_tertiary => return "Other articles of clothing and clothing accessories";
             when Cleaning_repair_and_hire_of_clothing_tertiary => return "Cleaning, repair and hire of clothing";
             when Liquid_fuels_tertiary => return "Liquid fuels";
             when Miscellaneous_printed_matter_tertiary => return "Miscellaneous printed matter";
             when Major_tools_and_equipment_tertiary => return "Major tools and equipment";
             when Savings_from_other_investments_tertiary => return "Savings from Other investments";
             when In_kind_income_from_free_water_tertiary => return "In kind Income from free Water";
             when Income_from_dividends_tertiary => return "Income from Dividends";
             when Passenger_transport_by_railway_tertiary => return "Passenger transport by railway";
             when Games_of_chances_tertiary => return "Games of chances";
             when Sugar_jam_honey_chocolate_and_confectionery_tertiary => return "Sugar, jam, honey, chocolate and confectionery";
             when Debts_other_bank_loans_tertiary => return "Debts Other bank loans";
             when Savings_from_listed_company_shares_tertiary => return "Savings from Listed company : shares";
             when In_kind_income_from_free_electricity_tertiary => return "In kind Income from free Electricity";
             when Recording_meedia_tertiary => return "Recording meedia";
             when Maintenance_and_repair_of_other_major_durables_for_recreation_and_culture_tertiary => return "Maintenance and repair of other major durables for recreation and culture";
             when Other_products_not_consumption_tertiary => return "Other Products not Consumption";
             when Debts_loans_from_money_lenders_tertiary => return "Debts Loans from money lenders";
             when Other_services_tertiary => return "Other services";
             when Refuse_collection_tertiary => return "Refuse collection";
             when Other_services_relating_to_the_dwelling_tertiary => return "Other services relating to the dwelling";
             when Education_not_definable_by_level_tertiary => return "Education not definable by level";
             when Insurance_connected_with_the_dwelling_tertiary => return "Insurance connected with the dwelling";
             when Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_tertiary => return "Panel : beating repairs Paid for by your insurance company or other party";
             when Loss_expenditure_incurred_in_obtaining_income_tertiary => return "Loss Expenditure incurred in obtaining income";
             when Transfer_toothers_tertiary => return "Transfer ToOthers";
             when Income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_tertiary => return "Income from imputed rent on owned dwellingI 7% Per Year of Dwelling";
             when Passenger_transport_by_road_tertiary => return "Passenger transport by road";
             when Service_of_the_maintenance_and_repair_of_the_dwelling_tertiary => return "Service of the maintenance and repair of the dwelling";
             when Wine_tertiary => return "Wine";
             when Debts_loans_from_friends_and_family_tertiary => return "Debts Loans from friends and family";
             when In_kind_income_from_pre_primary_primary_tertiary_education_and_vocational_training_grants_public_and_private_tertiary => return "In kind Income from Pre : primary,Primary, Tertiary education and Vocational training Grants Public and Private";
             when In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_tertiary => return "In kind Income from Teachers training and technical colleges, technikons boarding fees in private institutions : Grant";
             when In_kind_income_from_schools_boarding_fees_in_private_institutions_grant_tertiary => return "In kind Income from Schools boarding fees in private institutions : Grant";
             when Other_income_from_individuals_tertiary => return "Other Income from Individuals";
             when Package_holidays_tertiary => return "Package holidays";
             when Fish_tertiary => return "Fish";
             when Books_tertiary => return "Books";
             when Musical_instrument_and_major_durables_for_outdoor_recreation_tertiary => return "Musical instrument and major durables for outdoor recreation";
             when Repair_of_furniture_furnishings_and_floor_covering_tertiary => return "Repair of furniture, furnishings and floor covering";
             when missing => return "Null or Missing";
         end case;
         return "?";
    end Pretty_Print;


    function Convert_Coicop_Type( i : String ) return Coicop_Type is
    begin
            if( i = "01111101" ) then  return rice; 
            elsif( i = "01112101" ) then  return white_bread;
            elsif( i = "01112102" ) then  return brown_bread; 
            elsif( i = "01112103" ) then  return garlic_bread;
            elsif( i = "01112104" ) then  return whole_wheat_bread;
            elsif( i = "01112105" ) then  return other_bread_loaves;
            elsif( i = "01112201" ) then  return bread_rolls;
            elsif( i = "01112301" ) then  return rusks;
            elsif( i = "01112302" ) then  return marie_biscuits;
            elsif( i = "01112303" ) then  return other_biscuits;
            elsif( i = "01112304" ) then  return crackers;
            elsif( i = "01112305" ) then  return other_baked_products;
            elsif( i = "01113101" ) then  return spaghetti;
            elsif( i = "01113102" ) then  return macaroni;
            elsif( i = "01113103" ) then  return other_pasta;
            elsif( i = "01114101" ) then  return cakes;
            elsif( i = "01114102" ) then  return tarts;
            elsif( i = "01114103" ) then  return other_vetkoek_fat_cakes;
            elsif( i = "01115101" ) then  return sandwiches;
            elsif( i = "01116101" ) then  return mealie_meal_or_maize_flour;
            elsif( i = "01116102" ) then  return cake_flour;
            elsif( i = "01116103" ) then  return self_raising_meal;
            elsif( i = "01116104" ) then  return bread_flour;
            elsif( i = "01116105" ) then  return sorghum_meal_or_powder;
            elsif( i = "01116106" ) then  return corn_flour;
            elsif( i = "01116107" ) then  return other_meal_and_flour;
            elsif( i = "01116201" ) then  return taystee_wheat;
            elsif( i = "01116202" ) then  return mabella;
            elsif( i = "01116301" ) then  return corn_flakes;
            elsif( i = "01116302" ) then  return puffed_rice;
            elsif( i = "01116303" ) then  return muesli;
            elsif( i = "01116304" ) then  return other_baked_cereals;
            elsif( i = "01116401" ) then  return mealie_rice;
            elsif( i = "01116402" ) then  return samp;
            elsif( i = "01116501" ) then  return other_grain_products_pies_except_meat_pies_and_fruit_pies;
            elsif( i = "66111101" ) then  return maize;
            elsif( i = "66111201" ) then  return wheat;
            elsif( i = "66111301" ) then  return other_grains;
            elsif( i = "01121000" ) then  return beef_and_veal_incl_heads_and_feet;
            elsif( i = "01122000" ) then  return pork_incl_heads_and_feet;
            elsif( i = "01123000" ) then  return mutton_incl_heads_and_feet;
            elsif( i = "01123200" ) then  return lamb_incl_heads_and_feet;
            elsif( i = "01123300" ) then  return goat_incl_heads_and_feet;
            elsif( i = "01124100" ) then  return poultry_incl_heads_and_feet;
            elsif( i = "01125101" ) then  return boerewors;
            elsif( i = "01125102" ) then  return pork_sausage;
            elsif( i = "01125103" ) then  return beef_sausage;
            elsif( i = "01125104" ) then  return other_sausages_chicken_game_etc;
            elsif( i = "01125201" ) then  return viennas;
            elsif( i = "01125202" ) then  return polony;
            elsif( i = "01125203" ) then  return ham;
            elsif( i = "01125204" ) then  return bacon;
            elsif( i = "01125205" ) then  return other_processed_meat_russians;
            elsif( i = "01125301" ) then  return biltong;
            elsif( i = "01125302" ) then  return dried_sausages;
            elsif( i = "01125303" ) then  return mopane_worms;
            elsif( i = "01126101" ) then  return pre_cooked_frozen_meat;
            elsif( i = "01126102" ) then  return meat_spread_marmite;
            elsif( i = "01126401" ) then  return beef_extract_cubes;
            elsif( i = "01126402" ) then  return chicken_extract_cubes;
            elsif( i = "01126501" ) then  return other_meat_and_meat_products_including_meat_pies;
            elsif( i = "01126601" ) then  return meat_patties;
            elsif( i = "01127100" ) then  return other_meat_incl_heads_and_feet;
            elsif( i = "66211101" ) then  return cattle;
            elsif( i = "66211201" ) then  return sheep;
            elsif( i = "66211301" ) then  return pigs;
            elsif( i = "66211401" ) then  return goats;
            elsif( i = "66211501" ) then  return poultry;
            elsif( i = "01131100" ) then  return fresh_or_chilled_fish;
            elsif( i = "01131200" ) then  return frozen_fish;
            elsif( i = "01132100" ) then  return fresh_or_chilled_seafood;
            elsif( i = "01132201" ) then  return frozen_shrimps;
            elsif( i = "01132202" ) then  return frozen_lobster;
            elsif( i = "01132203" ) then  return frozen_mixed_seafood;
            elsif( i = "01133101" ) then  return dried_fish;
            elsif( i = "01133201" ) then  return smoked_fish;
            elsif( i = "01134101" ) then  return fish_cakes;
            elsif( i = "01134102" ) then  return fish_fingers;
            elsif( i = "01134103" ) then  return fish_portions;
            elsif( i = "01134201" ) then  return fish_paste;
            elsif( i = "01134301" ) then  return canned_tuna;
            elsif( i = "01134302" ) then  return canned_pilchards;
            elsif( i = "01134303" ) then  return other_canned_fish;
            elsif( i = "01134400" ) then  return other_preserved_or_processed_fish_and_seafood;
            elsif( i = "01141101" ) then  return fresh_full_cream_milk;
            elsif( i = "01141201" ) then  return longlife_full_cream_milk;
            elsif( i = "01142101" ) then  return fresh_low_fat_milk;
            elsif( i = "01142201" ) then  return longlife_low_fat_milk;
            elsif( i = "01143101" ) then  return condensed_milk;
            elsif( i = "01143201" ) then  return evaporated_milk;
            elsif( i = "01143301" ) then  return powdered_milk;
            elsif( i = "01143401" ) then  return whiteners_cremora_ellis_brown;
            elsif( i = "01144101" ) then  return plain_yogurt;
            elsif( i = "01144201" ) then  return flavoured_yogurt;
            elsif( i = "01145101" ) then  return cheddar_cheese;
            elsif( i = "01145201" ) then  return gouda_cheese;
            elsif( i = "01145301" ) then  return white_cheese;
            elsif( i = "01145401" ) then  return cottage_cheese;
            elsif( i = "01145501" ) then  return cheese_spread;
            elsif( i = "01145601" ) then  return other_cheese_specify;
            elsif( i = "01146101" ) then  return fresh_cream;
            elsif( i = "01146201" ) then  return butter_milk;
            elsif( i = "01146301" ) then  return sour_milk_or_maas;
            elsif( i = "01146401" ) then  return soya_milk;
            elsif( i = "01146501" ) then  return prepared_custard_eg_ultramel;
            elsif( i = "01146601" ) then  return amageu;
            elsif( i = "01146701" ) then  return other_milk_products;
            elsif( i = "01147101" ) then  return jumbo_eggs;
            elsif( i = "01147201" ) then  return extra_large_eggs;
            elsif( i = "01147301" ) then  return large_eggs;
            elsif( i = "01147401" ) then  return medium_eggs;
            elsif( i = "66111401" ) then  return milk;
            elsif( i = "66111501" ) then  return eggs;
            elsif( i = "01151101" ) then  return butter;
            elsif( i = "01152101" ) then  return medium_fat_margarine_spread;
            elsif( i = "01152102" ) then  return low_fat_margarine_spread;
            elsif( i = "01152103" ) then  return yellow_brick_margarine;
            elsif( i = "01152201" ) then  return peanut_butter;
            elsif( i = "01152301" ) then  return cooking_fat_vegetable_eg_holsum;
            elsif( i = "01153100" ) then  return olive_oils;
            elsif( i = "01154101" ) then  return edible_oils_eg_cooking_oils;
            elsif( i = "01155101" ) then  return other_edible_animal_fats_eg_lard;
            elsif( i = "66111601" ) then  return fruit;
            elsif( i = "01161101" ) then  return oranges;
            elsif( i = "01161201" ) then  return naartjies;
            elsif( i = "01161301" ) then  return grapefruit;
            elsif( i = "01161401" ) then  return lemons;
            elsif( i = "01161501" ) then  return other_citrus;
            elsif( i = "01162101" ) then  return bananas;
            elsif( i = "01163101" ) then  return apples;
            elsif( i = "01164101" ) then  return pears;
            elsif( i = "01165101" ) then  return apricots;
            elsif( i = "01165201" ) then  return peaches;
            elsif( i = "01165301" ) then  return plums;
            elsif( i = "01165401" ) then  return avocados;
            elsif( i = "01165501" ) then  return cherries;
            elsif( i = "01165601" ) then  return other_stone_fruit;
            elsif( i = "01166101" ) then  return grapes;
            elsif( i = "01166201" ) then  return strawberries;
            elsif( i = "01166301" ) then  return other_specify_berries;
            elsif( i = "01167101" ) then  return paw_paw;
            elsif( i = "01167201" ) then  return pineapple;
            elsif( i = "01167301" ) then  return mango;
            elsif( i = "01167401" ) then  return guava;
            elsif( i = "01167501" ) then  return watermelon;
            elsif( i = "01167601" ) then  return melon;
            elsif( i = "01167701" ) then  return other_specify_tropical_fruit;
            elsif( i = "01168101" ) then  return peaches_dried;
            elsif( i = "01168102" ) then  return prunes_dried;
            elsif( i = "01168103" ) then  return raisins;
            elsif( i = "01168104" ) then  return dates;
            elsif( i = "01168105" ) then  return other_dried_fruit;
            elsif( i = "01168106" ) then  return assorted_dried_fruit;
            elsif( i = "01168201" ) then  return coconut;
            elsif( i = "01168202" ) then  return almonds;
            elsif( i = "01168203" ) then  return pecan_nuts;
            elsif( i = "01168204" ) then  return walnuts;
            elsif( i = "01168205" ) then  return peanuts;
            elsif( i = "01168206" ) then  return other_nuts_specify;
            elsif( i = "01169101" ) then  return canned_pears;
            elsif( i = "01169102" ) then  return canned_peaches;
            elsif( i = "01169103" ) then  return canned_guavas;
            elsif( i = "01169104" ) then  return canned_fruit_cocktail;
            elsif( i = "01169105" ) then  return canned_granadilla_pulp;
            elsif( i = "01169106" ) then  return other_specify_lemon_juice;
            elsif( i = "66111701" ) then  return vegetables;
            elsif( i = "01171101" ) then  return lettuce;
            elsif( i = "01171102" ) then  return spinach_or_morogo_fresh;
            elsif( i = "01172101" ) then  return cabbage_fresh;
            elsif( i = "01172102" ) then  return cauliflower_fresh;
            elsif( i = "01172103" ) then  return broccoli_fresh;
            elsif( i = "01172201" ) then  return cauliflower_frozen;
            elsif( i = "01173101" ) then  return green_mealies_fresh;
            elsif( i = "01173102" ) then  return tomatoes_fresh;
            elsif( i = "01173103" ) then  return green_beans_fresh;
            elsif( i = "01173104" ) then  return pumpkin_butternut_fresh;
            elsif( i = "01173105" ) then  return marrow_fresh;
            elsif( i = "01173106" ) then  return gem_squashes_fresh;
            elsif( i = "01173107" ) then  return green_or_red_or_yellow_pepper_fresh;
            elsif( i = "01173108" ) then  return chillies_fresh;
            elsif( i = "01173109" ) then  return cucumber_fresh;
            elsif( i = "01173188" ) then  return mixed_vegetables_fresh;
            elsif( i = "01173191" ) then  return other_fresh_vegetables_specify;
            elsif( i = "01173201" ) then  return corn_kernels_frozen;
            elsif( i = "01173203" ) then  return green_beans_frozen;
            elsif( i = "01173204" ) then  return pumpkin_frozen;
            elsif( i = "01173210" ) then  return peas_frozen;
            elsif( i = "01173288" ) then  return mixed_vegetables_frozen;
            elsif( i = "01173299" ) then  return other_frozen_vegetables;
            elsif( i = "01174101" ) then  return onions;
            elsif( i = "01174102" ) then  return carrots_fresh;
            elsif( i = "01174103" ) then  return beetroot;
            elsif( i = "01174104" ) then  return mushrooms;
            elsif( i = "01174202" ) then  return carrots_frozen;
            elsif( i = "01175101" ) then  return peas_dried;
            elsif( i = "01175201" ) then  return beans_dried;
            elsif( i = "01175301" ) then  return lentils_dried;
            elsif( i = "01175401" ) then  return other_dried_vegetables_specify;
            elsif( i = "01176101" ) then  return corn_kernels_canned;
            elsif( i = "01176102" ) then  return sweet_corn_cream_style;
            elsif( i = "01176103" ) then  return baked_beans_in_tomato_sauce;
            elsif( i = "01176104" ) then  return peas_tinned;
            elsif( i = "01176105" ) then  return butter_beans;
            elsif( i = "01176106" ) then  return green_beans_canned;
            elsif( i = "01176107" ) then  return other_canned_vegetables;
            elsif( i = "01176108" ) then  return pickles;
            elsif( i = "01176109" ) then  return atchaar;
            elsif( i = "01176110" ) then  return vegetable_spread_bovril_fray_bentos;
            elsif( i = "01176201" ) then  return prepared_salads;
            elsif( i = "01177101" ) then  return potatoes;
            elsif( i = "01178101" ) then  return potato_chips_frozen;
            elsif( i = "01178201" ) then  return sweet_potatoes;
            elsif( i = "01178301" ) then  return potato_crisps;
            elsif( i = "01178302" ) then  return cheese_curls;
            elsif( i = "01178303" ) then  return corn_chips;
            elsif( i = "01178304" ) then  return pop_corn_kernels;
            elsif( i = "01178305" ) then  return prepared_pop_corn;
            elsif( i = "01178307" ) then  return other_vegetable_products_specify;
            elsif( i = "01181101" ) then  return white_sugar;
            elsif( i = "01181102" ) then  return brown_sugar;
            elsif( i = "01181103" ) then  return icing_sugar;
            elsif( i = "01181104" ) then  return castor_sugar;
            elsif( i = "01181201" ) then  return artificial_sweeteners;
            elsif( i = "01181301" ) then  return other_sugar_specify;
            elsif( i = "01182101" ) then  return honey;
            elsif( i = "01182201" ) then  return smooth_apricot_jam;
            elsif( i = "01182202" ) then  return smooth_peach_jam;
            elsif( i = "01182203" ) then  return melon_and_ginger_jam;
            elsif( i = "01182204" ) then  return other_jam_including_strawberry;
            elsif( i = "01182205" ) then  return preserves_specify;
            elsif( i = "01182206" ) then  return marmalade;
            elsif( i = "01183101" ) then  return milk_plain_slabs;
            elsif( i = "01183102" ) then  return milk_whole_nut_slabs;
            elsif( i = "01183201" ) then  return bar_with_filling;
            elsif( i = "01183301" ) then  return other_chocolates_specify;
            elsif( i = "01184101" ) then  return toffees;
            elsif( i = "01184201" ) then  return glucose_sweets;
            elsif( i = "01184301" ) then  return health_bars;
            elsif( i = "01184401" ) then  return other_sweets;
            elsif( i = "01185101" ) then  return full_cream_ice_cream;
            elsif( i = "01185102" ) then  return sorbet;
            elsif( i = "01185103" ) then  return frozen_yogurt;
            elsif( i = "01185104" ) then  return ice_cubes;
            elsif( i = "01185105" ) then  return other_edible_ices_and_ice_cream_specify;
            elsif( i = "01186101" ) then  return jelly_powder;
            elsif( i = "01186201" ) then  return golden_syrup;
            elsif( i = "01186301" ) then  return other_sugar_products;
            elsif( i = "01191101" ) then  return vinegar;
            elsif( i = "01191201" ) then  return chutney;
            elsif( i = "01191301" ) then  return mustard;
            elsif( i = "01191401" ) then  return tomato_sauce;
            elsif( i = "01191501" ) then  return mayonnaise;
            elsif( i = "01191601" ) then  return salad_dressing;
            elsif( i = "01191701" ) then  return other_sauces_and_condiments_specify;
            elsif( i = "01192101" ) then  return salt;
            elsif( i = "01192201" ) then  return fine_white_pepper;
            elsif( i = "01192202" ) then  return pepper_black_corns_and_fine_black_pepper;
            elsif( i = "01192203" ) then  return curry_powder;
            elsif( i = "01192301" ) then  return chicken_spice;
            elsif( i = "01192302" ) then  return steak_and_chops_spice;
            elsif( i = "01192304" ) then  return chili_powder;
            elsif( i = "01192305" ) then  return cinnamon;
            elsif( i = "01192401" ) then  return cloves;
            elsif( i = "01192501" ) then  return other_salt_and_spices_specify_aromat;
            elsif( i = "01193101" ) then  return baby_food_predominantly_grain;
            elsif( i = "01193102" ) then  return baby_food_predominantly_meat;
            elsif( i = "01193103" ) then  return baby_food_predominantly_vegetables;
            elsif( i = "01193104" ) then  return baby_food_predominantly_fruit;
            elsif( i = "01193105" ) then  return baby_food_predominantly_milk;
            elsif( i = "01193201" ) then  return canned_soup;
            elsif( i = "01193202" ) then  return powder_soup;
            elsif( i = "01193301" ) then  return custard_powder;
            elsif( i = "01193302" ) then  return instant_yeast;
            elsif( i = "01193303" ) then  return baking_powder;
            elsif( i = "01193304" ) then  return bicarbonate_of_soda;
            elsif( i = "01193305" ) then  return other_food_products_specify;
            elsif( i = "01193306" ) then  return instant_pudding_powder;
            elsif( i = "01194101" ) then  return soya_product_excluding_soy_milk;
            elsif( i = "01195000" ) then  return food_hampers;
            elsif( i = "66111801" ) then  return other_produce_specify;
            elsif( i = "66211601" ) then  return other_livestock_from_own_production;
            elsif( i = "01211101" ) then  return instant_coffee;
            elsif( i = "01211201" ) then  return ground_coffee;
            elsif( i = "01211301" ) then  return coffee_beans;
            elsif( i = "01212101" ) then  return tee_leaves;
            elsif( i = "01212102" ) then  return tagged_tea_bags;
            elsif( i = "01212103" ) then  return tag_less_tea_bags;
            elsif( i = "01212201" ) then  return rooibos_tea_leaves;
            elsif( i = "01212202" ) then  return rooibos_tea_bags;
            elsif( i = "01212300" ) then  return herbal_tea_not_from_food_service_place;
            elsif( i = "01212401" ) then  return other_tea_specify;
            elsif( i = "01213101" ) then  return cocoa_powder;
            elsif( i = "01213201" ) then  return powdered_chocolate;
            elsif( i = "01213301" ) then  return other_hot_drinks;
            elsif( i = "01221100" ) then  return mineral_water_or_spring_water_aerated_and_still;
            elsif( i = "01222101" ) then  return aerated_cold_drinks;
            elsif( i = "01222102" ) then  return other_eg_energade_lucozade_ice_tea_etc;
            elsif( i = "01223101" ) then  return fruit_juices_not_from_food_service_places;
            elsif( i = "01223102" ) then  return concentrates_and_drink_powders;
            elsif( i = "01224101" ) then  return vegetable_juices_not_from_food_service_places;
            elsif( i = "01225101" ) then  return fruit_and_vegetable_juices_combined_not_from_food_service_places;
            elsif( i = "01999999" ) then  return unclassified_expenditures_on_food;
            elsif( i = "02111100" ) then  return spirits_such_as_brandy_whisky_gin_liqueurs;
            elsif( i = "02121100" ) then  return table_wines_including_sparkling_wine_not_from_food_service_places;
            elsif( i = "02121201" ) then  return cooking_wines_not_from_food_service_places;
            elsif( i = "02121300" ) then  return fortified_wines_sherry_port_etc_not_from_food_service_places;
            elsif( i = "02122100" ) then  return spirit_coolers_cider_hooch_etc_not_from_a_food_service_place;
            elsif( i = "02122200" ) then  return other_eg_mampoer_home_brewed_not_from_food_service_place;
            elsif( i = "02131100" ) then  return clear_beer_not_purchased_from_a_food_service_place;
            elsif( i = "02131201" ) then  return sorghum_beer_pre_packed_not_from_a_food_service_place;
            elsif( i = "02131301" ) then  return sorghum_beer_traditional_not_from_a_food_service_place;
            elsif( i = "02211100" ) then  return cigarettes;
            elsif( i = "02212100" ) then  return cigars_and_cigarillos;
            elsif( i = "02213100" ) then  return pipe_and_cigarette_tobacco;
            elsif( i = "02213200" ) then  return chewing_tobacco_and_snuff;
            elsif( i = "02213300" ) then  return other_items_smoked;
            elsif( i = "03111100" ) then  return material_for_clothing;
            elsif( i = "03121001" ) then  return mens_clothing;
            elsif( i = "03121002" ) then  return sports_clothing;
            elsif( i = "03122001" ) then  return womens_clothing;
            elsif( i = "03122002" ) then  return specially_made_up_clothes_eg_clothes_made_by_dressmakers_and_tailors;
            elsif( i = "03123100" ) then  return infants_clothing;
            elsif( i = "03123200" ) then  return girls_school_uniform;
            elsif( i = "03123300" ) then  return boys_school_uniform;
            elsif( i = "03123400" ) then  return girls_clothing;
            elsif( i = "03123500" ) then  return boys_clothing;
            elsif( i = "03126000" ) then  return other_specify;
            elsif( i = "03131001" ) then  return clothing_accessories_such_as_scarves_ties_belts_gloves_etc;
            elsif( i = "03131101" ) then  return knitting_wool_and_yarns;
            elsif( i = "03131102" ) then  return patterns_trimming_lace_sewing_cotton_etc;
            elsif( i = "03141100" ) then  return cleaning_of_clothing;
            elsif( i = "03141200" ) then  return labour_cost_for_making_or_knitting_ofclothing_and_repairs_or_alterations_to_clothing;
            elsif( i = "03141300" ) then  return cost_of_the_hire_of_clothing;
            elsif( i = "03211001" ) then  return mens_footwear;
            elsif( i = "03211002" ) then  return sports_footwear;
            elsif( i = "03211003" ) then  return other_footwear;
            elsif( i = "03212001" ) then  return womens_footwear;
            elsif( i = "03213100" ) then  return girls_school_footwear;
            elsif( i = "03213200" ) then  return boys_school_footwear;
            elsif( i = "03213300" ) then  return girls_footwear;
            elsif( i = "03213400" ) then  return boys_footwear;
            elsif( i = "03213500" ) then  return infants_footwear;
            elsif( i = "03221100" ) then  return repair_of_footwear;
            elsif( i = "03221200" ) then  return cost_of_hire_of_shoes;
            elsif( i = "04111010" ) then  return rent_dwelling;
            elsif( i = "04211001" ) then  return imputed_rent_on_owned_dwellingi_7pct_peryear_of_dwelling;
            elsif( i = "04311100" ) then  return maintenance_and_repair_of_dwelling_existing_buildings_swimming_pools_etc_including_paints_wallpaper_etc;
            elsif( i = "04321100" ) then  return services_for_maintenance_and_repair_of_dwelling_plumbers_electricians_carpenters;
            elsif( i = "04321201" ) then  return labour_and_material_for_maintenance_and_repair_of_dwelling;
            elsif( i = "04321203" ) then  return security_systems_including_alarms_panic_buttons;
            elsif( i = "04321400" ) then  return swimming_pool_maintenance_excluding_wages_of_persons_who_maintain_pools_but_including_chemicals;
            elsif( i = "04404500" ) then  return water_and_electricity;
            elsif( i = "04411010" ) then  return water;
            elsif( i = "04421010" ) then  return refuse_removel;
            elsif( i = "04431010" ) then  return sanitation;
            elsif( i = "04441010" ) then  return rate_and_taxes;
            elsif( i = "04441020" ) then  return security_services_including_reaction_services_and_neighbourhood_watch;
            elsif( i = "04441040" ) then  return purchase_of_watch_dogs;
            elsif( i = "04442000" ) then  return vat_on_utilities;
            elsif( i = "04511010" ) then  return electricity;
            elsif( i = "04511110" ) then  return prepaid_electricity;
            elsif( i = "04522010" ) then  return gas;
            elsif( i = "04522102" ) then  return gas_in_cylinders_including_gas_for_heating_purposes;
            elsif( i = "04531101" ) then  return paraffin;
            elsif( i = "04531102" ) then  return petrol_for_household_use_not_transport;
            elsif( i = "04531103" ) then  return diesel_for_household_use_not_transport;
            elsif( i = "04541101" ) then  return firewood_bought;
            elsif( i = "04541102" ) then  return firewood_fetched_value;
            elsif( i = "04541201" ) then  return charcoal;
            elsif( i = "04541301" ) then  return candles;
            elsif( i = "04541401" ) then  return coal_including_anthracite;
            elsif( i = "04541501" ) then  return dung_bought;
            elsif( i = "04541502" ) then  return dung_fetched_value;
            elsif( i = "04541601" ) then  return crop_waste;
            elsif( i = "04541710" ) then  return other_household_fuel;
            elsif( i = "05111110" ) then  return other_bedroom_furniture;
            elsif( i = "05111201" ) then  return dining_room_furniture;
            elsif( i = "05111300" ) then  return lounge_furniture;
            elsif( i = "05111400" ) then  return kitchen_furniture_and_units_excluding_appliances_eg_refrigerators;
            elsif( i = "05111500" ) then  return study_desks_bookshelves_and_other_study_furniture;
            elsif( i = "05111600" ) then  return garden_and_patio_furniture;
            elsif( i = "05111610" ) then  return other_eg_ornaments_paintings_and_other_works_of_art_specify;
            elsif( i = "05111620" ) then  return other_loose_items_of_furniture_specify_eg_beanbags_mirrors;
            elsif( i = "05111700" ) then  return other_furniture;
            elsif( i = "05121101" ) then  return fitted_carpets;
            elsif( i = "05121102" ) then  return loose_carpets_and_rugs;
            elsif( i = "05121103" ) then  return tiles;
            elsif( i = "05121200" ) then  return other_floor_coverings_excluding_bathroom_and_door_mats_specify;
            elsif( i = "05131100" ) then  return upholstering;
            elsif( i = "05131210" ) then  return repairs_to_furniture;
            elsif( i = "05131220" ) then  return repairs_to_furnishings;
            elsif( i = "05131230" ) then  return repairs_to_floor_coverings;
            elsif( i = "05211000" ) then  return bed_bases_and_mattresses;
            elsif( i = "05211100" ) then  return blankets_and_travelling_rugs;
            elsif( i = "05211200" ) then  return sheets_and_pillow_cases;
            elsif( i = "05211300" ) then  return duvets_and_duvet_covers;
            elsif( i = "05211400" ) then  return table_and_bathroom_linen_eg_table_cloths_and_napkins_towels_and_face_cloths;
            elsif( i = "05211500" ) then  return curtains_including_making_and_hanging_charges_and_material_for_curtains;
            elsif( i = "05211600" ) then  return pillows_and_cushions;
            elsif( i = "05211700" ) then  return other_household_textiles;
            elsif( i = "05211800" ) then  return duvet_packs_eg_package_including_pillow_cases_and_sheets;
            elsif( i = "05211900" ) then  return value_of_repairs_to_household_textiles;
            elsif( i = "05311100" ) then  return refrigerators_deep_freezers_and_refrigerator_or_deep_freeze_combinations;
            elsif( i = "05311200" ) then  return refrigerators;
            elsif( i = "05312100" ) then  return washing_machines_dishwashers_and_tumble_dryers;
            elsif( i = "05313100" ) then  return stoves_and_ovens_including_microwave_ovens;
            elsif( i = "05313200" ) then  return coal_wood_and_anthracite_stoves;
            elsif( i = "05313300" ) then  return gas_stoves_and_heaters;
            elsif( i = "05314100" ) then  return heaters_and_air_conditioners;
            elsif( i = "05314200" ) then  return paraffin_stoves_and_heaters;
            elsif( i = "05315100" ) then  return vacuum_cleaners_polishers_and_carpet_cleaning_machines;
            elsif( i = "05316100" ) then  return sewing_machines_over_lockers_and_knitting_machines;
            elsif( i = "05316200" ) then  return sewing_and_knitting_machines;
            elsif( i = "05321101" ) then  return hotplates;
            elsif( i = "05321200" ) then  return irons;
            elsif( i = "05321300" ) then  return kettles_and_percolators_coffee_makers;
            elsif( i = "05321400" ) then  return food_mixers_processors_and_similar_accessories;
            elsif( i = "05321500" ) then  return frying_pans_and_woks;
            elsif( i = "05321600" ) then  return toaster_waffle_pans_and_sandwich_toasters;
            elsif( i = "05321800" ) then  return other_electrical_appliances_eg_electric_blankets_water_pumps_and_fans_specify;
            elsif( i = "05321900" ) then  return other_eg_dry_cabinets_and_safes_specify;
            elsif( i = "05331100" ) then  return repairs_and_service_charges_for_electrical_appliances;
            elsif( i = "05331200" ) then  return repairs_and_service_charges_for_non_electrical_appliances;
            elsif( i = "05411000" ) then  return glass_and_crystal_ware_tableware_including_household_or_toilet_articles_of_porcelain_ceramic_stoneware_china_etc;
            elsif( i = "05412000" ) then  return cutlery_flatware_and_silverware_kitchen_and_domestic_utensils_non_electrical_utensils_such_as_frying_pans_saucepans_etc;
            elsif( i = "05413100" ) then  return enamel;
            elsif( i = "05413200" ) then  return aluminum_iron_steel;
            elsif( i = "05413300" ) then  return plastic;
            elsif( i = "05413400" ) then  return other_such_as_towel_rails_bottle_racks_etc_specify;
            elsif( i = "05414200" ) then  return value_of_repairs_on_glassware_tableware_and_household_utensils;
            elsif( i = "05511110" ) then  return power_driven_garden_tools;
            elsif( i = "05511130" ) then  return power_drills;
            elsif( i = "05521101" ) then  return light_bulbs;
            elsif( i = "05521201" ) then  return dry_cells;
            elsif( i = "05521202" ) then  return recharging_of_rechargeable_cells_not_car_batteies;
            elsif( i = "05521301" ) then  return hand_tools_such_as_screwdrivers;
            elsif( i = "05521302" ) then  return garden_hand_tools_such_as_spades;
            elsif( i = "05521303" ) then  return garden_water_sprinkler;
            elsif( i = "05521304" ) then  return other_garden_equipment;
            elsif( i = "05611100" ) then  return soap_bars_and_cakes_not_toilet_soap_washing_powders_liquid_detergents_and_bleaches_dishwasher_tablets;
            elsif( i = "05611200" ) then  return scouring_powders_pot_scourers_etc;
            elsif( i = "05611300" ) then  return floor_shoe_and_furniture_polish;
            elsif( i = "05611400" ) then  return insecticides_indoor_pesticides_drain_and_toilet_cleansers_air_freshener_etc;
            elsif( i = "05612010" ) then  return scissors_needles_pins;
            elsif( i = "05612110" ) then  return packaging_materials_plastic_bags_and_sachets_foil_wax_paper_etc;
            elsif( i = "05612120" ) then  return paper_serviettes_or_napkins_disposable_dinner_ware_plates_tumblers_etc;
            elsif( i = "05612210" ) then  return brooms_brushes_feather_dusters_etc;
            elsif( i = "05612220" ) then  return dish_cloths_wash_and_dry;
            elsif( i = "05612310" ) then  return matches;
            elsif( i = "05612320" ) then  return fire_lighters;
            elsif( i = "05612410" ) then  return other_clothes_pegs_hangers_etc_specify;
            elsif( i = "05612500" ) then  return methylated_spirits_fuel_for_lawnmowers_and_generators_and_for_heating_excluding_fuel_for_your_motor_vehicles;
            elsif( i = "05621011" ) then  return cash_wage_incl_transport_received_by_general_domestic_worker;
            elsif( i = "05621012" ) then  return cash_wage_incl_transport_received_by_child_minder_or_nanny;
            elsif( i = "05621013" ) then  return cash_wage_incl_transport_received_by_cook;
            elsif( i = "05621014" ) then  return cash_wage_incl_transport_received_by_chaffeur;
            elsif( i = "05621015" ) then  return cash_wage_incl_transport_received_by_clothes_washers_or_ironers;
            elsif( i = "05621016" ) then  return cash_wage_incl_transport_received_by_garden_worker;
            elsif( i = "05621017" ) then  return cash_wage_incl_transport_received_by_baby_sitter;
            elsif( i = "05621018" ) then  return cash_wage_incl_transport_received_by_other_domestic_worker;
            elsif( i = "05622100" ) then  return dry_cleaning_of_household_linen_textiles_and_carpets;
            elsif( i = "05622200" ) then  return laundry_service_for_household_textile_and_carpets_and_nappy_services_including_launderettes;
            elsif( i = "05622300" ) then  return hiring_of_furniture_furnishings_carpets;
            elsif( i = "05622400" ) then  return fumigation_and_cleaning_services_including_those_of_upholstery_swimming_pool_window_cleaning_etc;
            elsif( i = "05622500" ) then  return grinding_or_gristing_of_maize_or_wheat;
            elsif( i = "06111100" ) then  return medicine_purchased_with_prescription_in_private_institutions;
            elsif( i = "06111101" ) then  return medicine_purchased_with_prescription_in_public_institutions;
            elsif( i = "06111200" ) then  return medicine_purchased_without_prescription_in_private_institutions;
            elsif( i = "06111201" ) then  return medicine_purchased_without_prescription_in_public_institutions;
            elsif( i = "06111300" ) then  return pharmacy_dispensing_fees_in_private_institutions;
            elsif( i = "06111301" ) then  return pharmacy_dispensing_fees_in_public_institutions;
            elsif( i = "06111400" ) then  return pharmacy_service_fees_in_private_institutions;
            elsif( i = "06111401" ) then  return pharmacy_service_fees_in_public_institutions;
            elsif( i = "06121000" ) then  return other_medical_products_bandages_syringes_knee_supports_etc_in_private_institutions;
            elsif( i = "06121001" ) then  return other_medical_products_bandages_syringes_knee_supports_etc_in_public_institutions;
            elsif( i = "06121100" ) then  return condoms_strings_and_other_contraceptives_excluding_tablets_and_injections;
            elsif( i = "06131000" ) then  return therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_private_institutions;
            elsif( i = "06131001" ) then  return therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_public_institutions;
            elsif( i = "06211100" ) then  return medical_services_in_private_institutions;
            elsif( i = "06211101" ) then  return medical_services_in_public_institutions;
            elsif( i = "06211110" ) then  return flat_rate_in_respect_of_services_and_medicine_obtained_at_hospital_or_clinic_in_private_institutions;
            elsif( i = "06211111" ) then  return flat_rate_in_respect_of_services_and_medicine_obtained_at_hospital_or_clinic_in_public_institutions;
            elsif( i = "06211120" ) then  return other_medical_services_in_private_institutions;
            elsif( i = "06211121" ) then  return other_medical_services_in_public_institutions;
            elsif( i = "06211200" ) then  return consultations_of_traditional_healers_in_private_institutions_or_work_places;
            elsif( i = "06211201" ) then  return consultations_of_traditional_healers_in_public_institutions;
            elsif( i = "06221000" ) then  return dental_service_service_of_dentists_include_oral_hygienists_in_private_institutions;
            elsif( i = "06221001" ) then  return dental_service_service_of_dentists_include_oral_hygienists_in_public_institutions;
            elsif( i = "06231101" ) then  return medical_analysis_laboratories_and_x_ray_service_in_private_institutions;
            elsif( i = "06231102" ) then  return medical_analysis_laboratories_and_x_ray_service_in_public_institutions;
            elsif( i = "06232000" ) then  return service_of_medical_auxiliaries_freelance_nurse_midwives_freelance_optometrist_physiotherapist_speech_therapist_etc_in_private_instituti;
            elsif( i = "06232001" ) then  return service_of_medical_auxiliaries_freelance_nurse_midwives_freelance_optometrist_physiotherapist_speech_therapist_etc_in_public_institutio;
            elsif( i = "06233000" ) then  return non_hospital_service_ambulance_service_other_than_hospital_in_public_institutions;
            elsif( i = "06233001" ) then  return non_hospital_service_ambulance_service_other_than_hospital_in_private_institutions;
            elsif( i = "06311100" ) then  return hospital_service_fees_eg_wards_beds_and_theatre_fees_in_private_institutions;
            elsif( i = "06311101" ) then  return hospital_service_fees_eg_wards_beds_and_theatre_fees_in_public_institutions;
            elsif( i = "07111100" ) then  return new_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes;
            elsif( i = "07111200" ) then  return new_bakkies;
            elsif( i = "07111300" ) then  return four_wheel_drive_vehicles;
            elsif( i = "07112100" ) then  return used_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes;
            elsif( i = "07112200" ) then  return used_bakkies;
            elsif( i = "07112300" ) then  return four_wheel_drive_vehicles_2;
            elsif( i = "07121100" ) then  return new_motor_cycles_and_scooters;
            elsif( i = "07121200" ) then  return used_motor_cycles_and_scooters;
            elsif( i = "07131100" ) then  return new_bicycles;
            elsif( i = "07131200" ) then  return used_bicycles;
            elsif( i = "07141100" ) then  return new_animal_drawn_vehicles;
            elsif( i = "07141200" ) then  return used_animal_drawn_vehicles;
            elsif( i = "07141300" ) then  return horse;
            elsif( i = "07141400" ) then  return donkey;
            elsif( i = "07141500" ) then  return other_private_modes_of_transport_animals;
            elsif( i = "07211100" ) then  return new_tyres_and_tubes;
            elsif( i = "07211200" ) then  return re_treaded_or_patched_tyres_and_tubes;
            elsif( i = "07211300" ) then  return spare_parts_maintenance_and_cleaning_materials_accessories_purchased_for_private_repair_and_installation;
            elsif( i = "07211410" ) then  return batteries_new_and_used;
            elsif( i = "07211500" ) then  return air_conditioner_for_cars_including_installations;
            elsif( i = "07211600" ) then  return security_systems_for_cars_including_installation;
            elsif( i = "07221110" ) then  return motor_car_fuel;
            elsif( i = "07221200" ) then  return oil_and_grease;
            elsif( i = "07231100" ) then  return maintenance_and_lubrication_services;
            elsif( i = "07231410" ) then  return panel_beating_repairs_paid_for_by_you;
            elsif( i = "07231510" ) then  return other_repair_work_paid_for_by_you;
            elsif( i = "07231600" ) then  return car_wash;
            elsif( i = "07231700" ) then  return valet_services;
            elsif( i = "07241100" ) then  return parking_fees;
            elsif( i = "07241200" ) then  return traffic_fines;
            elsif( i = "07241300" ) then  return toll_fees;
            elsif( i = "07241400" ) then  return licenses_and_registration_fees_including_that_of_motor_cycles;
            elsif( i = "07241500" ) then  return driving_lessons_driving_tests_and_driving_licenses;
            elsif( i = "07241700" ) then  return rented_vehicles_educational_trips;
            elsif( i = "07241701" ) then  return rented_vehicles_other_than_educational;
            elsif( i = "07241801" ) then  return rented_on_holiday;
            elsif( i = "07241900" ) then  return other_transport_specify;
            elsif( i = "07311110" ) then  return train_for_attending_educational_institutions;
            elsif( i = "07311111" ) then  return train_for_non_educational_institutions;
            elsif( i = "07311210" ) then  return train_for_when_away_from_home;
            elsif( i = "07321110" ) then  return bus_including_school_bus_for_educational_purposes;
            elsif( i = "07321111" ) then  return bus_including_school_bus_for_non_educational_purposes;
            elsif( i = "07321210" ) then  return bus;
            elsif( i = "07321310" ) then  return metered_cab_attending_educaional_trips;
            elsif( i = "07321311" ) then  return metered_cab_other_than_educaional;
            elsif( i = "07321320" ) then  return minibus_taxi_or_combi_including_30_seaters_eg_iveco_for_non_educational_purposes;
            elsif( i = "07321321" ) then  return minibus_taxi_or_combi_including_30_seaters_eg_iveco_for_educational_purposes;
            elsif( i = "07321330" ) then  return other_including_bakkies_used_as_taxis_for_education_purposes;
            elsif( i = "07321331" ) then  return other_including_bakkies_used_as_taxis_for_non_education_purposes;
            elsif( i = "07321410" ) then  return metered_cab_while_on_holiday;
            elsif( i = "07321420" ) then  return minibus_taxi_including_30_seaters_eg_iveco;
            elsif( i = "07321430" ) then  return other_including_bakkies_used_as_taxis;
            elsif( i = "07321510" ) then  return lift_clubs_educational_trips;
            elsif( i = "07321511" ) then  return lift_clubs_other;
            elsif( i = "07331110" ) then  return aircraft_educaional_trips;
            elsif( i = "07331111" ) then  return aircraft_other_than_educaional;
            elsif( i = "07331210" ) then  return aircraft;
            elsif( i = "07341110" ) then  return boat_or_ship_educational_trips;
            elsif( i = "07341111" ) then  return boat_or_ship_other_than_educaional;
            elsif( i = "07341210" ) then  return boat_or_ship_while_on_holiday;
            elsif( i = "07361110" ) then  return furniture_removals_and_transport_of_goods_not_for_business_purposes_for_educational_purposes;
            elsif( i = "07361111" ) then  return furniture_removals_and_transport_of_goods_not_for_business_purposes_for_non_educational_purposes;
            elsif( i = "07361130" ) then  return supporting_services_eg_parking_services_port_operators;
            elsif( i = "07361140" ) then  return other_eg_cable_car_horse;
            elsif( i = "07361150" ) then  return other_eg_horse_for_educational_puporses;
            elsif( i = "07361151" ) then  return other_eg_horse_for_non_educational_puporses;
            elsif( i = "07715111" ) then  return saddles;
            elsif( i = "07715112" ) then  return horse_shoes;
            elsif( i = "07715113" ) then  return veterinary_costs;
            elsif( i = "07715114" ) then  return foods_or_feeds;
            elsif( i = "07715115" ) then  return other_cost_for_other_modes_of_transport;
            elsif( i = "08111100" ) then  return stamps;
            elsif( i = "08111200" ) then  return packages;
            elsif( i = "08111300" ) then  return courier_services;
            elsif( i = "08111301" ) then  return other_postage;
            elsif( i = "08111400" ) then  return renting_of_post_boxes;
            elsif( i = "08111500" ) then  return other_eg_telegrams;
            elsif( i = "08211100" ) then  return cellular_phones;
            elsif( i = "08211200" ) then  return telephones_cordless_telephones_motor_telephones;
            elsif( i = "08211300" ) then  return fax_machines_and_telephone_answering_machines_for_household_purposes;
            elsif( i = "08211400" ) then  return pagers;
            elsif( i = "08211600" ) then  return repairs_of_computers_and_communication_equipment;
            elsif( i = "08311101" ) then  return installation;
            elsif( i = "08311201" ) then  return private_calls;
            elsif( i = "08311202" ) then  return calls_from_public_phones;
            elsif( i = "08311203" ) then  return calls_including_phone_cards;
            elsif( i = "08311301" ) then  return rental_landline;
            elsif( i = "08311302" ) then  return rental_cellphone;
            elsif( i = "08311401" ) then  return value_added_tax_vat_only_if_telephone_account_is_available;
            elsif( i = "08311402" ) then  return value_added_tax_vat_on_calls_only_if_telephone_account_is_available;
            elsif( i = "08311501" ) then  return connection_to_the_network_for_a_landline;
            elsif( i = "08311502" ) then  return connection_to_the_network_for_a_cellphone;
            elsif( i = "08311503" ) then  return internet_subscription_and_other_costs;
            elsif( i = "09111100" ) then  return radios_including_motor_car_radios_tape_recorders_compact_disk_players_and_similar_equipment;
            elsif( i = "09111200" ) then  return two_way_radios;
            elsif( i = "09112100" ) then  return television_sets_decoders_video_recorders_or_dvds;
            elsif( i = "09112200" ) then  return aerials_and_satellite_dishes;
            elsif( i = "09121100" ) then  return cameras_video_cameras_projectors_and_flashes;
            elsif( i = "09121300" ) then  return other_recreational_services;
            elsif( i = "09131100" ) then  return personal_desktop_computers_excluding_laptops;
            elsif( i = "09131200" ) then  return laptops_and_palm_tops;
            elsif( i = "09131300" ) then  return software_excluding_games_play_stations_etc;
            elsif( i = "09131400" ) then  return calculators;
            elsif( i = "09131500" ) then  return printers_or_scanners_or_copiers;
            elsif( i = "09131600" ) then  return modems;
            elsif( i = "09131700" ) then  return parts_and_upgrading_of_computers;
            elsif( i = "09141100" ) then  return diskettes_cds_flah_disks_and_other_consumable_goods;
            elsif( i = "09141200" ) then  return magnetic_tapes_excl_software_and_video_games_including_pre_recorded_and_unrecorded_music_tapes;
            elsif( i = "09141300" ) then  return disks_for_photographic_and_cinematographic_use;
            elsif( i = "09141400" ) then  return compact_disks_cds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_disks;
            elsif( i = "09141500" ) then  return dvds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_dvds;
            elsif( i = "09141600" ) then  return vcds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_vcds;
            elsif( i = "09141700" ) then  return other_musical_instruments_sound_equipment_and_accessories;
            elsif( i = "09211000" ) then  return boats_including_outboard_motors_aircrafts_go_carts;
            elsif( i = "09211100" ) then  return new_caravans_and_trailers_including_motorised_caravans;
            elsif( i = "09211200" ) then  return used_caravans_and_trailers_including_motorised_caravans;
            elsif( i = "09221000" ) then  return musical_instruments_pianos_organs_and_other_musical_instruments;
            elsif( i = "09231001" ) then  return repairs_and_service_charges_for_musical_instruments_sound_equipment_and_accessories;
            elsif( i = "09231002" ) then  return repairs_and_maintenance_services_to_recreation_entertainment_and_sports_equipment;
            elsif( i = "09311100" ) then  return hobbies;
            elsif( i = "09311200" ) then  return toys_and_games_video_games_including_software_games;
            elsif( i = "09311400" ) then  return fire_works;
            elsif( i = "09321100" ) then  return firearms_and_ammunition;
            elsif( i = "09321101" ) then  return firearms_and_ammunition_for_security_services;
            elsif( i = "09321200" ) then  return tennis_rackets_and_balls_fishing_rods_etc;
            elsif( i = "09321300" ) then  return special_sports_clothes_and_shoes;
            elsif( i = "09321400" ) then  return camping_equipment_tents_sleeping_bags_etc;
            elsif( i = "09321500" ) then  return swimming_pool_equipment_and_repairs_of_equipment;
            elsif( i = "09331100" ) then  return seed_plants_shrubs_and_trees_fertilizer_plant_and_pest_spray_remedies;
            elsif( i = "09331200" ) then  return bouquets_and_cut_flowers_for_household_use;
            elsif( i = "09331210" ) then  return garden_ornaments;
            elsif( i = "09341000" ) then  return purchase_of_pets;
            elsif( i = "09341200" ) then  return pet_food_or_feeds_and_other_requisites;
            elsif( i = "09351100" ) then  return licenses;
            elsif( i = "09351200" ) then  return care_eg_doggy_parlour_kennels_and_veterinary_costs;
            elsif( i = "09411020" ) then  return amusement_parks;
            elsif( i = "09411030" ) then  return membership_fees_for_gymnasiums_health_sport_and_social_clubs;
            elsif( i = "09411100" ) then  return sports;
            elsif( i = "09411200" ) then  return fees_for_lessons_connecting_with_recreation_ebtertainment_and_sport;
            elsif( i = "09411300" ) then  return schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public;
            elsif( i = "09411301" ) then  return schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat;
            elsif( i = "09421000" ) then  return cinema_theatres_concerts_festivals;
            elsif( i = "09422100" ) then  return museums_and_zoos_etc;
            elsif( i = "09422200" ) then  return library_fees_and_fines_for_non_academic_purposes;
            elsif( i = "09422300" ) then  return library_fees_fines_for_academic_purpose;
            elsif( i = "09422400" ) then  return library_services_for_academic_purposes;
            elsif( i = "09423101" ) then  return television_licenses;
            elsif( i = "09423102" ) then  return television_rental;
            elsif( i = "09423103" ) then  return subscription_to_pay_tv_channels;
            elsif( i = "09423104" ) then  return rent_for_decoder_video_equipment_and_tapes;
            elsif( i = "09424300" ) then  return film_development_and_photo_prints;
            elsif( i = "09424400" ) then  return admission_charges_other;
            elsif( i = "09431100" ) then  return lotto;
            elsif( i = "09431200" ) then  return casinos;
            elsif( i = "09431300" ) then  return other_gambling;
            elsif( i = "09511100" ) then  return textbooks_for_public_institutions;
            elsif( i = "09511101" ) then  return textbooks_for_private_institutions;
            elsif( i = "09511200" ) then  return books_excluding_those_in_1614;
            elsif( i = "09521100" ) then  return newspapers_daily_weekly;
            elsif( i = "09521200" ) then  return magazines_and_periodicals;
            elsif( i = "09531000" ) then  return miscellaneous_printed_mattereg_road_maps_greeting_cards_posters_etc;
            elsif( i = "09541100" ) then  return stationery_excluding_those_for_academic_purposes;
            elsif( i = "09541200" ) then  return stationery_for_academic_purposes_excluding_calculators_for_public_institutions;
            elsif( i = "09541201" ) then  return stationery_for_academic_purposes_excluding_calculators_for_private_institutions;
            elsif( i = "09541400" ) then  return other_specify_eg_junior_laptops_training_and_adult_education_for_public_institutions;
            elsif( i = "09541401" ) then  return other_specify_eg_junior_laptops_training_and_adult_education_for_private_institutions;
            elsif( i = "09611000" ) then  return holiday_tour_package;
            elsif( i = "10111101" ) then  return pre_primary_education_in_public_institutions;
            elsif( i = "10111111" ) then  return pre_primary_education_in_private_institutions;
            elsif( i = "10111201" ) then  return primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions;
            elsif( i = "10111301" ) then  return primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions;
            elsif( i = "10211101" ) then  return secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution;
            elsif( i = "10211111" ) then  return secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution;
            elsif( i = "10411101" ) then  return tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions;
            elsif( i = "10411111" ) then  return tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions;
            elsif( i = "10511101" ) then  return vocational_training_in_public_institutions;
            elsif( i = "10511102" ) then  return computer_certification_public_schools;
            elsif( i = "10511103" ) then  return other_including_language_classes_in_public_institutions;
            elsif( i = "10511104" ) then  return excursions_field_trips_in_public_institutions;
            elsif( i = "10511105" ) then  return other_tuition_fees_for_private_institutions;
            elsif( i = "10511111" ) then  return vocational_training_in_private_institutions;
            elsif( i = "10511112" ) then  return computer_certification_private_schools;
            elsif( i = "10511113" ) then  return other_including_language_classes_in_private_institutions;
            elsif( i = "10511114" ) then  return excursions_field_trips_in_private_institutions;
            elsif( i = "10511115" ) then  return other_tuition_fees_for_public_institutions;
            elsif( i = "11111211" ) then  return coffee;
            elsif( i = "11111221" ) then  return ordinary_tea;
            elsif( i = "11111222" ) then  return rooibos_tea;
            elsif( i = "11111223" ) then  return herbal_tea_from_food_service_place;
            elsif( i = "11111224" ) then  return other_eg_flavored_tea_specify;
            elsif( i = "11111231" ) then  return cocoa_and_powdered_chocolate;
            elsif( i = "11111241" ) then  return mineral_water_or_spring_water;
            elsif( i = "11111251" ) then  return soft_drinks;
            elsif( i = "11111261" ) then  return fruit_juices_from_food_service_places;
            elsif( i = "11111262" ) then  return fruit_and_vegetable_juices_combined_from_food_service_places;
            elsif( i = "11111271" ) then  return vegetable_juices_from_food_service_places;
            elsif( i = "11111311" ) then  return spirits;
            elsif( i = "11111321" ) then  return table_wines_including_sparkling_wine_from_food_service_places;
            elsif( i = "11111322" ) then  return cooking_wines_from_food_service_places;
            elsif( i = "11111323" ) then  return fortified_wines_sherry_port_etc_from_food_service_places;
            elsif( i = "11111324" ) then  return spirit_coolers_cider_hooch_etc_from_a_food_service_place;
            elsif( i = "11111325" ) then  return other_eg_mampoer_home_brewed_from_food_service_place;
            elsif( i = "11111331" ) then  return clear_beer_purchased_from_a_food_service_place;
            elsif( i = "11111332" ) then  return sorghum_beer_pre_packed_from_food_service_places;
            elsif( i = "11111333" ) then  return sorghum_beer_traditional_from_a_food_service_place;
            elsif( i = "11121110" ) then  return burger;
            elsif( i = "11121120" ) then  return burger_and_chips;
            elsif( i = "11121130" ) then  return curry_and_rice;
            elsif( i = "11121140" ) then  return pap_and_meat;
            elsif( i = "11121150" ) then  return other_prepared_meals_11121150;
            elsif( i = "11121160" ) then  return other_prepared_meals_11121160;
            elsif( i = "11121170" ) then  return other_prepared_meals_11121170;
            elsif( i = "11121180" ) then  return other_prepared_meals_11121180;
            elsif( i = "11121190" ) then  return other_prepared_meals_11121190;
            elsif( i = "11211100" ) then  return hotel_motel_and_or_or_boarding_fees_paying_for_yourself;
            elsif( i = "11211200" ) then  return rent_holiday_flat_or_house_caravan_etc_including_site_fees_paying_for_yourself;
            elsif( i = "11211301" ) then  return schools_boarding_fees_in_public_institutions;
            elsif( i = "11211302" ) then  return teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions;
            elsif( i = "11211303" ) then  return universities_boarding_fees_in_public_institution;
            elsif( i = "11211311" ) then  return schools_boarding_fees_in_private_institutions;
            elsif( i = "11211312" ) then  return teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions;
            elsif( i = "11211313" ) then  return universities_boarding_fees_in_private_institution;
            elsif( i = "11211401" ) then  return expenses_occurred_as_owner_of_a_holiday_home_ie_after_deduction_of_income_received_from_letting;
            elsif( i = "11211502" ) then  return boarding_and_lodging;
            elsif( i = "12111100" ) then  return mens_and_boys;
            elsif( i = "12111200" ) then  return womens_and_girls;
            elsif( i = "12121100" ) then  return hairdryers;
            elsif( i = "12121200" ) then  return shavers;
            elsif( i = "12121300" ) then  return other_eg_hot_brush_vibrator_etc;
            elsif( i = "12131110" ) then  return hair_pieces;
            elsif( i = "12131120" ) then  return hair_care_preparations_mousse_relaxers_gels_etc;
            elsif( i = "12131130" ) then  return shampoo_and_conditioners;
            elsif( i = "12131140" ) then  return sprays;
            elsif( i = "12131150" ) then  return other;
            elsif( i = "12131210" ) then  return body_soap_including_sunlight_liquid_soap;
            elsif( i = "12131220" ) then  return bubble_bath_bath_oils_and_bath_salts;
            elsif( i = "12131230" ) then  return toothpaste_toothbrushes_electrical_toothbrushes;
            elsif( i = "12131240" ) then  return mouth_wash_and_dental_floss;
            elsif( i = "12131250" ) then  return shaving_soap_and_cream_and_after_shave_lotions;
            elsif( i = "12131260" ) then  return razors_and_razor_blades;
            elsif( i = "12131270" ) then  return skin_creams_and_lotions_including_baby_lotions_facial_cleansers_and_toners_perfumes_and_colognes;
            elsif( i = "12131280" ) then  return powder_including_baby_powder_and_deodorants;
            elsif( i = "12131290" ) then  return make_up_preparations_not_shown_elsewhere_eg_lipstick_eye_shadow_etc;
            elsif( i = "12131310" ) then  return toilet_paper;
            elsif( i = "12131320" ) then  return disposable_nappies;
            elsif( i = "12131330" ) then  return tissues;
            elsif( i = "12131340" ) then  return sanitary_towels_and_tampons;
            elsif( i = "12131400" ) then  return other_personal_care_products;
            elsif( i = "12311100" ) then  return watches_and_personal_jewellery;
            elsif( i = "12321100" ) then  return handbags_travelling_bags_schoolbags_etc;
            elsif( i = "12322000" ) then  return value_of_repairs_to_miscellaneous_items;
            elsif( i = "12322100" ) then  return smokers_reqisites;
            elsif( i = "12322110" ) then  return prams_and_push_carts;
            elsif( i = "12322120" ) then  return car_seats_for_babies;
            elsif( i = "12322130" ) then  return carry_cot_toys_etc;
            elsif( i = "12322200" ) then  return other_umbrellas_pocket_knives_sunglasses_etc_including_repairs;
            elsif( i = "12412010" ) then  return day_care_mothers_creches_and_playgrounds_in_public_institutions;
            elsif( i = "12412020" ) then  return day_care_mothers_creches_and_playgrounds_in_private_institutions;
            elsif( i = "12521010" ) then  return insurance_on_buildings;
            elsif( i = "12521020" ) then  return insurance_on_contents_of_dwellings;
            elsif( i = "12521030" ) then  return package_insurance;
            elsif( i = "12531020" ) then  return medical_insurance;
            elsif( i = "12531110" ) then  return medical_aid_contribution_paid_by_household_member_in_private_institution;
            elsif( i = "12531111" ) then  return medical_aid_contribution_paid_by_household_member_in_public_institution;
            elsif( i = "12531200" ) then  return insurance_paid_for_holiday_purposes_life_luggage_medical;
            elsif( i = "12541100" ) then  return insurance_for_private_transport;
            elsif( i = "12551020" ) then  return funeral_policies;
            elsif( i = "12621020" ) then  return bank_charges;
            elsif( i = "12621040" ) then  return interest_or_finance_charges;
            elsif( i = "12711010" ) then  return levy_for_sectional_title;
            elsif( i = "12711011" ) then  return contribution_towards_communal_provision_of_sevices;
            elsif( i = "12711012" ) then  return payment_for_right_to_access_land;
            elsif( i = "12711013" ) then  return membership_fees;
            elsif( i = "12711014" ) then  return donations_to_institutions;
            elsif( i = "12711015" ) then  return donations_to_charity;
            elsif( i = "12711030" ) then  return levy_and_other_payments;
            elsif( i = "12711040" ) then  return professional_fees;
            elsif( i = "12711201" ) then  return lobola_or_dowry_paid;
            elsif( i = "12711301" ) then  return funeral_expenses;
            elsif( i = "12711400" ) then  return gravestones_and_maintenance_of_graves_excluding_unveiling;
            elsif( i = "12711500" ) then  return religious_and_traditional_ceremonies_unveiling_barmitzwah_diwali_weddings;
            elsif( i = "12711600" ) then  return fines_fines_for_straying_livestock_excluding_traffic_fines_and_library_fines;
            elsif( i = "12711700" ) then  return other_expenditure;
            elsif( i = "88888888" ) then  return unclassified_diary_items_except_food;
            elsif( i = "88999999" ) then  return others_expenditures_except_food;
            elsif( i = "04411210" ) then  return free_water;
            elsif( i = "04431210" ) then  return free_sanitation;
            elsif( i = "04511210" ) then  return free_electricity;
            elsif( i = "07241702" ) then  return estimated_value_of_private_use_of_company_or_similar_vehicle;
            elsif( i = "07321610" ) then  return value_of_discounted_fares_for_educational_purposes;
            elsif( i = "07321611" ) then  return value_of_discounted_fares_for_non_educational_purposes;
            elsif( i = "09411310" ) then  return schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public;
            elsif( i = "09411311" ) then  return schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat;
            elsif( i = "09422301" ) then  return library_fees_fines_grant_for_academic_purpose;
            elsif( i = "09422401" ) then  return library_services_grant_for_academic_purposes;
            elsif( i = "09511110" ) then  return textbooks_for_public_institutions_grant;
            elsif( i = "09511111" ) then  return textbooks_for_private_institutions_grant;
            elsif( i = "09541210" ) then  return stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions;
            elsif( i = "09541211" ) then  return stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions;
            elsif( i = "09541410" ) then  return other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions;
            elsif( i = "09541411" ) then  return other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions;
            elsif( i = "10111102" ) then  return pre_primary_education_in_public_institutions_grant;
            elsif( i = "10111112" ) then  return pre_primary_education_in_private_institutions_grant;
            elsif( i = "10111202" ) then  return primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions_grant;
            elsif( i = "10111302" ) then  return primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions_grant;
            elsif( i = "10211102" ) then  return secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution_grant;
            elsif( i = "10211112" ) then  return secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution_grant;
            elsif( i = "10411102" ) then  return tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions_grant;
            elsif( i = "10411112" ) then  return tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions_grant;
            elsif( i = "10511121" ) then  return vocational_training_in_public_institutions_grant;
            elsif( i = "10511122" ) then  return computer_certification_public_schools_grant;
            elsif( i = "10511123" ) then  return other_including_language_classes_in_public_institutions_grant;
            elsif( i = "10511124" ) then  return excursions_field_trips_in_public_institutions_grant;
            elsif( i = "10511125" ) then  return other_tuition_fees_for_private_institutions_grant;
            elsif( i = "10511131" ) then  return vocational_training_in_private_institutions_grant;
            elsif( i = "10511132" ) then  return computer_certification_private_schools_grant;
            elsif( i = "10511133" ) then  return other_including_language_classes_in_private_institutions_grant;
            elsif( i = "10511134" ) then  return excursions_field_trips_in_private_institutions_grant;
            elsif( i = "10511135" ) then  return other_tuition_fees_for_public_institutions_grant;
            elsif( i = "11211321" ) then  return schools_boarding_fees_in_public_institutions_grant;
            elsif( i = "11211322" ) then  return teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant;
            elsif( i = "11211323" ) then  return universities_boarding_fees_in_public_institution_grant;
            elsif( i = "11211331" ) then  return schools_boarding_fees_in_private_institutions_grant;
            elsif( i = "11211332" ) then  return teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant;
            elsif( i = "11211333" ) then  return universities_boarding_fees_in_private_institution_grant;
            elsif( i = "12412011" ) then  return day_care_mothers_creches_and_playgrounds_in_public_institutions_grant;
            elsif( i = "12412021" ) then  return day_care_mothers_creches_and_playgrounds_in_private_institutions_grant;
            elsif( i = "12531120" ) then  return medical_aid_contribution_contribution_by_employer_in_private_institutions;
            elsif( i = "12531121" ) then  return medical_aid_contribution_contribution_by_employer_in_public_institutions;
            elsif( i = "50110000" ) then  return household_salaries_and_wages;
            elsif( i = "50120000" ) then  return household_self_employment_and_business;
            elsif( i = "50210000" ) then  return income_from_letting_of_fixed_property;
            elsif( i = "50220000" ) then  return royalties;
            elsif( i = "50230000" ) then  return interest_received;
            elsif( i = "50241000" ) then  return dividends_of_listed_companies;
            elsif( i = "50242000" ) then  return dividends_of_unlisted_companies;
            elsif( i = "50250000" ) then  return other_dividends;
            elsif( i = "50310000" ) then  return pension_from_previous_employment;
            elsif( i = "50320000" ) then  return annuities_from_own_investment;
            elsif( i = "50331000" ) then  return old_age_pensions;
            elsif( i = "50332000" ) then  return disability_grants;
            elsif( i = "50333000" ) then  return family_and_other_allowances;
            elsif( i = "50334000" ) then  return workmens_compensation_funds;
            elsif( i = "50410000" ) then  return alimony_palimony_and_other_allowances;
            elsif( i = "50420000" ) then  return other_income_from_individuals;
            elsif( i = "50510100" ) then  return hobbis;
            elsif( i = "50510200" ) then  return side_lines_and_part_time_activities;
            elsif( i = "50510300" ) then  return sale_of_vehicles_property_etc;
            elsif( i = "50510400" ) then  return payments_received_from_boarders_and_other_non_members;
            elsif( i = "50510600" ) then  return claims;
            elsif( i = "50510700" ) then  return stokvel;
            elsif( i = "50510900" ) then  return benefits_donations_and_giftes;
            elsif( i = "50511000" ) then  return cash;
            elsif( i = "50511100" ) then  return value_of_food_received;
            elsif( i = "50511300" ) then  return value_of_clothing;
            elsif( i = "50511500" ) then  return value_of_other_benefints_donations_gifts_etc;
            elsif( i = "50511600" ) then  return lobola_or_dowry_received;
            elsif( i = "50511700" ) then  return income_from_gambling;
            elsif( i = "50511800" ) then  return tax_refunds_received;
            elsif( i = "50511900" ) then  return income_not_elsewhere_specified;
            elsif( i = "50512000" ) then  return gratuities_and_other_lump_sum_payments;
            elsif( i = "50600000" ) then  return imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling;
            elsif( i = "51200000" ) then  return free_water_income;
            elsif( i = "51300000" ) then  return free_sanitation_income;
            elsif( i = "51400000" ) then  return free_electricity_income;
            elsif( i = "51510000" ) then  return estimated_value_of_private_use_of_company_or_similar_vehicle_income;
            elsif( i = "51520000" ) then  return value_of_discounted_fares_for_educational_purposes_income;
            elsif( i = "51530000" ) then  return value_of_discounted_fares_for_non_educational_purposes_income;
            elsif( i = "51610000" ) then  return schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public_income;
            elsif( i = "51620000" ) then  return schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat_income;
            elsif( i = "51710000" ) then  return library_fees_fines_grant_for_academic_purpose_income;
            elsif( i = "51720000" ) then  return library_services_grant_for_academic_purposes_income;
            elsif( i = "51730000" ) then  return textbooks_for_public_institutions_grant_income;
            elsif( i = "51740000" ) then  return textbooks_for_private_institutions_grant_income;
            elsif( i = "51750000" ) then  return stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions_income;
            elsif( i = "51760000" ) then  return stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions_income;
            elsif( i = "51770000" ) then  return other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions_income;
            elsif( i = "51780000" ) then  return other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions_income;
            elsif( i = "51801000" ) then  return pre_primary_education_in_public_institutions_grant_income;
            elsif( i = "51802000" ) then  return pre_primary_education_in_private_institutions_grant_income;
            elsif( i = "51803000" ) then  return primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions_grant_income;
            elsif( i = "51804000" ) then  return primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions_grant_income;
            elsif( i = "51805000" ) then  return secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution_grant_income;
            elsif( i = "51806000" ) then  return secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution_grant_income;
            elsif( i = "51807000" ) then  return tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions_grant_income;
            elsif( i = "51808000" ) then  return tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions_grant_income;
            elsif( i = "51809000" ) then  return vocational_training_in_public_institutions_grant_income;
            elsif( i = "51810000" ) then  return computer_certification_public_schools_grant_income;
            elsif( i = "51811000" ) then  return other_including_language_classes_in_public_institutions_grant_income;
            elsif( i = "51812000" ) then  return excursions_field_trips_in_public_institutions_grant_income;
            elsif( i = "51813000" ) then  return vocational_training_in_private_institutions_grant_income;
            elsif( i = "51814000" ) then  return computer_certification_private_schools_grant_income;
            elsif( i = "51815000" ) then  return other_including_language_classes_in_private_institutions_grant_income;
            elsif( i = "51816000" ) then  return excursions_field_trips_in_private_institutions_grant_income;
            elsif( i = "51817000" ) then  return other_tuition_fees_for_public_institutions_grant_income;
            elsif( i = "51818000" ) then  return other_tuition_fees_for_private_institutions_grant_income;
            elsif( i = "51910000" ) then  return schools_boarding_fees_in_public_institutions_grant_income;
            elsif( i = "51920000" ) then  return teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_income;
            elsif( i = "51930000" ) then  return universities_boarding_fees_in_public_institution_grant_income;
            elsif( i = "51940000" ) then  return schools_boarding_fees_in_private_institutions_grant_income;
            elsif( i = "51950000" ) then  return teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_income;
            elsif( i = "51960000" ) then  return universities_boarding_fees_in_private_institution_grant_income;
            elsif( i = "51971000" ) then  return day_care_mothers_creches_and_playgrounds_in_public_institutions_grant_income;
            elsif( i = "51972000" ) then  return day_care_mothers_creches_and_playgrounds_in_private_institutions_grant_income;
            elsif( i = "51973000" ) then  return medical_aid_contribution_contribution_by_employer_in_private_institutions_income;
            elsif( i = "51974000" ) then  return medical_aid_contribution_contribution_by_employer_in_public_institutions_income;
            elsif( i = "52110000" ) then  return improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts;
            elsif( i = "52122000" ) then  return services_for_improvements_additions_and_alterationscarpenters_electricians_etc;
            elsif( i = "52130000" ) then  return security_structures_including_fences_electronic_gates;
            elsif( i = "52140000" ) then  return building_materials_not_included_in_q813_a_or_c_eg_for_building_purposes;
            elsif( i = "52150000" ) then  return labour_and_material_for_improvements_additions_and_alterations;
            elsif( i = "52210000" ) then  return cost_of_other_dewlling;
            elsif( i = "52220000" ) then  return capital_payments_including_deposit;
            elsif( i = "52230000" ) then  return monthly_capital_payments;
            elsif( i = "52240000" ) then  return other_payments_such_as_transfer_duty_and_transfer_costs_and_registration_of_mortgage_bond;
            elsif( i = "52251000" ) then  return purchase_of_timeshare;
            elsif( i = "52252000" ) then  return levy_on_timeshare;
            elsif( i = "52310000" ) then  return life_and_endownment_policies;
            elsif( i = "52320000" ) then  return life_insurance_covering_mortgage_debt;
            elsif( i = "52410000" ) then  return repayment_on_loans_and_overdrafts;
            elsif( i = "52421000" ) then  return contribution_to_pension_provident_and_annuity_funds;
            elsif( i = "52422000" ) then  return employer_contribution_to_pension_provident_and_annuity_funds;
            elsif( i = "52500000" ) then  return contributions_to_a_stokvel;
            elsif( i = "52610000" ) then  return listed_company_shares;
            elsif( i = "52620000" ) then  return unlisted_company_shares;
            elsif( i = "52630000" ) then  return unit_trusts;
            elsif( i = "52640000" ) then  return investment_plans;
            elsif( i = "52650000" ) then  return offshore;
            elsif( i = "52660000" ) then  return other_investments;
            elsif( i = "52710000" ) then  return deposits_into_savings;
            elsif( i = "52720000" ) then  return wthdrawals_from_savings;
            elsif( i = "53110000" ) then  return site_income_tax;
            elsif( i = "53120000" ) then  return paye_income_tax;
            elsif( i = "53130000" ) then  return according_to_assessment_income_tax;
            elsif( i = "53200000" ) then  return amnesty_tax;
            elsif( i = "53300000" ) then  return unemployment_insurance_fund_uif;
            elsif( i = "99111102" ) then  return in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children;
            elsif( i = "99111112" ) then  return in_cash_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children;
            elsif( i = "99111202" ) then  return gifts_to_persons_who_are_not_members_of_this_household_excluding_cash_gifts_in_kind;
            elsif( i = "99111212" ) then  return gifts_to_persons_who_are_not_members_of_this_household_excluding_cash_gifts;
            elsif( i = "99111302" ) then  return tribal_levies_not_for_housing_in_kind;
            elsif( i = "99111312" ) then  return tribal_levies_not_for_housing;
            elsif( i = "70100000" ) then  return bond_loan_from_the_bank;
            elsif( i = "70110000" ) then  return other_loans;
            elsif( i = "70200000" ) then  return motor_vehicle_loan_from_the_bank;
            elsif( i = "70300000" ) then  return bank_overdraft;
            elsif( i = "70400000" ) then  return other_bank_loans;
            elsif( i = "70500000" ) then  return furniture_and_appliances_amount_oustanding;
            elsif( i = "70600000" ) then  return retail_stores_clothers_on_account_or_lay_bye_amount_outstanding;
            elsif( i = "70700000" ) then  return loans_from_friends_and_family;
            elsif( i = "70800000" ) then  return loans_from_money_lenders;
            elsif( i = "70900000" ) then  return arreas_on_municipal_bills;
            elsif( i = "80000000" ) then  return expenditure_incurred_in_obtaining_income;
            elsif( i = "04211000" ) then  return imputed_rent_on_owned_dwelling;
            elsif( i = "07231420" ) then  return panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party;
            elsif( i = "07231520" ) then  return other_repair_work_paid_for_by_your_insurance_company_or_other_party;
            elsif( i = "12621010" ) then  return interest_on_mortgage_bonds;
            elsif( i = "12711020" ) then  return subsidy_on_payment_of_mortgage;
            elsif( i = "66311101" ) then  return seed;
            elsif( i = "66311201" ) then  return fertilizer;
            elsif( i = "66311301" ) then  return feed;
            elsif( i = "66311401" ) then  return livestock;
            elsif( i = "66311501" ) then  return services_eg_ploughing_veterinary_not_for_pets;
            elsif( i = "66311601" ) then  return processingeg_grinding_milling_and_slaughtering;
            elsif( i = "66311701" ) then  return other_items_from_own_production;
            elsif( i = "50510500" ) then  return good_and_services_received_by_virtue_of_occupation;
            elsif( i = "50510800" ) then  return non_refundable_bursaries;
            elsif( i = "50511200" ) then  return value_of_housing;
            elsif( i = "50511400" ) then  return value_of_transport;
        end if;
        return missing;
    end Convert_Coicop_Type;

end Coicop_Definitions; 
