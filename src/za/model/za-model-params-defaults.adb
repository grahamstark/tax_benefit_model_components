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

package body ZA.Model.Params.Defaults is
   
   function Get_Parameters( year : AvailableYears ) return Parameters is
      params : Parameters;
   begin
      case year is
         when 2009 => 
            Set_Rate_And_Band( 
               params.income_tax.rbs, ( rate=>0.18, band=>132_000.0 ), 1 );
            Set_Rate_And_Band( 
               params.income_tax.rbs, ( rate=>0.25, band=>210_000.0 ), 2 );
            Set_Rate_And_Band( 
               params.income_tax.rbs, ( rate=>0.30, band=>290_000.0 ), 3 );
            Set_Rate_And_Band( 
               params.income_tax.rbs, ( rate=>0.35, band=>410_000.0 ), 4 );
            Set_Rate_And_Band( 
               params.income_tax.rbs, ( rate=>0.38, band=>525_000.0 ), 5 );
            Set_Rate_And_Band( 
               params.income_tax.rbs, ( rate=>0.40, band=>Amount'Last ), 6 );
            params.income_tax.age_limit( male ) := 63; -- FIXME check this again
            params.income_tax.age_limit( female ) := 60; -- FIXME check this again
            params.income_tax.rebate := 9_756.0;
            params.income_tax.age_rebate := 5_400.0;
            params.income_tax.threshold := 54_200.0;
            params.income_tax.age_threshold := 84_200.0;
            params.income_tax.taxable_income := ( 
               employers_uif => -1.0, 
               Gross_Personal_Incomes_Range => 1.0, 
               In_Kind_Personal_Incomes_Range => 1.0, 
               Others => 0.0 ); 
               -- plus employers' pension and health from expenses
            params.income_tax.threshold_income := ( 
               employers_uif => -1.0, 
               Gross_Personal_Incomes_Range => 1.0, 
               In_Kind_Personal_Incomes_Range => 1.0,  
               Others => 0.0 ); 
               -- plus employers' pension and health from expenses
            --
            -- FIXME 149_736.00 is the 08 figure from the quick guide to UIF, 
            -- not the 09 one
            -- which I can't find anywhere
            -- 
            Set_Rate_And_Band( params.uif.employees.rbs, 
               ( rate => 0.01, band => 149_736.00 ), 1 );
            Set_Rate_And_Band( params.uif.employees.rbs, 
               ( rate => 0.00, band => Amount'Last ), 2 ); 
            Set_Rate_And_Band( params.uif.employers.rbs, 
               ( rate => 0.01, band => 149_736.00 ), 1 );
            Set_Rate_And_Band( params.uif.employers.rbs, 
               ( rate => 0.00, band => Amount'Last ), 2 ); 
            
            params.uif.employers.income := (
               salaries_and_wages => 1.0, Others => 0.0 ); 
               -- CHECK UIF on SE Incomes?
            params.uif.employees.income := ( 
               employers_uif => -1.0, salaries_and_wages => 1.0, Others => 0.0 );
            params.uif.employees.max_age( female ) := 59;
            params.uif.employees.max_age( male ) := 62;
            params.uif.employers.max_age( female ) := 59;
            params.uif.employers.max_age( male ) := 62;
               
            params.income_tax.health_capped_amount_per_person := 
               ( 1 .. 2 => 570.0*12.0, Others => 345.0*12.0 );
            params.income_tax.health_income_limitation_rate := 0.075;
            --
            -- FIXME check if 65 should be 63 (pension age)
            -- and different male/female
            -- and if these have been uprated since 2007
            -- 
            params.income_tax.health_age_limit := 65;
            params.income_tax.pension_contribution_limit := 1_750.0;
            params.income_tax.pension_income_limitation_rate := 0.075;
            params.income_tax.health_allow_all_for_disabled := True;
            params.income_tax.annuity_contribution_limit := 3_500.0;
            params.income_tax.annuity_income_limitation_rate := 0.150;
            params.income_tax.interest_exemption := 19_000.0; 
            params.income_tax.age_interest_exemption := 27_500.0; 
            
            params.indirect.vat := ( Others => 0.14 );
            --
            -- FIXME we need to disaggregate these 
            -- See indirect_calc.rb for how we derive these prices from
            -- the shares in the 2009 budget documents (REF??)
            -- 
            params.indirect.selling_price := (  
               spirits              => 81.54, -- 43% tax
               wine                 => 9.56,  -- 33% tax
               beer                 => 7.37,  -- 23% tax
               tobacco              => 19.39, -- 52% tax
               fuels_and_lubricants => 6.43, -- from (REF??)
               -- gas,
               -- liquid_fuels,
               -- solid_fuels,
               Others               => 1.0 -- not needed since no specific taxes
            );
            params.indirect.advalorem := ( Others => 0.0 );
            -- Figures from Tax Proposals 2009/10 from SARS site
            params.indirect.specific := ( 
               spirits              => 25.05, 
               wine                 => 1.98, -- 750ml bottle
               beer                 => 0.79, -- 35cl bottle from Answers.com! 12
               tobacco              => 7.70, -- pkt 20 cigs
               fuels_and_lubricants => 2.18, 
                  -- http://www.shell.co.za/vpower/pprice.htm 
                  -- pump price of petrol/litre in Gauteng 
               Others               => 0.0 );
            params.indirect.proportion_vatable := ( -- taken from AA's model 
               bread_and_cereals    => 0.7,
               fish                 => 0.9,
               milk_cheese_and_eggs => 0.7,
               oils_and_fats        => 0.8,
               fruits               => 0.4,
               vegetables           => 0.4,
               Others               => 1.0 );

            params.benefits.grant_for_older_persons.min_age( male ) := 63;
            params.benefits.grant_for_older_persons.min_age( female ) := 60;
            params.benefits.grant_for_older_persons.income_threshold_single  
               := 29_112.0;
            params.benefits.grant_for_older_persons.income_threshold_couple  
               := 58_224.0;
            params.benefits.grant_for_older_persons.capital_threshold_single 
               := 484_800.0;
            params.benefits.grant_for_older_persons.capital_threshold_couple 
               := 969_600.0;
            params.benefits.grant_for_older_persons.withdrawal_rate          
               := Rate'Last;
            params.benefits.grant_for_older_persons.incomes_list := ( 
               employers_uif => -1.0, 
               Gross_Personal_Incomes_Range => 1.0, 
               In_Kind_Personal_Incomes_Range => 1.0,
               Others=> 0.0 );
            params.benefits.grant_for_older_persons.amount_payable           
               := 1_010.00 * 12.0;

            params.benefits.care_dependency_grant.min_age( male ) := 1;
            params.benefits.care_dependency_grant.min_age( female ) := 1;
            params.benefits.care_dependency_grant.max_age( male ) := 17;
            params.benefits.care_dependency_grant.max_age( female ) := 17;
            params.benefits.care_dependency_grant.income_threshold_single  
               := 121_200.0;
            params.benefits.care_dependency_grant.income_threshold_couple  
               := 242_400.0;
            params.benefits.care_dependency_grant.capital_threshold_single 
               := Amount'Last;
            params.benefits.care_dependency_grant.capital_threshold_couple 
               := Amount'Last;
            params.benefits.care_dependency_grant.withdrawal_rate          
               := Rate'Last;
            params.benefits.care_dependency_grant.incomes_list  := ( 
               employers_uif => -1.0, 
               Gross_Personal_Incomes_Range => 1.0, 
               In_Kind_Personal_Incomes_Range => 1.0,
               Others=> 0.0 );
            params.benefits.care_dependency_grant.amount_payable           
               := 1_010.00 * 12.0;
            
            params.benefits.child_support_grant.max_age( male ) := 14;
            params.benefits.child_support_grant.max_age( female ) := 14;
            params.benefits.child_support_grant.income_threshold_single  
               := 28_800.0;
            params.benefits.child_support_grant.income_threshold_couple  
               := 57_600.0;
            params.benefits.child_support_grant.capital_threshold_single 
               := Amount'Last;
            params.benefits.child_support_grant.capital_threshold_couple 
               := Amount'Last;
            params.benefits.child_support_grant.withdrawal_rate          
               := Rate'Last;
            params.benefits.child_support_grant.incomes_list := ( 
               employers_uif => -1.0, 
               Gross_Personal_Incomes_Range => 1.0, 
               In_Kind_Personal_Incomes_Range => 1.0,
               Others=> 0.0 );
            params.benefits.child_support_grant.amount_payable           
               := 240.00 * 12.0;

            params.benefits.disability_grant.min_age( male ) := 18;
            params.benefits.disability_grant.min_age( female ) := 18;
            params.benefits.disability_grant.max_age( male ) := 62;
            params.benefits.disability_grant.max_age( female ) := 59;
            params.benefits.disability_grant.income_threshold_single  := 
               29_112.0;
            params.benefits.disability_grant.income_threshold_couple  := 
               58_224.0;
            params.benefits.disability_grant.capital_threshold_single := 
               484_800.0;
            params.benefits.disability_grant.capital_threshold_couple := 
               969_600.0;  -- not used at present
            params.benefits.disability_grant.withdrawal_rate := Rate'Last;
            params.benefits.disability_grant.incomes_list := ( 
               employers_uif => -1.0, 
               Gross_Personal_Incomes_Range => 1.0, 
               In_Kind_Personal_Incomes_Range => 1.0,
               Others=> 0.0 );
            params.benefits.disability_grant.amount_payable := 1_010.00 * 12.0;
         end case;
      return params;
   end Get_Parameters;

end ZA.Model.Params.Defaults;
