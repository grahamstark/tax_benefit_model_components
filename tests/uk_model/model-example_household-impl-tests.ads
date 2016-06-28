with AUnit.Test_Cases; 
with AUnit;

package Model.Example_Household.Impl.Tests is

   use AUnit.Test_Cases;
   use AUnit;
   
   type Test_Case is new AUnit.Test_Cases.Test_Case with null record;
   
   procedure Register_Tests (T : in out Test_Case);
   --  Register routines to be run
   
   function Name (T : Test_Case) return Message_String;
   --  Returns name identifying the test case
   


end Model.Example_Household.Impl.Tests;