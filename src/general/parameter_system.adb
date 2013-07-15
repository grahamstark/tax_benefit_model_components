with Ada.Strings.Unbounded;
with Text_Utils;
with Ada.Containers;
with Ada.Exceptions; 
with Ada.Text_IO;
with Ada.Strings.Maps;

package body Parameter_System is
   use Ada.Text_IO;
 
   procedure Make_Path_To_Left( sys : Parameter_System_Rec; path : in out Text_Utils.Unbounded_String_List ) is
   use Text_Utils;
   use Unbounded_String_Vector_Package;
   use Parameter_System_Rec_Package;
         num_subsystems : constant Natural := Natural( sys.parameter_systems.Length );
   begin
      Append( path, sys.instance_name );
      for sno in 1 .. num_subsystems loop
         if( sys.parameter_systems.Element( sno ).all.instance_name /= Null_Unbounded_String )then
            Make_Path_To_Left( sys.parameter_systems.Element( sno ).all, path );
            exit;
         end if;
      end loop;
   end Make_Path_To_Left;
   
   procedure Complete_Path_To_Left( 
      sys : Parameter_System_Rec; 
      path : in out Text_Utils.Unbounded_String_List; 
      depth : in out Natural ) is
    use Text_Utils;
    use Parameter_System_Rec_Package;
    use Unbounded_String_Vector_Package;
        num_subsystems    : constant Natural := Natural( sys.parameter_systems.Length );
        path_length       : constant Natural := Natural(  path.Length );
        this_element_name : Unbounded_String;
        current_sys       : Parameter_System_Rec; 
    begin
      if( num_subsystems > 0 )then
         depth := depth + 1;
         if( path_length >= depth ) and ( path_length > 0 )then
            this_element_name := path.Element( depth );
            for sysno in 1 .. num_subsystems loop
               current_sys := sys.parameter_systems.element( sysno ).all;
               if( current_sys.instance_name = this_element_name )then 
                  Complete_Path_To_Left( 
                     current_sys,
                     path,
                     depth );
               end if;
            end loop;
         else
            declare
               path_to_left : Unbounded_String_List;
            begin
               Make_Path_To_Left( sys.parameter_systems.element( 1 ).all, path_to_left );
               path.Append( path_to_left );
            end;
         end if;
      end if;
    end Complete_Path_To_Left;
  
   function Path_To_URL( prefix : Unbounded_String; path : in Text_Utils.Unbounded_String_List ) return Unbounded_String is
   use Text_Utils;
   use Unbounded_String_Vector_Package;
      n   : Natural := Natural( path.Length );
      url : Unbounded_String := prefix & "/";
   begin
      for i in 1 .. n loop
         url := url & path.Element( i );
         -- if( i < n ) then
         url := url & "/";
         -- end if;
      end loop;
      return "href='" & url & "'";
   end Path_To_URL;
    
   procedure Set_Delimiter( del : Character ) is
   begin
      delimiter := del;
      delimiter_str(1) := del;
   end Set_Delimiter;
   
   package body Enum_Search is
      
      function Get_Enum( this : Parameter_System_Rec; id : String ) return Enumerated_Type_Rec is
      use Ada.Exceptions; 
      use Enumerated_Type_Package; 
         n : constant Natural := Natural( this.enumerated_types.Length );
         e : Enumerated_Type_Rec;
         ub_id : constant Unbounded_String := To_Unbounded_String( id );
      begin
         for i in 1 .. n loop
            e := this.enumerated_types.Element( i );
            if( e.id = ub_id )then
               return e;
            end if;
         end loop;
         Raise_Exception( Param_Exception'Identity, 
            "Parameter : Get: enumerated type with id |" & id & "| was not found " );
       end Get_Enum;
       
      procedure Replace_Or_Insert_Enum( this : in out Parameter_System_Rec; e : Enumerated_Type_Rec ) is
      use Ada.Exceptions; 
      use Enumerated_Type_Package; 
         n : constant Natural := Natural( this.enumerated_types.Length );
         this_e : Enumerated_Type_Rec;
      begin
         for i in 1 .. n loop
            this_e := this.enumerated_types.Element( i );
            if( e.id = this_e.id )then
               this.enumerated_types.Replace_Element( i, e );
               return;
            end if;
         end loop;
         this.enumerated_types.Append( e );
       end Replace_Or_Insert_Enum;
       
   end Enum_Search;
   
   package body Parameter_Search is
   
      function Get_Parameter( 
         this : Parameter_System_Rec; 
         instance_name : String ) return Parameter_Rec is
         use Ada.Exceptions; 
         use Parameter_Rec_Package;
         p : Parameter_Rec;
         ub_name : constant Unbounded_String := To_Unbounded_String( instance_name );
         n : constant Natural := Natural(this.parameters.Length);
      begin
         for pno in 1 .. n loop
            p := this.parameters.Element( pno );
            if( p.instance_name = ub_name )then
               return p;
            end if;
         end loop;
         Raise_Exception( Param_Exception'Identity, 
            "Parameter : Get: parameter with name |" & instance_name & "| was not found " );
      end Get_Parameter;
   
   end Parameter_Search;
   
   function Get( this : Parameter_System_Rec; path : String; search : Search_Type := by_path ) return Parameter_System_Rec is
      use Text_Utils;
      use Ada.Exceptions; 
      use Ada.Strings.Unbounded; 
         
      procedure Get_By_Path( this : in out Parameter_System_Rec; path : in out Text_Utils.Unbounded_String_List; found : in out Boolean ) is
         use Text_Utils.Unbounded_String_Vector_Package;
         use Parameter_System_Rec_Package;
         sys :   Parameter_System_Rec;
         path_size : constant Positive := Positive(path.Length);
      begin
         if( found ) or ( path_size = 0 )then 
            return; 
         end if;
         if( this.instance_name = path.Element( 1 ))then
            if( path_size = 1 ) then
               found := True;
               return;
            else
               path.Delete( 1 );
               for i in 1 .. Natural( this.parameter_systems.Length )loop
                  sys := this.parameter_systems.Element( i ).all;
                  Get_By_Path( sys, path, found );
                  if( found )then
                     this := sys;
                     return;
                   end if;
               end loop;
            end if;
         end if;
      end Get_By_Path;
      
       procedure Get_By_Name( this : in out Parameter_System_Rec; name :  Unbounded_String; found : in out Boolean ) is
         use Parameter_System_Rec_Package;
          sys :   Parameter_System_Rec;
       begin
         if( found )then 
            return; 
         end if;
         Put_Line( "looking for " & To_String( name ) & " got : " & To_String( this.name ));
         if( this.name = name )then
            found := True;
            return;
         else
            for i in 1 .. Natural( this.parameter_systems.Length )loop
               sys := this.parameter_systems.Element( i ).all;
               Get_By_Name( sys, name, found );
               if( found )then
                  this := sys;
                  return;
                end if;
            end loop;
         end if;
      end Get_By_Name;
     
      sys:   Parameter_System_Rec := this;
      found  : Boolean := False;
   begin
      if( search = by_path )then
         declare
            slices :  Unbounded_String_List := Split( path, delimiter );
         begin
            Get_By_Path( sys, slices, found );
         end;
      else
         Get_By_Name( sys, To_Unbounded_String(path), found );
      end if;
      if( not found ) then
         Raise_Exception( Param_Exception'Identity, 
            "Parameter_System: Get: system with path |" & path & "| was not found " );
      end if;
      return sys;
   end Get;
   
   function Get_Extra( this : Describable; key : String ) return String is
      uk : constant Unbounded_String := To_Unbounded_String( key );
   begin
      return Text_Utils.Get( this.extras, key );
   end Get_Extra;
   
   function Trimmed_String( s : Unbounded_String ) return String is
   use Ada.Strings.Maps;
   begin
      return Text_Utils.Trim( To_String( s ));   
   end Trimmed_String;

  
   function Description( 
      this : Describable; 
      which : Description_Kind := journalese; 
      language : languages := Languages'First ) return String is
   begin
      if( this.descriptions( which )( language ) /= Null_Unbounded_String ) then
         return Trimmed_String( this.descriptions( which )( language ));
      end if;
      for d in Description_Kind'Range loop
         if( this.descriptions( d )( language ) /= Null_Unbounded_String ) then
            return Trimmed_String( this.descriptions( d )( language ));
         end if;
      end loop;
      for l in Languages'Range loop
         if( this.descriptions( which )( l ) /= Null_Unbounded_String ) then
            return Trimmed_String( this.descriptions( which )( l ));
         end if;
      end loop;
      for l in Languages'Range loop
         for d in Description_Kind'Range loop
            if( this.descriptions( d )( l ) /= Null_Unbounded_String ) then
               return Trimmed_String( this.descriptions( d )( l ));
            end if;
         end loop;
      end loop;
      return "";
   end Description;
   
   function Is_Hidden( this : Describable ) return Boolean is
   begin
      return this.edit_info.display = hidden;
   end Is_Hidden;
   
   function Pos_Of_Value( e : Enumerated_Type_Rec; which : Integer ) return Natural is
      use Enumerated_Element_Package;
      n : Natural := Natural( e.values.Length );      
   begin
      for i in 1 .. n loop
         if( e.values.Element( i ).value = which )then
            return i;
         end if;
      end loop;
      return 0;
   end Pos_Of_Value;
   
   procedure Clear_All_Elements( e : in out Enumerated_Type_Rec ) is
   begin
      e.values.Clear;
   end Clear_All_Elements;
   
   procedure Delete_Element( e : in out Enumerated_Type_Rec; which : Integer ) is
      p : Natural := e.Pos_Of_Value( which );
   begin
      if( p /= 0 )then
         e.values.Delete( p );
      end if;
   end Delete_Element;
   
   procedure Add_Element( 
      e : in out Enumerated_Type_Rec; 
      after : Integer; 
      name : String; 
      value : Integer; 
      is_default : Boolean; 
      default_text : String ) is
      p : Natural := e.Pos_Of_Value( after );
      elem : Enum_Value_Rec := (
         name => To_Unbounded_String( name ),
         value => value,
         is_default => is_default,
         text => ( others => To_Unbounded_String( default_text )) 
      );
      
   begin
      if( p = 0 )then
         e.values.Append( elem );
      else
         e.values.Replace_Element( p, elem );
      end if;
   end Add_Element;
   
   procedure Set_Default_Element( e : in out Enumerated_Type_Rec; which : Integer ) is
      use Enumerated_Element_Package;
      n                   : Extended_Index := Extended_Index( e.values.Length ); 
      current_default_pos : Extended_Index := 0;
      found               : Boolean := False;
      elem                : Enum_Value_Rec;
   begin
      for i in 1 .. n loop
         if( e.values.Element( i ).is_default )then
            current_default_pos := i;
         end if;
      end loop;
      for i in 1 .. n loop
         elem := e.values.Element( i ); 
         if( elem.value = which )then
            elem.is_default := True;
            found := True;
         else
            elem.is_default := False;
         end if;
         e.values.Replace_Element( i, elem );
      end loop;
      if( not found and current_default_pos /= 0 )then
         elem := e.values.Element( current_default_pos );          
         elem.is_default := True;
         e.values.Replace_Element( current_default_pos, elem );
      end if;
   end Set_Default_Element;
   
   
   
end Parameter_System;
