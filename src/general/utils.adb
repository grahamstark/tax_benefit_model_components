------------------------------------------------------------------------------
--                                                                          --
--  Some general utility functions which don't fit elsewhere                --
--                                                                          --
-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
--                                                                          --
--
--  $Revision: 6121 $
--  $Date: 2008-11-01 17:43:03 +0000 (Sat, 01 Nov 2008) $
--  $Author: graham_s $
--
--
--  $Revision: 6121 $
--  $Date: 2008-11-01 17:43:03 +0000 (Sat, 01 Nov 2008) $
--  $Author: graham_s $
--
pragma License( Modified_GPL );

with Ada.Calendar;
with Ada.Calendar.Formatting;

with Ada.Directories;
with Ada.Exceptions;
with Ada.IO_Exceptions;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;
with Ada.Streams.Stream_IO;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Strings.Unbounded;

with Ada.Text_IO;

with GNATColl.Traces;

with Text_Utils;

with Zip.Compress;
with Zip.Create;
with Zip;
with Zip_Streams;

package body Utils is
   
  log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UTILS" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;


   
   function Get_Stack_Trace( message : String := "" ) return String is
      use Ada.Exceptions;
      Local_Exception : Exception;
   begin
      begin
         Raise_Exception( Local_Exception'Identity, message );
      exception
         when ex : Local_Exception =>
            return Exception_Information( ex );
         when ex : others =>
            return Exception_Information( ex );
      end;
      return "";
   end Get_Stack_Trace;

   function Now_As_String return String is
   begin
      return Text_Utils.Censor_String( Ada.Calendar.Formatting.Image( Ada.Calendar.Clock ));
   end Now_As_String;
     
   package Random_Positive is new Ada.Numerics.Discrete_Random( Positive );
   Generator : Random_Positive.Generator;

   function Random_String return String is
      use Ada.Strings;
      use Ada.Strings.Fixed;
      i : Positive := Random_Positive.Random( Generator );
   begin
      return Trim( Positive'Image( i ), Both );
   end Random_String;
   
   --
   -- See (e.g.) http://coding.derkeiler.com/Archive/Ada/comp.lang.ada/2005-05/msg00281.html
   -- http://gcc.gnu.org/onlinedocs/gcc-3.3.6/gnat_rm/Storage_005fSize-Clauses.html
   --
   function Default_Stack_Size return Positive is -- Size_Type is
   --
   --
   begin
      return 102400 * 10240;
   end Default_Stack_Size;
   
   procedure Make_Directory_Path( path : String ) is
      use Ada.Text_IO;
      use Ada.Exceptions;
   begin
      begin   
         Ada.Directories.Create_Path( path );
      exception 
            when Error: Use_Error => Put_Line( "Make_Directory_Path: making " & path & " Exception Thrown " & Exception_Information(Error) );
            when Error: Others => Raise_Exception( Dir_Exception'Identity, "Make_Directory_Path for " & path & " caused " & Exception_Information(Error) ); 
      end;
   end Make_Directory_Path;

   procedure Zip_Directory(
      dir_name : String;
      zip_file_name : String ) is
      
   use Ada.Calendar;
   use Ada.Directories;
   use Ada.Text_IO;
   use Ada.Exceptions;
   
      ZipFile_Stream_Aliased  : aliased Zip_Streams.ZipFile_Stream;
      zip_stream              : constant Zip_Streams.Zipstream_Class := ZipFile_Stream_Aliased'Unchecked_Access;
      zip_info                : Zip.Create.Zip_Create_Info;
      home_length             : Natural;
      full_zip_name           : constant String := Full_Name( zip_file_name );
   
      -- 
      -- borrowed from Rosetta Code: http://www.rosettacode.org/wiki/Walk_Directory_Tree#Ada
      --
      procedure Walk( dir_name : String; file_pattern : String ) is
         
         procedure Add_To_Zip_File( directory_entry : Directory_Entry_Type ) is
            ZipFile_Stream_Aliased_Input  : aliased Zip_Streams.ZipFile_Stream;
            stream_file     : constant Zip_Streams.Zipstream_Class := ZipFile_Stream_Aliased_Input'Unchecked_Access;
            file            : File_Type;
            fullname        : constant String := Full_Name( directory_entry );
            save_name       : constant String := fullname( home_length .. fullname'Last ); 
         begin
            if( Kind( directory_entry ) = Ordinary_File ) and then ( full_zip_name /= fullname )then
               
               stream_file.SetName( save_name );
               Zip_Streams.Open( 
                  Zip_Streams.ZipFile_Stream( stream_file.all ), 
                  Ada.Streams.Stream_Io.In_File );
               Zip_Streams.Set_Index( stream_file, 1 );
               Zip.Create.Add_Stream( zip_info, stream_file );
               Zip_Streams.Close( Zip_Streams.ZipFile_Stream( stream_file.all ) );
            end if;
         exception
            when Error: others => 
               Put_Line( "failed to zip |" & 
                  Full_Name( directory_entry ) & "| as |" & save_name & "|; exception is: " 
                  & Exception_Information(Error));
         end Add_To_Zip_File;
         
         procedure Walk( directory_entry : Directory_Entry_Type ) is
         begin
            if Simple_Name( directory_entry ) /= "." and 
               then Simple_Name( directory_entry ) /= ".." then
               Walk( Full_Name( directory_entry ), file_pattern );
            end if;
         exception
            when Ada.IO_Exceptions.Name_Error => null;
         end Walk;
         
      begin
         Search( dir_name, file_pattern, ( Directory => False, others => True ), Add_To_Zip_File'Access );
         Search( dir_name, "", ( Directory => True, others => False ), Walk'Access );
         exception
            when Ada.IO_Exceptions.Name_Error => null; -- don't care if there's no such directory.
      end Walk;
   
      LAST_DIR : constant String := Current_Directory;
      
   begin
   
      home_length := dir_name'Last;
         
      if( dir_name(home_length) = Text_Utils.DIR_SEPARATOR ) then
         home_length := home_length + 1;
      else
         home_length := home_length + 2;
      end if;
      Zip.Create.Create( 
         zip_info, 
         zip_stream, 
         zip_file_name, 
         Zip.Compress.Shrink );
      Zip_Streams.Create( 
          Zip_Streams.ZipFile_Stream( zip_stream.all ), 
          Ada.Streams.Stream_Io.Out_File );
          
      Set_Directory( dir_name );
      Walk( ".", "" );  
      Put_Line( "in directory " & Current_Directory );
      Zip.Create.Finish( zip_info );
      Zip_Streams.Close( Zip_Streams.ZipFile_Stream( zip_stream.all ) );
      Set_Directory( LAST_DIR );
      
   end Zip_Directory;

begin
   Random_Positive.Reset( Generator );
end Utils;
