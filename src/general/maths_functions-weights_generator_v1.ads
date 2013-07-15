generic

package Maths_Functions.Weights_Generator is
   --
   -- Implements the weighting procedures from 
   -- Creedy 2003  http://www.business.curtin.edu.au/files/creedy2.pdf and
   -- Jean-Claude Deville and Carl-Erik Sarndal http://www.jstor.org/stable/2290268
   -- 
   
  
   --
   -- These are the distance function types from Creedy 2003 table 3, originally from Deville and Sarndal '92
   --
   type Distance_Function_Type is ( 
      chi_square, 
      constrained_chi_square, 
      d_and_s_type_a, 
      d_and_s_type_b, 
      d_and_s_constrained );

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
      data               : in Matrix;
      which_function     : in Distance_Function_Type;
      initial_weights    : in Vector;
      target_populations : in Vector;
      tolx               : in Real;
      tolf               : in Real;
      max_iterations     : in Positive;
      ru                 : in Real;
      rl                 : in Real;
      new_weights        : out Vector;
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
      data               : Matrix;
      initial_weights    : Vector;
      target_populations : Vector ) return Vector;
      
      
   -- testing only      
   procedure Evaluate_Function_And_Hessian( 
      data               : in Matrix;
      lambdas            : in Vector;
      which_function     : Distance_Function_Type;
      initial_weights    : in Vector;
      target_populations : in Vector;
      ru                 : Real;
      rl                 : Real;
      f_lambdas          : out Vector;
      hessian            : out Matrix );

end  Maths_Functions.Weights_Generator;
