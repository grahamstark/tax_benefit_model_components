with Ada.Calendar;
with Ada.Containers.Ordered_Maps;
with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Ada.Text_io;

with GNAT.String_Split;

with Base_Model_Types;
with Data_Constants;


package Conversions.FRS is

   use Data_Constants;
   use GNAT.String_Split;
   use Base_Model_Types;
   use Ada.Strings.Unbounded;
     
   type RecordComponents is (
      adultRec,
      accountRec,
      adminRec,
      assetRec,
      benefitRec,
      benunitRec,
      careRec,
      childRec,
      childCareRec,
      endowmentRec,
      extChildRec,
      govPayRec,
      hbaiRec,
      householdRec,
      insuranceRec,
      jobRec,
      maintRec,
      mortContRec,
      mortgageRec,
      oddJobRec,
      ownerRec,
      penprovRec,
      penAmtRec,
      pensionRec,
      rentContRec,
      renterRec,
      vehicleRec);
   
   BASE_DATA_DIR      : constant String :=
      "/mnt/data/frs/";
  
      
   type ComponentPointers is array (RecordComponents) of Record_Indicator;

   type Index_Rec is
      record
         SERNUM   : Sernum_Value;
         pointers : ComponentPointers;
      end record;
      
   package Index_io is new Ada.Direct_IO( Index_Rec );
   
   function To_String( index : Index_Rec ) return String;
   
   function Read_Sernum ( file : Ada.Text_IO.File_Type ) return Sernum_String;
   
   
   function Compare_Sernums_Lt( left, right: Sernum_Value ) return Boolean;
   
   function Compare_Values_Equal( left, right: Index_Rec ) return Boolean;
  
    package FRS_Index_Package is new Ada.Containers.Ordered_Maps( 
       Key_Type => Sernum_Value, 
       Element_Type => Index_Rec, 
       "=" => Compare_Values_Equal,
       "<" => Compare_Sernums_Lt ); 
    subtype FRS_Index is FRS_Index_Package.Map;

   function Get_Index( index_map : FRS_Index; sernum : Sernum_Value ) return Index_Rec;
   
   procedure Put_Index( index_map : in out FRS_Index; index : Index_Rec );
   
   procedure Store_Complete_Index( filename : String; index_map : FRS_Index );
   
   procedure Restore_Complete_Index( filename : String; index_map : out FRS_Index );
   
   procedure Dump_Index( Index_Name : String; name : String );
   
end Conversions.FRS;
