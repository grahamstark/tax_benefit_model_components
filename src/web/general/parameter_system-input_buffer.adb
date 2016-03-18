with Ada.Exceptions; 
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Maps.Constants;
with Ada.Calendar.Formatting;

with GNATColl.Traces;

with Line_Extractor;

package body Parameter_System.Input_Buffer is

   use Ada.Text_IO;
   use Text_Utils;
   use Ada.Containers;
   use Ada.Calendar;
   
   use GNATColl.Traces;
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "PARAMETER_SYSTEM.INPUT_BUFFER" );
   
   BIG_FLOAT : constant Float_Type := 99_999_999.0; -- instead of F'Last which can blow up validators
   
   function Is_Changed( val_and_err : Value_And_Error ) return Boolean is
   begin
      case val_and_err.dtype is
         when enumerated_type => return val_and_err.eval /= val_and_err.edefault;
         when real_type    => return val_and_err.rval /= val_and_err.rdefault;
         when integer_type => return val_and_err.ival /= val_and_err.idefault;
         when string_type  => return val_and_err.sval /= val_and_err.sdefault;
         when boolean_type => return val_and_err.bval /= val_and_err.bdefault;
         when date_type => return val_and_err.cval /= val_and_err.cdefault;
         when decimal_type => return val_and_err.dval /= val_and_err.ddefault;
      end case;
   end Is_Changed;

   function Basic_Text_Representation_Of_Value( v : Value_And_Error ) return Unbounded_String is   
   begin
      case v.dtype is
         when real_type       => return To_Unbounded_String( Float_Type'Image( v.rval ));
         when integer_type    => return To_Unbounded_String( Integer'Image( v.ival ));
         when enumerated_type => return v.eval; 
         when boolean_type    => return To_Unbounded_String( Boolean'Image( v.bval ));
         when string_type     => return v.sval;
         when date_type       => return To_Unbounded_String( Ada.Calendar.Formatting.Image( v.cval ));
         when decimal_type    => return To_Unbounded_String( Counter_Type'Image( v.dval ));
      end case;
   end Basic_Text_Representation_Of_Value;

   function Basic_Text_Representation_Of_Default( v : Value_And_Error ) return Unbounded_String is   
   begin
      case v.dtype is
         when real_type       => return To_Unbounded_String( Float_Type'Image( v.rdefault ));
         when integer_type    => return To_Unbounded_String( Integer'Image( v.idefault ));
         when enumerated_type => return v.edefault; 
         when boolean_type    => return To_Unbounded_String( Boolean'Image( v.bdefault ));
         when string_type     => return v.sdefault;
         when date_type       => return To_Unbounded_String( Ada.Calendar.Formatting.Image( v.cdefault ));
         when decimal_type    => return To_Unbounded_String( Counter_Type'Image( v.ddefault ));
      end case;
   end Basic_Text_Representation_Of_Default;

   function To_Text_Buffer( 
      buff       : Buffer;  
      which      : Buffer_Retrieval_Type; 
      start_year : Year_Number; 
      end_year   : Year_Number ) return Keyed_Text_Buffer.Text_Buffer is
      kbuff     :  Keyed_Text_Buffer.Text_Buffer;
      one_kbuff : Keyed_Text_Buffer.Text_Buffer;
      yprefix   : Unbounded_String;
   begin
      for year in start_year .. end_year loop
         yprefix := buff.Year_Prefix_Str( year );
         one_kbuff := buff.To_Text_Buffer( which, yprefix );
         Keyed_Text_Buffer.Merge( kbuff, one_kbuff ); 
      end loop;
      return kbuff;
   end To_Text_Buffer;
   
   function To_Text_Buffer( 
      buff     : Buffer;  
      which    : Buffer_Retrieval_Type; 
      matching : Unbounded_String := Null_Unbounded_String ) return Keyed_Text_Buffer.Text_Buffer is
   use Keyed_Text_Buffer;
      b : Text_Buffer;
      matching_as_string : constant String := TS( matching );

      procedure Add_Indexed_Subsysem( 
         cpv    : Complete_Param_And_Value_Rec; 
         prefix : Unbounded_String := Null_Unbounded_String ) is
         use Value_And_Error_Map_Package;
         
         procedure Add_One( c : Cursor ) is
            postfix : Unbounded_String := Key( c );
            vaev : Value_And_Error_Vector := Element( c );
            val_str : Unbounded_String;
            complete_key : Unbounded_String;
            k : Unbounded_String;
         begin         
            for pno in 1 .. cpv.current_size loop
               declare
                  v_and_e : Value_And_Error := vaev.Element( pno ).all;
               begin
                  if Is_Changed( v_and_e ) or which = get_all then
                     if( which = get_changed_base )then
                        val_str := Basic_Text_Representation_Of_Default( v_and_e );
                     else
                        val_str := Basic_Text_Representation_Of_Value( v_and_e );
                     end if;
                     
                     Trace( log_trace, "Add_One; pno = " & pno'Img & 
                          " cpv.current_size " & cpv.current_size'Img & 
                          " length of cpv.index_string " & cpv.index_strings.Length'Img & 
                          " postfix = " & TS( postfix ));
                     if cpv.is_enumerated then -- FIXME or IS_STRING 
                        k := cpv.index_strings.Element( pno );
                     else
                        k := TuS( pno'Img( 2 .. pno'Img'Length ));
                     end if;
                     complete_key := Line_Extractor.Make_Key( prefix, k, postfix );
                     Trace( log_trace, " k=|" & TS( k ) &
                        "Made Key as |" & TS( complete_key ) & 
                        "| value |" & TS( val_str  ) & 
                        "| matching_as_String = |" & matching_as_string & "|" );
                     if( matching = Null_Unbounded_String ) or ( matching_as_string = "" ) then
                        Trace( log_trace, "inserting key=|" & TS( complete_key & "| val= |" & val_str ));
                        b.Insert( complete_key, val_str );
                     elsif( Index( complete_key, matching_as_string ) > 0 )then
                        Trace( log_trace, "inserting key=|" & TS( complete_key & "| val= |" & val_str ));
                        b.Insert( complete_key, val_str );
                     end if;
                  end if;
               end;
            end loop;
            -- always load counter
            declare
               counter_key   : constant Unbounded_String := prefix & DELIMITER & "count";
               size_str      : constant Unbounded_String := 
                  TuS( cpv.current_size'Img( 2 ..  cpv.current_size'Img'Length ));
            begin
               Trace( log_trace, "adding counter key " & TS( counter_key ) & " = " & TS( size_str ));
               if b.Contains( counter_key ) then
                  b.Replace( counter_key, size_str );
               else
                  b.Insert( counter_key, size_str );
               end if;
            end;
         end Add_One;
            
      begin
         Iterate( cpv.valmap, Add_One'Access );
      end Add_Indexed_Subsysem;

      use Complete_Param_And_Value_Maps_Package;
      
      procedure Add_One( c : Cursor ) is
         k : Unbounded_String := Key( c );
         v : Complete_Param_And_Value_Rec := Element( c );
         s : Unbounded_String;
      begin         
         --
         -- FIXME complete this for maps and arrays
         -- this will fall over with those at present
         if( matching /= Null_Unbounded_String ) and then ( Index( k, matching_as_string ) = 0 )then
            return;
         end if;
         case v.etype is
            when single => 
               if Is_Changed( v.val.all ) or which = get_all then
                  if( which = get_changed_base )then
                     s := Basic_Text_Representation_Of_Default( v.val.all );
                  else
                     s := Basic_Text_Representation_Of_Value( v.val.all );
                  end if;
                  b.Insert( k, s );
               end if;
            when single_array => null;
            when map_of_arrays => Add_Indexed_Subsysem( v, k );
         end case;    
      end Add_One;
       
   begin
      Iterate( buff.params, Add_One'Access );
      return b;      
   end To_Text_Buffer;
      

   --
   -- (slight) hack for multi-year versions
   --
   
   procedure Set_Current_Year( buff : in out Buffer; year : Ada.Calendar.Year_Number ) is
   begin
      buff.current_year := year;
   end Set_Current_Year;
   
   function Get_Current_Year( buff : Buffer ) return Year_Number is
   begin
      return buff.current_year;
   end Get_Current_Year;


   
   procedure Set_Year_Range( buff : in out Buffer; yp : String; start_yr, end_yr : Ada.Calendar.Year_Number ) is
   begin
      buff.year_prefix := TuS( yp );
      buff.first_possible_year := start_yr;
      buff.last_possible_year := end_yr;
   end Set_Year_Range;
   
   function Has_Years( buff : Buffer ) return Boolean is
   begin
      return buff.first_possible_year /= Year_Number'First and 
             buff.last_possible_year /= Year_Number'First and 
             buff.year_prefix /= Null_Unbounded_String;
   end Has_Years;
   
   function Year_Prefix_Str( buff : Buffer; year : Year_Number ) return Unbounded_String is
   begin
      if( buff.Has_Years )then
         return Line_Extractor.Make_Key( buff.year_prefix, year );
      end if;
      return Null_Unbounded_String;
   end Year_Prefix_Str;

   function Year_Prefix_Str( buff : Buffer ) return Unbounded_String is
   begin
      -- Trace( log_trace, " Year_Prefix_Str " & buff.Has_Years'Img & "first_possible_year " & buff.first_possible_year'Img &
      --          " last_possible_year " & buff.last_possible_year'Img & " year_prefix " & TS( year_prefix ));
      return buff.Year_Prefix_Str( buff.current_year );
   end Year_Prefix_Str;
   
   procedure Correct_Array( pv : in out Complete_Param_And_Value_Rec ) is
   use Value_And_Error_Map_Package;
   use Parameter_Search;
      pa : Value_And_Error_Access;
      cur       : Cursor  := First( pv.valmap );
      vel       : Value_And_Error_Vector;
      param     : Parameter_Rec;
      postfix   : Unbounded_String;
      n : Positive := Positive( Length( pv.valmap ));
   begin
      for i in 1 .. n loop
         postfix := Value_And_Error_Map_Package.Key( cur );
         param := Get_Parameter( pv.system_desc, To_String( postfix ));
         if( param.logical_type = tax_allowance ) or ( param.edit_info.topset )then
            vel := pv.valmap.Element( postfix );
            pa := vel.Element( pv.current_size );
            if( pa.dtype = real_type )then
               pa.rval := BIG_FLOAT;
            elsif( pa.dtype = decimal_type )then
               pa.dval := Counter_Type'Last;
            elsif( pa.dtype = integer_type )then
               pa.ival := Integer'Last;
            end if;
         end if;
         if( i < n ) then
            Next( cur );
         end if;
      end loop;
   end Correct_Array;
   --
   -- needed for AWS Session storage
   ---
   function Get_Null_Buffer return Buffer is
      b : Buffer;
   begin
      b.is_null_buffer := True;
      return b;
   end Get_Null_Buffer;
   
   procedure Set_Delimiter( del : Character ) is
   begin
      delimiter := del;
      delimiter_str(1) := del;
   end Set_Delimiter;
   
   
   function Get_Boolean_Value_String( 
      buff                 : Buffer; 
      param_and_value      : Complete_Param_And_Value_Rec; 
      year_from_input      : Year_Number;
      base_key_from_input  : Unbounded_String;
      index                : Natural; 
      postfix              : Unbounded_String ) return String is
      key : Unbounded_String;
      base_key : Unbounded_String;
      istr : constant String := index'Img( 2 .. index'Img'Last );
      year_prefix : Unbounded_String := buff.Year_Prefix_Str( year_from_input );
   begin
      if( year_prefix /= Null_Unbounded_String )then
         base_key := year_prefix & '.' & base_key_from_input;
      else
         base_key := base_key_from_input;
      end if;

      case param_and_value.etype is
         when single        => key := base_key & "_value";
         when single_array  => key := base_key & "_value[" & istr &"]";
         when map_of_arrays =>
            key := base_key & "[" & istr &"]." & postfix & "_value";
      end case;
      return Censor_ID( TS( key ));
   end Get_Boolean_Value_String;

   --
   --
   --function Get_Largest_Changes(
   --   buff : Buffer; 
   --   max  : Positive ) return ;
      
   function Get_Value_And_Error( 
      param_and_value  : Complete_Param_And_Value_Rec; 
      index            : Natural := 0; 
      postfix          : Unbounded_String := Null_Unbounded_String ) return Value_And_Error_Access is
      pa : Value_And_Error_Access := null;
   begin
      case param_and_value.etype is
         when single        => pa := param_and_value.val;
         when single_array  => pa := param_and_value.vallist.Element( index );
         when map_of_arrays => 
            declare
               vel : Value_And_Error_Vector;
            begin
               Trace( log_trace, "Get_Value_And_Error: looking for postfix = " & TS( postfix ) & " index = " & index'Img );
               if( param_and_value.valmap.Contains( postfix ))then
                  vel := param_and_value.valmap.Element( postfix );
                  declare
                     len : Positive := Positive( vel.Length );
                  begin
                     if index <= len then
                        pa := vel.Element( index );
                     else
                        --
                        -- If we're extending this .. 
                        --
                        pa := vel.Element( len );
                        vel.Append( pa );
                     end if;
                  end;
                  Trace( log_trace, "Found it" );
               end if;
            end;
      end case;
      return pa;
   end Get_Value_And_Error;
   
   function Get_Value_And_Error( 
      buff : Buffer; 
      key : Unbounded_String; 
      index : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Value_And_Error_Access is
      pv : Complete_Param_And_Value_Rec;
      pa : Value_And_Error_Access := null;
   begin
      if( buff.params.Contains( key ))then
         pv := buff.params.Element( key );
         pa := Get_Value_And_Error( pv, index, postfix );
      end if;
      return pa;
   end Get_Value_And_Error;
   
   function Get_Local_Name( key : Unbounded_String ) return String is
   begin
      return "";
   end Get_Local_Name;
   
   function Get_Parameter_Rec(       
      buff : Buffer; 
      key : Unbounded_String; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Parameter_Rec is
    use Parameter_Search;
      pv : Complete_Param_And_Value_Rec;
      pr : Parameter_Rec;
    begin
      if( buff.params.Contains( key ))then
         pv := buff.params.Element( key );
         case pv.etype is
            when single        => pr := pv.param_desc;
            when single_array  => pr := pv.array_param_desc;
            when map_of_arrays => 
            if( pv.valmap.Contains( postfix ))then
               pr := Get_Parameter( pv.system_desc, To_String( postfix ));
            end if;
         end case;
      end if;
      return pr;
   end Get_Parameter_Rec;
     
   function Do_Op( actual, base : Float_Type; op : Get_Operation ) return Float_Type is
   begin
      case op is
         when actual_value  => return actual;
         when base_value    => return base;
         when pc_change     =>
            if( base = actual )then
               return 0.0;
            elsif( base /= 0.0 )then
               return 100.0*(actual-base)/base;
            else
               return 100.0*(actual-base)/actual;
            end if;
         when level_change   => return actual - base;
      end case;
   end Do_Op;
   
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Float_Type; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      ve := buff.Get_Value_And_Error( 
           lkey, 
           index, 
           postfix );   
      if( ve /= Null )then
         if( ve.dtype = real_type )then
            ve.rval := value;
         end if;
      end if;
   end Set;
    
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Integer; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      ve := buff.Get_Value_And_Error( 
           lkey, 
           index, 
           postfix );   
      if( ve /= Null )then
         if( ve.dtype = integer_type )then
            ve.ival := value;
         end if;
      end if;
    end Set;
    
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Boolean; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      ve := buff.Get_Value_And_Error( 
           lkey, 
           index, 
           postfix );   
      if( ve /= Null )then
         if( ve.dtype = boolean_type )then
            ve.bval := value;
         end if;
      end if;
    end Set;
    
   procedure Set(
      buff    : in out Buffer; 
      key     : Unbounded_String; 
      value   : Unbounded_String; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      ve := buff.Get_Value_And_Error( 
           lkey, 
           index, 
           postfix );   

      if( ve /= Null )then
         if( ve.dtype = string_type )then
            ve.sval := value;
         end if;
      end if;
    end Set;
    
   
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) return Float_Type
   is
      ve : Value_And_Error_Access; 
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      ve := 
         buff.Get_Value_And_Error( lkey, 
                                   index, 
                                   postfix );  
      if( ve /= Null )then
         if( ve.dtype = real_type ) and ( ve.error_message = Null_Unbounded_String )then
            return Do_Op( ve.rval, ve.rdefault, op );
         end if;
      end if;
      return 0.0;
   end Get;
   
   function Print_Keys( buff : Buffer ) return String is
   begin
      return Print_Keys( buff.params );
   end Print_Keys;
   
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) return Integer is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      Trace( log_trace, "searching for key |" & TS( lkey ) & "| buff.Year_Prefix_Str = " & TS( buff.Year_Prefix_Str ));
      ve := buff.Get_Value_And_Error( lkey, index, postfix );
      if( ve /= Null )then
         if( ve.dtype = integer_type ) and ( ve.error_message = Null_Unbounded_String )then
            case op is         
               when actual_value  => return ve.ival;
               when base_value    => return ve.idefault;
               when others=>
               return Integer( Do_Op( Float_Type(ve.ival), Float_Type(ve.idefault), op ));
            end case;
         elsif( ve.dtype = real_type ) and ( ve.error_message = Null_Unbounded_String )then
            case op is         
               when actual_value  => return Integer( ve.rval );
               when base_value    => return Integer( ve.rdefault );
               when others=>
               return Integer( Do_Op( Float_Type(ve.ival), Float_Type(ve.idefault), op ));
            end case;
         end if;
         Trace( log_trace, "|" & TS( key ) & "| is not an integer" ); 
      else
         Trace( log_trace, "nothing found for key " & TS( key ) & " keys are " & Print_Keys( buff.params ));
      end if;
      return 0;
   end Get;
   

   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) return Boolean is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      ve := buff.Get_Value_And_Error( lkey, index, postfix );   

      if( ve /= Null )then
         if( ve.dtype = boolean_type ) and ( ve.error_message = Null_Unbounded_String )then
            case op is         
               when actual_value  => return ve.bval;
               when base_value    => return ve.bdefault;
               when others=>
               return False;
            end case;
         end if;
      end if;
      return False;
   end Get;
   
   function Get( 
      buff    : Buffer; 
      key     : Unbounded_String; 
      op      : Get_Operation := actual_value; 
      index   : Natural := 0;
      postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String
   is
      ve : Value_And_Error_Access;
      lkey : Unbounded_String := key;
   begin
      if( buff.Year_Prefix_Str /= Null_Unbounded_String )then
         lkey := buff.Year_Prefix_Str  & Delimiter & key;
      end if;
      Trace( log_trace, "Get (UBS) searching for key |" & TS( lkey ) & "| buff.Year_Prefix_Str = " & TS( buff.Year_Prefix_Str ));
      ve := buff.Get_Value_And_Error( lkey, index, postfix );   
      if( ve /= Null )then
         if( ve.dtype = string_type ) and ( ve.error_message = Null_Unbounded_String )then
            case op is         
               when actual_value  => return ve.sval;
               when base_value    => return ve.sdefault;
               when others=>
               return Null_Unbounded_String;
            end case;
         elsif( ve.dtype = enumerated_type ) and ( ve.error_message = Null_Unbounded_String )then
            case op is         
               when actual_value  => return ve.eval;
               when base_value    => return ve.edefault;
               when others=>
               return Null_Unbounded_String;
            end case;
         end if;
      else
         Trace( log_trace, "Get string nothing found for key " & TS( key ) & " keys are " & Print_Keys( buff.params ));
      end if;
      return Null_Unbounded_String;
   end Get;
   
   procedure Operate( 
      buff     : in out Buffer; 
      prefix   : Unbounded_String;
      m        : Float_Type;
      which_operation : Integer := 0;
      start_year : Year_Number := Year_Number'First;
      end_year   : Year_Number := Year_Number'Last ) is
    
    use Complete_Param_And_Value_Maps_Package;
    
      procedure Do_Op( pos : Cursor ) is
         skey : Unbounded_String := Key( pos );
         pv : Complete_Param_And_Value_Rec := buff.params.Element( skey );
      begin
         if( buff.Has_Years )then
            --
            -- is this is dated, check we're in range
            --
            declare
               is_indexed_key : Boolean;
               base_key       : Unbounded_String;
               index          : Natural;
               postfix        : Unbounded_String;
               year           : Year_Number;
               this_year_prefix    : Unbounded_String;
               has_year       : Boolean;
            begin
               Line_Extractor.Parse_By_Year_Indexed_Key(  -- from the parameters, with the year prefix stripped off
                  skey,
                  this_year_prefix,
                  has_year,
                  year,
                  base_key,       
                  is_indexed_key, 
                  index,          
                  postfix );
               skey := base_key;
               Trace( log_trace, "Do_Op; has_year " & has_year'Img & 
                   " year " & year'Img & 
                   " start_year " & start_year'Img &
                   " end_year   " & end_year'Img );
               if has_year and then ( year < start_year or year > end_year ) then
                  Trace( log_trace, "Do_OP; year out of range; returning " );
                  return;
               end if;
            end;
         end if;
         --
         -- not this prefix ?
         --
         Trace( log_trace, "comparing prefix |" & TS( prefix ) & "| with key |" & TS( skey ) & "|" );
         if( prefix /= Null_Unbounded_String ) then 
            if( Index( skey, TS(prefix )) /= 1 )then -- prefix exists and key doesn't start with it - get out
               return;  
            end if;
         end if;
         case pv.etype is
         when single        => 
            if( pv.val.dtype = real_type )then
               Trace( log_trace, "operating on " & pv.val.rval'Img & " with m= " & m'Img );
               Operate( pv.val.rval, m, pv.param_desc, which_operation );
            end if;
         when single_array  => 
            -- FIXME BROKEN FOR NON REAL ARRAYS if( pv.vallist.dtype = real_type )then
               declare
                  n     : Natural := Natural( pv.vallist.Length );
                  v     : Float_Type;
               begin
                  for i in 1 .. n loop
                     v := pv.vallist.Element( i ).rval;
                     Operate( v, m, pv.array_param_desc, which_operation );
                     pv.vallist.Element( i ).rval := v;
                     -- pv.vallist.Replace_Element( i,  );
                  end loop;
               end;
            -- end if;
         when map_of_arrays =>
            declare
               use Value_And_Error_Map_Package;
               use Parameter_Search;
                  map_cur       : Value_And_Error_Map_Package.Cursor  := pv.valmap.First;
                  postfix       : Unbounded_String;
                  param         : Parameter_Rec;
                  vel           : Value_And_Error_Vector;
               begin
                  loop
                     postfix := Value_And_Error_Map_Package.Key( map_cur );
                     vel := pv.valmap.Element( postfix );
                     param := Get_Parameter( pv.system_desc, To_String( postfix ));
                     for i in 1 .. pv.current_size loop
                        if( vel.Element( i ).dtype = real_type )then
                           declare
                              currv : Value_And_Error_Access := vel.Element( i );
                           begin
                              Operate( currv.rval, m, param, which_operation );
                              vel.Replace_Element( i, currv );
                           end;
                        end if;
                     end loop;
                     pv.valmap.Replace( postfix, vel );
                     Next( map_cur );
                     exit when not Has_Element( map_cur ); 
                  end loop;
               end;
         end case;
         buff.params.Replace_Element( pos, pv );
      end Do_Op;
      
   begin      
      buff.params.Iterate( Do_Op'Access );
   end Operate;      
   
   function Get_Current_Collection_Size(
      buff    : Buffer; 
      key     : Unbounded_String ) return Natural is
      pv : Complete_Param_And_Value_Rec;
   begin
      if( buff.params.Contains( key ))then
         pv := buff.params.Element( key );
         case pv.etype is
            when single        => return 0;
            when single_array  => return Natural( pv.vallist.Length );
            when map_of_arrays => return pv.current_size;
         end case;
      else
         Trace( log_trace, "couldn't find key " & TS( key ));
      end if;
      return 0;
    end Get_Current_Collection_Size;
    
    function Convert_Boolean( s : Unbounded_String ) return Boolean is
       -- FIXME move to a library somewhere
       ss : constant String := Ada.Strings.Fixed.Translate( TS( s ),  
         Ada.Strings.Maps.Constants.Lower_Case_Map );
    begin
       if( ss = "on" or ss = "yes" or ss = "true" or ss = "1" )then
          return True;
       end if;
       return False;
    end Convert_Boolean;
    
   function Create_Value_And_Error_Access( copy_va : Value_And_Error ) return Value_And_Error_Access is
      va : Value_And_Error_Access := new Value_And_Error( dtype => copy_va.dtype );
   begin
      va.all := copy_va;
      return va;
   end Create_Value_And_Error_Access;
   
   function Create_Value_And_Error_Access( 
      param : Parameter_Rec;
      lang : Languages; 
      value   : Unbounded_String;
      default : Unbounded_String ) return Value_And_Error_Access is
      pa : Value_And_Error_Access := new Value_And_Error( dtype => param.data_type );
   begin
      if default /= Null_Unbounded_String then
         case pa.dtype is
         when real_type       => 
            pa.rval := Local_Format_Utils.Lenient_Convert( value );
            pa.rdefault  := Local_Format_Utils.Lenient_Convert( default );
            pa.text := To_Unbounded_String( Local_Format_Utils.Format( pa.rval ));
         when integer_type    => 
            pa.ival := Integer'Value( To_String( value ));
            pa.idefault  := Integer'Value( To_String( default ));
            pa.text := To_Unbounded_String( Local_Format_Utils.Format( pa.ival ));
         when enumerated_type => 
            pa.eval := value;
            pa.edefault := default;
            pa.text := default;
         when boolean_type    => 
            pa.bval      := Convert_Boolean( value );
            pa.bdefault  := Convert_Boolean( default );
            pa.text := To_Unbounded_String( Format( pa.bval, lang ));
         when string_type     => 
            pa.sval := value;
            pa.sdefault := default;
            pa.text := default;
         when date_type       =>
            null; -- FIXME TODO
            -- cval, cdefault  : Ada.Calendar.Time;
         when decimal_type    => -- dval, ddefault  : Counter_Type;
            pa.dval := Local_Format_Utils.Lenient_Convert( value );
            pa.ddefault  :=Local_Format_Utils.Lenient_Convert( default );
            pa.text := To_Unbounded_String( Local_Format_Utils.Format( pa.rval ));
         end case;
      end if;
      return pa;  
   end Create_Value_And_Error_Access;
   
   procedure Set(  buff : in out Buffer; key :  Unbounded_String ) is
   begin
      null;   
   end Set;
   
   function Maximum_Collection_Size( 
      buff : Buffer; 
      key : Unbounded_String ) return Natural is
      pv : Complete_Param_And_Value_Rec;
      sz : Natural := 0;
   begin
      Trace( log_trace, "Maximum_Collection_Size; looking for key |" & TS( key ) & "|" );
      if( buff.params.Contains( key ))then
         pv := buff.params.Element( key );
         case pv.etype is
            when single        => sz := 0;
            when single_array  =>
               sz := pv.array_param_desc.maximum_size; 
            when map_of_arrays => 
               sz := pv.reference_desc.maximum_size;
            when others =>
               sz := 0;
         end case;
         Trace( log_trace, "Key Found; size is " & sz'Img );
      else
         Trace( log_trace, "Key not found ");
      end if;
      return sz;
   end  Maximum_Collection_Size;
   
   function To_String( ve : Value_And_Error ) return String is
   use Ada.Calendar.Formatting;
      s : Unbounded_String;
   begin
      s := s & "Text " & ve.text;
      s := s & "Error_Message: " & ve.error_message;
      s := s & "error: " &  ve.error'Img;
      s := s & "val: " & Basic_Text_Representation_Of_Value( ve );
      return TS( s );
   end To_String;
      
   function To_String( vev : Value_And_Error_Vector ) return String is
      s : Unbounded_String;
      p : Positive := 1;
   begin
      for ve of vev loop
         s := s & "["&p'Img&" ]=" & To_String( ve.all ) & LINE_BREAK;
         p := p + 1;
      end loop;
      return TS( s );
   end To_String;
   
   function To_String( cpvr : Complete_Param_And_Value_Rec ) return String is
      use Value_And_Error_Map_Package;
      s : Unbounded_String;
   begin
      case cpvr.etype is
      when single        =>
         null;
      when single_array  =>
         s := s & To_String( cpvr.vallist );
      when map_of_arrays => 
         s := s & "current_size " & cpvr.current_size'Img;
         
         s := s & " keys :";
         for cur in cpvr.valmap.Iterate loop
            s := s & Key( cur ) & "=" & To_String( Element( cur )) & LINE_BREAK;
         end loop;
         -- valmap         : Value_And_Error_Map;
         -- is_enumerated  : Boolean := False;
         -- system_desc    : Parameter_System_Rec;
         -- reference_desc : Parameter_System_Reference_Rec;
         -- index_strings  : Text_Utils.Unbounded_String_List;         
      end case;
         
      return TS( s );
   end To_String;
      
   
   procedure Add( buff : in out Buffer; key : Unbounded_String; pos : Positive ) is
      cpvr : Complete_Param_And_Value_Rec;
      pa   : Value_And_Error_Access;
      
      -- d    : Unbounded_String := Null_Unbounded_String;
   begin
      Trace( log_trace, "Add entered target key is " & TS( key ));
      if( buff.params.Contains( key ))then
         cpvr := buff.params.Element( key );
         Trace( log_trace, "complete cpvr at start " & To_String( cpvr ));
         case cpvr.etype is
            when single        => null;
            when single_array  =>
               pa := Create_Value_And_Error_Access( 
                  cpvr.array_param_desc, 
                  buff.lang, 
                  Null_Unbounded_String, 
                  Null_Unbounded_String );
               cpvr.vallist.Insert( pos, pa );
            when map_of_arrays => 
               declare
               use Value_And_Error_Map_Package;
               use Parameter_Search;
                  cur       : Cursor  := First( cpvr.valmap );
                  num_parameters_in_record : Positive := Positive( Length( cpvr.valmap ));
               begin
                  Trace( log_trace, "Add cpvr.reference_desc.maximum_size " & cpvr.reference_desc.maximum_size'Img );
                  Trace( log_trace, "Add num_parameters_in_record " & num_parameters_in_record'Img );
                  if(( cpvr.reference_desc.maximum_size <= 0 ) or 
                     ( cpvr.current_size < cpvr.reference_desc.maximum_size )) then
                     --
                     -- add a record
                     -- has to be this count thing becase of weirdless with the discriminant 
                     --
                     Add_A_Record:
                     for i in 1 .. num_parameters_in_record loop
                        declare
                           postfix         : constant Unbounded_String := Value_And_Error_Map_Package.Key( cur );
                           vel             : Value_And_Error_Vector := cpvr.valmap.Element( postfix );
                           array_length    : Positive := Positive( vel.Length );
                           param           : Parameter_Rec := Get_Parameter( cpvr.system_desc, To_String( postfix ));
                           copy_pos        : Positive := Positive'Min( array_length, pos );
                           default_v_and_e : Value_And_Error_Access := vel.Element( copy_pos );
                        begin
                           Trace( log_trace, "postfix ", TS( postfix ));
                           pa := Create_Value_And_Error_Access(default_v_and_e.all );
                           vel.Insert( pos, pa );
                           cpvr.valmap.Replace( postfix, vel );
                           Next( cur );
                        end;
                     end loop Add_A_Record;
                     cpvr.current_size := cpvr.current_size + 1;
                     Trace( log_trace, "full record " & To_String( cpvr ));
                     Correct_Array( cpvr );
                     Trace( log_trace, "Add; map_of_arrays case; made current_size as " & cpvr.current_size'Img );
                     Trace( log_trace, "full record - afer correct_array" & To_String( cpvr ));
                  end if;
               end;
         end case;
         buff.params.Replace( key, cpvr );
         Trace( log_trace, "complete cpvr at end " & To_String( cpvr ));
      else
         Trace( log_trace, "Add: Failed to find key " & TS( key ));
      end if;
   end Add;
   
   procedure Delete( buff : in out Buffer; key : Unbounded_String; delete_pos : Positive ) is
      cpvr : Complete_Param_And_Value_Rec;
   begin
      Put_Line( "delete entered" );
      if( buff.params.Contains( key ))then
         cpvr := buff.params.Element( key );
         case cpvr.etype is
            when single        => null;
            when single_array  =>
               if cpvr.vallist.Length > 1 then
                  cpvr.vallist.Delete( delete_pos );
               end if;
            when map_of_arrays => 
               declare
               use Value_And_Error_Map_Package;
               use Parameter_Search;
                  cur       : Cursor  := First( cpvr.valmap );
                  vel       : Value_And_Error_Vector;
                  param     : Parameter_Rec;
                  postfix   : Unbounded_String;
                  n : Positive := Positive( Length( cpvr.valmap ));
               begin
                  Trace( log_trace, "deleting item " & delete_pos'Img );
                  Trace( log_trace, "on entry: record to " & To_String( cpvr ));
                  if( cpvr.current_size > 1 ) and ( delete_pos <= cpvr.current_size ) then 
                     for i in 1 .. n loop
                        postfix := Value_And_Error_Map_Package.Key( cur );
                        param := Get_Parameter( cpvr.system_desc, To_String( postfix ));
                        vel := cpvr.valmap.Element( postfix );
                        vel.Delete( delete_pos );
                        -- need this? reference ??
                        cpvr.valmap.Replace( postfix, vel );
                        if( i < n ) then
                           Next( cur );
                        end if;
                     end loop;
                     cpvr.current_size := cpvr.current_size - 1;
                     Trace( log_trace, "set record to " & To_String( cpvr ));
                     Correct_Array( cpvr );
                     Trace( log_trace, "after correction; set record to " & To_String( cpvr ));
                  end if;
               end;
         end case;
         buff.params.Replace( key, cpvr );
      else
         Trace( log_trace, "Delete: Failed to find key " & TS( key ));
      end if;
   end Delete;
   
   function Get_Formatted( buff : Buffer; key : Unbounded_String ) return Unbounded_String is
   begin
      -- TODO
      return Null_Unbounded_String;
   end Get_Formatted;
    
   procedure Set_Language( 
      buff : in out Buffer; 
      lang     : Languages ) is
   begin
      buff.lang := lang;
   end Set_Language;

   function Compare_Params( 
      p1 : Complete_Param_And_Value_Rec; 
      p2 : Complete_Param_And_Value_Rec ) return Boolean is
   begin
      return p1 = p2;
   end Compare_Params;
   
   function Compare_Value_And_Error_Vector( v1, v2 : Value_And_Error_Vector ) return Boolean is
      use Value_And_Error_Vector_Package;
   begin
      return v1 = v2;
   end Compare_Value_And_Error_Vector;

   function Get_Error_Message( 
      buff : Buffer; 
      key : Unbounded_String;
      index : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String is
      ve : Value_And_Error_Access := 
         buff.Get_Value_And_Error( key, 
                                   index, 
                                   postfix );   

   begin
      if( ve = Null ) then 
         return Null_Unbounded_String;
      end if;
      return ve.error_message;
   end Get_Error_Message;
   
   function Get_Num_Errors( buff : Buffer ) return Natural is
      use Utils;
      num_errors : Natural := 0;
            
      procedure Count_Errors_In_Map_Of_Arrays( c : Value_And_Error_Map_Package.Cursor ) is
      use Value_And_Error_Map_Package;
         vande : Value_And_Error_Vector := Element( c );
      begin
         for i in 1 .. Natural( vande.Length ) loop
            if( vande.Element( i ).error /= No_Error )then
               num_errors := num_errors + 1;
            end if;
         end loop;
      end Count_Errors_In_Map_Of_Arrays;
      
      procedure Count_Errors( c : Complete_Param_And_Value_Maps_Package.Cursor ) is
      use Complete_Param_And_Value_Maps_Package;
         cpvr : Complete_Param_And_Value_Rec := Element( c );
      begin
         case cpvr.etype is
         when single        => 
            if( cpvr.val.error /= No_Error )then
               num_errors := num_errors + 1;
            end if;
         when single_array  => 
            for i in 1 .. Natural( cpvr.vallist.Length ) loop
               if( cpvr.vallist.Element( i ).error /= No_Error )then
                  num_errors := num_errors + 1;
               end if;
            end loop;
         when map_of_arrays => 
            cpvr.valmap.Iterate( Count_Errors_In_Map_Of_Arrays'Access );
         end case;
      end Count_Errors;
      
   begin
      buff.params.Iterate( Count_Errors'Access ); 
      return num_errors;
   end Get_Num_Errors;
   
      
   procedure Load( 
      buff          : in out Buffer; 
      global_system : Parameter_System_Rec; 
      target_system : Parameter_System_Rec; 
      values        : Keyed_Text_Buffer.Text_Buffer;
      defaults      : Keyed_Text_Buffer.Text_Buffer;
      prefix        : Unbounded_String;
      year          : Year_Number := Year_Number'First ) is
   prefix_copy : Unbounded_String := prefix;
   
   use Text_Utils.String_Maps_Package;
   use Ada.Exceptions; 
   --
   -- note that we use Include rather than Insert here - overwrite
   -- anything currently there. This allows us to use this for
   -- restoration as well as initialisation
   --
   begin
      
      Iterate_Parameters:
      declare
      use Parameter_Rec_Package;
         num_params : constant Natural := Natural( target_system.parameters.Length );  
         parameter  : Parameter_Rec;
         key        : Unbounded_String;
         default    : Unbounded_String;
         value      : Unbounded_String;
       begin
         for pno in 1 .. num_params loop
            parameter := target_system.parameters.Element( pno );
            -- FIXME MISSING array params 
            case parameter.collection_type is
               when singular =>
                  declare
                     complete_value : Complete_Param_And_Value_Rec( single );
                  begin
                     key := prefix_copy & DELIMITER & parameter.instance_name;
                     Trace( log_trace, "Load: looking for key |" & To_String( key ) & "|" );
                     if( parameter.edit_info.display /= label_only )then
                        default := defaults.Element( key );
                        value := values.Element( key );
                     end if;
                     Trace( log_trace, "found it |" & TS( default ) & "|" );
                     complete_value.param_desc := parameter;
                     complete_value.val := Create_Value_And_Error_Access( 
                        parameter,
                        buff.lang,
                        value,
                        default );
                     if( parameter.enum_type_ref /= Null_Unbounded_String )then
                        complete_value.enum_type := 
                           Enum_Search.Get_Enum( global_system, To_String( parameter.enum_type_ref ));   
                     end if;
                     buff.params.Include( key, complete_value );
                  end;
            when list => -- TODDO COMPLETE THIS FOR AT LEAST ENUM CASE
                  declare
                     complete_value : Complete_Param_And_Value_Rec( single_array );
                  begin
                     key := prefix_copy & DELIMITER & parameter.instance_name;
                     if( parameter.enum_type_ref /= Null_Unbounded_String )then
                        complete_value.enum_type := 
                           Enum_Search.Get_Enum( global_system, To_String( parameter.enum_type_ref ));   
                     end if;
                     if( parameter.index_enum_type_ref /= Null_Unbounded_String )then
                        complete_value.index_enum_type := 
                           Enum_Search.Get_Enum( global_system, To_String( parameter.index_enum_type_ref ));   
                     end if;
                     buff.params.Include( key, complete_value );
                  end;
            when others =>
               Raise_Exception( Param_Exception'Identity, 
                   "Parameter-System.Input_Buffer : non single param is not inplemented parameter" & To_String( key ));
            end case;
         end loop;
      end Iterate_Parameters;
      
      Iterate_References:
      declare
      use Parameter_System_Reference_Rec_Package;  
      use Parameter_Rec_Package;
         num_references : constant Natural := Natural( target_system.parameter_system_references.Length );  
         key            : Unbounded_String;
         ref            : Parameter_System_Reference_Rec;
         reffed_system  : Parameter_System_Rec;
      begin
         --
         -- FIXME: this really isn't sensible
         -- treat this symmetrically with Subsystems below 
         for rno in 1 .. num_references loop
            ref := target_system.parameter_system_references.Element( rno );
            reffed_system := global_system.Get( To_String( ref.sys_type ), by_name );
            key := prefix_copy & DELIMITER & ref.instance_name;
            case ref.collection_type is
            when singular =>  
               Load( 
                  buff,
                  global_system,
                  reffed_system,
                  values,
                  defaults,
                  prefix_copy & DELIMITER & ref.instance_name,
                  year );
            when set      => 
                Raise_Exception( Param_Exception'Identity, 
                   "Parameter-System.Input_Buffer : set of params is not implemented key:" & To_String( key ));
            when Parameter_System.map      => 
                Raise_Exception( Param_Exception'Identity, 
                   "Parameter-System.Input_Buffer : map of params is not implemented key:" & To_String( key ));
            when list     => 
               case ref.index_type is
                  when none => 
                     Raise_Exception( Param_Exception'Identity, 
                        "Parameter-System.Input_Buffer : inconsistent state list: but no collection type key:" & To_String( key ));
                  when integer_type =>
                     declare
                     use Value_And_Error_Map_Package;
                        parameter  : Parameter_Rec;
                        num_params : constant Natural := Natural( reffed_system.parameters.Length );  
                        counter : Integer;
                        complete_value : Complete_Param_And_Value_Rec( map_of_arrays );
                        default_value : Unbounded_String;
                        value_str     : Unbounded_String;
                        index_key     : Unbounded_String;
                        counter_key   : constant Unbounded_String := key & DELIMITER & "count";
                        value         : Value_And_Error_Access; 
                        vel           : Value_And_Error_Vector;
                     begin
                        Trace( log_trace, "looking for counter | " & To_String( counter_key ));
                        counter := Integer'Value( To_String( values.Element( counter_key )));
                        Trace( log_trace, "got counter as " & counter'Img );
                        each_param:
                        for pno in 1 .. num_params loop
                           parameter := reffed_system.parameters.Element( pno );
                           vel.Clear; -- in case we're reloading
                           each_index:
                           for i in 1 .. counter loop
                              index_key := Line_Extractor.Make_Key( key, i, parameter.instance_name );
                              Trace( log_trace, "looking for index_key " & To_String( index_key ));
                              -- default might not exist of we've expanded rates and bands, for instance
                              if defaults.Contains( index_key )then
                                 default_value := defaults.Element( index_key );
                              else
                                 default_value := TuS( parameter.Default_Value_String );
                              end if;
                              value_str := values.Element( index_key );
                              Trace( log_trace, "found value " & To_String( default_value ));
                              value := Create_Value_And_Error_Access( 
                                 parameter,
                                 buff.lang,
                                 value_str,
                                 default_value );
                             
                              vel.Insert( i, value );
                              if( pno = 1 )then
                                 complete_value.index_strings.Append( TuS( i'Img( 2 .. i'Img'Length )));
                              end if;
                           end loop each_index;
                           complete_value.valmap.Include( parameter.instance_name, vel );
                        end loop each_param;
                        complete_value.system_desc := reffed_system;
                        complete_value.reference_desc := ref;
                        complete_value.current_size   := counter;
                        Correct_Array( complete_value ); -- make sure top is set on allowances, etc.
                        buff.params.Include( key, complete_value );
                        Trace( log_trace,  "final value: complete_value.current_size="&complete_value.current_size'Img );
                     end;
                  when enumerated_type =>
                     declare
                     use Value_And_Error_Map_Package;
                        parameter      : Parameter_Rec;
                        num_params     : constant Natural := Natural( reffed_system.parameters.Length );  
                        complete_value : Complete_Param_And_Value_Rec( map_of_arrays );
                        default_value  : Unbounded_String;
                        value_str      : Unbounded_String;
                        index_key      : Unbounded_String;
                        value          : Value_And_Error_Access; 
                        vel            : Value_And_Error_Vector;
                        index_enum     : Enumerated_Type_Rec := Enum_Search.Get_Enum( global_system, To_String( ref.index_enum_type_ref ));
                        counter        : Integer := Integer( index_enum.Values.Length );
                        ev             : Enum_Value_Rec;                          
                     begin
                        each_param_e:
                        for pno in 1 .. num_params loop
                           vel.Clear; -- in case we're reloading
                           parameter := reffed_system.parameters.Element( pno );
                           each_index_e:
                           for i in 1 .. counter loop
                              ev := index_enum.values.Element( i );
                              index_key := Line_Extractor.Make_Key( key, ev.name, parameter.instance_name );
                              Trace( log_trace, "looking for index_key " & To_String( index_key ));
                              Trace( log_trace, "looking for index_key " & To_String( index_key ));
                              default_value := defaults.Element( index_key );
                              value_str := values.Element( index_key );
                              Trace( log_trace, "found value " & To_String( default_value ));
                              value := Create_Value_And_Error_Access( 
                                 parameter,
                                 buff.lang,
                                 value_str,
                                 default_value );
                              vel.Insert( i, value );
                              if( pno = 1 )then
                                 complete_value.index_strings.Append( ev.name );
                              end if;
                           end loop each_index_e;
                           complete_value.valmap.Include( parameter.instance_name, vel );
                        end loop each_param_e;
                        complete_value.system_desc := reffed_system;
                        complete_value.reference_desc := ref;
                        complete_value.current_size   := counter;
                        complete_value.is_enumerated := True;
                        Correct_Array( complete_value ); -- make sure top is set on allowances, etc.
                        buff.params.Include( key, complete_value );   
                     end;
                  when string_type => --
                     Raise_Exception( Param_Exception'Identity, 
                         "Parameter-System.Input_Buffer : list of params using string index is not inplemented key:" & To_String( key ));
               end case;
            end case;
         end loop;
      end Iterate_References;
      
      Iterate_Subsystems:
      declare
         use Parameter_System_Rec_Package;
         subsys : Parameter_System_Rec;
         num_subsystems : constant Natural := Natural( target_system.parameter_systems.Length );
      begin
         for sno in 1 .. num_subsystems loop
            subsys := target_system.parameter_systems.Element( sno ).all;
            if( subsys.instance_name /= Null_Unbounded_String ) then
               Load( 
                  buff,
                  global_system,
                  subsys,
                  values,
                  defaults,
                  prefix_copy & DELIMITER & subsys.instance_name,
                  year );
               end if;
         end loop;
      
      end Iterate_Subsystems;
   
   end Load;
    
   function Init( 
      language              : Languages; 
      system_structure      : Parameter_System_Rec; 
      hashmap_of_parameters : Keyed_Text_Buffer.Text_Buffer;
      default_hashmap       : Keyed_Text_Buffer.Text_Buffer;
      start_year            : Year_Number := Year_Number'First;
      end_year              : Year_Number := Year_Number'First;
      year_prefix           : Unbounded_String := Null_Unbounded_String ) return Buffer is
      loaded_editing_buffer : Buffer;
      path : Unbounded_String := Null_Unbounded_String;
   begin
      path := path & system_structure.instance_name;
      loaded_editing_buffer.lang := language;
      loaded_editing_buffer.first_possible_year := start_year;
      loaded_editing_buffer.last_possible_year := end_year;
      loaded_editing_buffer.year_prefix := year_prefix;
      if( loaded_editing_buffer.Has_Years )then
         for year in loaded_editing_buffer.first_possible_year .. loaded_editing_buffer.last_possible_year loop
            path := loaded_editing_buffer.Year_Prefix_Str( year );
            Load( loaded_editing_buffer,
                  system_structure,
                  system_structure,
                  hashmap_of_parameters,
                  default_hashmap,
                  path,
                  year );
         end loop;
      else
         Load( loaded_editing_buffer,
               system_structure,
               system_structure,
               hashmap_of_parameters,
               default_hashmap,
               path );
      end if;
      return loaded_editing_buffer;
   end Init;
   
   procedure Load( 
      buff       : in out Buffer;  
      params     : in AWS.Parameters.List;
      year       : in Year_Number := Year_Number'First ) is
      num_cgi_values : Natural := params.count;
      input_year     : Year_Number := Year_Number'First;
      has_year       : Boolean;
   begin
      Loop_Round_CGI_Values:
      for i in 1 .. num_cgi_values loop
         declare
            key              : Unbounded_String := To_Unbounded_String( UnCensor_Id( params.Get_Name( i )));
            str_value        : String := params.Get_Value( i );
            is_indexed_key   : Boolean;
            base_key         : Unbounded_String;
            base_key_from_input : Unbounded_String;
            index            : Natural;
            postfix          : Unbounded_String;
            this_year_prefix : Unbounded_String;
         begin
            if( year /= Year_Number'First )then
               Line_Extractor.Parse_By_Year_Indexed_Key( 
                  key,
                  this_year_prefix,
                  has_year,
                  input_year,
                  base_key_from_input,
                  is_indexed_key,
                  index,
                  postfix );
             else
               Line_Extractor.Parse_Indexed_Key(  -- from the parameters, with the year prefix stripped off
                  key,
                  is_indexed_key, 
                  base_key_from_input,       
                  index,          
                  postfix );
            end if;
            if( buff.Year_Prefix_Str( year ) /= Null_Unbounded_String )then
               base_key := buff.Year_Prefix_Str( year ) & '.' & base_key_from_input;
            else
               base_key := base_key_from_input;
            end if;
            Trace( log_trace, "looking for base_key |" & TS( base_key ) & 
                 "| index |" & Natural'Image( index ) & 
                 " postfix |" & TS( postfix ) & 
                 "| from key |" & TS( key ) & "| " &
                 "str_value |" & str_value & "| " );
            if( buff.params.Contains( base_key ))then
               declare
                  use Utils;
                  param_and_value : Complete_Param_And_Value_Rec := buff.params.Element( base_key );
                  val_and_err     : Value_And_Error_Access := Get_Value_And_Error( param_and_value, index, postfix );
                  param_desc      : Parameter_Rec := Get_Parameter_Rec( buff, base_key, postfix );
               begin  
                  if( val_and_err /= null )then
                     Trace( log_trace, "Got val_and_err" );
                     val_and_err.text := To_Unbounded_String( str_value );
                     case val_and_err.dtype is
                        when real_type       => 
                           Trace( log_trace, "validating " & str_value & " against min " & 
                           Format( param_desc.edit_info.min, buff.lang ) & 
                           " max " & Format( param_desc.edit_info.max, buff.lang ));
                           Validate( 
                              str_value, 
                              buff.lang, 
                              val_and_err.rval, 
                              val_and_err.error_message, 
                              val_and_err.error, 
                              param_desc.edit_info.min, 
                              param_desc.edit_info.max );
                           if( val_and_err.error = no_error )then
                              val_and_err.text := To_Unbounded_String( Format( val_and_err.rval, buff.lang )); -- FIXME precision                                       
                           else
                              val_and_err.text := TuS( str_value );
                           end if;
                        when integer_type    =>
                           declare
                              imin : Integer;
                              imax : Integer;
                           begin
                              if param_desc.edit_info.min < Float_Type( Integer'First )then
                                 imin := Integer'First;
                              else
                                 imin := Integer( param_desc.edit_info.min );
                              end if;
                              if param_desc.edit_info.max < Float_Type( Integer'Last )then
                                 imax := Integer( param_desc.edit_info.max );
                              else
                                 imax := Integer'Last;
                              end if;
                              Validate( 
                                 str_value, 
                                 buff.lang, 
                                 val_and_err.ival, 
                                 val_and_err.error_message, 
                                 val_and_err.error, 
                                 imin,
                                 imax );
                           end;
                           if( val_and_err.error = no_error )then
                              val_and_err.text := To_Unbounded_String( Format( val_and_err.ival, buff.lang ));                                       
                           else
                              val_and_err.text := TuS( str_value );
                           end if;
                        when enumerated_type => val_and_err.eval := val_and_err.text; -- store I val & assume no error possible 
                           Trace( log_trace, "enumerated_type;eval = " & TS( val_and_err.eval ));
                           
                        when boolean_type    => 
                            --
                            -- This is convoluted, but this parsing code
                            -- only handles parameters actually passed to it,
                            -- and nothing is passed in the case of an unchecked checkbox,
                            -- so we'll add a hidden field with that key value to alert the parsing code
                            -- that the field must be there. The actual value (if checked) is in <base_key>_value
                            --
                           declare
                              bkey : String := Get_Boolean_Value_String( buff, param_and_value, input_year, base_key_from_input, index, postfix ); 
                              actual_value : constant String := params.Get( bkey );
                              -- FIXME what a mess - try again with '[xx]'s
                              actual_value_2 : constant String := params.Get( Uncensor_Id( bkey ));
                           begin
                              Trace( log_trace, "made boolean value key of |" & bkey & "| actual value=|" & actual_value & "| " );
                              val_and_err.bval := actual_value = "on" or actual_value_2 = "on"; -- FIXME: this assumes a checkbox!
                           end;
                        when string_type     => val_and_err.sval := val_and_err.text;
                           -- passwords, email, .... checks from logical type
                        when date_type       => null; 
                        when decimal_type    => null; -- dval
                     end case;                  
                     if( param_and_value.on_change_handler /= null ) and then 
                       ( val_and_err.error = no_error ) then
                        param_and_value.on_change_handler.all( buff ); 
                     end if;
                  end if;
               end;
            else
               Trace( log_trace, "not found; " ); -- buffer is " & Print_Keys( buff.params ));
            end if;
         end;         
      end loop Loop_Round_CGI_Values;
   end Load;
   
   function Print_Keys( map : Complete_Param_And_Value_Map ) return String is
   use Complete_Param_And_Value_Maps_Package;
       s : Unbounded_String;
       
    procedure Print_One( c : Cursor ) is
       k : Unbounded_String := Key( c );
    begin          
       s := s & "|" & k & "|" & LINE_BREAK;
    end Print_One;
       
   begin
        Iterate( map, Print_One'Access );
        return TS( s );
   end Print_Keys;
   
   procedure Set_Handler( 
      buff    : in out Buffer;
      target  : Unbounded_String;
      handler : Handler_Access_T;
      htype   : Handler_Type ) is
      param_and_value : Complete_Param_And_Value_Rec;
   begin
      if( buff.params.Contains( target ))then
         param_and_value := buff.params.Element( target );
         case htype is
            when on_change =>
               param_and_value.on_change_handler := handler;
            when on_display =>
               param_and_value.on_display_handler := handler;
         end case;
         buff.params.Replace( target, param_and_value );
      end if;
   end Set_Handler;

   procedure Replace_Enum( 
      buff      : in out Buffer; 
      key       : Unbounded_String;
      enum_type : Enumerated_Type_Rec ) is
      v : Complete_Param_And_Value_Rec := buff.params.Element( key );
   begin
      v.enum_type := enum_type;
      buff.params.Replace( key, v );
   end Replace_Enum;

   function Get_Enum( 
      buff      : Buffer; 
      key       : Unbounded_String ) return Enumerated_Type_Rec is
   begin
      return buff.params.Element( key ).enum_type;
   end Get_Enum;
   --
   -- FIXME need lots more of these ..
   --
   
end Parameter_System.Input_Buffer;
