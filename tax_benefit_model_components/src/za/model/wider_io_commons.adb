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

package body Wider_IO_Commons is

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
      sysno            : System_Number ) is
  begin
      Put( f, """table""," & Positive'Image( table_number ) & "," );
      Put( f, Integer'Image( no_change_column ) & "," );
      Put( f, "0," ); -- FIXME: jam year to zero for now Simulation_Year_Range'Image( year ) & "," );
      Put( f, Positive'Image( num_rows ) & "," );
      Put( f, Positive'Image( num_cols ) & "," );
      Put( f, """" & col_var_name & """," );
      Put( f, """" & row_var_name & """," );
      Put( f, Integer'Image( Wider_Table_Type'Pos( table_type )) & "," );
      Put( f, "0," ); -- difference op - not used in wider
      Put( f, "0," ); -- comparison op - not used in wider
      Put( f, System_Number'Image( sysno ) & "," );
      Put( f, "0," ); -- comparison op - not used in wider
      Put_Line( f, """" & table_name & """" ); 
  end Write_Header;
  
end Wider_IO_Commons;
