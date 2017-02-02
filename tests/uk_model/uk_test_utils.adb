package body UK_Test_Utils is

   --
   -- top trivia HMRC round *each bit* of NI calculation to 1p
   -- and I'm not going to, so ...
   --
   function Within_1p( a, b : Amount; within : Amount := 0.01 ) return Boolean is
   begin
      return abs( a - b ) <= within;
   end Within_1p;
   
end UK_Test_Utils;