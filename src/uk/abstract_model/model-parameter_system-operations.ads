package Model.Parameter_System.Operations is

   UPRATE_ROUND_UP : constant Amount := 0.01;

   procedure Uprate( p : in out Pension_System; v : Rate );   
   procedure Uprate( p : in out Guaranteed_Credit_System; v : Rate );
  `procedure Uprate( p : in out Savings_Credit_System; v : Rate );  
   procedure Uprate( p : in out Pension_Credit_System; v : Rate );

end Model.Parameter_System.Operations;