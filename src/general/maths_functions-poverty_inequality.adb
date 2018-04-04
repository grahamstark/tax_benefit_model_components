pragma License( Modified_GPL );

with Ada.Assertions;
with Ada.Text_IO;
with GNATColl.Traces;
with Ada.Strings.Unbounded;
with Text_Utils;

package body Maths_Functions.Poverty_Inequality is
   
   use Elementary_Functions;
   use Ada.Assertions;
   use Ada.Text_IO;
   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   package IIO is new Ada.Text_IO.Integer_IO( Integer );
   
   function FN( r : Real; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
      FIO.Put( s, r, 6, 0 );
      return s;
   end FN;

   function FN( i : Integer; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
      IIO.Put( s, i );
      return s;
   end FN;

   function F10( i : Integer ) return String is
   begin
      return FN( i, 10 );
   end F10;
   
   function F10( r : Real ) return String is
   begin
      return FN( r, 10 );
   end F10;
    
   function To_String( q : Quantile ) return String is
      s : Unbounded_String;
   begin
      s := s & "index           = " & F10( q.index ) & ";" & LINE_BREAK;
      s := s & "income          = " & F10( q.income ) & ";" & LINE_BREAK;
      s := s & "weight          = " & F10( q.weight ) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
  
   function To_String( aq : Augmented_Quantile ) return String is
      s : Unbounded_String;
   begin
      s := s & "index           = " & F10( aq.index ) & ";" & LINE_BREAK;
      s := s & "income          = " & F10( aq.income ) & ";" & LINE_BREAK;
      s := s & "weighted_income = " & F10( aq.weighted_income ) & ";" & LINE_BREAK;
      s := s & "weight          = " & F10( aq.weight ) & ";" & LINE_BREAK;
      s := s & "log             = " & F10( aq.log ) & ";" & LINE_BREAK;
      s := s & "income_accum    = " & F10( aq.income_accum ) & ";" & LINE_BREAK;
      s := s & "popn_accum      = " & F10( aq.popn_accum ) & ";" & LINE_BREAK;
      s := s & "growth%         = " & F10( 100.0*(aq.growth-1.0)) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
   
   function To_String( pr : Poverty_Rec ) return String is
      s : Unbounded_String;
   begin
      s := s & "headcount = " & F10( pr.headcount ) & ";" & LINE_BREAK;
      s := s & "gap = " & F10( pr.gap ) & ";" & LINE_BREAK;
      for i in 0 .. 4 loop
         s := s & "foster_greer_thorndyke[ " & i'Img & " ] = " & F10( pr.foster_greer_thorndyke( i )) & ";" & LINE_BREAK;
      end loop;
      s := s & "sen = " & F10( pr.sen ) & ";" & LINE_BREAK;
      s := s & "shorrocks = " & F10( pr.shorrocks ) & ";" & LINE_BREAK;
      s := s & "watts = " & F10( pr.watts ) & ";" & LINE_BREAK;
      s := s & "gini_amongst_poor = " & F10( pr.gini_amongst_poor ) & ";" & LINE_BREAK;
      s := s & "poverty_gap_gini = " & F10( pr.poverty_gap_gini ) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
   
   function To_String( ir : Inequality_Rec ) return String is
      s : Unbounded_String;
   begin
      for i in ir.theil'Range loop
         s := s & "theil["&i'Img & " ] = " & F10( ir.theil(i)) & ";" & LINE_BREAK;
      end loop;
      for i in ir.atkinson'Range loop
         s := s & "atkinson["&i'Img & " ] = " & F10( ir.atkinson(i)) & ";" & LINE_BREAK;
      end loop;
      s := s & "gini = " & F10( ir.gini ) & ";" & LINE_BREAK;
      s := s & "hoover = " & F10( ir.hoover ) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
   
 
   
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
         Put_Line( "a.income_accum " & F10( a.income_accum ) & 
                   " a.weighted_income " & F10( a.weighted_income ));
         Inc( lorenz, a.weight*(2.0*a.income_accum - a.weighted_income) );
      end loop;       
      Put_Line( "lorenz " & F10( lorenz ) & 
                " lasta.income_accum " & F10( lasta.income_accum ) &
                "lasta.popn_accum " & F10( lasta.popn_accum ));
      return 1.0 - ( lorenz/lasta.income_accum ) / lasta.popn_accum;
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
      growth : Real := 0.0 ) return Poverty_Rec is
      pov_rec           : Poverty_Rec;
      gap               : Real;
      below_line        : Augmented_Quantile_Array := Make_All_Below_Line( ina, line );
   use Elementary_Functions;    
      population        : constant Real := ina( ina'Last ).popn_accum;
      total_income      : constant Real := ina( ina'Last ).income_accum;
   begin
      pov_rec.gini_amongst_poor := Make_Gini( below_line );
      for a of below_line loop
         gap := line - a.income; 
         Assert( gap > 0.0, "Gap should always be positive " );
         Inc( pov_rec.headcount, a.weight );
         Inc( pov_rec.gap, a.weight * gap/line );
         Put_Line( "watts add " & F10( log( line/a.income )));
         Inc( pov_rec.watts, a.weight*log( line/a.income ));
         for p in 0 .. 4 loop
            Inc( pov_rec.foster_greer_thorndyke( p ), a.weight*((gap/line)**p ));
         end loop;
      end loop;
      
      pov_rec.watts := pov_rec.watts/population; 
      
      if growth > 0.0 then -- no point otherwise ..
         pov_rec.time_to_exit := pov_rec.watts/(1.0+growth );   
      end if;
      pov_rec.headcount := pov_rec.headcount/population;      
      pov_rec.gap := pov_rec.gap / population;
      
      for p in pov_rec.foster_greer_thorndyke'Range loop
         pov_rec.foster_greer_thorndyke( p ) := pov_rec.foster_greer_thorndyke( p )/population; 
      end loop;
      
      Assert( Nearly_Equal( pov_rec.foster_greer_thorndyke( 0 ), pov_rec.headcount ), 
         "mismatch hc/fgt(0) " &  pov_rec.foster_greer_thorndyke( 0 )'Img & " vs " &
         pov_rec.headcount'Img );
      Assert( Nearly_Equal( pov_rec.foster_greer_thorndyke( 1 ), pov_rec.gap ), 
         "mismatch hc/fgt(0) " &  pov_rec.foster_greer_thorndyke( 1 )'Img & " vs " &
         pov_rec.gap'Img );

      --
      -- Gini of poverty gaps; see: WB pp 74-5
      -- FIXME: actually simpler to use quantile and then make aug. version
      declare
         ci : Real := 0.0;
         cp : Real := 0.0;
         data_for_gap_gini : Augmented_Quantile_Array := ina;
      begin
         for dg of data_for_gap_gini loop
            gap := line - dg.income;
            if gap < 0.0 then 
               gap := 0.0; 
            end if;
            dg.income := gap;
         end loop;
         Augmented_Quantile_Sort( data_for_gap_gini );
         for dg of data_for_gap_gini loop            
            dg.weighted_income := dg.income * dg.weight;
            Inc( ci, dg.weighted_income );
            Inc( cp, dg.weight );
            dg.income_accum := ci;
            dg.popn_accum := cp;
         end loop;
         pov_rec.poverty_gap_gini := Make_Gini( data_for_gap_gini );
      end;
         
      declare
         gp : Real renames pov_rec.poverty_gap_gini;
         g  : Real renames pov_rec.gini_amongst_poor;
         p0 : Real renames pov_rec.headcount;
         p1 : Real renames pov_rec.gap;
      begin
         pov_rec.sen := p0*g + p1*(1.0-g);
         pov_rec.shorrocks := p0*p1*(1.0+gp);
      end;
         
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