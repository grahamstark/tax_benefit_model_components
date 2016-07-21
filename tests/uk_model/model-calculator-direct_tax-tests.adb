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

with Model.Abstract_Household;

with AUnit.Assertions;

package body Model.Calculator.Direct_Tax.Tests is

   use AUnit.Assertions;
   use Ada.Calendar;
   use Ada.Text_IO;
   use Ada.Containers;
   use Model.Example_Household;
   
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
   
   sys : Complete_System := Make_Complete_System( 2015 );
   
   procedure Test_Calculate_National_Insurance( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Example_Household.Cases;
   begin
      for ext in Example_Type loop
         declare
            hh  : Household := Get_Household( ext );
            mhh : Impl.Model_Household := ( hh with null record );
            ss  : Sernum_Set_List := mhh.Get_Default_Benefit_Unit_PIDs;
            sn  : Sernum_Set := ss.Element( 1 );
            pno : Person_Number;
         begin
            Assert( ss.Length = 1, "ss length always 1; was " & ss.Length'Img );
         end;
      end loop;
   end Test_Calculate_National_Insurance;
   
    procedure Test_Calculate_Income_Tax( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Example_Household.Cases;
      use Model.Example_Results.Impl;
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
                           pers   :  Abstract_Household.Person'Class := mhh.Find_Person( pid );
                           pers_result : mar.Personal_Result'Class := res.Get_Personal( pid );
                        begin
                           
                           Calculate_Income_Tax( 
                              sys.it, 
                              pers,
                              pers_result );
                           Calculate_National_Insurance( 
                              sys.ni, 
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
      Register_Routine (T, Test_Calculate_Income_Tax'Access, "Test_Income_Tax");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end Model.Calculator.Direct_Tax.Tests;
