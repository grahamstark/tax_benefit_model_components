--
--  $Author: graham_s $
--  $Date: 2008-12-16 15:42:13 +0000 (Tue, 16 Dec 2008) $
--  $Revision: 6486 $
--
--
-- 

pragma License( Modified_GPL );

with Ada.Containers.Vectors;

with FRS_Enums;
with Model.Incomes;
with Model.Household;
with Model.Parameters.Complete;
with Model.Output.Complete;
with Model.Run_Settings;
with Data_Constants;
with Model.Income_Measure_Types;

package Model.Income_Measures is

   use Model.Income_Measure_Types;

   package settings renames  Model.Run_Settings;
   use Model.Parameters.Complete;
   use Model.Output.Complete;
   use Model.Household;
   use FRS_Enums;
   
   --
   --
   function Is_On_Income_Support( bu : Model_Benefit_Unit ) return Boolean; 
   -- function to_CDA ( res : One_Complete_Means_Tested_Output ) return String;
   
   procedure Calculate_Income_Measures(
      hh              : Household_Rec; 
      results         : Household_Result;
      income_measures : in out Household_Incomes_Result;
      run_settings    : settings.Settings_Rec; 
      grossing_factor : Amount ); 
   
   
   procedure Add_Observation( outp : in One_Complete_Income_Measure_Output; obs : in out Income_Measure_List.Vector );
   

end Model.Income_Measures;
