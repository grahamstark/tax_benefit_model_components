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
--  $Date: 2010-02-11 19:11:22 +0000 (Thu, 11 Feb 2010) $
--  $Revision: 8612 $
--
pragma License( Modified_GPL );

with Ada.Text_IO;
with Ada.Containers;
with Ada.Calendar;
with Model.Example_Household.Cases;
with Model.Example_Household.Impl;
with Model.Example_Household.Cases;
with Model.Example_Results;
with Model.Example_Results.Impl;
with Model.Parameter_System;
with Model.Parameter_System.Defaults;
with Model.Parameter_System.Operations;
with UK_Test_Utils;

with Model.Abstract_Household;

with AUnit.Assertions;

package body Model.Calculator.Direct_Tax.Tests is

   use AUnit.Assertions;
   use Ada.Calendar;
   use Ada.Text_IO;
   use Ada.Containers;
   use Model.Example_Household;
   use UK_Test_Utils;

   subtype A_Pers is Abstract_Household.Person'Class;
   subtype A_HH is Abstract_Household.Household'Class;
   subtype A_Res is mar.Personal_Result'Class;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   function Make_Complete_System( year :Year_Number )return Complete_System is
      sys : Complete_System := Defaults.Get_Complete_System( year );
   begin
      Operations.To_Weekly( sys ); 
      return sys;
   end Make_Complete_System;
   
   procedure Test_Calculate_National_Insurance( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Example_Household.Cases;
      use Model.Example_Results.Impl;
      ni_sys  : National_Insurance_System := 
         Model.Parameter_System.Defaults.Get_National_Insurance_System( 2015 );
      pen_sys : Pension_System := 
         Model.Parameter_System.Defaults.Get_State_Pension( 2015 );
   begin
      Operations.To_Weekly( ni_sys );
      for ext in hmrc_ni_example_1 .. se_example_2 loop
         Put_Line( "on household " & ext'Img );
         declare
            mhh     : Impl.Model_Household := ( Get_Household( ext ) with null record );
            pids    : Sernum_Set := mhh.Get_PIDs;
         begin
            for pid of pids loop
               declare
                  pers : A_Pers := mhh.Find_Person( pid );
                  res : Model_Personal_Result;
               begin
                  Put_Line( "on person " & pers.pid'Img & " age " & pers.age'Img );
                  res.Zero;
                  Calculate_National_Insurance( ni_sys, pen_sys, pers, res );
                  declare
                     ni : Amount := res.Get( national_insurance );
                     empl_ni : Amount := res.Get( employers_ni );
                  begin
                     Put( "Wage: " & Format( pers.Get_Income( wages )));
                     Put( "; Profits: " & Format( pers.Get_Income( self_employment )));
                     Put( "; NI: " & Format( ni ));
                     Put_Line( "; Empl NI: " & Format( empl_ni ));
                     case ext is
                        when hmrc_ni_example_1 =>
                           Assert( Within_1P( ni, 0.0 ), " ex. 1 should be 0.0; was " & Format( ni ));
                           Assert( Within_1P( empl_ni, 0.0 ), " ex. 1 empl_ni should be 0.0; was " & Format( ni ));
                        when hmrc_ni_example_2 =>
                           Assert( Within_1P( ni, 81.48 ), " ex. 2 should be 81.48; was " & Format( ni ));
                           Assert( Within_1P( empl_ni, 98.40 ), " ex. 2 exmpl ni should be 98.40; was " & Format( empl_ni ));
                        when hmrc_ni_example_4 =>
                           Assert( Within_1P( ni, 80.78 ), " ex. 4 should be 80.78; was " & Format( ni ));
                           Assert( Within_1P( empl_ni, 0.97 ), " ex. 4 exmpl ni should be 0.97 ; was " & Format( empl_ni ));
                        when hmrc_ni_example_7 =>
                           Assert( Within_1P( ni, 84.09 ), " ex. 7 should be 84.09; was " & Format( ni ));
                           Assert( Within_1P( empl_ni, 23.88 ), " ex. 7 exmpl ni should be 23.88 ; was " & Format( empl_ni ));
                        when se_example_1 =>
                           Assert( Within_1P( ni, 6.16 ), " se_case_1 should be 6.16; was " & Format( ni ));
                           Assert( Within_1P( empl_ni, 0.0 ), " se_case_1 ni should be 0.0 ; was " & Format( empl_ni ));
                        when se_example_2 =>
                           Assert( Within_1P( ni, 66.73 ), " se_case_2 should be 66.73; was " & Format( ni ));
                           Assert( Within_1P( empl_ni, 0.0 ), " se_case_2 exmpl ni should be 0.0 ; was " & Format( empl_ni ));
                           
                     end case;
                  end;
               end;
            end loop;
         end;
      end loop;
   end Test_Calculate_National_Insurance;
   
   
   procedure Test_Calculate_Income_Tax( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Example_Household.Cases;
      use Model.Example_Results.Impl;
      sys : Complete_System := Make_Complete_System( 2015 );
     
   begin
      Families:
      for ext in Example_Type loop
         Put_Line( "HHLD " & ext'Img );
         Put_Line( "pno,wages,dividends,bank_interest,ni,income_tax" );
                              
         declare
            mhh  : Impl.Model_Household := ( Get_Household( ext ) with null record );
            ss  : Sernum_Set_List := mhh.Get_Default_Benefit_Unit_PIDs;
            sn  : Sernum_Set := ss.Element( 1 );
            pno : Person_Number := 1;
            res : Model_Household_Result := Initialise( mhh );
         begin
            Assert( ss.Length = 1, "ss length always 1; was " & ss.Length'Img );
            People:
            for pid of sn loop
               Income_Type:
               for inctype in 1 .. 3 loop
                  declare
                     income : Amount := 0.0;
                  begin
                     Incomes:
                     for i in 1 .. 50 loop
                        case inctype is
                        when 1 => mhh.Set_Income( pid, wages, income );
                                  mhh.Set_Income( pid, dividends, 100.0 );
                                  mhh.Set_Income( pid, bank_interest, 100.0 );
                        when 2 => mhh.Set_Income( pid, dividends, income );
                                  mhh.Set_Income( pid, wages, 500.0 );
                                  mhh.Set_Income( pid, bank_interest, 100.0 );
                        when 3 => mhh.Set_Income( pid, bank_interest, income );
                                  mhh.Set_Income( pid, wages, 500.0 );
                                  mhh.Set_Income( pid, dividends, 100.0 );                                     
                       end case;
                        declare
                           pers   :  A_Pers := mhh.Find_Person( pid );
                           pers_result : A_Res := res.Get_Personal( pid );
                        begin
                           
                           Calculate_Income_Tax( 
                              sys.it, 
                              pers,
                              pers_result );
                           Calculate_National_Insurance( 
                              sys.ni, 
                              sys.benefits.state_pension,
                     
                              pers,
                              pers_result );
                           res.Set( pers.pid, pers_result );   
                           declare
                              it             : Amount := pers_result.Get( income_tax );
                              ni             : Amount := pers_result.Get( national_insurance );
                              wage           : Amount := pers.Get_Income( wages );
                              dividend       : Amount := pers.Get_Income( dividends );
                              bank_intr      : Amount := pers.Get_Income( bank_interest );
                              gross          : Amount := pers_result.Get( gross_income );
                            begin
                              Put_Line( 
                                 pno'Img & ","
                                 & Format( wage ) & "," 
                                 & Format( dividend ) & "," 
                                 & Format( bank_intr ) & "," 
                                 & Format( ni ) & ","
                                 & Format( it ));
                                 case ext is
                                 when single_retired_person => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when couple_bu_retired => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when young_single => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when young_couple => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when old_sick_single_male => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when cpag_terry_and_julie => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it ));  -- 2012 edn p 478
                                 when cpag_angelina_and_michael => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when zero_income => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when care_home_resident => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when caring_couple => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when working_single_parent => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                                 when hmrc_ni_example_1 => null;
                                 when hmrc_ni_example_2 => null;
                                 when hmrc_ni_example_4 => null;
                                 when hmrc_ni_example_7 => null;
                                 when se_example_1 => null;
                                 when se_example_2 => null;
                              end case;
                            end;
                        end;
                        Inc( income, 100.0 );
                     end loop Incomes;
                  end;
               end loop Income_Type;
               pno := pno + 1;
               New_Line;
            end loop People;
            New_Line;
         end;         
      end loop Families;
   end Test_Calculate_Income_Tax;
  
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Calculate_National_Insurance'Access, "Test_Calculate_National_Insurance");
      -- Register_Routine (T, Test_Calculate_Income_Tax'Access, "Test_Income_Tax");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end Model.Calculator.Direct_Tax.Tests;
