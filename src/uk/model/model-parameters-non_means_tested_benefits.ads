--
--  $Author: graham_s $
--  $Date: 2012-08-23 19:40:48 +0100 (Thu, 23 Aug 2012) $
--  $Revision: 15270 $
--
--
--
-- FIXME: this needs massively expanded
--
--
pragma License( Modified_GPL );

with Ada.Containers.Ordered_Sets;
with T_Utils;

generic
   
package Model.Parameters.Non_Means_Tested_Benefits is

   type Child_Benefit_Sys is record
      first_child         : Amount;
      subsequent_children : Amount;
   end record;
   
   type Non_Means_Tested_Benefits_Sys is record
      child_benefit : Child_Benefit_Sys;
   end record;
   
   function Get_2007_8_System return Non_Means_Tested_Benefits_Sys;

   procedure Uprate( sys : in out Non_Means_Tested_Benefits_Sys; m : Rate );
   
   procedure To_Annual( sys : in out Non_Means_Tested_Benefits_Sys );
   
   procedure To_Weekly( sys : in out Non_Means_Tested_Benefits_Sys );


end Model.Parameters.Non_Means_Tested_Benefits;
