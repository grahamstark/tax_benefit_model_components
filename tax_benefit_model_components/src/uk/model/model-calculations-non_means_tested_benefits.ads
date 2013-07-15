--
--  $Author: graham_s $
--  $Date: 2008-04-13 16:39:43 +0100 (Sun, 13 Apr 2008) $
--  $Revision: 4998 $
--
--
pragma License( Modified_GPL );


with Model.Parameters.Non_Means_Tested_Benefits;

package Model.Calculations.Non_Means_Tested_Benefits is

   use Model.Parameters.Non_Means_Tested_Benefits;
   
   procedure Calculate( 
      hh : Household_Rec; 
      params : Non_Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec );
        
end Model.Calculations.Non_Means_Tested_Benefits;
