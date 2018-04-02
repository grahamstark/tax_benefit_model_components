pragma License( Modified_GPL );

with Ada.Assertions;
with Ada.Text_IO;
with GNATColl.Traces;

package body Maths_Functions.Poverty_Inequality is
   
   use Elementary_Functions;
   use Ada.Assertions;
   use Ada.Text_IO;
   

   function Lower_Income( left, right : Quantile ) return Boolean is
   begin
      return left.income < right.income;
   end Lower_Income;
   
   function Lower_Income( left, right : Augmented_Quantile ) return Boolean is
   begin
      return left.income < right.income;
   end Lower_Income;
   

   procedure To_Augmented_Quantile_Array( 
      ina : Quantile_Array; 
      outa : out Augmented_Quantile_Array ) is
      cumulative_population : Real := 0.0;
      ina : Quantile;
   begin
      Assert( ina'Length = outa'Length, "array size mismatch " );
      for i in ina'Range loop
         outa( i ).income := ina( i ).income;
         outa( i ).population := ina( i ).population;
         Inc( cumulative_population, ina( i ).population );
         Inc( cumulative_income, ina( i ).income );
         outa( i ).popn_accum := cumulative_population;
         outa( i ).income_accum := cumulative_income;
         outa( i ).log := Log( ina( i ).income( i )/ina( i ).population( i ));
         if i > 1 then
            Assert( ina( i ).income >= ina( i -1 ).income, "incomes out of seq at " & i'Img ); 
            outa( i ).growth := exp( ina( i ).log - ina( i - 1 ).log );
         end if;
      end loop;
   end To_Augmented_Quantile_Array;  
   
   
   function Gini( 
      ina    : Quantile_Array ) return Real is
      g : Real;
   begin
      return g;
   end Gini; 
   
   function Make_All_Below_Line( 
      ina    : Quantile_Array;
      line   : Real ) return Quantile_Array is
         n  : Natural := 0;
   begin
      for a of ina loop
         if a.income < line then
            n := n + 1;
         end if;
      end loop;
      declare
         outa : Quantile_Array( 1 .. n );
         i : Natural := 0;
      begin
         for a of ina loop
            if a.income < line then
               i := i + 1;
               outa[i] := a;
            end if;
         end loop;
         return a;
      end;
   end Make_All_Below_Line;
       
      
   function Make_Poverty( 
      ina    : Quantile_Array; 
      line   : Real;
      growth : Real ) return Inequality_Rec is
      last_a : Quantile;
   begin
      for a in ina loop
         if a.income <= line then
            null;
         end if;
      end loop;
   end Make_Poverty;
                             
   function Binify( 
      quantiles : Quantile_Array; 
      num_bins : Positive ) return Quantile_Array is
      outa              : Quantile_Array( 1 .. num_bins );
      total_income      : Real := 0.0;
      cumulative_income : Real := 0.0;
      total_population  : Real := 0.0;
      rnb               : constant Real := Real( num_bins );
   begin
      for q of quantiles loop
         Inc( total_income, q.income );
         Inc( total_population, q.population );
      end loop;
      declare
         bin_size              : constant Real := total_population / rnb;
         bin_limit             : Real := bin_size;
         p                     : Positive := 1;
         cumulative_income     : Real := 0.0;
         cumulative_population : Real := 0.0;
      begin
         for q of quantiles loop
            Inc( cumulative_income, q.income );
            Inc( cumulative_population, q.population );
            if cumulative_population > bin_limit then
               outa( p ).income := cumulative_income;
               outa( p ).population := cumulative_population;
               Inc( bin_limit, bin_size );
               p := p + 1;
            end if;
         end loop;
      end;
      return outa;
   end Binify;
   
   
   
   

   
end Maths_Functions.Poverty_Inequality;