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

package ZA.Model.Params is

   type Amount_By_Gender is array( Gender_Type ) of Amount;
   type Age_By_Gender is array( Gender_Type ) of Age_Range;
   
   type Per_Person_Allowance is array( Person_Range ) of Amount;
   
   type Income_Tax_Rec is record
   --
   -- FIXME consolidate all these age ranges into a single 
   -- retirement age?
   --
      rbs              : Rates_And_Bands;
      age_limit        : Age_By_Gender := ( Others=> Age_Range'Last );
      rebate           : Amount := 0.0;
      age_rebate       : Amount := 0.0;
      threshold        : Amount := 0.0;
      age_threshold    : Amount := 0.0;
      taxable_income   : Included_Income_Array := ( Others=>0.0 ); -- note we have to deduct exempt chunks from this
      threshold_income : Included_Income_Array := ( Others=>0.0 );
      health_capped_amount_per_person : Per_Person_Allowance := ( Others=>0.0);
      health_income_limitation_rate : Rate := 0.0;
      health_age_limit : Age_Range := Age_Range'Last;
      health_allow_all_for_disabled : Boolean := False;
      pension_contribution_limit : Amount := 0.0;
      pension_income_limitation_rate : Rate := 0.0;      
      annuity_contribution_limit : Amount := 0.0;
      annuity_income_limitation_rate : Rate := 0.0;
      interest_exemption : Amount := 0.0; 
      age_interest_exemption : Amount := 0.0; 
    end record;
   
   type One_UIF_Rec is record
      rbs           : Rates_And_Bands;
      income        : Included_Income_Array;
      --
      -- FIXME: we need the labour force matching records for this
      -- but don't yet have them as of 3/8/09
      -- so keep this unset for now
      minimum_hours : Hours_Of_Work_Per_Month := Hours_Of_Work_Per_Month'First;
      --
      -- FIXME: see section 11 of quick guide on deductions
      --  
      max_age : Age_By_Gender := ( Others=> Age_Range'Last );
   end record;
   
   type UIF_Rec is record
      employers,
      employees : One_UIF_Rec;
   end record;
   
   type Indirect_Tax_Rec is record
      selling_price   : Expenditure_Array;
      vat             : Expenditure_Rate_Array;
      proportion_vatable : Expenditure_Rate_Array;
      advalorem       : Expenditure_Rate_Array;
      specific        : Expenditure_Array;
   end record;
   
    
   type Means_Tested_Benefit is tagged record
      income_threshold_single  : Amount := Amount'Last;
      income_threshold_couple  : Amount := Amount'Last;
      capital_threshold_single : Amount := Amount'Last;
      capital_threshold_couple : Amount := Amount'Last;
      withdrawal_rate          : Rate := Rate'Last;
      incomes_list             : Included_Income_Array := ( Others=>0.0 );
      amount_payable           : Amount := 0.0;
   end record;

   type Grant_For_Older_Persons_Rec is new Means_Tested_Benefit with record
      min_age : Age_By_Gender := ( Others=> Age_Range'Last );
   end record;
   
   type Disability_Grant_Rec is new Means_Tested_Benefit with record
      max_age : Age_By_Gender := ( Others=> Age_Range'Last );
      min_age : Age_By_Gender := ( Others=> Age_Range'First );
   end record;
   
   type Care_Dependency_Grant_Rec is new Means_Tested_Benefit with record
      min_age : Age_By_Gender := ( Others=> Age_Range'First );
      max_age : Age_By_Gender := ( Others=> Age_Range'Last );
   end record;
  
   type Child_Support_Grant_Rec is new Means_Tested_Benefit with record
      max_age : Age_By_Gender := ( Others=> Age_Range'Last );
   end record;
   
   type Benefit_Rec is record
      grant_for_older_persons : Grant_For_Older_Persons_Rec;
      care_dependency_grant   : Care_Dependency_Grant_Rec;
      disability_grant        : Disability_Grant_Rec;
      child_support_grant     : Child_Support_Grant_Rec;
   end record;

   type Parameters is record
      income_tax : Income_Tax_Rec;
      uif        : UIF_Rec;
      indirect   : Indirect_Tax_Rec;
      benefits   : Benefit_Rec;
   end record;
  
   procedure Uprate( params : in out Parameters; r : Rate );
   
end ZA.Model.Params;
