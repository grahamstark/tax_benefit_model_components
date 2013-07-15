--
--  $Revision: 12164 $
--  $Date: 2011-07-01 21:23:17 +0100 (Fri, 01 Jul 2011) $
--  $Author: graham_s $
--
pragma License( Modified_GPL );

with Ada.Containers.Ordered_Sets;
with Ada.Text_IO;
with Ada.Calendar;
with Ada.Calendar.Formatting;

with Ada.Strings.Unbounded;
with Time_Format;

package body Logger is

   use Ada.Text_IO;
   use Ada.Strings.Unbounded;
   
   type Target_Array is array( Target_Type ) of Boolean;
   
   targets : Target_Array := ( others => False );

   out_file  : File_Type; 
   blank_name : constant Unbounded_String := To_Unbounded_String("");
   file_name : Unbounded_String := BLANK_NAME;
   
   function Message_Header( which : Target_Type ) return String is
   begin
      return Target_Type'Image( which ) & ": " & Ada.Calendar.Formatting.Image( Ada.Calendar.Clock ); 
   end Message_Header;
   
   procedure Log( which : Target_Type; s : String ) is
   begin
      if( targets( which )) then
         declare
            out_str : constant String := Message_Header( which ) & " : " & s;
         begin
            if( file_name = BLANK_NAME ) then
               Put_Line( Standard_Output, out_str );
            else
               Put_Line( out_file, out_str );
               Flush( out_file );
            end if;
         end;
      end if;
   end Log;

   procedure Add_Target( which : Target_Type ) is
   begin
      targets( which ) := True;
   end Add_Target;
   
   procedure Add_All_Targets is
   begin
      for r in Target_Type'Range loop
         Add_Target( r );
      end loop;
   end Add_All_Targets;
   
   procedure Remove_Target( which : Target_Type ) is
   begin
      targets( which ) := False;
   end Remove_Target;
   
   procedure Clear_All_Targets is
   begin
      for r in Target_Type loop
         targets( r ) := False;
      end loop;
   end Clear_All_Targets;
   
   procedure Set_Output( name : String ) is
   begin
      if( name /= "" ) and ( To_Unbounded_String( name ) /= file_name ) then
         file_name := To_Unbounded_String( name );
         Create( out_file, Append_File, name );
      end if;
   end Set_Output;
   
   procedure Flush is
   begin
      Reset( out_file, Append_File );
   end Flush;
   
end Logger;
