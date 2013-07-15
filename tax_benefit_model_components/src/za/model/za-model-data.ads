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
pragma License( Modified_GPL );

with T_Utils;
with Ada.Calendar;
with ZA.Model.Settings;

package ZA.Model.Data is

   use ZA.Model.Settings;
   
   type Person_Rec is record
      age       : Age_Range;
      gender    : Gender_Type;
      income    : Income_Array := ( Others=>0.0 );
      expenses  : Personal_Expenses_Array := ( Others=>0.0 );
      in_kind_and_from_employer_expenses  : Personal_Expenses_Array := 
         ( Others=>0.0 );
      education : Education_Level;
      race      : Population_Group;
      is_disabled_or_blind : Boolean := False;
      family_unit : Family_Unit_Range;
      family_person_num : Person_Range;
      is_classed_as_adult : Boolean := False;
   end record;
   
   type Person_Array is array( Person_Range ) of Person_Rec;

   --
   -- just the household section. This is a hack of sorts
   -- to make binary i/o easier since we can
   -- have the people declared seperately.
   -- 
   type Household_Info is record
      uqno                         : Sernum_Value  := Sernum_Value'First;
      interview_date               : Ada.Calendar.Time;
      province                     : Province_Type := Province_Type'First;
      tenure                       : Tenure_Type := Tenure_Type'First;
      num_children_under_16        : Person_Count := Person_Count'First;
      num_adults_over_60_and_over  : Person_Count := 
                                       Person_Count'First;
      urban_or_rural               : Settlement_Type := Settlement_Type'First;
      dwelling                     : Main_Dwelling_Type := 
                                       Main_Dwelling_Type'First;
      ies_total_income             : Amount := 0.0;
      ies_in_kind_income           : Amount := 0.0;
      ies_total_consumption        : Amount := 0.0;
      has_disabled_member          : Boolean := False;
      consumption                  : Consumption_Array := ( Others=>0.0);
      weight                       : Amount := 0.0;
      num_people                   : Person_Count := Person_Count'First;
      num_families                 : Family_Unit_Count := 
                                       Family_Unit_Count'First;
      is_married_household         : Boolean := False;
      age_of_oldest_person         : Age_Range := Age_Range'First;
      age_of_youngest_person       : Age_Range := Age_Range'Last;
   end record;
   
   type Family_Unit_Rec is record
      num_adults   : Person_Count := 0;
      num_children : Person_Count := 0;
      num_people   : Person_Count := 0;
      person       : Person_Array;
      age_of_oldest_person         : Age_Range := Age_Range'First;
      age_of_youngest_person       : Age_Range := Age_Range'Last;
      has_disabled_member          : Boolean := False;
   end record;
   
   type Family_Unit_Array is array( Family_Unit_Range ) of Family_Unit_Rec;
   
   type Household is record
      info    : Household_Info;
      family  : Family_Unit_Array;      
   end record;
   
   --
   -- fill in age of oldest/youngest, has disabled ..
   --
   procedure Complete_Household_Information( hh : in out Household );

   function To_String( 
      hh : Household; include_non_zeros : Boolean := false ) return String;
   
   function To_String( 
      fam : Family_Unit_Rec; include_non_zeros : Boolean := false ) return String;
   
   function To_String( 
      pers : Person_Rec; include_non_zeros : Boolean := false ) return String;
   
   procedure Uprate(
      hh : in out Household; settings : Run_Settings );
   
   procedure Apply_Income_Consumption_Adjustments( 
      hh : in out Household; settings : Run_Settings );
   
end ZA.Model.Data;
