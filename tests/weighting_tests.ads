with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with AUnit;

with AUnit.Test_Cases; 

package Weighting_Tests is
   
   use AUnit;
   use AUnit.Test_Cases;
   
   type Test_Case is new AUnit.Test_Cases.Test_Case with null record;
   
   procedure Register_Tests( t : in out Test_Case );
   --  Register routines to be run
   
   function Name( t : Test_Case ) return Message_String;
   --  Returns name identifying the test case
   
   --  Override if needed. Default empty implementations provided:
   
   --  Preparation performed before each routine:
   procedure Set_Up (T : in out Test_Case);


end Weighting_Tests;
