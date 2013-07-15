--
--  $Author: graham_s $
--  $Date: 2008-11-13 23:23:48 +0000 (Thu, 13 Nov 2008) $
--  $Revision: 6179 $
--  things common between raw frs and model datasets, to cut down cross dependencies.
--
package Data_Constants is

   FIRST_AVAILABLE_DATA_YEAR : constant := 2003;
   
   LAST_AVAILABLE_DATA_YEAR : constant := 2005;
   
   subtype DATA_YEARS is Positive range FIRST_AVAILABLE_DATA_YEAR .. LAST_AVAILABLE_DATA_YEAR;
   
   type DATA_YEAR_STRINGS_ARRAY is array( DATA_YEARS ) of String( 1..4 );
   
   type Household_Count_Array is array( DATA_YEARS ) of Positive;
   RAW_FRS_HOUSEHOLD_COUNTS : constant Household_Count_Array := ( 2003=>28_861, 2004=>28_042, 2005=> 28_030 );
   
   DATA_YEAR_STRINGS : constant DATA_YEAR_STRINGS_ARRAY := ( 2003=>"0304", 2004=>"0405", 2005=>"0506" );
   
   subtype Sernum_String is String (1 .. 10);
   type Sernum_Value  is range 100_000_000 .. 10_000_000_001;
   
   MISSING_SERNUM : constant Sernum_Value := Sernum_Value'Last;

   function Format( v : Sernum_Value ) return String; 
   
end Data_Constants;

