with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;

package body Text_Buffer is

   use Ada.Strings.Unbounded;
   use Data_Lines_Package;
  
   function Load( filename : String ) return Buffer is
      use Ada.Text_IO.Unbounded_IO;
      use Ada.Text_IO;
      use Data_Lines_Package;
      b : Buffer;
      line : Unbounded_String;
      file : File_Type;
   begin
     Open( file, In_File, filename );
     loop
         Get_Line( file, line );
         Append( b.lines, line );
         exit when End_Of_File( file );
      end loop;
      Close( file );
      return b;
   end Load;
   
   function Get_Line( this_buffer : Buffer; line_no : Positive ) return String is
   begin
      return To_String( Element( this_buffer.lines, line_no ));
   end Get_Line;
   
   function Get_Line( this_buffer : Buffer; line_no : Positive ) return Unbounded_String is
   begin
      return Element( this_buffer.lines, line_no );
   end Get_Line;

   function Num_Lines( this_buffer : Buffer ) return Positive is
   begin
      return Positive( Length( this_buffer.lines ));      
   end Num_Lines;
 
end Text_Buffer;
