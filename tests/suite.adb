with AUnit.Test_Suites; use AUnit.Test_Suites;

with component_tests;
with legal_aid_tests;
with PovLine_Tests;
with Input_Collection_Tests;
with Maths_Functions.Poverty_Inequality.Tests;
with ZA_Tests;

function suite return Access_Test_Suite is
   Result : Access_Test_Suite := new Test_Suite;
begin
   Add_Test ( Result, new Component_Tests.Test_Case );
   Add_Test ( Result, new ZA_Tests.Test_Case ); 
   -- Add_Test ( Result, new Legal_Aid_Tests.Test_Case );
   --Add_Test ( Result, new PovLine_Tests.Test_Case );
   --Add_Test ( Result, new Input_Collection_Tests.Test_Case );
   return Result;
end suite;
