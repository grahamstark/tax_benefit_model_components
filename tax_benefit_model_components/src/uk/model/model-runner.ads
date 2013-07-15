--
--  $Author: graham_s $
--  $Date: 2008-04-13 16:13:22 +0100 (Sun, 13 Apr 2008) $
--  $Revision: 4996 $
--
pragma License( Modified_GPL );

with Model.Parameters.Legal_Aid;   

with Model.Run_Settings;    
with Model.Calculator;
with Model.Calculator.Legal_Aid;
with Model.Household;
with Model.Output;
with Model.Parameters.Legal_Aid;

pragma Elaborate_All (factor_table);

package Model.Runner is

   use Model.Parameters.Legal_Aid;
   use Model.Run_Settings;
   
        --
        --  Retrieve a predefined system.
        --
   procedure getBaseSystem
         (settings : Model.Run_Settings.Settings_Rec;
          sys      : in out Legal_Aid_Sys;
          ctype    : in out Claim_Type);
   
   function doRun
         (newParameters : Legal_Aid_Sys;
          id            : String;
          settings      : Model.Run_Settings.Settings_Rec )
          return          Output_Tables;
   --
   --  get a model household; suitable annualised and uprated.
   --
   --
   function get_one_Model.Household
         (settings : Model.Run_Settings.Settings_Rec;
          hhref    : Integer;
          year     : Integer )
          return     Model.Household.Household_Rec;
   
   
   
   function do_one_household
         (newParameters : Legal_Aid_Sys;
          settings      : Model.Run_Settings.Settings_Rec;
          hhref         : Integer;
          year          : Integer )
          return          Model_Outputs;

end Model.Runner;
