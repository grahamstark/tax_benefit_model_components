with Text_Utils;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Characters.Handling;
with Ada.Text_IO;

package body T_Utils.Web_IO is
   
   function Image( i : T ) return String is
      use Ada.Strings.Fixed;
      use Ada.Strings;   
      use Ada.Characters.Handling;
   begin
      return To_Lower(Trim( T'Image( i ), Both ));      
   end Image;

   function Make_Checkbox( 
      varname : Unbounded_String;
      selected : Boolean ) return Unbounded_String is
      s : Unbounded_String;
   begin
      s := s & "<input type='checkbox' name='" & varname & "'";
      if( selected ) then
         s := s & " checked='checked' ";
      end if;
      s := s & " />";
      return s;
   end Make_Checkbox;

   function Handle( 
      varname : String; 
      params : AWS.Parameters.List ) return Set is
   use Text_Utils;
   use Ada.Text_IO;
      s : Set;
      key : Unbounded_String;
   begin
      for i in t'Range loop
         key := TuS( varname ) & "_" & Image( i );
         -- Put_Line( "looking for " & TS(key) );
         if( AWS.Parameters.Exist( params, TS(key) ) )then
            Set_Ops.Include( s, i );
         end if;
      end loop;
      return s;
   end Handle;
   
   function Make_Select(
      varname             : String;
      selected_element    : T; 
      printer             : Pretty_Print_Item_Access_T; -- a function to display a nice string for each value of T
      displayed_elements  : Set := EMPTY_SET            -- empty = print everything; otherwise print just what's in the set  
      ) return Unbounded_String is
      use type Set;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & "<select name='" & varname & "' id='" & varname & "'>" & LINE_BREAK;
      for i in t'Range loop
         if(( displayed_elements = EMPTY_SET ) or ( Set_Ops.Contains( displayed_elements, i ))) then
            s := s & "<option value='" & Image(i) & "' ";
            if( i = selected_element ) then
               s := s & " selected='selected' ";
            end if;
            s := s & ">";
            s := s & printer( i );
            s := s & "</option>" & LINE_BREAK;
         end if;         
      end loop;      
      s := s & "</select>";
      return s;
   end Make_Select;
   
   function Make_Discrete_Select_Boxes(
      group_id            : String;
      varname             : String;
      selected_elements   : Set; 
      printer             : Pretty_Print_Item_Access_T;
      displayed_elements  : Set := EMPTY_SET; 
      container_css_class               : String := "" ) return Unbounded_String is
      
      use type Set;
      use Text_Utils;
      
      id : constant String := varname & "_" & group_id; 
      s : Unbounded_String;
      checked : Boolean;
      local_varname  : Unbounded_String := TuS( "" );
      class_decl     : Unbounded_String := TuS( "" );
      row_class      : Unbounded_String;
      p              : Natural := 0;
   begin
      if( container_css_class /= "" ) then
         class_decl := TuS(" class='" ) & container_css_class & "' ";
      end if;
      s := s & Indent( 1 ) & "<div id='" & id & "_block' " & class_decl & " >" & LINE_BREAK;
      s := s & Indent( 2 ) & "<table>" & LINE_BREAK;
      s := s & Indent( 3 ) & "<tbody>" & LINE_BREAK;
      
      for i in t'Range loop
         if(( displayed_elements = EMPTY_SET ) or ( Set_Ops.Contains( displayed_elements, i ))) then
            checked := False;
            if( Set_Ops.Contains( selected_elements, i ) )then
               checked := True;
            end if;
            if( p MOD 2 ) = 0 then
               row_class := TuS( "tableRowEven" );
            else
               row_class := TuS( "tableRowOdd" );
            end if;
            s := s & Indent( 4 ) & "<tr class='" & row_class & "' >" & LINE_BREAK;
            s := s & Indent( 5 ) & "<td align='left'> " & printer( i ) & "&nbsp;&nbsp;</td>" & LINE_BREAK;
            local_varname := TuS( id ) & "_" & Image( i );
            s := s & Indent( 5 ) & "<td align='left'> " & Make_Checkbox( local_varname, checked ) & " </td>" & LINE_BREAK;
            s := s & Indent( 4 ) & "</tr> " & LINE_BREAK;
            p := p + 1;
         end if;
      end loop;
      s := s & Indent( 3 ) & "</tbody>" & LINE_BREAK;
      s := s & Indent( 2 ) & "</table>" & LINE_BREAK;   
      s := s & Indent( 1 ) & "</div>" & LINE_BREAK;
      return s;
   end Make_Discrete_Select_Boxes;
   
   function To_Table( 
      caption : String := ""; 
      a : Abs_Amount_Array; 
      print_zeros : Boolean := False ) return String is
      use Text_Utils;
      s : Unbounded_String;
   begin
      if not print_zeros then
         if( for all i of a => i = 0.0 ) then
            return "";
         end if;
      end if;
      s := s & "<table>" & LINE_BREAK;
      s := s & "<caption>" & caption & "</caption>" & Line_Break;
      for i in T loop
         if( a( i ) /= 0.0 ) or print_zeros then
            s := s & "<tr><th>" & Prettify_Image( i'Img ) & "</th><td>" & AFormat.Format( a( i )) & "</td></tr>"&LINE_BREAK;
         end if;
      end loop;
      s := s & "</table>";
      return TS( s );
   end To_Table;
   
   function To_Table( 
      caption : String := ""; 
      a : Abs_Boolean_Array; 
      print_zeros : Boolean := False ) return String is
      use Text_Utils;
      s : Unbounded_String;
   begin
      if not print_zeros then
         if( for all i of a => not i ) then
            return "";
         end if;
      end if;
      s := s & "<table>" & LINE_BREAK;
      s := s & "<caption>" & caption & "</caption>" & Line_Break;
      for i in T loop
         if not a( i ) or print_zeros then
            s := s & "<tr><th>" & Prettify_Image( i'Img ) & "</th><td>" & a( i )'Img & "</td></tr>"&LINE_BREAK;
         end if;
      end loop;
      s := s & "</table>";
      return TS( s );
   end To_Table;
   
   function To_Table( 
      caption : String := ""; 
      a : Abs_Integer_Array; 
      print_zeros : Boolean := False ) return String is
      use Text_Utils;
      s : Unbounded_String;
   begin
      if not print_zeros then
         if( for all i of a => i = 0 ) then
            return "";
         end if;
      end if;
      s := s & "<table>" & LINE_BREAK;
      s := s & "<caption>" & caption & "</caption>" & Line_Break;
      for i in T loop
         if( a( i ) /= 0 ) or print_zeros then
            s := s & "<tr><th>" & Prettify_Image( i'Img ) & "</th><td>" & a( i )'Img & "</td></tr>"&LINE_BREAK;
         end if;
      end loop;
      s := s & "</table>";
      return TS( s );
   end To_Table;
   
   function To_Table( 
      caption     : String := "";      
      a           : Abs_Amount_Array;
      a_label     : String;
      b           : Abs_Amount_Array;
      b_label     : String;
      print_differences : Boolean := True;
      print_zeros : Boolean := False ) return String is
      
      use Text_Utils;
      s : Unbounded_String;
   begin
      if not print_zeros then
         if( for all i in T => a( i ) = 0.0 and b( i ) = 0.0 ) then
            return "";
         end if;
      end if;

      s := s & "<table>" & LINE_BREAK;
      s := s & "<caption>" & caption & "</caption>" & Line_Break;
      s := s & "<tr><th>"&a_label&"</th><th>"&b_label&"</th>";
      if print_differences then
         s := s & "<th>Difference</th>";
      end if;
      s := s & "</tr>" & LINE_BREAK;
      
      for i in T loop
         if( a( i ) /= 0.0 ) or b( i ) /= 0.0 or print_zeros then
            s := s & "<tr><th>" & Prettify_Image( i'Img ) & "</th>";
            s := s & "<td>" & AFormat.Format( a( i )) & "</td>";
            s := s & "<td>" & AFormat.Format( b( i )) & "</td>";
            if print_differences then
               s := s & "<td>" & AFormat.Format( b( i )-a( i )) & "</td>";
            end if;
            s := s & "</tr>" & LINE_BREAK;
         end if;
      end loop;
      s := s & "</table>";
      return TS( s );
   end To_Table;
   
end T_Utils.Web_IO;
