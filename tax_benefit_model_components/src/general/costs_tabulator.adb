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
-- $Revision: 10690 $
-- $Author: graham_s $
-- $Date: 2011-01-17 16:02:37 +0000 (Mon, 17 Jan 2011) $
--
--
--
-- This is a specialised table for displaying costs of  broken down by something
-- 
pragma License( Modified_GPL );


with Tabulator_Commons;
with Text_Utils;
with Ada.Strings.Unbounded;

package body Costs_Tabulator is

   package ustr renames Ada.Strings.Unbounded;
   
   use Tabulator_Commons;
   use Text_Utils;

   -- Add a vector of values to the table, a grossing factor for the
   -- observation).
   --   
   procedure Add_Observation(  
      tab     : in out Table_Type; 
      row     : Breakdown_Range;
      weight  : Data_Type;
      values  : Values_Array ) is
   begin
      for v in Values_Range loop
         tab.cells( row )( v ).amount := tab.cells( row )( v ).amount + (values(v)*weight); 
         tab.totals( v ).amount := tab.totals( v ).amount + ( values(v)*weight);
         if( values(v) /= 0.0 ) then
            tab.cells( row )( v ).count := tab.cells( row )( v ).count + weight;
            tab.totals( v ).count := tab.totals( v ).count + weight;
         end if;
      end loop;
   end Add_Observation;
   
   function To_String( table : Table_Type; delim : String := " " ) return String is
      outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
   begin
      ustr.append( outs, delim );
      
      for v in Values_Range loop 
          ustr.append( outs, Censor_String( Values_Range'Image( v )) & delim );
          ustr.append( outs, Values_Range'Image( v ) & delim );
      end loop;
      ustr.append( outs, LINE_BREAK );
      ustr.append( outs, delim );
      for v in Values_Range loop 
          ustr.append( outs, "Value" & delim & "Count"  & delim );
      end loop;
      ustr.append( outs, LINE_BREAK );
      for b in Breakdown_Range loop
         ustr.append( outs, Censor_String( Breakdown_Range'Image( b )) & delim );
         for v in Values_Range loop 
             ustr.append( outs, 
               Data_Type'Image( table.cells( b )( v ).amount ) & delim ); 
             ustr.append( outs,
               Data_Type'Image( table.cells( b )( v ).count ) & delim ); 
         end loop;
         ustr.append( outs, LINE_BREAK );
      end loop;
      
      ustr.append( outs, delim );
      for v in Values_Range loop 
          ustr.append( outs, 
            Data_Type'Image( table.totals( v ).amount ) & delim ); 
          ustr.append( outs,
            Data_Type'Image( table.totals( v ).count ) & delim ); 
      end loop;
      ustr.append( outs, LINE_BREAK );
      return ustr.To_String (outs);
   end To_String;
   
   function To_Delimited( table : Table_Type ) return String is
   begin
      return To_String( table, TAB );
   end To_Delimited;
   
   function Difference( pre_table : Table_Type; post_table : Table_Type ) return Table_Type is
      diff : Table_Type;
   begin
      for b in Breakdown_Range loop
         for v in Values_Range loop
            diff.cells( b )( v ).amount := 
               post_table.cells( b )( v ).amount - pre_table.cells( b )( v ).amount; 
            diff.cells( b )( v ).count := 
               post_table.cells( b )( v ).count - pre_table.cells( b )( v ).count; 
         end loop;
      end loop;
      for v in Values_Range loop
         diff.totals( v ).amount := 
            post_table.totals( v ).amount - pre_table.totals( v ).amount; 
         diff.totals( v ).count := 
            post_table.totals( v ).count - pre_table.totals( v ).count; 
      end loop;
      return diff;
   end Difference;
   
   function Extract_Counts_Row( table : Table_Type; which_breakdown : Breakdown_Range; do_totals : Boolean := False ) return Values_Array is
      row : Values_Array;
   begin
      for v in Values_Range loop
         if( do_totals )then
               row( v ) := table.totals( v ).count;
         else
               row( v ) := table.cells( which_breakdown )( v ).count;
         end if;
      end loop;
      return row;
   end Extract_Counts_Row;
   
   function Extract_Costs_Row( table : Table_Type; which_breakdown : Breakdown_Range; do_totals : Boolean := False ) return Values_Array is
      row : Values_Array;
   begin
      for v in Values_Range loop
         if( do_totals )then
               row( v ) := table.totals( v ).amount;
         else
               row( v ) := table.cells( which_breakdown )( v ).amount;
         end if;
      end loop;
      return row;
   end Extract_Costs_Row;

   
end Costs_Tabulator;
