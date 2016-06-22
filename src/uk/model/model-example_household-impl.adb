package body Model.Example_Household.Impl is
   
 
   function Pid( pers : Model_Person ) return Sernum_Value is
   begin
      return pers.pid;
   end Pid;
   
   function Get_Income( pers : Model_Person; w : Non_Calculated_Incomes_Range ) return Amount is
   begin
      return pers.incomes( w );   
   end Get_Income;
   
   function Get_Incomes( pers : Model_Person ) return Incomes_List is
   begin
      return pers.incomes;
   end Get_Incomes;
   
   function Age( pers : Model_Person ) return Age_Range is
   begin
      return pers.age;
   end Age;
   
   function Family_Relationship( pers : Model_Person ) return Relationship_Type is
   begin
      return pers.relationship;
   end Family_Relationship;
   
   function Employment( pers : Model_Person ) return Broad_Employment_Status is
   begin
      return pers.employment;
   end Employment;
   
   function Gender( pers : Model_Person ) return Gender_Type is
   begin
      return pers.sex;
   end Gender;
   
   function Is_Contracted_In_To_Serps( pers : Model_Person ) return Boolean is
   begin
      return pers.is_contracted_in_to_serps;
   end  Is_Contracted_In_To_Serps;
   
   function Hours_Worked( pers : Model_Person ) return Work_Hours_Range is
   begin
      return pers.hours_worked;
   end Hours_Worked;
   
   function Average_Wage_Per_Hour( pers : Model_Person ) return Amount is
   begin
      return pers.average_wage_per_hour;
   end Average_Wage_Per_Hour;
   
    function Get_Pids(
      bu                : Model_Benefit_Unit;
      start_age         : Age_Range := 0;
      end_age           : Age_Range := Age_Range'Last;
      relationship_from : Relationship_Type := Relationship_Type'First;
      relationship_to   : Relationship_Type := Relationship_Type'Last;
      start_person      : Person_Count := 1 ) return Sernum_Set is
      
      n : Person_Count := 1;
      s : Sernum_Set;
   begin
      for pers of bu.people loop
            if pers.age >= start_age and pers.age <= end_age and
               n >= start_person and
               pers.relationship >= relationship_from and
               pers.relationship <= relationship_to then 
               s.Include( pers.pid );
               n := n + 1;
            end if;
      end loop;
      return s;
   end Get_Pids;

   function Get_Benefit_Unit_Type( 
      bu : Model_Benefit_Unit ) return Primary_Or_Secondary is
   begin
      return primary;
   end  Get_Benefit_Unit_Type;
   
   function Find_Person( 
      bu  : Model_Benefit_Unit; 
      pid : Sernum_Value ) return Model.Abstract_Household.Person'Class is
      mpers : Model_Person;
   begin
      for pers of bu.people loop   
         if pers.pid = pid then
            declare
               mpers : Model_Person := ( pers with null record );
            begin
               return mpers;
            end;
         end if;
      end loop;
      return mpers;
   end Find_Person;
   
   function Is_Couple( bu : Model_Benefit_Unit ) return Boolean is
   begin
      for pers of bu.people loop
         if pers.marital_status in married_or_civil_partnership .. cohabiting  then
            return true;
         end if;
      end loop;
      return false;
   end Is_Couple;


end Model.Example_Household.Impl;