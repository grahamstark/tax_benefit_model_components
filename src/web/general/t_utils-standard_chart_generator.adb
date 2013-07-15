with Ada.Text_IO.Editing;
with Ada.Strings.Fixed;
with Text_Utils;
with Ada.Strings;
with Strings_Edit.Float_Edit;
with AWS.URL;
with Format_Utils;
with Ada.Strings.Fixed;

package body T_Utils.Standard_Chart_Generator is

   package f_utils is new Format_Utils( Float_Type=>Amount_Type, Counter_Type=> Counter_Type );
   use Ada.Strings;
   use Text_Utils;
   use General_Chart_Constants;
   
      --
   -- Dmitry's formatting package NOT USED
   --
   package Local_Float_Edit is new Strings_Edit.Float_Edit( Number => Amount_Type );

   function Data_To_Str( 
      data  : Abs_Amount_Array;
      displayed_elements  : Set ) return String is
      data_string : Unbounded_String ;
   use type Set;
   use Ada.Strings.Fixed;  
   begin
      for i in data'Range loop
         if( displayed_elements = EMPTY_SET ) or ( displayed_elements.Contains( i )) then
            declare
               ds : String := AWS.URL.Encode( Trim( Amount_Type'Image( data( i )), both ));
            begin
               data_string := data_string & ds;
            end;
            if( i /= data'Last ) then  -- FIXME Wrong if remaining not in displayed element
               data_string := data_string & ",";
            end if;
         end if;
      end loop;      
      return TS( data_string );
   end  Data_To_Str;
   
   function Make_Univariate_Chart( 
      plotter_url         : String;
      title               : String;
      subtitle            : String;
      data1               : Abs_Amount_Array;
      x_axis_label        : String;
      y_axis_label        : String;
      printer             : Pretty_Print_Item_Access_T;
      ctype               : Chart_Type;
      size                : Chart_Size;
      system              : Pre_Or_Post      := pre;
      style               : Chart_Style      := normal;
      data2               : Abs_Amount_Array := ZERO_Abs_Amount_Array;
      displayed_elements  : Set := EMPTY_SET ) return Unbounded_String
   is
   
   use type Set;   
      type_str  : constant String := Censor_String( Chart_Type'Image( ctype ));
      size_str  : constant String := Censor_String( Chart_Size'Image( size ));
      style_str : constant String := Censor_String( Chart_Style'Image( style ));
      sys_str   : constant String := Censor_String( Pre_Or_Post'Image( system ));
      url : Unbounded_String := TuS( plotter_url & "?" ) & 
          "type=" & type_str & 
          "&amp;size=" & size_str & 
          "&amp;style=" & style_str & 
          "&amp;pre_or_post=" & sys_str & 
          "&amp;num_series=1&amp;";
   begin
      case system is
         when pre => 
         	url := url & "da_pre_1=" & Data_To_Str( data1, displayed_elements );
         	url := url & "&amp;col_pre_1=" & To_String( STD_COLOURS( dark_gray_blue ));
         when post => 
            url := url & "da_post_1=" & Data_To_Str( data1, displayed_elements );
            url := url & "&amp;col_post_1=" & To_String( STD_COLOURS( dark_gray_blue ));
         when both | abs_change | pct_change =>  
            url := url & "da_pre_1=" & Data_To_Str( data1, displayed_elements );
            url := url & "&amp;da_post_1=" & Data_To_Str( data2, displayed_elements );
            url := url & "&amp;col_pre_1=" & DEFAULT_PRE_COLOUR_STRING;
            url := url & "&amp;col_post_1=" & DEFAULT_POST_COLOUR_STRING;
      end case;
      if( size /= thumb ) then
         url := url & "&amp;title=" & AWS.URL.Encode( title );
         url := url & "&amp;subtitle=" & AWS.URL.Encode( subtitle );
         url := url & "&amp;xlabel=" & AWS.URL.Encode( x_axis_label );
         url := url & "&amp;ylabel=" & AWS.URL.Encode( y_axis_label );
         declare
            keystr : Unbounded_String := TuS( "&amp;labels=" );
         begin
            for i in  T loop
               if( displayed_elements = EMPTY_SET ) or ( Set_Ops.Contains( displayed_elements, i )) then
                  keystr := keystr & AWS.URL.Encode( printer(i) );
                  if( i /= data1'Last ) then
                     keystr := keystr & "|";
                  end if;
               end if;               
            end loop;
            url := url & keystr;
         end;
      end if;
      return url;
   end Make_Univariate_Chart;
   
   -- function Write_Data_Group(
      -- prefix : String;
      -- colour : Standard_Colours_Type;
      -- data : Data_Series_Array ) return Unbounded_String is
      -- s : Unbounded_String;
      -- colstr : constant String := To_String( STD_COLOURS( colour ));
  -- begin
     -- for i in data'Range loop
        -- declare
           -- iss : constant String := Positive'Image( i )( 2 .. Positive'Image( i )'Length );
        -- begin
           -- s := s & "&amp;" & "da_" & prefix & "_" & iss & "=" & Data_To_Str( data( i ), EMPTY_SET);
           -- s := s & "&amp;" & "col_" & prefix & "_" & iss & "=" & colstr;
        -- end;
     -- end loop;
     -- return s;
  -- end Write_Data_Group;
   -- 
   -- 
  -- function Make_Time_Series_Chart(      
      -- plotter_url         : String;
      -- title               : String;
      -- subtitle            : String;
      -- start_year          : Year_Number;
      -- end_year            : Year_Number;      
      -- data                : Data_Series_Array;
      -- x_axis_label        : String;
      -- y_axis_label        : String;
      -- ctype               : Chart_Type;
      -- size                : Chart_Size;
      -- system              : Pre_Or_Post := pre;
      -- style               : Chart_Style := normal ) return Unbounded_String is
   -- use type Set;   
      -- type_str  : constant String := Censor_String( Chart_Type'Image( ctype ));
      -- size_str  : constant String := Censor_String( Chart_Size'Image( size ));
      -- style_str : constant String := Censor_String( Chart_Style'Image( style ));
      -- sys_str   : constant String := Censor_String( Pre_Or_Post'Image( system ));
      -- start_y_str : constant String := Year_Number'Image( start_year );
      -- end_y_str : constant String := Year_Number'Image( end_year );
      -- url : Unbounded_String := TuS( plotter_url & "?" ) & 
          -- "type=" & type_str & 
          -- "&amp;size=" & size_str & 
          -- "&amp;style=" & style_str & 
          -- "&amp;pre_or_post=" & sys_str & 
          -- "&amp;start_year=" & start_y_str &      
          -- "&amp;end_year=" & end_y_str &      
          -- "&amp;num_series=1&amp;";
   -- begin
      -- url := url & Write_Data_Group( "pre", vw_dark_blue, data );
      -- if( size /= thumb ) then
         -- url := url & "&amp;title=" & AWS.URL.Encode( title );
         -- url := url & "&amp;subtitle=" & AWS.URL.Encode( subtitle );
         -- url := url & "&amp;xlabel=" & AWS.URL.Encode( x_axis_label );
         -- url := url & "&amp;ylabel=" & AWS.URL.Encode( y_axis_label );
      -- end if;
      -- return url;
   -- end Make_Time_Series_Chart;
   -- 
   -- function Make_Time_Series_Chart_2(      
      -- plotter_url         : String;
      -- title               : String;
      -- subtitle            : String;
      -- start_year          : Year_Number;
      -- end_year            : Year_Number;      
      -- data1               : Data_Series_Array;
      -- data2               : Data_Series_Array;
      -- x_axis_label        : String;
      -- y_axis_label        : String;
      -- ctype               : Chart_Type;
      -- size                : Chart_Size;
      -- system              : Pre_Or_Post      := pre;
      -- style               : Chart_Style      := normal ) return Unbounded_String is
      -- url : Unbounded_String; 
   -- begin
      -- url := Make_Time_Series_Chart( 
         -- plotter_url,   
         -- title,          
         -- subtitle,       
         -- start_year,     
         -- end_year,       
         -- data1,          
         -- x_axis_label,   
         -- y_axis_label,   
         -- ctype,          
         -- size,           
         -- system,         
         -- style );
      -- url := url & Write_Data_Group( "post", vw_red, data2 );
      -- return url;   
   -- end Make_Time_Series_Chart_2;
   -- 
end T_Utils.Standard_Chart_Generator;
