package body BHPS.State_Changes is


   
   procedure Uprate( ad : in out Adult ) is
   begin
      null;
   end Uprate;
   
   procedure Age( ad : in out Adult ) is
   begin
      ad.age := ad.age + 1;
      Uprate( ad );
      
   end Age;
   
   function Age( hh : Household ) return Household_Vector is 
      hv : Household_Vector;
   begin
      return hv;
   end Age;
   
end  BHPS.State_Changes;
