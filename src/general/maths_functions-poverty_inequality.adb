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
                             
   function Binify( 
      quantiles : Quantile_Array; 
      num_bins : Positive ) return Quantile_Array is
      outa : Quantile_Array( 1 .. num_bins );
   begin
      return outa;
   end Binify;

   
end Maths_Functions.Poverty_Inequality;