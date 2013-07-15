--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
--   $Revision: 5490 $
--   $Date: 2008-07-23 19:42:24 +0100 (Wed, 23 Jul 2008) $
--
-- A Collection of simple indirect tax calculations
--
--   British - style indirect tax system with (per unit):
-- 
--   Price = ADVAL + VAT + Specific + FactorCost
--   VAT = v * ( Specific + ADVAL + FactorCost )
--   ADVAL = a * Price
--   FactorCost = Price - (ADVAL + VAT + Specific) 
-- Calc_Factor_Cost - use once with base values; these could be stored somewhere.
-- then Calc_Selling_Price for each system given factor costs and taxes for that system
-- then Calc_Total_Indirect_Tax_Due is the main one.
-- There's also Calc_Indir_Tax_Components if you want the same info with
-- seperate entries for VAT and excise duties.
-- 
pragma License( Modified_GPL );

with T_Utils;

generic

    with package TU is new T_Utils( <> );
   
package Indirect_Tax_Utils is

   use TU;
   --
   -- Factor cost (tax exclusive cost) given VAT, per unit tax and ad valorem tax).
   -- 
   -- selling_price per unit in some currency
   -- advalorem - tax as % of final selling price as 0.2 for 20%, for instance
   -- vat tax as % of input costs (including advalorem and specific duties) 0.175 for 17.5% e.g.
   -- 
   --   
   function Calc_Factor_Cost( 
      selling_price     : Abs_Amount_Array; 
      vat, advalorem    : Abs_Rate_Array; 
      specific          : Abs_Amount_Array ) return Abs_Amount_Array;
      
   --
   -- Selling cost given a tax-exclusive cost and the same taxes as above.
   --
   function Calc_Selling_Price( 
         factor_cost     : Abs_Amount_Array; 
         vat, advalorem  : Abs_Rate_Array; 
         specific        : Abs_Amount_Array ) return Abs_Amount_Array;
   --
   -- Taxes due on one unit given selling price and tax rates
   -- return vatdue, addvalorem due, specific (last unchanged)
   --         
   procedure Calc_Indir_Components_Per_Unit( 
            selling_price   : Abs_Amount_Array; 
            vat, advalorem  : Abs_Rate_Array; 
            specific        : Abs_Amount_Array;
            vat_due         : out Abs_Amount_Array;
            add_due         : out Abs_Amount_Array;
            spec_due        : out Abs_Amount_Array );
   --
   -- Taxes due on expenditures given selling price and tax rates
   -- return vatdue, adddue, specific
   --            
   procedure Calc_Indir_Tax_Components( 
            expenditures,
            selling_price    : Abs_Amount_Array; 
            vat              : Abs_Rate_Array;
            advalorem        : Abs_Rate_Array; 
            specific         : Abs_Amount_Array;
            vat_due          : out Abs_Amount_Array;
            add_due          : out Abs_Amount_Array;
            spec_due         : out Abs_Amount_Array );
            
   function Calc_Total_Indir_Due_Per_Unit( 
      selling_price  : Abs_Amount_Array; 
      vat, advalorem : Abs_Rate_Array; 
      specific       : Abs_Amount_Array ) return Abs_Amount_Array;
      
   function Calc_Total_Indirect_Tax_Due( 
      expenditure,
      selling_price    : Abs_Amount_Array; 
      vat, advalorem   : Abs_Rate_Array; 
      specific         : Abs_Amount_Array ) return Abs_Amount_Array;
      
end Indirect_Tax_Utils;
