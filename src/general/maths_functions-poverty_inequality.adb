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
                             
   function Binify( 
      quantiles : Quantile_Array; 
      num_bins : Positive ) return Quantile_Array is
      outa : Quantile_Array( 1 .. num_bins );
      total_income : Real := 0.0;
      cumulative_income : Real := 0.0;
      total_population : Real := 0.0;
   begin
      for q of quantiles loop
         Inc( total_income, q.income );
         Inc( total_population, q.population );
      end loop;
      declare
         rnb       : Real := Real( num_bins );
         bin_size  : constant Real := total_population / rnb;
         bin_limit : Real := bin_size;
         p         : Positive := 1;
         cumulative_income : Real := 0.0;
         cumulative_population : Real := 0.0;
      begin
         for q of quantiles loop
            Inc( cumulative_income, q.income );
            Inc( cumulative_population, q.population );
            if cumulative_population > bin_limit then
               outa( p ).income := cumulative_income;
               outa( p ).population := cumulative_populaton;
               Inc( bin_limit, bin_size );
               p := p + 1;
            end if;
         end loop;
      end;
      return outa;
   end Binify;

   
end Maths_Functions.Poverty_Inequality;