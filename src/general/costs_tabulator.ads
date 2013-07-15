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
-- This is a specialised table for displaying costs of (e.g.) taxes or benefits broken down by something. It's really simple.
-- 
pragma License( Modified_GPL );

with Tabulator_Commons;

generic
   --
   -- Use some kind of decimal/fixed point number throughout.
   --
   type Data_Type is digits<>; 
   --
   -- For example, region, or family type
   --
   type Breakdown_Range is (<>);
   --
   -- For example, a list of taxes paid and benefits received
   --
   type Values_Range is (<>);

   --
   -- FIXME : move this to below package definition?
   --    
   type Values_Array is array ( Values_Range ) of Data_Type;
   
package Costs_Tabulator is

   use Tabulator_Commons;
   --
   -- The list of pre/post items added to a cell (tax, benefit receipts, etc..)
   --
   
   type Cell_Type is record
      amount : Data_Type := 0.0;
      count  : Data_Type := 0.0;
   end record;
   -- type Value_And_Counts_Array is array ( Values_Range ) of Cell_Type;
   type Table_Type is tagged private; 
   
   --
   -- Add a vector of values to the table, a grossing factor for the
   -- observation).
   --   
   procedure Add_Observation(  
      tab     : in out Table_Type; 
      row     : Breakdown_Range;
      weight  : Data_Type;
      values  : Values_Array );
   
   function To_String( table : Table_Type; delim : String := " " ) return String;
   function To_Delimited( table : Table_Type ) return String;
   function Difference( pre_table : Table_Type; post_table : Table_Type ) return Table_Type;
   function Extract_Counts_Row( 
      table : Table_Type; 
      which_breakdown : Breakdown_Range; 
      do_totals : Boolean := False ) return Values_Array;
   function Extract_Costs_Row( 
      table : Table_Type; 
      which_breakdown : Breakdown_Range; 
      do_totals : Boolean := False ) return Values_Array;

private
   
   type Results_Row is array( Values_Range ) of Cell_Type;
   type Cells_Array is array( Breakdown_Range ) of Results_Row;

   type Table_Type is tagged record
      cells : Cells_Array;
      totals : Results_Row;
   end record;
   
end Costs_Tabulator;
