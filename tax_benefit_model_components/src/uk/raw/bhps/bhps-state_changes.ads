with T_Utils;

package BHPS.State_Changes is
   
   procedure Age( ad : in out Adult );
   function Age( hh : Household ) return Household_Vector;
   
private
   
   
end  BHPS.State_Changes;
