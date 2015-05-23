with Model.Abstract_Household;
with Model.Abstract_Result;
with Model.Parameter_System;

package Model.Calculator.Direct_Tax is

   package mar renames Model.Abstract_Result;
   use Model.Parameter_System;
   --
   -- basic income tax system
   -- investment incomes should be grossed up
   -- todo: MCA/Age Allowance, Expenses ..
   --
   procedure Calculate_Income_Tax(
      sys : Income_Tax_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out mar.Personal_Result'Class );

   procedure Calculate_National_Insurance(
      sys : National_Insurance_System;
      ad  : Model.Abstract_Household.Person'Class;
      res : in out mar.Personal_Result'Class );

   function Combine_Incomes(
      non_calculated : Incomes_List;
      calculated     : Incomes_List ) return Incomes_List;

   procedure Accumulate_To_HHld_Level(
      hh    : Model.Abstract_Household.Household'Class;
      res   : in out mar.Household_Result'Class;
      which : Broad_Calculated_Type );

private

   procedure Apply_Allowance(
      income : in out Amount; allowance : in out Amount );

end Model.Calculator.Direct_Tax;
