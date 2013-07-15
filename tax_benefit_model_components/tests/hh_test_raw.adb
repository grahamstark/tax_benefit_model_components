--
--  $Author: graham_s $
--  $Date: 2008-08-17 14:44:05 +0100 (Sun, 17 Aug 2008) $
--  $Revision: 5659 $
--
with AUnit.Test_Cases.Registration; use AUnit.Test_Cases.Registration;
with AUnit.Assertions;              use AUnit.Assertions;
with Base_Model_Types;              use Base_Model_Types;
with Ada.Exceptions;                use Ada.Exceptions;

with raw_frs_conversions_0304;
with raw_frs_conversions_0405;



package body hh_test_raw is


        procedure Set_Up ( T : in out Test_Case ) is
        begin
	null;
        end Set_Up;


        procedure testWriteBinary ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
        begin

                raw_frs_conversions_0304.write_everything_in_binary;
                raw_frs_conversions_0405.write_everything_in_binary;

        end testWriteBinary;




        --------------------
        -- Register_Tests --
        --------------------

        procedure Register_Tests (T : in out Test_Case) is
        begin
                Register_Routine (T, testWriteBinary'Access, "testWriteBinary" );
        end Register_Tests;

        ----------
        -- Name --
        ----------

        function Name ( T : Test_Case ) return String_Access is
        begin
                return new String'("Raw FRS tests.");
        end Name;

end hh_test_raw;
