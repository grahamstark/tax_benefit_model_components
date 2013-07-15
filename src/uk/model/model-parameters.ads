--
--  $Author: graham_s $
--  $Date: 2012-08-23 19:40:48 +0100 (Thu, 23 Aug 2012) $
--  $Revision: 15270 $
--
--
pragma License( Modified_GPL );

with Tax_Utils;

generic
   
   type Incomes_Type is ( <> );
   type Expenses_Type is ( <> );
   
   MAX_NUM_CHILDREN : Natural; 
   
   BASIC_ARRAY_SIZE : Natural;
   
package Model.Parameters is

   subtype BASIC_ARRAY_RANGE is Natural range 1 .. BASIC_ARRAY_SIZE;

   type Child_Age_Array is array( 1..MAX_NUM_CHILDREN ) of Child_Age;
   type Child_Amount_Array is array( 1..MAX_NUM_CHILDREN ) of Amount;
   type Basic_Array is array( BASIC_ARRAY_RANGE ) of Amount;
   type Incomes_List is array( Incomes_Type ) of Amount;
   
   -- subtype Rates_And_Bands is UK_Tax_Utils.Rates_And_Bands;
   -- subtype Limits_And_Amounts is UK_Tax_Utils.Limits_And_Amounts;
   use UK_Tax_Utils;
   
   type One_Expense is
      record
         is_flat : Boolean := False;
         amount  : Rate    := 1.0;
      end record;
      
   type Expenses_List is array( Expenses_Type ) of Expenses_Type;

   procedure Uprate( a: in out Basic_Array; n : Natural; m : Rate; next : Amount := 0.0 );
   procedure Uprate( a: in out Child_Amount_Array; n : Natural; m : Rate; next : Amount := 0.0 );
   

end Model.Parameters;
