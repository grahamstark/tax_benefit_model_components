with Format_Utils;
with Text_Utils;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Characters.Latin_1;
with Ada.Directories;
with Ada.Strings.Unbounded;
with GNAT.Regpat;

package body Conversions is

   Missing_R : Rate    := MISS_R;
   Missing_I : Integer := MISS;
   FLATTEN_MISSING_INTS : Boolean := False;

   procedure Set_Assigned_Missing_Values( missr : Rate; missi : Integer ) is
   begin
      Missing_R := Missr;
      Missing_I := Missi;
   end  Set_Assigned_Missing_Values;

   function Get( slices : Slice_Set; which : Natural ) return String is
      wn : Slice_Number := Slice_Number( which );
   begin
      return Slice( slices, wn );
   end Get;

   function Convert_Index( slices : Slice_Set; which : Natural ) return Serial_Num is
      use Ada.Strings.Fixed;
      use Ada.Strings;
      wn : Slice_Number := Slice_Number( which );
      n  : Serial_Num;
   begin
      n := Serial_Num'Value( Trim( Slice( slices , wn ), Both ));
      return n;
   end Convert_Index;

   function Convert( slices : Slice_Set; which : Natural; missing : R_Null_Or_Missing_Indicators ) return Rate is
      use Ada.Strings.Fixed;
      use Ada.Strings;
      package UK_Format_Utils is new Format_Utils( Float_Type=>Rate, Counter_Type=>Counter_Type );
      use UK_Format_Utils;
      wn : Slice_Number := Slice_Number( which );
      r  : Real;
   begin
      if( Slice( slices, wn)'Length = 0 ) or ( Slice( slices, wn) = " " )then
         return MISS_R;
      end if;
      declare
         s  : String := Trim( Slice( slices , wn ), Both );
         sf : constant Integer := s'First;
         sl : constant Integer := s'Last;
      begin
         if( s( sl ) = '-' )then -- in SPSS files, negatives are written "1012-", leaving -9, etc for missing value indicatore
            r := -1.0 * Lenient_Convert( s( sf .. sl-1 ));
         else
            r := Lenient_Convert( s );
         end if;
      end;
      for i in missing'Range loop
         if( r = missing( i ))then return Missing_R; end if;
      end loop;
      return r;
   end Convert;

   function Convert( slices : Slice_Set; which : Natural; missing : Null_Or_Missing_Indicators  ) return Rate is
      rms : R_Null_Or_Missing_Indicators( missing'First .. missing'Last );
   begin
      for i in missing'First .. missing'Last loop
         rms( i ) := Rate( missing( i ));
      end loop;
      return Convert( slices, which, rms );
   end Convert;

   function Convert( slices : Slice_Set; which : Natural ) return Rate is
      mvs : constant R_Null_Or_Missing_Indicators := ( 1 .. 0 => -1.0 );
   begin
      return Convert( slices, which, mvs );
   end Convert;

   function Convert( slices : Slice_Set; which : Natural ) return Sernum_Value is
      use Ada.Strings.Fixed;
      use Ada.Strings;
      wn : Slice_Number := Slice_Number( which );
   begin
      return Sernum_Value'Value( Trim(Slice( slices , wn ), Both ));
   end Convert;

   function Convert( slices : Slice_Set; which : Natural; missing : Null_Or_Missing_Indicators ) return Integer is
      use GNAT.Regpat;
      use Ada.Strings.Fixed;
      use Ada.Strings;
      i  : Integer;
      wn : Slice_Number := Slice_Number( which );
   begin
      if( Slice( slices, wn )'Length = 0 ) or ( Slice( slices, wn) = " " )then
         return MISS;
      end if;
      declare
         NEG_VAL_RE : constant Pattern_Matcher := Compile( "([\d]+)\-+" ); -- negs written xx- in bhps tab files
         JUNK_VAL_RE : constant Pattern_Matcher := Compile( "^(-+)$" ); -- some like '---' which I treat as missing
         s  : String := Trim( Slice( slices , wn ), Both );
         sf : constant Integer := s'First;
         sl : constant Integer := s'Last;
         matches : Match_Array( 0 .. 1 );
      begin
         Match( NEG_VAL_RE, s, matches);
         if( matches( 0 ) /= No_Match )then
            Ada.Text_IO.Put_Line( "found a funny |" & s & " s( matches (1).first .. matches (1).last ) |" & s( matches (1).first .. matches (1).last ) & "|" );
            i := -1 * Integer'Value( s( matches (1).first .. matches (1).last ));
            return i;
         end if;
         Match( JUNK_VAL_RE, s, matches);
         if( matches( 0 ) /= No_Match )then
            Ada.Text_IO.Put_Line( "found a junk number |" & s & "|" );
            return Missing_I;
         end if;
         i := Integer'Value( s );
         -- NOTE: I've decided to leave missing/non response values in for int cases
         if( FLATTEN_MISSING_INTS )then
            for j in missing'Range loop
               if( i = missing( j )) then return Missing_I; end if;
            end loop;
         end if;
      end;
      return i;
   end Convert;

   function Convert( slices : Slice_Set; which : Natural ) return Integer is
   begin
      return Convert( slices=>slices, which=>which, missing=>( 0 .. -1 => -1 ));
   end Convert;

   function Convert( s : String ) return Ada.Calendar.Time is
      use Ada.Calendar;
      use Ada.Text_IO;
      subset : Slice_Set;
      secs : Day_Duration := Day_Duration(0);
      year  : Integer;
      month : Integer;
      day   : Integer;
   begin
      Create( subset, s, "/", Single );
      month := Convert( subset, 1 );
      day := Convert( subset, 2 );
      year := Convert( subset, 3 );
      put_line( "year " & year'Img );
      return Time_Of(
               Year_Number( year ),
               Month_Number( month ),
               Day_Number( day ),
               secs );

   end Convert;


   function Convert( slices : Slice_Set; which : Natural ) return Ada.Calendar.Time is
   begin
      return Convert( Slice( slices , Slice_Number(which) ) );
   end Convert;

   use Ada.Characters.Latin_1;

   TDA_DELIMS : constant String := HT & LF & CR;

   function TDA_Tokenize( s : String ) return Slice_Set is
   begin
      return Tokenize( s, TDA_Delims );
   end TDA_Tokenize;

   function TDA_Tokenize( s : Unbounded_String ) return Slice_Set is
   begin
      return Tokenize( s, TDA_DELIMS );
   end TDA_Tokenize;

   function Tokenize( s : String; delims : String ) return Slice_Set is
      use Ada.Strings.Fixed;
      use Ada.Strings;

      slices : Slice_Set;
      last   : Natural := s'Last;
   begin
      if( s(last) = LF ) then last := last - 1; end if;
      Create( slices, Trim( s( s'First .. last ), Both ), delims, Single );
      return slices;
   end Tokenize;

   function Tokenize( s : Unbounded_String; delims : String ) return Slice_Set is
   begin
      return Tokenize( To_String( s ), delims );
   end Tokenize;


end Conversions;
