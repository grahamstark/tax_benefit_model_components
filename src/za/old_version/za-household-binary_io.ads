with ZA_Enums;
with Base_Model_Types;
with Ada.Text_IO;

package ZA.Household.Binary_IO is

   type Family_Unit_Index_Array is array( Family_Unit_Count ) of Record_Indicator;
   
   type Household_Index is record
      reference_number : Very_Large_Positive_Type := 1;
      num_families : Family_Unit_Count := Family_Unit_Count'First;
      start_pos : Positive := 1;
      family_starts : Family_Unit_Index_Array;
   end record;
   
   function To_String( index : Household_Index ) return String;

   function Read_Household( which : Positive ) return Household_Rec;
   
   --
   -- on in, the index is the existing index from the last hh if
   -- there is one, rewritten to be the current one on out
   --
   procedure Write_Household( hh : Household_Rec; index : in out Household_Index );
   
   procedure Open_Files_For_Reading;
   
   procedure Open_Files_For_Writing;
   
   procedure Close_Files;
   
   function No_More_Households return Boolean;
   
end ZA.Household.Binary_IO;
