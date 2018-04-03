pragma License( Modified_GPL );

with Statistics_Commons;
with Ada.Containers.Generic_Array_Sort;
with Ada.Unchecked_Deallocation;

generic
   
   Num_Observations : Positive;
   
package Maths_Functions.Poverty_Inequality is

   use Statistics_Commons;

   subtype Row_Range is Positive range 1 .. Num_Observations;
   
   type Summary_Array is array( Simple_Measures ) of Real;
   
   type Quantile is record
      index  : Positive := Positive'First;
      income : Real;
      weight : Real;
   end record;
   
   -- type Ranking_Rec is record
      -- index : Positive;
      -- rank  : Positive;
      -- cumulative_weight : REAL;
   -- end record;
   -- 
   type Quantile_Array is array( Positive range <> ) of Quantile;

   function Make_Summary( qa : Quantile_Array ) return Summary_Array; 
   
   
   
   subtype Array_For_Ginis is Quantile_Array( 1 .. 100 );
   
   function Lower_Income( left, right : Quantile ) return Boolean;

   procedure Quantile_Sort is new Ada.Containers.Generic_Array_Sort(
      Index_Type   => Positive,
      Element_Type => Quantile,
      Array_Type   => Quantile_Array,
      "<"          => Lower_Income );

   type Quantile_Array_Access is access Quantile_Array;
   procedure Free_Dataset is new Ada.Unchecked_Deallocation(
      Object => Quantile_Array, Name => Quantile_Array_Access );
         
      
   
   subtype Decile is Quantile_Array( 1 .. 10 );
   subtype Quintile is Quantile_Array( 1 .. 5 );
   
   type Poverty_Rec is record
      headcount              : Real;
      foster_greer_thorndyke : Vector( 1 .. 5 );    
      sen                    : Real;
      shorrocks              : Real;
      watts                  : Real;
      time_to_exit           : Real;
   end record;
   
   type Poverty_Rec_Array is array( Positive range <> ) of Poverty_Rec;
   
   type Inequality_Rec is record
      thiel                  : Vector( 1 .. 3 );
      atkinson               : Vector( 1 .. 5 );
      gini                   : Real;
      hoover                 : Real;
   end record;
   
   type Summary_Rec is record
      summary                : Summary_Array; 
      deciles                : Decile;
      quintiles              : Quintile;
      gini_data              : Array_For_Ginis;
   end record;
      
      
   function Binify( 
      quantiles : Quantile_Array; 
      num_bins : Positive ) return Quantile_Array;
   
   
   type Augmented_Quantile is record
      index           : Positive;
      position        : Positive;
      income          : Real;
      weighted_income : Real;
      weight          : Real; -- the population/total_population
      population      : Real;
      log             : Real := 0.0;
      income_accum    : Real := 0.0;
      popn_accum      : Real := 0.0;
      growth          : Real := 0.0;
   end record;
   
   -- type Ranking_Array is array( Positive range <> ) of Ranking_Rec;
   type Augmented_Quantile_Array is array( Positive range <> ) of Augmented_Quantile;
   
   procedure To_Augmented_Quantile_Array( ina : Quantile_Array; outa : out Augmented_Quantile_Array );  

   
   function Lower_Income( left, right : Augmented_Quantile ) return Boolean;
   
   procedure Augmented_Quantile_Sort is new Ada.Containers.Generic_Array_Sort(
      Index_Type   => Positive,
      Element_Type => Augmented_Quantile,
      Array_Type   => Augmented_Quantile_Array,
      "<"          => Lower_Income );

   type Augmented_Quantile_Array_Access is access Augmented_Quantile_Array;
   procedure Free_Dataset is new Ada.Unchecked_Deallocation(
      Object => Augmented_Quantile_Array, Name => Augmented_Quantile_Array_Access );
    
end  Maths_Functions.Poverty_Inequality;