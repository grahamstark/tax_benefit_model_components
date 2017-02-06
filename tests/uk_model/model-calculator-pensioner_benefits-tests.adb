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

package body Model.Calculator.Pensioner_Benefits.Tests is

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
   
   
   procedure Test_Calculate_Guaranteed_Pension_Credit( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      sys : Complete_System := Make_Complete_System( 2015 );
      use Model.Example_Household.Cases;
      use Model.Example_Results.Impl;
   begin
      Families:
      for ext in single_retired_person .. young_single loop
         Put_Line( "HHLD " & ext'Img );
         Put_Line( "pno,dividends,private_pensions,state_pen,hb,pension_credit,state_pen(BU),hb(BU),pension_credit(BU)" );
                              
         declare
            mhh  : Impl.Model_Household := ( Get_Household( ext ) with null record );
            ss   : Sernum_Set_List := mhh.Get_Default_Benefit_Unit_PIDs;
            sn   : Sernum_Set := ss.Element( 1 );
            
            pno  : Person_Number := 1;
            
         begin
            Assert( ss.Length = 1, "ss length always 1; was " & ss.Length'Img );
            People:
            for pid of sn loop
               declare
                  income : Amount := 0.0;
               begin
                  Incomes:
                  for i in 1 .. 50 loop
                     mhh.Set_Income( pid, private_pensions, income );
                     declare 
                        res  : Model_Household_Result := Initialise( mhh );
                        bres : mar.Benefit_Unit_Result'Class := res.Get( 1 );
                        mbu : mah.Benefit_Unit'Class := mhh.Get_Benefit_Unit( sn, 1 );                     
                     begin
                        Calculate_State_Pension( 
                           sys      => sys.benefits.state_pension, 
                           bu       => mbu,  
                           res      => bres );
                        Calculate_Guaranteed_Pension_Credit(
                           gpcsys   => sys.benefits.pension_credit.guaranteed_credit,                           
                           pensys   => sys.benefits.state_pension,
                           bu       => mbu,  
                           res      => bres );
                        Calculate_Savings_Credit(
                           sys      =>  sys.benefits.pension_credit.savings_credit,
                           bu       =>  mbu,  
                           res      =>  bres );
                        res.Set( 1, bres );   
                        declare
                           pen            : Amount := bres.Get( pid ).Get( retirement_pension );
                           hb             : Amount := bres.Get( pid ).Get( housing_benefit );
                           pen_cred       : Amount := bres.Get( pid ).Get( pension_credit );
                           dividend       : Amount := mbu.Find_Person( pid ).Get_Income( dividends );
                           bank_intr      : Amount := mbu.Find_Person( pid ).Get_Income( private_pensions );
                           gross          : Amount := bres.Get( gross_income );
                           pen_b          : Amount := bres.Get( retirement_pension );
                           hb_b           : Amount := bres.Get( housing_benefit );
                           pen_cred_b     : Amount := bres.Get( pension_credit );
                        begin
                           Put_Line( 
                              pno'Img & ","
                              & Format( dividend ) & "," 
                              & Format( bank_intr ) & "," 
                              & Format( pen ) & ","
                              & Format( hb ) & ","
                              & Format( pen_cred ) & ","
                              & Format( pen_b ) & ","
                              & Format( hb_b ) & ","
                              & Format( pen_cred_b ));
                           case ext is
                              when single_retired_person => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                              when couple_bu_retired => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                              when young_single => null; -- Assert( NearlyEqual( it, XX ), " it should be " & Format( XX ) & " was " & Format( it )); 
                              
                           end case;
                        end;
                     end;
                     Inc( income, 5.0 );
                  end loop Incomes;
               end;
               pno := pno + 1;
               New_Line;
            end loop People;
            New_Line;
         end;         
      end loop Families;      
   end Test_Calculate_Guaranteed_Pension_Credit;
  
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Calculate_Guaranteed_Pension_Credit'Access, "Test_Calculate_Guaranteed_Pension_Credit");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end Model.Calculator.Pensioner_Benefits.Tests;
  