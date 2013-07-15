--
--  $Author: graham_s $
--  $Date: 2008-04-13 16:18:43 +0100 (Sun, 13 Apr 2008) $
--  $Revision: 4997 $
--
--  Implements brent's method for finding a miminum of an arbtrary function.
-- 
--  from Numerical Recipies (Pascal) ch 10.,
--  from Numerical Recipies (Pascal) ch 9.3,
--
--
pragma License( Modified_GPL );

with Ada.Containers.Vectors;

generic
   
   type Real is digits<>;

   MAX_ITERATIONS : Positive;
   Tolerance      : Real;
   Increment      : Real;
   Start          : Real;
   Stop           : Real;
   type Control_Rec is private;  
   --
   -- minimise this function 
   --
   with function Minimand( control : Control_Rec; m : Real ) return Real;

package Optimiser is


   type Error_Conditions is (NoError, TooManyIterations, RootNotBracketed, OtherOptimumProblem);
   --
   --
   -- 
   --
   procedure Optimise(   
      control        : Control_Rec;
      optimum_x      : in out Real;
      optimum_y      : in out Real;
      err            : in out Error_Conditions );

end Optimiser;
