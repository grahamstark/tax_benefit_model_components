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

with Ada.Strings.Unbounded;
with ZA.Model.Takeup;

package ZA.Model.Settings is

   use Ada.Strings.Unbounded;
   use ZA.Model.Takeup;
   type Income_Adjustment_Type is ( to_national_accounts, fixed, no_adjustment );

   type Model_Target_Type is ( windows, development, web );
 
   type Paths_Rec is record
      run_root   : Unbounded_String;
      data_dir   : Unbounded_String;
      output_dir : Unbounded_String;
      params_dir : Unbounded_String;
   end record;
   
   type Poverty_Settings is record
      poverty_line_per_adult : Amount;
      poverty_line_per_child : Amount;
      included_consumption_items : Included_Consumption_Array := ( Others=>0.0 );
      deduct_indirect_taxes : Boolean := True;
      included_income : Income_Array := ( Others => 0.0 );
   end record;
   
   type MR_Compute_Type is ( none, head_of_hh, all_adults );
   
   type Run_Settings is record
      
      income_adjustment          : Income_Adjustment_Type := 
         to_national_accounts;
      poverty                    : Poverty_Settings;
      paths                      : Paths_Rec;
      takeup_adjustment : Takeup_Ajustment_Type := 
         crude_probability;
      compute_marginal_rates     : MR_Compute_Type := none;
      compute_budget_constraints : MR_Compute_Type := none;
      --
      -- Fixme for probit case this needs moved to a per-system place.
      -- It's here so we get the same takeups pre- and post- even
      -- with random selections
      -- 
      case_takes_up              : Benefit_Takeup_Array := (Others=>True);
    end record;
   
   function Get_Default_Settings( 
      working_dir : String; 
      target : Model_Target_Type ) return Run_Settings;

end ZA.Model.Settings;
