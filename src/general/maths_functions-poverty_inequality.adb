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
   

   function Make_Summary( qa : Augmented_Quantile_Array ) return Summary_Array is
      v       : Summary_Array;
      last_qa : Augmented_Quantile;
      i       : Positive := 1;
      sum     : Real := 0.0;
      popn    : Real := 0.0;
      popn_sq : Real := 0.0;      
   begin
      for a of qa loop
         if i > 1 then
            Assert( a.income >= last_qa.income, "array not sorted at position " & i'Img );
         end if;
         Inc( sum, a.weighted_income );
         Inc( popn, a.weight );
         Inc( popn_sq, a.weight**2 );
         last_qa := a;
         i := i + 1;
      end loop;
      v( effective_sample_size ) := popn_sq / ( popn**2 );
      for a of qa loop
         if ( a.popn_accum/popn) >= 0.5 then
            v( median ) := a.income;
            exit;
         end if;
      end loop;      
      v( maximum ) := qa( qa'Last ).income;
      v( minimum ) := qa( qa'First ).income;
      v( mean ) := sum/popn;
      v( observations ) := popn;
      for a of qa loop
         declare
            x : constant Real := a.weighted_income - v( mean );
         begin
            Inc( v( average_deviation ), x );
            Inc( v( variance ), x**2 );
            Inc( v( skewness ), x**3 );
            Inc( v( kurtosis ), x**4 );
         end;
      end loop;
      
      v( average_deviation ) := v( average_deviation )/popn;
      v( variance ) := v( variance )/(popn-1.0); -- CHECK THIS AGAIN: should it be popn - (mean weight)
      v( standard_deviation ) := sqrt( v( variance ));
      
      if v( variance ) /= 0.0 then -- NOTE THESE ARE POPULATION NOT SAMPLE; 
         v( skewness ) := v( skewness ) / ( popn * ( v( standard_deviation )**3 ));
         v( kurtosis ) := v( skewness ) / ( popn * ( v( standard_deviation )**4 ) - 3.0);
      end if;
      return v;
   end Make_Summary;

   procedure To_Augmented_Quantile_Array( 
      ina : in Quantile_Array; 
      outa : out Augmented_Quantile_Array ) is
      cumulative_weight : Real := 0.0;
      cumulative_income : Real := 0.0;
   begin
      Assert( ina'Length = outa'Length, "array size mismatch " );
      for i in ina'Range loop
         outa( i ).index := i;
         outa( i ).income := ina( i ).income;
         outa( i ).weight := ina( i ).weight;
         outa( i ).weighted_income := ina( i ).weight * ina( i ).income;
         Inc( cumulative_weight, ina( i ).weight );
         Inc( cumulative_income, outa( i ).weighted_income );
         outa( i ).popn_accum := cumulative_weight;
         outa( i ).income_accum := cumulative_income;
         -- fixme do we need this?
         outa( i ).log := Log( ina( i ).income/ina( i ).weight );
         if i > 1 then
            Assert( ina( i ).income >= ina( i -1 ).income, "incomes out of seq at " & i'Img ); 
            outa( i ).growth := exp( outa( i ).log - outa( i - 1 ).log );
         end if;
      end loop;
   end To_Augmented_Quantile_Array;  
   
   
   function Make_Gini( 
      ina    : Augmented_Quantile_Array ) return Real is
      lorenz : Real := 0.0;
      lasta  : constant Augmented_Quantile := ina( ina'Last );
   begin
      for a of ina loop
         Inc( lorenz, ( 2.0*a.income_accum - a.weighted_income );
      end loop;      
      return 1.0 - ( lorenz/lasta.cumulative_income ) / lasta.pop_accum;
   end Make_Gini; 
   
   function Make_All_Below_Line( 
      ina    : Augmented_Quantile_Array;
      line   : Real ) return Augmented_Quantile_Array is
         n  : Natural := 0;
   begin
      for a of ina loop
         if a.income < line then
            n := n + 1;
         end if;
      end loop;
      declare
         outa : Augmented_Quantile_Array( 1 .. n );
         i : Natural := 0;
      begin
         for a of ina loop
            if a.income < line then
               i := i + 1;
               outa(i) := a;
            end if;
         end loop;
         return outa;
      end;
    end Make_All_Below_Line;
       
      
   function Make_Poverty( 
      ina    : Augmented_Quantile_Array; 
      line   : Real;
      growth : Real ) return Poverty_Rec is
      last_a : Augmented_Quantile;
      pov_rec : Poverty_Rec;
      gap  : Real;
      below_line : Augmented_Quantile_Array := Make_All_Below_Line( ina, line );
      gini_amongst_poor : Real := Make_Gini( below_line );
   begin
      for a of below_line loop
         gap := line - a.income; 
         Assert( gap > 0.0, "Gap should always be positive " );
         Inc( pov_rec.headcount, a.weight );
         Inc( pov_rec.gap, a.weight * gap );
         for p in 0 .. 4 loop
            Inc( pov_rec.foster_greer_thorndyke( p+1 ), a.weight*(gap**p ));
         end loop;
      end loop;
      Assert( Nearly_Equal( pov_rec.foster_greer_thorndyke( 1 ), pov_rec.headcount ), 
         "mismatch hc/fgt(0) " &  pov_rec.foster_greer_thorndyke( 1 )'Img & " vs " &
         pov_rec.headcount'Img );
      Assert( Nearly_Equal( pov_rec.foster_greer_thorndyke( 2 ), pov_rec.gap ), 
         "mismatch hc/fgt(0) " &  pov_rec.foster_greer_thorndyke( 2 )'Img & " vs " &
         pov_rec.gap'Img );
         
      return pov_rec;
   end Make_Poverty;
                             
   function Binify( 
      quantiles : Quantile_Array; 
      num_bins : Positive ) return Quantile_Array is
      outa              : Quantile_Array( 1 .. num_bins );
      total_income      : Real := 0.0;
      cumulative_income : Real := 0.0;
      total_weight  : Real := 0.0;
      rnb               : constant Real := Real( num_bins );
   begin
      for q of quantiles loop
         Inc( total_income, q.income );
         Inc( total_weight, q.weight );
      end loop;
      declare
         bin_size              : constant Real := total_weight / rnb;
         bin_limit             : Real := bin_size;
         p                     : Positive := 1;
         cumulative_income     : Real := 0.0;
         cumulative_weight : Real := 0.0;
      begin
         for q of quantiles loop
            Inc( cumulative_income, q.income );
            Inc( cumulative_weight, q.weight );
            if cumulative_weight > bin_limit then
               outa( p ).income := cumulative_income;
               outa( p ).weight := cumulative_weight;
               Inc( bin_limit, bin_size );
               p := p + 1;
            end if;
         end loop;
      end;
      return outa;
   end Binify;
   
   
   
   

   
end Maths_Functions.Poverty_Inequality;