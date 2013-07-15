
package Hashing_Functions_Pkg is

   generic
      Prime_Num : in Positive;
      --| Required to be prime.

   function Hash_String (S : in String) return Natural;
   --| Effects:
   --| Produces a uniform distribution over the range 0..prime - 1.

end Hashing_Functions_Pkg;
