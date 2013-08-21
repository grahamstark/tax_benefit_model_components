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

--
--  $Author: graham_s $
--  $Date: 2010-02-11 19:11:22 +0000 (Thu, 11 Feb 2010) $
--  $Revision: 8612 $
--
pragma License( Modified_GPL );

with Ada.Text_IO;
with Ada.Text_Io.Editing;

with AUnit.Assertions;   
with Base_Model_Types;             
with Format_Utils;
with Indirect_Tax_Utils;
with Text_Utils;

with Coicop_Definitions;
with ZA;
with ZA.IES.Raw_IO;
with ZA.IES;
with ZA.Model;
with ZA.Model_Types;
with ZA.Model.Data;
with ZA.Model.Data.Binary_IO;
with ZA.Model.Data.Examples;
with ZA.Model_Dataset_Maker;
with ZA.Model.Results;
with ZA.Model.Params;
with ZA.Model.Settings;
with Inequality_Generator;

package body ZA.Tests is

   use Ada.Text_IO;
   use AUnit.Assertions;
   use Text_Utils;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   package za_inequality is new Inequality_Generator( Amount=>Amount, Rate=>Rate );

   package mod_enums renames ZA.Model_Types;
   
   procedure Test_Edits( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   use Ada.Text_IO.Editing;
      P1     : Picture :=
      To_Picture ("-ZZZ_ZZZ_ZZZ_ZZZZ_ZZZ_ZZ9.9" );
      P2     : Picture :=
      To_Picture ("ZZZ_ZZZ_ZZZ_ZZZZ_ZZZ_ZZ9.9" );
      P3     : Picture :=
      To_Picture ("99999999.9" );
      i : Integer := Integer'Value( "0001" );
   package Decimal_Format is new Decimal_Output (
         Num => Counter_Type,
         Default_Currency => Default_Currency,
         Default_Fill => Default_Fill,
         Default_Separator => Default_Separator,
         Default_Radix_Mark => Default_Radix_Mark );
      
   begin
      Put_Line( " p1 |" & Decimal_Format.Image( -100.0, P1 ));
      Put_Line( " p2 |" & Decimal_Format.Image( -100.0, P2 ));
      Put_Line( " p3 |" & Decimal_Format.Image( -100.0, P3 ));
   end Test_Edits;
    
   procedure Test_Aggregation( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Coicop_Definitions;
   begin   
      for i in Coicop_Type loop
         if i in Other_personal_effects_tertiary_Range then
            Put_Line( "i " & Coicop_Type'Image( i ));
         end if;
      end loop;
   end Test_Aggregation;
   
   
   
  
   procedure Test_Allocate_To_Benefit_Units( T : in out AUnit.Test_Cases.Test_Case'Class ) is    
   begin
      null;
      
   end Test_Allocate_To_Benefit_Units;
      
   
      
   
   
   procedure Test_Read_Binary( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.IES.Raw_IO;
      use ZA.IES;
      use Coicop_Definitions;
      use za_inequality;
      
      type Sex_by_Province_By_Race_HH_Table is array( Gender_Type, Population_Group_Of_Head, Province_Type ) of Amount;
      type Sex_by_Province_By_Race_Pers_Table is array( Gender_Type, Population_Group, Province_Type ) of Amount;
      type By_Sex_Table is array( Gender_Type ) of Amount;
      type By_Race_Table is array( Population_Group_Of_Head ) of Amount;
      type By_Province_Table is array( Province_Type ) of Amount;
      type Exp_by_Race_Table is array( Population_Group_Of_Head ) of Tertiary_Group_Array;
      
      hh : Household;
      p  : Natural := 0;
      population : Amount := 0.0;
      by_hh_head : Sex_by_Province_By_Race_HH_Table := ( Others=>(Others=>(Others=>0.0 )));
      by_person : Sex_by_Province_By_Race_Pers_Table := ( Others=>(Others=>(Others=>0.0 )));
      households_by_race,
      by_race : By_Race_Table := ( Others=>0.0 );
      by_sex : By_Sex_Table := ( Others=>0.0 );
      by_province : By_Province_Table := ( Others=>0.0 );
      weighted_size : Amount;
      household_count : Amount := 0.0;
      lorenz        : Quantile_List;
      all_net_incomes   : Quantile_List;
      inequality_measures : Inequality_Array;
      
      expenditure_value,
      expenditure_annualised : Tertiary_Group_Array := ( Others=>0.0 );
      expenditure_value_by_race,
      expenditure_annualised_by_race : Exp_by_Race_Table := ( Others=>( Others => 0.0 ) );
      quant : Quantile;
      
      procedure Read_HH( pos : IES_Map_Package.Cursor ) is
         index : Index_Rec := IES_Map_Package.Element( pos );
         total_household_wages : Amount;
      begin
         p := p + 1;
         hh := Read_Household( index );
         household_count := household_count + hh.housing.weight;
         --
         -- inequalities
         --
         quant.population := hh.housing.weight * Amount( hh.housing.Hsize );
         quant.income := hh.housing.income;
         if quant.income > 0.0 then
            Quantile_Package.Append( all_net_incomes, quant );
         end if;
         Put_Line( "On Household " & Natural'Image( p ) & " hhref " & Sernum_Value'Image( hh.housing.uqno ) );
         if( p < 50 ) then
            Put_Line( To_String( hh ));
         end if;
         weighted_size := hh.housing.weight * Amount( hh.housing.Hsize );
         by_hh_head( hh.housing.Genderofhead, hh.housing.Popgrpofhead, hh.housing.Prov ) := 
            by_hh_head( hh.housing.Genderofhead, hh.housing.Popgrpofhead, hh.housing.Prov ) +  
               weighted_size;
         total_household_wages := 0.0;
         for p in Person_Range loop 
            if( hh.person( p ).info.uqno /= Sernum_Value'First ) then
               declare
                  race   : Population_Group := hh.person(p).info.popgrp;
                  gender : Gender_Type := hh.person(p).info.gender;
                  weight : Amount := hh.person(p).info.weight;
               begin
                  total_household_wages := total_household_wages + 
                     hh.person(p).person_income( household_salaries_and_wages ).value;
                  by_person( gender, race, hh.housing.Prov ) := 
                     by_person( gender, race, hh.housing.Prov ) + weight; 
               end;
            end if;
         end loop;
         --
         -- test sum of individual earnings against aggregate for household; should be identical
         --
         Put( Sernum_Value'Image( hh.housing.uqno ) & " : " &
              Format( total_household_wages ) & " : " & 
              Format( hh.expenditure_and_income( household_salaries_and_wages ).value ));
         if( total_household_wages /= hh.expenditure_and_income( household_salaries_and_wages ).value ) then
            Put( " DIFFERENT" );
            --  Put_Line( To_String( hh ));
         end if;
         New_Line;
         
         by_sex( hh.housing.Genderofhead ) := by_sex( hh.housing.Genderofhead ) +  weighted_size;
         by_province( hh.housing.prov ) := by_province( hh.housing.prov ) +  weighted_size;
         by_race( hh.housing.Popgrpofhead ) := by_race( hh.housing.Popgrpofhead ) +  weighted_size;
         households_by_race( hh.housing.Popgrpofhead ) := households_by_race( hh.housing.Popgrpofhead ) +  hh.housing.weight;
         
         population := population + weighted_size;
         for i in hh.expenditure_and_income'Range loop
            if( hh.expenditure_and_income( i ).uqno /= Sernum_Value'First ) then
                  Aggregate_To( expenditure_value, i, hh.expenditure_and_income( i ).value * hh.housing.weight );
                  Aggregate_To( expenditure_annualised, i, hh.expenditure_and_income( i ).Valueannualized * hh.housing.weight );
                  Aggregate_To( expenditure_value_by_race( hh.housing.Popgrpofhead ), i, 
                     hh.expenditure_and_income( i ).value * hh.housing.weight );
                  Aggregate_To( expenditure_annualised_by_race( hh.housing.Popgrpofhead ), i, 
                     hh.expenditure_and_income( i ).Valueannualized * hh.housing.weight );
            end if;
         end loop;
         -- TODO compare hsize with loop round people
      end Read_HH;
      
      index : Index_Map := Open_Index;
      total_value, total_annualised : Amount := 0.0;
   begin
      Open_Files;
      IES_Data_Index.Dump_Index( "/mnt/data/za/ies/2005/raw/org0160/index.bin", "tmp/index.dump" );
      IES_Map_Package.Iterate( index, Read_HH'Access );
      Close_Index( index );
      Close_Files;
      Put_Line( "total population " & Format_With_Commas(  population ));
      Put_Line( "By HH Head" );
      for sex in Gender_Type loop
         for pop in Population_Group_Of_Head loop
            for prov in Province_Type loop
               Put( Pretty_Print( sex ) & ", " );
               Put( Pretty_Print( pop ) & ", ");
               Put( Pretty_Print( prov ) & " = " );
               Put_Line( Format_With_Commas(  by_hh_head( sex, pop, prov ) ));
            end loop;
            New_Line;
         end loop;
         New_Line;
      end loop;
      Put_Line( "By Individual" );
      for sex in Gender_Type loop
         for pop in Population_Group loop
            for prov in Province_Type loop
               Put( Pretty_Print( sex ) & ", " );
               Put( Pretty_Print( pop ) & ", ");
               Put( Pretty_Print( prov ) & " = " );
               Put_Line( Format_With_Commas(  by_person( sex, pop, prov ) ));
            end loop;
            New_Line;
         end loop;
         New_Line;
      end loop;
      for sex in Gender_Type loop
         Put_Line( Pretty_Print( sex ) & " = " & Format_With_Commas(  by_sex( sex )));
      end loop;
      for prov in Province_Type loop
         Put_line( Pretty_Print( prov ) & " = " & Format_With_Commas(  by_province( prov )));
      end loop;
      for pop in Population_Group_Of_Head loop
         Put_line( Pretty_Print( pop ) & " = " & Format_With_Commas(  by_race( pop )));
      end loop;
      
      for i in expenditure_value'Range loop
         total_value := total_value + expenditure_value(i);
         total_annualised := total_annualised + expenditure_annualised(i);
      end loop;
      
      Put_Line( "======= totals " );
      for i in expenditure_value'Range loop
         Put_Line( Pretty_Print( i ) & Format_With_Commas( expenditure_value(i)) & 
            "  " & Format_With_Commas(  expenditure_annualised(i)/1000.0));
      end loop;
      for i in expenditure_value'Range loop
         expenditure_value(i) := expenditure_value( i ) / household_count;
         expenditure_annualised( i ) := expenditure_annualised( i ) / household_count;
         for pop in Population_Group_Of_Head loop
            if( households_by_race( pop ) /= 0.0 ) then
               expenditure_value_by_race( pop )( i ) := 
                  expenditure_value_by_race( pop )( i ) / households_by_race( pop );
               expenditure_annualised_by_race( pop )( i ) := 
                  expenditure_annualised_by_race( pop )( i ) / households_by_race( pop );
            end if;
         end loop;
      end loop;
      New_Line;
      Put_Line( " ======== Household totals ======== " );
      for pop in Population_Group_Of_Head loop
            Put_line( Pretty_Print( pop ) & "  " & Format_With_Commas(  households_by_race( pop )));
      end loop;
      New_Line;
      Put_Line( "======= averages " );
      for i in expenditure_value'Range loop
         Put( Pretty_Print( i ) & "  " ); 
         for pop in Population_Group_Of_Head loop
            Put( Pretty_Print( pop ) & "  " );
            Put( Format_With_Commas(  expenditure_value_by_race( pop )( i )));
            Put( "  " & Format_With_Commas(  expenditure_annualised_by_race( pop )( i )));
         end loop;
         Put_Line( " Totals " &  Format_With_Commas(  expenditure_value(i)) & "  " & Format_With_Commas(  expenditure_annualised(i)));
      end loop;
      Sort_By_Income( all_net_incomes );
      inequality_measures := Generate( all_net_incomes );
      Put_Line( To_String( inequality_measures ));
      lorenz := Binify( all_net_incomes, 10 );
      for i in 1 .. Quantile_Package.Length( lorenz ) loop
         quant := Quantile_Package.Element( lorenz, Positive(i) );
         Put_Line( "POPN " & TAB & Format( quant.population ) & TAB & " Inc " &
              TAB & Format( quant.income ) & TAB & " PC " & Format( quant.population/quant.income ));
      end loop;
   end Test_Read_Binary;
   
   procedure Test_Formats( T : in out AUnit.Test_Cases.Test_Case'Class ) is
     a : Amount;
     b : Counter_Type;
   begin
     a := 10000.01;
     b := 20000.01;
     Put_Line( ZA_Format_Utils.Format( a ));
     Put_Line( ZA_Format_Utils.Format( b ));
     Put_Line( ZA_Format_Utils.Format_With_Commas( a ));
     Put_Line( ZA_Format_Utils.Format_With_Commas( b ));
     Put_Line( ZA_Format_Utils.Format_Percent( a ));
     Put_Line( ZA_Format_Utils.Format_Percent( b ));
     
   end Test_Formats;
   
   procedure Test_Modular( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model_Types;    
      age : Age_Range := 40;
      type M5 is mod 5;
      age_addn : M5 := 0;
   begin
      for i in 1 .. 100 loop
         age := 40 + Age_Range( age_addn );
         Assert( age <= 44 and age >= 40, "age should never exceed 44 was " & Age_Range'Image( age ));
         Put_Line( "age " & Age_Range'Image( age ));
         age_addn := age_addn + 1;
      end loop;
   end Test_Modular;
      

   procedure Raise_Exception is 
   begin 
      raise Constraint_Error; 
   end Raise_Exception;
   
   procedure Test_Traceback( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      Raise_Exception;
   end Test_Traceback;
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      -- Register_Routine (T, Test_Modular'Access, "Test_Modular");
      Register_Routine (T, Test_Read_Binary'Access, "Test_Read_Binary");
      -- Register_Routine (T, Test_Formats'Access, "Test_Formats");
      -- Register_Routine (T, Test_Traceback'Access, "Test_Traceback");
     -- Register_Routine (T, Test_Edits'Access, "Test_Edits");
     null;
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( "South Africa calculations unit tests." );
   end Name;

end ZA.Tests;
