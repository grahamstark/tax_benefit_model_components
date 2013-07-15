--
--
with Base_Model_Types; use Base_Model_Types;
with T_Utils;

package Coicop_Definitions is

   type Coicop_Type is (  
      missing,
      rice,            --  01111101
      white_bread,            --  01112101
      brown_bread,            --  01112102
      garlic_bread,            --  01112103
      whole_wheat_bread,            --  01112104
      other_bread_loaves,            --  01112105
      bread_rolls,            --  01112201
      rusks,            --  01112301
      marie_biscuits,            --  01112302
      other_biscuits,            --  01112303
      crackers,            --  01112304
      other_baked_products,            --  01112305
      spaghetti,            --  01113101
      macaroni,            --  01113102
      other_pasta,            --  01113103
      cakes,            --  01114101
      tarts,            --  01114102
      other_vetkoek_fat_cakes,            --  01114103
      sandwiches,            --  01115101
      mealie_meal_or_maize_flour,            --  01116101
      cake_flour,            --  01116102
      self_raising_meal,            --  01116103
      bread_flour,            --  01116104
      sorghum_meal_or_powder,            --  01116105
      corn_flour,            --  01116106
      other_meal_and_flour,            --  01116107
      taystee_wheat,            --  01116201
      mabella,            --  01116202
      corn_flakes,            --  01116301
      puffed_rice,            --  01116302
      muesli,            --  01116303
      other_baked_cereals,            --  01116304
      mealie_rice,            --  01116401
      samp,            --  01116402
      other_grain_products_pies_except_meat_pies_and_fruit_pies,            --  01116501
      maize,            --  66111101
      wheat,            --  66111201
      other_grains,            --  66111301
      beef_and_veal_incl_heads_and_feet,            --  01121000
      pork_incl_heads_and_feet,            --  01122000
      mutton_incl_heads_and_feet,            --  01123000
      lamb_incl_heads_and_feet,            --  01123200
      goat_incl_heads_and_feet,            --  01123300
      poultry_incl_heads_and_feet,            --  01124100
      boerewors,            --  01125101
      pork_sausage,            --  01125102
      beef_sausage,            --  01125103
      other_sausages_chicken_game_etc,            --  01125104
      viennas,            --  01125201
      polony,            --  01125202
      ham,            --  01125203
      bacon,            --  01125204
      other_processed_meat_russians,            --  01125205
      biltong,            --  01125301
      dried_sausages,            --  01125302
      mopane_worms,            --  01125303
      pre_cooked_frozen_meat,            --  01126101
      meat_spread_marmite,            --  01126102
      beef_extract_cubes,            --  01126401
      chicken_extract_cubes,            --  01126402
      other_meat_and_meat_products_including_meat_pies,            --  01126501
      meat_patties,            --  01126601
      other_meat_incl_heads_and_feet,            --  01127100
      cattle,            --  66211101
      sheep,            --  66211201
      pigs,            --  66211301
      goats,            --  66211401
      poultry,            --  66211501
      fresh_or_chilled_fish,            --  01131100
      frozen_fish,            --  01131200
      fresh_or_chilled_seafood,            --  01132100
      frozen_shrimps,            --  01132201
      frozen_lobster,            --  01132202
      frozen_mixed_seafood,            --  01132203
      dried_fish,            --  01133101
      smoked_fish,            --  01133201
      fish_cakes,            --  01134101
      fish_fingers,            --  01134102
      fish_portions,            --  01134103
      fish_paste,            --  01134201
      canned_tuna,            --  01134301
      canned_pilchards,            --  01134302
      other_canned_fish,            --  01134303
      other_preserved_or_processed_fish_and_seafood,            --  01134400
      fresh_full_cream_milk,            --  01141101
      longlife_full_cream_milk,            --  01141201
      fresh_low_fat_milk,            --  01142101
      longlife_low_fat_milk,            --  01142201
      condensed_milk,            --  01143101
      evaporated_milk,            --  01143201
      powdered_milk,            --  01143301
      whiteners_cremora_ellis_brown,            --  01143401
      plain_yogurt,            --  01144101
      flavoured_yogurt,            --  01144201
      cheddar_cheese,            --  01145101
      gouda_cheese,            --  01145201
      white_cheese,            --  01145301
      cottage_cheese,            --  01145401
      cheese_spread,            --  01145501
      other_cheese_specify,            --  01145601
      fresh_cream,            --  01146101
      butter_milk,            --  01146201
      sour_milk_or_maas,            --  01146301
      soya_milk,            --  01146401
      prepared_custard_eg_ultramel,            --  01146501
      amageu,            --  01146601
      other_milk_products,            --  01146701
      jumbo_eggs,            --  01147101
      extra_large_eggs,            --  01147201
      large_eggs,            --  01147301
      medium_eggs,            --  01147401
      milk,            --  66111401
      eggs,            --  66111501
      butter,            --  01151101
      medium_fat_margarine_spread,            --  01152101
      low_fat_margarine_spread,            --  01152102
      yellow_brick_margarine,            --  01152103
      peanut_butter,            --  01152201
      cooking_fat_vegetable_eg_holsum,            --  01152301
      olive_oils,            --  01153100
      edible_oils_eg_cooking_oils,            --  01154101
      other_edible_animal_fats_eg_lard,            --  01155101
      fruit,            --  66111601
      oranges,            --  01161101
      naartjies,            --  01161201
      grapefruit,            --  01161301
      lemons,            --  01161401
      other_citrus,            --  01161501
      bananas,            --  01162101
      apples,            --  01163101
      pears,            --  01164101
      apricots,            --  01165101
      peaches,            --  01165201
      plums,            --  01165301
      avocados,            --  01165401
      cherries,            --  01165501
      other_stone_fruit,            --  01165601
      grapes,            --  01166101
      strawberries,            --  01166201
      other_specify_berries,            --  01166301
      paw_paw,            --  01167101
      pineapple,            --  01167201
      mango,            --  01167301
      guava,            --  01167401
      watermelon,            --  01167501
      melon,            --  01167601
      other_specify_tropical_fruit,            --  01167701
      peaches_dried,            --  01168101
      prunes_dried,            --  01168102
      raisins,            --  01168103
      dates,            --  01168104
      other_dried_fruit,            --  01168105
      assorted_dried_fruit,            --  01168106
      coconut,            --  01168201
      almonds,            --  01168202
      pecan_nuts,            --  01168203
      walnuts,            --  01168204
      peanuts,            --  01168205
      other_nuts_specify,            --  01168206
      canned_pears,            --  01169101
      canned_peaches,            --  01169102
      canned_guavas,            --  01169103
      canned_fruit_cocktail,            --  01169104
      canned_granadilla_pulp,            --  01169105
      other_specify_lemon_juice,            --  01169106
      vegetables,            --  66111701
      lettuce,            --  01171101
      spinach_or_morogo_fresh,            --  01171102
      cabbage_fresh,            --  01172101
      cauliflower_fresh,            --  01172102
      broccoli_fresh,            --  01172103
      cauliflower_frozen,            --  01172201
      green_mealies_fresh,            --  01173101
      tomatoes_fresh,            --  01173102
      green_beans_fresh,            --  01173103
      pumpkin_butternut_fresh,            --  01173104
      marrow_fresh,            --  01173105
      gem_squashes_fresh,            --  01173106
      green_or_red_or_yellow_pepper_fresh,            --  01173107
      chillies_fresh,            --  01173108
      cucumber_fresh,            --  01173109
      mixed_vegetables_fresh,            --  01173188
      other_fresh_vegetables_specify,            --  01173191
      corn_kernels_frozen,            --  01173201
      green_beans_frozen,            --  01173203
      pumpkin_frozen,            --  01173204
      peas_frozen,            --  01173210
      mixed_vegetables_frozen,            --  01173288
      other_frozen_vegetables,            --  01173299
      onions,            --  01174101
      carrots_fresh,            --  01174102
      beetroot,            --  01174103
      mushrooms,            --  01174104
      carrots_frozen,            --  01174202
      peas_dried,            --  01175101
      beans_dried,            --  01175201
      lentils_dried,            --  01175301
      other_dried_vegetables_specify,            --  01175401
      corn_kernels_canned,            --  01176101
      sweet_corn_cream_style,            --  01176102
      baked_beans_in_tomato_sauce,            --  01176103
      peas_tinned,            --  01176104
      butter_beans,            --  01176105
      green_beans_canned,            --  01176106
      other_canned_vegetables,            --  01176107
      pickles,            --  01176108
      atchaar,            --  01176109
      vegetable_spread_bovril_fray_bentos,            --  01176110
      prepared_salads,            --  01176201
      potatoes,            --  01177101
      potato_chips_frozen,            --  01178101
      sweet_potatoes,            --  01178201
      potato_crisps,            --  01178301
      cheese_curls,            --  01178302
      corn_chips,            --  01178303
      pop_corn_kernels,            --  01178304
      prepared_pop_corn,            --  01178305
      other_vegetable_products_specify,            --  01178307
      white_sugar,            --  01181101
      brown_sugar,            --  01181102
      icing_sugar,            --  01181103
      castor_sugar,            --  01181104
      artificial_sweeteners,            --  01181201
      other_sugar_specify,            --  01181301
      honey,            --  01182101
      smooth_apricot_jam,            --  01182201
      smooth_peach_jam,            --  01182202
      melon_and_ginger_jam,            --  01182203
      other_jam_including_strawberry,            --  01182204
      preserves_specify,            --  01182205
      marmalade,            --  01182206
      milk_plain_slabs,            --  01183101
      milk_whole_nut_slabs,            --  01183102
      bar_with_filling,            --  01183201
      other_chocolates_specify,            --  01183301
      toffees,            --  01184101
      glucose_sweets,            --  01184201
      health_bars,            --  01184301
      other_sweets,            --  01184401
      full_cream_ice_cream,            --  01185101
      sorbet,            --  01185102
      frozen_yogurt,            --  01185103
      ice_cubes,            --  01185104
      other_edible_ices_and_ice_cream_specify,            --  01185105
      jelly_powder,            --  01186101
      golden_syrup,            --  01186201
      other_sugar_products,            --  01186301
      vinegar,            --  01191101
      chutney,            --  01191201
      mustard,            --  01191301
      tomato_sauce,            --  01191401
      mayonnaise,            --  01191501
      salad_dressing,            --  01191601
      other_sauces_and_condiments_specify,            --  01191701
      salt,            --  01192101
      fine_white_pepper,            --  01192201
      pepper_black_corns_and_fine_black_pepper,            --  01192202
      curry_powder,            --  01192203
      chicken_spice,            --  01192301
      steak_and_chops_spice,            --  01192302
      chili_powder,            --  01192304
      cinnamon,            --  01192305
      cloves,            --  01192401
      other_salt_and_spices_specify_aromat,            --  01192501
      baby_food_predominantly_grain,            --  01193101
      baby_food_predominantly_meat,            --  01193102
      baby_food_predominantly_vegetables,            --  01193103
      baby_food_predominantly_fruit,            --  01193104
      baby_food_predominantly_milk,            --  01193105
      canned_soup,            --  01193201
      powder_soup,            --  01193202
      custard_powder,            --  01193301
      instant_yeast,            --  01193302
      baking_powder,            --  01193303
      bicarbonate_of_soda,            --  01193304
      other_food_products_specify,            --  01193305
      instant_pudding_powder,            --  01193306
      soya_product_excluding_soy_milk,            --  01194101
      food_hampers,            --  01195000
      other_produce_specify,            --  66111801
      other_livestock_from_own_production,            --  66211601
      instant_coffee,            --  01211101
      ground_coffee,            --  01211201
      coffee_beans,            --  01211301
      tee_leaves,            --  01212101
      tagged_tea_bags,            --  01212102
      tag_less_tea_bags,            --  01212103
      rooibos_tea_leaves,            --  01212201
      rooibos_tea_bags,            --  01212202
      herbal_tea_not_from_food_service_place,            --  01212300
      other_tea_specify,            --  01212401
      cocoa_powder,            --  01213101
      powdered_chocolate,            --  01213201
      other_hot_drinks,            --  01213301
      mineral_water_or_spring_water_aerated_and_still,            --  01221100
      aerated_cold_drinks,            --  01222101
      other_eg_energade_lucozade_ice_tea_etc,            --  01222102
      fruit_juices_not_from_food_service_places,            --  01223101
      concentrates_and_drink_powders,            --  01223102
      vegetable_juices_not_from_food_service_places,            --  01224101
      fruit_and_vegetable_juices_combined_not_from_food_service_places,            --  01225101
      unclassified_expenditures_on_food,            --  01999999
      spirits_such_as_brandy_whisky_gin_liqueurs,            --  02111100
      table_wines_including_sparkling_wine_not_from_food_service_places,            --  02121100
      cooking_wines_not_from_food_service_places,            --  02121201
      fortified_wines_sherry_port_etc_not_from_food_service_places,            --  02121300
      spirit_coolers_cider_hooch_etc_not_from_a_food_service_place,            --  02122100
      other_eg_mampoer_home_brewed_not_from_food_service_place,            --  02122200
      clear_beer_not_purchased_from_a_food_service_place,            --  02131100
      sorghum_beer_pre_packed_not_from_a_food_service_place,            --  02131201
      sorghum_beer_traditional_not_from_a_food_service_place,            --  02131301
      cigarettes,            --  02211100
      cigars_and_cigarillos,            --  02212100
      pipe_and_cigarette_tobacco,            --  02213100
      chewing_tobacco_and_snuff,            --  02213200
      other_items_smoked,            --  02213300
      material_for_clothing,            --  03111100
      mens_clothing,            --  03121001
      sports_clothing,            --  03121002
      womens_clothing,            --  03122001
      specially_made_up_clothes_eg_clothes_made_by_dressmakers_and_tailors,            --  03122002
      infants_clothing,            --  03123100
      girls_school_uniform,            --  03123200
      boys_school_uniform,            --  03123300
      girls_clothing,            --  03123400
      boys_clothing,            --  03123500
      other_specify,            --  03126000
      clothing_accessories_such_as_scarves_ties_belts_gloves_etc,            --  03131001
      knitting_wool_and_yarns,            --  03131101
      patterns_trimming_lace_sewing_cotton_etc,            --  03131102
      cleaning_of_clothing,            --  03141100
      labour_cost_for_making_or_knitting_ofclothing_and_repairs_or_alterations_to_clothing,            --  03141200
      cost_of_the_hire_of_clothing,            --  03141300
      mens_footwear,            --  03211001
      sports_footwear,            --  03211002
      other_footwear,            --  03211003
      womens_footwear,            --  03212001
      girls_school_footwear,            --  03213100
      boys_school_footwear,            --  03213200
      girls_footwear,            --  03213300
      boys_footwear,            --  03213400
      infants_footwear,            --  03213500
      repair_of_footwear,            --  03221100
      cost_of_hire_of_shoes,            --  03221200
      rent_dwelling,            --  04111010
      imputed_rent_on_owned_dwellingi_7pct_peryear_of_dwelling,            --  04211001
      maintenance_and_repair_of_dwelling_existing_buildings_swimming_pools_etc_including_paints_wallpaper_etc,            --  04311100
      services_for_maintenance_and_repair_of_dwelling_plumbers_electricians_carpenters,            --  04321100
      labour_and_material_for_maintenance_and_repair_of_dwelling,            --  04321201
      security_systems_including_alarms_panic_buttons,            --  04321203
      swimming_pool_maintenance_excluding_wages_of_persons_who_maintain_pools_but_including_chemicals,            --  04321400
      water_and_electricity,            --  04404500
      water,            --  04411010
      refuse_removel,            --  04421010
      sanitation,            --  04431010
      rate_and_taxes,            --  04441010
      security_services_including_reaction_services_and_neighbourhood_watch,            --  04441020
      purchase_of_watch_dogs,            --  04441040
      vat_on_utilities,            --  04442000
      electricity,            --  04511010
      prepaid_electricity,            --  04511110
      gas,            --  04522010
      gas_in_cylinders_including_gas_for_heating_purposes,            --  04522102
      paraffin,            --  04531101
      petrol_for_household_use_not_transport,            --  04531102
      diesel_for_household_use_not_transport,            --  04531103
      firewood_bought,            --  04541101
      firewood_fetched_value,            --  04541102
      charcoal,            --  04541201
      candles,            --  04541301
      coal_including_anthracite,            --  04541401
      dung_bought,            --  04541501
      dung_fetched_value,            --  04541502
      crop_waste,            --  04541601
      other_household_fuel,            --  04541710
      other_bedroom_furniture,            --  05111110
      dining_room_furniture,            --  05111201
      lounge_furniture,            --  05111300
      kitchen_furniture_and_units_excluding_appliances_eg_refrigerators,            --  05111400
      study_desks_bookshelves_and_other_study_furniture,            --  05111500
      garden_and_patio_furniture,            --  05111600
      other_eg_ornaments_paintings_and_other_works_of_art_specify,            --  05111610
      other_loose_items_of_furniture_specify_eg_beanbags_mirrors,            --  05111620
      other_furniture,            --  05111700
      fitted_carpets,            --  05121101
      loose_carpets_and_rugs,            --  05121102
      tiles,            --  05121103
      other_floor_coverings_excluding_bathroom_and_door_mats_specify,            --  05121200
      upholstering,            --  05131100
      repairs_to_furniture,            --  05131210
      repairs_to_furnishings,            --  05131220
      repairs_to_floor_coverings,            --  05131230
      bed_bases_and_mattresses,            --  05211000
      blankets_and_travelling_rugs,            --  05211100
      sheets_and_pillow_cases,            --  05211200
      duvets_and_duvet_covers,            --  05211300
      table_and_bathroom_linen_eg_table_cloths_and_napkins_towels_and_face_cloths,            --  05211400
      curtains_including_making_and_hanging_charges_and_material_for_curtains,            --  05211500
      pillows_and_cushions,            --  05211600
      other_household_textiles,            --  05211700
      duvet_packs_eg_package_including_pillow_cases_and_sheets,            --  05211800
      value_of_repairs_to_household_textiles,            --  05211900
      refrigerators_deep_freezers_and_refrigerator_or_deep_freeze_combinations,            --  05311100
      refrigerators,            --  05311200
      washing_machines_dishwashers_and_tumble_dryers,            --  05312100
      stoves_and_ovens_including_microwave_ovens,            --  05313100
      coal_wood_and_anthracite_stoves,            --  05313200
      gas_stoves_and_heaters,            --  05313300
      heaters_and_air_conditioners,            --  05314100
      paraffin_stoves_and_heaters,            --  05314200
      vacuum_cleaners_polishers_and_carpet_cleaning_machines,            --  05315100
      sewing_machines_over_lockers_and_knitting_machines,            --  05316100
      sewing_and_knitting_machines,            --  05316200
      hotplates,            --  05321101
      irons,            --  05321200
      kettles_and_percolators_coffee_makers,            --  05321300
      food_mixers_processors_and_similar_accessories,            --  05321400
      frying_pans_and_woks,            --  05321500
      toaster_waffle_pans_and_sandwich_toasters,            --  05321600
      other_electrical_appliances_eg_electric_blankets_water_pumps_and_fans_specify,            --  05321800
      other_eg_dry_cabinets_and_safes_specify,            --  05321900
      repairs_and_service_charges_for_electrical_appliances,            --  05331100
      repairs_and_service_charges_for_non_electrical_appliances,            --  05331200
      glass_and_crystal_ware_tableware_including_household_or_toilet_articles_of_porcelain_ceramic_stoneware_china_etc,            --  05411000
      cutlery_flatware_and_silverware_kitchen_and_domestic_utensils_non_electrical_utensils_such_as_frying_pans_saucepans_etc,            --  05412000
      enamel,            --  05413100
      aluminum_iron_steel,            --  05413200
      plastic,            --  05413300
      other_such_as_towel_rails_bottle_racks_etc_specify,            --  05413400
      value_of_repairs_on_glassware_tableware_and_household_utensils,            --  05414200
      power_driven_garden_tools,            --  05511110
      power_drills,            --  05511130
      light_bulbs,            --  05521101
      dry_cells,            --  05521201
      recharging_of_rechargeable_cells_not_car_batteies,            --  05521202
      hand_tools_such_as_screwdrivers,            --  05521301
      garden_hand_tools_such_as_spades,            --  05521302
      garden_water_sprinkler,            --  05521303
      other_garden_equipment,            --  05521304
      soap_bars_and_cakes_not_toilet_soap_washing_powders_liquid_detergents_and_bleaches_dishwasher_tablets,            --  05611100
      scouring_powders_pot_scourers_etc,            --  05611200
      floor_shoe_and_furniture_polish,            --  05611300
      insecticides_indoor_pesticides_drain_and_toilet_cleansers_air_freshener_etc,            --  05611400
      scissors_needles_pins,            --  05612010
      packaging_materials_plastic_bags_and_sachets_foil_wax_paper_etc,            --  05612110
      paper_serviettes_or_napkins_disposable_dinner_ware_plates_tumblers_etc,            --  05612120
      brooms_brushes_feather_dusters_etc,            --  05612210
      dish_cloths_wash_and_dry,            --  05612220
      matches,            --  05612310
      fire_lighters,            --  05612320
      other_clothes_pegs_hangers_etc_specify,            --  05612410
      methylated_spirits_fuel_for_lawnmowers_and_generators_and_for_heating_excluding_fuel_for_your_motor_vehicles,            --  05612500
      cash_wage_incl_transport_received_by_general_domestic_worker,            --  05621011
      cash_wage_incl_transport_received_by_child_minder_or_nanny,            --  05621012
      cash_wage_incl_transport_received_by_cook,            --  05621013
      cash_wage_incl_transport_received_by_chaffeur,            --  05621014
      cash_wage_incl_transport_received_by_clothes_washers_or_ironers,            --  05621015
      cash_wage_incl_transport_received_by_garden_worker,            --  05621016
      cash_wage_incl_transport_received_by_baby_sitter,            --  05621017
      cash_wage_incl_transport_received_by_other_domestic_worker,            --  05621018
      dry_cleaning_of_household_linen_textiles_and_carpets,            --  05622100
      laundry_service_for_household_textile_and_carpets_and_nappy_services_including_launderettes,            --  05622200
      hiring_of_furniture_furnishings_carpets,            --  05622300
      fumigation_and_cleaning_services_including_those_of_upholstery_swimming_pool_window_cleaning_etc,            --  05622400
      grinding_or_gristing_of_maize_or_wheat,            --  05622500
      medicine_purchased_with_prescription_in_private_institutions,            --  06111100
      medicine_purchased_with_prescription_in_public_institutions,            --  06111101
      medicine_purchased_without_prescription_in_private_institutions,            --  06111200
      medicine_purchased_without_prescription_in_public_institutions,            --  06111201
      pharmacy_dispensing_fees_in_private_institutions,            --  06111300
      pharmacy_dispensing_fees_in_public_institutions,            --  06111301
      pharmacy_service_fees_in_private_institutions,            --  06111400
      pharmacy_service_fees_in_public_institutions,            --  06111401
      other_medical_products_bandages_syringes_knee_supports_etc_in_private_institutions,            --  06121000
      other_medical_products_bandages_syringes_knee_supports_etc_in_public_institutions,            --  06121001
      condoms_strings_and_other_contraceptives_excluding_tablets_and_injections,            --  06121100
      therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_private_institutions,            --  06131000
      therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_public_institutions,            --  06131001
      medical_services_in_private_institutions,            --  06211100
      medical_services_in_public_institutions,            --  06211101
      flat_rate_in_respect_of_services_and_medicine_obtained_at_hospital_or_clinic_in_private_institutions,            --  06211110
      flat_rate_in_respect_of_services_and_medicine_obtained_at_hospital_or_clinic_in_public_institutions,            --  06211111
      other_medical_services_in_private_institutions,            --  06211120
      other_medical_services_in_public_institutions,            --  06211121
      consultations_of_traditional_healers_in_private_institutions_or_work_places,            --  06211200
      consultations_of_traditional_healers_in_public_institutions,            --  06211201
      dental_service_service_of_dentists_include_oral_hygienists_in_private_institutions,            --  06221000
      dental_service_service_of_dentists_include_oral_hygienists_in_public_institutions,            --  06221001
      medical_analysis_laboratories_and_x_ray_service_in_private_institutions,            --  06231101
      medical_analysis_laboratories_and_x_ray_service_in_public_institutions,            --  06231102
      service_of_medical_auxiliaries_freelance_nurse_midwives_freelance_optometrist_physiotherapist_speech_therapist_etc_in_private_instituti,            --  06232000
      service_of_medical_auxiliaries_freelance_nurse_midwives_freelance_optometrist_physiotherapist_speech_therapist_etc_in_public_institutio,            --  06232001
      non_hospital_service_ambulance_service_other_than_hospital_in_public_institutions,            --  06233000
      non_hospital_service_ambulance_service_other_than_hospital_in_private_institutions,            --  06233001
      hospital_service_fees_eg_wards_beds_and_theatre_fees_in_private_institutions,            --  06311100
      hospital_service_fees_eg_wards_beds_and_theatre_fees_in_public_institutions,            --  06311101
      new_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes,            --  07111100
      new_bakkies,            --  07111200
      four_wheel_drive_vehicles,            --  07111300
      used_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes,            --  07112100
      used_bakkies,            --  07112200
      four_wheel_drive_vehicles_2,            --  07112300
      new_motor_cycles_and_scooters,            --  07121100
      used_motor_cycles_and_scooters,            --  07121200
      new_bicycles,            --  07131100
      used_bicycles,            --  07131200
      new_animal_drawn_vehicles,            --  07141100
      used_animal_drawn_vehicles,            --  07141200
      horse,            --  07141300
      donkey,            --  07141400
      other_private_modes_of_transport_animals,            --  07141500
      new_tyres_and_tubes,            --  07211100
      re_treaded_or_patched_tyres_and_tubes,            --  07211200
      spare_parts_maintenance_and_cleaning_materials_accessories_purchased_for_private_repair_and_installation,            --  07211300
      batteries_new_and_used,            --  07211410
      air_conditioner_for_cars_including_installations,            --  07211500
      security_systems_for_cars_including_installation,            --  07211600
      motor_car_fuel,            --  07221110
      oil_and_grease,            --  07221200
      maintenance_and_lubrication_services,            --  07231100
      panel_beating_repairs_paid_for_by_you,            --  07231410
      other_repair_work_paid_for_by_you,            --  07231510
      car_wash,            --  07231600
      valet_services,            --  07231700
      parking_fees,            --  07241100
      traffic_fines,            --  07241200
      toll_fees,            --  07241300
      licenses_and_registration_fees_including_that_of_motor_cycles,            --  07241400
      driving_lessons_driving_tests_and_driving_licenses,            --  07241500
      rented_vehicles_educational_trips,            --  07241700
      rented_vehicles_other_than_educational,            --  07241701
      rented_on_holiday,            --  07241801
      other_transport_specify,            --  07241900
      train_for_attending_educational_institutions,            --  07311110
      train_for_non_educational_institutions,            --  07311111
      train_for_when_away_from_home,            --  07311210
      bus_including_school_bus_for_educational_purposes,            --  07321110
      bus_including_school_bus_for_non_educational_purposes,            --  07321111
      bus,            --  07321210
      metered_cab_attending_educaional_trips,            --  07321310
      metered_cab_other_than_educaional,            --  07321311
      minibus_taxi_or_combi_including_30_seaters_eg_iveco_for_non_educational_purposes,            --  07321320
      minibus_taxi_or_combi_including_30_seaters_eg_iveco_for_educational_purposes,            --  07321321
      other_including_bakkies_used_as_taxis_for_education_purposes,            --  07321330
      other_including_bakkies_used_as_taxis_for_non_education_purposes,            --  07321331
      metered_cab_while_on_holiday,            --  07321410
      minibus_taxi_including_30_seaters_eg_iveco,            --  07321420
      other_including_bakkies_used_as_taxis,            --  07321430
      lift_clubs_educational_trips,            --  07321510
      lift_clubs_other,            --  07321511
      aircraft_educaional_trips,            --  07331110
      aircraft_other_than_educaional,            --  07331111
      aircraft,            --  07331210
      boat_or_ship_educational_trips,            --  07341110
      boat_or_ship_other_than_educaional,            --  07341111
      boat_or_ship_while_on_holiday,            --  07341210
      furniture_removals_and_transport_of_goods_not_for_business_purposes_for_educational_purposes,            --  07361110
      furniture_removals_and_transport_of_goods_not_for_business_purposes_for_non_educational_purposes,            --  07361111
      supporting_services_eg_parking_services_port_operators,            --  07361130
      other_eg_cable_car_horse,            --  07361140
      other_eg_horse_for_educational_puporses,            --  07361150
      other_eg_horse_for_non_educational_puporses,            --  07361151
      saddles,            --  07715111
      horse_shoes,            --  07715112
      veterinary_costs,            --  07715113
      foods_or_feeds,            --  07715114
      other_cost_for_other_modes_of_transport,            --  07715115
      stamps,            --  08111100
      packages,            --  08111200
      courier_services,            --  08111300
      other_postage,            --  08111301
      renting_of_post_boxes,            --  08111400
      other_eg_telegrams,            --  08111500
      cellular_phones,            --  08211100
      telephones_cordless_telephones_motor_telephones,            --  08211200
      fax_machines_and_telephone_answering_machines_for_household_purposes,            --  08211300
      pagers,            --  08211400
      repairs_of_computers_and_communication_equipment,            --  08211600
      installation,            --  08311101
      private_calls,            --  08311201
      calls_from_public_phones,            --  08311202
      calls_including_phone_cards,            --  08311203
      rental_landline,            --  08311301
      rental_cellphone,            --  08311302
      value_added_tax_vat_only_if_telephone_account_is_available,            --  08311401
      value_added_tax_vat_on_calls_only_if_telephone_account_is_available,            --  08311402
      connection_to_the_network_for_a_landline,            --  08311501
      connection_to_the_network_for_a_cellphone,            --  08311502
      internet_subscription_and_other_costs,            --  08311503
      radios_including_motor_car_radios_tape_recorders_compact_disk_players_and_similar_equipment,            --  09111100
      two_way_radios,            --  09111200
      television_sets_decoders_video_recorders_or_dvds,            --  09112100
      aerials_and_satellite_dishes,            --  09112200
      cameras_video_cameras_projectors_and_flashes,            --  09121100
      other_recreational_services,            --  09121300
      personal_desktop_computers_excluding_laptops,            --  09131100
      laptops_and_palm_tops,            --  09131200
      software_excluding_games_play_stations_etc,            --  09131300
      calculators,            --  09131400
      printers_or_scanners_or_copiers,            --  09131500
      modems,            --  09131600
      parts_and_upgrading_of_computers,            --  09131700
      diskettes_cds_flah_disks_and_other_consumable_goods,            --  09141100
      magnetic_tapes_excl_software_and_video_games_including_pre_recorded_and_unrecorded_music_tapes,            --  09141200
      disks_for_photographic_and_cinematographic_use,            --  09141300
      compact_disks_cds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_disks,            --  09141400
      dvds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_dvds,            --  09141500
      vcds_excluding_software_and_video_games_including_pre_recorded_and_unrecorded_vcds,            --  09141600
      other_musical_instruments_sound_equipment_and_accessories,            --  09141700
      boats_including_outboard_motors_aircrafts_go_carts,            --  09211000
      new_caravans_and_trailers_including_motorised_caravans,            --  09211100
      used_caravans_and_trailers_including_motorised_caravans,            --  09211200
      musical_instruments_pianos_organs_and_other_musical_instruments,            --  09221000
      repairs_and_service_charges_for_musical_instruments_sound_equipment_and_accessories,            --  09231001
      repairs_and_maintenance_services_to_recreation_entertainment_and_sports_equipment,            --  09231002
      hobbies,            --  09311100
      toys_and_games_video_games_including_software_games,            --  09311200
      fire_works,            --  09311400
      firearms_and_ammunition,            --  09321100
      firearms_and_ammunition_for_security_services,            --  09321101
      tennis_rackets_and_balls_fishing_rods_etc,            --  09321200
      special_sports_clothes_and_shoes,            --  09321300
      camping_equipment_tents_sleeping_bags_etc,            --  09321400
      swimming_pool_equipment_and_repairs_of_equipment,            --  09321500
      seed_plants_shrubs_and_trees_fertilizer_plant_and_pest_spray_remedies,            --  09331100
      bouquets_and_cut_flowers_for_household_use,            --  09331200
      garden_ornaments,            --  09331210
      purchase_of_pets,            --  09341000
      pet_food_or_feeds_and_other_requisites,            --  09341200
      licenses,            --  09351100
      care_eg_doggy_parlour_kennels_and_veterinary_costs,            --  09351200
      amusement_parks,            --  09411020
      membership_fees_for_gymnasiums_health_sport_and_social_clubs,            --  09411030
      sports,            --  09411100
      fees_for_lessons_connecting_with_recreation_ebtertainment_and_sport,            --  09411200
      schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public,            --  09411300
      schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat,            --  09411301
      cinema_theatres_concerts_festivals,            --  09421000
      museums_and_zoos_etc,            --  09422100
      library_fees_and_fines_for_non_academic_purposes,            --  09422200
      library_fees_fines_for_academic_purpose,            --  09422300
      library_services_for_academic_purposes,            --  09422400
      television_licenses,            --  09423101
      television_rental,            --  09423102
      subscription_to_pay_tv_channels,            --  09423103
      rent_for_decoder_video_equipment_and_tapes,            --  09423104
      film_development_and_photo_prints,            --  09424300
      admission_charges_other,            --  09424400
      lotto,            --  09431100
      casinos,            --  09431200
      other_gambling,            --  09431300
      textbooks_for_public_institutions,            --  09511100
      textbooks_for_private_institutions,            --  09511101
      books_excluding_those_in_1614,            --  09511200
      newspapers_daily_weekly,            --  09521100
      magazines_and_periodicals,            --  09521200
      miscellaneous_printed_mattereg_road_maps_greeting_cards_posters_etc,            --  09531000
      stationery_excluding_those_for_academic_purposes,            --  09541100
      stationery_for_academic_purposes_excluding_calculators_for_public_institutions,            --  09541200
      stationery_for_academic_purposes_excluding_calculators_for_private_institutions,            --  09541201
      other_specify_eg_junior_laptops_training_and_adult_education_for_public_institutions,            --  09541400
      other_specify_eg_junior_laptops_training_and_adult_education_for_private_institutions,            --  09541401
      holiday_tour_package,            --  09611000
      pre_primary_education_in_public_institutions,            --  10111101
      pre_primary_education_in_private_institutions,            --  10111111
      primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions,            --  10111201
      primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions,            --  10111301
      secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution,            --  10211101
      secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution,            --  10211111
      tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions,            --  10411101
      tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions,            --  10411111
      vocational_training_in_public_institutions,            --  10511101
      computer_certification_public_schools,            --  10511102
      other_including_language_classes_in_public_institutions,            --  10511103
      excursions_field_trips_in_public_institutions,            --  10511104
      other_tuition_fees_for_private_institutions,            --  10511105
      vocational_training_in_private_institutions,            --  10511111
      computer_certification_private_schools,            --  10511112
      other_including_language_classes_in_private_institutions,            --  10511113
      excursions_field_trips_in_private_institutions,            --  10511114
      other_tuition_fees_for_public_institutions,            --  10511115
      coffee,            --  11111211
      ordinary_tea,            --  11111221
      rooibos_tea,            --  11111222
      herbal_tea_from_food_service_place,            --  11111223
      other_eg_flavored_tea_specify,            --  11111224
      cocoa_and_powdered_chocolate,            --  11111231
      mineral_water_or_spring_water,            --  11111241
      soft_drinks,            --  11111251
      fruit_juices_from_food_service_places,            --  11111261
      fruit_and_vegetable_juices_combined_from_food_service_places,            --  11111262
      vegetable_juices_from_food_service_places,            --  11111271
      spirits,            --  11111311
      table_wines_including_sparkling_wine_from_food_service_places,            --  11111321
      cooking_wines_from_food_service_places,            --  11111322
      fortified_wines_sherry_port_etc_from_food_service_places,            --  11111323
      spirit_coolers_cider_hooch_etc_from_a_food_service_place,            --  11111324
      other_eg_mampoer_home_brewed_from_food_service_place,            --  11111325
      clear_beer_purchased_from_a_food_service_place,            --  11111331
      sorghum_beer_pre_packed_from_food_service_places,            --  11111332
      sorghum_beer_traditional_from_a_food_service_place,            --  11111333
      burger,            --  11121110
      burger_and_chips,            --  11121120
      curry_and_rice,            --  11121130
      pap_and_meat,            --  11121140
      other_prepared_meals_11121150,            --  11121150
      other_prepared_meals_11121160,            --  11121160
      other_prepared_meals_11121170,            --  11121170
      other_prepared_meals_11121180,            --  11121180
      other_prepared_meals_11121190,            --  11121190
      hotel_motel_and_or_or_boarding_fees_paying_for_yourself,            --  11211100
      rent_holiday_flat_or_house_caravan_etc_including_site_fees_paying_for_yourself,            --  11211200
      schools_boarding_fees_in_public_institutions,            --  11211301
      teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions,            --  11211302
      universities_boarding_fees_in_public_institution,            --  11211303
      schools_boarding_fees_in_private_institutions,            --  11211311
      teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions,            --  11211312
      universities_boarding_fees_in_private_institution,            --  11211313
      expenses_occurred_as_owner_of_a_holiday_home_ie_after_deduction_of_income_received_from_letting,            --  11211401
      boarding_and_lodging,            --  11211502
      mens_and_boys,            --  12111100
      womens_and_girls,            --  12111200
      hairdryers,            --  12121100
      shavers,            --  12121200
      other_eg_hot_brush_vibrator_etc,            --  12121300
      hair_pieces,            --  12131110
      hair_care_preparations_mousse_relaxers_gels_etc,            --  12131120
      shampoo_and_conditioners,            --  12131130
      sprays,            --  12131140
      other,            --  12131150
      body_soap_including_sunlight_liquid_soap,            --  12131210
      bubble_bath_bath_oils_and_bath_salts,            --  12131220
      toothpaste_toothbrushes_electrical_toothbrushes,            --  12131230
      mouth_wash_and_dental_floss,            --  12131240
      shaving_soap_and_cream_and_after_shave_lotions,            --  12131250
      razors_and_razor_blades,            --  12131260
      skin_creams_and_lotions_including_baby_lotions_facial_cleansers_and_toners_perfumes_and_colognes,            --  12131270
      powder_including_baby_powder_and_deodorants,            --  12131280
      make_up_preparations_not_shown_elsewhere_eg_lipstick_eye_shadow_etc,            --  12131290
      toilet_paper,            --  12131310
      disposable_nappies,            --  12131320
      tissues,            --  12131330
      sanitary_towels_and_tampons,            --  12131340
      other_personal_care_products,            --  12131400
      watches_and_personal_jewellery,            --  12311100
      handbags_travelling_bags_schoolbags_etc,            --  12321100
      value_of_repairs_to_miscellaneous_items,            --  12322000
      smokers_reqisites,            --  12322100
      prams_and_push_carts,            --  12322110
      car_seats_for_babies,            --  12322120
      carry_cot_toys_etc,            --  12322130
      other_umbrellas_pocket_knives_sunglasses_etc_including_repairs,            --  12322200
      day_care_mothers_creches_and_playgrounds_in_public_institutions,            --  12412010
      day_care_mothers_creches_and_playgrounds_in_private_institutions,            --  12412020
      insurance_on_buildings,            --  12521010
      insurance_on_contents_of_dwellings,            --  12521020
      package_insurance,            --  12521030
      medical_insurance,            --  12531020
      medical_aid_contribution_paid_by_household_member_in_private_institution,            --  12531110
      medical_aid_contribution_paid_by_household_member_in_public_institution,            --  12531111
      insurance_paid_for_holiday_purposes_life_luggage_medical,            --  12531200
      insurance_for_private_transport,            --  12541100
      funeral_policies,            --  12551020
      bank_charges,            --  12621020
      interest_or_finance_charges,            --  12621040
      levy_for_sectional_title,            --  12711010
      contribution_towards_communal_provision_of_sevices,            --  12711011
      payment_for_right_to_access_land,            --  12711012
      membership_fees,            --  12711013
      donations_to_institutions,            --  12711014
      donations_to_charity,            --  12711015
      levy_and_other_payments,            --  12711030
      professional_fees,            --  12711040
      lobola_or_dowry_paid,            --  12711201
      funeral_expenses,            --  12711301
      gravestones_and_maintenance_of_graves_excluding_unveiling,            --  12711400
      religious_and_traditional_ceremonies_unveiling_barmitzwah_diwali_weddings,            --  12711500
      fines_fines_for_straying_livestock_excluding_traffic_fines_and_library_fines,            --  12711600
      other_expenditure,            --  12711700
      unclassified_diary_items_except_food,            --  88888888
      others_expenditures_except_food,            --  88999999
      free_water,            --  04411210
      free_sanitation,            --  04431210
      free_electricity,            --  04511210
      estimated_value_of_private_use_of_company_or_similar_vehicle,            --  07241702
      value_of_discounted_fares_for_educational_purposes,            --  07321610
      value_of_discounted_fares_for_non_educational_purposes,            --  07321611
      schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public,            --  09411310
      schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat,            --  09411311
      library_fees_fines_grant_for_academic_purpose,            --  09422301
      library_services_grant_for_academic_purposes,            --  09422401
      textbooks_for_public_institutions_grant,            --  09511110
      textbooks_for_private_institutions_grant,            --  09511111
      stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions,            --  09541210
      stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions,            --  09541211
      other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions,            --  09541410
      other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions,            --  09541411
      pre_primary_education_in_public_institutions_grant,            --  10111102
      pre_primary_education_in_private_institutions_grant,            --  10111112
      primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions_grant,            --  10111202
      primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions_grant,            --  10111302
      secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution_grant,            --  10211102
      secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution_grant,            --  10211112
      tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions_grant,            --  10411102
      tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions_grant,            --  10411112
      vocational_training_in_public_institutions_grant,            --  10511121
      computer_certification_public_schools_grant,            --  10511122
      other_including_language_classes_in_public_institutions_grant,            --  10511123
      excursions_field_trips_in_public_institutions_grant,            --  10511124
      other_tuition_fees_for_private_institutions_grant,            --  10511125
      vocational_training_in_private_institutions_grant,            --  10511131
      computer_certification_private_schools_grant,            --  10511132
      other_including_language_classes_in_private_institutions_grant,            --  10511133
      excursions_field_trips_in_private_institutions_grant,            --  10511134
      other_tuition_fees_for_public_institutions_grant,            --  10511135
      schools_boarding_fees_in_public_institutions_grant,            --  11211321
      teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant,            --  11211322
      universities_boarding_fees_in_public_institution_grant,            --  11211323
      schools_boarding_fees_in_private_institutions_grant,            --  11211331
      teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant,            --  11211332
      universities_boarding_fees_in_private_institution_grant,            --  11211333
      day_care_mothers_creches_and_playgrounds_in_public_institutions_grant,            --  12412011
      day_care_mothers_creches_and_playgrounds_in_private_institutions_grant,            --  12412021
      medical_aid_contribution_contribution_by_employer_in_private_institutions,            --  12531120
      medical_aid_contribution_contribution_by_employer_in_public_institutions,            --  12531121
      household_salaries_and_wages,            --  50110000 c
      household_self_employment_and_business,            --  50120000
      income_from_letting_of_fixed_property,            --  50210000
      royalties,            --  50220000
      interest_received,            --  50230000
      dividends_of_listed_companies,            --  50241000
      dividends_of_unlisted_companies,            --  50242000
      other_dividends,            --  50250000
      pension_from_previous_employment,            --  50310000
      annuities_from_own_investment,            --  50320000
      old_age_pensions,            --  50331000
      disability_grants,            --  50332000
      family_and_other_allowances,            --  50333000
      workmens_compensation_funds,            --  50334000
      alimony_palimony_and_other_allowances,            --  50410000
      other_income_from_individuals,            --  50420000 x
      hobbis,            --  50510100
      side_lines_and_part_time_activities,            --  50510200
      sale_of_vehicles_property_etc,            --  50510300
      payments_received_from_boarders_and_other_non_members,            --  50510400
      claims,            --  50510600
      stokvel,            --  50510700
      benefits_donations_and_giftes,            --  50510900
      cash,            --  50511000
      value_of_food_received,            --  50511100
      value_of_clothing,            --  50511300
      value_of_other_benefints_donations_gifts_etc,            --  50511500
      lobola_or_dowry_received,            --  50511600
      income_from_gambling,            --  50511700
      tax_refunds_received,            --  50511800
      income_not_elsewhere_specified,            --  50511900
      gratuities_and_other_lump_sum_payments,            --  50512000
      imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling,            --  50600000
      free_water_income,            --  51200000
      free_sanitation_income,            --  51300000
      free_electricity_income,            --  51400000++++++++++++++++++++++++++
      estimated_value_of_private_use_of_company_or_similar_vehicle_income,            --  51510000
      value_of_discounted_fares_for_educational_purposes_income,            --  51520000
      value_of_discounted_fares_for_non_educational_purposes_income,            --  51530000
      schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public_income,            --  51610000
      schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat_income,            --  51620000
      library_fees_fines_grant_for_academic_purpose_income,            --  51710000
      library_services_grant_for_academic_purposes_income,            --  51720000
      textbooks_for_public_institutions_grant_income,            --  51730000
      textbooks_for_private_institutions_grant_income,            --  51740000
      stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions_income,            --  51750000
      stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions_income,            --  51760000
      other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions_income,            --  51770000
      other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions_income,            --  51780000
      pre_primary_education_in_public_institutions_grant_income,            --  51801000
      pre_primary_education_in_private_institutions_grant_income,            --  51802000
      primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_public_institutions_grant_income,            --  51803000
      primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions_grant_income,            --  51804000
      secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution_grant_income,            --  51805000
      secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution_grant_income,            --  51806000
      tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions_grant_income,            --  51807000
      tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions_grant_income,            --  51808000
      vocational_training_in_public_institutions_grant_income,            --  51809000
      computer_certification_public_schools_grant_income,            --  51810000
      other_including_language_classes_in_public_institutions_grant_income,            --  51811000
      excursions_field_trips_in_public_institutions_grant_income,            --  51812000
      vocational_training_in_private_institutions_grant_income,            --  51813000
      computer_certification_private_schools_grant_income,            --  51814000
      other_including_language_classes_in_private_institutions_grant_income,            --  51815000
      excursions_field_trips_in_private_institutions_grant_income,            --  51816000
      other_tuition_fees_for_public_institutions_grant_income,            --  51817000
      other_tuition_fees_for_private_institutions_grant_income,            --  51818000
      schools_boarding_fees_in_public_institutions_grant_income,            --  51910000
      teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_income,            --  51920000
      universities_boarding_fees_in_public_institution_grant_income,            --  51930000
      schools_boarding_fees_in_private_institutions_grant_income,            --  51940000
      teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_income,            --  51950000
      universities_boarding_fees_in_private_institution_grant_income,            --  51960000
      day_care_mothers_creches_and_playgrounds_in_public_institutions_grant_income,            --  51971000
      day_care_mothers_creches_and_playgrounds_in_private_institutions_grant_income,            --  51972000
      medical_aid_contribution_contribution_by_employer_in_private_institutions_income,            --  51973000
      medical_aid_contribution_contribution_by_employer_in_public_institutions_income,            --  51974000
      improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts,            --  52110000
      services_for_improvements_additions_and_alterationscarpenters_electricians_etc,            --  52122000
      security_structures_including_fences_electronic_gates,            --  52130000
      building_materials_not_included_in_q813_a_or_c_eg_for_building_purposes,            --  52140000
      labour_and_material_for_improvements_additions_and_alterations,            --  52150000
      cost_of_other_dewlling,            --  52210000
      capital_payments_including_deposit,            --  52220000
      monthly_capital_payments,            --  52230000
      other_payments_such_as_transfer_duty_and_transfer_costs_and_registration_of_mortgage_bond,            --  52240000
      purchase_of_timeshare,            --  52251000
      levy_on_timeshare,            --  52252000
      life_and_endownment_policies,            --  52310000
      life_insurance_covering_mortgage_debt,            --  52320000
      repayment_on_loans_and_overdrafts,            --  52410000
      contribution_to_pension_provident_and_annuity_funds,            --  52421000
      employer_contribution_to_pension_provident_and_annuity_funds,            --  52422000
      contributions_to_a_stokvel,            --  52500000
      listed_company_shares,            --  52610000
      unlisted_company_shares,            --  52620000
      unit_trusts,            --  52630000
      investment_plans,            --  52640000
      offshore,            --  52650000
      other_investments,            --  52660000
      deposits_into_savings,            --  52710000
      wthdrawals_from_savings,            --  52720000
      site_income_tax,            --  53110000
      paye_income_tax,            --  53120000
      according_to_assessment_income_tax,            --  53130000
      amnesty_tax,            --  53200000
      unemployment_insurance_fund_uif,            --  53300000
      in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children,            --  99111102
      in_cash_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children,            --  99111112
      gifts_to_persons_who_are_not_members_of_this_household_excluding_cash_gifts_in_kind,            --  99111202
      gifts_to_persons_who_are_not_members_of_this_household_excluding_cash_gifts,            --  99111212
      tribal_levies_not_for_housing_in_kind,            --  99111302
      tribal_levies_not_for_housing,            --  99111312
      bond_loan_from_the_bank,            --  70100000
      other_loans,            --  70110000
      motor_vehicle_loan_from_the_bank,            --  70200000
      bank_overdraft,            --  70300000
      other_bank_loans,            --  70400000
      furniture_and_appliances_amount_oustanding,            --  70500000
      retail_stores_clothers_on_account_or_lay_bye_amount_outstanding,            --  70600000
      loans_from_friends_and_family,            --  70700000
      loans_from_money_lenders,            --  70800000
      arreas_on_municipal_bills,            --  70900000
      expenditure_incurred_in_obtaining_income,            --  80000000
      imputed_rent_on_owned_dwelling,            --  04211000
      panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party,            --  07231420
      other_repair_work_paid_for_by_your_insurance_company_or_other_party,            --  07231520
      interest_on_mortgage_bonds,            --  12621010
      subsidy_on_payment_of_mortgage,            --  12711020
      seed,            --  66311101
      fertilizer,            --  66311201
      feed,            --  66311301
      livestock,            --  66311401
      services_eg_ploughing_veterinary_not_for_pets,            --  66311501
      processingeg_grinding_milling_and_slaughtering,            --  66311601
      other_items_from_own_production,            --  66311701
      good_and_services_received_by_virtue_of_occupation,            --  50510500
      non_refundable_bursaries,            --  50510800
      value_of_housing,            --  50511200
      value_of_transport            --  50511400
   );

   package Coicop_Type_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Coicop_Type );
   subtype Coicop_Type_Array is Coicop_Type_Package.Amount_Array;
      
   type Coicop is (  
      missing,
      Consumption_coi,
      Debts_coi,
      In_kind_consumption_coi,
      In_kind_income_coi,
      Income_coi,
      Loss_coi,
      Other_products_not_consumption_coi,
      Savings_coi,
      Taxes_coi,
      Transfers_to_others_coi );

   type Main_Group is (  
      missing,
      food_and_non_alcoholic_beverages_main,
      alcoholic_beverages_tobacco_and_narcotics_main,
      clothing_and_footwear_main,
      housing_water_electricity_gas_and_other_fuels_main,
      furnishings_househould_equipment_and_routine_maintenance_of_the_house_main,
      health_main,
      transport_main,
      communication_main,
      recreation_and_culture_main,
      education_main,
      restaurants_and_hotels_main,
      miscellaneous_goods_and_services_main,
      other_unclasified_expenses_main,
      in_kind_consumption_main,
      income_main,
      income_in_kind_main,
      savings_main,
      taxes_main,
      transfers_to_others_main,
      debts_main,
      loss_main,
      not_cpi_consumption_main );
      
   package Main_Group_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Main_Group );
    subtype Main_Group_Array is Main_Group_Package.Amount_Array;  

    procedure Aggregate_To( a : in out Main_Group_Array; which : in Coicop_Type; value : in Amount );
    
   type Secondary_Group is (  
      missing,
      food_secondary,
      non_alcoholic_beverages_secondary,
      unclassified_food_items_secondary,
      alcoholic_beverages_secondary,
      tobacco_secondary,
      clothing_secondary,
      footwear_secondary,
      actual_rentals_for_housing_secondary,
      imputed_rentals_for_housing_secondary,
      maintenance_and_repair_of_the_dwelling_secondary,
      water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary,
      electricity_gas_and_other_fuels_secondary,
      furniture_and_furnishings_carpets_and_other_floor_covering_secondary,
      household_textiles_secondary,
      household_appliances_secondary,
      glassware_tableware_andhousehold_utensils_secondary,
      tools_and_equipment_for_house_and_garden_secondary,
      goods_and_services_for_routine_household_maintenance_secondary,
      medical_products_appliances_and_equipment_secondary,
      out_patient_services_secondary,
      hospital_services_secondary,
      purchase_of_vehicles_secondary,
      operation_of_personal_transport_equipment_secondary,
      transport_services_secondary,
      operational_values_of_other_modes_of_transport_secondary,
      postal_services_secondary,
      telephone_and_telefax_equipment_secondary,
      telephone_and_telefax_services_secondary,
      audio_visual_photographic_and_information_processing_equipment_secondary,
      other_major_durables_for_recreation_and_culture_secondary,
      other_recreational_items_and_equipment_garden_and_pets_secondary,
      recreational_and_cultural_services_secondary,
      newspapers_books_and_stationary_secondary,
      package_holidays_secondary,
      pre_primary_and_primary_education_secondary,
      secondary_education_secondary,
      tertiary_education_secondary,
      education_not_definable_by_level_secondary,
      catering_services_secondary,
      accommodation_services_secondary,
      personal_care_secondary,
      personal_effects_secondary,
      social_protection_secondary,
      insurance_secondary,
      financial_services_nec_secondary,
      other_services_nec_secondary,
      others_diary_secondary,
      others_main_secondary,
      in_kind_consumption_secondary,
      income_from_work_secondary,
      income_from_capital_secondary,
      pensions_social_insuerance_family_allowances_secondary,
      income_from_individuals_secondary,
      other_income_secondary,
      imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary,
      in_kind_income_from_free_water_secondary,
      in_kind_income_from_free_sanitation_secondary,
      in_kind_income_from_free_electricity_secondary,
      in_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary,
      in_kind_income_from_schools_and_other_edu_inst_grant_secondary,
      in_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary,
      in_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary,
      in_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary,
      savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary,
      savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary,
      savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary,
      savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary,
      savings_from_contributions_to_a_stokvel_secondary,
      savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary,
      savings_from_deposits_and_wthdrawals_secondary,
      taxes_site_paye_and_income_tax_secondary,
      taxes_amnesty_tax_secondary,
      taxes_uif_secondary,
      transfers_to_others_secondary,
      debts_bond_loan_from_the_bank_and_other_loans_secondary,
      debts_motor_vehicle_loan_from_the_bank_secondary,
      debts_bank_overdraft_secondary,
      debts_other_bank_loans_secondary,
      debts_furniture_and_appliances_amount_oustanding_secondary,
      debts_retail_stores_secondary,
      debts_loans_from_friends_and_family_secondary,
      debts_loans_from_money_lenders_secondary,
      debts_arreas_on_municipal_bills_secondary,
      debts_expenditure_incurred_in_obtaining_income_secondary,
      imputed_rentals_of_owner_occupiers_secondary,
      panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary,
      interest_on_mortgage_bonds_secondary,
      subsidy_on_payment_of_mortgage_secondary,
      imputed_cost_for_home_production_secondary,
      other_products_not_consumption_secondary );
 
   package Secondary_Group_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Secondary_Group );
    subtype Secondary_Group_Array is Secondary_Group_Package.Amount_Array;  
   
    procedure Aggregate_To( a : in out Secondary_Group_Array; which : in Coicop_Type; value : in Amount );   
   
    type Tertiary_Group is (  
      missing,
      bread_and_cereals_tertiary,
      meat_tertiary,
      fish_tertiary,
      milk_cheese_and_eggs_tertiary,
      oils_and_fats_tertiary,
      fruits_tertiary,
      vegetables_tertiary,
      sugar_jam_honey_chocolate_and_confectionery_tertiary,
      food_products_nec_tertiary,
      coffee_tea_and_cocoa_tertiary,
      mineral_waters_soft_drinks_fruit_and_vegetable_juices_tertiary,
      unclassified_food_items_tertiary,
      spirits_tertiary,
      wine_tertiary,
      beer_tertiary,
      tobacco_tertiary,
      clothing_materials_tertiary,
      garments_tertiary,
      other_articles_of_clothing_and_clothing_accessories_tertiary,
      cleaning_repair_and_hire_of_clothing_tertiary,
      shoes_and_other_footwear_tertiary,
      repair_and_hire_of_foowear_tertiary,
      actual_rentals_paid_by_tenants_tertiary,
      imputed_rentals_of_owner_occupiers_tertiary,
      materials_for_maintenance_and_repair_of_the_dwelling_tertiary,
      service_of_the_maintenance_and_repair_of_the_dwelling_tertiary,
      water_and_electricity_tertiary,
      water_supply_tertiary,
      refuse_collection_tertiary,
      sewarage_collection_tertiary,
      other_services_relating_to_the_dwelling_tertiary,
      electricity_tertiary,
      gas_tertiary,
      liquid_fuels_tertiary,
      solid_fuels_tertiary,
      furniture_and_furnishings_tertiary,
      carpets_and_other_floor_covering_tertiary,
      repair_of_furniture_furnishings_and_floor_covering_tertiary,
      household_textile_tertiary,
      major_household_appliances_wheter_or_no_aelectriccal_tertiary,
      small_electrical_household_appliance_tertiary,
      repair_of_household_appliance_tertiary,
      glassware_tableware_and_household_utensils_tertiary,
      major_tools_and_equipment_tertiary,
      small_tools_and_miscellaneous_accessories_tertiary,
      non_durable_household_goods_tertiary,
      domestics_services_and_household_arcticles_tertiary,
      pharmaceutical_products_tertiary,
      other_medical_products_tertiary,
      therapeutic_appliances_and_equipment_tertiary,
      medical_services_tertiary,
      dental_services_tertiary,
      paramedic_services_tertiary,
      hospital_services_tertiary,
      motor_cars_tertiary,
      motor_cycles_tertiary,
      bicycles_tertiary,
      animal_drawn_vehicle_tertiary,
      spare_parts_and_accessories_tertiary,
      fuels_and_lubricants_tertiary,
      maintenance_and_repairs_of_personal_transport_equipment_tertiary,
      other_services_in_respect_of_personal_transport_equipment_tertiary,
      passenger_transport_by_railway_tertiary,
      passenger_transport_by_road_tertiary,
      passenger_transport_by_air_tertiary,
      passenger_transport_by_sea_and_inland_waterway_tertiary,
      other_puchased_transport_services_tertiary,
      cost_for_other_modes_of_transport_tertiary,
      postal_services_tertiary,
      telephone_and_telefax_equipment_tertiary,
      telephone_and_telefax_services_tertiary,
      equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures_tertiary,
      photographic_and_cinematographic_equipment_and_optical_instruments_tertiary,
      information_processing_equipment_tertiary,
      recording_meedia_tertiary,
      major_durables_for_outdoor_recreation_tertiary,
      musical_instrument_and_major_durables_for_outdoor_recreation_tertiary,
      maintenance_and_repair_of_other_major_durables_for_recreation_and_culture_tertiary,
      games_toys_and_hobbies_tertiary,
      equipment_for_sport_camping_and_open_air_recreation_tertiary,
      gardens_plants_and_flowers_tertiary,
      pets_and_related_products_tertiary,
      veterinary_and_other_services_tertiary,
      recreational_and_sporting_services_tertiary,
      cultural_services_tertiary,
      games_of_chances_tertiary,
      books_tertiary,
      newspaper_and_periodicals_tertiary,
      miscellaneous_printed_matter_tertiary,
      stationery_and_drawing_materials_tertiary,
      package_holidays_tertiary,
      pre_primary_and_primary_education_tertiary,
      scondary_education_tertiary,
      tertiary_education_tertiary,
      education_not_definable_by_level_tertiary,
      beverages_in_restaurants_cafes_canteens_and_the_likes_tertiary,
      meals_in_restaurants_cafes_canteens_and_the_likes_tertiary,
      accommodation_services_tertiary,
      hairdressing_salons_and_personal_grooming_astablishment_tertiary,
      elecrtical_appliances_for_personal_care_tertiary,
      other_appliances_articles_and_products_for_personal_care_tertiary,
      jewellery_clocks_and_watches_tertiary,
      other_personal_effects_tertiary,
      social_protection_services_tertiary,
      insurance_connected_with_the_dwelling_tertiary,
      insurance_connected_with_the_health_tertiary,
      insurance_connected_with_the_transport_tertiary,
      other_insurance_tertiary,
      financial_services_nec_tertiary,
      other_services_tertiary,
      consumption_unclassified_diary_items_tertiary,
      consumption_others_expenditures_tertiary,
      in_kind_consumption_tertiary,
      income_from_salaries_and_wages_tertiary,
      income_from_self_employment_and_business_tertiary,
      income_from_property_tertiary,
      income_from_royalties_tertiary,
      income_interest_received_tertiary,
      income_from_dividends_tertiary,
      income_from_other_dividends_tertiary,
      income_from_pension_from_previous_employment_tertiary,
      income_from_annuities_from_own_investment_tertiary,
      income_from_social_pensions_tertiary,
      income_from_alimony_palimony_and_other_allowances_tertiary,
      other_income_from_individuals_tertiary,
      other_income_tertiary,
      income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_tertiary,
      in_kind_income_from_free_water_tertiary,
      in_kind_income_from_free_sanitation_tertiary,
      in_kind_income_from_free_electricity_tertiary,
      in_kind_income_from_estimated_value_of_private_use_of_company_vehicle_tertiary,
      in_kind_income_from_value_of_discounted_fares_for_educational_purposes_tertiary,
      in_kind_income_from_value_of_discounted_fares_for_non_educational_purposes_tertiary,
      in_kind_income_from_schools_and_other_edu_inst_publice_grant_tertiary,
      in_kind_income_from_schools_and_other_edu_inst_privat_grant_tertiary,
      in_kind_income_from_library_fees_fines_grant_tertiary,
      in_kind_income_from_library_services_grant_tertiary,
      in_kind_income_from_textbooks_for_public_institutions_grant_tertiary,
      in_kind_income_from_textbooks_for_private_institutions_grant_tertiary,
      in_kind_income_from_stationery_public_grant_tertiary,
      in_kind_income_from_stationery_private_grant_tertiary,
      in_kind_income_from_other_specify_public_grant_tertiary,
      in_kind_income_from_other_specify_private_grant_tertiary,
      in_kind_income_from_pre_primary_primary_tertiary_education_and_vocational_training_grants_public_and_private_tertiary,
      in_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private_tertiary,
      in_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public_tertiary,
      in_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_tertiary,
      in_kind_income_from_universities_boarding_fees_in_public_institution_grant_tertiary,
      in_kind_income_from_schools_boarding_fees_in_private_institutions_grant_tertiary,
      in_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_tertiary,
      in_kind_income_from_universities_boarding_fees_in_private_institution_grant_tertiary,
      in_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant_tertiary,
      savings_from_improvements_additions_and_alterations_tertiary,
      savings_from_services_for_improvements_additions_and_alterations_tertiary,
      savings_from_security_structures_tertiary,
      savings_from_building_materials_not_included_in_q813_tertiary,
      savings_from_labour_and_material_for_improvements_additions_and_alterations_tertiary,
      savings_from_cost_of_other_dewlling_tertiary,
      savings_from_capital_payments_tertiary,
      savings_from_monthly_capital_payments_tertiary,
      savings_from_other_payments_tertiary,
      savings_from_purchase_and_levy_of_timeshare_tertiary,
      savings_from_life_and_endownment_policies_tertiary,
      savings_from_life_insurance_covering_mortgage_debt_tertiary,
      savings_from_repayment_on_loans_and_overdrafts_tertiary,
      savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary,
      savings_from_contributions_to_a_stokvel_tertiary,
      savings_from_listed_company_shares_tertiary,
      savings_from_unlisted_company_shares_tertiary,
      savings_from_unit_trusts_tertiary,
      savings_from_investment_plans_tertiary,
      savings_from_offshore_tertiary,
      savings_from_other_investments_tertiary,
      savings_from_deposits_into_savings_tertiary,
      savings_from_wthdrawals_from_savings_tertiary,
      taxes_site_income_tax_tertiary,
      taxes_paye_income_tax_tertiary,
      taxes_according_to_assessment_income_tax_tertiary,
      taxes_amnesty_tax_tertiary,
      taxes_unemployment_insurance_fund_uif_tertiary,
      transfer_toothers_tertiary,
      debts_bond_loan_from_the_bank_tertiary,
      debts_other_loans_tertiary,
      debts_motor_vehicle_loan_from_the_bank_tertiary,
      debts_bank_overdraft_tertiary,
      debts_other_bank_loans_tertiary,
      debts_furniture_and_appliances_amount_oustanding_tertiary,
      debts_retail_stores_tertiary,
      debts_loans_from_friends_and_family_tertiary,
      debts_loans_from_money_lenders_tertiary,
      debts_arreas_on_municipal_bills_tertiary,
      loss_expenditure_incurred_in_obtaining_income_tertiary,
      -- gks: dup imputed_rentals_of_owner_occupiers_tertiary,
      panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_tertiary,
      interest_on_mortgage_bonds_tertiary,
      subsidy_on_payment_of_mortgage_tertiary,
      imputed_cost_for_home_production_tertiary,
      other_products_not_consumption_tertiary );

   package Tertiary_Group_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Tertiary_Group );
   subtype Tertiary_Group_Array is Tertiary_Group_Package.Amount_Array; 
    
   procedure Aggregate_To( a : in out Tertiary_Group_Array; which : in Coicop_Type; value : in Amount );
   
   function Map( a : Coicop_Type_Array ) return Main_Group_Array;
   function Map( a : Coicop_Type_Array ) return Secondary_Group_Array;
   function Map( a : Coicop_Type_Array ) return Tertiary_Group_Array;
   
   subtype Personal_Income_Range is Coicop_Type range household_salaries_and_wages ..  other_income_from_individuals;
    
   ---
   --- Level 1 ranges
   ---
   subtype Consumption_coi_Range is Coicop_Type range rice .. others_expenditures_except_food;
   subtype Debts_coi_Range is Coicop_Type range bond_loan_from_the_bank .. arreas_on_municipal_bills;
   subtype In_kind_consumption_coi_Range is Coicop_Type range free_water .. medical_aid_contribution_contribution_by_employer_in_public_institutions;
   subtype In_kind_income_coi_Range is Coicop_Type range free_water_income .. medical_aid_contribution_contribution_by_employer_in_public_institutions_income;
   subtype Income_coi_Range is Coicop_Type range household_salaries_and_wages .. imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling;
   subtype Loss_coi_Range is Coicop_Type range expenditure_incurred_in_obtaining_income .. expenditure_incurred_in_obtaining_income;
   subtype Other_products_not_consumption_coi_Range is Coicop_Type range imputed_rent_on_owned_dwelling .. value_of_transport;
   subtype Savings_coi_Range is Coicop_Type range improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts .. wthdrawals_from_savings;
   subtype Taxes_coi_Range is Coicop_Type range site_income_tax .. unemployment_insurance_fund_uif;
   subtype Transfers_to_others_coi_Range is Coicop_Type range in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children .. tribal_levies_not_for_housing;
   ---
   --- Level 2
   ---
   subtype Alcoholic_beverages_tobacco_and_narcotics_main_Range is Consumption_coi_Range range spirits_such_as_brandy_whisky_gin_liqueurs .. other_items_smoked;
   subtype Clothing_and_footwear_main_Range is Consumption_coi_Range range material_for_clothing .. cost_of_hire_of_shoes;
   subtype Communication_main_Range is Consumption_coi_Range range stamps .. internet_subscription_and_other_costs;
   subtype Debts_main_Range is Debts_coi_Range range bond_loan_from_the_bank .. arreas_on_municipal_bills;
   subtype Education_main_Range is Consumption_coi_Range range pre_primary_education_in_public_institutions .. other_tuition_fees_for_public_institutions;
   subtype Food_and_non_alcoholic_beverages_main_Range is Consumption_coi_Range range rice .. unclassified_expenditures_on_food;
   subtype Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range is Consumption_coi_Range range other_bedroom_furniture .. grinding_or_gristing_of_maize_or_wheat;
   subtype Health_main_Range is Consumption_coi_Range range medicine_purchased_with_prescription_in_private_institutions .. hospital_service_fees_eg_wards_beds_and_theatre_fees_in_public_institutions;
   subtype Housing_water_electricity_gas_and_other_fuels_main_Range is Consumption_coi_Range range rent_dwelling .. other_household_fuel;
   subtype In_kind_consumption_main_Range is In_kind_consumption_coi_Range range free_water .. medical_aid_contribution_contribution_by_employer_in_public_institutions;
   subtype Income_in_kind_main_Range is In_kind_income_coi_Range range free_water_income .. medical_aid_contribution_contribution_by_employer_in_public_institutions_income;
   subtype Income_main_Range is Income_coi_Range range household_salaries_and_wages .. imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling;
   subtype Loss_main_Range is Loss_coi_Range range expenditure_incurred_in_obtaining_income .. expenditure_incurred_in_obtaining_income;
   subtype Miscellaneous_goods_and_services_main_Range is Consumption_coi_Range range mens_and_boys .. other_expenditure;
   subtype Not_cpi_consumption_main_Range is Other_products_not_consumption_coi_Range range imputed_rent_on_owned_dwelling .. value_of_transport;
   subtype Other_unclasified_expenses_main_Range is Consumption_coi_Range range unclassified_diary_items_except_food .. others_expenditures_except_food;
   subtype Recreation_and_culture_main_Range is Consumption_coi_Range range radios_including_motor_car_radios_tape_recorders_compact_disk_players_and_similar_equipment .. holiday_tour_package;
   subtype Restaurants_and_hotels_main_Range is Consumption_coi_Range range coffee .. boarding_and_lodging;
   subtype Savings_main_Range is Savings_coi_Range range improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts .. wthdrawals_from_savings;
   subtype Taxes_main_Range is Taxes_coi_Range range site_income_tax .. unemployment_insurance_fund_uif;
   subtype Transfers_to_others_main_Range is Transfers_to_others_coi_Range range in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children .. tribal_levies_not_for_housing;
   subtype Transport_main_Range is Consumption_coi_Range range new_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes .. other_cost_for_other_modes_of_transport;
   ---
   --- Level 3
   ---
   subtype Accommodation_services_secondary_Range is Restaurants_and_hotels_main_Range range hotel_motel_and_or_or_boarding_fees_paying_for_yourself .. boarding_and_lodging;
   subtype Actual_rentals_for_housing_secondary_Range is Housing_water_electricity_gas_and_other_fuels_main_Range range rent_dwelling .. rent_dwelling;
   subtype Alcoholic_beverages_secondary_Range is Alcoholic_beverages_tobacco_and_narcotics_main_Range range spirits_such_as_brandy_whisky_gin_liqueurs .. sorghum_beer_traditional_not_from_a_food_service_place;
   subtype Audio_visual_photographic_and_information_processing_equipment_secondary_Range is Recreation_and_culture_main_Range range radios_including_motor_car_radios_tape_recorders_compact_disk_players_and_similar_equipment .. other_musical_instruments_sound_equipment_and_accessories;
   subtype Catering_services_secondary_Range is Restaurants_and_hotels_main_Range range coffee .. other_prepared_meals_11121190;
   subtype Clothing_secondary_Range is Clothing_and_footwear_main_Range range material_for_clothing .. cost_of_the_hire_of_clothing;
   subtype Debts_arreas_on_municipal_bills_secondary_Range is Debts_main_Range range arreas_on_municipal_bills .. arreas_on_municipal_bills;
   subtype Debts_bank_overdraft_secondary_Range is Debts_main_Range range bank_overdraft .. bank_overdraft;
   subtype Debts_bond_loan_from_the_bank_and_other_loans_secondary_Range is Debts_main_Range range bond_loan_from_the_bank .. other_loans;
   subtype Debts_expenditure_incurred_in_obtaining_income_secondary_Range is Loss_main_Range range expenditure_incurred_in_obtaining_income .. expenditure_incurred_in_obtaining_income;
   subtype Debts_furniture_and_appliances_amount_oustanding_secondary_Range is Debts_main_Range range furniture_and_appliances_amount_oustanding .. furniture_and_appliances_amount_oustanding;
   subtype Debts_loans_from_friends_and_family_secondary_Range is Debts_main_Range range loans_from_friends_and_family .. loans_from_friends_and_family;
   subtype Debts_loans_from_money_lenders_secondary_Range is Debts_main_Range range loans_from_money_lenders .. loans_from_money_lenders;
   subtype Debts_motor_vehicle_loan_from_the_bank_secondary_Range is Debts_main_Range range motor_vehicle_loan_from_the_bank .. motor_vehicle_loan_from_the_bank;
   subtype Debts_other_bank_loans_secondary_Range is Debts_main_Range range other_bank_loans .. other_bank_loans;
   subtype Debts_retail_stores_secondary_Range is Debts_main_Range range retail_stores_clothers_on_account_or_lay_bye_amount_outstanding .. retail_stores_clothers_on_account_or_lay_bye_amount_outstanding;
   subtype Education_not_definable_by_level_secondary_Range is Education_main_Range range vocational_training_in_public_institutions .. other_tuition_fees_for_public_institutions;
   subtype Electricity_gas_and_other_fuels_secondary_Range is Housing_water_electricity_gas_and_other_fuels_main_Range range electricity .. other_household_fuel;
   subtype Financial_services_nec_secondary_Range is Miscellaneous_goods_and_services_main_Range range bank_charges .. interest_or_finance_charges;
   subtype Food_secondary_Range is Food_and_non_alcoholic_beverages_main_Range range rice .. other_livestock_from_own_production;
   subtype Footwear_secondary_Range is Clothing_and_footwear_main_Range range mens_footwear .. cost_of_hire_of_shoes;
   subtype Furniture_and_furnishings_carpets_and_other_floor_covering_secondary_Range is Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range range other_bedroom_furniture .. repairs_to_floor_coverings;
   subtype Glassware_tableware_andhousehold_utensils_secondary_Range is Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range range glass_and_crystal_ware_tableware_including_household_or_toilet_articles_of_porcelain_ceramic_stoneware_china_etc .. value_of_repairs_on_glassware_tableware_and_household_utensils;
   subtype Goods_and_services_for_routine_household_maintenance_secondary_Range is Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range range soap_bars_and_cakes_not_toilet_soap_washing_powders_liquid_detergents_and_bleaches_dishwasher_tablets .. grinding_or_gristing_of_maize_or_wheat;
   subtype Hospital_services_secondary_Range is Health_main_Range range hospital_service_fees_eg_wards_beds_and_theatre_fees_in_private_institutions .. hospital_service_fees_eg_wards_beds_and_theatre_fees_in_public_institutions;
   subtype Household_appliances_secondary_Range is Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range range refrigerators_deep_freezers_and_refrigerator_or_deep_freeze_combinations .. repairs_and_service_charges_for_non_electrical_appliances;
   subtype Household_textiles_secondary_Range is Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range range bed_bases_and_mattresses .. value_of_repairs_to_household_textiles;
   subtype Imputed_cost_for_home_production_secondary_Range is Not_cpi_consumption_main_Range range seed .. other_items_from_own_production;
   subtype Imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary_Range is Income_main_Range range imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling .. imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling;
   subtype Imputed_rentals_for_housing_secondary_Range is Housing_water_electricity_gas_and_other_fuels_main_Range range imputed_rent_on_owned_dwellingi_7pct_peryear_of_dwelling .. imputed_rent_on_owned_dwellingi_7pct_peryear_of_dwelling;
   subtype Imputed_rentals_of_owner_occupiers_secondary_Range is Not_cpi_consumption_main_Range range imputed_rent_on_owned_dwelling .. imputed_rent_on_owned_dwelling;
   subtype In_kind_consumption_secondary_Range is In_kind_consumption_main_Range range free_water .. medical_aid_contribution_contribution_by_employer_in_public_institutions;
   subtype In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary_Range is Income_in_kind_main_Range range pre_primary_education_in_public_institutions_grant_income .. other_tuition_fees_for_private_institutions_grant_income;
   subtype In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range is Income_in_kind_main_Range range schools_boarding_fees_in_public_institutions_grant_income .. medical_aid_contribution_contribution_by_employer_in_public_institutions_income;
   subtype In_kind_income_from_free_electricity_secondary_Range is Income_in_kind_main_Range range free_electricity_income .. free_electricity_income;
   subtype In_kind_income_from_free_sanitation_secondary_Range is Income_in_kind_main_Range range free_sanitation_income .. free_sanitation_income;
   subtype In_kind_income_from_free_water_secondary_Range is Income_in_kind_main_Range range free_water_income .. free_water_income;
   subtype In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary_Range is Income_in_kind_main_Range range estimated_value_of_private_use_of_company_or_similar_vehicle_income .. value_of_discounted_fares_for_non_educational_purposes_income;
   subtype In_kind_income_from_schools_and_other_edu_inst_grant_secondary_Range is Income_in_kind_main_Range range schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public_income .. schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat_income;
   subtype In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range is Income_in_kind_main_Range range library_fees_fines_grant_for_academic_purpose_income .. other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions_income;
   subtype Income_from_capital_secondary_Range is Income_main_Range range income_from_letting_of_fixed_property .. other_dividends;
   subtype Income_from_individuals_secondary_Range is Income_main_Range range alimony_palimony_and_other_allowances .. other_income_from_individuals;
   subtype Income_from_work_secondary_Range is Income_main_Range range household_salaries_and_wages .. household_self_employment_and_business;
   subtype Insurance_secondary_Range is Miscellaneous_goods_and_services_main_Range range insurance_on_buildings .. funeral_policies;
   subtype Interest_on_mortgage_bonds_secondary_Range is Not_cpi_consumption_main_Range range interest_on_mortgage_bonds .. interest_on_mortgage_bonds;
   subtype Maintenance_and_repair_of_the_dwelling_secondary_Range is Housing_water_electricity_gas_and_other_fuels_main_Range range maintenance_and_repair_of_dwelling_existing_buildings_swimming_pools_etc_including_paints_wallpaper_etc .. swimming_pool_maintenance_excluding_wages_of_persons_who_maintain_pools_but_including_chemicals;
   subtype Medical_products_appliances_and_equipment_secondary_Range is Health_main_Range range medicine_purchased_with_prescription_in_private_institutions .. therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_public_institutions;
   subtype Newspapers_books_and_stationary_secondary_Range is Recreation_and_culture_main_Range range textbooks_for_public_institutions .. other_specify_eg_junior_laptops_training_and_adult_education_for_private_institutions;
   subtype Non_alcoholic_beverages_secondary_Range is Food_and_non_alcoholic_beverages_main_Range range instant_coffee .. fruit_and_vegetable_juices_combined_not_from_food_service_places;
   subtype Operation_of_personal_transport_equipment_secondary_Range is Transport_main_Range range new_tyres_and_tubes .. other_transport_specify;
   subtype Operational_values_of_other_modes_of_transport_secondary_Range is Transport_main_Range range saddles .. other_cost_for_other_modes_of_transport;
   subtype Other_income_secondary_Range is Income_main_Range range hobbis .. gratuities_and_other_lump_sum_payments;
   subtype Other_major_durables_for_recreation_and_culture_secondary_Range is Recreation_and_culture_main_Range range boats_including_outboard_motors_aircrafts_go_carts .. repairs_and_maintenance_services_to_recreation_entertainment_and_sports_equipment;
   subtype Other_products_not_consumption_secondary_Range is Not_cpi_consumption_main_Range range good_and_services_received_by_virtue_of_occupation .. value_of_transport;
   subtype Other_recreational_items_and_equipment_garden_and_pets_secondary_Range is Recreation_and_culture_main_Range range hobbies .. care_eg_doggy_parlour_kennels_and_veterinary_costs;
   subtype Other_services_nec_secondary_Range is Miscellaneous_goods_and_services_main_Range range levy_for_sectional_title .. other_expenditure;
   subtype Others_diary_secondary_Range is Other_unclasified_expenses_main_Range range unclassified_diary_items_except_food .. unclassified_diary_items_except_food;
   subtype Others_main_secondary_Range is Other_unclasified_expenses_main_Range range others_expenditures_except_food .. others_expenditures_except_food;
   subtype Out_patient_services_secondary_Range is Health_main_Range range medical_services_in_private_institutions .. non_hospital_service_ambulance_service_other_than_hospital_in_private_institutions;
   subtype Package_holidays_secondary_Range is Recreation_and_culture_main_Range range holiday_tour_package .. holiday_tour_package;
   subtype Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary_Range is Not_cpi_consumption_main_Range range panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party .. other_repair_work_paid_for_by_your_insurance_company_or_other_party;
   subtype Pensions_social_insuerance_family_allowances_secondary_Range is Income_main_Range range pension_from_previous_employment .. workmens_compensation_funds;
   subtype Personal_care_secondary_Range is Miscellaneous_goods_and_services_main_Range range mens_and_boys .. other_personal_care_products;
   subtype Personal_effects_secondary_Range is Miscellaneous_goods_and_services_main_Range range watches_and_personal_jewellery .. other_umbrellas_pocket_knives_sunglasses_etc_including_repairs;
   subtype Postal_services_secondary_Range is Communication_main_Range range stamps .. other_eg_telegrams;
   subtype Pre_primary_and_primary_education_secondary_Range is Education_main_Range range pre_primary_education_in_public_institutions .. primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions;
   subtype Purchase_of_vehicles_secondary_Range is Transport_main_Range range new_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes .. other_private_modes_of_transport_animals;
   subtype Recreational_and_cultural_services_secondary_Range is Recreation_and_culture_main_Range range amusement_parks .. other_gambling;
   subtype Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_Range is Savings_main_Range range improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts .. labour_and_material_for_improvements_additions_and_alterations;
   subtype Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary_Range is Savings_main_Range range repayment_on_loans_and_overdrafts .. employer_contribution_to_pension_provident_and_annuity_funds;
   subtype Savings_from_contributions_to_a_stokvel_secondary_Range is Savings_main_Range range contributions_to_a_stokvel .. contributions_to_a_stokvel;
   subtype Savings_from_deposits_and_wthdrawals_secondary_Range is Savings_main_Range range deposits_into_savings .. wthdrawals_from_savings;
   subtype Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary_Range is Savings_main_Range range life_and_endownment_policies .. life_insurance_covering_mortgage_debt;
   subtype Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range is Savings_main_Range range listed_company_shares .. other_investments;
   subtype Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_Range is Savings_main_Range range cost_of_other_dewlling .. levy_on_timeshare;
   subtype Secondary_education_secondary_Range is Education_main_Range range secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution .. secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution;
   subtype Social_protection_secondary_Range is Miscellaneous_goods_and_services_main_Range range day_care_mothers_creches_and_playgrounds_in_public_institutions .. day_care_mothers_creches_and_playgrounds_in_private_institutions;
   subtype Subsidy_on_payment_of_mortgage_secondary_Range is Not_cpi_consumption_main_Range range subsidy_on_payment_of_mortgage .. subsidy_on_payment_of_mortgage;
   subtype Taxes_amnesty_tax_secondary_Range is Taxes_main_Range range amnesty_tax .. amnesty_tax;
   subtype Taxes_site_paye_and_income_tax_secondary_Range is Taxes_main_Range range site_income_tax .. according_to_assessment_income_tax;
   subtype Taxes_uif_secondary_Range is Taxes_main_Range range unemployment_insurance_fund_uif .. unemployment_insurance_fund_uif;
   subtype Telephone_and_telefax_equipment_secondary_Range is Communication_main_Range range cellular_phones .. repairs_of_computers_and_communication_equipment;
   subtype Telephone_and_telefax_services_secondary_Range is Communication_main_Range range installation .. internet_subscription_and_other_costs;
   subtype Tertiary_education_secondary_Range is Education_main_Range range tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions .. tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions;
   subtype Tobacco_secondary_Range is Alcoholic_beverages_tobacco_and_narcotics_main_Range range cigarettes .. other_items_smoked;
   subtype Tools_and_equipment_for_house_and_garden_secondary_Range is Furnishings_househould_equipment_and_routine_maintenance_of_the_house_main_Range range power_driven_garden_tools .. other_garden_equipment;
   subtype Transfers_to_others_secondary_Range is Transfers_to_others_main_Range range in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children .. tribal_levies_not_for_housing;
   subtype Transport_services_secondary_Range is Transport_main_Range range train_for_attending_educational_institutions .. other_eg_horse_for_non_educational_puporses;
   subtype Unclassified_food_items_secondary_Range is Food_and_non_alcoholic_beverages_main_Range range unclassified_expenditures_on_food .. unclassified_expenditures_on_food;
   subtype Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_Range is Housing_water_electricity_gas_and_other_fuels_main_Range range water_and_electricity .. vat_on_utilities;
   ---
   --- Level 4
   ---
   subtype Accommodation_services_tertiary_Range is Accommodation_services_secondary_Range range hotel_motel_and_or_or_boarding_fees_paying_for_yourself .. boarding_and_lodging;
   subtype Actual_rentals_paid_by_tenants_tertiary_Range is Actual_rentals_for_housing_secondary_Range range rent_dwelling .. rent_dwelling;
   subtype Animal_drawn_vehicle_tertiary_Range is Purchase_of_vehicles_secondary_Range range new_animal_drawn_vehicles .. other_private_modes_of_transport_animals;
   subtype Beer_tertiary_Range is Alcoholic_beverages_secondary_Range range clear_beer_not_purchased_from_a_food_service_place .. sorghum_beer_traditional_not_from_a_food_service_place;
   subtype Beverages_in_restaurants_cafes_canteens_and_the_likes_tertiary_Range is Catering_services_secondary_Range range coffee .. sorghum_beer_traditional_from_a_food_service_place;
   subtype Bicycles_tertiary_Range is Purchase_of_vehicles_secondary_Range range new_bicycles .. used_bicycles;
   subtype Books_tertiary_Range is Newspapers_books_and_stationary_secondary_Range range textbooks_for_public_institutions .. books_excluding_those_in_1614;
   subtype Bread_and_cereals_tertiary_Range is Food_secondary_Range range rice .. other_grains;
   subtype Carpets_and_other_floor_covering_tertiary_Range is Furniture_and_furnishings_carpets_and_other_floor_covering_secondary_Range range fitted_carpets .. other_floor_coverings_excluding_bathroom_and_door_mats_specify;
   subtype Cleaning_repair_and_hire_of_clothing_tertiary_Range is Clothing_secondary_Range range cleaning_of_clothing .. cost_of_the_hire_of_clothing;
   subtype Clothing_materials_tertiary_Range is Clothing_secondary_Range range material_for_clothing .. material_for_clothing;
   subtype Coffee_tea_and_cocoa_tertiary_Range is Non_alcoholic_beverages_secondary_Range range instant_coffee .. other_hot_drinks;
   subtype Consumption_others_expenditures_tertiary_Range is Others_main_secondary_Range range others_expenditures_except_food .. others_expenditures_except_food;
   subtype Consumption_unclassified_diary_items_tertiary_Range is Others_diary_secondary_Range range unclassified_diary_items_except_food .. unclassified_diary_items_except_food;
   subtype Cost_for_other_modes_of_transport_tertiary_Range is Operational_values_of_other_modes_of_transport_secondary_Range range saddles .. other_cost_for_other_modes_of_transport;
   subtype Cultural_services_tertiary_Range is Recreational_and_cultural_services_secondary_Range range cinema_theatres_concerts_festivals .. admission_charges_other;
   subtype Debts_arreas_on_municipal_bills_tertiary_Range is Debts_arreas_on_municipal_bills_secondary_Range range arreas_on_municipal_bills .. arreas_on_municipal_bills;
   subtype Debts_bank_overdraft_tertiary_Range is Debts_bank_overdraft_secondary_Range range bank_overdraft .. bank_overdraft;
   subtype Debts_bond_loan_from_the_bank_tertiary_Range is Debts_bond_loan_from_the_bank_and_other_loans_secondary_Range range bond_loan_from_the_bank .. bond_loan_from_the_bank;
   subtype Debts_furniture_and_appliances_amount_oustanding_tertiary_Range is Debts_furniture_and_appliances_amount_oustanding_secondary_Range range furniture_and_appliances_amount_oustanding .. furniture_and_appliances_amount_oustanding;
   subtype Debts_loans_from_friends_and_family_tertiary_Range is Debts_loans_from_friends_and_family_secondary_Range range loans_from_friends_and_family .. loans_from_friends_and_family;
   subtype Debts_loans_from_money_lenders_tertiary_Range is Debts_loans_from_money_lenders_secondary_Range range loans_from_money_lenders .. loans_from_money_lenders;
   subtype Debts_motor_vehicle_loan_from_the_bank_tertiary_Range is Debts_motor_vehicle_loan_from_the_bank_secondary_Range range motor_vehicle_loan_from_the_bank .. motor_vehicle_loan_from_the_bank;
   subtype Debts_other_bank_loans_tertiary_Range is Debts_other_bank_loans_secondary_Range range other_bank_loans .. other_bank_loans;
   subtype Debts_other_loans_tertiary_Range is Debts_bond_loan_from_the_bank_and_other_loans_secondary_Range range other_loans .. other_loans;
   subtype Debts_retail_stores_tertiary_Range is Debts_retail_stores_secondary_Range range retail_stores_clothers_on_account_or_lay_bye_amount_outstanding .. retail_stores_clothers_on_account_or_lay_bye_amount_outstanding;
   subtype Dental_services_tertiary_Range is Out_patient_services_secondary_Range range dental_service_service_of_dentists_include_oral_hygienists_in_private_institutions .. dental_service_service_of_dentists_include_oral_hygienists_in_public_institutions;
   subtype Domestics_services_and_household_arcticles_tertiary_Range is Goods_and_services_for_routine_household_maintenance_secondary_Range range cash_wage_incl_transport_received_by_general_domestic_worker .. grinding_or_gristing_of_maize_or_wheat;
   subtype Education_not_definable_by_level_tertiary_Range is Education_not_definable_by_level_secondary_Range range vocational_training_in_public_institutions .. other_tuition_fees_for_public_institutions;
   subtype Elecrtical_appliances_for_personal_care_tertiary_Range is Personal_care_secondary_Range range hairdryers .. other_eg_hot_brush_vibrator_etc;
   subtype Electricity_tertiary_Range is Electricity_gas_and_other_fuels_secondary_Range range electricity .. prepaid_electricity;
   subtype Equipment_for_sport_camping_and_open_air_recreation_tertiary_Range is Other_recreational_items_and_equipment_garden_and_pets_secondary_Range range firearms_and_ammunition .. swimming_pool_equipment_and_repairs_of_equipment;
   subtype Equipment_for_the_reception_recording_and_reproduction_of_sound_and_pictures_tertiary_Range is Audio_visual_photographic_and_information_processing_equipment_secondary_Range range radios_including_motor_car_radios_tape_recorders_compact_disk_players_and_similar_equipment .. aerials_and_satellite_dishes;
   subtype Financial_services_nec_tertiary_Range is Financial_services_nec_secondary_Range range bank_charges .. interest_or_finance_charges;
   subtype Fish_tertiary_Range is Food_secondary_Range range fresh_or_chilled_fish .. other_preserved_or_processed_fish_and_seafood;
   subtype Food_products_nec_tertiary_Range is Food_secondary_Range range vinegar .. other_livestock_from_own_production;
   subtype Fruits_tertiary_Range is Food_secondary_Range range oranges .. vegetables;
   subtype Fuels_and_lubricants_tertiary_Range is Operation_of_personal_transport_equipment_secondary_Range range motor_car_fuel .. oil_and_grease;
   subtype Furniture_and_furnishings_tertiary_Range is Furniture_and_furnishings_carpets_and_other_floor_covering_secondary_Range range other_bedroom_furniture .. other_furniture;
   subtype Games_of_chances_tertiary_Range is Recreational_and_cultural_services_secondary_Range range lotto .. other_gambling;
   subtype Games_toys_and_hobbies_tertiary_Range is Other_recreational_items_and_equipment_garden_and_pets_secondary_Range range hobbies .. fire_works;
   subtype Gardens_plants_and_flowers_tertiary_Range is Other_recreational_items_and_equipment_garden_and_pets_secondary_Range range seed_plants_shrubs_and_trees_fertilizer_plant_and_pest_spray_remedies .. garden_ornaments;
   subtype Garments_tertiary_Range is Clothing_secondary_Range range mens_clothing .. other_specify;
   subtype Gas_tertiary_Range is Electricity_gas_and_other_fuels_secondary_Range range gas .. gas_in_cylinders_including_gas_for_heating_purposes;
   subtype Glassware_tableware_and_household_utensils_tertiary_Range is Glassware_tableware_andhousehold_utensils_secondary_Range range glass_and_crystal_ware_tableware_including_household_or_toilet_articles_of_porcelain_ceramic_stoneware_china_etc .. value_of_repairs_on_glassware_tableware_and_household_utensils;
   subtype Hairdressing_salons_and_personal_grooming_astablishment_tertiary_Range is Personal_care_secondary_Range range mens_and_boys .. womens_and_girls;
   subtype Hospital_services_tertiary_Range is Hospital_services_secondary_Range range hospital_service_fees_eg_wards_beds_and_theatre_fees_in_private_institutions .. hospital_service_fees_eg_wards_beds_and_theatre_fees_in_public_institutions;
   subtype Household_textile_tertiary_Range is Household_textiles_secondary_Range range bed_bases_and_mattresses .. value_of_repairs_to_household_textiles;
   subtype Imputed_cost_for_home_production_tertiary_Range is Imputed_cost_for_home_production_secondary_Range range seed .. other_items_from_own_production;
   subtype Imputed_rentals_of_owner_occupiers_tertiary_Range is Imputed_rentals_of_owner_occupiers_secondary_Range range imputed_rent_on_owned_dwelling .. imputed_rent_on_owned_dwelling;
   subtype In_kind_consumption_tertiary_Range is In_kind_consumption_secondary_Range range free_water .. medical_aid_contribution_contribution_by_employer_in_public_institutions;
   subtype In_kind_income_from_computer_certification_excursions_and_other_grants_public_and_private_tertiary_Range is In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary_Range range computer_certification_public_schools_grant_income .. other_tuition_fees_for_private_institutions_grant_income;
   subtype In_kind_income_from_estimated_value_of_private_use_of_company_vehicle_tertiary_Range is In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary_Range range estimated_value_of_private_use_of_company_or_similar_vehicle_income .. estimated_value_of_private_use_of_company_or_similar_vehicle_income;
   subtype In_kind_income_from_free_electricity_tertiary_Range is In_kind_income_from_free_electricity_secondary_Range range free_electricity_income .. free_electricity_income;
   subtype In_kind_income_from_free_sanitation_tertiary_Range is In_kind_income_from_free_sanitation_secondary_Range range free_sanitation_income .. free_sanitation_income;
   subtype In_kind_income_from_free_water_tertiary_Range is In_kind_income_from_free_water_secondary_Range range free_water_income .. free_water_income;
   subtype In_kind_income_from_library_fees_fines_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range library_fees_fines_grant_for_academic_purpose_income .. library_fees_fines_grant_for_academic_purpose_income;
   subtype In_kind_income_from_library_services_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range library_services_grant_for_academic_purposes_income .. library_services_grant_for_academic_purposes_income;
   subtype In_kind_income_from_other_specify_private_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions_income .. other_specify_grant_eg_junior_laptops_training_and_adult_education_for_private_institutions_income;
   subtype In_kind_income_from_other_specify_public_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions_income .. other_specify_granteg_junior_laptops_training_and_adult_education_for_public_institutions_income;
   subtype In_kind_income_from_pre_primary_primary_tertiary_education_and_vocational_training_grants_public_and_private_tertiary_Range is In_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary_Range range pre_primary_education_in_public_institutions_grant_income .. vocational_training_in_public_institutions_grant_income;
   subtype In_kind_income_from_schools_and_other_edu_inst_privat_grant_tertiary_Range is In_kind_income_from_schools_and_other_edu_inst_grant_secondary_Range range schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat_income .. schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat_income;
   subtype In_kind_income_from_schools_and_other_edu_inst_publice_grant_tertiary_Range is In_kind_income_from_schools_and_other_edu_inst_grant_secondary_Range range schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public_income .. schools_and_other_edu_inst_grant_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_public_income;
   subtype In_kind_income_from_schools_boarding_fees_in_private_institutions_grant_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range schools_boarding_fees_in_private_institutions_grant_income .. schools_boarding_fees_in_private_institutions_grant_income;
   subtype In_kind_income_from_schools_boarding_fees_in_public_institutions_grant_public_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range schools_boarding_fees_in_public_institutions_grant_income .. schools_boarding_fees_in_public_institutions_grant_income;
   subtype In_kind_income_from_stationery_private_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions_income .. stationery_grant_for_academic_purposes_excluding_calculators_for_private_institutions_income;
   subtype In_kind_income_from_stationery_public_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions_income .. stationery_grant_for_academic_purposes_excluding_calculators_for_public_institutions_income;
   subtype In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_income .. teachers_training_and_technical_colleges_technikons_boarding_fees_in_private_institutions_grant_income;
   subtype In_kind_income_from_teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_income .. teachers_training_and_technical_colleges_technikons_boarding_fees_in_public_institutions_grant_income;
   subtype In_kind_income_from_textbooks_for_private_institutions_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range textbooks_for_private_institutions_grant_income .. textbooks_for_private_institutions_grant_income;
   subtype In_kind_income_from_textbooks_for_public_institutions_grant_tertiary_Range is In_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary_Range range textbooks_for_public_institutions_grant_income .. textbooks_for_public_institutions_grant_income;
   subtype In_kind_income_from_universities_boarding_fees_in_private_institution_and_medical_aidby_employer_grant_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range day_care_mothers_creches_and_playgrounds_in_public_institutions_grant_income .. medical_aid_contribution_contribution_by_employer_in_public_institutions_income;
   subtype In_kind_income_from_universities_boarding_fees_in_private_institution_grant_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range universities_boarding_fees_in_private_institution_grant_income .. universities_boarding_fees_in_private_institution_grant_income;
   subtype In_kind_income_from_universities_boarding_fees_in_public_institution_grant_tertiary_Range is In_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary_Range range universities_boarding_fees_in_public_institution_grant_income .. universities_boarding_fees_in_public_institution_grant_income;
   subtype In_kind_income_from_value_of_discounted_fares_for_educational_purposes_tertiary_Range is In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary_Range range value_of_discounted_fares_for_educational_purposes_income .. value_of_discounted_fares_for_educational_purposes_income;
   subtype In_kind_income_from_value_of_discounted_fares_for_non_educational_purposes_tertiary_Range is In_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary_Range range value_of_discounted_fares_for_non_educational_purposes_income .. value_of_discounted_fares_for_non_educational_purposes_income;
   subtype Income_from_alimony_palimony_and_other_allowances_tertiary_Range is Income_from_individuals_secondary_Range range alimony_palimony_and_other_allowances .. alimony_palimony_and_other_allowances;
   subtype Income_from_annuities_from_own_investment_tertiary_Range is Pensions_social_insuerance_family_allowances_secondary_Range range annuities_from_own_investment .. annuities_from_own_investment;
   subtype Income_from_dividends_tertiary_Range is Income_from_capital_secondary_Range range dividends_of_listed_companies .. dividends_of_unlisted_companies;
   subtype Income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_tertiary_Range is Imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling_secondary_Range range imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling .. imputed_rent_income_on_owned_dwellingi_7pct_peryear_of_dwelling;
   subtype Income_from_other_dividends_tertiary_Range is Income_from_capital_secondary_Range range other_dividends .. other_dividends;
   subtype Income_from_pension_from_previous_employment_tertiary_Range is Pensions_social_insuerance_family_allowances_secondary_Range range pension_from_previous_employment .. pension_from_previous_employment;
   subtype Income_from_property_tertiary_Range is Income_from_capital_secondary_Range range income_from_letting_of_fixed_property .. income_from_letting_of_fixed_property;
   subtype Income_from_royalties_tertiary_Range is Income_from_capital_secondary_Range range royalties .. royalties;
   subtype Income_from_salaries_and_wages_tertiary_Range is Income_from_work_secondary_Range range household_salaries_and_wages .. household_salaries_and_wages;
   subtype Income_from_self_employment_and_business_tertiary_Range is Income_from_work_secondary_Range range household_self_employment_and_business .. household_self_employment_and_business;
   subtype Income_from_social_pensions_tertiary_Range is Pensions_social_insuerance_family_allowances_secondary_Range range old_age_pensions .. workmens_compensation_funds;
   subtype Income_interest_received_tertiary_Range is Income_from_capital_secondary_Range range interest_received .. interest_received;
   subtype Information_processing_equipment_tertiary_Range is Audio_visual_photographic_and_information_processing_equipment_secondary_Range range personal_desktop_computers_excluding_laptops .. parts_and_upgrading_of_computers;
   subtype Insurance_connected_with_the_dwelling_tertiary_Range is Insurance_secondary_Range range insurance_on_buildings .. package_insurance;
   subtype Insurance_connected_with_the_health_tertiary_Range is Insurance_secondary_Range range medical_insurance .. insurance_paid_for_holiday_purposes_life_luggage_medical;
   subtype Insurance_connected_with_the_transport_tertiary_Range is Insurance_secondary_Range range insurance_for_private_transport .. insurance_for_private_transport;
   subtype Interest_on_mortgage_bonds_tertiary_Range is Interest_on_mortgage_bonds_secondary_Range range interest_on_mortgage_bonds .. interest_on_mortgage_bonds;
   subtype Jewellery_clocks_and_watches_tertiary_Range is Personal_effects_secondary_Range range watches_and_personal_jewellery .. watches_and_personal_jewellery;
   subtype Liquid_fuels_tertiary_Range is Electricity_gas_and_other_fuels_secondary_Range range paraffin .. diesel_for_household_use_not_transport;
   subtype Loss_expenditure_incurred_in_obtaining_income_tertiary_Range is Debts_expenditure_incurred_in_obtaining_income_secondary_Range range expenditure_incurred_in_obtaining_income .. expenditure_incurred_in_obtaining_income;
   subtype Maintenance_and_repair_of_other_major_durables_for_recreation_and_culture_tertiary_Range is Other_major_durables_for_recreation_and_culture_secondary_Range range repairs_and_service_charges_for_musical_instruments_sound_equipment_and_accessories .. repairs_and_maintenance_services_to_recreation_entertainment_and_sports_equipment;
   subtype Maintenance_and_repairs_of_personal_transport_equipment_tertiary_Range is Operation_of_personal_transport_equipment_secondary_Range range maintenance_and_lubrication_services .. valet_services;
   subtype Major_durables_for_outdoor_recreation_tertiary_Range is Other_major_durables_for_recreation_and_culture_secondary_Range range boats_including_outboard_motors_aircrafts_go_carts .. used_caravans_and_trailers_including_motorised_caravans;
   subtype Major_household_appliances_wheter_or_no_aelectriccal_tertiary_Range is Household_appliances_secondary_Range range refrigerators_deep_freezers_and_refrigerator_or_deep_freeze_combinations .. sewing_and_knitting_machines;
   subtype Major_tools_and_equipment_tertiary_Range is Tools_and_equipment_for_house_and_garden_secondary_Range range power_driven_garden_tools .. power_drills;
   subtype Materials_for_maintenance_and_repair_of_the_dwelling_tertiary_Range is Maintenance_and_repair_of_the_dwelling_secondary_Range range maintenance_and_repair_of_dwelling_existing_buildings_swimming_pools_etc_including_paints_wallpaper_etc .. maintenance_and_repair_of_dwelling_existing_buildings_swimming_pools_etc_including_paints_wallpaper_etc;
   subtype Meals_in_restaurants_cafes_canteens_and_the_likes_tertiary_Range is Catering_services_secondary_Range range burger .. other_prepared_meals_11121190;
   subtype Meat_tertiary_Range is Food_secondary_Range range beef_and_veal_incl_heads_and_feet .. poultry;
   subtype Medical_services_tertiary_Range is Out_patient_services_secondary_Range range medical_services_in_private_institutions .. consultations_of_traditional_healers_in_public_institutions;
   subtype Milk_cheese_and_eggs_tertiary_Range is Food_secondary_Range range fresh_full_cream_milk .. eggs;
   subtype Mineral_waters_soft_drinks_fruit_and_vegetable_juices_tertiary_Range is Non_alcoholic_beverages_secondary_Range range mineral_water_or_spring_water_aerated_and_still .. fruit_and_vegetable_juices_combined_not_from_food_service_places;
   subtype Miscellaneous_printed_matter_tertiary_Range is Newspapers_books_and_stationary_secondary_Range range miscellaneous_printed_mattereg_road_maps_greeting_cards_posters_etc .. miscellaneous_printed_mattereg_road_maps_greeting_cards_posters_etc;
   subtype Motor_cars_tertiary_Range is Purchase_of_vehicles_secondary_Range range new_motor_cars_station_wagons_and_mini_buses_excluding_vehicles_for_business_purposes .. four_wheel_drive_vehicles_2;
   subtype Motor_cycles_tertiary_Range is Purchase_of_vehicles_secondary_Range range new_motor_cycles_and_scooters .. used_motor_cycles_and_scooters;
   subtype Musical_instrument_and_major_durables_for_outdoor_recreation_tertiary_Range is Other_major_durables_for_recreation_and_culture_secondary_Range range musical_instruments_pianos_organs_and_other_musical_instruments .. musical_instruments_pianos_organs_and_other_musical_instruments;
   subtype Newspaper_and_periodicals_tertiary_Range is Newspapers_books_and_stationary_secondary_Range range newspapers_daily_weekly .. magazines_and_periodicals;
   subtype Non_durable_household_goods_tertiary_Range is Goods_and_services_for_routine_household_maintenance_secondary_Range range soap_bars_and_cakes_not_toilet_soap_washing_powders_liquid_detergents_and_bleaches_dishwasher_tablets .. methylated_spirits_fuel_for_lawnmowers_and_generators_and_for_heating_excluding_fuel_for_your_motor_vehicles;
   subtype Oils_and_fats_tertiary_Range is Food_secondary_Range range butter .. fruit;
   subtype Other_appliances_articles_and_products_for_personal_care_tertiary_Range is Personal_care_secondary_Range range hair_pieces .. other_personal_care_products;
   subtype Other_articles_of_clothing_and_clothing_accessories_tertiary_Range is Clothing_secondary_Range range clothing_accessories_such_as_scarves_ties_belts_gloves_etc .. patterns_trimming_lace_sewing_cotton_etc;
   subtype Other_income_from_individuals_tertiary_Range is Income_from_individuals_secondary_Range range other_income_from_individuals .. other_income_from_individuals;
   subtype Other_income_tertiary_Range is Other_income_secondary_Range range hobbis .. gratuities_and_other_lump_sum_payments;
   subtype Other_insurance_tertiary_Range is Insurance_secondary_Range range funeral_policies .. funeral_policies;
   subtype Other_medical_products_tertiary_Range is Medical_products_appliances_and_equipment_secondary_Range range other_medical_products_bandages_syringes_knee_supports_etc_in_private_institutions .. condoms_strings_and_other_contraceptives_excluding_tablets_and_injections;
   subtype Other_personal_effects_tertiary_Range is Personal_effects_secondary_Range range handbags_travelling_bags_schoolbags_etc .. other_umbrellas_pocket_knives_sunglasses_etc_including_repairs;
   subtype Other_products_not_consumption_tertiary_Range is Other_products_not_consumption_secondary_Range range good_and_services_received_by_virtue_of_occupation .. value_of_transport;
   subtype Other_puchased_transport_services_tertiary_Range is Transport_services_secondary_Range range furniture_removals_and_transport_of_goods_not_for_business_purposes_for_educational_purposes .. other_eg_horse_for_non_educational_puporses;
   subtype Other_services_in_respect_of_personal_transport_equipment_tertiary_Range is Operation_of_personal_transport_equipment_secondary_Range range parking_fees .. other_transport_specify;
   subtype Other_services_relating_to_the_dwelling_tertiary_Range is Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_Range range rate_and_taxes .. vat_on_utilities;
   subtype Other_services_tertiary_Range is Other_services_nec_secondary_Range range levy_for_sectional_title .. other_expenditure;
   subtype Package_holidays_tertiary_Range is Package_holidays_secondary_Range range holiday_tour_package .. holiday_tour_package;
   subtype Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_tertiary_Range is Panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party_secondary_Range range panel_beating_repairs_paid_for_by_your_insurance_company_or_other_party .. other_repair_work_paid_for_by_your_insurance_company_or_other_party;
   subtype Paramedic_services_tertiary_Range is Out_patient_services_secondary_Range range medical_analysis_laboratories_and_x_ray_service_in_private_institutions .. non_hospital_service_ambulance_service_other_than_hospital_in_private_institutions;
   subtype Passenger_transport_by_air_tertiary_Range is Transport_services_secondary_Range range aircraft_educaional_trips .. aircraft;
   subtype Passenger_transport_by_railway_tertiary_Range is Transport_services_secondary_Range range train_for_attending_educational_institutions .. train_for_when_away_from_home;
   subtype Passenger_transport_by_road_tertiary_Range is Transport_services_secondary_Range range bus_including_school_bus_for_educational_purposes .. lift_clubs_other;
   subtype Passenger_transport_by_sea_and_inland_waterway_tertiary_Range is Transport_services_secondary_Range range boat_or_ship_educational_trips .. boat_or_ship_while_on_holiday;
   subtype Pets_and_related_products_tertiary_Range is Other_recreational_items_and_equipment_garden_and_pets_secondary_Range range purchase_of_pets .. pet_food_or_feeds_and_other_requisites;
   subtype Pharmaceutical_products_tertiary_Range is Medical_products_appliances_and_equipment_secondary_Range range medicine_purchased_with_prescription_in_private_institutions .. pharmacy_service_fees_in_public_institutions;
   subtype Photographic_and_cinematographic_equipment_and_optical_instruments_tertiary_Range is Audio_visual_photographic_and_information_processing_equipment_secondary_Range range cameras_video_cameras_projectors_and_flashes .. other_recreational_services;
   subtype Postal_services_tertiary_Range is Postal_services_secondary_Range range stamps .. other_eg_telegrams;
   subtype Pre_primary_and_primary_education_tertiary_Range is Pre_primary_and_primary_education_secondary_Range range pre_primary_education_in_public_institutions .. primary_education_includes_literacy_programmes_for_students_too_old_for_primary_school_in_private_institutions;
   subtype Recording_meedia_tertiary_Range is Audio_visual_photographic_and_information_processing_equipment_secondary_Range range diskettes_cds_flah_disks_and_other_consumable_goods .. other_musical_instruments_sound_equipment_and_accessories;
   subtype Recreational_and_sporting_services_tertiary_Range is Recreational_and_cultural_services_secondary_Range range amusement_parks .. schools_and_other_educational_institutions_expenses_incurred_not_normally_regarded_as_tuition_eg_contributions_to_sports_grounds_in_privat;
   subtype Refuse_collection_tertiary_Range is Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_Range range refuse_removel .. refuse_removel;
   subtype Repair_and_hire_of_foowear_tertiary_Range is Footwear_secondary_Range range repair_of_footwear .. cost_of_hire_of_shoes;
   subtype Repair_of_furniture_furnishings_and_floor_covering_tertiary_Range is Furniture_and_furnishings_carpets_and_other_floor_covering_secondary_Range range upholstering .. repairs_to_floor_coverings;
   subtype Repair_of_household_appliance_tertiary_Range is Household_appliances_secondary_Range range repairs_and_service_charges_for_electrical_appliances .. repairs_and_service_charges_for_non_electrical_appliances;
   subtype Savings_from_building_materials_not_included_in_q813_tertiary_Range is Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_Range range building_materials_not_included_in_q813_a_or_c_eg_for_building_purposes .. building_materials_not_included_in_q813_a_or_c_eg_for_building_purposes;
   subtype Savings_from_capital_payments_tertiary_Range is Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_Range range capital_payments_including_deposit .. capital_payments_including_deposit;
   subtype Savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary_Range is Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary_Range range contribution_to_pension_provident_and_annuity_funds .. employer_contribution_to_pension_provident_and_annuity_funds;
   subtype Savings_from_contributions_to_a_stokvel_tertiary_Range is Savings_from_contributions_to_a_stokvel_secondary_Range range contributions_to_a_stokvel .. contributions_to_a_stokvel;
   subtype Savings_from_cost_of_other_dewlling_tertiary_Range is Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_Range range cost_of_other_dewlling .. cost_of_other_dewlling;
   subtype Savings_from_deposits_into_savings_tertiary_Range is Savings_from_deposits_and_wthdrawals_secondary_Range range deposits_into_savings .. deposits_into_savings;
   subtype Savings_from_improvements_additions_and_alterations_tertiary_Range is Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_Range range improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts .. improvements_additions_and_alterations_including_build_in_furniture_solar_energy_systems_swimming_pools_and_garden_layouts;
   subtype Savings_from_investment_plans_tertiary_Range is Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range range investment_plans .. investment_plans;
   subtype Savings_from_labour_and_material_for_improvements_additions_and_alterations_tertiary_Range is Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_Range range labour_and_material_for_improvements_additions_and_alterations .. labour_and_material_for_improvements_additions_and_alterations;
   subtype Savings_from_life_and_endownment_policies_tertiary_Range is Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary_Range range life_and_endownment_policies .. life_and_endownment_policies;
   subtype Savings_from_life_insurance_covering_mortgage_debt_tertiary_Range is Savings_from_life_and_endownment_policies_and_life_insurance_covering_mortgage_debt_secondary_Range range life_insurance_covering_mortgage_debt .. life_insurance_covering_mortgage_debt;
   subtype Savings_from_listed_company_shares_tertiary_Range is Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range range listed_company_shares .. listed_company_shares;
   subtype Savings_from_monthly_capital_payments_tertiary_Range is Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_Range range monthly_capital_payments .. monthly_capital_payments;
   subtype Savings_from_offshore_tertiary_Range is Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range range offshore .. offshore;
   subtype Savings_from_other_investments_tertiary_Range is Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range range other_investments .. other_investments;
   subtype Savings_from_other_payments_tertiary_Range is Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_Range range other_payments_such_as_transfer_duty_and_transfer_costs_and_registration_of_mortgage_bond .. other_payments_such_as_transfer_duty_and_transfer_costs_and_registration_of_mortgage_bond;
   subtype Savings_from_purchase_and_levy_of_timeshare_tertiary_Range is Savings_from_monthly_capital_and_other_payments_levy_on_timeshare_capital_payments_cost_of_other_dewlling_and_purchase_of_timeshare_secondary_Range range purchase_of_timeshare .. levy_on_timeshare;
   subtype Savings_from_repayment_on_loans_and_overdrafts_tertiary_Range is Savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary_Range range repayment_on_loans_and_overdrafts .. repayment_on_loans_and_overdrafts;
   subtype Savings_from_security_structures_tertiary_Range is Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_Range range security_structures_including_fences_electronic_gates .. security_structures_including_fences_electronic_gates;
   subtype Savings_from_services_for_improvements_additions_and_alterations_tertiary_Range is Savings_for_improvements_services_for_improvements_security_structures_building_materials_and_labour_and_material_for_improvements_secondary_Range range services_for_improvements_additions_and_alterationscarpenters_electricians_etc .. services_for_improvements_additions_and_alterationscarpenters_electricians_etc;
   subtype Savings_from_unit_trusts_tertiary_Range is Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range range unit_trusts .. unit_trusts;
   subtype Savings_from_unlisted_company_shares_tertiary_Range is Savings_from_listed_and_unlisted_company_shares_unit_trusts_investment_plans_offshore_and_other_investments_secondary_Range range unlisted_company_shares .. unlisted_company_shares;
   subtype Savings_from_wthdrawals_from_savings_tertiary_Range is Savings_from_deposits_and_wthdrawals_secondary_Range range wthdrawals_from_savings .. wthdrawals_from_savings;
   subtype Scondary_education_tertiary_Range is Secondary_education_secondary_Range range secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_public_institution .. secondary_education_includes_out_of_school_secondary_education_for_adults_and_young_people_in_private_institution;
   subtype Service_of_the_maintenance_and_repair_of_the_dwelling_tertiary_Range is Maintenance_and_repair_of_the_dwelling_secondary_Range range services_for_maintenance_and_repair_of_dwelling_plumbers_electricians_carpenters .. swimming_pool_maintenance_excluding_wages_of_persons_who_maintain_pools_but_including_chemicals;
   subtype Sewarage_collection_tertiary_Range is Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_Range range sanitation .. sanitation;
   subtype Shoes_and_other_footwear_tertiary_Range is Footwear_secondary_Range range mens_footwear .. infants_footwear;
   subtype Small_electrical_household_appliance_tertiary_Range is Household_appliances_secondary_Range range hotplates .. other_eg_dry_cabinets_and_safes_specify;
   subtype Small_tools_and_miscellaneous_accessories_tertiary_Range is Tools_and_equipment_for_house_and_garden_secondary_Range range light_bulbs .. other_garden_equipment;
   subtype Social_protection_services_tertiary_Range is Social_protection_secondary_Range range day_care_mothers_creches_and_playgrounds_in_public_institutions .. day_care_mothers_creches_and_playgrounds_in_private_institutions;
   subtype Solid_fuels_tertiary_Range is Electricity_gas_and_other_fuels_secondary_Range range firewood_bought .. other_household_fuel;
   subtype Spare_parts_and_accessories_tertiary_Range is Operation_of_personal_transport_equipment_secondary_Range range new_tyres_and_tubes .. security_systems_for_cars_including_installation;
   subtype Spirits_tertiary_Range is Alcoholic_beverages_secondary_Range range spirits_such_as_brandy_whisky_gin_liqueurs .. spirits_such_as_brandy_whisky_gin_liqueurs;
   subtype Stationery_and_drawing_materials_tertiary_Range is Newspapers_books_and_stationary_secondary_Range range stationery_excluding_those_for_academic_purposes .. other_specify_eg_junior_laptops_training_and_adult_education_for_private_institutions;
   subtype Subsidy_on_payment_of_mortgage_tertiary_Range is Subsidy_on_payment_of_mortgage_secondary_Range range subsidy_on_payment_of_mortgage .. subsidy_on_payment_of_mortgage;
   subtype Sugar_jam_honey_chocolate_and_confectionery_tertiary_Range is Food_secondary_Range range white_sugar .. other_sugar_products;
   subtype Taxes_according_to_assessment_income_tax_tertiary_Range is Taxes_site_paye_and_income_tax_secondary_Range range according_to_assessment_income_tax .. according_to_assessment_income_tax;
   subtype Taxes_amnesty_tax_tertiary_Range is Taxes_amnesty_tax_secondary_Range range amnesty_tax .. amnesty_tax;
   subtype Taxes_paye_income_tax_tertiary_Range is Taxes_site_paye_and_income_tax_secondary_Range range paye_income_tax .. paye_income_tax;
   subtype Taxes_site_income_tax_tertiary_Range is Taxes_site_paye_and_income_tax_secondary_Range range site_income_tax .. site_income_tax;
   subtype Taxes_unemployment_insurance_fund_uif_tertiary_Range is Taxes_uif_secondary_Range range unemployment_insurance_fund_uif .. unemployment_insurance_fund_uif;
   subtype Telephone_and_telefax_equipment_tertiary_Range is Telephone_and_telefax_equipment_secondary_Range range cellular_phones .. repairs_of_computers_and_communication_equipment;
   subtype Telephone_and_telefax_services_tertiary_Range is Telephone_and_telefax_services_secondary_Range range installation .. internet_subscription_and_other_costs;
   subtype Tertiary_education_tertiary_Range is Tertiary_education_secondary_Range range tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_public_institutions .. tertiary_education_education_not_definable_by_level_excluding_driving_and_music_lessons_sport_etc_in_private_institutions;
   subtype Therapeutic_appliances_and_equipment_tertiary_Range is Medical_products_appliances_and_equipment_secondary_Range range therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_private_institutions .. therapeutic_appliances_and_equipment_like_spectacles_and_hearing_aids_in_public_institutions;
   subtype Tobacco_tertiary_Range is Tobacco_secondary_Range range cigarettes .. other_items_smoked;
   subtype Transfer_toothers_tertiary_Range is Transfers_to_others_secondary_Range range in_kind_maintenance_of_or_remittance_to_family_members_and_dependants_living_elsewhere_including_alimony_or_palimony_paid_to_ex_wife_or_ex_husband_children .. tribal_levies_not_for_housing;
   subtype Unclassified_food_items_tertiary_Range is Unclassified_food_items_secondary_Range range unclassified_expenditures_on_food .. unclassified_expenditures_on_food;
   subtype Vegetables_tertiary_Range is Food_secondary_Range range lettuce .. other_vegetable_products_specify;
   subtype Veterinary_and_other_services_tertiary_Range is Other_recreational_items_and_equipment_garden_and_pets_secondary_Range range licenses .. care_eg_doggy_parlour_kennels_and_veterinary_costs;
   subtype Water_and_electricity_tertiary_Range is Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_Range range water_and_electricity .. water_and_electricity;
   subtype Water_supply_tertiary_Range is Water_supply_and_miscellaneous_services_relating_to_the_dwelling_secondary_Range range water .. water;
   subtype Wine_tertiary_Range is Alcoholic_beverages_secondary_Range range table_wines_including_sparkling_wine_not_from_food_service_places .. other_eg_mampoer_home_brewed_not_from_food_service_place;

   function Pretty_Print( i : Coicop_Type ) return String;

   function Pretty_Print( i : Coicop ) return String;

   function Pretty_Print( i : Main_Group ) return String;

   function Pretty_Print( i : Secondary_Group ) return String;

   function Pretty_Print( i : Tertiary_Group ) return String;

   function Convert_Coicop_Type( i : String ) return Coicop_Type;

end Coicop_Definitions; 