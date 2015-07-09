package Model.Parameter_System.Operations is

   UPRATE_ROUND_UP : constant Amount := 0.01;

   procedure Annual_To_Weekly( a : in out Amount );
   procedure A2W( a : in out Amount ) renames Annual_To_Weekly;
   procedure Monthly_To_Weekly( a : in out Amount );
   procedure M2W( a : in out Amount ) renames Monthly_To_Weekly;

   procedure Uprate( p : in out Pension_System; v : Rate );   
   procedure Uprate( p : in out Guaranteed_Credit_System; v : Rate );
   procedure Uprate( p : in out Savings_Credit_System; v : Rate );  
   procedure Uprate( p : in out Pension_Credit_System; v : Rate );

end Model.Parameter_System.Operations;