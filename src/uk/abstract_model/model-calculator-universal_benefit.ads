with Model.Abstract_Household;
with Model.Results;
with Model.Parameter_System;
with Model_Types;

package Model.Calculator.Universal_Benefit is

  use Model.Results;
  use Model.Parameter_System;
  use Model_Types;

  procedure Calculate_Child_Benefit(
     sys           : Child_Benefit_System;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out Benefit_Unit_Result );
  
  procedure Calculate_Universal_Benefit(
     sys           : Universal_Credit_System;
     tenure        : Tenure_Type;
     housing_costs : Housing_Array;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out Benefit_Unit_Result );

end Model.Calculator.Universal_Benefit;
