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
pragma License( Modified_GPL );

with Ada.Strings.Unbounded;

package ZA.Model.Data.Binary_IO is

   use Ada.Strings.Unbounded;

   subtype Household_Count is Positive range 1 .. 30_000;
   
   procedure Open_Files;
   procedure Close_Files;
   function Read( href : Household_Count ) return Household;
   function Num_Households return Household_Count;
   procedure Create_Files;
   procedure Write( hh : Household );
   procedure Set_Model_Data_Dir( s : String );
   procedure Set_Model_Data_Dir( s : Unbounded_String );

end ZA.Model.Data.Binary_IO;
