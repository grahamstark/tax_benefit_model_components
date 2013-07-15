--
--  $Author: graham_s $
--  $Date: 2008-04-29 09:28:46 +0100 (Tue, 29 Apr 2008) $
--  $Revision: 5132 $
--
--

pragma License( Modified_GPL );

with Model.Calculations.Means_Tested_Benefits;
with Model.Calculations.Non_Means_Tested_Benefits;
with Model.Calculations.Legal_Aid;


package body Model.Calculations.Complete is

   package non_mt renames Model.Calculations.Non_Means_Tested_Benefits;
   package mt renames Model.Calculations.Means_Tested_Benefits;
   package legal renames Model.Calculations.Legal_Aid;

   function Calculate( 
      hh : Household_Rec; 
      params : comp_params.Parameters; 
      run_settings : settings.Settings_Rec ) return comp_outs.Household_Result is      
      res : comp_outs.Household_Result := comp_outs.New_Output;      
   begin
      
      non_mt.Calculate( hh, params.non_means_tested, res, run_settings );
      mt.Calculate( hh, params.means_tested, res, run_settings );
      legal.Calculate( hh, params.legal_aid, res, run_settings );
      comp_outs.Accumulate( hh, res );
      
      return res;
      
   end Calculate;
   
end Model.Calculations.Complete;
