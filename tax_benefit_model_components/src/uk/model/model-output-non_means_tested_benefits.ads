--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
--   
pragma License( Modified_GPL );

with Model.Parameters.Non_Means_Tested_Benefits;

package Model.Output.Non_Means_Tested_Benefits is

   use Model.Parameters.Non_Means_Tested_Benefits;

 
 
   type One_Complete_Non_Means_Tested_Output is record
      child_benefit : Amount := 0.0;
   end record;
   
   type One_Means_Tested_Intermediate_Output is record
      stuff : Amount := 0.0; -- and so on      
   end record;
   
   function To_String( res : One_Complete_Non_Means_Tested_Output ) return String;
    
   --
   --  a record with differences (2-1) in all the numeric values. The entitlement sets are xors - 
   --  so any differences between the two are included.
   --
   function Difference( res1, res2 : One_Complete_Non_Means_Tested_Output ) return One_Complete_Non_Means_Tested_Output;
   function Sum( res1, res2 : One_Complete_Non_Means_Tested_Output ) return One_Complete_Non_Means_Tested_Output;
   --
   --  a fresh output record
   --
   function New_Output return One_Complete_Non_Means_Tested_Output;

end Model.Output.Non_Means_Tested_Benefits;
