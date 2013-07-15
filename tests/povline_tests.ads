with AUnit.Test_Cases; use AUnit.Test_Cases;

package PovLine_Tests is
   use AUnit;
   use AUnit.Test_Cases;

   type Test_Case is new AUnit.Test_Cases.Test_Case with null record;
   
   procedure Register_Tests (T : in out Test_Case);
   --  Register routines to be run
   
   function Name (T : Test_Case) return Message_String;
   --  Returns name identifying the test case
   
   --  Override if needed. Default empty implementations provided:
   
   --  Preparation performed before each routine:
   procedure Set_Up (T : in out Test_Case);


end PovLine_Tests;
