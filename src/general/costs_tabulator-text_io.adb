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

package body Costs_Tabulator.Text_IO is
   
   use IO_Commons;
   use Text_Utils;

   procedure Print( 
         f                : File_Type;
         table_name       : String;
         table            : Table_Type;
         table_number     : Positive;
         row_var_name     : String;
         col_var_name     : String;
         year             : Positive;
         sysno            : Positive ) is
   begin
      Write_Header( 
         f, 
         table_number, 
         table_name, 
         -1,
         Breakdown_Range'Pos( Breakdown_Range'Last ) + 1,
         Values_Range'Pos( Values_Range'Last ) + 1,
         row_var_name,
         col_var_name,
         budget,
         sysno );
      Put( f, "," );
      for v in Values_Range loop 
          Put( f, """" & Censor_String( Values_Range'Image( v )) & """," );
      end loop;
      New_Line( f  );
      for b in Breakdown_Range loop
         Put( f, Censor_String( Breakdown_Range'Image( b )) & "," );
         for v in Values_Range loop 
             Put( f, Data_Type'Image( table.cells( b )( v ).amount ) & "," ); 
         end loop;
         New_Line( f );
      end loop;
      Put( f, "," );
      for v in Values_Range loop 
          Put( f, Data_Type'Image( table.totals( v ).amount ) & "," ); 
      end loop;
      New_Line( f );
   end Print;

end Costs_Tabulator.Text_IO;
