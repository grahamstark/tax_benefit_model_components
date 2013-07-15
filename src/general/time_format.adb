------------------------------------------------------------------------------
--                                                                          --
--  Simple Map thing for basic language lookups                             --
--                                                                          --
-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with this;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--
-- Not Used?? Ada one is good enough
--
--
pragma License( Modified_GPL );

with Ada.Text_IO.Editing;
with Ada.Strings.Fixed;   
with Ada.Strings; 
with Ada.Strings.UnBounded;
with Ada.Calendar;

package body Time_Format is
   
   use Ada.Strings.Fixed;
   use Ada.Strings;
   use Ada.Calendar;
   
   function round_down( d : Ada.Calendar.Day_Duration ) return Integer is
   begin
      return Integer(Float'Floor(Float( d ) ));
   end round_down;

   
      -- return a string like '2007-09-24 16:07:47'
   function Format( t :Ada.Calendar.Time ) return String is      
      
      YEAR_PICTURE : constant Ada.Text_IO.Editing.Picture :=
         Ada.Text_IO.Editing.To_Picture ("9999");
      TWO_PICTURE : constant Ada.Text_IO.Editing.Picture :=
         Ada.Text_IO.Editing.To_Picture ("99");
      
      type some_decimal is delta 1.0 digits 4;
      
      package Decimal_Format is new Ada.Text_IO.Editing.Decimal_Output (
      Num => some_decimal,
      Default_Currency => "",
      Default_Fill => '0',
      Default_Separator => ',',
      Default_Radix_Mark => '.');
      
      use Ada.Calendar;
      use Ada.Strings.Unbounded;
      s : Unbounded_String := to_unbounded_string( "" );
      
      secs      : constant Day_Duration := Seconds( t );
      hour      : Integer;
      remaining : Day_Duration;
      minute    : Integer;
      second    : Integer;
   begin
      hour := round_down( secs / 3600.0 );
      remaining :=  secs - Day_Duration( hour )*3600.0;
      minute  := round_down( remaining / 60.0 );
      if( minute > 0 ) and ( Day_Duration(minute*60) < remaining ) then
         remaining := remaining - Day_Duration( minute )*60.0;
      end if;
      second := round_down( remaining );
       s := s & decimal_format.image( some_decimal(Year(t)) ,YEAR_PICTURE ) & "-";
      s := s & decimal_format.image( some_decimal(Month(t)),TWO_PICTURE ) & "-";
      s := s & decimal_format.image( some_decimal(Day(t)),TWO_PICTURE ) & " ";
      s := s & decimal_format.image( some_decimal( hour ),TWO_PICTURE ) & ":";
      s := s & decimal_format.image( some_decimal( minute ),TWO_PICTURE ) & ":";
      s := s & decimal_format.image( some_decimal( second ),TWO_PICTURE );
      return to_string( s );
   end Format;


end Time_Format;
