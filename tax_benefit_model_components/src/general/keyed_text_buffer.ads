with Ada.Strings.Unbounded;
with Text_Utils;

package Keyed_Text_Buffer is

   use Ada.Strings.Unbounded;
   
   subtype Text_Buffer is Text_Utils.Unbounded_String_Map; 
   
   type Load_Type is ( single_line_delimited, multiline );
   
   function Load( filename : String; which_load : Load_Type ) return Text_Buffer;
   
   function Parse( data : String; sep : Character ) return Text_Buffer;
   function Parse( data : Unbounded_String; sep : Character ) return Text_Buffer;

   function Get( this_buffer : Text_Buffer; key : String ) return String;
   function Get( this_buffer : Text_Buffer; key : Unbounded_String ) return Unbounded_String;
   
   procedure Merge( to : in out Text_Buffer; to_add : Text_Buffer );
  
end Keyed_Text_Buffer;
