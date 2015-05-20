with Model.Abstract_Household;
with Model.Results;
with Model.Parameter_System;
with Model_Types;

package Model.Calculator.Direct_Tax is

   use Model.Results;
   use Model.Parameter_System;
   use Model_Types;

   --
   -- basic income tax system
   -- investment incomes should be grossed up
   -- todo: MCA/Age Allowance, Expenses ..
   --
   procedure Calculate_Income_Tax(
      sys : Income_Tax_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out Model.Results.Personal_Result );

   procedure Calculate_National_Insurance(
      sys : National_Insurance_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out Personal_Result );

   function Combine_Incomes(
      non_calculated : Incomes_List;
      calculated     : Incomes_List ) return Incomes_List;

   procedure Make_Household_Taxable_Income(
      hh  : Model.Abstract_Household.Household'Class;
      res : in out Model.Results.Household_Result );
      
   procedure Make_Household_Net_Income(
      hh  : Model.Abstract_Household.Household'Class;
      res : in out Model.Results.Household_Result );
      
private

   procedure Apply_Allowance(
      income : in out Amount; allowance : in out Amount );

end Model.Calculator.Direct_Tax;
