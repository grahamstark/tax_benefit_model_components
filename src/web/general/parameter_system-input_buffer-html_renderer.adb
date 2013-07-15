with AWS.Parameters;

with Ada.Characters.Handling;
with Ada.Exceptions;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Text_IO;

with GNATColl.Traces;

with HTML_Utils;
with Line_Extractor;
with Strings_Edit.Float_Edit;
with Templates_Parser;
with Text_Utils;
with Web_Utils;

package body Parameter_System.Input_Buffer.HTML_Renderer is

   use Text_Utils;
   use Ada.Text_IO;
    
   JAVA_IMAGES_PATH  : constant String := "/images/java_graphs/";
   INSERT_BEFORE_IMG : constant String := JAVA_IMAGES_PATH & "table/RowInsertBefore24.gif";
   INSERT_AFTER_IMG  : constant String := JAVA_IMAGES_PATH & "table/RowInsertAfter24.gif";
   DELETE_IMG        : constant String := JAVA_IMAGES_PATH & "table/RowDelete24.gif";
   SAVE_IMG          : constant String := JAVA_IMAGES_PATH & "general/Save24.gif";
   COPY_IMG          : constant String := JAVA_IMAGES_PATH & "general/Copy24.gif";
   PASTE_IMG         : constant String := JAVA_IMAGES_PATH & "general/Paste24.gif";
   HELP_IMG          : constant String := JAVA_IMAGES_PATH & "general/Help24.gif";
   
   html_type : HTML_Kind;
 
   package Local_HTML_Utils is new HTML_Utils(
      Rate=>Float_Type, 
      Counter_Type=>Counter_Type
   );
   
   template_components_path : Unbounded_String;
   web_root                 : Unbounded_String;
   directory_separator      : Character;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "PARAMETER_SYSTEM.INPUT_BUFFER.HTML_RENDERER" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
   procedure Set_Paths(
      new_web_root                 : String;
      new_template_components_path : String;
      new_directory_separator      : Character ) is
   begin
      web_root := To_Unbounded_String( new_web_root );
      template_components_path := To_Unbounded_String( new_template_components_path );
      directory_separator := new_directory_separator;
   end Set_Paths;

   
   --
   -- Dmitry's formatting package
   --
   package Local_Float_Edit is new Strings_Edit.Float_Edit( Number => Float_Type );

   function Format_For_Input_Field( f : Float_Type; edit : Edit_Info_Rec ) return Unbounded_String is
      MAX_SAFE_FLOAT     : constant := 9999999.99;
      MAX_SAFE_FLOAT_USTR : constant Unbounded_String := TuS( "999999999.99" ); 
      -- note this is bigger than the corresponding number, since the back-end may
      -- be using a smaller precision than euromod and we need a bif number for upper limits.
      -- REALLY need to work out how to 
      -- fix this properly
      MIN_SAFE_FLOAT     : constant := -9999999.99;
      MIN_SAFE_FLOAT_USTR : constant Unbounded_String := TuS( "-999999999.99" );
      buff : String( 1 .. 30 );
      pos  : Integer := 1;
   begin
      Log( "edit.length = " & edit.length'Img & " edit.prec " & edit.prec'Img );
      --
      -- FIXME horrible hack to ensure euromod doesn't get numbers formatted with
      -- exponents, which kills it
      -- 
      if( f >= MAX_SAFE_FLOAT )then 
         return MAX_SAFE_FLOAT_USTR;
      elsif( f <= MIN_SAFE_FLOAT )then
         return MIN_SAFE_FLOAT_USTR;
      end if;
      Local_Float_Edit.Put( 
         Destination => buff,
         Pointer     => pos,
         Value       => f,
         Field       => buff'Length,
         AbsSmall    => -(edit.prec ) );
      return TuS( Ada.Strings.Fixed.Trim( buff, Ada.Strings.Both ));
   end Format_For_Input_Field;
   
   function Format_For_Input_Field( i : Integer; edit : Edit_Info_Rec ) return Unbounded_String is
      s : String := Integer'Image( i );
   begin
      return TuS( s( 1 .. s'Length ));
   end Format_For_Input_Field;

   procedure Make_Input_Menus( 
      sys            : Parameter_System_Rec; 
      path           : in out Unbounded_String_List;
      menu_string    : in out Unbounded_String;
      lang           : Languages;
      depth          : in out Natural;
      prefix         : Unbounded_String ) is
    use Parameter_System_Rec_Package;
    use Unbounded_String_Vector_Package;
         num_subsystems : constant Natural := Natural( sys.parameter_systems.Length );
    begin
      if( num_subsystems > 0 )then
         declare
            list           : Unbounded_String;
            selected_sys   : Parameter_System_Rec;
            this_element_name : Unbounded_String := TuS( "XX" );
            all_but_last        : Unbounded_String_List;
            path_length    : constant Natural := Natural( path.Length );
         begin
            -- path is (say) income_tax | allowances
            --
            -- if the path stretches down this far, use this element 
            --
            --
            -- the elements in the path up to this point, if any
            --
            for i in 1 .. depth loop
               if( i <= path_length )then
                  all_but_last.Append( path.Element( i ));
               end if;
            end loop;
            depth := depth + 1;
            if( num_subsystems > 0 )then
               selected_sys :=  sys.parameter_systems.element( 1 ).all;  
               if( path_length >= depth ) and ( path_length > 0 )then
                  this_element_name := path.Element( depth );
               else
                  this_element_name := selected_sys.instance_name;
               end if;
               list := list & "<ul>" & LINE_BREAK;
               
               for sno in 1 .. num_subsystems loop
                  declare
                     current_sys : Parameter_System_Rec := sys.parameter_systems.element( sno ).all;
                     labelstr : String := current_sys.Description( label, lang  );
                     elem  : Unbounded_String;
                     url   : Unbounded_String;
                     path_to_left :  Unbounded_String_List;
                     full_path_to_left :  Unbounded_String_List;
                  begin
                     if( current_sys.instance_name = Null_Unbounded_String )then
                        null; -- no instance parameter systems, e.g. ratebands
                     elsif( current_sys.instance_name = this_element_name )then
                        selected_sys := current_sys;
                        elem := elem & "    <li class='on'>" & labelstr & "</li>" & LINE_BREAK;
                     else
                        Make_Path_To_Left( current_sys, path_to_left );
                        full_path_to_left.Append( all_but_last );
                        full_path_to_left.Append( path_to_left );
                        url := Path_To_URL( prefix, full_path_to_left );
                        elem := elem & "    <li><a " & url & ">" & labelstr & "</a></li>" & LINE_BREAK;
                     end if;
                     list := list & elem;
                  end;
               end loop;
               list := list & "</ul>" & LINE_BREAK;
               menu_string := menu_string & list;
            end if;
            if(( depth - 1 ) > path_length )then
               path.append( selected_sys.instance_name );   
            end if;
            Make_Input_Menus( selected_sys, path, menu_string, lang, depth, prefix ); 
         end;
     end if;
    end Make_Input_Menus;

    function Year_As_String( year : Year_Number ) return Unbounded_String is
    begin
        return TuS( Year_Number'Image( year )( 2 .. Year_Number'Image( year )'Last ));
    end Year_As_String;
    
    function Make_Year_Menu(
      prefix              : Unbounded_String;
      path_to_left        : Unbounded_String_List;
      start_year          : Year_Number;
      end_year            : Year_Number;
      this_year           : Year_Number ) return Unbounded_String is
      elem : Unbounded_String;
      full_path_to_left : Unbounded_String_List := path_to_left; 
   begin
      elem := elem & "<ul>" & LINE_BREAK;
      for y in start_year .. end_year loop
         declare
            year_str    : Unbounded_String := Year_As_String( y );
         begin
            if( y = this_year )then
               elem := elem & "    <li class='on'>" & year_str & "</li>" & LINE_BREAK;
            else
               declare
                  url         : Unbounded_String;
                  full_prefix : Unbounded_String := prefix & year_str;
               begin
                  url :=  Path_To_URL( full_prefix, full_path_to_left );
                  elem := elem & "    <li><a " & url & ">" & year_str & "</a></li>" & LINE_BREAK;
               end;
            end if;
         end;
      end loop;
      elem := elem & "</ul>" & LINE_BREAK;
      return elem;
   end Make_Year_Menu;
   
   function Make_Parameter_Menu(
      start_year           : Year_Number;
      end_year             : Year_Number;
      this_year            : Year_Number;
      base_sys             : Parameter_System_Rec; 
      current_path         : Unbounded_String_List;
      prefix               : Unbounded_String;
      lang                 : Languages ) return Unbounded_String is  
      menu : Unbounded_String;
      lists : Unbounded_String ;
      year_menu : Unbounded_String;
      depth : Natural := 0;
      locpath : Unbounded_String_List := current_path;
      year_str    : Unbounded_String := Year_As_String( this_year );
      full_prefix : Unbounded_String := prefix & year_str;
      full_path_to_left :  Unbounded_String_List;
   begin
      Make_Path_To_Left( base_sys, full_path_to_left );
      full_path_to_left.Delete( 1 ); -- the top level bit is left off the menus by convention
      -- locpath.Replace_Element( 1,  Year_As_String( this_year )); -- so all our submenus always have, say, '/2012/' as the 1st element
      year_menu := Make_Year_Menu( prefix, full_path_to_left, start_year, end_year, this_year );
      Make_Input_Menus( base_sys, locpath, lists, lang, depth, full_prefix );
      menu := menu & "<div id='modelNavSub'>" & LINE_BREAK & year_menu & LINE_BREAK & lists & LINE_BREAK &  "</div>" & LINE_BREAK;
      return menu;
   end Make_Parameter_Menu;

   --
    
   function Contains_Value( table : AWS.Parameters.List; value : String ) return Boolean is
      table_size : Integer := AWS.Parameters.Count (table);
   begin
      for i in  1 .. table_size loop
          if (AWS.Parameters.Get( table, i ).Value = value) then            
            return True;
         end if;
      end loop;
      return False;
   end Contains_Value;
   
   

   function Reverse_Table_Lookup( table : AWS.Parameters.List; value : String ) return String is
      table_size : Integer := AWS.Parameters.Count( table );
   begin
      for i in  1 .. table_size loop
          if( AWS.Parameters.Get( table, i ).Value = value ) then
            return AWS.Parameters.Get( table, i ).Name;
         end if;
      end loop;
      return "";
   end Reverse_Table_Lookup;
  
   function Units_String( ltype : Logical_Kind; units : Units_Kind; lang : Languages ) return String is
   begin
      case ltype is
         when any_kind | quickies | rates_and_bands  => return "";
         when rate                     => return "&nbsp;<span class='units'>(%)</span>";
         when tax_allowance | tax_band => return "&nbsp;<span class='units'>(&pound; " & Lookup( "per year", lang ) & ")</span>"; 
         when benefit | poverty_line   => 
            if( units = day ) then
               return "&nbsp;<span class='units'>(&pound; " & Lookup( "per day", lang ) & ")</span>"; 
            else
               return "&nbsp;<span class='units'>(&pound; " & Lookup( "per week", lang ) & ")</span>";
            end if;
         when age_limit                => return "&nbsp;<span class='units'>(" & Lookup( "years", lang ) & ")</span>"; 
      end case;
   end Units_String;
   
   procedure Set_HTML_Type( t : HTML_Kind ) is
   begin
      html_type := t;
   end Set_HTML_Type;

   function Make_Radio
     (varname           : Unbounded_String;
      selected          : Unbounded_String;
      enum              : Enumerated_Type_Rec;
      lang              : Languages;
      class             : String := "";
      extras            : String := "";
      help              : String := "")
      return              Unbounded_String is
      use Enumerated_Element_Package;
      n : Positive := Positive( Length( enum.values ));
      s : Unbounded_String :=  Null_Unbounded_String;
   begin
      for i in 1 .. n loop
         s := s & "<input type='radio name='" & varname & "' id='" & varname & "'";
         if (class /= "") then
            s := s & " class='" & class & "' ";
         end if;
         if (extras /= "") then
            s := s & " " & extras;
         end if;
         if (help /= "") then
            s := s & " alt='" & help & "' ";
         end if;
         declare
            ev : Enum_Value_Rec := enum.values.Element( i );
         begin
            if( selected = ev.name ) or ( selected = Null_Unbounded_String and ev.is_default ) then
               s := s & " default = 'default' ";
            end if;
            s := s & " value='" & ev.name & "' />";
            if( ev.text( lang ) /= Null_Unbounded_String )then
               s := s & ev.text( lang );
            else
               s := s & ev.text( Languages'First );
            end if;
         end;
      end loop;
      return s;
   end Make_Radio;
 
   function Make_Checkbox
     (varname : Unbounded_String;
      checked : Boolean;
      class   : Unbounded_String := Null_Unbounded_String;
      help    : Unbounded_String := Null_Unbounded_String;
      extras  : Unbounded_String := Null_Unbounded_String )
      return    Unbounded_String
   is
      s : Unbounded_String := Null_Unbounded_String;
   begin
      s := s & "<input type='checkbox' name='" & varname & "' ";
      if (class /= Null_Unbounded_String) then
         s := s & "class='" & class & "' ";
      end if;
      if (extras /= Null_Unbounded_String) then
         s := s & extras;
      end if;
      if (help /= Null_Unbounded_String) then
         s := s & " alt='" & help & "' ";
      end if;
      if (checked) then
         s := s & " checked='checked' ";
      end if;
      s := s & " />";
      return s;
   end Make_Checkbox;
   
   function Make_Validator_Code( key : Unbounded_String; param : Parameter_Rec ) return Unbounded_String is
      s : Unbounded_String := """" & key & """: { required: true, ";   
   begin
      
      -- case logical_type is
         -- when any_kind, 
         -- when rate =>
         -- when tax_allowance =>
         -- when tax_band =>
         -- when benefit =>
         -- when age_limit =>
         -- when quickies =>
         -- when poverty_line =>
         -- when rates_and_bands =>   
      -- end case;
      if( param.edit_info.treat_as_percentage )then
            s := s & "min: 0,";
            s := s & "max: 100,";
      else
         if( param.edit_info.min /= Float_Type'First )then
            s := s & "min: " & Float_Type'Image( param.edit_info.min ) & ",";
         end if;
         if( param.edit_info.max /= Float_Type'Last )then
            s := s & "max: " & Float_Type'Image( param.edit_info.max ) & ",";
         end if;
      end if;
      s := s & "number: true }"; -- FIXME allow for Dutch style xxx xxx,00
      return s;
   end Make_Validator_Code;
   
   function Make_Info_Box( 
      key : Unbounded_String;
      text : Unbounded_String ) return Unbounded_String is
         s : Unbounded_String;
   begin
      s := s & "<div class='info' id='" & key & "_help' >" & LINE_BREAK;
      s := s & text & LINE_BREAK;
      s := s & "</div>" & LINE_BREAK;
      return s;
   end Make_Info_Box;
   
   function Make_Select
     (varname           : Unbounded_String;
      selected          : Unbounded_String;
      enum              : Enumerated_Type_Rec;
      lang              : Languages;
      class             : Unbounded_String := Null_Unbounded_String;
      extras            : Unbounded_String := Null_Unbounded_String;
      help              : Unbounded_String := Null_Unbounded_String)
      return              Unbounded_String
      
   is
      use Enumerated_Element_Package;
      use Ada.Characters.Handling;
      n : Positive := Positive( Length( enum.values ));
      lower_selected_str : constant String := To_Lower( To_String( selected ));
      s : Unbounded_String := Null_Unbounded_String & 
         "<select" & " name='" & varname & "' id='" & varname & "'";
   begin
      if( class /= Null_Unbounded_String )then
         s := s & " class='" & class & "' ";
      end if;
      if (extras /= Null_Unbounded_String) then
         s := s & extras;
      end if;
      if (help /= Null_Unbounded_String) then
         s := s & " alt='" & help & "' ";
      end if;

      s := s & ">";
      
      for i in 1 .. n loop
         s := s & "<option ";
         declare
            ev : Enum_Value_Rec := enum.values.Element( i );
            lower_name_str : constant String := To_Lower( To_String( ev.name ));
         begin
            if lower_selected_str = lower_name_str then
               s := s & " selected = 'selected' ";
            elsif ev.is_default then
               s := s & " selected = 'selected' ";
            end if;
            s := s &
              " value='" & ev.name & "'>";
            if( ev.text( lang ) /= Null_Unbounded_String )then
               s := s & ev.text( lang );
            else
               s := s & ev.text( Languages'First );
            end if;
            s := s & "</option>";
         end;
      end loop;
      s := s & "</select>";
      return s;
   end Make_Select;

   function Make_Input
     (varname    : Unbounded_String;
      value      : Unbounded_String;
      class      : Unbounded_String  := Null_Unbounded_String;
      size       : Integer           := 12;
      help       : Unbounded_String  := Null_Unbounded_String;
      error_text : Unbounded_String  := Null_Unbounded_String;
      extras     : Unbounded_String  := Null_Unbounded_String )
      return       Unbounded_String
   is
      s : Unbounded_String :=
         To_Unbounded_String
           ("<input type='text' size='" & 
             Censor_String(Integer'Image(size)) & 
            "' name='" ) & varname & "' id='" & varname & "' ";
   begin
      if (class /= Null_Unbounded_String) then
         s := s & "class='" & class & "' ";
      end if;
      if (extras /= Null_Unbounded_String) then
         s := s & extras;
      end if;
      if (help /= Null_Unbounded_String) then
         s := s & " alt='" & help & "' ";
      end if;
      s := s & " value='" & value & "' ";
      s := s & " />";
      if( error_text /= Null_Unbounded_String )then
         s := s & "<br/>";
         s := s & "<span class='input_error_message'>" & error_text & "</span>";
      end if;
      return s;
   end Make_Input;
   
   function Make_Hidden_Field( varname : Unbounded_String; value : Unbounded_String ) return Unbounded_String is
      s : Unbounded_String :=
         To_Unbounded_String
           ( "<input type='hidden' name='" ) & varname & "' id='" & varname & "' />";
   begin
      return s;
   end Make_Hidden_Field;
      

   
   function Get_Display_Priority( param : Parameter_Rec ) return Float_Type is
      priority :  Float_Type := 1.0;
   begin
      if( param.logical_type = quickies )then
         priority := 100.0;
      else
         declare 
            pstring : String := param.Get_Extra( "priority" );
         begin
            if( pstring /= "" )then
               priority := Local_Format_Utils.Lenient_Convert( pstring );                       
            end if;
         end;
      end if;
      return priority;
   end Get_Display_Priority;
   
   function Get_Class( val_and_err  : Value_And_Error ) return Unbounded_String is
      use Utils;
      ERROR   : constant Unbounded_String := To_Unbounded_String( "input_error" );
      CHANGED : constant Unbounded_String := To_Unbounded_String( "is_changed_from_base" );
      
   begin
      if( val_and_err.error /= no_error )then
         return ERROR;
      else
         case val_and_err.dtype is
            when real_type       => if( val_and_err.rval /= val_and_err.rdefault ) then return CHANGED; end if;
            when integer_type    =>
               Log( "default is " & val_and_err.idefault'Img );
               if( val_and_err.ival /= val_and_err.idefault ) then return CHANGED; end if;
            when enumerated_type => if( val_and_err.eval /= val_and_err.edefault ) then return CHANGED; end if;
            when boolean_type    => if( val_and_err.bval /= val_and_err.bdefault ) then return CHANGED; end if;
            when string_type     => if( val_and_err.sval /= val_and_err.sdefault ) then return CHANGED; end if;
            when date_type       => null; -- TODO cval, cdefault  : Ada.Calendar.Time;
            when decimal_type    => if( val_and_err.dval /= val_and_err.ddefault ) then return CHANGED; end if;
         end case;
      end if;
      return Null_Unbounded_String;
   end Get_Class;

   function Make_Description_Table( desc : Parameter_Rec; lang : languages ) return Unbounded_String is
      s : Unbounded_String;
   begin
      s := s & "<h4>" & desc.Description( label, lang ) & "</h4>" & LINE_BREAK; 
      s := s & "<table width='100%'>" & LINE_BREAK;
      if( desc.Description( label, lang ) /=  desc.Description( description, lang ))then
         s := s & "   <tr><td colspan='2'>" & desc.Description( description, lang ) & "</td></tr>" & LINE_BREAK; 
      end if;
      if( desc.edit_info.min > Float_Type'First )then
         s := s & "   <tr><th>" & Lookup( "Minimum Value", lang ) & ":</th><td>" & Format( desc.edit_info.min, lang ) & "</td></tr>" & LINE_BREAK; 
      end if;
      if( desc.edit_info.max < Float_Type'Last )then
         s := s & "   <tr><th>" & Lookup( "Maximum Value", lang ) & ":</th><td>" & Format( desc.edit_info.max, lang ) & "</td></tr>" & LINE_BREAK; 
      end if;
      s := s & "   <tr><th>" & Lookup( "Units", lang ) & ":</th><td>" & Units_String( desc.logical_type, desc.units, lang ) & "</td></tr>" & LINE_BREAK; 
      
      s := s & "</table>" & LINE_BREAK;
      return s;   
   end Make_Description_Table; 
   
   function Write_Help_Box( 
      key  : Unbounded_String;
      elem : Parameter_Rec;
      lang : Languages ) return Unbounded_String is
   use Templates_Parser;
      translations       : Translate_Set;
      call : Unbounded_String;  
      text : String := " ";
   begin
      if( text = "" )then
         return Null_Unbounded_String;
      end if;
      Insert( translations, Assoc( "KEY", key ));
      Insert( translations, Assoc( "MAIN-HELP-TEXT", Make_Description_Table( elem, lang ) ));
      Insert( translations, Assoc( "ROOT", Web_Root ));
      Insert( translations, Assoc( "CHANGED_PARAMETERS", "CHANGED PARAMS GO HERE" ));
      
      Insert( translations, Assoc( "IMG", HELP_IMG ));
      return Web_Utils.Parse_Template( 
         template_components_path  &
         Dir_Separator & "jquery_help", translations );
   end Write_Help_Box;
   
   function Create_Single_Input( 
      key               : Unbounded_String;
      lang              : Languages;
      param_desc        : Parameter_Rec;
      val_and_err       : Value_And_Error;
      enum_type         : Enumerated_Type_Rec;
      do_complete_row   : Boolean;
      make_hidden       : Boolean := False;
      print_static_only : Boolean := False; 
      print_all         : Boolean := False ) return Unbounded_String is
      use Ada.Exceptions; 
      use Utils;
      
      s : Unbounded_String;
      class : Unbounded_String := Get_Class( val_and_err );
      label_str   : String := param_desc.Description( label, lang );
      short_help  : Unbounded_String := To_Unbounded_String( param_desc.Description( journalese, lang ));
      full_help   : Unbounded_String := To_Unbounded_String( param_desc.Description( description, lang ));
      input_text  : Unbounded_String;
      extras      : Unbounded_String;
      print_label : Boolean := False;
   begin
      Log( "key |" & TS( key ) & "| onchange = |" & TS( param_desc.Edit_Info.onchange ) & "| logical type |" & param_desc.logical_type'Img );
      Log( "label_str = " & label_str );
      if( param_desc.edit_info.onchange /= TuS( "" ))then
         extras := " onchange='" & param_desc.Edit_Info.onchange & "' ";
      end if;
      if( not param_desc.edit_info.enabled )then
         extras := extras & " disabled='disabled' ";
      end if;
      if( print_static_only )then
         if( Is_Changed( val_and_err ) or print_all )then
            print_label := True; 
         end if;
      else
         print_label := do_complete_row;
      end if;
      if( print_label )then
         s := s & 
            "<tr><td width='50%'><label for='" & key & "'>" & label_str &
            "</label></td><td>";
      end if;
      if( make_hidden )then
         s := s & "<input type='hidden' name='"& key & "' id='" & key & "' value='";
         case val_and_err.dtype is
            when enumerated_type =>s := s & val_and_err.eval;
            when real_type    => s := s & val_and_err.rval'Img;
            when integer_type => s := s & val_and_err.ival'Img;
            when decimal_type => s := s & val_and_err.dval'Img; 
            when string_type  => s := s & val_and_err.sval;
            when boolean_type => s := s & val_and_err.bval'Img;
            when others =>
               Raise_Exception( Param_Exception'Identity, 
                      "Parameter-System.Input_Buffer : Create_Single_Input for: " &
                      Data_Kind'Image( val_and_err.dtype ) &
                      " is not inplemented key:" & To_String( key ));
         end case;
         s := s & "' />";
      elsif param_desc.edit_info.display = read_only then
         s := s & "<span class='static_value'>";
         case val_and_err.dtype is
            when enumerated_type =>s := s & val_and_err.eval;
            when real_type    => s := s & Format( val_and_err.rval, lang );
            when integer_type => s := s & Format( val_and_err.ival, lang );
            when decimal_type => s := s & Format( Float_Type( val_and_err.dval ), lang ); 
            when string_type  => s := s & val_and_err.sval;
            when boolean_type => s := s & Format( val_and_err.bval, lang );
            when others =>
               Raise_Exception( Param_Exception'Identity, 
                      "Parameter-System.Input_Buffer : Create_Single_Input for: " &
                      Data_Kind'Image( val_and_err.dtype ) &
                      " is not inplemented key:" & To_String( key ));
         end case;
         s := s & "&nbsp;</span>";
         -- FIXME passwords
      elsif print_static_only then
         if( Is_Changed( val_and_err ) or print_all )then
            s := s & "<span class='static_value'>";
            case val_and_err.dtype is
               when enumerated_type =>s := s & val_and_err.eval;
               when real_type    => s := s & "now: " & Format( val_and_err.rval, lang ) & " <span class='orig_value'>(was : " & Format( val_and_err.rdefault, lang ) & ")</span>";
               when integer_type => s := s & "now: " & Format( val_and_err.ival, lang ) & " <span class='orig_value'>(was : " & Format( val_and_err.idefault, lang ) & ")</span>";
               when decimal_type => s := s & "now: " & Format( Float_Type( val_and_err.dval ), lang ) & " <span class='orig_value'>(was : " & Format( Float_Type( val_and_err.ddefault ), lang ) & ")</span>"; 
               when string_type  => s := s & "now: " & val_and_err.sval & " <span class='orig_value'>(was :" & val_and_err.sdefault & ")</span>";
               when boolean_type => s := s & "now: " & Format( val_and_err.bval, lang ) & " <span class='orig_value'>(was :" & Format( val_and_err.bdefault, lang ) & ")</span>";
               when others =>
                  Raise_Exception( Param_Exception'Identity, 
                         "Parameter-System.Input_Buffer : Create_Single_Input for: " &
                         Data_Kind'Image( val_and_err.dtype ) &
                         " is not inplemented key:" & To_String( key ));
            end case;
            s := s & "&nbsp;</span>";
         end if;
         -- FIXME passwords
      else
         case val_and_err.dtype is
            when enumerated_type =>
               Log( "wsc_renderer::doing an enum; varname " & TS( key ) & " got this as default; " & TS( val_and_err.eval ));
               s := s & 
                  Make_Select( 
                     varname    => key,
                     selected   => val_and_err.eval,
                     enum       => enum_type,
                     lang       => lang,
                     help       => short_help,
                     extras     => extras,
                     class      => class );
            when real_type | integer_type | decimal_type | string_type =>
               -- hack because we've used a format that may have commas or spaces
               -- as the text in val_and_err.text
               if( val_and_err.error = no_error )then
                  if( val_and_err.dtype = real_type )then
                     input_text := Format_For_Input_Field( val_and_err.rval, param_desc.edit_info );
                  elsif( val_and_err.dtype = integer_type )then
                     input_text := Format_For_Input_Field( val_and_err.ival, param_desc.edit_info );
                  else
                     input_text := val_and_err.text;
                  end if;
               else 
                  input_text := val_and_err.text;
               end if;  
               s := s & 
                  Make_Input(
                     varname    => key,
                     value      => input_text,
                     class      => class,
                     size       => param_desc.edit_info.length,
                     help       => short_help,
                     extras     => extras,
                     error_text => val_and_err.error_message );
               
           when boolean_type =>
                --
                -- This is convoluted, but the parsing code
                -- only handles parameters actually passed to it,
                -- and nothing is passed in the case of an unchecked checkbox,
                -- sp we'll add a hidden field to alert the parsing code
                -- that the field must be there.
                --
                s := s & 
                  Make_Hidden_Field(
                     varname   => key,
                     value     => TuS( val_and_err.bval'Img ));
                s := s & 
                  Make_Checkbox(
                     varname    => key & "_value",
                     checked    => val_and_err.bval,
                     class      => class,
                     extras     => extras,
                     help       => short_help );
            when others =>        
               Raise_Exception( Param_Exception'Identity, 
                      "Parameter-System.Input_Buffer : Create_Single_Input for: " &
                      Data_Kind'Image( val_and_err.dtype ) &
                      " is not inplemented key:" & To_String( key ));
         end case;
      end if;
      if( print_label )then
         s := s & "</td>";
         s := s & "<td width='15%' >" & Units_String( param_desc.logical_type, param_desc.units, lang ) & "</td>";
         s := s & "<td>";
         s := s & Write_Help_Box( 
            key, param_desc, lang );
         s := s & "</td></tr>" & LINE_BREAK; 
      end if;
      return s;  
   end Create_Single_Input;
   
  function Make_Ajax_Call_Indexed( 
      action          : Ajax_Action_Type;
      key             : Unbounded_String;
      row             : Natural;
      lang            : Languages;
      ajax_target_key : Unbounded_String ) return Unbounded_String is
      ERROR_CHECK_JS : constant String := " new Ajax.Updater( 'error_section', '" & TS( web_root ) & "ajax', { method: 'post', parameters: 'action=error_check'})";
   use Templates_Parser;
      translations       : Translate_Set;
   begin
      case action is
      when insert_above =>
         Insert( translations, Assoc( "IMG", WEB_ROOT& INSERT_BEFORE_IMG ));
         Insert( translations, Assoc( "ALT", Lookup( "ajax_insert_before",lang )));
      when insert_below => 
         Insert( translations, Assoc( "IMG", WEB_ROOT& INSERT_AFTER_IMG ));
         Insert( translations, Assoc( "ALT",  Lookup( "ajax_insert_after",lang )));
      when delete => 
         Insert( translations, Assoc( "IMG", WEB_ROOT& DELETE_IMG ));
         Insert( translations, Assoc( "ALT", Lookup( "ajax_delete",lang )));
      when save => 
         Insert( translations, Assoc( "IMG", WEB_ROOT& SAVE_IMG ));
         Insert( translations, Assoc( "ALT", Lookup( "ajax_save",lang )));
      when copy =>
         Insert( translations, Assoc( "IMG", WEB_ROOT& COPY_IMG ));
         Insert( translations, Assoc( "ALT", Lookup( "ajax_copy",lang )));
      when error_check  => null;
      end case;
      Insert( translations, Assoc( "TABLE-DATA-ID", key ));
      Insert( translations, Assoc( "KEY", key ));
      Insert( translations, Assoc( "ROW", row ));
      Insert( translations, Assoc( "ACTION", Censor_String( Ajax_Action_Type'Image( action ))));
      Insert( translations, Assoc( "URL", WEB_ROOT & "array_update" ));
      Insert( translations, Assoc( "TABLE-CONTAINER-ID", ajax_target_key ));
      return Web_Utils.Parse_Template( template_components_path  & dir_separator & "jquery_ajax", translations );
   end Make_Ajax_Call_Indexed;
   
 
   function Make_Indexed_Block(
      complete_sys      : Parameter_System_Rec;
      key               : Unbounded_String;
      buff              : Buffer;
      ajax_target_key   : Unbounded_String;
      print_static_only : Boolean := False; 
      print_all         : Boolean := False ) return Unbounded_String is
   use Ada.Exceptions; 
   use Text_Utils;
      s : Unbounded_String;
      INDENT : constant String := "  ";
      complete_value : Complete_Param_And_Value_Rec;
   begin
      Log( "Make_Indexed_Block; Looking for key |" & TS( key ) & "| " );
      complete_value := buff.params.Element( key );
      case complete_value.reference_desc.index_type is
         when none => 
            Raise_Exception( Param_Exception'Identity, 
              "Parameter-System.Input_Buffer : inconsistent state list: but no collection type key:" & To_String( key ));
         when integer_type =>
            declare
               use Value_And_Error_Map_Package;
               parameter  : Parameter_Rec;
               num_params : constant Natural := Natural( complete_value.system_desc.parameters.Length );  
               make_hidden : Boolean;
               print_edit  : Boolean;
            begin
               --
               -- create a table with each row consisting of one of the records, and editing
               -- controls at the end which can change the number of rows
               -- see [ ] for an example of a suitable Ajax callback for this
               -- an example use case is rate/band combos for income tax, where each rate/band
               -- pair is modelled as a mini-system and we use an integer as the index 
               --
               s := s & "<table class='editable_table' id='table-" & key & "'> " & LINE_BREAK;
               s := s & INDENT & "<tbody>" & LINE_BREAK;
               s := s & INDENT & INDENT & "<tr>" & LINE_BREAK;
               for pno in 1 .. num_params loop
                  parameter := complete_value.system_desc.parameters.Element( pno );
                  s := s & INDENT & INDENT & INDENT & "<th>" & parameter.Description( label, buff.lang ) & 
                           "<br/>" & Units_String( parameter.logical_type, parameter.units, buff.lang ) &
                           "</th>" & LINE_BREAK;
               end loop;   
               s := s & INDENT & INDENT & "</tr>" & LINE_BREAK;
               each_index:
               for row in 1 .. complete_value.current_size loop
                  s := s & INDENT & INDENT & "<tr id='" & key & "_row_" & Trim( Natural'Image( row )) & "' >" & LINE_BREAK;
                  each_param:
                  for pno in 1 .. num_params loop
                     declare
                        index_key     : Unbounded_String;
                        val_and_err   : Value_And_Error_Access;
                        cell          : Unbounded_String;
                        enum          : Enumerated_Type_Rec;
                     begin
                        parameter := complete_value.system_desc.parameters.Element( pno );
                        if( To_String( parameter.enum_type_ref ) /= "" )then
                           enum := Enum_Search.Get_Enum( complete_sys, To_String( parameter.enum_type_ref ));
                        end if;
                        index_key := Line_Extractor.Make_Key( key, row, parameter.instance_name );
                        index_key := Censor_Id( index_key );
                        val_and_err := Get_Value_And_Error( 
                           param_and_value => complete_value,
                           index           => row,
                           postfix         => parameter.name );
                        make_hidden := ( row = complete_value.current_size ) and then
                          (( parameter.Edit_Info.topset ) or ( parameter.logical_type = tax_band ));
                        cell := Create_Single_Input( 
                           key              => index_key,
                           lang             => buff.lang,
                           param_desc       => parameter,
                           val_and_err      => val_and_err.all,
                           enum_type        => enum,
                           do_complete_row  => False,
                           make_hidden      => make_hidden,
                           print_static_only => print_static_only,
                           print_all         => print_all
                           );
                        if( make_hidden )then
                           cell := cell & Lookup( "All other income", buff.lang );
                        end if;
                        s := s & INDENT & INDENT & INDENT & "<td>" & cell & "</td>";
                     end;
                     s := s & LINE_BREAK;
                  end loop each_param;
                  --
                  -- action options 
                  --
                  for action in Ajax_Action_Type'First .. delete loop
                     print_edit := not 
                      ((( action = delete ) and ( complete_value.current_size = 1 )) or
                       (( action /= delete ) and ( complete_value.current_size = complete_value.reference_desc.maximum_size )));
                     if( print_edit )then
                        s := s & "<td>" & Make_Ajax_Call_Indexed( 
                           action => action,
                           key    => key,
                           row             => row,
                           lang            => buff.lang,
                           ajax_target_key => ajax_target_key ) & "</td>"; 
                     else
                        s := s & "<td></td>";
                     end if;
                  end loop;
                  s := s & INDENT & INDENT & "</tr>" & LINE_BREAK;
               end loop each_index;
               s := s & INDENT & "</tbody>" & LINE_BREAK & "</table>" & LINE_BREAK;
            end; -- local declarations
         when enumerated_type =>
            declare
               parameter  : Parameter_Rec;
               index_enum : Enumerated_Type_Rec := 
                  Enum_Search.Get_Enum( complete_sys, To_String( complete_value.reference_desc.index_enum_type_ref ));
               ev         : Enum_Value_Rec;
               n          : constant Natural := Natural( index_enum.values.Length );
               num_params : constant Natural := Natural( complete_value.system_desc.parameters.Length );  
            begin
               s := s & "<table class='editable_table' id='table-" & key & "'> " & LINE_BREAK;
               s := s & INDENT & "<tbody>" & LINE_BREAK;
               s := s & INDENT & INDENT & "<tr><th></th>" & LINE_BREAK;
               for pno in 1 .. num_params loop
                  parameter := complete_value.system_desc.parameters.Element( pno );
                  s := s & INDENT & INDENT & INDENT & "<th>" & parameter.Description( label, buff.lang ) & 
                           "<br/>" & Units_String( parameter.logical_type, parameter.units, buff.lang ) &
                           "</th>" & LINE_BREAK;
               end loop;   
               s := s & INDENT & INDENT & "</tr>" & LINE_BREAK;
               each_enum_value:
               for row in 1 .. n loop
                  ev := index_enum.values.Element( row );
                  s := s & INDENT & INDENT & "<tr id='" & key & "_row_" & ev.name & "' >" & LINE_BREAK;
                  s := s & INDENT & INDENT & INDENT & "<td>" & ev.text( buff.lang ) & "</td>" & LINE_BREAK;
                  each_param2:
                  for pno in 1 .. num_params loop
                     declare
                        index_key     : Unbounded_String;
                        val_and_err   : Value_And_Error_Access;
                        cell          : Unbounded_String;
                        enum          : Enumerated_Type_Rec;
                     begin
                        parameter := complete_value.system_desc.parameters.Element( pno );
                        if( To_String( parameter.enum_type_ref ) /= "" )then
                           enum := Enum_Search.Get_Enum( complete_sys, To_String( parameter.enum_type_ref ));
                        end if;
                        index_key := Line_Extractor.Make_Key( key, row, parameter.instance_name );
                        index_key := Censor_Id( index_key );
                        val_and_err := Get_Value_And_Error( 
                           param_and_value => complete_value,
                           index           => row,
                           postfix         => parameter.name );
                        cell := Create_Single_Input( 
                           key              => index_key,
                           lang             => buff.lang,
                           param_desc       => parameter,
                           val_and_err      => val_and_err.all,
                           enum_type        => enum,
                           do_complete_row  => False,
                           print_static_only => print_static_only,
                           print_all         => print_all );
                        s := s & INDENT & INDENT & INDENT & "<td>" & cell & "</td>";
                     end;
                     s := s & LINE_BREAK;
                  end loop each_param2;
                  s := s & INDENT & INDENT & "</tr>" & LINE_BREAK;
               end loop each_enum_value;                    
               s := s & INDENT & "</tbody>" & LINE_BREAK & "</table>" & LINE_BREAK;
            end; -- declare
          when string_type => --
            Raise_Exception( Param_Exception'Identity, 
               "Parameter-System.Input_Buffer : list of params using string index is not inplemented key:" & To_String( key ));
       end case;
       return s;
   end Make_Indexed_Block;

   function Make_Single_Array_List(
      complete_sys      : Parameter_System_Rec;
      parameter         : Parameter_Rec;
      key               : Unbounded_String;
      buff              : Buffer ) return Unbounded_String is
   use Ada.Exceptions; 
   use Text_Utils;
      s : Unbounded_String;
      INDENT : constant String := "  ";
      complete_value : Complete_Param_And_Value_Rec;
   begin
      Log( "Make_Indexed_Block; Looking for key |" & TS( key ) & "| " );
      complete_value := buff.params.Element( key );
      case complete_value.reference_desc.index_type is
         when none => 
            Raise_Exception( Param_Exception'Identity, 
              "Parameter-System.Input_Buffer : inconsistent state list: but no collection type key:" & To_String( key ));
         when integer_type =>
            Raise_Exception( Param_Exception'Identity, 
               "Parameter-System.Input_Buffer : list of params using integer index is not inplemented key:" & To_String( key ));
         when enumerated_type =>
            declare
               index_enum : Enumerated_Type_Rec := 
                  Enum_Search.Get_Enum( complete_sys, To_String( parameter.index_enum_type_ref ));
               ev         : Enum_Value_Rec;
               n          : constant Natural := Natural( index_enum.values.Length );
            begin
               s := s & "<table> " & LINE_BREAK;
               s := s & INDENT & "<tbody>" & LINE_BREAK;
               s := s & INDENT & INDENT & "<tr><th></th>" & LINE_BREAK;
               s := s & INDENT & INDENT & INDENT & "<th>" & parameter.Description( label, buff.lang ) & 
                        "<br/>" & Units_String( parameter.logical_type, parameter.units, buff.lang ) &
                        "</th>" & LINE_BREAK;
               s := s & INDENT & INDENT & "</tr>" & LINE_BREAK;
               each_enum_value:
               for row in 1 .. n loop
                  ev := index_enum.values.Element( row );
                  s := s & INDENT & INDENT & "<tr id='" & key & "_row_" & ev.name & "' >" & LINE_BREAK;
                  s := s & INDENT & INDENT & INDENT & "<td>" & ev.text( buff.lang ) & "</td>" & LINE_BREAK;
                  declare
                     index_key     : Unbounded_String;
                     val_and_err   : Value_And_Error_Access;
                     cell          : Unbounded_String;
                     enum          : Enumerated_Type_Rec;
                  begin
                     index_key := Line_Extractor.Make_Key( key, row, parameter.instance_name );
                     index_key := Censor_Id( index_key );
                     val_and_err := Get_Value_And_Error( 
                        param_and_value => complete_value,
                        index           => row,
                        postfix         => parameter.name );
                     cell := Create_Single_Input( 
                        key               => index_key,
                        lang              => buff.lang,
                        param_desc        => parameter,
                        val_and_err       => val_and_err.all,
                        enum_type         => enum,
                        do_complete_row   => False,
                        print_static_only => True,
                        make_hidden       => parameter.edit_info.display = hidden,
                        print_all         => True );
                     s := s & INDENT & INDENT & INDENT & "<td>" & cell & "</td>";
                  end;
                  s := s & LINE_BREAK;
                  s := s & INDENT & INDENT & "</tr>" & LINE_BREAK;
               end loop each_enum_value;                    
               s := s & INDENT & "</tbody>" & LINE_BREAK & "</table>" & LINE_BREAK;
            end; -- declare
          when string_type => --
            Raise_Exception( Param_Exception'Identity, 
               "Parameter-System.Input_Buffer : list of params using string index is not inplemented key:" & To_String( key ));
       end case;
       return s;
   end Make_Single_Array_List;

   
   procedure Create_HTML_Inputs( 
      html_cells         : in out Templates_Parser.Vector_Tag;
      buff               : Buffer;
      base_sys           : Parameter_System_Rec; 
      sys                : Parameter_System_Rec; 
      parameter_prefix   : Unbounded_String;
      print_static_only : Boolean := False; 
      print_all         : Boolean := False ) is

   prefix_copy : Unbounded_String := parameter_prefix;
   
   use Text_Utils.String_Maps_Package;
   use Ada.Exceptions; 
   use Templates_Parser;
   use Utils;
      num_params : constant Natural := Natural( sys.parameters.Length );  

   begin
      
      if( print_static_only ) and ( num_params > 0 )then
         html_cells := html_cells & "<tr><td colspan='3' align='middle'><h2>" & sys.Description( label, buff.lang ) & "</h2></td></tr>";
      end if;
      
      Iterate_Parameters:
      declare
      use Parameter_Rec_Package;
         parameter  : Parameter_Rec;
         key        : Unbounded_String;
         html       : Unbounded_String;
       begin
         for pno in 1 .. num_params loop
            parameter := sys.parameters.Element( pno );
            -- FIXME MISSING array params 
            if( parameter.edit_info.display = label_only )then
               html := 
                  TuS( "<tr><td colspan='2' align='middle'><h3>" ) & 
                  parameter.Description( label, buff.lang ) & 
                  "</h3></td></tr>"; 
               html_cells := html_cells & html;              
            else
               case parameter.collection_type is
                  when singular =>
                     declare
                        complete_value : Complete_Param_And_Value_Rec;
                     begin
                        key := parameter_prefix & DELIMITER & parameter.instance_name;
                        Log( "Iterate_Parameters; looking for key |" & To_String( key )); -- & "| Keys Are |" & Print_Keys( buff.params ));
                        complete_value := buff.params.Element( key );
                        
                        html := Create_Single_Input( 
                              key               => key,
                              lang              => buff.lang,
                              param_desc        => complete_value.param_desc,
                              val_and_err       => complete_value.val.all,
                              enum_type         => complete_value.enum_type,
                              do_complete_row   => True,
                              make_hidden       => parameter.edit_info.display = hidden,
                              print_static_only => print_static_only,
                              print_all         => print_all );
                        html_cells := html_cells & html;
                        -- if( complete_value.on_display_handler /= null ) and then 
                                -- ( complete_value.val.error = no_error ) then
                           -- complete_value.on_display_handler.all( buff ); 
                        -- end if;
                     end;
               when list =>
                     html := Make_Single_Array_List(
                        complete_sys => base_sys,
                        parameter    => parameter,
                        key          => key,
                        buff         => buff );
                     html_cells := html_cells & html;
               when set | map =>   
                  Raise_Exception( Param_Exception'Identity, 
                      "Parameter-System.Input_Buffer : non param as set or list is not inplemented parameter" & To_String( key ));
               end case;
            end if;
         end loop;
      end Iterate_Parameters;
      
      Iterate_References:
      declare
      use Parameter_System_Reference_Rec_Package;  
      use Parameter_Rec_Package;
         num_references : constant Natural := Natural( sys.parameter_system_references.Length );  
         key            : Unbounded_String;
         ref            : Parameter_System_Reference_Rec;
         row            : Unbounded_String;
         ajax_target    : Unbounded_String;
      begin
         for rno in 1 .. num_references loop
            ref := sys.parameter_system_references.Element( rno );
            key := parameter_prefix & DELIMITER & ref.instance_name;
            ajax_target := key & "_td";
            Log( "Iterate_References; looking for key " & TS( key ));
            row := TuS( "<tr id='" ) & key & "_tr' class='input_table_block'><td id='" & ajax_target & "' >" & LINE_BREAK &
            Make_Indexed_Block(
               complete_sys      => base_sys,
               key               => key,
               buff              => buff,
               ajax_target_key   => ajax_target,
               print_static_only => print_static_only,
               print_all         => print_all ) & LINE_BREAK &
               "</td></tr>" & 
               LINE_BREAK;
            html_cells := html_cells & row;
         end loop;
      end Iterate_References;
      
      Iterate_Subsystems:
      declare
         use Parameter_System_Rec_Package;
         subsys : Parameter_System_Rec;
         num_subsystems : constant Natural := Natural( sys.parameter_systems.Length );
      begin
         for sno in 1 .. num_subsystems loop
            subsys := sys.parameter_systems.Element( sno ).all;
            if( subsys.instance_name /= Null_Unbounded_String ) then
               Create_HTML_Inputs(
                  html_cells,
                  buff,
                  base_sys,
                  subsys,
                  parameter_prefix & DELIMITER & subsys.instance_name,
                  print_static_only,
                  print_all );
               end if;
         end loop;
      
      end Iterate_Subsystems;
   
   end Create_HTML_Inputs;
   

   function Create_Static_Page(
      buff                : Buffer;
      sys                 : Parameter_System_Rec; 
      parameter_prefix   : Unbounded_String ) return Unbounded_String is
   use Templates_Parser;
      html_cells    : Templates_Parser.Vector_Tag;
      translations  : Translate_Set;
   begin
      Create_HTML_Inputs( 
         html_cells,
         buff,
         sys, 
         sys,
         buff.year_prefix_str & parameter_prefix,
         True,
         False );   
         
      Insert( translations, Assoc( "YEAR", buff.Get_Current_Year ));
      Insert( translations, Assoc( "INPUT-CELL", html_cells ));
      return Web_Utils.Parse_Template( template_components_path & 
         Dir_Separator & "static_input_one_year", translations );               
    end Create_Static_Page;
   
   function Create_Complete_Translations( 
      title               : Unbounded_String;
      buff                : Buffer;
      model_menu          : Unbounded_String;
      breadcrumb          : Unbounded_String;
      base_sys            : Parameter_System_Rec; 
      sys                 : Parameter_System_Rec; 
      parameter_prefix    : Unbounded_String;
      main_error_message  : Unbounded_String;
      job_is_running      : Boolean;
      extra_translations  : Templates_Parser.Translate_Set ) return Translate_Set is
   use Templates_Parser;
      html_cells    : Templates_Parser.Vector_Tag;
      translations  : Translate_Set;
   begin
      Log( "create input page " & " buff.year_prefix_str " & TS( buff.year_prefix_str ) &
           " parameter_prefix " & TS( parameter_prefix ));
      Create_HTML_Inputs( 
         html_cells,
         buff,
         base_sys, 
         sys,
         buff.year_prefix_str & parameter_prefix  );   
      Insert( translations, extra_translations );
      Insert( translations, Assoc( "TITLE", title ));
      Insert( translations, Assoc( "MAIN-HELP", "MAIN HELP GOES HERE" ));
      Insert( translations, Assoc( "MODEL-MENU", model_menu ));
      Insert( translations, Assoc( "BREADCRUMB", breadcrumb ));
      Insert( translations, Assoc( "INFORMATION", Lookup( "Information", buff.lang ) ));
      Insert( translations, Assoc( "ROOT", web_root ));
      Insert( translations, Assoc( "LANG", Censor_String( buff.lang'Img )));
      Insert( translations, Assoc( "IS_INPUT_PAGE", True ));
      Insert( translations, Assoc( "HEADER", sys.Description( label, buff.lang )));
      Insert( translations, Assoc( "INPUT-CELL", html_cells ));
      return translations;
   end Create_Complete_Translations;
   
   function Create_Input_Page(
      title               : Unbounded_String;
      buff                : Buffer;
      model_menu          : Unbounded_String;
      breadcrumb          : Unbounded_String;
      base_sys            : Parameter_System_Rec; 
      sys                 : Parameter_System_Rec; 
      parameter_prefix    : Unbounded_String;
      main_error_message  : Unbounded_String;
      job_is_running      : Boolean;
      extra_translations  : Templates_Parser.Translate_Set ) return Unbounded_String is
   use Templates_Parser;
      html_cells    : Templates_Parser.Vector_Tag;
      translations  : Translate_Set := 
            Create_Complete_Translations( 
               title, 
               buff, 
               model_menu, 
               breadcrumb, 
               base_sys, 
               sys, 
               parameter_prefix,
               main_error_message,
               job_is_running,
               extra_translations );
   begin
      return Web_Utils.Parse_Template( template_components_path & dir_separator & "input", translations );      
   end Create_Input_Page;
  
end Parameter_System.Input_Buffer.HTML_Renderer;
