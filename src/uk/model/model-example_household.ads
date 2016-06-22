with Standard_UK_Enums;
with Ada.Calendar;

package Model.Example_Household is

   use Standard_UK_Enums;
   use Ada.Calendar;
   
   type Person is tagged record
      pid                       : Sernum_Value;
      age                       : Age_Range := Age_Range'First;
      sex                       : Gender_Type := male;
      relationship              : Relationship_Type := head;
      marital_status            : Marital_Status_Type := na;
      incomes                   : Incomes_List := ( others => 0.0 );
      wealth                    : Wealth_List := ( others => 0.0 );
      employment                : Broad_Employment_Status := full_time;
      is_contracted_in_to_serps : Boolean := False; 
      hours_worked              : Work_Hours_Range := Work_Hours_Range'First;
      average_wage_per_hour     : Amount := 0.0;
    end record;  
    
    type Person_Array is array( Person_Number range <>  ) of Person;
    
    type Benefit_Unit( num_people : Person_Number ) is tagged record
       people : Person_Array( 1 .. num_people );
    end record;
    
    type Household( num_people : Person_Number ) is tagged record
       hid           : Sernum_Value := Sernum_Value'First;
       year          : Year_Number := 2016;
       tenure        : Broad_Tenure_Type := social_rented; 
       housing_costs : Housing_Array := ( others => 0.0 );
       wealth        : Wealth_List := ( others => 0.0 );
       people        : Person_Array( 1 .. num_people );       
    end record;
                           
end Model.Example_Household;