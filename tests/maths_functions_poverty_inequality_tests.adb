with AUnit.Assertions;
with Ada.Text_IO;
with Ada.Calendar;
with Maths_Functions.Poverty_Inequality;
with Base_Model_Types;

package body Maths_Functions_Poverty_Inequality_Tests is
   
   use AUnit.Assertions;
   use Ada.Calendar;
   use Ada.Text_IO;
   use Base_Model_Types;
   
   package MF is new Maths_Functions( Amount );   
   package MFP is new MF.Poverty_Inequality;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;

   function Generate_Pov( 
      qa : in out MFP.Quantile_Array; 
      line : Amount ) return MFP.Poverty_Rec is
   use MFP;
      aqa : Augmented_Quantile_Array( qa'Range );
      summary : Summary_Array;
   begin
      Quantile_Sort( qa );
      To_Augmented_Quantile_Array( qa, aqa );
      summary := Make_Summary( aqa );
      return Make_Poverty( aqa, line );         
   end Generate_Pov;
      
   
   
      
   procedure Test_WB_CH_4( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use MFP;
      --
      -- This test (roughly) tries to replicate some of the examples in
      -- World Bank "Handbook on poverty and inequality" Ch. 4
      --
      country_a : Quantile_Array( 1 .. 4 ); 
      country_b : Quantile_Array( 1 .. 4 ); 
      country_c : Quantile_Array( 1 .. 4 );
      country_a_2 : Quantile_Array( 1 .. 2 ); 
      country_b_2 : Quantile_Array( 1 .. 2 );
   begin
      country_a( 1 ).income := 100.0;
      country_a( 2 ).income := 100.0;
      country_a( 3 ).income := 150.0;
      country_a( 4 ).income := 150.0;
      country_b := country_a;
      country_b( 1 ).income := 124.0;
      country_b( 2 ).income := 124.0;
      
      country_c( 1 ).income := 100.0;
      country_c( 2 ).income := 110.0;
      country_c( 3 ).income := 150.0;
      country_c( 4 ).income := 160.0;
      
      --
      -- these should be the same as country_a and _b, 
      -- but with 2 obs of weight 2 rather than 4 of weight 1
      --
      country_a_2( 1 ).income := 100.0;
      country_a_2( 1 ).weight := 2.0;
      country_a_2( 2 ).income := 150.0;
      country_a_2( 2 ).weight := 2.0;
      country_b_2 := country_a_2;
      country_b_2( 1 ).income := 124.0;
      declare
         line : constant Amount := 125.0;
         c_a_pov : Poverty_Rec := Generate_Pov( country_a, line );
         c_a_2_pov : Poverty_Rec := Generate_Pov( country_a_2, line );
         c_b_pov : Poverty_Rec := Generate_Pov( country_b, line );
         c_b_2_pov : Poverty_Rec := Generate_Pov( country_b_2, line );
         c_c_pov : Poverty_Rec := Generate_Pov( country_c, line );
      begin
         --
         -- simple checks of weights
         --
         Assert( Nearly_Equal( c_a_2_pov.headcount, c_a_pov.headcount ), "Headcount: p_a_2 /= pa " 
            & To_String( c_a_2_pov ) & To_String( c_a_pov )); 
         Assert( Nearly_Equal( c_b_2_pov.headcount, c_b_pov.headcount ), "Headcount: p_b_2 /= pb " 
           & To_String( c_b_2_pov ) & To_String( c_b_pov )); 
         Assert( Nearly_Equal( c_a_2_pov.shorrocks, c_a_pov.shorrocks ), "Shorrocks: p_a_2 /= pa " 
            & To_String( c_a_2_pov ) & To_String( c_a_pov )); 
         Assert( Nearly_Equal( c_a_2_pov.sen, c_a_pov.sen ), "Sen: p_a_2 /= pa " 
            & To_String( c_a_2_pov ) & To_String( c_a_pov )); 
 
         Assert( Nearly_Equal( c_a_2_pov.gap, c_a_pov.gap ), "GAP: p_a_2 /= pa " 
           & To_String( c_a_2_pov ) & To_String( c_a_pov )); 
         Assert( Nearly_Equal( c_b_2_pov.gap, c_b_pov.gap ), "GAP: p_b_2 /= pb " 
           & To_String( c_b_2_pov ) & To_String( c_b_pov ));
           
         --
         -- not quite ch.4, but ..
         -- 
         Assert( Nearly_Equal( c_a_pov.headcount, 0.5 ), "Headcount: p_a /= 0.5 " 
           & To_String( c_a_pov )); 
         
         Assert( Nearly_Equal( c_b_pov.headcount, 0.5 ), "Headcount: p_b_2 /= 0.5 "  
           & To_String( c_b_pov )); 
         Assert( Nearly_Equal( c_a_pov.gap, 0.1 ), "GAP: p_a /= 0.1 "  
           & To_String( c_a_pov )); 
         Assert( Nearly_Equal( c_b_pov.gap, 1.0/250.0 ), "GAP: p_b_2 /= 1/250 " 
           & To_String( c_b_pov )); 
         
         Assert( Nearly_Equal( c_c_pov.watts, 0.087744, 0.00001 ), "Watts: p_c /= 0.087744 " 
           & To_String( c_c_pov )); 
         Put_Line( "finished! c_a_pov = " & To_String( c_a_pov ));
         Put_Line( "finished! c_b_pov = " & To_String( c_b_pov ));
         Put_Line( "finished! c_c_pov = " & To_String( c_c_pov ));
      end;
   end Test_WB_CH_4;
   
   
   procedure Test_UK_2014( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      -- IGNORE: this is bollocks
      use MFP;
      uk : Quantile_Array( 1 .. 20 );
      -- From http://iresearch.worldbank.org/PovcalNet/povOnDemand.aspx
      -- detail view, UK, 2014
      -- original data
      -- Seems to be based on 400 datapoints from somewhere ...
      -- ----------- Distribution ------------
      --    i           P           L 
      -- -------------------------------------
      --    0    0.052484     0.01229
      --    1      0.1025     0.02994
      --    2     0.15239    0.050433
      --    3     0.20248    0.073837
      --    4     0.25246    0.099866
      --    5      0.3025     0.12865
      --    6     0.35248     0.16001
      --    7     0.40236     0.19409
      --    8     0.45243     0.23123
      --    9     0.50247     0.27125
      --   10     0.55247     0.31442
      --   11     0.60245     0.36095
      --   12     0.65242     0.41142
      --   13     0.70221     0.46601
      --   14     0.75242     0.52563
      --   15      0.8025     0.59047
      --   16     0.85247     0.66169
      --   17     0.90249     0.74244
      --   18     0.95219     0.83858
      --   19           1           1
      --   
      -- ----------------- PPP$ and local currency --------------
      --          PPP used in computation: 0.756404
      --      Data mean in local currency: 1154.4
      --                Data mean in PPP$: 1426.48
      --         Poverty line in PPP$/Day: 1.9
      --       Poverty line in PPP$/Month: 57.7917
      --   Poverty line in local currency: 46.7686
      -- -------------------------------------------------------
      -- 
      -- ----------------- Estimation result --------------
      --      Number of observation: 400
      --           Total population: 6.35859E+07
      --               Total wealth: 9.70424E+10(PPP$)
      --                    Minimum: 39.5797(PPP$)
      --                    Maximum: 16678.5(PPP$)
      --              Headcount(HC): 0.00241165
      --           Poverty gap (PG): 0.000867867
      --        Poverty gap squared: 0.000312314
      --                       Gini: 0.340661
      --                     Median: 1183.08
      --                        MLD: 0.201623
      --                       Watt: 0.00107578
      -- --------------------------------------------------
      -- 
      -- -------------------------------- Income or Consumption share by deciles (%) -------------------------------------
      --      2.9058     4.3621     5.4534     6.5261     7.6801     8.9397     10.492     12.365     15.117     26.159
      -- -----------------------------------------------------------------------------------------------------------------


      total_population : constant Amount := 6.35859E+07; 
      average_income : constant Amount := 1154.4;
      total_income :  constant Amount := average_income * total_population;
      line : constant Amount := 46.7686; -- rescale to data mean
      pov : Poverty_Rec;
   begin
      --
      -- converted from Lorenz plots by wb_pars1.rb
      --
      uk(1) := ( index => 1, weight => 0.052484, income => 0.01229 );
      uk(2) := ( index => 2, weight => 0.05001599999999999, income => 0.01765 );
      uk(3) := ( index => 3, weight => 0.049890000000000004, income => 0.020492999999999997 );
      uk(4) := ( index => 4, weight => 0.050089999999999996, income => 0.023404 );
      uk(5) := ( index => 5, weight => 0.049980000000000024, income => 0.026028999999999997 );
      uk(6) := ( index => 6, weight => 0.05003999999999997, income => 0.02878399999999999 );
      uk(7) := ( index => 7, weight => 0.049980000000000024, income => 0.03136000000000003 );
      uk(8) := ( index => 8, weight => 0.04987999999999998, income => 0.03408 );
      uk(9) := ( index => 9, weight => 0.05007, income => 0.03713999999999998 );
      uk(10) := ( index => 10, weight => 0.05003999999999997, income => 0.04002 );
      uk(11) := ( index => 11, weight => 0.050000000000000044, income => 0.043169999999999986 );
      uk(12) := ( index => 12, weight => 0.049980000000000024, income => 0.046530000000000016 );
      uk(13) := ( index => 13, weight => 0.04996999999999996, income => 0.050470000000000015 );
      uk(14) := ( index => 14, weight => 0.04979, income => 0.05458999999999997 );
      uk(15) := ( index => 15, weight => 0.05020999999999998, income => 0.05962000000000006 );
      uk(16) := ( index => 16, weight => 0.05008000000000001, income => 0.06484000000000001 );
      uk(17) := ( index => 17, weight => 0.04996999999999996, income => 0.07121999999999995 );
      uk(18) := ( index => 18, weight => 0.050020000000000064, income => 0.08074999999999999 );
      uk(19) := ( index => 19, weight => 0.049699999999999966, income => 0.09614 );
      uk(20) := ( index => 20, weight => 0.04781000000000002, income => 0.16142 );
      for u of uk loop
         u.income := u.income * total_income;
         u.weight := u.weight*total_population;
      end loop;
      pov :=  Generate_Pov( uk, line );
      Put_Line( To_String( pov ));
   end Test_UK_2014;
   
   
  --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine( T, Test_WB_CH_4'Access, "Test Basic Poverty");
      Register_Routine( T, Test_UK_2014'Access, "Test_UK_2014");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( "Maths_Functions_Poverty_Inequality_Tests" );
   end Name;

end  Maths_Functions_Poverty_Inequality_Tests;