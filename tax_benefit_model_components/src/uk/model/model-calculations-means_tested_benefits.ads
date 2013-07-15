--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
pragma License( Modified_GPL );


with Model.Output.Means_Tested_Benefits; 
with Model.Parameters.Means_Tested_Benefits;


package Model.Calculations.Means_Tested_Benefits is

   use Model.Parameters.Means_Tested_Benefits;
   
   procedure Calculate( 
      hh : Household_Rec; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec );
      
--
-- below only for Unit testing
--
   function Find_Entitled_Premia( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      which_benefit : Means_Tested_Benefit_Types ) return Premia_Set;
      
   function Calculate_Premia_Value( 
      values : Premia_Array;  
      premiums : Premia_Set ) return Amount;
   
   function Calculate_Allowance_Value( 
      bu : Model_Benefit_Unit; 
      allowances : Personal_Allowances_Array; 
      entitled_allowances :  Personal_Allowances_Set ) return Amount;
   
   function Is_Entitled_To_Pension_Credit( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys ) return Boolean;
   
   procedure Calculate_Pension_Credit( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec );
      
   function Is_Entitled_To_Child_Tax_Credit( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys ) return Boolean;
   
   procedure Calculate_Child_Tax_Credit( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec );
      
   function Is_Entitled_To_Income_Support( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys ) return Boolean; 
   
   procedure Calculate_Income_Support( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec );
      
   procedure Calculate_Housing_Benefit(  
      hh : Household_Rec; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec );   
   
   procedure Calculate_Local_Tax_Benefit(  
      hh : Household_Rec; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec ); 

        
end Model.Calculations.Means_Tested_Benefits;
