--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
pragma License( Modified_GPL );

package body Model.Parameters is
   
   procedure Uprate( a: in out Basic_Array; n : Natural; m : Rate; next : Amount := 0.0 ) is
   begin
      for i in 1 .. n loop
         a(i) := UK_Tax_Utils.Uprate( a(i), m, next );
      end loop;
   end Uprate;
   
   procedure Uprate( a: in out Child_Amount_Array; n : Natural; m : Rate; next : Amount := 0.0 ) is
   begin
      for i in 1 .. n loop
         a(i) := UK_Tax_Utils.Uprate( a(i), m, next );
      end loop;
   end Uprate;

end Model.Parameters;
