--
--  $Author: graham_s $
--  $Date: 2008-04-20 17:40:42 +0100 (Sun, 20 Apr 2008) $
--  $Revision: 5042 $
--
--
pragma License( Modified_GPL );

with Model.Parameters.Means_Tested_Benefits;
with Model.Parameters.Non_Means_Tested_Benefits;
with Model.Parameters.Legal_Aid;

package Model.Parameters.Complete is

   use Model.Parameters.Legal_Aid;
   use Model.Parameters.Means_Tested_Benefits;
   use Model.Parameters.Non_Means_Tested_Benefits;
   
   type Parameters is record
      legal_aid        : Legal_Aid_Sys;
      means_tested     : Means_Tested_Benefits_Sys;
      non_means_tested : Non_Means_Tested_Benefits_Sys;
   end record;

   procedure Uprate( params : in out Parameters; m : Rate );
   
   function Get_2007_8_System return Parameters;
   
   function Get_Default_System return Parameters renames Get_2007_8_System;
   
   procedure To_Annual( params : in out Parameters );
   
   procedure To_Weekly( params : in out Parameters );


end Model.Parameters.Complete;
