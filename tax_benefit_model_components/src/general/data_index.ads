with Ada.Containers.Ordered_Maps;

generic 

   type Unique_ID_Type is (<>);

   type Record_Components is (<>);
 
package Data_Index is
  
   type Record_Indicator is record
      start_pos : Natural := 0;
      counter   : Natural := 0;
   end record;
 
   type Component_Pointers is array ( Record_Components ) of Record_Indicator;

   type Data_Index_Rec is
      record
         SERNUM   : Unique_ID_Type := Unique_ID_Type'First;
         pointers : Component_Pointers;
      end record;

   function Compare_UID_Lt( left, right: Unique_ID_Type ) return Boolean;
   
   function Compare_Data_Index_Record_Equal( left, right: Data_Index_Rec ) return Boolean;

   package Data_Index_Map_Package is new Ada.Containers.Ordered_Maps( 
       Key_Type => Unique_ID_Type, 
       Element_Type => Data_Index_Rec, 
       "=" => Compare_Data_Index_Record_Equal,
       "<" => Compare_UID_Lt ); 
       
   subtype Data_Index_Map is Data_Index_Map_Package.Map;
   subtype Data_Index_Cursor is Data_Index_Map_Package.Cursor;

   function Get_Index( imap : Data_Index_Map; sernum : Unique_ID_Type ) return Data_Index_Rec;
   
   procedure Put_Index( imap : in out Data_Index_Map; index : Data_Index_Rec );
   
   procedure Store_Complete_Index( filename : String; imap : Data_Index_Map );
   
   procedure Restore_Complete_Index( filename : String; imap : out Data_Index_Map );
   
   procedure Dump_Index( Index_Name : String; dump_file_name : String );
end Data_Index;
