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
with Text_Utils;
with Coicop_Definitions;
with Ada.Calendar.Formatting;

package body ZA.Model.Data is

   --
   -- fill in age of oldest/youngest, has disabled ..
   --
   procedure Complete_Household_Information( hh : in out Household ) is
   begin
      for fno in 1 .. hh.info.num_families loop
         for pno in 1 .. hh.family( fno ).num_people loop
            if( hh.family( fno ).person( pno ).age > hh.info.age_of_oldest_person ) then
               hh.info.age_of_oldest_person := hh.family( fno ).person( pno ).age;
            end if;
            if( hh.family( fno ).person( pno ).age > hh.family( fno ).age_of_oldest_person ) then
               hh.family( fno ).age_of_oldest_person := hh.family( fno ).person( pno ).age;
            end if;
            if( hh.family( fno ).person( pno ).age < hh.info.age_of_youngest_person ) then
               hh.info.age_of_youngest_person := hh.family( fno ).person( pno ).age;
            end if;
            if( hh.family( fno ).person( pno ).age < hh.family( fno ).age_of_youngest_person ) then
               hh.family( fno ).age_of_youngest_person := hh.family( fno ).person( pno ).age;
            end if;
            if( hh.family( fno ).person( pno ).is_disabled_or_blind ) then
               hh.family( fno ).has_disabled_member := True;
               hh.info.has_disabled_member := True;
            end if;
         end loop;
      end loop;
   end Complete_Household_Information;
   
   function To_String( pers : Person_Rec; include_non_zeros : Boolean := false ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & " Age " & Format( pers.age ) & LINE_BREAK;
      s := s & " Gender " & Pretty_Print( pers.gender ) & LINE_BREAK;
      s := s & " Race " & Pretty_Print( pers.race ) & LINE_BREAK;
      s := s & " Education " & Pretty_Print( pers.education ) & LINE_BREAK;
      s := s & " Is Disabled/Blind " & Boolean'Image( pers.is_disabled_or_blind ) & LINE_BREAK;
      s := s & " ==== Incomes ========= " & LINE_BREAK;
      for i in pers.income'Range loop 
         if( pers.income( i ) /= 0.0 ) or include_non_zeros then
            s := s & ZA.Model_Types.Pretty_Print( i ) & "  " & Format_With_Commas( pers.income( i )) & LINE_BREAK;
         end if;
      end loop;
      s := s & " ==== Expenses ========= " & LINE_BREAK;
      for i in pers.expenses'Range loop 
         if( pers.expenses( i ) /= 0.0 ) or include_non_zeros then
            s := s & ZA.Model_Types.Pretty_Print( i ) & "  " & Format_With_Commas( pers.expenses( i )) & LINE_BREAK;
         end if;
      end loop;
      s := s & " ==== Employer's and In-Kind expenses ========= " & LINE_BREAK;
      for i in pers.expenses'Range loop 
         if( pers.in_kind_and_from_employer_expenses( i ) /= 0.0 ) or include_non_zeros then
            s := s & ZA.Model_Types.Pretty_Print( i ) & "  " & Format_With_Commas( pers.in_kind_and_from_employer_expenses( i )) & LINE_BREAK;
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( fam : Family_Unit_Rec; include_non_zeros : Boolean := false ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & " Num Adults " & Person_Count'Image( fam.num_adults ) & LINE_BREAK;
      s := s & " Num Children " & Person_Count'Image( fam.num_children ) & LINE_BREAK;
      for pno in 1 .. fam.num_people loop
         s := s & "======== Person " & Person_Count'Image( pno ) & "==========" & LINE_BREAK;
         s := s & To_String( fam.person( pno ), include_non_zeros );
         s := s & "=== End Person " & Person_Count'Image( pno ) & "==========" & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( hh : Household; include_non_zeros : Boolean := false ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & " Serial Number " & Sernum_Value'Image( hh.info.uqno ) & LINE_BREAK;
      s := s & " Weight " & Format( hh.info.weight ) & LINE_BREAK;
      s := s & " Interview Date " & Ada.Calendar.Formatting.Image( hh.info.interview_date ) & LINE_BREAK;
      s := s & " Num People " & Person_Count'Image( hh.info.num_people ) & LINE_BREAK;
      s := s & " Num Families " & Family_Unit_Count'Image( hh.info.num_families ) & LINE_BREAK;
      
      s := s & " Province " & Pretty_Print( hh.info.province )  & LINE_BREAK;
      s := s & " Tenure " & Pretty_Print( hh.info.tenure ) & LINE_BREAK;
      s := s & " Urban or rural " & Pretty_Print( hh.info.urban_or_rural ) & LINE_BREAK;
      s := s & " IES total income " & Format_With_Commas( hh.info.ies_total_income )  & LINE_BREAK;
      s := s & " IES in kind income " & Format_With_Commas( hh.info.ies_in_kind_income )  & LINE_BREAK;
      s := s & " IES total consumption " & Format_With_Commas( hh.info.ies_total_consumption )  & LINE_BREAK;
      s := s & " Has Disabled/Blind member " & Boolean'Image( hh.info.has_disabled_member ) & LINE_BREAK;
      s := s & " ==== Consumption ========= " & LINE_BREAK;
      for i in hh.info.consumption'Range loop
         if( hh.info.consumption(i) /= 0.0 ) or include_non_zeros then
             s := s & Pretty_Print( i ) & "  " & Format_With_Commas( hh.info.consumption( i )) & LINE_BREAK;
         end if;
      end loop;
      for fno in 1 .. hh.info.num_families loop
         s := s & "======== Family Unit " & Family_Unit_Count'Image( fno ) & "==========" & LINE_BREAK;
         s := s & To_String( hh.family( fno ));
         s := s & "=== End Family " & Family_Unit_Count'Image( fno ) & "==========" & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;
  
   EMPLOYERS_UIF_RATE : constant := 0.01;
   --
   -- FIXME : make these monthy and move to files
   --
   -- crude popn adjustment mid year 2005 = 46.9m mid year 2009 49.32m
   --
   POPULATION_GROWTH : constant := 49.32/46.9;
   --
   -- see http://www.statssa.gov.za/publications/P0441/P04411stQuarter2009.pdf
   -- Q3 2005 - Q1 2009.
   NOM_GDP_GROWTH_PER_CAPITA : constant := 574_838.0/(375_115.0*POPULATION_GROWTH);
   EMPLOYEE_COMPENSATION_GROWTH_PER_CAPITA : constant := 243_098.0/(172_443.0*POPULATION_GROWTH);
   --
   -- See: http://www.statssa.gov.za/publications/statsdownload.asp?PPN=P0141&SCH=4411
   -- and http://www.statssa.gov.za/keyindicators/CPI/CPIHistory_rebased.pdf
   -- 2005 July 80.3 May 2009 106.6 (FIXME: may be slightly rebased)
   --
   CPI_INFLATION : constant := 106.6/80.3;
   
   procedure Uprate( hh : in out Household; settings : Run_Settings ) is
      use Coicop_Definitions;
      mult : amount := 1.0;
      --
      --
      -- note all data is ?? moved to June 2005 (CHECK THIS) so we only need 1 uprating factor 
    begin
      each_family:
      for fno in 1 .. hh.info.num_families loop
         each_member:
         for pno in 1 .. hh.family( fno ).num_people loop
            for i in Personal_Incomes_Type loop
               case i is
                  when 
                     self_employment_and_business_income |
                     salaries_and_wages =>
                     mult := EMPLOYEE_COMPENSATION_GROWTH_PER_CAPITA;
                  when others =>
                     mult := NOM_GDP_GROWTH_PER_CAPITA;
               end case;
               hh.family( fno ).person( pno ).income( i ) := 
                  hh.family( fno ).person( pno ).income( i ) * mult;
               -- NOM_GDP_GROWTH (check may not be consistent with expenditure
            end loop;
            for i in Personal_Expenses_Type loop
               hh.family( fno ).person( pno ).expenses( i ) := 
                  hh.family( fno ).person( pno ).expenses( i ) * NOM_GDP_GROWTH_PER_CAPITA;
            end loop;
         end loop each_member;
      end loop each_family;
      mult := 1.0;
      for i in hh.info.consumption'Range loop
          case i is
            when bread_and_cereals .. tobacco => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when clothing_materials .. repair_and_hire_of_foowear => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when actual_rentals_paid_by_tenants .. solid_fuels => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when furniture_and_furnishings .. domestics_services_and_household_arcticles => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when pharmaceutical_products .. hospital_services => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when motor_cars .. cost_for_other_modes_of_transport => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when postal_services .. package_holidays => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when pre_primary_and_primary_education .. education_not_definable_by_level => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when beverages_in_restaurants_cafes_canteens_and_the_likes .. accommodation_services => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when hairdressing_salons_and_personal_grooming_astablishment .. consumption_others_expenditures => mult := NOM_GDP_GROWTH_PER_CAPITA;
            when others => mult := NOM_GDP_GROWTH_PER_CAPITA;
          end case;
          hh.info.consumption( i ) := hh.info.consumption( i ) * mult;
      end loop;
   end Uprate;
   
   --
   -- rough fixes to National Income Aggregates
   --
   procedure Apply_Income_Consumption_Adjustments( hh : in out Household; settings : Run_Settings ) is
      use Coicop_Definitions;
      mult : amount := 1.0;
      --
      -- this is a hack to scale back VAT from a value of 195bn 
      -- run of 18/8/08 to actual 168bn 2009 ( Estimates of revenue 2009 Table 2)
      -- This is applied on top of the adjustments in the IES book from
      -- comparing expenditures with National Accounts. Run revision 7950
      -- Exciseable goods are treated seperately.
      -- 
      VAT_SCALEBACK : constant Amount := 169.0/195.0;
   begin
      --
      -- see:  Income and expenditure of households 2005/2006: Analysis of results
      -- Table 3 – Comparison of IES 2005/2006 with national accounts data (R billion)
      --
       -- A) PERSONAL INCOMES
      each_family:
      for fno in 1 .. hh.info.num_families loop
         each_member:
         for pno in 1 .. hh.family( fno ).num_people loop
            for i in Personal_Incomes_Type loop
               case i is
                  when 
                     alimony_palimony_and_other_allowances |
                     income_from_other_individuals |
                     private_pensions |
                     royalties |
                     other_income =>
                     mult := 1.0/0.68;
                  when annuities => -- Note 0.12 is from iterating till tax came to 200 bn
                     mult := 1.0/0.115; -- 1.0/0.12;
                  when dividends => 
                     mult :=  1.0/0.115; -- 111.9/1.6;
                  when interest_received =>
                     mult :=  1.0/0.115; -- 1.0/0.12;
                  when property_income => 
                     mult :=  1.0/0.115; -- 1.0/0.04; -- FIXME
                  when 
                     salaries_and_wages |
                     self_employment_and_business_income =>       
                     mult := 1.0/0.96;
                  when Personal_State_Benefits_Range =>
                     mult := 1.0/1.10; -- FIXME
                  when Personal_Taxes_Range =>
                     mult := 1.0; -- FIXME ntable 2ot needed? check book
                  when In_Kind_Personal_Incomes_Range =>
                     mult := 1.0; -- FIXME not needed? check book
               end case;
               hh.family( fno ).person( pno ).income( i ) := 
                  hh.family( fno ).person( pno ).income( i ) * mult;
            end loop;
            --
            -- gross up wages to be gross of employers UIF
            --
            hh.family( fno ).person( pno ).income( salaries_and_wages ) := 
               hh.family( fno ).person( pno ).income( salaries_and_wages ) / ( 1.0-EMPLOYERS_UIF_RATE );
         end loop each_member;
      end loop each_family;
      --
      -- 
      -- B) CONSUMPTION
      -- the weights here come from  table 13 in IES report, 
      -- comparisons with National accounts
      --
      mult := 1.0;
      for i in hh.info.consumption'Range loop
          case i is
            when bread_and_cereals .. unclassified_food_items => mult := VAT_SCALEBACK * 26.2/(0.67*15.6);
            when clothing_materials .. repair_and_hire_of_foowear => mult := VAT_SCALEBACK * 5.8/(0.67*5.0);
            when actual_rentals_paid_by_tenants .. solid_fuels => mult := VAT_SCALEBACK * 13.0/(0.67*23.6);
            when furniture_and_furnishings .. domestics_services_and_household_arcticles => mult := VAT_SCALEBACK * 7.8/(0.67*6.9);
            when pharmaceutical_products .. hospital_services => mult := VAT_SCALEBACK * 8.4/(0.67*5.1);
            when motor_cars .. cost_for_other_modes_of_transport => mult := VAT_SCALEBACK * 17.5/(0.67*19.9);
            when postal_services .. package_holidays => mult := VAT_SCALEBACK * 4.2/(0.67*4.6);
            when pre_primary_and_primary_education .. education_not_definable_by_level => mult := VAT_SCALEBACK * 3.1/(0.67*2.4);
            when beverages_in_restaurants_cafes_canteens_and_the_likes .. accommodation_services => mult := VAT_SCALEBACK * 2.7/(0.67*2.2);
            when hairdressing_salons_and_personal_grooming_astablishment .. consumption_others_expenditures => mult := VAT_SCALEBACK * 11.4/(0.67*14.8);
            --
            -- excisable are from run of 18/8 with weights of 1.0
            -- revision 7950 (deminator). 
            --  tmp/tab_indir_with_excise_not_grossed.csv
            -- compared to 
            -- 2009  estimates of national revenue table 2 (numerator).
            -- dunno what's happened to beer.. 
            -- FIXME we should probably revise the everything else down a little
            -- 
            when beer => mult := 6_512.0/296.0;
            when wine => mult := 1_559.0/213.0;
            when spirits => mult := 2_807.0/422.0;
            when tobacco => mult := 9_614.0/2_855.0;
            when others => mult := 1.0;
          end case;
          
          hh.info.consumption( i ) := hh.info.consumption( i ) * mult;
      end loop;
      hh.info.weight := hh.info.weight * POPULATION_GROWTH;
      --
      -- FIXME: all other expenditures; hh incomes
      -- 
      
   end Apply_Income_Consumption_Adjustments;
   
   
end ZA.Model.Data;
