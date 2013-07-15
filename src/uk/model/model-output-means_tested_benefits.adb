--
--  $Author: graham_s $
--  $Date: 2008-04-27 12:32:03 +0100 (Sun, 27 Apr 2008) $
--  $Revision: 5113 $
--
pragma License( Modified_GPL );

with base_model_types; use base_model_types;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;
with Text_Utils;
--
--
--
package body Model.Output.Means_Tested_Benefits is
    
   --
   --  a fresh output record
   --
   function New_Output return One_Complete_Means_Tested_Output is
      diff : One_Complete_Means_Tested_Output;
      
   begin
      return diff;
   end New_Output;

   function To_String ( res : One_Means_Tested_Result ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
   
      outs : Unbounded_String := To_Unbounded_String( "" ); 
   begin
      outs := outs & "applicable amount: " & format( res.applicable_amount ) & LINE_BREAK;
      outs := outs & "amount due: " & format( res.due ) & LINE_BREAK;
      outs := outs & "entitled premia: " & Premia_Package.To_String( res.entitled_prems ) & LINE_BREAK;
      outs := outs & "entitled allowances: " & Personal_Allowances_Package.To_String( res.entitled_allowances ) & LINE_BREAK;
      return To_String( outs );
   end To_String;

   function To_String ( res : One_Pension_Credit_Result  ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
   
      outs : Unbounded_String := To_Unbounded_String( "" ); 
   begin
      outs := outs & "applicable amount: " & format( res.applicable_amount ) & LINE_BREAK;
      outs := outs & "amount due: " & format( res.due ) & LINE_BREAK;
      outs := outs & "entitled elements: " & Pension_Credit_Package.To_String( res.entitled_elements ) & LINE_BREAK;
      outs := outs & "entitled premia: " & Premia_Package.To_String( res.entitled_prems ) & LINE_BREAK;
      return To_String( outs );
   end To_String;

   function To_String ( res : One_Child_Tax_Credit_Result  ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
 
      outs : Unbounded_String := To_Unbounded_String( "" ); 
   begin
      outs := outs & "applicable amount: " & format( res.applicable_amount ) & LINE_BREAK;
      outs := outs & "amount due: " & format( res.due ) & LINE_BREAK;
      outs := outs & "entitled elements: " & Child_Tax_Credit_Package.To_String( res.entitled_elements ) & LINE_BREAK;
      return To_String( outs );
   end To_String;
   
   function To_String ( res : One_Complete_Means_Tested_Output ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
     
      outs : Unbounded_String := To_Unbounded_String( "" ); 
   begin
      outs := outs & "Overall "& LINE_BREAK & To_String( res.overall ) & LINE_BREAK;
      outs := outs & "Child Tax Credit "& LINE_BREAK & To_String( res.child_tax_credit ) & LINE_BREAK;
      outs := outs & "Housing Benefit "& LINE_BREAK & To_String( res.housing_benefit ) & LINE_BREAK;
      outs := outs & "Income Support "& LINE_BREAK & To_String( res.income_support ) & LINE_BREAK;
      outs := outs & "Local Tax Benefit "& LINE_BREAK & To_String( res.local_tax_benefit ) & LINE_BREAK;
      outs := outs & "Pension Credit "& LINE_BREAK & To_String( res.pension_credit ) & LINE_BREAK;
      return To_String( outs );
   end To_String;

   function To_CDA ( res : One_Complete_Means_Tested_Output ) return string is
   begin
       return "";
   end To_CDA;
   
   function Difference( res1, res2 : One_Means_Tested_Result ) return One_Means_Tested_Result is
   use Personal_Allowances_Package.Set_Ops;
   use Premia_Package.Set_Ops;
      diff : One_Means_Tested_Result;
   begin
      diff.applicable_amount := res2.applicable_amount - res1.applicable_amount;
      diff.due := res2.due - res1.due;
      diff.entitled_allowances := res2.entitled_allowances xor res1.entitled_allowances;
      diff.entitled_prems := res2.entitled_prems xor res1.entitled_prems;
      return diff;
   end Difference;
   
   function Difference( res1, res2 : One_Child_Tax_Credit_Result ) return One_Child_Tax_Credit_Result  is
   use Child_Tax_Credit_Package.Set_Ops;
      diff : One_Child_Tax_Credit_Result;
   begin
      diff.applicable_amount := res2.applicable_amount - res1.applicable_amount;
      diff.due := res2.due - res1.due;
      diff.entitled_elements := res2.entitled_elements xor res1.entitled_elements;
      return diff;
   end Difference;
   
   function Difference( res1, res2 : One_Pension_Credit_Result ) return One_Pension_Credit_Result  is
   use Pension_Credit_Package.Set_Ops;
   use Premia_Package.Set_Ops;
      diff : One_Pension_Credit_Result;
   begin
      diff.applicable_amount := res2.applicable_amount - res1.applicable_amount;
      diff.due := res2.due - res1.due;
      diff.entitled_elements := res2.entitled_elements xor res1.entitled_elements;
      diff.entitled_prems := res2.entitled_prems xor res1.entitled_prems;
      return diff;
   end Difference;
   

   function Difference( res1, res2 : One_Complete_Means_Tested_Output ) return One_Complete_Means_Tested_Output is
      diff : One_Complete_Means_Tested_Output;
   begin
      diff.overall := Difference( res1.overall, res2.overall );
      diff.child_tax_credit := Difference( res1.child_tax_credit, res2.child_tax_credit );
      diff.housing_benefit := Difference( res1.housing_benefit, res2.housing_benefit );
      diff.income_support := Difference( res1.income_support, res2.income_support );
      diff.local_tax_benefit := Difference( res1.local_tax_benefit, res2.local_tax_benefit );
      diff.pension_credit := Difference( res1.pension_credit, res2.pension_credit );
      return diff;
   end Difference;

   function Sum( res1, res2 : One_Means_Tested_Result ) return One_Means_Tested_Result is
   use Personal_Allowances_Package.Set_Ops;
   use Premia_Package.Set_Ops;
      diff : One_Means_Tested_Result;
   begin
      diff.applicable_amount := res2.applicable_amount + res1.applicable_amount;
      diff.due := res2.due + res1.due;
      diff.entitled_allowances := res2.entitled_allowances or res1.entitled_allowances;
      diff.entitled_prems := res2.entitled_prems or res1.entitled_prems;
      return diff;
   end Sum;
   
   function Sum( res1, res2 : One_Child_Tax_Credit_Result ) return One_Child_Tax_Credit_Result  is
   use Child_Tax_Credit_Package.Set_Ops;
      diff : One_Child_Tax_Credit_Result;
   begin
      diff.applicable_amount := res2.applicable_amount + res1.applicable_amount;
      diff.due := res2.due + res1.due;
      diff.entitled_elements := res2.entitled_elements or res1.entitled_elements;
      return diff;
   end Sum;
   
   function Sum( res1, res2 : One_Pension_Credit_Result ) return One_Pension_Credit_Result  is
   use Pension_Credit_Package.Set_Ops;
   use Premia_Package.Set_Ops;
      diff : One_Pension_Credit_Result;
   begin
      diff.applicable_amount := res2.applicable_amount + res1.applicable_amount;
      diff.due := res2.due + res1.due;
      diff.entitled_elements := res2.entitled_elements or res1.entitled_elements;
      diff.entitled_prems := res2.entitled_prems or res1.entitled_prems;
      return diff;
   end Sum;
   

   function Sum( res1, res2 : One_Complete_Means_Tested_Output ) return One_Complete_Means_Tested_Output is
      diff : One_Complete_Means_Tested_Output;
   begin
      diff.overall := Sum( res1.overall, res2.overall );
      diff.child_tax_credit := Sum( res1.child_tax_credit, res2.child_tax_credit );
      diff.housing_benefit := Sum( res1.housing_benefit, res2.housing_benefit );
      diff.income_support := Sum( res1.income_support, res2.income_support );
      diff.local_tax_benefit := Sum( res1.local_tax_benefit, res2.local_tax_benefit );
      diff.pension_credit := Sum( res1.pension_credit, res2.pension_credit );
      return diff;
   end Sum;

end Model.Output.Means_Tested_Benefits;
