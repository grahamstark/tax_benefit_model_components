--
-- copyrigh(c) 2007 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
-- Inequality functions.
-- 
-- pretty much copied verbatim from Python code:
--    http://luaforge.net/frs/download.php/181/inequality-1.3.4.py.html
--
pragma License( Modified_GPL );

with Ada.Numerics.Generic_Elementary_Functions; 
with Ada.Numerics; 
with Ada.Text_IO; 
with Ada.Strings.Unbounded; 
with Text_Utils; 
with Format_Utils; 
with Ada.Exceptions; 
with Ada.Assertions;

package body Inequality_Generator is

   use Text_Utils;
   use Ada.Assertions;
   
   type Dec is delta 0.01 digits 12; -- purely for formatting

   package F is new Format_Utils( Float_Type=>Rate, Counter_Type=>Dec );

   type Sum_Components is record
      logxa       : Rate := 0.0;
      logxe       : Rate := 0.0;
      lorenz      : Rate := 0.0;
      income      : Rate := 0.0;
      population  : Rate := 0.0;
      xabs        : Rate := 0.0;
      square      : Rate := 0.0;
      var         : Rate := 0.0;
   end record;
   
   function To_String( s : Sum_Components ) return String is
   begin
      return 
         "logxa = " & Rate'Image(s.logxa) &
         " logxe = " & Rate'Image(s.logxe) &
         " lorenz = " & Rate'Image(s.lorenz) &
         " income = " & Rate'Image(s.income) &
         " population = " & Rate'Image(s.population) &
         " xabs = " & Rate'Image(s.xabs) &
         " square = " & Rate'Image(s.square) &
         " var = " & Rate'Image(s.var);
   end To_String;
   

   type Augmented_Quantile is record
      index         : Positive;
      position      : Positive;
      income        : Rate;
      population    : Rate;
      log           : Rate    := 0.0;
      income_accum  : Rate := 0.0;
      popn_accum    : Rate := 0.0;
      growth        : Rate   := 0.0;
   end record;
   
   function To_String( q : Augmented_Quantile ) return String is
   begin
      return
         " income = " & Rate'Image(q.income) &
         " population = " & Rate'Image(q.population) &
         " log = " & Rate'Image(q.log) &
         " index = " & Integer'Image(q.index) &
         " income_accum = " & Rate'Image(q.income_accum) &
         " popn_accum = " & Rate'Image(q.popn_accum) &
         " growth = " & Rate'Image(q.growth);
   end To_String;
   
   package Augmented_Quantile_Package is new Ada.Containers.Vectors( Element_Type => Augmented_Quantile, Index_Type => Positive );
   -- Ordering function for two points, return true if point_2 is
   -- to the right of point_2, or they have the same x but point_2 is above.  
   -- 
   subtype Augmented_Quantile_List is Augmented_Quantile_Package.Vector;
   
   function Compare_Quantile_By_Log_Share( q_1, q_2 : Augmented_Quantile ) return Boolean is
   begin
      return ( q_1.log < q_2.log );
   end Compare_Quantile_By_Log_Share;

   function Compare_Aug_Quantile_Income( q_1, q_2 : Augmented_Quantile ) return Boolean is
   begin
      return ( q_1.income < q_2.income );
   end Compare_Aug_Quantile_Income;
   
   function Compare_Quantile_By_Income( q_1, q_2 : Quantile ) return Boolean is
   begin
      return (q_1.income < q_2.income);
   end Compare_Quantile_By_Income;
   
   package Log_Sorter is new Augmented_Quantile_Package.Generic_Sorting( "<" => Compare_Quantile_By_Log_Share ); 
   package Aug_Income_Sorter is new Augmented_Quantile_Package.Generic_Sorting( "<" => Compare_Aug_Quantile_Income ); 
   package Quant_Sorter is new Quantile_Package.Generic_Sorting( "<" => Compare_Quantile_By_Income );
   
   function Rank_By_Income( quantiles : Quantile_List ) return Rank_List is
      r : Rank_List;
      q    : Quantile;
      aq   : Augmented_Quantile;
      aq_list : Augmented_Quantile_List;
      num_quantiles    : constant Positive := Positive(Quantile_Package.Length( quantiles ));
      rank : Ranking_Rec;
      cumulative_population : Amount := 0.0;
   begin
      r.Set_Length( quantiles.Length );
      for p in 1 .. num_quantiles loop
         q := quantiles.element( p );
         aq.income := Rate( q.income );
         aq.population := Rate( q.population );
         -- not needed aq.log := Log( aq.income/aq.population );
         aq.index := q.index;
         aq.position := p;
         Assert( aq.income > 0.0, 
            "negative or zero income found " & Rate'Image( aq.income ) & " for obs " & Positive'Image( p ));
         Assert( aq.population > 0.0, 
            "negative or zero population found " & Rate'Image( aq.population ) & " for obs " & Positive'Image( p ));
         if( p = 1 ) then
            aq.income_accum := aq.income;
            aq.popn_accum := aq.population;
         end if;
         aq_list.append( aq );
      end loop;
      Aug_Income_Sorter.Sort( aq_list );
      for p in 1 .. num_quantiles loop
         aq := aq_list.Element( p );
         rank.index := aq.index;
         rank.rank  := p;
         rank.cumulative_population := cumulative_population;
         r.Replace_Element( aq.position, rank );
         cumulative_population := cumulative_population + Amount( aq.population );
      end loop;
      return r;    
   end Rank_By_Income;
   
   procedure Sort_By_Income( quantiles : in out Quantile_List ) is
   begin
       Quant_Sorter.sort( quantiles );
   end Sort_By_Income;
   
   
   function Binify( quantiles : Quantile_List; num_bins : Positive )  return Quantile_List is
      out_bins : Quantile_List;
      total_population : Amount := 0.0;
      total_income : Amount := 0.0;
      bin_size : Amount;
      cumulative_income     : Amount := 0.0;
      cumulative_population : Amount := 0.0;
      n    : constant Positive := Positive(Quantile_Package.Length( quantiles ));
      q    : Quantile;
      out_q : Quantile;
      bin_limit : Amount := 0.0;      
   begin
      for p in 1 .. n loop
         q := Quantile_Package.element( quantiles, p );
         total_population := total_population + q.population;
         total_income := total_income + q.income;
      end loop;
      bin_size := total_population / Amount( num_bins );
      bin_limit := bin_size;
      for p in 1 .. n-1 loop
         q := Quantile_Package.element( quantiles, p );
         cumulative_income := cumulative_income + q.income;
         cumulative_population := cumulative_population + q.population;
         if( cumulative_population > bin_limit ) then
            bin_limit := bin_limit + bin_size;
            out_q.income := cumulative_income;
            out_q.population := cumulative_population;
            Quantile_Package.append( out_bins, out_q );
         end if;
      end loop;
      Quantile_Package.append( out_bins, ( index=>n, population=>total_population, income=>total_income ));
      return out_bins;
   end Binify;
   
   --
   -- Generate all the strange inequality measures in the list above.
   --
   function Generate( 
      quantiles : Quantile_List;
      incomes_are_pre_weighted  : Boolean := True;
      allow_non_positive_values : Boolean := True ) return Inequality_Array is
      
      package Math is new Ada.Numerics.Generic_Elementary_Functions( Rate );      
      use Math;
      use Ada.Numerics;
      use Ada.Text_IO;
      
      MAX_ITERATIONS : constant := 1000;
      
      sum  : Sum_Components;
      ineq : Inequality_Array := ( others=>0.0 );
      num_quantiles    : constant Positive := Positive(Quantile_Package.Length( quantiles ));
      p    : Natural := 0;
      aq   : Augmented_Quantile;
      last_aq : Augmented_Quantile;
      q    : Quantile;
      aq_list : Augmented_Quantile_List;
      x    : Rate;
      theil_swapped : Rate;
      kli  : Rate;
      dkli : Rate := 1.0;
      pareto : Rate;
      half_popn : Rate;
      sorted_quantiles : Quantile_List;
      sum_income     : Amount := 0.0;
      non_positives_found : Boolean := False;
   begin
      Assert( num_quantiles >= 2, "must have at least 2 observations" );
      if( not incomes_are_pre_weighted )then
         for p in 1 .. num_quantiles loop
            q := quantiles.element( p );
            q.income :=  q.income * q.population;
            Put_Line( p'Img &  q.population'Img & q.income'Img );
            sorted_quantiles.Append( q );
         end loop;
      else
         sorted_quantiles := quantiles;
      end if;
      Quant_Sorter.sort( sorted_quantiles );
      for p in 1 .. num_quantiles loop
         q := sorted_quantiles.element( p );
         aq.income := Rate( q.income );
         sum_income := sum_income + q.income;
         aq.population := Rate( q.population );
         Assert( aq.income > 0.0 or allow_non_positive_values, 
            "negative or zero income found " & Rate'Image( aq.income ) & " for obs " & Positive'Image( p ));
         if( aq.income <= 0.0 )then
            non_positives_found := True;
         else
            aq.log := Log( aq.income/aq.population );
         end if;
         aq.index := p;
         Assert( aq.population > 0.0, 
            "negative or zero population found " & Rate'Image( aq.population ) & " for obs " & Positive'Image( p ));
         aq_list.append( aq );
      end loop;
      Put_Line( "total income " & total_income'Img );
      Log_Sorter.Sort( aq_list );
      
      for p in 1 .. num_quantiles loop 
         aq := Augmented_Quantile_Package.element( aq_list, p );
         if( p = 1 )then
            aq.income_accum := aq.income;
            aq.popn_accum := aq.population;
         else
            last_aq := Augmented_Quantile_Package.element( aq_list, p-1 );
            aq.popn_accum := last_aq.popn_accum + aq.population;
            aq.income_accum := last_aq.income_accum + aq.income;
            aq.growth := exp( aq.log - last_aq.log );
         end if;
         aq_list.Replace_Element( p, aq );
      end loop;
      --
      -- todo deviation .. percentile 95
      --
      sum.income := aq.income_accum;
      sum.population := aq.popn_accum;
      ineq( Total_Population ) := sum.population;
      ineq( Total_Income )     := sum.income;
      
      for p in 1 .. num_quantiles loop
         aq := Augmented_Quantile_Package.element( aq_list, p );
         x := (((aq.income/aq.population)-(sum.income/sum.population))**2)*(aq.population/sum.population);
         sum.var := sum.var + x; 
         x := abs(aq.income/sum.income - aq.population/sum.population);
         sum.xabs := sum.xabs + x;
         sum.square := sum.square + x*x;
         sum.logxa := sum.logxa + ( aq.log * aq.population );
         sum.logxe := sum.logxe + ( aq.log * aq.income );
         sum.lorenz := sum.lorenz + ( (aq.income_accum * 2.0) - aq.income ) * aq.population;
      end loop;
      Assert( sum.population > 0.0, 
            "negative or zero sum.population found " & Rate'Image( sum.population ));
      Assert( sum.income > 0.0, 
            "negative or zero sum.income found " & Rate'Image( sum.income ));
      
      x := log( sum.population ) - log( sum.income );
      if( not non_positives_found )then
         ineq( theil_redundancy ) := sum.logxe / sum.income + x;
         theil_swapped := -1.0 * ( sum.logxa / sum.population ) - x;
         ineq( kullback_leibler_redundancy ) := ( ineq( theil_redundancy ) + theil_swapped ) / 2.0;
         ineq( macrae_inequality ) := exp( -1.0 * ineq( theil_redundancy ));
         ineq( atkinson_inequality ) := 1.0 - ineq( macrae_inequality );
         ineq( kullback_leibler_inequality ) := 1.0 - exp( -1.0 * ineq( kullback_leibler_redundancy ));
      end if;
      ineq( hoover_inequality ) := sum.xabs / 2.0;
      ineq( gini ) := 1.0 - ( sum.lorenz/sum.income ) / sum.population;
      ineq( europe_equality ) := ( 1.0 - ineq( gini )) / ( 1.0 + ineq( gini ));
      ineq (europe_inequality ) := ( 1.0 - ineq( europe_equality ));
         
      ineq( coulter_inequality ) := sqrt( sum.square / 2.0 );
      ineq( williamson_variation ) := sqrt( sum.var ) * sum.population / sum.income;
      -- compute platon inequality
      if( not non_positives_found )then
         kli := ineq( kullback_leibler_inequality );
         dkli := 1.0;
         ineq( platon_inequality ) := -9999999.99;
         p := 0;
         while (( abs( dkli ) > 0.00001 ) and ( kli < 1.0 ) and ( p < max_iterations )) loop
            declare
               omkli : rate := 1.0 - kli;
            begin
               if( omkli > -1.0 ) and ( omkli < 1.0 )then -- keep arcsin in range
                  pareto := arcsin(( omkli ) ** (( kli * 0.06 ) + 0.61 )) / pi;
                  dkli := 0.0;
                  if( pareto > 0.0 ) then
                     ineq( platon_inequality ) := 1.0 - ( 2.0 * pareto );
                     dkli := ( 1.0 / pareto - 1.0 )**( -1.0 * ineq( platon_inequality )) - 1.0 + ineq( kullback_leibler_inequality );
                     if( ineq( platon_inequality ) > 0.97 ) then
                        dkli := dkli / 10.0;
                     end if;
                  end if;
                  kli := kli + dkli;
               end if;
            end;
            p := p + 1;
         end loop;
      end if; -- no negatives
      ineq( mean ) := ( sum.income / sum.population );
      -- aug_income_sorter.sort( aq_list ); 
      half_popn :=  sum.population/2.0;
      
      for p in 2 .. num_quantiles loop
         aq := augmented_quantile_package.element( aq_list, p );
         last_aq := augmented_quantile_package.element( aq_list, p-1 );
         if( aq.popn_accum >= half_popn )then
            if(( num_quantiles mod 2 ) = 0 )then
               ineq( median ) := ( aq.income + last_aq.income ) / ( aq.population + last_aq.population ); 
            else
               ineq( median ) := aq.income / aq.population;
            end if;
            exit;
         end if;
      end loop;
      if( non_positives_found )then
         ineq( Negative_Warning ) := 1.0;
      end if;
      return ineq;
   end Generate;
   
   --
   
   function To_String( ineq : Inequality_Array ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String := To_Unbounded_String( "Inequality Measures" & LINE_BREAK );
   begin
      for i in Measures loop
         s := s & Measures'Image(i);
         s := s & TAB;
         if( i < Median )then
            s := s & f.Format( ineq(i) * 100.0 );
            s := s & "%";
         else
            s := s & Rate'Image( ineq(i) );
         end if;            
         s := s & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( quant : Quantile ) return String is
   begin
      return " population=" &  Amount'Image(quant.population) & " income="&  Amount'Image(quant.income);
   end To_String;
   
   procedure Dump_All_Quantiles( filename : String; quantiles : Quantile_List ) is
      use Ada.Text_IO;
      f : File_Type;
      num_quantiles    : constant Positive := Positive(Quantile_Package.Length( quantiles ));
      q : Quantile;
   begin
      Create( f, Out_File, filename );
      for p in 1 .. num_quantiles loop
         q := quantiles.element( p );
         Put_Line( f, Amount'Image( q.population ) & "," & Amount'Image( q.income ));
      end loop;
      Close( f );
   end Dump_All_Quantiles;
      
end Inequality_Generator;
