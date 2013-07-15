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

with Ada.Strings.Unbounded;
with Ada.Text_IO;

package body ZA.Model_Types is

   use Ada.Text_IO;

   function Calculate_Income( 
      incomes : Income_Array; 
      propns : Included_Income_Array ) return Amount is
   begin
      return Income_Package.Sum( incomes, propns );
   end Calculate_Income;
   
   function Calculate_Expenses( 
      expenses : Personal_Expenses_Array; 
      propns : Allowable_Expenses_Array  ) return Amount is
   begin
      return Expenses_Package.Sum( expenses, propns );
   end Calculate_Expenses;
  
   function Pretty_Print( i : Personal_Expenses_Type ) return String is
   begin
      case i is 
         when travel_to_work => return "Travel to work";
         when health_spending => return "Spending on health (not insurance)";
         when health_insurance => return "Health insurance";
         when pension_contributions => return "Pension contributions";
         when annuity_funds_contributions => return "Contributions to pension, provident and annuity funds";
      end case;
   end Pretty_Print;
   
   function Pretty_Print( i : Personal_Incomes_Type ) return String is
   begin
      case i is
         when salaries_and_wages => return "Salaries and wages";
         when self_employment_and_business_income => return "Self-employment and business income";
         when property_income => return "Property income";
         when royalties => return "Royalties";
         when interest_received => return "Interest received";
         when dividends => return "Dividends";
         when private_pensions => return "Private pensions";
         when annuities => return "Annuities";
         when alimony_palimony_and_other_allowances => return "Alimony palimony and other allowances";
         when income_from_other_individuals => return "Income from other individuals";
         when other_income => return "Other income";
         when in_kind_water_sanitation_electricity => return "In kind water, sanitation and electricity";
         when in_kind_company_vehicle_or_discounted_fares => return "In-kind company vehicle or discounted fares";
         when in_kind_education => return "In-kind education";
         when in_kind_child_care => return "In-kind child care";
         when disability_grants => return "Disability grants";
         when old_age_pensions => return "Old-age pensions";
         when family_allowances => return "Family allowances";
         -- when social_pensions => return "Social pensions";
         when other_state_benefits => return "Other state benefits";
         -- when paye_income_tax => return "PAYE Income Tax";
         when site_income_tax => return "SITE Income Tax";
         when employers_uif => return "Employers Unemployment Insurance Fund (UIF)";
         when employees_uif => return "Employees Unemployment Insurance Fund (UIF)";
      end case;
   end Pretty_Print;
   
   function Pretty_Print( i : Poverty_State ) return String is
   begin
      case i is
         when in_poverty => return "In Poverty";
         when not_in_poverty => return "Not Poor";
      end case;
   end Pretty_Print;

   function Pretty_Print( i : Age_Group_Type ) return String is
   begin
      case i is
          when age_00_to_04_years => return "00  to  04 years";
          when age_05_to_09_years => return "05  to  09 years";
          when age_10_to_14_years => return "10  to  14 years";
          when age_15_to_19_years => return "15  to  19 years";
          when age_20_to_24_years => return "20  to  24 years";
          when age_25_to_29_years => return "25  to  29 years";
          when age_30_to_34_years => return "30  to  34 years";
          when age_35_to_39_years => return "35  to  39 years";
          when age_40_to_44_years => return "40  to  44 years";
          when age_45_to_49_years => return "45  to  49 years";
          when age_50_to_54_years => return "50  to  54 years";
          when age_55_to_59_years => return "55  to  59 years";
          when age_60_to_64_years => return "60  to  64 years";
          when age_65_to_69_years => return "65  to  69 years";
          when age_70_to_74_years => return "70  to  74 years";
          when age_75_to_79_years => return "75  to  79 years";
          when age_80_to_84_years => return "80  to  84 years";
          when age_85_plus => return "85 Plus";
          when unspecified => return "Unspecified ";
      end case;
   end Pretty_Print;
    

   function Pretty_Print( i : Gender_Type ) return String is
   begin
      case i is
          when male => return "Male";
          when female => return "Female";
          when unspecified => return "Unspecified";
      end case;
   end Pretty_Print;
   
   
   function Pretty_Print( i : Education_Level ) return String is
   begin
      case i is
          when no_schooling => return "No schooling";
          when grade_r_or_0 => return "Grade R / 0";
          when grade_1_or_sub_a => return "Grade 1 / Sub A";
          when grade_2_or_sub_b => return "Grade 2 / Sub B";
          when grade_3_or_standard_1 => return "Grade 3 / Standard 1";
          when grade_4_or_standard_2 => return "Grade 4 / Standard 2";
          when grade_5_or_standard_3 => return "Grade 5 / Standard 3";
          when grade_6_or_standard_4 => return "Grade 6 / Standard 4";
          when grade_7_or_standard_5 => return "Grade 7 / Standard 5";
          when grade_8_or_standard_6_or_form_1 => return "Grade 8 / Standard 6 / Form 1";
          when grade_9_or_standard_7_or_form_2 => return "Grade 9 / Standard 7 / Form 2  ";
          when grade_10_or_standard_8_or_form_3 => return "Grade 10 / Standard 8 / Form 3";
          when grade_11_or_standard_9_or_form_4 => return "Grade 11 / Standard 9 / Form 4";
          when grade_12_or_standard_10_or_form_5_or_matric => return "Grade 12 / Standard 10 / Form 5/Matric";
          when ntc_l => return "NTC l";
          when ntc_ii => return "NTC II";
          when ntc_iii => return "NTC III";
          when diploma_or_certificate_with_less_than_grade_12_or_std_10 => return "Diploma / certificate with less than Grade 12 / Std 10 ";
          when diploma_with_less_than_grade_12_or_std_10 => return "Diploma with less than Grade 12 / Std 10";
          when certificate_with_grade_12_or_std_10 => return "Certificate with Grade 12 / Std 10";
          when diploma_with_grade_12_or_std_10 => return "Diploma with Grade 12 / Std 10";
          when bachelors_degree => return "Bachelors Degree";
          when bachelors_degree_and_diploma => return "Bachelors Degree and Diploma";
          when honours_degree => return "Honours Degree";
          when higher_degree_masters_doctorate => return "Higher Degree (Masters, Doctorate)";
          when other_education => return "Other ";
          when dont_know_or_unspecified => return "Don't know/Unspecified";
      end case;
   end Pretty_Print;
   
   function Pretty_Print( i : Dwelling_Type ) return String is
   begin
      case i is
          when boarding_school_or_university_hostel => return "Boarding school/university hostel";
          when old_age_home => return "Old-age home";
          when frail_care_centre => return "Frail care centre";
          when home_for_the_disabled => return "Home for the disabled";
          when initiation_school => return "Initiation school";
          when prison => return "Prison";
          when retirement_village => return "Retirement village";
          when hospital_or_medical_facility_or_clinic => return "Hospital/medical facility/clinic";
          when private_house => return "Private house";
          when other_dwelling_type => return "Other Dwelling Type";
          when unspecified => return "Unspecified";
       end case;
   end Pretty_Print;
   
   
   function Pretty_Print( i : Population_Group ) return String is
   begin
      case i is
          when african_or_black => return "African/Black";
          when coloured => return "Coloured";
          when indian_or_asian => return "Indian/Asian";
          when white => return "White";
          when other_population_group => return "Other Group";
          -- when not_applicable => return "Not applicable";
          -- when unspecified => return "Unspecified";
      end case;
   end Pretty_Print;
   
   function Pretty_Print( i : Province_Type ) return String is
   begin
      case i is
          when western_cape => return "Western Cape";
          when eastern_cape => return "Eastern Cape";
          when northern_cape => return "Northern Cape";
          when free_state => return "Free State";
          when kwazulu_natal => return "KwaZulu-Natal";
          when north_west => return "North West";
          when gauteng => return "Gauteng";
          when mpumalanga => return "Mpumalanga";
          when limpopo => return "Limpopo";
       end case;
   end Pretty_Print;

   function Pretty_Print( i : Settlement_Type ) return String is
   begin
      case i is
          when urban => return "Urban";
          when rural => return "Rural";
       end case;
   end Pretty_Print;
   
   function Pretty_Print( i : Main_Dwelling_Type ) return String is
   begin
      case i is
          when dwelling_or_brick_structure_on_a_separate_stand_or_yard_or_on_farm => return "Dwelling or brick structure on a separate stand or yard or on farm";
          when traditional_dwelling_or_hut_or_structure_made_of_traditional_material => return "Traditional dwelling/hut/structure made of traditional material";
          when flat_or_apartment_in_a_block_of_flats => return "Flat or apartment in a block of flats";
          when town_or_cluster_or_semi_detached_house_simplex_duplex_or_triplex => return "Town/cluster/semi-detached house (simplex, duplex or triplex)";
          when unit_in_retirement_village => return "Unit in retirement village";
          when dwelling_or_flat_or_room_in_backyard => return "Dwelling/flat/room in backyard";
          when informal_dwelling_or_shack_in_backyard => return "Informal dwelling/shack in backyard  ";
          when informal_dwelling_or_shack_not_in_backyard_eg_in_an_informal_or_squatter_settlement_or_on_farm => return "Informal dwelling/shack not in backyard e.g. in an informal/squatter settlement or on farm";
          when room_or_flatlet_or_a_larger_dwelling_or_servants_quarters_or_granny_flat => return "Room/flatlet or a larger dwelling/servants quarters/granny flat";
          when caravan_or_tent => return "Caravan/tent";
          when workers_hostel => return "Workers’ hostel";
          when family_unit_formerly_workers_hostel => return "Family unit (formerly workers’ hostel)";
          when other_dwelling_type => return "Other Dwelling Type";
          when unspecified => return "Unspecified";
      end case;
   end Pretty_Print;
   
   
   function Pretty_Print( i : Ownership_Type ) return String is
   begin
      case i is
          when owns => return "Owns";
          when does_not_own_but_has_access_to => return "Does not own, but has access to";
          when neither_owns_nor_has_access => return "Neither owns nor has access";
          when unspecified => return "Unspecified";
      end case;
   end Pretty_Print;
   
   
   function Pretty_Print( i : Tenure_Type ) return String is
   begin
      case i is
          when owned_and_fully_paid_off => return "Owned and fully paid off";
          when owned_but_not_yet_fully_paid_off_eg_with_a_mortgage => return "Owned, but not yet fully paid off (e.g. with a mortgage)";
          when rented_as_part_of_employment_contract_of_household_member => return "Rented as part of employment contract of household member";
          when rented_not_as_part_of_employment_contract_of_household_member => return "Rented not as part of employment contract of household member";
          when occupied_rent_free_as_part_of_employment_contract_of_household_member => return "Occupied rent-free as part of employment contract of household member";
          when occupied_rent_free_not_as_part_of_employment_contract_of_household_member => return "Occupied rent-free not as part of employment contract of household member";
          when occupied_as_a_boarder_or_lodger => return "Occupied as a boarder/lodger";
          when other_tenure_type => return "Other";
          when unspecified => return "Unspecified";
      end case;
   end Pretty_Print;
   
   function Pretty_Print( p : Poverty_Type ) return String is
   begin
     case p is
        when extreme_poverty => return "Extreme poverty";
        when poverty => return "Poverty";
        when mild_poverty => return "Mild poverty";
        when not_in_poverty => return "Not in poverty";
     end case;
   end Pretty_Print;
   
   function Pretty_Print( i : Consumption_Type ) return String is
   begin
      case i is
          when Imputed_cost_for_home_production => return "Imputed Cost for home production";
          when In_kind_income_from_stationery_private_grant => return "In kind Income from Stationery private : Grant";
          when Other_insurance => return "Other insurance";
          when Stationery_and_drawing_materials => return "Stationery and drawing materials";
          when Subsidy_on_payment_of_mortgage => return "Subsidy on payment of mortgage";
          when Debts_bond_loan_from_the_bank => return "Debts Bond loan from the bank";
          when Taxes_paye_income_tax => return "Taxes : PAYE : income tax";
          when Savings_from_building_materials_not_included_in_q813 => return "Savings from Building materials not included in Q813";
          when In_kind_income_from_textbooks_for_private_institutions_grant => return "In kind Income from Textbooks for private institutions : Grant";
          when Debts_arreas_on_municipal_bills => return "Debts Arreas on municipal bills";
          when In_kind_income_from_estimated_value_of_private_use_of_company_vehicle => return "In kind Income from Estimated value of private use of company vehicle";
          when Income_interest_received => return "Income Interest received";
          when Beverages_in_restaurants_cafes_canteens_and_the_likes => return "Beverages in restaurants , cafes, canteens and the likes";
          when Taxes_site_income_tax => return "Taxes : SITE : income tax";
          when Water_supply => return "Water supply";
          when Other_medical_products => return "Other medical products";
          when Beer => return "Beer";
          when Savings_from_capital_payments => return "Savings from Capital payments";
          when Savings_from_improvements_additions_and_alterations => return "Savings from Improvements, additions and alterations";
          when In_kind_income_from_library_fees_fines_grant => return "In kind Income from library fees fines  : Grant";
          when Medical_services => return "Medical Services";
          when Domestics_services_and_household_arcticles => return "Domestics services and household arcticles";
          when Income_from_salaries_and_wages => return "Income from Salaries and wages";
          when Income_from_other_dividends => return "Income from Other Dividends";
          when Food_products_nec => return "Food products n.e.c.";
          when Milk_cheese_and_eggs => return "Milk, cheese and eggs";
          when Hairdressing_salons_and_personal_grooming_astablishment => return "Hairdressing salons and personal grooming astablishment";
          when Financial_services_nec => return "Financial services n.e.c";
          when Savings_from_deposits_into_savings => return "Savings from Deposits into savings";
          when Savings_from_other_payments => return "Savings from Other payments";
          when In_kind_income_from_schools_and_other_edu_inst_publice_grant => return "In kind Income from schools and other edu inst  Publice  : Grant";
          when Information_processing_equipment => return "Information processing equipment";
          when Meals_in_restaurants_cafes_canteens_and_the_likes => return "Meals in restaurants , cafes, canteens and the likes";
          when Accommodation_services => return "Accommodation services";
          when Recreational_and_sporting_services => return "Recreational and sporting services";
          when Scondary_education => return "Scondary education";
          when Debts_motor_vehicle_loan_from_the_bank => return "Debts Motor vehicle loan from the bank";
          when In_kind_income_from_other_specify_public_grant => return "In kind Income from Other, specify  public :  Grant";
          when In_kind_income_from_other_specify_private_grant => return "In kind Income from Other, specify  private :  Grant";
          when Insurance_connected_with_the_transport => return "Insurance connected with the transport";
          when Postal_services => return "Postal services";
          when Jewellery_clocks_and_watches => return "Jewellery, clocks and watches";
          when Interest_on_mortgage_bonds => return "Interest on mortgage bonds";
          when Savings_from_unit_trusts => return "Savings from Unit trusts";
          when Meat => return "Meat";
          when Paramedic_services => return "Paramedic services";
          when Savings_from_offshore => return "Savings from Offshore";
          when Savings_from_life_insurance_covering_mortgage_debt => return "Savings from Life insurance covering mortgage debt";
          when Income_from_pension_from_previous_employment => return "Income from Pension from previous employment";
          when Veterinary_and_other_services => return "Veterinary and other services";
          when Savings_from_life_and_endownment_policies => return "Savings from Life and endownment policies";
          when Major_household_appliances_wheter_or_no_aelectriccal => return "Major household appliances wheter or no aelectriccal";
          when Vegetables => return "Vegetables";
          when Bread_and_cereals => return "Bread and cereals";
          when Savings_from_security_structures => return "Savings from Security structures";
          when In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant => return "In kind Income from Teachers training and technical colleges, technikons boarding fees in public institutions : Grant";
          when Telephone_and_telefax_services => return "Telephone and telefax services";
          when Repair_of_household_appliance => return "Repair of household appliances";
          when Repair_and_hire_of_foowear => return "Repair and hire of foowear";
          when Savings_from_wthdrawals_from_savings => return "Savings from Withdrawals from savings";
          when Savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution => return "Savings from Contribution to pension, provident and annuity funds and Employer contribution";
          when In_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public => return "In kind Income from Schools boarding fees in public institutions : Grant  : public";
          when In_kind_income_from_textbooks_for_public_institutions_grant => return "In kind Income from Textbooks for public institutions : Grant";
          when In_kind_income_from_value_of_discounted_fares_for_educational_purposes => return "In kind Income from Value of discounted fares for educational purposes";
          when Therapeutic_appliances_and_equipment => return "Therapeutic appliances and equipment";
          when Electricity => return "Electricity";
          when Spirits => return "Spirits";
          when Oils_and_fats => return "Oils and fats";
          when Savings_from_contributions_to_a_stokvel => return "Savings from Contributions to a stokvel";
          when Savings_from_repayment_on_loans_and_overdrafts => return "Savings from Repayment on loans and overdrafts";
          when In_kind_income_from_universities_boarding_fees_in_private_institution_grant => return "In kind Income from Universities boarding fees in private institution : Grant";
          when Small_tools_and_miscellaneous_accessories => return "Small tools and miscellaneous accessories";
          when Spare_parts_and_accessories => return "Spare parts and accessories";
          when Pharmaceutical_products => return "Pharmaceutical products";
          when Debts_retail_stores => return "Debts Retail stores";
          when In_kind_income_from_stationery_public_grant => return "In kind Income from Stationery public : Grant";
          when In_kind_income_from_library_services_grant => return "In kind Income from Library services : Grant";
          when Income_from_annuities_from_own_investment => return "Income from Annuities from own investment";
          when Passenger_transport_by_air => return "Passenger transport by air";
          when Savings_from_purchase_and_levy_of_timeshare => return "Savings from Purchase  and Levy  of timeshare";
          when Savings_from_labour_and_material_for_improvements_additions_and_alterations => return "Savings from Labour and material for improvements, additions and alterations";
          when In_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private => return "In kind Income from computer certification ,Excursions and  Other Grants Public and Private";
          when Maintenance_and_repairs_of_personal_transport_equipment => return "Maintenance and repairs of personal transport equipment";
          when Hospital_services => return "Hospital services";
          when Other_personal_effects => return "Other personal effects";
          when Passenger_transport_by_sea_and_inland_waterway => return "Passenger transport by sea and inland waterway";
          when Actual_rentals_paid_by_tenants => return "Actual rentals paid by tenants";
          when In_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant => return "In kind Income from Universities boarding fees in private institution  and Medical aidby employer :  Grant";
          when Motor_cycles => return "Motor : cycles";
          when Furniture_and_furnishings => return "Furniture and furnishings";
          when Equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures => return "Equipment for the reception, recording and reproduction of sound and pictures";
          when Sewarage_collection => return "Sewarage collection";
          when Tertiary_education => return "Tertiary education";
          when Materials_for_maintenance_and_repair_of_the_dwelling => return "Materials for maintenance and repair of the dwelling";
          when Other_services_in_respect_of_personal_transport_equipment => return "Other services in respect of personal transport equipment";
          when Insurance_connected_with_the_health => return "Insurance connected with the health";
          when Water_and_electricity => return "Water and Electricity";
          when Other_puchased_transport_services => return "Other puchased transport services";
          when Carpets_and_other_floor_covering => return "Carpets and other floor covering";
          when Photographic_and_cinematographic_equipment_and_optical_instruments => return "Photographic and cinematographic equipment and optical instruments";
          when Gardens_plants_and_flowers => return "Gardens, plants and flowers";
          when Savings_from_services_for_improvements_additions_and_alterations => return "Savings from Services for improvements, additions and alterations(";
          when Unclassified_food_items => return "Unclassified food items";
          when Equipment_for_sport_camping_and_open_air_recreation => return "Equipment for sport, camping and open : air recreation";
          when Non_durable_household_goods => return "Non : durable household goods";
          when Debts_furniture_and_appliances_amount_oustanding => return "Debts Furniture and appliances : amount oustanding";
          when Gas => return "Gas";
          when Glassware_tableware_and_household_utensils => return "Gkassware,tableware and household utensils";
          when Small_electrical_household_appliance => return "Small electrical household appliance";
          when Consumption_others_expenditures => return "Consumption Others expenditures";
          when Taxes_according_to_assessment_income_tax => return "Taxes : According to assessment : income tax";
          when In_kind_income_from_schools_and_other_edu_inst_privat_grant => return "In kind Income from schools and other edu inst  Privat  : Grant";
          when Other_income => return "Other Income";
          when In_kind_consumption => return "In kind Consumption";
          when Newspaper_and_periodicals => return "Newspaper and periodicals";
          when Garments => return "Garments";
          when Debts_other_loans => return "Debts Other loans";
          when Savings_from_unlisted_company_shares => return "Savings from Unlisted company : shares";
          when In_kind_income_from_value_of_discounted_fares_for_non_educational_purposes => return "In kind Income from Value of discounted fares for non educational purposes";
          when Income_from_property => return "Income from property";
          when Major_durables_for_outdoor_recreation => return "Major durables for outdoor recreation";
          when Bicycles => return "Bicycles";
          when Taxes_unemployment_insurance_fund_uif => return "Taxes  : Unemployment insurance fund (UIF)";
          when Fuels_and_lubricants => return "Fuels and lubricants";
          when Cultural_services => return "Cultural services";
          when Mineral_waters_soft_drinks_fruit_and_vegetable_juices => return "Mineral waters, soft drinks, fruit and vegetable juices";
          when Consumption_unclassified_diary_items => return "Consumption Unclassified Diary Items";
          when Taxes_amnesty_tax => return "Taxes : Amnesty tax";
          when In_kind_income_from_free_sanitation => return "In kind Income from free Sanitation";
          when Income_from_royalties => return "Income from Royalties";
          when Household_textile => return "Household textile";
          when Other_appliances_articles_and_products_for_personal_care => return "Other appliances, articles and products for personal care";
          when Telephone_and_telefax_equipment => return "Telephone and telefax equipment";
          when Social_protection_services => return "Social protection services";
          when Savings_from_cost_of_other_dewlling => return "Savings from Cost of Other Dewlling";
          when Income_from_self_employment_and_business => return "Income from Self : employment and business";
          when Fruits => return "Fruits";
          when Coffee_tea_and_cocoa => return "Coffee, tea and cocoa";
          when Cost_for_other_modes_of_transport => return "cost for other modes of transport";
          when Animal_drawn_vehicle => return "Animal drawn vehicle";
          when Solid_fuels => return "Solid fuels";
          when Games_toys_and_hobbies => return "Games, toys and hobbies";
          when Pre_primary_and_primary_education => return "Pre : primary and primary education";
          when Tobacco => return "Tobacco";
          when Clothing_materials => return "Clothing materials";
          when Debts_bank_overdraft => return "Debts Bank overdraft";
          when Savings_from_monthly_capital_payments => return "Savings from Monthly capital payments";
          when Motor_cars => return "Motor : cars";
          when Elecrtical_appliances_for_personal_care => return "Elecrtical appliances for personal care";
          when Shoes_and_other_footwear => return "Shoes and other footwear";
          when Dental_services => return "Dental Services";
          when Pets_and_related_products => return "Pets and related products";
          when Savings_from_investment_plans => return "Savings from Investment plans";
          when In_kind_income_from_universities_boarding_fees_in_public_institution_grant => return "In kind Income from Universities boarding fees in public institution : Grant";
          when Income_from_alimony_palimony_and_other_allowances => return "Income from Alimony, palimony and other allowances";
          when Income_from_social_pensions => return "Income from Social pensions";
          when Imputed_rentals_of_owner_occupiers => return "Imputed rentals of owner : occupiers";
          when Other_articles_of_clothing_and_clothing_accessories => return "Other articles of clothing and clothing accessories";
          when Cleaning_repair_and_hire_of_clothing => return "Cleaning, repair and hire of clothing";
          when Liquid_fuels => return "Liquid fuels";
          when Miscellaneous_printed_matter => return "Miscellaneous printed matter";
          when Major_tools_and_equipment => return "Major tools and equipment";
          when Savings_from_other_investments => return "Savings from Other investments";
          when In_kind_income_from_free_water => return "In kind Income from free Water";
          when Income_from_dividends => return "Income from Dividends";
          when Passenger_transport_by_railway => return "Passenger transport by railway";
          when Games_of_chances => return "Games of chances";
          when Sugar_jam_honey_chocolate_and_confectionery => return "Sugar, jam, honey, chocolate and confectionery";
          when Debts_other_bank_loans => return "Debts Other bank loans";
          when Savings_from_listed_company_shares => return "Savings from Listed company : shares";
          when In_kind_income_from_free_electricity => return "In kind Income from free Electricity";
          when Recording_meedia => return "Recording meedia";
          when Maintenance_and_repair_of_other_major_durables_for_recreation_and_culture => return "Maintenance and repair of other major durables for recreation and culture";
          when Other_products_not_consumption => return "Other Products not Consumption";
          when Debts_loans_from_money_lenders => return "Debts Loans from money lenders";
          when Other_services => return "Other services";
          when Refuse_collection => return "Refuse collection";
          when Other_services_relating_to_the_dwelling => return "Other services relating to the dwelling";
          when Education_not_definable_by_level => return "Education not definable by level";
          when Insurance_connected_with_the_dwelling => return "Insurance connected with the dwelling";
          when Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party => return "Panel : beating repairs Paid for by your insurance company or other party";
          when Loss_expenditure_incurred_in_obtaining_income => return "Loss Expenditure incurred in obtaining income";
          when Transfer_toothers => return "Transfer ToOthers";
          when Income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling => return "Income from imputed rent on owned dwellingI 7% Per Year of Dwelling";
          when Passenger_transport_by_road => return "Passenger transport by road";
          when Service_of_the_maintenance_and_repair_of_the_dwelling => return "Service of the maintenance and repair of the dwelling";
          when Wine => return "Wine";
          when Debts_loans_from_friends_and_family => return "Debts Loans from friends and family";
          when In_kind_income_from_pre_primary_primary_education_and_vocational_training_grants_public_and_private => return "In kind Income from Pre : primary,Primary, Tertiary education and Vocational training Grants Public and Private";
          when In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant => return "In kind Income from Teachers training and technical colleges, technikons boarding fees in private institutions : Grant";
          when In_kind_income_from_schools_boarding_fees_in_private_institutions_grant => return "In kind Income from Schools boarding fees in private institutions : Grant";
          when Other_income_from_individuals => return "Other Income from Individuals";
          when Package_holidays => return "Package holidays";
          when Fish => return "Fish";
          when Books => return "Books";
          when Musical_instrument_and_major_durables_for_outdoor_recreation => return "Musical instrument and major durables for outdoor recreation";
          when Repair_of_furniture_furnishings_and_floor_covering => return "Repair of furniture, furnishings and floor covering";
      end case;
   end Pretty_Print;

end ZA.Model_Types;
 
