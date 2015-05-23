package Model.Abstract_Result is

   use Standard_UK_Enums;

   type Personal_Result is interface;
   
   procedure Set( result : in out Personal_Result;which : Calculated_Incomes_Range; value : Amount ) is abstract;
   function Get( which : Calculated_Incomes_Range ) return Amount  is abstract;
   
   type Benefit_Unit_Result is interface;
   
   procedure Set( result : in out Benefit_Unit_Result;which : Person_Number; value : Personal_Result ) is abstract;
   function Get( which : Person_Number ) return Personal_Result  is abstract;
   
   type Household_Result is interface;
   
   procedure Set( result : in out Household_Result;which : Benefit_Unit_Number; value : Benefit_Unit_Result ) is abstract;
   function Get( which : Benefit_Unit_Number ) return Benefit_Unit_Result  is abstract;
   
   procedure Add_Note( result : in out Household_Result; key : String; value : String ) is abstract;
   function Get_Notes( result : Household_Result ) return String; 
   
end Model.Abstract_Result;
