pragma License( Modified_GPL );

with Text_Utils;
with Ada.Strings.Unbounded;
with Ada.Containers;
with Ada.Containers.Vectors;
with Ada.Containers.Hashed_Maps;

package Keyed_Buffer is

   type Buffer is tagged private;
   
   --
   -- intitialise a row
   --
   procedure Initialise_Row( buff : in out Buffer; key : String; value : String );
   
   --
   -- insert at the given position; if col = 0, append
   --
   procedure Insert( buff : in out Buffer; key : String; col : Natural; value : String );

   function Has_Non_Blank( buff : Buffer; key : String; start_col : Positive := 2 ) return Boolean;
   function Changes_Value( buff : Buffer; key : String; start_col : Positive := 2 ) return Boolean;
   
   function To_String( 
      buff     : in out Buffer; 
      enclose  : String := "";
      delim    : String := "," ) return String;
      
private   

   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   package String_List_Package is new Ada.Containers.Hashed_Maps(
       Key_Type        => Unbounded_String, 
       Element_Type    => Unbounded_String_List,
       Hash            => Hash_String,
       Equivalent_Keys => "=" );

   
   subtype String_List_Map is String_List_Package.Map; 
       
   type Buffer is tagged record   
      order : Unbounded_String_List; 
      data  : String_List_Map;
   end record;

   
end Keyed_Buffer;
