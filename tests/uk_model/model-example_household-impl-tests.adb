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
with Ada.Text_Io.Editing;

with AUnit.Assertions;

package body Model.Example_Household.Impl.Tests is

   use AUnit.Assertions;             
   use Ada.Text_IO;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      null;
      -- Register_Routine (T, Test_Read_Model_Datasets'Access, "Test_Read_Model_Datasets");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end  Model.Example_Household.Impl.Tests;
