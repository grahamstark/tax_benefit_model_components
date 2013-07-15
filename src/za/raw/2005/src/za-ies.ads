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

with Coicop_Definitions;
--
-- Interface to the Income and expenditure of households (IES) dataset, 2005/2006
--
-- 
package ZA.IES is
   use Coicop_Definitions;
  
   subtype Room_Count is Natural range 0 .. 9; 
   -- nb in data 0 .. 4 or 0..9 depending on room but we'll standardise
   
   subtype Person_Count is Natural range 0 .. 24;
   subtype Person_Range is Person_Count range 1 .. Person_Count'Last;

   subtype Supported_Persons_Range is Positive range 1 .. 10; -- See: DATA FILE: SUPPORTED_PERSONS
   subtype Product_Code_Range is Positive range 1 .. 23; -- see Metadata.doc - DATA FILE: PURCHASE_PLACE
   
   type Age_Group_Type is (  
      missing,
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
   function Convert_Age_Group_Type( i : String ) return Age_Group_Type;
   
   type Gender_Type is (  
      missing,
      male,
      female,
      unspecified );
   function Pretty_Print( i : Gender_Type ) return String;
   function Convert_Gender_Type( i : String ) return Gender_Type;


    type Week2_spentw2_Type is (  
      missing,
      yes,
      no,
      unspecified );
   function Pretty_Print( i : Week2_spentw2_Type ) return String;
   function Convert_Week2_spentw2_Type( i : String ) return Week2_spentw2_Type;


    type Yes_No_Unspecified_Type is (  
      missing,
      yes,
      no,
      unspecified );
   function Pretty_Print( i : Yes_No_Unspecified_Type ) return String;
   function Convert_Yes_No_Unspecified_Type( i : String ) return Yes_No_Unspecified_Type;


    type Tobacco1_Type is (  
      missing,
      smoking,
      not_smoking,
      unspecified );
   function Pretty_Print( i : Tobacco1_Type ) return String;
   function Convert_Tobacco1_Type( i : String ) return Tobacco1_Type;


    type Tobacco2_Type is (  
      missing,
      not_smoking_cigarettes,
      yes_cigarettes,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Tobacco2_Type ) return String;
   function Convert_Tobacco2_Type( i : String ) return Tobacco2_Type;


    type Tobacco3_Type is (  
      missing,
      not_smoking_cigars,
      yes_cigars,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Tobacco3_Type ) return String;
   function Convert_Tobacco3_Type( i : String ) return Tobacco3_Type;


    type Tobacco4_Type is (  
      missing,
      not_using_other_tobacco_products,
      yes_tobacco,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Tobacco4_Type ) return String;
   function Convert_Tobacco4_Type( i : String ) return Tobacco4_Type;


    type Tobacco5_Type is (  
      missing,
      not_using_other_items_for_smoking,
      yes_other,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Tobacco5_Type ) return String;
   function Convert_Tobacco5_Type( i : String ) return Tobacco5_Type;


    type Education_Level is (  
      missing,
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
      xother,
      dont_know_or_unspecified );
   function Pretty_Print( i : Education_Level ) return String;
   function Convert_Education_Level( i : String ) return Education_Level;


    type Dwelling_Type is (  
      missing,
      boarding_school_or_university_hostel,
      old_age_home,
      frail_care_centre,
      home_for_the_disabled,
      initiation_school,
      prison,
      retirement_village,
      hospital_or_medical_facility_or_clinic,
      private_house,
      other_specify,
      unspecified );
   function Pretty_Print( i : Dwelling_Type ) return String;
   function Convert_Dwelling_Type( i : String ) return Dwelling_Type;


    type Gender2 is (  
      missing,
      male,
      female,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Gender2 ) return String;
   function Convert_Gender2( i : String ) return Gender2;


    type Population_Group is (  
      missing,
      african_or_black,
      coloured,
      indian_or_asian,
      white,
      xother,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Population_Group ) return String;
   function Convert_Population_Group( i : String ) return Population_Group;


    type Yes_No_NA_Unspecified is (  
      missing,
      yes,
      no,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Yes_No_NA_Unspecified ) return String;
   function Convert_Yes_No_NA_Unspecified( i : String ) return Yes_No_NA_Unspecified;


    type Area_Of_Purchase is (  
      missing,
      not_applicable,
      in_the_town_or_city_where_the_household_lives,
      in_another_town_or_city_away_from_where_the_household_lives,
      in_the_rural_area );
   function Pretty_Print( i : Area_Of_Purchase ) return String;
   function Convert_Area_Of_Purchase( i : String ) return Area_Of_Purchase;


    type Retailer_Type is (  
      missing,
      formal_sector_chain_store,
      formal_sector_other_retailer,
      informal_sector_street_trading,
      informal_sector_other,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Retailer_Type ) return String;
   function Convert_Retailer_Type( i : String ) return Retailer_Type;


    type Province_Type is (  
      missing,
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
   function Convert_Province_Type( i : String ) return Province_Type;


    type Settlement_Type is (  
      missing,
      urban,
      rural );
   function Pretty_Print( i : Settlement_Type ) return String;
   function Convert_Settlement_Type( i : String ) return Settlement_Type;


    type Survey_Month is (  
      missing,
      january,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september,
      october,
      november,
      december );
   function Pretty_Print( i : Survey_Month ) return String;
   function Convert_Survey_Month( i : String ) return Survey_Month;


    type Population_Group_Of_Head is (  
      missing,
      african_or_black,
      coloured,
      indian_or_asian,
      white,
      unspecified );
   function Pretty_Print( i : Population_Group_Of_Head ) return String;
   function Convert_Population_Group_Of_Head( i : String ) return Population_Group_Of_Head;


    type Q16support_Type is (  
      missing,
      yes,
      no );
   function Pretty_Print( i : Q16support_Type ) return String;
   function Convert_Q16support_Type( i : String ) return Q16support_Type;


    type Main_Dwelling_Type is (  
      missing,
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
      xother,
      unspecified );
   function Pretty_Print( i : Main_Dwelling_Type ) return String;
   function Convert_Main_Dwelling_Type( s : String ) return Main_Dwelling_Type;


    type Wall_Materials_Type is (  
      missing,
      bricks,
      cement_block_or_concrete,
      corrugated_iron_or_zinc,
      wood,
      plastic,
      cardboard,
      mixture_of_mud_and_cement,
      wattle_and_daub,
      tile,
      mud,
      thatching,
      asbestos,
      xother,
      unspecified );
   function Pretty_Print( i : Wall_Materials_Type ) return String;
   function Convert_Wall_Materials_Type( s : String ) return Wall_Materials_Type;


    type Yes_No_Dont_Know_Type is (  
      missing,
      yes,
      no,
      dont_know_or_unspecified );
   function Pretty_Print( i : Yes_No_Dont_Know_Type ) return String;
   function Convert_Yes_No_Dont_Know_Type( i : String ) return Yes_No_Dont_Know_Type;


    type Toilet_Type is (  
      missing,
      flush_toilet_in_dwelling_with_offsite_disposal,
      flush_toilet_on_site_with_offsite_disposal,
      flush_toilet_off_site_with_offsite_disposal,
      flush_toilet_in_dwelling_with_onsite_disposal_septic_tank,
      flush_toilet_on_site_with_onsite_disposal_septic_tank,
      flush_toilet_off_site_with_onsite_disposal_septic_tank,
      chemical_toilet_on_site,
      chemical_toilet_off_site,
      pit_latrine_on_site_with_ventilation_pipe,
      pit_latrine_off_site_with_ventilation_pipe,
      pit_latrine_on_site_without_ventilation_pipe,
      pit_latrine_off_site_without_ventilation_pipe,
      bucket_toilet_on_site,
      bucket_toilet_off_site,
      none,
      unspecified );
   function Pretty_Print( i : Toilet_Type ) return String;
   function Convert_Toilet_Type( s : String ) return Toilet_Type;


    type Q36sharetoilet_Type is (  
      missing,
      yes,
      no,
      unspecified_or_not_applicable );
   function Pretty_Print( i : Q36sharetoilet_Type ) return String;
   function Convert_Q36sharetoilet_Type( s : String ) return Q36sharetoilet_Type;


    type Energy_For_Cooking_Type is (  
      missing,
      electricity_from_mains,
      electricity_from_generator,
      gas,
      paraffin,
      wood,
      coal,
      animal_dung,
      electricity_from_solar,
      xother,
      none,
      unspecified );
   function Pretty_Print( i : Energy_For_Cooking_Type ) return String;
   function Convert_Energy_For_Cooking_Type( s : String ) return Energy_For_Cooking_Type;


    type Energy_For_Heat_Type  is (  
      missing,
      electricity_from_mains,
      electricity_from_generator,
      gas,
      paraffin,
      wood,
      coal,
      candles,
      animal_dung,
      electricity_from_solar,
      xother,
      none,
      unspecified );
   function Pretty_Print( i : Energy_For_Heat_Type ) return String;
   function Convert_Energy_For_Heat_Type( s : String ) return Energy_For_Heat_Type;


    type Energy_For_Lighting_Type is (  
      missing,
      electricity_from_mains,
      electricity_from_generator,
      gas,
      paraffin,
      candles,
      electricity_from_solar,
      xother,
      none,
      unspecified );
   function Pretty_Print( i : Energy_For_Lighting_Type ) return String;
   function Convert_Energy_For_Lighting_Type( s : String ) return Energy_For_Lighting_Type;


    type Refuse_Type is (  
      missing,
      removed_by_local_authority_at_least_once_a_week,
      removed_by_local_authority_less_often_than_once_a_week,
      removed_by_community_members_at_least_once_a_week,
      removed_by_community_members_less_often_than_once_a_week,
      communal_refuse_dump_or_communal_container,
      own_refuse_dump,
      no_rubbish_removal,
      xother,
      unspecified );
   function Pretty_Print( i : Refuse_Type ) return String;
   function Convert_Refuse_Type( i : String ) return Refuse_Type;


    type Ownership_Type is (  
      missing,
      owns,
      does_not_own_but_has_access_to,
      neither_owns_nor_has_access,
      unspecified );
   function Pretty_Print( i : Ownership_Type ) return String;
   function Convert_Ownership_Type( i : String ) return Ownership_Type;


    type Tenure_Type is (  
      missing,
      owned_and_fully_paid_off,
      owned_but_not_yet_fully_paid_off_eg_with_a_mortgage,
      rented_as_part_of_employment_contract_of_household_member,
      rented_not_as_part_of_employment_contract_of_household_member,
      occupied_rent_free_as_part_of_employment_contract_of_household_member,
      occupied_rent_free_not_as_part_of_employment_contract_of_household_member,
      occupied_as_a_boarder_or_lodger,
      xother,
      unspecified );
   function Pretty_Print( i : Tenure_Type ) return String;
   function Convert_Tenure_Type( i : String ) return Tenure_Type;


    type Resultcode_Type is (  
      missing,
      completed,
      non_contact,
      refused,
      partly_complete,
      no_usable_information_comment,
      vacant_dwelling,
      listing_error,
      xother,
      ended_at_question_b );
   function Pretty_Print( i : Resultcode_Type ) return String;
   function Convert_Resultcode_Type( i : String ) return Resultcode_Type;
   
   type Support_Age_Group_Type is (  
      missing,
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
      age_60_to_64_years,
      age_65_to_69_years,
      age_70_to_74_years,
      age_75_plus,
      not_applicable,
      unspecified );
   function Pretty_Print( i : Support_Age_Group_Type ) return String;
   function Convert_Support_Age_Group_Type( i : String ) return Support_Age_Group_Type;

   type  Person_Info is record
      uqno : Sernum_Value := Sernum_Value'First;
      Personno : Integer := 0;
      Gender : Gender_Type := Gender_Type'First;
      Agegrp : Age_Group_Type := Age_Group_Type'First;
      Popgrp : Population_Group := Population_Group'First;
      Week2_spentw2 : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Week3_spentw3 : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Week4_spentw4 : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Week5_spentw5 : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a01srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a02srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a03srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a04srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a05srcinc : Yes_No_Unspecified_Type := Yes_No_Unspecified_Type'First;
      Q11a07srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a08srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a09srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a10srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a11srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a12srcinc : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q11a13srcinc : Integer := 0;
      Q12tobacco1 : Tobacco1_Type := Tobacco1_Type'First;
      Q12tobacco2 : Tobacco2_Type := Tobacco2_Type'First;
      Q12tobacco3 : Tobacco3_Type := Tobacco3_Type'First;
      Tobacco4 : Tobacco4_Type := Tobacco4_Type'First;
      Tobacco5 : Tobacco5_Type := Tobacco5_Type'First;
      Q13read : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q14write : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q15higheduc : Education_Level := Education_Level'First;
      Weight : Amount := 0.0;
  end record;
  
  function To_String( rec : Person_Info ) return String;
  
  type Supported_Persons is record
      uqno : Sernum_Value := Sernum_Value'First;
      Personsupported : Supported_Persons_Range := Supported_Persons_Range'First;
      Agegrp : Support_Age_Group_Type := Support_Age_Group_Type'First;
      Q19dwelltype : Dwelling_Type := Dwelling_Type'First;
      Q110gender : Gender2 := Gender2'First;
      Q112popgroup : Population_Group := Population_Group'First;
      Q113support1 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support2 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support3 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support4 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support5 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support6 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support7 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support8 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q113support9 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q114finaid : Integer := 0;
      Q115moneyuse1 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse2 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse3 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse4 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse5 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse6 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse7 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse8 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse9 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse10 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
      Q115moneyuse11 : Yes_No_NA_Unspecified := Yes_No_NA_Unspecified'First;
   end record;
   
   function To_String( rec : Supported_Persons ) return String;
   
   type Purchase_Place is record
      uqno : Sernum_Value := Sernum_Value'First;
      Prodcode : Product_Code_Range := Product_Code_Range'First;
      Q21aareapurch : Area_Of_Purchase := Area_Of_Purchase'First;
      Q21btyperetailer : Retailer_Type := Retailer_Type'First;
      Weight : Amount := 0.0;
   end record;
   
   function To_String( rec : Purchase_Place ) return String;
   
   type House_Info is record
      uqno : Sernum_Value := Sernum_Value'First;
      Prov : Province_Type := Province_Type'First;
      Settlement : Settlement_Type := Settlement_Type'First;
      Surveyyear : Integer := 0;
      Surveymonth : Survey_Month := Survey_Month'First;
      Hsize : Integer := 0;
      Popgrpofhead : Population_Group_Of_Head := Population_Group_Of_Head'First;
      Genderofhead : Gender_Type := Gender_Type'First;
      Q16support : Q16support_Type := Q16support_Type'First;
      Q17numsupport : Integer := 0;
      Q31dwelltypemain : Main_Dwelling_Type := Main_Dwelling_Type'First;
      Q31dwelltypeoth : Main_Dwelling_Type := Main_Dwelling_Type'First;
      Q32materialwalls : Wall_Materials_Type := Wall_Materials_Type'First;
      Q32materialroof : Wall_Materials_Type := Wall_Materials_Type'First;
      Q33govgrant : Yes_No_Dont_Know_Type := Yes_No_Dont_Know_Type'First;
      Q35typetoilet : Toilet_Type := Toilet_Type'First;
      Q36sharetoilet : Q36sharetoilet_Type := Q36sharetoilet_Type'First;
      Q37streetlight : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q38elecsupply : Week2_spentw2_Type := Week2_spentw2_Type'First;
      Q39energycook : Energy_For_Cooking_Type := Energy_For_Cooking_Type'First;
      Q39energyheat : Energy_For_Heat_Type := Energy_For_Heat_Type'First;
      Q39energylight : Energy_For_Lighting_Type := Energy_For_Lighting_Type'First;
      Q310refuse : Refuse_Type := Refuse_Type'First;
      Radio : Ownership_Type := Ownership_Type'First;
      Stereo_hifi : Ownership_Type := Ownership_Type'First;
      Tape_recorder : Ownership_Type := Ownership_Type'First;
      Television : Ownership_Type := Ownership_Type'First;
      Video_cassette_recorder_dvd : Ownership_Type := Ownership_Type'First;
      Refrigerator_freezer : Ownership_Type := Ownership_Type'First;
      Stove_gas_or_electric : Ownership_Type := Ownership_Type'First;
      Microwave : Ownership_Type := Ownership_Type'First;
      Washing_machine : Ownership_Type := Ownership_Type'First;
      Motor_vehicle : Ownership_Type := Ownership_Type'First;
      Motor_cycle_scooter : Ownership_Type := Ownership_Type'First;
      Sewing_knitting_machine : Ownership_Type := Ownership_Type'First;
      Donkey_cart_ox_cart : Ownership_Type := Ownership_Type'First;
      Plough : Ownership_Type := Ownership_Type'First;
      Tractor : Ownership_Type := Ownership_Type'First;
      Wheelbarrow : Ownership_Type := Ownership_Type'First;
      Grinding_mill : Ownership_Type := Ownership_Type'First;
      Bicycle : Ownership_Type := Ownership_Type'First;
      Computer : Ownership_Type := Ownership_Type'First;
      Canoe_boat : Ownership_Type := Ownership_Type'First;
      Motorboat : Ownership_Type := Ownership_Type'First;
      Camera : Ownership_Type := Ownership_Type'First;
      Bed : Ownership_Type := Ownership_Type'First;
      Cellular_telephone : Ownership_Type := Ownership_Type'First;
      Landline_telephone : Ownership_Type := Ownership_Type'First;
      Satellite_dish : Ownership_Type := Ownership_Type'First;
      Internet : Ownership_Type := Ownership_Type'First;
      Q41aoccrooms : Integer := 0;
      Q41anorooms : Integer := 0;
      Q41boccrooms : Integer := 0;
      Q41bnorooms : Integer := 0;
      Q41coccrooms : Integer := 0;
      Q41cnorooms : Integer := 0;
      Q41dnorooms : Integer := 0;
      Q41eoccrooms : Integer := 0;
      Q41enorooms : Integer := 0;
      Q41foccrooms : Integer := 0;
      Q41fnorooms : Integer := 0;
      Q42nocars : Integer := 0;
      Q44value : Integer := 0;
      Q44valueimputed : Integer := 0;
      Q45ownrent : Tenure_Type := Tenure_Type'First;
      Q41totoccrooms : Integer := 0;
      Q41totnorooms : Integer := 0;
      Consumptions : Amount := 0.0;
      Inkindconsumptions : Amount := 0.0;
      Income : Amount := 0.0;
      Inkindincome : Amount := 0.0;
      Resultcode : Resultcode_Type := Resultcode_Type'First;
      Weight : Amount := 0.0;
   end record;
   
   function To_String( rec : House_Info ) return String;
   
   type Total_IES is record
      uqno : Sernum_Value := Sernum_Value'First;
      Coicop : Coicop_Type := Coicop_Type'First;
      Valuemain : Amount := 0.0;
      Valuediary : Amount := 0.0;
      Value : Amount := 0.0;
      Valuemainannualized : Amount := 0.0;
      ValueDiaryannualized : Amount := 0.0;
      Valueannualized : Amount := 0.0;
      Weight : Amount := 0.0;
   end record;
   
   function To_String( rec : Total_IES ) return String;
   
   type Person_Income is record
      uqno : Sernum_Value := Sernum_Value'First;
      Personno : Integer := 0;
      Coicop : Coicop_Type := Coicop_Type'First;
      Value : Amount := 0.0;
      Weight : Amount := 0.0;
   end record;
  
   function To_String( rec : Person_Income ) return String;


   type Person_Income_Array is array( Personal_Income_Range ) of Person_Income;
   
   type Person_Rec is record
      person_income : Person_Income_Array;
      info : Person_Info;
   end record;
   
   type Person_Array is array( Person_Range ) of Person_Rec;
   type Supported_Persons_Array is array( Supported_Persons_Range ) of Supported_Persons;
   type Total_IES_Array is array( Coicop_Type ) of Total_IES;
   type Purchase_Place_Array is array ( Product_Code_Range ) of Purchase_Place;  
   type Household is record
      num_people             : Person_Count := 0;
      person                 : Person_Array;
      housing                : House_Info;
      supported              : Supported_Persons_Array;
      place_of_purchase      : Purchase_Place_Array;
      expenditure_and_income : Total_IES_Array;
   end record;
   
   function To_String( hh : Household ) return String;
   
   
end ZA.IES;
