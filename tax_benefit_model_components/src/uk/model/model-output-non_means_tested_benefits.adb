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
package body Model.Output.Non_Means_Tested_Benefits is

   use Ada.Strings.Unbounded;  
   use Text_Utils;
   --
   --  a fresh output record
   --
   function New_Output return One_Complete_Non_Means_Tested_Output is
      diff : One_Complete_Non_Means_Tested_Output;
      
   begin
      return diff;
   end New_Output;

      
   function To_String ( res : One_Complete_Non_Means_Tested_Output ) return String is
      outs : Unbounded_String := To_Unbounded_String( "" );
   begin
      outs := outs & "child benefit: " & format( res.child_benefit ) & LINE_BREAK;
      return To_String( outs );
   end To_String;

   function To_CDA ( res : One_Complete_Non_Means_Tested_Output ) return string is
   begin
       return "";
   end To_CDA;
   

   function Difference( res1, res2 : One_Complete_Non_Means_Tested_Output ) return One_Complete_Non_Means_Tested_Output is
      diff : One_Complete_Non_Means_Tested_Output;
   begin
      diff.child_benefit := res2.child_benefit - res1.child_benefit; 
      return diff;
   end Difference;

   function Sum( res1, res2 : One_Complete_Non_Means_Tested_Output ) return One_Complete_Non_Means_Tested_Output is
      diff : One_Complete_Non_Means_Tested_Output;
   begin
      diff.child_benefit := res2.child_benefit + res1.child_benefit; 
      return diff;
   end Sum;

end Model.Output.Non_Means_Tested_Benefits;
