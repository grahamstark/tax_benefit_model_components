--
--  $Author: graham_s $
--  $Date: 2008-04-13 21:06:20 +0100 (Sun, 13 Apr 2008) $
--  $Revision: 4999 $
--
with Model.Household;        
with Model.Incomes;
with base_model_types; use base_model_types;

package test_households is

   use Model.Household;
   use Model.Incomes;

   MAX_TEST_HOUSEHOLDS : constant := 5;
   
   type Test_Household_Array is array ( 1 .. MAX_TEST_HOUSEHOLDS ) of Household_Rec;
   
   function makeSomeExpenses return Expenses_Array;
   
   function makeSomeFinances return Finance_Array;
   
   function makeExampleHouseholds return Test_Household_Array;
   
   --
   --  households from equivilisation examples from cmd 6678 pp 28-9
   --
   function make_Equiv_Example_Households return Test_Household_Array;
   
   --
   --  households from examples from cmd 6678 pp 7-8
   --
   function make_Criminal_Households return Test_Household_Array;
   
   
   function rentHcosts return Model_Housing_Costs;

end test_households;
