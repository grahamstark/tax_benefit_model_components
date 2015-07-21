with Ada.Calendar;

package Model.Parameter_System.Defaults is

   use Ada.Calendar;

   function Get_Complete_System( year : Year_Number ) return Complete_System;

   function Get_Expenses return Expenses_Included;

   type Income_List_Type is ( 
      housing_benefit, 
      council_tax_benefit,
      guaranteed_pension_credit, 
      savings_credit, 
      universal_credit, 
      savings_credit_qualifying_income );

   type Benefit_Incomes_Type is ( earned, unearned, both );
      
   function Get_Default_Incomes( 
      which : Income_List_Type; 
      itype : Benefit_Incomes_Type := both ) return Incomes_Included;


   function Get_Income_Tax_System( year : Year_Number ) return Income_Tax_System;
   function Get_National_Insurance_System( year : Year_Number ) return National_Insurance_System;
   function Get_Universal_Credit_System( year : Year_Number ) return Universal_Credit_System;
   function Get_Child_Benefit_System( year : Year_Number ) return Child_Benefit_System;

   
end Model.Parameter_System.Defaults;
