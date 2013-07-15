--
--  $Author: graham_s $
--  $Date: 2010-02-11 20:08:09 +0000 (Thu, 11 Feb 2010) $
--  $Revision: 8616 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;             
with Base_Model_Types;             
with Model.Household;              
with Tax_Utils;                    

with Model.Parameters;                 
with Model.Calculations;    
with Model.Output;
with Model.Parameters.Legal_Aid;                 
with Model.Calculations.Legal_Aid;
with Model.Output.Legal_Aid;

with Test_Households;               

with Ada.Text_IO;
with Ada.Strings.Fixed;   
with Ada.Strings;   
with format_utils;
with text_utils;
with HTML_Utils;
with legal_aid_output_types; 
-- with legal_aid_runner;
with Model.Run_Settings;
with Model.Equivalence_Scales;
with frs_enums; 
with Model.Incomes;

package body Legal_Aid_Tests is

   use text_utils.Std_Bounded_String;
   use AUnit.Assertions;
   use Model.Incomes;
   
   use Ada.Text_IO;
   use Ada.Strings;
   
   use frs_enums;
   
   use base_model_types;
   use Model.Household;
   use test_households;
   
   use Model.Parameters.Legal_Aid;                 
   use Model.Calculations.Legal_Aid;
   use Model.Calculations;
   use Model.Parameters;
   use Model.Output.Legal_Aid;
   use Legal_Aid_Output_Types;
   
   test_households : Test_Household_Array;
   default_parameters : Legal_Aid_Sys;



   procedure Set_Up ( T : in out Test_Case ) is
   begin
      default_parameters := Get_Default_System;
      test_households := makeExampleHouseholds;
   end Set_Up;

   procedure Test_Equivalisation ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      scale : Rate := -999.99;
      equiv_hhlds : constant Test_Household_Array := make_Equiv_Example_Households;
      eq1, eq2, eq3, eq4 : Amount;
   begin
      scale := Model.Equivalence_Scales.Calculate_McLements_Scale ( test_households(1).benefit_units(1));
      assert ( scale = 0.88, "single parent with 1 kid should be 0.61+0.27=0.88; was " & scale'Img );
      scale := Model.Equivalence_Scales.Calculate_McLements_Scale ( test_households(2).benefit_units(1));
      assert ( scale = 1.95, "single parent with 1 kid should be 0.61+1.95; was " & scale'Img );
      --
      -- test cases from pp 29- of cmd
      --
      eq1 := Model.Equivalence_Scales.equivalise_income(equiv_hhlds(1).benefit_units(1), 24000.0 );
      assert( eq1 = 39_344.26, "equivlised income case 1: should be 39_344; was " & eq1'Img );
      eq2 := Model.Equivalence_Scales.equivalise_income(equiv_hhlds(2).benefit_units(1), 24000.0 );
      assert( eq2 = 24_000.0, "equivlised income case 2: should be 24,000; was " & eq2'Img );
      eq3 := Model.Equivalence_Scales.equivalise_income(equiv_hhlds(3).benefit_units(1), 24000.0 );
      assert( eq3 = 20_338.98, "equivlised income case 3: should be 20_338.98; was " & eq3'Img );
      eq4 := Model.Equivalence_Scales.equivalise_income(equiv_hhlds(4).benefit_units(1), 24000.0 );
      assert( eq4 = 17_266.19, "equivlised income case 3: should be 17266; was " & eq4'Img );      
   end Test_Equivalisation;

	--
        --  These attempt to reproduces the 4 case studies on p6-7 of
        --  cmd  6678
        --
        procedure Make_CDS_Case_Studies ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
                scale : Rate := -999.99;
                hhlds : constant Test_Household_Array := make_Criminal_Households;
		--
                -- FIXME no criminal defined
                sys :Legal_Aid_Sys := Get_default_System;
                results : One_LA_Output;
                results2 : LA_Output_Array;
        begin
                Calc_One_BU_Legal_Aid ( hhlds (1),
                                   	1,
                                        results,
                                        sys,

                                  	normal_claim );
                put( To_String( results ));
                assert( results.gross_income = 39_344.26, "cda case 1: gross income should be 39_344; was " & results.gross_income'Img );
                assert( results.net_income = 24_000.0, "cda case 1: net income should be 39_344; was " &  results.net_income'Img ); -- note this is NOT equivalised
                assert( results.disposable_income = 18_702.76, "cda case 1: disposable income should be 34047.02; was "&results.disposable_income'Img );
                assert( results.la_State = disqualified, " should be disqualified " );
                results2 := Calc_One_HH_Legal_Aid ( hhlds (2),
                                        sys,
                                  	normal_claim,
                                        false );

                put( To_String( results2(1) ));
                assert( results2(1).gross_income = 24_000.0, "case 2: gross income should be 24,000 but was: "&results2(1).gross_income'Img );
                assert( results2(1).net_income = 17_876.0-5520.0, "case 2: net income should be 17,876 but was: "&results2(1).net_income'Img );
                assert( results2(1).disposable_income = 3672.0, "case 2: disposable income should be 3672 bus was:"&results2(1).disposable_income'Img );
                assert( results2(1).la_State = disqualified, " 2; should be disqualified " );

                results2 := Calc_One_HH_Legal_Aid ( hhlds(3),
                                        sys,
                                  	normal_claim,
                                        false );
                put( To_String( results2(1) ));
                assert( results2(1).gross_income = 20_338.98, "case 3: gross income should be 20,338.98 but was: "&results2(1).gross_income'Img );
                assert( results2(1).net_income = 17_876.0-5520.0, "case 3: net income should be 17,876 but was: "&results2(1).net_income'Img );
                assert( results2(1).disposable_income = 2108.88, "case 3: disposable income should be 2108.98 bus was:"&results2(1).disposable_income'Img );
                assert( results2(1).la_State = partially_entitled, "case 4; should be part entiteled was"& results2(1).la_State'Img);

                results2 := Calc_One_HH_Legal_Aid ( hhlds(4),
                                        sys,
                                  	normal_claim,
                                        false );
                put( To_String( results2(1) ));
                assert( results2(1).gross_income = 17_266.19, "case 4: gross income should be 20,338.98 but was: "&results2(1).gross_income'Img );
                assert( results2(1).la_State = fully_entitled, "case 4; should be fully_entitled but was"&results2(1).la_State'Img );

        end Make_CDS_Case_Studies;

        procedure testchild_allowances ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
                allow : Amount;
        begin
                allow := Calc_Child_Allowances(
                        test_households(1).benefit_units(1),
                        default_parameters.allow( income ).child_age_limit,
                        default_parameters.allow( income ).child_allowance );
                assert( (allow = 2377.0), " hh1 allowances should be 2377; got " & allow'Img );
                allow := Calc_Child_Allowances(
                        test_households(2).benefit_units(1),
                        default_parameters.allow( income ).child_age_limit,
                        default_parameters.allow ( Income ).child_allowance );
                put( "got allowances as " & allow'Img );
                assert( allow = Amount(2377.0)*Amount(3.0), " hh2 allowances should be 7131 got " & allow'Img );
        end testchild_allowances;



        procedure testIncomes ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
                ne1 : Amount := 0.0;
                results : One_LA_Output;
        begin
                ne1 := Calc_One_Income(
                        test_households(1).benefit_units(1).adults( head ).incomes,
                        default_parameters.incomesList );
                assert( ne1 = 9900.0," Calc_One_Income should be 9900.0 was " & ne1'Img );
                Calc_Gross_Income( test_households (1).benefit_units (1),
                                    default_parameters,
                                    results );

                Make_Personal_Income ( test_households (1).benefit_units (1).adults( head ),
                                    default_parameters,
                                    results );
                assert ( results.assessable_Income = 9900.0,
                           " testIncomes(2) netinc should be 9900.0 was" & results.assessable_Income'Img );
                assert ( results.gross_Income = 0.0,
                        " testIncomes(2) netinc should be 10000.0 was" & results.gross_Income'Img );

                test_households(1).benefit_units(1).adults( head ).incomes(luncheon_vouchers) :=  Amount(0.15)  * Amount(5.0);
                Make_Personal_Income( test_households(1).benefit_units(1).adults( head ), default_parameters, results );
                assert ( results.benefits_In_Kind = 0.0,
                        " Make_Personal_Income(3) should be 0 was " & results.benefits_In_Kind'Img);

                test_households(1).benefit_units(1).adults( head ).incomes(luncheon_vouchers) :=  Amount(10.0) + (Amount(0.15)  * Amount(5.0));
                Make_Personal_Income ( test_households (1).benefit_units (1).adults ( head ), default_parameters, results );
                Calc_Benefits_In_Kind( test_households (1).benefit_units (1),  default_parameters, results );
                assert ( results.benefits_In_Kind = 10.0,
                        "Make_Personal_Income(4) should be 10 was " & results.benefits_In_Kind'Img );

                test_households(1).benefit_units(1).adults( head ).has_Company_Car := true;
                results.benefits_In_Kind := 0.0;

                Make_Personal_Income ( test_households (1).benefit_units (1).adults ( head ), default_parameters, results );
                Calc_Benefits_In_Kind( test_households (1).benefit_units (1),  default_parameters, results );
                assert ( results.benefits_In_Kind = 3010.0,
                        "Make_Personal_Income (5) should be 3010 was: " & results.benefits_In_Kind'Img );

        end testIncomes;


   procedure testRentshare_deduction ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      results : LA_Output_Array;
      rent_Share_Deduction : Amount := 0.0;
   begin
      --  2 adults in 2nd bu hh2, so should be 0.15 * 2931.0
      rent_Share_Deduction :=  Calc_Rent_Share_Deduction ( test_households (1),
                                                   default_parameters,
                                                   normal_claim );
      assert( rent_Share_Deduction = 0.0, "Rentshare_deduction; case 1 should be 0" );
      rent_Share_Deduction :=  Calc_Rent_Share_Deduction ( test_households (3),
                                                   default_parameters,
                                                   normal_claim );
      
      assert ( rent_Share_Deduction = 439.65 * 2.0,
            "2 adults in 2nd bu hh2, so should be 0.15 * 2931.0; got: " &  rent_Share_Deduction'Img );
   end testRentshare_deduction;

   procedure testHouseholders_Housing_Costs ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      housing_Costs : Model_Housing_Costs;
      hcosts : Amount := 0.0;
   begin
      housing_Costs := rentHcosts;
      hcosts := Householders_Housing_Costs( rents, housing_Costs );
      assert( hcosts = 10000.0, "rented tests; should be 10000.0; is actually " & hcosts'Img );
      hcosts := Householders_Housing_Costs( buying_with_the_help_of_a_mortgage, housing_Costs );
      assert( hcosts = 13500.0, "mortgaged costs; should be 13500.0 got " & hcosts'Img );
   end testHouseholders_Housing_Costs;

   procedure testExpenses_Ops ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      exp : One_Expense;
      x   : Amount := 0.0;
   begin
      exp.is_flat := false;
      exp.amount := 1.0;
      x := Expenses_Op ( 10.0, exp );
      assert ( x = 10.0, "testExpenses_Ops 1; should be 10; got " & x'Img );
      exp.amount := 1.0 / 3.0;
      x := Expenses_Op ( 10.0, exp );
      assert ( x = 3.33, "testExpenses_Ops 2; should be 3.33; got " & x'Img );
      exp.is_flat := true;
      exp.amount := 1.0;
      x := Expenses_Op ( 10.0, exp );
      assert ( x = 1.0, "testExpenses_Ops 3; should be 1.0; got " & x'Img );
      exp.amount := 12.0;
      x := Expenses_Op ( 10.0, exp );
      assert ( x = 10.0, "testExpenses_Ops 4; should be 10.0; got " & x'Img );
   end testExpenses_Ops;


   procedure testPassporting ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      assert ( not Passport_Person ( test_households(2).benefit_units (1).adults (head), default_parameters ),
            "passport hh2(2).head" );
      assert ( Passport_Person ( test_households(2).benefit_units (1).adults (spouse), default_parameters ),
            "passport hh2(2).spouse" );
      assert ( not Passport_Benefit_Unit ( test_households(1).benefit_units (1), default_parameters ),
            "passport hh1(2)" );
      assert ( Passport_Benefit_Unit ( test_households(2).benefit_units (1), default_parameters ),
            "passport hh2(2)" );
   end  testPassporting;

   procedure testCapital ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      assert ( Earned_Capital_Disregard ( 1600.0, default_parameters.capital_disregard ( Pensioner ) ) = 20000.0,
            " cap dis income 1870, pensioner" );
      assert ( Earned_Capital_Disregard ( 1600.0, default_parameters.capital_disregard ( NonPensioner ) ) = 0.0,
            " cap dis income non pensioner" );
      assert ( Earned_Capital_Disregard ( 1601.0, default_parameters.capital_disregard ( Pensioner ) ) = 15000.0,
            " cap dis income 5000" );
      assert ( Earned_Capital_Disregard ( 1601.0, default_parameters.capital_disregard ( NonPensioner ) ) = 0.0,
            " cap dis income 1871 non pens" );
      assert ( Earned_Capital_Disregard ( 0.0, default_parameters.capital_disregard ( Pensioner ) ) = 35000.0,
            " cap dis income 0" );
   end testCapital;

   procedure testAllowances ( T : in out AUnit.Test_Cases.Test_Case'Class ) is
          results : One_LA_Output;
   begin
       Calc_Allowances( test_households(1).benefit_units(1), default_parameters.allow(income), results );
       assert ( results.allowances = 2_377.0,
                 "allowances for hh(1)(1) was "  & results.allowances'Img );
       results.allowances  := 0.0;
       Calc_Allowances( test_households(2).benefit_units(1), default_parameters.allow(income), results );
       assert ( results.allowances = 1_702.0 + (2_377.0*3.0),
                 "allowances for hh(2)(1) was " & results.allowances'Img );
   end testAllowances;

   procedure testCapitalAllowances( T : in out AUnit.Test_Cases.Test_Case'Class ) is
          results : One_LA_Output;
   begin
      results.disposable_Income := 2000.0;
      Calc_Capital_Allowances( test_households(4).benefit_units(1), default_parameters, results );
      assert ( results.capital_Allowances = 5000.0,
            " cap allow hh3; should be 5000; got " & results.capital_Allowances'Img );
      test_households(4).benefit_units(1).adults( head ).age := 25;
      Calc_Capital_Allowances( test_households(4).benefit_units(1), default_parameters, results );
      assert ( results.capital_Allowances = 0.0,
            "cap allow hh4 young should be 0; got" & results.capital_Allowances'Img );
   end testCapitalAllowances;


   procedure testFullSystem(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
          res : One_LA_Output;
   begin
      Calc_One_BU_Legal_Aid ( test_households (1),
                        1,  res,
                            default_parameters,
                            normal_claim );
      --  assert( res.housing_Costs = 17500.0, "housing costs should be 17500; were " & res.housing_Costs'Img );
      assert( res.allowances = 2_288.28, "allowances should be 2_288.28 (1 child) was: " &res.allowances'Img  );
      assert( res.disposable_Income =  7611.72, " disposable should be 7611.72; was: "&res.disposable_Income'Img );
      assert ( res.la_State = partially_entitled, " hh1 should be part; was " & res.la_State'Img );
      res := New_Output;
      Calc_One_BU_Legal_Aid( test_households(2), 1,
                            res,
                            default_parameters,
                            normal_claim );
      assert( res.allowances = 0.0, "hh2 allowances should be 0; was "&res.allowances'Img );
      assert( res.disposable_Income = 0.0, "disposable should be 0; was "&res.disposable_Income'Img );
      assert( res.la_State = passported, "hh2 should be passported; is"& res.la_State'Img  );
      res := New_Output;
      Calc_One_BU_Legal_Aid( test_households(5), 1,
                            res,
                            default_parameters,
                            normal_claim );
      assert( res.disposable_Capital = 5000.0,  "hh5 should be 5000 was "& res.disposable_Capital'Img );
      assert( res.capital_Contribution = 2000.0, "capital contrib 2000; was " &res.capital_Contribution'Img  );
      assert ( res.la_State = partially_entitled, "LA state partial; was: " & res.la_State'Img );
      put( To_String( res ) );
   end testFullSystem;




        --------------------
        -- Register_Tests --
        --------------------

   procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, testchild_allowances'Access, "child_Allowances");
      Register_Routine (T, testRentshare_deduction'Access, "test Rent Share Deductions");
      Register_Routine (T, testHouseholders_Housing_Costs'Access, "test Householders Housing Costs ");
      Register_Routine (T, testExpenses_Ops'Access, "test Expenses_Ops ");
      Register_Routine (T, testIncomes'Access, "test incomes" );
      Register_Routine (T, testCapital'Access, "test capital" );
      Register_Routine (T, testPassporting'Access, "test passporting" );
      Register_Routine (T, testAllowances'Access, "test allowances" );
      Register_Routine (T, testCapitalAllowances'Access, "test capital allowances" );
      Register_Routine (T, testFullSystem'Access, "full system, pt1" );
      Register_Routine (T, Test_Equivalisation'Access, "testEquivalisation" );
      Register_Routine (T, Make_CDS_Case_Studies'Access, "CDS Case Studies" );
   end Register_Tests;

        ----------
        -- Name --
        ----------

   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format("Legal Aid calculations unit tests.");
   end Name;

end Legal_Aid_Tests;
