with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Directories;
with Ada.Strings.Unbounded;
with Text_Utils;
with GNATColl.Traces;

package body Data_Index is
   
   use Ada.Text_IO;
   package Index_io is new Ada.Direct_IO( Data_Index_Rec );
 
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "DATA_INDEX" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
   
   function Compare_UID_Lt( left, right: Unique_ID_Type ) return Boolean is
    begin
      return left < right;
   end Compare_UID_Lt;

   function Compare_Data_Index_Record_Equal( left, right: Data_Index_Rec ) return Boolean is
   begin
      if( left.SERNUM /= right.SERNUM )then
         return false;
      end if;
      for i in Record_Components loop
         if( left.pointers(i).start_pos /= left.pointers(i).start_pos ) then
            return False;
         end if;
         if( left.pointers(i).counter /= left.pointers(i).counter ) then
            return False;
         end if;         
      end loop;
      return True;
   end Compare_Data_Index_Record_Equal;

   function Get_Index( imap : Data_Index_Map; sernum : Unique_ID_Type ) return Data_Index_Rec is
      use Data_Index_Map_Package;
      index :  Data_Index_Rec;
   begin
      if( Contains( imap, sernum ) ) then
         return Element( imap, sernum );
      else      
         return index;
      end if;
   end Get_Index;
   
   procedure Put_Index( imap : in out Data_Index_Map; index : Data_Index_Rec ) is
      use Data_Index_Map_Package;
   begin
      if( Contains( imap, index.SERNUM ) ) then
         Replace( imap, index.SERNUM, index );
      else      
         Insert( imap, index.SERNUM, index );
      end if;
   end Put_Index;
   
   procedure Store_Complete_Index( filename : String; imap : Data_Index_Map ) is
      use Data_Index_Map_Package;
      outfile : Index_io.File_Type;
      
      procedure Write_One( pos : Cursor ) is
         index : Data_Index_Rec := Element( pos );
      begin
         Index_io.Write( outfile, index );
      end Write_One;
      
   begin
      Index_io.Create( outfile, Index_io.Out_File, filename );
      Iterate( imap, Write_One'Access );
      Index_io.Close( outfile );
   end Store_Complete_Index;
   
   procedure Restore_Complete_Index( filename : String; imap : out Data_Index_Map ) is
      use Ada.Directories;
      use Ada.Text_IO;
      infile : Index_io.File_Type;
      index  : Data_Index_Rec;
   begin
      if( Exists( filename ) ) then
         Index_io.Open( infile, Index_io.In_File, filename  );
         Data_Index_Map_Package.Clear( imap );
         loop 
            Index_io.Read( infile, index );
            Put_Index( imap, index );
            exit when( Index_io.End_Of_File ( infile ) );
         end loop;      
         Index_io.close( infile );
      end if;
   end Restore_Complete_Index;
   
   function To_String( index : Data_Index_Rec ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & "sernum: " & Unique_ID_Type'Image(index.SERNUM) & LINE_BREAK;
      for r in Record_Components loop
         s := s & Record_Components'Image(r) & 
             " : startPos " & Natural'Image( index.pointers( r ).start_pos ) &
             " : counter " & Natural'Image( index.pointers( r ).counter ) & LINE_BREAK;
      end loop;
      s := s & LINE_BREAK & "--------------------" & LINE_BREAK;
      return To_String( s );
   end To_String;
   
   procedure Dump_Index( Index_Name : String; dump_file_name : String ) is
      use Data_Index_Map_Package;
      use Ada.Directories;
      use Ada.Text_IO;
      infile : Index_io.File_Type;
      outfile : File_Type;
      index  : Data_Index_Rec;
   begin
      Create( outfile, Out_File, dump_file_name );
      if( Exists( index_name ) ) then
         Index_io.Open( infile, Index_io.In_File, index_name );
         loop
            Index_io.Read( infile, index );
            Put_Line( outfile, To_String( index ) );
            exit when( Index_io.End_Of_File ( infile ) );
         end loop;      
         Index_io.close( infile );
      end if;
      Close( outfile );
   end Dump_Index;

end Data_Index;
