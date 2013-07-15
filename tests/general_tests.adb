--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

--
--  $Author: graham_s $
--  $Date: 2013-03-03 17:14:52 +0000 (Sun, 03 Mar 2013) $
--  $Revision: 15892 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;   

with Ada.Exceptions;           
with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded;
with Ada.Calendar;
with Ada.Containers.Ordered_Maps;
with Ada.Directories; 
with Ada.Direct_IO;
with Ada.Streams.Stream_IO;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;

with Ada.Numerics.Generic_Real_Arrays;

with GNAT.String_Split;

with Ada.Containers.Vectors;
with Ada.Exceptions;
with Base_Model_Types; 
with Colours;
with Costs_Tabulator;
with Financial_Functions;
with Format_Utils;
with Google_Chart_Constants;
with HTML_Utils;
with Indirect_Tax_Utils;
with Inequality_Generator;
with Key_Value_IO;
with Keyed_Text_Buffer;
with Legal_Aid_Output_Types;
with Line_Extractor;
with Monitor;
with Optimiser;
with Standard_Colours;
with T_Utils.Web_IO;
with T_Utils;
with Tabulator;
with Tabulator_Commons;
with Tax_Utils;
with Text_Utils;
with Time_Format;
with Translate_Utils;
with Utils;

with Test_Monitor;

with Zip;
with Zip_Streams;
with Zip.Compress;
with Zip.Create;

--  with User_IO;
package body General_Tests is

   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   use Ada.Text_IO;
   use Ada.Exceptions;
   use Base_Model_Types;
   use Text_Utils;   
   use Ada.Strings.Unbounded;
   
   package lio renames Ada.Text_IO.Unbounded_IO;
   package ubstr renames Ada.Strings.Unbounded;
   package UK_Format_Utils is new Format_Utils( Float_Type => Amount,  Counter_Type=>Counter_Type );
   package UK_HTML_Utils is new HTML_Utils( Rate => Rate, Counter_Type=>Counter_Type );
   
   package Real_Arrays_Package is new Ada.Numerics.Generic_Real_Arrays( Real => Amount );
   
   DATA_DIR : constant String := "";
   
   procedure Test_Monitor_1( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Test_Monitor;
      
      procedure P1( m : in out Test_Monitor.M1.Monitor_Type'Class ) is
      begin
         m.Observe;
      end P1;
      
      m0 : Test_Monitor.M1.Monitor_Type;
      m1 : Test_Monitor.Mon1;
      
   begin
      P1( m0 );
      P1( m1 );
   end Test_Monitor_1;
    
   procedure Test_Zip( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      ZipFile_Stream_Aliased  : aliased Zip_Streams.ZipFile_Stream;
      zip_stream              : constant Zip_Streams.Zipstream_Class := ZipFile_Stream_Aliased'Unchecked_Access;
      -- zip_stream : aliased Zip_Streams.ZipFile_Stream;
      zip_info                : Zip.Create.Zip_Create_Info;
      ZipFile_Stream_Aliased_Input  : aliased Zip_Streams.ZipFile_Stream;
      stream_file             : constant Zip_Streams.Zipstream_Class := ZipFile_Stream_Aliased_Input'Unchecked_Access;
   begin
      Utils.Zip_Directory( "/home/graham_s/tmp", "tmpdir.zip" );
   end Test_Zip;
   
   --------------------
   -- Register_Tests --
   --------------------
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      null;
   end Register_Tests;

   procedure Shut_Down(T : in out Test_Case) is
   begin
      Null;
   end Shut_Down;

   procedure Set_Up(T : in out Test_Case) is
   begin
      Null;
   end Set_Up;
   
   ----------
   -- Name --
   ----------
   
   function Name ( T : Test_Case ) return Message_String is
   begin
          return Format( "General Tests.");
   end Name;

end General_Tests;
