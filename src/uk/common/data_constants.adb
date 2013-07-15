with Ada.Strings.Fixed;
with Ada.Strings;

package body Data_Constants is

   function Format( v : Sernum_Value ) return String is
      use Ada.Strings.Fixed;
      use Ada.Strings;
   begin
      return Trim ( Sernum_Value'Image( v ), Side => Both);
   end Format;
   
   function Year_From_Data_String( data_string : String ) return Data_Years is
   begin
      for y in Data_Years loop
         if( data_string = Data_Year_Strings( y ))then
            return y;
         end if;
      end loop;
   end Year_From_Data_String;
   
   
end Data_Constants;
