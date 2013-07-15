--
-- copyright(c) 2007 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
-- $Revision: 10792 $
-- $Author: graham_s $
-- $Date: 2011-01-20 19:01:45 +0000 (Thu, 20 Jan 2011) $
--
--
--
-- A generic Tabulator for Tax Benefit models or similar.
-- 
pragma License( Modified_GPL );

with Ada.Containers.Vectors;
with Tabulator_Commons;

generic
   --
   -- Use some kind of decimal/fixed point number throughout.
   --
   type Data_Type is digits<>; 
   --
   -- An example of what's in a cell. Might be, for example, a reference to a household, or something more complicated
   --
   type Example_Type is private;
   --
   -- A discrete type for selecting which row, for example an enumeration for (say) gender, tenure type and so on
   --
   type Row_Range is (<>);
   --
   -- Ditto for the column number; this is the counter used in the scale array below (usually an integer range) 
   --
   type Col_Range is (<>);
   --
   --
   --
   type Scale_Array is array( Col_Range ) of Data_Type;
   --
   -- We add an array of values at a time, for example, a vector of tax payments, benefit receipts, etc. This enumerates it for
   -- this table
   --
   type Cell_Values_Range is (<>);
   --
   -- an array of this type. Having this here cuts down on pointless typecasting
   --
   type Values_Array is array( Cell_Values_Range ) of Data_Type;
   --
   -- This is indended for, for example, a count of people in a cell by Province_Type or family type. Typically, it's
   -- a list with, say, the tenure type, region, etc. for this observation.
   --
   type Cell_Breakdown is private;
   --
   -- Messy: this is the thing that the Cell_Breakdowns aggregate to. Typically, it's a matrix with the 1st col being
   -- (say) tenures, the 2nd regions and so on.
   --
   type Aggregate_Cell_Breakdown is private;
   
   MAX_EXAMPLES : Natural;
   
   --
   -- The procedure that adds a Cell_Breakdown to an Aggregate_Cell_Breakdown
   --
   with procedure Increment_Cell_Breakdown( 
      current_breakdown : in out Aggregate_Cell_Breakdown; 
      new_breakdown : Cell_Breakdown;
      weight        : Data_Type );   
                 
package Tabulator is

   use Tabulator_Commons;
   
   type Table_Type is tagged private;
   type Cell_Rec is tagged private;

   type Row_Scale is array( Row_Range ) of Data_Type;
   
   --
   -- Convenience methods for producing row and column positions from a scale and a value, or pair of values.
   --
   function Get_Row_Range( v : Data_Type; scale : Row_Scale ) return Row_Range; 
   function Get_Col_Range( v : Data_Type; scale : Scale_Array ) return Col_Range; 
   function Get_Row_Range( pre : Data_Type; post : Data_Type; scale : Row_Scale; op : Scale_Op_Type ) return Row_Range;
   function Get_Col_Range( pre : Data_Type; post : Data_Type; scale : Scale_Array; op : Scale_Op_Type ) return Col_Range;
   
   --
   -- The list of pre/post items added to a cell (tax, benefit receipts, etc..)
   --
   

   --
   -- These declarations define a simple num_rows x num_cols array of data_type, used to report
   -- a single view of all the data in our table
   -- 
   type Simple_Cell_Array is array( Row_Range, Col_Range ) of Data_Type;
   type Simple_Row_Array is array( Row_Range ) of Data_Type;
   type Simple_Col_Array is array( Col_Range ) of Data_Type;
   
   --
   -- A very simple matrix of our numeric type used to report a snapshot of the contents of the table. 
   --   
   type Table_Expression is record
      cells : Simple_Cell_Array  := (others => (others => 0.0));
      row_totals : Simple_Row_Array := (others => 0.0 );
      col_totals : Simple_Col_Array := (others => 0.0 );
      total : Data_Type := 0.0;
   end record;
   
   function Get_Num_Examples( table : Table_Type; row : Row_Range; col : Col_Range ) return Natural;
   function Get_Example( table : Table_Type; row : Row_Range; col : Col_Range; which : Positive ) return Example_Type;
   --
   -- Row Totals
   --
   function Get_Num_Examples_Row_Totals( table : Table_Type; row : Row_Range ) return Natural;
   function Get_Example_Row_Totals( table : Table_Type; row : Row_Range; which : Positive ) return Example_Type;
   --
   -- Col totals
   --
   function Get_Num_Examples_Col_Totals( table : Table_Type; col : Col_Range ) return Natural;
   function Get_Example_Col_Totals( table : Table_Type; col : Col_Range; which : Positive ) return Example_Type;
   --
   -- Totals
   --
   function Get_Num_Examples_Total( table : Table_Type ) return Natural;
   function Get_Example_Total( table : Table_Type; which : Positive ) return Example_Type;
   
   function Get_Breakdown( table : Table_Type ; row : Row_Range; col : Col_Range ) return Aggregate_Cell_Breakdown;
   function Get_Breakdown_Row_Totals( table : Table_Type ; row : Row_Range ) return Aggregate_Cell_Breakdown;
   function Get_Breakdown_Col_Totals( table : Table_Type ; col : Col_Range ) return Aggregate_Cell_Breakdown;
   function Get_Breakdown_Total( table : Table_Type ) return Aggregate_Cell_Breakdown;

   
   --
   -- Add pre- and post = Values_Arrays to the cell [row,col] using the given weight (typically, a grossing factor for the
   -- observation).
   --   
   procedure Add_Observation( 
      tab         : in out Table_Type; 
      row         : Row_Range;
      col         : Col_Range; 
      weight      : Data_Type;
      pre_values  : Values_Array;  
      post_values : Values_Array;
      breakdown   : Cell_Breakdown;
      example     : Example_Type );
  
   --
   -- Convert some aspect of the table into a simple rows x cols matrix of Data_Type
   --
   function Express_Table
     (table        : Table_Type ;
      comp_cell    : Compare_Cell;        -- compare the cells to this, for example differences to the row totals, col totals, etc;
      cell_op      : Cell_Compare_Type;   -- show levels, percentage changes and so on;
      value_to_use : Cell_Values_Range ) return Table_Expression; -- which of the pre/post values to use (might be income tax, la contributions, etc.)
   
   function To_String( te : Table_Expression; delim : String := " " ) return String;
   function To_Delimited( te : Table_Expression ) return String;

private

   package Examples_List_Package is new Ada.Containers.Vectors( Element_Type => Example_Type, Index_Type => Positive );
   subtype Examples_List is Examples_List_Package.Vector;
   
   
   type Cell_Rec is tagged
      record
         count                   : Data_Type      := 0.0;
         pre_values, post_values : Values_Array   := (others => 0.0);
         breakdown               : Aggregate_Cell_Breakdown;
         examples                : Examples_List; 
       end record;
		
   type Table_Row is array( Row_Range ) of Cell_Rec;
   type Table_Col is array( Col_Range ) of Cell_Rec;
   type Table_Cells is array( Row_Range ) of Table_Col;

   type Table_Type is
      tagged record
         cells      : Table_Cells;
         row_totals : Table_Row;
         col_totals : Table_Col;
         total      : Cell_Rec;
      end record;
   
end Tabulator;
