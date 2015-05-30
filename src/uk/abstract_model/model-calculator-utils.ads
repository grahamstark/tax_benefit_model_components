package Model.Calculator.Utils is

   function Combine_Incomes(
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_List;
      
   function Calculate_Incomes(
      non_calculated   : Incomes_List;
      res              : mar.Personal_Result'Class;
      which_to_include : Incomes_List ) return Amount;
   
end  Model.Calculator.Utils;