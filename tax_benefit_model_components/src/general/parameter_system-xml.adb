with XML_Utils.Conversions;
with GNAT.String_Split;
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Text_Utils;

package body Parameter_System.XML is

   use Ada.Text_IO;
   use Text_Utils;

   package xconv is new XML_Utils.Conversions( 
      Float_Type=>Float_Type, 
      Counter_Type=>Counter_Type );

 
   function Convert( s : String; default : Logical_Kind ) return Logical_Kind is
      k : Logical_Kind := default;
   begin
      Put_Line( "comparing |"& s & "| " );      
      if s = "any_kind" then
         k := any_kind;
      elsif s = "rate" then
         k := rate;
      elsif s = "tax_allowance" then
         k := tax_allowance;
      elsif s = "tax_band" then
         k := tax_band;
      elsif s = "benefit" then
         k := benefit;
      elsif s = "age_limit" then
         k := age_limit;
      elsif s = "quickies" then
         k := quickies;
      elsif s = "poverty_line" then
         k := poverty_line;
      elsif s = "rates_and_bands" then
         k := rates_and_bands;
      end if;
      Put_Line( "got kind as " & k'Img );
      return k;
   end Convert;
   
   function Convert( s : String; default : Collection_Kind ) return Collection_Kind is
   begin
      if s = "set" then
         return set;
      elsif s = "map" then
         return map;
      elsif s = "list" then
         return list;
      elsif s = "singular" then
         return singular;
      end if;
      return default;
   end Convert;
   
   function Convert( s : String; default : Index_Kind ) return Index_Kind is
   begin
      if s = "none" then
       return none;
     elsif s = "integer" then
       return integer_type;
     elsif s = "enumerated" then
       return enumerated_type;
     elsif s = "string" then
       return string_type;
     end if;
     return default;
   end Convert;
   
   function Convert( s : String; default : Units_Kind ) return Units_Kind is
   begin
      if s = "timeless" then
          return timeless;
      elsif s = "day" then
          return day;
      elsif s = "week" then
          return week;
      elsif s = "month" then
          return month;
      elsif s = "year" then
          return year;
      elsif s = "percent" then
          return percent;
      elsif s = "level" then
          return level;
      elsif s = "counts" then
          return counts;
      elsif s = "money" then
          return money;
      elsif s = "rate" then
          return rate;
      elsif s = "no_unit" then
          return no_unit;
      end if;
      return default;
   end Convert;
   
   function Convert( s : String; default : Data_Kind ) return Data_Kind is
   begin
      if s = "real" then
         return real_type;
      elsif s = "integer" then
         return integer_type;
      elsif s = "enumerated" then
         return enumerated_type;
      elsif s = "boolean" then
         return boolean_type;
      elsif s = "string" then
         return string_type;
      elsif s = "date" then
         return date_type;
      elsif s = "decimal" then
         return decimal_type;
      end if;
      return default;
   end Convert;
   
   function Convert( s : String; default : Access_Level_Kind ) return Access_Level_Kind is
   begin
      if s = "normal" then
         return normal;
      elsif s = "admin" then
         return admin;
      end if;
      return default;
   end Convert;
   
   function Convert( s : String; default : Display_Kind ) return Display_Kind is   
   begin
      if s = "hidden" then
         return hidden;
      elsif s = "normal" then
         return normal;
      elsif s = "password" then
         return password;
      elsif s = "label_only" then
         return label_only;
      elsif s = "read_only" then
         return read_only;
      end if;
      return default;
   end Convert;
   
   
   function Convert( s : String; default : Uprate_Kind ) return Uprate_Kind is
   begin
      if s = "standard_uprate" then
         return standard_uprate;
      elsif s = "dont_uprate" then
         return dont_uprate;
      elsif s = "rooker_wise" then
         return rooker_wise;
      end if;
      return default;
   end Convert;
   
   function Convert( s : String; default : Check_Kind ) return Check_Kind is
   begin
      if s = "dont_check" then
         return dont_check;
      elsif s = "warn" then
         return warn;
      elsif s = "halt" then
         return halt;
      end if;
      return default;
   end Convert;

   
   function Make_X_Path_From_Path( path : String; is_for_parameter  : Boolean := False ) return String is
      use GNAT.String_Split;
      slices   : Slice_Set;
      outs     : Unbounded_String;
      ends     : Slice_Number;
      start    : Slice_Number;
   begin
      outs := outs & "//";
      Create( slices, path, delimiter_str, single );
      if( path( path'First ) = delimiter ) then 
         start := 2;
      else
         start := 1;
      end if;
      ends := Slice_Count( slices );
      if( path( path'Last ) = delimiter )then
         ends := ends - 1;
      end if;
      for i in start .. ends - 1 loop
         outs := outs & "ParameterSystem[@instanceName='" & Slice( slices, i ) & "']/";
      end loop;
      if( is_for_parameter ) then
         outs := outs & "Parameter[@instanceName='" & Slice( slices, ends ) & "']";
      else
         outs := outs & "ParameterSystem[@instanceName='" & Slice( slices, ends ) & "']";
      end if;
      return To_String( outs );
   end Make_X_Path_From_Path;
   
   function Load_Extras( elem  : domc.Element ) return Text_Utils.Unbounded_String_Map is
      use domc;
      extras : domc.Node_List; 
      ds : domc.Node;
      key : Unbounded_String;
      val : Unbounded_String;
      exmap : Text_Utils.Unbounded_String_Map;
   begin
      -- extras := delems.Get_Elements_By_Tag_Name( elem, "Description" );
      extras := dnodes.Child_Nodes( elem ); 
      for dno in 1 .. dnodes.Length( extras ) loop
         ds := dnodes.Item( extras, dno - 1 );
         if dnodes.Node_Name( ds ) = "Extra" then
            key := Get_Attr_Value( ds, "key" );
            val := Get_Attr_Value( ds, "value" );
            exmap.Include( key, val );            
         end if;
      end loop;
      return exmap;
   end Load_Extras; 
  
   
   procedure Load_Descriptions( elem  : domc.Element; desc : in out Describable ) is
      use domc;
      descriptions : domc.Node_List; 
      ds : domc.Node;
      text_node : domc.Node;
      lang : Languages;
      dk   : Description_Kind;
      
   begin
      -- Put_Line( "#3" );
      descriptions := dnodes.Child_Nodes( elem ); 
      for dno in 1 .. dnodes.Length( descriptions ) loop
         ds := dnodes.Item( descriptions, dno - 1 );
         -- Put_Line( "#4 " & dno'Img & " name " & dnodes.Node_Name( ds ));
         -- Put_Line( "#4A " );
         -- if dnodes.Node_Name( ds ) = "Description" then
         --   Put_Line( "#5aaa " & dno'Img );
         -- end if;
         -- Put_Line( "dnodes.Node_Name( ds ) = |" & dnodes.Node_Name( ds ) & "|" );
         if dnodes.Node_Name( ds ) = "Description" then
            -- Put_Line( "Got description node" );
            lang := Languages'Value( Get_Attr_Value( ds, "lang", Languages'First'Img ));
            dk := Description_Kind'Value( Get_Attr_Value( ds, "type", "description" ));
            declare
               desc_bits : domc.Node_List;
               content   : Unbounded_String;
               bit       : domc.Node;    
            begin
               desc_bits:= dnodes.Child_Nodes( ds );
               -- Put_Line( "#5aa " );
               for bitno in 1 .. dnodes.Length( desc_bits ) loop
                  -- Put_Line( "#5b " & bitno'Img );
                  bit :=  dnodes.Item( desc_bits, bitno - 1 );
                  content := content & Text_Utils.Trim( XML_Utils.To_String( bit ));
                  -- Put_Line( "#5c " & bitno'Img );

               end loop;
               desc.descriptions( dk )( lang ) := content;
            end;
         end if;
      end loop;
      -- Put_Line( "#6 " );
   end Load_Descriptions; 

   function Load_Edit_Info( parent : domc.Element; logical_type : Logical_Kind ) return Edit_Info_Rec is
      use xconv;
      --
      -- Assume a single edit element
      --
      ei       : Edit_Info_Rec ;
      ei_elems : domc.Node_List;
      elem     : domc.Node;
      preset : Boolean := False;
   begin
      --
      -- FIXME the logical type stuff should be moved to a generic somewhere
      --
      ei.check := halt;
      case logical_type is
         when any_kind => null;
         when rate => 
            ei.prec := 2; 
            ei.uprate := dont_uprate;
            ei.length := 8;
            ei.treat_As_Percentage := True;
            ei.min := -1000.0;
            ei.max := 1000.0;
            preset := True;

         when tax_allowance => 
            ei.prec := 2; 
            ei.uprate := rooker_wise; 
            ei.length := 12;
            ei.min := 0.0;
            ei.max := 100_000_000.0;
            preset := True;
         when tax_band => 
            ei.min := 0.0;
            ei.max := Float_Type'Last;
            ei.prec := 2; 
            ei.uprate := rooker_wise; 
            ei.length := 12; 
            ei.as_array := True; 
            ei.topset := True; 
            ei.order := True;
            preset := True;
         when benefit => 
            ei.min := 0.0;
            ei.max := 100_000_000.0;
            ei.prec := 2; 
            ei.uprate := standard_uprate; 
            ei.length := 8;
            preset := True;
         when age_limit => 
            ei.prec := 0; 
            ei.uprate := dont_uprate; 
            ei.length := 6;
            ei.min := 0.0;
            ei.max := 150.0; -- NOTE match this against age_limit_type if there is one
            ei.topset := False; 
            ei.order := False;
            preset := True;
         when quickies => null;
         when poverty_line => 
            ei.prec := 2; 
            ei.uprate := standard_uprate; 
            ei.length := 8;
            ei.min := 0.0;
            ei.max := 100_000_000.0;
            ei.topset := False; 
            ei.order := False;
            preset := True;
         when rates_and_bands => 
            ei.prec := 2; 
            ei.uprate := rooker_wise; 
            ei.length := 12; 
            ei.as_array := True;
            ei.topset := True; 
            ei.order := True;
            ei.min := 0.0;
            ei.max := 100_000_000.0;
            preset := True;
      end case;
      
      -- Put_Line( "logical type = " & Logical_Kind'Image( logical_type ));
      ei_elems := dnodes.Child_Nodes( parent ); 
      for dno in 1 .. dnodes.Length( ei_elems ) loop
         elem := dnodes.Item( ei_elems, dno - 1 );
         -- Put_Line( "FOUND NODE " & dnodes.Node_Name( elem ));
         if dnodes.Node_Name( elem ) = "EditInfo" then
            -- Put_Line( "FOUND EditInfo" );
            ei.extras := Load_Extras( elem );
            ei.enabled               :=  Get_Attr_Value( elem, "enabled", ei.enabled );
            ei.sums_to_100           :=  Get_Attr_Value( elem, "sumsTo100", ei.sums_to_100 );
            ei.level_change_possible := Get_Attr_Value( elem, "levelChangePossible", ei.level_change_possible );
            ei.is_exogenous          := Get_Attr_Value( elem, "isExogenous", ei.is_exogenous );
            ei.uprate                := Convert( Get_Attr_Value( elem, "uprate" ), ei.uprate);
            ei.next                  := Get_Attr_Value( elem, "next", ei.next );
            ei.display               := Convert( Get_Attr_Value( elem, "display" ), ei.display );
            ei.check                 := Convert( Get_Attr_Value( elem, "check" ), ei.check ); 
            ei.min                   := Get_Attr_Value( elem, "min", ei.min );
            ei.max                   := Get_Attr_Value( elem, "max", ei.max );
            ei.prec                  := Get_Attr_Value( elem, "prec", ei.prec );
            ei.length                := Get_Attr_Value( elem, "length", ei.length );
            ei.as_array              := Get_Attr_Value( elem, "asArray", ei.as_array );
            ei.topset                := Get_Attr_Value( elem, "topset", ei.topset ); -- fixme change to isTopSet
            ei.order                 := Get_Attr_Value( elem, "order", ei.order );
            ei.treat_As_Percentage   := Get_Attr_Value( elem, "treatAsPercentage", ei.treat_as_percentage );
            ei.access_level          := Convert( Get_Attr_Value( elem, "accessLevel" ), ei.access_level );
            ei.onchange              := Get_Attr_Value( elem, "onchange", TS( ei.onchange ));
            return ei;
         end if;
         -- Put_Line( "got onchange as " & TS( ei.onchange ));
      end loop;
      return ei;
   end Load_Edit_Info;

   function Load( elem  : domc.Element ) return Enum_Value_Rec is
      use xconv;
      use XML_Utils;
      use domc;
      ev : Enum_Value_Rec;
      texts : domc.Node_List;
      ds : domc.Node;
      lang : Languages;
      text_node : domc.Node;
   begin
      ev.name := Get_Attr_Value( elem, "name" );
      ev.value := Get_Attr_Value( elem, "value", 0 );
      ev.is_default := Get_Attr_Value( elem, "value", False );
      texts := dnodes.Child_Nodes( elem ); 
      for dno in 1 .. dnodes.Length( texts ) loop
         ds := dnodes.Item( texts, dno - 1 );
         if dnodes.Node_Name( ds ) = "Text" then
            lang := Languages'Value( Get_Attr_Value( ds, "lang", Languages'First'Img ));
            text_node := dnodes.First_Child( ds );
            if( text_node /= null )then
               dnodes.Normalize( text_node );
               declare
                  raw_text : String := dnodes.Node_Value( text_node );
                  text     : String := Text_Utils.Trim( raw_text );
               begin
                  ev.text( lang ) := To_Unbounded_String( text );
               end;
            end if;
         end if;
      end loop;
      return ev;
   end Load;
   
   function Load( elem  : domc.Element ) return Enumerated_Type_Rec is
      et : Enumerated_Type_Rec;
      values : domc.Node_List;
      ds : domc.Node;
   begin
      et.id := Get_Attr_Value( elem, "id" );
      et.name := Get_Attr_Value( elem, "name", To_String( et.id ));
      values := dnodes.Child_Nodes( elem );
      for dno in 1 .. dnodes.Length( values ) loop
         ds := dnodes.Item( values, dno - 1 );
         if dnodes.Node_Name( ds ) = "EnumValue" then
            et.values.Append( Load( ds ));
         end if;
      end loop;
      return et;
   end Load;
   
   function Load( elem  : domc.Element ) return Parameter_Rec is
      use xconv;
      use XML_Utils;
      pr : Parameter_Rec;
   begin
      Load_Descriptions( elem, Describable( pr ));
      pr.extras := Load_Extras( elem );
      
      pr.name := Get_Attr_Value( elem, "name" );
      pr.instance_name := Get_Attr_Value( elem, "instanceName" );
      pr.index_type := Convert( Get_Attr_Value( elem, "indexType" ), none );
      pr.units := Convert( Get_Attr_Value( elem, "units" ), money );
      pr.data_type := Convert( Get_Attr_Value( elem, "type" ), real_type );
      pr.logical_type := Convert( Get_Attr_Value( elem, "logicalType" ), any_kind );
      case pr.logical_type is
         when rate | tax_allowance | tax_band | benefit =>
            pr.data_type := real_type;
         when age_limit => pr.data_type := integer_type;
         when others => null;
      end case; -- override data type if needed
      pr.enum_type_ref := Get_Attr_Value( elem, "enumTypeRef" );
      pr.index_enum_type_ref := Get_Attr_Value( elem, "indexEnumTypeRef" );
      pr.collection_type := Convert( Get_Attr_Value( elem, "collectionType" ), singular );
      pr.maximum_size := Get_Attr_Value( elem, "maximumSize", 0 );
      -- Put_Line( "pr.instance_name=|" & TS( pr.instance_name ) & "|" );
      pr.edit_info := Load_Edit_Info( elem, pr.logical_type );
      return pr;
   end Load;

   function Load( elem  : domc.Element ) return Parameter_System_Reference_Rec is
      use xconv;
      use XML_Utils;
     ps : Parameter_System_Reference_Rec;
   begin
      Load_Descriptions( elem, Describable( ps ));
      ps.extras := Load_Extras( elem );

      ps.instance_name := Get_Attr_Value( elem, "instanceName" );
      ps.index_type := Convert( Get_Attr_Value( elem, "indexType" ), none );
      ps.sys_type := Get_Attr_Value( elem, "type" );
      ps.index_enum_type_ref := Get_Attr_Value( elem, "indexEnumTypeRef" );
      ps.collection_type := Convert( Get_Attr_Value( elem, "collectionType" ), singular );
      ps.maximum_size := Get_Attr_Value( elem, "maximumSize", 0 );
      return ps;
   end Load;
   
   
   function Load( root_elem  : domc.Node ) return Parameter_System_Rec is
      use xconv;
      use dnodes;
      use domc;
      use XML_Utils;
      ps : Parameter_System_Rec;
      children :  domc.Node_List; 
      ds : domc.Node;
      elem : domc.Element; 
   begin
      if( Node_Type( root_elem ) = Document_Node )then
         elem := Get_First_Element( root_elem );
      else
         elem := root_elem;
      end if;
      Put_Line( "#1" );
      Load_Descriptions( elem, Describable( ps ));
      ps.extras := Load_Extras( elem );
      Put_Line( "#2" );
      
      ps.edit_info := Load_Edit_Info( elem, ps.logical_type );
      ps.name := Get_Attr_Value( elem, "name" );
      ps.id := Get_Attr_Value( elem, "id" );
      ps.logical_type := Convert( Get_Attr_Value( elem, "logicalType" ), any_kind );
      ps.instance_name := Get_Attr_Value( elem, "instanceName" );
      ps.enabled := Get_Attr_Value( elem, "enabled", True );
      children := dnodes.Child_Nodes( elem ); 
      for cno in 1 .. dnodes.Length( children ) loop
         ds := dnodes.Item( children, cno - 1 );
         declare
            ch_type : String := dnodes.Node_Name( ds );
         begin
            if ch_type = "ParameterSystem" then
               -- Put_Line( "ParameterSystem" );
               declare
                  use Parameter_System_Rec_Package;
                  param_sys : Parameter_System_Rec := Load( ds );
                  param_sys_a : Parameter_System_Rec_A;
               begin
                  param_sys_a := new Parameter_System_Rec;
                  param_sys_a.all := param_sys;
                  Append( ps.parameter_systems, param_sys_a );
               end;
            elsif ch_type = "ParameterSystemReference" then
               Put_Line( "ParameterSystemReference" );
               declare
                  use Parameter_System_Reference_Rec_Package;
                  param_ref : Parameter_System_Reference_Rec := Load( ds );
               begin
                  Append( ps.parameter_system_references, param_ref );
               end;
            elsif ch_type = "Parameter" then
               -- Put_Line( "Parameter" );
               declare
                  use Parameter_Rec_Package;
                  param : Parameter_Rec := Load( ds );
               begin
                  Append( ps.parameters, param );
               end;
            elsif ch_type = "EnumeratedType" then
               Put_Line( "Enumerated Type" );
               declare
                  use Enumerated_Type_Package;
                  enum : Enumerated_Type_Rec := Load( ds );
               begin
                  Append( ps.enumerated_types, enum );
               end;
            end if;
         end;
      end loop;
      return ps;
   end Load;

   function Load( xpath : String; from : domc.Document ) return Parameter_Rec is
      pr : Parameter_Rec;     
      parameters : domc.Node_List;
      parameter : domc.Element;
   begin
      parameters := xp.XPath_Query( from, xpath );
      parameter :=  dnodes.Item( parameters, 0 );
      return Load( parameter );
   end Load;
      
   function Load( xpath : String; from : domc.Document ) return Parameter_System_Rec is
      ps : Parameter_System_Rec;
      parameter_systems : domc.Node_List;
      system : domc.Element;
   begin
      parameter_systems := xp.XPath_Query( from, xpath );
      system :=  dnodes.Item( parameter_systems, 0 );
      dnodes.Normalize( system );
      return Load( system );
   end Load;
   

end Parameter_System.XML;
