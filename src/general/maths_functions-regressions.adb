with Ada.Direct_IO;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Text_Utils;
with Ada.Unchecked_Deallocation;
with Ada.Assertions;

--
-- copyright(c) 2013 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
--
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
--
-- This is a specialised table for displaying costs of (e.g.) taxes or benefits broken down by something. It's really simple.
--
--
-- Very basic OLS, Probit and Logit functions, mainly so I can keep up
-- with my students. References in the body text are to
-- Greene "Econometric Analysis" 2nd Edition; Prentice-Hall 1990.
--

package body Maths_Functions.Regressions is

   package IIO is new Ada.Text_IO.Integer_IO( Integer );
   use Ada.Assertions;
   use Matrix_Functions;

   function Add_Vector_Of_Ones_To( m : Matrix ) return Matrix is
     num_rows : constant Positive := m'Last( 1 );
     num_cols : constant Positive := m'Last( 2 ) + 1;
     nm : Matrix( 1 .. num_rows, 1 .. num_cols );
   begin
     for row in 1 .. num_rows loop
        nm( row, 1 ) := 1.0;
        for col in 2 .. num_cols loop
           nm( row, col ) := m( row, col-1 );
        end loop;
     end loop;
     return nm;
   end  Add_Vector_Of_Ones_To;

   function One_D_Matrix( v : Vector ) return Matrix is
     num_cols : constant Positive := 1;
     num_rows : constant Positive := v'Last;
     nm : Matrix( 1 .. num_rows, 1 .. num_cols );
   begin
     for row in 1 .. num_rows loop
        nm( row, 1 ) := v( row );
     end loop;
     return nm;
   end One_D_Matrix;

   function Add_Vector_Of_Ones_To( v : Vector ) return Matrix is
     num_cols : constant Positive := 2;
     num_rows : constant Positive := v'Last;
     nm : Matrix( 1 .. num_rows, 1 .. num_cols );
   begin
     for row in 1 .. num_rows loop
        nm( row, 1 ) := 1.0;
        nm( row, 2 ) := v( row );
     end loop;
     return nm;
   end  Add_Vector_Of_Ones_To;

   function M_Matrix( x : Matrix ) return Matrix is
      nr  : constant Positive := x'Last( 1 );
      nc  : constant Positive := x'Last( 2 );
      i   : constant Matrix := Unit_Matrix( nr, nr );
      xpx : constant Matrix := Transpose( x ) * x;
   begin
      return i - x*Inverse( xpx ) * Transpose( x );
   end M_Matrix;

   procedure Make_Unit_Matrix( m : in out Matrix ) is
   begin
     for row in m'Range( 1 ) loop
        for col in m'Range( 2 ) loop
           if( row = col )then
              m( row, col ) := 1.0;
           else
              m( row, col ) := 0.0;
           end if;
        end loop;
     end loop;
   end Make_Unit_Matrix;

   -- prototype of version with allocated matrices. Really, we need
   -- sparse matrices here.
   procedure Local_OLS_Big( x : Matrix; y : Vector; rr : in out Regression_Result ) is
      use Elementary_Functions;
      nr   : constant Positive := x'Last( 1 );
      nc   : constant Positive := x'Last( 2 );
      subtype MX is Matrix( 1..nr, 1..nr );
      type MXA is access MX;
      procedure Free is new Ada.Unchecked_Deallocation(
               Object => MX, Name => MXA );
      i    : MXA;
      m    : MXA;
      xpx  : constant Matrix := Transpose( x ) * x;
      xpxi : constant Matrix := Inverse( xpx );
   begin
      i    := new MX;
      m    := new MX;
      Make_Unit_Matrix( i.all );
      m.all  := i.all - x * xpxi * Transpose( x );
      rr.b   := Inverse( xpx ) * Transpose( x ) * y;
      rr.e   := m.all * y;
      rr.df  := nr - nc;
      rr.ess := rr.e * rr.e;
      rr.standard_error_of_regression := sqrt(rr.ess/Real( rr.df ));
      rr.covariance_matrix := (rr.ess/Real( rr.df )) * xpxi;
      for col in 1 .. nc loop
	rr.b_standard_errors( col ) := sqrt( rr.covariance_matrix( col, col ));
        rr.t_0( col ) := rr.b( col )/rr.b_standard_errors( col );
      end loop;
      Free( i );
      Free( m );
   end Local_OLS_Big;

   procedure Local_OLS( settings : Regression_Control_Rec; x : Matrix; y : Vector; rr : in out Regression_Result ) is
      use Elementary_Functions;
      nr   : constant Positive := x'Last( 1 );
      rnr  : constant Real := Real( nr );
      nc   : constant Positive := x'Last( 2 );
      rnc  : constant Real := Real( nc );
      i    : constant Matrix := Unit_Matrix( nr, nr );
      xpx  : constant Matrix := Transpose( x ) * x;
      xpxi : constant Matrix := Inverse( xpx );
      m    : constant Matrix := i - x * xpxi * Transpose( x );
      unit_vector : constant Vector( 1 .. nr ) := ( others => 1.0 );
   begin
      rr.mean_of_dependent := y * unit_vector / rnr;
      rr.b   := Inverse( xpx ) * Transpose( x ) * y;
      rr.e   := m * y;
      rr.df  := nr - nc;
      rr.rss := rr.b * Transpose( x ) * y - ( rnr*rr.mean_of_dependent**2 );
      rr.ess := rr.e * rr.e;
      rr.tss := y*y - rnr*rr.mean_of_dependent**2;
      -- assert tss ~= ess+rss
      rr.r2  := rr.rss / rr.tss;
      --
      rr.rb2 := (1.0 - ((( rnr-1.0 )/( rnr - rnc )) * ( 1.0 - rr.r2 )));
      -- p185  eq 6-28
      rr.standard_error_of_regression := sqrt(rr.ess/Real( rr.df ));
      if( settings.se_type in Robust_Standard_Errors )then
         -- eq 14-7 p390-391
         declare
            s0 : Matrix( 1 .. nc, 1 .. nc ) := ( others => ( others => 0.0 ));
         begin
            for row in 1 .. nr loop
               declare
                  x_v : Vector := Extract_Row( x, row );
                  xx : Matrix := x_v*x_v;
               begin
                  s0 := s0 + ((rr.e( row ) ** 2) * xx);
               end;
            end loop;
            -- type '0' as in Green's book, uncorrected for num regressors
	    rr.covariance_matrix := xpxi * s0 * xpxi;
            -- type '1' correct for degrees of freedom
            if( settings.se_type = hc1 )then
               declare
	          df_correction : constant Real := ( rnr / ( rnr - rnc ));
               begin
	          rr.covariance_matrix :=  df_correction * rr.covariance_matrix;
               end;
            end if;
            -- there's also a type 2 and 3 I don't understand
         end;
      else
         rr.covariance_matrix := (rr.ess/Real( rr.df )) * xpxi;
      end if;
      for col in 1 .. nc loop
        rr.b_standard_errors( col ) := sqrt( rr.covariance_matrix( col, col ));
        rr.t_0( col ) := rr.b( col )/rr.b_standard_errors( col );
      end loop;
   end Local_OLS;

   function FN( r : Real; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
	FIO.Put(s, r, 6, 0 );
        return s;
   end FN;

   function FN( i : Integer; n : Positive ) return String is
      s : String( 1 .. n ) := ( others => ' ' );
   begin
	IIO.Put(s, i );
        return s;
   end FN;

   function F5( i : Integer ) return String is
   begin
      return FN( i, 5 );
   end F5;

   function F10( i : Integer ) return String is
   begin
      return FN( i, 10 );
   end F10;

   function F10( r : Real ) return String is
   begin
      return FN( r, 10 );
   end F10;

   function F20( r : Real ) return String is
   begin
      return FN( r, 20 );
   end F20;

   function To_String( rr : Regression_Result ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;
      rn  : constant Real := Real( rr.num_obs );
      rk  : constant Real := Real( rr.num_regressors );
      dfr : constant Positive := rr.num_regressors - 1;
      dfe : constant Positive := rr.num_obs - rr.num_regressors;
      dft : constant Positive := rr.num_obs - 1;
      msr : constant Real := rr.rss / Real( dfr );
      mse : constant Real := rr.ess / Real( dfe );
      mst : constant Real := rr.tss / Real( dft );
   begin
      s := s & "Num Observations             :" & rr.num_obs'Img & LINE_BREAK;
      s := s & "Num Regressors               :" & rr.num_regressors'Img & LINE_BREAK;
      s := s & "Mean of Dependent            :" & F20( rr.mean_of_dependent ) & LINE_BREAK;
      s := s & "Degrees of Freedom           :" & rr.df'Img & LINE_BREAK;
      if( rr.regtype = OLS )then
         s := s & "Error Sum of Squares         : " & F20( rr.ess ) & LINE_BREAK;
         s := s & "Standard Error of Regression : " & F20( rr.standard_error_of_regression ) & LINE_BREAK;
      end if;
      s := s & "      COEFFICIENT         STANDARD ERROR        T-STAT" & LINE_BREAK;
      s := s & "-----------------------------------------------------------" & LINE_BREAK;
      for i in rr.b'Range loop
         s := s & F20( rr.b( i )) & F20( rr.b_standard_errors( i )) & F20( rr.t_0( i )) & LINE_BREAK;
      end loop;
      if( rr.regtype = OLS )then
         s := s & LINE_BREAK;
         s := s & "Analysis of Variance " & LINE_BREAK;
         s := s & "                         SOURCE       DF   MEAN SQUARE" & LINE_BREAK;
         s := s & "-----------------------------------------------------------" & LINE_BREAK;
         s := s & "Regression :" & F20( rr.rss ) & "   " & F5( dfr ) & F20( msr ) & LINE_BREAK;
         s := s & "Error      :" & F20( rr.ess ) & "   " & F5( dfe ) & F20( mse ) & LINE_BREAK;
         s := s & "Total      :" & F20( rr.tss ) & "   " & F5( dft ) & F20( mst ) & LINE_BREAK;
         s := s & "-----------------------------------------------------------" & LINE_BREAK;
         s := s & "R^2           :" & F20( rr.r2 ) & LINE_BREAK;
         s := s & "Corrected R^2 :" & F20( rr.rb2 ) & LINE_BREAK;
      else
         s := s & "Log-Likelihood :" & F20( rr.log_likelihood ) & LINE_BREAK;
      end if;
      s := s & LINE_BREAK;
      s := s & "Covariance Matrix " & LINE_BREAK;
      for i in rr.covariance_matrix'Range( 1 ) loop
	 for j in rr.covariance_matrix'Range( 2 ) loop
             if( i <= j )then
                s := s & F20( rr.covariance_matrix( i, j ));
             else
                s := s & "                    ";
             end if;
         end loop;
         s := s & LINE_BREAK;
      end loop;
      s := s & LINE_BREAK;
      return To_String( s );
   end To_String;

   function OLS( settings : Regression_Control_Rec; x : Matrix; y : Vector ) return Regression_Result is
       cx           : constant Matrix := ( if settings.add_constant then Add_Vector_Of_Ones_To( x ) else x );
       n_obs        : constant Positive := cx'Last( 1 );
       n_regressors : constant Positive := cx'Last( 2 );
       rr           : Regression_Result( n_obs, n_regressors, ols );
   begin
      Local_OLS( settings, cx, y, rr );
      return rr;
   end OLS;

   function OLS( settings : Regression_Control_Rec; x : Vector; y : Vector ) return Regression_Result is
     cx    : constant Matrix :=
        ( if( settings.add_constant )then
	     Add_Vector_Of_Ones_To( x )
          else
             One_D_Matrix( x ));
     n_obs : constant Positive := cx'Last( 1 );
     rr    : Regression_Result( n_obs, 2, ols );
   begin
      Local_OLS( settings, cx, y, rr );
      return rr;
   end OLS;

   function Logit( beta : Vector; x : Vector ) return Real is
   use Elementary_Functions;
     bx : constant Real := beta * x;
   begin
     return Exp( bx ) / ( 1.0 + Exp( bx ));
   end Logit;

   procedure Evaluate_First_Deriv_And_Hessian_Probit(
        settings       : in Regression_Control_Rec;
        betas          : in Vector;
        x              : in Matrix;
        y              : in Vector;
        gradients      : out Vector;
	hessian        : out Matrix;
        log_likelihood : out Real ) is
   use Elementary_Functions;
      nr   : constant Positive := x'Last( 1 );
   begin
      log_likelihood := 0.0;
      gradients := ( others => 0.0 );
      hessian := ( others => ( others => 0.0 ));
      for row in 1 .. nr loop
         Assert( y( row ) = 0.0 or y( row ) = 1.0, " Yi not 1 or 0; was : " & y( row )'Img );
         declare
            xr  : constant Vector := Extract_Row( x, row );
            bx  : constant Real := betas * xr;
            cdf : constant Real := Standard_Normal_PDF( bx );
            cn  : constant Real := Cumulative_Normal( bx );
            xx  : constant Matrix := xr * xr;
            yi  : constant Real := y( row );
            lambda : constant Real := (
               if yi = 0.0 then
                  -1.0 * cdf / ( 1.0 - cn )
               else
                  cdf / cn );
         begin
            if( yi = 1.0 )then
    	       log_likelihood := log_likelihood + Log( cn );
            else
    	       log_likelihood := log_likelihood + Log( 1.0 - cn );
            end if;
            gradients := gradients + lambda * xr;
            hessian := hessian + lambda*( lambda + bx ) * xx;
         end;
      end loop;
   end Evaluate_First_Deriv_And_Hessian_Probit;

   procedure Evaluate_First_Deriv_And_Hessian_Logit(
        settings     : in Regression_Control_Rec;
        betas        : in Vector;
        x            : in Matrix;
        y            : in Vector;
        gradients    : out Vector;
	hessian      : out Matrix;
        log_likelihood : out Real ) is
   use Elementary_Functions;
      nr   : constant Positive := x'Last( 1 );
   begin
      log_likelihood := 0.0;
      gradients := ( others => 0.0 );
      hessian := ( others => ( others => 0.0 ));
      for row in 1 .. nr loop
         declare
            xr : constant Vector := Extract_Row( x, row );
            ld : constant Real := Logit( betas, xr );
            xx : constant Matrix := xr * xr;
         begin
  	    log_likelihood := log_likelihood +
                 y( row )*Log( ld ) +
		( 1.0 - y( row ))*Log( 1.0 - ld );
            gradients := gradients + ( y( row ) - ld ) * xr;
            hessian := hessian + ( ld * (1.0 - ld) * xx );
         end;
      end loop;
   end Evaluate_First_Deriv_And_Hessian_Logit;

   procedure Local_Logit_Or_Probit(
	settings : Regression_Control_Rec;
        x        : Matrix;
        y        : Vector;
        rr       : in out Regression_Result ) is
      use Elementary_Functions;
      nr   : constant Positive := x'Last( 1 );
      rnr  : constant Real := Real( nr );
      nc   : constant Positive := x'Last( 2 );
      rnc  : constant Real := Real( nc );
      subtype Hessian_Matrix is Matrix( 1 .. nc, 1 .. nc );
      subtype Row_Vector is Vector( 1 .. nc );
      saved_hessian : Hessian_Matrix;

      procedure Local_Evaluate(
         betas         : in Row_Vector;
         hessian       : out Hessian_Matrix;
         gradient      : out Row_Vector ) is
      begin
         case settings.regtype is
         when logit =>
            Evaluate_First_Deriv_And_Hessian_Logit(
               settings, betas, x, y, gradient, hessian, rr.log_likelihood );
         when probit =>
            Evaluate_First_Deriv_And_Hessian_Probit(
               settings, betas, x, y, gradient, hessian, rr.log_likelihood );
         when others => null; -- exception ??
         end case;
         saved_hessian := hessian;
      end Local_Evaluate;

      procedure Solve is new Solve_Non_Linear_Equation_System( Evaluate=>Local_Evaluate );

   begin
      Solve( rr.b, settings.num_trials, settings.tolx, settings.tolf, rr.iterations, rr.iteration_error );
      if( rr.iteration_error = normal )then
	 rr.covariance_matrix := Inverse( saved_hessian );
         for col in 1 .. nc loop
            rr.b_standard_errors( col ) := sqrt( rr.covariance_matrix( col, col ));
            rr.t_0( col ) := rr.b( col )/rr.b_standard_errors( col );
         end loop;
      end if;
   end Local_Logit_Or_Probit;

   function Logit_Or_Probit(
      settings : Regression_Control_Rec;
      x : Vector;
      y : Vector ) return Regression_Result is
     cx    : constant Matrix :=
        ( if( settings.add_constant )then
	     Add_Vector_Of_Ones_To( x )
          else
             One_D_Matrix( x ));
     n_obs : constant Positive := cx'Last( 1 );
     rr    : Regression_Result( n_obs, 2, logit );
  begin
      Local_Logit_Or_Probit( settings, cx, y, rr );
      return rr;
   end Logit_Or_Probit;

   function Logit_Or_Probit(
      settings : Regression_Control_Rec;
      x : Matrix; y : Vector ) return Regression_Result is
     cx    : constant Matrix :=
        ( if( settings.add_constant )then
	     Add_Vector_Of_Ones_To( x )
          else
             x );
     n_obs : constant Positive := cx'Last( 1 );
     nc    : constant Positive := cx'Last( 2 );
     rr    : Regression_Result( n_obs, nc, logit );
   begin
      Local_Logit_Or_Probit( settings, cx, y, rr );
      return rr;
   end Logit_Or_Probit;

end Maths_Functions.Regressions;
