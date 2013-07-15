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
--   $Revision: 5475 $
--   $Date: 2008-07-19 19:35:49 +0100 (Sat, 19 Jul 2008) $
--
-- A Collection of tax calculations and uprating procedures.
--
pragma License( Modified_GPL );

generic

   type Amount is digits<>;   
   type Rate is digits<>;
   MAX_NUM_BANDS  : Positive;

package Tax_Utils is

   subtype Bands_Range is Integer range 1 .. MAX_NUM_BANDS;

   type Basic_Array is array ( Bands_Range ) of Amount;
   type Basic_Int_Array is array ( Bands_Range ) of Integer;
   type Basic_Rate_Array is array ( Bands_Range ) of Rate;

   type Tax_Result is
      record
         due      : Amount  := 0.0;
         end_band : Natural := 0; 
      end record;

   --
   --  standard banded income tax - style calculation
   --
   --
   function Calc_Tax_Due
     (taxable   : Amount;
      rates     : Basic_Rate_Array;
      bands     : Basic_Array;
      num_bands : Bands_Range )
      return     Tax_Result;
   --
   --  old style ni tax calculation: tax is band(p) * taxdue
   --  where p is the 1st band greater or equal to taxable.
   --
   function Stepped_Tax_Calculation
     (taxable   : Amount;
      rates     : Basic_Rate_Array;
      bands     : Basic_Array;
      num_bands : Bands_Range )
      return     Tax_Result;
   --
   --   make a contribution of the p th element of rate
   --   when income is greater than or equal to the p th
   --   element of bands.
   --
   function Calc_Stepped_Contribution
     (taxable   : Amount;
      rates     : Basic_Rate_Array;
      bands     : Basic_Array;
      num_bands : Bands_Range )
      return     Tax_Result;
   --
   --  uprate the Amount value x by uprate by, rounding to next
   --  using Rooker Wise rules
   --
   function Uprate
     (x        : Amount;
      uprate_by: Rate;
      next     : Amount := 0.0)
      return     Amount;
   --
   --  uprate some bands, using rooker wise 'uprate the gaps'
   --  rules if next is greater than 0
   --
   function Uprate_Bands
     (bands     : Basic_Array;
      num_bands : Bands_Range;
      uprate_by : Rate;
      next      : Amount := 0.0)
      return     Basic_Array;
      
end Tax_Utils;
