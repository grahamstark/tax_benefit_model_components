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
--   $Revision: 5490 $
--   $Date: 2008-07-23 19:42:24 +0100 (Wed, 23 Jul 2008) $
--
-- A Collection of simple indirect tax calculations
--
package body Indirect_Tax_Utils is

   --
   -- Factor cost (tax exclusive cost) given VAT, per unit tax and ad valorem tax).
   -- 
   -- All inputs assumed to be vectors/1 dimension arrays of the same length
   -- @param selling_price per unit in some currency
   -- @param advalorem - tax as % of final selling price as 0.2 for 20%, for instance
   -- @param vat tax as % of input costs (including advalorem and specific duties) 0.175 for 17.5% e.g.
   -- @param 
   --
   function Calc_Factor_Cost( 
      selling_price     : Abs_Amount_Array; 
      vat, advalorem    : Abs_Rate_Array; 
      specific          : Abs_Amount_Array ) return Abs_Amount_Array is
      factor_cost       : Abs_Amount_Array( selling_price'Range );
   begin
      for i in selling_price'Range loop
         declare
            f : Amount_Type := factor_cost( i );
            p : Amount_Type := selling_price( i );
            a : Amount_Type := Amount_Type(advalorem( i ));
            s : Amount_Type := specific( i );
            v : Amount_Type := Amount_Type( vat( i ));
         begin
            f := ( p * ( 1.0 - a - ( v * a ))/( 1.0 + v ) ) - s;
            factor_cost( i ) := f;
         end;
      end loop;
      return factor_cost;
   end Calc_Factor_Cost;
  
   --
   -- Selling cost given a tax-exclusive cost and the same taxes as above.
   --
   function Calc_Selling_Price( 
         factor_cost     : Abs_Amount_Array; 
         vat, advalorem  : Abs_Rate_Array; 
         specific        : Abs_Amount_Array ) return Abs_Amount_Array is
     selling_price : Abs_Amount_Array( factor_cost'Range );
     p1 : Amount_Type;
   begin
      for i in selling_price'Range loop
         declare 
            p : Amount_Type;
            f : Amount_Type := factor_cost( i );
            v : Amount_Type := Amount_Type( vat( i ) );
            a : Amount_Type := Amount_Type( advalorem( i ) );
            s : Amount_Type := specific( i );
         begin 
            p := ( f + s ) * ( 1.0 + v )/( 1.0 - a - ( v * a ) );
            selling_price( i ) := p; 
         end;
      end loop;
      return selling_price;
   end Calc_Selling_Price;        

   --
   -- Taxes due on one unit given selling price and tax rates
   -- @ return vatdue, adddue, specific (last unchanged)
   --
   procedure Calc_Indir_Components_Per_Unit( 
            selling_price   : Abs_Amount_Array; 
            vat, advalorem  : Abs_Rate_Array; 
            specific        : Abs_Amount_Array;
            vat_due         : out Abs_Amount_Array;
            add_due         : out Abs_Amount_Array;
            spec_due        : out Abs_Amount_Array ) is
            factor_cost : Abs_Amount_Array := Calc_Factor_Cost( 
               selling_price, vat, advalorem, specific );
   begin         
         for i in selling_price'Range loop
            add_due(i) := Amount_Type( advalorem(i) ) * selling_price(i);
            vat_due(i) := Amount_Type( vat(i) ) * ( factor_cost(i) + add_due(i) + specific(i) );
            spec_due(i) := specific(i);
         end loop;
   end Calc_Indir_Components_Per_Unit;
    
   --
   -- Taxes due on expenditures given selling price and tax rates
   -- @ return vatdue, adddue, specific
   --
   procedure Calc_Indir_Tax_Components( 
   
            expenditures,
            selling_price    : Abs_Amount_Array; 
            vat              : Abs_Rate_Array;
            advalorem        : Abs_Rate_Array; 
            specific         : Abs_Amount_Array;
            vat_due          : out Abs_Amount_Array;
            add_due          : out Abs_Amount_Array;
            spec_due         : out Abs_Amount_Array ) is
            factor_cost : Abs_Amount_Array := Calc_Factor_Cost( selling_price, vat, advalorem, specific );
      quantity : Amount_Type;
   begin   
         Calc_Indir_Components_Per_Unit( 
            selling_price,
            vat, advalorem, 
            specific,
            vat_due,
            add_due,
            spec_due );
         for i in selling_price'Range loop
            quantity := expenditures(i) / selling_price(i);
            add_due(i) := add_due(i) * quantity;
            vat_due(i) := vat_due(i) * quantity;
            spec_due(i) := spec_due(i) * quantity;
         end loop;
   end Calc_Indir_Tax_Components;
   
  function Calc_Total_Indir_Due_Per_Unit( 
      selling_price  : Abs_Amount_Array; 
      vat, advalorem : Abs_Rate_Array; 
      specific       : Abs_Amount_Array ) return Abs_Amount_Array is
      add_due        : Abs_Amount_Array( selling_price'Range );
      vat_due        : Abs_Amount_Array( selling_price'Range );
      spec_due       : Abs_Amount_Array( selling_price'Range );
      total_tax : Abs_Amount_Array( selling_price'Range );
   begin
      Calc_Indir_Components_Per_Unit( 
         selling_price, 
         vat, 
         advalorem, 
         specific, 
         vat_due, 
         add_due, 
         spec_due );
      for i in selling_price'Range loop
         total_tax(i) := vat_due(i) + add_due(i) + spec_due(i);
      end loop;
      return total_tax;
   end Calc_Total_Indir_Due_Per_Unit;
 
  function Calc_Total_Indirect_Tax_Due( 
      expenditure,
      selling_price    : Abs_Amount_Array; 
      vat, advalorem   : Abs_Rate_Array; 
      specific         : Abs_Amount_Array ) return Abs_Amount_Array is
      total_tax        : Abs_Amount_Array := Calc_Total_Indir_Due_Per_Unit( 
         selling_price, vat, advalorem, specific );
      quantity : Amount_Type;
   begin
      for i in selling_price'Range loop
         quantity := expenditure(i) / selling_price(i);
         total_tax(i) := total_tax(i) * quantity;
      end loop;
      return total_tax;
   end Calc_Total_Indirect_Tax_Due;

end Indirect_Tax_Utils;
