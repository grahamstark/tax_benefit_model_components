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
   
   function FN( r : Real; n : Positive; prec : Positive := 7 ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
      FIO.Put( s, r, prec, 0 );
      return s;
   end FN;

   function FN( i : Integer; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
      IIO.Put( s, i );
      return s;
   end FN;

   function FS( i : Integer ) return String is
      s : String := FN( i, 40 );
   begin
      return Text_Utils.Trim( s );
   end FS;
   
   function FS( r : Real ) return String is
      s : String := FN( r, 40 );
   begin
      return Text_Utils.Trim( s );
   end FS;
   

   function Nearly_Equal( i1: Inequality_Rec; i2 : Inequality_Rec'Class; tol : Real := 0.00001 )return Boolean is
   begin
      if i1.num_atkinsons /= i2.num_atkinsons then return false; end if;
      if i1.num_entropies /= i2.num_entropies then return false; end if;
      for i in 0 .. 1 loop
         if not Nearly_Equal( i1.theil(i), i2.theil(i), tol ) then return false; end if;
      end loop;
      -- Put_Line("#p1");
      for i in i1.generalised_entropy_alphas'Range loop
         if not Nearly_Equal( i1.generalised_entropy_alphas(i), i2.generalised_entropy_alphas(i), tol ) then return false; end if;
         if not Nearly_Equal( i1.generalised_entropy(i), i2.generalised_entropy(i), tol ) then return false; end if;
      end loop;
      -- Put_Line("#p2");
      
      for i in i1.atkinson_es'Range loop
         if not Nearly_Equal( i1.atkinson_es(i), i2.atkinson_es(i), tol ) then return false; end if;
         if not Nearly_Equal( i1.atkinson(i), i2.atkinson(i), tol ) then return false; end if;
      end loop;
      -- Put_Line("#p3");
      
      if not Nearly_Equal( i1.gini, i2.gini, tol ) then return false; end if;
      -- Put_Line("#p4");
      if not Nearly_Equal( i1.hoover, i2.hoover, tol ) then return false; end if;
      return true;
   end Nearly_Equal;
   
   function Nearly_Equal( p1:Poverty_Rec; p2 : Poverty_Rec'Class; tol : Real := 0.00001 )return Boolean is
   begin
      if p1.num_foster_greer_thorndyke_alphas /= p2.num_foster_greer_thorndyke_alphas then return false; end if;
      if not Nearly_Equal( p1.headcount, p2.headcount, tol ) then return false; end if;
      if not Nearly_Equal( p1.gap, p2.gap, tol ) then return false; end if;
      for i in p1.foster_greer_thorndyke_alphas'Range loop
         if not Nearly_Equal( p1.foster_greer_thorndyke_alphas(i), p2.foster_greer_thorndyke_alphas(i), tol ) then return false; end if;
         if not Nearly_Equal( p1.foster_greer_thorndyke(i), p2.foster_greer_thorndyke(i), tol ) then return false; end if;
      end loop;
      if not Nearly_Equal( p1.sen, p2.sen, tol ) then return false; end if;
      if not Nearly_Equal( p1.shorrocks, p2.shorrocks, tol ) then return false; end if;
      if not Nearly_Equal( p1.watts, p2.watts, tol ) then return false; end if;
      if not Nearly_Equal( p1.time_to_exit, p2.time_to_exit, tol ) then return false; end if;
      if not Nearly_Equal( p1.gini_amongst_poor, p2.gini_amongst_poor, tol ) then return false; end if;
      if not Nearly_Equal( p1.poverty_gap_gini, p2.poverty_gap_gini, tol ) then return false; end if;
      return true;
   end Nearly_Equal;
    
   function To_String( q : Quantile ) return String is
      s : Unbounded_String;
   begin
      s := s & "index           = " & FS( q.index ) & ";" & LINE_BREAK;
      s := s & "income          = " & FS( q.income ) & ";" & LINE_BREAK;
      s := s & "weight          = " & FS( q.weight ) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
  
   function To_String( aq : Augmented_Quantile ) return String is
      s : Unbounded_String;
   begin
      s := s & "index           = " & FS( aq.index ) & ";" & LINE_BREAK;
      s := s & "income          = " & FS( aq.income ) & ";" & LINE_BREAK;
      s := s & "weighted_income = " & FS( aq.weighted_income ) & ";" & LINE_BREAK;
      s := s & "weight          = " & FS( aq.weight ) & ";" & LINE_BREAK;
      s := s & "log             = " & FS( aq.log ) & ";" & LINE_BREAK;
      s := s & "income_accum    = " & FS( aq.income_accum ) & ";" & LINE_BREAK;
      s := s & "popn_accum      = " & FS( aq.popn_accum ) & ";" & LINE_BREAK;
      s := s & "growth%         = " & FS( 100.0*(aq.growth-1.0)) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
   
   function To_String( pr : Poverty_Rec ) return String is
      s : Unbounded_String;
   begin
      s := s & "headcount = " & FS( pr.headcount ) & ";" & LINE_BREAK;
      s := s & "gap = " & FS( pr.gap ) & ";" & LINE_BREAK;
      for p in pr.foster_greer_thorndyke_alphas'Range loop
         declare
            as : String := FN( pr.foster_greer_thorndyke_alphas( p ), 5, 2 );
         begin
            s := s & "foster_greer_thorndyke[" & as & " ] = " & FS( pr.foster_greer_thorndyke( p )) & ";" & LINE_BREAK;
         end;   
      end loop;
      s := s & "sen = " & FS( pr.sen ) & ";" & LINE_BREAK;
      s := s & "shorrocks = " & FS( pr.shorrocks ) & ";" & LINE_BREAK;
      s := s & "watts = " & FS( pr.watts ) & ";" & LINE_BREAK;
      s := s & "time_to_exit = " & FS( pr.time_to_exit ) & ";" & LINE_BREAK;
      s := s & "gini_amongst_poor = " & FS( pr.gini_amongst_poor ) & ";" & LINE_BREAK;
      s := s & "poverty_gap_gini = " & FS( pr.poverty_gap_gini ) & ";" & LINE_BREAK;
      return TS( s );
   end To_String;
   
   function To_String( ir : Inequality_Rec ) return String is
      s : Unbounded_String;
   begin
      s := s & "gini = " & FS( ir.gini ) & ";" & LINE_BREAK;
      s := s & "theil[0] L  = " & FS( ir.theil(0)) & ";" & LINE_BREAK;
      s := s & "theil[1] T  = " & FS( ir.theil(1)) & ";" & LINE_BREAK;
      for i in ir.generalised_entropy_alphas'Range loop
         declare
            ea : constant String := FN( ir.generalised_entropy_alphas( i ), 5, 2 );
         begin
            s := s & "generalised_entropy[" & ea & " ] = " & FS( ir.generalised_entropy(i)) & ";" & LINE_BREAK;
         end;
      end loop;
      for i in ir.atkinson_es'Range loop
         declare
            es : constant String := FN( ir.atkinson_es( i ), 5, 2 );
         begin
            s := s & "atkinson["& es & " ] = " & FS( ir.atkinson(i)) & ";" & LINE_BREAK;
         end;
      end loop;
      s := s & "hoover = " & FS( ir.hoover ) & ";" & LINE_BREAK;
      if ir.zero_or_negative_income_flag then
         s := s & "WARNING: zero or negative incomes encountered; Thiel indexes may be wrong " & LINE_BREAK;
      end if;
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
         -- outa( i ).log := Log( ina( i ).income/ina( i ).weight );
         if i > 1 then
            Assert( ina( i ).income >= ina( i -1 ).income, "incomes out of seq at " & i'Img ); 
            outa( i ).growth := exp( outa( i ).log - outa( i - 1 ).log );
         end if;
      end loop;
   end To_Augmented_Quantile_Array;  
   
   
   function Make_Gini( 
      ina    : Augmented_Quantile_Array ) return Real is
      lorenz : Real := 0.0;
      lasta  : Augmented_Quantile;
   begin
      if ina'Length <= 0 then
         return -1.0;
      end if;
      lasta := ina( ina'Last );
      for a of ina loop
         -- Put_Line( "a.income_accum " & FS( a.income_accum ) & 
                   -- " a.weighted_income " & FS( a.weighted_income ));
         Inc( lorenz, a.weight*(2.0*a.income_accum - a.weighted_income) );
      end loop;       
      -- Put_Line( "lorenz " & FS( lorenz ) & 
                -- " lasta.income_accum " & FS( lasta.income_accum ) &
                -- "lasta.popn_accum " & FS( lasta.popn_accum ));
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
      growth : Real := 0.0;
      foster_greer_thorndyke_alphas : Vector := DEFAULT_FGT_ALPHAS ) return Poverty_Rec is
      pov_rec           : Poverty_Rec := Construct( foster_greer_thorndyke_alphas );
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
         -- Put_Line( "watts add " & FS( log( line/a.income )));
         Inc( pov_rec.watts, a.weight*log( line/a.income ));
         for p in pov_rec.foster_greer_thorndyke_alphas'Range loop
            declare
               alpha : Real := pov_rec.foster_greer_thorndyke_alphas( p );
            begin
               Inc( pov_rec.foster_greer_thorndyke( p ), a.weight*((gap/line)**alpha ));
            end;
         end loop;
      end loop;
      
      pov_rec.watts := pov_rec.watts/population; 
      
      if growth > 0.0 then -- no point otherwise ..
         pov_rec.time_to_exit := pov_rec.watts/growth;   
      end if;
      pov_rec.headcount := pov_rec.headcount/population;      
      pov_rec.gap := pov_rec.gap / population;
      
      for p in pov_rec.foster_greer_thorndyke_alphas'Range loop
         pov_rec.foster_greer_thorndyke( p ) := pov_rec.foster_greer_thorndyke( p )/population; 
      end loop;
      
      -- just checking code -can delete?
      for p in pov_rec.foster_greer_thorndyke_alphas'Range loop
         declare
            alpha : Real := pov_rec.foster_greer_thorndyke_alphas( p );
         begin
            if alpha = 0.0 then
               Assert( Nearly_Equal( pov_rec.foster_greer_thorndyke( p ), pov_rec.headcount ), 
                  "mismatch hc/fgt(0) " &  pov_rec.foster_greer_thorndyke( p )'Img & " vs " &
                  pov_rec.headcount'Img );
            end if;
            if alpha = 1.0 then
               Assert( Nearly_Equal( pov_rec.foster_greer_thorndyke( p ), pov_rec.gap ), 
                  "mismatch hc/fgt(1) " &  pov_rec.foster_greer_thorndyke( p )'Img & " vs " &
                  pov_rec.gap'Img );
            end if;
         end;
      end loop;
      --
      -- Gini of poverty gaps; see: WB pp 74-5
      -- 
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
   
   function Make_Inequality( 
      ina                        : Augmented_Quantile_Array; 
      atkinson_es                : Vector := DEFAULT_ATKINSONS;  
      generalised_entropy_alphas : Vector := DEFAULT_ENTROPIES ) return Inequality_Rec is
         
      ineq_rec     : Inequality_Rec := Construct( atkinson_es, generalised_entropy_alphas );
      popn         : Real renames ina( ina'Last ).popn_accum;
      pop_div      : constant Real := 1.0/popn;      
      total_income : Real renames ina( ina'Last ).income_accum; 
      y_bar        : constant Real := total_income * pop_div;
   begin
      -- Put_Line( "y_bar " & FS( y_bar ));
      -- Put_Line( "popn " & FS( popn ));
      
      for i in ineq_rec.atkinson_es'Range loop
         if ineq_rec.atkinson_es( i ) /= 1.0 then 
            ineq_rec.atkinson( i ) := 0.0;
         else
            ineq_rec.atkinson( i ) := 1.0; 
         end if;
      end loop;
      
      ineq_rec.gini := Make_Gini( ina );                                      
      for a of ina loop
         
         if a.income > 0.0 then
            declare
               y_yb : constant Real := a.income/y_bar;
               yb_y : constant Real := y_bar/a.income;
               ln_y_yb : constant Real := Log( y_yb );
               ln_yb_y : constant Real := Log( yb_y );
            begin
               -- Put_Line( "income" & FS( a.income ));
               -- Put_Line( "weight " & FS( a.weight ));
               -- Put_Line( "y_yb " & FS( y_yb ));
               -- Put_Line( "yb_y " & FS( yb_y ));
               -- Put_Line( "ln_y_yb " & FS( ln_y_yb ));
               Inc( ineq_rec.hoover,  a.weight*abs( a.income-y_bar ));
               Inc( ineq_rec.theil( 0 ), a.weight*ln_yb_y );
               Inc( ineq_rec.theil( 1 ), a.weight*y_yb*ln_y_yb );
               for i in ineq_rec.atkinson_es'Range loop
                  declare
                     e : Real renames ineq_rec.atkinson_es( i );
                  begin
                     if e /= 1.0 then 
                        Inc( ineq_rec.atkinson( i ), a.weight*( y_yb )**( 1.0 - e ));
                     else
                        -- Put_Line( "ATK times " & FS( ( a.income )**( pop_div )));
                        ineq_rec.atkinson( i ) := ineq_rec.atkinson( i ) * (( a.income )**( a.weight*pop_div )); 
                     end if;
                  end;
               end loop;
               for i in ineq_rec.generalised_entropy_alphas'Range loop
                  declare
                     alpha : Real renames ineq_rec.generalised_entropy_alphas( i );
                  begin
                     -- Put_Line( "alpha " & FS( alpha ));
                     -- Put_Line( "( y_yb )**alpha)" & FS(( y_yb )**alpha));
                     Inc( ineq_rec.generalised_entropy( i ), a.weight*(( y_yb )**alpha) );
                  end;
               end loop;            
            end;
         else
            ineq_rec.zero_or_negative_income_flag := True;
         end if;
      end loop;
      ineq_rec.hoover := 0.5 * ineq_rec.hoover / total_income;
      for i in ineq_rec.generalised_entropy_alphas'Range loop
         declare
            alpha : Real renames ineq_rec.generalised_entropy_alphas( i );
         begin
            ineq_rec.generalised_entropy( i ) := 
               (1.0/(alpha*(alpha-1.0))) * (pop_div*ineq_rec.generalised_entropy( i ) - 1.0 );
         end;
      end loop;
                             
      for i in ineq_rec.atkinson_es'Range loop
         declare
            e : Real renames ineq_rec.atkinson_es( i );
         begin
            -- Put_Line( "ineq_rec.atkinson( i ) " & FS( ineq_rec.atkinson( i )));
            if e /= 1.0 then
               ineq_rec.atkinson( i ) := 1.0 - ( pop_div*ineq_rec.atkinson( i ))**(1.0/(1.0-e));
            else
               ineq_rec.atkinson( i ) := 1.0 - ( ineq_rec.atkinson( i ) / y_bar ); 
            end if;
         end;
      end loop;            
       
      ineq_rec.theil( 0 ) := ineq_rec.theil( 0 )*pop_div;
      ineq_rec.theil( 1 ) := ineq_rec.theil( 1 )*pop_div;

      return ineq_rec;
   end Make_Inequality;
                             
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
   
   
   function Construct( 
      atkinson_es : Vector := DEFAULT_ATKINSONS;  
      generalised_entropy_alphas : Vector := DEFAULT_ENTROPIES ) return Inequality_Rec is
      ir : Inequality_Rec( atkinson_es'Last, generalised_entropy_alphas'Last );
   begin
      ir.generalised_entropy_alphas := generalised_entropy_alphas;
      ir.atkinson_es := atkinson_es;
      return ir;      
   end Construct;
    
   function Construct( 
      foster_greer_thorndyke_alphas : Vector := DEFAULT_FGT_ALPHAS ) return Poverty_Rec is
      ip : Poverty_Rec( foster_greer_thorndyke_alphas'Last );
   begin
      ip.foster_greer_thorndyke_alphas := foster_greer_thorndyke_alphas;
      return ip;
   end Construct;
   

   
end Maths_Functions.Poverty_Inequality;