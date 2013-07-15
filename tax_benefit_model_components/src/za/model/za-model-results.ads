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

with ZA.Model.Settings;
with ZA.Model.Data;
with T_Utils;

package ZA.Model.Results is

   use ZA.Model.Settings;
   use ZA.Model.Data;
   
   
   type Intermediate_Health_Results is record
      total_health_spending           : Amount := 0.0;
      capped_amount                   : Amount := 0.0;
      employers_cont_in_gross         : Amount := 0.0;
      capped_amount_deduction         : Amount := 0.0; 
      additional_capping              : Amount := 0.0;
      amount_subject_to_limitation    : Amount := 0.0;
      income_before_medical_deduction : Amount := 0.0;
      calculated_limitation           : Amount := 0.0;
      amount_allowable_as_deduction   : Amount := 0.0;
   end record;
   
   type Intermediate_Tax_Results is record
      rebate           : Amount := 0.0;
      paye_threshold   : Amount := 0.0;
      taxable_income   : Amount := 0.0;
      threshold_income : Amount := 0.0;
   end record; 
   
   type Intermediate_Results is record
      tax    : Intermediate_Tax_Results;
      health : Intermediate_Health_Results;
   end record;
   
   type Personal_Result is record
      marginal_tax_rate      : Rate := 0.0;
      income                 : Income_Array := ( Others=> 0.0 );
      income_less_exemptions : Income_Array := ( Others=> 0.0 );
      deductions             : Personal_Expenses_Array := ( Others=> 0.0 );
      taxable_income         : Amount := 0.0;
      income_tax_deduction   : Amount := 0.0;
      disposable_income      : Amount := 0.0;
      --  intermediate         : Intermediate_Results;
   end record;
   
   type Personal_Result_Array is array( Person_Range ) of Personal_Result; 
   
   type Family_Result is record
      num_people : Person_Count := 0;
      disposable_income : Amount := 0.0;      
      person     : Personal_Result_Array;
      income     : Income_Array := ( Others=>0.0 );
   end record;
   
   type Family_Result_Array is array( Family_Unit_Range ) of Family_Result; 
   
   type Household_Result is record
      disposable_income            : Amount := 0.0;
      per_capita_disposable_income : Amount := 0.0;
      net_income                   : Amount := 0.0;      
      per_capita_net_income        : Amount := 0.0;      
      income                       : Income_Array := ( Others=>0.0 );
      vat                          : Expenditure_Array := ( Others=>0.0 );
      specific                     : Expenditure_Array := ( Others=>0.0 );
      ad_valorem                   : Expenditure_Array := ( Others=>0.0 );
      total_vat                    : Amount := 0.0;
      total_excise                 : Amount := 0.0;
      total_direct_taxes           : Amount := 0.0;
      total_benefits               : Amount := 0.0;
      poverty                      : Poverty_State := not_in_poverty;
      poverty_gap                  : Amount := 0.0;
      poverty_line                 : Amount := 0.0;
      equivalence_scale            : Amount := 1.0;
      num_families                 : Family_Unit_Count := 0;
      num_people                   : Person_Count := 0;
      family                       : Family_Result_Array;
   end record;
   
   function Difference( res1, res2 : Household_Result ) return Household_Result;
   
   function To_String( 
      res : Personal_Result; 
      include_non_zeros : Boolean := False ) return String;
      
   function To_String( 
      res : Family_Result; 
      include_non_zeros : Boolean := False ) return String;

   function To_String( 
      res : Household_Result; 
      include_non_zeros : Boolean := False ) return String;
   
   procedure Accumulate( hh : Household; settings : Run_Settings; res : in out Household_Result );
   
   --
   -- just a little total results array useful for some output routines
   -- FIXME better elsewhere?
   -- 
   type All_Taxes_And_Benefits_Type is (
      disability_grants,
      old_age_pensions,
      child_support,
      other_state_benefits,
      income_tax,
      employers_uif,
      employees_uif,
      vat,
      spirits,
      wine,
      beer,
      tobacco,
      petrol );
      
   package All_Taxes_And_Benefits_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => All_Taxes_And_Benefits_Type );
      
   subtype All_Taxes_And_Benefits_Array is All_Taxes_And_Benefits_Package.Amount_Array;  
   function Map( results : Household_Result ) return All_Taxes_And_Benefits_Array;
   
   type Summary_Items_Type is ( 
      direct_taxes,
      indirect_taxes,
      benefits,
      disposable_income,
      net_income );
      
   package Summary_Items_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Summary_Items_Type );
      
   subtype Summary_Items_Array is Summary_Items_Package.Amount_Array;  
   function Map( results : Household_Result ) return Summary_Items_Array;

end ZA.Model.Results;
