--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
-- 
-- Root of the calculation modules. Include as little in here as possible
-- 
pragma License( Modified_GPL );

with Model.Household; 
with Model.Parameters;
with Model.Incomes;
with FRS_Enums;
with Model.Output.Complete;
with Model.Run_Settings;

package Model.Calculations is

   use Model.Household;
   use Model.Parameters;
   use Model.Incomes;
   use Model.Output.Complete;
   use FRS_Enums;
   
   package settings renames Model.Run_Settings;

   
   --  handle a single expense or allowance
   --  val - expense amount
   --  exp - this proportion eligible (0-1.0), or maximum value (0- inf)
   --       and boolean is_flat: allow a percentage or FLAT - allow up to prop as a maximum
   function Expenses_Op (val : Amount; exp : One_Expense) return Amount;

   --
   --   children array of Household_Rec.child objects
   --   bands - age bands
   --
   function Calc_Child_Allowances
               ( benunit : Model.Household.Model_Benefit_Unit;
                 bands   : Child_Age_Array;
                 rates   : Child_Amount_Array ) return Amount;
        
end Model.Calculations;
