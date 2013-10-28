--
--  $Author: graham_s $
--  $Date: 2012-08-23 19:40:48 +0100 (Thu, 23 Aug 2012) $
--  $Revision: 15270 $
--
--  basic types for our model;
-- Originally UK-centric, but now moved out since really common to all. If we
-- started using decimals to model currency again we'd probably want a model-specific
-- version of this.
--
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers.Ordered_Maps;

pragma Elaborate_All (Ada.Text_IO);

package Base_Model_Types is

   --  pragma Preelaborate;
   --
   --  standard types we use everywhere
   --

   type Real is new Long_Float;

   type Counter_Type is delta 0.01 digits 18;

   subtype Rate is Real;
   subtype Amount is Real;
   subtype Probability is Real range 0.0 .. 1.0;

   type Big_Integer is range -9223372036854775808 .. 9223372036854775807;

   C100 : constant Counter_Type  := 100.0;

   MISS   : constant       := -12345;
   MISS_R : constant Rate  := -12345.0;
   MISS_M : constant Amount := -12345.0;

   subtype Age_Range           is Natural range 0 .. 150;
   subtype Child_Age           is Age_Range range 0 .. 21;

   subtype Child_Count         is Natural range 0 .. 10;
   subtype Child_Number        is Child_Count range 1 .. Child_Count'Last;

   subtype Adult_Count         is Natural range 0 .. 10;
   subtype Adult_Number        is Adult_Count range 1 .. Adult_Count'Last;

   subtype Person_Count        is Natural range 0 .. (Child_Count'Last + Adult_Count'Last);
   subtype Person_Number       is Person_Count range 1 .. Person_Count'Last;

   subtype Benefit_Unit_Count  is Natural range 0 .. 12; -- Person_Count'Last;
   subtype Benefit_Unit_Number is Benefit_Unit_Count range 1 .. Benefit_Unit_Count'Last;

   subtype Hours_Count         is Natural range 0 .. (7 * 24);

   --
   --  FIXME: It'd be really nice to do a proper version of this using
   --  actual financial assumptions, if ever I could find out about them
   --  Maybe a new module?
   --
   type Periods is ( day, week, month, year );
   DAYS_PER_PERIOD : constant array( Periods ) of Positive := ( 1, 7, 30, 365 );

   function Ratio_Between( old_period : Periods; new_period : Periods ) return Rate;
   function Standard_Ratio_Between( old_period : Periods; new_period : Periods ) return Rate;

   type Record_Indicator is record
      startPos : Natural := 0;
      counter  : Natural := 0;
   end record;

   --
   -- Big number useful for (e.g.) dataset serial numbers, which are often huge.
   --
   type Very_Large_Positive_Type is range 1 .. 1_000_000_000_000;
   package Very_Large_Positive_Text_IO is new Ada.Text_IO.Integer_IO( Very_Large_Positive_Type );

   --
   --  some standard io packages typed for the above
   --
   package Count_IO is new Ada.Text_IO.Decimal_IO( Counter_Type );

   package Real_IO is new Ada.Text_IO.Float_IO( Real );
   function To_String( r : Real; width : Positive := 12; prec : Natural := 2 ) return String;

   package Int_IO is new Ada.Text_IO.Integer_IO( Integer );
   function To_String( i : Integer; width : Positive := 10 ) return String;

   package Big_Int_IO is new Ada.Text_IO.Integer_IO( Big_Integer );
   function To_String( i : Big_Integer; width : Positive := 20 ) return String;

   package Rate_IO renames Real_IO;
   package Amount_IO renames Real_IO;
   package Boolean_IO is new Ada.Text_IO.Enumeration_IO( Enum => Boolean );


   type Rate_Array is array (Positive range <>) of Rate;
   type Amount_Array is array (Positive range <>) of Amount;
   type Integer_Array is array (Positive range <>) of Integer;
   type Big_Integer_Array is array (Positive range <>) of Big_Integer;
   type Boolean_Array is array (Positive range <>) of Boolean;
   type Counter_Type_Array is array (Positive range <>) of Counter_Type;
   type Age_Limit_Array is array( Positive range <> ) of Age_Range;

   package Amount_Package is new Ada.Containers.Vectors( Element_Type => Amount, Index_Type => Positive );
   subtype Amount_List is Amount_Package.Vector;

   package Counter_Type_Package is new Ada.Containers.Vectors( Element_Type => Counter_Type, Index_Type => Positive );
   subtype Counter_Type_List is Counter_Type_Package.Vector;

   package Rate_Package is new Ada.Containers.Vectors( Element_Type => Rate, Index_Type => Positive );
   subtype Rate_List is Rate_Package.Vector;

   package Big_Integer_Package is new Ada.Containers.Vectors( Element_Type => Big_Integer, Index_Type => Positive );
   subtype Big_Integer_List is Big_Integer_Package.Vector;

   function Multiply( r : Rate_Array; m : Rate ) return Rate_Array;
   function "*" ( r : Rate_Array; m : Rate ) return Rate_Array renames Multiply;
   function Multiply( a : Amount_Array; m : Rate ) return Amount_Array;
   function "*" ( r : Amount_Array; m : Rate ) return Amount_Array renames Multiply;

   function To_Percent( r : Amount_Array ) return Amount_Array;
   function Sum( r : Amount_Array ) return Amount;
   -- .... and so on finish this !!!
   --
   -- Functions to add things with missing values
   --
   function Safe_Add( a, b : Real; c, d, e, f, g, h : Real := 0.0 ) return Amount;
   function Safe_Add( a, b : Integer ) return Integer;
   function Safe_Mult( a, b : Real ) return Real;

   --
   -- these return 0 if r is missing as identified by the missing values above
   --
   function Safe_Assign( r : Real) return Real;
   function Safe_Int_To_Real( r : Integer ) return Real;
   function Safe_Real_To_Int( r : Real ) return Integer;
   function Zero_Or_Missing ( r : Real ) return Boolean;

   function Differs_By( a, b : Real; tol : Real := 0.0001 ) return Boolean;
   -- renames
   function Nearly_Equal( a, b : Real; tol : Real := 0.0001 ) return Boolean;

   function Annual_To_Weekly( m : Amount ) return Amount;
   function Weekly_To_Annual( m : Amount ) return Amount;


   package Auxiliary_Results_Package is new Ada.Containers.Ordered_Maps(
      Key_Type => Ada.Strings.Unbounded.Unbounded_String,
      Element_Type => Amount,
      "=" => "=",
      "<" => Ada.Strings.Unbounded."<" );
   subtype Auxiliary_Results is Auxiliary_Results_Package.Map;

   procedure Add_To_Map( map : in out Auxiliary_Results; key : String; value : Amount );
   function To_String( intermediate : Auxiliary_Results; indent : String ) return String;

end Base_Model_Types;
