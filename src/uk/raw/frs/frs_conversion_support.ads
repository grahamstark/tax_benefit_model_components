with GNAT.String_Split;
with Base_Model_Types;

package FRS_Conversion_Support is

   use GNAT.String_Split;
   use Base_Model_Types;
   
   function Convert( slices : Slice_Set; which : Natural ) return Rate;
   
   function Convert( slices : Slice_Set; which : Natural ) return Integer;
   
   function TDA_Tokenize( s : String ) return Slice_Set;
   
   
end FRS_Conversion_Support;
