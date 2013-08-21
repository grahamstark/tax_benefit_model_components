with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

package Long_Menu is
   
   type Menu_Item is tagged private;
   type Menu_Type is tagged private;
   
   function Create( key : String; label : String; is_selectable : Boolean; is_selected : Boolean ) return Menu_Item;
   function Is_Null( item : Menu_Item ) return Boolean;
   function Label( item : Menu_Item ) return String;
   function Key( item : Menu_Item ) return String;
   function Sub_Menu( item : Menu_Item'Class ) return Menu_Type;
   procedure Set_Sub_Menu( item : in out Menu_Item'Class; submenu : Menu_Type );
   
   function Is_Selected( item : Menu_Item ) return Boolean;
   function Is_Selectable( item : Menu_Item ) return Boolean;
   procedure Set_Selected( item : in out Menu_Item );
   
   procedure Add( menu : in out Menu_Type; item : Menu_Item'Class; after : String := "" );
   procedure Add( menu : in out Menu_Type; 
      key           : String; 
      label         : String; 
      is_selectable : Boolean;
      is_selected   : Boolean := False; 
      after         : String := "" );
   procedure Insert_Sub_Menu( menu : in out Menu_Type; submenu : Menu_Type; key : String );
   
   procedure Remove( menu : in out Menu_Type; key : String );
   function Find( menu : Menu_Type; key : String ) return Menu_Item'Class;

private   
   use Ada.Strings.Unbounded;

   type Menu_Item is tagged record
      key           : Unbounded_String := Null_Unbounded_String;
      label         : Unbounded_String := Null_Unbounded_String;
      is_selected   : Boolean := False;
      is_selectable : Boolean := False;
      submenu       : access Menu_Type;
   end record;

   package Menu_Vector_Package is new Ada.Containers.Vectors( 
      Index_Type   => Positive,
      Element_Type => Menu_Item );
   
   type Menu_Type is new Menu_Vector_Package.Vector with null record;
   
end Long_Menu;
