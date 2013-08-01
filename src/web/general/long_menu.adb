package body Long_Menu is
   
   function Create( key : String; label : String; is_selected : Boolean ) return Menu_Item is
      m : Menu_Item;
   begin
      m.key := To_Unbounded_String( key );
      m.label := To_Unbounded_String( label );
      m.is_selected := is_selected;
      return m;
   end Create;
   
   function Sub_Menu( item : Menu_Item'Class ) return Menu_Type is
   begin
      return item.submenu.all;
   end Sub_Menu;
   
   procedure Set_Sub_Menu( item : in out Menu_Item'Class; submenu : Menu_Type ) is
   begin
      item.submenu.all := submenu;
   end Set_Sub_Menu;
   
   function Is_Null( item : Menu_Item ) return Boolean is
   begin
      return item.key = Null_Unbounded_String and
             item.label = Null_Unbounded_String and
             item.is_selected = False;
   end Is_Null;
   
   function Label( item : Menu_Item ) return String is
   begin
      return To_String( item.label );      
   end Label;
   function Key( item : Menu_Item ) return String is
   begin
      return To_String( item.key );      
   end Key;
   
   function Is_Selected( item : Menu_Item ) return Boolean is
   begin
      return item.is_selected;
   end Is_Selected;
   
   procedure Set_Selected( item : in out Menu_Item ) is
   begin
      item.is_selected := True;
   end Set_Selected;
   
   use Menu_Vector_Package;
   
   function Find( menu : Menu_Type; key : String ) return Natural is
      f : Natural := 0;
      ks : Unbounded_String := To_Unbounded_String( key );
   begin
      for i in 1 .. Natural( Menu.Length ) loop
         if menu.Element( i ).key = ks then
            return i;
         end if;
      end loop;
      return 0;
   end Find;
   
   procedure Clear_Selected_Flag( item : in out Menu_Item ) is
   begin
      item.is_selected := False;
   end Clear_Selected_Flag;
  
   procedure Add( menu : in out Menu_Type; item : Menu_Item'Class; after : String := "" ) is

      procedure Clear_Selected( c : Cursor ) is
         item : Menu_Item := Element( c );
      begin
         menu.Update_Element( c, Clear_Selected_Flag'Access );
      end Clear_Selected;
      
      mi : Menu_Item := Menu_Item( item );
      
   begin
      if item.is_selected then
         menu.Iterate( Clear_Selected'Access );
      end if;
      if( after = "" )then
         menu.Append( mi );   
      else
         declare
            f : Natural := Find( menu, after );
         begin
            if( f = 0 )then
               menu.append( mi );
            else
               menu.Insert( f + 1, mi );  -- since it's before
            end if;
         end;          
      end if;
   end Add;
   
   procedure Add( menu : in out Menu_Type; 
      key         : String; 
      label       : String; 
      is_selected : Boolean := False; 
      after       : String := "" ) is
      item : Menu_Item := Create( key, label, is_selected );
   begin
      menu.Add( item, after );
   end Add;
   
   procedure Remove( menu : in out Menu_Type; key : String ) is
      p : Natural := Find( menu, key );
   begin
      if p > 0 then
         menu.Delete( p );
      end if;
   end Remove;
   
   function Find( menu : Menu_Type; key : String ) return Menu_Item'Class is
      p : Natural := Find( menu, key );
      i : Menu_Item;
   begin
      if p > 0 then
         return menu.Element( p );
      end if;
      return i;
   end Find;
   
   function Num_Items( menu : Menu_Type ) return Natural is
   begin
      return Natural( menu.Length );
   end Num_Items;
   
   procedure Insert_Sub_Menu( menu : in out Menu_Type; submenu : Menu_Type; key : String ) is
      p : Natural := Find( menu, key );
   begin
      if p > 0 then
         declare
            item : Menu_Item := menu.Element( p );
         begin
            item.submenu.all := submenu;
            menu.Replace_Element( p, item );
         end;
      end if;
   end Insert_Sub_Menu;
   
end Long_Menu;
