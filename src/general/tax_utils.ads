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
--   $Author: graham_s $
--   $Revision: 11995 $
--   $Date: 2011-06-13 21:12:27 +0100 (Mon, 13 Jun 2011) $
--
-- A Collection of tax calculations and uprating procedures.
--
pragma License( Modified_GPL );

with Ada.Containers.Vectors;

generic
   --
   -- A decimal or fixed point type for Amount amounts, such as tax bands and amounts due
   --
   type Amount_Type is digits<>;
   --
   -- A floating point type for rates.
   --
   type Rate_Type is digits<>;

package Tax_Utils is

   type Tax_Result is record
         due      : Amount_Type  := 0.0;
         end_band : Natural := 0;
      end record;

   --  pragma Preelaborate;

   type Rate_And_Band is record
      rate : Rate_Type;
      band : Amount_Type;
   end record;


   type Rates_And_Bands    is tagged private;

   function To_String( ratebands : Rates_And_Bands ) return String;

   procedure Set_Rate_And_Band( ratebands : in out Rates_And_Bands; rb : Rate_And_Band; pos : Positive; replace : Boolean := true );
   function Get_Rate_And_Band( ratebands : Rates_And_Bands; which : Positive ) return Rate_And_Band;
   procedure Delete_Rate_And_Band( ratebands :  in out Rates_And_Bands; which : Positive );
   procedure Delete_All_Rates_And_Bands( ratebands :  in out Rates_And_Bands );
   function Get_Num_Rates_And_Bands( ratebands : Rates_And_Bands ) return Natural;
   -- for example, if someone has 20,000 and bands are 5k=>1,10k=>10,30k=>30,40k=>50, change to 10k=>30,40k=>50
   -- useful for uk income tax calculation where there are seperate rate bands in earnings, unearned, dividends
   procedure Remove_Up_To( ratebands : in out Rates_And_Bands; upto : Amount_Type );
   --
   --
   procedure To_Levels
     ( ratebands : in out Rates_and_Bands );
   --
   --
   procedure To_Percent
     ( ratebands : in out Rates_and_Bands );
   --
   --
   procedure Weekly_To_Annual
     ( ratebands : in out Rates_and_Bands );
   --
   --  standard banded income tax - style calculation
   --
   --
   function Calc_Tax_Due(
      ratebands : Rates_and_Bands;
      taxable   : Amount_Type ) return Tax_Result;

   --
   --  old style ni tax calculation: tax is band(p) * taxdue
   --  where p is the 1st band greater or equal to taxable.
   --
   function Stepped_Tax_Calculation
     ( ratebands : Rates_and_Bands;
       taxable   : Amount_Type )
      return     Tax_Result;

   --
   --  uprate some bands, using rooker wise 'uprate the gaps'
   --  rules if next is greater than 0 THIS NEEDS FIXED
   --
   procedure Uprate
     ( ratebands : in out Rates_and_Bands;
       uprate_by : Rate_Type; -- enter, say, 0.12 for a 12% increase
       next      : Amount_Type := 0.0 );
   procedure Multiply_Rates( ratebands : in out Rates_and_Bands; amount : Rate_Type );
   procedure Multiply_Bands( ratebands : in out Rates_and_Bands; amount : Rate_Type );

   --
   --
   procedure Annual_To_Weekly
     ( ratebands : in out Rates_and_Bands );

   type Limit_And_Amount is record
      limit  : Integer;
      amount : Amount_Type;
   end record;
   type Limits_And_Amounts is tagged private;

   procedure Set_Limit_And_Amount( lms : in out Limits_And_Amounts; rb : Limit_And_Amount; pos : Positive; replace : Boolean := true );
   function Get_Limit_And_Amount( lms : Limits_And_Amounts; which : Positive ) return Limit_And_Amount;
   procedure Delete_Limit_And_Amount( lms :  in out Limits_And_Amounts; which : Positive );
   procedure Delete_All_Limits_And_Amounts( lms :  in out Limits_And_Amounts );
   function Get_Num_Limits_And_Amounts( lms : Limits_And_Amounts ) return Natural;

   --
   --  uprate the Amount value x by uprate by, rounding to next
   --  using Rooker Wise rules.
   --
   function Uprate
     ( x        : Amount_Type;
       uprate_by: Rate_Type; -- enter, say, 0.12 for a 12% increase
       next     : Amount_Type := 0.0 ) return Amount_Type;

   procedure Uprate
     ( x        : in out Amount_Type;
       uprate_by: Rate_Type; -- enter, say, 0.12 for a 12% increase
       next     : Amount_Type := 0.0 );

   --
   --  uprate some bands, using rooker wise 'uprate the gaps'
   --  rules if next is greater than 0
   --
   procedure Uprate
     ( lms           : in out Limits_And_Amounts;
       uprate_by     : Rate_Type; -- enter, say, 0.12 for a 12% increase
       limit_next    : Amount_Type := 0.0;
       amount_next   : Amount_Type := 0.0 );
   --
   --
   procedure Annual_To_Weekly
     ( lms           : in out Limits_And_Amounts );

   procedure Weekly_To_Annual
     ( lms           : in out Limits_And_Amounts );
   procedure Multiply_Limits_And_Amounts( lms : in out Limits_And_Amounts; amount : Rate_Type );

private

   package Rates_And_Bands_List is new Ada.Containers.Vectors( Element_Type => Rate_And_Band, Index_Type => Positive );
   type Rates_And_Bands is tagged record
      v : Rates_and_Bands_List.Vector;
   end record;

   package Limits_And_Amounts_List is new Ada.Containers.Vectors( Element_Type => Limit_And_Amount, Index_Type => Positive );
   type Limits_And_Amounts is tagged record
      v : Limits_And_Amounts_List.Vector;
   end record;

end Tax_Utils;
