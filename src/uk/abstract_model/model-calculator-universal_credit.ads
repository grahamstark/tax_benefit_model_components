with Model.Abstract_Household;
with Model.Abstract_Result;
with Model.Parameter_System;

package Model.Calculator.Universal_Credit is

  use Model.Parameter_System;
  package mar renames Model.Abstract_Result;

  --
  -- fixme move to some non-means tested package
  --
  procedure Calculate_Child_Benefit(
     sys : Child_Benefit_System;
     bu  : Model.Abstract_Household.Benefit_Unit'Class;
     res : in out mar.Benefit_Unit_Result'Class );
  
  procedure Calculate_Universal_Credit(
     sys           : Universal_Credit_System;
     tenure        : Broad_Tenure_Type;
     housing_costs : Housing_Array;
     bu            : Model.Abstract_Household.Benefit_Unit'Class;
     res           : in out mar.Benefit_Unit_Result'Class );

end Model.Calculator.Universal_Credit;
