with HTML_Header_Commons;
with Ada.Calendar;
with Ada.Strings.Unbounded;
with Text_Utils;
with Translate_Utils;

generic

   type Languages is (<>);

package HTML_Header_Generator is
   
   use HTML_Header_Commons;
   use Ada.Calendar;
   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   type Header_Data is tagged private;
  
   procedure Set_Title( h : in out header_Data; title : String ); 
   
   procedure Set_Language_Lookup_File_Name( filename : String );
   
   procedure Set_OG_Base_Metadata(
      title : String;
      otype : Open_Graph_Base_Type;
      image : String;
      canonical_url : String 
   );
   
   procedure Set_Address(
      street_address : String;  -- e.g., "1601 S California Ave"
      locality : String; -- e.g, "Palo Alto"
      region : String; -- e.g., "CA"
      postal_code : String; -- e.g., "94304"
      country_name : String -- e.g., "USA"
   );
   
   procedure Set_Contact_Information(
      email  : String; -- e.g., "me@example.com".
      phone_number : String; -- e.g., "+1-650-123-4567".
      fax_number : String -- e.g., "+1-415-123-4567".
   );
   
   -- video, audio
  
   procedure Add_Library( h : in out header_Data; loc : String; l_type : Library_Type );

   procedure Add_Author( h : in out header_Data; name : String ); 
  
   procedure Add_DC_Value( h : in out header_Data; dc_type : Dublin_Core_Type; value : String ); 
  
   function To_String( h : Header_Data; include_dc : Boolean; include_og : Boolean; lang : Languages ) return String;
   
begin

   
   type Header_Data is tagged record
      title : Unbounded_String;
      otype : Open_Graph_Base_Type;
      image : Unbounded_String;
      canonical_url : Unbounded_String 
      street_address : Unbounded_String := Null_Unbounded_String;  -- e.g., "1601 S California Ave"
      locality : Unbounded_String := Null_Unbounded_String; -- e.g, "Palo Alto"
      region : Unbounded_String := Null_Unbounded_String; -- e.g., "CA"
      postal_code : Unbounded_String := Null_Unbounded_String; -- e.g., "94304"
      country_name : Unbounded_String := Null_Unbounded_String -- e.g., "USA"
      
   end record;

end HTML_Header_Generator;
