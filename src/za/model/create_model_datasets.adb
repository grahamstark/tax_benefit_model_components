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
pragma License( Modified_GPL );

with ZA.IES;
with ZA.Model.Data;
with ZA.IES.Raw_IO;
with ZA.Model.Data.Binary_IO;
with ZA.Model_Dataset_Maker;


procedure Create_Model_Datasets is

   package raw renames ZA.IES;
   package modhh renames ZA.Model.Data;
   package rio renames ZA.IES.Raw_IO;
   package mio renames ZA.Model.Data.Binary_IO;
   package iesmap renames rio.IES_Map_Package;

   p : Natural := 0;

   procedure Create_Model_HH( pos : iesmap.Cursor ) is
      use type za.Sernum_Value;
      index : rio.Index_Rec := iesmap.Element( pos );
      rhh : raw.Household;
      mhh : modhh.Household;
   begin
         p := p + 1;
         rhh := rio.Read_Household( index );
         mhh := ZA.Model_Dataset_Maker.Map( rhh );
         mio.Write( mhh );
   end Create_Model_HH;

   ind_map : rio.Index_Map := rio.Open_Index;

begin

   rio.Open_Files;
   mio.Set_Model_Data_Dir( "C:\IES\model_data\" );
   mio.Create_Files;
   iesmap.Iterate( ind_map, Create_Model_HH'Access );
   rio.Close_Index( ind_map );
   rio.Close_Files;
   mio.Close_Files;

end Create_Model_Datasets;
