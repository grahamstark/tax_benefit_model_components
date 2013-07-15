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

with Ada.Text_IO;
with ZA.Model_Types;

generic

package Costs_Tabulator.Wider_IO is
   
   use Ada.Text_IO;
   use ZA.Model_Types;
   
   procedure Print( 
         f                : File_Type;
         table_name       : String;
         table            : Table_Type;
         table_number     : Positive;
         row_var_name     : String;
         col_var_name     : String;
         year             : Simulation_Year_Range;
         sysno            : System_Number );


end Costs_Tabulator.Wider_IO;
