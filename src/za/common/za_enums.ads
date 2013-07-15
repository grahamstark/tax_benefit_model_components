--
--  $Author: graham_s $
--  $Date: 2009-01-19 20:37:18 +0000 (Mon, 19 Jan 2009) $
--  $Revision: 6618 $
--
pragma License( Modified_GPL );

with T_Utils;
with Base_Model_Types;

package ZA_Enums is
   
   Enum_Conversion_Exception : exception;
--
-- For most of these enums we declare a T_Utils package as the simplest way to get sets and arrays 
-- of these types. Note that some are commented out because the 32-bit version of Gnat 2008 on Linux runs out 
-- of memory if all of them are in. 
-- 
   use Base_Model_Types;
   
   type Ownship_Type is (  
      missing,
      site_and_dwelling_fully_paid_off,
      site
   );

   function Pretty_Print( i : Ownship_Type ) return String;
   function Convert_Ownship_Type( i : Integer ) return Ownship_Type;
   package Ownship_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Ownship_Type );


   type Matroof_Type is (  
      missing,
      cocrete,
      prefab,
      zink,
      wood
   );

   function Pretty_Print( i : Matroof_Type ) return String;
   function Convert_Matroof_Type( i : Integer ) return Matroof_Type;
   package Matroof_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Matroof_Type );


   type Matwall_Type is (  
      missing,
      bricks,
      concrete,
      prefab
   );

   function Pretty_Print( i : Matwall_Type ) return String;
   function Convert_Matwall_Type( i : Integer ) return Matwall_Type;
   package Matwall_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Matwall_Type );


   type Watsourc_Type is (  
      missing,
      running_tap_in_dwe,
      running_tap_on_site
   );

   function Pretty_Print( i : Watsourc_Type ) return String;
   function Convert_Watsourc_Type( i : Integer ) return Watsourc_Type;
   package Watsourc_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Watsourc_Type );


   type Watmain_Type is (  
      missing,
      running_tap_in_dwe,
      running_tap_on_site
   );

   function Pretty_Print( i : Watmain_Type ) return String;
   function Convert_Watmain_Type( i : Integer ) return Watmain_Type;
   package Watmain_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Watmain_Type );


   type Watadeq_Type is (  
      missing,
      always_adequate,
      mostly_yes,
      mostly_not,
      no
   );

   function Pretty_Print( i : Watadeq_Type ) return String;
   function Convert_Watadeq_Type( i : Integer ) return Watadeq_Type;
   package Watadeq_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Watadeq_Type );


   type Watkm_Type is (  
      missing,
      lt_100m,
      v_100_200m,
      v_200_500m
   );

   function Pretty_Print( i : Watkm_Type ) return String;
   function Convert_Watkm_Type( i : Integer ) return Watkm_Type;
   package Watkm_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Watkm_Type );


   type Yes_No_Sometimes_Type is (  
      missing,
      yes,
      no,
      sometimes
   );

   function Pretty_Print( i : Yes_No_Sometimes_Type ) return String;
   function Convert_Yes_No_Sometimes_Type( i : Integer ) return Yes_No_Sometimes_Type;
   package Yes_No_Sometimes_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Yes_No_Sometimes_Type );


   type Fwoods_Type is (  
      missing,
      woodlot,
      commercial_plantations,
      indegenous
   );

   function Pretty_Print( i : Fwoods_Type ) return String;
   function Convert_Fwoods_Type( i : Integer ) return Fwoods_Type;
   package Fwoods_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Fwoods_Type );


   type Fwoodad_Type is (  
      missing,
      always,
      mostly_yes,
      mostly_no,
      no
   );

   function Pretty_Print( i : Fwoodad_Type ) return String;
   function Convert_Fwoodad_Type( i : Integer ) return Fwoodad_Type;
   package Fwoodad_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Fwoodad_Type );


   type Fwoodkm_Type is (  
      missing,
      lt_100m,
      v_100_200m,
      v_200_1km,
      gt_1km
   );

   function Pretty_Print( i : Fwoodkm_Type ) return String;
   function Convert_Fwoodkm_Type( i : Integer ) return Fwoodkm_Type;
   package Fwoodkm_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Fwoodkm_Type );


   type Toilkm_Type is (  
      missing,
      lt_25m,
      v_25_50m,
      v_51_100m,
      gt_100m
   );

   function Pretty_Print( i : Toilkm_Type ) return String;
   function Convert_Toilkm_Type( i : Integer ) return Toilkm_Type;
   package Toilkm_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Toilkm_Type );


   type Refdisp_Type is (  
      missing,
      removed_by_local_authority,
      communal
   );

   function Pretty_Print( i : Refdisp_Type ) return String;
   function Convert_Refdisp_Type( i : Integer ) return Refdisp_Type;
   package Refdisp_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Refdisp_Type );


   type Reffreq_Type is (  
      missing,
      v_1_week,
      fortnight,
      month
   );

   function Pretty_Print( i : Reffreq_Type ) return String;
   function Convert_Reffreq_Type( i : Integer ) return Reffreq_Type;
   package Reffreq_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Reffreq_Type );


   type Telkm_Type is (  
      missing,
      lt_100m,
      v_100_200m,
      v_200_1km,
      v_1_km
   );

   function Pretty_Print( i : Telkm_Type ) return String;
   function Convert_Telkm_Type( i : Integer ) return Telkm_Type;
   package Telkm_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Telkm_Type );


   type Landirs_Type is (  
      missing,
      river,
      spring,
      dam_on_land,
      other_dam
   );

   function Pretty_Print( i : Landirs_Type ) return String;
   function Convert_Landirs_Type( i : Integer ) return Landirs_Type;
   package Landirs_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Landirs_Type );


   type Trus_Type is (  
      missing,
      river,
      spring,
      dam_on_land,
      other_dam
   );

   function Pretty_Print( i : Trus_Type ) return String;
   function Convert_Trus_Type( i : Integer ) return Trus_Type;
   package Trus_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Trus_Type );


   type Safeout_Type is (  
      missing,
      very_safe,
      rather_safe,
      rather
   );

   function Pretty_Print( i : Safeout_Type ) return String;
   function Convert_Safeout_Type( i : Integer ) return Safeout_Type;
   package Safeout_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Safeout_Type );


   type Safein_Type is (  
      missing,
      very_safe,
      rather_safe,
      rather
   );

   function Pretty_Print( i : Safein_Type ) return String;
   function Convert_Safein_Type( i : Integer ) return Safein_Type;
   package Safein_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Safein_Type );


   type Safeprev_Type is (  
      missing,
      safer,
      same,
      less_safe
   );

   function Pretty_Print( i : Safeprev_Type ) return String;
   function Convert_Safeprev_Type( i : Integer ) return Safeprev_Type;
   package Safeprev_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Safeprev_Type );


   type Crime_Type is (  
      missing,
      assault,
      robbery,
      rape,
      murder,
      abduction,
      other
   );

   function Pretty_Print( i : Crime_Type ) return String;
   function Convert_Crime_Type( i : Integer ) return Crime_Type;
   package Crime_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Crime_Type );

   type Pollute_Type is (  
      missing,
      very_difficult,
      difficult,
      slightly
   );
      
   function Pretty_Print( i : Pollute_Type ) return String;
   function Convert_Pollute_Type( i : Integer ) return Pollute_Type;
   package Pollute_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Pollute_Type );


   type Feedab_Type is (  
      missing,
      yes,
      no,
      not_applicable
   );

   function Pretty_Print( i : Feedab_Type ) return String;
   function Convert_Feedab_Type( i : Integer ) return Feedab_Type;
   package Feedab_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Feedab_Type );


   type Satisf_Type is (  
      missing,
      very_satisfied,
      satisfied,
      neither
   );

   function Pretty_Print( i : Satisf_Type ) return String;
   function Convert_Satisf_Type( i : Integer ) return Satisf_Type;
   package Satisf_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Satisf_Type );


   type Compliv_Type is (  
      missing,
      things_are_better,
      worse,
      neither
   );

   function Pretty_Print( i : Compliv_Type ) return String;
   function Convert_Compliv_Type( i : Integer ) return Compliv_Type;
   package Compliv_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Compliv_Type );


   type Reashead_Type is (  
      missing,
      employment,
      business
   );

   function Pretty_Print( i : Reashead_Type ) return String;
   function Convert_Reashead_Type( i : Integer ) return Reashead_Type;
   package Reashead_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Reashead_Type );


   type Medsour_Type is (  
      missing,
      public_hospital,
      public_clinic,
      other_public
   );

   function Pretty_Print( i : Medsour_Type ) return String;
   function Convert_Medsour_Type( i : Integer ) return Medsour_Type;
   package Medsour_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Medsour_Type );


   type Medkm_Type is (  
      missing,
      lt_1km,
      v_1_5km,
      gt_5km
   );

   function Pretty_Print( i : Medkm_Type ) return String;
   function Convert_Medkm_Type( i : Integer ) return Medkm_Type;
   package Medkm_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Medkm_Type );


   type Medtime_Type is (  
      missing,
      v_1_4_hour,
      v_1_2_hour,
      v_1_hour,
      gt_1_hour
   );

   function Pretty_Print( i : Medtime_Type ) return String;
   function Convert_Medtime_Type( i : Integer ) return Medtime_Type;
   package Medtime_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Medtime_Type );


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
      northern_province
   );

   function Pretty_Print( i : Province_Type ) return String;
   function Convert_Province_Type( i : Integer ) return Province_Type;
   package Province_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Province_Type );


   type Welfkm_Type is (  
      missing,
      lt_1km,
      v_1_5km,
      gt_5km,
      dont
   );

   function Pretty_Print( i : Welfkm_Type ) return String;
   function Convert_Welfkm_Type( i : Integer ) return Welfkm_Type;
   package Welfkm_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Welfkm_Type );


   type Relate_Type is (  
      missing,
      head_of_hh,
      spouse,
      son_daughter
   );

   function Pretty_Print( i : Relate_Type ) return String;
   function Convert_Relate_Type( i : Integer ) return Relate_Type;
   package Relate_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Relate_Type );


   type Mstate_Type is (  
      missing,
      never_married,
      civil_married,
      traditional_married
   );

   function Pretty_Print( i : Mstate_Type ) return String;
   function Convert_Mstate_Type( i : Integer ) return Mstate_Type;
   package Mstate_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Mstate_Type );


   type Gender_Type is (  
      missing,
      male,
      female
   );

   function Pretty_Print( i : Gender_Type ) return String;
   function Convert_Gender_Type( i : Integer ) return Gender_Type;
   package Gender_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Gender_Type );


   type Dwe_Type is (  
      missing,
      formal,
      traditional,
      flat,
      townhouse
   );

   function Pretty_Print( i : Dwe_Type ) return String;
   function Convert_Dwe_Type( i : Integer ) return Dwe_Type;
   package Dwe_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Dwe_Type );


   type Loc_Type is (  
      missing,
      urban,
      rural
   );

   function Pretty_Print( i : Loc_Type ) return String;
   function Convert_Loc_Type( i : Integer ) return Loc_Type;
   package Loc_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Loc_Type );


   type Race_Type is (  
      missing,
      African,
      Coloured,
      Indian,
      White
   );

   function Pretty_Print( i : Race_Type ) return String;
   function Convert_Race_Type( i : Integer ) return Race_Type;
   package Race_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Race_Type );


   type Predw_Type is (  
      missing,
      formal,
      backyard,
      squatter,
      hostel
   );

   function Pretty_Print( i : Predw_Type ) return String;
   function Convert_Predw_Type( i : Integer ) return Predw_Type;
   package Predw_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Predw_Type );


   type Edreas_Type is (  
      missing,
      no_money,
      distance
   );

   function Pretty_Print( i : Edreas_Type ) return String;
   function Convert_Edreas_Type( i : Integer ) return Edreas_Type;
   package Edreas_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Edreas_Type );


   type Conspla_Type is (  
      missing,
      public_hospital,
      public_clinic
   );

   function Pretty_Print( i : Conspla_Type ) return String;
   function Convert_Conspla_Type( i : Integer ) return Conspla_Type;
   package Conspla_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Conspla_Type );


   type Disab1_Type is (  
      missing,
      none,
      sight,
      hearing,
      physical,
      mental
   );

   function Pretty_Print( i : Disab1_Type ) return String;
   function Convert_Disab1_Type( i : Integer ) return Disab1_Type;
   package Disab1_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Disab1_Type );


   type Edcat_Type is (  
      missing,
      no_school,
      prima,
      sec,
      matric,
      no_matr_plus_dip,
      mat_plus_d,
      univ
   );

   function Pretty_Print( i : Edcat_Type ) return String;
   function Convert_Edcat_Type( i : Integer ) return Edcat_Type;
   package Edcat_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Edcat_Type );


   type Expenditure_Type is (  
      missing,
      housm,
      housy,
      domwag,
      cereal,
      meat,
      fish,
      fats,
      milk,
      veg,
      fruit,
      sugar,
      syrup,
      tea,
      othfood,
      hotelfoo,
      hnalcbev,
      snalcbev,
      halcbev,
      salcbev,
      tobacco,
      personal,
      consgood,
      hhserv,
      subtot,
      subtoty,
      fuel,
      womcloth,
      girlcl,
      mcloth,
      boycloth,
      chncl,
      womfoot,
      gfoot,
      menfoot,
      boyfoot,
      chnfoot,
      handmade,
      furn,
      textile,
      applianc,
      equip,
      medserm,
      medsernm,
      vehicle,
      vehrun,
      pubtraws,
      ptravis,
      computer,
      communic,
      edfeesel,
      edfeegr,
      readmat,
      recreq,
      recrgood,
      licence,
      subtot2,
      miscel,
      remit,
      taxpaid,
      fincharg,
      other,
      loss,
      ownprod,
      livestoc,
      hhexp,
      dirinc,
      indirinc,
      totinc,
      hweight
   );

   function Pretty_Print( i : Expenditure_Type ) return String;
   function Convert_Expenditure_Type( i : Integer ) return Expenditure_Type;
   package Expenditure_Type_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Expenditure_Type );


   type Income_Type is (  
      missing,
      hobby,
      carsal,
      prop,
      usedit,
      rental,
      houben,
      traben,
      medben,
      othben,
      lump,
      policy,
      otlump,
      linsur,
      funcla,
      propcl,
      trafcl,
      gratui,
      stokv,
      saving,
      bursar,
      cashbe,
      foodbe,
      othseb,
      clben,
      otgift,
      lobola,
      othinc,
      ttothinc,
      wages,
      bonus,
      commi,
      allow,
      profit,
      rent,
      royal,
      inter,
      divid,
      pens,
      oldage,
      disabg,
      famall,
      unembe,
      alimon,
      remit,
      income,
      inckin,
      indinc,
      income_from_employment,
      netacy,
      hincom
   );

   function Pretty_Print( i : Income_Type ) return String;
   function Convert_Income_Type( i : Integer ) return Income_Type;
   package Income_Package is new T_Utils(
      Rate_Type    => Rate,
      Amount_Type  => Amount,
      Counter_Type => Counter_Type,
      T            => Income_Type );

      
end ZA_Enums;

