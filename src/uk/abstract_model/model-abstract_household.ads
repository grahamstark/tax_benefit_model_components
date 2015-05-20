with Ada.Containers.Indefinite_Vectors;
with Model_Types;

package Model.Abstract_Household is

   use Model_Types;

   type Incomes is interface;
   function Get_Income( i : Incomes; w : Non_Calculated_Incomes_Range ) return Amount is abstract;
   function Get_Incomes( i : Incomes ) return Incomes_List is abstract;

   type Demog is interface;
   function Age( d : Demog ) return Age_Range is abstract;
   function Employment( d : Demog ) return Employment_Status is abstract;
   function Gender( d : Demog ) return Gender_Type is abstract;
   function Family_Relationship( d : Demog ) return Relationship_Type is abstract;
   function Education_Status( d : Demog ) return Education_Type is abstract;

   type Employment_Record is interface;
   function Is_Contracted_In_To_Serps( e : Employment_Record ) return Boolean is abstract;
   function Hours_Worked( e : Employment_Record ) return Work_Hours_Range is abstract;
   function Average_Wage_Per_Hour( e : Employment_Record ) return Amount is abstract;

   type Person is interface and Demog and Incomes and Employment_Record;
   package Person_List_Package is new Ada.Containers.Indefinite_Vectors( Positive, Person'Class );
   subtype Person_Vector is Person_List_Package.Vector;
   subtype Person_Ptr is Person_List_Package.Cursor;

   package Expenses is
      type Expenses is interface;
   end Expenses;

   package Health is
      type Health is interface;
   end Health;
   
   
   package Life_Events is
      type Life_Events is interface;
   end Life_Events;
   

   package Weights is
      type Weights is interface;
      
   end Weights;

   package Wealth is
      type Wealth is interface;
   end Wealth;


   type Benefit_Unit is interface;

   function Get_Num_People(
      bu        : Benefit_Unit;
      start_age : Age_Range := 0;
      end_age   : Age_Range := Age_Range'Last;
      relationship_from : Relationship_Type := Relationship_Type'First;
      relationship_to   : Relationship_Type := Relationship_Type'Last;
      start_person : Person_Count := 1 ) return Person_Count is abstract;
   function Get_Person( bu : Benefit_Unit; which : Positive ) return Person'Class is abstract;
   function Get_Benefit_Unit_Type( bu : Benefit_Unit ) return Primary_Or_Secondary is abstract;
   
   package Benefit_Unit_List_Package is new Ada.Containers.Indefinite_Vectors( Benefit_Unit_Number, Benefit_Unit'Class );
   subtype Benefit_Unit_Vector is Benefit_Unit_List_Package.Vector;
   subtype Benefit_Unit_Ptr is Benefit_Unit_List_Package.Cursor;

   type Household is interface;
   
   function Get_Benefit_Units( hh : Household ) return Benefit_Unit_Vector is abstract;

   function Get_Num_Benefit_Units(
      hh        : Household ) return Benefit_Unit_Count is abstract;

   function Get_Num_People(
      hh        : Household;
      start_age : Age_Range := 0;
      end_age   : Age_Range := Age_Range'Last;
      relationship_from : Relationship_Type := Relationship_Type'First;
      relationship_to   : Relationship_Type := Relationship_Type'Last;
      start_person : Person_Count := 1 ) return Person_Count is abstract;

   function Get_Housing_Cost( hh : Household; htype : Housing_Cost_Type ) return Amount is abstract;
   function Get_Tenure_Type( hh : Household ) return Tenure_Type is abstract;

   function Get_Person( hh : Household; bu_no : Positive; pers_no : Positive ) return Person'Class is abstract;
   function Get_Benefit_Unit( hh : Household; which : Positive ) return Benefit_Unit'Class is abstract;
   
   

   -- function Relationship( from : Person_Number; to : Person_Number ) return Relationship_Type;

end Model.Abstract_Household;
