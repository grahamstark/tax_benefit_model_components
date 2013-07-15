with AUnit.Test_Suites;

with Component_Tests;
with Legal_Aid_Tests;
with PovLine_Tests;
with Input_Collection_Tests;
with BHPS_Tests;

function TB_Suite return AUnit.Test_Suites.Access_Test_Suite is
   
   use AUnit.Test_Suites;
   
   result : Access_Test_Suite := new Test_Suite;
begin
   Add_Test( result, new BHPS_Tests.Test_Case );
   Add_Test( result, new Component_Tests.Test_Case );
   Add_Test( result, new Legal_Aid_Tests.Test_Case );
   Add_Test( result, new PovLine_Tests.Test_Case );
   Add_Test( result, new Input_Collection_Tests.Test_Case );
   return result;
end TB_Suite;
