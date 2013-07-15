with Ada.Text_IO.Editing;
with Ada.Strings.Fixed;
with Text_Utils;
with Ada.Strings;
with Strings_Edit.Float_Edit;
with AWS.URL;
with Standard_Colours;
with Colours;
with Format_Utils;

package body T_Utils.Google_Chart_Generator is


   package A_Edit is new Strings_Edit.Float_Edit( Amount_Type );
   package f_utils is new Format_Utils( Float_Type=>Amount_Type, Counter_Type=> Counter_Type );
   use Ada.Strings;
   use Text_Utils;
   use Colours;
   
   -- see: http://code.google.com/apis/chart/docs/data_formats.html#axis_scale
   function Simple_Encode( data : Abs_Amount_Array ) return String is
      b : Unbounded_String;
      pos : Positive;
      SIMPLE_ENCODING : constant String := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      max : Amount_Type := Amount_Type'First;
   begin
      for i in T loop
         if( data( i ) > max )then max := data( i ); end if;   
      end loop;
      for i in T loop
         pos := 1;
      end loop;
      return TS( b );   
   end Simple_Encode;
   
   procedure Append_Number( s : in out Unbounded_String; d : Amount_Type ) is
      numstr : String(1..50);
      p : Positive := 1;
   begin
      A_Edit.Put( Destination => numstr, 
                  Pointer => p, 
                  Value => d,
                  RelSmall => 6,  
                  AbsSmall => 1 );
      s := s & f_utils.Format( d ); --numstr( 1 .. p-1 );
   end Append_Number;
   
   function Make_Colour_Text( ctype : Chart_Type ) return Unbounded_String is 
   use Standard_Colours;
   use Colours;
      colstr : Unbounded_String := TuS( "&amp;chco=" );
      col : Standard_Colours_Type := Standard_Colours_Type'First;
   begin
      if( ctype = pie ) or ( ctype = pie_3d ) then
         begin
            for i in T loop
               colstr := colstr & To_String( STD_COLOURS( col ));
               if( col /= Standard_Colours_Type'Last ) then
                  col := Standard_Colours_Type'Succ( col );
               else
                  col := Standard_Colours_Type'First;
               end if;
               if( i /= T'Last ) then
                  colstr := colstr & "|";
               end if;
            end loop;
         end;
      else
         colstr := colstr & To_String( STD_COLOURS( slate_blue ));
      end if;
      return colstr;
   end Make_Colour_Text;
      
   function Make_Univariate_Chart( 
      title               : String;
      data                : Abs_Amount_Array;
      printer             : Pretty_Print_Item_Access_T;
      ctype               : Chart_Type;
      is_thumbnail        : Boolean;
      displayed_elements  : Set := EMPTY_SET ) return Unbounded_String is
   use type Set;   
      data_string : Unbounded_String := TuS( "&amp;chd=t:" );
      url : Unbounded_String := TuS( "http://chart.apis.google.com/chart?cht=" & To_String( ctype ));
      min : Amount_Type := Amount_Type'Last;
      max : Amount_Type := Amount_Type'First;
   begin
      -- Encode_Data( data, data_string, units_string );
      for i in data'Range loop
         if( displayed_elements = EMPTY_SET ) or ( Set_Ops.Contains( displayed_elements, i )) then
            if( data(i) > max ) then max := data(i); end if;
            if( data(i) < min ) then min := data(i); end if;
            Append_Number( data_string, data(i) );         
            if( i /= data'Last ) then
               data_string := data_string & ",";
            end if;
         end if;
      end loop;
      url := url & data_string;      
      -- if( max > 100.0 ) or ( min < 0.0 ) then
         -- -- scale the data using chds ...
         -- -- if( min /= 0.0 ) then min := min * 1.20; end if;
         -- -- if( max /= 100.0 ) then max := max * 1.20; end if;
         -- declare
            -- bs : Unbounded_String := TuS( "&amp;chds=" );
         -- begin
            -- Append_Number( bs, min );
            -- bs := bs & ",";
            -- Append_Number( bs, max );
            -- url := url & bs;
         -- end;
      -- end if;
      if( not is_thumbnail ) then
         -- labels for full-size charts
         url := url & "&amp;" & FULL_SIZE_STR;
         url := url & "&amp;chtt=" & AWS.URL.Encode( title );
         declare
            keystr : Unbounded_String := TuS( "&amp;chxt=x,y" );
         begin
            if( Is_Vertical( ctype )) then
               keystr := keystr & "&amp;chxl=0:|";
            elsif( Is_Horizontal( ctype )) then
               keystr := keystr & "&amp;chxl=1:|";
            else
               keystr := keystr & "&amp;chl=";               
            end if;
            if( Is_Horizontal( ctype )) then 
               -- for some strange reason the labels are displayed the opposite way around to the data in horizontally aligned
               -- charts, so we'll do this backwards
               for i in reverse T loop
                  if( displayed_elements = EMPTY_SET ) or ( Set_Ops.Contains( displayed_elements, i )) then
                     keystr := keystr & AWS.URL.Encode( printer(i) );
                     if( i /= data'First ) then
                        keystr := keystr & "|";
                     end if;
                  end if;               
               end loop;
            else
               for i in T loop
                  if( displayed_elements = EMPTY_SET ) or ( Set_Ops.Contains( displayed_elements, i )) then
                     keystr := keystr & AWS.URL.Encode( printer(i) );
                     if( i /= data'Last ) then
                        keystr := keystr & "|";
                     end if;
                  end if;
               end loop;
            end if;
            url := url & keystr;
         end;
         if( Is_Bar( ctype )) then
            url := url & "&amp;chbh=a"; -- auto size bars
            declare
               imin : Integer := Integer( min );
               imax : Integer := Integer( max );
               min_str : constant String := Integer'Image( imin )( 2 .. Integer'Image( imin )'Length );
               max_str : constant String := Integer'Image( imax )( 2 .. Integer'Image( imax )'Length );
            begin
               url := url & "&amp;chxr=0," & min_str & "," & max_str;
            end;
            -- url := url & "&amp;chxr=1,"; -- y axis scale - FIXME BOTH at once?
            -- Append_Number( url, min );
            -- url := url & ",";
            -- Append_Number( url, max );
         end if;
      else
         url := url & "&amp;" & THUMBNAIL_SIZE_STR;    
         if( Is_Bar( ctype )) then
            url := url & "&amp;chbh=a,1,0"; -- auto size bars
         end if;
      end if;
      url := url & Make_Colour_Text( ctype );
      return url;
   end Make_Univariate_Chart;
      

end T_Utils.Google_Chart_Generator;
