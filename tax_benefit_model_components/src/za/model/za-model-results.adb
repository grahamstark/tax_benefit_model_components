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

with Ada.Strings.Unbounded;
with Text_Utils;
with Ada.Assertions;

package body ZA.Model.Results is

   use Ada.Assertions;
   
   NET_INCOME_LIST : constant Included_Income_Array := ( 
      Personal_Taxes_Range => -1.0, Others=>1.0 );
   ALL_TAXES_LIST : constant Included_Income_Array := ( 
      Personal_Taxes_Range => 1.0, Others=>0.0 );
   ALL_BENEFITS_LIST : constant Included_Income_Array := ( 
      Personal_State_Benefits_Range => 1.0, Others=>0.0 );

   procedure Accumulate( hh : Household; settings : Run_Settings; res : in out Household_Result ) is
      use Consumption_Package;
      use Income_Package;
   begin
      each_family:
      for fno in 1 .. res.num_families loop
         each_person:
         for pno in 1 .. res.family( fno ).num_people loop
            res.family( fno ).person( pno ).disposable_income := 
               Calculate_Income( 
                  res.family( fno ).person( pno ).income, NET_INCOME_LIST );  
            res.disposable_income := res.disposable_income +
                  res.family( fno ).person( pno ).disposable_income;
            res.family( fno ).disposable_income := 
                  res.family( fno ).disposable_income +
                  res.family( fno ).person( pno ).disposable_income;
            res.total_benefits := res.total_benefits + 
               Calculate_Income( 
                  res.family( fno ).person( pno ).income, ALL_BENEFITS_LIST );  
            res.total_direct_taxes := res.total_direct_taxes + 
               Calculate_Income( 
                  res.family( fno ).person( pno ).income, ALL_TAXES_LIST );
            res.income := res.income + res.family( fno ).person( pno ).income;
            res.family( fno ).income := res.family( fno ).income + 
               res.family( fno ).person( pno ).income;
         end loop each_person;
      end loop each_family;
      res.total_vat := Sum( res.vat );
      res.total_excise := Sum( res.specific ) + Sum( res.ad_valorem );
      --
      -- add in inputed incomes and home production if needed
      --
      res.disposable_income := res.disposable_income + 
         Sum( hh.info.consumption, settings.poverty.included_consumption_items );
      res.net_income := res.disposable_income - res.total_vat - res.total_excise;
      res.per_capita_net_income := res.net_income/Amount( res.num_people );
      res.per_capita_disposable_income := res.disposable_income/Amount( res.num_people );
   end Accumulate;
   

   function Difference( res1, res2 : Personal_Result ) return Personal_Result is
      diff : Personal_Result;
   begin
      diff.marginal_tax_rate := 
         res1.marginal_tax_rate - res2.marginal_tax_rate;
      diff.income_tax_deduction := 
         res1.income_tax_deduction - res2.income_tax_deduction;
      diff.taxable_income := 
         res1.taxable_income - res2.taxable_income;
      diff.disposable_income := 
         res1.disposable_income - res2.disposable_income;
      for i in res1.income'Range loop
         diff.income(i) := res1.income(i) - res2.income(i);
      end loop;
      return diff;
   end Difference;
   
   function Difference( res1, res2 : Family_Result ) return Family_Result is
      diff : Family_Result;
   begin
      for pno in 1 .. res1.num_people loop      
         diff.person( pno ) := Difference( 
               res1.person( pno ), 
               res2.person( pno ));
      end loop;
      for i in res1.income'Range loop
         diff.income(i) := res1.income(i) - res2.income(i);
      end loop;
      diff.disposable_income := res1.disposable_income - res2.disposable_income;
      return diff;
   end Difference;
               
   function Difference( res1, res2 : Household_Result ) return Household_Result is
      diff : Household_Result;
   begin
      diff.net_income := res1.net_income - res2.net_income;
      diff.disposable_income := res1.disposable_income - res2.disposable_income;
      diff.per_capita_net_income := 
         res1.per_capita_net_income - res2.per_capita_net_income;
      diff.per_capita_disposable_income := 
         res1.per_capita_disposable_income - res2.per_capita_disposable_income;
      for i in res1.income'Range loop
         diff.income(i) := res1.income(i) - res2.income(i);
      end loop;
      for i in res1.vat'Range loop
         diff.vat(i) := res1.vat(i) - res2.vat(i);
         diff.specific(i) := res1.specific(i) - res2.specific(i);
         diff.ad_valorem(i) := res1.ad_valorem(i) - res2.ad_valorem(i);
      end loop;
      diff.total_vat := res1.total_vat - res2.total_vat;
      diff.total_excise := res1.total_excise - res2.total_excise;
      diff.total_direct_taxes := res1.total_direct_taxes - res2.total_direct_taxes;
      diff.total_benefits := res1.total_benefits - res2.total_benefits;
      diff.poverty_gap := res1.poverty_gap - res2.poverty_gap;
      diff.poverty_line := res1.poverty_line - res2.poverty_line;
      diff.equivalence_scale := res1.equivalence_scale - res2.equivalence_scale;
      for fno in 1 .. res1.num_families loop
         for pno in 1 .. res1.family( fno ).num_people loop         
            diff.family( fno ) := Difference( res1.family( fno ), res2.family( fno ));
         end loop;
      end loop;
      return diff;
   end Difference;
   
   function To_String( 
      res : Personal_Result; 
      include_non_zeros : Boolean := False ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      s := s & "Disposable Income = " & Format( res.disposable_income ) & LINE_BREAK;
      s := s & "---- Calculated Components of income -------- " & LINE_BREAK;
      for i in res.income'Range loop
         if(( res.income(i) /= 0.0 ) or include_non_zeros ) then
            s := s & Pretty_Print( i ) & " = " & Format( res.income(i) ) & LINE_BREAK;
         end if;
      end loop;
      s := s & "Taxable Income = " & Format( res.taxable_income ) & LINE_BREAK;
      s := s & "Income tax deductions = " & Format( res.income_tax_deduction  ) & LINE_BREAK;
      s := s & "Marginal tax rate = " & Format( res.marginal_tax_rate ) & LINE_BREAK;
      return To_String( s );
   end To_String;

   function To_String( 
      res : Family_Result; 
      include_non_zeros : Boolean := False ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      s := s & "Family Disposable income (Before Indirect Taxes ) = " & Format( res.disposable_income ) & LINE_BREAK;
      s := s & "====== Family INCOMES ======= " & LINE_BREAK;
      for i in res.income'Range loop
         if(( res.income(i) /= 0.0 ) or include_non_zeros ) then
            s := s & Pretty_Print( i ) & " = " & Format( res.income(i) ) & LINE_BREAK;
         end if;
      end loop;
      for pno in 1 .. res.num_people loop
         s := s & "     Person Number " & Person_Count'Image( pno ) & LINE_BREAK;
         s := s & To_String( res.person( pno ));
         s := s & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( 
      res : Household_Result; 
      include_non_zeros : Boolean := False ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
      s : Unbounded_String;
   begin
      s := s & "Household Disposable income (Before Indirect Taxes ) = " & Format( res.disposable_income ) & LINE_BREAK;
      s := s & "Household Net income (After Indirect Taxes ) = " & Format( res.net_income ) & LINE_BREAK;
      s := s & "Per Capita Household Disposable income (Before Indirect Taxes ) = " & Format( res.per_capita_disposable_income ) & LINE_BREAK;
      s := s & "Per Capita Household Net income (After Indirect Taxes ) = " & Format( res.per_capita_net_income ) & LINE_BREAK;
      s := s & "====== Household INCOMES ======= " & LINE_BREAK;
      for i in res.income'Range loop
         if(( res.income(i) /= 0.0 ) or include_non_zeros ) then
            s := s & Pretty_Print( i ) & " = " & Format( res.income(i) ) & LINE_BREAK;
         end if;
      end loop;
      s := s & "====== VAT Payments ======= " & LINE_BREAK;
      for i in res.vat'Range loop
         if(( res.vat(i) /= 0.0 ) or include_non_zeros ) then
            s := s & Pretty_Print( i ) & " = " & Format( res.vat(i) ) & LINE_BREAK;
         end if;
      end loop;
      s := s & "====== Specific Duties ======= " & LINE_BREAK;
      for i in res.specific'Range loop
         if(( res.specific(i) /= 0.0 ) or include_non_zeros ) then
            s := s & Pretty_Print( i ) & " = " & Format( res.specific(i) ) & LINE_BREAK;
         end if;
      end loop;
      s := s & "====== Ad Valorem Payments ======= " & LINE_BREAK;
      for i in res.ad_valorem'Range loop
         if(( res.ad_valorem(i) /= 0.0 ) or include_non_zeros ) then
            s := s & Pretty_Print( i ) & " = " & Format( res.ad_valorem(i) ) & LINE_BREAK;
         end if;
      end loop;
      
      s := s & "Total vat = " & Format( res.total_vat ) & LINE_BREAK;
      s := s & "Total excise = " & Format( res.total_excise ) & LINE_BREAK;
      s := s & "Total direct taxes = " & Format( res.total_direct_taxes ) & LINE_BREAK;
      s := s & "Total benefits = " & Format( res.total_benefits ) & LINE_BREAK;
      s := s & "Poverty state= " & Pretty_Print( res.poverty ) & LINE_BREAK;
      s := s & "Poverty gap = " & Format( res.poverty_gap ) & LINE_BREAK;
      s := s & "Poverty line = " & Format( res.poverty_line ) & LINE_BREAK;
      s := s & "Equivalence scale = " & Format( res.equivalence_scale ) & LINE_BREAK;
      for fno in 1 .. res.num_families loop
         s := s & " Family Number " & Family_Unit_Count'Image( fno ) & LINE_BREAK;
         s := s & To_String( res.family( fno ));
         s := s & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;
   
   function Map( results : Household_Result ) return All_Taxes_And_Benefits_Array is
      agg : All_Taxes_And_Benefits_Array;
   begin
      agg( disability_grants ) := results.income( disability_grants );
      agg( old_age_pensions ) := results.income( old_age_pensions );
      agg( child_support ) := results.income( family_allowances );
      agg( other_state_benefits ) := results.income( other_state_benefits );
      agg( income_tax ) := results.income( site_income_tax );
      agg( employers_uif ) := results.income( employers_uif );
      agg( employees_uif ) := results.income( employees_uif );
      agg( vat ) := results.total_vat;
      agg( spirits ) := 
         results.specific( spirits ) + results.ad_valorem( spirits );
      agg( wine ) := results.specific( wine ) + results.ad_valorem( wine );
      agg( beer ) := results.specific( beer ) + results.ad_valorem( beer );
      agg( tobacco ) := 
         results.specific( tobacco ) + results.ad_valorem( tobacco );   
      agg( petrol ) := 
         results.specific( fuels_and_lubricants ) + 
         results.ad_valorem( fuels_and_lubricants );
      return agg;                
   end Map;

   function Map( results : Household_Result ) return Summary_Items_Array is
      agg : Summary_Items_Array;
   begin
      agg( benefits ) := 
         results.income( disability_grants ) +
         results.income( old_age_pensions ) +
         results.income( family_allowances ) +
         results.income( other_state_benefits );
      agg( direct_taxes ) := results.income( site_income_tax ) +
         results.income( employers_uif ) +
         results.income( employees_uif );
      agg( indirect_taxes ) := results.total_vat +
         results.specific( spirits ) + results.ad_valorem( spirits ) +
         results.specific( wine ) + results.ad_valorem( wine ) +
         results.specific( beer ) + results.ad_valorem( beer ) +
         results.specific( tobacco ) + results.ad_valorem( tobacco ) +   
         results.specific( fuels_and_lubricants ) + 
         results.ad_valorem( fuels_and_lubricants );
      agg( disposable_income ) := results.disposable_income;
      agg( net_income ) := results.net_income;
      return agg;                
   end Map;

   
end ZA.Model.Results;

