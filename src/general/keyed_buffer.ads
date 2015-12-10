pragma License( Modified_GPL );

with Text_Utils;
with Ada.Strings.Unbounded;
with Ada.Containers;
with Ada.Containers.Vectors;
with Ada.Containers.Hashed_Maps;

package Keyed_Buffer is

   type Buffer is tagged private;
   
   procedure Insert( buff : in out Buffer; key : String; value : String );
   procedure Append( buff : in out Buffer; key : String; value : String );
   procedure Print( 
      buff     : in out Buffer; 
      filename : String; 
      delim    : String := ","; 
      append   : Boolean := False );
   
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
