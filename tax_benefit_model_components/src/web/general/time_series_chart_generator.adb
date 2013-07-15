with Text_Utils;
with Ada.Strings.Fixed;
with AWS.URL;
with Ada.Text_IO.Editing;
with Ada.Strings;

package body Time_Series_Chart_Generator is

   use Text_Utils;
   
   function Construct( 
      plotter_url         : String;
      title               : String;
      subtitle            : String;
      start_year          : Year_Number;
      x_axis_label        : String;
      y_axis_label        : String;
      ctype               : Chart_Type;
      system              : Pre_Or_Post ) return Time_Series_Chart is
      chart : Time_Series_Chart;
   begin
      chart.plotter_url := TuS( plotter_url );
      chart.title := TuS( title );
      chart.subtitle := TuS( subtitle );
      chart.start_year := start_year;
      chart.x_axis_label := TuS( x_axis_label );
      chart.y_axis_label := TuS( y_axis_label );
      chart.ctype := ctype;
      chart.system := system;
      return chart;
   end Construct;
 
   
   function Data_To_Str( 
      data        : Time_Series_Array ) return Unbounded_String is
      data_string : Unbounded_String ;
   use Ada.Strings.Fixed;  
   use Ada.Text_IO.Editing;
   use Ada.Strings;
   begin
      for i in data'Range loop
         declare
            ds : String := AWS.URL.Encode( Trim( Real_Type'Image( data( i )), both ));
         begin
            data_string := data_string & ds;
         end;
         if( i /= data'Last ) then  -- FIXME Wrong if remaining not in displayed element
            data_string := data_string & ",";
         end if;
      end loop;      
      return data_string;
   end  Data_To_Str;

    function Write_Data_Group(
       prefix : String;
        dl     : Data_List ) return Unbounded_String is
       s      : Unbounded_String;
   begin
      for i in 1 .. Natural( dl.Length )  loop
         declare
            it     : Data_Item := dl.Element( i );  
            iss    : constant String := Natural'Image( i )( 2 .. Natural'Image( i )'Length );
            colstr : constant String := To_String( STD_COLOURS( it.colour ));
         begin
            s := s & "&amp;" & "da_" & prefix & "_" & iss & "=" & Data_To_Str( it.data );
            s := s & "&amp;" & "col_" & prefix & "_" & iss & "=" & colstr;
            if( it.label /= Null_Unbounded_String )then
               s := s & "&amp;" & "dt_" & prefix & "_" & iss & "=" & AWS.URL.Encode( TS( it.label ));
            end if;
         end;
      end loop;
      return s;
   end Write_Data_Group;
   
   
   procedure Add_Data_Series( 
      chart        : in out Time_Series_Chart;
      data         : Time_Series_Array;
      label        : String;
      colour       : Standard_Colours_Type;
      which_system : Positive := 1 ) is
      di : Data_Item;
   begin
      di.label := TuS( label );
      di.colour := colour;
      di.data := data;
      chart.data( which_system ).Append( di );
   end  Add_Data_Series;
      
   function To_URL( chart : Time_Series_Chart; size : Chart_Size; is_svg : Boolean ) return Unbounded_String is
      type_str       : constant String := Censor_String( Chart_Type'Image( chart.ctype ));
      size_str       : constant String := Censor_String( Chart_Size'Image( size ));
      style_str      : constant String := Censor_String( Chart_Style'Image( chart.style ));
      sys_str        : constant String := Censor_String( Pre_Or_Post'Image( chart.system ));
      start_year_str : constant String := Censor_String( Year_Number'Image( chart.start_year ));
      end_year       : constant Year_Number := chart.start_year + Time_Series_Array'Length;
      end_year_str   : constant String := Censor_String( Year_Number'Image( end_year ));
      num_series     : constant Natural := ( if chart.system = post then Natural( chart.data( 2 ).Length ) else Natural( chart.data( 1 ).Length ));
      num_series_str : constant String := Censor_String( Natural'Image( num_series ));
      svg_str        : constant String := ( if is_svg then "1" else "0" );
      url : Unbounded_String := chart.plotter_url & "?" & 
          "type=" & type_str & 
          "&amp;size=" & size_str & 
          "&amp;style=" & style_str & 
          "&amp;pre_or_post=" & sys_str & 
          "&amp;num_series=" & num_series_str & 
          "&amp;start_year=" & start_year_str &
          "&amp;end_year=" & end_year_str &
          "&amp;svg=" & svg_str;
   begin
      if( size /= thumb ) then
         url := url & "&amp;title=" & AWS.URL.Encode( TS( chart.title ));
         url := url & "&amp;subtitle=" & AWS.URL.Encode( TS( chart.subtitle ));
         url := url & "&amp;xlabel=" & AWS.URL.Encode( TS( chart.x_axis_label ));
         url := url & "&amp;ylabel=" & AWS.URL.Encode( TS( chart.y_axis_label ));
      end if;
      if chart.system = pre or chart.system = pct_change or chart.system = abs_change then
         url := url & Write_Data_Group( "pre", chart.data( 1 ));
      end if;
      if chart.system = post or chart.system = both then
         url := url & Write_Data_Group( "post", chart.data( 2 ));
      end if;      
   	return url;
   end To_URL;


end Time_Series_Chart_Generator;
