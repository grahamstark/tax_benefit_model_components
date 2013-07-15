--
--  $Author: graham_s $
--  $Date: 2013-05-26 16:51:52 +0100 (Sun, 26 May 2013) $
--  $Revision: 16137 $
--  things common between raw frs and model datasets, to cut down cross dependencies.
--
package Data_Constants is

   FIRST_AVAILABLE_DATA_YEAR : constant := 2003;
   
   LAST_AVAILABLE_DATA_YEAR : constant := 2010;
   
   subtype DATA_YEARS is Positive range FIRST_AVAILABLE_DATA_YEAR .. LAST_AVAILABLE_DATA_YEAR;
   
   type DATA_YEAR_STRINGS_ARRAY is array( DATA_YEARS ) of String( 1..4 );
   
   type Household_Count_Array is array( DATA_YEARS ) of Positive;
   
   RAW_FRS_HOUSEHOLD_COUNTS : constant Household_Count_Array := ( 
      2003 => 28_860, 
      2004 => 28_041, 
      2005 => 28_029, 
      2006 => 25_792, 
      2007 => 24_977, 
      2008 => 25_088, 
      2009 => 25_200, 
      2010 => 25_350 );
   
   DATA_YEAR_STRINGS : constant DATA_YEAR_STRINGS_ARRAY := ( 
      2003 => "0304", 
      2004 => "0405", 
      2005 => "0506", 
      2006 => "0607", 
      2007 => "0708",
      2008 => "0809",
      2009 => "0910",
      2010 => "1011");
      
   function Year_From_Data_String( data_string : String ) return Data_Years;
   
   subtype Sernum_String is String (1 .. 10);
   type Sernum_Value  is range 1 .. 10_000_000_001;
   
   MISSING_SERNUM : constant Sernum_Value := Sernum_Value'Last;

   function Format( v : Sernum_Value ) return String; 
   
end Data_Constants;

