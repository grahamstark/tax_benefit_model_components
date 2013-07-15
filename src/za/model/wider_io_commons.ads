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

with Tabulator_Commons;
with ZA.Model_Types;
with Ada.Text_IO;

package Wider_IO_Commons is
   
   use ZA.Model_Types;
   use Tabulator_Commons;
   use Ada.Text_IO;
   --
   -- matches tabulator.prg TABLE_BUDGET = 1;TABLE_GAIN_LOSE = 2;TABLE_STD = 3;
   -- with poverty == TABLE_BUDGET;
   --
   type Wider_Table_Type is ( na, budget, gain_lose, standard );

   NO_CHANGE_COL : constant := 4;
      
   STD_GAIN_LOSE_SCALE_STR : constant String := 
      ",""&lt; -50"",""-49.99 -10"",""-9.99 -1"","" - "",""1 9.99"",""10 49.9"","" &ge; 50"",""total""";
 
   procedure Write_Header( 
      f                : File_Type;
      table_number     : Positive;
      table_name       : String;
      no_change_column : Integer;
      year             : Simulation_Year_Range;
      num_rows         : Positive;
      num_cols         : Positive;
      row_var_name     : String;
      col_var_name     : String;
      table_type       : Wider_Table_Type;
      sysno            : System_Number );
  
end Wider_IO_Commons;
