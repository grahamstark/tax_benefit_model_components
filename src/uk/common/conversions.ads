with Ada.Calendar;
with Ada.Containers.Ordered_Maps;
with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Ada.Text_io;

with GNAT.String_Split;

with Base_Model_Types;
with Data_Constants;


package Conversions is

   use Data_Constants;
   use GNAT.String_Split;
   use Base_Model_Types;
   use Ada.Strings.Unbounded;


   type Null_Or_Missing_Indicators is array ( Natural range <> ) of Integer;
   type R_Null_Or_Missing_Indicators is array ( Natural range <> ) of Rate;

   function Get( slices : Slice_Set; which : Natural ) return String;

   generic
       type Serial_Num is (<>);
   function Convert_Index( slices : Slice_Set; which : Natural ) return Serial_Num;


    --
   -- converts a string in practically any format to a real number
   -- using code from John P Woodruff's Numerical_IO package
   -- jpwoodruff@irisinternet.net
   --
   function Convert( slices : Slice_Set; which : Natural ) return Rate;

   function Convert( slices : Slice_Set; which : Natural ) return Integer;

   function Convert( slices : Slice_Set; which : Natural; missing : R_Null_Or_Missing_Indicators  ) return Rate;

   function Convert( slices : Slice_Set; which : Natural; missing : Null_Or_Missing_Indicators ) return Integer;

   function Convert( slices : Slice_Set; which : Natural ) return Sernum_Value;

   --
   -- String of the form "5/13/2003" ONLY
   --
   function Convert( s : String ) return Ada.Calendar.Time;
   --
   -- converts a date in exactly the format mm/dd/yy to an Ada Time record
   --
   function Convert( slices : Slice_Set; which : Natural ) return Ada.Calendar.Time;

   function TDA_Tokenize( s : String ) return Slice_Set;
   function TDA_Tokenize( s : Unbounded_String ) return Slice_Set;
   function Tokenize( s : String; delims : String ) return Slice_Set;
   function Tokenize( s : Unbounded_String; delims : String ) return Slice_Set;

   procedure Set_Assigned_Missing_Values( missr : Rate; missi : Integer );

end Conversions;
