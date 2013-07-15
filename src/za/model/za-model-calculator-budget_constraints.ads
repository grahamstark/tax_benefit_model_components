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

with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;

package ZA.Model.Calculator.Budget_Constraints is
   
   use Ada.Strings.Unbounded;

   type Gross_And_Net is record
      gross : Amount;
      net   : Amount;
      description : Unbounded_String;
   end record;
   
   package Gross_And_Net_Package is new Ada.Containers.Vectors( Element_Type => Gross_And_Net , Index_Type => Positive );
   subtype Gross_And_Net_List is Gross_And_Net_Package.Vector;
   
   function Generate_Budget_Constraint( 
      hh           : Household;
      params       : Parameters;
      settings     : Run_Settings;
      which_family : Family_Unit_Range;
      which_person : Person_Range ) return Gross_And_Net_List;
   
end ZA.Model.Calculator.Budget_Constraints;
