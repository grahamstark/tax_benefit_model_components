with Regression_Commons;

--
-- copyrigh(c) 2013 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
generic

package Maths_Functions.Regressions is

   use Regression_Commons;

   type Regression_Control_Rec( regtype : Regression_Type ) is record
      se_type       : Standard_Error_Type := uncorrected;
      add_constant  : Boolean := True;
      case regtype is
         when OLS    => null;
         when Probit | Logit =>
	          num_trials : Natural := 100;
                  tolx       : Real := 0.000001;
                  tolf       : Real := 0.000001;
      end case;
   end record;

   type Regression_Result( num_obs : Positive; num_regressors : Positive; regtype : Regression_Type ) is record
     b                            : Vector( 1 .. num_regressors ) := ( others => 0.0 );
     standard_error_of_regression : Real := 0.0;
     b_standard_errors            : Vector( 1 .. num_regressors ) := ( others => 0.0 );
     t_0                          : Vector( 1 .. num_regressors ) := ( others => 0.0 );
     e                            : Vector( 1 .. num_obs )  := ( others => 0.0 );
     covariance_matrix            : Matrix( 1 .. num_regressors, 1 .. num_regressors ) := ( others => ( others => 0.0 ));
     ess                          : Real := 0.0;
     rss                          : Real := 0.0;
     tss                          : Real := 0.0;
     r2                           : Real := 0.0;
     rb2                          : Real := 0.0;
     mean_of_dependent            : Real := 0.0;
     df                           : Positive := Positive'First;
     log_likelihood               : Real := 0.0;
     case regtype is
         when OLS    => null;
         when Probit | Logit =>
	    iterations : Natural := 0;
            iteration_error : Eval_Error_Type := Eval_Error_Type'First;
     end case;
   end record;

   function OLS( settings : Regression_Control_Rec; x : Matrix; y : Vector ) return Regression_Result;
   function OLS( settings : Regression_Control_Rec; x : Vector; y : Vector ) return Regression_Result;
   function Logit_Or_Probit( settings : Regression_Control_Rec; x : Vector; y : Vector ) return Regression_Result;
   function Logit_Or_Probit( settings : Regression_Control_Rec; x : Matrix; y : Vector ) return Regression_Result;

   function To_String( rr : Regression_Result ) return String;

end Maths_Functions.Regressions;
