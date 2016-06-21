with Standard_UK_Enums;

package Model.Example_Household is
   
   type Person is record
      pid : Sernum_Value;
      age                       : Age_Range;
      sex                       : Gender_Type;
      incomes                   : Incomes_List;
      employment                : Broad_Employment_Status;
      is_contracted_in_to_serps : Boolean;
      hours_worked              : Work_Hours_Range;
    end record;  
    
    type Person_Array is array( Person_Number range <>  ) or Person;
    
    type Household( num_people : Person_Number := 1 ) is record
       hid    : Sernum_Value;
       tenure : Broad_Tenure_Type; 
       people : Person_Array( 1 .. num_people );       
    end record;
                           
end Model.Example_Household;