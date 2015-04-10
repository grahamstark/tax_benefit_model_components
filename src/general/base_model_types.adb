--
--  $Author: graham_s $
--  $Date: 2012-08-17 18:12:13 +0100 (Fri, 17 Aug 2012) $
--  $Revision: 15230 $
--
--  basic types for our models;
--  originally UK-centric, but now moved out since really
with Ada.Text_IO; use Ada.Text_IO;

with Ada.Strings.Bounded; use Ada.Strings.Bounded;

with Text_Utils;

package body Base_Model_Types is
   
   procedure Add_To_Map( map : in out Auxiliary_Results; key : String; value : Amount ) is
      use Ada.Strings.Unbounded;
      s : Unbounded_String := To_Unbounded_String( key );
   begin
      if( map.Contains( s ))then
         map.Replace( s, value );
      else
         map.Include( s, value );
      end if;
   end Add_To_Map;


   function Standard_Ratio_Between( old_period : Periods; new_period : Periods ) return Rate is
      r : Rate;
   begin
      case old_period is
      when day =>
         case new_period is
            when day => r := 1.0;
            when week => r := 7.0;
            when month => r := 30.0;
            when year => r := 365.0;
         end case;
      when week =>
         case new_period is
            when day => r := 1.0/7.0;
            when week => r := 1.0;
            when month => r := 4.0;
            when year => r := 52.0;
         end case;
      when month =>
         case new_period is
            when day => r := 1.0/30.0;
            when week => r := 1.0/4.0;
            when month => r := 1.0;
            when year => r := 12.0;
         end case;
      when year =>
         case new_period is
            when day => r := 1.0/365.0;
            when week => r := 1.0/52.0;
            when month => r := 1.0/12.0;
            when year => r := 1.0;
         end case;
      end case;
      return r;
   end Standard_Ratio_Between;

   function Ratio_Between( old_period : Periods; new_period : Periods ) return Rate is
   begin
      return Rate( DAYS_PER_Period( old_period ))/Rate( DAYS_PER_Period( new_period ));
   end Ratio_Between;


   function Safe_Mult( a, b : Real ) return Real is
      as : Real := a;
      bs : Real := b;
   begin
      if (a = MISS_R) then
         as := 0.0;
      end if;
      if (b = MISS_R) then
         bs := 0.0;
      end if;
      return Amount (as * bs);
   end Safe_Mult;

   function Safe_Add( a, b : Real; c, d, e, f, g, h : Real := 0.0) return Amount is
      as : Rate := a;
      bs : Rate := b;
      cs : Rate := c;
      ds : Rate := d;
      es : Rate := e;
      fs : Rate := f;
      gs : Rate := g;
      hs : Rate := h;
   begin
      if (as = MISS_R) then
         as := 0.0;
      end if;
      if (bs = MISS_R) then
         bs := 0.0;
      end if;
      if (cs = MISS_R) then
         cs := 0.0;
      end if;
      if (ds = MISS_R) then
         ds := 0.0;
      end if;
      if (es = MISS_R) then
         es := 0.0;
      end if;
      if (fs = MISS_R) then
         fs := 0.0;
      end if;
      if (gs = MISS_R) then
         gs := 0.0;
      end if;
      if (hs = MISS_R) then
         hs := 0.0;
      end if;
      return Amount (as + bs + cs + ds + es + fs + gs + hs);

   end Safe_Add;

   function Safe_Add( a, b : Integer) return Integer is
      as : Integer := a;
      bs : Integer := b;
   begin
      if (as = MISS) then
         as := 0;
      end if;
      if (bs = MISS) then
         bs := 0;
      end if;
      return as + bs;
   end Safe_Add;

   function Safe_Add( a, b : Real) return Real is
      as : Real := a;
      bs : Real := b;
   begin
      if (as = MISS_R) then
         as := 0.0;
      end if;
      if (bs = MISS_R) then
         bs := 0.0;
      end if;
      return as + bs;
   end Safe_Add;


   function Safe_Assign( r : Real ) return Real is
   begin
      if (r = MISS_R) then
         return 0.0;
      end if;
      return r;
   end Safe_Assign;

   function Safe_Real_To_Int( r : Real ) return Integer is
   begin
      if (r = MISS_R) then
         return 0;
      end if;
      return Integer(r);
   end Safe_Real_To_Int;


   function Safe_Int_To_Real( r : Integer ) return Real is
   begin
      if (r = MISS) then
         return 0.0;
      end if;
      return Real(r);
   end Safe_Int_To_Real;

   function Zero_Or_Missing (r : Real) return Boolean is
   begin
      return ((r = 0.0) or (r = MISS_R));
   end Zero_Or_Missing;


   function Annual_To_Weekly( m : Amount ) return Amount is
   begin
      return m / 52.0;
   end Annual_To_Weekly;

   function Weekly_To_Annual( m : Amount ) return Amount is
   begin
      return m * 52.0;
   end Weekly_To_Annual;

   function Multiply( r : Rate_Array; m : Rate ) return Rate_Array is
      x : Rate_Array( r'Range );
   begin
      for i in r'Range loop
         x(i) := r(i) * m;
      end loop;
      return x;
   end Multiply;

   function Multiply( a : Amount_Array; m : Rate ) return Amount_Array is
      x : Amount_Array( a'Range );
   begin
      for i in a'Range loop
         x(i) := a(i) * m;
      end loop;
      return x;
   end Multiply;

   function Sum( r : Amount_Array ) return Amount is
      sm : Amount := 0.0;
   begin
      for i in r'Range loop
         sm := sm + r(i);
      end loop;
      return sm;
   end Sum;

   function To_Percent( r : Amount_Array ) return Amount_Array is
      sm  :  constant Amount := Sum( r );
      x   : Amount_Array( r'Range ) := ( Others=>0.0);
   begin
      if( sm /= 0.0 ) then
         for i in r'Range loop
            x(i) := 100.0 * r(i)/sm;
         end loop;
      end if;
      return x;
   end To_Percent;

   --
   -- From http://en.wikibooks.org/wiki/Ada_Style_Guide/Portability
   -- The following examples test for (1) absolute "equality" in storage, (2) absolute "equality" in computation, (3) relative "equality" in storage, and (4) relative "equality" in computation:
   -- abs (X - Y) <= Float_Type'Model_Small                -- (1)
   -- abs (X - Y) <= Float_Type'Base'Model_Small           -- (2)
   -- abs (X - Y) <= abs X * Float_Type'Model_Epsilon      -- (3)
   -- abs (X - Y) <= abs X * Float_Type'Base'Model_Epsilon -- (4)
   --
   function Differs_By( a, b : Real; tol : Real := 0.0001 ) return Boolean is
   begin
      return Abs( a - b ) < tol;
   end Differs_By;

   function Nearly_Equal( a, b : Real; tol : Real := 0.0001 ) return Boolean is
   begin
      return Abs( a - b ) < tol;
   end Nearly_Equal;

   function To_String( r : Real; width : Positive := 12; prec : Natural := 2 ) return String is
      s : String( 1 .. width ) := ( others => ' ' );
   begin
	Real_IO.Put( s, r, prec, 0 );
        return s;
   end To_String;

   function To_String( i : Integer; width : Positive := 10 ) return String is
      s : String( 1 .. width ) := ( others => ' ' );
   begin
	Int_IO.Put( s, i );
        return s;
   end To_String;

   function To_String( i : Big_Integer; width : Positive := 20 ) return String is
      s : String( 1 .. width ) := ( others => ' ' );
   begin
	Big_Int_IO.Put( s, i );
        return s;
   end To_String;


   function To_String( intermediate : Auxiliary_Results; indent : String ) return String is
   use Ada.Strings.Unbounded;
   use Auxiliary_Results_Package;
      s : Unbounded_String;

      procedure Print_One( c : Cursor ) is
         k   : Unbounded_String := Key( c );
         a   : Amount := Element( c );
      begin
         s := s & indent & k & " = " & To_String( a, 12, 3 ) & Text_Utils.LINE_BREAK;
      end Print_One;

   begin
       intermediate.Iterate( Print_One'Access );
       return To_String( s );
   end To_String;

   procedure Inc( p : in out Integer; by : Integer := 1 ) is
   begin
      p := p + by;
   end Inc;
   
   procedure Inc( r : in out Real; by : Real := 1.0 ) is
   begin
      r := r + by;
   end Inc;

   procedure Inc( r : in out Real; by : Integer ) is
   begin
      r := r + Real( by );
   end Inc;

   procedure Inc( r : in out Counter_Type; by : Real ) is
   begin
      r := r + Counter_Type( by );
   end Inc;

   procedure Inc( r : in out Counter_Type; by : Integer )is
   begin
      r := r + Counter_Type( by );
   end Inc;
   procedure Inc( r : in out Counter_Type; by : Counter_Type := 1.00 )is
   begin
      r := r + Counter_Type( by );
   end Inc;

   procedure Dec( p : in out Integer; by : Integer := 1 ) is
   begin
      p := p - by;
   end Dec;
   
   procedure Dec( r : in out Real; by : Real := 1.0 ) is
   begin
      r := r - by;
   end Dec;

   procedure Dec( r : in out Real; by : Integer ) is
   begin
      r := r - Real( by );
   end Dec;

   procedure Dec( r : in out Counter_Type; by : Real ) is
   begin
      r := r - Counter_Type( by );
   end Dec;
   
   procedure Dec( r : in out Counter_Type; by : Integer ) is
   begin
      r := r - Counter_Type( by );
   end Dec;

   procedure Dec( r : in out Counter_Type; by : Counter_Type := 1.00 )is
   begin
      r := r - Counter_Type( by );
   end Dec;

   --
   -- FIXME Make some generic thingy here ...
   --
   function To_String( r : Rate_Array; width : Positive := 12; prec : Natural := 2 ) return String is
   use Ada.Strings.Unbounded;   
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " => " & To_String( r( i ), width, prec );
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Amount_Array; width : Positive := 12; prec : Natural := 2 ) return String is
   use Ada.Strings.Unbounded;   
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " => " & To_String( r( i ), width, prec );
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Integer_Array ) return String is
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Natural_Array ) return String is
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Positive_Array ) return String is
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Big_Integer_Array ) return String is
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Boolean_Array ) return String is
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Counter_Type_Array ) return String is
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( r : Age_Limit_Array ) return String is  
   use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      for i in r'Range loop
         s := s & i'Img & " =>" & r( i )'Img;
         if( i < r'Last )then
            s := s & ", ";
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function Nearly_Equal( 
      a   : Rate_Array; 
      b   : Rate_Array; 
      tol : Rate := 0.0001 ) return Boolean is
   begin
      if a'First /= b'First or a'Last /= b'Last then
         return False;
      end if;
      for i in a'Range loop
         if not Nearly_Equal( a( i ), b( i ), tol ) then
            return False;
         end if;
      end loop;
      return True;
   end Nearly_Equal;
   
   function Nearly_Equal( 
      a   : Amount_Array; 
      b   : Amount_Array; 
      tol : Amount := 0.0001 ) return Boolean  is
   begin
      if a'First /= b'First or a'Last /= b'Last then
         return False;
      end if;
      for i in a'Range loop
         if not Nearly_Equal( a( i ), b( i ), tol ) then
            return False;
         end if;
      end loop;
      return True;
   end Nearly_Equal;

end Base_Model_Types;
