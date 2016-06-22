with Model.Abstract_Household;

package Model.Example_Household.Impl is


   type Model_Person is new Person and Model.Abstract_Household.Person with null record;
   
   overriding function Pid( pers : Model_Person ) return Sernum_Value;
   overriding function Get_Income( pers : Model_Person; w : Non_Calculated_Incomes_Range ) return Amount;
   overriding function Get_Incomes( pers : Model_Person ) return Incomes_List;
   overriding function Age( pers : Model_Person ) return Age_Range;
   overriding function Family_Relationship( pers : Model_Person ) return Relationship_Type;
   overriding function Employment( pers : Model_Person ) return Broad_Employment_Status;
   overriding function Gender( pers : Model_Person ) return Gender_Type;
   overriding function Is_Contracted_In_To_Serps( pers : Model_Person ) return Boolean;
   overriding function Hours_Worked( pers : Model_Person ) return Work_Hours_Range;
   overriding function Average_Wage_Per_Hour( pers : Model_Person ) return Amount;

   type Model_Benefit_Unit is new Benefit_Unit and Model.Abstract_Household.Benefit_Unit with null record;

   overriding function Get_Pids(
      bu                : Model_Benefit_Unit;
      start_age         : Age_Range := 0;
      end_age           : Age_Range := Age_Range'Last;
      relationship_from : Relationship_Type := Relationship_Type'First;
      relationship_to   : Relationship_Type := Relationship_Type'Last;
      start_person      : Person_Count := 1 ) return Sernum_Set;
      
   overriding function Get_Benefit_Unit_Type( 
      bu : Model_Benefit_Unit ) return Primary_Or_Secondary;
   
   overriding function Find_Person( 
      bu  : Model_Benefit_Unit; 
      pid : Sernum_Value ) return Model.Abstract_Household.Person'Class;
   
   overriding function Is_Couple( 
      bu : Model_Benefit_Unit ) return Boolean;

end  Model.Example_Household.Impl;