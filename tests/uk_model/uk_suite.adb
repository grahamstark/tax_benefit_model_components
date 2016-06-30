--
-- Created by ada_generator.py on 2014-10-31 08:50:07.050126
-- 
with AUnit.Test_Suites; 
with Ada.Text_IO;
with Text_Utils;
with GNAT.Command_Line;
with Base_Model_Types;
with Model.Example_Household.Impl.Tests;
with Model.Example_Results.Impl.Tests;

use AUnit.Test_Suites;
use GNAT.Command_Line;
use Ada.Text_IO;
use Text_Utils;
use Base_Model_Types;
--
-- This is the top-level driver for the model's unit test suite.
-- Each of the main components of the model has a child test package 
-- and this starts them up depending on the contents of the command line 
--
function UK_Suite return Access_Test_Suite is

   HELP_MESSAGE : constant String :=
      " driver for test suite. Use: " & LINE_BREAK &
      " i => HH Impl Tests "  & LINE_BREAK;

   result : Access_Test_Suite := new Test_Suite;

begin
   loop
      case Getopt ("h i") is
      when ASCII.NUL => exit;
          -- when 's' =>
      when 'h' =>
         Put_Line( HELP_MESSAGE );
      when 'i' =>
         Add_Test( result, new Model.Example_Household.Impl.Tests.Test_Case );
      when 'i' =>
         Add_Test( result, new Model.Example_Results.Impl.Tests.Test_Case );
      when others =>
         raise Program_Error;         -- cannot occur!
      end case;
   end loop;   
   return result;
end UK_Suite;