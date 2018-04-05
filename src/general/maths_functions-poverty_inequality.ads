pragma License( Modified_GPL );

with Statistics_Commons;
with Ada.Containers.Generic_Array_Sort;
with Ada.Unchecked_Deallocation;

generic package Maths_Functions.Poverty_Inequality is

   use Statistics_Commons;

   type Summary_Array is array( Simple_Measures ) of Real;
   
   type Quantile is record
      index  : Positive := Positive'First;
      income : Real := 0.0;
      weight : Real := 1.0;
   end record;
   
   function To_String( q : Quantile ) return String;
   
   -- type Ranking_Rec is record
      -- index : Positive;
      -- rank  : Positive;
      -- cumulative_weight : REAL;
   -- end record;
   -- 
   type Quantile_Array is array( Positive range <> ) of Quantile;
   

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
      headcount              : Real := 0.0;
      gap                    : Real := 0.0;
      foster_greer_thorndyke : Vector( 0 .. 4 ) := ( others => 0.0 );    
      sen                    : Real := 0.0;
      shorrocks              : Real := 0.0;
      watts                  : Real := 0.0;
      time_to_exit           : Real := 0.0;
      gini_amongst_poor      : Real := 0.0;
      poverty_gap_gini       : Real := 0.0;
   end record;
   
   function To_String( pr : Poverty_Rec ) return String;
   
   type Poverty_Rec_Array is array( Positive range <> ) of Poverty_Rec;
   
   type Inequality_Rec is record
      theil                        : Vector( 1 .. 2 ) := ( others => 0.0 );
      generalised_entropy          : Vector( 1 .. 12 ) := ( others => 0.0 );
      atkinson                     : Vector( 1 .. 5 ) := ( others => 0.0 );
      gini                         : Real := 0.0;
      hoover                       : Real := 0.0;
      zero_or_negative_income_flag : Boolean := False;
   end record;

   function To_String( ir : Inequality_Rec ) return String;
   
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
      income          : Real := 0.0;
      weighted_income : Real := 0.0;
      weight          : Real := 0.0; 
      log             : Real := 0.0;
      income_accum    : Real := 0.0;
      popn_accum      : Real := 0.0;
      growth          : Real := 0.0;
   end record;

   function To_String( aq : Augmented_Quantile ) return String;
   
   -- type Ranking_Array is array( Positive range <> ) of Ranking_Rec;
   type Augmented_Quantile_Array is array( Positive range <> ) of Augmented_Quantile;
   
   --
   -- ina most be sorted using Quantile_Sort above
   -- 
   procedure To_Augmented_Quantile_Array( 
      ina : in Quantile_Array; 
      outa : out Augmented_Quantile_Array );  

   
   function Lower_Income( left, right : Augmented_Quantile ) return Boolean;
   
   procedure Augmented_Quantile_Sort is new Ada.Containers.Generic_Array_Sort(
      Index_Type   => Positive,
      Element_Type => Augmented_Quantile,
      Array_Type   => Augmented_Quantile_Array,
      "<"          => Lower_Income );

   type Augmented_Quantile_Array_Access is access Augmented_Quantile_Array;
   procedure Free_Dataset is new Ada.Unchecked_Deallocation(
      Object => Augmented_Quantile_Array, Name => Augmented_Quantile_Array_Access );
   
   function Make_Summary( qa : Augmented_Quantile_Array ) return Summary_Array;
   
   function Make_All_Below_Line( 
      ina    : Augmented_Quantile_Array;
      line   : Real ) return Augmented_Quantile_Array;
      
   --
   -- growth should be (e.g.) 0.01 for 10% growth
   --
   function Make_Poverty( 
      ina    : Augmented_Quantile_Array; 
      line   : Real;
      growth : Real := 0.0 ) return Poverty_Rec;
      
   function Make_Inequality( 
      ina    : Augmented_Quantile_Array; 
      summary : Summary_Array ) return Inequality_Rec;
      
end  Maths_Functions.Poverty_Inequality;