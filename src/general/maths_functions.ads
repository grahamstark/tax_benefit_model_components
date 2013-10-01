pragma License( Modified_GPL );

with Random_Normal_Draw;
with Ada.Numerics.Generic_Real_Arrays;
with Ada.Numerics.Generic_Elementary_Functions;
--
-- Some handy maths functions. Although this is generic on the float-type, for the normal and inverse-normal
-- internally all the calculations are jammed on as double-precision floats.
--
generic
   
   type Real is digits<>;
   
package Maths_Functions is
   
   package Random_Normal_Generator is new Random_Normal_Draw( Real );
   
   function Random_0_To_1 return Real;
   
   package Matrix_Functions is new Ada.Numerics.Generic_Real_Arrays( Real => Real );
   subtype Matrix is Matrix_Functions.Real_Matrix;
   subtype Vector is Matrix_Functions.Real_Vector;
   
   function To_String( m : Matrix ) return String;
   function To_String( v : Vector ) return String;
   
   function Extract_Row( m : Matrix; row : Integer ) return Vector;
   function Extract_Col( m : Matrix; col : Integer ) return Vector;
   procedure Set_Row( m : in out Matrix; row : Integer; v : Vector );
   procedure Set_Col( m : in out Matrix; col : Integer; v : Vector );
   function Sum( v : Vector ) return Real;
   
   package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions( Float_Type => Real );
    
   -- from Delphi implementation from
   -- http://home.online.no/~pjacklam/notes/invnorm/impl/mccormick/icnorm.pas
   -- p must be >= 0.0 and =< 1.0
   function Inverse_Cumulative_Normal( p : Real ) return Real;
   
   function Truncate_To( r : Real; prec : Natural ) return Real;
   

   -- From a Java version by Steve Verrill
   -- see: http://www1.fpl.fs.fed.us/covnorm.code.html
   function Cumulative_Normal( x : Real ) return Real;

   

   -- evaluated against a random threshold with mean 0.5 and uniform distrubution if use_random_threshold is true,
   -- otherwise against 0.5
   function Evaluate_Probit( 
      v                    : Real; 
      use_random_threshold : Boolean := False ) return Boolean;

   -- evaluate against a variable threshold 
   -- if add random component, a random normal (0,1) is added to v
   -- 
   function Evaluate_Probit( 
      v                    : Real; 
      threshold            : Real;
      add_random_component : Boolean := False ) return Boolean;
   
      
   type Eval_Error_Type  is ( normal, underflow, iterations_exceeded );
   --
   -- Adapted from from Press, Flannery et. al pp307 -
   -- tolx - converged if summed absolute variable increments are < this
   -- tolf - converged if summed absolute function values are < this
  generic 
    with procedure Evaluate(  
          inputs               : in  Vector;
          hessian              : out Matrix;
          gradient             : out Vector );
          
    procedure Solve_Non_Linear_Equation_System( 
      x          : in out Vector;
      num_trials : Natural; 
      tolx       : Real; 
      tolf       : Real;
      iterations : out Natural;
      error      : out Eval_Error_Type );
 
   procedure Do_Debug( onoff : Boolean );
      
private      

   function Debug return Boolean;
      
end Maths_Functions;
