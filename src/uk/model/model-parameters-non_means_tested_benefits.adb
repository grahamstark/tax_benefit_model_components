--
--  $Author: graham_s $
--  $Date: 2008-07-19 21:27:20 +0100 (Sat, 19 Jul 2008) $
--  $Revision: 5478 $
--
--
pragma License( Modified_GPL );

with Ada.Strings.Unbounded; 

package body Model.Parameters.Non_Means_Tested_Benefits is


   function Get_2007_8_System return Non_Means_Tested_Benefits_Sys is
      sys : Non_Means_Tested_Benefits_Sys;
   begin
      sys.child_benefit.first_child := 18.80;
      sys.child_benefit.subsequent_children := 12.55;
      return sys;
   end  Get_2007_8_System;
   
   procedure Multiply( sys : in out Non_Means_Tested_Benefits_Sys; m : Rate ) is
   begin
      sys.child_benefit.first_child := sys.child_benefit.first_child * m;
      sys.child_benefit.subsequent_children := sys.child_benefit.subsequent_children * m;
   end Multiply;
   
   procedure Uprate( sys : in out Non_Means_Tested_Benefits_Sys; m : Rate ) is
   begin
      sys.child_benefit.first_child := UK_Tax_Utils.Uprate( sys.child_benefit.first_child, m );
      sys.child_benefit.subsequent_children := UK_Tax_Utils.Uprate( sys.child_benefit.subsequent_children, m );
   end Uprate;
   
   procedure To_Annual( sys : in out Non_Means_Tested_Benefits_Sys ) is
   begin
      Multiply( sys, 52.0 );
   end To_Annual;
   
   procedure To_Weekly( sys : in out Non_Means_Tested_Benefits_Sys ) is
   begin
      Multiply( sys, 1.0/52.0 );
   end To_Weekly;

   

end Model.Parameters.Non_Means_Tested_Benefits;
