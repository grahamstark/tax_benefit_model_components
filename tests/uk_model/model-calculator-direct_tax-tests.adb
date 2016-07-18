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
with Model.Example_Household.Cases;
with Model.Example_Household.Impl;
with Model.Example_Household.Cases;
with Model.Example_Results;
with Model.Example_Results.Impl;
with Model.Parameter_System;

with Model.Abstract_Household;

with AUnit.Assertions;

package body Model.Calculator.Direct_Tax.Tests is

   use AUnit.Assertions;             
   use Ada.Text_IO;
   use Ada.Containers;
   use Model.Example_Household;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   function Get_Sys return Complete_System is
      sys : Complete_System;
   begin
      return sys;
   end Get_Sys;
      
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
      sys : Complete_System := Get_Sys;
   begin
      for ext in Example_Type loop
         declare
            mhh  : Impl.Model_Household := ( Get_Household( ext ) with null record );
            ss  : Sernum_Set_List := mhh.Get_Default_Benefit_Unit_PIDs;
            sn  : Sernum_Set := ss.Element( 1 );
            pno : Person_Number;
            res : Model_Household_Result := Initialise( mhh );
         begin
            Assert( ss.Length = 1, "ss length always 1; was " & ss.Length'Img );
            for pid of sn loop
               declare
                  pers   :  Abstract_Household.Person'Class := mhh.Find_Person( pid );
                  pers_result : mar.Personal_Result'Class := res.Get_Personal( pid );
                  bu_result :  mar.Benefit_Unit_Result'Class := res.Get( 1 ); -- just 1 bu in examples
               begin
                  Calculate_Income_Tax( 
                     sys.it, 
                     pers,
                     pers_result );
               end;
            end loop;
         end;
      end loop;
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
