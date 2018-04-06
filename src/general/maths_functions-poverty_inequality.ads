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
      
   
   subtype Decile is Quantile_Array( 1 .. 10 );
   subtype Quintile is Quantile_Array( 1 .. 5 );
   
   DEFAULT_FGT_ALPHAS : constant Vector( 1 .. 6 ) := ( 0.0, 0.50, 1.0, 1.50, 2.0, 2.5 );
   
   type Poverty_Rec( num_foster_greer_thorndyke_alphas : Positive ) is tagged record
      headcount                     : Real := 0.0;
      gap                           : Real := 0.0;
      foster_greer_thorndyke_alphas : Vector( 1 .. num_foster_greer_thorndyke_alphas );
      foster_greer_thorndyke        : Vector( 1 .. num_foster_greer_thorndyke_alphas ) := ( others => 0.0 );    
      sen                           : Real := 0.0;
      shorrocks                     : Real := 0.0;
      watts                         : Real := 0.0;
      time_to_exit                  : Real := 0.0;
      gini_amongst_poor             : Real := 0.0;
      poverty_gap_gini              : Real := 0.0;
   end record;
   
   function Construct( 
      foster_greer_thorndyke_alphas : Vector := DEFAULT_FGT_ALPHAS ) return Poverty_Rec;
   
   function To_String( pr : Poverty_Rec ) return String;
   
   function Nearly_Equal( p1:Poverty_Rec; p2 : Poverty_Rec'Class )return Boolean;
   
   function Make_Poverty( 
      ina                           : Augmented_Quantile_Array; 
      line                          : Real;
      growth                        : Real := 0.0;
      foster_greer_thorndyke_alphas : Vector := DEFAULT_FGT_ALPHAS ) return Poverty_Rec;
      
   --
   -- TODO some sort of class or something that allows proper initialising 
   -- of  the coefficients of atk and ge measures
   -- or make these <e><i> Maps
   -- 
   type Inequality_Rec( num_atkinsons : Positive; num_entropies : Positive ) is tagged record
      theil                        : Vector( 0 .. 1 ) := ( others => 0.0 );
      generalised_entropy_alphas   : Vector( 1 .. num_entropies );
      generalised_entropy          : Vector( 1 .. num_entropies ) := ( others => 0.0 );
      atkinson_es                  : Vector( 1 .. num_atkinsons );
      atkinson                     : Vector( 1 .. num_atkinsons ) := ( others => 0.0 );
      gini                         : Real := 0.0;
      hoover                       : Real := 0.0;
      zero_or_negative_income_flag : Boolean := False;
   end record;
   
   DEFAULT_ENTROPIES : constant Vector( 1 .. 6 ) := ( 1.25, 1.50, 1.75, 2.0, 2.25, 2.50 );
   DEFAULT_ATKINSONS : constant Vector( 1 .. 9 ) := ( 0.25, 0.50, 0.75, 1.0, 1.25, 1.50, 1.75, 2.0, 2.25 );
   
   function Construct( 
      atkinson_es                : Vector := DEFAULT_ATKINSONS;  
      generalised_entropy_alphas : Vector := DEFAULT_ENTROPIES ) return Inequality_Rec;

   function Nearly_Equal( p1: Inequality_Rec; p2 : Inequality_Rec'Class )return Boolean;
   
   --
   -- growth should be (e.g.) 0.01 for 10% growth
   --
   function Make_Inequality( 
      ina                        : Augmented_Quantile_Array; 
      atkinson_es                : Vector := DEFAULT_ATKINSONS;  
      generalised_entropy_alphas : Vector := DEFAULT_ENTROPIES ) return Inequality_Rec;
   

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
   
   
   
   function Make_Summary( qa : Augmented_Quantile_Array ) return Summary_Array;
   
   function Make_All_Below_Line( 
      ina    : Augmented_Quantile_Array;
      line   : Real ) return Augmented_Quantile_Array;
      
      
end  Maths_Functions.Poverty_Inequality;