
with Equivalence_Scale_Commons;
-- 
-- see (e.g.) www.oecd.org/eco/growth/OECD-Note-EquivalenceScales.pdf
--
generic
   
   type Real is digits<>;

package Equivalence_Scales is

   use Equivalence_Scale_Commons;
   
   --  
   -- from: Equivalence scales: rationales, uses and assumptions
   -- Jenny Chanfreau and Tania Burchardt Table 1 p.5
   --
   function Calculate( 
      people      : Person_Array; 
      which_scale : Equivalence_Scale_Type ) return Real;
   
end Equivalence_Scales;
