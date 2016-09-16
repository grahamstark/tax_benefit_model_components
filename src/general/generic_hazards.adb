with Text_Utils;
with Ada.Strings.Unbounded;

package body Generic_Hazards is   
   
   function To_Hazards( tab : in out Table_Type )  return Table_Type is
      htab : Table_Type := ( others => ( others => 0.0 ));
      row_tots : array( Values_Range ) of Amount := ( others => 0.0 ); 
   begin
      for r in Values_Range loop
         for c in Values_Range loop 
            row_tots( r ) := row_tots( r ) + tab( r, c );
         end loop;
      end loop;
      for r in Values_Range loop
         if row_tots( r ) /= 0.0 then
            for c in Values_Range loop            
               htab( r,c ) := tab( r, c ) / row_tots( r );
            end loop;
         end if;
      end loop;      
      return htab;
   end To_Hazards;
   
   function To_String( tab : Table_Type ) return String is
   use Text_Utils;
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for r in Values_Range loop
         for c in Values_Range loop
            s := s & Prettify_Image( r'Img ) & " => " & Prettify_Image( c'Img ) & ", " & tab( r, c )'Img & LINE_BREAK; 
         end loop;
      end loop;
      return TS( s );
   end To_String;
      
   function To_String( tab : Abs_Table_Type_Array ) return String is
   use Text_Utils;
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      s := s & ",";
      for year in tab'Range loop
         s := s & year'Img & ",";
      end loop;
      s := s & LINE_BREAK;
      for r in Values_Range loop
         for c in Values_Range loop
            s := s & Prettify_Image( r'Img ) & " => " & Prettify_Image( c'Img ) & ", ";
            for year in tab'Range loop
               s := s & tab( year )( r, c )'Img & ",";
            end loop;
            s := s & LINE_BREAK;
         end loop;
       end loop;      
      return TS( s );
   end To_String;
   
end Generic_Hazards;