package Model.Parameter_System.Operations is


   UPRATE_ROUND_UP : constant Amount := 0.01;

   DAYS_PER_YEAR   : constant Rate := 365.25;
   WEEKS_PER_YEAR  : constant Rate := DAYS_PER_YEAR / 7.0;
   WEEKS_PER_MONTH : constant Rate := 12.0 / WEEKS_PER_YEAR;

   procedure Annual_To_Weekly( a : in out Amount );
   procedure A2W renames Annual_To_Weekly( a : in out Amount );
   procedure Monthly_To_Weekly( a : in out Amount );
   procedure M2W renames Monthly_To_Weekly( a : in out Amount );

   procedure Uprate( p : in out Pension_System; v : Rate );   
   procedure Uprate( p : in out Guaranteed_Credit_System; v : Rate );
   procedure Uprate( p : in out Savings_Credit_System; v : Rate );  
   procedure Uprate( p : in out Pension_Credit_System; v : Rate );

end Model.Parameter_System.Operations;