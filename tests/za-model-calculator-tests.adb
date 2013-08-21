--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

--
--  $Author: graham_s $
--  $Date: 2009-08-03 17:04:04 +0100 (Mon, 03 Aug 2009) $
--  $Revision: 7827 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;

with Ada.Text_IO;
with Ada.Text_Io.Editing;
with Ada.Numerics.Float_Random;

with Costs_Tabulator;
with Text_Utils;
with Inequality_Generator;

with ZA.Model.Calculator.Budget_Constraints;
with ZA.Model.Calculator.Runner;
with ZA.Model.Data.Binary_IO;
with ZA.Model.Data.Examples;
with ZA.Model.Params.Defaults;
with ZA.Model.Takeup;
with ZA.Model.Calculator.Wider_Output;


package body ZA.Model.Calculator.Tests is

   use AUnit.Assertions;
   use Ada.Text_IO;

   
   Target : constant Model_Target_Type := Windows;

   OUTPUT_DIR : constant String := ""; -- fill in as needed

   package mio renames ZA.Model.Data.Binary_IO;

   package za_inequality is new Inequality_Generator( Amount=>Amount, Rate=>Rate );

   procedure Test_Create_XML( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      package C_IO is new Enumeration_IO( Consumption_Range );
      
      package I_IO is new Integer_IO( Integer );
      use Text_Utils;
      f : File_Type;
   begin
      Create( f, Out_File, "c_enums.xml" );
      for i in Consumption_Range loop
         Put( f, "<EnumValue name='" );
         C_IO.Put( f, i, 0, lower_case );
         Put( f , "' value='" );I_IO.Put( f, Consumption_Range'Pos( i ) + 1, 0 );
         Put_Line( f, "'>" );
         Put( f, "   <Text lang='en'>" );Put( f, Pretty_Print( i ));Put_Line( f, "</Text>" );
         Put( f, "   <Text lang='fr'>" );Put( f, Pretty_Print( i ));Put_Line( f, "</Text>" );
         Put( f, "   <Text lang='pt'>" );Put( f, Pretty_Print( i ));Put_Line( f, "</Text>" );
         Put_Line( f, "</EnumValue>" );
      end loop;
      Close( f );
   end Test_Create_XML;
   
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      --  Add_Target( income_tax );
      Set_Output( "tmp/za.log" );

   end Set_Up;

   procedure Test_Takeup( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Takeup;
      takeup : Benefits_Array := ( Others => 0.0 );
   begin
      for i in 1 .. 1_000_000 loop
         for b in Benefits_Array'Range loop
            if( Takes_Up( b, crude_probability )) then
               takeup( b ) := takeup( b ) + 1.0;
            end if;
         end loop;
      end loop;
      for b in Benefits_Array'Range loop
         Put_Line( Personal_State_Benefits_Range'Image( b ) &
            " Takeup % = " & Amount'Image( takeup( b )/10_000.0 ));
      end loop;
   end Test_Takeup;

   procedure Test_UIT( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      use ZA.Model.Results;
      hh         : Household := Get_Example( single );
      results    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 1_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( employers_uif ) = 120.0,
         "UIT Employees at R12,000 should be 120 was " &
            Format( results.family( 1 ).person( 1 ).income( employees_uif )));
      Assert( results.family( 1 ).person( 1 ).income( employees_uif ) = 118.8,
         "UIT Employers at R12,000 should be 120 was " &
            Format( results.family( 1 ).person( 1 ).income( employees_uif )));


      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 10_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( employers_uif ) = 1_200.0,
         "IT at R120,000 should be 1,200 was " &
            Format( results.family( 1 ).person( 1 ).income( employers_uif )) &
            To_String( results.family( 1 ).person( 1 )));

      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 50_000.0;
      results := Calculate( hh, params, settings );
      Assert(
         Nearly_Equal(
            results.family( 1 ).person( 1 ).income( employers_uif ), 1_497.36 ),
         "IT at R50,000 should be 1,497.36 was " &
            Format( results.family( 1 ).person( 1 ).income( employers_uif )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 100_000.0;
      results := Calculate( hh, params, settings );
      Assert(
         Nearly_Equal(
            results.family( 1 ).person( 1 ).income( employers_uif ), 1_497.36 ),
         "IT at R100,000 should be 1,497.36 was " &
            Format( results.family( 1 ).person( 1 ).income( employers_uif )));
   end Test_UIT;

   procedure Test_Health(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      use ZA.Model.Results;
      hh         : Household := Get_Example( family_2_kids );
      results1    : Household_Result;
      results2    : Household_Result;
      results3    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- Replicate the ases from section 7.1 'Comprehensive Guide to I2S 2007 version
      -- should be in docs dir and on SARS site.
      --
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN
      --
      --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 150_000.0;
      hh.family( 1 ).person( 1 ).expenses( health_spending ) := 9_500.0;
      hh.family( 1 ).person( 1 ).expenses( health_insurance ) := 12_000.0;
      hh.family( 1 ).person( 1 ).expenses( pension_contributions ) := 30_000.0;
      hh.family( 1 ).person( 1 ).in_kind_and_from_employer_expenses( health_insurance ) := 24_000.0;

      --
      -- case 1 : 12k person 24k employer
      --
      results1 := Calculate( hh, params, settings );
      Assert( results1.family( 1 ).person( 1 ).deductions( pension_contributions ) = 11_250.0,
         " pension contribs should be 11,250 were " &
            Format( results1.family( 1 ).person( 1 ).deductions( pension_contributions )));
      Assert( Amount'Ceiling( results1.family( 1 ).person( 1 ).deductions( health_insurance )) = 12_981.0,
         " health contribs case 1 should be 12,981 were (not rounded) "&
            Format( results1.family( 1 ).person( 1 ).deductions( health_insurance )));
      --
      -- case 2 : 24k person 12k employer
      --
      hh.family( 1 ).person( 1 ).expenses( health_insurance ) := 24_000.0;
      hh.family( 1 ).person( 1 ).in_kind_and_from_employer_expenses( health_insurance ) := 12_000.0;
      results2 := Calculate( hh, params, settings );
      Assert( Amount'Ceiling( results2.family( 1 ).person( 1 ).deductions( health_insurance )) = 24_741.0,
         " health contribs case 2 should be 24,741 were (not rounded) "&
            Format( results2.family( 1 ).person( 1 ).deductions( health_insurance )));
      --
      -- case 3 : 36,000 employee 0 employer
      --
      hh.family( 1 ).person( 1 ).expenses( health_insurance ) := 36_000.0;
      hh.family( 1 ).person( 1 ).in_kind_and_from_employer_expenses( health_insurance ) := 0.0;
      results3 := Calculate( hh, params, settings );
      Assert( Amount'Ceiling( results3.family( 1 ).person( 1 ).deductions( health_insurance )) = 36_741.0,
         " health contribs case 3 should be 36,741  were (not rounded) "&
            Format( results3.family( 1 ).person( 1 ).deductions( health_insurance )));

   end Test_Health;

   procedure Test_Income_Tax( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      use ZA.Model.Results;
      hh         : Household := Get_Example( single );
      results    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN

      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 1_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 0.0,
         "IT at R12,000 should be zero was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 10_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 11_844.0,
         "IT at R120,000 should be 11,844 was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )) &
            To_String( results.family( 1 ).person( 1 )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 50_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 173_204.0,
         "IT at R50,000 should be 173,204.0 was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 100_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 413_204.0,
         "IT at R100,000 should be 413,204.0 was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
   end Test_Income_Tax;

   procedure Test_Pension( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      hh         : Household := Get_Example( single_pensioner );
      results    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN
      --
      -- single no income
      --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 0.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( old_age_pensions ) = 1_010.00 * 12.0,
         "single zero income; should be 1_010 * 12 was " &
         Format( results.family( 1 ).person( 1 ).income( old_age_pensions ) ));
      --
      -- single at threshold
      --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 29_112.01;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( old_age_pensions ) = 0.0,
         "single has income at threshold; should be 0 was " &
         Format( results.family( 1 ).person( 1 ).income( old_age_pensions ) ));
      --
      -- 0 income couple
      --
      hh := Get_Example( couple_pensioner );
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 0.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( old_age_pensions ) = 1_010.00 * 12.0,
          "couple person 1 zero income; should be 1_010 * 12 each was " &
         Format( results.family( 1 ).person( 1 ).income( old_age_pensions ) ));
      Assert( results.family( 1 ).person( 2 ).income( old_age_pensions ) = 1_010.00 * 12.0,
          "couple person 2 zero income; should be 1_010 * 12 each was " &
         Format( results.family( 1 ).person( 2 ).income( old_age_pensions ) ));
      --
      -- income just above threshold
      --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 58_224.01;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( old_age_pensions ) = 0.0,
          "couple person 1 income > thresh should be 0 each was " &
         Format( results.family( 1 ).person( 1 ).income( old_age_pensions ) ));
      Assert( results.family( 1 ).person( 2 ).income( old_age_pensions ) = 0.0,
          "couple person 2 income > thresh; should be 0 each was " &
         Format( results.family( 1 ).person( 2 ).income( old_age_pensions ) ));
       --
      -- income just above threshold
      --
      hh := Get_Example( couple_pensioner );
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 0.0;
      hh.family( 1 ).person( 2 ).age := 58;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( old_age_pensions ) = 1_010.00 * 12.0,
          "couple person 1 zero income; should be 1_010 * 12 each was " &
         Format( results.family( 1 ).person( 1 ).income( old_age_pensions ) ));
      Assert( results.family( 1 ).person( 2 ).income( old_age_pensions ) = 0.0,
          "couple person 2 zero income but 58 yo; should be 0 was " &
         Format( results.family( 1 ).person( 2 ).income( old_age_pensions ) ));

   end Test_Pension;

   procedure Test_Child_Support_Grant( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      hh         : Household := Get_Example( family_2_kids );
      results    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN
      --
      -- single no income
      --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 0.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 3 ).income( family_allowances ) = 240.00 * 12.0,
         "child support single zero income kid 1; should be 2040 * 12.0 was " &
         Format( results.family( 1 ).person( 1 ).income( family_allowances ) ));
      Assert( results.family( 1 ).person( 3 ).income( family_allowances ) = 240.00 * 12.0,
         "child support single zero income kid 4; should be 2040 * 12.0 was " &
         Format( results.family( 1 ).person( 4 ).income( family_allowances ) ));

      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 57_600.00;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 3 ).income( family_allowances ) = 240.00 * 12.0,
         "child support income = thresh kid 1; should be 2040 * 12.0 was " &
         Format( results.family( 1 ).person( 1 ).income( family_allowances ) ));
      Assert( results.family( 1 ).person( 3 ).income( family_allowances ) = 240.00 * 12.0,
         "child support income = thresh kid 4; should be 2040 * 12.0 was " &
         Format( results.family( 1 ).person( 4 ).income( family_allowances ) ));
      Put_Line( "Net Incomes with 2 kids; income at threshold" );
      Put_Line( To_String( results ));

      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 57_600.01;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 3 ).income( family_allowances ) = 0.0,
         "child support single income > thresh kid 1; should be 0 was " &
         Format( results.family( 1 ).person( 1 ).income( family_allowances ) ));
      Assert( results.family( 1 ).person( 3 ).income( family_allowances ) = 0.0,
         "child support single income > thresh kid 4; should be 0 was " &
         Format( results.family( 1 ).person( 4 ).income( family_allowances ) ));
   end Test_Child_Support_Grant;

   procedure Test_Disability_Grant( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      hh         : Household := Get_Example( family_2_kids );
      results    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN
      --
      -- single no income
      --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 0.0;
      hh.family( 1 ).person( 2 ).is_disabled_or_blind := True;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.00 * 12.0,
         "disabled zero income pers 2; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.0 * 12.0,
         "disabled zero income pers 2; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      -- both disabled
      hh.family( 1 ).person( 1 ).is_disabled_or_blind := True;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.00 * 12.0,
         "2 dis disabled zero income pers 2; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.0 * 12.0,
         "2 dis disabled zero income pers 2; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 1 ).income( disability_grants ) = 1_010.00 * 12.0,
         "2 dis disabled zero income pers 1; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.0 * 12.0,
         "2 dis disabled zero income pers 1; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));

      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 58_224.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.00 * 12.0,
         "income on thresh: 2 disabled disabled pers 2; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.0 * 12.0,
         "income on thresh: 2 disabled disabledpers 2; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 1 ).income( disability_grants ) = 1_010.00 * 12.0,
         "income on thresh: 2 disabled disabledpers 1; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 1_010.0 * 12.0,
         "income on thresh: 2 disabled disabled pers 1; should be 1,010 * 12.0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
         --
         -- add 1 cebt to wife
         --
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 58_224.0;
      hh.family( 1 ).person( 2 ).income( interest_received ) := 0.01;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 0.0,
         "income 0.01 above thresh: 2 disabled disabled pers 2; should be 0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 0.0,
         "income 0.01 above thresh: 2 disabled disabled pers 2; 0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 1 ).income( disability_grants ) = 0.0,
         "income 0.01 above thresh: 2 disabled disabled pers 1; should be 0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));
      Assert( results.family( 1 ).person( 2 ).income( disability_grants ) = 0.0,
         "income 0.01 above thresh: 2 disabled disabled  pers 1; should be 0 was " &
         Format( results.family( 1 ).person( 2 ).income( disability_grants ) ));

   end Test_Disability_Grant;

   procedure Test_Income_Tax_Pens( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Data.Examples;
      hh         : Household := Get_Example( single_pensioner );
      results    : Household_Result;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 1_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 0.0,
         "Pensioner: IT at R12,000 should be zero was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 10_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 6_444.0,
         "Pensioner: IT at R120,000 should be 6,444 was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 50_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 167_804.0,
         "Pensioner: IT at R50,000 should be 167,804.0 was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
      hh.family( 1 ).person( 1 ).income( salaries_and_wages ) := 12.0 * 100_000.0;
      results := Calculate( hh, params, settings );
      Assert( results.family( 1 ).person( 1 ).income( site_income_tax ) = 407_804.0,
         "Pensioner: IT at R100,000 should be 407,804.0 was " &
            Format( results.family( 1 ).person( 1 ).income( site_income_tax )));
   end Test_Income_Tax_Pens;

   procedure Test_Budget_Constraints( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use ZA.Model.Calculator.Budget_Constraints;
      use ZA.Model.Data.Examples;
      use Gross_And_Net_Package;
      use Text_Utils;

      procedure Print( pos : Cursor ) is
         p : Gross_And_Net;
      begin
         p := Element( pos );
         Put_Line( " gross " & TAB & Amount'Image( p.gross ) &
            TAB & " net " & TAB & Amount'Image( p.net ));
      end Print;


      hh         : Household;
      points     : Gross_And_Net_List;
      settings   : Run_Settings := Get_Default_Settings( OUTPUT_DIR,  target=>Target );
      params     : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   begin
      --
      -- turn off employer's UIT so the income below are assumed net of this
      --
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate=>0.00, band=>Amount'Last ), 1 ); -- CHECK AGAIN
      for t in Example_Types'Range loop
         hh := Get_Example( t );
         Put_Line( Example_Types'Image( t ));
         points :=  Generate_Budget_Constraint( hh, params, settings, 1, 1 );
         Put_Line( "BC Points are: " );
         Iterate( points, Print'Access );
         Put_Line( "Ends" );
      end loop;
   end Test_Budget_Constraints;


   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      null;
      Register_Routine (T, Test_Create_XML'Access, "Test Create XML" );
      Register_Routine (T, Test_Takeup'Access, "Test Takeup" );
      Register_Routine (T, Test_Income_Tax'Access, "Test Income Tax" );
      Register_Routine (T, Test_Income_Tax_Pens'Access, "Test Pensioner Income Tax" );
      Register_Routine (T, Test_Health'Access, "Test Health Deductions" );
      Register_Routine (T, Test_UIT'Access, "Test UIT" );
      Register_Routine (T, Test_Pension'Access, "Test Pension" );
      Register_Routine (T, Test_Child_Support_Grant'Access, "Test Child Grant" );
      Register_Routine (T, Test_Disability_Grant'Access, "Test Disability Grant" );
      Register_Routine (T, Test_Budget_Constraints'Access, "Test BCs" );
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( "South Africa calculations unit tests." );
   end Name;

end ZA.Model.Calculator.Tests;
