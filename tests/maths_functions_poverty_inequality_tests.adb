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
      growth : constant Amount := 0.05;
      aqa : Augmented_Quantile_Array( qa'Range );
      summary : Summary_Array;
   begin
      Quantile_Sort( qa );
      To_Augmented_Quantile_Array( qa, aqa );
      summary := Make_Summary( aqa );
      return Make_Poverty( aqa, line, growth );         
   end Generate_Pov;
      
   function Generate_Ineq( 
      qa : in out MFP.Quantile_Array ) return MFP.Inequality_Rec is
   use MFP;
      aqa : Augmented_Quantile_Array_Access := new Augmented_Quantile_Array( qa'Range );
      summary : Summary_Array;
   begin
      Quantile_Sort( qa );
      To_Augmented_Quantile_Array( qa, aqa.all );
      summary := Make_Summary( aqa.all );
      declare
        ir : Inequality_Rec := Make_Inequality( aqa.all );
      begin
        Free_Dataset( aqa );   
        return ir;
      end;
   end Generate_Ineq;
   
   
      
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
         country_d : Quantile_Array := country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a &
            country_a & country_a & country_a;
         c_d_pov : Poverty_Rec := Generate_Pov( country_d, line );         
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
           
         Assert( Nearly_Equal( c_a_pov, c_a_2_pov, 0.0001 ), "c_a/=c_a_2" );
         Assert( Nearly_Equal( c_b_pov, c_b_2_pov, 0.0001 ), "c_b/=c_b_2" );
         Assert( Nearly_Equal( c_a_pov, c_d_pov, 0.0001 ), "c_a/=c_d" );
           
           
         Put_Line( "c_a_pov " );Put_Line( To_String( c_a_pov ));
         Put_Line( "c_b_pov = " );Put_Line( To_String( c_b_pov ));
         Put_Line( "c_c_pov = " );Put_Line( To_String( c_c_pov ));
      end;
   end Test_WB_CH_4;
   
   procedure Test_WB_CH_6( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   -- reproduce WB Table 6.3 with various cominations ofweights & data
   -- note table has errors:
   -- 
   --    1. uses log10 not ln for  theil 
   --    2. has N in wrong place for ge(2) - outside bracket
   --
   use MFP;
      -- all these datasets should produce near-identical inequalityresults.
      c1    : Quantile_Array( 1 .. 10 );
      c3    : Quantile_Array := c1;
      c9    : Quantile_Array( 1 .. 9 );
      c180k : Quantile_Array( 1 .. 180_000 );
      c64k  : Quantile_Array( 1 .. 60_004 );
      k     : Natural := 0;
   begin
      -- c1 is the case in the table,with 1 weights
      c1( 1 ).income := 10.0;
      c1( 2 ).income := 15.0;
      c1( 3 ).income := 20.0;
      c1( 4 ).income := 25.0;
      c1( 5 ).income := 40.0;
      c1( 6 ).income := 20.0;
      c1( 7 ).income := 30.0;
      c1( 8 ).income := 35.0;
      c1( 9 ).income := 45.0;
      c1( 10 ).income := 90.0;
      
      -- copy with 1 x 20 with weight 2
      c9( 1 ).income := 10.0;
      c9( 2 ).income := 15.0;
      c9( 3 ).income := 20.0;
      c9( 3 ).weight := 2.0;
      c9( 4 ).income := 25.0;
      c9( 5 ).income := 40.0;
      c9( 6 ).income := 30.0;
      c9( 7 ).income := 35.0;
      c9( 8 ).income := 45.0;
      c9( 9 ).income := 90.0;
      
      -- copy with constant large weight 
      c3 := c1;
      for c of c3 loop
         c.weight := 10_000.0;
      end loop;
      
      -- large repeat copy of c1, const weight
      for i in c180k'Range loop
         declare
            p : Positive := 1+(i mod 9);
         begin
            c180k(i) := c9(p);
         end;
      end loop;
      
      --
      -- very unbalanced weights - 10,000 copies of c1(1..6),
      -- 1 copy of 7..10 with 10,000 weight each
      -- 
      for i in 1 .. 10_000 loop
         for j in 1 .. 6 loop
            k := k + 1;
            c64k( k ) := c1( j );
         end loop;
      end loop;
      c64k( 60_001 ).income := 30.0;
      c64k( 60_001 ).weight := 10_000.0;
      c64k( 60_002 ).income := 35.0;
      c64k( 60_002 ).weight := 10_000.0;
      c64k( 60_003 ).income := 45.0;
      c64k( 60_003 ).weight := 10_000.0;
      c64k( 60_004 ).income := 90.0;
      c64k( 60_004 ).weight := 10_000.0;

      declare
         --
         -- 1st version of larger replicated dataset
         -- I think " * 20 " should also work, but it didn't.
         -- 
         c2  : Quantile_Array := c1&c1&c1&c1&c1&
            c1&c1&c1&c1&c1&c1&c1&c1&
            c1&c1&c1&c1&c1&c1&c1&c1&
            c1&c1&c1&c1&c1&c1&c1&c1&
            c1&c1&c1&c1&c1&c1&c1;
         ir1    : Inequality_Rec := Generate_Ineq( c1 );
         ir2    : Inequality_Rec := Generate_Ineq( c2 );
         ir3    : Inequality_Rec := Generate_Ineq( c3 );
         ir9    : Inequality_Rec := Generate_Ineq( c9 );
         ir180k : Inequality_Rec := Generate_Ineq( c180k );
         ir64k  : Inequality_Rec := Generate_Ineq( c64k );
       begin 
         Put_Line( "ir1" );
         Put_Line( To_String( ir1 ));
         Put_Line( "ir2" );
         Put_Line( To_String( ir2 ));
         Put_Line( "ir3" );
         Put_Line( To_String( ir3 ));
         Put_Line( "ir9" );
         Put_Line( To_String( ir9 ));
         Put_Line( "ir180k" );
         Put_Line( To_String( ir180k ));
         Put_Line( "ir64k" );
         Put_Line( To_String( ir64k ));
         
         Assert( Nearly_Equal( ir2, ir1, 0.0001 ), "ir1/=ir2" );
         Assert( Nearly_Equal( ir3, ir1, 0.0001 ), "ir3/=ir1" );
         Assert( Nearly_Equal( ir9, ir1, 0.0001 ), "ir9/=ir1" );
         Assert( Nearly_Equal( ir180k, ir1, 0.0001 ), "ir180k/=ir1" );
         Assert( Nearly_Equal( ir64k, ir1, 0.0001 ), "ir64k/=ir1" );
      end; 
   end Test_WB_CH_6;
   
    
  --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine( T, Test_WB_CH_4'Access, "Test Basic Poverty");
      Register_Routine( T, Test_WB_CH_6'Access, "WB Table 6.3");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( "Maths_Functions_Poverty_Inequality_Tests" );
   end Name;

end  Maths_Functions_Poverty_Inequality_Tests;