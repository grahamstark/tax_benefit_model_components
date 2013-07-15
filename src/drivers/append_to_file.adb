with Ada.Text_IO;use Ada.Text_IO;
with Text_Utils; use Text_Utils;
with Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Command_Line;use Ada.Command_Line;

procedure Append_To_File is
   checkfile_lines : Unbounded_String;
   outputlines : Unbounded_String;
   f : File_Type;
   status : Exit_Status := 0;
begin
   if( Argument_Count /= 2 )then
      Put_Line( "File to Check | File to update if 1st file exists and has > 0 length " );
   elsif( not Ada.Directories.Exists( Argument( 2 )))then
      Put_Line( "target file doesn't exist " );
   else   
      if( Ada.Directories.Exists( Argument( 1 )))then
         checkfile_lines := Read_Whole_File( Argument( 1 ));
      end if;
      if( Length( checkfile_lines ) > 1 )then
         outputlines  := Read_Whole_File( Argument( 2 ));
         outputlines := outputlines & LINE_BREAK & " "; 
         Create( f, Out_File, Argument( 2 ));
         Put_Line( f, TS( outputlines ));
         status := 1;
         Close( f );
      end if;
   end if;
   Set_Exit_Status( status );
end Append_To_File;
