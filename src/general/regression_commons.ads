package Regression_Commons is

   type Regression_Type is ( OLS, Probit, Logit ); -- stuff
   type Standard_Error_Type is ( uncorrected, hc0, hc1, hc2, hc3 );
   subtype Robust_Standard_Errors is Standard_Error_Type range hc0 .. hc3;

end Regression_Commons;
