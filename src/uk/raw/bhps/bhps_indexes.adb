with Format_Utils;
with Text_Utils;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Characters.Latin_1;
with Ada.Directories;
with Ada.Strings.Unbounded;

package body BHPS_Indexes is


   function Read_Sernum ( file : ada.text_io.FILE_TYPE ) return Sernum_String is
          serstr : Sernum_String := ( others => ' ');
          ch     : character;
   begin
      for p in Sernum_String'Range loop
         Ada.Text_IO.Get ( file, ch );
         if ( ch = ' ') then
            exit;
         end if;
         serstr(p) := ch;
      end loop;
      return serstr;
   end Read_Sernum;
   
   procedure Restore_All_Indexes( directory : String; indexes : out BHPS_Index_Array ) is
   begin
      for wave in Waves_With_Data loop
         BHPS_Index_Package.Restore_Complete_Index( 
            directory & wave & "/index.bin", indexes( wave )); 
      end loop;
   end Restore_All_Indexes;

end BHPS_Indexes;
