--
--
with Base_Model_Types; use Base_Model_Types;
with Text_Utils; 
with Ada.Strings.Unbounded;
with AWS.Parameters;
with Ada.Characters.Latin_1;

generic
 
   --
   -- A floating point type for rates.
   --    
   type Rate is digits<>;
   --
   -- 
   --
   type Counter_Type is delta <> digits<>;

package HTML_Utils is

   use Ada.Strings.Unbounded;
   package stda renames Ada.Characters.Latin_1;
   use Text_Utils;
   
   type OptionsStr is array (Positive range <>) of Unbounded_String;
   
   type HTML_Kind is ( html5, xhtml1 );
   
   procedure Set_HTML_Type( t : HTML_Kind );


   BOOLEAN_VALUES         : constant OptionsStr :=
         (To_Unbounded_String ("0"),
          To_Unbounded_String ("1"));
   DEFAULT_BOOLEAN_LABELS : constant OptionsStr :=
         (To_Unbounded_String ("No"),
          To_Unbounded_String ("Yes"));

            

        --  function tr( inp : String ) return String;

   function Make_Input
         (varname : String;
          value   : Unbounded_String;
          class   : String  := "";
          size    : Integer := 12;
          extras  : String  := "";
          help    : String  := "";
          has_error : boolean := false;
          error_text : Unbounded_String := TuS("") )
          return    String;


        function Make_Select
               (varname, selected : String;
                options           : OptionsStr;
                values            : OptionsStr;
                class             : String := "";
                extras            : String := "";
                help              : String := "")
                return              String;


        function Make_Radio
               (varname, selected : String;
                options           : OptionsStr;
                values            : OptionsStr;
                class             : String := "";
                extras            : String := "";
                help              : String := "") return String;

        --
        --   Does several (too many?) things at once:
        --   1) parses the value of Param_String if Param_String is true and sets value to that if
        --  there is no error
        --   2) makes an html input element, possibly with an attached error condition
        --
        procedure Make_One_Input
               (varname      : String;
                output_str    : in out Unbounded_String;
                value        : in out Counter_Type;
                default_value : Counter_Type;
                help         : String  := "";
                param_string  : String;
                param_is_set   : Boolean := False;
                min          : Counter_Type   := Counter_Type'First;
                max          : Counter_Type   := Counter_Type'Last;
                is_error     : in out boolean );
        --
        --   Does several (too many?) things at once:
        --   1) parses the value of Param_String if Param_String is true and sets value to that if
        --  there is no error
        --   2) makes an html input element, possibly with an attached error condition
        --
        procedure Make_One_Input
               (varname      : String;
                output_str    : in out Unbounded_String;
                value        : in out Rate;
                default_value : Rate;
                help         : String  := "";
                param_string  : String;
                param_is_set   : Boolean := False;
                min          : Rate   := -100.0;
                max          : Rate   := 100.0;
                is_percent    : boolean := false;
                is_error     : in out boolean );

       procedure Make_One_Input
               (varname      : String;
                output_str    : in out Unbounded_String;
                value        : in out Integer;
                default_value : integer;
                help         : String  := "";
                param_string  : String  := "";
                param_is_set   : Boolean := False;
                min          : integer   := integer'First;
                max          : integer   := integer'Last;
                is_error     : in out boolean);


      procedure Make_One_Input
               (varname       : String;
                output_str    : in out Unbounded_String;
                value         : in out Boolean;
                default_value : Boolean;
                help          : String     := "";
                param_string  : String     := "";
                param_is_set  : Boolean    := False;
                use_if_set    : boolean    := false );


      generic
                  type T is (<>);
      procedure Make_One_Select_Box
               (varname       : String;
                output_str    : in out Unbounded_String;
                value         : in out T;
                default_value : T;
                option_names  : OptionsStr;
                option_values : OptionsStr;
                help          : String     := "";
                param_string  : String     := "";
                param_is_set  : Boolean    := False );
        --      varname      
        -- string - only case, with no direct validation
        --
      procedure Make_One_String_Input
               (varname       : String;
                output_str    : in out Unbounded_String;
                value         : in out Unbounded_String;
                default_value : Unbounded_String := To_Unbounded_String("");
                help          : String  := "";
                param_string  : Unbounded_String  := To_Unbounded_String("");
                param_is_set  : Boolean := False;
                is_error      : in out boolean;
                size          : integer );
        --
        --  given one of aws' containters, look up the key corresponding to value, or return ""
        --  this is useful for hanling submit buttons where the value is constant and the actual target
        --  is in the action
        --
      function Reverse_Table_Lookup( table : AWS.Parameters.List; value : String ) return String;
      function Contains_Value( table : AWS.Parameters.List; value : String ) return Boolean;
      function Contains_Key( table : AWS.Parameters.List; key : String ) return Boolean;
      function Dump( table : AWS.Parameters.List ) return String;
      
end HTML_Utils;
