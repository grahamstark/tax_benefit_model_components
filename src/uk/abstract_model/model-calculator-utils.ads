with Model.Abstract_Result;
with Model.Abstract_Household;

package Model.Calculator.Utils is

   package mar renames Model.Abstract_Result;
   package mah renames Model.Abstract_Household;
   
   function Combine_Incomes(
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_List;
      
   function Calculate_Incomes(
      non_calculated   : Incomes_List;
      res              : mar.Personal_Result'Class;
      which_to_include : Incomes_List ) return Amount;
      
   function Calculate_Incomes(
      bu               : mah.Benefit_Unit'Class;
      res              : mar.Benefit_Unit_Result'Class;
      which_to_include : Incomes_List ) return Amount;
      
   function Which_Incomes_Received( 
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_Set; 
   
end  Model.Calculator.Utils;