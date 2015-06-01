with Model.Abstract_Household;
with Model.Abstract_Result;
with Model.Parameter_System;

package Model.Calculator.Pensioner_Benefits is

  use Model.Parameter_System;
  package mar renames Model.Abstract_Result;
  package mah renames Model.Abstract_Household;
  
   procedure Calculate_Guaranteed_Pension_Credit(
      gpcsys   : Guaranteed_Credit_System;
      pensys   : Pension_System; 
      bu       : mah.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class );
  
   procedure Calculate_Savings_Credit(
      sys      : Savings_Credit_System; 
      bu       : mah.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class );
      
   procedure Calculate_State_Pension( 
      sys      : Pension_System; 
      bu       : mah.Benefit_Unit'Class;  
      res      : in out mar.Benefit_Unit_Result'Class );
      
private      

   function Test_Ages( 
      bu : mah.Benefit_Unit'Class;
      age_men : Age_Range;
      age_women : Age_Range ) return Boolean;
   
end Model.Calculator.Pensioner_Benefits;
