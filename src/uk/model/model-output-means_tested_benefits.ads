--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
--   
with Model.Parameters.Means_Tested_Benefits;

package Model.Output.Means_Tested_Benefits is

   use Model.Parameters.Means_Tested_Benefits;

   type One_Means_Tested_Result is record
      applicable_amount   : Amount := 0.0;
      due                 : Amount := 0.0;
      entitled_prems      : Premia_Set;
      entitled_allowances : Personal_Allowances_Set;
   end record;
   
   type One_Child_Tax_Credit_Result is record
      applicable_amount   : Amount := 0.0;
      due                 : Amount := 0.0;
      entitled_elements   : Child_Tax_Credit_Set;
   end record;
   
   type One_Pension_Credit_Result is record
      applicable_amount   : Amount := 0.0;
      due                 : Amount := 0.0;
      entitled_elements   : Pension_Credit_Set;
      entitled_prems      : Premia_Set;
   end record;
 
   type One_Complete_Means_Tested_Output is record
      overall           : One_Means_Tested_Result;
      child_tax_credit  : One_Child_Tax_Credit_Result;
      housing_benefit   : One_Means_Tested_Result;
      income_support    : One_Means_Tested_Result;
      local_tax_benefit : One_Means_Tested_Result;
      pension_credit    : One_Pension_Credit_Result;
   end record;
   
   type One_Means_Tested_Intermediate_Output is record
      stuff : Amount := 0.0; -- and so on      
   end record;
   
   function To_String( res : One_Complete_Means_Tested_Output ) return String;
   function To_String( res : One_Means_Tested_Result ) return String;
   function To_String( res : One_Child_Tax_Credit_Result ) return String;
   function To_String( res : One_Pension_Credit_Result ) return String;
    
   --
   --  a record with differences (2-1) in all the numeric values. The entitlement sets are xors - 
   --  so any differences between the two are included.
   --
   function Difference( res1, res2 : One_Complete_Means_Tested_Output ) return One_Complete_Means_Tested_Output;
   function Difference( res1, res2 : One_Child_Tax_Credit_Result ) return One_Child_Tax_Credit_Result;
   function Difference( res1, res2 : One_Pension_Credit_Result ) return One_Pension_Credit_Result;
   function Difference( res1, res2 : One_Means_Tested_Result ) return One_Means_Tested_Result;
   
   function Sum( res1, res2 : One_Complete_Means_Tested_Output ) return One_Complete_Means_Tested_Output;
   function Sum( res1, res2 : One_Child_Tax_Credit_Result ) return One_Child_Tax_Credit_Result;
   function Sum( res1, res2 : One_Pension_Credit_Result ) return One_Pension_Credit_Result;
   function Sum( res1, res2 : One_Means_Tested_Result ) return One_Means_Tested_Result;
   --
   --  a fresh output record
   --
   function New_Output return One_Complete_Means_Tested_Output;
   
   -- function To_String ( res : One_Complete_Means_Tested_Output ) return String;
   
   -- function to_CDA ( res : One_Complete_Means_Tested_Output ) return String;

end Model.Output.Means_Tested_Benefits;
