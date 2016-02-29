with Base_Model_Types;
with Equivalence_Scale_Commons;
-- 
-- see (e.g.) www.oecd.org/eco/growth/OECD-Note-EquivalenceScales.pdf
--
generic
   
   type Real is digits<>;

package Equivalence_Scales is

   use Base_Model_Types;
   use Equivalence_Scale_Commons;
   
   type Person is record
      age   : Age_Range;
      ptype : Person_Type;
   end record;
   
   type Person_Array is array( Person_Count range <> ) of Person; 
   
   --  
   -- from: Equivalence scales: rationales, uses and assumptions
   -- Jenny Chanfreau and Tania Burchardt Table 1 p.5
   --
   function Calculate( 
      people      : Person_Array; 
      which_scale : Equivalence_Scale_Type := modified_oecd ) return Real;
   
end Equivalence_Scales;
