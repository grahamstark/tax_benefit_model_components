pragma License( Modified_GPL );

package body Keyed_Buffer is

   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   procedure Insert( buff : in out Buffer; key : String; value : String ) is
      uk : constant Unbounded_String := TuS( key );
      uv : constant Unbounded_String := TuS( value );
      ub : Unbounded_String_List;
   begin
      ub.Append( uv );
      buff.order.Append( uk );
      buff.data.Insert( uk, ub );
   end Insert;
   
   procedure Append( buff : in out Buffer; key : String; value : String ) is
      uk : constant Unbounded_String := TuS( key );
      uv : constant Unbounded_String := TuS( value );
      ub : Unbounded_String_List := buff.data.Element( uk );
   begin
      ub.Append( uv );
      buff.data.Replace( uk, ub );
   end Append;
   
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
               end if;
            end loop;
         end;
      end loop;
      return TS( s );
   end To_String;
   
end Keyed_Buffer;
