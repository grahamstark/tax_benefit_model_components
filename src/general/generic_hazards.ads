with Base_Model_Types;
with Ada.Calendar;

generic
   type Values_Range is (<>);
package Generic_Hazards is
   
   use Base_Model_Types;
   use Ada.Calendar;
   
   type Table_Type is array( Values_Range, Values_Range ) of Amount;
   
   type  Abs_Table_Type_Array is array( Year_Number range <> ) of Table_Type; 
   
   function To_Hazards( tab : in out Table_Type ) return Table_Type;
   
   function To_String( tab : Table_Type ) return String;
   
end Generic_Hazards;
   
