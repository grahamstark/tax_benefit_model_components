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
with Model.Example_Household.Cases;
with Ada.Containers;

with AUnit.Assertions;

package body Model.Calculator.Direct_Tax.Tests is

   use AUnit.Assertions;             
   use Ada.Text_IO;
   use Ada.Containers;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   procedure Test_Calculate_National_Insurance( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Example_Household.Cases;
   begin
      for ext in Example_Type loop
         declare
            hh  : Household := Get_Household( ext );
            mhh : Model_Household := ( hh with null record );
            ss  : Sernum_Set_List := mhh.Get_Default_Benefit_Unit_PIDs;
            sn  : Sernum_Set := ss.Element( 1 );
            pno : Person_Number;
         begin
            Assert( ss.Length = 1, "ss length always 1; was " & ss.Length'Img );
         end;
      end loop;
   end Test_Impls;
   
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Calculate_National_Insurance'Access, "Test_Calculate_National_Insurance");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end Model.Calculator.Direct_Tax.Tests;
