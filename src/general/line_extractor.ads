with Ada.Strings.Unbounded;
with Ada.Calendar;

package Line_Extractor is

   use Ada.Strings.Unbounded;
   use Ada.Calendar;
   
   MISSING     : constant Unbounded_String := To_Unbounded_String( "MISSING!" );
   TERMINATOR  : constant String := ";";
   SEPARATOR   : constant String := "=";

   function Make_Key( prefix : Unbounded_String; count : Natural := 0; postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String;
   function Make_Key( prefix : String; count : Natural := 0; postfix : String  := "" ) return String;
   function Make_Key( prefix : String; k : String; postfix : String  := "" ) return String; -- fred[k].postfix
   function Make_Key( prefix : Unbounded_String; k : Unbounded_String; postfix : Unbounded_String  := Null_Unbounded_String ) return Unbounded_String; -- fred[k].postfix
   
   function Make_Key_With_Year( 
      year_prefix : Unbounded_String;
      year : Year_Number;       
      prefix : Unbounded_String; 
      count : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String;
   
   function Make_Key_With_Year(
      year_prefix : String;
      year        : Year_Number;          
      prefix      : String; 
      count       : Natural := 0; 
      postfix     : String  := "" ) return String;
      

   function Extract_Key( s : Unbounded_String ) return Unbounded_String;
   function Extract_Value( s : Unbounded_String ) return Unbounded_String;
   
   procedure Set_Delimiter( del : Character );
   function Get_Delimiter return Character;
 
   procedure Strip_Escapes( s : in out Unbounded_String );
   function Last_Character( s : Unbounded_String ) return Character;
   function Comment_Position( s : Unbounded_String ) return Natural;
   procedure Delete_After_Comment( s : in out Unbounded_String );
   
   --
   -- fred[22].joe => is_indexed_key :True, base_key: fred, index:22 postfix: joe
   -- fred.xx      => is_indexed_key: False;
   -- fred[smama].joe => is_indexed_key: False (FIX THIS?)
   --
   procedure Parse_Indexed_Key( 
      key            : in Unbounded_String;
      is_indexed_key : out Boolean;
      base_key       : out Unbounded_String;
      index          : out Natural;
      postfix        : out Unbounded_String );
   
   procedure Parse_By_Year_Indexed_Key( 
      key             : in Unbounded_String;
      year_prefix     : out Unbounded_String;
      has_year        : out Boolean;
      year            : out Year_Number;
      base_key        : out Unbounded_String;
      is_indexed_key  : out Boolean;
      index           : out Unbounded_String;
      postfix         : out Unbounded_String );
   
   procedure Parse_By_Year_Indexed_Key( 
      key             : in Unbounded_String;
      year_prefix     : out Unbounded_String;
      has_year        : out Boolean;
      year            : out Year_Number;
      base_key        : out Unbounded_String;
      is_indexed_key  : out Boolean;
      index           : out Natural;
      postfix         : out Unbounded_String );       
      
end Line_Extractor;
