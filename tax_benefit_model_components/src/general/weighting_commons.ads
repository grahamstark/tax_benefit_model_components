--
-- just the enumerations needed for the Maths reweighing routines (since those are generic)
--
package Weighting_Commons is
   --
   -- These are the distance function types from Creedy 2003 table 3, originally from Deville and Sarndal '92
   --
   type Distance_Function_Type is ( 
      chi_square, 
      constrained_chi_square, 
      d_and_s_type_a, 
      d_and_s_type_b, 
      d_and_s_constrained );

end  Weighting_Commons;
