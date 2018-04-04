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
      
      country_a : Quantile_Array( 1 .. 4 ); 
      country_b : Quantile_Array( 1 .. 4 ); 
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
      
      country_a_2( 1 ).income := 100.0;
      country_a_2( 1 ).weight := 2.0;
      country_a_2( 2 ).income := 150.0;
      country_a_2( 2 ).weight := 2.0;
      country_b_2 := country_a_2;
      country_b_2( 1 ).income := 124.0;
      declare
         line : constant Amount := 125.0;
         c_a_pov : Poverty_Rec := Generate_Pov( country_a, line );
         c_b_pov : Poverty_Rec := Generate_Pov( country_b, line );
         c_a_2_pov : Poverty_Rec := Generate_Pov( country_a_2, line );
         c_b_2_pov : Poverty_Rec := Generate_Pov( country_b_2, line );
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
         Assert( Nearly_Equal( c_a_pov.gap, 0.1 ), "Headcount: p_a /= 0.1 "  
           & To_String( c_a_pov )); 
         Assert( Nearly_Equal( c_b_pov.gap, 1.0/250.0 ), "GAP: p_b_2 /= 1/250 " 
           & To_String( c_b_pov )); 
         Put_Line( "finished! c_a_pov = " & To_String( c_a_pov ));
         Put_Line( "finished! c_b_pov = " & To_String( c_b_pov ));
      end;
   end Test_WB_CH_4;
   
  --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      null;
      -- Register_Routine (T, Test_Calculate_National_Insurance'Access, "Test_Calculate_National_Insurance");
      Register_Routine( T, Test_WB_CH_4'Access, "Test Basic Poverty");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end  Maths_Functions_Poverty_Inequality_Tests;