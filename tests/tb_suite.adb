with AUnit.Test_Suites;

with General_Tests;
-- with Component_Tests;
-- with Legal_Aid_Tests;
-- with PovLine_Tests;
-- with Input_Collection_Tests;
-- with BHPS_Tests;
with Weighting_Tests;
with Maths_Functions.Poverty_Inequality.Tests;

function TB_Suite return AUnit.Test_Suites.Access_Test_Suite is
   
   use AUnit.Test_Suites;
   
   package MF is new Maths_Functions( Long_Float );
   package MFIE_1_000 is new MF.Poverty_Inequality( 1_000 );
   package MFIE_10_000 is new MF.Poverty_Inequality( 10_000 );
   package MFIE_10_000_Test is new MFIE_10_000.Tests; 
   result : Access_Test_Suite := new Test_Suite;
begin
   -- Add_Test( result, new BHPS_Tests.Test_Case );
   -- Add_Test( result, new Component_Tests.Test_Case );
   -- Add_Test( result, new Legal_Aid_Tests.Test_Case );
   -- Add_Test( result, new PovLine_Tests.Test_Case );
   Add_Test( result, new MFIE_10_000_Test.Test_Case );
   Add_Test( result, new Weighting_Tests.Test_Case );
   
   return result;
end TB_Suite;
