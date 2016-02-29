with Base_Model_Types;

package Equivalence_Scale_Commons is
      
   use Base_Model_Types;

   type Person_Type is ( 
      head, 
      spouse_of_head, 
      other_adult, 
      dependent_child );
   
   type Equivalence_Scale_Type is ( 
      oxford, 
      modified_oecd, 
      square_root, 
      mcclements );
      
   type Person is record
      age   : Age_Range;
      ptype : Person_Type;
   end record;
   
   type Person_Array is array( Person_Count range <> ) of Person; 
   

end Equivalence_Scale_Commons;
