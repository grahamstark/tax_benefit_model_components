--
-- $Revision $
-- $Author $
-- $Date $
--
-- Format numbers with 2 decimal places and optional commas
--
--
pragma License( Modified_GPL );

with Ada.Strings.Fixed;
with Ada.Strings;
with Text_Utils;
with Numeric_IO;
with GNAT.Regpat;
with Text_IO;

package body Format_utils is
   
   use Ada.Strings.Fixed;
   use Ada.Strings;
   use Text_Utils;
   use Text_IO;
   use type Utils.Error_Type;
   
   NUMERIC_REGEP : constant String := "^ *\-{0,1}((\d+)|(\d{1,3})(\" & DEFAULT_SEPARATOR & "\d{3})*)";
   FLOAT_REGEP  : constant String := NUMERIC_REGEP & "(\" & DEFAULT_RADIX_MARK&"\d{2,})* *$";
   INT_REGEP  : constant String := NUMERIC_REGEP & " *$";
   
   -- See: http://regexlib.com/DisplayPatterns.aspx?cattabindex=2&categoryid=3&p=6 for the regep
   
   function Validate_String_As_Number( s : String; is_integer : Boolean := False ) return Boolean is
      -- GNAT Specific ..
      -- See: http://www.adacore.com/2008/02/11/gem-26-2/ for usage Regpat example
      --
      use GNAT.Regpat;
      MATCH_FLOAT_RE : constant Pattern_Matcher := Compile( FLOAT_REGEP );
      MATCH_INT_RE : constant Pattern_Matcher := Compile( INT_REGEP );
      Pos : Natural;
   begin
       if( is_integer )then
         pos := Match( MATCH_INT_RE, s );
       else
         pos := Match( MATCH_FLOAT_RE, s );
       end if;
       return pos = 1;
   end Validate_String_As_Number;
   
   function Format( t : Ada.Calendar.Time ) return String is
      use Ada.Calendar;
      s : Unbounded_String;
   begin
      s := s & TuS(Format( Day( t ))) & "/";
      s := s & TuS(Format( Month( t ))) & "/";
      s := s & TuS(Format( Year( t )));
      return To_String( s );
   end Format;
   
   Percent_Picture : constant Ada.Text_IO.Editing.Picture :=
      Ada.Text_IO.Editing.To_Picture ("-ZZZ_ZZZ_ZZZ_ZZ9.99" );
      
   package Decimal_Format is new Ada.Text_IO.Editing.Decimal_Output (
      Num => Counter_Type,
         Default_Currency => Default_Currency,
         Default_Fill => Default_Fill,
         Default_Separator => Default_Separator,
         Default_Radix_Mark => Default_Radix_Mark );

  function Format_counts ( c : Counter_Type ) return String is
  begin
      if (not Decimal_Format.Valid (c, COUNTS_PICTURE)) then
         if( c < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      return Trim (Decimal_Format.Image (c, COUNTS_PICTURE), Side => Both);
   end Format_counts;

   function Format_with_commas (i : Integer) return String is
      m : Counter_Type := Counter_Type(i);
   begin
      if (not Decimal_Format.Valid (m, COUNTS_PICTURE)) then
         if( m < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      return Trim (Decimal_Format.Image (m, COUNTS_PICTURE), Side => Both);
   end Format_with_commas;

   function Strip_Internal_Blanks( s : String ) return String is
   begin
         if( s( 1 ) = '-' )then -- strip blanks from negatives; must be better way .. 
         for i in 2 .. s'Length loop
            if( s( i ) /= ' ' )then
               return "-" & s( i .. s'Length );
            end if;
         end loop;
      end if;
      return s;
   end Strip_Internal_Blanks;
   
   function Format_with_commas( c : Counter_Type; include_decimals : Boolean := True ) return String is
   begin
      if (not Decimal_Format.Valid (c, COUNTS_PICTURE)) then
        if( c < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      if( include_decimals ) then
          return Strip_Internal_Blanks( Trim (Decimal_Format.Image( c, Amount_PICTURE ), Side => Both ));
      else
         return Strip_Internal_Blanks( Trim (Decimal_Format.Image( c, COUNTS_PICTURE ), Side => Both ));
      end if;
   end Format_with_commas;

   function Format_Percent( c : Counter_Type ) return String is
   begin
      if (not Decimal_Format.Valid( c, Percent_PICTURE )) then
        if( c < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      return Trim (Decimal_Format.Image( c, Percent_Picture ), Side => Both);
   end Format_Percent;

   function Format_Percent( r : Float_Type ) return String is
      m : Counter_Type;
   begin
      m := Counter_Type(r);
      if (not Decimal_Format.Valid( m, Percent_PICTURE )) then
        if( r < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;      
      return Format_Percent( m );
   end Format_Percent;
   
   
   function Format_with_commas( r : Float_Type; include_decimals : Boolean := True ) return String is
      m : Counter_Type;
      lr : Float_Type := Float_Type'Rounding( r * 100.0 );
   begin
      if( lr < Float_Type(Counter_Type'First )) or  ( lr > Float_Type( Counter_Type'Last ))then
        if( lr < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      m := Counter_Type( lr ) / 100.0;
      if (not Decimal_Format.Valid( m, COUNTS_PICTURE )) then
        if( m < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      return Format_with_commas( m, include_decimals );
   end Format_with_commas;
   

   function Format( r : Float_Type ) return String is
      lr : Float_Type := Float_Type'Rounding( r * 100.0 );
   begin
      if( lr < Float_Type(Counter_Type'First )) or  ( lr > Float_Type(Counter_Type'Last ))then
        if( lr < 0.0 )then
            return "-infinity";
         else
            return "infinity";
         end if;
      end if;
      return Format( Counter_Type( lr )/100.0);
   end Format;
   
   function Format( c : Counter_Type ) return String is
      s :  String := Trim (
         Decimal_Format.Image( c, Default_Picture ), 
            Side => Both );
      k : Positive;
   begin
      return Strip_Internal_Blanks( s );
   end Format;

   
   function Format (i : Integer) return String is
   begin
      return Trim ( Integer'Image( i ), Side => Both);
   end Format;
   
   function Format_With_Commas_L( c : Counter_Type; include_decimals : Boolean := True ) return Unbounded_String is
   begin
      return TuS( Format_With_Commas( c, include_decimals ));
   end Format_With_Commas_L;
   
   function Format_With_Commas_L( r : Float_Type; include_decimals : Boolean := True ) return Unbounded_String is
   begin
      return TuS( Format_With_Commas( r, include_decimals ));
   end Format_With_Commas_L;
   
   function Format_With_Commas_L( i : Integer ) return Unbounded_String is
   begin
      return TuS( Format_With_Commas( i ));
   end Format_With_Commas_L;
   
   function Format_L( c : Counter_Type ) return Unbounded_String is
   begin
      return TuS( Format( c ));
   end Format_L;
   
   function Format_L( r : Float_Type ) return Unbounded_String is
   begin
      return TuS( Format( r ));
   end Format_L;
   
   function Format_L( i : Integer ) return Unbounded_String is
   begin
      return TuS( Format( i ));
   end Format_L;
   
   function Format_L( t : Ada.Calendar.Time ) return Unbounded_String is
   begin
      return TuS( Format( t ));
   end Format_L;


   procedure Validate
     (inputStr : String;
      val      : out Float_Type;
      message  : out Unbounded_String;
      error    : out Utils.Error_Type;
      min      : Float_Type := Float_Type'First;
      max      : Float_Type := Float_Type'Last) is
   begin
      val     := Lenient_Convert(inputStr);
      message := TuS("");
      error := Utils.No_Error;
      if (val > max) then
         message := TuS("This should be no more than " & Format( max ));
         error := Utils.Out_Of_Range_Error;
      end if;
      if (val < min) then
         message := TuS("This needs to be at least " & Format( min ));
         error := Utils.Out_Of_Range_Error;
      end if;
   exception
      when others =>
         message := TuS("This is not a valid number");
         error := Utils.Format_Error;
   end validate;
   
   procedure Validate
     (inputStr : String;
      val      : out Counter_Type;
      message  : out Unbounded_String;
      error    : out Utils.Error_Type;
      min      : Counter_Type := Counter_Type'First;
      max      : Counter_Type := Counter_Type'Last) is
   begin
      val     := Lenient_Convert(inputStr);
      message := TuS("");
      error := Utils.No_Error;
      if (val > max) then
         message := TuS("This should be no more than " & Format( max ));
         error := Utils.Out_Of_Range_Error;
      end if;
      if (val < min) then
         message := TuS("This needs to be at least " & Format( min ));
         error := Utils.Out_Of_Range_Error;
      end if;
   exception
      when others =>
         message := TuS("This is not a valid number");
         error := Utils.Format_Error;
   end validate;

   procedure Validate
     (inputStr : String;
      val      : out Integer;
      message  : out Unbounded_String;
      error    : out Utils.Error_Type;
      min      : Integer := Integer'First;
      max      : Integer := Integer'Last) is
   begin
      val     := Integer'Value (inputStr);
      message := TuS("");
      error := Utils.No_Error;
      if (val > max) then
         message := TuS("This should be no more than " & Integer'Image( max ));
         error := Utils.Out_Of_Range_Error;
      end if;
      if (val < min) then
         message := TuS("This needs to be at least " & Integer'Image( min ));
         error := Utils.Out_Of_Range_Error;
      end if;
   exception
      when others =>
         message := TuS("This is not a valid integer");
         error := Utils.Format_Error;
   end validate;
   
   function Lenient_Convert( s : String ) return Float_Type is
      --
      -- This uses John P Woodruff's Numeric_IO package
      --
      package nio is new Numeric_IO( Floating_Type=>Float_Type, Integer_Type=>Integer );
      
      last : Positive := 1;
      r    : Float_Type;
   begin      
      -- Put_Line( "Lenient_Convert; converting |" & s & "|" );
      nio.Real_Decode( s, r, last );
      return r;
   end Lenient_Convert;
   
   function Lenient_Convert( s : Unbounded_String ) return Float_Type is
   begin
      return Lenient_Convert( TS( s ) );
   end Lenient_Convert;

   function Lenient_Convert( s : String ) return Counter_Type is
      r : Float_Type := Lenient_Convert( s );
   begin
      return Counter_Type( r );
   end Lenient_Convert;
   
   function Lenient_Convert( s : Unbounded_String ) return Counter_Type is
   begin
      return Lenient_Convert( TS( s ) );
   end Lenient_Convert;

end Format_utils;
