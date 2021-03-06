--
--  $Author: graham_s $
--  $Date: 2011-04-21 14:19:45 +0100 (Thu, 21 Apr 2011) $
--  $Revision: 11490 $
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
--
-- Got to think of a decent name for this. Gives you a little package which,
-- for some discrete type T gives you a set of T, a Real and
-- Amount array of T and some simple sum and print operations.
-- Amazing how often this pattern turns up. The arrays are available in both
-- unconstrained and
--
pragma License( Modified_GPL );

with Ada.Containers.Ordered_Sets;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Format_Utils;
with GNATColl.Tribooleans;

generic

   type T is (<>); -- Any discrete type: integer, modular, or enumeration.

   --
   -- A floating point type for rates.
   --
   type Rate_Type is digits<>;

   --
   --
   --
   type Amount_Type is digits<>;
   --
   --
   --
   type Counter_Type is delta<> digits<>;

package T_Utils is

   use Ada.Strings.Unbounded;
   use GNATColl.Tribooleans;
   
   package Set_Ops is new Ada.Containers.Ordered_Sets( Element_Type => T );
   subtype Set is Set_Ops.Set;
   
   package RFormat is new Format_Utils( Rate_Type, Counter_Type );
   package AFormat is new Format_Utils( Amount_Type, Counter_Type );

   package List_Ops is new Ada.Containers.Vectors( Index_Type=>Positive, Element_Type => T );
   subtype List is List_Ops.Vector;

   EMPTY_SET : Set renames Set_Ops.Empty_Set; -- constant

   type Abs_Rate_Array is array( t range <> ) of Rate_Type;
   subtype Rate_Array is Abs_Rate_Array( t );

   type Abs_Amount_Array is array ( t range <> ) of Amount_Type;
   subtype Amount_Array is Abs_Amount_Array( t );
   ZERO_Abs_Amount_Array : constant Amount_Array := ( others => 0.0 );

   type Abs_Counter_Type_Array is array( t range <> ) of Counter_Type;
   subtype Counter_Type_Array is Abs_Counter_Type_Array( t );

   type Abs_Integer_Array is array( t range <> ) of Integer;
   subtype Integer_Array is Abs_Integer_Array( t );

   type Abs_Boolean_Array is array( t range <> ) of Boolean;
   subtype Boolean_Array is Abs_Boolean_Array( t );
   
   type Abs_Triboolean_Array is array( t range <> ) of Triboolean;
   subtype Triboolean_Array is Abs_Triboolean_Array( t );
   

   type Abs_String_Array is array( t range <> ) of Unbounded_String;
   subtype String_Array is Abs_String_Array( t );

   type Pretty_Print_Item_Access_T is access function( v : T ) return String;

   function To_String( r : Abs_Rate_Array; break_lines : Boolean := True ) return String;
   function To_String( r : Abs_Amount_Array; break_lines : Boolean := True ) return String;
   function To_String( i : Abs_Integer_Array; break_lines : Boolean := True ) return String;
   function To_String( b : Abs_Boolean_Array; break_lines : Boolean := True ) return String;
   function To_String( b : Abs_Triboolean_Array; break_lines : Boolean := True ) return String;
   
   function To_String( s : Set ) return String;

   procedure From_String( s : String; a : in out Abs_Rate_Array );
   procedure From_String( s : String; a : in out Abs_Amount_Array );
   procedure From_String( s : String; a : in out Abs_Counter_Type_Array );
   procedure From_String( s : String; a : in out Abs_Integer_Array );
   procedure From_String( str : String; s : in out Set );
   --
   -- Vector product FIXME could we replace all these just with vectors from Maths??
   --
   function Sum( a : Abs_Amount_Array; weights : Abs_Rate_Array ) return Amount_Type;
   function Vector_Product( a : Abs_Amount_Array; weights : Abs_Rate_Array ) return Amount_Type renames Sum;
   
   function Vector_Product( a1 : Abs_Rate_Array; a2 : Abs_Rate_Array ) return Rate_Type;
   function Vector_Product( a1 : Abs_Amount_Array; a2 : Abs_Amount_Array ) return Amount_Type;
   
   --
   -- Sum a over just those elements
   --
   function Sum( a : Abs_Amount_Array; just_these_elements : Set := EMPTY_SET ) return Amount_Type;

   --
   -- b - a differences
   --
   function Difference( a, b : Abs_Amount_Array ) return Abs_Amount_Array;

   --
   -- b - a differences
   --
   function Difference( a,b : Abs_Rate_Array ) return Abs_Rate_Array;

   --
   --
   --
   function Mult( a : Abs_Amount_Array; m : Rate_Type ) return Abs_Amount_Array;
   function Mult( a, b : Abs_Amount_Array ) return Abs_Amount_Array;
   function Mult( a : Abs_Amount_Array; b : Abs_Rate_Array ) return Abs_Amount_Array;

   function Mult( a, b : Abs_Rate_Array ) return Abs_Rate_Array;
   --
   --
   --
   function To_Percent( r : Abs_Amount_Array; just_these_elements : Set := EMPTY_SET ) return Abs_Amount_Array;

   --
   -- m : 0.1 for 10% increase
   --
   function Uprate( a : Abs_Amount_Array; m : Rate_Type; next : Amount_Type := 0.0 ) return Abs_Amount_Array;

   function "+" ( a, b : Abs_Amount_Array ) return Abs_Amount_Array;

   function "+" ( a, b : Abs_Rate_Array ) return Abs_Rate_Array;
   
   function "*" ( a, b : Abs_Amount_Array ) return Abs_Amount_Array renames Mult;

   function "-" ( a, b : Abs_Amount_Array ) return Abs_Amount_Array renames Difference;
   
   function "-" ( a, b : Abs_Rate_Array ) return Abs_Rate_Array renames Difference;

   function "*" ( a : Abs_Amount_Array; b : Abs_Rate_Array ) return Abs_Amount_Array renames Mult;
   
   function "*" ( a : Abs_Rate_Array; b : Abs_Rate_Array ) return Abs_Rate_Array renames Mult;

   
   function Construct_Set( first : T; last : T  ) return Set;

   procedure Increment(
      sum : in out Abs_Counter_Type_Array;
      inc : in Abs_Counter_Type_Array;
      grossing_factor : Amount_Type := 1.0 );

   procedure Increment(
      sum : in out Abs_Amount_Array;
      inc : in Abs_Amount_Array;
      grossing_factor : Amount_Type := 1.0 );

   procedure Increment(
      sum   : in out Abs_Counter_Type_Array;
      which : in T;
      grossing_factor : Amount_Type := 1.0 );

   procedure Increment(
      sum   : in out Abs_Amount_Array;
      which : in T;
      grossing_factor : Amount_Type := 1.0 );
      
      
   function Pick_Randomly return T;
   
   --
   -- so if there are 10 elements in T then Pick_Modular( 22 ) is 2nd element in T 
   --
   function Pick_Modular( i : Integer ) return T;
   
   function Format_Enum_As_List return String;

end T_Utils;
