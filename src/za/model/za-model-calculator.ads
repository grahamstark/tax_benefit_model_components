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

with ZA.Model.Params;
with ZA.Model.Data;
with ZA.Model.Results;
with ZA.Model.Settings;

package ZA.Model.Calculator is

   use ZA.Model.Params;
   use ZA.Model.Data;
   use ZA.Model.Results;
   use ZA.Model.Settings;

   function Calculate( 
      hh       : Household; 
      params   : Parameters; 
      settings : Run_Settings ) return Household_Result;

   function Calculate_Marginal_Rate( 
      hh       : Household; 
      params   : Parameters; 
      settings : Run_Settings;
      income_increment : Amount;
      increment_target : Personal_Incomes_Type := salaries_and_wages;
      which_family : Family_Unit_Range := 1; 
      which_person : Person_Range := 1 ) return Household_Result;
   
end ZA.Model.Calculator;
