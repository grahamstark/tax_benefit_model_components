--
-- copyrigh(c) 2007 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
-- $Revision: 11246 $
-- $Author: graham_s $
-- $Date: 2011-03-15 11:02:44 +0000 (Tue, 15 Mar 2011) $
--
--
--
-- Some definitions for a generic Tabulator
-- 
pragma License( Modified_GPL );

package Tabulator_Commons is
   
   type Type_Of_Cell is ( row_total, col_total, overall_total, standard_cell );
   
   type Compare_Cell is ( current_cell, row_total, col_total, total );
   type Cell_Compare_Type is ( counter, sys1_level, sys2_level, abs_change, pct_change, sys_1_average, sys_2_average, average_change );
   type Scale_Op_Type is ( sys1_level, sys2_level, abs_change, pct_change );
   --
   -- FIXME this is nothing to do with table definitions! move somewhere ..
   --
   type Poverty_Elements is (
      population,
      people_in_poverty,
      poverty_rate,
      poverty_gap_total,
      poverty_gap_per_poor_person    
   );
   
   
end Tabulator_Commons;
