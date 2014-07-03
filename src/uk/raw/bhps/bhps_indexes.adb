with Format_Utils;
with Text_Utils;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Characters.Latin_1;
with Ada.Directories;
with Ada.Strings.Unbounded;

package body BHPS_Indexes is

   DEBUG : constant Boolean := True;

   function Read_Sernum ( file : Ada.Text_IO.File_Type ) return Sernum_String is
      serstr : Sernum_String := ( others => ' ');
      ch     : character;
   begin
      for p in Sernum_String'Range loop
         Ada.Text_IO.Get( file, ch );
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
         declare
            index_name : constant String := directory & wave & "/index.bin";
         begin
            BHPS_Index_Package.Restore_Complete_Index( 
               index_name, indexes( wave )); 
            if( debug )then
               BHPS_Index_Package.Dump_Index( 
                  index_name, "/tmp/index_dump_wave_" & wave & ".txt" );
            end if;
         end;
      end loop;
   end Restore_All_Indexes;

end BHPS_Indexes;
