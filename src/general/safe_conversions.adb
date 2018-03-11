with Ada.Strings.Unbounded;

package body Safe_Conversions is
  
   function Is_Valid( s : String ) return Boolean is
      a : T;
   begin
      begin
         a := T'Value( s );
      exception
         when Constraint_Error =>
            return False;
      end;
      return True;   
   end Is_Valid;
   
   function Convert( s : String; default : T := T'First ) return T is
      a : constant T := ( if Is_Valid( s ) then T'Value( s ) else default );
   begin
      return a;
   end Convert;
   
   function Valid_Values( delim : String := ", " )  return String is
      use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in T'Range loop
         s := s & T'Image( i );
         if i < T'Last then
            s := s & delim;
         end if;
      end loop;
      return To_String( s );
   end Valid_Values;
      
end Safe_Conversions;
