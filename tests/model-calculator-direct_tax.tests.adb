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
with Long_Menu;
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
package body Model.Calculator.Direct_Tax.Tests is

   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   use Ada.Text_IO;
   use Ada.Exceptions;
   use Text_Utils;   
   use Ada.Strings.Unbounded;

   procedure Register_Tests ( t : in out Test_Case ) is
   begin
      null;
   end Register_Tests;

   procedure Shut_Down( t : in out Test_Case ) is
   begin
      Null;
   end Shut_Down;

   procedure Set_Up( t : in out Test_Case ) is
   begin
      Null;
   end Set_Up;
   
   ----------
   -- Name --
   ----------
   
   function Name ( t : Test_Case ) return Message_String is
   begin          
      return Format( "Model.Calculator.Direct_Tax.Tests");
   end Name;

   
end Model.Calculator.Direct_Tax.Tests;