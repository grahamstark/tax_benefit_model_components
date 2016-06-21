with AUnit.Test_Cases; 
with AUnit; 

package Model.Calculator.Direct_Tax.Tests is

   use AUnit;
   use AUnit.Test_Cases;
 
   type Test_Case is new AUnit.Test_Cases.Test_Case with null record;
   
   procedure Register_Tests( t : in out Test_Case );
   --  Register routines to be run
   
   function Name( t : Test_Case ) return Message_String;
   --  Returns name identifying the test case
   
   --  Override if needed. Default empty implementations provided:
   
   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case );


end Model.Calculator.Direct_Tax.Tests;
