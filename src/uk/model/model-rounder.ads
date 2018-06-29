package Model.Rounder is

   type Round_Strategy is ( up, down, exact );
   
   type Rounder_Type is tagged private;
   
   function Round( r : Rounder_Type; thing_in_pounds : Amount; strategy : Round_Strategy := exact ) return Amount;

   function Initialise( always_exact : Boolean := True ) return Rounder_Type;
   
private

   type Rounder_Type is tagged record
      always_exact : Boolean := True;
   end record;

end Model.Rounder;