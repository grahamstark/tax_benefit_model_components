--
--  $Author: graham_s $
--  $Date: 2010-02-11 19:11:22 +0000 (Thu, 11 Feb 2010) $
--  $Revision: 8612 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;             
with Base_Model_Types;             
with Model.Household;              
with Tax_Utils;                    

with Model.Parameters;                 
with Model.Calculations;    
with Model.Output;

with Model.Run_Settings;
with Model.Parameters.Legal_Aid;                 
with Model.Calculations.Legal_Aid;
with Model.Calculations.Means_Tested_Benefits;
with Model.Calculations.Non_Means_Tested_Benefits;
with Model.Output.Legal_Aid;
with Model.Parameters.Means_Tested_Benefits;
with Model.Income_Measures;
with Test_Households;               

with Ada.Text_IO;
with Ada.Strings.Fixed;   
with Ada.Strings;   
with format_utils;
with text_utils;
with HTML_Utils;
with legal_aid_output_types; 
-- with legal_aid_runner;
with Model.Run_Settings;
with Model.Equivalence_Scales;
with frs_enums; 
with Model.Incomes;

with Model.Calculations.Complete;
with Model.Parameters.Complete;
with Model.Output.Complete;
with Model.Run_Settings;
with Model.Income_Measures;
with Model.Income_Measure_Types;

with Logger;

package body Povline_Tests is

   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   
   
   use Ada.Text_IO;
   use Ada.Strings;
   
   use Model.Household;
   use FRS_Enums;
   use Model.Incomes;
   use test_households;
   
   package calcs renames Model.Calculations.Complete;
   package pars  renames Model.Parameters.Complete;
   package outp  renames Model.Output.Complete;
   package rs    renames Model.Run_Settings;
   package mtb   renames Model.Calculations.Means_Tested_Benefits;
   package mim  renames Model.Income_Measures;
   package mimt  renames Model.Income_Measure_Types;
   
   TEST_HOUSEHOLDS : Test_Household_Array;
   DEFAULT_PARAMETERS : pars.Parameters;

   procedure Set_Up ( T : in out Test_Case ) is
      use Model;
   begin
      DEFAULT_PARAMETERS := pars.Get_2007_8_System;
      TEST_HOUSEHOLDS := makeExampleHouseholds;
      UK_Logger.Add_Target( means_tested );
      UK_Logger.Add_Target( non_means_tested );
   end Set_Up;
   
   procedure Test_MT_Components(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   use Model.Parameters.Means_Tested_Benefits;
      hh : Household_Rec;
      settings : rs.Settings_Rec; 
      prems    : Premia_Set;
      age_old  : Positive;
   begin 
      hh.num_benefit_units := 1;
      declare
         bu : Model_Benefit_Unit renames hh.benefit_units(1);
         ad : Model_Adult renames bu.adults(Head);
      begin
         bu.last_adult := Head;
         bu.num_children := 0;
         ad.age := 20;
         ad.sex := Female;
         age_old := Age_Of_Oldest_Person( bu );
         put_line( "Test_MT_Components:: "& To_String( hh ) );
         assert( age_old = 20, "age of oldest should be 20 was " & age_old'Img );
         prems := mtb.Find_Entitled_Premia( bu, DEFAULT_PARAMETERS.means_tested, Income_Support_JSA );
         Put_line( "entitled premia " & Premia_Package.To_String( prems ) );
      end;   
   end Test_MT_Components;   


   procedure Test_Poverty_Lines(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      results  : outp.Household_Result;
      settings : rs.Settings_Rec; 
      income_measures  : mimt.Household_Incomes_Result;
      
   begin
      for i in 1 ..MAX_TEST_HOUSEHOLDS loop
      
         put_line( "age of oldest " & Age_Of_Oldest_Person( TEST_HOUSEHOLDS(i).benefit_units(1) )'Img );
         put_line( "age of youngest adult" & Age_Of_Youngest_Adult( TEST_HOUSEHOLDS(i).benefit_units(1) )'Img );
         put_line( "household " & To_String( TEST_HOUSEHOLDS(i) ));
         put_line( "On Household " & Integer'Image(i) );
         results := calcs.Calculate( TEST_HOUSEHOLDS(i), DEFAULT_PARAMETERS, settings );
         mim.Calculate_Income_Measures( TEST_HOUSEHOLDS(i), results, income_measures, settings, 1.0 );
         Put_Line( outp.To_String( TEST_HOUSEHOLDS(i), results ) );
         Put_Line( mimt.To_String( TEST_HOUSEHOLDS(i), income_measures ) );
         results := outp.New_Output;
         income_measures := mimt.New_Output;
      end loop;
   end Test_Poverty_Lines;




        --------------------
        -- Register_Tests --
        --------------------

   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine (T, Test_Poverty_Lines'Access, "Poverty Lines");
      Register_Routine (T, Test_MT_Components'Access, "MT Components");
   end Register_Tests;

        ----------
        -- Name --
        ----------

   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format("Poverty Line unit tests.");
   end Name;

end Povline_Tests;
