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
with IO_Commons;
with Text_Utils;

package body Tabulator.Text_IO is
   
   use IO_Commons;
   use Text_Utils;
   
   procedure Print( 
         f                : File_Type; 
         table_name       : String;
         tab              : Table_Type;
         table_number     : Positive;
         row_var_name     : String;
         col_var_name     : String;
         year             : Year_Number;
         no_change_column : Integer := -1 
      ) is
      ts : constant Table_Expression := Express_Table( 
         tab, 
         current_cell,       
         counter,
         Cell_Values_Range'First ); -- ignored
      net_1 : constant Table_Expression := Express_Table( 
         tab, 
         current_cell,        
         sys1_level,
         Cell_Values_Range'Last );
      net_2 : constant Table_Expression := Express_Table( 
         tab, 
         current_cell,        
         sys2_level,
         Cell_Values_Range'Last );
   begin
      Write_Header( 
         f, 
         table_number, 
         table_name, 
         no_change_column,
         Row_Range'Pos( Row_Range'Last ) + 1,
         Col_Range'Pos( Col_Range'Last ),
         col_var_name,
         row_var_name,
         gain_lose_table,
         1 );
      Put_Line( f, STD_GAIN_LOSE_SCALE_STR );
      for row in Row_Range loop
         Put( f, """" & Censor_String( Row_Range'Image( row )) & """," );
         for col in Col_Range loop
            Put( f, Data_Type'Image( ts.cells( row, col )) & "," );
         end loop;
         Put( f, Data_Type'Image( ts.row_totals( row )) & "," );
         Put( f, Data_Type'Image( net_1.row_totals( row )) & "," );
         Put( f, Data_Type'Image( net_2.row_totals( row )) );
         New_Line( f );
      end loop;
      Put( f, """totals""," );
      for col in Col_Range loop
         Put( f, Data_Type'Image( ts.col_totals( col )) & "," );
      end loop;
      Put( f, Data_Type'Image( ts.total ) & "," );
      Put( f, Data_Type'Image( net_1.total ) & "," );
      Put( f, Data_Type'Image( net_2.total ));
      New_Line( f );
   end Print;

end Tabulator.Text_IO;
