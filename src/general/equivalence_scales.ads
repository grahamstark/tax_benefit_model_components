with Base_Model_Types;
   
-- see (e.g.) www.oecd.org/eco/growth/OECD-Note-EquivalenceScales.pdf

package Equivalence_Scales is

   use Base_Model_Types;
   
   type Person_Type = ( head, spouse, adult, dependent_child );
   
   type Equivalence_Scale_Type is ( 
      oxford, 
      modified_oecd, 
      square_root, 
      mcclements );

   type Person is
      age : Age_Range;
      ptype : Person_Type;
   end;
   
   type Person_Array is array( Person_Count range <> ) of Person; 
   
   --  
   -- from: Equivalence scales: rationales, uses and assumptions
   -- Jenny Chanfreau and Tania Burchardt Table 1 p.5
   --
   function Calculate( 
           people      : Person_Array; 
           which_scale : Equivalence_Scale_Type := modified_oecd ) return Amount is
   
end Equivalence_Scales;
