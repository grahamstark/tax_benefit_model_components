with Model.Abstract_Household;
with Model.Results;
with Model.Parameter_System;

package Model.Calculator.Universal_Benefit is

  use Model.Parameter_System;
  package mar renames Model.Abstract_Result;

  procedure Calculate_Child_Benefit(
     sys : Child_Benefit_System;
     bu  : Model.Abstract_Household.Benefit_Unit'Class;
     res : in out mar.Personal_Result'Class );
  
  procedure Calculate_Universal_Benefit(
     sys           : Universal_Credit_System;
     tenure        : Tenure_Type;
     housing_costs : Housing_Array;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out mar.Personal_Result'Class );

end Model.Calculator.Universal_Benefit;
