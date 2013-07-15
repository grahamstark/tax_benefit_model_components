--
--  $Author: graham_s $
--  $Date: 2008-09-22 09:27:15 +0100 (Mon, 22 Sep 2008) $
--  $Revision: 5917 $
--
--
pragma License( Modified_GPL );

with Model.Household;
with Tax_Utils;

package Model.Parameters is

   use Model.Household;
   --
   -- some simple types and ops common to UK system
   --
   BASIC_ARRAY_SIZE : constant := 20;
   subtype BASIC_ARRAY_RANGE is Natural range 1 .. BASIC_ARRAY_SIZE;

   type Child_Age_Array is array(1..MAX_NUM_CHILDREN) of Child_Age;
   type Child_Amount_Array is array(1..MAX_NUM_CHILDREN) of Amount;
   type Basic_Array is array( BASIC_ARRAY_RANGE ) of Amount;
   
   -- subtype Rates_And_Bands is UK_Tax_Utils.Rates_And_Bands;
   -- subtype Limits_And_Amounts is UK_Tax_Utils.Limits_And_Amounts;
   use UK_Tax_Utils;
   
   type One_Expense is
      record
         is_flat : Boolean := False;
         amount  : Rate    := 1.0;
      end record;

   procedure Uprate( a: in out Basic_Array; n : Natural; m : Rate; next : Amount := 0.0 );
   procedure Uprate( a: in out Child_Amount_Array; n : Natural; m : Rate; next : Amount := 0.0 );
   

end Model.Parameters;
