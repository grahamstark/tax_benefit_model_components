--
--  $Author: graham_s $
--  $Date: 2008-04-29 09:28:46 +0100 (Tue, 29 Apr 2008) $
--  $Revision: 5132 $
--
--
pragma License( Modified_GPL );


with Model.Output.Complete;
with Model.Parameters.Complete;


package Model.Calculations.Complete is

   package comp_outs renames Model.Output.Complete;
   package comp_params renames Model.Parameters.Complete;
   
     
   function Calculate( 
      hh : Household_Rec; 
      params : comp_params.Parameters; 
       
      run_settings : settings.Settings_Rec ) return comp_outs.Household_Result;
   
   
end Model.Calculations.Complete;
