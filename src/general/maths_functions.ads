pragma License( Modified_GPL );

with Random_Normal_Draw;
with Ada.Numerics.Generic_Real_Arrays;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Direct_IO;
with Ada.Text_IO;
with Maths_Functions_Commons;
--
-- Some handy maths functions. Although this is generic on the float-type, for the normal and inverse-normal
-- internally all the calculations are jammed on as double-precision floats.
--
generic
   
   type Real is digits<>;
   
package Maths_Functions is
   
   use Maths_Functions_Commons;
   
   package Random_Normal_Generator is new Random_Normal_Draw( Real );

   subtype Prob is Real range 0.0 .. 1.0;
   subtype Odds is Real range 0.0 .. 1.0;

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

   function Normal_PDF( x : Real; mean : Real; standard_deviation : Real ) return Real;
   function Standard_Normal_PDF( x : Real ) return Real;
      
   type Eval_Error_Type  is ( normal, underflow, iterations_exceeded );
   --
   -- Adapted from from Press, Flannery et. al pp307 -
   -- tolx - converged if summed absolute variable increments are < this
   -- tolf - converged if summed absolute function values are < this

   package DIO is new Ada.Direct_IO( Real );
   package FIO is new Ada.Text_IO.Float_IO( Real );
   
   function To_String( r : Real; width : Positive := 12; prec : Positive := 2 ) return String;
   
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
      
   --
   -- extend a dataset by taking the growth between final and last_period 
   -- and using that from the final obs
   --
   function Extrapolate( 
      v            : Vector;
      length       : Positive;
      last_period  : Positive := 1 ) return Vector;
   --
   -- make an array periods long interpolating between two values
   -- v1 - 1st value
   -- v2 - final value
   -- v2_v1_distance e.g. 10 years 
   -- periods array will be this long, starting from 1
   -- method - LINEAR/EXPONENTIAL (exp is very rough for small nos of periods)
   -- return vector( 1 .. periods ) 
   --
   function Interpolate( 
      v1             : Real; 
      v2_v1_distance : Positive;
      v2             : Real; 
      periods        : Positive; 
      method         : Interpolation_Method ) return Vector;
      
   procedure Do_Debug( onoff : Boolean );
      
private      

   function Debug return Boolean;
      
end Maths_Functions;
