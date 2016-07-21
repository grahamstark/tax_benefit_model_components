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

with UK_Suite;

with AUnit.Run;
with AUnit.Reporter.Text;
with GNATColl.Traces;

procedure UK_Harness is

   procedure Run is new AUnit.Run.Test_Runner( UK_Suite );
   reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   Run( reporter );
end UK_Harness;
