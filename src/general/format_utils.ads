
--
-- $Revision $
-- $Author $
-- $Date $
--
pragma License( Modified_GPL );

with Ada.Strings.Unbounded;
with Text_Utils;
with Ada.Containers.Ordered_Sets;
with Ada.Calendar;
with Utils;
with Ada.Text_IO.Editing;

generic
   --
   -- This is the floating type we use throughout. 
   --
   type Float_Type is digits<>;
   --
   --
   --
   type Counter_Type is delta<> digits<>;
   
   Default_Currency   : in String    :=  ""; --Ada.Text_IO.Editing.Default_Currency;
   Default_Fill       : in Character := Ada.Text_IO.Editing.Default_Fill;
   Default_Separator  : in Character := Ada.Text_IO.Editing.Default_Separator;
   Default_Radix_Mark : in Character := Ada.Text_IO.Editing.Default_Radix_Mark;
   Default_Picture    : in Ada.Text_IO.Editing.Picture :=
      Ada.Text_IO.Editing.To_Picture ("-ZZZZZZZZZZZZZZZZZZZZZ9.99" );
   Amount_Picture     : in Ada.Text_IO.Editing.Picture :=
      Ada.Text_IO.Editing.To_Picture ("-ZZZ_ZZZ_ZZZ_ZZZZ_ZZZ_ZZ9.99" );
   Counts_Picture     : in Ada.Text_IO.Editing.Picture :=
      Ada.Text_IO.Editing.To_Picture ("-ZZZ_ZZZ_ZZZ_ZZZZ_ZZZ_ZZ9" );
      
package Format_Utils is
   -- note: format needed as a hack sine I tried making amount and Float_Type subtypes of float_type 
   -- ug .. 
   --  pragma PreelaboFloat_Type;
   use Ada.Strings.Unbounded;

   function Format_With_Commas( c : Counter_Type; include_decimals : Boolean := True ) return String;
   function Format_With_Commas( r : Float_Type; include_decimals : Boolean := True ) return String;
   function Format_With_Commas( i : Integer ) return String;
   function Format( c : Counter_Type ) return String;
   
   function Format_Percent( r : Float_Type ) return String;
   function Format_Percent( c : Counter_Type ) return String;
  
   function Format( r : Float_Type; prec : Natural := 2 ) return String;
   function Format( i : Integer ) return String;
   function Format( t : Ada.Calendar.Time ) return String;
   
   function Format_With_Commas_L( c : Counter_Type; include_decimals : Boolean := True ) return Unbounded_String;
   function Format_With_Commas_L( r : Float_Type; include_decimals : Boolean := True ) return Unbounded_String;
   function Format_With_Commas_L( i : Integer ) return Unbounded_String;
   function Format_L( c : Counter_Type ) return Unbounded_String;
   
   function Format_L( r : Float_Type; prec : Natural := 2 ) return Unbounded_String;
   function Format_L( i : Integer ) return Unbounded_String;
   function Format_L( t : Ada.Calendar.Time ) return Unbounded_String; 
   
   function Lenient_Convert( s : String ) return Float_Type;
   function Lenient_Convert( s : String ) return Counter_Type;
   function Lenient_Convert( s : Unbounded_String ) return Float_Type;
   function Lenient_Convert( s : Unbounded_String ) return Counter_Type;

   procedure Validate
     (inputStr : String;
      val      : out Float_Type;
      message  : out Unbounded_String;
      error    : out Utils.Error_Type;
      min      : Float_Type := Float_Type'First;
      max      : Float_Type := Float_Type'Last);
      
   procedure Validate
     (inputStr : String;
      val      : out Counter_Type;
      message  : out Unbounded_String;
      error    : out Utils.Error_Type;
      min      : Counter_Type := Counter_Type'First;
      max      : Counter_Type := Counter_Type'Last);
      
   procedure Validate
     (inputStr : String;
      val      : out Integer;
      message  : out Unbounded_String;
      error    : out Utils.Error_Type;
      min      : Integer := Integer'First;
      max      : Integer := Integer'Last);

   function Validate_String_As_Number( s : String; is_integer : Boolean := False ) return Boolean;
   
end Format_Utils;
