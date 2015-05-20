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
--  $Author: graham_s $
--  $Date: 2009-08-08 19:36:08 +0100 (Sat, 08 Aug 2009) $
--  $Revision: 7868 $
--
pragma License( Modified_GPL );

with Ada.Strings.Unbounded;
with Text_Utils;
with Format_Utils;
with Tax_Utils;
with GNAT.String_Split;
with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Text_IO;

package body T_Utils is
   use Ada.Strings.Unbounded;
   use Text_Utils;
   use Ada.Characters.Latin_1;
   use Ada.Strings.Fixed;
   use Ada.Strings;
   use GNAT.String_Split;
   use Ada.Text_IO;

   TERMINATOR  : constant String := ",";
   SEPARATOR   : constant String := "=";

   package Local_Format_Utils is new Format_Utils( Float_Type=>Rate_Type, Counter_Type=>Counter_Type );
   use Local_Format_Utils;

   procedure Delete_Last_Character( outs : in out Unbounded_String ) is
   begin
      if Length( outs ) > 0 then
         Delete( outs, Length( outs ), Length( outs ));
      end if;
   end Delete_Last_Character;


   function Key( s : String ) return T is
      p : Natural := 0;
   begin
      p := Index( s, SEPARATOR );
      put_line( " s = |" & s & "| p = " & p'Img );
      return T'Value( Trim( s( s'First .. p-1 ), Both ));
   end key;

   function Value( s : String ) return Amount_Type is
      p : Natural := Index( s, SEPARATOR );
   begin
      return Amount_Type'Value( Trim( s( p+1 .. s'Last ), Both ));
   end Value;

   function Value( s : String ) return Integer is
      p : Natural := Index( s, SEPARATOR );
   begin
      return Integer'Value( Trim( s( p+1 .. s'Last ), Both ));
   end Value;

   function Value( s : String ) return Rate_Type is
      p : Natural := Index( s, SEPARATOR );
   begin
      return Lenient_Convert( Trim( s( p+1 .. s'Last ), Both ));
   end Value;

   function Value( s : String ) return Counter_Type is
      p : Natural := Index( s, SEPARATOR );
   begin
      return Lenient_Convert( Trim( s( p .. s'Last ), Both ));
   end Value;

   procedure From_String( s : String; a : in out Abs_Rate_Array ) is
      last   : Natural := s'Last;
      slices : Slice_Set;
      k      : T;
      v      : Rate_Type;
   begin
      if( last > 1 ) then
         if( s(last) = LF ) then last := last - 1; end if;
         -- put_line( "From_String String is |" & s & "| " );
         Create( slices, Trim( s( s'First .. last ), Both ), TERMINATOR, Single );
         for i in a'Range loop
            a(i) := 0.0;
         end loop;
         for n in 1 .. Slice_Count( slices ) loop
            -- Put_Line( "slice(" & n'Img & " ) = " & slice( slices, n ));
            k := Key( Trim(slice( slices, n ), both));
            v := Value( Trim(slice( slices, n ), both));
            -- Put_Line( "value = " & v'Img );
            a( k ) := v;
         end loop;
      end if;
   end From_String;

   procedure From_String( s : String; a : in out Abs_Counter_Type_Array ) is
      last   : Natural := s'Last;
      slices : Slice_Set;
      k      : T;
      v      : Counter_Type;
   begin
      if( last > 1 ) then
         if( s(last) = LF ) then last := last - 1; end if;
         -- put_line( "From_String String is |" & s & "| " );
         Create( slices, Trim( s( s'First .. last ), Both ), TERMINATOR, Single );
         for i in a'Range loop
            a(i) := 0.0;
         end loop;
         for n in 1 .. Slice_Count( slices ) loop
            -- Put_Line( "slice(" & n'Img & " ) = " & slice( slices, n ));
            k := Key( Trim(slice( slices, n ), both));
            v := Value( Trim(slice( slices, n ), both));
            -- Put_Line( "value = " & v'Img );
            a( k ) := v;
         end loop;
      end if;
   end From_String;

   procedure From_String( s : String; a : in out Abs_Amount_Array ) is
      last   : Natural := s'Last;
      slices : Slice_Set;
      k      : T;
      v      : Amount_Type;
   begin
      if( last > 1 ) then
         if( s(last) = LF ) then last := last - 1; end if;
         -- put_line( "From_String String is |" & s & "| " );
         Create( slices, Trim( s( s'First .. last ), Both ), TERMINATOR, Single );
         for i in a'Range loop
            a(i) := 0.0;
         end loop;
         for n in 1 .. Slice_Count( slices ) loop
            -- Put_Line( "slice(" & n'Img & " ) = " & slice( slices, n ));
            k := Key( Trim(slice( slices, n ), both));
            v := Value( Trim(slice( slices, n ), both));
            -- Put_Line( "value = " & v'Img );
            a( k ) := v;
         end loop;
      end if;
   end From_String;

   procedure From_String( s : String; a : in out Abs_Integer_Array ) is
      last   : Natural := s'Last;
      slices : Slice_Set;
      k      : T;
      v      : Integer;
   begin
      if( last > 1 ) then
         if( s(last) = LF ) then last := last - 1; end if;
         -- put_line( "From_String String is |" & s & "| " );
         Create( slices, Trim( s( s'First .. last ), Both ), TERMINATOR, Single );
         for i in a'Range loop
            a(i) := 0;
         end loop;
         for n in 1 .. Slice_Count( slices ) loop
            -- Put_Line( "slice(" & n'Img & " ) = " & slice( slices, n ));
            k := Key( Trim(slice( slices, n ), both));
            v := Value( Trim(slice( slices, n ), both));
            -- Put_Line( "value = " & v'Img );
            a( k ) := v;
         end loop;
      end if;
   end From_String;



   function To_String( r : Abs_Rate_Array; break_lines : Boolean := True ) return String is
       outs : Unbounded_String := To_Unbounded_String( "" );
   begin
      for i in r'Range loop
         if( r(i) /= 0.0 ) then
            outs := outs & T'Image( i ) & SEPARATOR & Format( r(i) );

            if( break_lines ) then
               outs := outs & LINE_BREAK;
            else
               outs := outs & TERMINATOR;
            end if;
         end if;
      end loop;
      if( not break_lines ) then
         Delete_Last_Character( outs );
      end if;
      return To_String(outs);
   end To_String;

   function To_String( r : Abs_Amount_Array; break_lines : Boolean := True ) return String is
       outs : Unbounded_String := To_Unbounded_String( "" );
   begin
      for i in r'Range loop
         if( r(i) /= 0.0 ) then
            outs := outs & T'Image( i ) & SEPARATOR & Format( Rate_Type(r(i)) );
            if( break_lines ) then
               outs := outs & LINE_BREAK;
            else
               outs := outs & TERMINATOR;
            end if;
         end if;
      end loop;
      if( not break_lines ) then
         Delete_Last_Character( outs );
      end if;
      return To_String(outs);
   end To_String;

   function To_String( i : Abs_Integer_Array; break_lines : Boolean := True ) return String is
       outs : Unbounded_String := To_Unbounded_String( "" );
   begin
      for j in i'Range loop
         if( i(j) /= 0 ) then
            outs := outs & T'Image( j ) & SEPARATOR & Integer'Image(i(j));
            if( break_lines ) then
               outs := outs & LINE_BREAK;
            else
               outs := outs & TERMINATOR;
            end if;
         end if;
      end loop;
      if( not break_lines ) then
         Delete_Last_Character( outs );
      end if;
      return To_String(outs);
   end To_String;

   function To_String( b : Abs_Boolean_Array; break_lines : Boolean := True ) return String is
      outs : Unbounded_String := To_Unbounded_String( "" );
   begin
      for i in b'Range loop
         if( b(i) ) then
            outs := outs & T'Image( i );
            if( break_lines ) then
               outs := outs & LINE_BREAK;
            else
               outs := outs & TERMINATOR;
            end if;
         end if;
      end loop;
      if( not break_lines ) and ( Length( outs ) > 0 ) then
         Delete_Last_Character( outs );
      end if;
      return To_String(outs);
   end To_String;


   procedure From_String( str : String; s : in out Set ) is
      use Set_Ops;
      last   : Natural := str'Last;
      slices : Slice_Set;
      begin
      if( last > 1 ) then
         if( str(last) = LF ) then last := last - 1; end if;
         -- put_line( "From_String String is |" & s & "| " );
         Create( slices, Trim( str( str'First .. last ), Both ), ",", Single );
         Clear( s );
         for n in 1 .. Slice_Count( slices ) loop
            Include( s, T'Value(Trim(slice( slices, n ), both)));
         end loop;
      end if;
   end From_String;

   function To_String( s : Set ) return String is
      use Ada.Strings.Unbounded;
      use Set_Ops;
      outs : Unbounded_String := To_Unbounded_String( "" );

      procedure Print( pos : Set_Ops.Cursor ) is
         item : T := Element( pos );
      begin
         outs := outs & ( T'Image(item) );
         if( pos /= Last( s ) ) then
            outs := outs & ", ";
         end if;
      end Print;

   begin
      Iterate( s, Print'Access );
      return To_String( outs );
   end To_String;


   function Sum( a : Abs_Amount_Array; weights : Abs_Rate_Array ) return Amount_Type is
      sum : Amount_Type := 0.0;
   begin
      for i in a'Range loop
         sum := sum + Amount_Type( Rate_Type( a(i) ) * weights(i));
      end loop;
      return sum;
   end Sum;
   
   function Vector_Product( a1 : Abs_Amount_Array; a2 : Abs_Amount_Array ) return Amount_Type is
      sum : Amount_Type := 0.0;
   begin
      for i in a1'Range loop
         sum := sum + (a1(i) * a2(i));
      end loop;
      return sum;
   end Vector_Product;
      
   function Vector_Product( a1 : Abs_Rate_Array; a2 : Abs_Rate_Array ) return Rate_Type is
      sum : Rate_Type := 0.0;
   begin
      for i in a1'Range loop
         sum := sum + (a1(i) * a2(i));
      end loop;
      return sum;
   end Vector_Product;

   function Sum( a : Abs_Amount_Array; just_these_elements : Set := EMPTY_SET ) return Amount_Type is
   use type Set;
      sum : Amount_Type := 0.0;
   begin
      for i in a'Range loop
         if( Set_Ops.Contains( just_these_elements, i ) or ( just_these_elements = EMPTY_SET ) ) then
            sum := sum + a(i);
         end if;
      end loop;
      return sum;
   end Sum;

   function Difference( a,b : Abs_Amount_Array ) return Abs_Amount_Array is
      subtype dt is Abs_Amount_Array( a'Range );
      d : dt;
   begin
      for i in a'Range loop
         d(i) := a(i) - b(i);
      end loop;
      return d;
   end Difference;

   function "+" ( a ,b : Abs_Amount_Array ) return Abs_Amount_Array is
      subtype dt is Abs_Amount_Array( a'Range );
      d : dt;
   begin
      for i in a'Range loop
         d(i) := a(i) + b(i);
      end loop;
      return d;
   end "+";

   function Difference( a,b : Abs_Rate_Array ) return Abs_Rate_Array is
      subtype tr is Abs_Rate_Array( a'Range );
      d : tr;
   begin
      for i in a'Range loop
         d(i) := a(i) - b(i);
      end loop;
      return d;
   end Difference;

   -- 2 for doubling
   function Mult( a : Abs_Amount_Array; m : Rate_Type ) return Abs_Amount_Array is
      subtype dt is Abs_Amount_Array( a'Range );
      d : dt;
   begin
      for i in a'Range loop
         d(i) := Amount_Type( Rate_Type(a(i)) * m );
      end loop;
      return d;
   end Mult;

   -- 2 for doubling
   function Mult( a, b : Abs_Amount_Array ) return Abs_Amount_Array is
      subtype dt is Abs_Amount_Array( a'Range );
      d : dt;
   begin
      for i in a'Range loop
         d(i) := a(i) * b(i);
      end loop;
      return d;
   end Mult;

   -- 2 for doubling

   function Mult( a : Abs_Amount_Array; b : Abs_Rate_Array ) return Abs_Amount_Array is
      subtype dt is Abs_Amount_Array( a'Range );
      d : dt;
   begin
      for i in a'Range loop
         d(i) := a(i) * Amount_Type(b(i));
      end loop;
      return d;
   end Mult;

   -- next : 0.1 for 10% increase
   function Uprate( a : Abs_Amount_Array; m : Rate_Type; next : Amount_Type := 0.0 ) return Abs_Amount_Array is
      package tu is new Tax_Utils( Amount_Type=>Amount_Type, Rate_Type=>Rate_Type );
      subtype dt is Abs_Amount_Array( a'Range );
      d : dt;
   begin
      for i in a'Range loop
         d(i) := tu.Uprate( a(i), m, next );
      end loop;
      return d;
   end Uprate;

   function Construct_Set( first : T; last : T ) return Set is
      s : Set;
   begin
      for i in first .. last loop
         Set_Ops.Include( s, i );
      end loop;
      return s;
   end Construct_Set;

   procedure Increment(
      sum : in out Abs_Counter_Type_Array;
      inc : in Abs_Counter_Type_Array;
      grossing_factor : Amount_Type := 1.0 ) is
   begin
      for i in sum'Range loop
         sum( i ) := sum( i ) + ( inc( i ) * Counter_Type( grossing_factor ));
      end loop;
   end Increment;

   procedure Increment(
      sum : in out Abs_Amount_Array;
      inc : in Abs_Amount_Array;
      grossing_factor : Amount_Type := 1.0 ) is
   begin
      for i in sum'Range loop
         sum( i ) := sum( i ) + ( inc( i ) * grossing_factor );
      end loop;
   end Increment;

   procedure Increment(
      sum   : in out Abs_Counter_Type_Array;
      which : in T;
      grossing_factor : Amount_Type := 1.0 ) is
   begin
      sum( which ) := sum( which ) + Counter_Type( grossing_factor );
   end Increment;

   procedure Increment(
      sum   : in out Abs_Amount_Array;
      which : in T;
      grossing_factor : Amount_Type := 1.0 ) is
    begin
      sum( which ) := sum( which ) + grossing_factor;
    end Increment;

    function To_Percent( r : Abs_Amount_Array; just_these_elements : Set := EMPTY_SET ) return Abs_Amount_Array is
    use type Set;
      sm  :  constant Amount_Type := Sum( r );
      x   : Abs_Amount_Array( r'Range ) := ( Others=>0.0);
    begin
       if( sm /= 0.0 ) then
          for i in r'Range loop
             if( Set_Ops.Contains( just_these_elements, i ) or ( just_these_elements = EMPTY_SET ) ) then
                x(i) := 100.0 * r(i)/sm;
             end if;
          end loop;
       end if;
       return x;
    end To_Percent;


end T_Utils;
