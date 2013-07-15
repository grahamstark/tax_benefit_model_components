with Ada.Strings.Fixed;
with Ada.Strings;

package body Data_Constants is

   function Format( v : Sernum_Value ) return String is
      use Ada.Strings.Fixed;
      use Ada.Strings;
   begin
      return Trim ( Sernum_Value'Image( v ), Side => Both);
   end Format;
   
end Data_Constants;
