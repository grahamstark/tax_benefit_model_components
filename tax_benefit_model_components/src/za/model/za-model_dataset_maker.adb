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

with Ada.Assertions;
with Ada.Calendar;      
with Ada.Containers.Ordered_Sets;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with Text_Utils;

with Coicop_Definitions;
with ZA.IES;
with ZA.Model.Data;
with ZA.Model_Types;

--
--  Note that we could use valueAnnualized rather than value for all the expenditures
--  we're assuming 1 period in the uprating at the moment so this is inconsistent but
--  lets us check against aggregates more easily.
-- 
package body ZA.Model_Dataset_Maker is

   use Ada.Text_IO;
   use Ada.Assertions;
   
   --
   -- FIXME completely made up!!!
   --
   PROPN_TRANSPORT_FOR_WORK : constant := 0.33;
   
   package model_types renames ZA.Model_Types;
   
   type Person_Allocation is record 
      tuno               : raw.Person_Count;
      is_adult           : Boolean := False;
      is_head_of_family  : Boolean := False;
      is_married         : Boolean := False;
   end record;
   
   --
   -- this is here so we can add 0 .. 4 in cycles to each of the age brackets below
   -- better than random number since this will give same results each time
   -- (maybe random would, too?)
   -- 1 is added to age_addn during each call of Map_Age_Range
   -- 
   type M5 is mod 5;
   age_addn : M5 := 0;
   
   function Map_Age_Range( ar : raw.Age_Group_Type ) return model_types.Age_Range is
      use raw;
      use type model_types.Age_Range;
      age : model_types.Age_Range;
   begin
      age_addn := age_addn + 1;
      case ar is
         when age_00_to_04_years => age := 0;
         when age_05_to_09_years => age := 5;
         when age_10_to_14_years => age :=  10;
         when age_15_to_19_years => age :=  15;
         when age_20_to_24_years => age :=  20;
         when age_25_to_29_years => age :=  25; 
         when age_30_to_34_years => age :=  30;
         when age_35_to_39_years => age :=  35;
         when age_40_to_44_years => age :=  40;
         when age_45_to_49_years => age :=  45;
         when age_50_to_54_years => age :=  50;
         when age_55_to_59_years => age :=  55;
         when age_60_to_64_years => age :=  60;
         when age_65_to_69_years => age :=  65;
         when age_70_to_74_years => age :=  70;
         when age_75_to_79_years => age :=  75;
         when age_80_to_84_years => age :=  80;
         when age_85_plus => age :=  80;
         when unspecified | missing=> age := 0;
      end case;
      age := age + model_types.Age_Range( age_addn );
      return age;
   end Map_Age_Range;
   
   type Child_Count_Array is array( raw.Person_Range ) of raw.Person_Count;
   type Adult_Count_Array is array( 1 .. 2 ) of raw.Person_Count;
      
   type Pers_Skel is record
      age : model_types.Age_Range;
      gender : raw.Gender_Type;
      person_num : raw.Person_Range;
   end record;
   
   type TU_Skel is record
      adults : Adult_Count_Array := (Others=>0);
      num_adults : raw.Person_Count := 0;
      child : Child_Count_Array := (Others=>0);
      num_children : raw.Person_Count := 0;
      having_kids_weight : Rate := 1.0;
      age_of_carer :  model_types.Age_Range := model_types.Age_Range'Last;
      has_female_carer   : Boolean := False;
   end record;
   
   type TU_Skel_Array is array( raw.Person_Range ) of TU_Skel;
   
   type HH_Skel is record
      num_tus            : raw.Person_Count := 0;
      tus                : TU_Skel_Array;
      num_people         : raw.Person_Count := 0;
   end record;
   
   function To_String( skel : TU_Skel ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & "     num_adults " & raw.Person_Range'Image( skel.num_adults ) & LINE_BREAK;
      s := s & "     num_children " & raw.Person_Range'Image( skel.num_children ) & LINE_BREAK;
      s := s & "     has_female_carer " & Boolean'Image( skel.has_female_carer ) & LINE_BREAK;
      s := s & "     age_of_carer " & model_types.Age_Range'Image( skel.age_of_carer ) & LINE_BREAK;
      s := s & "     having_kids_weight " & Format( skel.having_kids_weight );
      s := s & "     Adult IDS : ";
      for i in 1 .. skel.num_adults loop
         s := s & raw.Person_Range'Image( skel.adults( i ));
      end loop;
      s := s & LINE_BREAK;
      s := s & "     Child IDS : ";
      for i in 1 .. skel.num_children loop
         s := s & raw.Person_Range'Image( skel.child( i ));
      end loop;
      s := s & LINE_BREAK;
      return To_String( s );
   end To_String;
  
   function To_String( skel : HH_Skel ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & LINE_BREAK & " num_tus " & raw.Person_Range'Image( skel.num_tus ) & LINE_BREAK;
      s := s & " num_people " & raw.Person_Range'Image( skel.num_people ) & LINE_BREAK;
      for i in 1 .. skel.num_tus loop
         s := s & " TU " & raw.Person_Range'Image( i ) & LINE_BREAK;
         s := s & To_String( skel.tus( i )) & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;
   
   function People_Count( skel : HH_Skel ) return raw.Person_Count is
      pc : raw.Person_Count := 0;
   begin
      for tuno in 1 .. skel.num_tus loop
         pc := pc + skel.tus( tuno ).num_adults;
         pc := pc + skel.tus( tuno ).num_children;         
      end loop;
      return pc;
   end People_Count;
   
   -- type Person_Allocation_Array is array( raw.Person_Count ) of Person_Allocation;
    
   function Allocate_People_To_Families( hh : in raw.Household ) return HH_Skel is
      use raw;
      package People_Package is new Ada.Containers.Ordered_Sets( Element_Type => Person_Count );
      use People_Package;
      allocated  : Set;
      skel : HH_Skel;
      
      function No_More_Adults return Boolean is
      begin
         for pno in 1 .. hh.num_people loop
            if( hh.person( pno ).info.agegrp > age_10_to_14_years ) and
              ( not Contains( allocated, pno )) then
              return False;
            end if;
         end loop;
         return True;
      end No_More_Adults;
      
      skipped : Natural := 0;
      
   begin
      for pno in 1 .. hh.num_people loop
         if( hh.person( pno ).info.uqno = Sernum_Value'First ) then
            Include( allocated, pno ); -- skip any non-contiguous people
            skipped := skipped + 1;
         end if;
      end loop;
      Put_Line( "Skipped " & skipped'Img & " of " & hh.num_people'Img );
      all_adults_allocated:
      loop
         each_adult:
         for pno in 1 .. hh.num_people loop
            if( not Contains( allocated, pno ))then
               person_unallocated:
               declare
                  person : Person_Info := hh.person( pno ).info;
                  person_age : model_types.Age_Range := 
                     Map_Age_Range( person.agegrp );
               begin
                  Put_Line( "allocating person" & To_String( person ));
                  if( person.agegrp > age_10_to_14_years ) then
                     -- find a mate for each adult
                     skel.num_tus := skel.num_tus + 1;
                     skel.num_people := skel.num_people + 1;
                     skel.tus( skel.num_tus ).adults( 1 ) := pno;
                     skel.tus( skel.num_tus ).num_adults := 1;
                     skel.tus( skel.num_tus ).age_of_carer := person_age;
                     skel.tus( skel.num_tus ).has_female_carer := person.gender = female;
                     Include( allocated, pno );
                     
                     each_prospective_partner:
                     for partner_no in 1 .. hh.num_people loop
                        if( not Contains( allocated, partner_no )) and 
                          (skel.tus( skel.num_tus ).num_adults = 1 ) then
                           partner_unallocated:
                           declare 
                              prospective_partner : Person_Info := hh.person( partner_no ).info;
                              partner_age : model_types.Age_Range := 
                                 Map_Age_Range( prospective_partner.agegrp );
                           begin
                              if( prospective_partner.agegrp > age_10_to_14_years ) then
                                 if( abs( partner_age - person_age ) < 20 ) and 
                                   ( prospective_partner.gender /= person.gender ) then
                                    skel.tus( skel.num_tus ).adults( 2 ) := partner_no;
                                    Include( allocated, partner_no );
                                    skel.tus( skel.num_tus ).num_adults := 2;
                                    if( prospective_partner.gender = female ) then
                                       skel.tus( skel.num_tus ).age_of_carer := partner_age;
                                       skel.tus( skel.num_tus ).has_female_carer := True;
                                    end if;
                                    skel.num_people := skel.num_people + 1;
                                    Put_Line( "allocating partner" & To_String( prospective_partner ));
                                 end if;
                                 -- skel.num_tus := skel.num_tus + 1;
                              end if;
                           end  partner_unallocated;
                        end if;
                     end loop each_prospective_partner;
                  end if;
               end person_unallocated;
            end if;
         end loop each_adult;
         exit when No_More_Adults;
      end loop all_adults_allocated;
      
      allocate_children:
      declare
        tu_with_kids : Person_Range := 1;
        max_weight : Rate := Rate'First;
      begin
         if( skel.num_tus > 1 ) then
            for tuno in 1 .. skel.num_tus loop
               if( skel.tus( tuno ).num_adults = 2 )then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight * 5.0;
               elsif( skel.tus( tuno ).has_female_carer ) then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight * 3.0;
               end if;
               if( skel.tus( tuno ).age_of_carer > 80 )then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight / 10.0;
               elsif( skel.tus( tuno ).age_of_carer > 60 ) then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight / 5.0;
               elsif( skel.tus( tuno ).age_of_carer > 50 ) then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight / 1.50;
               elsif( skel.tus( tuno ).age_of_carer < 20 ) then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight / 1.50;
               elsif( skel.tus( tuno ).age_of_carer < 16 ) then
                  skel.tus( tuno ).having_kids_weight := skel.tus( tuno ).having_kids_weight / 5.0;
               end if;
            end loop;
            for tuno in 1 .. skel.num_tus loop
               if( skel.tus( tuno ).having_kids_weight > max_weight )then
                  tu_with_kids := tuno;
                  max_weight := skel.tus( tuno ).having_kids_weight;
               end if;
            end loop;
         end if;
         
         for pno in 1 .. hh.num_people loop
            if( not Contains( allocated, pno ))then
               skel.tus( tu_with_kids ).num_children :=
                  skel.tus( tu_with_kids ).num_children + 1;
               skel.tus( tu_with_kids ).child( 
                  skel.tus( tu_with_kids ).num_children ) := pno;
               skel.num_people := skel.num_people + 1;
               Include( allocated, pno );
            end if;
         end loop;
      end allocate_children;
      Put_Line( To_String( skel ));
      Assert( People_Count( skel ) + skipped = hh.num_people, 
         "people count doesn't match skel has " & Person_Count'Image( People_Count( skel )) &
         " raw has "& Person_Count'Image( hh.num_people ) & 
         To_String( skel ) );
      Assert( Person_Count( Length( allocated )) = hh.num_people, 
         " allocated does't match allocated has " & 
         Person_Count'Image( Person_Count( Length( allocated ))) & 
         " raw has " & Person_Count'Image( hh.num_people ) & 
         To_String( skel ) );
      Assert( skel.num_people + skipped = hh.num_people, "skel.num_people doesn't match " &
         " skel has " & Person_Count'Image( skel.num_people ) & 
         " raw has " & Person_Count'Image( hh.num_people ) & 
         To_String( skel ));
      return skel;
   end Allocate_People_To_Families;

   
        
   procedure Assign_Household_Level_Income_And_Expenses( 
      rhh    : in raw.Household;
      level2 : in Coicop_Definitions.Secondary_Group_Array;
      level3 : in Coicop_Definitions.Tertiary_Group_Array;
      rpers  : in out model.Person_Rec ) is
      use model_types;
      use Coicop_Definitions;
   begin
      if(( rpers.income( salaries_and_wages ) + 
          rpers.income( self_employment_and_business_income )) > 0.0 ) then
         rpers.expenses( travel_to_work ) :=
            level2( transport_services_secondary ) +  -- FIXME propn??
            level2( purchase_of_vehicles_secondary ) +
            level2( operation_of_personal_transport_equipment_secondary );
         rpers.expenses( travel_to_work ) := 
            rpers.expenses( travel_to_work ) * PROPN_TRANSPORT_FOR_WORK;
      end if;
      
      rpers.expenses( health_spending ) := 
         level2( medical_products_appliances_and_equipment_secondary ) +
         level2( out_patient_services_secondary ) +
         level2( hospital_services_secondary );
         
      rpers.expenses( health_insurance ) := 
         level3( insurance_connected_with_the_health_tertiary );

      rpers.expenses( pension_contributions) := 
         level3( savings_from_contribution_to_pension_provident_and_annuity_funds_and_employer_contribution_tertiary );

      rpers.income( in_kind_water_sanitation_electricity ) := 
         level2( in_kind_income_from_free_water_secondary ) +
         level2( in_kind_income_from_free_sanitation_secondary ) +
         level2( in_kind_income_from_free_electricity_secondary );
      
      rpers.income( in_kind_company_vehicle_or_discounted_fares ) :=
         level2( in_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary );
      
      rpers.income( in_kind_education ) :=
         level2( in_kind_income_from_schools_and_other_edu_inst_grant_secondary ) +
         level2( in_kind_income_from_textbooks_others_library_services_and_stationery_grants_secondary ) +
         level2( in_kind_income_from_computer_certification_excursions_other_including_language_classes_pre_primary_primary_tertiary_education_and_vocational_training_grants_secondary );
      
      rpers.income( in_kind_child_care ) :=
         level2( in_kind_income_from_day_care_mothers_medical_aid_contribution_schools_and_universities_boarding_fees_secondary );

      rpers.in_kind_and_from_employer_expenses( health_insurance ) := 
         rhh.expenditure_and_income( medical_aid_contribution_contribution_by_employer_in_private_institutions ).Valueannualized +
         rhh.expenditure_and_income( medical_aid_contribution_contribution_by_employer_in_public_institutions ).Valueannualized +
         rhh.expenditure_and_income( medical_aid_contribution_contribution_by_employer_in_private_institutions_income ).Valueannualized + 
         rhh.expenditure_and_income( medical_aid_contribution_contribution_by_employer_in_public_institutions_income ).Valueannualized;

      rpers.in_kind_and_from_employer_expenses( travel_to_work ) :=
         level2( in_kind_income_from_private_use_of_company_vehicle_or_discounted_fares_for_educational_and_non_educational_purposes_secondary );
      
      rpers.in_kind_and_from_employer_expenses( pension_contributions) := 
         level2( savings_from_contribution_to_pension_repayment_on_loans_and_employer_contribution_to_pension_secondary );
      rpers.expenses( annuity_funds_contributions ) := 
         rhh.expenditure_and_income( contribution_to_pension_provident_and_annuity_funds ).Valueannualized;
      
      rpers.in_kind_and_from_employer_expenses( annuity_funds_contributions ) := 
         rhh.expenditure_and_income( employer_contribution_to_pension_provident_and_annuity_funds ).Valueannualized;
      --
      -- these are mostly for checking purposes and will be overwritten
      -- 
      -- rpers.income( paye_income_tax ) := level3( taxes_paye_income_tax_tertiary );
      rpers.income( site_income_tax ) := 
         level3( taxes_site_income_tax_tertiary ) +
         level3( taxes_according_to_assessment_income_tax_tertiary ) +
         level3( taxes_amnesty_tax_tertiary );
      rpers.income( employers_uif ) := 0.0;
      rpers.income( employees_uif ) := level3( taxes_unemployment_insurance_fund_uif_tertiary ); 
      
         
   end Assign_Household_Level_Income_And_Expenses;
   
   function Map_Race( rawr : raw.Population_Group ) return model_types.Population_Group is
   use raw;
   begin
      case rawr is
      when african_or_black => return model_types.african_or_black;
      when coloured => return model_types.coloured;
      when indian_or_asian => return model_types.indian_or_asian;
      when white => return model_types.white;
      when others => return model_types.other_population_group;
      end case;
   end Map_Race;
   
   function Map( rpers : raw.Person_Rec ) return model.Person_Rec is
      use model_types;
      use Coicop_Definitions;
      mpers : model.Person_Rec;
   begin
      mpers.age := Map_Age_Range( rpers.info.Agegrp );
      Put_Line( "mapping " & rpers.info.gender'Img );
      mpers.gender := model_types.Gender_Type'Val( 
         raw.Gender_Type'Pos( rpers.info.Gender ) - 1 );
      Put_Line( "mapped to" & mpers.gender'Img );
      mpers.education := model_types.Education_Level'Val( 
         raw.Education_Level'Pos( rpers.info.Q15higheduc ) - 1 );      
      mpers.race := Map_Race( rpers.info.Popgrp );
      mpers.income( salaries_and_wages ) := 
         rpers.person_income( household_salaries_and_wages ).value;
      mpers.income( self_employment_and_business_income ) := 
         rpers.person_income( household_self_employment_and_business ).value; -- FIXME minus losses
      mpers.income( property_income ) := 
         rpers.person_income( income_from_letting_of_fixed_property ).value;
      mpers.income( royalties ) := 
         rpers.person_income( royalties ).value;
      mpers.income( interest_received ) := 
         rpers.person_income( interest_received ).value;
      mpers.income( dividends ) := 
         rpers.person_income( dividends_of_listed_companies ).value + 
         rpers.person_income( dividends_of_unlisted_companies ).value +
         rpers.person_income( other_dividends ).value;
      mpers.income( private_pensions ) := 
         rpers.person_income( pension_from_previous_employment ).value;
      mpers.income( annuities ) :=
         rpers.person_income( annuities_from_own_investment ).value;
      mpers.income( alimony_palimony_and_other_allowances ) :=
         rpers.person_income( alimony_palimony_and_other_allowances ).value;
      mpers.income( income_from_other_individuals ) :=
         rpers.person_income( other_income_from_individuals ).value;
      
      mpers.income( disability_grants ) := 
         rpers.person_income( disability_grants ).value;
      mpers.income( old_age_pensions ) := 
         rpers.person_income( old_age_pensions ).value;
      mpers.income( family_allowances ) := 
         rpers.person_income( family_and_other_allowances ).value;
      mpers.income( other_state_benefits ) := 
         rpers.person_income( workmens_compensation_funds ).value;
      mpers.is_disabled_or_blind := mpers.income( disability_grants ) > 0.0;
      return mpers;
   end Map;
   
   function Make_Total_Personal_Income( rpers : raw.Person_Rec ) return Amount is
      sum : Amount := 0.0;
   begin
      for i in rpers.person_income'Range loop
         sum := sum + rpers.person_income(i).value;
      end loop;
      return sum;
   end Make_Total_Personal_Income;
   
   function Count_Members( mhh : in model.Household ) return model_types.Person_Count is
      use ZA.Model_Types;
      n : model_types.Person_Count := 0;
   begin
      for fno in 1 .. mhh.info.num_families loop
         n := n + mhh.family( fno ).num_people;
      end loop; 
      return n;
   end Count_Members;

   procedure Assign_People_To_Family_Units( 
      mhh     : in out model.Household; 
      mpeople : model.Person_Array; 
      skel    : HH_Skel ) is
      use ZA.Model_Types;
      pno : model_types.Person_Count;
   begin
      mhh.info.num_families := Family_Unit_Count( skel.num_tus );
      families:
      for fno in 1 .. mhh.info.num_families loop
         pno := 0;
         declare
            rfno : Natural := Natural( fno );
         begin
            mhh.family( fno ).num_adults := Person_Count( skel.tus( rfno ).num_adults );
            mhh.family( fno ).num_children := Person_Count( skel.tus( rfno ).num_children );         
            adults:
            for adno in 1 .. skel.tus( rfno ).num_adults loop
               declare
                  radno : Natural := Natural( adno );
               begin
                  pno := pno + 1;
                  mhh.family( fno ).person( pno ) := mpeople( Person_Range( skel.tus( rfno ).adults( radno ))); 
                  mhh.family( fno ).person( pno ).family_unit := fno;
                  mhh.family( fno ).person( pno ).family_person_num := pno;
                  mhh.family( fno ).person( pno ).is_classed_as_adult := True;
               end;
            end loop adults;
            children:
            for chno in 1 .. skel.tus( rfno ).num_children loop
               declare
                  rchno : Natural := Natural( chno );
               begin
                  pno := pno + 1;
                  mhh.family( fno ).person( pno ) := mpeople( Person_Range( skel.tus( rfno ).child( rchno )));
                  mhh.family( fno ).person( pno ).family_unit := fno;
                  mhh.family( fno ).person( pno ).family_person_num := pno;
               end;
            end loop children;
            mhh.family( fno ).num_people := pno;
            Assert( mhh.family( fno ).num_people = Person_Range( skel.tus( rfno ).num_adults + skel.tus( rfno ).num_children ), "fu count doesn't match" );
         end;
      end loop families;
      Assert( Count_Members( mhh ) = Person_Count( People_Count( skel )), "skel counts don't match " & 
         Count_Members( mhh )'Img & " " & People_Count( skel )'Img );
      Assert( mhh.info.num_people = Count_Members( mhh ), " num_people mismatch " &
         Count_Members( mhh )'Img & " " & mhh.info.num_people'Img );
   end Assign_People_To_Family_Units;
   
   function Map( rhh : raw.Household ) return model.Household is
      use ZA.Model_Types;
      use Ada.Calendar;
      level3 : Coicop_Definitions.Tertiary_Group_Array := ( Others=>0.0 );
      level2 : Coicop_Definitions.Secondary_Group_Array := ( Others=>0.0 );
      
      mhh : model.Household;
      np  : Person_Count := 0;
      richest_person : Person_Range := 1;
      max_income : Amount := 0.0;
      skel : constant HH_Skel := Allocate_People_To_Families( rhh );
      mpeople : model.Person_Array;
   begin
      mhh.info.uqno := rhh.housing.uqno;
      Put_Line( " rhh.housing.SurveyYear " & Format( rhh.housing.SurveyYear ) &
                " raw.Survey_Month " & raw.Pretty_Print( rhh.housing.surveyMonth ));
      mhh.info.interview_date := Time_Of( 
         rhh.housing.SurveyYear,
         raw.Survey_Month'Pos( rhh.housing.SurveyMonth ), 
         1 );
      mhh.info.dwelling := model_types.Main_Dwelling_Type'Val(
            raw.Main_Dwelling_Type'Pos( rhh.housing.Q31dwelltypemain ) - 1 );
      mhh.info.province := model_types.Province_Type'Val( 
         raw.Province_Type'Pos( rhh.housing.prov ) - 1 );
      mhh.info.tenure := model_types.Tenure_Type'Val( 
         raw.Tenure_Type'Pos( rhh.housing.Q45ownrent ) - 1 );
      mhh.info.urban_or_rural := model_types.Settlement_Type'Val( 
         raw.Settlement_Type'Pos( rhh.housing.settlement ) - 1 );
      mhh.info.ies_total_income := rhh.housing.Income;
      mhh.info.ies_in_kind_income := rhh.housing.Inkindincome;
      mhh.info.ies_total_consumption := rhh.housing.Consumptions;
      mhh.info.weight := rhh.housing.weight;
      for p in rhh.person'Range loop
         if( rhh.person( p ).info.uqno /= Sernum_Value'First ) then
            np := np + 1;            
            mpeople( np ) := Map( rhh.person( p ));
            if( mpeople( np ).is_disabled_or_blind )then
               mhh.info.has_disabled_member := True;
            end if;
            if( mpeople( np ).age > mhh.info.age_of_oldest_person )then
               mhh.info.age_of_oldest_person := mpeople( np ).age;
            end if;
            if( mpeople( np ).age < mhh.info.age_of_youngest_person )then
               mhh.info.age_of_youngest_person := mpeople( np ).age;
            end if;
            declare
               inc : constant Amount := Make_Total_Personal_Income( rhh.person( p ));
            begin
               if( inc > max_income ) then
                  max_income := inc;
                  richest_person := np;
               end if;
            end;
         end if;
      end loop;
      mhh.info.num_people := np;
      if( mpeople( richest_person ).age < 16 ) then
         richest_person := 1;
      end if;
      -- CHECK mhh.num_people = raw people count
      for i in rhh.expenditure_and_income'Range loop
         if( rhh.expenditure_and_income( i ).uqno /= Sernum_Value'First ) then
            Coicop_Definitions.Aggregate_To( level3, i, rhh.expenditure_and_income( i ).Valueannualized );
            Coicop_Definitions.Aggregate_To( level2, i, rhh.expenditure_and_income( i ).Valueannualized );
         end if;
      end loop;
      for i in model_types.Consumption_Type'Range loop
         declare
            n : Natural := model_types.Consumption_Type'Pos( i ) + 1;
            p : Coicop_Definitions.Tertiary_Group := 
               Coicop_Definitions.Tertiary_Group'Val( n );
         begin
            mhh.info.consumption( i ) := level3( p );
         end;
      end loop;
      --
      -- expenses: these are 
      -- recorded at hh level but we want to assign to
      -- the pricipal earner
      Assign_Household_Level_Income_And_Expenses( rhh, level2, level3, mpeople( richest_person ));
      
      Assign_People_To_Family_Units( mhh, mpeople, skel );
      return mhh;
   end Map;
        
end ZA.Model_Dataset_Maker;        
