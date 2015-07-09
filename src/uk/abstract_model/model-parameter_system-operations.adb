package body Model.Parameter_System.Operations is

   procedure Monthly_To_Weekly( a : in out Amount ) is
   begin
      a := a / WEEKS_PER_MONTH;
   end Monthly_To_Weekly;
   
   procedure Annual_To_Weekly( a : in out Amount ) is
   begin
      a := a / WEEKS_PER_YEAR;
   end Annual_To_Weekly;
   
   procedure Uprate( p : in out Pension_System; v : Rate ) is
   begin
      Uprate( p.class_a, v, UPRATE_ROUND_UP );
   end Uprate;
   
   procedure Uprate( p : in out Guaranteed_Credit_System; v : Rate ) is
   begin
      Uprate( p.single, v, UPRATE_ROUND_UP );
      Uprate( p.couple, v, UPRATE_ROUND_UP );
      Uprate( p.carer_single, v, UPRATE_ROUND_UP );
      Uprate( p.severe_disability_single, v, UPRATE_ROUND_UP );
      Uprate( p.severe_disability_couple, v, UPRATE_ROUND_UP );
   end Uprate;
   
   procedure Uprate( p : in out Savings_Credit_System; v : Rate ) is
   begin
      Uprate( p.threshold_single, v, UPRATE_ROUND_UP );
      Uprate( p.threshold_couple, v, UPRATE_ROUND_UP );
      Uprate( p.maximum_single, v, UPRATE_ROUND_UP );
      Uprate( p.maximum_couple, v, UPRATE_ROUND_UP );
  end Uprate;
  
   procedure Uprate( p : in out Pension_Credit_System; v : Rate ) is
   begin
      Uprate( p.guaranteed_credit, v );
      Uprate( p.savings_credit, v );
   end Uprate;
   
   procedure Uprate( p : in out Complete_System; v : Rate ) is
   begin
      null; -- Uprate( p.pension, v );
      
   end Uprate;
   
end Model.Parameter_System.Operations;