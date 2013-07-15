with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Text_Utils;

generic
   
   -- This is the floating type we use throughout. 
   --
   type Float_Type is digits<>;
   --
   --
   --
   type Counter_Type is delta<> digits<>;
   
   type Languages is (<>); 
   
package Parameter_System is

   use Ada.Strings.Unbounded;
   
   MAX_SAFE_REAL : constant Float_Type := Float_Type'Last; 
   
   Param_Exception : exception;
   
   procedure Set_Delimiter( del : Character );

   type Text_Block is record
   	text : Unbounded_String;
   end record;

   type Language_Texts is array( Languages ) of Unbounded_String;

   type Uprate_Kind is ( standard_uprate, dont_uprate, rooker_wise );
   type Display_Kind is ( hidden, normal, password, label_only, read_only );
   type Access_Level_Kind is ( normal, admin ); -- 'all' 
   type Check_Kind is ( dont_check, warn, halt );
   --
   -- FIXME make this and the thing that handles it generic
   --
   type Logical_Kind is ( any_kind, rate, tax_allowance, tax_band, 
                          benefit, age_limit, quickies, poverty_line, 
                          rates_and_bands );
   type Data_Kind is ( real_type, integer_type, enumerated_type, boolean_type, string_type, date_type, decimal_type );
   type Units_Kind is  (
        timeless,
        day,
        week,
        month,
        year,
        percent,
        level,
        counts,
        money,
        rate,
        no_unit );
   type Description_Kind is ( tooltip, journalese, description, label );
   type Descriptions_Array is array( Description_Kind ) of Language_Texts;
   type Index_Kind is ( none, integer_type, enumerated_type, string_type );
   type Collection_Kind is ( set, map, list, singular ); 
        
   type Edit_Info_Rec is tagged record
      enabled               : Boolean := True;
      sums_to_100           : Boolean := false;
      level_change_possible : Boolean := true;
      is_exogenous          : Boolean := false;
      uprate                : Uprate_Kind := dont_uprate;
      next                  : Float_Type := 0.0;
      display               : Display_Kind := normal;
      check                 : Check_Kind := halt;
      min                   : Float_Type := Float_Type'First;
      max                   : Float_Type := Float_Type'Last;
      prec                  : Natural := 2;
      length                : Natural := 7;
      as_array              : Boolean := False;
      topset                : Boolean := False; -- fixme change to isTopSet
      order                 : Boolean := False;
      treat_As_Percentage   : Boolean := False;
      access_level          : Access_Level_Kind := normal;
      extras                : Text_Utils.Unbounded_String_Map;
      onchange              : Unbounded_String;
   end record;
     
   type Describable is tagged record
      descriptions : Descriptions_Array := ( others => ( others => Null_Unbounded_String ));
      edit_info    : Edit_Info_Rec;
      extras        : Text_Utils.Unbounded_String_Map;
   end record;
   function Get_Extra( this : Describable; key : String ) return String;

   function Is_Hidden( this : Describable ) return Boolean;
   
   function Description( 
      this : Describable; 
      which : Description_Kind := journalese; 
      language : Languages := Languages'First ) return String;
      
   type Parameter_Rec is new Describable with record
      name          : Unbounded_String := Null_Unbounded_String;   
      instance_name : Unbounded_String := Null_Unbounded_String;
      index_type    : Index_Kind       := none;
      units         : Units_Kind       := no_unit;
      logical_type  : Logical_Kind     := any_kind;
      data_type     : Data_Kind        := real_type;
      enum_type_ref : Unbounded_String := Null_Unbounded_String;   
      index_enum_type_ref : Unbounded_String := Null_Unbounded_String;   
      collection_type : Collection_Kind := singular;
      maximum_size : Natural := 0;
   end record;   
   
   package Parameter_Rec_Package is new Ada.Containers.Vectors( 
      Element_Type => Parameter_Rec, 
      Index_Type => Positive );
   
   subtype Parameter_Rec_List is Parameter_Rec_Package.Vector;  
     
   -- type Enum_Value_Type is ( int, str );
   
   type Enum_Value_Rec is tagged record
        name       : Unbounded_String := Null_Unbounded_String;
        value      : Integer := 0;
        is_default : Boolean := False;
        text       : Language_Texts := ( others=>Null_Unbounded_String );
   end record;
        -- case vtype : Enum_Value_Type is
        --   when int => value : Integer := 0;
        --   when str => str : Unbounded_String := Null_Unbounded_String;
        -- end case;

   package Enumerated_Element_Package is new Ada.Containers.Vectors( 
      Element_Type => Enum_Value_Rec, 
      Index_Type => Positive );
      
   subtype Enum_Value_List is Enumerated_Element_Package.Vector;  
      
   type Enumerated_Type_Rec is tagged record
      id     : Unbounded_String := Null_Unbounded_String;
      name   : Unbounded_String := Null_Unbounded_String;
      values : Enum_Value_List;
   end record;
   
   function Pos_Of_Value( e : Enumerated_Type_Rec; which : Integer ) return Natural;
   procedure Set_Default_Element( e : in out Enumerated_Type_Rec; which : Integer );
   procedure Delete_Element( e : in out Enumerated_Type_Rec; which : Integer );
   procedure Clear_All_Elements( e : in out Enumerated_Type_Rec );
   procedure Add_Element( 
      e : in out Enumerated_Type_Rec; 
      after : Integer; 
      name : String; 
      value : Integer; 
      is_default : Boolean; 
      default_text : String );

   package Enumerated_Type_Package is new Ada.Containers.Vectors( 
      Element_Type => Enumerated_Type_Rec, 
      Index_Type => Positive );
      
   subtype Enumerated_Type_List is Enumerated_Type_Package.Vector;  
  
   type Parameter_System_Rec;
   
   type Parameter_System_Rec_A is access all Parameter_System_Rec;
   
   package Parameter_System_Rec_Package is new Ada.Containers.Vectors( 
      Element_Type => Parameter_System_Rec_A, 
      Index_Type => Positive );
      
   subtype Parameter_System_Rec_List is Parameter_System_Rec_Package.Vector;  

   type Parameter_System_Reference_Rec is new Describable with record
      instance_name : Unbounded_String := Null_Unbounded_String;
      index_type    : Index_Kind       := none;
      sys_type      : Unbounded_String := Null_Unbounded_String;
      index_enum_type_ref : Unbounded_String := Null_Unbounded_String;   
      collection_type : Collection_Kind := singular;
      maximum_size    : Natural := 0;
   end record;
   
   package Parameter_System_Reference_Rec_Package is new Ada.Containers.Vectors( 
      Element_Type => Parameter_System_Reference_Rec, 
      Index_Type => Positive );
      
   subtype Parameter_System_Reference_Rec_List is Parameter_System_Reference_Rec_Package.Vector;  
  
   type Parameter_System_Rec is new Describable with record
      name : Unbounded_String := Null_Unbounded_String;
      id   : Unbounded_String := Null_Unbounded_String;
      logical_type  : Logical_Kind     := any_kind;
      instance_name : Unbounded_String := Null_Unbounded_String;
      enabled : Boolean;
      parameter_systems : Parameter_System_Rec_List;
      parameters : Parameter_Rec_List;
      enumerated_types : Enumerated_Type_List;
      parameter_system_references : Parameter_System_Reference_Rec_List;
   end record;   
   
   type Search_Type is ( by_path, by_name );
   
   function Get( 
      this : Parameter_System_Rec; 
      path : String; 
      search : Search_Type := by_path ) return Parameter_System_Rec;

   package Parameter_Search is
      function Get_Parameter( this : Parameter_System_Rec; instance_name : String ) return Parameter_Rec;
   end Parameter_Search;
   
   package Enum_Search is
      procedure Replace_Or_Insert_Enum( this : in out Parameter_System_Rec; e : Enumerated_Type_Rec );
      function Get_Enum( this : Parameter_System_Rec; id : String ) return Enumerated_Type_Rec;
   end Enum_Search;
   
   procedure Make_Path_To_Left( sys : Parameter_System_Rec; path : in out Text_Utils.Unbounded_String_List );
   procedure Complete_Path_To_Left( sys : Parameter_System_Rec; path : in out Text_Utils.Unbounded_String_List; depth : in out Natural );
   function Path_To_URL( prefix : Unbounded_String; path : in Text_Utils.Unbounded_String_List ) return Unbounded_String;

   
private
   
   delimiter : Character := '/';
   delimiter_str : String := "/";

end Parameter_System;
