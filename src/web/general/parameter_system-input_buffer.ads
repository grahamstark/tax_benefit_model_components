with AWS.Parameters;
-- with AWS.Log;
with Ada.Calendar;
with Ada.Containers.Hashed_Maps;
with Ada.Containers.Ordered_Maps;
with Ada.Strings.Unbounded;
with Ada.Calendar;

with Format_Utils;
with Keyed_Text_Buffer;
with Text_Utils;
with Utils;
with Parameter_System_IO_Commons;


generic
   --
   -- fixme better with separators
   --
   with procedure Operate( c : in out Float_Type; m : Float_Type; rec : Parameter_Rec; which_operation : Integer := 0 );
   
   with function Format( c : Float_Type; lang : Languages ) return String; -- FIXME precision
   with function Format( c : Integer; lang : Languages ) return String;
   with function Format( b : Boolean; lang : Languages ) return String;
   with procedure Validate(
      input_str : String;
      lang      : Languages;
      val       : out Float_Type;
      message   : out Unbounded_String;
      error     : out Utils.Error_Type;
      min       : Float_Type := Float_Type'First;
      max       : Float_Type := Float_Type'Last );
      
   with procedure Validate(
      input_str : String;
      lang      : Languages;
      val       : out Integer;
      message   : out Unbounded_String;
      error     : out Utils.Error_Type;
      min       : Integer := Integer'First;
      max       : Integer:= Integer'Last );
      --- add a boolean validate
      
   with function Lookup( key : String; lang : Languages ) return String;
   -- with procedure Log( s : String ) is;
      
package Parameter_System.Input_Buffer is
   
   use Ada.Calendar;
   use Parameter_System_IO_Commons;
   
   --
   -- Essentially, a flat list. one per parameter in the whole system
   -- with keys representing the heirarchical path to each element in each subsystem.
   -- 
   type Buffer is tagged private;
   
   --
   -- (slight) hack for multi-year versions
   --
   procedure Set_Year_Range( buff : in out Buffer; yp : String; start_yr, end_yr : Year_Number );

   --
   -- needed for AWS Session storage
   --
   function Get_Null_Buffer return Buffer;
   
   function Get_Current_Collection_Size(
      buff    : Buffer; 
      key     : Unbounded_String ) return Natural;
   
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) return Float_Type;
      
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Integer;
      
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String;
      
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Boolean;

   procedure Add( 
      buff : in out Buffer; 
      key : Unbounded_String; 
      pos : Positive );
      
   procedure Delete( 
      buff        : in out Buffer; 
      key         : Unbounded_String; 
      delete_pos  : Positive );
   
   function Maximum_Collection_Size( 
      buff : Buffer; 
      key : Unbounded_String ) return Natural;
      
      
   function Get_Formatted( 
      buff : Buffer; 
      key  : Unbounded_String ) return Unbounded_String;
      
   function Get_Error_Message( 
      buff : Buffer; 
      key : Unbounded_String;
      index : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String
      ) return Unbounded_String;

   function Get_Num_Errors( buff : Buffer ) return Natural;

   procedure Set_Language( 
      buff     : in out Buffer; 
      lang     : Languages );
      
   --
   -- load the buffer with the values contained in the defaults hashmap
   -- FIXME: the sys parameter shouldn't really be needed here; we just need to match the buffer
   -- against the keys in defaults.
   -- 
   procedure Load( 
      buff          : in out Buffer; 
      global_system : Parameter_System_Rec; 
      target_system : Parameter_System_Rec; 
      values        : Keyed_Text_Buffer.Text_Buffer;
      defaults      : Keyed_Text_Buffer.Text_Buffer;
      prefix        : Unbounded_String;
      year          : Year_Number := Year_Number'First  );
     
   
   function To_Text_Buffer( buff : Buffer; which : Buffer_Retrieval_Type; matching : Unbounded_String := Null_Unbounded_String ) return Keyed_Text_Buffer.Text_Buffer;
   function To_Text_Buffer( buff : Buffer; which : Buffer_Retrieval_Type; start_year : Year_Number; end_year : Year_Number ) return Keyed_Text_Buffer.Text_Buffer;

   function Init( 
      language              : Languages; 
      system_structure      : Parameter_System_Rec; 
      hashmap_of_parameters : Keyed_Text_Buffer.Text_Buffer;
      default_hashmap       : Keyed_Text_Buffer.Text_Buffer;
      start_year            : Year_Number := Year_Number'First;
      end_year              : Year_Number := Year_Number'First;
      year_prefix           : Unbounded_String := Null_Unbounded_String ) return Buffer;
   
   procedure Load( 
      buff   : in out Buffer;  
      params : in AWS.Parameters.List;
      year   : in Year_Number := Year_Number'First ); 

   procedure Set_Delimiter( del : Character );
   
   procedure Operate( 
      buff     : in out Buffer; 
      prefix   : Unbounded_String;
      m        : Float_Type;
      which_operation : Integer := 0;
      start_year : Year_Number := Year_Number'First;
      end_year   : Year_Number := Year_Number'Last ); 
      
       
      
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Float_Type; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String );
   
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Boolean; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String );
      
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Integer; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String );

   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Unbounded_String; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String );
      

   procedure Replace_Enum( 
      buff      : in out Buffer; 
      key       : Unbounded_String;
      enum_type : Enumerated_Type_Rec );

   function Get_Enum( 
      buff      : Buffer; 
      key       : Unbounded_String ) return Enumerated_Type_Rec;

      -- TODO Lots more of these get/sets
    
   type Handler_Access_T is access procedure( buff : in out Buffer );
   type Handler_Type is ( on_display, on_change );

   procedure Set_Handler( 
      buff    : in out Buffer;
      target  : Unbounded_String;
      handler : Handler_Access_T;
      htype   : Handler_Type ); 
   procedure Set_Current_Year( buff : in out Buffer; year : Year_Number );
   
   function Get_Current_Year( buff : Buffer ) return Year_Number;
   
   function Year_Prefix_Str( buff : Buffer ) return Unbounded_String;
   
   function Print_Keys( buff : Buffer ) return String;
 
