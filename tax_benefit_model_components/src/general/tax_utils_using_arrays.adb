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
--   $Revision: 4997 $
--   $Date: 2008-04-13 16:18:43 +0100 (Sun, 13 Apr 2008) $
--
pragma License( Modified_GPL );

package body Tax_Utils is

   function Uprate
     (x         : Amount;
      uprate_by : Rate;
      next      : Amount := 0.0)
      return     Amount
   is
      rx    : Rate;
      iadd  : Integer;
      add   : Rate;
      rnext : Rate;
   begin
      if x = 0.0 then
         return 0.0;
      end if;
      if uprate_by= 0.0 then
         return x;
      end if;
      if (next = 0.0) then
         return Amount (Rate (x) * uprate_by);
      end if;
      rnext := Rate (next);
      rx    := Rate (x);
      iadd  := Integer ((rx * uprate_by) / Rate (next));
      add   := (rnext * Rate (iadd)) + rnext;
      return Amount (rx + add);
   end uprate;

   function Uprate_Bands
     (bands     : Basic_Array;
      num_bands : Bands_Range;
      uprate_by : Rate; --  enter 1.1 for a 10% increase
      next      : Amount := 0.0)
      return     Basic_Array
   is
      gap      : Amount;
      width    : Basic_Array;
      igap     : Integer;
      outArray : Basic_Array;
   begin
      if (uprate_by= 0.0) then
         outArray := bands;
      elsif (next = 0.0) then
         for b in  1 .. num_bands loop
            if (bands (b) = Amount'Last) then
               outArray (b) := bands (b);
            else
               outArray (b) := Amount (Rate (bands (b)) * uprate_by);
            end if;
         end loop;
      else
         width (1) := bands (1);
         igap      := Integer (Rate (width (1)) * (uprate_by- 1.0));
         gap       := Amount (igap) + next;
         width (1) := width (1) + gap;
         for i in  2 .. num_bands loop
            width (i) := bands (i) - bands (i - 1);
            igap      := Integer((Rate (width (i)) * (uprate_by- 1.0)));
            gap       := Amount (igap) + next;
            width (i) := width (i) + gap;
         end loop;
         outArray (1) := width (1);
         for i in  2 .. num_bands loop
            if (bands (i) = Amount'Last) then
               outArray (i) := bands (i);
            else
               outArray (i) := outArray (i - 1) + width (i);
            end if;
         end loop;
      end if;
      return outArray;
   end Uprate_Bands;

   --
   --   make a contribution of the p th element of rate
   --   when income is greater than or equal to the p th
   --   element of bands.
   --
   function Calc_Stepped_Contribution
     (taxable   : Amount;
      rates     : Basic_Rate_Array;
      bands     : Basic_Array;
      num_bands : Bands_Range)
      return     Tax_Result
   is
      taxr   : Amount;
      result : Tax_Result;
   begin
      taxr := Amount'Min (taxable, bands (num_bands));
      for p in  1 .. num_bands loop
         if (taxr < bands (p)) then
            result.end_band := p;
            result.due     := Amount (rates (p));
         end if;
      end loop;
      return result;
   end Calc_Stepped_Contribution;

   --
   --  old style ni tax calculation: tax is band(p) * taxdue
   --  where p is the 1st band greater or equal to taxable.
   --
   function Stepped_Tax_Calculation
     (taxable   : Amount;
      rates     : Basic_Rate_Array;
      bands     : Basic_Array;
      num_bands : Bands_Range)
      return     Tax_Result
   is
      m      : Rate := 0.0;
      taxr   : Amount;
      result : Tax_Result;
   begin
      taxr := Amount'Min (taxable, bands (num_bands));
      for p in  1 .. num_bands loop
         if (taxr < bands (p)) then
            result.end_band := p;
            m              := Rate (taxr) * rates (p);
            result.due     := Amount (m);
         end if;
      end loop;
      return result;
   end Stepped_Tax_Calculation;

   --
   --  standard banded income tax - style calculation
   --
   --
   function Calc_Tax_Due
     (taxable   : Amount;
      rates     : Basic_Rate_Array;
      bands     : Basic_Array;
      num_bands : Bands_Range)
      return     Tax_Result
   is
      remaining, gap : Amount;
      i              : Natural;
      t              : Rate;
      result         : Tax_Result;
   begin
      --
      --  calculate in floats then convert back to fixed on exit
      --
      remaining := taxable;
      i         := 0;
      gap       := bands (1);
      while remaining > 0.0 loop
         i := i + 1;
         if i > 1 then
            if i < num_bands then
               gap := bands (i) - bands (i - 1);
            else
               gap := Amount'Last;
            end if;
         end if;
         t          := Rate (Amount'Min (remaining, gap));
         result.due := result.due + Amount (t * rates (i));
         remaining  := remaining - gap;
      end loop;
      result.end_band := i;
      return result;
   end Calc_Tax_Due;

end Tax_Utils;
