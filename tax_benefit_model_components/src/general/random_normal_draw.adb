with Ada.Numerics;                      
with Ada.Numerics.Float_Random;         
with Ada.Numerics.Generic_Elementary_Functions;  
-- 
-- from http://rosettacode.org/wiki/Random_numbers#Ada
--
package body Random_Normal_Draw is
   
   use Ada.Numerics.Float_Random;
   
   seed : Generator;

   package Elementary is new Ada.Numerics.Generic_Elementary_Functions( Real );
   
   procedure Reset is
   begin
      Reset( seed );   
   end Reset;
   
   function Draw(
      mean               : Real := 0.0;
      standard_deviation : Real := 1.0 ) return Real is
   use Elementary;
   use Ada.Numerics;
   begin
      return mean + standard_deviation * 
         Sqrt( -2.0 * Log( Real( Random( seed )))) * 
            Cos( 2.0 * Pi * Real(Random( Seed )));
   end Draw;

begin
   Reset( seed );
end Random_Normal_Draw;
