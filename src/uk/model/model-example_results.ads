with Standard_UK_Enums;

package Model.Example_Results is

   use Standard_UK_Enums;
   
   subtype Calculated_Incomes_List is T_Incomes.Abs_Amount_Array( Calculated_Incomes_Range'Range ); 
   
   type Personal_Result is tagged record
      income       : Calculated_Incomes_List;
      intermediate : Broad_Calculated_List;
   end record;
   
   type Personal_Result_Array is array(Person_Number range <>  ) of Personal_Result; 
   
   type Household_Result( num_people : Person_Number ) is tagged record 
      people : Personal_Result_Array( 1 .. num_people );
   end record;
      

end Model.Example_Results;