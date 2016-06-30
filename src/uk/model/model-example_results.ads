with Standard_UK_Enums;

package Model.Example_Results is

   use Standard_UK_Enums;
   
   type Personal_Result is tagged record
      incomes : Calculated_Incomes_Array;
   end record;
   
   type Personal_Result_Array is array(Person_Number range <>  ) of Personal_Result; 
   
   type Household_Result( num_people : Person_Number ) is tagged record 
      people : Personal_Result_Array( 1 .. num_people );
   end record;
      

end Model.Example_Results;