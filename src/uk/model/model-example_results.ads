with Standard_UK_Enums;

package Model.Example_Results is

   use Standard_UK_Enums;
   
   subtype Calculated_Incomes_List is T_Incomes.Abs_Amount_Array( Calculated_Incomes_Range'Range ); 
   
   type Personal_Result is tagged record
      pid          : Sernum_Value;
      income       : Calculated_Incomes_List;
      intermediate : Broad_Calculated_List;
   end record;
   
   type Personal_Result_Array is array(Person_Number range <>  ) of Personal_Result; 
   
   type Household_Result( num_people : Person_Number ) is tagged record 
      people : Personal_Result_Array( 1 .. num_people );
   end record;

   function Find( 
      result : Household_Result; 
      pid    : Sernum_Value; 
      found  : out Boolean ) return Personal_Result'Class;
   
   subtype Benefit_Unit_Result is Household_Result;
   
   --we're assuming a single benefit uniut for now, so nothing else neeed here e.g. extract benefit unit from hhls 
    

end Model.Example_Results;