with Format_Utils;
with Text_Utils;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Characters.Latin_1;
with Ada.Directories;
with Ada.Strings.Unbounded;

package body Conversions.FRS is

   function To_String( index : Index_Rec ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & "sernum: " & Sernum_Value'Image(index.SERNUM) & LINE_BREAK;
      for r in RecordComponents loop
         s := s & RecordComponents'Image(r) & 
             " : startPos " & Natural'Image( index.pointers( r ).startPos ) &
             " : counter " & Natural'Image( index.pointers( r ).counter ) & LINE_BREAK;
      end loop;
      s := s & LINE_BREAK & "--------------------" & LINE_BREAK;
      return To_String( s );
   end To_String;

   function Read_Sernum ( file : ada.text_io.FILE_TYPE ) return Sernum_String is
          serstr : Sernum_String := ( others => ' ');
          ch     : character;
   begin
      for p in Sernum_String'Range loop
         ada.text_io.get ( file, ch );
         if ( ch = ' ') then
            exit;
         end if;
         serstr(p) := ch;
      end loop;
      return serstr;
   end Read_Sernum;
   
   function Compare_Sernums_Lt( left, right: Sernum_Value ) return Boolean is
    begin
      return left < right;
   end Compare_Sernums_Lt;

   function Compare_Values_Equal( left, right: Index_Rec ) return Boolean is
   begin
      if( left.SERNUM /= right.SERNUM )then
         return false;
      end if;
      for i in RecordComponents loop
         if( left.pointers(i).startPos /= left.pointers(i).startPos ) then
            return False;
         end if;
         if( left.pointers(i).counter /= left.pointers(i).counter ) then
            return False;
         end if;         
      end loop;
      return True;
   end Compare_Values_Equal;


   
   function Get_Index( index_map : FRS_Index; sernum : Sernum_Value ) return Index_Rec is
      use FRS_Index_Package;
      index :  Index_Rec;
   begin
      if( Contains( index_map, sernum ) ) then
         return Element( index_map, sernum );
      else      
         return index;
      end if;
   end Get_Index;
   
   procedure Put_Index( index_map : in out FRS_Index; index : Index_Rec ) is
      use FRS_Index_Package;
  begin
      if( Contains( index_map, index.SERNUM ) ) then
         Replace( index_map, index.SERNUM, index );
      else      
         Insert( index_map, index.SERNUM, index );
      end if;
   end Put_Index;
   
   procedure Store_Complete_Index( filename : String; index_map : FRS_Index ) is
      use FRS_Index_Package;
      outfile : Index_io.File_Type;
      
      procedure Write_One( pos : Cursor ) is
         index : Index_Rec := Element( pos );
      begin
         Index_io.Write( outfile, index );
      end Write_One;
      
   begin
      Index_io.Create( outfile, Index_io.Out_File, filename );
      Iterate( index_map, Write_One'Access );
      Index_io.Close( outfile );
   end Store_Complete_Index;
   
   procedure Restore_Complete_Index( filename : String; index_map : out FRS_Index ) is
      use Ada.Directories;
      use Ada.Text_IO;
      infile : Index_io.File_Type;
      index  : Index_Rec;
   begin
      if( Exists( filename ) ) then
         Index_io.Open( infile, Index_io.In_File, filename  );
         FRS_Index_Package.Clear( index_map );
         loop 
            Index_io.Read( infile, index );
            Put_Index( index_map, index );
            exit when( Index_io.End_Of_File ( infile ) );
         end loop;      
         Index_io.close( infile );
      end if;
   end Restore_Complete_Index;
   
   procedure Dump_Index( Index_Name : String; name : String ) is
      use FRS_Index_Package;
      use Ada.Directories;
      use Ada.Text_IO;
      infile : Index_io.File_Type;
      index  : Index_Rec;
   begin
      if( Exists( index_name ) ) then
         Index_io.Open( infile, Index_io.In_File, index_name );
         loop
            Index_io.Read( infile, index );
            Put_Line( "Test_Dump_Index::" & name & "::" & To_String( index ) );
            exit when( Index_io.End_Of_File ( infile ) );
         end loop;      
         Index_io.close( infile );
      end if;
   end Dump_Index;


end Conversions.FRS;
