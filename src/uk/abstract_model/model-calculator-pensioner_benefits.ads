with Model.Abstract_Household;
with Model.Abstract_Result;
with Model.Parameter_System;

package Model.Calculator.Pensioner_Benefits is

  use Model.Parameter_System;
  package mar renames Model.Abstract_Result;
  
   procedure Calculate_Guaranteed_Pension_Credit(
      gpcsys   : Guaranteed_Credit_System;
      pensys   : Pension_System; 
      bu       : Model.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class );
  
   procedure Calculate_Savings_Credit(
      sys      : Savings_Credit_System; 
      bu       : Model.Abstract_Household.Benefit_Unit;  
      res      : in out mar.Benefit_Unit_Result );
      
   procedure Calculate_State_Pension( 
      sys      : Pension_System; 
      bu       : Model.Abstract_Household.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result );
      
private      

   function Test_Ages( 
      bu : Model.Abstract_Household.Benefit_Unit;
      age_men : Age_Range;
      age_women : Age_Range ) return Boolean;
   
end Model.Calculator.Pensioner_Benefits;
