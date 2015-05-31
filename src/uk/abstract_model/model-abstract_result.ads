--
-- This is where the calculations from the basic calculation models
-- are stored. It's in the form of interfaces which have to me implemented in an actual
-- model somewhere.
-- 
package Model.Abstract_Result is

   type Personal_Result is interface;

   procedure Set( 
      result : in out Personal_Result;
      which  : Calculated_Incomes_Range; 
      value  : Amount; 
      op     : Operation_Type := Replace ) is abstract;
      
   function Get( 
      result : Personal_Result; 
      which  : Calculated_Incomes_Range ) return Amount  is abstract;
      
   procedure Set( 
      result : in out Personal_Result;
      which  : Broad_Calculated_Type; 
      value  : Amount; 
      op     : Operation_Type := Replace ) is abstract;
      
   function Get( 
      result : Personal_Result; 
      which  : Broad_Calculated_Type ) return Amount  is abstract;
      
   procedure Zero( result : in out Personal_Result ) is abstract;

   type Benefit_Unit_Result is interface;
   
   procedure Set( 
      result : in out Benefit_Unit_Result;
      pid    : Sernum_Value; 
      value  : Personal_Result'Class ) is abstract;
 
   function Get( 
      result : Benefit_Unit_Result; 
      pid    : Sernum_Value ) return Personal_Result'Class  is abstract;
      
   procedure Set( 
      result : in out Benefit_Unit_Result;
      pid    : Sernum_Value; 
      which  : Calculated_Incomes_Range; 
      value  : Amount;
      op     : Operation_Type := Replace ) is abstract;
      
   procedure Set( 
      result : in out Benefit_Unit_Result;
      pid    : Sernum_Value; 
      which  : Broad_Calculated_Type; 
      value  : Amount;
      op     : Operation_Type := Replace ) is abstract;
      
   function Get( 
      result : Benefit_Unit_Result; 
      which  : Broad_Calculated_Type ) return Amount  is abstract;
      
   procedure Zero( 
      result : in out Benefit_Unit_Result ) is abstract;

   type Household_Result is interface;
   
   procedure Set( 
      result : in out Household_Result;
      which : Benefit_Unit_Number; 
      value : Benefit_Unit_Result'Class ) is abstract;
      
   procedure Set( 
      result : in out Household_Result;
      pid    : Sernum_Value; 
      value  : Personal_Result'Class;
      op     : Operation_Type := Replace ) is abstract;
      
   function Get( 
      result : Household_Result; 
      which  : Benefit_Unit_Number ) return Benefit_Unit_Result'Class  is abstract;
   
   function Get( 
      result : Household_Result; 
      which  : Broad_Calculated_Type ) return Amount is abstract;
   
   procedure Zero( result : in out Household_Result ) is abstract;

   -- procedure Add_Note( result : in out Household_Result; key : String; value : String ) is abstract;
   -- function Get_Notes( result : Household_Result ) return String is abstract; 
   
end Model.Abstract_Result;
