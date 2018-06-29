package body Model.Rounder is

   function Round( r : Rounder_Type; thing_in_pounds : Amount; strategy : Round_Strategy := exact ) return Amount is
   begin
      if r.always_exact or strategy = exact then
         return thing_in_pounds;
      end if;
      declare 
         a : Amount := thing_in_pounds;
      begin
         case strategy is 
            when up => 
               Inc( a, 0.99999999 );
               a := Amount'Floor( a );
            when down =>
               a := Amount'Floor( a );
            when exact =>
               null;
         end case;
         return a;
      end;
   end Round;

   function Initialise( always_exact : Boolean := True ) return Rounder_Type is
      r : Rounder_Type;
   begin
      r.always_exact := always_exact;
      return r;
   end Initialise;

end Model.Rounder;