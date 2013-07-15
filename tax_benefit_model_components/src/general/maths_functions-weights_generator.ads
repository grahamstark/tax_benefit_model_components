pragma License( Modified_GPL );

with Weighting_Commons;

generic
   
   Num_Constraints  : Positive;
   Num_Observations : Positive;
   
package Maths_Functions.Weights_Generator is
   
   use Weighting_Commons;
   
   --
   -- Implements the weighting procedures from 
   -- Creedy 2003 http://www.treasury.govt.nz/publications/research-policy/wp/2003/03-17/twp03-17.pdf
   -- Jean-Claude Deville and Carl-Erik Sarndal http://www.jstor.org/stable/2290268
   -- 
   
   subtype Row_Range is Positive range 1 .. Num_Constraints;
   subtype Col_Range is Positive range 1 .. Num_Observations;
   
   subtype Row_Vector is Vector( Row_Range );
   subtype Col_Vector is Vector( Col_Range );
   
   subtype Dataset is Matrix( Col_Range, Row_Range );
   
   -- 
   -- data : KxJ matrix where k is num observations and J is num constraints;
   -- see:
   -- Microdata Adjustment by the Minimum Information Loss Principle Joachim Merz; FFB Discussion Paper No. 10 July 1994
   -- for a good discussion on how to lay out the dataset
   -- 
   -- intial_weights, new_weights : K length vector
   -- target_populations - J length vector;
   --
   -- tolx, tolf, max_iterations : see Solve_Non_Linear_Equation_System in the parent
   -- ru/rl max/min acceptable values of ratio of final_weight/initial_weight (for constrained distance functions)
   --
   -- note: chi-square is just there for checking purposes; use Do_Basic_Reweighting if that's all you need.
   -- 
   procedure Do_Reweighting(
      data               : in Dataset;
      which_function     : in Distance_Function_Type;
      initial_weights    : in Col_Vector;
      target_populations : in Row_Vector;
      tolx               : in Real;
      tolf               : in Real;
      max_iterations     : in Positive;
      ru                 : in Real;
      rl                 : in Real;
      new_weights        : out Col_Vector;
      iterations         : out Natural;
      error              : out Eval_Error_Type );

    --
    -- Very basic "Chi-Square" type with no checking for negatives
    -- from Creedy 2003  http://www.business.curtin.edu.au/files/creedy2.pdf
    -- data should be arranged as in Creedy's example table 1 n categories x m observations
    -- initial_weights - m length vector
    -- target_populations - n length vector
    -- returns - m length vector (i.e. a weight for each observation such that sum data * weight = target_population
    --           and the sum of squares of (initial_weights - weights) is minimised. NOTE THESE WEIGHTS CAN BE NEGATIVE
   function Do_Basic_Reweighting(
      data               : Dataset;
      initial_weights    : Col_Vector;
      target_populations : Row_Vector ) return Vector;

   procedure Do_Debug( onoff : Boolean );
  
private
      
   subtype Hessian_Matrix is Matrix( Row_Range, Row_Range );
      
   -- testing only      
   procedure Evaluate_Function_And_Hessian( 
      data               : in Dataset;
      lambdas            : in Row_Vector;
      which_function     : Distance_Function_Type;
      initial_weights    : in Col_Vector;
      target_populations : in Row_Vector;
      ru                 : Real;
      rl                 : Real;
      f_lambdas          : out Row_Vector;
      hessian            : out Hessian_Matrix );

end  Maths_Functions.Weights_Generator;
