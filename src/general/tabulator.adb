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
-- $Revision: 10659 $
-- $Author: graham_s $
-- $Date: 2011-01-15 20:06:36 +0000 (Sat, 15 Jan 2011) $
--
--
--
-- A generic Tabulator
-- 
pragma License( Modified_GPL );


with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Text_Utils;
with Ada.Text_IO;

package body Tabulator is

   use Ada.Text_IO;

   package ustr renames Ada.Strings.Unbounded;

   type Real is new Long_Float; --
   
   function Extract_From_Cell
     (cell         : Cell_Rec;
      cell_op      : Cell_Compare_Type;
      value_To_Use : Cell_Values_Range )
      return         Data_Type
   is
      outx : Data_Type := 0.0;
   begin
      case cell_op is
         when sys_1_average =>
            if( cell.count /= 0.0 )then
               outx := Data_Type(Real(cell.pre_values(value_To_Use))/Real(cell.count));
            end if;
         when sys_2_average =>
            if( cell.count /= 0.0 )then
               outx := Data_Type(Real(cell.post_values(value_To_Use))/Real(cell.count));
            end if;
         when average_change =>
            if( cell.count /= 0.0 )then
               outx := Data_Type(Real(cell.post_values(value_To_Use)-cell.pre_values(value_To_Use))/Real(cell.count));
            end if;
         when counter =>
            outx := cell.count;
         when sys1_level =>
            outx := cell.pre_values (value_To_Use);
         when sys2_level =>
            outx := cell.post_values (value_To_Use);
         when abs_change =>
            outx := cell.post_values (value_To_Use) - cell.pre_values (value_To_Use);
         when pct_change =>
            if (cell.pre_values (value_To_Use) /= 0.0) then
               outx :=
                 Data_Type (100.0 *
                        (Real (cell.post_values (value_To_Use) - cell.pre_values (value_To_Use))) /
                         Real (cell.pre_values (value_To_Use)));
            end if;
      end case;
      return outx;
   end extract_From_Cell;
   

   
   procedure Add_Observation( 
      tab         : in out Table_Type; 
      row         : Row_Range;
      col         : Col_Range; 
      weight      : Data_Type;
      pre_values  : Values_Array;  
      post_values : Values_Array;
      breakdown   : Cell_Breakdown;
      example     : Example_Type ) is
      
      use Examples_List_Package;
      
   begin
      tab.cells( row )( col ).count  := tab.cells( row )( col ).count + weight;
      tab.col_totals (col).count    := tab.col_totals (col).count + weight;
      tab.row_totals (row).count    := tab.row_totals (row).count + weight;
      tab.total.count              := tab.total.count + weight;
      Increment_Cell_Breakdown( tab.cells (row) (col).breakdown, breakdown, weight );
      Increment_Cell_Breakdown( tab.col_totals(col).breakdown, breakdown, weight );
      Increment_Cell_Breakdown( tab.row_totals(row).breakdown, breakdown, weight );
      Increment_Cell_Breakdown( tab.total.breakdown, breakdown, weight );
      for i in Cell_Values_Range loop
         tab.cells (row) (col).pre_values (i)   := tab.cells (row) (col).pre_values (i) +
                                                     (pre_values (i) * weight);
         tab.cells (row) (col).post_values (i)  := tab.cells (row) (col).post_values (i) +
                                                     (post_values (i) * weight);
         tab.col_totals (col).pre_values (i) := tab.col_totals (col).pre_values (i) +
                                                 (pre_values (i) * weight);
         tab.row_totals (row).pre_values (i) := tab.row_totals (row).pre_values (i) +
                                                 (pre_values (i) * weight);

         tab.total.pre_values (i) := tab.total.pre_values (i) +
                                       (pre_values (i) * weight);

         tab.col_totals (col).post_values (i) := tab.col_totals (col).post_values (i) +
                                                  (post_values (i) * weight);
         tab.row_totals (row).post_values (i) := tab.row_totals (row).post_values (i) +
                                                  (post_values (i) * weight);

         tab.total.post_values (i) := tab.total.post_values (i) +
                                        (post_values (i) * weight);
      end loop;
      if( Get_Num_Examples( tab, row, col ) < MAX_EXAMPLES ) then
            Append( tab.cells (row) (col).examples, example );
      end if;
      if( Get_Num_Examples_Row_Totals( tab, row ) < MAX_EXAMPLES ) then
            Append( tab.row_totals (row).examples, example );
      end if;
      if( Get_Num_Examples_Col_Totals( tab, col ) < MAX_EXAMPLES ) then
            Append( tab.col_totals (col).examples, example );
      end if;
      if( Get_Num_Examples_Total( tab ) < MAX_EXAMPLES ) then
            Append( tab.total.examples, example );
      end if;
         
       
   end Add_Observation;
  
   function Get_Examples( table : Table_Type ; row : Row_Range; col : Col_Range ) return Examples_List is
   begin
      return table.cells( row )( col ).examples;
   end Get_Examples;
   
   function Get_Num_Examples( table : Table_Type ; row : Row_Range; col : Col_Range ) return Natural is
   begin
      return Natural( Examples_List_Package.Length( table.cells( row )( col ).examples ) );
   end Get_Num_Examples;
   
   function Get_Example( table : Table_Type; row : Row_Range; col : Col_Range; which : Positive ) return Example_Type is
      use Examples_List_Package;
      n : constant Natural := Get_Num_Examples( table, row, col );
      example : Example_Type;
   begin
      if( ( which > 0 ) and ( which <= n )) then 
         example := Element( table.cells( row )( col ).examples, which );
      end if;
      return example;
   end Get_Example;

   
   function Get_Num_Examples_Row_Totals( table : Table_Type ; row : Row_Range ) return Natural is
   begin
      return Natural( Examples_List_Package.Length( table.row_totals( row ).examples ) );
   end Get_Num_Examples_Row_Totals;
   
   function Get_Example_Row_Totals( table : Table_Type; row : Row_Range; which : Positive ) return Example_Type is
      n : constant Natural := Get_Num_Examples_Row_Totals( table, row );
      example : Example_Type;
   begin
      if( ( which > 0 ) and ( which <= n )) then 
         example := Examples_List_Package.Element( table.row_totals( row ).examples, which );
      end if;
      return example;
   end Get_Example_Row_Totals;
   
   function Get_Num_Examples_Total( table : Table_Type ) return Natural is
   begin
      return Natural( Examples_List_Package.Length( table.total.examples ) );
   end Get_Num_Examples_Total;
   
   function Get_Example_Total( table : Table_Type; which : Positive ) return Example_Type is
      n : constant Natural := Get_Num_Examples_Total( table );
      example : Example_Type;
   begin
      if( ( which > 0 ) and ( which <= n )) then 
         example := Examples_List_Package.Element( table.total.examples, which );
      end if;
      return example;
   end Get_Example_Total;
   
   function Get_Num_Examples_Col_Totals( table : Table_Type ; col : Col_Range ) return Natural is
   begin
      return Natural( Examples_List_Package.Length( table.col_totals( col ).examples ) );
   end Get_Num_Examples_Col_Totals;
   
   function Get_Example_Col_Totals( table : Table_Type; col : Col_Range; which : Positive ) return Example_Type is
      n : constant Natural := Get_Num_Examples_Col_Totals( table, col );
      example : Example_Type;
   begin
      if( ( which > 0 ) and ( which <= n )) then 
         example := Examples_List_Package.Element( table.col_totals( col ).examples, which );
      end if;
      return example;
   end Get_Example_Col_Totals;
   
   
   function Get_Breakdown( table : Table_Type ; row : Row_Range; col : Col_Range ) return Aggregate_Cell_Breakdown is
   begin
      return table.cells( row )( col ).breakdown;
   end Get_Breakdown;
   
   function Get_Breakdown_Row_Totals( table : Table_Type ; row : Row_Range ) return Aggregate_Cell_Breakdown is
   begin
      return table.row_totals( row ).breakdown;
   end Get_Breakdown_Row_Totals;

   function Get_Breakdown_Col_Totals( table : Table_Type ; col : Col_Range ) return Aggregate_Cell_Breakdown is
   begin
      return table.col_totals( col ).breakdown;
   end Get_Breakdown_Col_Totals;
   
   function Get_Breakdown_Total( table : Table_Type ) return Aggregate_Cell_Breakdown is
   begin
      return table.total.breakdown;
   end Get_Breakdown_Total;
   
   procedure Re_Express_Table( 
      te : in out Table_Expression;
      comp_Cell    : Compare_Cell ) is
      comp : Data_Type;
   begin
      if( comp_Cell = current_cell ) then
         return;
      end if;
      for r in Row_Range loop
         for c in Col_Range loop
            case comp_Cell is
               when current_cell =>
                  comp := 1.0;
               when row_total =>
                  comp := te.row_totals( r );
               when col_total =>
                  comp := te.col_totals( c );
               when total =>
                  comp := te.total;
            end case;
            if( comp /= 0.0 ) then
               te.cells( r, c ) := 100.0 * te.cells( r, c ) / comp;
            end if;
         end loop;
      end loop;
      for r in Row_Range loop
         case comp_Cell is
            when current_cell =>
               comp := 1.0;
            when row_total =>
               comp := te.row_totals( r );
            when col_total =>
               comp := te.total;
            when total =>
               comp := te.total;
         end case;
         if( comp /= 0.0 ) then
            te.row_totals( r ) := 100.0 * te.row_totals( r ) / comp;
         end if;
      end loop;
      for c in Col_Range loop
         case comp_Cell is
            when current_cell =>
               comp := 1.0;
            when row_total =>
               comp := te.total;
            when col_total =>
               comp := te.col_totals( c );
            when total =>
               comp := te.total;
         end case;
         if( comp /= 0.0 ) then
            te.col_totals( c ) := 100.0 * te.col_totals( c ) / comp;
         end if;
      end loop;
      te.total := 100.0;
   end Re_Express_Table;
      
  function Express_Table
     (table        : Table_Type ;
      comp_Cell    : Compare_Cell; -- compare the cells to this, for example differences to the row totals, col totals, etc;
      cell_op      : Cell_Compare_Type; -- show levels, percentage changes and so on;
      value_To_Use : Cell_Values_Range ) return Table_Expression is
      te : Table_Expression;
   begin 
      for r in Row_Range loop
         for c in Col_Range loop
            te.cells (r, c) := Extract_From_Cell (table.cells (r) (c), cell_op, value_To_Use);
         end loop;
      end loop;
      for c in Col_Range loop
         te.col_totals ( c ) := Extract_From_Cell (table.col_totals (c), cell_op, value_To_Use);
      end loop;
      for r in Row_Range loop
         te.row_totals ( r ) := Extract_From_Cell (table.row_totals (r), cell_op, value_To_Use);
      end loop;
      te.total := Extract_From_Cell (table.total, cell_op, value_To_Use);
      Re_Express_Table( te, comp_cell );
      return te;
   end Express_Table;
 
   function To_String( te : Table_Expression; delim : String := " " ) return String is
      outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
   begin
      for r in Row_Range loop
         ustr.append( outs, r'Img & delim );
         for c in Col_Range loop
            ustr.append( outs, te.cells (r, c)'Img & delim );
         end loop;
         ustr.append( outs, te.row_totals( r )'Img );
         ustr.append( outs, Text_Utils.LINE_BREAK );
      end loop;
      ustr.append( outs, "TOTALS" & delim );
      for c in Col_Range loop
         ustr.append( outs, te.col_totals(c)'Img & delim );
      end loop;
      ustr.append( outs, te.total'Img );
      ustr.append( outs, Text_Utils.LINE_BREAK );
      return ustr.To_String (outs);
   end To_String;
   
   function To_Delimited( te : Table_Expression ) return String is
   begin
      return To_String( te, Text_Utils.TAB );
   end To_Delimited;
   
   function Get_Difference( v1 : Data_Type; v2 : Data_Type; op : Scale_Op_Type  ) return Data_Type is
      diff : Data_Type;
   begin
      case op is
         when sys1_level => diff := v1;
         when sys2_level => diff := v2;
         when abs_change => diff := v2 - v1;
         when pct_change => 
            if( v1 /= 0.0 ) then
               diff := Data_Type( 100.0 * Real( v2 - v1 )/Real(v1) );
               --
               -- idiot check for changing signs
               --
               if( v1 < 0.0 ) then 
                  diff := -1.0 * diff ; 
               end if;
            elsif( v2 /= 0.0 ) then
               diff := Data_Type( 100.0 * Real( v2 - v1 )/Real(v2) );
               if( v2 < 0.0 ) then 
                  diff := -1.0 * diff; 
               end if;
            else
               diff := 0.0;
            end if;
      end case;
      return diff;
   end Get_Difference;
   
   function Get_Col_Range( v : Data_Type; scale : Scale_Array ) return Col_Range is
   begin
      for p in scale'First  .. scale'Last loop
         if( scale(p) > v )then 
            return p; 
         end if;
      end loop;
      return scale'Last;
   end Get_Col_Range;
   
   function Get_Col_Range( pre : Data_Type; post : Data_Type; scale : Scale_Array; op : Scale_Op_Type ) return Col_Range is
      v : constant Data_Type := Get_Difference( pre, post, op );
   begin
      return Get_Col_Range( v, scale );
   end Get_Col_Range;
  
   function Get_Row_Range( v : Data_Type; scale : Row_Scale ) return Row_Range is
   begin
      for p in scale'Range loop
         if( scale(p) > v )then 
            return p; 
         end if;
      end loop;
      return scale'Last;
   end Get_Row_Range;
   
   function Get_Row_Range( pre : Data_Type; post : Data_Type; scale : Row_Scale; op : Scale_Op_Type ) return Row_Range is
      v : constant Data_Type := Get_Difference( pre, post, op );
   begin
      return Get_Row_Range( v, scale );
   end Get_Row_Range;
   
end Tabulator;
