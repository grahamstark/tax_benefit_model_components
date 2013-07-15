with Ada.Text_IO;

package ZA.Household.Gauss_IO is
 
   procedure Read_From_Gauss_File( f : Ada.Text_IO.File_Type; 
      hh : out Household_Rec; 
      household_counter : in out Positive; 
      is_end : out Boolean );
      
   Data_Conversion_Exception : exception;
   
end ZA.Household.Gauss_IO;
