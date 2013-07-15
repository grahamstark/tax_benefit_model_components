package BHPS_Enums is

   type Adla_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      by_self,
      with_help_from_someone_else,
      not_at_all );

   function Pretty_Print( i : Adla_Type ) return String;
   function Null_Or_Missing( i : Adla_Type ) return Boolean;
   function Convert_Adla_Type( i : String ) return Adla_Type;


   type Adlad_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      very_easy,
      fairly_easy,
      fairly_difficult,
      very_difficult );

   function Pretty_Print( i : Adlad_Type ) return String;
   function Null_Or_Missing( i : Adlad_Type ) return Boolean;
   function Convert_Adlad_Type( i : String ) return Adlad_Type;


   type Age_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Age_Type ) return String;
   function Null_Or_Missing( i : Age_Type ) return Boolean;
   function Convert_Age_Type( i : String ) return Age_Type;


   type Agead1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      happy_with_work,
      secure_financially,
      insecure_financially,
      financial_concession,
      financial_penalties,
      more_finan_respons,
      less_finan_respons,
      cost_of_education,
      other_money_mention,
      unhappy_with_work,
      happy_with_partner,
      problems_w_partner,
      mention_of_children,
      mention_gchildren,
      happy_with_family,
      family_problems,
      living_alone,
      happy_with_friends,
      lack_friends_or_social,
      other_family_or_friend,
      ageism_re_work,
      more_leisure_time,
      pressures_on_time,
      legal_drinking_age,
      other_leisure_or_time,
      more_job_opps,
      good_phys_health,
      bad_phys_health,
      good_psych_health,
      memory_or_depression,
      other_health_reason,
      adv_semiretired,
      mature_or_experienced,
      life_slipping_by,
      stability_or_establish,
      greater_freedom,
      constraint_curr_age,
      look_fwd_to_future,
      uncertain_future,
      few_responsibility,
      more_responsibilit,
      concern_aging_body,
      dissatis_w_retirement,
      positive_re_fitness,
      towards_end_of_life,
      other_issues_aging,
      mention_of_education,
      age_not_important,
      other_ages_undesire,
      other_age_desirable,
      likes_current_age,
      dislike_current_age,
      more_respect_shown,
      less_respect_shown,
      gen_happy_w_life,
      other_work_mentions,
      no_disadvantages,
      no_advantages,
      other_reason_nes,
      nothing_or_blank );

   function Pretty_Print( i : Agead1_Type ) return String;
   function Null_Or_Missing( i : Agead1_Type ) return Boolean;
   function Convert_Agead1_Type( i : String ) return Agead1_Type;


   type Ageadv_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      mostly_advantages,
      mostly_disadvantages,
      bothvolunteered );

   function Pretty_Print( i : Ageadv_Type ) return String;
   function Null_Or_Missing( i : Ageadv_Type ) return Boolean;
   function Convert_Ageadv_Type( i : String ) return Ageadv_Type;


   type Agechy_Type is (  
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Agechy_Type ) return String;
   function Null_Or_Missing( i : Agechy_Type ) return Boolean;
   function Convert_Agechy_Type( i : String ) return Agechy_Type;


   type Agei_Type is (  
      not_imputed,
      imputed );

   function Pretty_Print( i : Agei_Type ) return String;
   function Null_Or_Missing( i : Agei_Type ) return Boolean;
   function Convert_Agei_Type( i : String ) return Agei_Type;


   type Agelh_Type is (  
      dont_know,
      refused,
      not_live_w_both_pars,
      proxy_and_or_phone,
      inapplicable,
      missing );

   function Pretty_Print( i : Agelh_Type ) return String;
   function Null_Or_Missing( i : Agelh_Type ) return Boolean;
   function Convert_Agelh_Type( i : String ) return Agelh_Type;


   type Ageret_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Ageret_Type ) return String;
   function Null_Or_Missing( i : Ageret_Type ) return Boolean;
   function Convert_Ageret_Type( i : String ) return Ageret_Type;


   type Aglqut_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Aglqut_Type ) return String;
   function Null_Or_Missing( i : Aglqut_Type ) return Boolean;
   function Convert_Aglqut_Type( i : String ) return Aglqut_Type;


   type Aglt20_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Aglt20_Type ) return String;
   function Null_Or_Missing( i : Aglt20_Type ) return Boolean;
   function Convert_Aglt20_Type( i : String ) return Aglt20_Type;


   type Aidhh_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      other );

   function Pretty_Print( i : Aidhh_Type ) return String;
   function Null_Or_Missing( i : Aidhh_Type ) return Boolean;
   function Convert_Aidhh_Type( i : String ) return Aidhh_Type;


   type Aidhrs_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_0_4_hrs_per_week,
      some_other_times,
      s_5_9_hrs_per_week,
      s_10_19_hrs_per_wk,
      s_20_34_hrs_per_wk,
      s_35_49_hrs_per_wk,
      s_50_99_hrs_per_wk,
      s_100_plus_hrs_per_wk,
      varies_under_20,
      varies_20_hrs_plus );

   function Pretty_Print( i : Aidhrs_Type ) return String;
   function Null_Or_Missing( i : Aidhrs_Type ) return Boolean;
   function Convert_Aidhrs_Type( i : String ) return Aidhrs_Type;


   type Aidhu1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      parent_or_parent_in_law,
      other_relative,
      friend_or_neighbour,
      clients_of_vol_orgs,
      other_specified,
      grandparents,
      aunt_or_uncle );

   function Pretty_Print( i : Aidhu1_Type ) return String;
   function Null_Or_Missing( i : Aidhu1_Type ) return Boolean;
   function Convert_Aidhu1_Type( i : String ) return Aidhu1_Type;


   type Aidhu2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      parent_or_in_law,
      other_relative,
      friend_or_neighbour,
      clients_vol_orgs,
      other_specified,
      grandparents,
      aunt_or_uncle );

   function Pretty_Print( i : Aidhu2_Type ) return String;
   function Null_Or_Missing( i : Aidhu2_Type ) return Boolean;
   function Convert_Aidhu2_Type( i : String ) return Aidhu2_Type;


   type Aidhua_Type is (  
      not_answered,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned );

   function Pretty_Print( i : Aidhua_Type ) return String;
   function Null_Or_Missing( i : Aidhua_Type ) return Boolean;
   function Convert_Aidhua_Type( i : String ) return Aidhua_Type;


   type Aidhub_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned );

   function Pretty_Print( i : Aidhub_Type ) return String;
   function Null_Or_Missing( i : Aidhub_Type ) return Boolean;
   function Convert_Aidhub_Type( i : String ) return Aidhub_Type;


   type Aidpl1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Aidpl1_Type ) return String;
   function Null_Or_Missing( i : Aidpl1_Type ) return Boolean;
   function Convert_Aidpl1_Type( i : String ) return Aidpl1_Type;


   type Aidxhh_Type is (  
      not_answered,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Aidxhh_Type ) return String;
   function Null_Or_Missing( i : Aidxhh_Type ) return Boolean;
   function Convert_Aidxhh_Type( i : String ) return Aidxhh_Type;


   type Aivfho_Type is (  
      inapplicable,
      missing_or_wild,
      demolished_or_derelict,
      all_eligible_hh_intervd,
      interviews_plus_proxies,
      interviews_plus_refusals,
      hh_comp_plus_ques_only,
      hh_composition_only,
      docs_missing_or_unusable,
      business_use_only,
      refusal_to_hq,
      all_refus_to_inter,
      lang_probs_no_interp,
      too_old_or_infirm,
      no_hh_member_contact,
      temp_accomm_only,
      empty_at_first_call,
      building_not_complete,
      institut_no_privt_hh,
      address_not_found );

   function Pretty_Print( i : Aivfho_Type ) return String;
   function Null_Or_Missing( i : Aivfho_Type ) return Boolean;
   function Convert_Aivfho_Type( i : String ) return Aivfho_Type;


   type Aivfio_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      proxy,
      refusal,
      absent_no_proxy,
      oth_non_cont_or_no_proxy,
      pres_or_no_intv_or_no_proxy,
      child_under_16,
      other );

   function Pretty_Print( i : Aivfio_Type ) return String;
   function Null_Or_Missing( i : Aivfio_Type ) return Boolean;
   function Convert_Aivfio_Type( i : String ) return Aivfio_Type;


   type Apno_Type is (  
      inapplicable );

   function Pretty_Print( i : Apno_Type ) return String;
   function Null_Or_Missing( i : Apno_Type ) return Boolean;
   function Convert_Apno_Type( i : String ) return Apno_Type;


   type Astat_Type is (  
      active,
      retd_isolated_tsm,
      retd_adamant_refusal,
      retd_lt_untraced,
      retd_wdrawn_before_field,
      retd_other_reasons,
      retd_death,
      reting_isolated_tsm,
      reting_adamant_refusal,
      l_t_untraced_wdrawn,
      reting_wdrawn_before_field,
      reting_other_reasons,
      reting_death );

   function Pretty_Print( i : Astat_Type ) return String;
   function Null_Or_Missing( i : Astat_Type ) return Boolean;
   function Convert_Astat_Type( i : String ) return Astat_Type;


   type Boolean_With_Missing is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Boolean_With_Missing ) return String;
   function Null_Or_Missing( i : Boolean_With_Missing ) return Boolean;
   function Convert_Boolean_With_Missing( i : String ) return Boolean_With_Missing;


   type Bankj_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      sole_only,
      joint_only,
      both_sole_and_joint );

   function Pretty_Print( i : Bankj_Type ) return String;
   function Null_Or_Missing( i : Bankj_Type ) return Boolean;
   function Convert_Bankj_Type( i : String ) return Bankj_Type;


   type Bankj1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Bankj1_Type ) return String;
   function Null_Or_Missing( i : Bankj1_Type ) return Boolean;
   function Convert_Bankj1_Type( i : String ) return Bankj1_Type;


   type Bankj2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned );

   function Pretty_Print( i : Bankj2_Type ) return String;
   function Null_Or_Missing( i : Bankj2_Type ) return Boolean;
   function Convert_Bankj2_Type( i : String ) return Bankj2_Type;


   type Basrate_Type is (  
      dont_know,
      refused,
      no_set_amount,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Basrate_Type ) return String;
   function Null_Or_Missing( i : Basrate_Type ) return Boolean;
   function Convert_Basrate_Type( i : String ) return Basrate_Type;


   type Basrest_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      exact_amount_given,
      estimated_amount_given );

   function Pretty_Print( i : Basrest_Type ) return String;
   function Null_Or_Missing( i : Basrest_Type ) return Boolean;
   function Convert_Basrest_Type( i : String ) return Basrest_Type;


   type Bivfho_Type is (  
      inapplicable,
      missing_or_wild,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      hh_comp_plus_qaire_only,
      hh_composition_only,
      pxy_at_original_addr,
      phone_pxy_intvw_only,
      youth_interview_only,
      docs_missing_or_unusable,
      demolished_or_derelict,
      only_business_prem,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal );

   function Pretty_Print( i : Bivfho_Type ) return String;
   function Null_Or_Missing( i : Bivfho_Type ) return Boolean;
   function Convert_Bivfho_Type( i : String ) return Bivfho_Type;


   type Bivfio_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_refusl,
      other_retiring,
      dead );

   function Pretty_Print( i : Bivfio_Type ) return String;
   function Null_Or_Missing( i : Bivfio_Type ) return Boolean;
   function Convert_Bivfio_Type( i : String ) return Bivfio_Type;


   type Bpar16_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      other );

   function Pretty_Print( i : Bpar16_Type ) return String;
   function Null_Or_Missing( i : Bpar16_Type ) return Boolean;
   function Convert_Bpar16_Type( i : String ) return Bpar16_Type;


   type Bscnsp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      spend_it_all,
      spend_some_and_save_some,
      save_it_all,
      other );

   function Pretty_Print( i : Bscnsp_Type ) return String;
   function Null_Or_Missing( i : Bscnsp_Type ) return Boolean;
   function Convert_Bscnsp_Type( i : String ) return Bscnsp_Type;


   type Bscnsp1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      nothing_written_in,
      holiday_or_holiday_booking,
      gifts_for_family_members,
      gifts_for_friends,
      clothing,
      other_everyday_or_hhold_items,
      payment_of_bills_or_debts,
      home_improvements_or_repairs_etc,
      hhold_consumer_durables,
      carpets_or_furniture_or_garden_sheds,
      computer_or_computer_accessories,
      car_purchase_or_maintenance,
      house_purchase_or_mortgage_repayment,
      hobbies_or_leisure_activities,
      family_events,
      other,
      no_reason_given_written_in );

   function Pretty_Print( i : Bscnsp1_Type ) return String;
   function Null_Or_Missing( i : Bscnsp1_Type ) return Boolean;
   function Convert_Bscnsp1_Type( i : String ) return Bscnsp1_Type;


   type Bscnsp2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      holiday_or_holiday_booking,
      gifts_for_family_members,
      gifts_for_friends,
      clothing,
      other_everyday_or_hhold_items,
      payment_of_bills_or_debts,
      home_improvements_or_repairs_etc,
      hhold_consumer_durables,
      carpets_or_furniture_or_garden_sheds,
      computer_or_computer_accessories,
      car_purchase_or_maintenance,
      house_purchase_or_mortgage_repayment,
      hobbies_or_leisure_activities,
      family_events,
      other,
      no_reason_given_written_in );

   function Pretty_Print( i : Bscnsp2_Type ) return String;
   function Null_Or_Missing( i : Bscnsp2_Type ) return Boolean;
   function Convert_Bscnsp2_Type( i : String ) return Bscnsp2_Type;


   type Bscon_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Bscon_Type ) return String;
   function Null_Or_Missing( i : Bscon_Type ) return Boolean;
   function Convert_Bscon_Type( i : String ) return Bscon_Type;


   type Butype_Type is (  
      dependent_child,
      missing_or_wild,
      couple_no_ch_m_lt_65,
      single_woman_20_39,
      single_woman_40_59,
      single_woman_60_74,
      single_woman_75_plus,
      single_man_lt_30,
      single_man_30_54,
      single_man_55_64,
      single_man_65_plus,
      couple_1_ch_m_lt_65,
      couple_2_ch_m_lt_65,
      couple_3_plus_ch_m_lt_65,
      couple_man_65_to_74,
      couple_man_75_plus,
      f_lone_parent_lt_60,
      m_lone_parent_lt_65,
      single_woman_lt_20 );

   function Pretty_Print( i : Butype_Type ) return String;
   function Null_Or_Missing( i : Butype_Type ) return Boolean;
   function Convert_Butype_Type( i : String ) return Butype_Type;


   type Bwtag1_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Bwtag1_Type ) return String;
   function Null_Or_Missing( i : Bwtag1_Type ) return Boolean;
   function Convert_Bwtag1_Type( i : String ) return Bwtag1_Type;


   type Bwtel_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      early,
      late );

   function Pretty_Print( i : Bwtel_Type ) return String;
   function Null_Or_Missing( i : Bwtel_Type ) return Boolean;
   function Convert_Bwtel_Type( i : String ) return Bwtel_Type;


   type Bwtel2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      early,
      late );

   function Pretty_Print( i : Bwtel2_Type ) return String;
   function Null_Or_Missing( i : Bwtel2_Type ) return Boolean;
   function Convert_Bwtel2_Type( i : String ) return Bwtel2_Type;


   type Bwtg5_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      more,
      less );

   function Pretty_Print( i : Bwtg5_Type ) return String;
   function Null_Or_Missing( i : Bwtg5_Type ) return Boolean;
   function Convert_Bwtg5_Type( i : String ) return Bwtg5_Type;


   type Bwtg51_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      more,
      less,
      no_dont_know );

   function Pretty_Print( i : Bwtg51_Type ) return String;
   function Null_Or_Missing( i : Bwtg51_Type ) return Boolean;
   function Convert_Bwtg51_Type( i : String ) return Bwtg51_Type;


   type Bwtkn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_in_lbs_oz,
      yes_in_kilos,
      no_dont_know );

   function Pretty_Print( i : Bwtkn_Type ) return String;
   function Null_Or_Missing( i : Bwtkn_Type ) return Boolean;
   function Convert_Bwtkn_Type( i : String ) return Bwtkn_Type;


   type Bwtkn4_Type is (  
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_in_lbs_oz,
      yes_in_kilos,
      no_dont_know );

   function Pretty_Print( i : Bwtkn4_Type ) return String;
   function Null_Or_Missing( i : Bwtkn4_Type ) return Boolean;
   function Convert_Bwtkn4_Type( i : String ) return Bwtkn4_Type;


   type Bwtlb_Type is (  
      dont_know,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Bwtlb_Type ) return String;
   function Null_Or_Missing( i : Bwtlb_Type ) return Boolean;
   function Convert_Bwtlb_Type( i : String ) return Bwtlb_Type;


   type Caidua_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      get_lifts_in_car );

   function Pretty_Print( i : Caidua_Type ) return String;
   function Null_Or_Missing( i : Caidua_Type ) return Boolean;
   function Convert_Caidua_Type( i : String ) return Caidua_Type;


   type Caidub_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      shopping_for_you,
      be_shopped_for );

   function Pretty_Print( i : Caidub_Type ) return String;
   function Null_Or_Missing( i : Caidub_Type ) return Boolean;
   function Convert_Caidub_Type( i : String ) return Caidub_Type;


   type Caiduc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      providing_or_cooking_meals,
      be_cooked_for );

   function Pretty_Print( i : Caiduc_Type ) return String;
   function Null_Or_Missing( i : Caiduc_Type ) return Boolean;
   function Convert_Caiduc_Type( i : String ) return Caiduc_Type;


   type Caidud_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      help_with_basic_personal_needs,
      helped_with_needs );

   function Pretty_Print( i : Caidud_Type ) return String;
   function Null_Or_Missing( i : Caidud_Type ) return Boolean;
   function Convert_Caidud_Type( i : String ) return Caidud_Type;


   type Caidue_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      washing_ironing_or_cleaning,
      washed_ironed_for );

   function Pretty_Print( i : Caidue_Type ) return String;
   function Null_Or_Missing( i : Caidue_Type ) return Boolean;
   function Convert_Caidue_Type( i : String ) return Caidue_Type;


   type Caiduf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      dealing_with_personal_affairs,
      affairs_dealt_with );

   function Pretty_Print( i : Caiduf_Type ) return String;
   function Null_Or_Missing( i : Caiduf_Type ) return Boolean;
   function Convert_Caiduf_Type( i : String ) return Caiduf_Type;


   type Caidug_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      decorating_gardening_or_house_repairs,
      decorated_etc_for );

   function Pretty_Print( i : Caidug_Type ) return String;
   function Null_Or_Missing( i : Caidug_Type ) return Boolean;
   function Convert_Caidug_Type( i : String ) return Caidug_Type;


   type Caiduh_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      financial_help,
      financial_assist );

   function Pretty_Print( i : Caiduh_Type ) return String;
   function Null_Or_Missing( i : Caiduh_Type ) return Boolean;
   function Convert_Caiduh_Type( i : String ) return Caiduh_Type;


   type Caidui_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      anything_else,
      something_else );

   function Pretty_Print( i : Caidui_Type ) return String;
   function Null_Or_Missing( i : Caidui_Type ) return Boolean;
   function Convert_Caidui_Type( i : String ) return Caidui_Type;


   type Carjob_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      own_employer,
      empl_other_person );

   function Pretty_Print( i : Carjob_Type ) return String;
   function Null_Or_Missing( i : Carjob_Type ) return Boolean;
   function Convert_Carjob_Type( i : String ) return Carjob_Type;


   type Carown_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      owned_by_household,
      company_vehicles,
      both_owned_and_company );

   function Pretty_Print( i : Carown_Type ) return String;
   function Null_Or_Missing( i : Carown_Type ) return Boolean;
   function Convert_Carown_Type( i : String ) return Carown_Type;


   type Carowr_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      rs_car,
      other_in_hh,
      company_car,
      other_outside_hh );

   function Pretty_Print( i : Carowr_Type ) return String;
   function Null_Or_Missing( i : Carowr_Type ) return Boolean;
   function Convert_Carowr_Type( i : String ) return Carowr_Type;


   type Caruse_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      dont_drive );

   function Pretty_Print( i : Caruse_Type ) return String;
   function Null_Or_Missing( i : Caruse_Type ) return Boolean;
   function Convert_Caruse_Type( i : String ) return Caruse_Type;


   type Carval_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_99997_or_above );

   function Pretty_Print( i : Carval_Type ) return String;
   function Null_Or_Missing( i : Carval_Type ) return Boolean;
   function Convert_Carval_Type( i : String ) return Carval_Type;


   type Casmin_Type is (  
      undefined,
      proxy_and_or_phone,
      inapplicable,
      missing,
      s_1anone,
      s_1belementary,
      s_1cbasic_voc,
      s_2bmiddle_gen,
      s_2amiddle_voc,
      s_2c_genhi_gen,
      s_2c_vochi_voc,
      s_3alow_tert,
      s_3bhigh_tert );

   function Pretty_Print( i : Casmin_Type ) return String;
   function Null_Or_Missing( i : Casmin_Type ) return Boolean;
   function Convert_Casmin_Type( i : String ) return Casmin_Type;


   type Cbage_Type is (  
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      male_16_64,
      female_16_45,
      other );

   function Pretty_Print( i : Cbage_Type ) return String;
   function Null_Or_Missing( i : Cbage_Type ) return Boolean;
   function Convert_Cbage_Type( i : String ) return Cbage_Type;


   type Cbagef_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Cbagef_Type ) return String;
   function Null_Or_Missing( i : Cbagef_Type ) return Boolean;
   function Convert_Cbagef_Type( i : String ) return Cbagef_Type;


   type Ccbill_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      nothing_to_pay,
      pay_the_full_amount,
      more_than_the_min,
      pay_the_minimum,
      usually_pay_the_min,
      sometimes_cant_pay,
      other );

   function Pretty_Print( i : Ccbill_Type ) return String;
   function Null_Or_Missing( i : Ccbill_Type ) return Boolean;
   function Convert_Ccbill_Type( i : String ) return Ccbill_Type;


   type Cd10cst_Type is (  
      dont_know,
      refused,
      cost_inc_elsewhere,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Cd10cst_Type ) return String;
   function Null_Or_Missing( i : Cd10cst_Type ) return Boolean;
   function Convert_Cd10cst_Type( i : String ) return Cd10cst_Type;


   type Cd10new_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      yes );

   function Pretty_Print( i : Cd10new_Type ) return String;
   function Null_Or_Missing( i : Cd10new_Type ) return Boolean;
   function Convert_Cd10new_Type( i : String ) return Cd10new_Type;


   type Cd13new_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      yes );

   function Pretty_Print( i : Cd13new_Type ) return String;
   function Null_Or_Missing( i : Cd13new_Type ) return Boolean;
   function Convert_Cd13new_Type( i : String ) return Cd13new_Type;


   type Cd1new_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Cd1new_Type ) return String;
   function Null_Or_Missing( i : Cd1new_Type ) return Boolean;
   function Convert_Cd1new_Type( i : String ) return Cd1new_Type;


   type Cd1own_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Cd1own_Type ) return String;
   function Null_Or_Missing( i : Cd1own_Type ) return Boolean;
   function Convert_Cd1own_Type( i : String ) return Cd1own_Type;


   type Cdnuxp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Cdnuxp_Type ) return String;
   function Null_Or_Missing( i : Cdnuxp_Type ) return Boolean;
   function Convert_Cdnuxp_Type( i : String ) return Cdnuxp_Type;


   type Ch1bm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Ch1bm_Type ) return String;
   function Null_Or_Missing( i : Ch1bm_Type ) return Boolean;
   function Convert_Ch1bm_Type( i : String ) return Ch1bm_Type;


   type Chaida_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      give_lifts_in_car );

   function Pretty_Print( i : Chaida_Type ) return String;
   function Null_Or_Missing( i : Chaida_Type ) return Boolean;
   function Convert_Chaida_Type( i : String ) return Chaida_Type;


   type Chaidb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      shopping_for_them,
      shop_for_them );

   function Pretty_Print( i : Chaidb_Type ) return String;
   function Null_Or_Missing( i : Chaidb_Type ) return Boolean;
   function Convert_Chaidb_Type( i : String ) return Chaidb_Type;


   type Chaidc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      providing_or_cooking_meals,
      provide_or_cook_meals );

   function Pretty_Print( i : Chaidc_Type ) return String;
   function Null_Or_Missing( i : Chaidc_Type ) return Boolean;
   function Convert_Chaidc_Type( i : String ) return Chaidc_Type;


   type Chaidd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      looking_after_their_children,
      give_lifts_in_car );

   function Pretty_Print( i : Chaidd_Type ) return String;
   function Null_Or_Missing( i : Chaidd_Type ) return Boolean;
   function Convert_Chaidd_Type( i : String ) return Chaidd_Type;


   type Chaide_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      washing_ironing_or_cleaning,
      wash_iron_clean );

   function Pretty_Print( i : Chaide_Type ) return String;
   function Null_Or_Missing( i : Chaide_Type ) return Boolean;
   function Convert_Chaide_Type( i : String ) return Chaide_Type;


   type Chaidf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      dealing_with_personal_affairs,
      handle_affairs );

   function Pretty_Print( i : Chaidf_Type ) return String;
   function Null_Or_Missing( i : Chaidf_Type ) return Boolean;
   function Convert_Chaidf_Type( i : String ) return Chaidf_Type;


   type Chaidg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      decorating_gardening_or_house_repairs,
      decorate_garden );

   function Pretty_Print( i : Chaidg_Type ) return String;
   function Null_Or_Missing( i : Chaidg_Type ) return Boolean;
   function Convert_Chaidg_Type( i : String ) return Chaidg_Type;


   type Cheseq_Type is (  
      not_applicable,
      missing );

   function Pretty_Print( i : Cheseq_Type ) return String;
   function Null_Or_Missing( i : Cheseq_Type ) return Boolean;
   function Convert_Cheseq_Type( i : String ) return Cheseq_Type;


   type Chfar_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      less_than_15_minutes,
      between_15_and_30_minutes,
      between_30_minutes_and_one_hour,
      between_one_and_two_hours,
      more_than_two_hours,
      lives_abroadvolunteered );

   function Pretty_Print( i : Chfar_Type ) return String;
   function Null_Or_Missing( i : Chfar_Type ) return Boolean;
   function Convert_Chfar_Type( i : String ) return Chfar_Type;


   type Chmail_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      daily,
      at_least_once_a_week,
      at_least_once_a_month,
      several_times_a_year,
      less_often,
      never );

   function Pretty_Print( i : Chmail_Type ) return String;
   function Null_Or_Missing( i : Chmail_Type ) return Boolean;
   function Convert_Chmail_Type( i : String ) return Chmail_Type;


   type Citzn1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      france,
      portugal,
      spain,
      luxembourg,
      monaco,
      san_marino,
      belgium,
      morocco,
      algeria,
      tunesia,
      libya,
      egypt,
      sudan,
      mauritania,
      mali,
      burkina_faso,
      iceland,
      niger,
      chad,
      cape_verde,
      senegal,
      gambia,
      guinea_bissau,
      guinea,
      sierra_leone,
      liberia,
      ivory_coast,
      ghana,
      norway,
      togo,
      benin,
      nigeria,
      netherland,
      sweden,
      cameroon,
      central_african_republic,
      equatorial_guinea,
      sao_tome_and_principe,
      gabon,
      congo,
      finland,
      zaire,
      rwanda,
      burundi,
      sthelena,
      angola,
      ethiopia,
      djibouti,
      somalia,
      kenya,
      uganda,
      tanzania,
      seychelles,
      british_indian_ocean_territory,
      switzerland,
      mozambigue,
      liechtenstein,
      madagascar,
      reunion,
      mauritius,
      comoros,
      mayotte,
      zambia,
      austria,
      zimbabwe,
      malawi,
      south_africa,
      namibia,
      botswana,
      swaziland,
      lesotho,
      germany,
      united_states,
      puerto_rico,
      canada,
      greenland,
      stpierre_and_miguelon,
      faroe_islands,
      mexico,
      bermuda,
      guatemala,
      belize,
      honduras,
      el_salvador,
      andorra,
      nicaragua,
      costa_rica,
      gibraltar,
      panama,
      anguilla,
      cuba,
      stchristopher_and_nevis,
      vatican_city_state,
      haiti,
      bahamas,
      turks_and_caicos_island,
      dominican_republic,
      virgin_islands_of_the_us,
      guadeloupe,
      antigua_and_barbuda,
      malta,
      dominica,
      british_virgin_islands_and_montserrat,
      martinique,
      cayman_island,
      jamaica,
      st_lucia,
      st_vincent,
      barbados,
      trinidad_and_tobago,
      grenada,
      aruba,
      netherlands_antilles,
      colombia,
      venezuela,
      guyana,
      surinam,
      french_guiana,
      italy,
      ecuador,
      peru,
      brazil,
      chile,
      bolivia,
      turkey,
      paraguay,
      uruguay,
      argentina,
      falkland_islands,
      estonia,
      latvia,
      lithuania,
      united_kingdom,
      poland,
      cyprus,
      lebanon,
      syria,
      czech_republic,
      iraq,
      iran,
      israel,
      jordan,
      slovakia,
      saudi_arabia,
      kuwait,
      hungary,
      bahrain,
      qatar,
      united_arab_emirates,
      oman,
      yemen,
      romania,
      afghanistan,
      pakistan,
      india,
      bangladesh,
      maldives,
      sri_lanka,
      nepal,
      bhutan,
      myanmar,
      bulgaria,
      thailand,
      laos,
      vietnam,
      cambodia_kampuchea,
      ireland,
      albania,
      indonesia,
      malaysia,
      brunei,
      singapore,
      philippine,
      mongolia,
      ukraine,
      china,
      north_korea,
      south_korea,
      belarus,
      japan,
      taiwan,
      moldavia,
      hong_kong,
      macao,
      russia,
      georgia,
      armenia,
      azerbaijan,
      kazakhstan,
      denmark,
      turkmenistan,
      australia,
      papua_new_guinea,
      australian_oceania,
      nauru,
      new_zealand,
      solomon_island,
      tuvalu,
      new_caledonia,
      uzbekistan,
      american_oceania,
      wallis_and_futuna,
      kiribati,
      pitcairn,
      new_zealand_oceania,
      fiji,
      vanuatu,
      tonga,
      western_samoa,
      tadjikistan,
      french_polynesia,
      states_of_micronesia,
      marshall_island,
      kyrghystan,
      polar_region,
      greece,
      europe,
      european_community,
      other_european_countries,
      slovenia,
      africa,
      north_africa,
      west_africa,
      central_east_and_south_africa,
      croatia,
      north_america,
      central_and_south_america,
      bosnia_herzegovina,
      asia,
      near_and_middle_east,
      other_asian_countries,
      serbia_and_montenegro,
      australia_oceania,
      macedonia,
      any_other_country,
      nothing_written_in );

   function Pretty_Print( i : Citzn1_Type ) return String;
   function Null_Or_Missing( i : Citzn1_Type ) return Boolean;
   function Convert_Citzn1_Type( i : String ) return Citzn1_Type;


   type Citzn2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      france,
      portugal,
      spain,
      luxembourg,
      monaco,
      san_marino,
      belgium,
      morocco,
      algeria,
      tunesia,
      libya,
      egypt,
      sudan,
      mauritania,
      mali,
      burkina_faso,
      iceland,
      niger,
      chad,
      cape_verde,
      senegal,
      gambia,
      guinea_bissau,
      guinea,
      sierra_leone,
      liberia,
      ivory_coast,
      ghana,
      norway,
      togo,
      benin,
      nigeria,
      netherland,
      sweden,
      cameroon,
      central_african_republic,
      equatorial_guinea,
      sao_tome_and_principe,
      gabon,
      congo,
      finland,
      zaire,
      rwanda,
      burundi,
      sthelena,
      angola,
      ethiopia,
      djibouti,
      somalia,
      kenya,
      uganda,
      tanzania,
      seychelles,
      british_indian_ocean_territory,
      switzerland,
      mozambigue,
      liechtenstein,
      madagascar,
      reunion,
      mauritius,
      comoros,
      mayotte,
      zambia,
      austria,
      zimbabwe,
      malawi,
      south_africa,
      namibia,
      botswana,
      swaziland,
      lesotho,
      germany,
      united_states,
      puerto_rico,
      canada,
      greenland,
      stpierre_and_miguelon,
      faroe_islands,
      mexico,
      bermuda,
      guatemala,
      belize,
      honduras,
      el_salvador,
      andorra,
      nicaragua,
      costa_rica,
      gibraltar,
      panama,
      anguilla,
      cuba,
      stchristopher_and_nevis,
      vatican_city_state,
      haiti,
      bahamas,
      turks_and_caicos_island,
      dominican_republic,
      virgin_islands_of_the_us,
      guadeloupe,
      antigua_and_barbuda,
      malta,
      dominica,
      british_virgin_islands_and_montserrat,
      martinique,
      cayman_island,
      jamaica,
      st_lucia,
      st_vincent,
      barbados,
      trinidad_and_tobago,
      grenada,
      aruba,
      netherlands_antilles,
      colombia,
      venezuela,
      guyana,
      surinam,
      french_guiana,
      italy,
      ecuador,
      peru,
      brazil,
      chile,
      bolivia,
      turkey,
      paraguay,
      uruguay,
      argentina,
      falkland_islands,
      estonia,
      latvia,
      lithuania,
      united_kingdom,
      poland,
      cyprus,
      lebanon,
      syria,
      czech_republic,
      iraq,
      iran,
      israel,
      jordan,
      slovakia,
      saudi_arabia,
      kuwait,
      hungary,
      bahrain,
      qatar,
      united_arab_emirates,
      oman,
      yemen,
      romania,
      afghanistan,
      pakistan,
      india,
      bangladesh,
      maldives,
      sri_lanka,
      nepal,
      bhutan,
      myanmar,
      bulgaria,
      thailand,
      laos,
      vietnam,
      cambodia_kampuchea,
      ireland,
      albania,
      indonesia,
      malaysia,
      brunei,
      singapore,
      philippine,
      mongolia,
      ukraine,
      china,
      north_korea,
      south_korea,
      belarus,
      japan,
      taiwan,
      moldavia,
      hong_kong,
      macao,
      russia,
      georgia,
      armenia,
      azerbaijan,
      kazakhstan,
      denmark,
      turkmenistan,
      australia,
      papua_new_guinea,
      australian_oceania,
      nauru,
      new_zealand,
      solomon_island,
      tuvalu,
      new_caledonia,
      uzbekistan,
      american_oceania,
      wallis_and_futuna,
      kiribati,
      pitcairn,
      new_zealand_oceania,
      fiji,
      vanuatu,
      tonga,
      western_samoa,
      tadjikistan,
      french_polynesia,
      states_of_micronesia,
      marshall_island,
      kyrghystan,
      polar_region,
      greece,
      europe,
      european_community,
      other_european_countries,
      slovenia,
      africa,
      north_africa,
      west_africa,
      central_east_and_south_africa,
      croatia,
      north_america,
      central_and_south_america,
      bosnia_herzegovina,
      asia,
      near_and_middle_east,
      other_asian_countries,
      serbia_and_montenegro,
      australia_oceania,
      macedonia,
      any_other_country );

   function Pretty_Print( i : Citzn2_Type ) return String;
   function Null_Or_Missing( i : Citzn2_Type ) return Boolean;
   function Convert_Citzn2_Type( i : String ) return Citzn2_Type;


   type Civfho_Type is (  
      inapplicable,
      missing_or_wild,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      hh_comp_plus_qaire_only,
      hh_composition_only,
      pxy_at_original_addr,
      phone_pxy_intvw_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal );

   function Pretty_Print( i : Civfho_Type ) return String;
   function Null_Or_Missing( i : Civfho_Type ) return Boolean;
   function Convert_Civfho_Type( i : String ) return Civfho_Type;


   type Civfio_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_refusl,
      dead );

   function Pretty_Print( i : Civfio_Type ) return String;
   function Null_Or_Missing( i : Civfio_Type ) return Boolean;
   function Convert_Civfio_Type( i : String ) return Civfio_Type;


   type Cjsbgm_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Cjsbgm_Type ) return String;
   function Null_Or_Missing( i : Cjsbgm_Type ) return Boolean;
   function Convert_Cjsbgm_Type( i : String ) return Cjsbgm_Type;


   type Cjsbly_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes_on_or_before_1990,
      no_after_1990 );

   function Pretty_Print( i : Cjsbly_Type ) return String;
   function Null_Or_Missing( i : Cjsbly_Type ) return Boolean;
   function Convert_Cjsbly_Type( i : String ) return Cjsbly_Type;


   type Cjsblye_Type is (  
      proxy_and_or_phone,
      inapplicable,
      s_010196_or_before,
      after_010196 );

   function Pretty_Print( i : Cjsblye_Type ) return String;
   function Null_Or_Missing( i : Cjsblye_Type ) return Boolean;
   function Convert_Cjsblye_Type( i : String ) return Cjsblye_Type;


   type Cjscjs_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_ended );

   function Pretty_Print( i : Cjscjs_Type ) return String;
   function Null_Or_Missing( i : Cjscjs_Type ) return Boolean;
   function Convert_Cjscjs_Type( i : String ) return Cjscjs_Type;


   type Cjsck1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      employed_no_changes,
      not_int_last_year_old_employment,
      in_current_employment,
      have_ff_retirement_activity_and_have_dat,
      not_employed_and_activity_is_sth_else,
      not_currently_employed,
      other );

   function Pretty_Print( i : Cjsck1_Type ) return String;
   function Null_Or_Missing( i : Cjsck1_Type ) return Boolean;
   function Convert_Cjsck1_Type( i : String ) return Cjsck1_Type;


   type Cjsck2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Cjsck2_Type ) return String;
   function Null_Or_Missing( i : Cjsck2_Type ) return Boolean;
   function Convert_Cjsck2_Type( i : String ) return Cjsck2_Type;


   type Cjsem_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Cjsem_Type ) return String;
   function Null_Or_Missing( i : Cjsem_Type ) return Boolean;
   function Convert_Cjsem_Type( i : String ) return Cjsem_Type;


   type Cjsstly_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      self_employed,
      something_else,
      in_paid_employment,
      unemployed,
      retired_from_paid_work_altogether,
      on_maternity_leave,
      looking_after_family_or_home,
      full_time_student_or_at_school,
      long_term_sick_or_disabled,
      on_a_govt_training_scheme );

   function Pretty_Print( i : Cjsstly_Type ) return String;
   function Null_Or_Missing( i : Cjsstly_Type ) return Boolean;
   function Convert_Cjsstly_Type( i : String ) return Cjsstly_Type;


   type Cjsten_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Cjsten_Type ) return String;
   function Null_Or_Missing( i : Cjsten_Type ) return Boolean;
   function Convert_Cjsten_Type( i : String ) return Cjsten_Type;


   type Cjswk9_Type is (  
      proxy_respondent,
      proxy,
      missing_or_wild );

   function Pretty_Print( i : Cjswk9_Type ) return String;
   function Null_Or_Missing( i : Cjswk9_Type ) return Boolean;
   function Convert_Cjswk9_Type( i : String ) return Cjswk9_Type;


   type Coh1mr_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Coh1mr_Type ) return String;
   function Null_Or_Missing( i : Coh1mr_Type ) return Boolean;
   function Convert_Coh1mr_Type( i : String ) return Coh1mr_Type;


   type Cohad1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing_written_in,
      trial_marriage,
      no_legal_ties,
      improves_relationship,
      prev_bad_marriage,
      personal_independence,
      financial_advantages,
      companionship,
      prefer_cohab_nes,
      other );

   function Pretty_Print( i : Cohad1_Type ) return String;
   function Null_Or_Missing( i : Cohad1_Type ) return Boolean;
   function Convert_Cohad1_Type( i : String ) return Cohad1_Type;


   type Cohad2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      trial_marriage,
      no_legal_ties,
      improves_relationship,
      prev_bad_marriage,
      personal_independence,
      financial_advantages,
      companionship,
      prefer_cohab_nes,
      other );

   function Pretty_Print( i : Cohad2_Type ) return String;
   function Null_Or_Missing( i : Cohad2_Type ) return Boolean;
   function Convert_Cohad2_Type( i : String ) return Cohad2_Type;


   type Cohds1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing_written_in,
      financial_insecurity,
      no_legal_status,
      affects_on_children,
      lack_of_commitment,
      social_stigma,
      other );

   function Pretty_Print( i : Cohds1_Type ) return String;
   function Null_Or_Missing( i : Cohds1_Type ) return Boolean;
   function Convert_Cohds1_Type( i : String ) return Cohds1_Type;


   type Cohds2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      financial_insecurity,
      no_legal_status,
      affects_on_children,
      lack_of_commitment,
      social_stigma,
      other );

   function Pretty_Print( i : Cohds2_Type ) return String;
   function Null_Or_Missing( i : Cohds2_Type ) return Boolean;
   function Convert_Cohds2_Type( i : String ) return Cohds2_Type;


   type Cohxpm1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      planning_to_marry,
      probably_get_married,
      just_live_together,
      no_thought_to_future,
      other );

   function Pretty_Print( i : Cohxpm1_Type ) return String;
   function Null_Or_Missing( i : Cohxpm1_Type ) return Boolean;
   function Convert_Cohxpm1_Type( i : String ) return Cohxpm1_Type;


   type Cohxpm2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      very_likely,
      likely,
      unlikely,
      very_unlikely );

   function Pretty_Print( i : Cohxpm2_Type ) return String;
   function Null_Or_Missing( i : Cohxpm2_Type ) return Boolean;
   function Convert_Cohxpm2_Type( i : String ) return Cohxpm2_Type;


   type Cosb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      yes_but_no_form );

   function Pretty_Print( i : Cosb_Type ) return String;
   function Null_Or_Missing( i : Cosb_Type ) return Boolean;
   function Convert_Cosb_Type( i : String ) return Cosb_Type;


   type Cose_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      child_not_at_school,
      not_applicable,
      yes_but_no_form );

   function Pretty_Print( i : Cose_Type ) return String;
   function Null_Or_Missing( i : Cose_Type ) return Boolean;
   function Convert_Cose_Type( i : String ) return Cose_Type;


   type Crburg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      very_common,
      fairly_common,
      not_very_common,
      not_at_all_common );

   function Pretty_Print( i : Crburg_Type ) return String;
   function Null_Or_Missing( i : Crburg_Type ) return Boolean;
   function Convert_Crburg_Type( i : String ) return Crburg_Type;


   type Crdark_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      very_safe,
      fairly_safe,
      a_bit_unsafe,
      very_unsafe,
      never_go_out_after_dark );

   function Pretty_Print( i : Crdark_Type ) return String;
   function Null_Or_Missing( i : Crdark_Type ) return Boolean;
   function Convert_Crdark_Type( i : String ) return Crdark_Type;


   type Crworb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      big_worry,
      bit_of_a_worry,
      occassional_doubt );

   function Pretty_Print( i : Crworb_Type ) return String;
   function Null_Or_Missing( i : Crworb_Type ) return Boolean;
   function Convert_Crworb_Type( i : String ) return Crworb_Type;


   type Debt_Type is (  
      dont_know,
      refused,
      yes_but_refused_or_dk,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Debt_Type ) return String;
   function Null_Or_Missing( i : Debt_Type ) return Boolean;
   function Convert_Debt_Type( i : String ) return Debt_Type;


   type Debta_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      hire_purchase );

   function Pretty_Print( i : Debta_Type ) return String;
   function Null_Or_Missing( i : Debta_Type ) return Boolean;
   function Convert_Debta_Type( i : String ) return Debta_Type;


   type Debtb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      personal_loan );

   function Pretty_Print( i : Debtb_Type ) return String;
   function Null_Or_Missing( i : Debtb_Type ) return Boolean;
   function Convert_Debtb_Type( i : String ) return Debtb_Type;


   type Debtc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      credit_cards );

   function Pretty_Print( i : Debtc_Type ) return String;
   function Null_Or_Missing( i : Debtc_Type ) return Boolean;
   function Convert_Debtc_Type( i : String ) return Debtc_Type;


   type Debtd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      mail_order_pchase );

   function Pretty_Print( i : Debtd_Type ) return String;
   function Null_Or_Missing( i : Debtd_Type ) return Boolean;
   function Convert_Debtd_Type( i : String ) return Debtd_Type;


   type Debte_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      dss_social_fund );

   function Pretty_Print( i : Debte_Type ) return String;
   function Null_Or_Missing( i : Debte_Type ) return Boolean;
   function Convert_Debte_Type( i : String ) return Debte_Type;


   type Debtf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      loan_from_indivdl );

   function Pretty_Print( i : Debtf_Type ) return String;
   function Null_Or_Missing( i : Debtf_Type ) return Boolean;
   function Convert_Debtf_Type( i : String ) return Debtf_Type;


   type Debtg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      something_else );

   function Pretty_Print( i : Debtg_Type ) return String;
   function Null_Or_Missing( i : Debtg_Type ) return Boolean;
   function Convert_Debtg_Type( i : String ) return Debtg_Type;


   type Debth_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      overdrafts );

   function Pretty_Print( i : Debth_Type ) return String;
   function Null_Or_Missing( i : Debth_Type ) return Boolean;
   function Convert_Debth_Type( i : String ) return Debth_Type;


   type Debti_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      student_loan );

   function Pretty_Print( i : Debti_Type ) return String;
   function Null_Or_Missing( i : Debti_Type ) return Boolean;
   function Convert_Debti_Type( i : String ) return Debti_Type;


   type Debtpn1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Debtpn1_Type ) return String;
   function Null_Or_Missing( i : Debtpn1_Type ) return Boolean;
   function Convert_Debtpn1_Type( i : String ) return Debtpn1_Type;


   type Debtpn2_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned );

   function Pretty_Print( i : Debtpn2_Type ) return String;
   function Null_Or_Missing( i : Debtpn2_Type ) return Boolean;
   function Convert_Debtpn2_Type( i : String ) return Debtpn2_Type;


   type Debtsj_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      sole_only,
      joint_only,
      both_sole_and_joint );

   function Pretty_Print( i : Debtsj_Type ) return String;
   function Null_Or_Missing( i : Debtsj_Type ) return Boolean;
   function Convert_Debtsj_Type( i : String ) return Debtsj_Type;


   type Depchl_Type is (  
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Depchl_Type ) return String;
   function Null_Or_Missing( i : Depchl_Type ) return Boolean;
   function Convert_Depchl_Type( i : String ) return Depchl_Type;


   type Dfwld1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      more_leisure,
      technological_improvements_beyond_hhold,
      tech_improvements_life_easier_or_better,
      medical_or_health_improvements,
      improvement_in_education,
      more_jobs_or_working_conditions_easier,
      more_economic_opportunities,
      political_improvements,
      increased_freedom,
      peace_or_absence_of_war,
      improved_environmental_awareness,
      other_positve_reasons,
      more_opportunities,
      fewer_opportunities,
      kids_grow_up_too_fast,
      lack_of_discipline_or_respect,
      too_individualistic,
      too_materialistic,
      life_too_easy,
      more_pressure,
      children_less_active,
      more_family_breakdown,
      parents_working_or_absent_from_home,
      negative_media_influence,
      society_less_safe,
      increased_crime_or_fear_of_crime,
      increased_use_of_drugs_or_alcohol,
      increased_sex_or_promiscuity_or_pornography,
      loss_of_religion_or_moral_breakdown,
      loss_of_community,
      increased_unemployment,
      other_negative_economic_effects,
      decline_in_welfare_state,
      decline_in_education,
      increased_health_risks,
      negative_effects_of_technological_change,
      political_problems,
      ethnic_diversity,
      urbanisation_or_loss_of_countryside,
      environmental_problems,
      war_or_conflicts,
      terrorism,
      life_harder_nes,
      other_negative_effects,
      neutral_technological_change,
      neutral_life_has_faster_pace,
      neutral_individual_level,
      neutral_family_or_hhold_level,
      neutral_societal_level,
      neutral_global_level,
      neutral_other,
      not_codable_or_missing );

   function Pretty_Print( i : Dfwld1_Type ) return String;
   function Null_Or_Missing( i : Dfwld1_Type ) return Boolean;
   function Convert_Dfwld1_Type( i : String ) return Dfwld1_Type;


   type Dfwld2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      more_leisure,
      technological_improvements_beyond_hhold,
      tech_improvements_life_easier_or_better,
      medical_or_health_improvements,
      improvement_in_education,
      more_jobs_or_working_conditions_easier,
      more_economic_opportunities,
      political_improvements,
      increased_freedom,
      peace_or_absence_of_war,
      improved_environmental_awareness,
      other_positve_reasons,
      more_opportunities,
      fewer_opportunities,
      kids_grow_up_too_fast,
      lack_of_discipline_or_respect,
      too_individualistic,
      too_materialistic,
      life_too_easy,
      more_pressure,
      children_less_active,
      more_family_breakdown,
      parents_working_or_absent_from_home,
      negative_media_influence,
      society_less_safe,
      increased_crime_or_fear_of_crime,
      increased_use_of_drugs_or_alcohol,
      increased_sex_or_promiscuity_or_pornography,
      loss_of_religion_or_moral_breakdown,
      loss_of_community,
      increased_unemployment,
      other_negative_economic_effects,
      decline_in_welfare_state,
      decline_in_education,
      increased_health_risks,
      negative_effects_of_technological_change,
      political_problems,
      ethnic_diversity,
      urbanisation_or_loss_of_countryside,
      environmental_problems,
      war_or_conflicts,
      terrorism,
      life_harder_nes,
      other_negative_effects,
      neutral_technological_change,
      neutral_life_has_faster_pace,
      neutral_individual_level,
      neutral_family_or_hhold_level,
      neutral_societal_level,
      neutral_global_level,
      neutral_other );

   function Pretty_Print( i : Dfwld2_Type ) return String;
   function Null_Or_Missing( i : Dfwld2_Type ) return Boolean;
   function Convert_Dfwld2_Type( i : String ) return Dfwld2_Type;


   type Distmov_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing );

   function Pretty_Print( i : Distmov_Type ) return String;
   function Null_Or_Missing( i : Distmov_Type ) return Boolean;
   function Convert_Distmov_Type( i : String ) return Distmov_Type;


   type Divfho_Type is (  
      inapplicable,
      missing_or_wild,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_pxy_intvw_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal );

   function Pretty_Print( i : Divfho_Type ) return String;
   function Null_Or_Missing( i : Divfho_Type ) return Boolean;
   function Convert_Divfho_Type( i : String ) return Divfho_Type;


   type Divfio_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_refusl,
      dead );

   function Pretty_Print( i : Divfio_Type ) return String;
   function Null_Or_Missing( i : Divfio_Type ) return Boolean;
   function Convert_Divfio_Type( i : String ) return Divfio_Type;


   type Doid_Type is (  
      proxy_and_or_phone,
      missing_or_wild );

   function Pretty_Print( i : Doid_Type ) return String;
   function Null_Or_Missing( i : Doid_Type ) return Boolean;
   function Convert_Doid_Type( i : String ) return Doid_Type;


   type Doim_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
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

   function Pretty_Print( i : Doim_Type ) return String;
   function Null_Or_Missing( i : Doim_Type ) return Boolean;
   function Convert_Doim_Type( i : String ) return Doim_Type;


   type Doiy_Type is (  
      inapplicable,
      missing_or_wild,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Doiy_Type ) return String;
   function Null_Or_Missing( i : Doiy_Type ) return Boolean;
   function Convert_Doiy_Type( i : String ) return Doiy_Type;


   type Doiy4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1994,
      s_1995,
      s_1996,
      s_1997,
      s_1998,
      s_1999 );

   function Pretty_Print( i : Doiy4_Type ) return String;
   function Null_Or_Missing( i : Doiy4_Type ) return Boolean;
   function Convert_Doiy4_Type( i : String ) return Doiy4_Type;


   type Eaage_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      male_16_64,
      female_16_59,
      other );

   function Pretty_Print( i : Eaage_Type ) return String;
   function Null_Or_Missing( i : Eaage_Type ) return Boolean;
   function Convert_Eaage_Type( i : String ) return Eaage_Type;


   type Edasp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      gcses,
      as_levels,
      a_levels,
      nvq_or_gnvq,
      standard_grades,
      highers,
      other );

   function Pretty_Print( i : Edasp_Type ) return String;
   function Null_Or_Missing( i : Edasp_Type ) return Boolean;
   function Convert_Edasp_Type( i : String ) return Edasp_Type;


   type Edbgm1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Edbgm1_Type ) return String;
   function Null_Or_Missing( i : Edbgm1_Type ) return Boolean;
   function Convert_Edbgm1_Type( i : String ) return Edbgm1_Type;


   type Edbgm3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Edbgm3_Type ) return String;
   function Null_Or_Missing( i : Edbgm3_Type ) return Boolean;
   function Convert_Edbgm3_Type( i : String ) return Edbgm3_Type;


   type Edbgy3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Edbgy3_Type ) return String;
   function Null_Or_Missing( i : Edbgy3_Type ) return Boolean;
   function Convert_Edbgy3_Type( i : String ) return Edbgy3_Type;


   type Edblyr3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Edblyr3_Type ) return String;
   function Null_Or_Missing( i : Edblyr3_Type ) return Boolean;
   function Convert_Edblyr3_Type( i : String ) return Edblyr3_Type;


   type Edendm_Type is (  
      dont_know,
      refused,
      not_left,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Edendm_Type ) return String;
   function Null_Or_Missing( i : Edendm_Type ) return Boolean;
   function Convert_Edendm_Type( i : String ) return Edendm_Type;


   type Edendy_Type is (  
      dont_know,
      refused,
      not_left,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996 );

   function Pretty_Print( i : Edendy_Type ) return String;
   function Null_Or_Missing( i : Edendy_Type ) return Boolean;
   function Convert_Edendy_Type( i : String ) return Edendy_Type;


   type Edendy4_Type is (  
      dont_know,
      refused,
      not_left,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Edendy4_Type ) return String;
   function Null_Or_Missing( i : Edendy4_Type ) return Boolean;
   function Convert_Edendy4_Type( i : String ) return Edendy4_Type;


   type Edenne1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes );

   function Pretty_Print( i : Edenne1_Type ) return String;
   function Null_Or_Missing( i : Edenne1_Type ) return Boolean;
   function Convert_Edenne1_Type( i : String ) return Edenne1_Type;


   type Edenne2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_ended );

   function Pretty_Print( i : Edenne2_Type ) return String;
   function Null_Or_Missing( i : Edenne2_Type ) return Boolean;
   function Convert_Edenne2_Type( i : String ) return Edenne2_Type;


   type Edenne3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_ended );

   function Pretty_Print( i : Edenne3_Type ) return String;
   function Null_Or_Missing( i : Edenne3_Type ) return Boolean;
   function Convert_Edenne3_Type( i : String ) return Edenne3_Type;


   type Yes_Or_Missing_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      yes );

   function Pretty_Print( i : Yes_Or_Missing_Type ) return String;
   function Null_Or_Missing( i : Yes_Or_Missing_Type ) return Boolean;
   function Convert_Yes_Or_Missing_Type( i : String ) return Yes_Or_Missing_Type;


   type Ednewp1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      hours,
      days,
      weeks,
      other,
      months );

   function Pretty_Print( i : Ednewp1_Type ) return String;
   function Null_Or_Missing( i : Ednewp1_Type ) return Boolean;
   function Convert_Ednewp1_Type( i : String ) return Ednewp1_Type;


   type Ednewp2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Ednewp2_Type ) return String;
   function Null_Or_Missing( i : Ednewp2_Type ) return Boolean;
   function Convert_Ednewp2_Type( i : String ) return Ednewp2_Type;


   type Edoql1_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      clerical_or_commercial,
      nvq_or_svq_level_4,
      university_diploma,
      uni_or_cnaa_degree,
      univ_higher_degree,
      other_qualifications,
      city_and_guilds_pti,
      city_and_guilds_ptii,
      city_and_guilds_ptiii,
      ond_or_btec_national,
      hnd_or_btec_higher,
      nvq_or_svq_level_1,
      nvq_or_svq_level_2,
      nvq_or_svq_level_3 );

   function Pretty_Print( i : Edoql1_Type ) return String;
   function Null_Or_Missing( i : Edoql1_Type ) return Boolean;
   function Convert_Edoql1_Type( i : String ) return Edoql1_Type;


   type Edoqln1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none );

   function Pretty_Print( i : Edoqln1_Type ) return String;
   function Null_Or_Missing( i : Edoqln1_Type ) return Boolean;
   function Convert_Edoqln1_Type( i : String ) return Edoqln1_Type;


   type Edoqln3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none );

   function Pretty_Print( i : Edoqln3_Type ) return String;
   function Null_Or_Missing( i : Edoqln3_Type ) return Boolean;
   function Convert_Edoqln3_Type( i : String ) return Edoqln3_Type;


   type Edqual1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no_or_not_yet_or_waiting );

   function Pretty_Print( i : Edqual1_Type ) return String;
   function Null_Or_Missing( i : Edqual1_Type ) return Boolean;
   function Convert_Edqual1_Type( i : String ) return Edqual1_Type;


   type Edqual3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no_or_not_yet_or_waiting );

   function Pretty_Print( i : Edqual3_Type ) return String;
   function Null_Or_Missing( i : Edqual3_Type ) return Boolean;
   function Convert_Edqual3_Type( i : String ) return Edqual3_Type;


   type Edtype_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      comprehensive,
      polytechnic,
      university,
      grammar_not_fee_paying,
      fee_paying_grammar,
      sixth_form_college,
      public_or_other_privt,
      other_type_of_school,
      nursing_school_etc,
      college_of_f_educ,
      other_trng_establmnt );

   function Pretty_Print( i : Edtype_Type ) return String;
   function Null_Or_Missing( i : Edtype_Type ) return Boolean;
   function Convert_Edtype_Type( i : String ) return Edtype_Type;


   type Edtype1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      comprehensive_school,
      scot_central_inst,
      university,
      grammar_no_fees,
      fee_paying_grammar,
      sixth_form_college,
      public_or_other_private,
      other_type_of_school,
      nursing_or_teachhospit,
      college_fe_or_higher_ed,
      other_college );

   function Pretty_Print( i : Edtype1_Type ) return String;
   function Null_Or_Missing( i : Edtype1_Type ) return Boolean;
   function Convert_Edtype1_Type( i : String ) return Edtype1_Type;


   type Edtype3_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      comprehensive_school,
      scot_central_inst,
      university,
      grammar_no_fees,
      fee_paying_grammar,
      sixth_form_college,
      public_or_other_private,
      other_type_of_school,
      nursing_or_teachhospit,
      college_fe_or_higher_ed,
      other_college );

   function Pretty_Print( i : Edtype3_Type ) return String;
   function Null_Or_Missing( i : Edtype3_Type ) return Boolean;
   function Convert_Edtype3_Type( i : String ) return Edtype3_Type;


   type Eint_Type is (  
      no,
      yes );

   function Pretty_Print( i : Eint_Type ) return String;
   function Null_Or_Missing( i : Eint_Type ) return Boolean;
   function Convert_Eint_Type( i : String ) return Eint_Type;


   type Eprosa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      very_likely,
      likely,
      unlikely,
      very_unlikely,
      doesnt_apply );

   function Pretty_Print( i : Eprosa_Type ) return String;
   function Null_Or_Missing( i : Eprosa_Type ) return Boolean;
   function Convert_Eprosa_Type( i : String ) return Eprosa_Type;


   type Event1_Type is (  
      dont_know,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      illhealth_or_concern,
      caring_duties,
      babysitting,
      start_or_in_school,
      leaving_school,
      start_or_in_fe,
      birth_frnd,
      wedding_frnd,
      divorce_frnd,
      death_frnd,
      wedd_anniv_frnd,
      godparent_frnd,
      leaving_fe,
      study_course_or_skills_nec,
      travel_re_study,
      education_nec,
      in_hospital,
      change_job_or_status_or_hrs,
      plan_job_change,
      get_job_after_none,
      work_reltd_traing,
      lost_job_or_risk,
      retirement,
      travel_re_work,
      work_rltd_probs,
      jobs_nec,
      accident,
      vacation_or_travel_nec,
      leisure_actvties,
      learning_to_drive,
      politcl_or_vol_work,
      nat_or_world_events,
      begin_friendship,
      end_friendship,
      time_with_friends,
      neighbour_probs,
      non_fam_relatns_nec,
      health_tests,
      birth_fam,
      cohabitn_fam,
      wedding_fam,
      divorce_fam,
      leave_parentl_home,
      death_fam,
      wedd_anniv_fam,
      bday_celebs_fam,
      godparent_fam,
      less_mobility,
      visit_with_relatvs,
      family_life,
      family_probs,
      domestic_accident,
      pet_or_animal_ref,
      family_ref_nec,
      recovery_or_good_health,
      money_problems,
      forced_move,
      improved_finances,
      received_money,
      financial_nec,
      bought_vehicle,
      bought_or_built_house,
      home_repairs_or_appliances,
      won_prize_or_award,
      received_present,
      other_purchases,
      moved_home,
      intending_move,
      move_to_resid_home,
      move_in_rs_home,
      health_nec,
      victim_crime,
      trouble_with_police,
      joined_religion,
      othr_religious_ref,
      plan_not_fulfilled,
      cvl_court_or_bureaucrcy,
      other_occurence_nec,
      nothing_happened );

   function Pretty_Print( i : Event1_Type ) return String;
   function Null_Or_Missing( i : Event1_Type ) return Boolean;
   function Convert_Event1_Type( i : String ) return Event1_Type;


   type Event1s_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      household_or_we,
      parents_nec,
      parents_in_law,
      siblings,
      sis_or_bro_in_law,
      grandparents,
      grandchildren,
      othr_family_mem,
      friend_or_colleague,
      other,
      pet,
      self,
      not_specified,
      partner,
      daughters,
      sons,
      children_nec,
      son_or_dtr_in_law,
      mother,
      father );

   function Pretty_Print( i : Event1s_Type ) return String;
   function Null_Or_Missing( i : Event1s_Type ) return Boolean;
   function Convert_Event1s_Type( i : String ) return Event1s_Type;


   type Exp2mov_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      very_likely,
      quite_likely,
      quite_unlikely,
      very_unlikely );

   function Pretty_Print( i : Exp2mov_Type ) return String;
   function Null_Or_Missing( i : Exp2mov_Type ) return Boolean;
   function Convert_Exp2mov_Type( i : String ) return Exp2mov_Type;


   type F101_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ni_retir_pension );

   function Pretty_Print( i : F101_Type ) return String;
   function Null_Or_Missing( i : F101_Type ) return Boolean;
   function Convert_F101_Type( i : String ) return F101_Type;


   type F102_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      pension_prev_emp );

   function Pretty_Print( i : F102_Type ) return String;
   function Null_Or_Missing( i : F102_Type ) return Boolean;
   function Convert_F102_Type( i : String ) return F102_Type;


   type F103_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      pens_spse_prev_emp );

   function Pretty_Print( i : F103_Type ) return String;
   function Null_Or_Missing( i : F103_Type ) return Boolean;
   function Convert_F103_Type( i : String ) return F103_Type;


   type F104_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      annuity_or_priv_pens );

   function Pretty_Print( i : F104_Type ) return String;
   function Null_Or_Missing( i : F104_Type ) return Boolean;
   function Convert_F104_Type( i : String ) return F104_Type;


   type F105_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      widow_or_war_pens );

   function Pretty_Print( i : F105_Type ) return String;
   function Null_Or_Missing( i : F105_Type ) return Boolean;
   function Convert_F105_Type( i : String ) return F105_Type;


   type F106_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      wid_mothr_allow );

   function Pretty_Print( i : F106_Type ) return String;
   function Null_Or_Missing( i : F106_Type ) return Boolean;
   function Convert_F106_Type( i : String ) return F106_Type;


   type F107_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      pension_credit );

   function Pretty_Print( i : F107_Type ) return String;
   function Null_Or_Missing( i : F107_Type ) return Boolean;
   function Convert_F107_Type( i : String ) return F107_Type;


   type F116_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      sev_disabl_allow );

   function Pretty_Print( i : F116_Type ) return String;
   function Null_Or_Missing( i : F116_Type ) return Boolean;
   function Convert_F116_Type( i : String ) return F116_Type;


   type F117_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      invalidity_pens );

   function Pretty_Print( i : F117_Type ) return String;
   function Null_Or_Missing( i : F117_Type ) return Boolean;
   function Convert_F117_Type( i : String ) return F117_Type;


   type F118_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ind_injury_allow );

   function Pretty_Print( i : F118_Type ) return String;
   function Null_Or_Missing( i : F118_Type ) return Boolean;
   function Convert_F118_Type( i : String ) return F118_Type;


   type F119_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      attendance_allow );

   function Pretty_Print( i : F119_Type ) return String;
   function Null_Or_Missing( i : F119_Type ) return Boolean;
   function Convert_F119_Type( i : String ) return F119_Type;


   type F120_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      mobility_allow );

   function Pretty_Print( i : F120_Type ) return String;
   function Null_Or_Missing( i : F120_Type ) return Boolean;
   function Convert_F120_Type( i : String ) return F120_Type;


   type F121_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      inv_care_allow );

   function Pretty_Print( i : F121_Type ) return String;
   function Null_Or_Missing( i : F121_Type ) return Boolean;
   function Convert_F121_Type( i : String ) return F121_Type;


   type F122_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      war_disabl_pens );

   function Pretty_Print( i : F122_Type ) return String;
   function Null_Or_Missing( i : F122_Type ) return Boolean;
   function Convert_F122_Type( i : String ) return F122_Type;


   type F123_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      disab_livng_allwnce );

   function Pretty_Print( i : F123_Type ) return String;
   function Null_Or_Missing( i : F123_Type ) return Boolean;
   function Convert_F123_Type( i : String ) return F123_Type;


   type F124_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      disab_wrkng_allwnce );

   function Pretty_Print( i : F124_Type ) return String;
   function Null_Or_Missing( i : F124_Type ) return Boolean;
   function Convert_F124_Type( i : String ) return F124_Type;


   type F125_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      incapacity_benefit );

   function Pretty_Print( i : F125_Type ) return String;
   function Null_Or_Missing( i : F125_Type ) return Boolean;
   function Convert_F125_Type( i : String ) return F125_Type;


   type F126_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      disab_liv_allw_care );

   function Pretty_Print( i : F126_Type ) return String;
   function Null_Or_Missing( i : F126_Type ) return Boolean;
   function Convert_F126_Type( i : String ) return F126_Type;


   type F127_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      disab_liv_allw_mob );

   function Pretty_Print( i : F127_Type ) return String;
   function Null_Or_Missing( i : F127_Type ) return Boolean;
   function Convert_F127_Type( i : String ) return F127_Type;


   type F128_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      disab_liv_allw_dk );

   function Pretty_Print( i : F128_Type ) return String;
   function Null_Or_Missing( i : F128_Type ) return Boolean;
   function Convert_F128_Type( i : String ) return F128_Type;


   type F131_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      unempl_or_incme_supt );

   function Pretty_Print( i : F131_Type ) return String;
   function Null_Or_Missing( i : F131_Type ) return Boolean;
   function Convert_F131_Type( i : String ) return F131_Type;


   type F132_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      income_support );

   function Pretty_Print( i : F132_Type ) return String;
   function Null_Or_Missing( i : F132_Type ) return Boolean;
   function Convert_F132_Type( i : String ) return F132_Type;


   type F133_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      unempl_benefit );

   function Pretty_Print( i : F133_Type ) return String;
   function Null_Or_Missing( i : F133_Type ) return Boolean;
   function Convert_F133_Type( i : String ) return F133_Type;


   type F134_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ni_sick_benefit );

   function Pretty_Print( i : F134_Type ) return String;
   function Null_Or_Missing( i : F134_Type ) return Boolean;
   function Convert_F134_Type( i : String ) return F134_Type;


   type F135_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      child_benefit );

   function Pretty_Print( i : F135_Type ) return String;
   function Null_Or_Missing( i : F135_Type ) return Boolean;
   function Convert_F135_Type( i : String ) return F135_Type;


   type F136_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      one_parent_benefit );

   function Pretty_Print( i : F136_Type ) return String;
   function Null_Or_Missing( i : F136_Type ) return Boolean;
   function Convert_F136_Type( i : String ) return F136_Type;


   type F137_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      family_credit );

   function Pretty_Print( i : F137_Type ) return String;
   function Null_Or_Missing( i : F137_Type ) return Boolean;
   function Convert_F137_Type( i : String ) return F137_Type;


   type F138_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      maternity_allow );

   function Pretty_Print( i : F138_Type ) return String;
   function Null_Or_Missing( i : F138_Type ) return Boolean;
   function Convert_F138_Type( i : String ) return F138_Type;


   type F139_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      housing_benefit );

   function Pretty_Print( i : F139_Type ) return String;
   function Null_Or_Missing( i : F139_Type ) return Boolean;
   function Convert_F139_Type( i : String ) return F139_Type;


   type F140_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      comm_charge_bene );

   function Pretty_Print( i : F140_Type ) return String;
   function Null_Or_Missing( i : F140_Type ) return Boolean;
   function Convert_F140_Type( i : String ) return F140_Type;


   type F141_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_state_bene );

   function Pretty_Print( i : F141_Type ) return String;
   function Null_Or_Missing( i : F141_Type ) return Boolean;
   function Convert_F141_Type( i : String ) return F141_Type;


   type F142_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      job_seekers_allowance );

   function Pretty_Print( i : F142_Type ) return String;
   function Null_Or_Missing( i : F142_Type ) return Boolean;
   function Convert_F142_Type( i : String ) return F142_Type;


   type F143_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      child_tax_credit );

   function Pretty_Print( i : F143_Type ) return String;
   function Null_Or_Missing( i : F143_Type ) return Boolean;
   function Convert_F143_Type( i : String ) return F143_Type;


   type F144_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      return_to_work_credit );

   function Pretty_Print( i : F144_Type ) return String;
   function Null_Or_Missing( i : F144_Type ) return Boolean;
   function Convert_F144_Type( i : String ) return F144_Type;


   type F151_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      educa_grant );

   function Pretty_Print( i : F151_Type ) return String;
   function Null_Or_Missing( i : F151_Type ) return Boolean;
   function Convert_F151_Type( i : String ) return F151_Type;


   type F152_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      t_u_or_friendly_soc_payt );

   function Pretty_Print( i : F152_Type ) return String;
   function Null_Or_Missing( i : F152_Type ) return Boolean;
   function Convert_F152_Type( i : String ) return F152_Type;


   type F153_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      maint_or_alimony );

   function Pretty_Print( i : F153_Type ) return String;
   function Null_Or_Missing( i : F153_Type ) return Boolean;
   function Convert_F153_Type( i : String ) return F153_Type;


   type F154_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      payment_abs_relative );

   function Pretty_Print( i : F154_Type ) return String;
   function Null_Or_Missing( i : F154_Type ) return Boolean;
   function Convert_F154_Type( i : String ) return F154_Type;


   type F155_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      rent_or_boarders_or_lodgers );

   function Pretty_Print( i : F155_Type ) return String;
   function Null_Or_Missing( i : F155_Type ) return Boolean;
   function Convert_F155_Type( i : String ) return F155_Type;


   type F156_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      rent_other_prop );

   function Pretty_Print( i : F156_Type ) return String;
   function Null_Or_Missing( i : F156_Type ) return Boolean;
   function Convert_F156_Type( i : String ) return F156_Type;


   type F157_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      foster_allowance );

   function Pretty_Print( i : F157_Type ) return String;
   function Null_Or_Missing( i : F157_Type ) return Boolean;
   function Convert_F157_Type( i : String ) return F157_Type;


   type F158_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      sick_or_acci_insurance );

   function Pretty_Print( i : F158_Type ) return String;
   function Null_Or_Missing( i : F158_Type ) return Boolean;
   function Convert_F158_Type( i : String ) return F158_Type;


   type F159_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      any_other_payment );

   function Pretty_Print( i : F159_Type ) return String;
   function Null_Or_Missing( i : F159_Type ) return Boolean;
   function Convert_F159_Type( i : String ) return F159_Type;


   type Fair1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      v_fair,
      somewhat_fair,
      somewhat_unfair,
      v_unfair );

   function Pretty_Print( i : Fair1_Type ) return String;
   function Null_Or_Missing( i : Fair1_Type ) return Boolean;
   function Convert_Fair1_Type( i : String ) return Fair1_Type;


   type Fampos_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      eldest_1st_born,
      tenth,
      second_born,
      third,
      fourth,
      fifth,
      sixth,
      seventh,
      eighth,
      nineth );

   function Pretty_Print( i : Fampos_Type ) return String;
   function Null_Or_Missing( i : Fampos_Type ) return Boolean;
   function Convert_Fampos_Type( i : String ) return Fampos_Type;


   type Famsiz_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      yes_correct,
      no_incorrect );

   function Pretty_Print( i : Famsiz_Type ) return String;
   function Null_Or_Missing( i : Famsiz_Type ) return Boolean;
   function Convert_Famsiz_Type( i : String ) return Famsiz_Type;


   type Farkid_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      less_than_15_minutes,
      between_15_and_30_mins,
      between_30_min_and_1hr,
      between_one_and_two_hr,
      more_than_two_hours,
      lives_abroadvolunte );

   function Pretty_Print( i : Farkid_Type ) return String;
   function Null_Or_Missing( i : Farkid_Type ) return Boolean;
   function Convert_Farkid_Type( i : String ) return Farkid_Type;


   type Fedasp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      maybe_or_undecided );

   function Pretty_Print( i : Fedasp_Type ) return String;
   function Null_Or_Missing( i : Fedasp_Type ) return Boolean;
   function Convert_Fedasp_Type( i : String ) return Fedasp_Type;


   type Fedlik_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      very_likely,
      likely,
      not_very_likely,
      not_at_all_likely,
      dependsvolunteered );

   function Pretty_Print( i : Fedlik_Type ) return String;
   function Null_Or_Missing( i : Fedlik_Type ) return Boolean;
   function Convert_Fedlik_Type( i : String ) return Fedlik_Type;


   type Fednt1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      school_qualif_enough,
      other,
      decided_on_career,
      want_to_earn_money,
      cost_of_education,
      depends_on_grades,
      not_academic_enough,
      dont_want_to,
      want_to_travel,
      undecided );

   function Pretty_Print( i : Fednt1_Type ) return String;
   function Null_Or_Missing( i : Fednt1_Type ) return Boolean;
   function Convert_Fednt1_Type( i : String ) return Fednt1_Type;


   type Fednt2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      school_qualif_enough,
      other,
      decided_on_career,
      want_to_earn_money,
      cost_of_education,
      depends_on_grades,
      not_academic_enough,
      dont_want_to,
      want_to_travel,
      undecided );

   function Pretty_Print( i : Fednt2_Type ) return String;
   function Null_Or_Missing( i : Fednt2_Type ) return Boolean;
   function Convert_Fednt2_Type( i : String ) return Fednt2_Type;


   type Fedtyp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      nurs_sch_or_t_hosp,
      fe_or_he_college,
      other_college,
      university,
      none_of_above );

   function Pretty_Print( i : Fedtyp_Type ) return String;
   function Null_Or_Missing( i : Fedtyp_Type ) return Boolean;
   function Convert_Fedtyp_Type( i : String ) return Fedtyp_Type;


   type Fenow_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      still_in_f_educ );

   function Pretty_Print( i : Fenow_Type ) return String;
   function Null_Or_Missing( i : Fenow_Type ) return Boolean;
   function Convert_Fenow_Type( i : String ) return Fenow_Type;


   type Fetype_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      nursing_school_etc,
      college_of_f_educ,
      other_trng_establmnt,
      polytechnic,
      university,
      none_of_the_above );

   function Pretty_Print( i : Fetype_Type ) return String;
   function Null_Or_Missing( i : Fetype_Type ) return Boolean;
   function Convert_Fetype_Type( i : String ) return Fetype_Type;


   type Ficode_Type is (  
      ni_retir_pension,
      sev_disabl_allow,
      invalidity_pens,
      ind_injury_allow,
      attendance_allow,
      pension_prev_emp,
      mobility_allow,
      inv_care_allow,
      war_disabl_pens,
      disab_livng_allwnce,
      disab_wrkng_allwnce,
      incapacity_benefit,
      disab_liv_allowcare,
      disab_liv_allowmob,
      disab_liv_allow_dk,
      pens_spse_prev_emp,
      unempl_or_incme_supt,
      income_support,
      unempl_benefit,
      ni_sick_benefit,
      child_benefit,
      one_parent_benefit,
      family_credit,
      maternity_allow,
      housing_benefit,
      annuity_or_priv_pens,
      comm_charge_bene,
      other_state_bene,
      job_seekers_allow,
      child_tax_credit,
      return_to_work_credit,
      widow_or_war_pens,
      educa_grant,
      t_u_or_friendly_soc_payt,
      maint_or_alimony,
      payment_abs_relative,
      rent_or_boarders_or_lodgers,
      rent_other_prop,
      foster_allowance,
      sick_or_acci_insurance,
      any_other_payment,
      wid_mothr_allow,
      pension_credit );

   function Pretty_Print( i : Ficode_Type ) return String;
   function Null_Or_Missing( i : Ficode_Type ) return Boolean;
   function Convert_Ficode_Type( i : String ) return Ficode_Type;


   type Fihhmb_Type is (  
      not_imputed );

   function Pretty_Print( i : Fihhmb_Type ) return String;
   function Null_Or_Missing( i : Fihhmb_Type ) return Boolean;
   function Convert_Fihhmb_Type( i : String ) return Fihhmb_Type;


   type Fihhmbi_Type is (  
      proxy_and_or_phone,
      not_imputed,
      imp_part_indiv_incm,
      imp_full_indiv_incm );

   function Pretty_Print( i : Fihhmbi_Type ) return String;
   function Null_Or_Missing( i : Fihhmbi_Type ) return Boolean;
   function Convert_Fihhmbi_Type( i : String ) return Fihhmbi_Type;


   type Fihhmni_Type is (  
      var_dont_know,
      var_refused,
      proxy_and_or_phone,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed,
      imp_part_indiv_incm,
      imp_full_indiv_incm );

   function Pretty_Print( i : Fihhmni_Type ) return String;
   function Null_Or_Missing( i : Fihhmni_Type ) return Boolean;
   function Convert_Fihhmni_Type( i : String ) return Fihhmni_Type;


   type Fihhsel_Type is (  
      no_loss,
      loss_recorded );

   function Pretty_Print( i : Fihhsel_Type ) return String;
   function Null_Or_Missing( i : Fihhsel_Type ) return Boolean;
   function Convert_Fihhsel_Type( i : String ) return Fihhsel_Type;


   type Fim01l_Type is (  
      included_elsewhere,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Fim01l_Type ) return String;
   function Null_Or_Missing( i : Fim01l_Type ) return Boolean;
   function Convert_Fim01l_Type( i : String ) return Fim01l_Type;


   type Fim01n_Type is (  
      included_elsewhere,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Fim01n_Type ) return String;
   function Null_Or_Missing( i : Fim01n_Type ) return Boolean;
   function Convert_Fim01n_Type( i : String ) return Fim01n_Type;


   type Fim02n_Type is (  
      included_elsewhere,
      missing_or_wild );

   function Pretty_Print( i : Fim02n_Type ) return String;
   function Null_Or_Missing( i : Fim02n_Type ) return Boolean;
   function Convert_Fim02n_Type( i : String ) return Fim02n_Type;


   type Fimnbi_Type is (  
      var_dont_know,
      var_refused,
      var_proxy_resp,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed,
      imputed );

   function Pretty_Print( i : Fimnbi_Type ) return String;
   function Null_Or_Missing( i : Fimnbi_Type ) return Boolean;
   function Convert_Fimnbi_Type( i : String ) return Fimnbi_Type;


   type Fimnii_Type is (  
      var_dont_know,
      var_refused,
      proxy_and_or_phone,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed,
      imputed );

   function Pretty_Print( i : Fimnii_Type ) return String;
   function Null_Or_Missing( i : Fimnii_Type ) return Boolean;
   function Convert_Fimnii_Type( i : String ) return Fimnii_Type;


   type Fimnsel_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no_loss,
      loss_recorded );

   function Pretty_Print( i : Fimnsel_Type ) return String;
   function Null_Or_Missing( i : Fimnsel_Type ) return Boolean;
   function Convert_Fimnsel_Type( i : String ) return Fimnsel_Type;


   type Finloc_Type is (  
      missing_or_wild,
      duplicate,
      final_record );

   function Pretty_Print( i : Finloc_Type ) return String;
   function Null_Or_Missing( i : Finloc_Type ) return Boolean;
   function Convert_Finloc_Type( i : String ) return Finloc_Type;


   type Fisbm_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Fisbm_Type ) return String;
   function Null_Or_Missing( i : Fisbm_Type ) return Boolean;
   function Convert_Fisbm_Type( i : String ) return Fisbm_Type;


   type Fisit_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      living_comfortably,
      doing_alright,
      just_abt_getting_by,
      finding_it_quite_difficult,
      finding_it_very_difficult );

   function Pretty_Print( i : Fisit_Type ) return String;
   function Null_Or_Missing( i : Fisit_Type ) return Boolean;
   function Convert_Fisit_Type( i : String ) return Fisit_Type;


   type Fisitc_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      better_off,
      worse_off,
      about_same );

   function Pretty_Print( i : Fisitc_Type ) return String;
   function Null_Or_Missing( i : Fisitc_Type ) return Boolean;
   function Convert_Fisitc_Type( i : String ) return Fisitc_Type;


   type Fisitx_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      better_than_now,
      worse_than_now,
      about_the_same );

   function Pretty_Print( i : Fisitx_Type ) return String;
   function Null_Or_Missing( i : Fisitx_Type ) return Boolean;
   function Convert_Fisitx_Type( i : String ) return Fisitx_Type;


   type Fisity_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      earnings_increased,
      earnings_decreased,
      benefits_reduced,
      investt_income_dec,
      more_expenses,
      one_off_expenditure,
      benefits_increased,
      earn_lessless_expens,
      earn_moremore_expens,
      earn_moreless_benft,
      more_benftmore_expens,
      less_svgssame_std_livg,
      good_management,
      no_change_income_or_expens,
      investt_income_inc,
      better_offother_reason,
      worse_offother_reason,
      nthr_better_or_worsereason,
      less_expenses,
      windfall_payment,
      other,
      no_reason );

   function Pretty_Print( i : Fisity_Type ) return String;
   function Null_Or_Missing( i : Fisity_Type ) return Boolean;
   function Convert_Fisity_Type( i : String ) return Fisity_Type;


   type Fivfho_Type is (  
      inapplicable,
      missing_or_wild,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_pxy_intvw_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      missing_person_refusal,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal );

   function Pretty_Print( i : Fivfho_Type ) return String;
   function Null_Or_Missing( i : Fivfho_Type ) return Boolean;
   function Convert_Fivfho_Type( i : String ) return Fivfho_Type;


   type Fiyrdi_Type is (  
      dont_know,
      refused,
      var_proxy_resp,
      inapplicable,
      missing_or_wild,
      nothing,
      under_100_pounds,
      s_100_1000_pounds,
      s_1000_plus_pounds,
      gbp_1000_plus );

   function Pretty_Print( i : Fiyrdi_Type ) return String;
   function Null_Or_Missing( i : Fiyrdi_Type ) return Boolean;
   function Convert_Fiyrdi_Type( i : String ) return Fiyrdi_Type;


   type Fiyrdia_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing );

   function Pretty_Print( i : Fiyrdia_Type ) return String;
   function Null_Or_Missing( i : Fiyrdia_Type ) return Boolean;
   function Convert_Fiyrdia_Type( i : String ) return Fiyrdia_Type;


   type Fiyrdii_Type is (  
      var_dont_know,
      var_refused,
      blank,
      var_proxy_resp,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed,
      imputed );

   function Pretty_Print( i : Fiyrdii_Type ) return String;
   function Null_Or_Missing( i : Fiyrdii_Type ) return Boolean;
   function Convert_Fiyrdii_Type( i : String ) return Fiyrdii_Type;


   type Fiyrdiu_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      gbp_1000_gbp_2500,
      gbp_2501_gbp_4999,
      gbp_5000_gbp_10000,
      gt_gbp_10000 );

   function Pretty_Print( i : Fiyrdiu_Type ) return String;
   function Null_Or_Missing( i : Fiyrdiu_Type ) return Boolean;
   function Convert_Fiyrdiu_Type( i : String ) return Fiyrdiu_Type;


   type Fpid_Type is (  
      inapplicable,
      missing_or_wild,
      father_not_in_hh );

   function Pretty_Print( i : Fpid_Type ) return String;
   function Null_Or_Missing( i : Fpid_Type ) return Boolean;
   function Convert_Fpid_Type( i : String ) return Fpid_Type;


   type Fr18_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Fr18_Type ) return String;
   function Null_Or_Missing( i : Fr18_Type ) return Boolean;
   function Convert_Fr18_Type( i : String ) return Fr18_Type;


   type Frall_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      every_month );

   function Pretty_Print( i : Frall_Type ) return String;
   function Null_Or_Missing( i : Frall_Type ) return Boolean;
   function Convert_Frall_Type( i : String ) return Frall_Type;


   type Frec01_Type is (  
      not_applicable,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Frec01_Type ) return String;
   function Null_Or_Missing( i : Frec01_Type ) return Boolean;
   function Convert_Frec01_Type( i : String ) return Frec01_Type;


   type Frjt_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      sole,
      joint );

   function Pretty_Print( i : Frjt_Type ) return String;
   function Null_Or_Missing( i : Frjt_Type ) return Boolean;
   function Convert_Frjt_Type( i : String ) return Frjt_Type;


   type Frjtvf_Type is (  
      missing_or_wild,
      sole_edited,
      joint_edited,
      joint_missing_data,
      jnt_rcpnt_rep_sole,
      close_match,
      diff_months,
      diff_amounts,
      mismatch );

   function Pretty_Print( i : Frjtvf_Type ) return String;
   function Null_Or_Missing( i : Frjtvf_Type ) return Boolean;
   function Convert_Frjtvf_Type( i : String ) return Frjtvf_Type;


   type Frna_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      on_most_days,
      once_or_twice_a_week,
      once_or_twice_a_month,
      less_than_once_a_month,
      never );

   function Pretty_Print( i : Frna_Type ) return String;
   function Null_Or_Missing( i : Frna_Type ) return Boolean;
   function Convert_Frna_Type( i : String ) return Frna_Type;


   type Frnd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      every,
      the_majority,
      about_half,
      a_minority,
      none );

   function Pretty_Print( i : Frnd_Type ) return String;
   function Null_Or_Missing( i : Frnd_Type ) return Boolean;
   function Convert_Frnd_Type( i : String ) return Frnd_Type;


   type Frnow_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Frnow_Type ) return String;
   function Null_Or_Missing( i : Frnow_Type ) return Boolean;
   function Convert_Frnow_Type( i : String ) return Frnow_Type;


   type Frval_Type is (  
      dont_know,
      refused,
      incl_tot_elswhre,
      inapplicable,
      missing_or_wild,
      s_9997_or_above );

   function Pretty_Print( i : Frval_Type ) return String;
   function Null_Or_Missing( i : Frval_Type ) return Boolean;
   function Convert_Frval_Type( i : String ) return Frval_Type;


   type Frvali_Type is (  
      var_dont_know,
      var_refused,
      var_inc_tot_elsw,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed );

   function Pretty_Print( i : Frvali_Type ) return String;
   function Null_Or_Missing( i : Frvali_Type ) return Boolean;
   function Convert_Frvali_Type( i : String ) return Frvali_Type;


   type Frw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      one_off_payment,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Frw_Type ) return String;
   function Null_Or_Missing( i : Frw_Type ) return Boolean;
   function Convert_Frw_Type( i : String ) return Frw_Type;


   type Ftexa_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      parents,
      child,
      curr_sep_spse,
      ex_spouse,
      pars_in_law,
      other_relative,
      other_individual,
      organization,
      other );

   function Pretty_Print( i : Ftexa_Type ) return String;
   function Null_Or_Missing( i : Ftexa_Type ) return Boolean;
   function Convert_Ftexa_Type( i : String ) return Ftexa_Type;


   type Ftexa1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      maintenance );

   function Pretty_Print( i : Ftexa1_Type ) return String;
   function Null_Or_Missing( i : Ftexa1_Type ) return Boolean;
   function Convert_Ftexa1_Type( i : String ) return Ftexa1_Type;


   type Ftexa2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      hh_bills );

   function Pretty_Print( i : Ftexa2_Type ) return String;
   function Null_Or_Missing( i : Ftexa2_Type ) return Boolean;
   function Convert_Ftexa2_Type( i : String ) return Ftexa2_Type;


   type Ftexa3_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      educ_or_grant );

   function Pretty_Print( i : Ftexa3_Type ) return String;
   function Null_Or_Missing( i : Ftexa3_Type ) return Boolean;
   function Convert_Ftexa3_Type( i : String ) return Ftexa3_Type;


   type Ftexa4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      spend_money_or_allow );

   function Pretty_Print( i : Ftexa4_Type ) return String;
   function Null_Or_Missing( i : Ftexa4_Type ) return Boolean;
   function Convert_Ftexa4_Type( i : String ) return Ftexa4_Type;


   type Ftexa5_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      repay_loan );

   function Pretty_Print( i : Ftexa5_Type ) return String;
   function Null_Or_Missing( i : Ftexa5_Type ) return Boolean;
   function Convert_Ftexa5_Type( i : String ) return Ftexa5_Type;


   type Ftexa6_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other );

   function Pretty_Print( i : Ftexa6_Type ) return String;
   function Null_Or_Missing( i : Ftexa6_Type ) return Boolean;
   function Convert_Ftexa6_Type( i : String ) return Ftexa6_Type;


   type Ftexaw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      one_off_payment,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      weekly,
      fortnightly,
      monthly,
      yearly );

   function Pretty_Print( i : Ftexaw_Type ) return String;
   function Null_Or_Missing( i : Ftexaw_Type ) return Boolean;
   function Convert_Ftexaw_Type( i : String ) return Ftexaw_Type;


   type Ftexb_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_2nd_recipient,
      parents,
      child,
      curr_sep_spse,
      ex_spouse,
      pars_in_law,
      other_relative,
      other_individual,
      organization,
      other );

   function Pretty_Print( i : Ftexb_Type ) return String;
   function Null_Or_Missing( i : Ftexb_Type ) return Boolean;
   function Convert_Ftexb_Type( i : String ) return Ftexb_Type;


   type Ftexc_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_3rd_recipient,
      parents,
      child,
      curr_sep_spse,
      ex_spouse,
      pars_in_law,
      other_relative,
      other_individual,
      organization,
      other );

   function Pretty_Print( i : Ftexc_Type ) return String;
   function Null_Or_Missing( i : Ftexc_Type ) return Boolean;
   function Convert_Ftexc_Type( i : String ) return Ftexc_Type;


   type Fthh11_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      rent );

   function Pretty_Print( i : Fthh11_Type ) return String;
   function Null_Or_Missing( i : Fthh11_Type ) return Boolean;
   function Convert_Fthh11_Type( i : String ) return Fthh11_Type;


   type Fthh12_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      housekeeping );

   function Pretty_Print( i : Fthh12_Type ) return String;
   function Null_Or_Missing( i : Fthh12_Type ) return Boolean;
   function Convert_Fthh12_Type( i : String ) return Fthh12_Type;


   type Fthh13_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      board_and_keep );

   function Pretty_Print( i : Fthh13_Type ) return String;
   function Null_Or_Missing( i : Fthh13_Type ) return Boolean;
   function Convert_Fthh13_Type( i : String ) return Fthh13_Type;


   type Fthh14_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      pers_spending_or_allow );

   function Pretty_Print( i : Fthh14_Type ) return String;
   function Null_Or_Missing( i : Fthh14_Type ) return Boolean;
   function Convert_Fthh14_Type( i : String ) return Fthh14_Type;


   type Fthh15_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      hh_bills_or_food );

   function Pretty_Print( i : Fthh15_Type ) return String;
   function Null_Or_Missing( i : Fthh15_Type ) return Boolean;
   function Convert_Fthh15_Type( i : String ) return Fthh15_Type;


   type Fthh1v_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_9997_or_above );

   function Pretty_Print( i : Fthh1v_Type ) return String;
   function Null_Or_Missing( i : Fthh1v_Type ) return Boolean;
   function Convert_Fthh1v_Type( i : String ) return Fthh1v_Type;


   type Fthh1w_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      one_off_payment,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Fthh1w_Type ) return String;
   function Null_Or_Missing( i : Fthh1w_Type ) return Boolean;
   function Convert_Fthh1w_Type( i : String ) return Fthh1w_Type;


   type Fthh2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      none );

   function Pretty_Print( i : Fthh2_Type ) return String;
   function Null_Or_Missing( i : Fthh2_Type ) return Boolean;
   function Convert_Fthh2_Type( i : String ) return Fthh2_Type;


   type Fthh24_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      personal_spending );

   function Pretty_Print( i : Fthh24_Type ) return String;
   function Null_Or_Missing( i : Fthh24_Type ) return Boolean;
   function Convert_Fthh24_Type( i : String ) return Fthh24_Type;


   type Fthh2w_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      one_off_paymnt,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Fthh2w_Type ) return String;
   function Null_Or_Missing( i : Fthh2w_Type ) return Boolean;
   function Convert_Fthh2w_Type( i : String ) return Fthh2w_Type;


   type Fthh3w_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Fthh3w_Type ) return String;
   function Null_Or_Missing( i : Fthh3w_Type ) return Boolean;
   function Convert_Fthh3w_Type( i : String ) return Fthh3w_Type;


   type Futra_Type is (  
      dont_know,
      refused,
      doesnt_apply,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Futra_Type ) return String;
   function Null_Or_Missing( i : Futra_Type ) return Boolean;
   function Convert_Futra_Type( i : String ) return Futra_Type;


   type Gasway_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      slot_or_key_meter,
      account,
      board_budgeting_scheme,
      other );

   function Pretty_Print( i : Gasway_Type ) return String;
   function Null_Or_Missing( i : Gasway_Type ) return Boolean;
   function Convert_Gasway_Type( i : String ) return Gasway_Type;


   type Gelec_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_already_buy,
      yes_considering,
      no_neither,
      considered_and_rejected );

   function Pretty_Print( i : Gelec_Type ) return String;
   function Null_Or_Missing( i : Gelec_Type ) return Boolean;
   function Convert_Gelec_Type( i : String ) return Gelec_Type;


   type Gfuela_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_fitted,
      yes_considering,
      no,
      considered_and_rejected );

   function Pretty_Print( i : Gfuela_Type ) return String;
   function Null_Or_Missing( i : Gfuela_Type ) return Boolean;
   function Convert_Gfuela_Type( i : String ) return Gfuela_Type;


   type Ghqa_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      better_thn_usual,
      same_as_usual,
      less_than_usual,
      much_less_thn_usual );

   function Pretty_Print( i : Ghqa_Type ) return String;
   function Null_Or_Missing( i : Ghqa_Type ) return Boolean;
   function Convert_Ghqa_Type( i : String ) return Ghqa_Type;


   type Ghqb_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_at_all,
      no_more_thn_usual,
      rather_more,
      much_more );

   function Pretty_Print( i : Ghqb_Type ) return String;
   function Null_Or_Missing( i : Ghqb_Type ) return Boolean;
   function Convert_Ghqb_Type( i : String ) return Ghqb_Type;


   type Ghqc_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      more_than_usual,
      same_as_usual,
      less_so,
      much_less );

   function Pretty_Print( i : Ghqc_Type ) return String;
   function Null_Or_Missing( i : Ghqc_Type ) return Boolean;
   function Convert_Ghqc_Type( i : String ) return Ghqc_Type;


   type Ghqe_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_at_all,
      no_more_than_usual,
      rather_more,
      much_more );

   function Pretty_Print( i : Ghqe_Type ) return String;
   function Null_Or_Missing( i : Ghqe_Type ) return Boolean;
   function Convert_Ghqe_Type( i : String ) return Ghqe_Type;


   type Givfho_Type is (  
      inapplicable,
      missing_or_wild,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_pxy_intvw_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      missing_person_refusal,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal,
      l_t_untraced_wdrawn );

   function Pretty_Print( i : Givfho_Type ) return String;
   function Null_Or_Missing( i : Givfho_Type ) return Boolean;
   function Convert_Givfho_Type( i : String ) return Givfho_Type;


   type Givfio_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_refusl,
      l_t_untraced_wdrawn,
      dead );

   function Pretty_Print( i : Givfio_Type ) return String;
   function Null_Or_Missing( i : Givfio_Type ) return Boolean;
   function Convert_Givfio_Type( i : String ) return Givfio_Type;


   type Grnlfa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      always,
      very_often,
      quite_often,
      not_very_often,
      never,
      cannot_do_this );

   function Pretty_Print( i : Grnlfa_Type ) return String;
   function Null_Or_Missing( i : Grnlfa_Type ) return Boolean;
   function Convert_Grnlfa_Type( i : String ) return Grnlfa_Type;


   type Heatyp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      mains_gas,
      electricity,
      solid_fuel,
      oil,
      something_else );

   function Pretty_Print( i : Heatyp_Type ) return String;
   function Null_Or_Missing( i : Heatyp_Type ) return Boolean;
   function Convert_Heatyp_Type( i : String ) return Heatyp_Type;


   type Hgbm_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Hgbm_Type ) return String;
   function Null_Or_Missing( i : Hgbm_Type ) return Boolean;
   function Convert_Hgbm_Type( i : String ) return Hgbm_Type;


   type Hgcia_Type is (  
      inapplicable,
      missing_or_wild,
      not_absent,
      absent_from_hh );

   function Pretty_Print( i : Hgcia_Type ) return String;
   function Null_Or_Missing( i : Hgcia_Type ) return Boolean;
   function Convert_Hgcia_Type( i : String ) return Hgcia_Type;


   type Hgemp_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      under_16_years,
      yes,
      no );

   function Pretty_Print( i : Hgemp_Type ) return String;
   function Null_Or_Missing( i : Hgemp_Type ) return Boolean;
   function Convert_Hgemp_Type( i : String ) return Hgemp_Type;


   type Hgest_Type is (  
      inapplicable,
      missing_or_wild,
      under_16_years,
      working,
      unemployed,
      retired,
      family_care,
      full_time_educat,
      other );

   function Pretty_Print( i : Hgest_Type ) return String;
   function Null_Or_Missing( i : Hgest_Type ) return Boolean;
   function Convert_Hgest_Type( i : String ) return Hgest_Type;


   type Hgfno_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      father_not_in_hh );

   function Pretty_Print( i : Hgfno_Type ) return String;
   function Null_Or_Missing( i : Hgfno_Type ) return Boolean;
   function Convert_Hgfno_Type( i : String ) return Hgfno_Type;


   type Hgjnly_Type is (  
      inapplicable,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Hgjnly_Type ) return String;
   function Null_Or_Missing( i : Hgjnly_Type ) return Boolean;
   function Convert_Hgjnly_Type( i : String ) return Hgjnly_Type;


   type Hgmno_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      mother_not_in_hh );

   function Pretty_Print( i : Hgmno_Type ) return String;
   function Null_Or_Missing( i : Hgmno_Type ) return Boolean;
   function Convert_Hgmno_Type( i : String ) return Hgmno_Type;


   type Hgr2r_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      reference_person,
      natural_bro_or_sis,
      other_bro_or_sis,
      bro_or_sis_in_law,
      natural_parent,
      other_parent,
      mother_or_father_in_law,
      any_grand_parent,
      any_grand_child,
      any_cousin,
      any_aunt_or_uncle,
      lawful_spouse,
      any_nephew,
      any_other_relative,
      employee,
      lodger_or_boarder,
      unrelated_sharer,
      live_in_partner,
      other,
      natural_child,
      adopted_child,
      foster_child,
      step_child,
      partners_child,
      dghter_or_son_in_law );

   function Pretty_Print( i : Hgr2r_Type ) return String;
   function Null_Or_Missing( i : Hgr2r_Type ) return Boolean;
   function Convert_Hgr2r_Type( i : String ) return Hgr2r_Type;


   type Hgra_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      s_16_years_or_over );

   function Pretty_Print( i : Hgra_Type ) return String;
   function Null_Or_Missing( i : Hgra_Type ) return Boolean;
   function Convert_Hgra_Type( i : String ) return Hgra_Type;


   type Hgrab_Type is (  
      inapplicable,
      missing_or_wild,
      college,
      boarding_school,
      work_away,
      hospital,
      holiday,
      other );

   function Pretty_Print( i : Hgrab_Type ) return String;
   function Null_Or_Missing( i : Hgrab_Type ) return Boolean;
   function Convert_Hgrab_Type( i : String ) return Hgrab_Type;


   type Hgsex_Type is (  
      inapplicable,
      missing_or_wild,
      male,
      female );

   function Pretty_Print( i : Hgsex_Type ) return String;
   function Null_Or_Missing( i : Hgsex_Type ) return Boolean;
   function Convert_Hgsex_Type( i : String ) return Hgsex_Type;


   type Hgspn_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      no_spouse_in_hh );

   function Pretty_Print( i : Hgspn_Type ) return String;
   function Null_Or_Missing( i : Hgspn_Type ) return Boolean;
   function Convert_Hgspn_Type( i : String ) return Hgspn_Type;


   type Hgyjn_Type is (  
      inapplicable,
      missing_or_wild,
      s_1990,
      s_1991 );

   function Pretty_Print( i : Hgyjn_Type ) return String;
   function Null_Or_Missing( i : Hgyjn_Type ) return Boolean;
   function Convert_Hgyjn_Type( i : String ) return Hgyjn_Type;


   type Hhbb_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      very_often,
      fairly_often,
      not_very_often,
      never );

   function Pretty_Print( i : Hhbb_Type ) return String;
   function Null_Or_Missing( i : Hhbb_Type ) return Boolean;
   function Convert_Hhbb_Type( i : String ) return Hhbb_Type;


   type Hhch12_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Hhch12_Type ) return String;
   function Null_Or_Missing( i : Hhch12_Type ) return Boolean;
   function Convert_Hhch12_Type( i : String ) return Hhch12_Type;


   type Hhch16_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      none,
      one,
      two,
      three,
      four,
      five,
      six_or_more );

   function Pretty_Print( i : Hhch16_Type ) return String;
   function Null_Or_Missing( i : Hhch16_Type ) return Boolean;
   function Convert_Hhch16_Type( i : String ) return Hhch16_Type;


   type Hhdc_Type is (  
      inapplicable,
      missing_or_wild,
      non_int_household,
      full_household_docs,
      household_q_missing,
      no_hh_q_telephone_int );

   function Pretty_Print( i : Hhdc_Type ) return String;
   function Null_Or_Missing( i : Hhdc_Type ) return Boolean;
   function Convert_Hhdc_Type( i : String ) return Hhdc_Type;


   type Hhmem_Type is (  
      inapplicable,
      missing_or_wild,
      wave_2_non_contact,
      orig_member_resident,
      echp_rejoiner_tsm,
      lisw_non_con_at_w9,
      orig_member_absent,
      orig_member_moved,
      orig_member_deceased,
      new_entrant_resident,
      new_entrant_absent,
      orig_membr_missed_wv1,
      retired_rejoiner,
      echp_rejoiner_psm );

   function Pretty_Print( i : Hhmem_Type ) return String;
   function Null_Or_Missing( i : Hhmem_Type ) return Boolean;
   function Convert_Hhmem_Type( i : String ) return Hhmem_Type;


   type Hhmove_Type is (  
      w_1_non_contact_hh,
      inapplicable_echp,
      misisng,
      non_mover_hh,
      mover_household,
      part_mover_hh,
      whole_hh_deceased,
      hh_out_of_scope,
      no_elig_hh_members,
      unknown_status,
      all_finloc0 );

   function Pretty_Print( i : Hhmove_Type ) return String;
   function Null_Or_Missing( i : Hhmove_Type ) return Boolean;
   function Convert_Hhmove_Type( i : String ) return Hhmove_Type;


   type Hhorig_Type is (  
      not_applicable,
      missing,
      original_sample,
      echp_scpr,
      echp_ons,
      echp_ni,
      wales_new_sample,
      scotland_new_sample,
      ni_new_sample );

   function Pretty_Print( i : Hhorig_Type ) return String;
   function Null_Or_Missing( i : Hhorig_Type ) return Boolean;
   function Convert_Hhorig_Type( i : String ) return Hhorig_Type;


   type Hhrcyc_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      always,
      usually,
      sometimes,
      never );

   function Pretty_Print( i : Hhrcyc_Type ) return String;
   function Null_Or_Missing( i : Hhrcyc_Type ) return Boolean;
   function Convert_Hhrcyc_Type( i : String ) return Hhrcyc_Type;


   type Hhtype_Type is (  
      missing,
      single_non_elderly,
      single_elderly,
      couple_no_children,
      couple_dep_children,
      couple_non_dep_children,
      lone_par_dep_children,
      lone_par_non_dep_children,
      s_2_plus_unrelated_adults,
      other_households );

   function Pretty_Print( i : Hhtype_Type ) return String;
   function Null_Or_Missing( i : Hhtype_Type ) return Boolean;
   function Convert_Hhtype_Type( i : String ) return Hhtype_Type;


   type Hhyoi_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Hhyoi_Type ) return String;
   function Null_Or_Missing( i : Hhyoi_Type ) return Boolean;
   function Convert_Hhyoi_Type( i : String ) return Hhyoi_Type;


   type Hhyoi4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Hhyoi4_Type ) return String;
   function Null_Or_Missing( i : Hhyoi4_Type ) return Boolean;
   function Convert_Hhyoi4_Type( i : String ) return Hhyoi4_Type;


   type Hifued_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      higher_education,
      at_school_or_college );

   function Pretty_Print( i : Hifued_Type ) return String;
   function Null_Or_Missing( i : Hifued_Type ) return Boolean;
   function Convert_Hifued_Type( i : String ) return Hifued_Type;


   type Hivfho_Type is (  
      inapplicable,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_interview_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal );

   function Pretty_Print( i : Hivfho_Type ) return String;
   function Null_Or_Missing( i : Hivfho_Type ) return Boolean;
   function Convert_Hivfho_Type( i : String ) return Hivfho_Type;


   type Hivfio_Type is (  
      inapplicable,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_re,
      dead );

   function Pretty_Print( i : Hivfio_Type ) return String;
   function Null_Or_Missing( i : Hivfio_Type ) return Boolean;
   function Convert_Hivfio_Type( i : String ) return Hivfio_Type;


   type Hl2gp_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      none,
      one_or_two,
      three_to_five,
      six_to_ten,
      more_than_ten );

   function Pretty_Print( i : Hl2gp_Type ) return String;
   function Null_Or_Missing( i : Hl2gp_Type ) return Boolean;
   function Convert_Hl2gp_Type( i : String ) return Hl2gp_Type;


   type Hl2hop_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none,
      one_or_two,
      three_to_five,
      six_to_ten,
      more_than_ten );

   function Pretty_Print( i : Hl2hop_Type ) return String;
   function Null_Or_Missing( i : Hl2hop_Type ) return Boolean;
   function Convert_Hl2hop_Type( i : String ) return Hl2hop_Type;


   type Hlavpn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      mild,
      moderate,
      severe );

   function Pretty_Print( i : Hlavpn_Type ) return String;
   function Null_Or_Missing( i : Hlavpn_Type ) return Boolean;
   function Convert_Hlavpn_Type( i : String ) return Hlavpn_Type;


   type Hlch_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes_any_child,
      no_all_children );

   function Pretty_Print( i : Hlch_Type ) return String;
   function Null_Or_Missing( i : Hlch_Type ) return Boolean;
   function Convert_Hlch_Type( i : String ) return Hlch_Type;


   type Hlch2_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned );

   function Pretty_Print( i : Hlch2_Type ) return String;
   function Null_Or_Missing( i : Hlch2_Type ) return Boolean;
   function Convert_Hlch2_Type( i : String ) return Hlch2_Type;


   type Hlcka_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Hlcka_Type ) return String;
   function Null_Or_Missing( i : Hlcka_Type ) return Boolean;
   function Convert_Hlcka_Type( i : String ) return Hlcka_Type;


   type Hlckan_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      nhs,
      x_private,
      both );

   function Pretty_Print( i : Hlckan_Type ) return String;
   function Null_Or_Missing( i : Hlckan_Type ) return Boolean;
   function Convert_Hlckan_Type( i : String ) return Hlckan_Type;


   type Hlcki_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      yes );

   function Pretty_Print( i : Hlcki_Type ) return String;
   function Null_Or_Missing( i : Hlcki_Type ) return Boolean;
   function Convert_Hlcki_Type( i : String ) return Hlcki_Type;


   type Hlckin_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      nhs,
      x_private,
      both );

   function Pretty_Print( i : Hlckin_Type ) return String;
   function Null_Or_Missing( i : Hlckin_Type ) return Boolean;
   function Convert_Hlckin_Type( i : String ) return Hlckin_Type;


   type Hlcvr_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_in_own_name,
      yes_via_othr_fam_mem,
      no_not_insured );

   function Pretty_Print( i : Hlcvr_Type ) return String;
   function Null_Or_Missing( i : Hlcvr_Type ) return Boolean;
   function Convert_Hlcvr_Type( i : String ) return Hlcvr_Type;


   type Hlcvrh_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      paid_directly,
      deducted_from_wages,
      paid_for_by_employer,
      other );

   function Pretty_Print( i : Hlcvrh_Type ) return String;
   function Null_Or_Missing( i : Hlcvrh_Type ) return Boolean;
   function Convert_Hlcvrh_Type( i : String ) return Hlcvrh_Type;


   type Hldsbl1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Hldsbl1_Type ) return String;
   function Null_Or_Missing( i : Hldsbl1_Type ) return Boolean;
   function Convert_Hldsbl1_Type( i : String ) return Hldsbl1_Type;


   type Hlendw_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      can_do_nothing );

   function Pretty_Print( i : Hlendw_Type ) return String;
   function Null_Or_Missing( i : Hlendw_Type ) return Boolean;
   function Convert_Hlendw_Type( i : String ) return Hlendw_Type;


   type Hlhtc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing );

   function Pretty_Print( i : Hlhtc_Type ) return String;
   function Null_Or_Missing( i : Hlhtc_Type ) return Boolean;
   function Convert_Hlhtc_Type( i : String ) return Hlhtc_Type;


   type Hlhtm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      feet_and_inches,
      metres_and_centimetres,
      cant_give_estimate );

   function Pretty_Print( i : Hlhtm_Type ) return String;
   function Null_Or_Missing( i : Hlhtm_Type ) return Boolean;
   function Convert_Hlhtm_Type( i : String ) return Hlhtm_Type;


   type Hliv65_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      can_do_nothing );

   function Pretty_Print( i : Hliv65_Type ) return String;
   function Null_Or_Missing( i : Hliv65_Type ) return Boolean;
   function Convert_Hliv65_Type( i : String ) return Hliv65_Type;


   type Hllta_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      doing_housework );

   function Pretty_Print( i : Hllta_Type ) return String;
   function Null_Or_Missing( i : Hllta_Type ) return Boolean;
   function Convert_Hllta_Type( i : String ) return Hllta_Type;


   type Hlltb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      climbing_stairs );

   function Pretty_Print( i : Hlltb_Type ) return String;
   function Null_Or_Missing( i : Hlltb_Type ) return Boolean;
   function Convert_Hlltb_Type( i : String ) return Hlltb_Type;


   type Hlltc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      dressing );

   function Pretty_Print( i : Hlltc_Type ) return String;
   function Null_Or_Missing( i : Hlltc_Type ) return Boolean;
   function Convert_Hlltc_Type( i : String ) return Hlltc_Type;


   type Hlltd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      walking_10_mins );

   function Pretty_Print( i : Hlltd_Type ) return String;
   function Null_Or_Missing( i : Hlltd_Type ) return Boolean;
   function Convert_Hlltd_Type( i : String ) return Hlltd_Type;


   type Hllte_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no,
      something_else );

   function Pretty_Print( i : Hllte_Type ) return String;
   function Null_Or_Missing( i : Hllte_Type ) return Boolean;
   function Convert_Hllte_Type( i : String ) return Hllte_Type;


   type Hlltwa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      a_lot,
      somewhat,
      just_a_little,
      not_at_all );

   function Pretty_Print( i : Hlltwa_Type ) return String;
   function Null_Or_Missing( i : Hlltwa_Type ) return Boolean;
   function Convert_Hlltwa_Type( i : String ) return Hlltwa_Type;


   type Hlprb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no_health_probs );

   function Pretty_Print( i : Hlprb_Type ) return String;
   function Null_Or_Missing( i : Hlprb_Type ) return Boolean;
   function Convert_Hlprb_Type( i : String ) return Hlprb_Type;


   type Hlprb1_Type is (  
      inapplicable,
      missing_or_wild,
      probs_wth_arms_or_legs,
      alcohol_or_drugs,
      epilepsy,
      migrain_or_chrn_headach,
      other,
      difficulty_seeing,
      difficulty_hearing,
      skin_conds_or_allergies,
      chest_or_breathing_probs,
      heart_and_blood,
      stomach_or_liver_or_kidneys,
      diabetes,
      nerves_or_anxiety_or_depre );

   function Pretty_Print( i : Hlprb1_Type ) return String;
   function Null_Or_Missing( i : Hlprb1_Type ) return Boolean;
   function Convert_Hlprb1_Type( i : String ) return Hlprb1_Type;


   type Hlprb2_Type is (  
      inapplicable,
      missing_or_wild,
      not_mentioned,
      probs_wth_arms_or_legs,
      alcohol_or_drugs,
      epilepsy,
      migrain_or_chrn_headach,
      other,
      difficulty_seeing,
      difficulty_hearing,
      skin_conds_or_allergies,
      chest_or_breathing_probs,
      heart_and_blood,
      stomach_or_liver_or_kidneys,
      diabetes,
      nerves_or_anxiety_or_depre );

   function Pretty_Print( i : Hlprb2_Type ) return String;
   function Null_Or_Missing( i : Hlprb2_Type ) return Boolean;
   function Convert_Hlprb2_Type( i : String ) return Hlprb2_Type;


   type Hlprba_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      probs_arms_or_legs );

   function Pretty_Print( i : Hlprba_Type ) return String;
   function Null_Or_Missing( i : Hlprba_Type ) return Boolean;
   function Convert_Hlprba_Type( i : String ) return Hlprba_Type;


   type Hlprbb_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      difficulty_seeing );

   function Pretty_Print( i : Hlprbb_Type ) return String;
   function Null_Or_Missing( i : Hlprbb_Type ) return Boolean;
   function Convert_Hlprbb_Type( i : String ) return Hlprbb_Type;


   type Hlprbc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      difficulty_hearing );

   function Pretty_Print( i : Hlprbc_Type ) return String;
   function Null_Or_Missing( i : Hlprbc_Type ) return Boolean;
   function Convert_Hlprbc_Type( i : String ) return Hlprbc_Type;


   type Hlprbd_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      skin_conds_allergies );

   function Pretty_Print( i : Hlprbd_Type ) return String;
   function Null_Or_Missing( i : Hlprbd_Type ) return Boolean;
   function Convert_Hlprbd_Type( i : String ) return Hlprbd_Type;


   type Hlprbe_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      chest_breathing_prob );

   function Pretty_Print( i : Hlprbe_Type ) return String;
   function Null_Or_Missing( i : Hlprbe_Type ) return Boolean;
   function Convert_Hlprbe_Type( i : String ) return Hlprbe_Type;


   type Hlprbf_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      heart_and_blood );

   function Pretty_Print( i : Hlprbf_Type ) return String;
   function Null_Or_Missing( i : Hlprbf_Type ) return Boolean;
   function Convert_Hlprbf_Type( i : String ) return Hlprbf_Type;


   type Hlprbg_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      stomach_liver_kidney );

   function Pretty_Print( i : Hlprbg_Type ) return String;
   function Null_Or_Missing( i : Hlprbg_Type ) return Boolean;
   function Convert_Hlprbg_Type( i : String ) return Hlprbg_Type;


   type Hlprbh_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      diabetes );

   function Pretty_Print( i : Hlprbh_Type ) return String;
   function Null_Or_Missing( i : Hlprbh_Type ) return Boolean;
   function Convert_Hlprbh_Type( i : String ) return Hlprbh_Type;


   type Hlprbi_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      anxiety_depression );

   function Pretty_Print( i : Hlprbi_Type ) return String;
   function Null_Or_Missing( i : Hlprbi_Type ) return Boolean;
   function Convert_Hlprbi_Type( i : String ) return Hlprbi_Type;


   type Hlprbj_Type is (  
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      alcohol_drugs );

   function Pretty_Print( i : Hlprbj_Type ) return String;
   function Null_Or_Missing( i : Hlprbj_Type ) return Boolean;
   function Convert_Hlprbj_Type( i : String ) return Hlprbj_Type;


   type Hlprbk_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      epilepsy );

   function Pretty_Print( i : Hlprbk_Type ) return String;
   function Null_Or_Missing( i : Hlprbk_Type ) return Boolean;
   function Convert_Hlprbk_Type( i : String ) return Hlprbk_Type;


   type Hlprbl_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      migraine_freq_hdache );

   function Pretty_Print( i : Hlprbl_Type ) return String;
   function Null_Or_Missing( i : Hlprbl_Type ) return Boolean;
   function Convert_Hlprbl_Type( i : String ) return Hlprbl_Type;


   type Hlprbm_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other );

   function Pretty_Print( i : Hlprbm_Type ) return String;
   function Null_Or_Missing( i : Hlprbm_Type ) return Boolean;
   function Convert_Hlprbm_Type( i : String ) return Hlprbm_Type;


   type Hlprbn_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      cancer );

   function Pretty_Print( i : Hlprbn_Type ) return String;
   function Null_Or_Missing( i : Hlprbn_Type ) return Boolean;
   function Convert_Hlprbn_Type( i : String ) return Hlprbn_Type;


   type Hlprbo_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      stroke );

   function Pretty_Print( i : Hlprbo_Type ) return String;
   function Null_Or_Missing( i : Hlprbo_Type ) return Boolean;
   function Convert_Hlprbo_Type( i : String ) return Hlprbo_Type;


   type Hlsf1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      excellent,
      very_good,
      good,
      fair,
      poor );

   function Pretty_Print( i : Hlsf1_Type ) return String;
   function Null_Or_Missing( i : Hlsf1_Type ) return Boolean;
   function Convert_Hlsf1_Type( i : String ) return Hlsf1_Type;


   type Hlsf10a_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      definitely_true,
      mostly_true,
      not_sure,
      mostly_false,
      definitely_false );

   function Pretty_Print( i : Hlsf10a_Type ) return String;
   function Null_Or_Missing( i : Hlsf10a_Type ) return Boolean;
   function Convert_Hlsf10a_Type( i : String ) return Hlsf10a_Type;


   type Hlsf2_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      much_better_than_year_ago,
      better_than_year_ago,
      about_the_same,
      worse_than_year_ago,
      much_worse_than_year_ago );

   function Pretty_Print( i : Hlsf2_Type ) return String;
   function Null_Or_Missing( i : Hlsf2_Type ) return Boolean;
   function Convert_Hlsf2_Type( i : String ) return Hlsf2_Type;


   type Hlsf3a_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_limited_a_lot,
      yes_ltd_a_little,
      no_not_ltd_at_all );

   function Pretty_Print( i : Hlsf3a_Type ) return String;
   function Null_Or_Missing( i : Hlsf3a_Type ) return Boolean;
   function Convert_Hlsf3a_Type( i : String ) return Hlsf3a_Type;


   type Hlsf6_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_at_all,
      slightly,
      moderately,
      quite_a_bit,
      extremely );

   function Pretty_Print( i : Hlsf6_Type ) return String;
   function Null_Or_Missing( i : Hlsf6_Type ) return Boolean;
   function Convert_Hlsf6_Type( i : String ) return Hlsf6_Type;


   type Hlsf7_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none,
      very_mild,
      mild,
      moderate,
      severe,
      very_severe );

   function Pretty_Print( i : Hlsf7_Type ) return String;
   function Null_Or_Missing( i : Hlsf7_Type ) return Boolean;
   function Convert_Hlsf7_Type( i : String ) return Hlsf7_Type;


   type Hlsf9a_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      all_of_the_time,
      most_of_the_time,
      a_good_bit_of_the_time,
      some_of_the_time,
      a_little_of_the_time,
      none_of_the_time );

   function Pretty_Print( i : Hlsf9a_Type ) return String;
   function Null_Or_Missing( i : Hlsf9a_Type ) return Boolean;
   function Convert_Hlsf9a_Type( i : String ) return Hlsf9a_Type;


   type Hlstat_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      excellent,
      good,
      fair,
      poor,
      very_poor );

   function Pretty_Print( i : Hlstat_Type ) return String;
   function Null_Or_Missing( i : Hlstat_Type ) return Boolean;
   function Convert_Hlstat_Type( i : String ) return Hlstat_Type;


   type Hlsv_Type is (  
      cant_remember,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Hlsv_Type ) return String;
   function Null_Or_Missing( i : Hlsv_Type ) return Boolean;
   function Convert_Hlsv_Type( i : String ) return Hlsv_Type;


   type Hlsva_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_health_visitor );

   function Pretty_Print( i : Hlsva_Type ) return String;
   function Null_Or_Missing( i : Hlsva_Type ) return Boolean;
   function Convert_Hlsva_Type( i : String ) return Hlsva_Type;


   type Hlsvaf_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      free,
      paid,
      both );

   function Pretty_Print( i : Hlsvaf_Type ) return String;
   function Null_Or_Missing( i : Hlsvaf_Type ) return Boolean;
   function Convert_Hlsvaf_Type( i : String ) return Hlsvaf_Type;


   type Hlsvan_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      nhs_or_ssd,
      private_or_voluntary,
      both_nhs_and_private );

   function Pretty_Print( i : Hlsvan_Type ) return String;
   function Null_Or_Missing( i : Hlsvan_Type ) return Boolean;
   function Convert_Hlsvan_Type( i : String ) return Hlsvan_Type;


   type Hlsvb_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      has_used_home_help );

   function Pretty_Print( i : Hlsvb_Type ) return String;
   function Null_Or_Missing( i : Hlsvb_Type ) return Boolean;
   function Convert_Hlsvb_Type( i : String ) return Hlsvb_Type;


   type Hlsvc_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_meals_on_wheels );

   function Pretty_Print( i : Hlsvc_Type ) return String;
   function Null_Or_Missing( i : Hlsvc_Type ) return Boolean;
   function Convert_Hlsvc_Type( i : String ) return Hlsvc_Type;


   type Hlsvd_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_socl_wrker_etc );

   function Pretty_Print( i : Hlsvd_Type ) return String;
   function Null_Or_Missing( i : Hlsvd_Type ) return Boolean;
   function Convert_Hlsvd_Type( i : String ) return Hlsvd_Type;


   type Hlsve_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_chiropodist );

   function Pretty_Print( i : Hlsve_Type ) return String;
   function Null_Or_Missing( i : Hlsve_Type ) return Boolean;
   function Convert_Hlsve_Type( i : String ) return Hlsve_Type;


   type Hlsvf_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_altern_medicine );

   function Pretty_Print( i : Hlsvf_Type ) return String;
   function Null_Or_Missing( i : Hlsvf_Type ) return Boolean;
   function Convert_Hlsvf_Type( i : String ) return Hlsvf_Type;


   type Hlsvg_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_psychotherapist );

   function Pretty_Print( i : Hlsvg_Type ) return String;
   function Null_Or_Missing( i : Hlsvg_Type ) return Boolean;
   function Convert_Hlsvg_Type( i : String ) return Hlsvg_Type;


   type Hlsvh_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_spch_therapist );

   function Pretty_Print( i : Hlsvh_Type ) return String;
   function Null_Or_Missing( i : Hlsvh_Type ) return Boolean;
   function Convert_Hlsvh_Type( i : String ) return Hlsvh_Type;


   type Hlsvi_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_physiotherapist );

   function Pretty_Print( i : Hlsvi_Type ) return String;
   function Null_Or_Missing( i : Hlsvi_Type ) return Boolean;
   function Convert_Hlsvi_Type( i : String ) return Hlsvi_Type;


   type Hlsvj_Type is (  
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      one_other_service );

   function Pretty_Print( i : Hlsvj_Type ) return String;
   function Null_Or_Missing( i : Hlsvj_Type ) return Boolean;
   function Convert_Hlsvj_Type( i : String ) return Hlsvj_Type;


   type Hlsvk_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      second_welfr_service );

   function Pretty_Print( i : Hlsvk_Type ) return String;
   function Null_Or_Missing( i : Hlsvk_Type ) return Boolean;
   function Convert_Hlsvk_Type( i : String ) return Hlsvk_Type;


   type Hlsvl_Type is (  
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_consultant );

   function Pretty_Print( i : Hlsvl_Type ) return String;
   function Null_Or_Missing( i : Hlsvl_Type ) return Boolean;
   function Convert_Hlsvl_Type( i : String ) return Hlsvl_Type;


   type Hlsvlf_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      free,
      paid,
      both );

   function Pretty_Print( i : Hlsvlf_Type ) return String;
   function Null_Or_Missing( i : Hlsvlf_Type ) return Boolean;
   function Convert_Hlsvlf_Type( i : String ) return Hlsvlf_Type;


   type Hlsvln_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      nhs_or_ssd,
      private_or_voluntary,
      both_nhs_and_private );

   function Pretty_Print( i : Hlsvln_Type ) return String;
   function Null_Or_Missing( i : Hlsvln_Type ) return Boolean;
   function Convert_Hlsvln_Type( i : String ) return Hlsvln_Type;


   type Hlsvm_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      used_consultant );

   function Pretty_Print( i : Hlsvm_Type ) return String;
   function Null_Or_Missing( i : Hlsvm_Type ) return Boolean;
   function Convert_Hlsvm_Type( i : String ) return Hlsvm_Type;


   type Hltrpn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      every_day,
      once_a_week,
      once_a_month,
      less_often );

   function Pretty_Print( i : Hltrpn_Type ) return String;
   function Null_Or_Missing( i : Hltrpn_Type ) return Boolean;
   function Convert_Hltrpn_Type( i : String ) return Hltrpn_Type;


   type Hlwte_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      fairly_sure,
      estimate );

   function Pretty_Print( i : Hlwte_Type ) return String;
   function Null_Or_Missing( i : Hlwte_Type ) return Boolean;
   function Convert_Hlwte_Type( i : String ) return Hlwte_Type;


   type Hlwtl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      within_last_week,
      s_1_4_weeks_ago,
      s_1_3_months_ago,
      s_3_6_months_ago,
      s_6mths_to_a_year_ago,
      more_than_a_year,
      more_than_5_years );

   function Pretty_Print( i : Hlwtl_Type ) return String;
   function Null_Or_Missing( i : Hlwtl_Type ) return Boolean;
   function Convert_Hlwtl_Type( i : String ) return Hlwtl_Type;


   type Hlwtm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      stones_and_pounds,
      kilos_and_grams,
      cant_give_estimate );

   function Pretty_Print( i : Hlwtm_Type ) return String;
   function Null_Or_Missing( i : Hlwtm_Type ) return Boolean;
   function Convert_Hlwtm_Type( i : String ) return Hlwtm_Type;


   type Hlwtr_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      about_right_weight,
      underweight,
      slightly_overweight,
      very_overweight );

   function Pretty_Print( i : Hlwtr_Type ) return String;
   function Null_Or_Missing( i : Hlwtr_Type ) return Boolean;
   function Convert_Hlwtr_Type( i : String ) return Hlwtr_Type;


   type Hlzest_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      more_energetic,
      about_the_same,
      less_energetic );

   function Pretty_Print( i : Hlzest_Type ) return String;
   function Null_Or_Missing( i : Hlzest_Type ) return Boolean;
   function Convert_Hlzest_Type( i : String ) return Hlzest_Type;


   type Hoh_Type is (  
      inapplicable,
      missing_or_wild,
      head_of_household,
      not_head );

   function Pretty_Print( i : Hoh_Type ) return String;
   function Null_Or_Missing( i : Hoh_Type ) return Boolean;
   function Convert_Hoh_Type( i : String ) return Hoh_Type;


   type Holkid_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      regular_basis,
      irregular_basis,
      not_at_all );

   function Pretty_Print( i : Holkid_Type ) return String;
   function Null_Or_Missing( i : Holkid_Type ) return Boolean;
   function Convert_Holkid_Type( i : String ) return Holkid_Type;


   type Hood15_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      an_inner_city_area,
      a_suburban_area,
      a_town,
      a_village,
      rural_or_countryside,
      mixture_or_moved_around );

   function Pretty_Print( i : Hood15_Type ) return String;
   function Null_Or_Missing( i : Hood15_Type ) return Boolean;
   function Convert_Hood15_Type( i : String ) return Hood15_Type;


   type Hospch_Type is (  
      cant_remember,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_all,
      yes_some,
      no );

   function Pretty_Print( i : Hospch_Type ) return String;
   function Null_Or_Missing( i : Hospch_Type ) return Boolean;
   function Convert_Hospch_Type( i : String ) return Hospch_Type;


   type Hospnhs_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      all_free_under_nhs,
      all_paid_privately,
      some_nhs_or_private );

   function Pretty_Print( i : Hospnhs_Type ) return String;
   function Null_Or_Missing( i : Hospnhs_Type ) return Boolean;
   function Convert_Hospnhs_Type( i : String ) return Hospnhs_Type;


   type Howlng_Type is (  
      dont_know,
      refused,
      none,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Howlng_Type ) return String;
   function Null_Or_Missing( i : Howlng_Type ) return Boolean;
   function Convert_Howlng_Type( i : String ) return Howlng_Type;


   type Hs2val_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      under_5000,
      s_5000_to_10_000,
      s_10_000_to_50_000,
      s_50_000_to_100_000,
      s_100_000_or_more );

   function Pretty_Print( i : Hs2val_Type ) return String;
   function Null_Or_Missing( i : Hs2val_Type ) return Boolean;
   function Convert_Hs2val_Type( i : String ) return Hs2val_Type;


   type Hsbeds_Type is (  
      refused,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Hsbeds_Type ) return String;
   function Null_Or_Missing( i : Hsbeds_Type ) return Boolean;
   function Convert_Hsbeds_Type( i : String ) return Hsbeds_Type;


   type Hscimp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      very_important,
      somewhat_important,
      not_very_important );

   function Pretty_Print( i : Hscimp_Type ) return String;
   function Null_Or_Missing( i : Hscimp_Type ) return Boolean;
   function Convert_Hscimp_Type( i : String ) return Hscimp_Type;


   type Hscost_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_999997_or_above );

   function Pretty_Print( i : Hscost_Type ) return String;
   function Null_Or_Missing( i : Hscost_Type ) return Boolean;
   function Convert_Hscost_Type( i : String ) return Hscost_Type;


   type Hsctax_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      band_a_up_to_40_000,
      band_b_40_001_52_000,
      band_c_52_001_68_000,
      band_d_68_001_88_000,
      band_e_88_001_120_000,
      band_f_120_001_160_000,
      band_g_160_001_320_000,
      band_h_320_001_plus,
      hhold_accom_not_valued_separately,
      na_northern_ireland );

   function Pretty_Print( i : Hsctax_Type ) return String;
   function Null_Or_Missing( i : Hsctax_Type ) return Boolean;
   function Convert_Hsctax_Type( i : String ) return Hsctax_Type;


   type Hsfloor_Type is (  
      inapplicable,
      missing_or_wild,
      basement_or_semi_basement,
      grd_flr_or_str_level,
      s_1st_floor,
      s_2nd_floor,
      s_3rd_floor,
      s_4th_9th_floor,
      s_10th_19th_floor,
      s_20th_flr_and_up );

   function Pretty_Print( i : Hsfloor_Type ) return String;
   function Null_Or_Missing( i : Hsfloor_Type ) return Boolean;
   function Convert_Hsfloor_Type( i : String ) return Hsfloor_Type;


   type Hsownd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      owned_or_on_mortgage,
      shared_ownership,
      rented,
      rent_free,
      other );

   function Pretty_Print( i : Hsownd_Type ) return String;
   function Null_Or_Missing( i : Hsownd_Type ) return Boolean;
   function Convert_Hsownd_Type( i : String ) return Hsownd_Type;


   type Hsowr1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_in_houseshold );

   function Pretty_Print( i : Hsowr1_Type ) return String;
   function Null_Or_Missing( i : Hsowr1_Type ) return Boolean;
   function Convert_Hsowr1_Type( i : String ) return Hsowr1_Type;


   type Hsprba_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      big_problem,
      small_problem,
      not_a_problem );

   function Pretty_Print( i : Hsprba_Type ) return String;
   function Null_Or_Missing( i : Hsprba_Type ) return Boolean;
   function Convert_Hsprba_Type( i : String ) return Hsprba_Type;


   type Hstype_Type is (  
      dont_know,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      other,
      detd_house_or_bungalow,
      institutional,
      tphone_q_not_asked,
      semi_detd_house_or_bungalow,
      end_terraced_house,
      terraced_house,
      purpose_built_flat_or_maisonette,
      converted_flat_or_maisonette,
      incl_business_premises,
      bedsit_multi_occup,
      bedsitter_other );

   function Pretty_Print( i : Hstype_Type ) return String;
   function Null_Or_Missing( i : Hstype_Type ) return Boolean;
   function Convert_Hstype_Type( i : String ) return Hstype_Type;


   type Hsvali_Type is (  
      var_dont_know,
      var_refused,
      proxy_and_or_phone,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed );

   function Pretty_Print( i : Hsvali_Type ) return String;
   function Null_Or_Missing( i : Hsvali_Type ) return Boolean;
   function Convert_Hsvali_Type( i : String ) return Hsvali_Type;


   type Hsvndr_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      local_auth_or_council,
      new_town_corp_or_dev_agy,
      housing_association,
      someone_else );

   function Pretty_Print( i : Hsvndr_Type ) return String;
   function Null_Or_Missing( i : Hsvndr_Type ) return Boolean;
   function Convert_Hsvndr_Type( i : String ) return Hsvndr_Type;


   type Hswpc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      pre_1983_computer,
      apple_macintosh,
      ibm_compat_286_or_386,
      ibm_compatible_486,
      ibm_compat_pentium,
      other_not_specified,
      ibm_comp_nes,
      other_non_ibm_nes );

   function Pretty_Print( i : Hswpc_Type ) return String;
   function Null_Or_Missing( i : Hswpc_Type ) return Boolean;
   function Convert_Hswpc_Type( i : String ) return Hswpc_Type;


   type Hsyr0_Type is (  
      dont_know,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_1993,
      s_1994,
      s_1995,
      s_1996 );

   function Pretty_Print( i : Hsyr0_Type ) return String;
   function Null_Or_Missing( i : Hsyr0_Type ) return Boolean;
   function Convert_Hsyr0_Type( i : String ) return Hsyr0_Type;


   type Hsyr04_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1993,
      s_1994,
      s_1995,
      s_1996 );

   function Pretty_Print( i : Hsyr04_Type ) return String;
   function Null_Or_Missing( i : Hsyr04_Type ) return Boolean;
   function Convert_Hsyr04_Type( i : String ) return Hsyr04_Type;


   type Huasks_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      asks_spouse_or_part,
      tells_spouse_or_part,
      does_not_mention,
      other );

   function Pretty_Print( i : Huasks_Type ) return String;
   function Null_Or_Missing( i : Huasks_Type ) return Boolean;
   function Convert_Huasks_Type( i : String ) return Huasks_Type;


   type Huboss_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      respondent,
      partner,
      equal_say,
      other );

   function Pretty_Print( i : Huboss_Type ) return String;
   function Null_Or_Missing( i : Huboss_Type ) return Boolean;
   function Convert_Huboss_Type( i : String ) return Huboss_Type;


   type Hubuys_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      mostly_self,
      mostly_partner,
      shared,
      other );

   function Pretty_Print( i : Hubuys_Type ) return String;
   function Null_Or_Missing( i : Hubuys_Type ) return Boolean;
   function Convert_Hubuys_Type( i : String ) return Hubuys_Type;


   type Hucook_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      mostly_self,
      mostly_other_pers,
      shared );

   function Pretty_Print( i : Hucook_Type ) return String;
   function Null_Or_Missing( i : Hucook_Type ) return Boolean;
   function Convert_Hucook_Type( i : String ) return Hucook_Type;


   type Hudoes_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      always_self,
      usu_self,
      self_partnr_equal,
      usu_partner,
      always_partner,
      someone_else );

   function Pretty_Print( i : Hudoes_Type ) return String;
   function Null_Or_Missing( i : Hudoes_Type ) return Boolean;
   function Convert_Hudoes_Type( i : String ) return Hudoes_Type;


   type Hudraw_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      only_or_mainly_r,
      only_or_mainly_others,
      both_equally,
      does_not_apply );

   function Pretty_Print( i : Hudraw_Type ) return String;
   function Null_Or_Missing( i : Hudraw_Type ) return Boolean;
   function Convert_Hudraw_Type( i : String ) return Hudraw_Type;


   type Hukeep_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      mainly_resp,
      mainly_spouse_or_part,
      joint_w_spouse_or_part,
      some_one_else );

   function Pretty_Print( i : Hukeep_Type ) return String;
   function Null_Or_Missing( i : Hukeep_Type ) return Boolean;
   function Convert_Hukeep_Type( i : String ) return Hukeep_Type;


   type Hunurs_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      respondent,
      spouse_or_partner,
      mothers_help_or_nanny,
      relative,
      friend_or_neighbour,
      other,
      varies );

   function Pretty_Print( i : Hunurs_Type ) return String;
   function Null_Or_Missing( i : Hunurs_Type ) return Boolean;
   function Convert_Hunurs_Type( i : String ) return Hunurs_Type;


   type Huruns_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      r_looks_after_hh_mon,
      partner_looks_after,
      r_given_hh_allowance,
      part_has_hh_allwnce,
      share_hh_fin_equally,
      maintain_separately,
      other_arrangement,
      other );

   function Pretty_Print( i : Huruns_Type ) return String;
   function Null_Or_Missing( i : Huruns_Type ) return Boolean;
   function Convert_Huruns_Type( i : String ) return Huruns_Type;


   type Husits_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      mainly_resp,
      mainly_partner,
      joint_w_partner,
      some_one_else,
      always_partner );

   function Pretty_Print( i : Husits_Type ) return String;
   function Null_Or_Missing( i : Husits_Type ) return Boolean;
   function Convert_Husits_Type( i : String ) return Husits_Type;


   type Huxpch_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      all_from_r_wages,
      most_from_r_wages,
      share_costs_w_partnr,
      most_by_spouse_or_part,
      all_by_spouse_or_partnr,
      other );

   function Pretty_Print( i : Huxpch_Type ) return String;
   function Null_Or_Missing( i : Huxpch_Type ) return Boolean;
   function Convert_Huxpch_Type( i : String ) return Huxpch_Type;


   type Iivfho_Type is (  
      not_applicable,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_interview_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal,
      lt_untraced_withdrawn );

   function Pretty_Print( i : Iivfho_Type ) return String;
   function Null_Or_Missing( i : Iivfho_Type ) return Boolean;
   function Convert_Iivfho_Type( i : String ) return Iivfho_Type;


   type Iivfio_Type is (  
      not_applicable,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_re,
      dead );

   function Pretty_Print( i : Iivfio_Type ) return String;
   function Null_Or_Missing( i : Iivfio_Type ) return Boolean;
   function Convert_Iivfio_Type( i : String ) return Iivfio_Type;


   type Iodc_Type is (  
      inapplicable,
      missing_or_wild,
      no_interview,
      individual_only,
      proxy_questaire,
      proxy,
      indl_and_self_comp,
      sc_expected_but_not_yet_here );

   function Pretty_Print( i : Iodc_Type ) return String;
   function Null_Or_Missing( i : Iodc_Type ) return Boolean;
   function Convert_Iodc_Type( i : String ) return Iodc_Type;


   type Isced_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing,
      not_defined,
      primary,
      low_secondary,
      s_3clow_sec_voc,
      s_3ahisec_mivoc,
      s_5bhigher_voc,
      s_5afirst_degree,
      s_6higher_degree );

   function Pretty_Print( i : Isced_Type ) return String;
   function Null_Or_Missing( i : Isced_Type ) return Boolean;
   function Convert_Isced_Type( i : String ) return Isced_Type;


   type Iv10no_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      no_fed_forward_info );

   function Pretty_Print( i : Iv10no_Type ) return String;
   function Null_Or_Missing( i : Iv10no_Type ) return Boolean;
   function Convert_Iv10no_Type( i : String ) return Iv10no_Type;


   type Iv2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      a_great_deal,
      a_fair_amount,
      a_little,
      not_at_all );

   function Pretty_Print( i : Iv2_Type ) return String;
   function Null_Or_Missing( i : Iv2_Type ) return Boolean;
   function Convert_Iv2_Type( i : String ) return Iv2_Type;


   type Iv4_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      very_good,
      good,
      fair,
      poor,
      very_poor );

   function Pretty_Print( i : Iv4_Type ) return String;
   function Null_Or_Missing( i : Iv4_Type ) return Boolean;
   function Convert_Iv4_Type( i : String ) return Iv4_Type;


   type Iv5_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_completed,
      no_refused,
      other );

   function Pretty_Print( i : Iv5_Type ) return String;
   function Null_Or_Missing( i : Iv5_Type ) return Boolean;
   function Convert_Iv5_Type( i : String ) return Iv5_Type;


   type Iv5aa_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      mobile_number_given );

   function Pretty_Print( i : Iv5aa_Type ) return String;
   function Null_Or_Missing( i : Iv5aa_Type ) return Boolean;
   function Convert_Iv5aa_Type( i : String ) return Iv5aa_Type;


   type Iv5ab_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      email_given );

   function Pretty_Print( i : Iv5ab_Type ) return String;
   function Null_Or_Missing( i : Iv5ab_Type ) return Boolean;
   function Convert_Iv5ab_Type( i : String ) return Iv5ab_Type;


   type Iv5ac_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      neither_given );

   function Pretty_Print( i : Iv5ac_Type ) return String;
   function Null_Or_Missing( i : Iv5ac_Type ) return Boolean;
   function Convert_Iv5ac_Type( i : String ) return Iv5ac_Type;


   type Iv7_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_interpreter_hh );

   function Pretty_Print( i : Iv7_Type ) return String;
   function Null_Or_Missing( i : Iv7_Type ) return Boolean;
   function Convert_Iv7_Type( i : String ) return Iv7_Type;


   type Ivavt_Type is (  
      inapplicable,
      missing_or_wild,
      ten_pound_voucher,
      seven_pound_voucher );

   function Pretty_Print( i : Ivavt_Type ) return String;
   function Null_Or_Missing( i : Ivavt_Type ) return Boolean;
   function Convert_Ivavt_Type( i : String ) return Ivavt_Type;


   type Ivcbage_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      male_16_64,
      female_16_45,
      other );

   function Pretty_Print( i : Ivcbage_Type ) return String;
   function Null_Or_Missing( i : Ivcbage_Type ) return Boolean;
   function Convert_Ivcbage_Type( i : String ) return Ivcbage_Type;


   type Ivconv_Type is (  
      inapplicable,
      missing_or_wild,
      conversion_attempted,
      no_convrsion_attempt );

   function Pretty_Print( i : Ivconv_Type ) return String;
   function Null_Or_Missing( i : Ivconv_Type ) return Boolean;
   function Convert_Ivconv_Type( i : String ) return Ivconv_Type;


   type Ivcoop_Type is (  
      inapplicable,
      missing_or_wild,
      cooperative,
      some_persuasion_needed,
      very_reluctant );

   function Pretty_Print( i : Ivcoop_Type ) return String;
   function Null_Or_Missing( i : Ivcoop_Type ) return Boolean;
   function Convert_Ivcoop_Type( i : String ) return Ivcoop_Type;


   type Ivda_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      respondent_alone );

   function Pretty_Print( i : Ivda_Type ) return String;
   function Null_Or_Missing( i : Ivda_Type ) return Boolean;
   function Convert_Ivda_Type( i : String ) return Ivda_Type;


   type Ivdb_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      partner_present );

   function Pretty_Print( i : Ivdb_Type ) return String;
   function Null_Or_Missing( i : Ivdb_Type ) return Boolean;
   function Convert_Ivdb_Type( i : String ) return Ivdb_Type;


   type Ivdc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_adts_pres );

   function Pretty_Print( i : Ivdc_Type ) return String;
   function Null_Or_Missing( i : Ivdc_Type ) return Boolean;
   function Convert_Ivdc_Type( i : String ) return Ivdc_Type;


   type Ivdd_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      children_present );

   function Pretty_Print( i : Ivdd_Type ) return String;
   function Null_Or_Missing( i : Ivdd_Type ) return Boolean;
   function Convert_Ivdd_Type( i : String ) return Ivdd_Type;


   type Ivec_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_adults_pres );

   function Pretty_Print( i : Ivec_Type ) return String;
   function Null_Or_Missing( i : Ivec_Type ) return Boolean;
   function Convert_Ivec_Type( i : String ) return Ivec_Type;


   type Ivee_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      supervisor_present );

   function Pretty_Print( i : Ivee_Type ) return String;
   function Null_Or_Missing( i : Ivee_Type ) return Boolean;
   function Convert_Ivee_Type( i : String ) return Ivee_Type;


   type Ivelig_Type is (  
      inapplicable,
      missing_or_wild,
      continuing,
      new_entrants,
      not_eligible_this_yr,
      check_if_eligible,
      deceased,
      wave_1_non_contact );

   function Pretty_Print( i : Ivelig_Type ) return String;
   function Null_Or_Missing( i : Ivelig_Type ) return Boolean;
   function Convert_Ivelig_Type( i : String ) return Ivelig_Type;


   type Ivfc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_adlts_pres );

   function Pretty_Print( i : Ivfc_Type ) return String;
   function Null_Or_Missing( i : Ivfc_Type ) return Boolean;
   function Convert_Ivfc_Type( i : String ) return Ivfc_Type;


   type Ivfho_Type is (  
      inapplicable,
      missing_or_wild,
      demolished_or_derelict,
      all_eligible_hh_intervd,
      interviews_plus_proxies,
      interviews_plus_refusals,
      hh_comp_plus_ques_only,
      hh_composition_only,
      pxy_at_original_addr,
      phone_pxy_intvw_only,
      youth_interview_only,
      docs_missing_or_unusable,
      business_use_only,
      refusal_to_hq,
      all_refus_to_inter,
      lang_probs_no_interp,
      too_old_or_infirm,
      no_hh_member_contact,
      temp_accomm_only,
      coversheet_only,
      intervw_refusl_to_hq,
      intvw_refusl_to_intr,
      lang_probs_no_enumn,
      age_or_health_no_enumn,
      docs_missing_or_unus,
      empty_at_first_call,
      only_business_prem,
      out_scope_institn,
      pxy_w1_or_2_mem_add_sme,
      movd_back_to_w1_hh_or_add,
      no_psms_resident,
      adamant_refusal,
      building_not_complete,
      address_not_found,
      institut_no_privt_hh,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      missing_person_ref,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      lt_untraced_withdrawn,
      new_sample_withdrawn,
      withdrawn_before_field );

   function Pretty_Print( i : Ivfho_Type ) return String;
   function Null_Or_Missing( i : Ivfho_Type ) return Boolean;
   function Convert_Ivfho_Type( i : String ) return Ivfho_Type;


   type Ivfio_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      absent_no_proxy,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      oth_non_cont_or_no_proxy,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      pres_or_no_intv_or_no_proxy,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      other,
      no_one_elig_in_hh,
      prev_wave_adamant_refusl,
      l_t_untraced_wdrawn,
      withdrawn_before_field,
      lost_capi_intvw,
      other_retiring,
      dead );

   function Pretty_Print( i : Ivfio_Type ) return String;
   function Null_Or_Missing( i : Ivfio_Type ) return Boolean;
   function Convert_Ivfio_Type( i : String ) return Ivfio_Type;


   type Ivh1_Type is (  
      not_answered,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Ivh1_Type ) return String;
   function Null_Or_Missing( i : Ivh1_Type ) return Boolean;
   function Convert_Ivh1_Type( i : String ) return Ivh1_Type;


   type Ivhsize_Type is (  
      dont_know,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Ivhsize_Type ) return String;
   function Null_Or_Missing( i : Ivhsize_Type ) return Boolean;
   function Convert_Ivhsize_Type( i : String ) return Ivhsize_Type;


   type Ivhzif_Type is (  
      inapplicable,
      yes,
      no );

   function Pretty_Print( i : Ivhzif_Type ) return String;
   function Null_Or_Missing( i : Ivhzif_Type ) return Boolean;
   function Convert_Ivhzif_Type( i : String ) return Ivhzif_Type;


   type Ivia_Type is (  
      movers_known_bfr_field,
      not_issued_to_field,
      telephone_area_1,
      telephone_area_2,
      telephone_only );

   function Pretty_Print( i : Ivia_Type ) return String;
   function Null_Or_Missing( i : Ivia_Type ) return Boolean;
   function Convert_Ivia_Type( i : String ) return Ivia_Type;


   type Iviam_Type is (  
      missing_or_wild,
      no_nonlocal_move,
      tel_int_hh_moved,
      not_issued_or_alloc,
      telephone_area_1,
      telephone_area_2,
      telephone_only,
      mvd_ni_gb_no_attempt );

   function Pretty_Print( i : Iviam_Type ) return String;
   function Null_Or_Missing( i : Iviam_Type ) return Boolean;
   function Convert_Iviam_Type( i : String ) return Iviam_Type;


   type Ivid_Type is (  
      inapplicable,
      missing,
      intvw_not_attempted );

   function Pretty_Print( i : Ivid_Type ) return String;
   function Null_Or_Missing( i : Ivid_Type ) return Boolean;
   function Convert_Ivid_Type( i : String ) return Ivid_Type;


   type Ivievr_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no_new,
      no_never,
      no_check,
      deceased );

   function Pretty_Print( i : Ivievr_Type ) return String;
   function Null_Or_Missing( i : Ivievr_Type ) return Boolean;
   function Convert_Ivievr_Type( i : String ) return Ivievr_Type;


   type Iviolw_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      eligible_but_not_interviewed,
      youth_int,
      child_gt_11,
      adult_in_non_int_hhold,
      retired_rejoiner );

   function Pretty_Print( i : Iviolw_Type ) return String;
   function Null_Or_Missing( i : Iviolw_Type ) return Boolean;
   function Convert_Iviolw_Type( i : String ) return Iviolw_Type;


   type Iviow1_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      proxy,
      refusal,
      absent_no_proxy,
      oth_non_cont_or_no_prox,
      pres_or_no_intv_or_no_prox,
      child_under_16,
      other );

   function Pretty_Print( i : Iviow1_Type ) return String;
   function Null_Or_Missing( i : Iviow1_Type ) return Boolean;
   function Convert_Iviow1_Type( i : String ) return Iviow1_Type;


   type Iviow2_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      elig_in_refusal_hh,
      out_of_scope_or_institd,
      chld_in_nonresp_hh,
      proxy,
      refusal,
      absent,
      non_contact,
      child_under_16,
      moved,
      other,
      elig_in_non_cont_h );

   function Pretty_Print( i : Iviow2_Type ) return String;
   function Null_Or_Missing( i : Iviow2_Type ) return Boolean;
   function Convert_Iviow2_Type( i : String ) return Iviow2_Type;


   type Iviow3_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      child_in_non_cont_h,
      other,
      chld_in_nonresp_hh,
      proxy,
      telephone,
      refusal,
      elig_in_non_cont_h,
      child_under_16,
      elig_in_refusal_hh,
      moved,
      out_of_scope_or_institd );

   function Pretty_Print( i : Iviow3_Type ) return String;
   function Null_Or_Missing( i : Iviow3_Type ) return Boolean;
   function Convert_Iviow3_Type( i : String ) return Iviow3_Type;


   type Iviow4_Type is (  
      inapplicable,
      missing_or_wild,
      full_interview,
      child_in_non_cont_h,
      other,
      chld_in_nonresp_hh,
      retired_rejoiner,
      proxy,
      telephone,
      refusal,
      elig_in_non_cont_h,
      child_under_16,
      elig_in_refusal_hh,
      moved,
      out_of_scope_or_institd );

   function Pretty_Print( i : Iviow4_Type ) return String;
   function Null_Or_Missing( i : Iviow4_Type ) return Boolean;
   function Convert_Iviow4_Type( i : String ) return Iviow4_Type;


   type Ivips_Type is (  
      missing,
      in_ips_sample,
      not_in_ips_sample,
      orig_ips_but_moved,
      w_1_non_contact_hh );

   function Pretty_Print( i : Ivips_Type ) return String;
   function Null_Or_Missing( i : Ivips_Type ) return Boolean;
   function Convert_Ivips_Type( i : String ) return Ivips_Type;


   type Ivireis_Type is (  
      inapplicable,
      missing_or_wild,
      re_issued_to_field,
      no_re_issue_to_field,
      other_action );

   function Pretty_Print( i : Ivireis_Type ) return String;
   function Null_Or_Missing( i : Ivireis_Type ) return Boolean;
   function Convert_Ivireis_Type( i : String ) return Ivireis_Type;


   type Ivisst_Type is (  
      yes,
      no_or_inacsble_hhold_0,
      no_or_retiring_hhold_0,
      no_or_inlgble_splt_off,
      no_or_other_split_off,
      issued_to_field_in_error,
      not_fed_forward_but_issued );

   function Pretty_Print( i : Ivisst_Type ) return String;
   function Null_Or_Missing( i : Ivisst_Type ) return Boolean;
   function Convert_Ivisst_Type( i : String ) return Ivisst_Type;


   type Ivla_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      resp_alone );

   function Pretty_Print( i : Ivla_Type ) return String;
   function Null_Or_Missing( i : Ivla_Type ) return Boolean;
   function Convert_Ivla_Type( i : String ) return Ivla_Type;


   type Ivlb_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      partn_present );

   function Pretty_Print( i : Ivlb_Type ) return String;
   function Null_Or_Missing( i : Ivlb_Type ) return Boolean;
   function Convert_Ivlb_Type( i : String ) return Ivlb_Type;


   type Ivlc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_adult_present );

   function Pretty_Print( i : Ivlc_Type ) return String;
   function Null_Or_Missing( i : Ivlc_Type ) return Boolean;
   function Convert_Ivlc_Type( i : String ) return Ivlc_Type;


   type Ivlnc_Type is (  
      dont_know,
      missing_or_wild );

   function Pretty_Print( i : Ivlnc_Type ) return String;
   function Null_Or_Missing( i : Ivlnc_Type ) return Boolean;
   function Convert_Ivlnc_Type( i : String ) return Ivlnc_Type;


   type Ivlpar_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      married_and_with_spouse,
      cohabiting,
      neither,
      in_civil_partnership );

   function Pretty_Print( i : Ivlpar_Type ) return String;
   function Null_Or_Missing( i : Ivlpar_Type ) return Boolean;
   function Convert_Ivlpar_Type( i : String ) return Ivlpar_Type;


   type Ivlyr_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      new_entrant,
      yes,
      no,
      youth_int,
      child_gt_11,
      adult_in_non_int_hh,
      unlisted_retired );

   function Pretty_Print( i : Ivlyr_Type ) return String;
   function Null_Or_Missing( i : Ivlyr_Type ) return Boolean;
   function Convert_Ivlyr_Type( i : String ) return Ivlyr_Type;


   type Ivmvst_Type is (  
      missing_or_wild,
      deceased,
      resident_at_last_addr,
      resid_new_local_addr,
      resid_new_nonloc_addr,
      incomplete_info );

   function Pretty_Print( i : Ivmvst_Type ) return String;
   function Null_Or_Missing( i : Ivmvst_Type ) return Boolean;
   function Convert_Ivmvst_Type( i : String ) return Ivmvst_Type;


   type Ivnadd_Type is (  
      inapplicable,
      missing_or_wild,
      hh_at_new_address,
      address_corrections,
      no_corrections_reqd,
      new_addr_unkwn_or_o_o_s,
      mvd_ni_gb_add_known,
      mvd_ni_gb_ad_unknwn );

   function Pretty_Print( i : Ivnadd_Type ) return String;
   function Null_Or_Missing( i : Ivnadd_Type ) return Boolean;
   function Convert_Ivnadd_Type( i : String ) return Ivnadd_Type;


   type Ivno_Type is (  
      inapplicable,
      missing );

   function Pretty_Print( i : Ivno_Type ) return String;
   function Null_Or_Missing( i : Ivno_Type ) return Boolean;
   function Convert_Ivno_Type( i : String ) return Ivno_Type;


   type Ivpa_Type is (  
      inapplicable,
      missing_or_wild,
      not_mentioned,
      informant_alone );

   function Pretty_Print( i : Ivpa_Type ) return String;
   function Null_Or_Missing( i : Ivpa_Type ) return Boolean;
   function Convert_Ivpa_Type( i : String ) return Ivpa_Type;


   type Ivpb_Type is (  
      inapplicable,
      missing_or_wild,
      not_mentioned,
      partner_present );

   function Pretty_Print( i : Ivpb_Type ) return String;
   function Null_Or_Missing( i : Ivpb_Type ) return Boolean;
   function Convert_Ivpb_Type( i : String ) return Ivpb_Type;


   type Ivpc_Type is (  
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_adlts_pres );

   function Pretty_Print( i : Ivpc_Type ) return String;
   function Null_Or_Missing( i : Ivpc_Type ) return Boolean;
   function Convert_Ivpc_Type( i : String ) return Ivpc_Type;


   type Ivpd_Type is (  
      inapplicable,
      missing_or_wild,
      not_mentioned,
      children_present );

   function Pretty_Print( i : Ivpd_Type ) return String;
   function Null_Or_Missing( i : Ivpd_Type ) return Boolean;
   function Convert_Ivpd_Type( i : String ) return Ivpd_Type;


   type Ivpe_Type is (  
      inapplicable,
      missing_or_wild,
      not_mentioned,
      supervisor_present );

   function Pretty_Print( i : Ivpe_Type ) return String;
   function Null_Or_Missing( i : Ivpe_Type ) return Boolean;
   function Convert_Ivpe_Type( i : String ) return Ivpe_Type;


   type Ivreis_Type is (  
      inapplicable,
      missing_or_wild,
      re_issued_to_field,
      no_re_issue_to_field );

   function Pretty_Print( i : Ivreis_Type ) return String;
   function Null_Or_Missing( i : Ivreis_Type ) return Boolean;
   function Convert_Ivreis_Type( i : String ) return Ivreis_Type;


   type Ivrref_Type is (  
      inapplicable,
      missing_or_wild,
      too_busy,
      care_of_ill_or_old,
      childcare,
      r_rarely_home,
      r_temp_absent,
      elderly_or_sick,
      no_confidentlty,
      qs_too_personal,
      uninterested,
      wont_bother,
      nothing_changed,
      survey_too_long,
      waste_of_time,
      prev_bad_exprnce,
      probs_gift_voucher,
      probs_with_consents,
      other,
      hh_mem_says_refuse,
      othr_says_refuse,
      hh_mem_refs_for_r,
      risk_other_response,
      stressful_fam_sit,
      no_reason_given );

   function Pretty_Print( i : Ivrref_Type ) return String;
   function Null_Or_Missing( i : Ivrref_Type ) return Boolean;
   function Convert_Ivrref_Type( i : String ) return Ivrref_Type;


   type Ivrrefh_Type is (  
      inapplicable,
      missing_or_wild,
      too_ill,
      care_of_ill_or_old,
      childcare,
      r_rarely_home,
      r_temp_absent,
      too_busy,
      too_elderly,
      no_confidentiality,
      qs_too_personal,
      senile,
      wont_bother,
      nothing_changed,
      survey_too_long,
      waste_of_time,
      prev_bad_exprnce,
      probs_gift_voucher,
      probs_with_consents,
      speaks_no_english,
      hh_mem_says_refuse,
      othr_says_refuse,
      hh_mem_refs_for_r,
      stressful_fam_sit,
      no_hh_member_contact,
      out_scope_institn,
      other,
      no_reason_given );

   function Pretty_Print( i : Ivrrefh_Type ) return String;
   function Null_Or_Missing( i : Ivrrefh_Type ) return Boolean;
   function Convert_Ivrrefh_Type( i : String ) return Ivrrefh_Type;


   type Ivsc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      r_compl_or_returned,
      r_requi_assistance,
      r_refused,
      other,
      other_completed,
      other_not_completed );

   function Pretty_Print( i : Ivsc_Type ) return String;
   function Null_Or_Missing( i : Ivsc_Type ) return Boolean;
   function Convert_Ivsc_Type( i : String ) return Ivsc_Type;


   type Ivsex_Type is (  
      inapplicable,
      missing,
      male,
      female );

   function Pretty_Print( i : Ivsex_Type ) return String;
   function Null_Or_Missing( i : Ivsex_Type ) return Boolean;
   function Convert_Ivsex_Type( i : String ) return Ivsex_Type;


   type Ivstat1_Type is (  
      inapplicable,
      missing_or_wild,
      intvwd_at_w1_and_w2,
      joined_at_or_after_w3,
      new_entrant_16yrs,
      new_entrant_adult,
      youth,
      child,
      check,
      deceased );

   function Pretty_Print( i : Ivstat1_Type ) return String;
   function Null_Or_Missing( i : Ivstat1_Type ) return Boolean;
   function Convert_Ivstat1_Type( i : String ) return Ivstat1_Type;


   type Ivstat2_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      intvwd_at_w1_and_w2,
      joined_at_or_after_w3,
      new_entrant_16yrs,
      never_interviewed,
      new_entrant_adult,
      child,
      check,
      proxy_respondent );

   function Pretty_Print( i : Ivstat2_Type ) return String;
   function Null_Or_Missing( i : Ivstat2_Type ) return Boolean;
   function Convert_Ivstat2_Type( i : String ) return Ivstat2_Type;


   type Ivva_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      respndent_alone );

   function Pretty_Print( i : Ivva_Type ) return String;
   function Null_Or_Missing( i : Ivva_Type ) return Boolean;
   function Convert_Ivva_Type( i : String ) return Ivva_Type;


   type J1boss_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      worked_on_own,
      had_employees );

   function Pretty_Print( i : J1boss_Type ) return String;
   function Null_Or_Missing( i : J1boss_Type ) return Boolean;
   function Convert_J1boss_Type( i : String ) return J1boss_Type;


   type J1cssf_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : J1cssf_Type ) return String;
   function Null_Or_Missing( i : J1cssf_Type ) return Boolean;
   function Convert_J1cssf_Type( i : String ) return J1cssf_Type;


   type J1gold_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      service_class_higher,
      semi_unskilled_manua,
      agricultural_workers,
      service_class_lower,
      routine_non_manual_e,
      personal_service_wor,
      sml_props_w_employee,
      sml_props_w_or_o_employ,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_worke );

   function Pretty_Print( i : J1gold_Type ) return String;
   function Null_Or_Missing( i : J1gold_Type ) return Boolean;
   function Convert_J1gold_Type( i : String ) return J1gold_Type;


   type J1mngr_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      manager,
      foreman_or_supervis,
      not_mnger_or_superv );

   function Pretty_Print( i : J1mngr_Type ) return String;
   function Null_Or_Missing( i : J1mngr_Type ) return Boolean;
   function Convert_J1mngr_Type( i : String ) return J1mngr_Type;


   type J1none_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      still_in_ft_edn,
      never_had_job );

   function Pretty_Print( i : J1none_Type ) return String;
   function Null_Or_Missing( i : J1none_Type ) return Boolean;
   function Convert_J1none_Type( i : String ) return J1none_Type;


   type J1rgsc_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      professional_occ,
      managerial_and_technic,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : J1rgsc_Type ) return String;
   function Null_Or_Missing( i : J1rgsc_Type ) return Boolean;
   function Convert_J1rgsc_Type( i : String ) return J1rgsc_Type;


   type J1sec_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_and_or_phone,
      inapplicable,
      missing,
      employers_large_org,
      lwr_supervis_occups,
      lwr_technical_craft,
      lwr_tech_process_op,
      semi_routine_sales,
      semi_routine_service,
      semi_routine_tech,
      semi_routine_op,
      semi_routine_agric,
      semi_routine_cleri,
      semi_rtne_childcare,
      routine_sales_and_serv,
      routine_production,
      routine_technical,
      routine_operative,
      routine_agricultrl,
      higher_managerial,
      higher_prof_tradnl,
      higher_prof_new_emp,
      high_prof_trad_semp,
      high_prof_new_semp,
      lower_prof_trad_emps,
      lower_prof_new_emps,
      lwr_prof_trad_semp,
      lower_prof_new_semp,
      lower_manag_occupns,
      hgher_supervis_occup,
      intrmd_cleri_and_admin,
      intermd_sales_and_serv,
      intermed_techn_and_aux,
      intermed_engineering,
      emp_small_non_prof,
      emp_small_agricult,
      own_acct_wkrsnpro,
      own_acct_wkrsagric );

   function Pretty_Print( i : J1sec_Type ) return String;
   function Null_Or_Missing( i : J1sec_Type ) return Boolean;
   function Convert_J1sec_Type( i : String ) return J1sec_Type;


   type J1seg_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      employers_large,
      personal_service_wrk,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual,
      unskilled_manual_wkr,
      own_account_wkrs,
      farmers_employers,
      farmers_own_accoun,
      agricultural_workers,
      members_of_armed_for,
      managers_large,
      employers_small,
      managers_small,
      professional_self_em,
      professional_employe,
      int_non_manual_work,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : J1seg_Type ) return String;
   function Null_Or_Missing( i : J1seg_Type ) return Boolean;
   function Convert_J1seg_Type( i : String ) return J1seg_Type;


   type J1semp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      employee,
      self_employed );

   function Pretty_Print( i : J1semp_Type ) return String;
   function Null_Or_Missing( i : J1semp_Type ) return Boolean;
   function Convert_J1semp_Type( i : String ) return J1semp_Type;


   type J1soc00_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : J1soc00_Type ) return String;
   function Null_Or_Missing( i : J1soc00_Type ) return Boolean;
   function Convert_J1soc00_Type( i : String ) return J1soc00_Type;


   type J2hrs_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_97_hours_or_more );

   function Pretty_Print( i : J2hrs_Type ) return String;
   function Null_Or_Missing( i : J2hrs_Type ) return Boolean;
   function Convert_J2hrs_Type( i : String ) return J2hrs_Type;


   type J2payi_Type is (  
      var_dont_know,
      var_refused,
      blank,
      var_proxy_resp,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed );

   function Pretty_Print( i : J2payi_Type ) return String;
   function Null_Or_Missing( i : J2payi_Type ) return Boolean;
   function Convert_J2payi_Type( i : String ) return J2payi_Type;


   type J2semp_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      employee,
      self_employed );

   function Pretty_Print( i : J2semp_Type ) return String;
   function Null_Or_Missing( i : J2semp_Type ) return Boolean;
   function Convert_J2semp_Type( i : String ) return J2semp_Type;


   type J2soc_Type is (  
      not_answered,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : J2soc_Type ) return String;
   function Null_Or_Missing( i : J2soc_Type ) return Boolean;
   function Convert_J2soc_Type( i : String ) return J2soc_Type;


   type Jbasp1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      promotion_prospects,
      total_pay,
      good_relas_w_manager,
      job_security,
      using_initiative,
      actual_work,
      hours_worked,
      something_else );

   function Pretty_Print( i : Jbasp1_Type ) return String;
   function Null_Or_Missing( i : Jbasp1_Type ) return Boolean;
   function Convert_Jbasp1_Type( i : String ) return Jbasp1_Type;


   type Jbbgly_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_010990_or_before,
      after_010990 );

   function Pretty_Print( i : Jbbgly_Type ) return String;
   function Null_Or_Missing( i : Jbbgly_Type ) return Boolean;
   function Convert_Jbbgly_Type( i : String ) return Jbbgly_Type;


   type Jbbgly1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_01092005_or_before,
      after_01092005 );

   function Pretty_Print( i : Jbbgly1_Type ) return String;
   function Null_Or_Missing( i : Jbbgly1_Type ) return Boolean;
   function Convert_Jbbgly1_Type( i : String ) return Jbbgly1_Type;


   type Jbbgm1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Jbbgm1_Type ) return String;
   function Null_Or_Missing( i : Jbbgm1_Type ) return Boolean;
   function Convert_Jbbgm1_Type( i : String ) return Jbbgm1_Type;


   type Jbchc1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      when_chldrn_at_schl,
      friend_or_neighbour,
      other,
      after_school_club,
      look_after_themselves,
      i_work_from_home,
      spouse_or_partner,
      nanny_or_mother_help,
      workplace_nursry,
      day_nursery,
      child_minder,
      a_relative );

   function Pretty_Print( i : Jbchc1_Type ) return String;
   function Null_Or_Missing( i : Jbchc1_Type ) return Boolean;
   function Convert_Jbchc1_Type( i : String ) return Jbchc1_Type;


   type Jbchc2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      when_chldrn_at_schl,
      friend_or_neighbour,
      other,
      after_school_club,
      look_after_themselves,
      i_work_from_home,
      spouse_or_partner,
      nanny_or_mothers_help,
      workplace_nursry,
      day_nursery,
      child_minder,
      a_relative );

   function Pretty_Print( i : Jbchc2_Type ) return String;
   function Null_Or_Missing( i : Jbchc2_Type ) return Boolean;
   function Convert_Jbchc2_Type( i : String ) return Jbchc2_Type;


   type Jbchc3_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      when_chldrn_at_schl,
      friend_or_neighbour,
      other,
      after_school_club,
      look_after_themselves,
      i_work_from_home,
      spouse_or_partner,
      nanny_or_mothers_help,
      workplace_nursery,
      day_nursery,
      child_minder,
      a_relative );

   function Pretty_Print( i : Jbchc3_Type ) return String;
   function Null_Or_Missing( i : Jbchc3_Type ) return Boolean;
   function Convert_Jbchc3_Type( i : String ) return Jbchc3_Type;


   type Jbchgly_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      before_reference_date,
      after_reference_date );

   function Pretty_Print( i : Jbchgly_Type ) return String;
   function Null_Or_Missing( i : Jbchgly_Type ) return Boolean;
   function Convert_Jbchgly_Type( i : String ) return Jbchgly_Type;


   type Jbck1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      valid_soc_data,
      no_valid_soc_data,
      not_emp_or_not_int_at_prev_wave );

   function Pretty_Print( i : Jbck1_Type ) return String;
   function Null_Or_Missing( i : Jbck1_Type ) return Boolean;
   function Convert_Jbck1_Type( i : String ) return Jbck1_Type;


   type Jbck10_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      valid_sector,
      no_valid_sector,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck10_Type ) return String;
   function Null_Or_Missing( i : Jbck10_Type ) return Boolean;
   function Convert_Jbck10_Type( i : String ) return Jbck10_Type;


   type Jbck11_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      valid_workplace_size,
      no_valid_workplace_size,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck11_Type ) return String;
   function Null_Or_Missing( i : Jbck11_Type ) return Boolean;
   function Convert_Jbck11_Type( i : String ) return Jbck11_Type;


   type Jbck2_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      no_valid_soc_data,
      valid_soc_data,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck2_Type ) return String;
   function Null_Or_Missing( i : Jbck2_Type ) return Boolean;
   function Convert_Jbck2_Type( i : String ) return Jbck2_Type;


   type Jbck3_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      valid_sic_data,
      no_valid_sic_data,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck3_Type ) return String;
   function Null_Or_Missing( i : Jbck3_Type ) return Boolean;
   function Convert_Jbck3_Type( i : String ) return Jbck3_Type;


   type Jbck4_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no_valid_sic_data,
      valid_sic_data,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck4_Type ) return String;
   function Null_Or_Missing( i : Jbck4_Type ) return Boolean;
   function Convert_Jbck4_Type( i : String ) return Jbck4_Type;


   type Jbck5_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      ni_in_employment,
      valid_employer_name,
      no_valid_employer_name,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck5_Type ) return String;
   function Null_Or_Missing( i : Jbck5_Type ) return Boolean;
   function Convert_Jbck5_Type( i : String ) return Jbck5_Type;


   type Jbck6_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no_valid_employer_name,
      valid_employer_name,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck6_Type ) return String;
   function Null_Or_Missing( i : Jbck6_Type ) return Boolean;
   function Convert_Jbck6_Type( i : String ) return Jbck6_Type;


   type Jbck7_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      valid_emp_status,
      no_valid_emp_status,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck7_Type ) return String;
   function Null_Or_Missing( i : Jbck7_Type ) return Boolean;
   function Convert_Jbck7_Type( i : String ) return Jbck7_Type;


   type Jbck8_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      same_occ_and_employer,
      different_occ_or_employer,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck8_Type ) return String;
   function Null_Or_Missing( i : Jbck8_Type ) return Boolean;
   function Convert_Jbck8_Type( i : String ) return Jbck8_Type;


   type Jbck9_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      valid_managerial_duties,
      no_valid_managerial_duties,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jbck9_Type ) return String;
   function Null_Or_Missing( i : Jbck9_Type ) return Boolean;
   function Convert_Jbck9_Type( i : String ) return Jbck9_Type;


   type Jbedp2_Type is (  
      dont_know,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Jbedp2_Type ) return String;
   function Null_Or_Missing( i : Jbedp2_Type ) return Boolean;
   function Convert_Jbedp2_Type( i : String ) return Jbedp2_Type;


   type Jbft_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      full_time_30_hrs_plus,
      part_time_lt_30_hrs );

   function Pretty_Print( i : Jbft_Type ) return String;
   function Null_Or_Missing( i : Jbft_Type ) return Boolean;
   function Convert_Jbft_Type( i : String ) return Jbft_Type;


   type Jbgold_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      service_class_higher_grade,
      semi_unskilled_manual_workers,
      agricultural_workers,
      inadequately_described_non_stated,
      service_class_lower_grade,
      routine_non_manual_employees,
      personal_service_workers,
      sml_props_w_employees,
      sml_props_w_or_o_employees,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_workers );

   function Pretty_Print( i : Jbgold_Type ) return String;
   function Null_Or_Missing( i : Jbgold_Type ) return Boolean;
   function Convert_Jbgold_Type( i : String ) return Jbgold_Type;


   type Jbhh_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      young_children,
      family_obligs,
      older_children,
      divorce_or_separ,
      ill_health,
      child_caring,
      financial,
      family_business,
      spouse_or_partner,
      parents,
      other_relatives,
      genl_family_care,
      non_relatives,
      pregnancy,
      other );

   function Pretty_Print( i : Jbhh_Type ) return String;
   function Null_Or_Missing( i : Jbhh_Type ) return Boolean;
   function Convert_Jbhh_Type( i : String ) return Jbhh_Type;


   type Jbhrbg_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_97_or_more );

   function Pretty_Print( i : Jbhrbg_Type ) return String;
   function Null_Or_Missing( i : Jbhrbg_Type ) return Boolean;
   function Convert_Jbhrbg_Type( i : String ) return Jbhrbg_Type;


   type Jbhrlk_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      work_fewer_hours,
      work_more_hours,
      contin_same_hrs );

   function Pretty_Print( i : Jbhrlk_Type ) return String;
   function Null_Or_Missing( i : Jbhrlk_Type ) return Boolean;
   function Convert_Jbhrlk_Type( i : String ) return Jbhrlk_Type;


   type Jbhrly_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_97_or_above );

   function Pretty_Print( i : Jbhrly_Type ) return String;
   function Null_Or_Missing( i : Jbhrly_Type ) return Boolean;
   function Convert_Jbhrly_Type( i : String ) return Jbhrly_Type;


   type Jbhrs_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_applicable,
      s_97_or_above );

   function Pretty_Print( i : Jbhrs_Type ) return String;
   function Null_Or_Missing( i : Jbhrs_Type ) return Boolean;
   function Convert_Jbhrs_Type( i : String ) return Jbhrs_Type;


   type Jblkcha_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      doesnt_apply );

   function Pretty_Print( i : Jblkcha_Type ) return String;
   function Null_Or_Missing( i : Jblkcha_Type ) return Boolean;
   function Convert_Jblkcha_Type( i : String ) return Jblkcha_Type;


   type Jblky_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      more_or_bettr_money,
      more_flex_hrs,
      health_reasons,
      to_use_skills,
      less_dmandng_wrk,
      prefer_this_job,
      new_job_better,
      promot_prospects,
      more_responsibl,
      job_security,
      more_interes_job,
      to_be_own_boss,
      grter_initiative,
      less_commuting,
      less_hours,
      other );

   function Pretty_Print( i : Jblky_Type ) return String;
   function Null_Or_Missing( i : Jblky_Type ) return Boolean;
   function Convert_Jblky_Type( i : String ) return Jblky_Type;


   type Jblky1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      working_is_normal,
      essential_foods_etc,
      money_for_extras,
      earn_money_for_self,
      peoples_company,
      enjoy_working,
      follow_my_career,
      other_reason );

   function Pretty_Print( i : Jblky1_Type ) return String;
   function Null_Or_Missing( i : Jblky1_Type ) return Boolean;
   function Convert_Jblky1_Type( i : String ) return Jblky1_Type;


   type Jbmix_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      almost_excl_men,
      mainly_by_men,
      equal_men_or_women,
      mainly_by_women,
      almost_excl_women );

   function Pretty_Print( i : Jbmix_Type ) return String;
   function Null_Or_Missing( i : Jbmix_Type ) return Boolean;
   function Convert_Jbmix_Type( i : String ) return Jbmix_Type;


   type Jbmngr_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      manager,
      foreman_or_supervisor,
      not_mnger_or_supervisor );

   function Pretty_Print( i : Jbmngr_Type ) return String;
   function Null_Or_Missing( i : Jbmngr_Type ) return Boolean;
   function Convert_Jbmngr_Type( i : String ) return Jbmngr_Type;


   type Jbmrs_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      ab,
      c1,
      c2,
      blank,
      ni_not_applicable );

   function Pretty_Print( i : Jbmrs_Type ) return String;
   function Null_Or_Missing( i : Jbmrs_Type ) return Boolean;
   function Convert_Jbmrs_Type( i : String ) return Jbmrs_Type;


   type Jboff_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      waiting_for_job );

   function Pretty_Print( i : Jboff_Type ) return String;
   function Null_Or_Missing( i : Jboff_Type ) return Boolean;
   function Convert_Jboff_Type( i : String ) return Jboff_Type;


   type Jboffy_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      maternity_leave,
      other_leave_or_holiday,
      sick_or_injured,
      training_course,
      laid_off_or_short_time,
      on_strike,
      pers_or_family_reasons,
      other_reasons );

   function Pretty_Print( i : Jboffy_Type ) return String;
   function Null_Or_Missing( i : Jboffy_Type ) return Boolean;
   function Convert_Jboffy_Type( i : String ) return Jboffy_Type;


   type Jbong_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      before_tax,
      after_tax );

   function Pretty_Print( i : Jbong_Type ) return String;
   function Null_Or_Missing( i : Jbong_Type ) return Boolean;
   function Convert_Jbong_Type( i : String ) return Jbong_Type;


   type Jbot_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      none,
      s_97_or_above );

   function Pretty_Print( i : Jbot_Type ) return String;
   function Null_Or_Missing( i : Jbot_Type ) return Boolean;
   function Convert_Jbot_Type( i : String ) return Jbot_Type;


   type Jbotbg_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_paid_overtime,
      s_97_or_more );

   function Pretty_Print( i : Jbotbg_Type ) return String;
   function Null_Or_Missing( i : Jbotbg_Type ) return Boolean;
   function Convert_Jbotbg_Type( i : String ) return Jbotbg_Type;


   type Jbotly_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_paid_overtime,
      s_97_or_above );

   function Pretty_Print( i : Jbotly_Type ) return String;
   function Null_Or_Missing( i : Jbotly_Type ) return Boolean;
   function Convert_Jbotly_Type( i : String ) return Jbotly_Type;


   type Jbpatw_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      employer_fixes_hours,
      some_flexibility,
      jointly_decide_hours,
      decide_hours_self );

   function Pretty_Print( i : Jbpatw_Type ) return String;
   function Null_Or_Missing( i : Jbpatw_Type ) return Boolean;
   function Convert_Jbpatw_Type( i : String ) return Jbpatw_Type;


   type Jbpl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      at_home,
      employers_prems,
      driving_or_travel,
      s_1_plus_other_places,
      other );

   function Pretty_Print( i : Jbpl_Type ) return String;
   function Null_Or_Missing( i : Jbpl_Type ) return Boolean;
   function Convert_Jbpl_Type( i : String ) return Jbpl_Type;


   type Jbrgsc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      professional_occ,
      managerial_and_technical_occ,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : Jbrgsc_Type ) return String;
   function Null_Or_Missing( i : Jbrgsc_Type ) return Boolean;
   function Convert_Jbrgsc_Type( i : String ) return Jbrgsc_Type;


   type Jbsat_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      doesnt_apply,
      not_satis_at_all,
      not_satis_or_dissatis,
      completely_satis );

   function Pretty_Print( i : Jbsat_Type ) return String;
   function Null_Or_Missing( i : Jbsat_Type ) return Boolean;
   function Convert_Jbsat_Type( i : String ) return Jbsat_Type;


   type Jbsat1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      doesnt_apply,
      not_satisfied,
      not_satis_or_dissat,
      completely_satis );

   function Pretty_Print( i : Jbsat1_Type ) return String;
   function Null_Or_Missing( i : Jbsat1_Type ) return Boolean;
   function Convert_Jbsat1_Type( i : String ) return Jbsat1_Type;


   type Jbsat2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      doesnt_apply_to_resp,
      not_satis_at_all,
      not_satis_or_dissat,
      completely_satis );

   function Pretty_Print( i : Jbsat2_Type ) return String;
   function Null_Or_Missing( i : Jbsat2_Type ) return Boolean;
   function Convert_Jbsat2_Type( i : String ) return Jbsat2_Type;


   type Jbsat4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      doesnt_apply,
      not_satis_at_all,
      not_satis_or_dissat,
      completely_satis );

   function Pretty_Print( i : Jbsat4_Type ) return String;
   function Null_Or_Missing( i : Jbsat4_Type ) return Boolean;
   function Convert_Jbsat4_Type( i : String ) return Jbsat4_Type;


   type Jbsec_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      employers_large_org,
      lwr_supervis_occups,
      lwr_technical_craft,
      lwr_tech_process_op,
      semi_routine_sales,
      semi_routine_service,
      semi_routine_tech,
      semi_routine_op,
      semi_routine_agric,
      semi_routine_cleri,
      semi_rtne_childcare,
      routine_sales_and_serv,
      routine_production,
      routine_technical,
      routine_operative,
      routine_agricultrl,
      higher_managerial,
      higher_prof_tradnl,
      higher_prof_new_emp,
      high_prof_trad_semp,
      high_prof_new_semp,
      lower_prof_trad_emps,
      lower_prof_new_emps,
      lwr_prof_trad_semp,
      lower_prof_new_semp,
      lower_manag_occupns,
      hgher_supervis_occup,
      intrmd_cleri_and_admin,
      intermd_sales_and_serv,
      intermed_techn_and_aux,
      intermed_engineering,
      emp_small_non_prof,
      emp_small_agricult,
      own_acct_wkrsnpro,
      own_acct_wkrsagric );

   function Pretty_Print( i : Jbsec_Type ) return String;
   function Null_Or_Missing( i : Jbsec_Type ) return Boolean;
   function Convert_Jbsec_Type( i : String ) return Jbsec_Type;


   type Jbsect_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      private_firm_or_company,
      civil_srv_or_cntrl_govt,
      local_govt_or_town_hall,
      nhs_or_higher_educ,
      natnalised_industry,
      non_profit_orgs,
      armed_forces,
      other );

   function Pretty_Print( i : Jbsect_Type ) return String;
   function Null_Or_Missing( i : Jbsect_Type ) return Boolean;
   function Convert_Jbsect_Type( i : String ) return Jbsect_Type;


   type Jbseg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      employers_large,
      personal_service_wrkrs,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual_wkrs,
      unskilled_manual_wkrs,
      own_account_wkrs,
      farmers_employers_managers,
      farmers_own_account,
      agricultural_workers,
      members_of_armed_forces,
      managers_large,
      inadequately_described_non_stated,
      employers_small,
      managers_small,
      professional_self_employed,
      professional_employees,
      int_non_manual_workers,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : Jbseg_Type ) return String;
   function Null_Or_Missing( i : Jbseg_Type ) return Boolean;
   function Convert_Jbseg_Type( i : String ) return Jbseg_Type;


   type Jbsemp_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      employee,
      self_employed );

   function Pretty_Print( i : Jbsemp_Type ) return String;
   function Null_Or_Missing( i : Jbsemp_Type ) return Boolean;
   function Convert_Jbsemp_Type( i : String ) return Jbsemp_Type;


   type Jbsempp_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_employee,
      yes_self_employed,
      no );

   function Pretty_Print( i : Jbsempp_Type ) return String;
   function Null_Or_Missing( i : Jbsempp_Type ) return Boolean;
   function Convert_Jbsempp_Type( i : String ) return Jbsempp_Type;


   type Jbsize_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1_2,
      dk_or_less_than_25,
      dk_or_25_or_more,
      s_3_9,
      s_10_24,
      s_25_49,
      s_50_99,
      s_100_199,
      s_200_499,
      s_500_999,
      s_1000_or_more );

   function Pretty_Print( i : Jbsize_Type ) return String;
   function Null_Or_Missing( i : Jbsize_Type ) return Boolean;
   function Convert_Jbsize_Type( i : String ) return Jbsize_Type;


   type Jbsoc_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Jbsoc_Type ) return String;
   function Null_Or_Missing( i : Jbsoc_Type ) return Boolean;
   function Convert_Jbsoc_Type( i : String ) return Jbsoc_Type;


   type Jbstat_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      self_employed,
      something_else,
      in_paid_employ,
      unemployed,
      retired,
      family_care,
      ft_student,
      long_term_sick_or_disabled,
      on_matern_leave,
      govt_trng_scheme );

   function Pretty_Print( i : Jbstat_Type ) return String;
   function Null_Or_Missing( i : Jbstat_Type ) return Boolean;
   function Convert_Jbstat_Type( i : String ) return Jbstat_Type;


   type Jbstrna_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      never,
      occasionally,
      some_of_the_time,
      much_of_the_time,
      most_of_the_time,
      all_of_the_time );

   function Pretty_Print( i : Jbstrna_Type ) return String;
   function Null_Or_Missing( i : Jbstrna_Type ) return Boolean;
   function Convert_Jbstrna_Type( i : String ) return Jbstrna_Type;


   type Jbterm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      permanent_job,
      seasonal_or_tmp_job,
      contract_or_fixed_time );

   function Pretty_Print( i : Jbterm_Type ) return String;
   function Null_Or_Missing( i : Jbterm_Type ) return Boolean;
   function Convert_Jbterm_Type( i : String ) return Jbterm_Type;


   type Jbterm1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      permanent_job,
      not_permanent_job );

   function Pretty_Print( i : Jbterm1_Type ) return String;
   function Null_Or_Missing( i : Jbterm1_Type ) return Boolean;
   function Convert_Jbterm1_Type( i : String ) return Jbterm1_Type;


   type Jbterm2_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      seasonal_work,
      fixed_term_contract,
      agency_temping,
      casual,
      other );

   function Pretty_Print( i : Jbterm2_Type ) return String;
   function Null_Or_Missing( i : Jbterm2_Type ) return Boolean;
   function Convert_Jbterm2_Type( i : String ) return Jbterm2_Type;


   type Jbtime_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      mornings_only,
      other,
      daytime_and_evenings,
      afternoons_only,
      during_the_day,
      evenings_only,
      at_night,
      both_lunch_or_eves,
      other_times_or_day,
      rotating_shifts,
      varies_or_no_pattern );

   function Pretty_Print( i : Jbtime_Type ) return String;
   function Null_Or_Missing( i : Jbtime_Type ) return Boolean;
   function Convert_Jbtime_Type( i : String ) return Jbtime_Type;


   type Jbttwm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      brit_rail_or_train,
      underground_or_tube,
      bus_or_coach,
      moto_cycle_or_moped,
      car_or_van,
      car_or_van_passenger,
      pedal_cycle,
      walks_all_way,
      other );

   function Pretty_Print( i : Jbttwm_Type ) return String;
   function Null_Or_Missing( i : Jbttwm_Type ) return Boolean;
   function Convert_Jbttwm_Type( i : String ) return Jbttwm_Type;


   type Jbttwt_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_997_or_more );

   function Pretty_Print( i : Jbttwt_Type ) return String;
   function Null_Or_Missing( i : Jbttwt_Type ) return Boolean;
   function Convert_Jbttwt_Type( i : String ) return Jbttwt_Type;


   type Jbuby_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      claim_unemploym,
      claim_income_supp,
      obtain_ni_contrib );

   function Pretty_Print( i : Jbuby_Type ) return String;
   function Null_Or_Missing( i : Jbuby_Type ) return Boolean;
   function Convert_Jbuby_Type( i : String ) return Jbuby_Type;


   type Jbwkhrh_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      yes );

   function Pretty_Print( i : Jbwkhrh_Type ) return String;
   function Null_Or_Missing( i : Jbwkhrh_Type ) return Boolean;
   function Convert_Jbwkhrh_Type( i : String ) return Jbwkhrh_Type;


   type Jbwkpat_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      same_hours_each_day,
      rotating_shifts,
      no_fixed_pattern );

   function Pretty_Print( i : Jbwkpat_Type ) return String;
   function Null_Or_Missing( i : Jbwkpat_Type ) return Boolean;
   function Convert_Jbwkpat_Type( i : String ) return Jbwkpat_Type;


   type Jcegold_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      service_class_higher,
      semi_unskilled_manua,
      agricultural_workers,
      service_class_lower,
      routine_non_manual_e,
      personal_service_wor,
      sml_props_w_employee,
      sml_props_w_or_o_employ,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_worke );

   function Pretty_Print( i : Jcegold_Type ) return String;
   function Null_Or_Missing( i : Jcegold_Type ) return Boolean;
   function Convert_Jcegold_Type( i : String ) return Jcegold_Type;


   type Jcergsc_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      professional_occ,
      managerial_and_technic,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : Jcergsc_Type ) return String;
   function Null_Or_Missing( i : Jcergsc_Type ) return Boolean;
   function Convert_Jcergsc_Type( i : String ) return Jcergsc_Type;


   type Jcesec_Type is (  
      inapplicable,
      missing,
      employers_large_org,
      lwr_supervis_occups,
      lwr_technical_craft,
      lwr_tech_process_op,
      semi_routine_sales,
      semi_routine_service,
      semi_routine_tech,
      semi_routine_op,
      semi_routine_agric,
      semi_routine_cleri,
      semi_rtne_childcare,
      routine_sales_and_serv,
      routine_production,
      routine_technical,
      routine_operative,
      routine_agricultrl,
      higher_managerial,
      higher_prof_tradnl,
      higher_prof_new_emp,
      high_prof_trad_semp,
      high_prof_new_semp,
      lower_prof_trad_emps,
      lower_prof_new_emps,
      lwr_prof_trad_semp,
      lower_prof_new_semp,
      lower_manag_occupns,
      hgher_supervis_occup,
      intrmd_cleri_and_admin,
      intermd_sales_and_serv,
      intermed_techn_and_aux,
      intermed_engineering,
      emp_small_non_prof,
      emp_small_agricult,
      own_acct_wkrsnpro,
      own_acct_wkrsagric );

   function Pretty_Print( i : Jcesec_Type ) return String;
   function Null_Or_Missing( i : Jcesec_Type ) return Boolean;
   function Convert_Jcesec_Type( i : String ) return Jcesec_Type;


   type Jceseg_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      personal_service_wrk,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual,
      unskilled_manual_wkr,
      own_account_wkrs,
      farmers_employers,
      farmers_own_accoun,
      agricultural_workers,
      members_of_armed_for,
      managers_large,
      employers_small,
      managers_small,
      professional_self_em,
      professional_employe,
      int_non_manual_work,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : Jceseg_Type ) return String;
   function Null_Or_Missing( i : Jceseg_Type ) return Boolean;
   function Convert_Jceseg_Type( i : String ) return Jceseg_Type;


   type Jcesemp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      self_employed,
      ft_employee,
      pt_employee );

   function Pretty_Print( i : Jcesemp_Type ) return String;
   function Null_Or_Missing( i : Jcesemp_Type ) return Boolean;
   function Convert_Jcesemp_Type( i : String ) return Jcesemp_Type;


   type Jha9ly_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      sept_1990_or_before,
      after_sept_1990 );

   function Pretty_Print( i : Jha9ly_Type ) return String;
   function Null_Or_Missing( i : Jha9ly_Type ) return Boolean;
   function Convert_Jha9ly_Type( i : String ) return Jha9ly_Type;


   type Jhbgy4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Jhbgy4_Type ) return String;
   function Null_Or_Missing( i : Jhbgy4_Type ) return Boolean;
   function Convert_Jhbgy4_Type( i : String ) return Jhbgy4_Type;


   type Jhcjs_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild,
      not_ended,
      no );

   function Pretty_Print( i : Jhcjs_Type ) return String;
   function Null_Or_Missing( i : Jhcjs_Type ) return Boolean;
   function Convert_Jhcjs_Type( i : String ) return Jhcjs_Type;


   type Jhck1_Type is (  
      inapplicable,
      missing_or_wild,
      prev_employment,
      prev_non_employment,
      current_status );

   function Pretty_Print( i : Jhck1_Type ) return String;
   function Null_Or_Missing( i : Jhck1_Type ) return Boolean;
   function Convert_Jhck1_Type( i : String ) return Jhck1_Type;


   type Jhck2_Type is (  
      inapplicable,
      missing_or_wild,
      j28_required,
      end_job_history );

   function Pretty_Print( i : Jhck2_Type ) return String;
   function Null_Or_Missing( i : Jhck2_Type ) return Boolean;
   function Convert_Jhck2_Type( i : String ) return Jhck2_Type;


   type Jhendy_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Jhendy_Type ) return String;
   function Null_Or_Missing( i : Jhendy_Type ) return Boolean;
   function Convert_Jhendy_Type( i : String ) return Jhendy_Type;


   type Jhepflg_Type is (  
      not_applicable,
      missing_or_wild,
      end_after_1996,
      end_on_or_bef_1996 );

   function Pretty_Print( i : Jhepflg_Type ) return String;
   function Null_Or_Missing( i : Jhepflg_Type ) return Boolean;
   function Convert_Jhepflg_Type( i : String ) return Jhepflg_Type;


   type Jhgold_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      service_class_higher_grade,
      semi_unskilled_manual_workers,
      agricultural_workers,
      inadequately_described_non_stated,
      service_class_lower_grade,
      routine_non_manual_employees,
      personal_service_workers,
      sml_props_w_employees,
      sml_props_w_or_o_employees,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_workers );

   function Pretty_Print( i : Jhgold_Type ) return String;
   function Null_Or_Missing( i : Jhgold_Type ) return Boolean;
   function Convert_Jhgold_Type( i : String ) return Jhgold_Type;


   type Jhgpayi_Type is (  
      proxy_and_or_phone,
      var_inapplicable,
      not_imputed,
      imputed );

   function Pretty_Print( i : Jhgpayi_Type ) return String;
   function Null_Or_Missing( i : Jhgpayi_Type ) return Boolean;
   function Convert_Jhgpayi_Type( i : String ) return Jhgpayi_Type;


   type Jhlwai_Type is (  
      missing_or_wild,
      derived_from_last_wave,
      no_response_last_wave,
      new_spell );

   function Pretty_Print( i : Jhlwai_Type ) return String;
   function Null_Or_Missing( i : Jhlwai_Type ) return Boolean;
   function Convert_Jhlwai_Type( i : String ) return Jhlwai_Type;


   type Jhmngr_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      manager,
      foreman_or_superv,
      not_mngr_or_superv );

   function Pretty_Print( i : Jhmngr_Type ) return String;
   function Null_Or_Missing( i : Jhmngr_Type ) return Boolean;
   function Convert_Jhmngr_Type( i : String ) return Jhmngr_Type;


   type Jhpayl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_9997_or_above );

   function Pretty_Print( i : Jhpayl_Type ) return String;
   function Null_Or_Missing( i : Jhpayl_Type ) return Boolean;
   function Convert_Jhpayl_Type( i : String ) return Jhpayl_Type;


   type Jhpays_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      s_99997_or_above );

   function Pretty_Print( i : Jhpays_Type ) return String;
   function Null_Or_Missing( i : Jhpays_Type ) return Boolean;
   function Convert_Jhpays_Type( i : String ) return Jhpays_Type;


   type Jhpldf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      same_workplace,
      diff_workplace );

   function Pretty_Print( i : Jhpldf_Type ) return String;
   function Null_Or_Missing( i : Jhpldf_Type ) return Boolean;
   function Convert_Jhpldf_Type( i : String ) return Jhpldf_Type;


   type Jhpylg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      before_deductions,
      after_deductions,
      no_deductions );

   function Pretty_Print( i : Jhpylg_Type ) return String;
   function Null_Or_Missing( i : Jhpylg_Type ) return Boolean;
   function Convert_Jhpylg_Type( i : String ) return Jhpylg_Type;


   type Jhpylw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      per_hour,
      one_off_payment,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Jhpylw_Type ) return String;
   function Null_Or_Missing( i : Jhpylw_Type ) return Boolean;
   function Convert_Jhpylw_Type( i : String ) return Jhpylw_Type;


   type Jhpysg_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      before_deductions,
      after_deductions,
      no_deductions );

   function Pretty_Print( i : Jhpysg_Type ) return String;
   function Null_Or_Missing( i : Jhpysg_Type ) return Boolean;
   function Convert_Jhpysg_Type( i : String ) return Jhpysg_Type;


   type Jhpysw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Jhpysw_Type ) return String;
   function Null_Or_Missing( i : Jhpysw_Type ) return Boolean;
   function Convert_Jhpysw_Type( i : String ) return Jhpysw_Type;


   type Jhrgsc_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      professional_occ,
      managerial_and_technical_occ,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : Jhrgsc_Type ) return String;
   function Null_Or_Missing( i : Jhrgsc_Type ) return Boolean;
   function Convert_Jhrgsc_Type( i : String ) return Jhrgsc_Type;


   type Jhsec_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing,
      employers_large_org,
      lwr_supervis_occups,
      lwr_technical_craft,
      lwr_tech_process_op,
      semi_routine_sales,
      semi_routine_service,
      semi_routine_tech,
      semi_routine_op,
      semi_routine_agric,
      semi_routine_cleri,
      semi_rtne_childcare,
      routine_sales_and_serv,
      routine_production,
      routine_technical,
      routine_operative,
      routine_agricultrl,
      higher_managerial,
      higher_prof_tradnl,
      higher_prof_new_emp,
      high_prof_trad_semp,
      high_prof_new_semp,
      lower_prof_trad_emps,
      lower_prof_new_emps,
      lwr_prof_trad_semp,
      lower_prof_new_semp,
      lower_manag_occupns,
      hgher_supervis_occup,
      intrmd_cleri_and_admin,
      intermd_sales_and_serv,
      intermed_techn_and_aux,
      intermed_engineering,
      emp_small_non_prof,
      emp_small_agricult,
      own_acct_wkrsnpro,
      own_acct_wkrsagric );

   function Pretty_Print( i : Jhsec_Type ) return String;
   function Null_Or_Missing( i : Jhsec_Type ) return Boolean;
   function Convert_Jhsec_Type( i : String ) return Jhsec_Type;


   type Jhsect_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      priv_firm_or_compy,
      civ_serv_or_cnt_gvt,
      loc_gvt_or_twn_hall,
      nhs_or_higher_educ,
      natlised_indtry,
      non_profit_orgs,
      armed_forces,
      other );

   function Pretty_Print( i : Jhsect_Type ) return String;
   function Null_Or_Missing( i : Jhsect_Type ) return Boolean;
   function Convert_Jhsect_Type( i : String ) return Jhsect_Type;


   type Jhseg_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      employers_large,
      personal_service_wrkrs,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual_wkrs,
      unskilled_manual_wkrs,
      own_account_wkrs,
      farmers_employers_managers,
      farmers_own_account,
      agricultural_workers,
      members_of_armed_forces,
      managers_large,
      inadequately_described_non_stated,
      employers_small,
      managers_small,
      professional_self_employed,
      professional_employees,
      int_non_manual_workers,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : Jhseg_Type ) return String;
   function Null_Or_Missing( i : Jhseg_Type ) return Boolean;
   function Convert_Jhseg_Type( i : String ) return Jhseg_Type;


   type Jhsemp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      employee,
      self_employed );

   function Pretty_Print( i : Jhsemp_Type ) return String;
   function Null_Or_Missing( i : Jhsemp_Type ) return Boolean;
   function Convert_Jhsemp_Type( i : String ) return Jhsemp_Type;


   type Jhsize_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_1_2,
      dk_or_under_25,
      dk_or_25_plus,
      s_3_9,
      s_10_24,
      s_25_49,
      s_50_99,
      s_100_199,
      s_200_499,
      s_500_999,
      s_1000_or_more );

   function Pretty_Print( i : Jhsize_Type ) return String;
   function Null_Or_Missing( i : Jhsize_Type ) return Boolean;
   function Convert_Jhsize_Type( i : String ) return Jhsize_Type;


   type Jhstat_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      diff_job_same_emplyer,
      something_else,
      empl_self_or_diff_emply,
      unemp_or_job_seeking,
      retd_from_pd_emplymt,
      looking_after_family,
      f_t_education,
      lng_trm_sick_or_disabld,
      on_maternity_leave,
      on_govt_trng_scheme );

   function Pretty_Print( i : Jhstat_Type ) return String;
   function Null_Or_Missing( i : Jhstat_Type ) return Boolean;
   function Convert_Jhstat_Type( i : String ) return Jhstat_Type;


   type Jhstpy_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      promoted,
      care_of_other_person,
      other_reason,
      moved_away,
      start_college_or_uni,
      left_for_better_job,
      made_redundant,
      dismissed_or_sacked,
      temporary_job_ended,
      took_retirement,
      stopped_health_reas,
      left_to_have_baby,
      children_or_home_care );

   function Pretty_Print( i : Jhstpy_Type ) return String;
   function Null_Or_Missing( i : Jhstpy_Type ) return Boolean;
   function Convert_Jhstpy_Type( i : String ) return Jhstpy_Type;


   type Jlcssf_Type is (  
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Jlcssf_Type ) return String;
   function Null_Or_Missing( i : Jlcssf_Type ) return Boolean;
   function Convert_Jlcssf_Type( i : String ) return Jlcssf_Type;


   type Jlgold_Type is (  
      refused,
      proxy_respondent,
      not_applicable,
      missing,
      service_class_higher_grade,
      semi_unskilled_manual_workers,
      agricultural_workers,
      inadequately_described_non_stated,
      service_class_lower_grade,
      routine_non_manual_employees,
      personal_service_workers,
      sml_props_w_employees,
      sml_props_w_or_o_employees,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_workers );

   function Pretty_Print( i : Jlgold_Type ) return String;
   function Null_Or_Missing( i : Jlgold_Type ) return Boolean;
   function Convert_Jlgold_Type( i : String ) return Jlgold_Type;


   type Jlid_Type is (  
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing,
      current_job,
      job_spell_1,
      last_job_j93,
      see_ajlid,
      see_bjlid,
      see_cjlid,
      see_djlid,
      see_ejlid,
      see_fjlid,
      see_gjlid,
      job_spell_2,
      see_hjlid,
      see_ijlid,
      see_jjlid,
      see_kjlid,
      see_ljlid,
      see_mjlid,
      see_njlid,
      see_ojlid,
      see_pjlid,
      see_qjlid,
      job_spell_3,
      job_spell_4,
      job_spell_5,
      job_spell_6,
      job_spell_7 );

   function Pretty_Print( i : Jlid_Type ) return String;
   function Null_Or_Missing( i : Jlid_Type ) return Boolean;
   function Convert_Jlid_Type( i : String ) return Jlid_Type;


   type Jlmngr_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      manager,
      foreman_or_supervisor,
      not_mngr_or_supervisor );

   function Pretty_Print( i : Jlmngr_Type ) return String;
   function Null_Or_Missing( i : Jlmngr_Type ) return Boolean;
   function Convert_Jlmngr_Type( i : String ) return Jlmngr_Type;


   type Jlrgsc_Type is (  
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      professional_occ,
      managerial_and_technical_occ,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : Jlrgsc_Type ) return String;
   function Null_Or_Missing( i : Jlrgsc_Type ) return Boolean;
   function Convert_Jlrgsc_Type( i : String ) return Jlrgsc_Type;


   type Jlsec_Type is (  
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      employers_large_org,
      lwr_supervis_occups,
      lwr_technical_craft,
      lwr_tech_process_op,
      semi_routine_sales,
      semi_routine_service,
      semi_routine_tech,
      semi_routine_op,
      semi_routine_agric,
      semi_routine_cleri,
      semi_rtne_childcare,
      routine_sales_and_serv,
      routine_production,
      routine_technical,
      routine_operative,
      routine_agricultrl,
      higher_managerial,
      higher_prof_tradnl,
      higher_prof_new_emp,
      high_prof_trad_semp,
      high_prof_new_semp,
      lower_prof_trad_emps,
      lower_prof_new_emps,
      lwr_prof_trad_semp,
      lower_prof_new_semp,
      lower_manag_occupns,
      hgher_supervis_occup,
      intrmd_cleri_and_admin,
      intermd_sales_and_serv,
      intermed_techn_and_aux,
      intermed_engineering,
      emp_small_non_prof,
      emp_small_agricult,
      own_acct_wkrsnpro,
      own_acct_wkrsagric );

   function Pretty_Print( i : Jlsec_Type ) return String;
   function Null_Or_Missing( i : Jlsec_Type ) return Boolean;
   function Convert_Jlsec_Type( i : String ) return Jlsec_Type;


   type Jlseg_Type is (  
      refused,
      proxy_respondent,
      not_applicable,
      missing,
      employers_large,
      personal_service_wrkrs,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual_wkrs,
      unskilled_manual_wkrs,
      own_account_wkrs,
      farmers_employers_managers,
      farmers_own_account,
      agricultural_workers,
      members_of_armed_forces,
      managers_large,
      inadequately_described_non_stated,
      employers_small,
      managers_small,
      professional_self_employed,
      professional_employees,
      int_non_manual_workers,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : Jlseg_Type ) return String;
   function Null_Or_Missing( i : Jlseg_Type ) return Boolean;
   function Convert_Jlseg_Type( i : String ) return Jlseg_Type;


   type Jlsize_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1_2,
      dk_but_under_25,
      dk_but_25_plus,
      s_3_9,
      s_10_24,
      s_25_49,
      s_50_99,
      s_100_199,
      s_200_499,
      s_500_999,
      s_1000_or_more );

   function Pretty_Print( i : Jlsize_Type ) return String;
   function Null_Or_Missing( i : Jlsize_Type ) return Boolean;
   function Convert_Jlsize_Type( i : String ) return Jlsize_Type;


   type Jlyid_Type is (  
      proxy_respondent,
      proxy,
      missing,
      current_job,
      job_spell_1,
      job_spell_9,
      job_spell_2,
      job_spell_3,
      job_spell_4,
      job_spell_5,
      job_spell_6,
      job_spell_7,
      job_spell_8 );

   function Pretty_Print( i : Jlyid_Type ) return String;
   function Null_Or_Missing( i : Jlyid_Type ) return Boolean;
   function Convert_Jlyid_Type( i : String ) return Jlyid_Type;


   type Jsaccs_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      not_yet_but_will_be );

   function Pretty_Print( i : Jsaccs_Type ) return String;
   function Null_Or_Missing( i : Jsaccs_Type ) return Boolean;
   function Convert_Jsaccs_Type( i : String ) return Jsaccs_Type;


   type Jsbgly_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      before_reference_date,
      on_or_after_reference_date );

   function Pretty_Print( i : Jsbgly_Type ) return String;
   function Null_Or_Missing( i : Jsbgly_Type ) return Boolean;
   function Convert_Jsbgly_Type( i : String ) return Jsbgly_Type;


   type Jsbgly1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      before_reference_date,
      on_or_after_reference_date );

   function Pretty_Print( i : Jsbgly1_Type ) return String;
   function Null_Or_Missing( i : Jsbgly1_Type ) return Boolean;
   function Convert_Jsbgly1_Type( i : String ) return Jsbgly1_Type;


   type Jsboss_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_has_employees,
      no_no_employees );

   function Pretty_Print( i : Jsboss_Type ) return String;
   function Null_Or_Missing( i : Jsboss_Type ) return Boolean;
   function Convert_Jsboss_Type( i : String ) return Jsboss_Type;


   type Jsck1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      same_occupation,
      not_same_occupation,
      not_int_or_empld_previous_wave );

   function Pretty_Print( i : Jsck1_Type ) return String;
   function Null_Or_Missing( i : Jsck1_Type ) return Boolean;
   function Convert_Jsck1_Type( i : String ) return Jsck1_Type;


   type Jsloss_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Jsloss_Type ) return String;
   function Null_Or_Missing( i : Jsloss_Type ) return Boolean;
   function Convert_Jsloss_Type( i : String ) return Jsloss_Type;


   type Jspart_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      own_account_sole_owner,
      in_partnership );

   function Pretty_Print( i : Jspart_Type ) return String;
   function Null_Or_Missing( i : Jspart_Type ) return Boolean;
   function Convert_Jspart_Type( i : String ) return Jspart_Type;


   type Jspayw_Type is (  
      dont_know,
      refused,
      hourly,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      weekly_income,
      monthly_income );

   function Pretty_Print( i : Jspayw_Type ) return String;
   function Null_Or_Missing( i : Jspayw_Type ) return Boolean;
   function Convert_Jspayw_Type( i : String ) return Jspayw_Type;


   type Jspl_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      at_home,
      from_own_home,
      sep_business_prems,
      from_van_or_stall,
      client_or_custmrs_prems,
      some_other_place );

   function Pretty_Print( i : Jspl_Type ) return String;
   function Null_Or_Missing( i : Jspl_Type ) return Boolean;
   function Convert_Jspl_Type( i : String ) return Jspl_Type;


   type Jsprby_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1986,
      s_1987,
      s_1988,
      s_1989,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996 );

   function Pretty_Print( i : Jsprby_Type ) return String;
   function Null_Or_Missing( i : Jsprby_Type ) return Boolean;
   function Convert_Jsprby_Type( i : String ) return Jsprby_Type;


   type Jsprey_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1986,
      s_1987,
      s_1988,
      s_1989,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Jsprey_Type ) return String;
   function Null_Or_Missing( i : Jsprey_Type ) return Boolean;
   function Convert_Jsprey_Type( i : String ) return Jsprey_Type;


   type Jsprey4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1989,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Jsprey4_Type ) return String;
   function Null_Or_Missing( i : Jsprey4_Type ) return Boolean;
   function Convert_Jsprey4_Type( i : String ) return Jsprey4_Type;


   type Jsprf_Type is (  
      dont_know,
      refused,
      no_profit_or_loss,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      nothing_or_loss,
      s_99997_or_above );

   function Pretty_Print( i : Jsprf_Type ) return String;
   function Null_Or_Missing( i : Jsprf_Type ) return Boolean;
   function Convert_Jsprf_Type( i : String ) return Jsprf_Type;


   type Jsprls_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      profit_or_earnings,
      loss );

   function Pretty_Print( i : Jsprls_Type ) return String;
   function Null_Or_Missing( i : Jsprls_Type ) return Boolean;
   function Convert_Jsprls_Type( i : String ) return Jsprls_Type;


   type Jsprni_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_before_ni,
      no_after_ni );

   function Pretty_Print( i : Jsprni_Type ) return String;
   function Null_Or_Missing( i : Jsprni_Type ) return Boolean;
   function Convert_Jsprni_Type( i : String ) return Jsprni_Type;


   type Jsprtx_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_before_tax,
      no_after_tax );

   function Pretty_Print( i : Jsprtx_Type ) return String;
   function Null_Or_Missing( i : Jsprtx_Type ) return Boolean;
   function Convert_Jsprtx_Type( i : String ) return Jsprtx_Type;


   type Jspyni_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_before_ni,
      no_after_ni );

   function Pretty_Print( i : Jspyni_Type ) return String;
   function Null_Or_Missing( i : Jspyni_Type ) return Boolean;
   function Convert_Jspyni_Type( i : String ) return Jspyni_Type;


   type Jspytx_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_before_tax,
      no_after_tax );

   function Pretty_Print( i : Jspytx_Type ) return String;
   function Null_Or_Missing( i : Jspytx_Type ) return Boolean;
   function Convert_Jspytx_Type( i : String ) return Jspytx_Type;


   type Jssat1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      doesnt_apply,
      not_satisf_at_all,
      not_satis_or_dissatis,
      completely_satis );

   function Pretty_Print( i : Jssat1_Type ) return String;
   function Null_Or_Missing( i : Jssat1_Type ) return Boolean;
   function Convert_Jssat1_Type( i : String ) return Jssat1_Type;


   type Jssize_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_1_2,
      dk_or_under_25,
      dk_but_25_plus,
      s_3_9,
      s_10_24,
      s_25_49,
      s_50_99,
      s_100_199,
      s_200_499,
      s_500_999,
      s_1000_or_more );

   function Pretty_Print( i : Jssize_Type ) return String;
   function Null_Or_Missing( i : Jssize_Type ) return Boolean;
   function Convert_Jssize_Type( i : String ) return Jssize_Type;


   type Jstime_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      mornings_only,
      other,
      daytime_and_evenings,
      afternoons_only,
      during_the_day,
      evenings_only,
      at_night,
      both_lunch_or_eves,
      other_times_day,
      rotating_shifts,
      varies_or_no_pattern );

   function Pretty_Print( i : Jstime_Type ) return String;
   function Null_Or_Missing( i : Jstime_Type ) return Boolean;
   function Convert_Jstime_Type( i : String ) return Jstime_Type;


   type Jsttwm_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      brit_rail_or_train,
      underground_or_tube,
      bus_or_coach,
      moto_cycle_or_moped,
      car_or_van,
      car_or_van_passenger,
      pedal_cycle,
      walks_all_way,
      other );

   function Pretty_Print( i : Jsttwm_Type ) return String;
   function Null_Or_Missing( i : Jsttwm_Type ) return Boolean;
   function Convert_Jsttwm_Type( i : String ) return Jsttwm_Type;


   type Jsttwt_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_997_or_above );

   function Pretty_Print( i : Jsttwt_Type ) return String;
   function Null_Or_Missing( i : Jsttwt_Type ) return Boolean;
   function Convert_Jsttwt_Type( i : String ) return Jsttwt_Type;


   type Jstype_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      own_busin_or_pract,
      work_for_others,
      both,
      other );

   function Pretty_Print( i : Jstype_Type ) return String;
   function Null_Or_Missing( i : Jstype_Type ) return Boolean;
   function Convert_Jstype_Type( i : String ) return Jstype_Type;


   type Jstypeb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      own_business_or_practise,
      partner_in_business_or_practice,
      working_for_self,
      sub_contractor,
      freelance,
      other );

   function Pretty_Print( i : Jstypeb_Type ) return String;
   function Null_Or_Missing( i : Jstypeb_Type ) return Boolean;
   function Convert_Jstypeb_Type( i : String ) return Jstypeb_Type;


   type Jtyid_Type is (  
      proxy_respondent,
      proxy,
      missing,
      current_job,
      job_spell_1,
      job_spell_2,
      job_spell_3,
      job_spell_4,
      job_spell_5,
      job_spell_6,
      job_spell_7 );

   function Pretty_Print( i : Jtyid_Type ) return String;
   function Null_Or_Missing( i : Jtyid_Type ) return Boolean;
   function Convert_Jtyid_Type( i : String ) return Jtyid_Type;


   type Jupayl_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_9997_or_more );

   function Pretty_Print( i : Jupayl_Type ) return String;
   function Null_Or_Missing( i : Jupayl_Type ) return Boolean;
   function Convert_Jupayl_Type( i : String ) return Jupayl_Type;


   type Juspec_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      particular,
      any_sort_or_both );

   function Pretty_Print( i : Juspec_Type ) return String;
   function Null_Or_Missing( i : Juspec_Type ) return Boolean;
   function Convert_Juspec_Type( i : String ) return Juspec_Type;


   type Kidrel_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      very_close,
      quite_close,
      not_very_close,
      not_close_at_all );

   function Pretty_Print( i : Kidrel_Type ) return String;
   function Null_Or_Missing( i : Kidrel_Type ) return Boolean;
   function Convert_Kidrel_Type( i : String ) return Kidrel_Type;


   type Kidsee_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      other_or_both_par_dead,
      never,
      a_few_times_a_year,
      once_or_month_or_less,
      several_times_or_month,
      about_once_a_week,
      several_times_or_week,
      almost_every_day,
      shared_care_50_or_50 );

   function Pretty_Print( i : Kidsee_Type ) return String;
   function Null_Or_Missing( i : Kidsee_Type ) return Boolean;
   function Convert_Kidsee_Type( i : String ) return Kidsee_Type;


   type Kivfho_Type is (  
      inapplicable,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      hh_comp_and_ques_only,
      pxy_at_original_addr,
      phone_interview_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal );

   function Pretty_Print( i : Kivfho_Type ) return String;
   function Null_Or_Missing( i : Kivfho_Type ) return Boolean;
   function Convert_Kivfho_Type( i : String ) return Kivfho_Type;


   type Lacbm_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Lacbm_Type ) return String;
   function Null_Or_Missing( i : Lacbm_Type ) return Boolean;
   function Convert_Lacbm_Type( i : String ) return Lacbm_Type;


   type Laclv_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      died );

   function Pretty_Print( i : Laclv_Type ) return String;
   function Null_Or_Missing( i : Laclv_Type ) return Boolean;
   function Convert_Laclv_Type( i : String ) return Laclv_Type;


   type Lacst_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      stepchild,
      adopted );

   function Pretty_Print( i : Lacst_Type ) return String;
   function Null_Or_Missing( i : Lacst_Type ) return Boolean;
   function Convert_Lacst_Type( i : String ) return Lacst_Type;


   type Lacsx_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      boy,
      girl );

   function Pretty_Print( i : Lacsx_Type ) return String;
   function Null_Or_Missing( i : Lacsx_Type ) return Boolean;
   function Convert_Lacsx_Type( i : String ) return Lacsx_Type;


   type Lacta_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      at_least_once_a_week,
      at_least_once_a_month,
      several_times_a_year,
      once_a_year_or_less,
      never_or_almost_never );

   function Pretty_Print( i : Lacta_Type ) return String;
   function Null_Or_Missing( i : Lacta_Type ) return Boolean;
   function Convert_Lacta_Type( i : String ) return Lacta_Type;


   type Lcastat_Type is (  
      wave_one,
      wave_ten,
      wave_eleven,
      wave_twelve,
      wave_thirteen,
      wave_fourteen,
      wave_fifteen,
      wave_sixteen,
      wave_seventeen,
      wave_eighteen,
      wave_two,
      wave_three,
      wave_four,
      wave_five,
      wave_six,
      wave_seven,
      wave_eight,
      wave_nine );

   function Pretty_Print( i : Lcastat_Type ) return String;
   function Null_Or_Missing( i : Lcastat_Type ) return Boolean;
   function Convert_Lcastat_Type( i : String ) return Lcastat_Type;


   type Lchlv_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      died,
      stillborn );

   function Pretty_Print( i : Lchlv_Type ) return String;
   function Null_Or_Missing( i : Lchlv_Type ) return Boolean;
   function Convert_Lchlv_Type( i : String ) return Lchlv_Type;


   type Lchmor_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      self_partnr_pregnant,
      no );

   function Pretty_Print( i : Lchmor_Type ) return String;
   function Null_Or_Missing( i : Lchmor_Type ) return Boolean;
   function Convert_Lchmor_Type( i : String ) return Lchmor_Type;


   type Lcmarm_Type is (  
      dont_know,
      proxy_and_or_phone,
      inapplicable,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Lcmarm_Type ) return String;
   function Null_Or_Missing( i : Lcmarm_Type ) return Boolean;
   function Convert_Lcmarm_Type( i : String ) return Lcmarm_Type;


   type Lcmary4_Type is (  
      not_answered,
      proxy_and_or_phone,
      inapplicable );

   function Pretty_Print( i : Lcmary4_Type ) return String;
   function Null_Or_Missing( i : Lcmary4_Type ) return Boolean;
   function Convert_Lcmary4_Type( i : String ) return Lcmary4_Type;


   type Lcmcbm_Type is (  
      dont_know,
      proxy_and_or_phone,
      inapplicable,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Lcmcbm_Type ) return String;
   function Null_Or_Missing( i : Lcmcbm_Type ) return Boolean;
   function Convert_Lcmcbm_Type( i : String ) return Lcmcbm_Type;


   type Lcmcoh_Type is (  
      not_answered,
      proxy_and_or_phone,
      inapplicable,
      yes,
      no );

   function Pretty_Print( i : Lcmcoh_Type ) return String;
   function Null_Or_Missing( i : Lcmcoh_Type ) return Boolean;
   function Convert_Lcmcoh_Type( i : String ) return Lcmcoh_Type;


   type Lcmspm_Type is (  
      dont_know,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Lcmspm_Type ) return String;
   function Null_Or_Missing( i : Lcmspm_Type ) return Boolean;
   function Convert_Lcmspm_Type( i : String ) return Lcmspm_Type;


   type Lcsne_Type is (  
      inapplicable,
      missing_or_wild,
      not_ended );

   function Pretty_Print( i : Lcsne_Type ) return String;
   function Null_Or_Missing( i : Lcsne_Type ) return Boolean;
   function Convert_Lcsne_Type( i : String ) return Lcsne_Type;


   type Leaver_Type is (  
      dont_know,
      refused,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Leaver_Type ) return String;
   function Null_Or_Missing( i : Leaver_Type ) return Boolean;
   function Convert_Leaver_Type( i : String ) return Leaver_Type;


   type Lednow_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      never_left,
      never_went_to_school );

   function Pretty_Print( i : Lednow_Type ) return String;
   function Null_Or_Missing( i : Lednow_Type ) return Boolean;
   function Convert_Lednow_Type( i : String ) return Lednow_Type;


   type Leikid_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      never_or_rarely,
      once_or_month_or_less,
      several_times_or_month,
      about_once_a_week,
      several_times_or_week,
      almost_every_day );

   function Pretty_Print( i : Leikid_Type ) return String;
   function Null_Or_Missing( i : Leikid_Type ) return Boolean;
   function Convert_Leikid_Type( i : String ) return Leikid_Type;


   type Leshem_Type is (  
      cant_remember,
      refused,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      winter_nov_dec,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Leshem_Type ) return String;
   function Null_Or_Missing( i : Leshem_Type ) return Boolean;
   function Convert_Leshem_Type( i : String ) return Leshem_Type;


   type Leshey_Type is (  
      cant_remember,
      refused,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Leshey_Type ) return String;
   function Null_Or_Missing( i : Leshey_Type ) return Boolean;
   function Convert_Leshey_Type( i : String ) return Leshey_Type;


   type Leshst_Type is (  
      cant_remember,
      refused,
      inapplicable,
      missing_or_wild,
      self_employed,
      gvt_trng_scheme,
      national_or_war_service,
      something_else,
      f_or_t_paid_employment,
      p_or_t_paid_employment,
      unemployed,
      retired,
      maternity_leave,
      family_care,
      ft_studt_school,
      lt_sick_disabld );

   function Pretty_Print( i : Leshst_Type ) return String;
   function Null_Or_Missing( i : Leshst_Type ) return Boolean;
   function Convert_Leshst_Type( i : String ) return Leshst_Type;


   type Leslen_Type is (  
      missing_lt_1_year,
      missing_or_wild );

   function Pretty_Print( i : Leslen_Type ) return String;
   function Null_Or_Missing( i : Leslen_Type ) return Boolean;
   function Convert_Leslen_Type( i : String ) return Leslen_Type;


   type Lewght_Type is (  
      not_answered,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Lewght_Type ) return String;
   function Null_Or_Missing( i : Lewght_Type ) return Boolean;
   function Convert_Lewght_Type( i : String ) return Lewght_Type;


   type Lfimpa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      does_not_apply_to_me,
      not_important_at_all,
      very_important );

   function Pretty_Print( i : Lfimpa_Type ) return String;
   function Null_Or_Missing( i : Lfimpa_Type ) return Boolean;
   function Convert_Lfimpa_Type( i : String ) return Lfimpa_Type;


   type Lfsat1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      doesnt_apply,
      not_satisfied_at_all,
      not_satis_or_dissat,
      completely_satisfied );

   function Pretty_Print( i : Lfsat1_Type ) return String;
   function Null_Or_Missing( i : Lfsat1_Type ) return Boolean;
   function Convert_Lfsat1_Type( i : String ) return Lfsat1_Type;


   type Lfsatl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      more_satisfied,
      les_satisfied,
      about_the_same,
      not_satis_or_dissat,
      completely_satisfied );

   function Pretty_Print( i : Lfsatl_Type ) return String;
   function Null_Or_Missing( i : Lfsatl_Type ) return Boolean;
   function Convert_Lfsatl_Type( i : String ) return Lfsatl_Type;


   type Livfho_Type is (  
      inapplicable,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      hh_comp_and_ques_only,
      pxy_at_original_addr,
      phone_interview_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal,
      l_t_untraced_wdrawn );

   function Pretty_Print( i : Livfho_Type ) return String;
   function Null_Or_Missing( i : Livfho_Type ) return Boolean;
   function Convert_Livfho_Type( i : String ) return Livfho_Type;


   type Livfio_Type is (  
      inapplicable,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_re,
      l_t_untraced_wdrawn,
      dead );

   function Pretty_Print( i : Livfio_Type ) return String;
   function Null_Or_Missing( i : Livfio_Type ) return Boolean;
   function Convert_Livfio_Type( i : String ) return Livfio_Type;


   type Ljbgm_Type is (  
      cant_remember,
      refused,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Ljbgm_Type ) return String;
   function Null_Or_Missing( i : Ljbgm_Type ) return Boolean;
   function Convert_Ljbgm_Type( i : String ) return Ljbgm_Type;


   type Ljenst_Type is (  
      missing_or_undefined,
      not_last_spell,
      last_job_ever,
      began_after_1990,
      prsnt_job_bef_1990,
      prsnt_job_aft_1990 );

   function Pretty_Print( i : Ljenst_Type ) return String;
   function Null_Or_Missing( i : Ljenst_Type ) return Boolean;
   function Convert_Ljenst_Type( i : String ) return Ljenst_Type;


   type Ljesfv_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      correct,
      partly_correct,
      not_correct );

   function Pretty_Print( i : Ljesfv_Type ) return String;
   function Null_Or_Missing( i : Ljesfv_Type ) return Boolean;
   function Convert_Ljesfv_Type( i : String ) return Ljesfv_Type;


   type Ljgold_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      service_class_higher,
      semi_unskilled_manual,
      agricultural_workers,
      service_class_lower,
      routine_non_manual,
      personal_service,
      sml_props_w_employees,
      sml_props_w_or_o_employees,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_worker );

   function Pretty_Print( i : Ljgold_Type ) return String;
   function Null_Or_Missing( i : Ljgold_Type ) return Boolean;
   function Convert_Ljgold_Type( i : String ) return Ljgold_Type;


   type Ljhad_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      not_left_ft_ed );

   function Pretty_Print( i : Ljhad_Type ) return String;
   function Null_Or_Missing( i : Ljhad_Type ) return Boolean;
   function Convert_Ljhad_Type( i : String ) return Ljhad_Type;


   type Ljlen_Type is (  
      missing_lt_1_year,
      no_final_date,
      missing );

   function Pretty_Print( i : Ljlen_Type ) return String;
   function Null_Or_Missing( i : Ljlen_Type ) return Boolean;
   function Convert_Ljlen_Type( i : String ) return Ljlen_Type;


   type Ljlftm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      spring,
      summer,
      autumn,
      winter,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Ljlftm_Type ) return String;
   function Null_Or_Missing( i : Ljlftm_Type ) return Boolean;
   function Convert_Ljlftm_Type( i : String ) return Ljlftm_Type;


   type Ljlrst_Type is (  
      proxy_and_or_phone,
      no_lifetime_history,
      missing_or_undefined,
      last_job_ever,
      began_after_1990,
      prsnt_job_bef_1990,
      prsnt_job_aft_1990 );

   function Pretty_Print( i : Ljlrst_Type ) return String;
   function Null_Or_Missing( i : Ljlrst_Type ) return Boolean;
   function Convert_Ljlrst_Type( i : String ) return Ljlrst_Type;


   type Ljnrec_Type is (  
      proxy_and_or_phone,
      no_lifetime_history );

   function Pretty_Print( i : Ljnrec_Type ) return String;
   function Null_Or_Missing( i : Ljnrec_Type ) return Boolean;
   function Convert_Ljnrec_Type( i : String ) return Ljnrec_Type;


   type Ljothj_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_not_pres_emp,
      yes_with_pres_emp,
      no );

   function Pretty_Print( i : Ljothj_Type ) return String;
   function Null_Or_Missing( i : Ljothj_Type ) return Boolean;
   function Convert_Ljothj_Type( i : String ) return Ljothj_Type;


   type Ljrgsc_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      professional_occ,
      managerial_plus_technical,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : Ljrgsc_Type ) return String;
   function Null_Or_Missing( i : Ljrgsc_Type ) return Boolean;
   function Convert_Ljrgsc_Type( i : String ) return Ljrgsc_Type;


   type Ljseg_Type is (  
      not_applicable,
      missing_or_wild,
      employers_large,
      personal_service_wrk,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual,
      unskilled_manual_wkr,
      own_account_wkrs,
      farmers_employers,
      farmers_own_accoun,
      agricultural_workers,
      members_of_armed_for,
      managers_large,
      employers_small,
      managers_small,
      professional_self_em,
      professional_employe,
      int_non_manual_work,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : Ljseg_Type ) return String;
   function Null_Or_Missing( i : Ljseg_Type ) return Boolean;
   function Convert_Ljseg_Type( i : String ) return Ljseg_Type;


   type Ljsemp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      self_employed,
      full_time_employee,
      part_time_employee );

   function Pretty_Print( i : Ljsemp_Type ) return String;
   function Null_Or_Missing( i : Ljsemp_Type ) return Boolean;
   function Convert_Ljsemp_Type( i : String ) return Ljsemp_Type;


   type Ljterm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      permanent,
      temp_or_casual,
      fixed_contract );

   function Pretty_Print( i : Ljterm_Type ) return String;
   function Null_Or_Missing( i : Ljterm_Type ) return Boolean;
   function Convert_Ljterm_Type( i : String ) return Ljterm_Type;


   type Ljylft_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      better_job,
      other,
      war_or_nat_service,
      moved_from_area,
      f_or_t_education,
      different_job,
      redundancy,
      dismissed,
      temp_job_ended,
      retired,
      health_reasons,
      to_have_baby,
      family_care );

   function Pretty_Print( i : Ljylft_Type ) return String;
   function Null_Or_Missing( i : Ljylft_Type ) return Boolean;
   function Convert_Ljylft_Type( i : String ) return Ljylft_Type;


   type Lkdobm_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Lkdobm_Type ) return String;
   function Null_Or_Missing( i : Lkdobm_Type ) return Boolean;
   function Convert_Lkdobm_Type( i : String ) return Lkdobm_Type;


   type Lkdoby_Type is (  
      unknown );

   function Pretty_Print( i : Lkdoby_Type ) return String;
   function Null_Or_Missing( i : Lkdoby_Type ) return Boolean;
   function Convert_Lkdoby_Type( i : String ) return Lkdoby_Type;


   type Lkmove_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      stay_here,
      prefer_to_move );

   function Pretty_Print( i : Lkmove_Type ) return String;
   function Null_Or_Missing( i : Lkmove_Type ) return Boolean;
   function Convert_Lkmove_Type( i : String ) return Lkmove_Type;


   type Lkmovy_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      larger_or_better_acc,
      better_accom,
      feels_isolated,
      to_rural_environ,
      from_urban_environ,
      traffic,
      area_unsafe,
      noise,
      unfriendly_area,
      to_specific_area,
      dislikes_area,
      smaller_or_cheaper_acc,
      occupation_reasons,
      reduce_travelling,
      retirement,
      family_reasons,
      more_privacy,
      wants_a_change,
      for_childs_education,
      own_accommodation,
      to_buy_somewhere,
      health_reasons,
      no_stairs,
      another_type,
      other_aspects,
      dislikes_accom,
      other,
      no_reason );

   function Pretty_Print( i : Lkmovy_Type ) return String;
   function Null_Or_Missing( i : Lkmovy_Type ) return Boolean;
   function Convert_Lkmovy_Type( i : String ) return Lkmovy_Type;


   type Lksex_Type is (  
      unknown,
      missing,
      male,
      female );

   function Pretty_Print( i : Lksex_Type ) return String;
   function Null_Or_Missing( i : Lksex_Type ) return Boolean;
   function Convert_Lksex_Type( i : String ) return Lksex_Type;


   type Lmend_Type is (  
      refused,
      inapplicable,
      missing_or_wild,
      widowed,
      divorced,
      other_separated,
      currently_married );

   function Pretty_Print( i : Lmend_Type ) return String;
   function Null_Or_Missing( i : Lmend_Type ) return Boolean;
   function Convert_Lmend_Type( i : String ) return Lmend_Type;


   type Lnadopt_Type is (  
      proxy_and_or_phone,
      inapplicable );

   function Pretty_Print( i : Lnadopt_Type ) return String;
   function Null_Or_Missing( i : Lnadopt_Type ) return Boolean;
   function Convert_Lnadopt_Type( i : String ) return Lnadopt_Type;


   type Lngeng_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      english,
      other );

   function Pretty_Print( i : Lngeng_Type ) return String;
   function Null_Or_Missing( i : Lngeng_Type ) return Boolean;
   function Convert_Lngeng_Type( i : String ) return Lngeng_Type;


   type Lngoth_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      english,
      czech,
      danish,
      dutch,
      estonian,
      finnish,
      french,
      gaelic,
      georgian,
      german,
      greek,
      albanian,
      hungarian,
      icelandic,
      irish,
      italian,
      latvian,
      lithuanian,
      macedonian,
      maltese,
      norwegian,
      polish,
      armenian,
      portuguese,
      romanian,
      russian,
      serbo_croat,
      slovak,
      slovene,
      spanish,
      swedish,
      swiss,
      turkish,
      austrian,
      ukranian,
      welsh,
      yugoslav,
      other_european,
      belaruian,
      afrikaans,
      bambara_or_mandingo,
      hausa_or_igbo,
      kikuyu,
      shona,
      somali,
      swahili,
      zulu,
      other_african,
      belgian,
      bengali,
      cantonese,
      chinese,
      gujarati,
      hindi,
      indonesian,
      japanese,
      punjabi,
      malaysian,
      mandarin,
      bosnian,
      nepali,
      urdu,
      other_asian,
      bulgarian,
      arabic,
      hebrew,
      iranian,
      kurdish,
      yiddish,
      other_middle_eastern,
      croatian,
      filipino,
      maori,
      samoan,
      other );

   function Pretty_Print( i : Lngoth_Type ) return String;
   function Null_Or_Missing( i : Lngoth_Type ) return Boolean;
   function Convert_Lngoth_Type( i : String ) return Lngoth_Type;


   type Lngusa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      converse_in_other_language );

   function Pretty_Print( i : Lngusa_Type ) return String;
   function Null_Or_Missing( i : Lngusa_Type ) return Boolean;
   function Convert_Lngusa_Type( i : String ) return Lngusa_Type;


   type Lngusb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      read_other_language );

   function Pretty_Print( i : Lngusb_Type ) return String;
   function Null_Or_Missing( i : Lngusb_Type ) return Boolean;
   function Convert_Lngusb_Type( i : String ) return Lngusb_Type;


   type Lngusn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      no_other_language );

   function Pretty_Print( i : Lngusn_Type ) return String;
   function Null_Or_Missing( i : Lngusn_Type ) return Boolean;
   function Convert_Lngusn_Type( i : String ) return Lngusn_Type;


   type Lngwke_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      english,
      other_language,
      not_employed );

   function Pretty_Print( i : Lngwke_Type ) return String;
   function Null_Or_Missing( i : Lngwke_Type ) return Boolean;
   function Convert_Lngwke_Type( i : String ) return Lngwke_Type;


   type Lngwko_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none,
      english,
      czech,
      danish,
      dutch,
      estonian,
      finnish,
      french,
      gaelic,
      georgian,
      german,
      greek,
      albanian,
      hungarian,
      icelandic,
      irish,
      italian,
      latvian,
      lithuanian,
      macedonian,
      maltese,
      norwegian,
      polish,
      armenian,
      portuguese,
      romanian,
      russian,
      serbo_croat,
      slovak,
      slovene,
      spanish,
      swedish,
      swiss,
      turkish,
      austrian,
      ukranian,
      welsh,
      yugoslav,
      other_european,
      belaruian,
      afrikaans,
      bambara_or_mandingo,
      hausa_or_igbo,
      kikuyu,
      shona,
      somali,
      swahili,
      zulu,
      other_african,
      belgian,
      bengali,
      cantonese,
      chinese,
      gujarati,
      hindi,
      indonesian,
      japanese,
      punjabi,
      malaysian,
      mandarin,
      bosnian,
      nepali,
      urdu,
      other_asian,
      bulgarian,
      arabic,
      hebrew,
      iranian,
      kurdish,
      yiddish,
      other_middle_eastern,
      croatian,
      filipino,
      maori,
      samoan,
      other );

   function Pretty_Print( i : Lngwko_Type ) return String;
   function Null_Or_Missing( i : Lngwko_Type ) return Boolean;
   function Convert_Lngwko_Type( i : String ) return Lngwko_Type;


   type Locchd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      excellent,
      very_good,
      fair,
      poor,
      other );

   function Pretty_Print( i : Locchd_Type ) return String;
   function Null_Or_Missing( i : Locchd_Type ) return Boolean;
   function Convert_Locchd_Type( i : String ) return Locchd_Type;


   type Locsera_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      excellent,
      very_good,
      fair,
      poor );

   function Pretty_Print( i : Locsera_Type ) return String;
   function Null_Or_Missing( i : Locsera_Type ) return Boolean;
   function Convert_Locsera_Type( i : String ) return Locsera_Type;


   type Lprnt_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      not_applicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Lprnt_Type ) return String;
   function Null_Or_Missing( i : Lprnt_Type ) return Boolean;
   function Convert_Lprnt_Type( i : String ) return Lprnt_Type;


   type Lrio_Type is (  
      missing_or_wild,
      full_interview,
      refusal,
      other_non_intvw,
      chld_in_nonresp_hh,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      absent_no_proxy,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      oth_non_intv_no_proxy,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      child_instit_or_nc_hh,
      chd_untraced_mover,
      moved,
      other,
      no_one_elig_in_hh,
      prv_wave_adamant_ref,
      l_t_untraced_wdrawn,
      wdrawn_before_field,
      elig_in_non_cont_hh,
      withdrawn_other,
      dead );

   function Pretty_Print( i : Lrio_Type ) return String;
   function Null_Or_Missing( i : Lrio_Type ) return Boolean;
   function Convert_Lrio_Type( i : String ) return Lrio_Type;


   type Lvag14_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      natural_moth_and_fath,
      adoptiv_moth_and_fath,
      mother_and_stepfather,
      father_and_stepmother,
      mother_no_fath_figr,
      father_or_no_moth_figr,
      la_care_or_foster_home,
      other );

   function Pretty_Print( i : Lvag14_Type ) return String;
   function Null_Or_Missing( i : Lvag14_Type ) return Boolean;
   function Convert_Lvag14_Type( i : String ) return Lvag14_Type;


   type Lvag16_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      yes,
      no,
      other );

   function Pretty_Print( i : Lvag16_Type ) return String;
   function Null_Or_Missing( i : Lvag16_Type ) return Boolean;
   function Convert_Lvag16_Type( i : String ) return Lvag16_Type;


   type Lvch_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      sons_or_daughters );

   function Pretty_Print( i : Lvch_Type ) return String;
   function Null_Or_Missing( i : Lvch_Type ) return Boolean;
   function Convert_Lvch_Type( i : String ) return Lvch_Type;


   type Lvgch_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      grandchildren );

   function Pretty_Print( i : Lvgch_Type ) return String;
   function Null_Or_Missing( i : Lvgch_Type ) return Boolean;
   function Convert_Lvgch_Type( i : String ) return Lvgch_Type;


   type Lvggch_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      great_grandchildren );

   function Pretty_Print( i : Lvggch_Type ) return String;
   function Null_Or_Missing( i : Lvggch_Type ) return Boolean;
   function Convert_Lvggch_Type( i : String ) return Lvggch_Type;


   type Lvggpa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      great_grandparents );

   function Pretty_Print( i : Lvggpa_Type ) return String;
   function Null_Or_Missing( i : Lvggpa_Type ) return Boolean;
   function Convert_Lvggpa_Type( i : String ) return Lvggpa_Type;


   type Lvgpar_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      grandparents );

   function Pretty_Print( i : Lvgpar_Type ) return String;
   function Null_Or_Missing( i : Lvgpar_Type ) return Boolean;
   function Convert_Lvgpar_Type( i : String ) return Lvgpar_Type;


   type Lvhmag_Type is (  
      dont_know,
      never_with_both_parents,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Lvhmag_Type ) return String;
   function Null_Or_Missing( i : Lvhmag_Type ) return Boolean;
   function Convert_Lvhmag_Type( i : String ) return Lvhmag_Type;


   type Lvloc_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      current_resident,
      outside_gb,
      address_in_roi,
      in_gb_priv_add_known,
      in_gb_priv_add_unknown,
      institution,
      deceased,
      other,
      address_in_ni_known,
      unkown_address_in_ni );

   function Pretty_Print( i : Lvloc_Type ) return String;
   function Null_Or_Missing( i : Lvloc_Type ) return Boolean;
   function Convert_Lvloc_Type( i : String ) return Lvloc_Type;


   type Lvlong_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      very_likely,
      likely,
      unlikely,
      very_unlikely );

   function Pretty_Print( i : Lvlong_Type ) return String;
   function Null_Or_Missing( i : Lvlong_Type ) return Boolean;
   function Convert_Lvlong_Type( i : String ) return Lvlong_Type;


   type Lvma_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      mother );

   function Pretty_Print( i : Lvma_Type ) return String;
   function Null_Or_Missing( i : Lvma_Type ) return Boolean;
   function Convert_Lvma_Type( i : String ) return Lvma_Type;


   type Lvmn_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      current_resident,
      january,
      october,
      november,
      december,
      summer,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Lvmn_Type ) return String;
   function Null_Or_Missing( i : Lvmn_Type ) return Boolean;
   function Convert_Lvmn_Type( i : String ) return Lvmn_Type;


   type Lvpa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      father );

   function Pretty_Print( i : Lvpa_Type ) return String;
   function Null_Or_Missing( i : Lvpa_Type ) return Boolean;
   function Convert_Lvpa_Type( i : String ) return Lvpa_Type;


   type Lvsib_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      brothers_or_sisters );

   function Pretty_Print( i : Lvsib_Type ) return String;
   function Null_Or_Missing( i : Lvsib_Type ) return Boolean;
   function Convert_Lvsib_Type( i : String ) return Lvsib_Type;


   type Lvwhy_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      current_resident,
      deceased,
      separated_or_divorced,
      to_college_or_university,
      to_institution,
      left_for_job,
      marriage_or_cohabitation,
      to_set_up_own_home,
      other );

   function Pretty_Print( i : Lvwhy_Type ) return String;
   function Null_Or_Missing( i : Lvwhy_Type ) return Boolean;
   function Convert_Lvwhy_Type( i : String ) return Lvwhy_Type;


   type Lvyr_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      current_resident,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Lvyr_Type ) return String;
   function Null_Or_Missing( i : Lvyr_Type ) return Boolean;
   function Convert_Lvyr_Type( i : String ) return Lvyr_Type;


   type Lvyr4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      current_resident,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Lvyr4_Type ) return String;
   function Null_Or_Missing( i : Lvyr4_Type ) return Boolean;
   function Convert_Lvyr4_Type( i : String ) return Lvyr4_Type;


   type Lwdnw1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_monday );

   function Pretty_Print( i : Lwdnw1_Type ) return String;
   function Null_Or_Missing( i : Lwdnw1_Type ) return Boolean;
   function Convert_Lwdnw1_Type( i : String ) return Lwdnw1_Type;


   type Lwdnw2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_tuesday );

   function Pretty_Print( i : Lwdnw2_Type ) return String;
   function Null_Or_Missing( i : Lwdnw2_Type ) return Boolean;
   function Convert_Lwdnw2_Type( i : String ) return Lwdnw2_Type;


   type Lwdnw3_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_wednesday );

   function Pretty_Print( i : Lwdnw3_Type ) return String;
   function Null_Or_Missing( i : Lwdnw3_Type ) return Boolean;
   function Convert_Lwdnw3_Type( i : String ) return Lwdnw3_Type;


   type Lwdnw4_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_thursday );

   function Pretty_Print( i : Lwdnw4_Type ) return String;
   function Null_Or_Missing( i : Lwdnw4_Type ) return Boolean;
   function Convert_Lwdnw4_Type( i : String ) return Lwdnw4_Type;


   type Lwdnw5_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_friday );

   function Pretty_Print( i : Lwdnw5_Type ) return String;
   function Null_Or_Missing( i : Lwdnw5_Type ) return Boolean;
   function Convert_Lwdnw5_Type( i : String ) return Lwdnw5_Type;


   type Lwdnw6_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_saturday );

   function Pretty_Print( i : Lwdnw6_Type ) return String;
   function Null_Or_Missing( i : Lwdnw6_Type ) return Boolean;
   function Convert_Lwdnw6_Type( i : String ) return Lwdnw6_Type;


   type Lwdnw7_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      didnt_work_sunday );

   function Pretty_Print( i : Lwdnw7_Type ) return String;
   function Null_Or_Missing( i : Lwdnw7_Type ) return Boolean;
   function Convert_Lwdnw7_Type( i : String ) return Lwdnw7_Type;


   type Lwstat_Type is (  
      ego_new_entrant,
      missing_household,
      co_resident,
      different_household,
      alter_birth,
      alter_out_of_scope,
      blank,
      not_in_sample,
      both_non_resp_dk );

   function Pretty_Print( i : Lwstat_Type ) return String;
   function Null_Or_Missing( i : Lwstat_Type ) return Boolean;
   function Convert_Lwstat_Type( i : String ) return Lwstat_Type;


   type Maborn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      england,
      scotland,
      wales,
      northern_ireland,
      irish_republic,
      other_or_outside_uk );

   function Pretty_Print( i : Maborn_Type ) return String;
   function Null_Or_Missing( i : Maborn_Type ) return Boolean;
   function Convert_Maborn_Type( i : String ) return Maborn_Type;


   type Maboss_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      work_on_own,
      had_employees );

   function Pretty_Print( i : Maboss_Type ) return String;
   function Null_Or_Missing( i : Maboss_Type ) return Boolean;
   function Convert_Maboss_Type( i : String ) return Maboss_Type;


   type Mabrn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      abu_dhabi,
      alderney,
      ecuador,
      egypt,
      el_salvador,
      ellice_island,
      england,
      equatorial_guinea,
      eritrea,
      estonia,
      ethiopia,
      europe_not_elsewhere_coded,
      algeria,
      falkland_islands,
      faroe_islands,
      federated_states_of_micronesia,
      fiji,
      finland,
      france,
      french_guiana,
      french_polynesia,
      french_southern_territories,
      fujairah,
      american_samoa,
      gabon,
      gambia,
      gaza_and_west_bank,
      georgia_republic,
      germany,
      ghana,
      gibraltar,
      gough_island,
      greece,
      greenland,
      andorra,
      grenada,
      guadaloupe,
      guam,
      guatemala,
      guernsey,
      guinea,
      guinea_bissau,
      guyana,
      haiti,
      heard_and_mcdonald_islands,
      angola,
      herm,
      herzegovina,
      honduras,
      hong_kong,
      hungary,
      ibiza,
      iceland,
      inaccessible_island,
      india,
      indonesia,
      anguilla,
      ionian_islands,
      iran,
      iraq,
      ireland_northern,
      ireland_republic_of,
      isle_of_man,
      israel,
      italy,
      jamaica,
      japan,
      antarctica_nes,
      java,
      jersey,
      jethou_island,
      johnston_atoll_or_island,
      jordan,
      kashmir,
      kazakhstan,
      kenya,
      kiribati,
      korea_dem_peoples_rep_north_korea,
      antigua,
      korea_republic_of_south_korea,
      kosovo,
      kuwait,
      kyrgyzstan,
      laos,
      latvia,
      lebanon,
      lesotho,
      liberia,
      libya,
      antigua_and_barbuda,
      liechtenstein,
      lithuania,
      loyalty_islands,
      luxembourg,
      macao,
      macedonia,
      madagascar,
      malagasy_republic,
      malawi,
      malaysia,
      argentina,
      maldives,
      mali,
      malta_and_gozo,
      marshall_islands,
      martinique,
      mauritania,
      mauritius,
      mayotte_collectivity_of_aka_mahore,
      melilla,
      mexico,
      aden,
      argentina_antarctic_territory,
      middle_east_not_elsewhere_coded,
      middle_island,
      moldova,
      monaco,
      mongolia,
      montenegro,
      montserrat,
      morocco,
      mozambique,
      myanmar,
      armenia,
      namibia,
      nauru,
      nepal,
      netherland_antilles,
      netherlands,
      new_caledonia,
      new_zealand,
      nicaragua,
      niger,
      nigeria,
      aruba,
      nightingale_island,
      niue,
      norfolk_island,
      northern_mariana_islands,
      norway,
      norwegian_antarctic_territory,
      oman,
      pakistan,
      palau,
      palestine,
      ascension_island,
      palmyra_islands,
      panama,
      panama_canal_zone,
      papua_new_guinea,
      paraguay,
      peru,
      peter_island,
      philippines,
      pitcairn_islands_group,
      poland,
      asia_not_elsewhere_coded,
      polynesia,
      portugal,
      puerto_rico,
      qatar,
      queen_maud_land,
      ras_al_khaimah,
      reunion,
      romania,
      ross_dependency,
      russia,
      australia,
      rwanda,
      saint_barthelemy_collectivity_of,
      saint_martin_collectivity_of,
      san_marino,
      sao_tome_and_principe,
      sark,
      saudi_arabia,
      scotland,
      senegal,
      serbia,
      australian_antarctic_territory,
      seychelles,
      sharjah,
      sierra_leone,
      singapore,
      slovakia,
      slovenia,
      solomon_islands,
      somalia,
      south_africa,
      south_america_not_elsewhere_coded,
      austria,
      south_georgia_and_south_sandwich_islands,
      spain,
      sri_lanka,
      st_christopher_st_kitts_nevis,
      st_helena,
      st_lucia,
      st_pierre_et_miquelon,
      st_vincent_and_the_grenadines,
      stoltenhoff_island,
      sudan,
      azerbaijan,
      suriname,
      swaziland,
      sweden,
      switzerland,
      syrian_arab_republic,
      taiwan,
      tajikistan,
      tanzania,
      thailand,
      tibet,
      azores,
      togo,
      tokelau_islands,
      tonga,
      transkei,
      trinidad_and_tobago,
      tristan_da_cunha,
      tunisia,
      turkey,
      turkmenistan,
      turks_and_caicos_islands,
      afghanistan,
      bahamas,
      tuvalu,
      uganda,
      ukraine,
      umm_al_qaiwain,
      union_of_soviet_socialist_republics,
      united_arab_emirates,
      united_states_of_america,
      uruguay,
      us_pacific_islands,
      us_virgin_islands,
      bahrain,
      uzbekistan,
      vanuatu,
      vatican_city_state,
      venezuela,
      vietnam,
      wake_island,
      wales,
      wallis_and_futuna_islands,
      walvis_bay,
      west_falkland,
      bangladesh,
      west_indies_not_elsewhere_coded,
      western_samoa,
      yemen,
      yugoslavia,
      zaire_congolese_republic,
      zambia,
      zimbabwe_rhodesia,
      other_country_please_specify,
      bantu_homelands,
      barbados,
      barbuda,
      basutoland,
      belarus,
      belgium,
      belize,
      africa_east_nes,
      benin,
      bermuda,
      bhurma,
      bhutan,
      bolivia,
      bonaire,
      bophuthatswana,
      bosnia_and_herzegovina,
      botswana,
      brazil,
      africa_north_nes,
      british_antarctic_territory,
      british_indian_ocean_territory,
      british_virgin_islands,
      brunei,
      bulgaria,
      burkina_faso,
      burundi,
      cabinda,
      cambodia,
      cameroon,
      africa_west_nes,
      canada,
      canary_islands,
      cape_verde,
      caroline_islands,
      cayman_islands,
      central_african_republic,
      ceuta,
      chad,
      chagos_archipelago,
      channel_islands,
      africa_nes,
      chile,
      chilean_antarctic,
      china,
      christmas_island_australia,
      cocos_keeling_islands,
      colombia,
      cis_russia,
      comoros,
      congo,
      cook_islands,
      ajman,
      coral_sea_islands_territory,
      costa_rica,
      cote_d_ivoire_republic_of,
      crete,
      croatia,
      cuba,
      curacao,
      cyprus,
      czech_republic,
      czechoslovakia,
      albania,
      democratic_republic_of_congo,
      denmark,
      djibouti,
      dodecanese_islands,
      dominica,
      dominican_republic,
      dubai,
      east_falkland,
      east_samoa_american,
      east_timor_dem_rep_of_timor_leste,
      other );

   function Pretty_Print( i : Mabrn_Type ) return String;
   function Null_Or_Missing( i : Mabrn_Type ) return Boolean;
   function Convert_Mabrn_Type( i : String ) return Mabrn_Type;


   type Mach18_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Mach18_Type ) return String;
   function Null_Or_Missing( i : Mach18_Type ) return Boolean;
   function Convert_Mach18_Type( i : String ) return Mach18_Type;


   type Macssf_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Macssf_Type ) return String;
   function Null_Or_Missing( i : Macssf_Type ) return Boolean;
   function Convert_Macssf_Type( i : String ) return Macssf_Type;


   type Maedhi_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      never_went_to_school,
      left_school_no_quals,
      left_sch_w_some_qual,
      got_further_ed_quals,
      got_uni_or_highr_degree );

   function Pretty_Print( i : Maedhi_Type ) return String;
   function Null_Or_Missing( i : Maedhi_Type ) return Boolean;
   function Convert_Maedhi_Type( i : String ) return Maedhi_Type;


   type Magold_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      not_applicable,
      missing,
      service_class_higher_grade,
      semi_unskilled_manual_workers,
      agricultural_workers,
      inadequately_described_non_stated,
      service_class_lower_grade,
      routine_non_manual_employees,
      personal_service_workers,
      sml_props_w_employees,
      sml_props_w_or_o_employees,
      farmers_smallholders,
      foreman_technicians,
      skilled_manual_workers );

   function Pretty_Print( i : Magold_Type ) return String;
   function Null_Or_Missing( i : Magold_Type ) return Boolean;
   function Convert_Magold_Type( i : String ) return Magold_Type;


   type Maju_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      mother_not_work,
      mother_deceased,
      mother_not_live );

   function Pretty_Print( i : Maju_Type ) return String;
   function Null_Or_Missing( i : Maju_Type ) return Boolean;
   function Convert_Maju_Type( i : String ) return Maju_Type;


   type Mamngr_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      manager,
      foreman_or_supervis,
      not_mnger_or_superv );

   function Pretty_Print( i : Mamngr_Type ) return String;
   function Null_Or_Missing( i : Mamngr_Type ) return Boolean;
   function Convert_Mamngr_Type( i : String ) return Mamngr_Type;


   type Margsc_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      professional_occ,
      managerial_and_technical_occ,
      skilled_non_manual,
      skilled_manual,
      partly_skilled_occ,
      unskilled_occ,
      armed_forces );

   function Pretty_Print( i : Margsc_Type ) return String;
   function Null_Or_Missing( i : Margsc_Type ) return Boolean;
   function Convert_Margsc_Type( i : String ) return Margsc_Type;


   type Maseg_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      not_applicable,
      missing,
      employers_large,
      personal_service_wrkrs,
      foreman_manual,
      skilled_manual_wkrs,
      semi_skilled_manual_wkrs,
      unskilled_manual_wkrs,
      own_account_wkrs,
      farmers_employers_managers,
      farmers_own_account,
      agricultural_workers,
      members_of_armed_forces,
      managers_large,
      inadequately_described_non_stated,
      employers_small,
      managers_small,
      professional_self_employed,
      professional_employees,
      int_non_manual_workers,
      int_non_man_foreman,
      junior_non_manual );

   function Pretty_Print( i : Maseg_Type ) return String;
   function Null_Or_Missing( i : Maseg_Type ) return Boolean;
   function Convert_Maseg_Type( i : String ) return Maseg_Type;


   type Mastat_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      under_16_years,
      married,
      survive_from_civ_par,
      living_as_couple,
      widowed,
      divorced,
      separated,
      never_married,
      civil_partnership,
      dissolved_civil_partnership,
      sep_from_civil_part );

   function Pretty_Print( i : Mastat_Type ) return String;
   function Null_Or_Missing( i : Mastat_Type ) return Boolean;
   function Convert_Mastat_Type( i : String ) return Mastat_Type;


   type Memorig_Type is (  
      not_applicable,
      missing,
      original_sample,
      ni_resp_moved_to_uk,
      echp_scpr,
      echp_ons,
      echp_ni,
      wales_new_sample,
      scotland_new_sample,
      ni_new_sample );

   function Pretty_Print( i : Memorig_Type ) return String;
   function Null_Or_Missing( i : Memorig_Type ) return Boolean;
   function Convert_Memorig_Type( i : String ) return Memorig_Type;


   type Mghave_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      owned_outright,
      buying_mortgage_or_loan );

   function Pretty_Print( i : Mghave_Type ) return String;
   function Null_Or_Missing( i : Mghave_Type ) return Boolean;
   function Convert_Mghave_Type( i : String ) return Mghave_Type;


   type Mgstat_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      buying_with_mortgage,
      renting,
      owned_outright );

   function Pretty_Print( i : Mgstat_Type ) return String;
   function Null_Or_Missing( i : Mgstat_Type ) return Boolean;
   function Convert_Mgstat_Type( i : String ) return Mgstat_Type;


   type Mgtot_Type is (  
      dont_know,
      refused,
      none,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Mgtot_Type ) return String;
   function Null_Or_Missing( i : Mgtot_Type ) return Boolean;
   function Convert_Mgtot_Type( i : String ) return Mgtot_Type;


   type Mgtype_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      repaymnt_mortge_or_loan,
      endowment_mortgage,
      pt_repaymnt_or_endowmnt,
      other_mortgage_or_loan );

   function Pretty_Print( i : Mgtype_Type ) return String;
   function Null_Or_Missing( i : Mgtype_Type ) return Boolean;
   function Convert_Mgtype_Type( i : String ) return Mgtype_Type;


   type Mgxty1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      home_extension );

   function Pretty_Print( i : Mgxty1_Type ) return String;
   function Null_Or_Missing( i : Mgxty1_Type ) return Boolean;
   function Convert_Mgxty1_Type( i : String ) return Mgxty1_Type;


   type Mgxty2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      home_improvements );

   function Pretty_Print( i : Mgxty2_Type ) return String;
   function Null_Or_Missing( i : Mgxty2_Type ) return Boolean;
   function Convert_Mgxty2_Type( i : String ) return Mgxty2_Type;


   type Mgxty3_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      car_purchase );

   function Pretty_Print( i : Mgxty3_Type ) return String;
   function Null_Or_Missing( i : Mgxty3_Type ) return Boolean;
   function Convert_Mgxty3_Type( i : String ) return Mgxty3_Type;


   type Mgxty4_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_consumer_gds );

   function Pretty_Print( i : Mgxty4_Type ) return String;
   function Null_Or_Missing( i : Mgxty4_Type ) return Boolean;
   function Convert_Mgxty4_Type( i : String ) return Mgxty4_Type;


   type Mgxty5_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_specifed_expend );

   function Pretty_Print( i : Mgxty5_Type ) return String;
   function Null_Or_Missing( i : Mgxty5_Type ) return Boolean;
   function Convert_Mgxty5_Type( i : String ) return Mgxty5_Type;


   type Mgynot_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      paid_mortgage_or_loan,
      bought_it_with_cash,
      inherited_all_or_share_or_given,
      other_means_of_purch );

   function Pretty_Print( i : Mgynot_Type ) return String;
   function Null_Or_Missing( i : Mgynot_Type ) return Boolean;
   function Convert_Mgynot_Type( i : String ) return Mgynot_Type;


   type Mivfho_Type is (  
      inapplicable,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_interview_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal,
      l_t_untraced_wdrawn,
      wdrawn_before_field );

   function Pretty_Print( i : Mivfho_Type ) return String;
   function Null_Or_Missing( i : Mivfho_Type ) return Boolean;
   function Convert_Mivfho_Type( i : String ) return Mivfho_Type;


   type Mivfio_Type is (  
      inapplicable,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_re,
      l_t_untraced_wdrawn,
      wdrawn_before_field,
      lost_capi_intvw,
      dead );

   function Pretty_Print( i : Mivfio_Type ) return String;
   function Null_Or_Missing( i : Mivfio_Type ) return Boolean;
   function Convert_Mivfio_Type( i : String ) return Mivfio_Type;


   type Mlchm_Type is (  
      dont_know,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Mlchm_Type ) return String;
   function Null_Or_Missing( i : Mlchm_Type ) return Boolean;
   function Convert_Mlchm_Type( i : String ) return Mlchm_Type;


   type Mlchy_Type is (  
      refused,
      inapplicable,
      missing_or_wild,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Mlchy_Type ) return String;
   function Null_Or_Missing( i : Mlchy_Type ) return Boolean;
   function Convert_Mlchy_Type( i : String ) return Mlchy_Type;


   type Mlchy4_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Mlchy4_Type ) return String;
   function Null_Or_Missing( i : Mlchy4_Type ) return Boolean;
   function Convert_Mlchy4_Type( i : String ) return Mlchy4_Type;


   type Mlstat_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      married,
      separated,
      divorced,
      widowed,
      never_married,
      in_a_civil_partnership,
      have_a_dissolved_civil_partnership,
      separated_from_a_civil_partnership,
      surviving_partner_of_a_civil_partnership );

   function Pretty_Print( i : Mlstat_Type ) return String;
   function Null_Or_Missing( i : Mlstat_Type ) return Boolean;
   function Convert_Mlstat_Type( i : String ) return Mlstat_Type;


   type Mobuse_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      dont_drive );

   function Pretty_Print( i : Mobuse_Type ) return String;
   function Null_Or_Missing( i : Mobuse_Type ) return Boolean;
   function Convert_Mobuse_Type( i : String ) return Mobuse_Type;


   type Movest_Type is (  
      w_1_non_contact_hh,
      not_applicable,
      missing,
      non_mover,
      mover_status_unknown,
      inel_tsm_dk_mover_status,
      mover_within_gb,
      died,
      out_of_scope,
      ineligible_tsm,
      ineligible_tsm_non_mover,
      new_entrant_w2,
      unknown_status,
      dead );

   function Pretty_Print( i : Movest_Type ) return String;
   function Null_Or_Missing( i : Movest_Type ) return Boolean;
   function Convert_Movest_Type( i : String ) return Movest_Type;


   type Movjba_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      yes );

   function Pretty_Print( i : Movjba_Type ) return String;
   function Null_Or_Missing( i : Movjba_Type ) return Boolean;
   function Convert_Movjba_Type( i : String ) return Movjba_Type;


   type Movy1_Type is (  
      dont_know,
      refused,
      no_other_reason,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      mve_in_wth_partn,
      mve_to_college,
      left_college,
      job_reasn_self,
      job_reasn_othr,
      retirement,
      evicted_reposs,
      split_from_partn,
      larger_accom,
      smaller_accom,
      own_accom,
      buy_accom,
      health_reasons,
      no_stairs,
      another_type,
      other_aspects,
      dislkd_prev_acc,
      mve_in_wth_family,
      better_accom,
      privacy,
      wants_change,
      mve_from_family,
      dislkd_isolatn,
      to_rural_envirn,
      from_rural_env,
      traffic,
      area_unsafe,
      noise,
      area_unfriendly,
      to_specfc_place,
      dislkd_area,
      mve_in_wth_friend,
      closr_fam_friend,
      other );

   function Pretty_Print( i : Movy1_Type ) return String;
   function Null_Or_Missing( i : Movy1_Type ) return Boolean;
   function Convert_Movy1_Type( i : String ) return Movy1_Type;


   type Movy2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      mve_in_wth_partn,
      mve_to_college,
      left_college,
      job_reasn_self,
      job_reasn_othr,
      retirement,
      evicted_reposs,
      split_from_partn,
      larger_accom,
      smaller_accom,
      own_accom,
      buy_accom,
      health_reasons,
      no_stairs,
      another_type,
      other_aspects,
      dislkd_prev_acc,
      mve_in_wth_family,
      better_accom,
      privacy,
      wants_change,
      mve_from_family,
      dislkd_isolatn,
      to_rural_envirn,
      from_rural_env,
      traffic,
      area_unsafe,
      noise,
      area_unfriendly,
      to_specfc_place,
      dislkd_area,
      mve_in_wth_friend,
      closr_fam_friend,
      other );

   function Pretty_Print( i : Movy2_Type ) return String;
   function Null_Or_Missing( i : Movy2_Type ) return Boolean;
   function Convert_Movy2_Type( i : String ) return Movy2_Type;


   type Mpid_Type is (  
      inapplicable,
      missing_or_wild,
      mother_not_in_hh );

   function Pretty_Print( i : Mpid_Type ) return String;
   function Null_Or_Missing( i : Mpid_Type ) return Boolean;
   function Convert_Mpid_Type( i : String ) return Mpid_Type;


   type Mpno_Type is (  
      dont_know,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Mpno_Type ) return String;
   function Null_Or_Missing( i : Mpno_Type ) return Boolean;
   function Convert_Mpno_Type( i : String ) return Mpno_Type;


   type Mrjboss_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Mrjboss_Type ) return String;
   function Null_Or_Missing( i : Mrjboss_Type ) return Boolean;
   function Convert_Mrjboss_Type( i : String ) return Mrjboss_Type;


   type Mrjmngr_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      manager,
      foreman_or_supervisor,
      not_mngr_or_supervisor );

   function Pretty_Print( i : Mrjmngr_Type ) return String;
   function Null_Or_Missing( i : Mrjmngr_Type ) return Boolean;
   function Convert_Mrjmngr_Type( i : String ) return Mrjmngr_Type;


   type Mrjsemp_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      employee,
      self_employed );

   function Pretty_Print( i : Mrjsemp_Type ) return String;
   function Null_Or_Missing( i : Mrjsemp_Type ) return Boolean;
   function Convert_Mrjsemp_Type( i : String ) return Mrjsemp_Type;


   type Mrjsic_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_9997_or_above );

   function Pretty_Print( i : Mrjsic_Type ) return String;
   function Null_Or_Missing( i : Mrjsic_Type ) return Boolean;
   function Convert_Mrjsic_Type( i : String ) return Mrjsic_Type;


   type Mrjsic9_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing );

   function Pretty_Print( i : Mrjsic9_Type ) return String;
   function Null_Or_Missing( i : Mrjsic9_Type ) return Boolean;
   function Convert_Mrjsic9_Type( i : String ) return Mrjsic9_Type;


   type Mrjsize_Type is (  
      dont_know,
      refused,
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1_2,
      dk_but_under_25,
      dk_but_25_plus,
      s_3_9,
      s_10_24,
      s_25_49,
      s_50_99,
      s_100_199,
      s_200_499,
      s_500_999,
      s_1000_or_more );

   function Pretty_Print( i : Mrjsize_Type ) return String;
   function Null_Or_Missing( i : Mrjsize_Type ) return Boolean;
   function Convert_Mrjsize_Type( i : String ) return Mrjsize_Type;


   type Mrjsoc_Type is (  
      never_had_a_job,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Mrjsoc_Type ) return String;
   function Null_Or_Missing( i : Mrjsoc_Type ) return Boolean;
   function Convert_Mrjsoc_Type( i : String ) return Mrjsoc_Type;


   type Mrmseq_Type is (  
      not_applicable );

   function Pretty_Print( i : Mrmseq_Type ) return String;
   function Null_Or_Missing( i : Mrmseq_Type ) return Boolean;
   function Convert_Mrmseq_Type( i : String ) return Mrmseq_Type;


   type Mrssch_Type is (  
      proxy_and_or_phone,
      missing_or_wild,
      ab,
      c1,
      c2,
      blank,
      n_or_a_not_coded );

   function Pretty_Print( i : Mrssch_Type ) return String;
   function Null_Or_Missing( i : Mrssch_Type ) return Boolean;
   function Convert_Mrssch_Type( i : String ) return Mrssch_Type;


   type Mstat_Type is (  
      original,
      permanent,
      temporary );

   function Pretty_Print( i : Mstat_Type ) return String;
   function Null_Or_Missing( i : Mstat_Type ) return Boolean;
   function Convert_Mstat_Type( i : String ) return Mstat_Type;


   type Na75pl_Type is (  
      inapplicable,
      missing_or_wild,
      none );

   function Pretty_Print( i : Na75pl_Type ) return String;
   function Null_Or_Missing( i : Na75pl_Type ) return Boolean;
   function Convert_Na75pl_Type( i : String ) return Na75pl_Type;


   type Naidxhh_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      one_person,
      two_people,
      three_people,
      four_people,
      five_people,
      six_people,
      seven_plus_people );

   function Pretty_Print( i : Naidxhh_Type ) return String;
   function Null_Or_Missing( i : Naidxhh_Type ) return Boolean;
   function Convert_Naidxhh_Type( i : String ) return Naidxhh_Type;


   type Natidh_Type is (  
      not_answered,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      yes );

   function Pretty_Print( i : Natidh_Type ) return String;
   function Null_Or_Missing( i : Natidh_Type ) return Boolean;
   function Convert_Natidh_Type( i : String ) return Natidh_Type;


   type Natidmn_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      british,
      english,
      european,
      irish,
      northern_irish,
      scottish,
      welsh,
      other,
      none_of_these );

   function Pretty_Print( i : Natidmn_Type ) return String;
   function Null_Or_Missing( i : Natidmn_Type ) return Boolean;
   function Convert_Natidmn_Type( i : String ) return Natidmn_Type;


   type Nbooks_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      lots_of_books,
      quite_a_few_books,
      not_many_books );

   function Pretty_Print( i : Nbooks_Type ) return String;
   function Null_Or_Missing( i : Nbooks_Type ) return Boolean;
   function Convert_Nbooks_Type( i : String ) return Nbooks_Type;


   type Ncars_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      none,
      one,
      two,
      s_3_plus );

   function Pretty_Print( i : Ncars_Type ) return String;
   function Null_Or_Missing( i : Ncars_Type ) return Boolean;
   function Convert_Ncars_Type( i : String ) return Ncars_Type;


   type Ncigs_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      less_than_1_per_day );

   function Pretty_Print( i : Ncigs_Type ) return String;
   function Null_Or_Missing( i : Ncigs_Type ) return Boolean;
   function Convert_Ncigs_Type( i : String ) return Ncigs_Type;


   type Neigh_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      good,
      bad,
      mixed );

   function Pretty_Print( i : Neigh_Type ) return String;
   function Null_Or_Missing( i : Neigh_Type ) return Boolean;
   function Convert_Neigh_Type( i : String ) return Neigh_Type;


   type Neigh1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      people_friendly,
      white_area,
      connection_to_area,
      good_public_transport,
      good_shopping_facilities,
      good_entertainment_facilities,
      good_leisure_facilities,
      has_open_spaces,
      good_or_convenient_schools,
      good_church,
      good_medical_facilities,
      neighbours_friendly,
      good_local_facilities_nes,
      area_feels_safe,
      no_drugs,
      no_violence_or_muggings,
      no_car_crime,
      no_burglaries,
      no_vandalism,
      no_crime_nes,
      quiet_area,
      good_area_for_children,
      family_live_in_area,
      town_centre_accessible,
      accessible_to_london,
      good_transport_links,
      rural_surroundings,
      good_for_work,
      affluent_area,
      no_problems_with_traffic,
      good_parking_facilities,
      no_pollution,
      no_housing_problems,
      friends_in_area,
      attractive_buildings,
      like_current_house,
      house_a_good_investment,
      desirable_area,
      area_improved,
      like_the_area_nes,
      other_positive_aspect_nes,
      people_unfriendly,
      neighbours_unfriendly,
      no_family_in_area,
      provacy,
      no_friends_in_area,
      no_privacy,
      no_sense_of_community,
      dislike_racial_mix,
      problems_with_young_people,
      bad_language,
      poor_transport_facilities,
      poor_shopping_facilities,
      poor_entertainment_facilities,
      poor_leisure_facilities,
      good_community,
      lack_of_open_spaces,
      poor_education_facilities,
      no_church_locally,
      poor_medical_facilities,
      poor_local_facilities_nes,
      unsafe_area,
      problems_with_drugs,
      problems_with_violence,
      problems_with_car_crime,
      problems_with_burglary,
      racial_diversity,
      problems_with_vandalism,
      crime_rate_high,
      problems_with_alcohol,
      problems_with_street_gangs,
      police_intrusive,
      noise_problems,
      poor_area_for_children,
      poor_employment_prospects,
      area_deprived,
      traffic_problems,
      kids_well_behaved,
      lack_of_parking_facilities,
      pollution_problems,
      housing_problems,
      area_over_crowded,
      area_becoming_worse,
      dont_like_area_nes,
      other_negative_aspect_nes,
      good_and_bad_people,
      good_and_bad_area,
      average_area,
      cosmopolitan,
      other_neutral_nes,
      nothing_written_in,
      other );

   function Pretty_Print( i : Neigh1_Type ) return String;
   function Null_Or_Missing( i : Neigh1_Type ) return Boolean;
   function Convert_Neigh1_Type( i : String ) return Neigh1_Type;


   type Neigh2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      people_friendly,
      white_area,
      connection_to_area,
      good_public_transport,
      good_shopping_facilities,
      good_entertainment_facilities,
      good_leisure_facilities,
      has_open_spaces,
      good_or_convenient_schools,
      good_church,
      good_medical_facilities,
      neighbours_friendly,
      good_local_facilities_nes,
      area_feels_safe,
      no_drugs,
      no_violence_or_muggings,
      no_car_crime,
      no_burglaries,
      no_vandalism,
      no_crime_nes,
      quiet_area,
      good_area_for_children,
      family_live_in_area,
      town_centre_accessible,
      accessible_to_london,
      good_transport_links,
      rural_surroundings,
      good_for_work,
      affluent_area,
      no_problems_with_traffic,
      good_parking_facilities,
      no_pollution,
      no_housing_problems,
      friends_in_area,
      attractive_buildings,
      like_current_house,
      house_a_good_investment,
      desirable_area,
      area_improved,
      like_the_area_nes,
      other_positive_aspect_nes,
      people_unfriendly,
      neighbours_unfriendly,
      no_family_in_area,
      provacy,
      no_friends_in_area,
      no_privacy,
      no_sense_of_community,
      dislike_racial_mix,
      problems_with_young_people,
      bad_language,
      poor_transport_facilities,
      poor_shopping_facilities,
      poor_entertainment_facilities,
      poor_leisure_facilities,
      good_community,
      lack_of_open_spaces,
      poor_education_facilities,
      no_church_locally,
      poor_medical_facilities,
      poor_local_facilities_nes,
      unsafe_area,
      problems_with_drugs,
      problems_with_violence,
      problems_with_car_crime,
      problems_with_burglary,
      racial_diversity,
      problems_with_vandalism,
      crime_rate_high,
      problems_with_alcohol,
      problems_with_street_gangs,
      police_intrusive,
      noise_problems,
      poor_area_for_children,
      poor_employment_prospects,
      area_deprived,
      traffic_problems,
      kids_well_behaved,
      lack_of_parking_facilities,
      pollution_problems,
      housing_problems,
      area_over_crowded,
      area_becoming_worse,
      dont_like_area_nes,
      other_negative_aspect_nes,
      good_and_bad_people,
      good_and_bad_area,
      average_area,
      cosmopolitan,
      other_neutral_nes,
      other );

   function Pretty_Print( i : Neigh2_Type ) return String;
   function Null_Or_Missing( i : Neigh2_Type ) return Boolean;
   function Convert_Neigh2_Type( i : String ) return Neigh2_Type;


   type Neigh5_Type is (  
      dont_know,
      refused,
      not_mentioned,
      people_friendly,
      white_area,
      connection_to_area,
      good_public_transport,
      good_shopping_facilities,
      good_entertainment_facilities,
      good_leisure_facilities,
      has_open_spaces,
      good_or_convenient_schools,
      good_church,
      good_medical_facilities,
      neighbours_friendly,
      good_local_facilities_nes,
      area_feels_safe,
      no_drugs,
      no_violence_or_muggings,
      no_car_crime,
      no_burglaries,
      no_vandalism,
      no_crime_nes,
      quiet_area,
      good_area_for_children,
      family_live_in_area,
      town_centre_accessible,
      accessible_to_london,
      good_transport_links,
      rural_surroundings,
      good_for_work,
      affluent_area,
      no_problems_with_traffic,
      good_parking_facilities,
      no_pollution,
      no_housing_problems,
      friends_in_area,
      attractive_buildings,
      like_current_house,
      house_a_good_investment,
      desirable_area,
      area_improved,
      like_the_area_nes,
      other_positive_aspect_nes,
      people_unfriendly,
      neighbours_unfriendly,
      no_family_in_area,
      provacy,
      no_friends_in_area,
      no_privacy,
      no_sense_of_community,
      dislike_racial_mix,
      problems_with_young_people,
      bad_language,
      poor_transport_facilities,
      poor_shopping_facilities,
      poor_entertainment_facilities,
      poor_leisure_facilities,
      good_community,
      lack_of_open_spaces,
      poor_education_facilities,
      no_church_locally,
      poor_medical_facilities,
      poor_local_facilities_nes,
      unsafe_area,
      problems_with_drugs,
      problems_with_violence,
      problems_with_car_crime,
      problems_with_burglary,
      racial_diversity,
      problems_with_vandalism,
      crime_rate_high,
      problems_with_alcohol,
      problems_with_street_gangs,
      police_intrusive,
      noise_problems,
      poor_area_for_children,
      poor_employment_prospects,
      area_deprived,
      traffic_problems,
      kids_well_behaved,
      lack_of_parking_facilities,
      pollution_problems,
      housing_problems,
      area_over_crowded,
      area_becoming_worse,
      dont_like_area_nes,
      other_negative_aspect_nes,
      good_and_bad_people,
      good_and_bad_area,
      average_area,
      cosmopolitan,
      other_neutral_nes,
      other );

   function Pretty_Print( i : Neigh5_Type ) return String;
   function Null_Or_Missing( i : Neigh5_Type ) return Boolean;
   function Convert_Neigh5_Type( i : String ) return Neigh5_Type;


   type Nelocly_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing,
      all_or_both_same_hh_ly,
      liv_in_10_sep_hh_ly,
      liv_in_11_sep_hh_ly,
      liv_in_12_sep_hh_ly,
      liv_in_13_sep_hh_ly,
      liv_in_14_sep_hh_ly,
      live_in_2_sep_hh_ly,
      live_in_3_sep_hh_ly,
      live_in_4_sep_hh_ly,
      live_in_5_sep_hh_ly,
      live_in_6_sep_hh_ly,
      live_in_7_sep_hh_ly,
      live_in_8_sep_hh_ly,
      live_in_9_sep_hh_ly );

   function Pretty_Print( i : Nelocly_Type ) return String;
   function Null_Or_Missing( i : Nelocly_Type ) return Boolean;
   function Convert_Nelocly_Type( i : String ) return Nelocly_Type;


   type Nelyr_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      original_member,
      yes,
      no );

   function Pretty_Print( i : Nelyr_Type ) return String;
   function Null_Or_Missing( i : Nelyr_Type ) return Boolean;
   function Convert_Nelyr_Type( i : String ) return Nelyr_Type;


   type Nemnjn_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      original_member,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Nemnjn_Type ) return String;
   function Null_Or_Missing( i : Nemnjn_Type ) return Boolean;
   function Convert_Nemnjn_Type( i : String ) return Nemnjn_Type;


   type Nemst_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      other,
      unemployed,
      retired,
      maternity_leave,
      family_care,
      ft_studt_school,
      lt_sick_disabld,
      gvt_trng_scheme );

   function Pretty_Print( i : Nemst_Type ) return String;
   function Null_Or_Missing( i : Nemst_Type ) return Boolean;
   function Convert_Nemst_Type( i : String ) return Nemst_Type;


   type Net1ag_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      age_given );

   function Pretty_Print( i : Net1ag_Type ) return String;
   function Null_Or_Missing( i : Net1ag_Type ) return Boolean;
   function Convert_Net1ag_Type( i : String ) return Net1ag_Type;


   type Net1et_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      white,
      asian,
      black_african,
      black_caribbean,
      chinese,
      mixed,
      any_other );

   function Pretty_Print( i : Net1et_Type ) return String;
   function Null_Or_Missing( i : Net1et_Type ) return Boolean;
   function Convert_Net1et_Type( i : String ) return Net1et_Type;


   type Net1jb_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      ft_employed,
      pt_employed,
      unemployed,
      ft_educatn,
      ft_housewrk,
      fully_retird );

   function Pretty_Print( i : Net1jb_Type ) return String;
   function Null_Or_Missing( i : Net1jb_Type ) return Boolean;
   function Convert_Net1jb_Type( i : String ) return Net1jb_Type;


   type Net1kn_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      less_than_1_yr,
      s_1_2_yrs,
      s_3_10_yrs,
      s_10_yrs_or_more );

   function Pretty_Print( i : Net1kn_Type ) return String;
   function Null_Or_Missing( i : Net1kn_Type ) return Boolean;
   function Convert_Net1kn_Type( i : String ) return Net1kn_Type;


   type Net1lv_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      less_than_1_mile,
      less_than_5_miles,
      s_5_50_miles,
      over_50_miles );

   function Pretty_Print( i : Net1lv_Type ) return String;
   function Null_Or_Missing( i : Net1lv_Type ) return Boolean;
   function Convert_Net1lv_Type( i : String ) return Net1lv_Type;


   type Net1ph_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      most_days,
      least_once_week,
      least_once_month,
      less_often );

   function Pretty_Print( i : Net1ph_Type ) return String;
   function Null_Or_Missing( i : Net1ph_Type ) return Boolean;
   function Convert_Net1ph_Type( i : String ) return Net1ph_Type;


   type Net1rl_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      partner,
      child,
      sibling,
      parent,
      grandparent,
      grandchild,
      aunt_uncle_cous,
      other );

   function Pretty_Print( i : Net1rl_Type ) return String;
   function Null_Or_Missing( i : Net1rl_Type ) return Boolean;
   function Convert_Net1rl_Type( i : String ) return Net1rl_Type;


   type Netsoc_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_working_nos,
      looking_aft_hme_or_fmly,
      retired,
      unemployed,
      f_or_t_student,
      long_term_sick,
      valid_soc_code,
      insuff_detail );

   function Pretty_Print( i : Netsoc_Type ) return String;
   function Null_Or_Missing( i : Netsoc_Type ) return Boolean;
   function Convert_Netsoc_Type( i : String ) return Netsoc_Type;


   type Netsx1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      male,
      female );

   function Pretty_Print( i : Netsx1_Type ) return String;
   function Null_Or_Missing( i : Netsx1_Type ) return Boolean;
   function Convert_Netsx1_Type( i : String ) return Netsx1_Type;


   type Netuse_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      no_access,
      never,
      less_than_once_a_month,
      once_a_month,
      several_times_a_month,
      several_times_a_week,
      daily );

   function Pretty_Print( i : Netuse_Type ) return String;
   function Null_Or_Missing( i : Netuse_Type ) return Boolean;
   function Convert_Netuse_Type( i : String ) return Netuse_Type;


   type Newhy_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      listed_member,
      new_baby,
      marriage_or_cohab,
      from_college_or_university,
      from_institution,
      never_left,
      moved_in_with_parentss_or_relative,
      shared_accommodation,
      other );

   function Pretty_Print( i : Newhy_Type ) return String;
   function Null_Or_Missing( i : Newhy_Type ) return Boolean;
   function Convert_Newhy_Type( i : String ) return Newhy_Type;


   type Neyrjn_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      original_member,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Neyrjn_Type ) return String;
   function Null_Or_Missing( i : Neyrjn_Type ) return Boolean;
   function Convert_Neyrjn_Type( i : String ) return Neyrjn_Type;


   type Nfhs1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing,
      ni_pension,
      severe_disablement_allowance,
      industrial_injury,
      attendance_allowance,
      pension_from_prev_employer,
      invalid_care_allowance,
      war_disability_pension,
      incapacity_benefit,
      dla_care_component,
      dla_mobility_component,
      dla,
      pension_from_spouses_employer,
      income_support,
      child_benefit,
      one_parent_benefit,
      working_tax_credit,
      housing_benefit,
      private_pension,
      council_tax_benefit,
      job_seekers_allowance,
      child_tax_credit,
      widows_pension,
      educational_grant,
      tu_payment,
      maintenance,
      payment_from_family_member,
      rent_from_lodgers,
      rent_from_other_property,
      foster_allowance,
      accident_insurance,
      widowed_mothers_allowance,
      pension_credit );

   function Pretty_Print( i : Nfhs1_Type ) return String;
   function Null_Or_Missing( i : Nfhs1_Type ) return Boolean;
   function Convert_Nfhs1_Type( i : String ) return Nfhs1_Type;


   type Nfr_Type is (  
      missing_or_wild );

   function Pretty_Print( i : Nfr_Type ) return String;
   function Null_Or_Missing( i : Nfr_Type ) return Boolean;
   function Convert_Nfr_Type( i : String ) return Nfr_Type;


   type Nipop1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      improved_a_lot,
      improved_a_little,
      made_no_difference,
      made_a_little_worse,
      made_a_lot_worse,
      too_early_to_tell );

   function Pretty_Print( i : Nipop1_Type ) return String;
   function Null_Or_Missing( i : Nipop1_Type ) return Boolean;
   function Convert_Nipop1_Type( i : String ) return Nipop1_Type;


   type Nipop2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      strengthened,
      weakened,
      made_no_difference );

   function Pretty_Print( i : Nipop2_Type ) return String;
   function Null_Or_Missing( i : Nipop2_Type ) return Boolean;
   function Convert_Nipop2_Type( i : String ) return Nipop2_Type;


   type Nipop3_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      just_about_always,
      most_of_the_time,
      only_sometimes,
      almost_never );

   function Pretty_Print( i : Nipop3_Type ) return String;
   function Null_Or_Missing( i : Nipop3_Type ) return Boolean;
   function Convert_Nipop3_Type( i : String ) return Nipop3_Type;


   type Nipop5_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      unionist,
      nationalist,
      neither,
      other );

   function Pretty_Print( i : Nipop5_Type ) return String;
   function Null_Or_Missing( i : Nipop5_Type ) return Boolean;
   function Convert_Nipop5_Type( i : String ) return Nipop5_Type;


   type Nipop6_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      ni_indep_of_uk_and_eu,
      ni_ind_of_uk_not_eu,
      ni_in_uk_own_parli,
      ni_in_uk_w_assembly,
      ni_in_uk_no_assembly,
      ni_unify_with_roi );

   function Pretty_Print( i : Nipop6_Type ) return String;
   function Null_Or_Missing( i : Nipop6_Type ) return Boolean;
   function Convert_Nipop6_Type( i : String ) return Nipop6_Type;


   type Nisjsa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      yes );

   function Pretty_Print( i : Nisjsa_Type ) return String;
   function Null_Or_Missing( i : Nisjsa_Type ) return Boolean;
   function Convert_Nisjsa_Type( i : String ) return Nisjsa_Type;


   type Nivfho_Type is (  
      inapplicable,
      all_eligible_hh_intv,
      interviews_plus_proxies,
      interviews_plus_refusal,
      pxy_at_original_addr,
      phone_interview_only,
      youth_interview_only,
      docs_missing_or_unus,
      address_not_found,
      no_hh_member_contact,
      refus_to_rsrch_cntre,
      refusal_to_intviewer,
      language_problems,
      no_intv_age_or_health,
      moved_prev_wave_add,
      out_scope_institutn,
      moved_out_of_scope,
      whole_hh_deceased,
      no_psms_resident,
      adamant_refusal,
      l_t_untraced_wdrawn );

   function Pretty_Print( i : Nivfho_Type ) return String;
   function Null_Or_Missing( i : Nivfho_Type ) return Boolean;
   function Convert_Nivfho_Type( i : String ) return Nivfho_Type;


   type Nivfio_Type is (  
      inapplicable,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_re,
      l_t_untraced_wdrawn,
      lost_capi_intvw,
      dead );

   function Pretty_Print( i : Nivfio_Type ) return String;
   function Null_Or_Missing( i : Nivfio_Type ) return Boolean;
   function Convert_Nivfio_Type( i : String ) return Nivfio_Type;


   type Nivt1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      couldnt_vote );

   function Pretty_Print( i : Nivt1_Type ) return String;
   function Null_Or_Missing( i : Nivt1_Type ) return Boolean;
   function Convert_Nivt1_Type( i : String ) return Nivt1_Type;


   type Nivt2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      conservative,
      ulster_unionist,
      sdlp,
      alliance_party,
      democratic_unionist,
      sinn_fein,
      other_ni_political_party,
      labour,
      liberal_democrat_or_liberal_or_sld,
      scottish_nationalist,
      plaid_cymru,
      green_party,
      other_party,
      other_answer );

   function Pretty_Print( i : Nivt2_Type ) return String;
   function Null_Or_Missing( i : Nivt2_Type ) return Boolean;
   function Convert_Nivt2_Type( i : String ) return Nivt2_Type;


   type Njbnew_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      none );

   function Pretty_Print( i : Njbnew_Type ) return String;
   function Null_Or_Missing( i : Njbnew_Type ) return Boolean;
   function Convert_Njbnew_Type( i : String ) return Njbnew_Type;


   type Nmar_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      never_married,
      once,
      twice,
      three_times,
      more_than_three );

   function Pretty_Print( i : Nmar_Type ) return String;
   function Null_Or_Missing( i : Nmar_Type ) return Boolean;
   function Convert_Nmar_Type( i : String ) return Nmar_Type;


   type Nmwchk_Type is (  
      dont_know,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_before_141999,
      no_after_141999 );

   function Pretty_Print( i : Nmwchk_Type ) return String;
   function Null_Or_Missing( i : Nmwchk_Type ) return Boolean;
   function Convert_Nmwchk_Type( i : String ) return Nmwchk_Type;


   type Nmwhrch_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      basic_hours_increased,
      basic_hours_reduced,
      basic_hours_not_affected );

   function Pretty_Print( i : Nmwhrch_Type ) return String;
   function Null_Or_Missing( i : Nmwhrch_Type ) return Boolean;
   function Convert_Nmwhrch_Type( i : String ) return Nmwhrch_Type;


   type Nmwopch_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      premium_risen,
      premium_fallen,
      premium_the_same,
      no_premium_paid,
      no_paid_overtime,
      other );

   function Pretty_Print( i : Nmwopch_Type ) return String;
   function Null_Or_Missing( i : Nmwopch_Type ) return Boolean;
   function Convert_Nmwopch_Type( i : String ) return Nmwopch_Type;


   type Nmwufxb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      easier_to_find_job,
      harder_to_find_job,
      no_difference );

   function Pretty_Print( i : Nmwufxb_Type ) return String;
   function Null_Or_Missing( i : Nmwufxb_Type ) return Boolean;
   function Convert_Nmwufxb_Type( i : String ) return Nmwufxb_Type;


   type Nocaidu_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      none_of_these );

   function Pretty_Print( i : Nocaidu_Type ) return String;
   function Null_Or_Missing( i : Nocaidu_Type ) return Boolean;
   function Convert_Nocaidu_Type( i : String ) return Nocaidu_Type;


   type Nrptim_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      less_than_6_months,
      s_6_months_1_year,
      s_1_2_years,
      s_2_5_years,
      more_than_5_years );

   function Pretty_Print( i : Nrptim_Type ) return String;
   function Null_Or_Missing( i : Nrptim_Type ) return Boolean;
   function Convert_Nrptim_Type( i : String ) return Nrptim_Type;


   type Nrpxpm1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      expect_to_marry,
      expect_to_cohabit,
      no_plans_to_marry_or_cohabit );

   function Pretty_Print( i : Nrpxpm1_Type ) return String;
   function Null_Or_Missing( i : Nrpxpm1_Type ) return Boolean;
   function Convert_Nrpxpm1_Type( i : String ) return Nrpxpm1_Type;


   type Nvesta_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      nat_savings_cert );

   function Pretty_Print( i : Nvesta_Type ) return String;
   function Null_Or_Missing( i : Nvesta_Type ) return Boolean;
   function Convert_Nvesta_Type( i : String ) return Nvesta_Type;


   type Nvestb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      premium_bonds );

   function Pretty_Print( i : Nvestb_Type ) return String;
   function Null_Or_Missing( i : Nvestb_Type ) return Boolean;
   function Convert_Nvestb_Type( i : String ) return Nvestb_Type;


   type Nvestc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      unit_trusts );

   function Pretty_Print( i : Nvestc_Type ) return String;
   function Null_Or_Missing( i : Nvestc_Type ) return Boolean;
   function Convert_Nvestc_Type( i : String ) return Nvestc_Type;


   type Nvestd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      peps );

   function Pretty_Print( i : Nvestd_Type ) return String;
   function Null_Or_Missing( i : Nvestd_Type ) return Boolean;
   function Convert_Nvestd_Type( i : String ) return Nvestd_Type;


   type Nveste_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      shares );

   function Pretty_Print( i : Nveste_Type ) return String;
   function Null_Or_Missing( i : Nveste_Type ) return Boolean;
   function Convert_Nveste_Type( i : String ) return Nveste_Type;


   type Nvestf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      ns_or_bs_or_ins_bonds );

   function Pretty_Print( i : Nvestf_Type ) return String;
   function Null_Or_Missing( i : Nvestf_Type ) return Boolean;
   function Convert_Nvestf_Type( i : String ) return Nvestf_Type;


   type Nvestg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      other_invest_or_secur );

   function Pretty_Print( i : Nvestg_Type ) return String;
   function Null_Or_Missing( i : Nvestg_Type ) return Boolean;
   function Convert_Nvestg_Type( i : String ) return Nvestg_Type;


   type Nvesth_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      savings_or_deposits );

   function Pretty_Print( i : Nvesth_Type ) return String;
   function Null_Or_Missing( i : Nvesth_Type ) return Boolean;
   function Convert_Nvesth_Type( i : String ) return Nvesth_Type;


   type Nvesti_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      natsavings_bank );

   function Pretty_Print( i : Nvesti_Type ) return String;
   function Null_Or_Missing( i : Nvesti_Type ) return Boolean;
   function Convert_Nvesti_Type( i : String ) return Nvesti_Type;


   type Nvestj_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      yes,
      no );

   function Pretty_Print( i : Nvestj_Type ) return String;
   function Null_Or_Missing( i : Nvestj_Type ) return Boolean;
   function Convert_Nvestj_Type( i : String ) return Nvestj_Type;


   type Nvestl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      national_savings_certificate,
      premium_bonds,
      unit_trusts,
      personal_equity_plans,
      shares_uk_or_foreign,
      ns_or_bs_insurance_bonds,
      other_investments );

   function Pretty_Print( i : Nvestl_Type ) return String;
   function Null_Or_Missing( i : Nvestl_Type ) return Boolean;
   function Convert_Nvestl_Type( i : String ) return Nvestl_Type;


   type Nvestn_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      one_only,
      two_or_more );

   function Pretty_Print( i : Nvestn_Type ) return String;
   function Null_Or_Missing( i : Nvestn_Type ) return Boolean;
   function Convert_Nvestn_Type( i : String ) return Nvestn_Type;


   type Nwstat_Type is (  
      missing_household,
      still_co_resident,
      different_household,
      blank,
      alter_out_of_scope,
      alter_died,
      both_non_resp_dk,
      ego_left_sample,
      ego_died_or_out_scope );

   function Pretty_Print( i : Nwstat_Type ) return String;
   function Null_Or_Missing( i : Nwstat_Type ) return Boolean;
   function Convert_Nwstat_Type( i : String ) return Nwstat_Type;


   type Nxdts_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      one,
      two,
      three,
      four_plus );

   function Pretty_Print( i : Nxdts_Type ) return String;
   function Null_Or_Missing( i : Nxdts_Type ) return Boolean;
   function Convert_Nxdts_Type( i : String ) return Nxdts_Type;


   type Ocimpa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      very_important,
      important,
      not_important,
      not_at_all_important );

   function Pretty_Print( i : Ocimpa_Type ) return String;
   function Null_Or_Missing( i : Ocimpa_Type ) return Boolean;
   function Convert_Ocimpa_Type( i : String ) return Ocimpa_Type;


   type Ohch16_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Ohch16_Type ) return String;
   function Null_Or_Missing( i : Ohch16_Type ) return Boolean;
   function Convert_Ohch16_Type( i : String ) return Ohch16_Type;


   type Oivfio_Type is (  
      inapplicable,
      full_interview,
      refusal,
      other_non_intvw,
      moved,
      proxy_interview,
      child_under_16,
      youth_interview,
      youth_refusal,
      youth_oth_non_int,
      child_under_11,
      telephone_intvw,
      refusal_or_non_int_hh,
      non_int_or_non_int_hh,
      moved_or_non_int_hh,
      child_in_non_int_hh,
      youth_ref_or_no_int_hh,
      youth_oth_or_no_int_hh,
      child_u_11_no_int_hh,
      refusal_or_non_cont_hh,
      lang_prob_or_nc_hh,
      age_infirm_or_nc_hh,
      non_cont_or_nc_hh,
      out_of_scope_or_nc_hh,
      institutnsd_or_nc_hh,
      untraced_mover,
      child_ref_or_nc_hh,
      chd_lang_prob_or_nc_hh,
      chd_infirm_or_nc_hh,
      chd_non_cont_or_nc_hh,
      chd_o_o_scope_or_nc_hh,
      chd_instit_or_nc_hh,
      chd_untraced_mover,
      no_one_elig_in_hh,
      prev_wave_adamant_re,
      l_t_untraced_wdrawn,
      withdrawn_before_field,
      lost_capi_intvw,
      other_retiring,
      dead );

   function Pretty_Print( i : Oivfio_Type ) return String;
   function Null_Or_Missing( i : Oivfio_Type ) return Boolean;
   function Convert_Oivfio_Type( i : String ) return Oivfio_Type;


   type Opcca_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_i_believe_this,
      no_i_do_not_believe_this );

   function Pretty_Print( i : Opcca_Type ) return String;
   function Null_Or_Missing( i : Opcca_Type ) return Boolean;
   function Convert_Opcca_Type( i : String ) return Opcca_Type;


   type Opchd1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      missing_or_wild,
      well_liked,
      think_for_self,
      work_hard,
      help_others,
      obey_parents );

   function Pretty_Print( i : Opchd1_Type ) return String;
   function Null_Or_Missing( i : Opchd1_Type ) return Boolean;
   function Convert_Opchd1_Type( i : String ) return Opchd1_Type;


   type Opcls2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      nothing_written_in,
      lower_wrkng_class,
      no_partic_class,
      refuse_class_cat,
      working_class,
      upper_wrkng_class,
      lower_mid_class,
      middle_class,
      upper_mid_class,
      upper_class,
      other_not_class,
      other );

   function Pretty_Print( i : Opcls2_Type ) return String;
   function Null_Or_Missing( i : Opcls2_Type ) return Boolean;
   function Convert_Opcls2_Type( i : String ) return Opcls2_Type;


   type Opcls3_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      a_great_deal,
      quite_a_lot,
      not_very_much,
      not_at_all,
      other );

   function Pretty_Print( i : Opcls3_Type ) return String;
   function Null_Or_Missing( i : Opcls3_Type ) return Boolean;
   function Convert_Opcls3_Type( i : String ) return Opcls3_Type;


   type Opdev1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      s_or_w_indep_from_uk_and_eu,
      s_or_w_indep_from_uk_within_eu,
      s_or_w_in_uk_taxation_powers,
      s_or_w_in_uk_no_taxation_powers,
      s_or_w_in_uk_no_legislature );

   function Pretty_Print( i : Opdev1_Type ) return String;
   function Null_Or_Missing( i : Opdev1_Type ) return Boolean;
   function Convert_Opdev1_Type( i : String ) return Opdev1_Type;


   type Opdev2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      s_or_w_not_british,
      more_s_or_w_than_british,
      equally_s_or_w_and_british,
      more_british_than_s_or_w,
      british_not_s_or_w,
      other,
      none_of_these );

   function Pretty_Print( i : Opdev2_Type ) return String;
   function Null_Or_Missing( i : Opdev2_Type ) return Boolean;
   function Convert_Opdev2_Type( i : String ) return Opdev2_Type;


   type Opdvni1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      independent,
      part_of_eu,
      some_taxes_powers,
      no_taxes_powers,
      no_parl_or_assembly,
      unify_with_republic_of_ireland );

   function Pretty_Print( i : Opdvni1_Type ) return String;
   function Null_Or_Missing( i : Opdvni1_Type ) return Boolean;
   function Convert_Opdvni1_Type( i : String ) return Opdvni1_Type;


   type Opdvni2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      just_about_always,
      most_of_the_time,
      only_some_of_the_time,
      almost_never );

   function Pretty_Print( i : Opdvni2_Type ) return String;
   function Null_Or_Missing( i : Opdvni2_Type ) return Boolean;
   function Convert_Opdvni2_Type( i : String ) return Opdvni2_Type;


   type Openv1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      neither_agree_nor_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Openv1_Type ) return String;
   function Null_Or_Missing( i : Openv1_Type ) return Boolean;
   function Convert_Openv1_Type( i : String ) return Openv1_Type;


   type Openva_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      agree_strongly,
      agree,
      disagree,
      disagree_strongly );

   function Pretty_Print( i : Openva_Type ) return String;
   function Null_Or_Missing( i : Openva_Type ) return Boolean;
   function Convert_Openva_Type( i : String ) return Openva_Type;


   type Openvb_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      agree_strongly,
      agree,
      disagree,
      disagree_strongly,
      already_changed_way_of_life );

   function Pretty_Print( i : Openvb_Type ) return String;
   function Null_Or_Missing( i : Openvb_Type ) return Boolean;
   function Convert_Openvb_Type( i : String ) return Openvb_Type;


   type Openvc_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      frequently,
      sometimes,
      rarely,
      never );

   function Pretty_Print( i : Openvc_Type ) return String;
   function Null_Or_Missing( i : Openvc_Type ) return Boolean;
   function Convert_Openvc_Type( i : String ) return Openvc_Type;


   type Opeur1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      a_good_thing,
      a_bad_thing,
      neither_good_nor_bad );

   function Pretty_Print( i : Opeur1_Type ) return String;
   function Null_Or_Missing( i : Opeur1_Type ) return Boolean;
   function Convert_Opeur1_Type( i : String ) return Opeur1_Type;


   type Opeur2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      benefited,
      not_benefited );

   function Pretty_Print( i : Opeur2_Type ) return String;
   function Null_Or_Missing( i : Opeur2_Type ) return Boolean;
   function Convert_Opeur2_Type( i : String ) return Opeur2_Type;


   type Opeur3_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      leave_the_eu,
      stay_in_cut_eu_power,
      leave_things_as_they_are,
      stay_in_more_eu_powr,
      form_single_eu_govt );

   function Pretty_Print( i : Opeur3_Type ) return String;
   function Null_Or_Missing( i : Opeur3_Type ) return Boolean;
   function Convert_Opeur3_Type( i : String ) return Opeur3_Type;


   type Opeur4_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      join_the_euro,
      not_join_the_euro,
      would_not_vote );

   function Pretty_Print( i : Opeur4_Type ) return String;
   function Null_Or_Missing( i : Opeur4_Type ) return Boolean;
   function Convert_Opeur4_Type( i : String ) return Opeur4_Type;


   type Opfama_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      not_agree_or_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opfama_Type ) return String;
   function Null_Or_Missing( i : Opfama_Type ) return Boolean;
   function Convert_Opfama_Type( i : String ) return Opfama_Type;


   type Opfamj_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      neithr_agree_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opfamj_Type ) return String;
   function Null_Or_Missing( i : Opfamj_Type ) return Boolean;
   function Convert_Opfamj_Type( i : String ) return Opfamj_Type;


   type Opfamo_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      neithr_agree_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opfamo_Type ) return String;
   function Null_Or_Missing( i : Opfamo_Type ) return Boolean;
   function Convert_Opfamo_Type( i : String ) return Opfamo_Type;


   type Opfamq_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      neithr_agree_disagr,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opfamq_Type ) return String;
   function Null_Or_Missing( i : Opfamq_Type ) return Boolean;
   function Convert_Opfamq_Type( i : String ) return Opfamq_Type;


   type Opfamr_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      neithr_agree_disagr,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opfamr_Type ) return String;
   function Null_Or_Missing( i : Opfamr_Type ) return Boolean;
   function Convert_Opfamr_Type( i : String ) return Opfamr_Type;


   type Ophla_Type is (  
      cant_choose,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      not_agree_or_disagree,
      disagree,
      strongly_disagr );

   function Pretty_Print( i : Ophla_Type ) return String;
   function Null_Or_Missing( i : Ophla_Type ) return Boolean;
   function Convert_Ophla_Type( i : String ) return Ophla_Type;


   type Ophlb_Type is (  
      cant_choose,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      not_agree_or_disagr,
      disagree,
      strongly_disagr );

   function Pretty_Print( i : Ophlb_Type ) return String;
   function Null_Or_Missing( i : Ophlb_Type ) return Boolean;
   function Convert_Ophlb_Type( i : String ) return Ophlb_Type;


   type Opiss1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      great_deal,
      fair_amount,
      not_very_much,
      not_at_all );

   function Pretty_Print( i : Opiss1_Type ) return String;
   function Null_Or_Missing( i : Opiss1_Type ) return Boolean;
   function Convert_Opiss1_Type( i : String ) return Opiss1_Type;


   type Opnata_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      strongly_agree,
      agree,
      neither_agree_or_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opnata_Type ) return String;
   function Null_Or_Missing( i : Opnata_Type ) return Boolean;
   function Convert_Opnata_Type( i : String ) return Opnata_Type;


   type Opnisec_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      unionist,
      nationalist,
      neither,
      other );

   function Pretty_Print( i : Opnisec_Type ) return String;
   function Null_Or_Missing( i : Opnisec_Type ) return Boolean;
   function Convert_Opnisec_Type( i : String ) return Opnisec_Type;


   type Oppol1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      maintain_order,
      people_more_say,
      rising_prices,
      free_speech );

   function Pretty_Print( i : Oppol1_Type ) return String;
   function Null_Or_Missing( i : Oppol1_Type ) return Boolean;
   function Convert_Oppol1_Type( i : String ) return Oppol1_Type;


   type Oppol2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      maintain_order,
      people_more_say,
      rising_prices,
      freedom_of_speech );

   function Pretty_Print( i : Oppol2_Type ) return String;
   function Null_Or_Missing( i : Oppol2_Type ) return Boolean;
   function Convert_Oppol2_Type( i : String ) return Oppol2_Type;


   type Oppol3_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      inflation,
      unemployment,
      neither );

   function Pretty_Print( i : Oppol3_Type ) return String;
   function Null_Or_Missing( i : Oppol3_Type ) return Boolean;
   function Convert_Oppol3_Type( i : String ) return Oppol3_Type;


   type Oppol4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      living_standards,
      the_environment,
      neither );

   function Pretty_Print( i : Oppol4_Type ) return String;
   function Null_Or_Missing( i : Oppol4_Type ) return Boolean;
   function Convert_Oppol4_Type( i : String ) return Oppol4_Type;


   type Oppola_Type is (  
      cant_choose,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      not_agree_disagree,
      disagree,
      strongly_disagree,
      dont_know );

   function Pretty_Print( i : Oppola_Type ) return String;
   function Null_Or_Missing( i : Oppola_Type ) return Boolean;
   function Convert_Oppola_Type( i : String ) return Oppola_Type;


   type Oprlg1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_religion,
      muslim_or_islam,
      hindu,
      jewish,
      sikh,
      other,
      catholic_ni,
      presbyterian_ni,
      church_of_irelandni,
      c_of_e_or_anglican,
      methodist_ni,
      baptist_ni,
      free_presbyterianni,
      bretheren_ni,
      protestant_nesni,
      other_christianni,
      jewish_ni,
      oth_non_christianni,
      roman_catholic,
      presbyt_or_c_of_scot,
      methodist,
      baptist,
      congregation_or_urc,
      other_christian,
      christian );

   function Pretty_Print( i : Oprlg1_Type ) return String;
   function Null_Or_Missing( i : Oprlg1_Type ) return Boolean;
   function Convert_Oprlg1_Type( i : String ) return Oprlg1_Type;


   type Oprlg2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      once_a_wk_or_plus,
      at_least_1x_month,
      at_least_1x_year,
      practically_never,
      only_weddings_etc );

   function Pretty_Print( i : Oprlg2_Type ) return String;
   function Null_Or_Missing( i : Oprlg2_Type ) return Boolean;
   function Convert_Oprlg2_Type( i : String ) return Oprlg2_Type;


   type Oprlg3_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      a_little_diff,
      some_diff,
      a_great_diff,
      no_difference );

   function Pretty_Print( i : Oprlg3_Type ) return String;
   function Null_Or_Missing( i : Oprlg3_Type ) return Boolean;
   function Convert_Oprlg3_Type( i : String ) return Oprlg3_Type;


   type Oprlg4_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      yes,
      unwilling_to_answer,
      no_religion );

   function Pretty_Print( i : Oprlg4_Type ) return String;
   function Null_Or_Missing( i : Oprlg4_Type ) return Boolean;
   function Convert_Oprlg4_Type( i : String ) return Oprlg4_Type;


   type Oprlg5_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      catholic,
      jewish,
      other_non_christian,
      no_religion,
      muslim,
      sikh,
      any_other_religion,
      presbyterian,
      church_of_ireland,
      methodist,
      baptist,
      free_presbyterian,
      brethren,
      protestant_not_specified,
      other_christian );

   function Pretty_Print( i : Oprlg5_Type ) return String;
   function Null_Or_Missing( i : Oprlg5_Type ) return Boolean;
   function Convert_Oprlg5_Type( i : String ) return Oprlg5_Type;


   type Oprlg6_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      catholic,
      jewish,
      other_non_christian,
      no_religion,
      presbyterian,
      church_of_ireland,
      methodist,
      baptist,
      free_presbyterian,
      brethren,
      protestant_not_specified,
      other_christian );

   function Pretty_Print( i : Oprlg6_Type ) return String;
   function Null_Or_Missing( i : Oprlg6_Type ) return Boolean;
   function Convert_Oprlg6_Type( i : String ) return Oprlg6_Type;


   type Opsocb_Type is (  
      cant_choose,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      not_agree_or_disag,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opsocb_Type ) return String;
   function Null_Or_Missing( i : Opsocb_Type ) return Boolean;
   function Convert_Opsocb_Type( i : String ) return Opsocb_Type;


   type Opsocd_Type is (  
      cant_choose,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      not_agree_or_disag,
      disagree,
      strongly_disagr );

   function Pretty_Print( i : Opsocd_Type ) return String;
   function Null_Or_Missing( i : Opsocd_Type ) return Boolean;
   function Convert_Opsocd_Type( i : String ) return Opsocd_Type;


   type Opsocg_Type is (  
      cant_choose,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      strongly_agree,
      agree,
      neither_agree_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Opsocg_Type ) return String;
   function Null_Or_Missing( i : Opsocg_Type ) return Boolean;
   function Convert_Opsocg_Type( i : String ) return Opsocg_Type;


   type Opxpcr_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      ok_to_use_credit,
      especially_reluctant,
      neither_ok_or_reluctant,
      never_use_credit,
      cant_get_credit );

   function Pretty_Print( i : Opxpcr_Type ) return String;
   function Null_Or_Missing( i : Opxpcr_Type ) return Boolean;
   function Convert_Opxpcr_Type( i : String ) return Opxpcr_Type;


   type Opxpsv_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      ok_to_use_savings,
      especially_reluctant,
      neither_ok_or_reluctant,
      has_no_savings );

   function Pretty_Print( i : Opxpsv_Type ) return String;
   function Null_Or_Missing( i : Opxpsv_Type ) return Boolean;
   function Convert_Opxpsv_Type( i : String ) return Opxpsv_Type;


   type Orgaa_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_polit_party );

   function Pretty_Print( i : Orgaa_Type ) return String;
   function Null_Or_Missing( i : Orgaa_Type ) return Boolean;
   function Convert_Orgaa_Type( i : String ) return Orgaa_Type;


   type Orgab_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_trade_union );

   function Pretty_Print( i : Orgab_Type ) return String;
   function Null_Or_Missing( i : Orgab_Type ) return Boolean;
   function Convert_Orgab_Type( i : String ) return Orgab_Type;


   type Orgac_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_envir_grp );

   function Pretty_Print( i : Orgac_Type ) return String;
   function Null_Or_Missing( i : Orgac_Type ) return Boolean;
   function Convert_Orgac_Type( i : String ) return Orgac_Type;


   type Orgad_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_parent_or_schl_assoc );

   function Pretty_Print( i : Orgad_Type ) return String;
   function Null_Or_Missing( i : Orgad_Type ) return Boolean;
   function Convert_Orgad_Type( i : String ) return Orgad_Type;


   type Orgae_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_tenants_or_res_grp );

   function Pretty_Print( i : Orgae_Type ) return String;
   function Null_Or_Missing( i : Orgae_Type ) return Boolean;
   function Convert_Orgae_Type( i : String ) return Orgae_Type;


   type Orgaf_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_relig_grp );

   function Pretty_Print( i : Orgaf_Type ) return String;
   function Null_Or_Missing( i : Orgaf_Type ) return Boolean;
   function Convert_Orgaf_Type( i : String ) return Orgaf_Type;


   type Orgag_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_vol_svce_grp );

   function Pretty_Print( i : Orgag_Type ) return String;
   function Null_Or_Missing( i : Orgag_Type ) return Boolean;
   function Convert_Orgag_Type( i : String ) return Orgag_Type;


   type Orgah_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_other_civic_grp );

   function Pretty_Print( i : Orgah_Type ) return String;
   function Null_Or_Missing( i : Orgah_Type ) return Boolean;
   function Convert_Orgah_Type( i : String ) return Orgah_Type;


   type Orgai_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_social_club );

   function Pretty_Print( i : Orgai_Type ) return String;
   function Null_Or_Missing( i : Orgai_Type ) return Boolean;
   function Convert_Orgai_Type( i : String ) return Orgai_Type;


   type Orgaj_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_sports_club );

   function Pretty_Print( i : Orgaj_Type ) return String;
   function Null_Or_Missing( i : Orgaj_Type ) return Boolean;
   function Convert_Orgaj_Type( i : String ) return Orgaj_Type;


   type Orgak_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_womens_inst );

   function Pretty_Print( i : Orgak_Type ) return String;
   function Null_Or_Missing( i : Orgak_Type ) return Boolean;
   function Convert_Orgak_Type( i : String ) return Orgak_Type;


   type Orgal_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_womens_grp );

   function Pretty_Print( i : Orgal_Type ) return String;
   function Null_Or_Missing( i : Orgal_Type ) return Boolean;
   function Convert_Orgal_Type( i : String ) return Orgal_Type;


   type Orgam_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_other_group );

   function Pretty_Print( i : Orgam_Type ) return String;
   function Null_Or_Missing( i : Orgam_Type ) return Boolean;
   function Convert_Orgam_Type( i : String ) return Orgam_Type;


   type Orgao_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_prof_assoc );

   function Pretty_Print( i : Orgao_Type ) return String;
   function Null_Or_Missing( i : Orgao_Type ) return Boolean;
   function Convert_Orgao_Type( i : String ) return Orgao_Type;


   type Orgap_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_pensioner_gp );

   function Pretty_Print( i : Orgap_Type ) return String;
   function Null_Or_Missing( i : Orgap_Type ) return Boolean;
   function Convert_Orgap_Type( i : String ) return Orgap_Type;


   type Orgaq_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      active_scouts_or_guides );

   function Pretty_Print( i : Orgaq_Type ) return String;
   function Null_Or_Missing( i : Orgaq_Type ) return Boolean;
   function Convert_Orgaq_Type( i : String ) return Orgaq_Type;


   type Orgma_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_polit_party );

   function Pretty_Print( i : Orgma_Type ) return String;
   function Null_Or_Missing( i : Orgma_Type ) return Boolean;
   function Convert_Orgma_Type( i : String ) return Orgma_Type;


   type Orgmb_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_trade_union );

   function Pretty_Print( i : Orgmb_Type ) return String;
   function Null_Or_Missing( i : Orgmb_Type ) return Boolean;
   function Convert_Orgmb_Type( i : String ) return Orgmb_Type;


   type Orgmc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_envir_grp );

   function Pretty_Print( i : Orgmc_Type ) return String;
   function Null_Or_Missing( i : Orgmc_Type ) return Boolean;
   function Convert_Orgmc_Type( i : String ) return Orgmc_Type;


   type Orgmd_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_parent_or_schl_assoc );

   function Pretty_Print( i : Orgmd_Type ) return String;
   function Null_Or_Missing( i : Orgmd_Type ) return Boolean;
   function Convert_Orgmd_Type( i : String ) return Orgmd_Type;


   type Orgme_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      memb_tenants_or_res_grp );

   function Pretty_Print( i : Orgme_Type ) return String;
   function Null_Or_Missing( i : Orgme_Type ) return Boolean;
   function Convert_Orgme_Type( i : String ) return Orgme_Type;


   type Orgmf_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_relig_grp );

   function Pretty_Print( i : Orgmf_Type ) return String;
   function Null_Or_Missing( i : Orgmf_Type ) return Boolean;
   function Convert_Orgmf_Type( i : String ) return Orgmf_Type;


   type Orgmg_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_vol_svce_grp );

   function Pretty_Print( i : Orgmg_Type ) return String;
   function Null_Or_Missing( i : Orgmg_Type ) return Boolean;
   function Convert_Orgmg_Type( i : String ) return Orgmg_Type;


   type Orgmh_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_other_civic_grp );

   function Pretty_Print( i : Orgmh_Type ) return String;
   function Null_Or_Missing( i : Orgmh_Type ) return Boolean;
   function Convert_Orgmh_Type( i : String ) return Orgmh_Type;


   type Orgmi_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_social_club );

   function Pretty_Print( i : Orgmi_Type ) return String;
   function Null_Or_Missing( i : Orgmi_Type ) return Boolean;
   function Convert_Orgmi_Type( i : String ) return Orgmi_Type;


   type Orgmj_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_sports_club );

   function Pretty_Print( i : Orgmj_Type ) return String;
   function Null_Or_Missing( i : Orgmj_Type ) return Boolean;
   function Convert_Orgmj_Type( i : String ) return Orgmj_Type;


   type Orgmk_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_womens_inst );

   function Pretty_Print( i : Orgmk_Type ) return String;
   function Null_Or_Missing( i : Orgmk_Type ) return Boolean;
   function Convert_Orgmk_Type( i : String ) return Orgmk_Type;


   type Orgml_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_womens_grp );

   function Pretty_Print( i : Orgml_Type ) return String;
   function Null_Or_Missing( i : Orgml_Type ) return Boolean;
   function Convert_Orgml_Type( i : String ) return Orgml_Type;


   type Orgmm_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_other_group );

   function Pretty_Print( i : Orgmm_Type ) return String;
   function Null_Or_Missing( i : Orgmm_Type ) return Boolean;
   function Convert_Orgmm_Type( i : String ) return Orgmm_Type;


   type Orgmo_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_prof_assoc );

   function Pretty_Print( i : Orgmo_Type ) return String;
   function Null_Or_Missing( i : Orgmo_Type ) return Boolean;
   function Convert_Orgmo_Type( i : String ) return Orgmo_Type;


   type Orgmp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_pensioner_gp );

   function Pretty_Print( i : Orgmp_Type ) return String;
   function Null_Or_Missing( i : Orgmp_Type ) return Boolean;
   function Convert_Orgmp_Type( i : String ) return Orgmp_Type;


   type Orgmq_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      member_scouts_or_guides );

   function Pretty_Print( i : Orgmq_Type ) return String;
   function Null_Or_Missing( i : Orgmq_Type ) return Boolean;
   function Convert_Orgmq_Type( i : String ) return Orgmq_Type;


   type Ovtchc_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      overtime_req_by_employer,
      free_choice,
      neither );

   function Pretty_Print( i : Ovtchc_Type ) return String;
   function Null_Or_Missing( i : Ovtchc_Type ) return Boolean;
   function Convert_Ovtchc_Type( i : String ) return Ovtchc_Type;


   type Ovtrate_Type is (  
      dont_know,
      refused,
      no_paid_overtime,
      no_set_amount,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Ovtrate_Type ) return String;
   function Null_Or_Missing( i : Ovtrate_Type ) return Boolean;
   function Convert_Ovtrate_Type( i : String ) return Ovtrate_Type;


   type Paaida_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      giving_them_lifts_in_your_car );

   function Pretty_Print( i : Paaida_Type ) return String;
   function Null_Or_Missing( i : Paaida_Type ) return Boolean;
   function Convert_Paaida_Type( i : String ) return Paaida_Type;


   type Paaidb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      shopping_for_them );

   function Pretty_Print( i : Paaidb_Type ) return String;
   function Null_Or_Missing( i : Paaidb_Type ) return Boolean;
   function Convert_Paaidb_Type( i : String ) return Paaidb_Type;


   type Paaidc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      providing_or_cooking_meals );

   function Pretty_Print( i : Paaidc_Type ) return String;
   function Null_Or_Missing( i : Paaidc_Type ) return Boolean;
   function Convert_Paaidc_Type( i : String ) return Paaidc_Type;


   type Paaidd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      helping_with_basic_personal_needs );

   function Pretty_Print( i : Paaidd_Type ) return String;
   function Null_Or_Missing( i : Paaidd_Type ) return Boolean;
   function Convert_Paaidd_Type( i : String ) return Paaidd_Type;


   type Paaide_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      washing_ironing_or_cleaning );

   function Pretty_Print( i : Paaide_Type ) return String;
   function Null_Or_Missing( i : Paaide_Type ) return Boolean;
   function Convert_Paaide_Type( i : String ) return Paaide_Type;


   type Paaidf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      dealing_with_personal_affairs );

   function Pretty_Print( i : Paaidf_Type ) return String;
   function Null_Or_Missing( i : Paaidf_Type ) return Boolean;
   function Convert_Paaidf_Type( i : String ) return Paaidf_Type;


   type Paaidg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      decorating_gardening_or_house_repairs );

   function Pretty_Print( i : Paaidg_Type ) return String;
   function Null_Or_Missing( i : Paaidg_Type ) return Boolean;
   function Convert_Paaidg_Type( i : String ) return Paaidg_Type;


   type Paaidh_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      financial_help );

   function Pretty_Print( i : Paaidh_Type ) return String;
   function Null_Or_Missing( i : Paaidh_Type ) return Boolean;
   function Convert_Paaidh_Type( i : String ) return Paaidh_Type;


   type Paaidi_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      anything_else );

   function Pretty_Print( i : Paaidi_Type ) return String;
   function Null_Or_Missing( i : Paaidi_Type ) return Boolean;
   function Convert_Paaidi_Type( i : String ) return Paaidi_Type;


   type Pafar_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      less_than_15_minutes,
      between_15_and_30_minutes,
      between_30_minutes_and_one_hour,
      between_one_and_two_hours,
      more_than_two_hours,
      lives_abroadvolunteered,
      never_visited );

   function Pretty_Print( i : Pafar_Type ) return String;
   function Null_Or_Missing( i : Pafar_Type ) return Boolean;
   function Convert_Pafar_Type( i : String ) return Pafar_Type;


   type Paidud_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      looking_after_your_children,
      helped_with_needs );

   function Pretty_Print( i : Paidud_Type ) return String;
   function Null_Or_Missing( i : Paidud_Type ) return Boolean;
   function Convert_Paidud_Type( i : String ) return Paidud_Type;


   type Paju_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      father_not_work,
      father_deceased,
      father_not_live );

   function Pretty_Print( i : Paju_Type ) return String;
   function Null_Or_Missing( i : Paju_Type ) return Boolean;
   function Convert_Paju_Type( i : String ) return Paju_Type;


   type Paper1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      daily_express,
      the_independent,
      the_times,
      morning_star,
      irish_or_regional_daily,
      other,
      daily_mail,
      daily_mirror_or_record,
      daily_star,
      the_sun,
      today,
      daily_telegraph,
      financial_times,
      the_guardian );

   function Pretty_Print( i : Paper1_Type ) return String;
   function Null_Or_Missing( i : Paper1_Type ) return Boolean;
   function Convert_Paper1_Type( i : String ) return Paper1_Type;


   type Paper2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      daily_express,
      the_independent,
      the_times,
      morning_star,
      irish_or_regional_daily,
      other,
      daily_mail,
      daily_mirror_or_record,
      daily_star,
      the_sun,
      today,
      daily_telegraph,
      financial_times,
      the_guardian );

   function Pretty_Print( i : Paper2_Type ) return String;
   function Null_Or_Missing( i : Paper2_Type ) return Boolean;
   function Convert_Paper2_Type( i : String ) return Paper2_Type;


   type Paperm_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      daily_express,
      the_independent,
      the_times,
      morning_star,
      irish_or_regional_daily,
      other,
      the_irish_news,
      the_newsletter,
      daily_post,
      irish_news,
      daily_mail,
      belfast_telegraph,
      other_s_or_w_or_eng_or_ni_reg_or_local_dly_am_paper,
      other_eng_or_i_or_w_or_s_am_regional_paper,
      other_daily_am_paper,
      evening_paper_or_other,
      daily_mirror_or_record,
      daily_star,
      the_sun,
      today,
      daily_telegraph,
      financial_times,
      the_guardian );

   function Pretty_Print( i : Paperm_Type ) return String;
   function Null_Or_Missing( i : Paperm_Type ) return Boolean;
   function Convert_Paperm_Type( i : String ) return Paperm_Type;


   type Paperp_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      conservative,
      democratic_unionist,
      sinn_fein,
      other_irish_party,
      other_party,
      none,
      labour,
      other,
      plaid_cymru,
      green_party,
      ulster_unionist,
      sdlp,
      alliance_party );

   function Pretty_Print( i : Paperp_Type ) return String;
   function Null_Or_Missing( i : Paperp_Type ) return Boolean;
   function Convert_Paperp_Type( i : String ) return Paperp_Type;


   type Payck1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      same_job_promotion_int_prev_year,
      int_prev_year_no_promotion,
      int_2_yrs_same_job_promotion,
      int_2_yrs_not_same_job,
      other_int_2_yrs,
      not_int_2_yrs,
      other );

   function Pretty_Print( i : Payck1_Type ) return String;
   function Null_Or_Missing( i : Payck1_Type ) return Boolean;
   function Convert_Payck1_Type( i : String ) return Payck1_Type;


   type Paydf1_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      incl_back_pay );

   function Pretty_Print( i : Paydf1_Type ) return String;
   function Null_Or_Missing( i : Paydf1_Type ) return Boolean;
   function Convert_Paydf1_Type( i : String ) return Paydf1_Type;


   type Paydf2_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      incl_adv_holiday_pay );

   function Pretty_Print( i : Paydf2_Type ) return String;
   function Null_Or_Missing( i : Paydf2_Type ) return Boolean;
   function Convert_Paydf2_Type( i : String ) return Paydf2_Type;


   type Paydf3_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      incl_tax_refund );

   function Pretty_Print( i : Paydf3_Type ) return String;
   function Null_Or_Missing( i : Paydf3_Type ) return Boolean;
   function Convert_Paydf3_Type( i : String ) return Paydf3_Type;


   type Paydf4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      incl_stat_sick_pay );

   function Pretty_Print( i : Paydf4_Type ) return String;
   function Null_Or_Missing( i : Paydf4_Type ) return Boolean;
   function Convert_Paydf4_Type( i : String ) return Paydf4_Type;


   type Paydf5_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      abs_or_no_sick_pay_included );

   function Pretty_Print( i : Paydf5_Type ) return String;
   function Null_Or_Missing( i : Paydf5_Type ) return Boolean;
   function Convert_Paydf5_Type( i : String ) return Paydf5_Type;


   type Paydf6_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      incl_maternity_pay );

   function Pretty_Print( i : Paydf6_Type ) return String;
   function Null_Or_Missing( i : Paydf6_Type ) return Boolean;
   function Convert_Paydf6_Type( i : String ) return Paydf6_Type;


   type Paydf7_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      unusual_amt_overtime );

   function Pretty_Print( i : Paydf7_Type ) return String;
   function Null_Or_Missing( i : Paydf7_Type ) return Boolean;
   function Convert_Paydf7_Type( i : String ) return Paydf7_Type;


   type Paydf8_Type is (  
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other,
      yes );

   function Pretty_Print( i : Paydf8_Type ) return String;
   function Null_Or_Missing( i : Paydf8_Type ) return Boolean;
   function Convert_Paydf8_Type( i : String ) return Paydf8_Type;


   type Paydf9_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      inc_bonus_or_tip_or_comm,
      yes );

   function Pretty_Print( i : Paydf9_Type ) return String;
   function Null_Or_Missing( i : Paydf9_Type ) return Boolean;
   function Convert_Paydf9_Type( i : String ) return Paydf9_Type;


   type Paygw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      per_hour,
      one_off_payment,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      week,
      fortnight,
      four_weeks,
      calendar_month,
      year,
      other );

   function Pretty_Print( i : Paygw_Type ) return String;
   function Null_Or_Missing( i : Paygw_Type ) return Boolean;
   function Convert_Paygw_Type( i : String ) return Paygw_Type;


   type Paygya_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      gross_income,
      est_gross_income,
      net_income,
      est_net_income );

   function Pretty_Print( i : Paygya_Type ) return String;
   function Null_Or_Missing( i : Paygya_Type ) return Boolean;
   function Convert_Paygya_Type( i : String ) return Paygya_Type;


   type Paygyr_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_999997_or_above );

   function Pretty_Print( i : Paygyr_Type ) return String;
   function Null_Or_Missing( i : Paygyr_Type ) return Boolean;
   function Convert_Paygyr_Type( i : String ) return Paygyr_Type;


   type Payly_Type is (  
      dont_know,
      refused,
      same_as_now,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_99997_or_above );

   function Pretty_Print( i : Payly_Type ) return String;
   function Null_Or_Missing( i : Payly_Type ) return Boolean;
   function Convert_Payly_Type( i : String ) return Payly_Type;


   type Paylye_Type is (  
      dont_know,
      refused,
      same_as_now,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Paylye_Type ) return String;
   function Null_Or_Missing( i : Paylye_Type ) return Boolean;
   function Convert_Paylye_Type( i : String ) return Paylye_Type;


   type Paylyg_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      before_deductions,
      after_deductions,
      no_deductions );

   function Pretty_Print( i : Paylyg_Type ) return String;
   function Null_Or_Missing( i : Paylyg_Type ) return Boolean;
   function Convert_Paylyg_Type( i : String ) return Paylyg_Type;


   type Paylyge_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      before_deductions,
      after_deductions,
      no_deductions );

   function Pretty_Print( i : Paylyge_Type ) return String;
   function Null_Or_Missing( i : Paylyge_Type ) return Boolean;
   function Convert_Paylyge_Type( i : String ) return Paylyge_Type;


   type Paylyw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      per_hour,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      week,
      fortnight,
      four_weeks,
      blank,
      year,
      other );

   function Pretty_Print( i : Paylyw_Type ) return String;
   function Null_Or_Missing( i : Paylyw_Type ) return Boolean;
   function Convert_Paylyw_Type( i : String ) return Paylyw_Type;


   type Paynl_Type is (  
      dont_know,
      refused,
      no_deductions,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_99997_or_more );

   function Pretty_Print( i : Paynl_Type ) return String;
   function Null_Or_Missing( i : Paynl_Type ) return Boolean;
   function Convert_Paynl_Type( i : String ) return Paynl_Type;


   type Paynmw2_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      reported_to_employer,
      rep_enforcement_agency,
      reported_to_both,
      reported_to_neither,
      other );

   function Pretty_Print( i : Paynmw2_Type ) return String;
   function Null_Or_Missing( i : Paynmw2_Type ) return Boolean;
   function Convert_Paynmw2_Type( i : String ) return Paynmw2_Type;


   type Payslp_Type is (  
      not_answered,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      latest_payslip_seen,
      early_payslip_seen,
      no_payslip_seen );

   function Pretty_Print( i : Payslp_Type ) return String;
   function Null_Or_Missing( i : Payslp_Type ) return Boolean;
   function Convert_Payslp_Type( i : String ) return Payslp_Type;


   type Paysw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      per_hour,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      week,
      fortnight,
      four_weeks,
      calendar_month,
      year,
      other );

   function Pretty_Print( i : Paysw_Type ) return String;
   function Null_Or_Missing( i : Paysw_Type ) return Boolean;
   function Convert_Paysw_Type( i : String ) return Paysw_Type;


   type Paytyp_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      salaried,
      basic_salary_plus_comm,
      hourly_pay,
      other );

   function Pretty_Print( i : Paytyp_Type ) return String;
   function Null_Or_Missing( i : Paytyp_Type ) return Boolean;
   function Convert_Paytyp_Type( i : String ) return Paytyp_Type;


   type Payu_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_99997_or_more );

   function Pretty_Print( i : Payu_Type ) return String;
   function Null_Or_Missing( i : Payu_Type ) return Boolean;
   function Convert_Payu_Type( i : String ) return Payu_Type;


   type Pck2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      pension_before_1788,
      pension_since_1788_or_both );

   function Pretty_Print( i : Pck2_Type ) return String;
   function Null_Or_Missing( i : Pck2_Type ) return Boolean;
   function Convert_Pck2_Type( i : String ) return Pck2_Type;


   type Pcoftn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      every_day,
      at_least_once_a_week,
      at_least_once_a_month,
      less_than_once_a_month );

   function Pretty_Print( i : Pcoftn_Type ) return String;
   function Null_Or_Missing( i : Pcoftn_Type ) return Boolean;
   function Convert_Pcoftn_Type( i : String ) return Pcoftn_Type;


   type Pcusei_Type is (  
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      yes );

   function Pretty_Print( i : Pcusei_Type ) return String;
   function Null_Or_Missing( i : Pcusei_Type ) return Boolean;
   function Convert_Pcusei_Type( i : String ) return Pcusei_Type;


   type Pcusem_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      paid_work_done_at_home,
      voluntary_or_unpaid_work,
      education_or_course_work,
      playing_games,
      letters_or_word_processing,
      personal_financial_accounts,
      internet_connection,
      hobbies,
      something_else );

   function Pretty_Print( i : Pcusem_Type ) return String;
   function Null_Or_Missing( i : Pcusem_Type ) return Boolean;
   function Convert_Pcusem_Type( i : String ) return Pcusem_Type;


   type Pcusr1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      no_one );

   function Pretty_Print( i : Pcusr1_Type ) return String;
   function Null_Or_Missing( i : Pcusr1_Type ) return Boolean;
   function Convert_Pcusr1_Type( i : String ) return Pcusr1_Type;


   type Pcusr2_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned );

   function Pretty_Print( i : Pcusr2_Type ) return String;
   function Null_Or_Missing( i : Pcusr2_Type ) return Boolean;
   function Convert_Pcusr2_Type( i : String ) return Pcusr2_Type;


   type Pcwhen_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      s_1976,
      s_1977,
      s_1978,
      s_1979,
      s_1986,
      s_1981,
      s_1982,
      s_1983,
      s_1984,
      s_1985,
      s_1987,
      s_1988,
      s_1989,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996,
      s_1997 );

   function Pretty_Print( i : Pcwhen_Type ) return String;
   function Null_Or_Missing( i : Pcwhen_Type ) return Boolean;
   function Convert_Pcwhen_Type( i : String ) return Pcwhen_Type;


   type Penadw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      one_off_payment,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      a_week,
      a_month,
      a_quarter,
      six_months,
      a_year,
      a_once_off_payment,
      other_specified );

   function Pretty_Print( i : Penadw_Type ) return String;
   function Null_Or_Missing( i : Penadw_Type ) return Boolean;
   function Convert_Penadw_Type( i : String ) return Penadw_Type;


   type Penb4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      before_1788,
      s_1788_or_since,
      before_and_after );

   function Pretty_Print( i : Penb4_Type ) return String;
   function Null_Or_Missing( i : Penb4_Type ) return Boolean;
   function Convert_Penb4_Type( i : String ) return Penb4_Type;


   type Penck1_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      retired_or_male_65_plus_or_female_60_plus,
      no_current_occupational_pension,
      other );

   function Pretty_Print( i : Penck1_Type ) return String;
   function Null_Or_Missing( i : Penck1_Type ) return Boolean;
   function Convert_Penck1_Type( i : String ) return Penck1_Type;


   type Penck2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      contributes_to_pension,
      single_no_pension,
      partnered_no_pension,
      other );

   function Pretty_Print( i : Penck2_Type ) return String;
   function Null_Or_Missing( i : Penck2_Type ) return Boolean;
   function Convert_Penck2_Type( i : String ) return Penck2_Type;


   type Penmcn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      contrib_deductions,
      non_contrib_avcs,
      non_contrib_no_avc );

   function Pretty_Print( i : Penmcn_Type ) return String;
   function Null_Or_Missing( i : Penmcn_Type ) return Boolean;
   function Convert_Penmcn_Type( i : String ) return Penmcn_Type;


   type Penmtp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      pension_final_salary_scheme,
      pension_investment_scheme,
      pension_combined_or_other_scheme );

   function Pretty_Print( i : Penmtp_Type ) return String;
   function Null_Or_Missing( i : Penmtp_Type ) return Boolean;
   function Convert_Penmtp_Type( i : String ) return Penmtp_Type;


   type Penyr_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1988,
      s_1989,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996 );

   function Pretty_Print( i : Penyr_Type ) return String;
   function Null_Or_Missing( i : Penyr_Type ) return Boolean;
   function Convert_Penyr_Type( i : String ) return Penyr_Type;


   type Pim1_Type is (  
      inapplicable,
      missing_or_wild,
      informant_alone,
      partner_present,
      other_adults_present,
      children_present );

   function Pretty_Print( i : Pim1_Type ) return String;
   function Null_Or_Missing( i : Pim1_Type ) return Boolean;
   function Convert_Pim1_Type( i : String ) return Pim1_Type;


   type Plb4c_Type is (  
      dont_know,
      inapplicable,
      missing_or_wild,
      australia,
      canada,
      new_zealand,
      kenya,
      uganda,
      tanzania,
      malawi,
      zambia,
      zimbabwe,
      botswana,
      gambia,
      ghana,
      nigeria,
      sierra_leone,
      barbados,
      jamaica,
      trinidad_and_tobago,
      w_indies_assoc_states,
      west_indies,
      other_carib_cmmnwlth,
      belize_or_brit_honduras,
      guyana,
      bangladesh,
      india,
      sri_lanka_or_ceylon,
      hong_kong,
      malaysia,
      singapore,
      cyprus,
      gibraltar,
      malta_and_gozo,
      seychelles,
      mauritius,
      other_new_cmmnwlth,
      algeria,
      morocco,
      tunisia,
      libya,
      egypt,
      rep_of_south_africa,
      other_africa_foreign,
      usa,
      caribbean,
      central_america,
      south_america,
      pakistan,
      burma,
      china_incl_taiwan,
      japan,
      irish_republic,
      phillipines,
      vietnam,
      iran,
      israel,
      other_middle_eastern,
      other_asia,
      belgium,
      denmark,
      france,
      italy,
      luxembourg,
      netherlands,
      germany_fed_rep,
      germany_pns,
      albania,
      bulgaria,
      gdr,
      czechoslovakia,
      hungary,
      poland,
      romania,
      austria,
      switzerland,
      greece,
      portugal,
      spain,
      finland,
      norway,
      sweden,
      yugoslavia,
      other_europe,
      turkey,
      ussr,
      rest_of_the_world,
      at_sea_or_air,
      not_stated_or_refused );

   function Pretty_Print( i : Plb4c_Type ) return String;
   function Null_Or_Missing( i : Plb4c_Type ) return Boolean;
   function Convert_Plb4c_Type( i : String ) return Plb4c_Type;


   type Plb4d_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      city_westminster,
      newham,
      allerdale_carlisle,
      barrow_in_furness_copeland,
      eden_south_lakeland,
      amber_valley_ne_derbyshire,
      bolsover_chesterfield,
      derby,
      erewash_south_derbyshire,
      high_peak_derbyshire_dales,
      east_devon_mid_devon,
      exeter_teignbridge,
      southwark,
      north_devon_torridge,
      plymouth,
      south_hams_west_devon,
      torbay,
      bournemouth,
      christchurch_e_dorset_n_dorset,
      poole,
      purbeck_w_dorset_weymouth_and_portland,
      chester_le_street_durham,
      darlington_teesdale,
      tower_hamlets,
      derwentside_wear_valley,
      easington_sedgefield,
      brighton,
      eastbourne_hove_lewes,
      hastings_rother,
      wealdon,
      basildon,
      braintree_uttlesford,
      brentwood_epping_forest_harlow,
      castle_point_maldon_rochford,
      wandsworth,
      chelmsford,
      colchester,
      southend_on_sea,
      tendring,
      thurrock,
      cheltenham_cotswold,
      forest_of_dean_stroud,
      gloucester_tewkesbury,
      basingstoke_and_deane,
      east_hampshire_havant,
      barking_and_dagenham,
      eastleigh_fareham_gosport,
      hart_rushmoor,
      new_forest,
      portsmouth,
      southampton,
      test_valley_winchester,
      bromsgrove_wyre_forest,
      hereford_leominster_s_herefordshire,
      malvern_hills_worcester,
      redditch_wychavon,
      barnet,
      broxbourne_e_hertfordshire,
      dacorum,
      hertsmere_welwyn_hatfield,
      n_hertfordshire_stevenage,
      st_albans,
      three_rivers_watford,
      beverley_boothferry,
      cleethorpes_great_grimsby,
      e_yorkshire_holderness,
      glanford_scunthorpe,
      bexley,
      kingston_upon_hull,
      medina_south_wight,
      ashford_tunbridge_wells,
      canterbury,
      dartford_gravesham,
      dover_shepway,
      gillingham_swale,
      maidstone,
      rochester_upon_medway,
      sevenoaks_tonbridge_and_malling,
      brent,
      thanet,
      blackburn,
      blackpool,
      burnley_pendle,
      chorley_west_lancashire,
      fylde_wyre,
      hyndburn_rossendale,
      lancaster,
      preston,
      ribble_valley_south_ribble,
      bromley,
      blaby_oadby_and_wigston,
      charnwood,
      harborough_melton_rutland,
      hinkley_and_bosworth_nw_leics,
      leicester,
      boston_s_holland,
      e_lindsey_lincoln_w_lindsey,
      n_kesteven_s_kesteven,
      breckland_s_norfolk,
      broadland_norwich,
      croydon,
      great_yarmouth,
      kings_lynn_and_w_norfolk,
      corby_kettering,
      daventry_s_northants,
      e_northants_wellingborough,
      northampton,
      alnwick_berwick_morpeth_tynedale,
      blyth_valley_wansbeck,
      craven_hambleton_richmondshire,
      ryedale_scarborough,
      camden,
      ealing,
      harrogate,
      selby_york,
      ashfield_mansfield,
      bassetlaw_newark_and_sherwood,
      broxtowe_gedling_rushcliffe,
      nottingham,
      cherwell,
      oxford_vale_white_horse_west_oxford,
      south_oxfordshire,
      bridgnorth_shrewsbury_and_atcham,
      enfield,
      n_shropshire_oswestry_s_shropshire,
      the_wrekin,
      mendip_sedgemoor,
      south_somerset,
      taunton_deane_w_somerset,
      cannock_chase_s_staffs,
      e_staff_staffordshire_moorlands,
      lichfield_tamworth,
      newcastle_under_lyme_stafford,
      stoke_on_trent,
      greenwich,
      babergh_ipswich,
      forest_heath_m_suffolk_st_edmundsbury,
      suffolk_coastal_waveney,
      elmbridge_epsom_and_ewell,
      guildford,
      mole_valley_waverley,
      reigate_and_banstead_tandrige,
      runnymede_spelthorne,
      surrey_heath_woking,
      n_warwick_nuneaton_and_bedwoth_rugby,
      harrow,
      stratford_on_avon_warwick,
      adur_worthing,
      arun,
      chichester_horsham,
      crawley_mid_sussex,
      kennet_salisbury,
      n_wilts_w_wilts,
      thamesdown,
      alyn_and_deeside_delyn_wrexham_maelor,
      colwyn_glyndwr_rhuddlan,
      havering,
      carmarthen_dinefwr_llanelli,
      ceredigion_preseli_pembroke_s_pemb,
      blaenau_gwent_islywn,
      monmouth_torfaen,
      newport,
      gwynedd,
      cynon_valley_rhondda,
      merthyr_tydfil_rhymney_vall_taff_ely,
      ogwr,
      brecknock_montgomeryshire_radnorshire,
      hillingdon,
      cardiff,
      vale_of_glamorgan,
      lliw_valley_neath_port_talbot,
      swansea,
      e_and_m_lothian_borders,
      edinburgh_city,
      west_lothian,
      clackmannan_stirling,
      falkirk,
      annadale_nithsdale_stewarty_wigtown,
      hounslow,
      dunfermline,
      kirkcaldy_ne_fife,
      aberdeen_city,
      banff_and_buchan_moray,
      gordon_kincardine_and_deeside,
      nw_highlands_western_isles,
      s_and_e_highlands_orkney_shetlands,
      argyll_and_bute_dumbarton_inverclyde,
      bearsden_clydebank_strathkelvin,
      cumbernauld_and_kilsyth_monklands,
      kingston_upon_thames,
      clydesdale_cumnock_doon_kyle_carrick,
      cunninghame,
      east_kilbride_hamilton,
      eastwood_kilmarnock_and_loudon,
      glasgow_city,
      motherwell,
      renfrew,
      angus_perth_and_kinross,
      dundee_city,
      merton,
      redbridge,
      hackney,
      richmond_upon_thames,
      inner_london_nos,
      outer_london_nos,
      greater_manchester_nos,
      merseyside_nos,
      south_yorkshire_nos,
      tyne_and_wear_nos,
      west_midland_nos,
      west_yorkshire_yorkshire_nos,
      avon_nos,
      sutton,
      bedfordshire_nos,
      berkshire_nos,
      buckinghamshire_nos,
      cambridgeshire_nos,
      chesire_nos,
      cleveland_nos,
      cornwall_nos,
      cumbria_nos,
      derbyshire_nos,
      devon_nos,
      waltham_forest,
      dorset_nos,
      durham_nos,
      east_sussex_nos,
      essex_nos,
      gloucestershire_nos,
      hampshire_nos,
      hereford_and_worcester_nos,
      hertfordshire_nos,
      humberside_nos,
      isle_of_wight_nos,
      bolton,
      kent_nos,
      lancashire_nos,
      leicestershire_nos,
      lincolnshire_nos,
      norfolk_nos,
      northamptonshire_nos,
      northumberland_nos,
      north_yorkshire_nos,
      nottinghamshire_nos,
      oxfordshire_nos,
      bury,
      shropshire_nos,
      somerset_nos,
      staffordshire_nos,
      suffolk_nos,
      surrey_nos,
      warwickshire_nos,
      west_sussex_nos,
      wiltshire_nos,
      clwyd_nos,
      dyfed_nos,
      manchester,
      gwent_nos,
      gwynedd_nos,
      mid_glamorgan_nos,
      powys_nos,
      south_glamorgan_nos,
      west_glamorgan_nos,
      borders_nos,
      lothian_nos,
      central_nos,
      dumfries_and_galloway_nos,
      oldham,
      fife_nos,
      grampian_nos,
      highlands_and_islands_nos,
      strathclyde_nos,
      tayside_nos,
      northern_ireland,
      channel_islands_isle_of_man,
      rochdale,
      salford,
      stockport,
      hammersmith_and_fulham,
      tameside,
      trafford,
      wigan,
      knowsley,
      liverpool,
      st_helens,
      sefton,
      wirral,
      barnsley,
      doncaster,
      haringey,
      rotherham,
      sheffield,
      gateshead,
      newcastle_upon_tyne,
      north_tyneside,
      south_tyneside,
      sunderland,
      birmingham,
      coventry,
      dudley,
      islington,
      sandwell,
      solihull,
      walsall,
      wolverhampton,
      bradford,
      calderdale,
      kirklees,
      leeds,
      wakefield,
      bath_kingswood_wansdyke,
      kensington_and_chelsea,
      bristol,
      northavon,
      woodspring,
      luton,
      mid_beds_south_beds,
      north_bedfordshire,
      bracknell_forest_slough,
      newbury,
      reading,
      windor_and_maidenhead,
      lambeth,
      wokingham,
      aylesbury_vale,
      chiltern_south_bucks,
      milton_keynes,
      wycombe,
      cambridge_south_cambs,
      east_cambs_fenland,
      huntingdonshire,
      peterborough,
      chester_ellesmere_port_and_neston,
      lewisham,
      congleton_crewe_and_nantwich_vale_royal,
      halton,
      macclesfield,
      warrington,
      hartlepool_stockton,
      langbaurgh_on_tees,
      middlesborough,
      caradon_north_cornwall,
      carrick_restormel,
      kerrier_penwith_isles_of_scilly );

   function Pretty_Print( i : Plb4d_Type ) return String;
   function Null_Or_Missing( i : Plb4d_Type ) return Boolean;
   function Convert_Plb4d_Type( i : String ) return Plb4d_Type;


   type Plbornc_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      australia,
      canada,
      new_zealand,
      kenya,
      uganda,
      tanzania,
      malawi,
      zambia,
      zimbabwe,
      botswana,
      gambia,
      ghana,
      nigeria,
      sierra_leone,
      barbados,
      jamaica,
      trinidad_or_tobago,
      w_indies_assoc_states,
      west_indies,
      other_carib_cmmnwlth,
      belize_or_brit_honduras,
      guyana,
      bangladesh,
      india,
      sri_lanka_or_ceylon,
      hong_kong,
      malaysia,
      singapore,
      cyprus,
      gibraltar,
      malta_and_gozo,
      seychelles,
      mauritius,
      other_new_cmmnwlth,
      algeria,
      morocco,
      tunisia,
      libya,
      egypt,
      rep_of_s_africa,
      other_africa_foreign,
      usa,
      caribbean,
      central_america,
      south_america,
      pakistan,
      burma,
      china_includ_taiwan,
      japan,
      irish_republic,
      phillipines,
      vietnam,
      iran,
      israel,
      other_middle_eastern,
      other_asia,
      belgium,
      denmark,
      france,
      italy,
      luxembourg,
      netherlands,
      german_fed_rep,
      germany_pns,
      albania,
      bulgaria,
      gdr,
      czechoslovakia,
      hungary,
      poland,
      romania,
      austria,
      switzerland,
      greece,
      portugal,
      spain,
      finland,
      norway,
      sweden,
      yugoslavia,
      other_europe,
      turkey,
      ussr,
      rest_of_the_world,
      at_sea_or_air,
      not_stated_or_refused );

   function Pretty_Print( i : Plbornc_Type ) return String;
   function Null_Or_Missing( i : Plbornc_Type ) return Boolean;
   function Convert_Plbornc_Type( i : String ) return Plbornc_Type;


   type Plbornd_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      city_westminster,
      newham,
      allerdale_carlisle,
      barrow_in_furness_copeland,
      eden_south_lakeland,
      amber_valley_ne_derbyshire,
      bolsover_chesterfield,
      derby,
      erewash_south_derbyshire,
      high_peak_derbyshire_dales,
      east_devon_mid_devon,
      exeter_teignbridge,
      southwark,
      north_devon_torridge,
      plymouth,
      south_hams_west_devon,
      torbay,
      bournemouth,
      christchurch_e_dorset_n_dorset,
      poole,
      purbeck_w_dorset_weymouth_and_portland,
      chester_le_street_durham,
      darlington_teesdale,
      tower_hamlets,
      derwentside_wear_valley,
      easington_sedgefield,
      brighton,
      eastbourne_hove_lewes,
      hastings_rother,
      wealdon,
      basildon,
      braintree_uttlesford,
      brentwood_epping_forest_harlow,
      castle_point_maldon_rochford,
      wandsworth,
      chelmsford,
      colchester,
      southend_on_sea,
      tendring,
      thurrock,
      cheltenham_cotswold,
      forest_of_dean_stroud,
      gloucester_tewkesbury,
      basingstoke_and_deane,
      east_hampshire_havant,
      barking_and_dagenham,
      eastleigh_fareham_gosport,
      hart_rushmoor,
      new_forest,
      portsmouth,
      southampton,
      test_valley_winchester,
      bromsgrove_wyre_forest,
      hereford_leominster_s_herefordshire,
      malvern_hills_worcester,
      redditch_wychavon,
      barnet,
      broxbourne_e_hertfordshire,
      dacorum,
      hertsmere_welwyn_hatfield,
      n_hertfordshire_stevenage,
      st_albans,
      three_rivers_watford,
      beverley_boothferry,
      cleethorpes_great_grimsby,
      e_yorkshire_holderness,
      glanford_scunthorpe,
      bexley,
      kingston_upon_hull,
      medina_south_wight,
      ashford_tunbridge_wells,
      canterbury,
      dartford_gravesham,
      dover_shepway,
      gillingham_swale,
      maidstone,
      rochester_upon_medway,
      sevenoaks_tonbridge_and_malling,
      brent,
      thanet,
      blackburn,
      blackpool,
      burnley_pendle,
      chorley_west_lancashire,
      fylde_wyre,
      hyndburn_rossendale,
      lancaster,
      preston,
      ribble_valley_south_ribble,
      bromley,
      blaby_oadby_and_wigston,
      charnwood,
      harborough_melton_rutland,
      hinkley_and_bosworth_nw_leics,
      leicester,
      boston_s_holland,
      e_lindsey_lincoln_w_lindsey,
      n_kesteven_s_kesteven,
      breckland_s_norfolk,
      broadland_norwich,
      croydon,
      great_yarmouth,
      kings_lynn_and_w_norfolk,
      corby_kettering,
      daventry_s_northants,
      e_northants_wellingborough,
      northampton,
      alnwick_berwick_morpeth_tynedale,
      blyth_valley_wansbeck,
      craven_hambleton_richmondshire,
      ryedale_scarborough,
      camden,
      ealing,
      harrogate,
      selby_york,
      ashfield_mansfield,
      bassetlaw_newark_and_sherwood,
      broxtowe_gedling_rushcliffe,
      nottingham,
      cherwell,
      oxford_vale_white_horse_west_oxford,
      south_oxfordshire,
      bridgnorth_shrewsbury_and_atcham,
      enfield,
      n_shropshire_oswestry_s_shropshire,
      the_wrekin,
      mendip_sedgemoor,
      south_somerset,
      taunton_deane_w_somerset,
      cannock_chase_s_staffs,
      e_staff_staffordshire_moorlands,
      lichfield_tamworth,
      newcastle_under_lyme_stafford,
      stoke_on_trent,
      greenwich,
      babergh_ipswich,
      forest_heath_m_suffolk_st_edmundsbury,
      suffolk_coastal_waveney,
      elmbridge_epsom_and_ewell,
      guildford,
      mole_valley_waverley,
      reigate_and_banstead_tandrige,
      runnymede_spelthorne,
      surrey_heath_woking,
      n_warwick_nuneaton_and_bedwoth_rugby,
      harrow,
      stratford_on_avon_warwick,
      adur_worthing,
      arun,
      chichester_horsham,
      crawley_mid_sussex,
      kennet_salisbury,
      n_wilts_w_wilts,
      thamesdown,
      alyn_and_deeside_delyn_wrexham_maelor,
      colwyn_glyndwr_rhuddlan,
      havering,
      carmarthen_dinefwr_llanelli,
      ceredigion_preseli_pembroke_s_pemb,
      blaenau_gwent_islywn,
      monmouth_torfaen,
      newport,
      gwynedd,
      cynon_valley_rhondda,
      merthyr_tydfil_rhymney_vall_taff_ely,
      ogwr,
      brecknock_montgomeryshire_radnorshire,
      hillingdon,
      cardiff,
      vale_of_glamorgan,
      lliw_valley_neath_port_talbot,
      swansea,
      e_and_m_lothian_borders,
      edinburgh_city,
      west_lothian,
      clackmannan_stirling,
      falkirk,
      annadale_nithsdale_stewarty_wigtown,
      hounslow,
      dunfermline,
      kirkcaldy_ne_fife,
      aberdeen_city,
      banff_and_buchan_moray,
      gordon_kincardine_and_deeside,
      nw_highlands_western_isles,
      s_and_e_highlands_orkney_shetlands,
      argyll_and_bute_dumbarton_inverclyde,
      bearsden_clydebank_strathkelvin,
      cumbernauld_and_kilsyth_monklands,
      kingston_upon_thames,
      clydesdale_cumnock_doon_kyle_carrick,
      cunninghame,
      east_kilbride_hamilton,
      eastwood_kilmarnock_and_loudon,
      glasgow_city,
      motherwell,
      renfrew,
      angus_perth_and_kinross,
      dundee_city,
      merton,
      redbridge,
      hackney,
      richmond_upon_thames,
      inner_london_nos,
      outer_london_nos,
      greater_manchester_nos,
      merseyside_nos,
      south_yorkshire_nos,
      tyne_and_wear_nos,
      west_midland_nos,
      west_yorkshire_yorkshire_nos,
      avon_nos,
      sutton,
      bedfordshire_nos,
      berkshire_nos,
      buckinghamshire_nos,
      cambridgeshire_nos,
      chesire_nos,
      cleveland_nos,
      cornwall_nos,
      cumbria_nos,
      derbyshire_nos,
      devon_nos,
      waltham_forest,
      dorset_nos,
      durham_nos,
      east_sussex_nos,
      essex_nos,
      gloucestershire_nos,
      hampshire_nos,
      hereford_and_worcester_nos,
      hertfordshire_nos,
      humberside_nos,
      isle_of_wight_nos,
      bolton,
      kent_nos,
      lancashire_nos,
      leicestershire_nos,
      lincolnshire_nos,
      norfolk_nos,
      northamptonshire_nos,
      northumberland_nos,
      north_yorkshire_nos,
      nottinghamshire_nos,
      oxfordshire_nos,
      bury,
      shropshire_nos,
      somerset_nos,
      staffordshire_nos,
      suffolk_nos,
      surrey_nos,
      warwickshire_nos,
      west_sussex_nos,
      wiltshire_nos,
      clwyd_nos,
      dyfed_nos,
      manchester,
      gwent_nos,
      gwynedd_nos,
      mid_glamorgan_nos,
      powys_nos,
      south_glamorgan_nos,
      west_glamorgan_nos,
      borders_nos,
      lothian_nos,
      central_nos,
      dumfries_and_galloway_nos,
      oldham,
      fife_nos,
      grampian_nos,
      highlands_and_islands_nos,
      strathclyde_nos,
      tayside_nos,
      northern_ireland,
      channel_islands_isle_of_man,
      rochdale,
      salford,
      stockport,
      hammersmith_and_fulham,
      tameside,
      trafford,
      wigan,
      knowsley,
      liverpool,
      st_helens,
      sefton,
      wirral,
      barnsley,
      doncaster,
      haringey,
      rotherham,
      sheffield,
      gateshead,
      newcastle_upon_tyne,
      north_tyneside,
      south_tyneside,
      sunderland,
      birmingham,
      coventry,
      dudley,
      islington,
      sandwell,
      solihull,
      walsall,
      wolverhampton,
      bradford,
      calderdale,
      kirklees,
      leeds,
      wakefield,
      bath_kingswood_wansdyke,
      kensington_and_chelsea,
      bristol,
      northavon,
      woodspring,
      luton,
      mid_beds_south_beds,
      north_bedfordshire,
      bracknell_forest_slough,
      newbury,
      reading,
      windor_and_maidenhead,
      lambeth,
      wokingham,
      aylesbury_vale,
      chiltern_south_bucks,
      milton_keynes,
      wycombe,
      cambridge_south_cambs,
      east_cambs_fenland,
      huntingdonshire,
      peterborough,
      chester_ellesmere_port_and_neston,
      lewisham,
      congleton_crewe_and_nantwich_vale_royal,
      halton,
      macclesfield,
      warrington,
      hartlepool_stockton,
      langbaurgh_on_tees,
      middlesborough,
      caradon_north_cornwall,
      carrick_restormel,
      kerrier_penwith_isles_of_scilly );

   function Pretty_Print( i : Plbornd_Type ) return String;
   function Null_Or_Missing( i : Plbornd_Type ) return Boolean;
   function Convert_Plbornd_Type( i : String ) return Plbornd_Type;


   type Plever_Type is (  
      inapplicable,
      missing_or_wild,
      here_all_life );

   function Pretty_Print( i : Plever_Type ) return String;
   function Null_Or_Missing( i : Plever_Type ) return Boolean;
   function Convert_Plever_Type( i : String ) return Plever_Type;


   type Prearn_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      no_earnings_at_all,
      lt_25_pw_or_lt_1299_pa,
      s_210_259_or_11k_13499,
      s_260_299_or_13500_15999,
      s_300_379_or_16k_19999,
      s_380_479_or_20k_24999,
      s_480_plus_pw_or_25k_plus_pa,
      s_25_39_pw_or_1300_2099,
      s_40_59_pw_or_2100_3099,
      s_60_79_pw_or_3100_4199,
      s_80_99_pw_or_4200_5199,
      s_100_124_or_5200_6499,
      s_125_149_or_6500_7799,
      s_150_179_or_7800_9299,
      s_180_209_or_9300_10999 );

   function Pretty_Print( i : Prearn_Type ) return String;
   function Null_Or_Missing( i : Prearn_Type ) return Boolean;
   function Convert_Prearn_Type( i : String ) return Prearn_Type;


   type Prearni_Type is (  
      var_dont_know,
      var_refused,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed );

   function Pretty_Print( i : Prearni_Type ) return String;
   function Null_Or_Missing( i : Prearni_Type ) return Boolean;
   function Convert_Prearni_Type( i : String ) return Prearni_Type;


   type Presbgm_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      spring,
      summer,
      autumn,
      winter,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Presbgm_Type ) return String;
   function Null_Or_Missing( i : Presbgm_Type ) return Boolean;
   function Convert_Presbgm_Type( i : String ) return Presbgm_Type;


   type Presly_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      yes_after_1992,
      no_on_or_before_1992 );

   function Pretty_Print( i : Presly_Type ) return String;
   function Null_Or_Missing( i : Presly_Type ) return Boolean;
   function Convert_Presly_Type( i : String ) return Presly_Type;


   type Prf101_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ni_retir_pension );

   function Pretty_Print( i : Prf101_Type ) return String;
   function Null_Or_Missing( i : Prf101_Type ) return Boolean;
   function Convert_Prf101_Type( i : String ) return Prf101_Type;


   type Prf102_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      pension_prev_emp );

   function Pretty_Print( i : Prf102_Type ) return String;
   function Null_Or_Missing( i : Prf102_Type ) return Boolean;
   function Convert_Prf102_Type( i : String ) return Prf102_Type;


   type Prf107_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      pension_credit );

   function Pretty_Print( i : Prf107_Type ) return String;
   function Null_Or_Missing( i : Prf107_Type ) return Boolean;
   function Convert_Prf107_Type( i : String ) return Prf107_Type;


   type Prf116_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      invalidity_allow );

   function Pretty_Print( i : Prf116_Type ) return String;
   function Null_Or_Missing( i : Prf116_Type ) return Boolean;
   function Convert_Prf116_Type( i : String ) return Prf116_Type;


   type Prf125_Type is (  
      not_answered,
      refused,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      incapacity_benefit );

   function Pretty_Print( i : Prf125_Type ) return String;
   function Null_Or_Missing( i : Prf125_Type ) return Boolean;
   function Convert_Prf125_Type( i : String ) return Prf125_Type;


   type Prf131_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ub_and_or_or_is );

   function Pretty_Print( i : Prf131_Type ) return String;
   function Null_Or_Missing( i : Prf131_Type ) return Boolean;
   function Convert_Prf131_Type( i : String ) return Prf131_Type;


   type Prf134_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ni_sick_benefit );

   function Pretty_Print( i : Prf134_Type ) return String;
   function Null_Or_Missing( i : Prf134_Type ) return Boolean;
   function Convert_Prf134_Type( i : String ) return Prf134_Type;


   type Prf135_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      child_benefit );

   function Pretty_Print( i : Prf135_Type ) return String;
   function Null_Or_Missing( i : Prf135_Type ) return Boolean;
   function Convert_Prf135_Type( i : String ) return Prf135_Type;


   type Prf137_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      family_credit );

   function Pretty_Print( i : Prf137_Type ) return String;
   function Null_Or_Missing( i : Prf137_Type ) return Boolean;
   function Convert_Prf137_Type( i : String ) return Prf137_Type;


   type Prf139_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      housing_benefit );

   function Pretty_Print( i : Prf139_Type ) return String;
   function Null_Or_Missing( i : Prf139_Type ) return Boolean;
   function Convert_Prf139_Type( i : String ) return Prf139_Type;


   type Prf141_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_state_bene,
      other_state_benefit );

   function Pretty_Print( i : Prf141_Type ) return String;
   function Null_Or_Missing( i : Prf141_Type ) return Boolean;
   function Convert_Prf141_Type( i : String ) return Prf141_Type;


   type Prf143_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      child_tax_credit );

   function Pretty_Print( i : Prf143_Type ) return String;
   function Null_Or_Missing( i : Prf143_Type ) return Boolean;
   function Convert_Prf143_Type( i : String ) return Prf143_Type;


   type Prfehq_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      youth_training_cert,
      teaching_qualifications,
      university_diploma,
      first_degree,
      higher_degree,
      other_tech_or_professional,
      trade_apprenticeship,
      clerical_and_commercial,
      city_and_guilds_pt_i,
      city_and_guilds_pt_2,
      city_and_guilds_pt_3,
      onc_or_ond,
      hnc_or_hnd,
      nursing_qualifications );

   function Pretty_Print( i : Prfehq_Type ) return String;
   function Null_Or_Missing( i : Prfehq_Type ) return Boolean;
   function Convert_Prfehq_Type( i : String ) return Prfehq_Type;


   type Prfirn_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      none,
      none_listed_ben );

   function Pretty_Print( i : Prfirn_Type ) return String;
   function Null_Or_Missing( i : Prfirn_Type ) return Boolean;
   function Convert_Prfirn_Type( i : String ) return Prfirn_Type;


   type Prfitb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      no_income,
      lt_77_pw_or_lt_3999_pa,
      s_443_500_pw_or_23k_25999,
      s_501_558_pw_or_26k_28999,
      s_559_615_pw_or_29k_31999,
      s_616_673_pw_or_32k_34999,
      s_674_plus_pw_or_35000_plus_pa,
      s_78_115_pw_or_4k_5999,
      s_116_154_pw_or_6k_7999,
      s_155_192_pw_or_8k_9999,
      s_193_230_pw_or_10k_11999,
      s_231_289_pw_or_12k_14999,
      s_290_346_pw_or_15k_17999,
      s_347_385_pw_or_18k_19999,
      s_386_442_pw_or_20k_22999 );

   function Pretty_Print( i : Prfitb_Type ) return String;
   function Null_Or_Missing( i : Prfitb_Type ) return Boolean;
   function Convert_Prfitb_Type( i : String ) return Prfitb_Type;


   type Prfitbi_Type is (  
      var_dont_know,
      var_refused,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed,
      imputed );

   function Pretty_Print( i : Prfitbi_Type ) return String;
   function Null_Or_Missing( i : Prfitbi_Type ) return Boolean;
   function Convert_Prfitbi_Type( i : String ) return Prfitbi_Type;


   type Pripn_Type is (  
      inapplicable,
      missing_or_wild,
      not_in_household );

   function Pretty_Print( i : Pripn_Type ) return String;
   function Null_Or_Missing( i : Pripn_Type ) return Boolean;
   function Convert_Pripn_Type( i : String ) return Pripn_Type;


   type Prjbft_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      part_time,
      full_time );

   function Pretty_Print( i : Prjbft_Type ) return String;
   function Null_Or_Missing( i : Prjbft_Type ) return Boolean;
   function Convert_Prjbft_Type( i : String ) return Prjbft_Type;


   type Prjbly_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      yes_before_1993,
      no_on_or_before_1992 );

   function Pretty_Print( i : Prjbly_Type ) return String;
   function Null_Or_Missing( i : Prjbly_Type ) return Boolean;
   function Convert_Prjbly_Type( i : String ) return Prjbly_Type;


   type Prrs2i_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild,
      reference_person,
      natural_brother_or_sister,
      other_brother_or_sister,
      brother_or_sister_in_law,
      natural_parent,
      other_parent,
      mother_or_father_in_law,
      any_grand_parent,
      any_grand_child,
      any_cousin,
      any_aunt_or_uncle,
      lawful_spouse,
      any_nephew,
      any_other_relative,
      employee,
      lodger_or_boarder,
      unrelated_sharer,
      live_in_partner,
      other,
      natural_child,
      adopted_child,
      foster_child,
      step_child,
      partners_child,
      daughter_or_son_in_law );

   function Pretty_Print( i : Prrs2i_Type ) return String;
   function Null_Or_Missing( i : Prrs2i_Type ) return Boolean;
   function Convert_Prrs2i_Type( i : String ) return Prrs2i_Type;


   type Prsehq_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      school_cert_or_matric,
      gnvq,
      sce_ograde_d_e_or_4_5,
      o_grades,
      std_grades_4_7,
      std_grades_1_3,
      higher_grade,
      cert_6th_year_studies,
      slc_lower_grade,
      slc_higher_grade,
      cse_grade_1,
      other,
      stand_grades_1_3,
      slc_school_leaving,
      gcse_grades_d_g,
      other_or_foreign,
      gcse_grades_a_c,
      o_level,
      o_level_a_c,
      o_level_d_e,
      higher_school_certificate,
      a_level );

   function Pretty_Print( i : Prsehq_Type ) return String;
   function Null_Or_Missing( i : Prsehq_Type ) return Boolean;
   function Convert_Prsehq_Type( i : String ) return Prsehq_Type;


   type Prwhy_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      in_institution,
      deaf_or_speech_probs,
      language_problems,
      other,
      stressed_family_sitn,
      refused_full_intv,
      other_family_oppstn,
      studyg_away_frm_home,
      on_holiday,
      away_business_or_work,
      temp_away_from_home,
      non_contact,
      permly_too_unwell,
      temporarily_unwell,
      old_age );

   function Pretty_Print( i : Prwhy_Type ) return String;
   function Null_Or_Missing( i : Prwhy_Type ) return Boolean;
   function Convert_Prwhy_Type( i : String ) return Prwhy_Type;


   type Ptrt5a1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      does_not_apply,
      applies_perfectly );

   function Pretty_Print( i : Ptrt5a1_Type ) return String;
   function Null_Or_Missing( i : Ptrt5a1_Type ) return Boolean;
   function Convert_Ptrt5a1_Type( i : String ) return Ptrt5a1_Type;


   type Pyarg1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      most_days,
      more_than_once_a_wk,
      less_than_once_a_wk,
      hardly_ever );

   function Pretty_Print( i : Pyarg1_Type ) return String;
   function Null_Or_Missing( i : Pyarg1_Type ) return Boolean;
   function Convert_Pyarg1_Type( i : String ) return Pyarg1_Type;


   type Pyasm1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      never_smacked );

   function Pretty_Print( i : Pyasm1_Type ) return String;
   function Null_Or_Missing( i : Pyasm1_Type ) return Boolean;
   function Convert_Pyasm1_Type( i : String ) return Pyasm1_Type;


   type Pybunk_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      extremely_serious,
      very_serious,
      fairly_serious,
      not_very_serious );

   function Pretty_Print( i : Pybunk_Type ) return String;
   function Null_Or_Missing( i : Pybunk_Type ) return Boolean;
   function Convert_Pybunk_Type( i : String ) return Pybunk_Type;


   type Pydptcw_Type is (  
      not_answered,
      refused,
      period_uncodeable,
      proxy_and_or_phone,
      not_applicable,
      missing,
      week,
      fortnight,
      four_weeks,
      calendar_month );

   function Pretty_Print( i : Pydptcw_Type ) return String;
   function Null_Or_Missing( i : Pydptcw_Type ) return Boolean;
   function Convert_Pydptcw_Type( i : String ) return Pydptcw_Type;


   type Pyenrl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      strictly_enforced,
      not_very_strictly_enforced,
      it_varies );

   function Pretty_Print( i : Pyenrl_Type ) return String;
   function Null_Or_Missing( i : Pyenrl_Type ) return Boolean;
   function Convert_Pyenrl_Type( i : String ) return Pyenrl_Type;


   type Pyhap1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      completely_happy,
      neither_happy_or_unhappy,
      completely_unhappy );

   function Pretty_Print( i : Pyhap1_Type ) return String;
   function Null_Or_Missing( i : Pyhap1_Type ) return Boolean;
   function Convert_Pyhap1_Type( i : String ) return Pyhap1_Type;


   type Pyhlt1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      excellent,
      good,
      fair,
      poor );

   function Pretty_Print( i : Pyhlt1_Type ) return String;
   function Null_Or_Missing( i : Pyhlt1_Type ) return Boolean;
   function Convert_Pyhlt1_Type( i : String ) return Pyhlt1_Type;


   type Pyhlth_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      parents_resp,
      youths_resp,
      both_or_it_varies );

   function Pretty_Print( i : Pyhlth_Type ) return String;
   function Null_Or_Missing( i : Pyhlth_Type ) return Boolean;
   function Convert_Pyhlth_Type( i : String ) return Pyhlth_Type;


   type Pyhwrk_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      keep_regular_eye,
      keep_occasional_eye,
      leave_to_work_on_own );

   function Pretty_Print( i : Pyhwrk_Type ) return String;
   function Null_Or_Missing( i : Pyhwrk_Type ) return Boolean;
   function Convert_Pyhwrk_Type( i : String ) return Pyhwrk_Type;


   type Pyman1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      very_easy,
      quite_easy,
      quite_difficult,
      very_difficult,
      it_varies );

   function Pretty_Print( i : Pyman1_Type ) return String;
   function Null_Or_Missing( i : Pyman1_Type ) return Boolean;
   function Convert_Pyman1_Type( i : String ) return Pyman1_Type;


   type Pyrule_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      lots_of_rules,
      not_many_rules,
      it_varies );

   function Pretty_Print( i : Pyrule_Type ) return String;
   function Null_Or_Missing( i : Pyrule_Type ) return Boolean;
   function Convert_Pyrule_Type( i : String ) return Pyrule_Type;


   type Pysad1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none,
      s_1_3,
      s_4_10,
      s_11_days_or_more );

   function Pretty_Print( i : Pysad1_Type ) return String;
   function Null_Or_Missing( i : Pysad1_Type ) return Boolean;
   function Convert_Pysad1_Type( i : String ) return Pysad1_Type;


   type Pysat1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      scottish_ed_inapplicable );

   function Pretty_Print( i : Pysat1_Type ) return String;
   function Null_Or_Missing( i : Pysat1_Type ) return Boolean;
   function Convert_Pysat1_Type( i : String ) return Pysat1_Type;


   type Pyser_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      stealing_money,
      swearing,
      smoking,
      telling_lies_to_parents,
      taking_drugs,
      playing_truant );

   function Pretty_Print( i : Pyser_Type ) return String;
   function Null_Or_Missing( i : Pyser_Type ) return Boolean;
   function Convert_Pyser_Type( i : String ) return Pyser_Type;


   type Pysmk1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      less_than_once_a_wk );

   function Pretty_Print( i : Pysmk1_Type ) return String;
   function Null_Or_Missing( i : Pysmk1_Type ) return Boolean;
   function Convert_Pysmk1_Type( i : String ) return Pysmk1_Type;


   type Pyste1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      above_level_8 );

   function Pretty_Print( i : Pyste1_Type ) return String;
   function Null_Or_Missing( i : Pyste1_Type ) return Boolean;
   function Convert_Pyste1_Type( i : String ) return Pyste1_Type;


   type Pysty1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      s_11_year_old,
      s_14_year_old );

   function Pretty_Print( i : Pysty1_Type ) return String;
   function Null_Or_Missing( i : Pysty1_Type ) return Boolean;
   function Convert_Pysty1_Type( i : String ) return Pysty1_Type;


   type Pysxag_Type is (  
      dont_know,
      refused,
      when_child_asks,
      proxy_and_or_phone,
      not_applicable,
      missing );

   function Pretty_Print( i : Pysxag_Type ) return String;
   function Null_Or_Missing( i : Pysxag_Type ) return Boolean;
   function Convert_Pysxag_Type( i : String ) return Pysxag_Type;


   type Pysxed_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      mainly_parents,
      mainly_schools,
      both,
      neither );

   function Pretty_Print( i : Pysxed_Type ) return String;
   function Null_Or_Missing( i : Pysxed_Type ) return Boolean;
   function Convert_Pysxed_Type( i : String ) return Pysxed_Type;


   type Pytc_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      working_families_tc,
      disabled_persons_tc,
      none_of_these );

   function Pretty_Print( i : Pytc_Type ) return String;
   function Null_Or_Missing( i : Pytc_Type ) return Boolean;
   function Convert_Pytc_Type( i : String ) return Pytc_Type;


   type Pythh1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none_or_almost_none,
      under_1_hour,
      s_1_2_hours,
      s_3_5_hours,
      s_6_hours_or_more );

   function Pretty_Print( i : Pythh1_Type ) return String;
   function Null_Or_Missing( i : Pythh1_Type ) return Boolean;
   function Convert_Pythh1_Type( i : String ) return Pythh1_Type;


   type Pytvrl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      no_tv );

   function Pretty_Print( i : Pytvrl_Type ) return String;
   function Null_Or_Missing( i : Pytvrl_Type ) return Boolean;
   function Convert_Pytvrl_Type( i : String ) return Pytvrl_Type;


   type Pywftcw_Type is (  
      not_answered,
      refused,
      period_uncodeable,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      week,
      fortnight,
      four_weeks,
      calendar_month,
      other );

   function Pretty_Print( i : Pywftcw_Type ) return String;
   function Null_Or_Missing( i : Pywftcw_Type ) return Boolean;
   function Convert_Pywftcw_Type( i : String ) return Pywftcw_Type;


   type Pywhr1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      always,
      usually,
      sometimes,
      not_usually,
      never_out_goes_alone );

   function Pretty_Print( i : Pywhr1_Type ) return String;
   function Null_Or_Missing( i : Pywhr1_Type ) return Boolean;
   function Convert_Pywhr1_Type( i : String ) return Pywhr1_Type;


   type Pywor1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      none,
      s_1_2,
      s_3_5,
      s_6_7_nights );

   function Pretty_Print( i : Pywor1_Type ) return String;
   function Null_Or_Missing( i : Pywor1_Type ) return Boolean;
   function Convert_Pywor1_Type( i : String ) return Pywor1_Type;


   type Qallif1_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      good_health_mobility,
      finances_or_standard_of_living,
      consumption_or_shopping,
      home_comforts,
      employment,
      car_transport,
      education_own_or_childrens,
      other_material_benefits,
      freedom_or_independence,
      food_or_cooking_or_drink,
      music_or_radio_or_theatre,
      sports,
      walking_or_cycling,
      tv,
      gardening,
      reading_or_writing_or_painting,
      travel_or_holidays,
      other_leisure_activities,
      happiness_or_peace_of_mind,
      religion,
      equality_or_tolerance,
      helping_others,
      political_activities,
      other_moral_or_community,
      safety_or_lack_of_fear,
      children,
      partner,
      other_family_members,
      neighbours,
      friends_or_socialising,
      pets,
      other_relationships,
      time_for_self_or_not_overworked,
      recreational_facilities,
      neighbourhood_specific,
      neighbourhood_general,
      environment,
      lack_of_crime,
      climate_or_weather,
      other_environmental,
      life_course_characteristics,
      other_positive_mentions,
      better_personal_chars,
      better_material_chars,
      more_leisure,
      more_morality_etc,
      better_relationships,
      better_locality_or_environment,
      other_negative_mentions,
      other_personal_characteristics,
      other,
      dont_know,
      nothing_written_in_or_refused );

   function Pretty_Print( i : Qallif1_Type ) return String;
   function Null_Or_Missing( i : Qallif1_Type ) return Boolean;
   function Convert_Qallif1_Type( i : String ) return Qallif1_Type;


   type Qallif2_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      good_health_mobility,
      finances_or_standard_of_living,
      consumption_or_shopping,
      home_comforts,
      employment,
      car_transport,
      education_own_or_childrens,
      other_material_benefits,
      freedom_or_independence,
      food_or_cooking_or_drink,
      music_or_radio_or_theatre,
      sports,
      walking_or_cycling,
      tv,
      gardening,
      reading_or_writing_or_painting,
      travel_or_holidays,
      other_leisure_activities,
      happiness_or_peace_of_mind,
      religion,
      equality_or_tolerance,
      helping_others,
      political_activities,
      other_moral_or_community,
      safety_or_lack_of_fear,
      children,
      partner,
      other_family_members,
      neighbours,
      friends_or_socialising,
      pets,
      other_relationships,
      time_for_self_or_not_overworked,
      recreational_facilities,
      neighbourhood_specific,
      neighbourhood_general,
      environment,
      lack_of_crime,
      climate_or_weather,
      other_environmental,
      life_course_characteristics,
      other_positive_mentions,
      better_personal_chars,
      better_material_chars,
      more_leisure,
      more_morality_etc,
      better_relationships,
      better_locality_or_environment,
      other_negative_mentions,
      other_personal_characteristics,
      other );

   function Pretty_Print( i : Qallif2_Type ) return String;
   function Null_Or_Missing( i : Qallif2_Type ) return Boolean;
   function Convert_Qallif2_Type( i : String ) return Qallif2_Type;


   type Qfa_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      youth_train_cert );

   function Pretty_Print( i : Qfa_Type ) return String;
   function Null_Or_Missing( i : Qfa_Type ) return Boolean;
   function Convert_Qfa_Type( i : String ) return Qfa_Type;


   type Qfachi_Type is (  
      proxy_respondent,
      proxy,
      missing,
      higher_degree,
      s_1st_degree,
      hnd_hnc_teaching,
      a_level,
      o_level,
      cse,
      none_of_these );

   function Pretty_Print( i : Qfachi_Type ) return String;
   function Null_Or_Missing( i : Qfachi_Type ) return Boolean;
   function Convert_Qfachi_Type( i : String ) return Qfachi_Type;


   type Qfb_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      trade_apprenship );

   function Pretty_Print( i : Qfb_Type ) return String;
   function Null_Or_Missing( i : Qfb_Type ) return Boolean;
   function Convert_Qfb_Type( i : String ) return Qfb_Type;


   type Qfc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      clerical_or_comml );

   function Pretty_Print( i : Qfc_Type ) return String;
   function Null_Or_Missing( i : Qfc_Type ) return Boolean;
   function Convert_Qfc_Type( i : String ) return Qfc_Type;


   type Qfd_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      city_and_guilds_pt_i );

   function Pretty_Print( i : Qfd_Type ) return String;
   function Null_Or_Missing( i : Qfd_Type ) return Boolean;
   function Convert_Qfd_Type( i : String ) return Qfd_Type;


   type Qfe_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      city_and_guilds_pt_ii );

   function Pretty_Print( i : Qfe_Type ) return String;
   function Null_Or_Missing( i : Qfe_Type ) return Boolean;
   function Convert_Qfe_Type( i : String ) return Qfe_Type;


   type Qfeda_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      schl_cert_or_matric );

   function Pretty_Print( i : Qfeda_Type ) return String;
   function Null_Or_Missing( i : Qfeda_Type ) return Boolean;
   function Convert_Qfeda_Type( i : String ) return Qfeda_Type;


   type Qfedb_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      cse_grade_2_5 );

   function Pretty_Print( i : Qfedb_Type ) return String;
   function Null_Or_Missing( i : Qfedb_Type ) return Boolean;
   function Convert_Qfedb_Type( i : String ) return Qfedb_Type;


   type Qfedc_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      cse_grade_1 );

   function Pretty_Print( i : Qfedc_Type ) return String;
   function Null_Or_Missing( i : Qfedc_Type ) return Boolean;
   function Convert_Qfedc_Type( i : String ) return Qfedc_Type;


   type Qfedd_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      gcse_grades_d_g );

   function Pretty_Print( i : Qfedd_Type ) return String;
   function Null_Or_Missing( i : Qfedd_Type ) return Boolean;
   function Convert_Qfedd_Type( i : String ) return Qfedd_Type;


   type Qfede_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      gcse_grades_a_c );

   function Pretty_Print( i : Qfede_Type ) return String;
   function Null_Or_Missing( i : Qfede_Type ) return Boolean;
   function Convert_Qfede_Type( i : String ) return Qfede_Type;


   type Qfedf_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      o_level );

   function Pretty_Print( i : Qfedf_Type ) return String;
   function Null_Or_Missing( i : Qfedf_Type ) return Boolean;
   function Convert_Qfedf_Type( i : String ) return Qfedf_Type;


   type Qfedg_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      o_level_a_c );

   function Pretty_Print( i : Qfedg_Type ) return String;
   function Null_Or_Missing( i : Qfedg_Type ) return Boolean;
   function Convert_Qfedg_Type( i : String ) return Qfedg_Type;


   type Qfedh_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      o_level_d_e );

   function Pretty_Print( i : Qfedh_Type ) return String;
   function Null_Or_Missing( i : Qfedh_Type ) return Boolean;
   function Convert_Qfedh_Type( i : String ) return Qfedh_Type;


   type Qfedhi_Type is (  
      proxy_respondent,
      proxy,
      missing,
      higher_degree,
      apprenticeship,
      other_qf,
      no_qf,
      still_at_school_no_qf,
      first_degree,
      teaching_qf,
      other_higher_qf,
      nursing_qf,
      gce_a_levels,
      gce_o_levels_or_equiv,
      commercial_qf_no_o_levels,
      cse_grade_2_5_scot_grade_4_5 );

   function Pretty_Print( i : Qfedhi_Type ) return String;
   function Null_Or_Missing( i : Qfedhi_Type ) return Boolean;
   function Convert_Qfedhi_Type( i : String ) return Qfedhi_Type;


   type Qfedi_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      higher_sch_cert );

   function Pretty_Print( i : Qfedi_Type ) return String;
   function Null_Or_Missing( i : Qfedi_Type ) return Boolean;
   function Convert_Qfedi_Type( i : String ) return Qfedi_Type;


   type Qfedj_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      a_level );

   function Pretty_Print( i : Qfedj_Type ) return String;
   function Null_Or_Missing( i : Qfedj_Type ) return Boolean;
   function Convert_Qfedj_Type( i : String ) return Qfedj_Type;


   type Qfedk_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      sce_ord_d_e_or_4_5 );

   function Pretty_Print( i : Qfedk_Type ) return String;
   function Null_Or_Missing( i : Qfedk_Type ) return Boolean;
   function Convert_Qfedk_Type( i : String ) return Qfedk_Type;


   type Qfedl_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      o_grades );

   function Pretty_Print( i : Qfedl_Type ) return String;
   function Null_Or_Missing( i : Qfedl_Type ) return Boolean;
   function Convert_Qfedl_Type( i : String ) return Qfedl_Type;


   type Qfedm_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      stand_grades_4_7 );

   function Pretty_Print( i : Qfedm_Type ) return String;
   function Null_Or_Missing( i : Qfedm_Type ) return Boolean;
   function Convert_Qfedm_Type( i : String ) return Qfedm_Type;


   type Qfedn_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      stand_grades_1_3 );

   function Pretty_Print( i : Qfedn_Type ) return String;
   function Null_Or_Missing( i : Qfedn_Type ) return Boolean;
   function Convert_Qfedn_Type( i : String ) return Qfedn_Type;


   type Qfedo_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      higher_grade );

   function Pretty_Print( i : Qfedo_Type ) return String;
   function Null_Or_Missing( i : Qfedo_Type ) return Boolean;
   function Convert_Qfedo_Type( i : String ) return Qfedo_Type;


   type Qfedp_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      cert_6th_yr );

   function Pretty_Print( i : Qfedp_Type ) return String;
   function Null_Or_Missing( i : Qfedp_Type ) return Boolean;
   function Convert_Qfedp_Type( i : String ) return Qfedp_Type;


   type Qfedq_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      slc_lower_grade );

   function Pretty_Print( i : Qfedq_Type ) return String;
   function Null_Or_Missing( i : Qfedq_Type ) return Boolean;
   function Convert_Qfedq_Type( i : String ) return Qfedq_Type;


   type Qfedr_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      slc_higher_grade );

   function Pretty_Print( i : Qfedr_Type ) return String;
   function Null_Or_Missing( i : Qfedr_Type ) return Boolean;
   function Convert_Qfedr_Type( i : String ) return Qfedr_Type;


   type Qfedt_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      gnvq );

   function Pretty_Print( i : Qfedt_Type ) return String;
   function Null_Or_Missing( i : Qfedt_Type ) return Boolean;
   function Convert_Qfedt_Type( i : String ) return Qfedt_Type;


   type Qfedu_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      a_or_s_level );

   function Pretty_Print( i : Qfedu_Type ) return String;
   function Null_Or_Missing( i : Qfedu_Type ) return Boolean;
   function Convert_Qfedu_Type( i : String ) return Qfedu_Type;


   type Qfedxd_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      cpve );

   function Pretty_Print( i : Qfedxd_Type ) return String;
   function Null_Or_Missing( i : Qfedxd_Type ) return Boolean;
   function Convert_Qfedxd_Type( i : String ) return Qfedxd_Type;


   type Qfedxf_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      o_grades_a_c_or_1_3 );

   function Pretty_Print( i : Qfedxf_Type ) return String;
   function Null_Or_Missing( i : Qfedxf_Type ) return Boolean;
   function Convert_Qfedxf_Type( i : String ) return Qfedxf_Type;


   type Qfedxh_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      stand_grade_1_3 );

   function Pretty_Print( i : Qfedxh_Type ) return String;
   function Null_Or_Missing( i : Qfedxh_Type ) return Boolean;
   function Convert_Qfedxh_Type( i : String ) return Qfedxh_Type;


   type Qfedxm_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      a_level_c_e );

   function Pretty_Print( i : Qfedxm_Type ) return String;
   function Null_Or_Missing( i : Qfedxm_Type ) return Boolean;
   function Convert_Qfedxm_Type( i : String ) return Qfedxm_Type;


   type Qfedxn_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      a_level_a_b );

   function Pretty_Print( i : Qfedxn_Type ) return String;
   function Null_Or_Missing( i : Qfedxn_Type ) return Boolean;
   function Convert_Qfedxn_Type( i : String ) return Qfedxn_Type;


   type Qfedxo_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      as_level );

   function Pretty_Print( i : Qfedxo_Type ) return String;
   function Null_Or_Missing( i : Qfedxo_Type ) return Boolean;
   function Convert_Qfedxo_Type( i : String ) return Qfedxo_Type;


   type Qff_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      city_and_guilds_pt_iii );

   function Pretty_Print( i : Qff_Type ) return String;
   function Null_Or_Missing( i : Qff_Type ) return Boolean;
   function Convert_Qff_Type( i : String ) return Qff_Type;


   type Qfg_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      onc_or_ond );

   function Pretty_Print( i : Qfg_Type ) return String;
   function Null_Or_Missing( i : Qfg_Type ) return Boolean;
   function Convert_Qfg_Type( i : String ) return Qfg_Type;


   type Qfh_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      hnc_or_hnd );

   function Pretty_Print( i : Qfh_Type ) return String;
   function Null_Or_Missing( i : Qfh_Type ) return Boolean;
   function Convert_Qfh_Type( i : String ) return Qfh_Type;


   type Qfi_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      nursing_quals );

   function Pretty_Print( i : Qfi_Type ) return String;
   function Null_Or_Missing( i : Qfi_Type ) return Boolean;
   function Convert_Qfi_Type( i : String ) return Qfi_Type;


   type Qfj_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      teaching_quals );

   function Pretty_Print( i : Qfj_Type ) return String;
   function Null_Or_Missing( i : Qfj_Type ) return Boolean;
   function Convert_Qfj_Type( i : String ) return Qfj_Type;


   type Qfk_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      university_dipl );

   function Pretty_Print( i : Qfk_Type ) return String;
   function Null_Or_Missing( i : Qfk_Type ) return Boolean;
   function Convert_Qfk_Type( i : String ) return Qfk_Type;


   type Qfl_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      univ_1st_degree );

   function Pretty_Print( i : Qfl_Type ) return String;
   function Null_Or_Missing( i : Qfl_Type ) return Boolean;
   function Convert_Qfl_Type( i : String ) return Qfl_Type;


   type Qfm_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      univ_higher_deg );

   function Pretty_Print( i : Qfm_Type ) return String;
   function Null_Or_Missing( i : Qfm_Type ) return Boolean;
   function Convert_Qfm_Type( i : String ) return Qfm_Type;


   type Qfn_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other_tech_or_prof );

   function Pretty_Print( i : Qfn_Type ) return String;
   function Null_Or_Missing( i : Qfn_Type ) return Boolean;
   function Convert_Qfn_Type( i : String ) return Qfn_Type;


   type Qfvoc_Type is (  
      proxy_respondent,
      proxy,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Qfvoc_Type ) return String;
   function Null_Or_Missing( i : Qfvoc_Type ) return Boolean;
   function Convert_Qfvoc_Type( i : String ) return Qfvoc_Type;


   type Qfxo_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      nvq_or_svq_level_1 );

   function Pretty_Print( i : Qfxo_Type ) return String;
   function Null_Or_Missing( i : Qfxo_Type ) return Boolean;
   function Convert_Qfxo_Type( i : String ) return Qfxo_Type;


   type Qfxp_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      nvq_or_svq_level_2 );

   function Pretty_Print( i : Qfxp_Type ) return String;
   function Null_Or_Missing( i : Qfxp_Type ) return Boolean;
   function Convert_Qfxp_Type( i : String ) return Qfxp_Type;


   type Qfxq_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      nvq_or_svq_level_3 );

   function Pretty_Print( i : Qfxq_Type ) return String;
   function Null_Or_Missing( i : Qfxq_Type ) return Boolean;
   function Convert_Qfxq_Type( i : String ) return Qfxq_Type;


   type Qfxr_Type is (  
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      not_mentioned,
      nvq_or_svq_level_4 );

   function Pretty_Print( i : Qfxr_Type ) return String;
   function Null_Or_Missing( i : Qfxr_Type ) return Boolean;
   function Convert_Qfxr_Type( i : String ) return Qfxr_Type;


   type Qlfa_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      often,
      sometimes,
      not_often,
      never );

   function Pretty_Print( i : Qlfa_Type ) return String;
   function Null_Or_Missing( i : Qlfa_Type ) return Boolean;
   function Convert_Qlfa_Type( i : String ) return Qlfa_Type;


   type Race_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      white,
      black_carib,
      black_african,
      black_other,
      indian,
      pakistani,
      bangladeshi,
      chinese,
      other_ethnic_grp );

   function Pretty_Print( i : Race_Type ) return String;
   function Null_Or_Missing( i : Race_Type ) return Boolean;
   function Convert_Race_Type( i : String ) return Race_Type;


   type Racel_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      white_british,
      asian_or_brit_indian,
      asian_or_brit_pakistani,
      asian_or_brit_bangladeshi,
      other_asian_bground,
      black_or_brit_caribbean,
      black_or_brit_african,
      other_black_bground,
      chinese,
      any_other,
      white_irish,
      white_welsh,
      white_scottish,
      other_white_bground,
      mix_w_and_b_caribbean,
      mixed_w_and_b_african,
      mix_white_and_asian,
      other_mixed_bground );

   function Pretty_Print( i : Racel_Type ) return String;
   function Null_Or_Missing( i : Racel_Type ) return Boolean;
   function Convert_Racel_Type( i : String ) return Racel_Type;


   type Rapid_Type is (  
      inapplicable,
      missing_or_wild,
      s_16_years_or_over );

   function Pretty_Print( i : Rapid_Type ) return String;
   function Null_Or_Missing( i : Rapid_Type ) return Boolean;
   function Convert_Rapid_Type( i : String ) return Rapid_Type;


   type Region_Type is (  
      inapplicable,
      missing,
      inner_london,
      merseyside,
      r_of_north_west,
      south_yorkshire,
      west_yorkshire,
      r_of_yorks_and_humberside,
      tyne_and_wear,
      r_of_north,
      wales,
      scotland,
      northern_ireland,
      outer_london,
      r_of_south_east,
      south_west,
      east_anglia,
      east_midlands,
      west_midlands_conurbation,
      r_of_west_midlands,
      greater_manchester );

   function Pretty_Print( i : Region_Type ) return String;
   function Null_Or_Missing( i : Region_Type ) return Boolean;
   function Convert_Region_Type( i : String ) return Region_Type;


   type Region2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing,
      north_east,
      wales,
      scotland,
      northern_ireland,
      channel_islands,
      north_west,
      yorkshire_and_the_humber,
      east_midlands,
      west_midlands,
      east_of_england,
      london,
      south_east,
      south_west );

   function Pretty_Print( i : Region2_Type ) return String;
   function Null_Or_Missing( i : Region2_Type ) return Boolean;
   function Convert_Region2_Type( i : String ) return Region2_Type;


   type Rel_Type is (  
      missing_hh_information,
      undefined,
      natural_brother_or_sister,
      other_brother_or_sister,
      brother_or_sister_in_law,
      natural_parent,
      other_parent,
      mother_or_father_in_law,
      any_grand_parent,
      any_grand_child,
      any_cousin,
      any_aunt_or_uncle,
      lawful_spouse,
      any_nephew_or_niece,
      any_other_relative,
      employee,
      lodger_or_border,
      unrelated_sharer,
      step_parent,
      employer,
      landlady_or_lord,
      half_sibling,
      other_child,
      live_in_partner,
      other,
      natural_child,
      adopted_child,
      foster_child,
      step_or_partners_child,
      daughter_or_son_in_law );

   function Pretty_Print( i : Rel_Type ) return String;
   function Null_Or_Missing( i : Rel_Type ) return Boolean;
   function Convert_Rel_Type( i : String ) return Rel_Type;


   type Rent_Type is (  
      dont_know,
      refused,
      s_100pct_rent_rebate,
      rent_free_phone_q,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_9997_or_above );

   function Pretty_Print( i : Rent_Type ) return String;
   function Null_Or_Missing( i : Rent_Type ) return Boolean;
   function Convert_Rent_Type( i : String ) return Rent_Type;


   type Rent1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      na_in_northern_ireland );

   function Pretty_Print( i : Rent1_Type ) return String;
   function Null_Or_Missing( i : Rent1_Type ) return Boolean;
   function Convert_Rent1_Type( i : String ) return Rent1_Type;


   type Rent7_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      yes,
      no,
      na_in_northern_ireland );

   function Pretty_Print( i : Rent7_Type ) return String;
   function Null_Or_Missing( i : Rent7_Type ) return Boolean;
   function Convert_Rent7_Type( i : String ) return Rent7_Type;


   type Rentf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      furnished,
      partly_furnished,
      unfurnished );

   function Pretty_Print( i : Rentf_Type ) return String;
   function Null_Or_Missing( i : Rentf_Type ) return Boolean;
   function Convert_Rentf_Type( i : String ) return Rentf_Type;


   type Renthb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      not_applicable );

   function Pretty_Print( i : Renthb_Type ) return String;
   function Null_Or_Missing( i : Renthb_Type ) return Boolean;
   function Convert_Renthb_Type( i : String ) return Renthb_Type;


   type Renti_Type is (  
      var_dont_know,
      var_refused,
      var_period_uncodeable,
      var_one_off_payment,
      proxy_and_or_phone,
      var_inapplicable,
      var_missing_or_wild,
      not_imputed );

   function Pretty_Print( i : Renti_Type ) return String;
   function Null_Or_Missing( i : Renti_Type ) return Boolean;
   function Convert_Renti_Type( i : String ) return Renti_Type;


   type Rentll_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      local_auth_or_council,
      other_individual,
      newtown_comm_or_corp,
      property_company,
      scottish_homes,
      other_housg_assoc,
      employer,
      other_org,
      relative );

   function Pretty_Print( i : Rentll_Type ) return String;
   function Null_Or_Missing( i : Rentll_Type ) return Boolean;
   function Convert_Rentll_Type( i : String ) return Rentll_Type;


   type Rentw_Type is (  
      dont_know,
      refused,
      period_uncodeable,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Rentw_Type ) return String;
   function Null_Or_Missing( i : Rentw_Type ) return Boolean;
   function Convert_Rentw_Type( i : String ) return Rentw_Type;


   type Retamt_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      less_than_a_quarter,
      about_a_quarter,
      about_a_third,
      about_a_half,
      about_two_thirds,
      about_three_quarters,
      other );

   function Pretty_Print( i : Retamt_Type ) return String;
   function Null_Or_Missing( i : Retamt_Type ) return Boolean;
   function Convert_Retamt_Type( i : String ) return Retamt_Type;


   type Retexp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      more_than,
      less_than,
      about_the_same );

   function Pretty_Print( i : Retexp_Type ) return String;
   function Null_Or_Missing( i : Retexp_Type ) return Boolean;
   function Convert_Retexp_Type( i : String ) return Retexp_Type;


   type Retfix_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      never_worked );

   function Pretty_Print( i : Retfix_Type ) return String;
   function Null_Or_Missing( i : Retfix_Type ) return Boolean;
   function Convert_Retfix_Type( i : String ) return Retfix_Type;


   type Retsuf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      more_than_enough_to_meet_your_needs,
      just_about_enough_to_meet_your_needs,
      less_than_enough_to_meet_your_needs );

   function Pretty_Print( i : Retsuf_Type ) return String;
   function Null_Or_Missing( i : Retsuf_Type ) return Boolean;
   function Convert_Retsuf_Type( i : String ) return Retsuf_Type;


   type Rework_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes_hope_so,
      no );

   function Pretty_Print( i : Rework_Type ) return String;
   function Null_Or_Missing( i : Rework_Type ) return Boolean;
   function Convert_Rework_Type( i : String ) return Rework_Type;


   type Rf2ck_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes_has_no_private_pension,
      no_has_private_pension );

   function Pretty_Print( i : Rf2ck_Type ) return String;
   function Null_Or_Missing( i : Rf2ck_Type ) return Boolean;
   function Convert_Rf2ck_Type( i : String ) return Rf2ck_Type;


   type Riska_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      wont_take_risks,
      ready_to_take_risks );

   function Pretty_Print( i : Riska_Type ) return String;
   function Null_Or_Missing( i : Riska_Type ) return Boolean;
   function Convert_Riska_Type( i : String ) return Riska_Type;


   type Riskb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      dont_trust_strangers,
      will_trust_strangers );

   function Pretty_Print( i : Riskb_Type ) return String;
   function Null_Or_Missing( i : Riskb_Type ) return Boolean;
   function Convert_Riskb_Type( i : String ) return Riskb_Type;


   type Rtcomp_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      better,
      about_the_same,
      not_as_good,
      retired_lt_1_year );

   function Pretty_Print( i : Rtcomp_Type ) return String;
   function Null_Or_Missing( i : Rtcomp_Type ) return Boolean;
   function Convert_Rtcomp_Type( i : String ) return Rtcomp_Type;


   type Rtcon1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      a_lot,
      somewhat,
      a_little,
      not_at_all,
      didnt_work );

   function Pretty_Print( i : Rtcon1_Type ) return String;
   function Null_Or_Missing( i : Rtcon1_Type ) return Boolean;
   function Convert_Rtcon1_Type( i : String ) return Rtcon1_Type;


   type Rtlata_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      improve_finances );

   function Pretty_Print( i : Rtlata_Type ) return String;
   function Null_Or_Missing( i : Rtlata_Type ) return Boolean;
   function Convert_Rtlata_Type( i : String ) return Rtlata_Type;


   type Rtlatb_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      enjoyed_my_job_or_working,
      enjoyed_job );

   function Pretty_Print( i : Rtlatb_Type ) return String;
   function Null_Or_Missing( i : Rtlatb_Type ) return Boolean;
   function Convert_Rtlatb_Type( i : String ) return Rtlatb_Type;


   type Rtlatc_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      didnt_know,
      no_alternatives );

   function Pretty_Print( i : Rtlatc_Type ) return String;
   function Null_Or_Missing( i : Rtlatc_Type ) return Boolean;
   function Convert_Rtlatc_Type( i : String ) return Rtlatc_Type;


   type Rtlatd_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      to_keep_fit_and_active,
      keep_fit_active );

   function Pretty_Print( i : Rtlatd_Type ) return String;
   function Null_Or_Missing( i : Rtlatd_Type ) return Boolean;
   function Convert_Rtlatd_Type( i : String ) return Rtlatd_Type;


   type Rtlate_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      persuaded_my_my_employer_to_stay_on,
      employer_persuaded );

   function Pretty_Print( i : Rtlate_Type ) return String;
   function Null_Or_Missing( i : Rtlate_Type ) return Boolean;
   function Convert_Rtlate_Type( i : String ) return Rtlate_Type;


   type Rtlatf_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      could_not_afford_to_retire_at_that_time,
      couldnt_afford_it );

   function Pretty_Print( i : Rtlatf_Type ) return String;
   function Null_Or_Missing( i : Rtlatf_Type ) return Boolean;
   function Convert_Rtlatf_Type( i : String ) return Rtlatf_Type;


   type Rtlatg_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      to_retire_at_the_same_time_as_my_partner,
      same_time );

   function Pretty_Print( i : Rtlatg_Type ) return String;
   function Null_Or_Missing( i : Rtlatg_Type ) return Boolean;
   function Convert_Rtlatg_Type( i : String ) return Rtlatg_Type;


   type Rtlath_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      to_retire_different_time_to_my_partner,
      different_time );

   function Pretty_Print( i : Rtlath_Type ) return String;
   function Null_Or_Missing( i : Rtlath_Type ) return Boolean;
   function Convert_Rtlath_Type( i : String ) return Rtlath_Type;


   type Rtlati_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other,
      other_reason );

   function Pretty_Print( i : Rtlati_Type ) return String;
   function Null_Or_Missing( i : Rtlati_Type ) return Boolean;
   function Convert_Rtlati_Type( i : String ) return Rtlati_Type;


   type Rtlatj_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      does_not_consider_retired_late,
      not_considered_late );

   function Pretty_Print( i : Rtlatj_Type ) return String;
   function Null_Or_Missing( i : Rtlatj_Type ) return Boolean;
   function Convert_Rtlatj_Type( i : String ) return Rtlatj_Type;


   type Rtpro1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      very_important,
      moderately_important,
      somewhat_important,
      not_important_at_all );

   function Pretty_Print( i : Rtpro1_Type ) return String;
   function Null_Or_Missing( i : Rtpro1_Type ) return Boolean;
   function Convert_Rtpro1_Type( i : String ) return Rtpro1_Type;


   type Rtrhm_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      very_likely,
      likely,
      unlikely,
      very_unlikely,
      currently_in_a_nursing_home );

   function Pretty_Print( i : Rtrhm_Type ) return String;
   function Null_Or_Missing( i : Rtrhm_Type ) return Boolean;
   function Convert_Rtrhm_Type( i : String ) return Rtrhm_Type;


   type Rtrllt_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      retired_normally,
      retired_early,
      retired_late );

   function Pretty_Print( i : Rtrllt_Type ) return String;
   function Null_Or_Missing( i : Rtrllt_Type ) return Boolean;
   function Convert_Rtrllt_Type( i : String ) return Rtrllt_Type;


   type Rtrlya_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      own_ill_health );

   function Pretty_Print( i : Rtrlya_Type ) return String;
   function Null_Or_Missing( i : Rtrlya_Type ) return Boolean;
   function Convert_Rtrlya_Type( i : String ) return Rtrlya_Type;


   type Rtrlyb_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      ill_health_of_relative_or_friend,
      ill_health_of_other );

   function Pretty_Print( i : Rtrlyb_Type ) return String;
   function Null_Or_Missing( i : Rtrlyb_Type ) return Boolean;
   function Convert_Rtrlyb_Type( i : String ) return Rtrlyb_Type;


   type Rtrlyc_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      redundant_or_dismissed_or_no_choice,
      compulsorily );

   function Pretty_Print( i : Rtrlyc_Type ) return String;
   function Null_Or_Missing( i : Rtrlyc_Type ) return Boolean;
   function Convert_Rtrlyc_Type( i : String ) return Rtrlyc_Type;


   type Rtrlyd_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      offered_reasonable_financial_terms,
      financial_deal );

   function Pretty_Print( i : Rtrlyd_Type ) return String;
   function Null_Or_Missing( i : Rtrlyd_Type ) return Boolean;
   function Convert_Rtrlyd_Type( i : String ) return Rtrlyd_Type;


   type Rtrlye_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      couldnt_find_another_job,
      no_other_job );

   function Pretty_Print( i : Rtrlye_Type ) return String;
   function Null_Or_Missing( i : Rtrlye_Type ) return Boolean;
   function Convert_Rtrlye_Type( i : String ) return Rtrlye_Type;


   type Rtrlyf_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      spend_more_time_with_partner_or_family,
      time_with_family );

   function Pretty_Print( i : Rtrlyf_Type ) return String;
   function Null_Or_Missing( i : Rtrlyf_Type ) return Boolean;
   function Convert_Rtrlyf_Type( i : String ) return Rtrlyf_Type;


   type Rtrlyg_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      enjoy_life_while_young_and_fit,
      enjoy_life );

   function Pretty_Print( i : Rtrlyg_Type ) return String;
   function Null_Or_Missing( i : Rtrlyg_Type ) return Boolean;
   function Convert_Rtrlyg_Type( i : String ) return Rtrlyg_Type;


   type Rtrlyh_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      fed_up_with_job_wanted_a_change,
      needed_change );

   function Pretty_Print( i : Rtrlyh_Type ) return String;
   function Null_Or_Missing( i : Rtrlyh_Type ) return Boolean;
   function Convert_Rtrlyh_Type( i : String ) return Rtrlyh_Type;


   type Rtrlyi_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      to_retire_at_same_time_as_partner,
      same_time );

   function Pretty_Print( i : Rtrlyi_Type ) return String;
   function Null_Or_Missing( i : Rtrlyi_Type ) return Boolean;
   function Convert_Rtrlyi_Type( i : String ) return Rtrlyi_Type;


   type Rtrlyj_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      to_retire_at_different_time_to_partner,
      different_time );

   function Pretty_Print( i : Rtrlyj_Type ) return String;
   function Null_Or_Missing( i : Rtrlyj_Type ) return Boolean;
   function Convert_Rtrlyj_Type( i : String ) return Rtrlyj_Type;


   type Rtrlyk_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      to_give_younger_generation_a_chance,
      for_next_gen );

   function Pretty_Print( i : Rtrlyk_Type ) return String;
   function Null_Or_Missing( i : Rtrlyk_Type ) return Boolean;
   function Convert_Rtrlyk_Type( i : String ) return Rtrlyk_Type;


   type Rtrlyl_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      other );

   function Pretty_Print( i : Rtrlyl_Type ) return String;
   function Null_Or_Missing( i : Rtrlyl_Type ) return Boolean;
   function Convert_Rtrlyl_Type( i : String ) return Rtrlyl_Type;


   type Rtrlym_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      does_not_consider_to_be_retired_early,
      not_early );

   function Pretty_Print( i : Rtrlym_Type ) return String;
   function Null_Or_Missing( i : Rtrlym_Type ) return Boolean;
   function Convert_Rtrlym_Type( i : String ) return Rtrlym_Type;


   type Rtsat_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      very_satisfying,
      moderately_satisfying,
      not_at_all_satisfying );

   function Pretty_Print( i : Rtsat_Type ) return String;
   function Null_Or_Missing( i : Rtsat_Type ) return Boolean;
   function Convert_Rtsat_Type( i : String ) return Rtsat_Type;


   type Rtvol_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      wanted_to_do,
      forced_into,
      part_want_part_force );

   function Pretty_Print( i : Rtvol_Type ) return String;
   function Null_Or_Missing( i : Rtvol_Type ) return Boolean;
   function Convert_Rtvol_Type( i : String ) return Rtvol_Type;


   type Sampst_Type is (  
      not_applicable,
      missing,
      continuing_osm,
      w1_non_cont_or_enum,
      birth_osm,
      psm_parent_of_osm,
      tsm,
      osm_echp_sample,
      echp_rejoiner,
      scot_or_wales_new_sample,
      sw_w9_non_cont_or_enum );

   function Pretty_Print( i : Sampst_Type ) return String;
   function Null_Or_Missing( i : Sampst_Type ) return Boolean;
   function Convert_Sampst_Type( i : String ) return Sampst_Type;


   type Satinv_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      never_interviewed_before,
      not_happy_at_all,
      completely_happy );

   function Pretty_Print( i : Satinv_Type ) return String;
   function Null_Or_Missing( i : Satinv_Type ) return Boolean;
   function Convert_Satinv_Type( i : String ) return Satinv_Type;


   type Savey_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      holidays,
      old_age,
      car,
      children,
      house_purchase,
      home_improv,
      hh_bills,
      special_evnts,
      no_spec_reason,
      other );

   function Pretty_Print( i : Savey_Type ) return String;
   function Null_Or_Missing( i : Savey_Type ) return Boolean;
   function Convert_Savey_Type( i : String ) return Savey_Type;


   type Savey1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      holidays,
      share_schemes,
      own_education,
      grandchild,
      old_age,
      car,
      children,
      house_purchase,
      home_improv,
      hh_bills,
      special_evnts,
      no_spec_reason,
      other );

   function Pretty_Print( i : Savey1_Type ) return String;
   function Null_Or_Missing( i : Savey1_Type ) return Boolean;
   function Convert_Savey1_Type( i : String ) return Savey1_Type;


   type Savlt_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      mainly_long_term,
      mainly_short_term,
      both_equally );

   function Pretty_Print( i : Savlt_Type ) return String;
   function Null_Or_Missing( i : Savlt_Type ) return Boolean;
   function Convert_Savlt_Type( i : String ) return Savlt_Type;


   type Savreg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      regular_basis,
      from_time_to_time,
      other );

   function Pretty_Print( i : Savreg_Type ) return String;
   function Null_Or_Missing( i : Savreg_Type ) return Boolean;
   function Convert_Savreg_Type( i : String ) return Savreg_Type;


   type Sc2uni_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      yes_definitely,
      no,
      dont_mind_or_up_to_child );

   function Pretty_Print( i : Sc2uni_Type ) return String;
   function Null_Or_Missing( i : Sc2uni_Type ) return Boolean;
   function Convert_Sc2uni_Type( i : String ) return Sc2uni_Type;


   type Scach_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      very_important,
      important,
      not_very_important,
      not_at_all_important );

   function Pretty_Print( i : Scach_Type ) return String;
   function Null_Or_Missing( i : Scach_Type ) return Boolean;
   function Convert_Scach_Type( i : String ) return Scach_Type;


   type Scag11_Type is (  
      not_applicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Scag11_Type ) return String;
   function Null_Or_Missing( i : Scag11_Type ) return Boolean;
   function Convert_Scag11_Type( i : String ) return Scag11_Type;


   type Scage_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild );

   function Pretty_Print( i : Scage_Type ) return String;
   function Null_Or_Missing( i : Scage_Type ) return Boolean;
   function Convert_Scage_Type( i : String ) return Scage_Type;


   type Scarg_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      most_days,
      more_than_once_or_week,
      less_than_once_or_week,
      hardly_ever );

   function Pretty_Print( i : Scarg_Type ) return String;
   function Null_Or_Missing( i : Scarg_Type ) return Boolean;
   function Convert_Scarg_Type( i : String ) return Scarg_Type;


   type Sccudl_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      never,
      seldom,
      sometimes,
      very_often );

   function Pretty_Print( i : Sccudl_Type ) return String;
   function Null_Or_Missing( i : Sccudl_Type ) return Boolean;
   function Convert_Sccudl_Type( i : String ) return Sccudl_Type;


   type Schhw_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      almost_every_day,
      at_least_once_or_week,
      at_least_once_or_month,
      less_than_once_or_month,
      never_or_hardly_ever,
      n_or_a_no_homework );

   function Pretty_Print( i : Schhw_Type ) return String;
   function Null_Or_Missing( i : Schhw_Type ) return Boolean;
   function Convert_Schhw_Type( i : String ) return Schhw_Type;


   type Schlng_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      welsh_language,
      billingual,
      english_language );

   function Pretty_Print( i : Schlng_Type ) return String;
   function Null_Or_Missing( i : Schlng_Type ) return Boolean;
   function Convert_Schlng_Type( i : String ) return Schlng_Type;


   type School_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      never_went_school,
      still_at_school );

   function Pretty_Print( i : School_Type ) return String;
   function Null_Or_Missing( i : School_Type ) return Boolean;
   function Convert_School_Type( i : String ) return School_Type;


   type Schos1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      at_school_before_move,
      friend,
      better_school,
      special_need_or_disabled,
      religious_reasons,
      language_eg_welsh,
      grammar_sch_or_high_sch,
      local_school_full,
      good_for_sport_or_other,
      siblings_went_there,
      other );

   function Pretty_Print( i : Schos1_Type ) return String;
   function Null_Or_Missing( i : Schos1_Type ) return Boolean;
   function Convert_Schos1_Type( i : String ) return Schos1_Type;


   type Schos2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      at_school_before_move,
      friend,
      better_school,
      special_need_or_disabled,
      religious_reasons,
      language_eg_welsh,
      grammar_sch_or_high_sch,
      local_school_full,
      good_for_sport_or_other,
      siblings_went_there,
      other );

   function Pretty_Print( i : Schos2_Type ) return String;
   function Null_Or_Missing( i : Schos2_Type ) return Boolean;
   function Convert_Schos2_Type( i : String ) return Schos2_Type;


   type Schosa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      yes,
      no,
      not_school_age );

   function Pretty_Print( i : Schosa_Type ) return String;
   function Null_Or_Missing( i : Schosa_Type ) return Boolean;
   function Convert_Schosa_Type( i : String ) return Schosa_Type;


   type Schsat_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      very_satisfied,
      satisfied,
      not_very_satisfied,
      not_at_all_satisfied );

   function Pretty_Print( i : Schsat_Type ) return String;
   function Null_Or_Missing( i : Schsat_Type ) return Boolean;
   function Convert_Schsat_Type( i : String ) return Schsat_Type;


   type Schsta_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      state_school,
      private_school );

   function Pretty_Print( i : Schsta_Type ) return String;
   function Null_Or_Missing( i : Schsta_Type ) return Boolean;
   function Convert_Schsta_Type( i : String ) return Schsta_Type;


   type Scluni_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      yes_definitley,
      yes_probably,
      maybe,
      no );

   function Pretty_Print( i : Scluni_Type ) return String;
   function Null_Or_Missing( i : Scluni_Type ) return Boolean;
   function Convert_Scluni_Type( i : String ) return Scluni_Type;


   type Scsex_Type is (  
      not_applicable,
      missing_or_wild,
      male,
      female );

   function Pretty_Print( i : Scsex_Type ) return String;
   function Null_Or_Missing( i : Scsex_Type ) return Boolean;
   function Convert_Scsex_Type( i : String ) return Scsex_Type;


   type Sctut_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      yes,
      no );

   function Pretty_Print( i : Sctut_Type ) return String;
   function Null_Or_Missing( i : Sctut_Type ) return Boolean;
   function Convert_Sctut_Type( i : String ) return Sctut_Type;


   type Sctute_Type is (  
      not_applicable,
      missing_or_wild,
      not_mentioned,
      english );

   function Pretty_Print( i : Sctute_Type ) return String;
   function Null_Or_Missing( i : Sctute_Type ) return Boolean;
   function Convert_Sctute_Type( i : String ) return Sctute_Type;


   type Sctuth_Type is (  
      not_applicable,
      missing_or_wild,
      not_mentioned,
      humanitities );

   function Pretty_Print( i : Sctuth_Type ) return String;
   function Null_Or_Missing( i : Sctuth_Type ) return Boolean;
   function Convert_Sctuth_Type( i : String ) return Sctuth_Type;


   type Sctutl_Type is (  
      not_applicable,
      missing_or_wild,
      not_mentioned,
      languages );

   function Pretty_Print( i : Sctutl_Type ) return String;
   function Null_Or_Missing( i : Sctutl_Type ) return Boolean;
   function Convert_Sctutl_Type( i : String ) return Sctutl_Type;


   type Sctutm_Type is (  
      not_applicable,
      missing_or_wild,
      not_mentioned,
      maths );

   function Pretty_Print( i : Sctutm_Type ) return String;
   function Null_Or_Missing( i : Sctutm_Type ) return Boolean;
   function Convert_Sctutm_Type( i : String ) return Sctutm_Type;


   type Sctuto_Type is (  
      not_applicable,
      missing_or_wild,
      not_mentioned,
      other );

   function Pretty_Print( i : Sctuto_Type ) return String;
   function Null_Or_Missing( i : Sctuto_Type ) return Boolean;
   function Convert_Sctuto_Type( i : String ) return Sctuto_Type;


   type Sctuts_Type is (  
      not_applicable,
      missing_or_wild,
      not_mentioned,
      science );

   function Pretty_Print( i : Sctuts_Type ) return String;
   function Null_Or_Missing( i : Sctuts_Type ) return Boolean;
   function Convert_Sctuts_Type( i : String ) return Sctuts_Type;


   type Sctyp_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      not_at_school_yet,
      primary_school,
      secondary_or_6th_form,
      other );

   function Pretty_Print( i : Sctyp_Type ) return String;
   function Null_Or_Missing( i : Sctyp_Type ) return Boolean;
   function Convert_Sctyp_Type( i : String ) return Sctyp_Type;


   type Sctype_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      comprehensive_school,
      grammar_not_fee_pay,
      grammar_fee_paying,
      sixth_form_college,
      public_and_other_privte,
      elementary,
      secondary_modern,
      technical,
      other_specif_school );

   function Pretty_Print( i : Sctype_Type ) return String;
   function Null_Or_Missing( i : Sctype_Type ) return Boolean;
   function Convert_Sctype_Type( i : String ) return Sctype_Type;


   type Seekid_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      other_or_both_par_dead,
      never,
      a_few_times_a_year,
      once_or_month_or_less,
      several_timesmonth,
      about_once_a_week,
      several_times_or_week,
      almost_every_day,
      shared_care_50_or_50 );

   function Pretty_Print( i : Seekid_Type ) return String;
   function Null_Or_Missing( i : Seekid_Type ) return Boolean;
   function Convert_Seekid_Type( i : String ) return Seekid_Type;


   type Sex_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      male,
      female );

   function Pretty_Print( i : Sex_Type ) return String;
   function Null_Or_Missing( i : Sex_Type ) return Boolean;
   function Convert_Sex_Type( i : String ) return Sex_Type;


   type Smagbg_Type is (  
      dont_know,
      refused,
      never_smoked_reg,
      proxy_and_or_phone,
      not_applicable,
      missing,
      never_smoked_regularly );

   function Pretty_Print( i : Smagbg_Type ) return String;
   function Null_Or_Missing( i : Smagbg_Type ) return Boolean;
   function Convert_Smagbg_Type( i : String ) return Smagbg_Type;


   type Smcigs_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      smoked_regularly,
      smoked_occasionally,
      never_really_smoked );

   function Pretty_Print( i : Smcigs_Type ) return String;
   function Null_Or_Missing( i : Smcigs_Type ) return Boolean;
   function Convert_Smcigs_Type( i : String ) return Smcigs_Type;


   type Smstop_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      less_than_six_months_ago,
      s_6_to_12_months_ago,
      one_to_two_years_ago,
      two_to_five_years_ago,
      five_to_ten_years_ago,
      s_10_or_more_years_ago );

   function Pretty_Print( i : Smstop_Type ) return String;
   function Null_Or_Missing( i : Smstop_Type ) return Boolean;
   function Convert_Smstop_Type( i : String ) return Smstop_Type;


   type Spjb_Type is (  
      proxy_and_or_phone,
      no_spouse_or_partner,
      missing_or_wild,
      no,
      yes );

   function Pretty_Print( i : Spjb_Type ) return String;
   function Null_Or_Missing( i : Spjb_Type ) return Boolean;
   function Convert_Spjb_Type( i : String ) return Spjb_Type;


   type Spjbhr_Type is (  
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      no_expected_hours );

   function Pretty_Print( i : Spjbhr_Type ) return String;
   function Null_Or_Missing( i : Spjbhr_Type ) return Boolean;
   function Convert_Spjbhr_Type( i : String ) return Spjbhr_Type;


   type Spjbot_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      none );

   function Pretty_Print( i : Spjbot_Type ) return String;
   function Null_Or_Missing( i : Spjbot_Type ) return Boolean;
   function Convert_Spjbot_Type( i : String ) return Spjbot_Type;


   type Sppid_Type is (  
      inapplicable,
      missing_or_wild,
      spouse_not_in_hh );

   function Pretty_Print( i : Sppid_Type ) return String;
   function Null_Or_Missing( i : Sppid_Type ) return Boolean;
   function Convert_Sppid_Type( i : String ) return Sppid_Type;


   type Ssupa_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes_one_person,
      yes_more_thn_one,
      no_one );

   function Pretty_Print( i : Ssupa_Type ) return String;
   function Null_Or_Missing( i : Ssupa_Type ) return Boolean;
   function Convert_Ssupa_Type( i : String ) return Ssupa_Type;


   type Ssupr2r_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      nothing_written_in,
      partner,
      child,
      sibling,
      parent,
      grandparent,
      grandchild,
      aunt_or_uncle_or_cousin,
      other_relative,
      friend );

   function Pretty_Print( i : Ssupr2r_Type ) return String;
   function Null_Or_Missing( i : Ssupr2r_Type ) return Boolean;
   function Convert_Ssupr2r_Type( i : String ) return Ssupr2r_Type;


   type Swpop1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      improved_a_lot,
      improved_a_little,
      made_no_difference,
      made_a_little_worse,
      made_a_lot_worse,
      too_early_to_tell );

   function Pretty_Print( i : Swpop1_Type ) return String;
   function Null_Or_Missing( i : Swpop1_Type ) return Boolean;
   function Convert_Swpop1_Type( i : String ) return Swpop1_Type;


   type Swpop2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      strengthened,
      weakened,
      made_no_difference );

   function Pretty_Print( i : Swpop2_Type ) return String;
   function Null_Or_Missing( i : Swpop2_Type ) return Boolean;
   function Convert_Swpop2_Type( i : String ) return Swpop2_Type;


   type Swpop3_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      just_about_always,
      most_of_the_time,
      only_sometimes,
      almost_never );

   function Pretty_Print( i : Swpop3_Type ) return String;
   function Null_Or_Missing( i : Swpop3_Type ) return Boolean;
   function Convert_Swpop3_Type( i : String ) return Swpop3_Type;


   type Swvt1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no,
      couldnt_vote,
      refused_to_disclose );

   function Pretty_Print( i : Swvt1_Type ) return String;
   function Null_Or_Missing( i : Swvt1_Type ) return Boolean;
   function Convert_Swvt1_Type( i : String ) return Swvt1_Type;


   type Swvt2_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      conservative,
      labour,
      lib_dem,
      scot_nat_snp,
      plaid_cymru,
      green_party,
      scottish_socialist_alliance,
      other_party,
      refused_to_disclose );

   function Pretty_Print( i : Swvt2_Type ) return String;
   function Null_Or_Missing( i : Swvt2_Type ) return Boolean;
   function Convert_Swvt2_Type( i : String ) return Swvt2_Type;


   type Telhtq_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      university_first_degree,
      gnvq_or_gsvq,
      sce_ordinary_grades,
      standard_grades,
      higher_grade,
      advanced_higher,
      certificate_of_6th_year_studies,
      slc,
      other_school_exam,
      youth_training_cert,
      trade_or_apprenticeship,
      university_higher_degree,
      clerical,
      city_and_guilds,
      onc_or_ond_or_btec,
      hnc_or_hnd_or_btec,
      nvq_or_svq_level_1_or_2,
      nvq_or_svq_level_3_or_4,
      nursing_qualification,
      teaching_qualification,
      university_diploma,
      scottish_national_qualification,
      other_higher_academic_qual,
      other_technical_or_professional,
      school_certificate,
      cse,
      gcse,
      o_level,
      higher_school_certificate,
      a_level_or_as_level );

   function Pretty_Print( i : Telhtq_Type ) return String;
   function Null_Or_Missing( i : Telhtq_Type ) return Boolean;
   function Convert_Telhtq_Type( i : String ) return Telhtq_Type;


   type Telwhy_Type is (  
      not_answered,
      refused,
      inapplicable,
      missing_or_wild,
      too_ill_or_old,
      other,
      carer_situation_or_family_illness,
      stressful_family_situation,
      refused_full_interview,
      other_family_member_opposes_survey,
      too_busy,
      care_of_ill_or_old,
      stressful_fam_sit,
      refused_full_intv,
      hh_memb_says_refuse );

   function Pretty_Print( i : Telwhy_Type ) return String;
   function Null_Or_Missing( i : Telwhy_Type ) return Boolean;
   function Convert_Telwhy_Type( i : String ) return Telwhy_Type;


   type Tenure_Type is (  
      proxy_and_or_phone,
      missing,
      owned_outright,
      owned_with_mortgage,
      local_authority_rented,
      housing_assoc_rented,
      rented_from_employer,
      rented_private_unfurnished,
      rented_private_furnished,
      other_rented );

   function Pretty_Print( i : Tenure_Type ) return String;
   function Null_Or_Missing( i : Tenure_Type ) return Boolean;
   function Convert_Tenure_Type( i : String ) return Tenure_Type;


   type Tlhqly_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      university_first_degree,
      other_school_exam,
      youth_training_cert,
      trade_or_apprenticeship,
      clerical,
      city_and_guilds,
      onc_or_ond_or_btec,
      hnc_or_hnd_or_btec,
      nvq_or_svq_level_1_or_2,
      nvq_or_svq_level_3_or_4,
      scottish_national_qualification,
      university_higher_degree,
      other_technical_or_professional,
      other_higher_academic_qual,
      gcse,
      a_level_or_as_level,
      gnvq_or_gsvq,
      standard_grades,
      higher_grade,
      advance_higher );

   function Pretty_Print( i : Tlhqly_Type ) return String;
   function Null_Or_Missing( i : Tlhqly_Type ) return Boolean;
   function Convert_Tlhqly_Type( i : String ) return Tlhqly_Type;


   type Troql1_Type is (  
      dont_know,
      proxy_and_or_phone,
      not_applicable,
      missing,
      clerical_commercial,
      nvq_svq_level_4,
      university_diploma,
      university_degree,
      univ_higher_degree,
      other_qualifications,
      city_and_guilds_pti,
      city_and_guilds_ptii,
      city_and_guilds_ptiii,
      ond_btec_national,
      hnd_btec_higher,
      nvq_svq_level_1,
      nvq_svq_level_2,
      nvq_svq_level_3 );

   function Pretty_Print( i : Troql1_Type ) return String;
   function Null_Or_Missing( i : Troql1_Type ) return Boolean;
   function Convert_Troql1_Type( i : String ) return Troql1_Type;


   type Troql2_Type is (  
      not_answered,
      proxy_and_or_phone,
      not_applicable,
      missing,
      clerical_commercial,
      nvq_svq_level_4,
      university_diploma,
      university_degree,
      univ_higher_degree,
      other_qualifications,
      city_and_guilds_pti,
      city_and_guilds_ptii,
      city_and_guilds_ptiii,
      ond_btec_national,
      hnd_btec_higher,
      nvq_svq_level_1,
      nvq_svq_level_2,
      nvq_svq_level_3 );

   function Pretty_Print( i : Troql2_Type ) return String;
   function Null_Or_Missing( i : Troql2_Type ) return Boolean;
   function Convert_Troql2_Type( i : String ) return Troql2_Type;


   type Trplce1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      current_workplace,
      other,
      former_workplace,
      emps_training_centre,
      priv_training_centre,
      job_centre_job_club,
      hfe_college,
      adult_educ_centre,
      university,
      at_or_from_own_home,
      other_cannot_determine );

   function Pretty_Print( i : Trplce1_Type ) return String;
   function Null_Or_Missing( i : Trplce1_Type ) return Boolean;
   function Convert_Trplce1_Type( i : String ) return Trplce1_Type;


   type Trqlac1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      yes,
      no_not_yet_waiting );

   function Pretty_Print( i : Trqlac1_Type ) return String;
   function Null_Or_Missing( i : Trqlac1_Type ) return Boolean;
   function Convert_Trqlac1_Type( i : String ) return Trqlac1_Type;


   type Trqlxp1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      lead_to_qualif,
      lead_to_part_of_qual,
      not_lead_to_qualif );

   function Pretty_Print( i : Trqlxp1_Type ) return String;
   function Null_Or_Missing( i : Trqlxp1_Type ) return Boolean;
   function Convert_Trqlxp1_Type( i : String ) return Trqlxp1_Type;


   type Tru1_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      hours,
      days,
      weeks,
      months,
      other );

   function Pretty_Print( i : Tru1_Type ) return String;
   function Null_Or_Missing( i : Tru1_Type ) return Boolean;
   function Convert_Tru1_Type( i : String ) return Tru1_Type;


   type Trust_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      most_people_can_be_trusted,
      cant_be_too_careful,
      other_or_depends );

   function Pretty_Print( i : Trust_Type ) return String;
   function Null_Or_Missing( i : Trust_Type ) return Boolean;
   function Convert_Trust_Type( i : String ) return Trust_Type;


   type Unib_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      russell_group,
      other_pre_92_university,
      post_1992_university,
      other_uk_institution,
      non_uk_institution );

   function Pretty_Print( i : Unib_Type ) return String;
   function Null_Or_Missing( i : Unib_Type ) return Boolean;
   function Convert_Unib_Type( i : String ) return Unib_Type;


   type Vote_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      conservative,
      none,
      cant_vote,
      ulster_unionist,
      sdlp,
      alliance_party,
      democratic_unionist,
      sinn_fein,
      other_ni_party,
      labour,
      lib_dem_or_lib_or_sdp,
      scot_nat,
      plaid_cymru,
      green_party,
      other_party,
      other_answer );

   function Pretty_Print( i : Vote_Type ) return String;
   function Null_Or_Missing( i : Vote_Type ) return Boolean;
   function Convert_Vote_Type( i : String ) return Vote_Type;


   type Vote10a_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing_written_in,
      lack_of_trust_or_confidence,
      dislike_education_policies,
      dislike_health_policies,
      dislike_housing_policies,
      dislike_european_policies,
      dislike_pensions_policies,
      dislike_economic_policies,
      dislike_other_policies,
      depends_on_mainifesto,
      prefer_policies_of_other_party,
      will_not_vote,
      dislike_party_leader,
      prefer_other_party_leader,
      dislike_local_mp,
      no_particular_reason,
      will_vote_tactically,
      supported_party_cant_win,
      undecided_about_voting,
      time_for_a_change,
      other,
      not_eligible_to_vote );

   function Pretty_Print( i : Vote10a_Type ) return String;
   function Null_Or_Missing( i : Vote10a_Type ) return Boolean;
   function Convert_Vote10a_Type( i : String ) return Vote10a_Type;


   type Vote3_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      conservative,
      none,
      cant_vote,
      ulster_unionist,
      sdlp,
      alliance_party,
      democratic_unionist,
      sinn_fein,
      other_ni_party,
      labour,
      lib_dem_or_lib_or_sdp,
      scot_nat,
      plaid_cymru,
      green_party,
      other_party,
      other_answer,
      na_ons_sub_sample );

   function Pretty_Print( i : Vote3_Type ) return String;
   function Null_Or_Missing( i : Vote3_Type ) return Boolean;
   function Convert_Vote3_Type( i : String ) return Vote3_Type;


   type Vote5_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      very_strong,
      fairly_strong,
      not_very_strong );

   function Pretty_Print( i : Vote5_Type ) return String;
   function Null_Or_Missing( i : Vote5_Type ) return Boolean;
   function Convert_Vote5_Type( i : String ) return Vote5_Type;


   type Vote6_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      very_interested,
      fairly_int,
      not_very_int,
      not_at_all_int );

   function Pretty_Print( i : Vote6_Type ) return String;
   function Null_Or_Missing( i : Vote6_Type ) return Boolean;
   function Convert_Vote6_Type( i : String ) return Vote6_Type;


   type Vote7_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      cant_vote,
      na_ons_sub_sample );

   function Pretty_Print( i : Vote7_Type ) return String;
   function Null_Or_Missing( i : Vote7_Type ) return Boolean;
   function Convert_Vote7_Type( i : String ) return Vote7_Type;


   type Vote8_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      conservative,
      ulster_unionist,
      sdlp,
      alliance_party,
      democratic_unionist,
      sinn_fein,
      other_ni_party,
      labour,
      lib_dem_sld,
      scot_nat,
      plaid_cymru,
      green_party,
      other_party,
      other_answer );

   function Pretty_Print( i : Vote8_Type ) return String;
   function Null_Or_Missing( i : Vote8_Type ) return Boolean;
   function Convert_Vote8_Type( i : String ) return Vote8_Type;


   type Wemwba_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      none_of_the_time,
      rarely,
      some_of_the_time,
      often,
      all_of_the_time );

   function Pretty_Print( i : Wemwba_Type ) return String;
   function Null_Or_Missing( i : Wemwba_Type ) return Boolean;
   function Convert_Wemwba_Type( i : String ) return Wemwba_Type;


   type Whr14_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      natrl_mother_and_father,
      other_relative,
      step_parent,
      other_non_relative,
      institution,
      employers_premises,
      living_independently,
      adoptive_m_and_f,
      mother_and_stepfather,
      father_and_stepmother,
      mother_no_f_figure,
      father_no_m_figure,
      other,
      grand_parents,
      aunt_or_uncle_or_own_sibli );

   function Pretty_Print( i : Whr14_Type ) return String;
   function Null_Or_Missing( i : Whr14_Type ) return Boolean;
   function Convert_Whr14_Type( i : String ) return Whr14_Type;


   type Windfa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      life_ins_policy );

   function Pretty_Print( i : Windfa_Type ) return String;
   function Null_Or_Missing( i : Windfa_Type ) return Boolean;
   function Convert_Windfa_Type( i : String ) return Windfa_Type;


   type Windfb_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      pension_payout );

   function Pretty_Print( i : Windfb_Type ) return String;
   function Null_Or_Missing( i : Windfb_Type ) return Boolean;
   function Convert_Windfb_Type( i : String ) return Windfb_Type;


   type Windfc_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      accident_claim );

   function Pretty_Print( i : Windfc_Type ) return String;
   function Null_Or_Missing( i : Windfc_Type ) return Boolean;
   function Convert_Windfc_Type( i : String ) return Windfc_Type;


   type Windfd_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      redundancy_payment );

   function Pretty_Print( i : Windfd_Type ) return String;
   function Null_Or_Missing( i : Windfd_Type ) return Boolean;
   function Convert_Windfd_Type( i : String ) return Windfd_Type;


   type Windfe_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      employment_bonus );

   function Pretty_Print( i : Windfe_Type ) return String;
   function Null_Or_Missing( i : Windfe_Type ) return Boolean;
   function Convert_Windfe_Type( i : String ) return Windfe_Type;


   type Windff_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      inheritance );

   function Pretty_Print( i : Windff_Type ) return String;
   function Null_Or_Missing( i : Windff_Type ) return Boolean;
   function Convert_Windff_Type( i : String ) return Windff_Type;


   type Windfg_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      pools_or_lottery_win );

   function Pretty_Print( i : Windfg_Type ) return String;
   function Null_Or_Missing( i : Windfg_Type ) return Boolean;
   function Convert_Windfg_Type( i : String ) return Windfg_Type;


   type Windfi_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      not_mentioned,
      building_soc_conv,
      employment_bonus );

   function Pretty_Print( i : Windfi_Type ) return String;
   function Null_Or_Missing( i : Windfi_Type ) return Boolean;
   function Convert_Windfi_Type( i : String ) return Windfi_Type;


   type Wlshua_Type is (  
      not_answered,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing,
      only_welsh,
      mainly_welsh,
      welsh_and_engish_equally,
      mainly_english,
      only_english,
      other );

   function Pretty_Print( i : Wlshua_Type ) return String;
   function Null_Or_Missing( i : Wlshua_Type ) return Boolean;
   function Convert_Wlshua_Type( i : String ) return Wlshua_Type;


   type Xdt1m_Type is (  
      cant_remember,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Xdt1m_Type ) return String;
   function Null_Or_Missing( i : Xdt1m_Type ) return Boolean;
   function Convert_Xdt1m_Type( i : String ) return Xdt1m_Type;


   type Xdt1pl_Type is (  
      cant_remember,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      sports_facilities,
      normal_workplace,
      home_or_garden,
      school_or_college,
      in_motor_vehicle,
      on_road_or_pavement,
      other );

   function Pretty_Print( i : Xdt1pl_Type ) return String;
   function Null_Or_Missing( i : Xdt1pl_Type ) return Boolean;
   function Convert_Xdt1pl_Type( i : String ) return Xdt1pl_Type;


   type Xdt1y_Type is (  
      cant_remember,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995,
      s_1996 );

   function Pretty_Print( i : Xdt1y_Type ) return String;
   function Null_Or_Missing( i : Xdt1y_Type ) return Boolean;
   function Convert_Xdt1y_Type( i : String ) return Xdt1y_Type;


   type Xdt2m_Type is (  
      cant_remember,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      january,
      october,
      november,
      december,
      winter,
      spring,
      summer,
      autumn,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Xdt2m_Type ) return String;
   function Null_Or_Missing( i : Xdt2m_Type ) return Boolean;
   function Convert_Xdt2m_Type( i : String ) return Xdt2m_Type;


   type Xdt2y_Type is (  
      cant_remember,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1990,
      s_1991,
      s_1992,
      s_1993,
      s_1994,
      s_1995 );

   function Pretty_Print( i : Xdt2y_Type ) return String;
   function Null_Or_Missing( i : Xdt2y_Type ) return Boolean;
   function Convert_Xdt2y_Type( i : String ) return Xdt2y_Type;


   type Xpbldf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      all_included_in_rent );

   function Pretty_Print( i : Xpbldf_Type ) return String;
   function Null_Or_Missing( i : Xpbldf_Type ) return Boolean;
   function Convert_Xpbldf_Type( i : String ) return Xpbldf_Type;


   type Xpchcf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      child_care_free,
      child_care_paid );

   function Pretty_Print( i : Xpchcf_Type ) return String;
   function Null_Or_Missing( i : Xpchcf_Type ) return Boolean;
   function Convert_Xpchcf_Type( i : String ) return Xpchcf_Type;


   type Xpfood_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      under_gbp_10,
      gbp120_gbp139,
      gbp140_gbp159,
      gbp160_or_over,
      s_997_or_above,
      gbp10_gbp19,
      gbp20_gbp29,
      gbp30_gbp39,
      gbp40_gbp49,
      gbp50_gbp59,
      gbp60_gbp79,
      gbp80_gbp99,
      gbp100_gbp119 );

   function Pretty_Print( i : Xpfood_Type ) return String;
   function Null_Or_Missing( i : Xpfood_Type ) return Boolean;
   function Convert_Xpfood_Type( i : String ) return Xpfood_Type;


   type Xpgasl_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_997_or_above );

   function Pretty_Print( i : Xpgasl_Type ) return String;
   function Null_Or_Missing( i : Xpgasl_Type ) return Boolean;
   function Convert_Xpgasl_Type( i : String ) return Xpgasl_Type;


   type Xpgaslw_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_97_and_above );

   function Pretty_Print( i : Xpgaslw_Type ) return String;
   function Null_Or_Missing( i : Xpgaslw_Type ) return Boolean;
   function Convert_Xpgaslw_Type( i : String ) return Xpgaslw_Type;


   type Xpgasy_Type is (  
      dont_know,
      refused,
      no_gas,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing_or_included_in_rent );

   function Pretty_Print( i : Xpgasy_Type ) return String;
   function Null_Or_Missing( i : Xpgasy_Type ) return Boolean;
   function Convert_Xpgasy_Type( i : String ) return Xpgasy_Type;


   type Xphpdf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      heavy_burden,
      somewhat_of_burden,
      not_a_problem );

   function Pretty_Print( i : Xphpdf_Type ) return String;
   function Null_Or_Missing( i : Xphpdf_Type ) return Boolean;
   function Convert_Xphpdf_Type( i : String ) return Xphpdf_Type;


   type Xphsdf_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      s_100pct_rent_rebate );

   function Pretty_Print( i : Xphsdf_Type ) return String;
   function Null_Or_Missing( i : Xphsdf_Type ) return Boolean;
   function Convert_Xphsdf_Type( i : String ) return Xphsdf_Type;


   type Xpleclw_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      s_97_or_above );

   function Pretty_Print( i : Xpleclw_Type ) return String;
   function Null_Or_Missing( i : Xpleclw_Type ) return Boolean;
   function Convert_Xpleclw_Type( i : String ) return Xpleclw_Type;


   type Xplecy_Type is (  
      dont_know,
      refused,
      no_electricity,
      elec_or_gas_combined,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing_or_included_in_rent );

   function Pretty_Print( i : Xplecy_Type ) return String;
   function Null_Or_Missing( i : Xplecy_Type ) return Boolean;
   function Convert_Xplecy_Type( i : String ) return Xplecy_Type;


   type Xpleis_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      not_applicable,
      missing_or_wild,
      nothing,
      under_10,
      s_120_139,
      s_140_159,
      s_160_or_over,
      s_10_19,
      s_20_29,
      s_30_39,
      s_40_49,
      s_50_59,
      s_60_79,
      s_80_99,
      s_100_119 );

   function Pretty_Print( i : Xpleis_Type ) return String;
   function Null_Or_Missing( i : Xpleis_Type ) return Boolean;
   function Convert_Xpleis_Type( i : String ) return Xpleis_Type;


   type Xpoily_Type is (  
      dont_know,
      refused,
      no_oil,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      nothing_or_included_in_rent,
      s_9997_and_above );

   function Pretty_Print( i : Xpoily_Type ) return String;
   function Null_Or_Missing( i : Xpoily_Type ) return Boolean;
   function Convert_Xpoily_Type( i : String ) return Xpoily_Type;


   type Xpself_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_997_or_above );

   function Pretty_Print( i : Xpself_Type ) return String;
   function Null_Or_Missing( i : Xpself_Type ) return Boolean;
   function Convert_Xpself_Type( i : String ) return Xpself_Type;


   type Xpsfly_Type is (  
      dont_know,
      refused,
      no_solid_fuel_or_other,
      proxy_and_or_phone,
      not_applicable,
      missing,
      nothing_or_included_in_rent );

   function Pretty_Print( i : Xpsfly_Type ) return String;
   function Null_Or_Missing( i : Xpsfly_Type ) return Boolean;
   function Convert_Xpsfly_Type( i : String ) return Xpsfly_Type;


   type Xsupa_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      not_sure,
      doesnt_apply_to_me );

   function Pretty_Print( i : Xsupa_Type ) return String;
   function Null_Or_Missing( i : Xsupa_Type ) return Boolean;
   function Convert_Xsupa_Type( i : String ) return Xsupa_Type;


   type Ynbuks_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing );

   function Pretty_Print( i : Ynbuks_Type ) return String;
   function Null_Or_Missing( i : Ynbuks_Type ) return Boolean;
   function Convert_Ynbuks_Type( i : String ) return Ynbuks_Type;


   type Ynlp14_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing,
      parents_nr_married,
      one_or_both_paren_died,
      parents_sepa_or_divorce,
      other );

   function Pretty_Print( i : Ynlp14_Type ) return String;
   function Null_Or_Missing( i : Ynlp14_Type ) return Boolean;
   function Convert_Ynlp14_Type( i : String ) return Ynlp14_Type;


   type Ynopen1_Type is (  
      refused_not_available,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      exp_unafford_too_young,
      exp_unafford_other_business,
      exp_unafford_other_school_fees,
      exp_unafford_other_family_or_household,
      exp_unafford_rather_spend_money_on_self,
      exp_unafford_low_or_no_income_or_no_money,
      exp_unafford_cannot_afford,
      exp_unafford_student_or_ft_schooling,
      exp_dk_too_young,
      exp_dk_student_or_ft_schooling,
      exp_dk_unemployed,
      exp_dk_havent_worked_long_enough,
      exp_dk_other_employment_reason,
      exp_dk_long_way_off,
      exp_dk_too_old,
      exp_dk_on_benefits,
      exp_dk_disability_or_health_cond,
      exp_unafford_unemployed_not_working,
      exp_dk_other_exp_business,
      exp_dk_other_exp_school_fees_exp,
      exp_dk_other_exp_family_or_household,
      exp_dk_rather_spend_money_on_self,
      exp_dk_low_or_no_income_or_no_spare_money,
      exp_dk_spouse_or_partner_handles_finances,
      dont_know_never_thought_of_it,
      exp_unafford_havent_worked_long_enough,
      lack_of_knowledge,
      exp_unafford_other_employment_reason,
      r_doesnt_trust_them,
      r_doesnt_believe_in_them,
      r_thinks_they_are_not_worth_it,
      savings_pension_schemes_have_probs,
      exp_unafford_retired_already,
      already_invested_in_property,
      expects_to_live_on_state_benefits,
      live_for_today_or_live_for_the_present,
      other_preparations_for_retirement,
      exp_unafford_too_old,
      wont_live_that_long,
      intend_to,
      cannot_be_bothered,
      exp_unafford_on_benefits,
      not_exp_too_young,
      not_exp_student_or_ft_schooling,
      not_exp_unemployed_or_not_employed,
      not_exp_havent_worked_long_enough,
      not_exp_other_employment_reason,
      not_exp_long_way_off,
      not_exp_too_old,
      not_exp_on_benefits,
      not_exp_disability_or_health_conditions,
      exp_unafford_disability_or_health_cond,
      not_exp_other_exp_business,
      not_exp_other_exp_school_fees_exp,
      not_exp_other_exp_family_or_household,
      not_exp_rather_spend_money_on_self,
      not_exp_spouse_or_partner_handle_finances,
      not_exp_no_employer_scheme,
      not_exp_other_reasons,
      no_reason_given_at_all );

   function Pretty_Print( i : Ynopen1_Type ) return String;
   function Null_Or_Missing( i : Ynopen1_Type ) return Boolean;
   function Convert_Ynopen1_Type( i : String ) return Ynopen1_Type;


   type Ynopen2_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      exp_unafford_too_young,
      exp_unafford_other_business,
      exp_unafford_other_school_fees,
      exp_unafford_other_family_or_household,
      exp_unafford_rather_spend_money_on_self,
      exp_unafford_low_or_no_income_or_no_money,
      exp_unafford_cannot_afford,
      exp_unafford_student_or_ft_schooling,
      exp_dk_too_young,
      exp_dk_student_or_ft_schooling,
      exp_dk_unemployed,
      exp_dk_havent_worked_long_enough,
      exp_dk_other_employment_reason,
      exp_dk_long_way_off,
      exp_dk_too_old,
      exp_dk_on_benefits,
      exp_dk_disability_or_health_cond,
      exp_unafford_unemployed_not_working,
      exp_dk_other_exp_business,
      exp_dk_other_exp_school_fees_exp,
      exp_dk_other_exp_family_or_household,
      exp_dk_rather_spend_money_on_self,
      exp_dk_low_or_no_income_or_no_spare_money,
      exp_dk_spouse_or_partner_handles_finances,
      dont_know_never_thought_of_it,
      exp_unafford_havent_worked_long_enough,
      lack_of_knowledge,
      exp_unafford_other_employment_reason,
      r_doesnt_trust_them,
      r_doesnt_believe_in_them,
      r_thinks_they_are_not_worth_it,
      savings_pension_schemes_have_probs,
      exp_unafford_retired_already,
      already_invested_in_property,
      expects_to_live_on_state_benefits,
      live_for_today_or_live_for_the_present,
      other_preparations_for_retirement,
      exp_unafford_too_old,
      wont_live_that_long,
      intend_to,
      cannot_be_bothered,
      exp_unafford_on_benefits,
      not_exp_too_young,
      not_exp_student_or_ft_schooling,
      not_exp_unemployed_or_not_employed,
      not_exp_havent_worked_long_enough,
      not_exp_other_employment_reason,
      not_exp_long_way_off,
      not_exp_too_old,
      not_exp_on_benefits,
      not_exp_disability_or_health_conditions,
      exp_unafford_disability_or_health_cond,
      not_exp_other_exp_business,
      not_exp_other_exp_school_fees_exp,
      not_exp_other_exp_family_or_household,
      not_exp_rather_spend_money_on_self,
      not_exp_spouse_or_partner_handle_finances,
      not_exp_no_employer_scheme,
      not_exp_other_reasons,
      no_reason_given_at_all );

   function Pretty_Print( i : Ynopen2_Type ) return String;
   function Null_Or_Missing( i : Ynopen2_Type ) return Boolean;
   function Convert_Ynopen2_Type( i : String ) return Ynopen2_Type;


   type Yosm_Type is (  
      not_osm,
      enumerated_at_wave_1,
      new_child_of_osm,
      wave_1_non_cont_enum,
      echp_psm_at_wave_7,
      echp_psm_rejoiner,
      new_sample_mem_post_w1,
      post_w1_ns_non_con_enum );

   function Pretty_Print( i : Yosm_Type ) return String;
   function Null_Or_Missing( i : Yosm_Type ) return Boolean;
   function Convert_Yosm_Type( i : String ) return Yosm_Type;


   type Yp2uni_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yes,
      no,
      not_sure_yet );

   function Pretty_Print( i : Yp2uni_Type ) return String;
   function Null_Or_Missing( i : Yp2uni_Type ) return Boolean;
   function Convert_Yp2uni_Type( i : String ) return Yp2uni_Type;


   type Ypacta_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      at_least_once_or_week,
      at_least_once_or_month,
      several_times_or_year,
      once_or_year_or_less,
      never_or_almost_never );

   function Pretty_Print( i : Ypacta_Type ) return String;
   function Null_Or_Missing( i : Ypacta_Type ) return Boolean;
   function Convert_Ypacta_Type( i : String ) return Ypacta_Type;


   type Ypamar_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      will_never_marry );

   function Pretty_Print( i : Ypamar_Type ) return String;
   function Null_Or_Missing( i : Ypamar_Type ) return Boolean;
   function Convert_Ypamar_Type( i : String ) return Ypamar_Type;


   type Ypapar_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      dont_want_children );

   function Pretty_Print( i : Ypapar_Type ) return String;
   function Null_Or_Missing( i : Ypapar_Type ) return Boolean;
   function Convert_Ypapar_Type( i : String ) return Ypapar_Type;


   type Ypargf_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      most_days,
      more_than_once_a_wk,
      less_than_once_a_wk,
      hardly_ever,
      dont_have_a_father );

   function Pretty_Print( i : Ypargf_Type ) return String;
   function Null_Or_Missing( i : Ypargf_Type ) return Boolean;
   function Convert_Ypargf_Type( i : String ) return Ypargf_Type;


   type Ypargm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      most_days,
      more_than_once_a_wk,
      less_than_once_a_wk,
      hardly_ever,
      dont_have_a_mother );

   function Pretty_Print( i : Ypargm_Type ) return String;
   function Null_Or_Missing( i : Ypargm_Type ) return Boolean;
   function Convert_Ypargm_Type( i : String ) return Ypargm_Type;


   type Ypasmk_Type is (  
      dont_know,
      refused,
      missing_or_wild );

   function Pretty_Print( i : Ypasmk_Type ) return String;
   function Null_Or_Missing( i : Ypasmk_Type ) return Boolean;
   function Convert_Ypasmk_Type( i : String ) return Ypasmk_Type;


   type Ypbeau_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yes,
      no );

   function Pretty_Print( i : Ypbeau_Type ) return String;
   function Null_Or_Missing( i : Ypbeau_Type ) return Boolean;
   function Convert_Ypbeau_Type( i : String ) return Ypbeau_Type;


   type Ypbored_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_often,
      quite_often,
      occasionally,
      hardly_ever );

   function Pretty_Print( i : Ypbored_Type ) return String;
   function Null_Or_Missing( i : Ypbored_Type ) return Boolean;
   function Convert_Ypbored_Type( i : String ) return Ypbored_Type;


   type Ypbull_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      a_lot,
      a_bit,
      not_at_all );

   function Pretty_Print( i : Ypbull_Type ) return String;
   function Null_Or_Missing( i : Ypbull_Type ) return Boolean;
   function Convert_Ypbull_Type( i : String ) return Ypbull_Type;


   type Ypbunk_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      extremely_serious,
      very_serious,
      fairly_serious,
      not_very_serious );

   function Pretty_Print( i : Ypbunk_Type ) return String;
   function Null_Or_Missing( i : Ypbunk_Type ) return Boolean;
   function Convert_Ypbunk_Type( i : String ) return Ypbunk_Type;


   type Ypchor_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      dont_do_or_less_1_hr,
      s_1_3_hours,
      s_4_6_hours,
      s_7_or_more_hours );

   function Pretty_Print( i : Ypchor_Type ) return String;
   function Null_Or_Missing( i : Ypchor_Type ) return Boolean;
   function Convert_Ypchor_Type( i : String ) return Ypchor_Type;


   type Ypcoma_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      afraid,
      words,
      large,
      animal,
      x_separate );

   function Pretty_Print( i : Ypcoma_Type ) return String;
   function Null_Or_Missing( i : Ypcoma_Type ) return Boolean;
   function Convert_Ypcoma_Type( i : String ) return Ypcoma_Type;


   type Ypcomb_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      able_to_speak,
      eligible,
      fit_to_eat,
      wise,
      argumentative );

   function Pretty_Print( i : Ypcomb_Type ) return String;
   function Null_Or_Missing( i : Ypcomb_Type ) return Boolean;
   function Convert_Ypcomb_Type( i : String ) return Ypcomb_Type;


   type Ypcomc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      hatred,
      disobedience,
      friendship,
      animation,
      cuddly );

   function Pretty_Print( i : Ypcomc_Type ) return String;
   function Null_Or_Missing( i : Ypcomc_Type ) return Boolean;
   function Convert_Ypcomc_Type( i : String ) return Ypcomc_Type;


   type Ypcomd_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      disappoint,
      customary,
      encounter,
      get_used_to,
      business );

   function Pretty_Print( i : Ypcomd_Type ) return String;
   function Null_Or_Missing( i : Ypcomd_Type ) return Boolean;
   function Convert_Ypcomd_Type( i : String ) return Ypcomd_Type;


   type Ypcome_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      school,
      noon,
      captain,
      room,
      board );

   function Pretty_Print( i : Ypcome_Type ) return String;
   function Null_Or_Missing( i : Ypcome_Type ) return Boolean;
   function Convert_Ypcome_Type( i : String ) return Ypcome_Type;


   type Ypcomf_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      efface,
      make_level,
      elapse,
      embroider,
      widen );

   function Pretty_Print( i : Ypcomf_Type ) return String;
   function Null_Or_Missing( i : Ypcomf_Type ) return Boolean;
   function Convert_Ypcomf_Type( i : String ) return Ypcomf_Type;


   type Ypcomg_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      make_up,
      x_return,
      invent,
      turn_around,
      fall_out );

   function Pretty_Print( i : Ypcomg_Type ) return String;
   function Null_Or_Missing( i : Ypcomg_Type ) return Boolean;
   function Convert_Ypcomg_Type( i : String ) return Ypcomg_Type;


   type Ypcomp_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yes,
      no,
      dont_have_computer );

   function Pretty_Print( i : Ypcomp_Type ) return String;
   function Null_Or_Missing( i : Ypcomp_Type ) return Boolean;
   function Convert_Ypcomp_Type( i : String ) return Ypcomp_Type;


   type Ypcrwra_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      a_big_wory,
      a_bit_of_a_worry,
      an_occasional_doubt,
      not_a_worry_at_all );

   function Pretty_Print( i : Ypcrwra_Type ) return String;
   function Null_Or_Missing( i : Ypcrwra_Type ) return Boolean;
   function Convert_Ypcrwra_Type( i : String ) return Ypcrwra_Type;


   type Ypcrwrb_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_safe,
      fairly_safe,
      a_bit_unsafe,
      very_unsafe );

   function Pretty_Print( i : Ypcrwrb_Type ) return String;
   function Null_Or_Missing( i : Ypcrwrb_Type ) return Boolean;
   function Convert_Ypcrwrb_Type( i : String ) return Ypcrwrb_Type;


   type Ypdgfr_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      a_few,
      most );

   function Pretty_Print( i : Ypdgfr_Type ) return String;
   function Null_Or_Missing( i : Ypdgfr_Type ) return Boolean;
   function Convert_Ypdgfr_Type( i : String ) return Ypdgfr_Type;


   type Ypdgwh_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      mostly_from_school,
      mostly_from_family,
      mostly_from_friends,
      mostly_from_tv );

   function Pretty_Print( i : Ypdgwh_Type ) return String;
   function Null_Or_Missing( i : Ypdgwh_Type ) return Boolean;
   function Convert_Ypdgwh_Type( i : String ) return Ypdgwh_Type;


   type Ypdiet_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yes_all_the_time,
      yes_sometimes,
      no_never );

   function Pretty_Print( i : Ypdiet_Type ) return String;
   function Null_Or_Missing( i : Ypdiet_Type ) return Boolean;
   function Convert_Ypdiet_Type( i : String ) return Ypdiet_Type;


   type Ypdklm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      never,
      once_or_twice,
      several_times );

   function Pretty_Print( i : Ypdklm_Type ) return String;
   function Null_Or_Missing( i : Ypdklm_Type ) return Boolean;
   function Convert_Ypdklm_Type( i : String ) return Ypdklm_Type;


   type Ypdlfa_Type is (  
      dont_know,
      refused,
      nothing_written_in,
      not_applicable,
      missing,
      appearance_or_weight,
      girl_or_boy_friend,
      other_friends,
      rels_with_family,
      parental_relations,
      living_arrangements,
      fam_rel_problems,
      other_family_probs,
      self_confidence,
      getting_job,
      more_money_for_self,
      more_money_for_family,
      better_accomodation,
      new_possessions,
      animals_or_pets,
      other_life_style,
      age,
      being_bullied,
      school_circumstances,
      leaving_school,
      live_elsewhere,
      other_community,
      academic_ability,
      less_suffering_or_violence,
      environmental_improvement,
      other_improvements,
      health,
      no_change_all_ok,
      no_change_nothing,
      give_up_smoking,
      finess_or_sporting_ability,
      more_independence,
      other_personal_changes,
      other_changes );

   function Pretty_Print( i : Ypdlfa_Type ) return String;
   function Null_Or_Missing( i : Ypdlfa_Type ) return Boolean;
   function Convert_Ypdlfa_Type( i : String ) return Ypdlfa_Type;


   type Ypdlfb_Type is (  
      dont_know,
      nothing_written_in,
      not_applicable,
      missing,
      not_mentioned,
      appearance_or_weight,
      girl_or_boy_friend,
      other_friends,
      rels_with_family,
      parental_relations,
      living_arrangements,
      fam_rel_problems,
      other_family_probs,
      self_confidence,
      getting_job,
      more_money_for_self,
      more_money_for_family,
      better_accomodation,
      new_possessions,
      animals_or_pets,
      other_life_style,
      age,
      being_bullied,
      school_circumstances,
      leaving_school,
      live_elsewhere,
      other_community,
      academic_ability,
      less_suffering_or_violence,
      environmental_improvement,
      other_improvements,
      health,
      no_change_all_ok,
      no_change_nothing,
      give_up_smoking,
      finess_or_sporting_ability,
      more_independence,
      other_personal_changes,
      other_changes );

   function Pretty_Print( i : Ypdlfb_Type ) return String;
   function Null_Or_Missing( i : Ypdlfb_Type ) return Boolean;
   function Convert_Ypdlfb_Type( i : String ) return Ypdlfb_Type;


   type Ypdobm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      january,
      october,
      november,
      december,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september );

   function Pretty_Print( i : Ypdobm_Type ) return String;
   function Null_Or_Missing( i : Ypdobm_Type ) return Boolean;
   function Convert_Ypdobm_Type( i : String ) return Ypdobm_Type;


   type Ypdoby_Type is (  
      dont_know,
      refused,
      s_1978,
      s_1979,
      s_1980,
      s_1981,
      s_1982,
      s_1983,
      s_1984,
      s_1985 );

   function Pretty_Print( i : Ypdoby_Type ) return String;
   function Null_Or_Missing( i : Ypdoby_Type ) return Boolean;
   function Convert_Ypdoby_Type( i : String ) return Ypdoby_Type;


   type Ypdoby4_Type is (  
      dont_know,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild,
      s_1979,
      s_1980,
      s_1981,
      s_1982,
      s_1983,
      s_1984,
      s_1985 );

   function Pretty_Print( i : Ypdoby4_Type ) return String;
   function Null_Or_Missing( i : Ypdoby4_Type ) return Boolean;
   function Convert_Ypdoby4_Type( i : String ) return Ypdoby4_Type;


   type Ypeatn_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      s_1_2,
      s_3_5,
      s_6_7 );

   function Pretty_Print( i : Ypeatn_Type ) return String;
   function Null_Or_Missing( i : Ypeatn_Type ) return Boolean;
   function Convert_Ypeatn_Type( i : String ) return Ypeatn_Type;


   type Ypesta_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      strongly_agree,
      agree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Ypesta_Type ) return String;
   function Null_Or_Missing( i : Ypesta_Type ) return Boolean;
   function Convert_Ypesta_Type( i : String ) return Ypesta_Type;


   type Ypesti_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      strongly_agree,
      agree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Ypesti_Type ) return String;
   function Null_Or_Missing( i : Ypesti_Type ) return Boolean;
   function Convert_Ypesti_Type( i : String ) return Ypesti_Type;


   type Ypevnt1_Type is (  
      dont_know,
      refused,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      school_positive,
      relatnship_positive,
      health_improvement,
      house_move_positive,
      long_term_plans_plus_ve,
      other_positive_event,
      family_relations_plus_ve,
      school_negative,
      family_relations_ve,
      family_event_ve,
      leisure_negative,
      friends_negative,
      money_negative,
      consumption_negative,
      work_experience_ve,
      family_event_plus_ve,
      relatnship_negative,
      health_negative,
      house_move_negative,
      death_of_pet,
      long_term_plans_ve,
      other_negative_event,
      leisure_default,
      school_neutral,
      fam_relatns_neutral,
      family_event_neutral,
      friends_neutral,
      money_neutral,
      work_xprnce_neutral,
      friends_positive,
      relatnship_neutral,
      health_neutral,
      house_move_neutral,
      reference_to_pet,
      l_term_plan_neutral,
      other_neutral_event,
      money_positive,
      consumption_default,
      work_experience_plus_ve,
      nothing_happened );

   function Pretty_Print( i : Ypevnt1_Type ) return String;
   function Null_Or_Missing( i : Ypevnt1_Type ) return Boolean;
   function Convert_Ypevnt1_Type( i : String ) return Ypevnt1_Type;


   type Ypfarca_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      most_days,
      more_than_once_a_wk,
      less_than_once_a_wk,
      hardly_ever );

   function Pretty_Print( i : Ypfarca_Type ) return String;
   function Null_Or_Missing( i : Ypfarca_Type ) return Boolean;
   function Convert_Ypfarca_Type( i : String ) return Ypfarca_Type;


   type Ypfbeau_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      most_days,
      more_than_once_a_wk,
      less_than_once_a_wk,
      hardly_ever,
      dont_have_a_boy_or_girlfriend );

   function Pretty_Print( i : Ypfbeau_Type ) return String;
   function Null_Or_Missing( i : Ypfbeau_Type ) return Boolean;
   function Convert_Ypfbeau_Type( i : String ) return Ypfbeau_Type;


   type Ypffd_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      every_day_or_nearly,
      about_once_a_week,
      every_now_and_then,
      never_or_hardly_ever );

   function Pretty_Print( i : Ypffd_Type ) return String;
   function Null_Or_Missing( i : Ypffd_Type ) return Boolean;
   function Convert_Ypffd_Type( i : String ) return Ypffd_Type;


   type Ypfght_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      blank,
      s_2_5,
      s_6_9,
      s_10_or_more );

   function Pretty_Print( i : Ypfght_Type ) return String;
   function Null_Or_Missing( i : Ypfght_Type ) return Boolean;
   function Convert_Ypfght_Type( i : String ) return Ypfght_Type;


   type Ypfjob_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      dont_have_a_dad,
      father_doesnt_have_a_job );

   function Pretty_Print( i : Ypfjob_Type ) return String;
   function Null_Or_Missing( i : Ypfjob_Type ) return Boolean;
   function Convert_Ypfjob_Type( i : String ) return Ypfjob_Type;


   type Ypfpc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      s_1_2_days,
      s_3_4_days,
      most_days,
      dont_have_a_computer );

   function Pretty_Print( i : Ypfpc_Type ) return String;
   function Null_Or_Missing( i : Ypfpc_Type ) return Boolean;
   function Convert_Ypfpc_Type( i : String ) return Ypfpc_Type;


   type Ypfpcgm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      s_1_3,
      s_4_6,
      s_7_or_more );

   function Pretty_Print( i : Ypfpcgm_Type ) return String;
   function Null_Or_Missing( i : Ypfpcgm_Type ) return Boolean;
   function Convert_Ypfpcgm_Type( i : String ) return Ypfpcgm_Type;


   type Ypfsoc_Type is (  
      dont_know,
      proxy_respondent,
      not_applicable,
      missing,
      insufficient_detail_to_code );

   function Pretty_Print( i : Ypfsoc_Type ) return String;
   function Null_Or_Missing( i : Ypfsoc_Type ) return Boolean;
   function Convert_Ypfsoc_Type( i : String ) return Ypfsoc_Type;


   type Ypfuta_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      particular_career,
      pass_exams,
      completed_education,
      a_good_job,
      stable_relationship,
      have_children,
      no_children,
      be_single,
      get_on_with_family,
      own_business,
      own_car,
      own_home,
      have_lots_of_money,
      play_sports,
      play_music,
      travel,
      good_social_life,
      be_happy,
      help_society,
      financial_security,
      move_abroad,
      other );

   function Pretty_Print( i : Ypfuta_Type ) return String;
   function Null_Or_Missing( i : Ypfuta_Type ) return Boolean;
   function Convert_Ypfuta_Type( i : String ) return Ypfuta_Type;


   type Ypfutb_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      particular_career,
      pass_exams,
      completed_education,
      a_good_job,
      stable_relationship,
      have_children,
      no_children,
      be_single,
      get_on_with_family,
      own_business,
      own_car,
      own_home,
      have_lots_of_money,
      play_sports,
      play_music,
      travel,
      good_social_life,
      be_happy,
      help_society,
      financial_security,
      move_abroad,
      other );

   function Pretty_Print( i : Ypfutb_Type ) return String;
   function Null_Or_Missing( i : Ypfutb_Type ) return Boolean;
   function Convert_Ypfutb_Type( i : String ) return Ypfutb_Type;


   type Yphap_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      completely_happy,
      neither_happy_or_unhappy,
      completely_unhappy );

   function Pretty_Print( i : Yphap_Type ) return String;
   function Null_Or_Missing( i : Yphap_Type ) return Boolean;
   function Convert_Yphap_Type( i : String ) return Yphap_Type;


   type Yphlta_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yes_all_the_time,
      yes_sometimes,
      never );

   function Pretty_Print( i : Yphlta_Type ) return String;
   function Null_Or_Missing( i : Yphlta_Type ) return Boolean;
   function Convert_Yphlta_Type( i : String ) return Yphlta_Type;


   type Yphltb_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      nearly_every_day,
      about_once_a_week,
      every_now_and_then,
      never );

   function Pretty_Print( i : Yphltb_Type ) return String;
   function Null_Or_Missing( i : Yphltb_Type ) return Boolean;
   function Convert_Yphltb_Type( i : String ) return Yphltb_Type;


   type Yphstat_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      excellent,
      good,
      fair,
      poor,
      very_poor );

   function Pretty_Print( i : Yphstat_Type ) return String;
   function Null_Or_Missing( i : Yphstat_Type ) return Boolean;
   function Convert_Yphstat_Type( i : String ) return Yphstat_Type;


   type Ypjbqa_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_important,
      not_very_important,
      not_at_all_important );

   function Pretty_Print( i : Ypjbqa_Type ) return String;
   function Null_Or_Missing( i : Ypjbqa_Type ) return Boolean;
   function Convert_Ypjbqa_Type( i : String ) return Ypjbqa_Type;


   type Ypjbqf_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_important,
      important,
      not_very_important,
      not_at_all_important );

   function Pretty_Print( i : Ypjbqf_Type ) return String;
   function Null_Or_Missing( i : Ypjbqf_Type ) return Boolean;
   function Convert_Ypjbqf_Type( i : String ) return Ypjbqf_Type;


   type Ypjbqt_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      a_security,
      b_short_hours,
      c_using_your_brain,
      d_good_pay,
      e_feels_worthwhile );

   function Pretty_Print( i : Ypjbqt_Type ) return String;
   function Null_Or_Missing( i : Ypjbqt_Type ) return Boolean;
   function Convert_Ypjbqt_Type( i : String ) return Ypjbqt_Type;


   type Yplate_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      never,
      s_1_2,
      s_3_9,
      s_10_or_more );

   function Pretty_Print( i : Yplate_Type ) return String;
   function Null_Or_Missing( i : Yplate_Type ) return Boolean;
   function Convert_Yplate_Type( i : String ) return Yplate_Type;


   type Yplvsc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      leave_school_at_16,
      go_to_sixth_form_or_college );

   function Pretty_Print( i : Yplvsc_Type ) return String;
   function Null_Or_Missing( i : Yplvsc_Type ) return Boolean;
   function Convert_Yplvsc_Type( i : String ) return Yplvsc_Type;


   type Ypmenu_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yourself,
      mother,
      father,
      someone_else );

   function Pretty_Print( i : Ypmenu_Type ) return String;
   function Null_Or_Missing( i : Ypmenu_Type ) return Boolean;
   function Convert_Ypmenu_Type( i : String ) return Ypmenu_Type;


   type Ypmkfrn_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_easy,
      quite_easy,
      quite_difficult,
      very_difficult );

   function Pretty_Print( i : Ypmkfrn_Type ) return String;
   function Null_Or_Missing( i : Ypmkfrn_Type ) return Boolean;
   function Convert_Ypmkfrn_Type( i : String ) return Ypmkfrn_Type;


   type Ypnodg_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      can_get_into_trouble,
      can_damage_health );

   function Pretty_Print( i : Ypnodg_Type ) return String;
   function Null_Or_Missing( i : Ypnodg_Type ) return Boolean;
   function Convert_Ypnodg_Type( i : String ) return Ypnodg_Type;


   type Ypnosm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      costs_too_much,
      bad_for_health,
      make_parents_angry );

   function Pretty_Print( i : Ypnosm_Type ) return String;
   function Null_Or_Missing( i : Ypnosm_Type ) return Boolean;
   function Convert_Ypnosm_Type( i : String ) return Ypnosm_Type;


   type Ypnspt1_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      no_good_dont_like,
      no_facilities,
      no_time,
      cannot_afford,
      no_good_at_sport,
      health_or_disability,
      other,
      other_nes,
      missing_or_blank );

   function Pretty_Print( i : Ypnspt1_Type ) return String;
   function Null_Or_Missing( i : Ypnspt1_Type ) return Boolean;
   function Convert_Ypnspt1_Type( i : String ) return Ypnspt1_Type;


   type Ypnspt2_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      no_good_dont_like,
      no_facilities,
      no_time,
      cannot_afford,
      no_good_at_sport,
      health_or_disability,
      other_nes );

   function Pretty_Print( i : Ypnspt2_Type ) return String;
   function Null_Or_Missing( i : Ypnspt2_Type ) return Boolean;
   function Convert_Ypnspt2_Type( i : String ) return Ypnspt2_Type;


   type Ypntv_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      blank,
      s_3_or_more );

   function Pretty_Print( i : Ypntv_Type ) return String;
   function Null_Or_Missing( i : Ypntv_Type ) return Boolean;
   function Convert_Ypntv_Type( i : String ) return Ypntv_Type;


   type Ypnuna_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      want_job_earn_money,
      want_stay_at_home,
      want_make_own_home,
      get_on_with_life,
      go_abroad_travel,
      cant_be_bothered,
      unsure_what_to_do,
      too_expensive,
      money_1st_then_uni,
      want_apprenticeship,
      job_career_planned,
      no_need_of_qualifs,
      hard_work,
      incapable_uni_work,
      hate_school_college,
      waste_of_time,
      other,
      missing_blank );

   function Pretty_Print( i : Ypnuna_Type ) return String;
   function Null_Or_Missing( i : Ypnuna_Type ) return Boolean;
   function Convert_Ypnuna_Type( i : String ) return Ypnuna_Type;


   type Ypnunb_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      want_job_earn_money,
      want_stay_at_home,
      want_make_own_home,
      get_on_with_life,
      go_abroad_travel,
      cant_be_bothered,
      unsure_what_to_do,
      too_expensive,
      money_1st_then_uni,
      want_apprenticeship,
      job_career_planned,
      no_need_of_qualifs,
      hard_work,
      incapable_uni_work,
      hate_school_college,
      waste_of_time,
      other,
      missing_blank );

   function Pretty_Print( i : Ypnunb_Type ) return String;
   function Null_Or_Missing( i : Ypnunb_Type ) return Boolean;
   function Convert_Ypnunb_Type( i : String ) return Ypnunb_Type;


   type Ypopfb_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      strongly_agree,
      agree,
      neither_agree_or_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Ypopfb_Type ) return String;
   function Null_Or_Missing( i : Ypopfb_Type ) return Boolean;
   function Convert_Ypopfb_Type( i : String ) return Ypopfb_Type;


   type Ypopfj_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      strongly_agree,
      agree,
      neither_agree_nor_disagree,
      disagree,
      strongly_disagree );

   function Pretty_Print( i : Ypopfj_Type ) return String;
   function Null_Or_Missing( i : Ypopfj_Type ) return Boolean;
   function Convert_Ypopfj_Type( i : String ) return Ypopfj_Type;


   type Ypoprl_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      no_difference,
      some_difference,
      a_great_difference );

   function Pretty_Print( i : Ypoprl_Type ) return String;
   function Null_Or_Missing( i : Ypoprl_Type ) return Boolean;
   function Convert_Ypoprl_Type( i : String ) return Ypoprl_Type;


   type Ypopsc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      a_great_deal,
      quite_a_lot,
      a_bit_but_not_v_much,
      very_little );

   function Pretty_Print( i : Ypopsc_Type ) return String;
   function Null_Or_Missing( i : Ypopsc_Type ) return Boolean;
   function Convert_Ypopsc_Type( i : String ) return Ypopsc_Type;


   type Ypopsm_Type is (  
      missing_or_wild,
      very_dangerous,
      fairly_dangerous,
      not_very_dangerous,
      not_at_all_dangerous );

   function Pretty_Print( i : Ypopsm_Type ) return String;
   function Null_Or_Missing( i : Ypopsm_Type ) return Boolean;
   function Convert_Ypopsm_Type( i : String ) return Ypopsm_Type;


   type Yppalo_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      s_1_2,
      s_3_5,
      s_6_or_more );

   function Pretty_Print( i : Yppalo_Type ) return String;
   function Null_Or_Missing( i : Yppalo_Type ) return Boolean;
   function Convert_Yppalo_Type( i : String ) return Yppalo_Type;


   type Yppar_Type is (  
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      yes,
      no,
      na_echp_sub_sample );

   function Pretty_Print( i : Yppar_Type ) return String;
   function Null_Or_Missing( i : Yppar_Type ) return Boolean;
   function Convert_Yppar_Type( i : String ) return Yppar_Type;


   type Yppasc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      watch_me_v_closely,
      prefer_me_to_be_indep );

   function Pretty_Print( i : Yppasc_Type ) return String;
   function Null_Or_Missing( i : Yppasc_Type ) return Boolean;
   function Convert_Yppasc_Type( i : String ) return Yppasc_Type;


   type Yppcg_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      every_day,
      at_least_once_or_week,
      at_least_once_or_month,
      less_than_once_or_month,
      never );

   function Pretty_Print( i : Yppcg_Type ) return String;
   function Null_Or_Missing( i : Yppcg_Type ) return Boolean;
   function Convert_Yppcg_Type( i : String ) return Yppcg_Type;


   type Ypsad_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      s_1_3_days,
      s_4_10_days,
      s_11_days_or_more );

   function Pretty_Print( i : Ypsad_Type ) return String;
   function Null_Or_Missing( i : Ypsad_Type ) return Boolean;
   function Convert_Ypsad_Type( i : String ) return Ypsad_Type;


   type Ypsave_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      save_to_buy_things,
      save_and_not_spend,
      spend_immediately );

   function Pretty_Print( i : Ypsave_Type ) return String;
   function Null_Or_Missing( i : Ypsave_Type ) return Boolean;
   function Convert_Ypsave_Type( i : String ) return Ypsave_Type;


   type Ypser_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      a_stealing,
      b_swearing,
      c_smoking,
      d_telling_lies,
      e_taking_drugs,
      f_playing_truant );

   function Pretty_Print( i : Ypser_Type ) return String;
   function Null_Or_Missing( i : Ypser_Type ) return Boolean;
   function Convert_Ypser_Type( i : String ) return Ypser_Type;


   type Ypsex_Type is (  
      not_applicable,
      missing,
      male,
      female );

   function Pretty_Print( i : Ypsex_Type ) return String;
   function Null_Or_Missing( i : Ypsex_Type ) return Boolean;
   function Convert_Ypsex_Type( i : String ) return Ypsex_Type;


   type Ypshhc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      always_strict,
      sometimes_strict,
      not_strict_at_all );

   function Pretty_Print( i : Ypshhc_Type ) return String;
   function Null_Or_Missing( i : Ypshhc_Type ) return Boolean;
   function Convert_Ypshhc_Type( i : String ) return Ypshhc_Type;


   type Ypsm_Type is (  
      tsm_not_psm,
      osm,
      partner_or_parent_of_osm );

   function Pretty_Print( i : Ypsm_Type ) return String;
   function Null_Or_Missing( i : Ypsm_Type ) return Boolean;
   function Convert_Ypsm_Type( i : String ) return Ypsm_Type;


   type Ypsmag_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      never_smoked );

   function Pretty_Print( i : Ypsmag_Type ) return String;
   function Null_Or_Missing( i : Ypsmag_Type ) return Boolean;
   function Convert_Ypsmag_Type( i : String ) return Ypsmag_Type;


   type Ypsmof_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      i_have_never_smoked,
      only_once_or_twice,
      used_to_given_it_up,
      sometimes_lt_1_a_wk,
      i_smoke_regularly );

   function Pretty_Print( i : Ypsmof_Type ) return String;
   function Null_Or_Missing( i : Ypsmof_Type ) return Boolean;
   function Convert_Ypsmof_Type( i : String ) return Ypsmof_Type;


   type Ypsmop_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_dangerous,
      fairly_dangerous,
      not_very_dangerous,
      not_at_all_dangerous );

   function Pretty_Print( i : Ypsmop_Type ) return String;
   function Null_Or_Missing( i : Ypsmop_Type ) return Boolean;
   function Convert_Ypsmop_Type( i : String ) return Ypsmop_Type;


   type Ypsoc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      insufficient_detail_to_code );

   function Pretty_Print( i : Ypsoc_Type ) return String;
   function Null_Or_Missing( i : Ypsoc_Type ) return Boolean;
   function Convert_Ypsoc_Type( i : String ) return Ypsoc_Type;


   type Ypsoc00_Type is (  
      dont_know,
      refused,
      insufficient_detail_to_code,
      not_applicable,
      missing );

   function Pretty_Print( i : Ypsoc00_Type ) return String;
   function Null_Or_Missing( i : Ypsoc00_Type ) return Boolean;
   function Convert_Ypsoc00_Type( i : String ) return Ypsoc00_Type;


   type Ypsoc1_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      valid_soc_code,
      insufficient_detail );

   function Pretty_Print( i : Ypsoc1_Type ) return String;
   function Null_Or_Missing( i : Ypsoc1_Type ) return Boolean;
   function Convert_Ypsoc1_Type( i : String ) return Ypsoc1_Type;


   type Ypsoc10_Type is (  
      dont_know,
      refused,
      insufficient_detail,
      not_applicable,
      missing,
      valid_soc_code );

   function Pretty_Print( i : Ypsoc10_Type ) return String;
   function Null_Or_Missing( i : Ypsoc10_Type ) return Boolean;
   function Convert_Ypsoc10_Type( i : String ) return Ypsoc10_Type;


   type Ypsoc2_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      valid_soc_code,
      insufficient_detail );

   function Pretty_Print( i : Ypsoc2_Type ) return String;
   function Null_Or_Missing( i : Ypsoc2_Type ) return Boolean;
   function Convert_Ypsoc2_Type( i : String ) return Ypsoc2_Type;


   type Ypsoc20_Type is (  
      dont_know,
      refused,
      insufficient_detail,
      not_applicable,
      missing,
      not_mentioned,
      valid_soc_code );

   function Pretty_Print( i : Ypsoc20_Type ) return String;
   function Null_Or_Missing( i : Ypsoc20_Type ) return Boolean;
   function Convert_Ypsoc20_Type( i : String ) return Ypsoc20_Type;


   type Ypsocy_Type is (  
      dont_know,
      missing_or_wild,
      money_or_well_paid,
      like_to_work_w_hands,
      other_specific_skill,
      want_work_w_animals,
      want_work_w_children,
      want_to_help_others,
      gen_moral_concern,
      would_enjoy_it,
      undecided_or_too_young,
      good_job_or_high_status,
      always_wanted_to_be,
      follow_family_fstep,
      like_computing,
      like_or_good_at_arts,
      like_or_want_to_travel,
      like_or_good_at_sports,
      like_work_w_people,
      other );

   function Pretty_Print( i : Ypsocy_Type ) return String;
   function Null_Or_Missing( i : Ypsocy_Type ) return Boolean;
   function Convert_Ypsocy_Type( i : String ) return Ypsocy_Type;


   type Ypsprt_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      every_day_or_almost,
      about_once_a_week,
      every_now_and_then,
      never_or_hardly_ever );

   function Pretty_Print( i : Ypsprt_Type ) return String;
   function Null_Or_Missing( i : Ypsprt_Type ) return Boolean;
   function Convert_Ypsprt_Type( i : String ) return Ypsprt_Type;


   type Ypsprt1_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      walk_self_or_dog,
      cricket,
      athletics,
      marshall_arts,
      horse_riding,
      gymnastics,
      dancing_of_any_type,
      skating_ice_or_board,
      water_sports_ex_swim,
      golf,
      archery,
      swimming,
      army_cadets,
      bowling,
      motor_biking,
      wrestling,
      cycling,
      jogging_or_running,
      tennis_squash_badmin,
      keep_fit,
      gym_training,
      football_rugby,
      netbll_bsketbll_hcky,
      plays_unpec_sport,
      other_nes,
      missing_or_blank );

   function Pretty_Print( i : Ypsprt1_Type ) return String;
   function Null_Or_Missing( i : Ypsprt1_Type ) return Boolean;
   function Convert_Ypsprt1_Type( i : String ) return Ypsprt1_Type;


   type Ypsprt2_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      walk_self_or_dog,
      cricket,
      athletics,
      marshall_arts,
      horse_riding,
      gymnastics,
      dancing_of_any_type,
      skating_ice_or_board,
      water_sports_ex_swim,
      golf,
      archery,
      swimming,
      army_cadets,
      bowling,
      motor_biking,
      wrestling,
      cycling,
      jogging_or_running,
      tennis_squash_badmin,
      keep_fit,
      gym_training,
      football_rugby,
      netbll_bsketbll_hcky,
      plays_unpec_sport,
      other_nes );

   function Pretty_Print( i : Ypsprt2_Type ) return String;
   function Null_Or_Missing( i : Ypsprt2_Type ) return Boolean;
   function Convert_Ypsprt2_Type( i : String ) return Ypsprt2_Type;


   type Yptell_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      always,
      usually,
      sometimes,
      not_usually );

   function Pretty_Print( i : Yptell_Type ) return String;
   function Null_Or_Missing( i : Yptell_Type ) return Boolean;
   function Convert_Yptell_Type( i : String ) return Yptell_Type;


   type Ypthhc_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none_or_almost_none,
      under_1_hour,
      s_1_2_hours,
      s_3_5_hours,
      s_6_hours_or_more );

   function Pretty_Print( i : Ypthhc_Type ) return String;
   function Null_Or_Missing( i : Ypthhc_Type ) return Boolean;
   function Convert_Ypthhc_Type( i : String ) return Ypthhc_Type;


   type Yptlkp_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_easy,
      quite_easy,
      quite_difficult,
      very_difficult,
      dont_have_a_mother );

   function Pretty_Print( i : Yptlkp_Type ) return String;
   function Null_Or_Missing( i : Yptlkp_Type ) return Boolean;
   function Convert_Yptlkp_Type( i : String ) return Yptlkp_Type;


   type Yptrun_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      never,
      once_or_twice,
      several_times,
      often );

   function Pretty_Print( i : Yptrun_Type ) return String;
   function Null_Or_Missing( i : Yptrun_Type ) return Boolean;
   function Convert_Yptrun_Type( i : String ) return Yptrun_Type;


   type Ypttsm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      walk_all_the_way,
      ride_a_bike,
      by_bus_or_tube,
      by_car,
      by_train,
      some_other_way );

   function Pretty_Print( i : Ypttsm_Type ) return String;
   function Null_Or_Missing( i : Ypttsm_Type ) return Boolean;
   function Convert_Ypttsm_Type( i : String ) return Ypttsm_Type;


   type Yputel_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      always,
      usually,
      sometimes,
      not_usually,
      never_go_out );

   function Pretty_Print( i : Yputel_Type ) return String;
   function Null_Or_Missing( i : Yputel_Type ) return Boolean;
   function Convert_Yputel_Type( i : String ) return Yputel_Type;


   type Ypvt11_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing_or_wild,
      join_the_euro,
      not_to_join_euro,
      would_not_vote );

   function Pretty_Print( i : Ypvt11_Type ) return String;
   function Null_Or_Missing( i : Ypvt11_Type ) return Boolean;
   function Convert_Ypvt11_Type( i : String ) return Ypvt11_Type;


   type Ypvte3_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      conservative,
      none,
      ulster_unionist,
      sdlp,
      alliance_party,
      democratic_unionist,
      sinn_fein,
      other,
      labour,
      liberal_democrat,
      green_party );

   function Pretty_Print( i : Ypvte3_Type ) return String;
   function Null_Or_Missing( i : Ypvte3_Type ) return Boolean;
   function Convert_Ypvte3_Type( i : String ) return Ypvte3_Type;


   type Ypvte6_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      very_interested,
      fairly_interested,
      not_interested );

   function Pretty_Print( i : Ypvte6_Type ) return String;
   function Null_Or_Missing( i : Ypvte6_Type ) return Boolean;
   function Convert_Ypvte6_Type( i : String ) return Ypvte6_Type;


   type Ypwghr_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      about_right_weight,
      underweight,
      slightly_overweight,
      very_overweight );

   function Pretty_Print( i : Ypwghr_Type ) return String;
   function Null_Or_Missing( i : Ypwghr_Type ) return Boolean;
   function Convert_Ypwghr_Type( i : String ) return Ypwghr_Type;


   type Ypwkf_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      friday );

   function Pretty_Print( i : Ypwkf_Type ) return String;
   function Null_Or_Missing( i : Ypwkf_Type ) return Boolean;
   function Convert_Ypwkf_Type( i : String ) return Ypwkf_Type;


   type Ypwkm_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      monday );

   function Pretty_Print( i : Ypwkm_Type ) return String;
   function Null_Or_Missing( i : Ypwkm_Type ) return Boolean;
   function Convert_Ypwkm_Type( i : String ) return Ypwkm_Type;


   type Ypwksa_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      saturday );

   function Pretty_Print( i : Ypwksa_Type ) return String;
   function Null_Or_Missing( i : Ypwksa_Type ) return Boolean;
   function Convert_Ypwksa_Type( i : String ) return Ypwksa_Type;


   type Ypwksu_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      sunday );

   function Pretty_Print( i : Ypwksu_Type ) return String;
   function Null_Or_Missing( i : Ypwksu_Type ) return Boolean;
   function Convert_Ypwksu_Type( i : String ) return Ypwksu_Type;


   type Ypwkt_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      tuesday );

   function Pretty_Print( i : Ypwkt_Type ) return String;
   function Null_Or_Missing( i : Ypwkt_Type ) return Boolean;
   function Convert_Ypwkt_Type( i : String ) return Ypwkt_Type;


   type Ypwkth_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      thursday );

   function Pretty_Print( i : Ypwkth_Type ) return String;
   function Null_Or_Missing( i : Ypwkth_Type ) return Boolean;
   function Convert_Ypwkth_Type( i : String ) return Ypwkth_Type;


   type Ypwkw_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      not_mentioned,
      wednesday );

   function Pretty_Print( i : Ypwkw_Type ) return String;
   function Null_Or_Missing( i : Ypwkw_Type ) return Boolean;
   function Convert_Ypwkw_Type( i : String ) return Ypwkw_Type;


   type Ypwor_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none,
      s_1_2_nights,
      s_3_5_nights,
      s_6_7_nights );

   function Pretty_Print( i : Ypwor_Type ) return String;
   function Null_Or_Missing( i : Ypwor_Type ) return Boolean;
   function Convert_Ypwor_Type( i : String ) return Ypwor_Type;


   type Yr2uk_Type is (  
      cant_remember,
      refused,
      proxy_respondent,
      inapplicable,
      missing_or_wild );

   function Pretty_Print( i : Yr2uk_Type ) return String;
   function Null_Or_Missing( i : Yr2uk_Type ) return Boolean;
   function Convert_Yr2uk_Type( i : String ) return Yr2uk_Type;


   type Yrtlat_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      improve_finances,
      does_not_consider_retired_late,
      enjoyed_job,
      no_alternatives,
      keep_fit_active,
      employer_persuaded,
      couldnt_afford_it,
      same_time,
      different_time,
      other );

   function Pretty_Print( i : Yrtlat_Type ) return String;
   function Null_Or_Missing( i : Yrtlat_Type ) return Boolean;
   function Convert_Yrtlat_Type( i : String ) return Yrtlat_Type;


   type Yrtrly_Type is (  
      dont_know,
      refused,
      proxy_and_or_phone,
      inapplicable,
      missing_or_wild,
      not_mentioned,
      own_ill_health,
      different_time,
      for_next_gen,
      other,
      does_not_consider_to_be_retired_early,
      ill_health_of_other,
      compulsorily,
      financial_deal,
      no_other_job,
      time_with_family,
      enjoy_life,
      needed_change,
      same_time );

   function Pretty_Print( i : Yrtrly_Type ) return String;
   function Null_Or_Missing( i : Yrtrly_Type ) return Boolean;
   function Convert_Yrtrly_Type( i : String ) return Yrtrly_Type;


   type Ytvhrs_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      none_or_less_than_hour,
      s_1_3,
      s_4_6,
      s_7_or_more );

   function Pretty_Print( i : Ytvhrs_Type ) return String;
   function Null_Or_Missing( i : Ytvhrs_Type ) return Boolean;
   function Convert_Ytvhrs_Type( i : String ) return Ytvhrs_Type;


   type Ytvlmt_Type is (  
      dont_know,
      refused,
      not_applicable,
      missing,
      yes,
      no,
      dont_own_a_tv );

   function Pretty_Print( i : Ytvlmt_Type ) return String;
   function Null_Or_Missing( i : Ytvlmt_Type ) return Boolean;
   function Convert_Ytvlmt_Type( i : String ) return Ytvlmt_Type;


end BHPS_Enums;