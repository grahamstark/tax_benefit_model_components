package body Model.Example_Results is

   function Find( 
      result : Household_Result; 
      pid    : Sernum_Value; 
      found  : out Boolean ) return Personal_Result'Class is
      pres : Personal_Result := ( 
         pid          => Sernum_Value'First,
         income       => ( others => 0.0 ), 
         intermediate => ( others => 0.0 ));
   begin
      found := False;
      for pers_r of result.people loop
         if pers_r.pid = pid then
            found := True;
            pres := pers_r;
            exit;
         end if;
      end loop;
      return pres;
   end Find;
 
end Model.Example_Results;