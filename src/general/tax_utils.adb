--
-- copyright(c) 2007 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
--
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
--
-- /////////////////////////////
--
--
--   $Author: graham_s $
--   $Revision: 12868 $
--   $Date: 2011-10-18 15:45:46 +0100 (Tue, 18 Oct 2011) $
--
pragma License( Modified_GPL );

with Ada.Text_io;use Ada.Text_io;
with Ada.Strings.Unbounded;
with Text_Utils;


package body Tax_Utils is

   DAYS_PER_YEAR   : constant Rate_Type := 365.25;
   WEEKS_PER_YEAR  : constant Rate_Type := DAYS_PER_YEAR / 7.0;
   WEEKS_PER_MONTH : constant Rate_Type := WEEKS_PER_YEAR / 12.0;
   
   procedure Set_Rate_And_Band( ratebands : in out Rates_And_Bands; rb : Rate_And_Band; pos : Positive; replace : Boolean := true ) is
   use Rates_And_Bands_List;
   begin
      if(( Get_Num_Rates_And_Bands( ratebands ) > pos )  and replace ) then
         Replace_Element( ratebands.v, pos, rb );
      else
         Insert( Vector(ratebands.v), pos, rb );
      end if;
   end Set_Rate_And_Band;

   procedure Delete_All_Rates_And_Bands( ratebands :  in out Rates_And_Bands ) is
   use Rates_And_Bands_List;
   begin
      Clear( ratebands.v );
   end Delete_All_Rates_And_Bands;

   function Get_Rate_And_Band( ratebands : Rates_And_Bands; which : Positive ) return Rate_And_Band is
   use Rates_And_Bands_List;
   begin
      return Element( Vector( ratebands.v ), which );
   end Get_Rate_And_Band;

   procedure Delete_Rate_And_Band( ratebands : in out Rates_And_Bands; which : Positive ) is
   use Rates_And_Bands_List;
   begin
      Delete( Vector( ratebands.v ), which );
   end Delete_Rate_And_Band;

   function Get_Num_Rates_And_Bands( ratebands : Rates_And_Bands ) return Natural is
   use Rates_And_Bands_List;
   begin
      return Natural(Length( Vector( ratebands.v ) ));
   end Get_Num_Rates_And_Bands;


   function Uprate
     (x         : Amount_Type;
      uprate_by : Rate_Type; -- e.g 0.1 for a 10% increase
      next      : Amount_Type := 0.0)
      return     Amount_Type
   is
      rx    : constant Rate_Type := Rate_Type( x );
      iadd  : Amount_Type;
      add   : Rate_Type;
      rnext : Rate_Type;
   begin
      if x = 0.0 or uprate_by = 0.0 or x = Amount_Type'Last then
         return x;
      end if;
      if( next = 0.0 )then
         add := Rate_Type (x) * uprate_by;
      else
         rnext := Rate_Type (next);
         iadd  := Amount_Type'Rounding(( x * Amount_Type( uprate_by )) / next );
         add   := ( rnext * Rate_Type( iadd )) + rnext;
      end if;
      if(( Amount_Type'Last - Amount_Type(add)) < x ) then
         return Amount_Type'Last;
      else
         return Amount_Type( rx + add );
      end if;
   end Uprate;

   procedure Uprate
     (x         : in out Amount_Type;
      uprate_by : Rate_Type; -- e.g 0.1 for a 10% increase
      next      : Amount_Type := 0.0) is
   begin
      x := Uprate( x, uprate_by, next );
   end Uprate;


   MAX_SAFE_VALUE : constant := 9999999999999999.9;

   function New_Gap( b1, b2 : Amount_Type; uprate_by : Rate_Type; next : Amount_Type ) return Amount_Type is
      rnext      : Rate_Type := Rate_Type( next );
      rgap       : Rate_Type;
      rwidth     : Rate_Type;
      width      : Amount_Type := b2 - b1;
   begin
      rwidth := Rate_Type( width );
      rgap := Rate_Type'Floor( rwidth * ((uprate_by-1.0)/rnext ));
      rgap := rnext + ( rgap * rnext );
      if (MAX_SAFE_VALUE  - rgap <= rwidth ) then
         width := MAX_SAFE_VALUE;
      else
         width := Amount_Type(rgap+rwidth);
      end if;
      return width;
   end New_Gap;

   --
   -- FIXME: delete
   --

   procedure Uprate( ratebands : in out Rates_and_Bands; uprate_by : Rate_Type; next : Amount_Type := 0.0 ) is

      use Rates_And_Bands_List;

      package Gaps_List is new Ada.Containers.Vectors( Element_Type => Amount_Type, Index_Type => Positive );

      gaps       : Gaps_List.Vector;
      num_bands  : constant Positive := Get_Num_Rates_And_Bands( ratebands );
      rb         : Rate_And_Band;
      width      : Amount_Type;
      last_rb    : Rate_And_Band;
   begin
      if (uprate_by = 0.0) then
         return;
      end if;
      if (next = 0.0) then
         for b in 1 .. num_bands loop
            rb := Get_Rate_And_Band( ratebands, b );
            rb.band := Amount_Type( Rate_Type(rb.band) * uprate_by);
            Set_Rate_And_Band( ratebands, rb, b );
         end loop;
      else
         width  := New_Gap( 0.0, Get_Rate_And_Band( ratebands, 1 ).band, uprate_by, next );
         Gaps_List.append( gaps, width );
         for b in 2 .. num_bands loop
            width := New_Gap( Get_Rate_And_Band( ratebands, b-1 ).band, Get_Rate_And_Band( ratebands, b ).band, uprate_by, next );
            Gaps_List.append( gaps, width );
         end loop;
         rb := Get_Rate_And_Band( ratebands, 1 );
         rb.band := Gaps_List.Element( gaps, 1 );
         Set_Rate_And_Band( ratebands, rb, 1 );
         for b in 2 .. num_bands loop
            width :=  Gaps_List.Element( gaps, b );
            last_rb := Get_Rate_And_Band( ratebands, b-1 );
            rb := Get_Rate_And_Band( ratebands, b );
            if (MAX_SAFE_VALUE  - width <= last_rb.band ) then
               rb.band := MAX_SAFE_VALUE;
            else
               rb.band := last_rb.band + width;
            end if;
            Set_Rate_And_Band( ratebands, rb, b );
         end loop;
      end if;
   end Uprate;

   procedure Multiply_Rates( ratebands : in out Rates_and_Bands; amount : Rate_Type ) is
   use Rates_And_Bands_List;

      procedure Multiply_One( pos : Cursor ) is
         rb : Rate_And_Band :=  element( pos );
      begin
         rb.rate := rb.rate * amount;
         Replace_Element( ratebands.v, pos, rb );
      end Multiply_One;

   begin
      Iterate( ratebands.v, Multiply_One'Access );
   end Multiply_Rates;

   procedure Multiply_Bands( 
      ratebands   : in out Rates_and_Bands; 
      amount      : Rate_Type;
      exclude_top : Boolean := False ) is
   use Rates_And_Bands_List;

      procedure Multiply_One( pos : Cursor ) is
         rb : Rate_And_Band :=  element( pos );
      begin
         if pos = Last( ratebands.v ) and exclude_top then 
            return; 
         end if; 
         rb.band := rb.band * Amount_Type(amount);
         Replace_Element( ratebands.v, pos, rb );
      end Multiply_One;

   begin
      Iterate( ratebands.v, Multiply_One'Access );
   end Multiply_Bands;

   --
   --
   procedure To_Levels
     ( ratebands : in out Rates_and_Bands ) is
   begin
      Multiply_Rates( ratebands, 1.0/100.0 );
   end To_Levels;

   --
   --
   procedure To_Percent
     ( ratebands : in out Rates_and_Bands )is
   begin
      Multiply_Rates( ratebands, 100.0 );
   end To_Percent;

   --
   --
   procedure Weekly_To_Annual
     ( ratebands : in out Rates_and_Bands )is
   begin
      Multiply_Bands( ratebands, WEEKS_PER_YEAR, False );
   end Weekly_To_Annual;

   --
   --
   procedure Annual_To_Weekly
     ( ratebands : in out Rates_and_Bands ) is
   begin
      Multiply_Bands( ratebands, 1.0/WEEKS_PER_YEAR, False );
   end Annual_To_Weekly;
   --
   --

   --
   --   make a contribution of the p th element of rate
   --   when income is greater than or equal to the p th
   --   element of bands.
   --
   function Stepped_Tax_Calculation(
   	ratebands : Rates_and_Bands;
      taxable   : Amount_Type )
      return     Tax_Result is
    use Rates_And_Bands_List;

      rb_index   : Rates_And_Bands_List.Cursor;
      rb         : Rate_And_Band;
      result : Tax_Result;
      p      : Natural := 0;
      taxable_amount : constant Amount_Type := Amount_Type'Min( taxable, Rates_And_Bands_List.element( Rates_And_Bands_List.Last( ratebands.v ) ).band );
   begin

      rb_index := Rates_And_Bands_List.First ( ratebands.v );

      loop
         rb := Rates_And_Bands_List.element( rb_index );
         p := p + 1;
         if (taxable_amount <= rb.band ) then
            result.end_band := p;
            result.due := Amount_Type( rb.rate * Rate_Type( taxable_amount ));
            exit;
         end if;
         rb_index := Rates_And_Bands_List.next( rb_index );
         exit when rb_index = Rates_And_Bands_List.No_Element;
      end loop;
      return result;
   end Stepped_Tax_Calculation;

   procedure Remove_Up_To( ratebands : in out Rates_And_Bands; upto : Amount_Type ) is
      use Rates_And_Bands_List;
      use Ada.Containers;
      rb_index   : Cursor := ratebands.v.First;
      total : Amount_Type := 0.0;
      to_delete : Count_Type := 0;
      remaining : Amount_Type := upto;
      rb : Rate_And_Band;
   begin
      loop
         rb := Element( rb_index );
         total := total + rb.band;
         remaining := total - upto;
         exit when total >= upto;
         to_delete := to_delete + 1;
         Next( rb_index );
      end loop;
      if( to_delete > 0 )then
         ratebands.v.Delete_First( to_delete );
      end if;
      if ratebands.v.Length > 1 then
         rb := ratebands.v.First_Element;
         rb.band := remaining;
         ratebands.v.Replace_Element( 1, rb );
      end if;
   end Remove_Up_To;
   --
   --  standard banded income tax - style calculation
   --
   --
   function Calc_Tax_Due(
      ratebands : Rates_and_Bands;
      taxable   : Amount_Type
      ) return Tax_Result
   is

   use Rates_And_Bands_List;
      rb_index   : Rates_And_Bands_List.Cursor := Rates_And_Bands_List.First ( ratebands.v );
      remaining : Amount_Type := taxable;
      gap       : Amount_Type := Rates_And_Bands_List.element( Rates_And_Bands_List.First( ratebands.v ) ).band;
      last      : Amount_Type := 0.0;
      i         : Natural := 0;
      t         : Rate_Type;
      result    : Tax_Result;
      rb        : Rate_And_Band;
   begin
      --
      --  calculate in floats then convert back to fixed on exit
      --
      loop
         exit when( (remaining <= 0.0 ) or ( rb_index = Rates_And_Bands_List.No_Element ));
         i := i + 1;
         rb := Rates_And_Bands_List.Element( rb_index );
         if( rb_index /= Rates_And_Bands_List.Last( ratebands.v ) ) then
            gap := rb.band - last;
         else
            gap := Amount_Type'Last;
         end if;
         t          := Rate_Type (Amount_Type'Min ( remaining, gap ));
         result.due := result.due + Amount_Type (t * rb.rate );
         remaining  := remaining - gap;
         last       := rb.band;
         rb_index := Rates_And_Bands_List.next( rb_index );
      end loop;
      result.end_band := i;
      return result;
   end Calc_Tax_Due;

   procedure Set_Limit_And_Amount( lms : in out Limits_And_Amounts; rb : Limit_And_Amount; pos : Positive; replace : Boolean := true ) is
   use Limits_And_Amounts_List;
   begin
      if(( Get_Num_Limits_And_Amounts( lms ) > pos )  and replace ) then
         Replace_Element( lms.v, pos, rb );
      else
         Insert( Vector(lms.v), pos, rb );
      end if;
   end Set_Limit_And_Amount;

   function Get_Limit_And_Amount( lms : Limits_And_Amounts; which : Positive ) return Limit_And_Amount is
   use Limits_And_Amounts_List;
   begin
      return Element( Vector( lms.v ), which );
   end Get_Limit_And_Amount;

   procedure Delete_Limit_And_Amount( lms : in out Limits_And_Amounts; which : Positive ) is
   use Limits_And_Amounts_List;
   begin
      Delete( Vector( lms.v ), which );
   end Delete_Limit_And_Amount;

   procedure Delete_All_Limits_And_Amounts( lms :  in out Limits_And_Amounts ) is
   use Limits_And_Amounts_List;
   begin
      Clear( lms.v );
   end Delete_All_Limits_And_Amounts;

   function Get_Num_Limits_And_Amounts( lms : Limits_And_Amounts ) return Natural is
   use Limits_And_Amounts_List;
   begin
      return Natural(Length( Vector( lms.v ) ));
   end Get_Num_Limits_And_Amounts;

   procedure Uprate
     ( lms           : in out Limits_And_Amounts;
      uprate_by     : Rate_Type; -- enter, say, 0.12 for a 12% increase
      limit_next    : Amount_Type := 0.0;
      amount_next   : Amount_Type := 0.0 ) is
   begin
      null;
   end Uprate;

   package FIO is new Ada.Text_IO.Float_IO( Rate_Type );
   package AIO is new Ada.Text_IO.Float_IO( Amount_Type );

   function FN( r : Rate_Type; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
      FIO.Put(s, r, 2, 0 );
      return s;
   end FN;

   function FN( r : Amount_Type; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
      AIO.Put(s, r, 2, 0 );
      return s;
   end FN;



   function To_String( ratebands : Rates_And_Bands ) return String is
   use Rates_And_Bands_List;
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;

      procedure To_String( pos : Cursor ) is
         la : Rate_And_Band :=  element( pos );
      begin
         -- la.limit := la.limit * Amount_Type(amount);
         if( la.band < 999999999.99 )then
            s := s & FN( la.band, 13 );
         else
            s := s & "  inf        ";
         end if;
         s := s & FN( la.rate * 100.0, 10 );
         s := s & LINE_BREAK;
      end To_String;

   begin
      s := s & "        BAND      RATE " & LINE_BREAK;
      Iterate( ratebands.v, To_String'Access );
      return To_String( s );
   end To_String;


   procedure Multiply_Limits_And_Amounts( lms : in out Limits_And_Amounts; amount : Rate_Type ) is
   use Limits_And_Amounts_List;

      procedure Multiply_One( pos : Cursor ) is
         la : Limit_And_Amount :=  element( pos );
      begin
         -- la.limit := la.limit * Amount_Type(amount);
         la.amount := la.amount * Amount_Type(amount);
         Replace_Element( lms.v, pos, la );
      end Multiply_One;

   begin
      Iterate( lms.v, Multiply_One'Access );
   end Multiply_Limits_And_Amounts;

  procedure Annual_To_Weekly
     ( lms           : in out Limits_And_Amounts ) is
   begin
      Multiply_Limits_And_Amounts( lms, 1.0/WEEKS_PER_YEAR );
   end Annual_To_Weekly;

   procedure Weekly_To_Annual
     ( lms           : in out Limits_And_Amounts ) is
   begin
      Multiply_Limits_And_Amounts( lms, WEEKS_PER_YEAR );
   end Weekly_To_Annual;


end Tax_Utils;
