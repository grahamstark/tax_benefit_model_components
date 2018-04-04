with AUnit.Assertions;
with Ada.Text_IO;
with Ada.Calendar;

package body Maths_Functions_Poverty_Inequality_Tests is
   
   use AUnit.Assertions;
   use Ada.Calendar;
   use Ada.Text_IO;

   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
  --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      null;
      -- Register_Routine (T, Test_Calculate_National_Insurance'Access, "Test_Calculate_National_Insurance");
      -- Register_Routine (T, Test_Calculate_Income_Tax'Access, "Test_Income_Tax");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end  Maths_Functions_Poverty_Inequality_Tests;