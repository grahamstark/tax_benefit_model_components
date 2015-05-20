with Ada.Calendar;

package Model.Parameter_System.Defaults is

   use Ada.Calendar;

   function Get_Complete_System( year : Year_Number ) return Complete_System;

private

   function Get_Income_Tax_System( year : Year_Number ) return Income_Tax_System;
   function Get_National_Insurance_System( year : Year_Number ) return National_Insurance_System;
   function Get_Universal_Credit_System( year : Year_Number ) return Universal_Credit_System;
   function Get_Student_Loan_And_Grant_System(
      year : Year_Number;
      plan_type             : Loan_Plan_Type;
      num_maintenance_bands : Positive;
      num_algfe_bands       : Positive  ) return Student_Loan_And_Grant_System;
   function Get_Child_Benefit_System( year : Year_Number ) return Child_Benefit_System;

end Model.Parameter_System.Defaults;
