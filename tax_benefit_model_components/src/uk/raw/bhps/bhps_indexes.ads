with Ada.Calendar;
with Ada.Containers.Ordered_Maps;
with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Ada.Text_io;

with Data_Index;

with GNAT.String_Split;

with Base_Model_Types;
with Data_Constants;

--
-- FIXME make this a generic package
--

package BHPS_Indexes is

   use Data_Constants;
   use GNAT.String_Split;
   use Base_Model_Types;
   use Ada.Strings.Unbounded;

   subtype Waves is Character range 'a'  ..  'z';
   subtype Waves_With_Data is Waves range 'a' .. 'r';
     
   type Record_Components is (
      egoalt_component,
      hhresp_component,
      hhsamp_component,
      income_component,
      indall_component,
      indresp_component,
      jobhist_component,
      childad_component,
      childnt_component,
      cohabit_component,
      indsamp_component,
      lifemst_component,
      marriag_component,
      lifejob_component,
      youth_component,
      child_component,
      jobhstd_component
   );
   
   type X_Record_Components is (
      xivdata_component,
      xwavedat_component,
      xwaveid_component,
      xwlsten_component );
      
   --
   -- noe that hhid will be the main index 
   --
   type Sernum_Value is range -9 .. 1_000_000_000; -- the variable 'gechphid' has -8s sometimes for missing values
   MISSING_SERNUM : constant Sernum_Value := Sernum_Value'First;

   package X_BHPS_Index_Package is new Data_Index( Record_Components => X_Record_Components, Unique_ID_Type=>Sernum_Value );
   package BHPS_Index_Package is new Data_Index( Record_Components => Record_Components, Unique_ID_Type=>Sernum_Value );
   
   package BHPS_Map_Package renames BHPS_Index_Package.Data_Index_Map_Package;
   package X_BHPS_Map_Package renames X_BHPS_Index_Package.Data_Index_Map_Package;
   
   subtype BHPS_Index is BHPS_Index_Package.Data_Index_Map;
   type BHPS_Index_Array is array( Waves_With_Data ) of BHPS_Index;
   
   subtype X_BHPS_Index is X_BHPS_Index_Package.Data_Index_Map;
   subtype Index_Rec is BHPS_Index_Package.Data_Index_Rec;
   subtype X_Index_Rec is X_BHPS_Index_Package.Data_Index_Rec;
   subtype X_Index_Cursor is X_BHPS_Index_Package.Data_Index_Cursor;
   subtype Index_Cursor is BHPS_Index_Package.Data_Index_Cursor;
   
   function Read_Sernum ( file : Ada.Text_IO.File_Type ) return Sernum_String;
   procedure Restore_All_Indexes( directory : String; indexes : out BHPS_Index_Array );
   
end BHPS_Indexes;
