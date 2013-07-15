--
-- copyrigh(c) 2008 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
-- 
-- FIXME : split this into Incomes_List (list, quantiles, binify) Incomes_List.Basic_Statistics Incomes_List.Inequality
--

-- Inequality functions. This takes a vector of (population,income) pairs
-- and computes a bunch of inequality and concentration measures for them.
-- This is copied pretty much verbatim from Python code found here:
--    http://luaforge.net/frs/download.php/181/inequality-1.3.4.py.html
-- and authored by:
-- Goetz Kluge, Munich 2004-09-17, http://poorcity.richcity.org
-- To whom I am very grateful.
-- 
-- I've always thought that inequality measurement was a bit weird, and I'm
-- not always sure what some of these measures even mean, but if that's what you like,
-- this is what you like.
-- I think the Atkinson one is not *the* Atkinson measure (the one with the aversion parameter). But who knows?
-- Note that at present the incomes have to be positive in all cases (there are logs..).
--
pragma License( Modified_GPL );

with Ada.Containers.Vectors;pragma Elaborate_All( Ada.Containers.Vectors );

generic 
   --
   -- This is the floating type we use throughout. 
   --
   type Rate is digits<>;
   --
   -- Incomes and popns as 
   -- 
   type Amount is digits<>;
                 
package Inequality_Generator is

   -- pragma Preelaborate;
   
   type Quantile is record
      index      : Positive := Positive'First;
      income     : Amount;
      population : Amount;
   end record;
   
   
   type Ranking_Rec is record
      index : Positive;
      rank  : Positive;
      cumulative_population : Amount;
   end record;

   type Measures is (
      Mean,
      Median, 
      Average_Deviation,
      Standard_Deviation,
      Skewness,
      Kurtosis,
      Minimum,
      Maximum,
      Percentile_5,
      Percentile_95,     
      Total_Income, 
      Total_Population,
      Gini, 
      MacRae_Inequality, 
      Atkinson_Inequality, 
      Kullback_Leibler_Inequality, 
      Hoover_Inequality,
      Europe_Equality, 
      Europe_Inequality, 
      Coulter_Inequality,
      Platon_Inequality, 
      Theil_Redundancy, 
      Kullback_Leibler_Redundancy, 
      Williamson_Variation, 
      Negative_Warning ); 

   subtype Simple_Statistics is Measures range Mean .. Total_Population;
   type Inequality_Array is array( Measures ) of Rate;
   type Simple_Statistics_Array is array( Simple_Statistics ) of Rate;
   
   package Quantile_Package is new Ada.Containers.Vectors( Element_Type => Quantile, Index_Type => Positive );
   subtype Quantile_List is Quantile_Package.Vector;

   package Rank_Package is new Ada.Containers.Vectors( Element_Type => Ranking_Rec, Index_Type => Positive );
   subtype Rank_List is Rank_Package.Vector;
   --
   -- Generate all the strange inequality measures in the list above.
   --
   function Generate( 
      quantiles : Quantile_List;
      incomes_are_pre_weighted : Boolean := True;
      allow_non_positive_values : Boolean := True ) return Inequality_Array;
   
--   function Nth_Percentile(    
--      sorted_quantiles : Quantile_List;
--      which : Percentile ) return Amount;
      
   --
   -- 
   procedure Sort_By_Income( quantiles : in out Quantile_List );
   
   function Rank_By_Income( quantiles : Quantile_List ) return Rank_List;
   
   Inequality_Exception : exception;
   --
   -- Chop incomes up into num_bins bins. Useful for drawing lorenz curves;
   -- Input vector needs to be sorted (though this is not checked)
   -- 
   function Binify( quantiles : Quantile_List; num_bins : Positive ) return Quantile_List;

   
   function To_String( ineq : Inequality_Array ) return String;
   function To_String( quant : Quantile ) return String;
   
   procedure Dump_All_Quantiles( filename : String; quantiles : Quantile_List ); 

end Inequality_Generator;

