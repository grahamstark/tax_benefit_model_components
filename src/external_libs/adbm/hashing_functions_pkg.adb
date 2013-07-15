
package body Hashing_Functions_Pkg is

   type Hash_Value is mod Integer'Last;

   function Hash_String (S : in String) return Natural is

      V : Hash_Value := 0;

   begin
      for I in S'range loop
         V := (V + Character'Pos (S(I))) * 4;
      end loop;
      return Natural (V) mod Prime_Num;
   end Hash_String;

end Hashing_Functions_Pkg;
