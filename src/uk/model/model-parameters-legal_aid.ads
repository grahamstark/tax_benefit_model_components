--
--  $Author: graham_s $
--  $Date: 2009-01-07 16:18:12 +0000 (Wed, 07 Jan 2009) $
--  $Revision: 6600 $
--
pragma License( Modified_GPL );

with FRS_Enums;
with Ada.Strings.Unbounded;
with Text_Utils;
with Model.Incomes;
--
--
package Model.Parameters.Legal_Aid is

   use UK_Tax_Utils; 
   use FRS_Enums;
   use Ada.Strings.Unbounded;
   use Text_Utils;
   use Model.Incomes;

   LATEST_AVAILABLE_YEAR : constant := 2005;
   --
   -- Handy constant for withdrawal rates, etc.
   --
   ONE_THIRD : constant Rate := 1.0/3.0;
   
   DAILY_LUNCHEON_VOUCHER_MINIMUM : constant Amount := Amount( 0.15 * 5.0 * 52.0 );
   
   COMP_CAR_THRESHHOLD            : constant Amount := 8500.0; --  jammed on as annual!!!!

   type System_Type is (
      civil,
      green_form,
     -- personal_injury,
      abwor,
      magistrates_court_criminal);

   type Claim_Type is (normal_claim, personal_injury_claim, na);
   type Pensioner_State is (pensioner, nonPensioner, na);
   type Income_Or_Capital is (income, capital, na);
   type Net_Or_Gross is (net, gross, na);
   type Assessment_Period is (weekly, monthly, annualHistoric, annualForward);
   type Contribution_Type is (proportion, fixed);

   type Male_Female_Array is array (Male .. Female) of Integer;

   type Capital_Sys is
      record
         -- limits        : Rates_And_Bands;
         -- FIXME: maybe change to Rates_And_Bands??
         num_disregards : Integer    := 0;
         disregard     : Basic_Array := (others => 0.0);
         income_limit   : Basic_Array := (others => 0.0);
      end record;

   type Allowance_Sys is
      record
         living_allowance           : Amount           := 0.0;
         partners_allowance         : Amount           := 0.0;
         other_dependants_allowance : Amount           := 0.0;
         num_child_age_limits       : Integer         := 0;
         child_age_limit            : Child_Age_Array := (others => 0);
         child_allowance            : Child_Amount_Array := (others => 0.0);
         dependent_allowance        : Amount           := 0.0;
         --
         --  these aren't exactly allowances
         --  but model the increase in the capital limits
         --  for gf/abwor by dependent.
         --
         num_dependent_allowances : integer := 0;
         dependent_allowances : Basic_Array := (others => 0.0);
      end record;


   type Housing_Costs_Allowances is
      record
         mortgages             : One_Expense; --
         council_tax           : One_Expense;
         water_rates           : One_Expense; --  should be nil in NI
         ground_rent           : One_Expense;
         service_charges       : One_Expense;
         repairs_and_insurance : One_Expense;
         rent                  : One_Expense; --  see 167
         --  rent share see 169/2
         rent_rebates          : One_Expense;
         council_tax_rebates   : One_Expense;
      end record;

   type One_Contribution is
      record
         --numContributions        : Integer          := 0;
         cont_type               : Contribution_Type := proportion;
         contributions           : Rates_And_Bands;
         --contribution_proportion : BasicRateArray    := (others => 0.0);
         --contribution_band       : Basic_Array       := (others => 0.0);
      end record;

   type Contribution_Array is array (Income_Or_Capital) of One_Contribution;

   type Included_Benefits is array (Benefits) of Boolean;
   type Limits_Array is array (Income_Or_Capital, Claim_Type) of Amount;
   type Allowance_Systems is array (Income_Or_Capital) of Allowance_Sys;
   type Capital_Systems is array (Pensioner_State) of Capital_Sys;
   type Allowable_Expenses_Array is array (Expense_Items) of One_Expense;
   type Allowable_Finance_Array is array (Finance_Items) of One_Expense;

   --        type TitleString is new Bounded_String(80);

   type Legal_Aid_Sys is
      record
         title                         : String80.Bounded_String := String80.To_Bounded_String ("uninitialised");
         sys_type                      : System_Type := civil;
         reform_number                 : Integer := 0;
         gross_income_limit            : Amount   := 0.0;
         gross_Income_lower_limit      : Amount   := Amount'Last;

         equivalise_gross_income_limit : Boolean := False;
         equivalise_incomes            : Boolean := False;

         doCapital : Boolean := False;
         doIncome  : Boolean := False;
         --  passportStates : ;   ## set
         passport_benefits   : Included_Benefits := (others => False);
         use_own_income_test : Amount             := 0.0;
         income_to_use       : Net_Or_Gross      := na;

         lower_limit, upper_limit : Limits_Array;

         allowable_expenses : Allowable_Expenses_Array;
         allowable_finance  : Allowable_Finance_Array;

         period : Assessment_Period;
         allow  : Allowance_Systems;

         incomesList, gross_IncomesList : Incomes_Rates;
         pensioner_age_limit            : Male_Female_Array := (male => 60, female => 60);
         capital_disregard              : Capital_Systems;
         contributions                  : Contribution_Array;
         --  misc allowances
         student_grant_disregard     : Amount := 0.0;
         mortgage_maximum            : Amount := 0.0;
         averagewater_rates          : Amount := 0.0;
         business_profits_projection : Amount := 0.0;
         pay_rise_assumption         : Amount := 0.0;
         SRP_Maximum                 : Amount := 0.0;
         rent_allowance_maximum      : Amount := 0.0;
         share_deduction             : Amount := 0.0;
         --  sysType : Legal_Aid_Sys_Type;
         do_housing_costs_limit           : Boolean := False;
         housing_CostsLimit               : Amount   := 0.0;
         housing_costs_person_max         : Amount   := 0.0;
         pension_contribution_max         : Amount   := 0.0;
         housing_allowances               : Housing_Costs_Allowances;
         single_persons_housing_costs_max : Amount   := 0.0;
         housing_equity_is_capital        : Boolean := False;
         housing_equity_disregard         : Amount   := 0.0;
      end record;

   --
   --  FIXME check this against IFS lists??
   --  This is just use to generate company car charges, which should kick in just above
   --  Comp_Car_Threshhold constant, using taxable income
   TAXABLE_INCOMES_LIST : constant Incomes_Rates := (
         wages                                => 1.0,
         luncheon_Vouchers                    => 1.0,
         self_Employment                      => 1.0,
         investment_Income                    => 1.0,
         pensions                             => 1.0,
         other_Income                         => 1.0,
         income_Tax                           => 0.0,
         national_insurance                   => 0.0,
      --  disregarded
         disability_living_allowance          => 0.0,
         attendance_allowance                 => 0.0,
         constantattendance_allowance         => 0.0,
         social_fund                          => 0.0,
      --  included (or irrelevant)
         child_benefit                        => 0.0,
         guaranteed_pension_credit            => 0.0,
         savings_pension_credit               => 0.0,
         retirement_pension                   => 1.0,
         widows_pensions                      => 1.0,
         income_support                       => 0.0,
         maternity_allowance                  => 1.0,
         widowed_mothers_allowance            => 1.0,
         war_disablement_pension              => 1.0,
         war_widow_pension                    => 1.0,
         severe_disability_allowance          => 1.0,
         disabled_persons_tax_credit          => 1.0,
         invalid_care_allowance               => 0.0,
         income_related_jobseekers_allowance  => 1.0,
         contributory_jobseekers_allowance    => 1.0,
         industrial_injury_disablementBenefit => 1.0,
         incapacity_benefit                   => 1.0,
         working_families_tax_credit          => 0.0,
         new_deal                             => 1.0,
         working_tax_credit                   => 0.0,
         child_tax_credit                     => 0.0,
         any_other_benefit                    => 0.0,
         widows_payment                       => 1.0,

         unemployment_redundancy_insurance    => 1.0,
         winter_fuel_payments                 => 0.0,
         trade_union                          => 1.0,
         friendly_society_benefits            => 1.0,
         private_sickness_scheme              => 1.0,
         accident_insurance_scheme            => 1.0,
         hospital_savings_scheme              => 1.0,
         health_insurance                     => 1.0 );

   --
   --  Retrieve a predefined system.
   --
   function Get_2006_7_System return Legal_Aid_Sys;
   function Get_2007_8_System return Legal_Aid_Sys;
   function Get_2008_9_System return Legal_Aid_Sys;
   function Get_2009_10_System return Legal_Aid_Sys;
   
   function Get_Default_System return Legal_Aid_Sys renames Get_2008_9_System;
   procedure Turn_Off_Child_Allowances( sys : in out Legal_Aid_Sys );


   function Uprate (sys : Legal_Aid_Sys; amount : Rate) return Legal_Aid_Sys;

   function is_annual_system( sys_type : System_Type )  return Boolean;

   function Get_English_System return Legal_Aid_Sys;

   function Binary_Read_Params ( filename : String ) return Legal_Aid_Sys;

   procedure Binary_Write_Params( filename : String; params : Legal_Aid_Sys );
   --
   -- See: colin's tapering note of 2003 page 2.
   --
   function Make_Proposed_Contributions( use_current_below_upper : boolean := false ) return One_Contribution;

end Model.Parameters.Legal_Aid;
