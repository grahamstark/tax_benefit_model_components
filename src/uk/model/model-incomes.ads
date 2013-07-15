--
--  $Author: graham_s $
--  $Date: 2008-12-14 17:57:36 +0000 (Sun, 14 Dec 2008) $
--  $Revision: 6471 $
--
pragma License( Modified_GPL );

with T_Utils;
--
--  FIXME: takeup record should be moved both out of here and the raw frs
--  reference to raw_frs should then be deleted.
--
package Model.Incomes is

   type Expense_Items is (
      travel_expenses,
      pension,
      avcs,
      union_fees,
      friendly_societies,
      sports,
      loan_repayments,
      medical_insurance, --
      charities,
      maintenance_payments, --
      childminding,
      shared_rent,
      student_expenses);

   package Expenses_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Expense_Items );
   subtype Expenses_Array is Expenses_Package.Amount_Array;
   

   type Finance_Items is (loan_repayments, fines_and_transfers);
   

   package Finance_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Finance_Items );
   subtype Finance_Array is Finance_Package.Amount_Array;

   type Income_Items is (
      wages,
      luncheon_Vouchers,
      self_Employment,
      investment_Income,
      pensions,
      other_Income,
      income_Tax,
      national_insurance,
      disability_living_allowance,
      attendance_allowance,
      constantattendance_allowance,
      social_fund,
      child_benefit,
      guaranteed_pension_credit,
      savings_pension_credit,
      retirement_pension,
      widows_pensions,
      income_support,
      maternity_allowance,
      widowed_mothers_allowance,
      war_disablement_pension,
      war_widow_pension,
      severe_disability_allowance,
      disabled_persons_tax_credit,
      invalid_care_allowance,
      income_related_jobseekers_allowance,
      contributory_jobseekers_allowance,
      industrial_injury_disablementBenefit,
      incapacity_benefit,
      working_families_tax_credit,
      new_deal,
      working_tax_credit,
      child_tax_credit,
      any_other_benefit,
      widows_payment,
      unemployment_redundancy_insurance,
      winter_fuel_payments,
      trade_union,
      friendly_society_benefits,
      private_sickness_scheme,
      accident_insurance_scheme,
      hospital_savings_scheme,
      health_insurance);

   subtype Benefits is Income_Items range disability_living_allowance .. winter_fuel_payments;
   
   type Broad_Benefits is ( income_support, tax_credits, child_benefit, state_pension, illness_and_disability, contributory_unemployment, other_benefit );
  
   function Pretty_Print( b : Broad_Benefits ) return String;
   function Map_Broad_Benefit( b : Benefits ) return Broad_Benefits;
   
   subtype Calculated_Items is Income_Items range income_tax .. winter_fuel_payments;
   
   package Incomes_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Income_Items );
   subtype Incomes_Array is Incomes_Package.Amount_Array;   
   subtype Incomes_Rates is Incomes_Package.Rate_Array;
   subtype Incomes_Set is Incomes_Package.Set;
   
   function Pretty_Print( t : Income_Items ) return String;
   function Pretty_Print( e : Expense_Items ) return String;
   function Pretty_Print( f : Finance_Items ) return String;
       

   function Calc_One_Income( incomes : Incomes_Array; rates : Incomes_Rates ) return Amount renames Incomes_Package.Sum;
   function To_String( incomes : Incomes_Array; break_lines : Boolean := True ) return String renames Incomes_Package.To_String;
   function To_String( incomes : Incomes_Rates; break_lines : Boolean := True ) return String renames Incomes_Package.To_String;
   function Non_Zero_Incomes( incomes : Incomes_Array ) return Incomes_Set;
   function Contains_Incomes( incomes : Incomes_Array; which : Incomes_Set ) return Boolean;
   
   package Broad_Benefits_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Broad_Benefits ); 
   subtype Broad_Benefits_Array is Broad_Benefits_Package.Amount_Array;
   subtype Broad_Benefits_Set is Broad_Benefits_Package.Set;
   function Contains_Broad_Benefits( incomes : Incomes_Array; which : Broad_Benefits_Set ) return Boolean;
   function Benefit_In_Broad_Set( s : Broad_Benefits_Set; b : Benefits ) return Boolean;
   function Non_Zero_Broad_Benefits( incomes : Incomes_Array ) return Broad_Benefits_Set;

end Model.Incomes;
