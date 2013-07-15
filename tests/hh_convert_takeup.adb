--
--  $Author: graham_s $
--  $Date: 2008-08-17 14:44:05 +0100 (Sun, 17 Aug 2008) $
--  $Revision: 5659 $
--
with AUnit.Test_Cases.Registration; use AUnit.Test_Cases.Registration;
with AUnit.Assertions;              use AUnit.Assertions;
with Base_Model_Types;              use Base_Model_Types;
with Text_IO;                       use Text_IO;
with raw_frs;                       use raw_frs;
with Ada.Exceptions;                use Ada.Exceptions;

with raw_frs_conversions_0203;
with raw_frs_conversions_0304;
with raw_frs_conversions_0405;

with frs_binary_reads;

with frs_reader_0304;
with frs_reader_0203;
with frs_reader_0405;

with Factor_Table;
with raw_frs_printer;
with model_household; use model_household;
with FRS_To_Model_Mapper;
with la_calculator; use la_calculator;
with la_parameters; use la_parameters;
with model_output;
with Text_Utils; use Text_Utils;
with frs_utils; use frs_utils;

package body hh_convert_takeup is

          procedure Test_Write_Takeup_Estimates_In_Binary_0304( T : in out AUnit.Test_Cases.Test_Case'Class )  is
                  infile : string_io.FILE_TYPE;
                  outfile : frs_binary_reads.Takeup_Estimates_io.FILE_TYPE;
                  Takeup_Estimates   : Takeup_Estimates_Rec;
          begin
                  string_io.open ( infile, string_io.in_file, "/home/graham_s/tmp/EMPL_P_REVISED_0304.csv" );
                  Text_IO.put ( "opened Takeup_Estimates file "  );
                  Text_IO.New_Line;
                  frs_binary_reads.Takeup_Estimates_io.create( outfile,
                                    frs_binary_reads.Takeup_Estimates_io.out_file, "/home/graham_s/tmp/EMPL_P_REVISED_0304.bin" );
                  Text_IO.put ( "outfile created " );
                  Text_IO.New_Line;

                  while not(string_io.End_Of_File ( infile ) )loop
                          Takeup_Estimates := frs_reader_0304.loadTakeup_Estimates( infile );
                          Text_IO.put ( "Takeup_Estimates.sernum " & String (Takeup_Estimates.SERNUM)  );
                          Text_IO.New_Line;
                          frs_binary_reads.bin_Write_Takeup_Estimates( outfile, Takeup_Estimates );
                  end loop;
                  string_io.close ( infile );
                  frs_binary_reads.Takeup_Estimates_io.close( outfile );

          end Test_Write_Takeup_Estimates_In_Binary_0304;

          procedure Test_Write_Takeup_Estimates_In_Binary_0405( T : in out AUnit.Test_Cases.Test_Case'Class )  is
                  infile : string_io.FILE_TYPE;
                  outfile : frs_binary_reads.Takeup_Estimates_io.FILE_TYPE;
                  Takeup_Estimates   : Takeup_Estimates_Rec;
          begin
                  string_io.open ( infile, string_io.in_file, "/home/graham_s/tmp/EMPL_P_REVISED_0405.csv" );
                  Text_IO.put ( "opened Takeup_Estimates file "  );
                  Text_IO.New_Line;
                  frs_binary_reads.Takeup_Estimates_io.create( outfile,
                                    frs_binary_reads.Takeup_Estimates_io.out_file, "/home/graham_s/tmp/EMPL_P_REVISED_0405.bin" );
                  Text_IO.put ( "outfile created " );
                  Text_IO.New_Line;

                  while not(string_io.End_Of_File ( infile ) )loop
                          Takeup_Estimates := frs_reader_0405.loadTakeup_Estimates( infile );
                          Text_IO.put ( "Takeup_Estimates.sernum " & String (Takeup_Estimates.SERNUM)  );
                          Text_IO.New_Line;
                          frs_binary_reads.bin_Write_Takeup_Estimates( outfile, Takeup_Estimates );
                  end loop;
                  string_io.close ( infile );
                  frs_binary_reads.Takeup_Estimates_io.close( outfile );

          end Test_Write_Takeup_Estimates_In_Binary_0405;


        --------------------
        -- Register_Tests --
        --------------------
        
        procedure Set_Up ( T : in out Test_Case ) is
                x : integer;
        begin
                x := 0;
        end Set_Up;


        procedure Register_Tests (T : in out Test_Case) is
        begin
                Register_Routine (T, Test_Write_Takeup_Estimates_In_Binary_0304'Access, "Test_Write_Takeup_Estimates_In_Binary_0304" );
                Register_Routine (T, Test_Write_Takeup_Estimates_In_Binary_0405'Access, "Test_Write_Takeup_Estimates_In_Binary_0405" );
        end Register_Tests;

        ----------
        -- Name --
        ----------

        function Name ( T : Test_Case ) return String_Access is
        begin
                return new String'("Raw FRS tests.");
        end Name;

end hh_convert_takeup;
