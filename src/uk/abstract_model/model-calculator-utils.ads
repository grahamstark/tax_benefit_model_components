with Model.Abstract_Result;
with Model.Abstract_Household;
with Standard_UK_Enums.Utils;

package Model.Calculator.Utils is

   package mar renames Model.Abstract_Result;
   package mah renames Model.Abstract_Household;
   
   DISAB_SET : constant Incomes_Set := Standard_UK_Enums.Utils.Get_Disabled_Benefits;
   CARE_SET : constant Incomes_Set := Standard_UK_Enums.Utils.Get_Care_Benefits;
   
   function Combine_Incomes(
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_List;
      
   function Calculate_Incomes(
      non_calculated   : Incomes_List;
      res              : mar.Personal_Result'Class;
      which_to_include : Incomes_Included ) return Amount;
      
   function Calculate_Incomes(
      bu               : mah.Benefit_Unit'Class;
      res              : mar.Benefit_Unit_Result'Class;
      which_to_include : Incomes_Included ) return Amount;
      
   function Which_Incomes_Received( 
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_Set; 
      
   function Get_Head_Of_Benefit_Unit( bu : mah.Benefit_Unit'Class ) return Sernum_Value;
   function Get_Benefit_Unit_Carer( bu : mah.Benefit_Unit'Class ) return Sernum_Value;
   function Get_Spouse_Of_Head( 
      bu : mah.Benefit_Unit'Class; 
      head_pid : Sernum_Value ) return Sernum_Value;
 
end  Model.Calculator.Utils;