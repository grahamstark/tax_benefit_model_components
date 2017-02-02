with Base_Model_Types;

package UK_Test_Utils is

   use Base_Model_Types;
   --
   -- top trivia HMRC round *each bit* of NI calculation to 1p
   -- and I'm not going to, so ...
   --
   function Within_1p( a, b : Amount; within : Amount := 0.01 ) return Boolean;

end UK_Test_Utils;