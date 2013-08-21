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
--  $Date: 2013-03-03 15:04:12 +0000 (Sun, 03 Mar 2013) $
--  $Revision: 15890 $
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
with Data_Constants;
with FRS_Binary_Reads;
with FRS_Binary_Reads;
with FRS_Enums.Templates;
with FRS_Enums;
with FRS_Enums;
with Conversions;
with Conversions.FRS;
with Financial_Functions;
with Format_Utils;
with Google_Chart_Constants;
with HTML_Utils;
with Indirect_Tax_Utils;
with Inequality_Generator;
with Interfaces.C; 
with Key_Value_IO;
with Keyed_Text_Buffer;
with Legal_Aid_Output_Types;
with Line_Extractor;
with Logger;
with Long_Menu;
with Model.Calculations.Complete;
with Model.Calculations.Legal_Aid;
with Model.Calculations.Means_Tested_Benefits;
with Model.Calculations.Non_Means_Tested_Benefits;
with Model.Calculations;
with Model.Equivalence_Scales;
with Model.Household;
with Model.Income_Measures;
with Model.Incomes;
with Model.Output.Complete;
with Model.Output.Legal_Aid;
with Model.Output.Means_Tested_Benefits;
with Model.Output.Non_Means_Tested_Benefits;
with Model.Parameters;
with Model.Parameters.Complete;
with Model.Parameters.Legal_Aid;
with Model.Parameters.Means_Tested_Benefits;
with Model.Parameters.Non_Means_Tested_Benefits;
with Model.Run_Settings;
with Model.Run_Settings;
with Model.Uprate;
with Model;
with Monitor;
with Optimiser;
with Parameter_System.Input_Buffer;
with Parameter_System.Visitor;
with Parameter_System;
with Piecewise_Linear_Generator;
with Raw_FRS;
with Standard_Colours;
with T_Utils.Google_Chart_Generator;
with T_Utils.Web_IO;
with T_Utils;
with Tabulator;
with Tabulator_Commons;
with Tax_Utils;
with Templates_Parser;
with Test_Households;
with Text_Utils;
with Time_Format;
with Translate_Utils;
with Utils;

with Zip;
with Zip_Streams;
with Zip.Compress;
with Zip.Create;

with RW_File;

