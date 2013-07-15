with Base_Model_Types;      
with Ada.Strings.Unbounded; 

with format_utils;
with AWS.Parameters;
with Text_IO;
with Utils;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings;
--
--
--
--
package body HTML_Utils is



   package Local_Format is new Format_Utils( Float_Type=>Rate, Counter_Type=>Counter_Type );
   use Local_Format;
   use type Utils.Error_Type;
   use Base_Model_Types;
   use Text_Utils;
   use Ada.Strings.Unbounded;
   html_type : HTML_Kind;
   
   procedure Set_HTML_Type( t : HTML_Kind ) is
   begin
      html_type := t;
   end Set_HTML_Type;
      
   MAX_MESSAGE_LENGTH : constant := 120;
   
   function Contains_Value( table : AWS.Parameters.List; value : String ) return Boolean is
      table_size : Integer := AWS.Parameters.Count (table);
   begin
      for i in  1 .. table_size loop
          if( AWS.Parameters.Get( table, i ).Value = value )then            
            return True;
         end if;
      end loop;
      return False;
   end Contains_Value;
   
   function Dump( table : AWS.Parameters.List ) return String is
      table_size : Integer := AWS.Parameters.Count (table);
      s : Unbounded_String;
   begin
      for i in  1 .. table_size loop
         s := s & AWS.Parameters.Get( table, i ).Name & "=" & AWS.Parameters.Get( table, i ).Value;
         if( i < table_size )then
            s := s & "&";
         end if;
      end loop;
      return TS( s );
   end Dump;
   
   function Contains_Key( table : AWS.Parameters.List; key : String ) return Boolean is
      table_size : Integer := AWS.Parameters.Count (table);
   begin
      return AWS.Parameters.Exist( table, key );
      -- 
      -- for i in  1 .. table_size loop
          -- if( AWS.Parameters.Get( table, i ).Name = key )then            
            -- return True;
         -- end if;
      -- end loop;
      -- return False;
   end Contains_Key;

   function Reverse_Table_Lookup( table : AWS.Parameters.List; value : String ) return String is
      table_size : Integer := AWS.Parameters.Count( table );
   begin
      for i in  1 .. table_size loop
          if( AWS.Parameters.Get (table, i).Value = value )then
            return AWS.Parameters.Get( table, i ).Name;
         end if;
      end loop;
      return "";
   end Reverse_Table_Lookup;

   function Make_Input
     (varname    : String;
      value      : Unbounded_String;
      class      : String         := "";
      size       : Integer        := 12;
      extras     : String         := "";
      help       : String         := "";
      has_error  : Boolean        := False;
      error_text : Unbounded_String := Null_Unbounded_String )
      return       String
   is
      s : Unbounded_String :=
         To_Unbounded_String
           ("<input type='text' size='" & format (size) & "' name='" & varname & "' id='"& varname & "'" );
   begin
      if( class /= "")then
         s := s & " class='" & class & "' ";
      end if;
      if( extras /= "")then
         s := s & extras;
      end if;
      if( help /= "")then
         s := s & " alt='" & help & "' ";
      end if;
      s := s & " value='" & To_String (value) & "' ";
      s := s & " />";
      if( has_error)then
         s := s & "<br/>";
         s := s & "<span class='error'>" & error_text & "</span>";
      end if;
      return To_String (s);
   end Make_Input;

   function Make_Select
     (varname, selected : String;
      options           : OptionsStr;
      values            : OptionsStr;
      class             : String := "";
      extras            : String := "";
      help              : String := "")
      return              String
   is
      s : Unbounded_String := To_Unbounded_String ("<select" & " name='" & varname & "' id='" & varname & "' ");
   begin
      if( class /= "")then
         s := s & "class='" & class & "' ";
      end if;
      if( extras /= "")then
         s := s & extras;
      end if;
      if( help /= "")then
         s := s & " alt='" & help & "' ";
      end if;

      s := s & ">";
      for i in  1 .. options'Length loop
         s := s & "<option ";
         if( To_Unbounded_String (selected) = values(i) )then
            s := s & " selected = 'selected' ";
         end if;
         s := s &
              " value='" &
              To_String (values (i)) &
              "'>" &
              To_String (options (i)) &
              "</option>";
      end loop;
      s := s & "</select>";
      return To_String (s);
   end Make_Select;

   -- package Screen_Data_Session_Data is new AWS.Session.Generic_Data ( Inputs_Rec );

   function Make_Radio(
      varname           : String;
      selected          : String;
      options           : OptionsStr;
      values            : OptionsStr;
      class             : String := "";
      extras            : String := "";
      help              : String := "")
      return              String
   is
      s : Unbounded_String := Null_Unbounded_String;
   begin
      for i in  1 .. options'Length loop
         s := s & "<input type='radio' name='" & varname & "' id='" & varname & "' ";
         if( class /= "")then
            s := s & "class='" & class & "' ";
         end if;
         if( extras /= "")then
            s := s & extras;
         end if;
         if( help /= "")then
            s := s & " alt='" & help & "' ";
         end if;
         if( selected = values( i ))then
            s := s & " checked='checked' ";
         end if;
         s := s & " value='" & To_String (values (i)) & "' />" & To_String (options (i));
         --  "</input>";
      end loop;
      return To_String (s);
   end Make_Radio;

     
   function Make_Checkbox
     (varname : String;
      checked : Boolean;
      class   : String := "";
      extras  : String := "";
      help    : String := "")
      return    String
   is
      s : Unbounded_String := Null_Unbounded_String;
   begin
      s := s & "<input type='checkbox' name='" & varname & "' id='" & varname & "' ";
      if( class /= "")then
         s := s & "class='" & class & "' ";
      end if;
      if( extras /= "")then
         s := s & extras;
      end if;
      if( help /= "")then
         s := s & " alt='" & help & "' ";
      end if;
      if( checked)then
         s := s & " checked='checked' ";
      end if;
      s := s & " />";
      return To_String (s);
   end Make_Checkbox;

   --
   --   Does several (too many?) things at once:
   --   1) parses the value of Param_String if Param_String is true and sets value to that if
   --  there is no error
   --   2) makes an html input element, possibly with an attached error condition
   procedure Make_One_Input
     (varname        : String;
      Output_Str     : in out Unbounded_String;
      value          : in out Counter_Type;
      Default_Value  : Counter_Type;
      help           : String  := "";
      Param_String   : String;
      Param_Is_Set   : Boolean := False;
      min            : Counter_Type   := Counter_Type'First;
      max            : Counter_Type   := Counter_Type'Last;
      is_error       : in out Boolean)
   is

      valueStr : Unbounded_String;
      class    : Unbounded_String := To_Unbounded_String ("normal_input");
      message  : Unbounded_String;
      x        : Counter_Type          := 0.0;
      error    : Utils.Error_Type;
   begin
      is_error := False;
      if( Param_Is_Set)then
         Validate( Param_String, x, message, error, min => min, max => max );

         valueStr := To_Unbounded_String (Param_String);
         if(  error /= Utils.No_Error )then
            class    := To_Unbounded_String ("error_input");
            is_error := True;
         else
            value := x;
         end if;
      end if;
      if( not is_error)then
         if( value /= Default_Value)then
            class := To_Unbounded_String ("changed_input");
         end if;
         valueStr := To_Unbounded_String (format (value));
      end if;

      Output_Str :=
         To_Unbounded_String
           (Make_Input
               (varname    => varname,
                value      => valueStr,
                class      => To_String (class),
                help       => help,
                has_error  => is_error,
                error_text => message));

   end Make_One_Input;

   --
   --   Does several (too many?) things at once:
   --   1) parses the value of Param_String if Param_String is true and sets value to that if
   --  there is no error
   --   2) makes an html input element, possibly with an attached error condition
   --
   procedure Make_One_Input
     (varname       : String;
      Output_Str    : in out Unbounded_String;
      value         : in out Rate;
      Default_Value : Rate;
      help          : String  := "";
      Param_String  : String;
      Param_Is_Set  : Boolean := False;
      min           : Rate    := -100.0;
      max           : Rate    := 100.0;
      is_percent    : Boolean := False;
      is_error      : in out Boolean;
      prec          : Natural := 2 )
   is

      valueStr : Unbounded_String;
      class    : Unbounded_String := To_Unbounded_String ("normal_input");
      message  : Unbounded_String;
      x        : Rate           := 0.0;
      error    : Utils.Error_Type;
   begin
      is_error := False;
      if( Param_Is_Set)then
         valueStr := To_Unbounded_String (Param_String);
         validate (Param_String, x, message, error, min => min, max => max);
         if(  error /= Utils.No_Error )then
            class    := To_Unbounded_String ("error_input");
            is_error := True;
         else
            value := x;
            if( is_percent)then
               value := value / 100.0;
            end if;
         end if;
      end if;
      if( not is_error)then
         if( value /= Default_Value)then
            class := To_Unbounded_String ("changed_input");
         end if;
         if( is_percent)then
            valueStr := To_Unbounded_String (format( value * 100.0, prec ));
         else
            valueStr := To_Unbounded_String (format(value, prec ));
         end if;
      end if;

      Output_Str :=
         To_Unbounded_String
           (Make_Input
               (varname    => varname,
                value      => valueStr,
                class      => To_String (class),
                help       => help,
                has_error  => is_error,
                error_text => message));
   end Make_One_Input;

   procedure Make_One_Input
     (varname       : String;
      Output_Str    : in out Unbounded_String;
      value         : in out Integer;
      Default_Value : Integer;
      help          : String  := "";
      Param_String  : String  := "";
      Param_Is_Set  : Boolean := False;
      min           : Integer := Integer'First;
      max           : Integer := Integer'Last;
      is_error      : in out Boolean)
   is

      valueStr : Unbounded_String;
      class    : Unbounded_String := To_Unbounded_String ("normal_input");
      message  : Unbounded_String;
      x        : Integer        := 0;
      error    : Utils.Error_Type;
   begin
      is_error := False;
      if( Param_Is_Set)then
         valueStr := To_Unbounded_String (Param_String);
         validate (Param_String, x, message, error, min => min, max => max);
         if(  error /= Utils.No_Error )then
            class    := To_Unbounded_String ("error_input");
            is_error := True;
         else
            value := x;
         end if;
      end if;
      if( not is_error)then
         if( value /= Default_Value)then
            class := To_Unbounded_String ("changed_input");
         end if;

         valueStr := To_Unbounded_String (value'Img);
      end if;
      Output_Str :=
         To_Unbounded_String
           (Make_Input
               (varname    => varname,
                value      => valueStr,
                class      => To_String (class),
                help       => help,
                has_error  => is_error,
                error_text => message));
   end Make_One_Input;

   procedure Make_One_String_Input
     (varname      : String;
      Output_Str    : in out Unbounded_String;
      value        : in out Unbounded_String;
      Default_Value : Unbounded_String := Null_Unbounded_String;
      help         : String         := "";
      Param_String  : Unbounded_String := Null_Unbounded_String;
      Param_Is_Set   : Boolean        := False;
      is_error     : in out Boolean;
      size         : Integer)
   is
      class   : Unbounded_String := To_Unbounded_String ("normal_input");
      message : Unbounded_String;
   begin
      is_error := False;
      if( Param_Is_Set )then
         value := Param_String;
      end if;
      if( not is_error)then
         if( value /= Default_Value)then
            class := To_Unbounded_String ("changed_input");
         end if;
      end if;
      Output_Str :=
         To_Unbounded_String
           (Make_Input
               (varname    => varname,
                value      => value,
                class      => To_String (class),
                help       => help,
                has_error  => is_error,
                size       => size,
                error_text => message ));
   end Make_One_String_Input;

   procedure Make_One_Input_Radio
     (varname       : String;
      Output_Str    : in out Unbounded_String;
      value         : in out Unbounded_String;
      Default_Value : Unbounded_String;
      option_names  : OptionsStr;
      option_values : OptionsStr;
      help          : String     := "";
      Param_String  : String     := "";
      Param_Is_Set  : Boolean    := False ) is
     class    : Unbounded_String  := To_Unbounded_String ( "normal_input" );
   begin
      if( Param_Is_Set )then
         value := TuS( Param_String );
      end if;

      if( value /= Default_Value)then
         class := To_Unbounded_String ("changed_input");
      end if;
      Output_Str :=
         To_Unbounded_String
           (Make_Radio
               (varname  => varname,
                selected => TS( value ),
                options  => option_names,
                values   => option_values,
                class    => To_String( class ),
                help     => help));
   end Make_One_Input_Radio;
   
   procedure Make_One_Input_Radio_2
     (varname       : String;
      Output_Str    : in out Unbounded_String;
      value         : in out T;
      Default_Value : T;
      help          : String     := "";
      Param_String  : String     := "";
      Param_Is_Set  : Boolean    := False ) is
      
      function Make_Options( as_keys : Boolean ) return OptionsStr is
         o : OptionsStr( 1 .. T'Pos( T'Last )+1 );
         p : Positive;
      begin
         for i in T loop
            p := T'Pos( i ) + 1;
            if( as_keys )then
               o( p ) := To_Unbounded_String( Text_Utils.Censor_String( T'Image( i )));
            else
               o( p ) := To_Unbounded_String( Text_Utils.Prettify_Image( T'Image( i )));
            end if;      
         end loop;
         return o;
      end Make_Options;
  
     option_names  : OptionsStr := Make_Options( as_keys => False );
     option_values : OptionsStr := Make_Options( as_keys => True );
     valstr        : Unbounded_String;   
     class         : Unbounded_String;
   begin
      if( Param_Is_Set)then
         valstr := To_Unbounded_String( Param_String );
         for i in  T'First .. T'Last loop
            if( Trim (T'Image (i), Ada.Strings.Left) = valstr)then
               value := i;
               exit;
            end if;
         end loop;
      else
         valstr := To_Unbounded_String( Censor_String( value'Img ));
      end if;

      if( value /= Default_Value)then
         class := To_Unbounded_String ("changed_input");
      end if;
      Output_Str :=
         To_Unbounded_String
           (Make_Radio
               (varname  => varname,
                selected => TS( valstr ),
                options  => option_names,
                values   => option_values,
                class    => To_String( class ),
                help     => help ));
      
   end  Make_One_Input_Radio_2;
   

   procedure Make_One_Input
     (varname      : String;
      Output_Str    : in out Unbounded_String;
      value        : in out Boolean;
      Default_Value : Boolean;
      help         : String     := "";
      Param_String  : String     := "";
      Param_Is_Set   : Boolean    := False;
      use_if_set   : Boolean    := False)
   is

      class : Unbounded_String := To_Unbounded_String ("normal_input");
   begin
      if( use_if_set)then
         value := Param_Is_Set; -- all we can test for is it's presence not its value.
      end if;
      if( value /= Default_Value)then
         class := To_Unbounded_String ("changed_input");
      end if;
      Output_Str :=
         To_Unbounded_String
           (Make_Checkbox
               (varname => varname,
                checked => value,
                class   => To_String (class),
                help    => help));
   end Make_One_Input;

   --  Make_Checkbox(
   --                  varname : String;
   --          	checked          : boolean;
   --          	class             : String := "";
   --                  extras            : String := "";
   --                  help              : String := "")

   procedure Make_One_Select_Box
     (varname       : String;
      Output_Str     : in out Unbounded_String;
      value         : in out T;
      Default_Value  : T;
      option_names  : OptionsStr;
      option_values : OptionsStr;
      help          : String  := "";
      Param_String   : String  := "";
      Param_Is_Set    : Boolean := False)
   is
      valstr : Unbounded_String;
      class  : Unbounded_String := To_Unbounded_String ("normal_input");
   begin
      if( Param_Is_Set)then
         valstr := To_Unbounded_String (Param_String);
         for i in  T'First .. T'Last loop
            if( Trim (T'Image (i), Ada.Strings.Left) = valstr)then
               value := i;
               exit;
            end if;
         end loop;
      else
         valstr := To_Unbounded_String (value'Img);
      end if;
      if( value /= Default_Value)then
         class := To_Unbounded_String ("changed_input");
      end if;
      Output_Str :=
         To_Unbounded_String
           (Make_Select
               (varname,
                To_String (valstr),
                option_names,
                option_values,
                To_String (class),
                "",
                help));
   end Make_One_Select_Box;
   
   procedure Make_One_Select_Box_2( 
      varname       : String;
      Output_Str    : in out Unbounded_String;
      value         : in out T;
      Default_Value : T;
      help          : String  := "";
      Param_String  : String  := "";
      Param_Is_Set  : Boolean := False ) is
      
      function Make_Options( as_keys : Boolean ) return OptionsStr is
         o : OptionsStr( 1 .. T'Pos( T'Last )+1 );
         p : Positive;
      begin
         for i in T loop
            p := T'Pos( i ) + 1;
            if( as_keys )then
               o( p ) := To_Unbounded_String( Text_Utils.Censor_String( T'Image( i )));
            else
               o( p ) := To_Unbounded_String( Text_Utils.Prettify_Image( T'Image( i )));
            end if;      
         end loop;
         return o;
      end Make_Options;
      
      valstr : Unbounded_String;
      class  : Unbounded_String := To_Unbounded_String ("normal_input");
      option_names  : OptionsStr := Make_Options( as_keys => False );
      option_values : OptionsStr := Make_Options( as_keys => True );
      p : Natural := 0;
   begin
      if( Param_Is_Set)then
         valstr := To_Unbounded_String( param_string );
         for i in  T'First .. T'Last loop
            p := p + 1;
            if( option_values( p ) = valstr )then
               value := i;
               exit;
            end if;
         end loop;
      else
         valstr := To_Unbounded_String( Censor_String( value'Img ));
      end if;
      if( value /= Default_Value)then
         class := To_Unbounded_String( "changed_input" );
      end if;
      Output_Str :=
         To_Unbounded_String(
            Make_Select(
                varname,
                To_String( valstr ),
                option_names,
                option_values,
                To_String( class ),
                "",
                help ));
   end Make_One_Select_Box_2;
   

end HTML_Utils;
