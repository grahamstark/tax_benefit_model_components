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
with Wider_IO_Commons;
with Text_Utils;

package body Poverty_Tabulator.Wider_IO is
   
   use Wider_IO_Commons;
   use Text_Utils;
   
   procedure Print( 
         f : File_Type; 
         table_name       : String;
         table            : Table_Type;
         table_number     : Positive;
         row_var_name     : String;
         year             : Simulation_Year_Range;
         sysno            : System_Number
      ) is
   begin
      Write_Header( 
         f, 
         table_number, 
         table_name, 
         -1, -- no change column
         year, 
         Breakdown_Range'Pos( Breakdown_Range'Last ) + 1, -- num rows
         Poverty_Elements'Pos( Poverty_Elements'Last ) + 1, -- num columns
         row_var_name,
         "poverty_status",
         budget,
         sysno );
      --
      -- col labels
      --
      Put( f, "," );
      write_col_labels:
      for col in Poverty_Elements loop
         Put( f, """" & Censor_String( Poverty_Elements'Image( col )) & """," );
      end loop write_col_labels;
      New_Line( f );

      write_data_rows:
      for row in Breakdown_Range loop
         Put( f, """" & Censor_String( Breakdown_Range'Image( row )) & """," );
         for col in Poverty_Elements loop
            Put( f, Data_Type'Image( table.cells( row )( col )) & "," );
         end loop;
         New_Line( f );
      end loop write_data_rows;
      Put( f, """totals""," );
      write_totals_row:
      for col in Poverty_Elements loop
         Put( f, Data_Type'Image( table.totals( col )) & "," );
      end loop write_totals_row;
      New_Line( f );
   end Print;

end Poverty_Tabulator.Wider_IO;
