pragma License( Modified_GPL );

package body Keyed_Buffer is

   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   procedure Initialise_Row( buff : in out Buffer; key : String; value : String ) is
      uk : constant Unbounded_String := TuS( key );
      uv : constant Unbounded_String := TuS( value );
      ub : Unbounded_String_List;
   begin
      ub.Append( uv );
      buff.order.Append( uk );
      buff.data.Insert( uk, ub );
   end Initialise_Row;
   
   procedure Insert( buff : in out Buffer; key : String; col : Natural; value : String ) is
      uk : constant Unbounded_String := TuS( key );
      uv : constant Unbounded_String := TuS( value );
      ub : Unbounded_String_List := buff.data.Element( uk );
      len : Natural := Natural( ub.Length );
   begin
      if col > 0 then
         if col > len then
            for i in len+1 .. col loop
               ub.Append( TuS( "" ));
            end loop;
         end if;
         ub.Replace_Element( col, uv );
      else
         ub.append( uv );
      end if;
      buff.data.Replace( uk, ub );
   end Insert;
   
   function To_String( 
      buff     : in out Buffer;
      enclose  : String := "";
      delim    : String := "," ) return String is
      s : Unbounded_String;
   begin
      for key of buff.order loop
         declare
            ub : Unbounded_String_List := buff.data.Element( key );
            n  : constant Natural := Natural( ub.Length );
         begin
            for i in 1 .. n loop
               s := s & enclose & ub.Element( i ) & enclose;
               if i < n then
                  s := s & delim;
               else
                  s := s & LINE_BREAK;
               end if;
            end loop;
         end;
      end loop;
      return TS( s );
   end To_String;
   
end Keyed_Buffer;
