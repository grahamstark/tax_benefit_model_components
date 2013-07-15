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

with ZA.Model.Params.Defaults;
with Ada.Text_IO;

package body ZA.Model.Params.Wider is

   use ZA_Key_Value_IO;
   use Ada.Text_IO;
   
   type Quick_Params is record
      income_taxrate1    : Rate;
      income_taxrate6    : Rate;
      rebate             : Amount;
      age_rebate         : Amount;
      employees_uif_rate : Amount;
      employers_uif_rate : Amount;
      vat_food           : Rate;
      vat_other          : Rate;
      pension            : Amount;
      child_support      : Amount;
      disability         : Amount;
      beer               : Amount;
      wine               : Amount;
      spirits            : Amount;
      tobacco            : Amount;
      petrol             : Amount;
   end record;
   
   procedure Map( params : in out Parameters; quick : Quick_Params ) is 
      vat_food : constant Rate := quick.vat_food/100.0;
      vat_other : constant Rate := quick.vat_other/100.0;
   begin
      Set_Rate_And_Band( params.income_tax.rbs, ( rate=>quick.income_taxrate1/100.0, band=>132_000.0 ), 1 );
      Set_Rate_And_Band( params.income_tax.rbs, ( rate=>quick.income_taxrate6/100.0, band=>Amount'Last ), 6 );
      params.income_tax.rebate := quick.rebate;
      params.income_tax.age_rebate := quick.age_rebate;
      Set_Rate_And_Band( params.uif.employees.rbs, ( rate => quick.employees_uif_rate/100.0, band => 149_736.00 ), 1 );
      Set_Rate_And_Band( params.uif.employers.rbs, ( rate => quick.employers_uif_rate/100.0, band => 149_736.00 ), 1 );
      params.benefits.child_support_grant.amount_payable := quick.child_support * 12.0;
      params.benefits.disability_grant.amount_payable := quick.disability * 12.0;
      params.benefits.grant_for_older_persons.amount_payable := quick.pension * 12.0;
      params.indirect.specific( spirits ) := quick.spirits;
      params.indirect.specific( wine ) := quick.wine;
      params.indirect.specific( beer ) := quick.beer;
      params.indirect.specific( tobacco ) := quick.tobacco;
      params.indirect.specific( fuels_and_lubricants ) := quick.petrol;
      for v in params.indirect.vat'Range loop
         if( v in Food_Range ) then
             params.indirect.vat( v ) := vat_food;
         else
            params.indirect.vat( v ) := vat_other;
         end if;
      end loop;
   end Map;

   function Get_Parameters( filename : String ) return Parameters is
      params : Parameters := ZA.Model.Params.Defaults.Get_Parameters( 2009 );
      quick  : Quick_Params;
      f      : Ada.Text_IO.File_Type;
   begin
      Open( f, In_File, filename );
      quick.income_taxrate1    := Read( f, "tax_income_taxrate1" );
      quick.income_taxrate6    := Read( f, "tax_income_taxrate6" );
      quick.rebate             := Read( f, "tax_rebate" );
      quick.age_rebate         := Read( f, "tax_age_rebate" );
      quick.employees_uif_rate := Read( f, "tax_employees_uif_rate" );
      quick.employers_uif_rate := Read( f, "tax_employers_uif_rate" );
      quick.pension            := Read( f, "benefits_pension" );
      quick.child_support      := Read( f, "benefits_child_support" );
      quick.disability         := Read( f, "benefits_disability" );
      quick.vat_food           := Read( f, "indir_vat_food" );
      quick.vat_other          := Read( f, "indir_vat_other" );
      quick.beer               := Read( f, "indir_beer" );
      quick.wine               := Read( f, "indir_wine" );
      quick.spirits            := Read( f, "indir_spirits" );
      quick.tobacco            := Read( f, "indir_tobacco" );
      quick.petrol             := Read( f, "indir_petrol" );
      Map( params, quick );
      Close( f );
      return params;
   end Get_Parameters;

end ZA.Model.Params.Wider;