private   

   use Ada.Strings.Unbounded;
   
   type Value_And_Error( dtype : Data_Kind ) is record
      text                      : Unbounded_String := Null_Unbounded_String;
      error_message : Unbounded_String := Null_Unbounded_String;
      error         : Utils.Error_Type := Utils.No_Error;
      case dtype is
         when real_type       => rval, rdefault  : Float_Type        := 0.0;
         when integer_type    => ival, idefault  : Integer           := 0;
         when enumerated_type => eval, edefault  : Unbounded_String  := Null_Unbounded_String; 
         when boolean_type    => bval, bdefault  : Boolean           := False;
         when string_type     => sval, sdefault  : Unbounded_String  := Null_Unbounded_String;
         when date_type       => cval, cdefault  : Time;
         when decimal_type    => dval, ddefault  : Counter_Type;
      end case;
   end record;
   
   function To_String( ve : Value_And_Error ) return String;
   
   function Is_Changed( val_and_err : Value_And_Error ) return Boolean;

   type Value_And_Error_Access is access Value_And_Error;
   
   package Value_And_Error_Vector_Package is new Ada.Containers.Vectors( 
      Element_Type => Value_And_Error_Access, 
      Index_Type => Positive );
   subtype Value_And_Error_Vector is Value_And_Error_Vector_Package.Vector;
   
   function To_String( vev : Value_And_Error_Vector ) return String;
 
   function Compare_Value_And_Error_Vector( v1, v2 : Value_And_Error_Vector ) return Boolean;
 
   package Value_And_Error_Map_Package is new Ada.Containers.Hashed_Maps(
       Key_Type        => Unbounded_String, 
       Element_Type    => Value_And_Error_Vector,
       Hash            => Text_Utils.Hash_String,
       "="             => Compare_Value_And_Error_Vector,
       Equivalent_Keys => Text_Utils.Compare_String
   );

   subtype Value_And_Error_Map is Value_And_Error_Map_Package.Map;
   
   subtype Priority_Value is Float range 1.0 .. 5.0;
   
   type Collection_Type is ( single, single_array, map_of_arrays );
   
   
   
   type Complete_Param_And_Value_Rec( etype : Collection_Type := single ) is record
      enum_type          : Enumerated_Type_Rec;
      index_enum_type    : Enumerated_Type_Rec;
      priority           : Priority_Value;
      on_change_handler  : Handler_Access_T := null;
      on_display_handler : Handler_Access_T := null;
      case etype is
      when single        => 
         val         : Value_And_Error_Access;
         param_desc  : Parameter_Rec;
      when single_array  => 
         vallist     : Value_And_Error_Vector;
         array_param_desc  : Parameter_Rec;
      when map_of_arrays => 
         valmap         : Value_And_Error_Map;
         current_size   : Natural := 0;
         is_enumerated  : Boolean := False;
         system_desc    : Parameter_System_Rec;
         reference_desc : Parameter_System_Reference_Rec;
         index_strings  : Text_Utils.Unbounded_String_List;         
      end case;
   end record;
   
   function To_String( cpvr : Complete_Param_And_Value_Rec ) return String;
      
   function Compare_Params( 
      p1 : Complete_Param_And_Value_Rec; 
      p2 : Complete_Param_And_Value_Rec ) return Boolean;
      
   package Complete_Param_And_Value_Maps_Package is new Ada.Containers.Hashed_Maps(
       Key_Type        => Unbounded_String, 
       Element_Type    => Complete_Param_And_Value_Rec,
       Hash            => Text_Utils.Hash_String,
       -- "="             => Compare_Params,
       Equivalent_Keys => Text_Utils.Compare_String
   );

   subtype Complete_Param_And_Value_Map is Complete_Param_And_Value_Maps_Package.Map;
   function Print_Keys( map : Complete_Param_And_Value_Map ) return String;
   
   type Buffer is tagged record
      is_null_buffer : Boolean := False;
      lang    : Languages := Languages'First;
      params  : Complete_Param_And_Value_Map;
      current_year : Year_Number := Year_Number'First;
      first_possible_year    : Year_Number := Year_Number'First;
      last_possible_year     : Year_Number := Year_Number'First;
      year_prefix  : Unbounded_String := Null_Unbounded_String;
   end record;
   
   -- override the supplied format routines;
   -- this formats them as std numbers, not nice things
   -- with comments 
   package Local_Format_Utils is new Format_Utils( 
      Float_Type=>Float_Type, 
      Counter_Type=>Counter_Type );
   
   
   function Get_Value_And_Error( 
      param_and_value     : Complete_Param_And_Value_Rec; 
      index               : Natural := 0; 
      postfix             : Unbounded_String := Null_Unbounded_String ) return Value_And_Error_Access;
   
   function Get_Value_And_Error( 
      buff : Buffer; 
      key : Unbounded_String; 
      index : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Value_And_Error_Access;

   function Get_Parameter_Rec( 
      buff : Buffer; 
      key : Unbounded_String; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Parameter_Rec;

   function Has_Years( buff : Buffer ) return Boolean;   
   function Year_Prefix_Str( buff : Buffer; year : Year_Number ) return Unbounded_String;

end Parameter_System.Input_Buffer;
