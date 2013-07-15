package EIS_Definitions is

   type Gender_Type is (  
      missing,
      male,
      female );

   function Pretty_Print( i : Gender_type ) return String;

   function Convert_Gender_type( i : String ) return Gender_type;

   type Yes_No_Type is (  
      missing,
      yes,
      no );

   function Pretty_Print( i : Yes_No_Type ) return String;
   function Convert_Yes_No_Type( i : String ) return Yes_No_Type;
  
   type Yes_No_Unspecified_Type is (  
      missing,
      yes,
      no,
      unspecified );

   function Pretty_Print( i : Yes_No_Unspecified_Type ) return String;
   function Convert_Yes_No_Unspecified_Type( i : String ) return Yes_No_Type;
  
   type Tobacco1_Type is (  
      missing,
      smoking,
      not_smoking );

   function Pretty_Print( i : Tobacco1_Type ) return String;
   function Convert_Tobacco1_Type( i : String ) return Tobacco1_Type;

   function Pretty_Print( i : Tobacco1_Type ) return String;

   function Convert_Tobacco1_Type( i : String ) return Tobacco1_Type;
      
   type Tobacco2_Type is (  
      missing,
      not_smoking_cigarettes,
      yes_cigarettes,
      not_applicable );
   function Convert_Tobacco2_Type( i : String ) return Tobacco2_Type;
   function Pretty_Print( i : Tobacco2_Type ) return String;

   type Tobacco3_Type is (  
      missing,
      not_smoking_cigars,
      yes_cigars,
      not_applicable );
   function Convert_Tobacco3_Type( i : String ) return Tobacco3_Type;

   type Tobacco4_Type is (  
      missing,
      not_using_other_tobacco_products,
      yes_tobacco,
      not_applicable );

   function Pretty_Print( i : Tobacco4_type ) return String;
   function Convert_Tobacco4_type( i : String ) return Tobacco4_type;

   type Tobacco5_Type is (  
      missing,
      not_using_other_items_for_smoking,
      yes_other,
      not_applicable );

   function Pretty_Print( i : Tobacco5_type ) return String;
   function Convert_Tobacco5_type( i : String ) return Tobacco5_type;

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
      other );

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
      other_specify );

   function Pretty_Print( i : Dwelling_Type ) return String;

   function Convert_Dwelling_Type( i : String ) return Dwelling_Type;
   type Gender is (  
      missing,
      male,
      female,
      not_applicable );

   function Pretty_Print( i : Gender ) return String;
   function Convert_Gender( i : String ) return Gender;

   type Racial_Group is (  -- Q112popgroup_Typ
      missing,
      african_or_black,
      coloured,
      indian_or_asian,
      white,
      other,
      not_applicable );
      
   function Pretty_Print( i : Racial_Group ) return String;
   function Convert_Racial_Group( i : String ) return Racial_Group;
  
     function Convert_Q115moneyuse11_type( i : String ) return Q115moneyuse11_type;
   type Area_Of_Purchase is (  
      missing,
      not_applicable,
      in_the_town_or_city_where_the_household_lives,
      in_another_town_or_city_away_from_where_the_household_lives
);

   function Pretty_Print( i : Area_Of_Purchase ) return String;


   function Convert_Area_Of_Purchase( i : String ) return Area_Of_Purchase;
   type Retailer_Type is (  
      missing,
      formal_sector_chain_store,
      formal_sector_other_retailer,
      informal_sector_street_trading,
      informal_sector_other,
      not_applicable
);

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
      mpumalanga );

   function Pretty_Print( i : Province_Type ) return String;
   function Convert_Province( i : String ) return Province;

   type Settlement_Type is (  
      missing,
      urban );

   function Pretty_Print( i : Settlement_type ) return String;
   function Convert_Settlement_type( i : String ) return Settlement_type;

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
      november );

   function Pretty_Print( i : Survey_Month ) return String;

   function Convert_Survey_Month( i : String ) return Survey_Month;
   
   type Dwelling_Type is (  -- Dwelling_Type 
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
      other );

   function Pretty_Print( i : Dwelling_Type ) return String;
   function Convert_Dwelling_Type( i : String ) return Dwelling_Type;

   type Materials_Type is (  
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
      other );

   function Pretty_Print( i : Materials_Type ) return String;
   function Convert_Materials_Type( i : String ) return Materials_Type;
  
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
      none );

   function Pretty_Print( i : Toilet_Type ) return String;


   function Convert_Toilet_Type( i : String ) return Toilet_Type;
 
    type Energy_Type is (  -- Energy_Type
      missing,
      electricity_from_mains,
      electricity_from_generator,
      gas,
      paraffin,
      wood,
      coal,
      animal_dung,
      electricity_from_solar,
      other,
      none );

   function Pretty_Print( i : Energy_Type ) return String;
   
   function Convert_Energy_Type( i : String ) return Energy_Type;
   type Refuse_Type is (  
      missing,
      removed_by_local_authority_at_least_once_a_week,
      removed_by_local_authority_less_often_than_once_a_week,
      removed_by_community_members_at_least_once_a_week,
      removed_by_community_members_less_often_than_once_a_week,
      communal_refuse_dump_or_communal_container,
      own_refuse_dump,
      no_rubbish_removal,
      other );

   function Pretty_Print( i : Refuse_Type ) return String;
   function Convert_Refuse_Type( i : String ) return Refuse_Type;

   type Ownership_Type is (  
      missing,
      owns,
      does_not_own_but_has_access_to,
      neither_owns_nor_has_access );

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
      other );

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
      other );


end EIS_Definitions;
