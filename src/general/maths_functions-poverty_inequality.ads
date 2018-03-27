pragma License( Modified_GPL );

with Poverty_Inequality_Commons;
with Ada.Containers.Generic_Array_Sort;

generic
   
   Num_Observations : Positive;
   
package Maths_Functions.Poverty_Inequality is

   use Poverty_Inequality_Commons;

   subtype Row_Range is Positive range 1 .. Num_Observations;
   
   type Summary_Array is array( Measures ) of Real;
   
   type Quantile is record
      index      : Positive := Positive'First;
      income     : Real;
      population : Real;
   end record;
   
   type Ranking_Rec is record
      index : Positive;
      rank  : Positive;
      cumulative_population : REAL;
   end record;
   
   type Quantile_Array is array( Positive range <> ) of Quantile;
   
   subtype Array_For_Ginis is Quantile_Array( 1 .. 100 );
   
   function Lower_Income( left, right : Quantile ) return Boolean;

   procedure QSort is new Ada.Containers.Generic_Array_Sort(
      Index_Type   => Positive,
      Element_Type => Quantile,
      Array_Type   => Quantile_Array,
      "<"          => Lower_Income );

   
   subtype Decile is Quantile_Array( 1 .. 10 );
   subtype Quintile is Quantile_Array( 1 .. 5 );
   
   type Poverty_Inequality_Rec is record
      thiel                  : Vector( 1 .. 3 );
      atkinson               : Vector( 1 .. 5 );
      gini                   : Real;
      hoover                 : Real;
      summary                : Summary_Array; 
      hbai                   : Vector( 1 .. 5 );
      absolute_poverty       : Real;
      foster_greer_thorndyke : Vector( 1 .. 5 );
      deciles                : Decile;
      quintiles              : Quintile;
      gini_data              : Array_For_Ginis;
   end record;
   
private   
   
   function Binify( 
      quantiles : Quantile_Array; 
      num_bins : Positive ) return Quantile_Array;
   
   type Ranking_Array is array( Positive range <> ) of Ranking_Rec;
    
end  Maths_Functions.Poverty_Inequality;

