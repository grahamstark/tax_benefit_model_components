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

with Ada.Command_Line;
with Ada.Strings.Unbounded;

with ZA.Model.Calculator.Wider_Runner;
with ZA.Model.Settings;
with ZA.Model.Params;
with ZA.Model.Params.Defaults;
with ZA.Model.Params.Wider;
with ZA.Model_Types;

with Ada.Strings.Unbounded;

procedure ZA_Runner is

   use Ada.Strings.Unbounded;
   use ZA.Model.Settings;
   
   params1 : ZA.Model.Params.Parameters;
   params2 : ZA.Model.Params.Parameters;
   settings : Run_Settings;
   working_dir : constant String := 
      Ada.Command_Line.Argument( 1 );
   target : constant Model_Target_Type := 
      Model_Target_Type'Value( Ada.Command_Line.Argument( 2 ));
begin
   
   settings  := Get_Default_Settings( 
      Working_Dir=>working_dir, Target=>target );
   params1 := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
   params2 := ZA.Model.Params.Wider.Get_Parameters( To_String( settings.paths.params_dir & "parameters.txt" ));
   ZA.Model.Calculator.Wider_Runner.Run_Model( params1, params2, settings );
    
end ZA_Runner;


