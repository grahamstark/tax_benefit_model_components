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

package body ZA.Model.Settings is

   function Get_Default_Settings( working_dir : String; target : Model_Target_Type ) return Run_Settings is
      settings : Run_Settings;
   begin
      settings.income_adjustment := to_national_accounts;
      -- FIXME remember to uprate these!
      -- from http://www.finance.gov.za/publications/other/povertyline/Treasury%20StatsSA%20poverty%20line%20discussion%20paper.pdf
      settings.poverty.poverty_line_per_adult := 431.0 * 12.0;
      settings.poverty.poverty_line_per_child := 431.0 * 12.0;
      settings.poverty.included_consumption_items := (
         income_from_imputed_rent_on_owned_dwellingi_7pct_per_year_of_dwelling => 1.0,
         subsidy_on_payment_of_mortgage   => 1.0,
         imputed_cost_for_home_production => 1.0,
         Others                           => 0.0
      );
      settings.poverty.included_income := (
         Gross_Personal_Incomes_Range   => 1.0,
         In_Kind_Personal_Incomes_Range => 1.0,
         Personal_State_Benefits_Range  => 1.0,
         Personal_Taxes_Range           => -1.0 );
      settings.poverty.deduct_indirect_taxes := True;
      case target is
      when windows =>
         settings.paths.data_dir := To_Unbounded_String( "C:\IES\MODEL_DATA\" );
         settings.paths.run_root := To_Unbounded_String( WORKING_DIR );
         settings.paths.params_dir := To_Unbounded_String( WORKING_DIR & "\params\" );
         settings.paths.output_dir := To_Unbounded_String( WORKING_DIR & "\results\" );
      when development =>
         settings.paths.data_dir := To_Unbounded_String( "/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/model_datasets/za/" );
         settings.paths.run_root := To_Unbounded_String( working_dir );
         settings.paths.params_dir := To_Unbounded_String( working_dir & "/params/" );
         settings.paths.output_dir := To_Unbounded_String( working_dir & "/results/" );
      when web =>
         settings.paths.data_dir := To_Unbounded_String( "/home/za/micro/data/"  );
         settings.paths.run_root := To_Unbounded_String( working_dir );
         settings.paths.params_dir := To_Unbounded_String( working_dir & "/params/" );
         settings.paths.output_dir := To_Unbounded_String( working_dir & "/results/" );
      end case;
      settings.takeup_adjustment := crude_probability;
      settings.compute_marginal_rates     := none;
      settings.compute_budget_constraints := none;
      return settings;
   end Get_Default_Settings;

end ZA.Model.Settings;
