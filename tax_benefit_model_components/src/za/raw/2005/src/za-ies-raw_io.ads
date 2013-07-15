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

with Data_Index;

package ZA.IES.Raw_IO is
   
   type Record_Components is ( 
      Supported_Persons_Rec, 
      Person_Info_Rec, 
      Purchase_Place_Rec, 
      House_Info_Rec, 
      Total_IES_Rec, 
      Person_Income_Rec );
   
   package IES_Data_Index is new Data_Index( 
      Unique_ID_Type => Sernum_Value, 
      Record_Components => Record_Components );
      
   subtype Index_Map is IES_Data_Index.Data_Index_Map;
   subtype Index_Rec is IES_Data_Index.Data_Index_Rec;
   subtype Index_Cursor is IES_Data_Index.Data_Index_Cursor;
   package IES_Map_Package renames IES_Data_Index.Data_Index_Map_Package;
   
   function Open_Index return Index_Map;
   procedure Close_Index( indexmap : in out Index_Map );
   procedure Convert_To_Binary( indexmap : in out Index_Map );
   function Read_Household( index : in Index_Rec ) return Household;
   procedure Close_Files;
   procedure Open_Files;
end ZA.IES.Raw_IO;
