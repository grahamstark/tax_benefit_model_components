package body Model.Incomes is
   
   function Contains_Incomes( incomes : Incomes_Array; which : Incomes_Set ) return Boolean is
   use Incomes_Package.Set_Ops;
   begin
      return ( not Is_Empty( which and Non_Zero_Incomes( incomes )));
   end Contains_Incomes;

   function Non_Zero_Incomes( incomes : Incomes_Array ) return Incomes_Set is
      use Incomes_Package;
      set :  Incomes_Set;
   begin
      for i in Income_Items loop
         if( incomes(i) /= 0.0 ) then
            Set_Ops.Include( set, i );
         end if;
      end loop;
      return set;
   end Non_Zero_Incomes;
   
   function Non_Zero_Broad_Benefits( incomes : Incomes_Array ) return Broad_Benefits_Set is
      use Broad_Benefits_Package.Set_Ops;
      set : Broad_Benefits_Set;
   begin
      for i in Benefits loop
         if( incomes(i) /= 0.0 ) then
            Include( set, Map_Broad_Benefit(i) );
         end if;
      end loop;
      return set;
   end Non_Zero_Broad_Benefits;
   
   function Contains_Broad_Benefits( incomes : Incomes_Array; which : Broad_Benefits_Set ) return Boolean is
   use Broad_Benefits_Package.Set_Ops;
   begin
      return ( not Is_Empty( which and Non_Zero_Broad_Benefits( incomes )));
   end Contains_Broad_Benefits;
   
  
   function Pretty_Print( b : Broad_Benefits ) return String is
   begin
      case b is
         when income_support => return "Income Support and Equivalent";
         when tax_credits => return "All Tax Credits";
         when child_benefit => return "Child Benefit";
         when state_pension => return "State Pensions";
         when illness_and_disability => return "Illness and Disability";
         when contributory_unemployment => return "Unemployment Benefits (Contributory Job Seeker's Allowances)";
         when other_benefit => return "Any Other Benefit (war, windows, social fund, fuel, etc.)";
      end case;      
   end Pretty_Print;
   
   function Benefit_In_Broad_Set( s : Broad_Benefits_Set; b : Benefits ) return Boolean is
      use Broad_Benefits_Package.Set_Ops;
      bb : constant Broad_Benefits := Map_Broad_Benefit( b );
   begin
      return Contains( s, bb ); 
   end Benefit_In_Broad_Set;

   
   function Map_Broad_Benefit( b : Benefits ) return Broad_Benefits is
      bb : Broad_Benefits;         
   begin
      case b is
         when disability_living_allowance |
              attendance_allowance |
              constantattendance_allowance | 
              severe_disability_allowance |
              invalid_care_allowance |
              incapacity_benefit |
              industrial_injury_disablementBenefit =>
              bb := illness_and_disability;
         when child_benefit => bb := child_benefit;
         when guaranteed_pension_credit |
              savings_pension_credit |
              disabled_persons_tax_credit |
              working_families_tax_credit |
              working_tax_credit |
              child_tax_credit => bb := tax_credits;
         when retirement_pension | 
              widows_pensions => bb := state_pension;
         when income_support | 
              income_related_jobseekers_allowance => bb := income_support;
         when contributory_jobseekers_allowance => bb := contributory_unemployment;
         when maternity_allowance |
              widowed_mothers_allowance |
              widows_payment |
              unemployment_redundancy_insurance |
              war_disablement_pension | 
              new_deal | 
              any_other_benefit | 
              social_fund | 
              war_widow_pension |
              winter_fuel_payments => bb := other_benefit;
      end case;
      return bb;
   end Map_Broad_Benefit;
   
   function Pretty_Print( t : Income_Items ) return String is
   begin
      case t is
         when wages => return "Wages";
         when luncheon_Vouchers => return "Luncheon Vouchers";
         when self_Employment => return "Self Employment";
         when investment_Income => return "Investment Income";
         when pensions => return "Pensions";
         when other_Income => return "Other Income";
         when income_Tax => return "income Tax";
         when national_insurance => return "National Insurance";
         when disability_living_allowance => return "Disability Living Allowance";
         when attendance_allowance => return "Attendance Allowance";
         when constantattendance_allowance => return "Constant Attendance Allowance";
         when social_fund => return "Social Fund";
         when child_benefit => return "Child Benefit";
         when guaranteed_pension_credit => return "Guaranteed Pension Credit";
         when savings_pension_credit => return "Savings Pension Credit";
         when retirement_pension => return "Retirement Pension";
         when widows_pensions => return "Widows Pensions";
         when income_support => return "Income Support";
         when maternity_allowance => return "Maternity Allowance";
         when widowed_mothers_allowance => return "Widowed Mothers Allowance";
         when war_disablement_pension => return "War Disablement Pension";
         when war_widow_pension => return "War Widow Pension";
         when severe_disability_allowance => return "Severe Disability Allowance";
         when disabled_persons_tax_credit => return "Disabled Persons Tax Credit";
         when invalid_care_allowance => return "Invalid Care Allowance";
         when income_related_jobseekers_allowance => return "Income Related Jobseekers Allowance";
         when contributory_jobseekers_allowance => return "Contributory Jobseekers Allowance";
         when industrial_injury_disablementBenefit => return "Industrial Injury DisablementBenefit";
         when incapacity_benefit => return "Incapacity Benefit";
         when working_families_tax_credit => return "Working Families Tax Credit";
         when new_deal => return "New Deal";
         when working_tax_credit => return "Working Tax Credit";
         when child_tax_credit => return "Child Tax Credit";
         when any_other_benefit => return "Any Other Benefit";
         when widows_payment => return "Widows Payment";
         when unemployment_redundancy_insurance => return "Unemployment Redundancy Insurance";
         when winter_fuel_payments => return "Winter Fuel Payments";
         when trade_union => return "Trade Union";
         when friendly_society_benefits => return "Friendly Society Benefits";
         when private_sickness_scheme => return "Private Sickness Scheme";
         when accident_insurance_scheme => return "Accident Insurance Scheme";
         when hospital_savings_scheme => return "Hospital Savings Scheme";
         when health_insurance => return "Health Insurance";
      end case;
   end Pretty_Print;
   
   function Pretty_Print( e : Expense_Items ) return String is
   begin
      case e is
         when travel_expenses => return "Travel Expenses";
         when pension => return "Pension";
         when avcs => return "avcs";
         when union_fees => return "Union Fees";
         when friendly_societies => return "Friendly Societies";
         when sports => return "Sports";
         when loan_repayments => return "Loan Repayments";
         when medical_insurance => return "Medical Insurance";
         when charities => return "Charities";
         when maintenance_payments => return "Maintenance Payments";
         when childminding => return "Childminding";
         when shared_rent => return "Shared Rent";
         when student_expenses => return "Student Expenses";
      end case;
   end Pretty_Print;
    
   function Pretty_Print( f : Finance_Items ) return String is
   begin
      case f is
         when loan_repayments => return "Loan Repayments";
         when fines_and_transfers => return "Fines And Transfers";
      end case;
   end Pretty_Print;

end Model.Incomes;