--  with User_IO;
package body component_tests is

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
   package rs renames Model.Run_Settings;
   
   type Incomes_Type is ( i1, i2 );
   type Expenses_Type is ( e1, e2 );
   
   package MParams is new Model.Parameters( 
      Incomes_Type     => Incomes_Type, 
      Expenses_Type    => Expenses_Type, 
      MAX_NUM_CHILDREN => 10, 
      BASIC_ARRAY_SIZE => 10 );
      
   package pars is new MParams.Complete;
   
   package Real_Arrays_Package is new Ada.Numerics.Generic_Real_Arrays( Real => Amount );
   
   use Model.Household;
   use Test_Households;
   
   DATA_DIR : constant String := "";
   
   test_households : Test_Household_Array;
    
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
   
   procedure Test_Colours( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   use FRS_Enums;
   
   use Colours;
      white : Colour;
      a : constant := 16#aa#;
      package Regions_Google is new Standard_Region_Package.Google_Chart_Generator;
      v : Standard_Region_Package.Amount_Array := ( 0.0, 1000.0, 5000.0, 8000.0, 2000.1, 10.1, -999.9, 1000.0, 12010.0, 2000.0, 3000.0, 400.0, 4000.0 );
      url : Unbounded_String;
      s   : Unbounded_String;
      f   : File_Type;
   begin
      Put_Line( "a = " & Positive'Image( a ));
      white := ( red=>16#ff#, green=>16#ff#, blue=>16#ff# );
      Put_Line( "white = " & To_String( white ));
      Assert( To_String( white ) = "FFFFFF", "white should be FFFFFF was " & To_String( white ));
      Assert( From_String( "AACCFF" ) = ( 16#aa#, 16#cc#, 16#ff# ), 
         " AACCFF should be ( 16#aa, 16#cc, 16#ff ) was " &
         To_String(From_String( "AACCFF" )));
      Assert( From_String( "#aaccff" ) = ( 16#aa#, 16#cc#, 16#ff# ), 
         "#aaccff should be ( 16#aa#, 16#cc#, 16#ff# ) was " &
         To_String(From_String( "#aaccff" )));
      s := s & "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" & LINE_BREAK;
      s := s & "<html xml:lang='en-GB' xmlns='http://www.w3.org/1999/xhtml' lang='en-GB'>" & LINE_BREAK;   
      s := s & "<head><title>Google Chart Tests</title></head><body><table width='100%'><tbody>" & LINE_BREAK;
      for ctype in Google_Chart_Constants.Chart_Type loop
         for is_thumb in Boolean loop
            url := Regions_Google.Make_Univariate_Chart( 
               "Regions of Britain : " & Google_Chart_Constants.Pretty_Print( ctype ), 
               v, Pretty_Print'Access, 
               ctype, 
               is_thumb );
            s := s & "<tr><td align='center'><img src='" & url & "' alt='Some Chart'/></td></tr>" & LINE_BREAK;
         end loop;
      end loop;
      s := s & "</tbody></table></body></html>";
      Create( f, Out_File, "tmp/google.html" );
      
      Put_Line( f, TS( s ));
      Close( f );
   end Test_Colours;
    
   procedure Test_T_Utils_Web_IO( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Incomes;
      s : Incomes_Set;
      package Incomes_Web is new Incomes_Package.Web_IO;
      div : Unbounded_String;
      rand_str : String := Utils.Random_String;
   begin
      div := Incomes_Web.Make_Discrete_Select_Boxes( rand_str, "incomes", s, Pretty_Print'Access );
      put_line(TS( div ));
   end Test_T_Utils_Web_IO;
   
   procedure Test_Date_Convert( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Ada.Calendar;
      use Conversions;
      this_time : Ada.Calendar.Time;
   begin
      this_time := Convert( "5/13/2002" );
      Assert( Year( this_time ) = 2002, " year should be 2002 but was " & Year( this_time )'Img );
      Assert( Month( this_time ) = 5, " month should be 5 but was " & Month( this_time )'Img );
      Assert( Day( this_time ) = 13, " day should be 13 but was " & Day( this_time )'Img );
      Put_Line( "successfully created Time as " & UK_Format_Utils.Format( this_time ));
   end Test_Date_Convert;
   
   procedure Test_Translations( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Templates_Parser;
      type Languages is ( en );
      package Test_Translations is new Translate_Utils( Languages => Languages );
      assoc : Association;
   begin
      Test_Translations.load( "tests/MazeGreen.properties", en );
      assoc := Test_Translations.Lookup( "test1", en );
      Put_line( "Get( assoc ) 1 = " & Get( assoc ));
      Assert( Get( assoc ) = "this is a line", "test1 should be 'this is a line' was |" & Get( assoc ));
      assoc := Test_Translations.Lookup( "test2", en );
      Put_line( "Get( assoc ) 2 = " & Get( assoc ));
      Assert( Get( assoc ) = "this is a #line # still on the line", "test2 should be 'this is a #line # still on the line' was |" & Get( assoc ));
      assoc := Test_Translations.Lookup( "test3", en );
      Put_line( "Get( assoc ) 3 = " & Get( assoc ));
      Assert( Get( assoc ) = "this is a line", "test3 should be 'this is a line' was |" & Get( assoc ));
   end Test_Translations;
   
   procedure Test_KV( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      package KV_Local is new Key_Value_IO( Real_Type=>Amount,  Counter_Type=>Counter_Type );
      use KV_Local;
      use Ada.Exceptions;
      use Line_Extractor;
      kv : Real_Key_Pair;
      f  : Ada.Text_IO.File_Type;
      c  : Amount := 100.0;
      rv : Amount;
   begin
      kv := Extract( "x=120;", "x" );
      Assert( kv.value = 120.0, "x should be 120; was " & kv.value'Img );
      begin
         kv := Extract( "x=120;", "z" );
      exception
         when Except : KV_Exception =>
            Put( "Exception: " );
            Put( Exception_Name (Except) );
            Put_Line( Exception_Message (Except) );
      end;
      Create( f, Out_File, "kv.txt" );
      Write( f, "x", c );
      Close( f );
      Open( f, In_File, "kv.txt" );
      rv := Read( f, "x" );
      Assert( rv = 100.0, "x should be 100; was " & kv.value'Img );
      Close( f );
      Put_Line( Make_Key( "Fred", 100202, "bill" ));
   end Test_KV;
   
   procedure Test_Indexes( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Ada.Strings.Fixed;
      INDENT : constant String := 10 * ' ';
      n : Positive;
   begin
      n := 3;
      Put_Line( n * INDENT );
   end Test_Indexes;
   
   procedure Test_Dump_Index( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Conversions.FRS;
      use FRS_Index_Package;
      use Ada.Directories;
      infile : Index_IO.File_Type;
      index  : Index_Rec;
   begin
      if( Exists( "/mnt/data/frs/0304/bin/index.bin" ) ) then
         Index_io.Open( infile, Index_io.In_File, "/mnt/data/frs/0304/bin/index.bin" );
         while not( Index_io.End_Of_File ( infile ) ) loop
            Index_io.Read( infile, index );
            Put_Line( "Test_Dump_Index::index " & To_String( index ) );
         end loop;      
         Index_io.close( infile );
      end if;
   end Test_Dump_Index;

   
   procedure Test_Read_File( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use GNAT.String_Split;
      use Conversions;
      use FRS_Binary_Reads;
      use Raw_FRS;
      
      line        : String( 1 .. 20_000 ) := ( others=> ' ' );
      tab_file    : File_Type;
        
      line_number : Natural := 0; -- count 1st line (the header) as 0 and data lines from 1
      line_length : Natural;
   begin
      Open( tab_file, In_File, "/mnt/data/frs/0304/tab/adult.tab" );
      while not( End_Of_File( tab_file ) ) loop
         line := ( others => ' ' );         
         Get_Line( tab_file, line, line_length );
         Put_Line( "line " & line_number'Img & "| " & line( 1 .. line_length ) &"| " );
         line_number := line_number + 1;
      end loop;
      Close( tab_file );
    end Test_Read_File;
 
   procedure Test_Split_String( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use GNAT.String_Split;
      use Ada.Strings.Unbounded;
      use UK_Format_Utils;
      
      s : constant String := "A, B, C, DEF 10002";
      s3 : Unbounded_String;
      slices : Slice_Set;
      ns : Slice_Number;
      f  : Rate;
   begin
      Create( slices, s, " ," & Text_Utils.TAB, Multiple );
      ns := Slice_Count( slices );
      s3 := To_Unbounded_String(Slice( slices , 3 ));
      f := Lenient_Convert( To_String( Slice( slices , 5 )));
      assert( f = 10002.0, " f sound be 10002.0 was " & f'Img );
      assert( s3 = To_Unbounded_String("C"), "should be C, was |" &  s & "| " );
      for i in 1 .. ns loop
         put_line( "s["&i'Img&" ] = |" & Slice( slices , i ) & "| " );
      end loop;
      assert( ns = 4, " ns should be 4 was " & ns'Img );
       
   end Test_Split_String;
   
   procedure Test_Funny_Formats( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   use  UK_Format_Utils;
      r : Rate;
   
   begin
      r := Lenient_Convert( "10.1" );
      assert( r = 10.1 , " r should be 10.1 was " & r'Img );
      put_line( r'Img );
      r := Lenient_Convert( "-10.1" );
      assert( r = -10.1 , " r should be -10.1 was " & r'Img );
      
      r := Lenient_Convert( ".1" );
      assert( r = 0.1 , " r (.1) should be 0.1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( "-.1" );
      assert( r = -0.1 , " r (-.1) should be -0.1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( "1" );
      assert( r = 1.0 , " r (1) should be 1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( "-2" );
      assert( r = -2.0 , " r (-2 should be -2.0 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( " 10.1 " );
      assert( r = 10.1 , " r should be 10.1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( " -10.1 " );
      assert( r = -10.1 , " r should be -10.1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( " .1 " );
      assert( r = 0.1 , " r ( .1 ) should be 0.1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( " -.1 " );
      assert( r = -0.1 , " r ( -.1 ) should be -0.1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( " 1 " );
      assert( r = 1.0 , " r ( 1 ) should be 1 was " & r'Img );
      put_line( r'Img );
      
      r := Lenient_Convert( " -2 " );
      assert( r = -2.0 , " r ( -2 ) should be -2.0 was " & r'Img );
      put_line( r'Img );
      
   end Test_Funny_Formats;
   
   procedure Test_Execute_System( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      function Sys( Arg : Interfaces.C.Char_Array ) return Natural;
      pragma Import( C, Sys, "system" );
      ret_val : Natural;
   begin
      ret_val := Sys( Interfaces.C.To_C( "ls" ) );
      put_line( " ret_val " & Natural'Image(ret_val)); 
      Assert( ret_val = 0, " return value from ls should be 0 was " & Natural'Image(ret_val));
   end Test_Execute_System;

   
   procedure Test_Annualise( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   use Model.Parameters.Means_Tested_Benefits;
      params : pars.Parameters := pars.Get_2007_8_System;
      ann_params : pars.Parameters :=  pars.Get_2007_8_System;
   begin
      pars.To_Annual( ann_params );
      assert( 
         params.means_tested.housing_benefit.allowances( couple_one_aged_60_64)*52.0 = 
         ann_params.means_tested.housing_benefit.allowances( couple_one_aged_60_64 ), 
         " not * 52 "& Amount'Image(ann_params.means_tested.housing_benefit.allowances( couple_one_aged_60_64) ));
   end Test_Annualise;
   
   -- type Control_Index is range 1 .. 10;
   type Control_Record is record
      hhref : integer;
      which_bu : integer;
      which_person : integer;
   end record;
   
   SOME_RUSSIAN : constant String := "Darts позволяет Вам давать название вводимым  параметрам  и сохранять их копии";
   
   type Details_Rec is record
      something : integer;
      something_else : Rate;
   end record;
   
   ROW_SIZE : constant := 5;
   
   subtype Change_Range is Natural range 1 .. ROW_SIZE;
   type Values is ( income_tax, net_income, something );
   type Tenure is ( rented, owned );
   type Values_Array_Type is array( Values ) of Amount;
   
   type Cell_Breakdown is record
      v1 : Amount := 0.0;
      
      v2 : Amount := 0.0;
   end record;
   
   type Aggregate_Cell_Breakdown is record
      v1 : Amount := 0.0;
      v2 : Amount := 0.0;
   end record;
   
   type Example is record
      hhref : integer := 1;
      stuff : integer := 1;
   end record;
   
   package Finance is new Financial_Functions( Rate=>Rate, Amount=>Amount );
      
   
   procedure Types_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      type F is new Long_Float;
      subtype R is F;
      subtype S is F;
      
      v1 : F := 10.0;
      v2 : R := 100.0;
      v3 : S := v1 * v2;
   begin
   
      put( v3'Img );
   
   end Types_Test;
      
   
   
   procedure Test_T( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
      type A_Type is (a, b, c, d, e );
      package t_p is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => A_Type );
      
      use t_p.Set_Ops;
      
      s   : t_p.Set;
      s_2 : t_p.Set;
      s_3 : t_p.Set; 
      s_4 : t_p.Set;
      ar : t_p.Amount_Array := ( a=>100.0, b=>200.0, c=>10.0, others=>0.0 );
      br : t_p.Rate_Array   := ( a=>1.0, b=>0.5, c=>0.1, others=>0.0 );
      br2 : t_p.Rate_Array;
      brs   : String( 1 .. 1000 );
      sum : Amount;
   begin
      Include( s, b );
      Include( s, c );
      put_line( " should be b, c "& t_p.To_String( s ) );
      sum := t_p.Sum( ar, s );
      Assert( sum = 210.0, "Sum should be 210 but was " & sum'Img );
      sum := t_p.Sum( ar, br );
      Assert( sum = 201.0, "Sum should be 201 but was " & sum'Img );
      
      Include( s_2, b );
      Include( s_2, e );
      
      s_3 := s_2 xor s;
      
      put_line( " should be c, e " & t_p.To_String(s_3) ); -- should be c,e
      
      t_p.From_String( t_p.To_String( s_3 ), s_4 );
      
      put_line( "s_4 = " & t_p.To_String( s_4 ));
      put_line( "s_3 = " & t_p.To_String( s_3 ));
      --  assert( Length( s_4 ) = Length( s_3 ) , " counts of sets don;t match " );
      
      --brs := t_p.To_String( br );
      Put_line( t_p.To_String( br, False ));
      t_p.From_String( t_p.To_String( br, False ), br2 );
      put_line( "before checking loop " );
      -- put_line( "brs = " & brs );
      for t in A_Type'Range loop
         put_line( "br(" & t'Img & " ) = " & br2(t)'Img );
         Assert( br2(t) = br(t), "value for " & t'Img & " should match but was " & br2(t)'Img & " vs " & br(t)'Img );
      end loop;
   end Test_T;
   
   
   procedure Test_Logger( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      type Log_Test is ( t1, t2, t3 );
      package t_log is new Logger( Target_Type=> Log_Test );
      use t_log;
   begin
      put_line( "should be no log next" );
      Log( t1, "this should not appear  #1" ); 
      put_line( "should be no log above" );
      Add_Target( t2 );
      Log( t2, "This should be 1st log message " );
      Remove_Target( t2 );
      Log( t2, "this should not appear  #2" );
      Add_Target( t1 );
      Log( t1, "This should be 2nd log message " );
      Set_Output( "my_log_file" );
      Log( t1, "This should be 1st log message in my_log_file" );
      t_log.Flush;
      Log( t1, "This should be 2nd log message in my_log_file" );
   end Test_Logger;
   
   
   procedure test_apr( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   use Finance;
       payments_1 : Payment_Stream; 
       payments_2 : Payment_Stream; 
       apr : Rate;
   begin 
       Add_To_Payment_Stream( payments_1, 1, -1_000.0 );
       for p in 2 .. 12 loop
         Add_To_Payment_Stream( payments_1, p, 100.0 );
       end loop;
       apr := Find_Apr( payments_1 );
       put( "APR = " & Amount(apr*100.0)'Img );
       
       Add_To_Payment_Stream( payments_2, 1, -999.0 );
       for p in 2 .. 29 loop
         Add_To_Payment_Stream( payments_2, p, 101.0 );
       end loop;
       apr := Find_Apr( payments_2 );
       put( "APR = " & Amount(apr*100.0)'Img );
       
       
   end test_apr;
   
   
   function x_2( control : Control_Record; m : Rate ) return Rate is
   begin
      return 100.0 + ( m * m ) - m;
   end x_2;
    
   package Tax1 is new Tax_Utils( Amount_Type => Amount, Rate_Type => Rate );
   
   package Opt1 is new Optimiser(
      MAX_ITERATIONS => 200,
      Tolerance   => 0.000001,
      Increment   => 0.0001,
      Start       => -20.0,
      Stop        => 20.0,
      Real        => Rate,
      Control_Rec => Control_Record,
      Minimand => x_2 );
      
   procedure test_optimiser( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   use Opt1;
     -- 
      -- procedure print( pos : opt1.Output_List.Cursor ) is 
         -- p : opt1.Iteration_Output;
      -- begin
         -- p := opt1.Output_List.element( pos );
         -- put( " p.x = " & p.point.x'Img & " p.y = " & p.point.y'Img );
         -- new_line;
      -- end print;
-- 
   
      x : Rate := 0.0;
      y : Rate := 0.0;
      z : Rate;
      -- Model.Output_details : Opt1.Output_List.Vector;
      err : Error_Conditions;
      ctl : Control_Record;
   begin
      z := x_2( ctl, 10.0 );
      put( "z = " & z'Img );
      Opt1.optimise( ctl, x, y, err ); 
      put( "optimise x = " & x'Img & " y = " & y'Img );
      -- Opt1.Output_List.iterate( Model.Output_details, print'Access );
      assert( abs( x - 0.50 ) < 0.0002, " x should be 10 was " & x'Img );
      assert( abs( y - 99.75 ) < 0.0002, " y should be 100 was " & y'Img );
      
   end test_optimiser;
      
   procedure Increment_Cell_Breakdown( 
      current_breakdown : in out Aggregate_Cell_Breakdown; 
      new_breakdown : Cell_Breakdown;
      weight        : Amount ) is
   begin
      current_breakdown.v1 := current_breakdown.v1 + ( new_breakdown.v1 * weight );
      current_breakdown.v2 := current_breakdown.v2 + ( new_breakdown.v2 * weight );
   end Increment_Cell_Breakdown;
   
   type Scale_Array is array( Change_Range ) of Amount;
   
   package Tabulator1 is new Tabulator(
         Data_Type => Amount, 
         Example_Type => Example,
         Row_Range => Tenure,
         Scale_Array => Scale_Array,
         Col_Range => Change_Range,
         Cell_Values_Range  => Values,
         Values_Array       => Values_Array_Type,
         MAX_EXAMPLES       => 1000,
         Cell_Breakdown => Cell_Breakdown,
         Aggregate_Cell_Breakdown => Aggregate_Cell_Breakdown,
         Increment_Cell_Breakdown => Increment_Cell_Breakdown
   );
   
   package Costs_Tabulator_1 is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => tenure,
      Values_Range => values,
      Values_Array => Values_Array_Type
   );
   
   procedure test_costs_tabulator( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      values   : Values_Array_Type := ( 1.0, 2.0, 0.0 );
      values2  : Values_Array_Type := ( 0.0, 2.0, 1.0 );
      pre_tab,
      post_tab,
      diff_tab      : Costs_Tabulator_1.Table_Type;
   begin
      for i in 1 .. 100_000 loop
         Costs_Tabulator_1.Add_Observation( pre_tab, rented, 1.0, values ); 
         Costs_Tabulator_1.Add_Observation( post_tab, rented, 1.0, values2 );
      end loop;
      diff_tab := Costs_Tabulator_1.Difference( pre_tab, post_tab );
      put( "pre " );new_line;
      put( Costs_Tabulator_1.To_String( pre_tab ) );
      new_line;
      put( "post " );new_line;
      put( Costs_Tabulator_1.To_String( post_tab ) );
      new_line;
      put( "difference " );new_line;
      put( Costs_Tabulator_1.To_String( diff_tab ) );
      new_line;
      
   end test_costs_tabulator;
   
   procedure test_tabulator_1( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   use Tabulator_Commons;
   
      example1 : Example;
      scale   : constant Scale_Array := ( 1.0, 2.0, 3.0, 4.0, 5.0 );  
      row     : Tenure := rented;
      v_pre   : Values_Array_Type := ( 1.0, 2.0, 0.0 );
      v_post  : Values_Array_Type := ( 1.0, 2.0, 0.0 );
      weight  : Amount := 1.0;
      cell    : Cell_Breakdown; 
      tab     : Tabulator1.Table_Type;
      col     : Change_Range :=  Tabulator1.Get_Col_Range( 10.0, scale );
      expression : Tabulator1.Table_Expression;
   begin
      for i in 1 .. 100_000 loop
         Tabulator1.Add_Observation( 
            tab, 
            row, 
            col, 
            weight, 
            v_pre, 
            v_post, 
            cell, 
            example1 ); 
      end loop;
      expression := Tabulator1.Express_Table( tab, current_cell, counter, net_income ); 
      put( Tabulator1.to_string( expression, Text_Utils.TAB ) );
   end test_tabulator_1;
   
   function Inspect_One( x, y : Rate; ctl  : Control_Record ) return Details_Rec is
      det  : Details_Rec;
   begin
      return det;   
   end Inspect_One;
   
   function Calculate_One( x   : Rate; ctl : Control_Record ) return Rate is
      y   : Rate;
   begin
      if( x < 2_000.0 ) then
         y := 2000.0;
      elsif( x < 5_000.0 ) then
         y := (x * 0.8) + 1_000.0;
      elsif( x < 20_000.0 ) then
         y := x * 0.6 + 1_500.0;
      elsif( x < 25_000.0 ) then
         y := x * 0.4 + 2_500.0;
      elsif( x < 28_000.0 ) then
         y := x * 0.35 + 2_500.0;
      else
         y :=  12300.0 + ((x-28_000.0) * 0.32) + 2_500.0;
      end if;
      return y;
   end Calculate_One;
   
 
   package pwlc1 is new Piecewise_Linear_Generator( 
      Rate => Rate,
      
      Control_Record => Control_Record,
      Details => Details_Rec,
            
      MAX_DEPTH => 500,
      
      increment => 0.0001,
      tolerance => 0.01,
      
      Calculate_One_Position => Calculate_One,
      Run_Inspector => Inspect_One ); 
      
   procedure test_generator_1( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
      procedure print( pos : pwlc1.Points_Package.Cursor ) is 
         p : pwlc1.point;
      begin
         p := pwlc1.Points_Package.element( pos );
         put( pwlc1.To_String( p )); new_line;
      end print;

      points   : pwlc1.Points_Package.Vector;
      details  : pwlc1.Details_Package.Vector;
      control  : constant Control_Record :=  ( hhref => 20, which_bu => 10, which_person=>1 );
      START    : constant Rate := 0.0;
      STOP     : constant Rate := 45_000.0;

   begin
      pwlc1.generate( points, control, START, STOP );
      pwlc1.Points_Package.iterate( points, print'Access );
   exception 
      when Error : others =>
         assert ( false, "test_generator_1: exception thrown " & Exception_Information(Error) );
   end test_generator_1;
   
   function get_default_rate_bands return Tax1.Rates_And_Bands is
      l  : Tax1.Rates_And_Bands;
      rb : Tax1.Rate_And_Band;
   begin
      rb.rate := 0.10;
      rb.band := 1_000.0;
      Tax1.Set_Rate_And_Band( l, rb, 1 );
      rb.rate := 0.20;
      rb.band := 2_000.0;
      Tax1.Set_Rate_And_Band( l, rb, 2 );
      rb.rate := 0.50;
      rb.band := 999_999.99;
      Tax1.Set_Rate_And_Band( l, rb, 3 );
      return l;
   end get_default_rate_bands;
   
   procedure test_tax_1( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      rbs  : Tax1.Rates_And_Bands := get_default_rate_bands;
      inc  : Amount := 0.0;
      res  : Tax1.Tax_Result;
   begin
      res := Tax1.Calc_Tax_Due( rbs, inc );
      assert( res.due = 0.0, "tax for zero income should be 0 " );
      inc := 1000.0;
      res := Tax1.Calc_Tax_Due( rbs, inc );
      assert( res.due = 100.0, "tax for 100 income should be 100 " );
      inc := 2000.0;
      res := Tax1.Calc_Tax_Due( rbs, inc );
      assert( res.due = 300.0, "tax for 300 income should be 300 " );
      inc := 1_000_000.0;
      res := Tax1.Calc_Tax_Due( rbs, inc );
      assert( res.due = 499_300.0, "tax for 1,000,000 income should be 499,300 was " & res.due'Img );      
   end test_tax_1;
   
   procedure test_tax_uprate( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   use Tax1;
   
      rbs  : Rates_And_Bands := get_default_rate_bands;
      rb         : Tax1.Rate_And_Band;
   begin
      Tax1.Uprate( rbs, 1.02, 100.0 );
      rb :=  Tax1.Get_Rate_And_Band( rbs, 1 );
      assert( rb.band = 1_100.0, "2% increase to next 100 should give 1_100 from 1,000 ; was " & rb.band'Img );
   end test_tax_uprate;
   
   procedure Test_Russian(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      s : ubstr.Unbounded_String;
      len : Natural := ubstr.Length(ubstr.To_Unbounded_String( "позволяет" ));
      
   begin
      put( SOME_RUSSIAN );
      assert( SOME_RUSSIAN = "Darts позволяет Вам давать название вводимым  параметрам  и сохранять их копии", "string constants match" );new_line;new_line;
      lio.Get_Line( s );
      lio.Put_Line( s );
      new_line;
      put( "len 'позволяет' is " & Natural'Image(len) ); 
   end Test_Russian;
   
   
   procedure test_inequality(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      package iqg is new Inequality_Generator( Rate=>Rate, Amount=>Amount );
      quant : iqg.Quantile;
      quant_list : iqg.Quantile_List;
      ineq  : iqg.Inequality_Array;
      bins  :  iqg.Quantile_List;
      n     : Positive;
   begin
      quant := (1, population=>1_145_008.0,income=>2954.35);
      iqg.Quantile_Package.append(quant_list, quant );
      iqg.Quantile_Package.append(quant_list, (2,population=>1274868.0, income=>9680.00 ));
      iqg.Quantile_Package.append(quant_list, (3,population=>1489169.0, income=>18586.47 ));
      iqg.Quantile_Package.append(quant_list, (4,population=>1309984.0, income=>22810.09 ));
      iqg.Quantile_Package.append(quant_list, (5,population=>1227877.0, income=>27624.27 ));
      iqg.Quantile_Package.append(quant_list, (6,population=>1333681.0, income=>36713.67 ));
      iqg.Quantile_Package.append(quant_list, (7,population=>3136635.0, income=>110401.13 ));
      iqg.Quantile_Package.append(quant_list, (8,population=>3619401.0, income=>162869.10 ));
      iqg.Quantile_Package.append(quant_list, (9,population=>3105688.0, income=>170061.28 ));
      iqg.Quantile_Package.append(quant_list, (10,population=>3252768.0, income=>217926.70 ));
      iqg.Quantile_Package.append(quant_list, (11,population=>3383398.0, income=>291369.02 ));
      iqg.Quantile_Package.append(quant_list, (12,population=>3126897.0, income=>420418.97 ));
      iqg.Quantile_Package.append(quant_list, (13,population=>207672.0, income=>68629.44 ));
      iqg.Quantile_Package.append(quant_list, (14,population=>49031.0, income=>32752.28 ));
      iqg.Quantile_Package.append(quant_list, (15,population=>13820.0, income=>18659.36 ));
      iqg.Quantile_Package.append(quant_list, (16,population=>5249.0, income=>15461.40 ));
      iqg.Quantile_Package.append(quant_list, (17,population=>1247.0, income=>8458.45 ));
      iqg.Quantile_Package.append(quant_list, (18,population=>686.0, income=>14801.38 ));
      new_line;put( "Inequality measures" );new_line;
      ineq := iqg.generate( quant_list );
      put( iqg.To_String( ineq ) );
      
      new_line;
      new_line;
      iqg.Quantile_Package.clear( quant_list );
      for i in 1..36 loop
         iqg.Quantile_Package.append(quant_list, (i,population=>1.0, income=>1.0 ));
      end loop;
      iqg.Quantile_Package.append( quant_list, (1,population=>1.0, income=>1.0E+08 ));
      ineq := iqg.generate( quant_list );
      put( iqg.To_String( ineq ) );
      
      iqg.Sort_By_Income( quant_list ); 
      
      bins := iqg.Binify( quant_list, 3 );
      n :=  Positive(iqg.Quantile_Package.Length( bins ));
      for p in 1 .. n loop
          put( Positive'Image(p) & " = " & iqg.To_String( iqg.Quantile_Package.element( bins, p ) ));
          new_line;
      end loop;
   end test_inequality;
   
   procedure test_loans_1( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      loan1 : constant Finance.Loan_Input := ( 
         principal => 10_000.0, 
         interest_rate => Finance.monthly_equivalent_of_annual_interest(10.0), 
         num_payments => 12 );
         
      cost1 : Finance.Loan_Output;
   begin
      cost1 := Finance.Calculate_Loan( loan1 );
      put( Finance.to_string( cost1 ) );new_line;
      assert( cost1.monthly_payment = 879.16, " cost1.monthly_payment should be 879.16 was "& cost1.monthly_payment'Img );
      assert( cost1.total_interest = 549.92, " cost1.total_interest should be 549.92 was " & cost1.total_interest'Img );
      assert( cost1.total_payments = 10_549.92, "cost1.total_payments should be 10_549.92 was " & cost1.total_payments'Img );
   end test_loans_1;
   
   procedure Test_Indirect( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      type Index_Type is new Positive range 1 .. 10;
      package T_10 is new T_Utils( T=>Index_Type, Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type );
      package IT is new Indirect_Tax_Utils( T_10 );
      use T_10;
      use IT;
      selling_price : Abs_Amount_Array := ( 1075.16339869281, 200.0, 1000.0, 200.0, 500.0, 10.0, 1000.0, 1.0, 100.0, 5.30 );
      vat  : Abs_Rate_Array := ( 0.175, 0.175, 0.175, 0.0, 0.0, 0.175, 1.25, 0.175 , 0.175, 0.175 );
      advalorem : Abs_Rate_Array := ( 0.2, 0.0, 0.0, 0.0, 0.4,  0.1, 0.0, 0.0, 0.0, 0.22 );
      specific : Abs_Amount_Array := ( 500.0, 100.0, 0.0, 100.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.17 );
      spending : Abs_Amount_Array := ( 10000.0, 10000.0, 10000.0, 10000.0, 10000.0, 10000.0, 10000.0, 10000.0, 10000.0, 5.30 );
      total_tax_due, vat_due, spec_due, adval_due, factor_costs, new_prices : Abs_Amount_Array( Index_Type'Range );
   begin
      factor_costs := Calc_Factor_Cost( selling_price, vat, advalorem, specific );
      new_prices := Calc_Selling_Price( factor_costs, vat, advalorem, specific );
      total_tax_due := Calc_Total_Indirect_Tax_Due( spending, selling_price, vat, advalorem, specific );
      Calc_Indir_Tax_Components( spending, selling_price, vat, advalorem, specific, vat_due, adval_due, spec_due );
      Put_Line( "factor costs : " & To_String( factor_costs, true ) );
      Put_Line( "new_prices : " & To_String( new_prices, true ) );
      Put_Line( "VAT Due : " & To_String( vat_due, true ) );
      Put_Line( "Adval Due : " & To_String( adval_due, true ) );
      Put_Line( "Specif Due : " & To_String( spec_due, true ) );
      Put_Line( "total_tax_due : " & To_String( total_tax_due, true ) );
      assert( abs(total_tax_due(8) - total_tax_due(9)) < 0.0001, " last 2 should be same since only unit cost differs and only VAT charged" );
      assert( new_prices = selling_price, "Selling Prices Don't Match" );
  end Test_Indirect;
   
   --------------------
   -- Register_Tests --
   --------------------
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine (T, Test_Indirect'Access, "Test Indirect");
      Register_Routine (T, Test_Colours'Access, "Test Colours");
      Register_Routine (T, Test_T'Access, "Test T");
      Register_Routine (T, Test_Translations'Access, "Test Translations" );
      Register_Routine (T, Test_Date_Convert'Access, "Date Convert" );
      Register_Routine (T, Test_KV'Access, "Test KV " );
      Register_Routine (T, Test_T_Utils_Web_IO'Access, "Test_T_Utils_Web_IO" );
      Register_Routine (T, Test_Zip'Access, "Test_Zip" );
      -- Register_Routine (T, Test_Indexes'Access, "Test Indexes" );
      -- Register_Routine (T, Test_Dump_Index'Access, "Test Dump Indexes" );
      -- Register_Routine (T, Test_Read_File'Access, "Test Read File" );
      -- Register_Routine (T, Test_Split_String'Access, "Test Split String" );
      -- Register_Routine (T, Test_Funny_Formats'Access, "Test Funny Formats");
      -- Register_Routine (T, Test_Execute_System'Access, "Test Execute System");
      -- Register_Routine (T, Test_Logger'Access, "Test Logger");
      -- Register_Routine (T, Test_Annualise'Access, "Test Annualise");
      -- Register_Routine (T, test_generator_1'Access, "Test Generator");
      -- Register_Routine (T, test_tabulator_1'Access, "Test Tab");
      -- Register_Routine (T, test_costs_tabulator'Access, "Test Costs Tab");
      -- Register_Routine (T, test_optimiser'Access, "Test Optimiser");
      -- Register_Routine (T, test_tax_1'Access, "Test Tax 1");
      -- Register_Routine (T, test_tax_uprate'Access, "Test Tax Uprate");
      -- Register_Routine (T, test_russian'Access, "Test Russian");
      -- Register_Routine (T, test_inequality'Access, "Test Inequality");
      -- Register_Routine (T, test_loans_1'Access, "Test Loans1");
      -- Register_Routine (T, test_apr'Access, "Test APR");
   end Register_Tests;
   
   procedure Set_Up (T : in out Test_Case) is
   begin
      test_households := makeExampleHouseholds;
   end Set_Up;
   
   procedure Shut_Down(T : in out Test_Case) is
   begin
      Null;
   end Shut_Down;

   
   ----------
   -- Name --
   ----------
   
   function Name ( T : Test_Case ) return Message_String is
   begin
          return Format( "Components Tests.");
   end Name;

end component_tests;
