--
--  $Author: graham_s $
--  $Date: 2011-02-25 14:55:37 +0000 (Fri, 25 Feb 2011) $
--  $Revision: 11107 $
--
pragma License( Modified_GPL );

with Ada.Text_IO;
with AUnit.Assertions; 
with Base_Model_Types; 
with raw_frs;         
with FRS_Enums;       
with Conversions.FRS;       
with Model.Incomes;
with Model.Household;
with Ada.Calendar;     
with Model.Uprate;

--
--  FIXME: 1) revise capital estimates
--         2) check housing costs gross and net
--         3) takeup estimates don't Rately belong here
--         4) check incomes again against frs/hbai derived vars
--
package body Model.FRS_To_Model_Mapper is

   use AUnit.Assertions;
   
   use Model.Incomes;
   use Base_Model_Types;
   use raw_frs;
   use Ada.Calendar;
   use Conversions.FRS;
   
   use Raw_FRS;
   use FRS_Enums;
   use Ada.Text_IO;
   
   ABORT_ON_HBAI_ERROR : constant Boolean := FALSE;
   

   Oct_2003 : constant Time := Time_Of( 2003, 10, 1 );
   
   procedure Test( test: Boolean; message : String; hh : Raw_Household; mhh : modhh.Household_Rec; printed_household : in out Boolean ) is
      use modhh;
      use AUnit.Assertions;
   begin
      if( not test ) then
         Put_Line( message );
         if( not printed_household ) then
            Put_Line( To_String( hh ));
            Put_Line( To_String( mhh ));
            if( ABORT_ON_HBAI_ERROR ) then
               Assert( False, message );
            end if;
            printed_household := True;
         end if;
      end if;
   end Test;
   
   procedure Validate_Against_HBAI( hh : Raw_Household; mhh : modhh.Household_Rec ) is
      use modhh;
      num_adults : Natural := 0;
      printed_household : Boolean := False;
   begin
      if( hh.benunits(1).hbai.SERNUM = MISSING_SERNUM ) then
         put_line( "no hbai record for " & Format( mhh.sernum ) );
         return;
      end if;
      Put_line( "Validate_Against_HBAI Household " & Format( mhh.sernum ));
      
--      EGRERNHH (FRS extended - gross earnings for the household) [egrernhh] : 63.00
--      ENTERNHH (FRS extended - net earnings for the household) [enternhh] : 62.00
--      EBENINHH (FRS extended - total benefit income for the household) [ebeninhh] : 130.00
--      EPRIBNHH (FRS extended - private benefit income for the household) [epribnhh] : 0.00
--      EMISCIHH (FRS extended - total miscellaneous income for the household) [emiscihh] : 16.00
--      EGRINCHH (FRS extended - gross income for the household) [egrinchh] : 209.00
      
      for buno in 1 .. mhh.num_benefit_units loop
         declare
            num_boys, num_children : Natural := 0;
            hbai : Hbai_Rec := hh.benunits( buno ).hbai;
            mbu  : Model_Benefit_Unit := mhh.benefit_units( buno ); 
            bu_se_income : Amount := 0.0;
            oldest_age   : Natural := 0;
         begin
            Put_Line( "benefit_unit " & Format( buno ));
            if( hbai.SERNUM = MISSING_SERNUM ) then
               put_line( "no hbai record for bu " & Format( buno ));
            else
               Assert(hbai.SERNUM = mhh.SERNUM, "sernum mismatch");
               for adno in head .. mbu.last_adult loop
                  bu_se_income := bu_se_income + mbu.adults(adno).incomes( self_employment );
                  num_adults := num_adults + 1;
                  if( mbu.adults( adno ).age > oldest_age ) then
                     oldest_age := mbu.adults( adno ).age;
                  end if;
               end loop;
               for chno in 1 .. mbu.num_children loop
                     if( mbu.children( chno ).sex = Male ) then
                        num_boys := num_boys + 1;
                     end if;
                     num_children := num_children + 1;
               end loop;
               Test( oldest_age = Safe_Real_To_Int(hbai.AGEHD), 
                  "age of head differs " & 
                  Format( oldest_age ) & " hbai " & Format( hbai.AGEHD ), 
                  hh, mhh, printed_household );
               
               Test( Differs_By( bu_se_income, Safe_Assign( hbai.GINSEBU ), 4.0 ), 
                  "se income differs us " & 
                  Format( bu_se_income ) & " hbai " & Format( hbai.GINSEBU ), 
                  hh, mhh, printed_household );
               Test( num_boys = Safe_Real_To_Int(hbai.BOYS), 
                  " boys mismatch us : " & Format(num_boys) & " hbai " & Format(hbai.BOYS), hh, mhh, printed_household);
               Test( num_children = hbai.DEPCHLDB, 
                  " children mismatch us : " & Format(num_children) & " hbai " & Format(hbai.DEPCHLDB), hh, mhh, printed_household );
            end if;
         end;
      end loop;
      
      declare
         hbai : Hbai_Rec := hh.benunits( 1 ).hbai;
         mhc  : Model_Housing_Costs := mhh.housing_costs;
      begin
         Test( num_adults = hbai.ADULTH, 
            "num adults different " & 
            Format( num_adults ) & " hbai " & Format( hbai.ADULTH ), 
            hh, mhh, printed_household );
         Test( mhc.gross_council_tax = Safe_Assign( hbai.CTLIAB ), 
            "gross ct mismatch us " & 
            Format( mhc.gross_council_tax ) & " hbai " & Format( hbai.CTLIAB ), 
            hh, mhh, printed_household );
         Test( mhc.council_tax_rebates = Safe_Assign( hbai.CTREBAM1 ),
            "ct rebate mismatch us " & 
            Format( mhc.council_tax_rebates ) & " hbai " & Format( hbai.CTREBAM1 ), 
            hh, mhh, printed_household );
         Test( Differs_By( mhc.rent, Safe_Assign( hbai.HRENTHH ), 4.0),
            "gross rent mismatch us " & 
            Format( mhc.rent ) & " hbai " & Format( hbai.HRENTHH ), 
            hh, mhh, printed_household );
         if(  mhh.num_benefit_units = 1 ) then
            Test( Differs_By( mhc.rent_rebates, Safe_Assign( hbai.EHBENBU ), 4.0 ), -- FRS extended - housing benefit for benefit unit
               "rent rebates mismatch us " & 
               Format( mhc.rent_rebates ) & " hbai " & Format( hbai.EHBENBU ), 
               hh, mhh, printed_household );
         end if;
      end; 
   end Validate_Against_HBAI;

   
   --
   --  this only works for households with an outstanding mortgage.
   --
   procedure Make_Home_Equity( hh : Raw_Household; hcosts : in out modhh.Model_Housing_Costs) is
      use modhh;
      use Model.Uprate;
      price_change : Rate;
      purchase_year : Integer := hh.owner.BUYYEAR;
   begin
      if (purchase_year /= MISS)  then
         if( purchase_year < Integer(NW_House_Price_Years'First) ) then
            Put_Line( "purchase_year too low = " & purchase_year'Img );
            purchase_year := NW_House_Price_Years'First;
         end if;
         if( purchase_year > Integer(NW_House_Price_Years'Last) ) then
            Put_Line( "purchase_year too high = " & purchase_year'Img );
            purchase_year := NW_House_Price_Years'Last;
         end if;
         Price_Change := model.uprate.House_Price_Change( purchase_year, 6 );
         hcosts.house_price := Safe_Mult(Price_Change, hh.owner.PURCAMT );
         for m in  1 .. hh.numMortgages loop
            hcosts.mortgages_outstanding := Safe_Add(
               hcosts.mortgages_outstanding, 
               hh.mortgages (m).MORTLEFT );
         end loop;
         hcosts.home_equity := hcosts.house_price - hcosts.mortgages_outstanding; -- could be negative
      end if;
   end Make_Home_Equity;

   function Make_Housing_Costs (hh : Raw_Household) return modhh.Model_Housing_Costs is
      use modhh;
      mhh       : Model_Housing_Costs;
   begin

      mhh.mortgages := Safe_Assign (hh.household.MORTPAY);        --  including
      --  protection
      --  premia
      --  net_council_tax               := Safe_Add( hh.household.RTCHECK, hh.household.RTREBAMT);
      --NOT USED
      mhh.water_rates     := 0.0; --  should be nil in NI
      mhh.ground_rent     := Safe_Assign (hh.household.CHRGAMT1);
      mhh.service_charges :=
         safe_add
           (hh.household.CHRGAMT2,
            hh.household.CHRGAMT3,
            hh.household.CHRGAMT4,
            hh.household.CHRGAMT5,
            hh.household.CHRGAMT6,
            hh.household.CHRGAMT7,
            hh.household.CHRGAMT8,
            hh.household.CHRGAMT9);
      ---
      mhh.repairs_And_Insurance := Safe_Assign (hh.household.STRAMT2);
      if (hh.household.HHSTAT = 1) then
         --   (hh.renter.RENT, hh.renter.HBENAMT);  --  see 167
         mhh.costs_are_shared := False;
      else
         mhh.costs_are_shared := True;
      end if;
      --  rent share see 169/2
      --mhh.council_tax_rebates    := Safe_Assign (hh.household.RTREBAMT);
      mhh.costs_are_shared := False; --   FIXME
      Make_Home_Equity( hh, mhh);
      mhh.rent := Safe_Assign (hh.household.HHRENT);   --  net_rent +
                                                         --mhh.council_tax_rebates;
                                       
      -- mhh.council_tax_rebates := Safe_Assign (hh.household.CTREBAMT);
      -- household record is consistently different from hbai version; 
      mhh.council_tax_rebates := Safe_Assign( hh.benunits(1).hbai.CTREBAM1 );
      -- WAS:
      -- mhh.council_tax_rebates := Safe_Assign( hh.household.CTREBAMT );
      mhh.rent_rebates := Amount'Min( mhh.rent, Safe_Assign (hh.renter.HBENAMT) );
      mhh.gross_council_tax := Safe_Assign( hh.benunits(1).hbai.CTLIAB );
      -- FIXME: below differs from the HBAI version in ways that I don't understand
      -- Safe_Add( hh.household.CTREBAMT, hh.household.CTAMT);-- make_rate_rebates_f
      return mhh;
   end Make_Housing_Costs;

   function Map_FRS_Benefit (ben_no : Integer) return Benefit_Types is
      b : Benefit_Types;
   begin
      case ben_no is
      when 1 =>
         b := dla_self_care;
      when 2 =>
         b := dla_mobility;
      when 3 =>
         b := child_benefit;
      when 4 =>
         b := pension_credit;
      when 5 =>
         b := retirement_pension_opp;
      when 6 =>
         b := widows_pension_bereavement_allowance;
      when 7 =>
         b := widowed_mothers_widowed_parents_allowance;
      when 8 =>
         b := war_disablement_pension;
      when 9 =>
         b := war_widows_widowers_pension;
      when 10 =>
         b := severe_disability_allowance;
      when 11 =>
         b := disabled_persons_tax_credit;
      when 12 =>
         b := attendence_allowance;
      when 13 =>
         b := invalid_care_allowance;
      when 14 =>
         b := jobseekers_allowance;
      when 15 =>
         b := industrial_injury_disablement_benefit;
      when 17 =>
         b := incapacity_benefit;
      when 18 =>
         b := working_families_tax_credit;
      when 19 =>
         b := income_support;
      when 20 =>
         b := new_deal;
      when 21 =>
         b := maternity_allowance;
      when 22 =>
         b := maternity_grant_from_social_fund;
      when 24 =>
         b := funeral_grant_from_social_fund;
      when 25 =>
         b := community_care_grant_from_social_fund;
      when 26 =>
         b := back_to_work_bonus_received;
      when 27 =>
         b := back_to_work_bonus_accrued;
      when 30 =>
         b := any_other_ni_or_state_benefit;
      when 31 =>
         b := trade_union_sick_strike_pay;
      when 32 =>
         b := friendly_society_benefits;
      when 33 =>
         b := private_sickness_scheme_benefits;
      when 34 =>
         b := accident_insurance_scheme_benefits;
      when 35 =>
         b := hospital_savings_scheme_benefits;
      when 36 =>
         b := government_training_allowances;
      when 37 =>
         b := guardians_allowance;
      when 39 =>
         b := social_fund_loan_budgeting;
      when 40 =>
         b := social_fund_loan_crisis;
      when 41 =>
         b := working_families_tax_credit_lump_sum;
      when 42 =>
         b := future_dla_self_care;
      when 43 =>
         b := future_dla_mobility;
      when 44 =>
         b := future_attendance_allowance;
      when 50 =>
         b := disabled_persons_tax_credit_lump_sum;
      when 51 =>
         b := child_maintenance_bonus;
      when 52 =>
         b := lone_parent_benefit_run_on;
      when 60 =>
         b := widows_payment;
      when 61 =>
         b := unemployment_redundancy_insurance;
      when 62 =>
         b := winter_fuel_payments;
      when 65 =>
         b := dwp_direct_payments_isa;
      when 66 =>
         b := dwp_direct_payments_jsa;
      when 78 =>
         b := hb_only_or_separately;
      when 79 =>
         b := ctb_only_or_separately;
      when 80 =>
         b := hb_ctb_paid_together;
      when 81 =>
         b := permanent_health_insurance;
      when 82 =>
         b := any_other_sickness_insurance;
      when 83 =>
         b := critical_illness_cover;
      when 90 =>
         b := working_tax_credit;
      when 91 =>
         b := child_tax_credit;
      when 92 =>
         b := working_tax_credit_lump_sum;
      when 93 =>
         b := child_tax_credit_lump_sum;
      when MISS =>
         b := missing;
      when others =>
         b := missing;
      end case;
      return b;
   end Map_FRS_Benefit;

   function Map_Benefit_Type (btype : Benefit_Types) return Income_Items is
      item : Income_Items;
   begin
      case btype is
      when dla_self_care .. dla_mobility =>
         item := disability_living_allowance; --  DLA(self care)
      when child_benefit =>
         item := child_benefit;  --  Child Benefit
      when pension_credit =>
         item := guaranteed_pension_credit; --  Pension credit FIXME: split
      when retirement_pension_opp =>
         item := retirement_pension;   --  Retirement Pension /OPP
      when war_widows_widowers_pension =>
         item := war_widow_pension;   --  Widow's Pension/Bereavement Allowance
      when widowed_mothers_widowed_parents_allowance | widows_pension_bereavement_allowance =>
         item := widowed_mothers_allowance; --  Widowed Mothers/Widowed Parents Allowance
      when war_disablement_pension =>
         item := war_disablement_pension;  --  War Disablement Pension
      when severe_disability_allowance =>
         item := severe_disability_allowance;   --  Severe Disability Allowance
      when disabled_persons_tax_credit | disabled_persons_tax_credit_lump_sum =>
         item := disabled_persons_tax_credit;   --  Disabled Person's Tax Credit
      when attendence_allowance =>
         item := attendance_allowance;   --  Attendence Allowance
      when invalid_care_allowance =>
         item := invalid_care_allowance;   --  Invalid Care Allowance
      when jobseekers_allowance =>  -- !!! FIXME/contrib non contrib
         item := income_related_jobseekers_allowance;      -- contributory_jobseekers_allowance;
      --  inc/contJobseeker's
      --  Allowance
      when industrial_injury_disablement_benefit =>
         item := industrial_injury_disablementBenefit;     --  Industrial Injury
      --  Disablement Benefit
      when incapacity_benefit =>
         item := incapacity_benefit;   --  Incapacity Benefit
      when working_families_tax_credit | working_families_tax_credit_lump_sum =>
         item := working_families_tax_credit;       --  Working Families' Tax Credit
      --  CHECK 91!!
      when income_support => 
         item := income_support;  --  Income Support and jsa (14)
      when dwp_direct_payments_isa | dwp_direct_payments_jsa =>
         null;  --  | FIXME: these are deductions!!  
      when new_deal =>
         item := new_deal;   --  New Deal
      when maternity_allowance =>
         item := maternity_allowance;   --  Maternity Allowance
      when maternity_grant_from_social_fund      |
           funeral_grant_from_social_fund        |
           community_care_grant_from_social_fund |
           social_fund_loan_budgeting            |
           social_fund_loan_crisis               =>
         item := social_fund;   --  Maternity Grant from Social Fund
      when back_to_work_bonus_received =>
         item := any_other_benefit;   --  Back to Work Bonus (received)
      when back_to_work_bonus_accrued =>
         item := any_other_benefit;   --  Back to Work Bonus (accrued)
      when any_other_ni_or_state_benefit =>
         item := any_other_benefit;   --  Any other NI or State benefit
      when trade_union_sick_strike_pay =>
         item := trade_union;  --  Trade Union sick/strike pay
      when friendly_society_benefits =>
         item := friendly_society_benefits;   --  Friendly Society Benefits
      when private_sickness_scheme_benefits =>
         item := private_sickness_scheme;   --  Private sickness scheme benefits
      when accident_insurance_scheme_benefits =>
         item := accident_insurance_scheme;   --  Accident insurance scheme benefits
      when hospital_savings_scheme_benefits =>
         item := hospital_savings_scheme;   --  Hospital savings scheme benefits
      when government_training_allowances =>
         item := any_other_benefit;   --  Government training allowances
      when guardians_allowance =>
         item := any_other_benefit;   --  Guardians Allowance
      --  when  => item :=    --  Working Families' Tax Credit - Lump Sum
      when future_dla_self_care =>
         item := any_other_benefit;   --  Future: DLA Self Care
      when future_dla_mobility =>
         item := any_other_benefit;   --  Future: DLA Mobility
      when future_attendance_allowance =>
         item := any_other_benefit;   --  Future: Attendance Allowance
      when child_maintenance_bonus =>
         item := any_other_benefit;   --  Child Maintenance Bonus
      when lone_parent_benefit_run_on =>
         item := any_other_benefit;    --  Lone Parent Benefit run-on
      when widows_payment =>
         item := widows_payment;   --  Widow's Payment
      when unemployment_redundancy_insurance =>
         item := unemployment_redundancy_insurance;        --  Unemployment/Redundancy
      --  Insurance
      when winter_fuel_payments =>
         item := winter_fuel_payments;  --  Winter Fuel Payments
      --  when 65 => item :=    --  DWP direct payments - ISA
      --  when 66 => item :=    --  DWP direct payments - JSA
      --      when 78 =>
      --        item := council_tax_rebates;   --  HB only or separately
      --     when 79 =>
      --      item := council_tax_rebates;   --  CTB only or separately
      --   when 80 =>
      --      item := council_tax_rebates;   --  HB/CTB paid together
      when permanent_health_insurance =>
         item := health_insurance;   --  Permanent health insurance
      when any_other_sickness_insurance =>
         item := health_insurance;   --  Any other sickness insurance
      when critical_illness_cover =>
         item := health_insurance;   --  Critical Illness Cover
      when working_tax_credit_lump_sum | working_tax_credit =>
         item := working_tax_credit;  --  Working Tax Credit
      when child_tax_credit | child_tax_credit_lump_sum =>
         item := child_tax_credit;  --  Child Tax Credit
      when hb_only_or_separately .. hb_ctb_paid_together =>
         item := any_other_benefit; -- we're ignoring all housing benefit paid to individuals for
                                    --now
      when missing =>
         item := any_other_benefit;
      end case;
      return item;
   end Map_Benefit_Type;

   procedure Assign_Benefits (interview_date : Time; mad : in out modhh.Model_Adult; adult : Raw_Adult) is
      btype : Benefit_Types;
      ptype : Pension_Types;
      itype : Income_Items;
      pen_amount : Real;
      found_savings_pension_credit : boolean := false;
      found_guaranteed_pension_credit : boolean := false;
   begin
      for bno in  1 .. adult.numBenefits loop
         put_line( " num benefits = " & adult.numBenefits'Img );
         if (adult.benefits (bno).BENEFIT /= MISS) then
            Put_Line( " on benefit type  = " & adult.benefits (bno).BENEFIT'Img );
            btype := Map_FRS_Benefit (adult.benefits (bno).BENEFIT);
            Put_Line( "got benefit type of " & frs_enums.pretty_print ( btype ));
            put_line( "amount " & adult.benefits (bno).BENAMT'Img );
            case btype is
               when missing | hb_only_or_separately .. hb_ctb_paid_together =>
                  Put_Line( "skipping benefit " );
                  null; -- skip hb at individual level
               when income_support =>
                  -- pensioner Migs, recorded in 1st half of 0304 counted as pension credit
                  if (( interview_date < Oct_2003 ) and ( mad.age > 59 ) )then
                     mad.incomes (guaranteed_pension_credit) := mad.incomes (guaranteed_pension_credit) + Safe_Assign (adult.benefits (bno).BENAMT);
                  else
                     mad.incomes (income_support) := mad.incomes (income_support) + Safe_Assign (adult.benefits (bno).BENAMT);
                  end if;
               when pension_credit =>
                  found_savings_pension_credit := false;
                  found_guaranteed_pension_credit := false;
                  if( adult.numPenAmts > 0 ) then -- Try splitting into savings/gtd using the penamt record;
                                                  -- this data has some records
                                                  -- for gtd and savings credits, but not all. So, search through
                                                  -- this record and use it to allocate if present, else fall back
                                                  -- on assuming it's all gtd and use the benefits record
                     for penno in  1 .. adult.numPenAmts loop
                        ptype := convert_pension_types(adult.penamts (penno).AMTTYPE);
                        pen_amount := adult.penamts (penno).PENQ;
                        if( pen_amount /= MISS_R ) then
                           if (ptype = pension_credit_savings_element_amt) then
                              mad.incomes (savings_pension_credit) := mad.incomes (savings_pension_credit) + pen_amount;
                              mad.incomes (savings_pension_credit) := mad.incomes (savings_pension_credit) + pen_amount;
                              found_savings_pension_credit := true;
                           elsif (ptype = pension_credit_guaranteed_element_amt) then
                              mad.incomes(guaranteed_pension_credit) := mad.incomes(guaranteed_pension_credit) + pen_amount;
                              found_guaranteed_pension_credit := true;
                           end if;
                        end if;
                     end loop;
                  end if;
                  if( not ( found_savings_pension_credit or found_guaranteed_pension_credit )) then
                     --
                     --  nothing in the pension amounts records:
                     --  fall back on the
                     --
                     mad.incomes (guaranteed_pension_credit) := mad.incomes (guaranteed_pension_credit) + 
                           Safe_Assign (adult.benefits (bno).BENAMT);
                  end if;
               when jobseekers_allowance =>
                  --
                  --  undocumented, and reverse engineered from some old
                  --  code: VAR2 = 2 for means-tested jsa
                  --

                  if (adult.benefits (bno).VAR2 = 2) then
                     mad.incomes (income_related_jobseekers_allowance) := mad.incomes (income_related_jobseekers_allowance) +
                        Safe_Assign (adult.benefits (bno).BENAMT);
                  else 
                     mad.incomes (contributory_jobseekers_allowance) := mad.incomes (contributory_jobseekers_allowance) +
                        Safe_Assign (adult.benefits (bno).BENAMT);
                  end if;
               when others =>
                  itype               := Map_Benefit_Type (btype);
                  mad.incomes (itype) := mad.incomes (itype) + Safe_Assign (adult.benefits (bno).BENAMT);
                  if ( itype = social_fund ) or ( itype = winter_fuel_payments ) then
                     mad.incomes (itype) := mad.incomes (itype) / 52.0;
                     --  FIXME check against old IFS code!!!
                  end if;
                  Put_Line( "set income " & itype'Img & " to " & mad.incomes (itype)'Img );
            end case;
         end if;
      end loop;

   end Assign_Benefits;

   function Make_Finance( adult : Raw_Adult ) return Finance_Array is
      fin : Finance_Array := (others => 0.0);
   begin
      fin (loan_repayments) :=
         safe_add
           (Rate (adult.adult.ED1AMT),
            Rate (adult.adult.ED2AMT),
            Rate (adult.adult.SLREPAMT));
      return fin;
   end Make_Finance;

   function Make_Expenses( adult : Raw_Adult) return Expenses_Array is
      exp : Expenses_Array := (others => 0.0);
   begin
      for jno in  1 .. adult.numJobs loop
         exp (pension) := Safe_Add( exp (pension), adult.jobs (jno).UDEDUC1);
         --  Amount deducted: pension
         exp (avcs) := Safe_Add( exp (avcs), adult.jobs (jno).UDEDUC2);
         --  Amount deducted: AVCs
         exp (union_fees) := Safe_Add( exp (union_fees), adult.jobs (jno).UDEDUC3);
         --  Amount deducted: Union fees
         exp (friendly_societies) :=
            Safe_Add( exp (friendly_societies), adult.jobs (jno).UDEDUC4);
         --  Amount deducted: friendly socs
         exp (sports) := Safe_Add( exp (sports), adult.jobs (jno).UDEDUC5);
         --  Amount deducted: sports/social
         exp (loan_repayments) := Safe_Add( exp (loan_repayments), adult.jobs (jno).UDEDUC6);
         --  Amount deducted: loan repayment
         exp (charities) := Safe_Add( exp (charities), adult.jobs (jno).UDEDUC8);
         --  Amount deducted: Charities

         --  Amount deducted: Medical Ins
         exp (medical_insurance) := Safe_Add( exp (medical_insurance), adult.jobs (jno).UDEDUC7);

      end loop;
      exp (travel_expenses) := Safe_Assign (adult.adult.TTWCOSTS);
      for mno in  1 .. adult.numMaintenances loop
         exp (maintenance_payments) :=
            Safe_Add( exp (maintenance_payments), adult.maintenances (mno).MRAMT);
      end loop;
      return exp;

   end Make_Expenses;

   type JobNetRec is
      record
         isSE  : Boolean := False;
         gross : Amount   := 0.0;
         it    : Amount   := 0.0;
         ni    : Amount   := 0.0;
      end record;

   function Make_One_Earnings( adult : Adult_Rec; job : Job_Rec ) return JobNetRec is
      inc    : JobNetRec;
      refund : Amount;
   begin
      if (job.ETYPE = 1) then --  note frs coding of incseo2 checks working and jobaway here to
                              --  ensure they get current earnings, which is NOT what we want here.
                              --We want usual.
         inc.isSE := False;
         if (zero_or_missing (job.UGRSPAY)) then     -- this is the derived usual gross wage var,
                                                     -- with bonuses, etc. added back in
            inc.gross := Safe_Assign (job.GRWAGE); -- take the wage, if present
         else
            inc.gross := Safe_Assign (job.UGRSPAY);
         end if;
         inc.ni := Safe_Assign (job.NATINS);
         inc.it := Safe_Add( job.PAYE, job.TAXDAMT);
         refund := Safe_Assign (job.TAXAMT);
         inc.it := Amount'Max (0.0, inc.it - refund); --
         Assert
           (zero_or_missing (job.SETAXAMT),
            "job.SETAXAMT " & job.SETAXAMT'Img & " sernum " & job.SERNUM'Img);
         Assert
           (zero_or_missing (job.PROFIT1),
            "job.PROFIT1 " & job.PROFIT1'Img & " sernum " & job.SERNUM'Img);
         Assert
           (zero_or_missing (job.SENILAMT),
            "job.SENILAMT" & job.SENILAMT'Img & " sernum " & job.SERNUM'Img);
         Assert
           (zero_or_missing (job.SENIRAMT),
            "job.SENIRAMT" & job.SENIRAMT'Img & " sernum " & job.SERNUM'Img );
      else
         -- see http://www.data-archive.ac.uk/doc/5291%5Cmrdoc%5Cpdf%5C5291userguide14.pdf
         --
         -- Note, there is no national insurance here; instead tax and ni are loaded
         -- on to the income tax slot
         -- 
         inc.isSE  := True;
         inc.gross := Safe_Assign (adult.INCSEO2);

         inc.it := Safe_Assign (adult.INCSEO2) - Safe_Assign (adult.NINCSEO2);
         Put
           ("gross se ( (adult.INCSEO2) " &
            adult.INCSEO2'Img &
            " net " &
            adult.NINCSEO2'Img &
            " ");
         New_Line;
         -- This was for the  Irish model. Scottish one just uses 
         --  ripped off with some minor changes from the frs derivation routine for
         --  incseo2.
         --  GKS The Irish Model had a Gross > Net Assertion here, but this fails in the UK Dataset
         --(rebates?)
         --  see hhld  1305803061   in 0304 database (adult record ).
         --  Assert
         --   (Safe_Assign (adult.INCSEO2) >= Safe_Assign (adult.NINCSEO2),
         --   "gross se income was lt net ");
         -- inc.it := safe_add( job.SETAXAMT , job.TAXDAMT );  -- not sure at all why we need
         --taxdamt here, but see e.g. 5000303061 p 1 job 2
         --                          if ( job.PROFIT1 /= MISS_R ) then                  -- note
         --that the frs coding of incseo2 checks on JOBBUS =1,2 which seems redundant to me if what
         --we want is usual earnings for se, not current.
         --                                  inc.gross := Safe_Assign( job.PROFIT1 ); --  gross
         --profit, if present
         --                                  if ( job.PROFIT2 = 2 ) then  --  profit is a loss,
         --Rately?
         --                                          inc.gross := -1.0*inc.gross;
         --                                  end if;
         --                          elsif ( job.SEINCAMT /= MISS_R ) then
         --                                  inc.gross := Safe_Assign( job.SEINCAMT );  --  "What
         --is your income from this business?"
         --                                  --  add back tax, as needed
         --                                  inc.it := Safe_Assign( job.TAXDAMT );
         --                                  if( job.CHECKTAX = 1 ) and ( job.CHKINCOM = 2 ) then
         --                                          inc.gross := inc.gross + inc.it;
         --                                  end if; -- add back income tax
         --                                  inc.ni := Safe_Assign( job.NIDAMT );
         --                                  if( job.CHECKTAX = 2 ) and ( job.CHKINCOM = 2 ) then
         --                                          inc.gross := inc.gross + inc.ni;
         --                                  end if;
         --                          end if;
         --                          -- FIXME: we need to uprate from account date, not interview
         --date, Rately.
         --                          if( job.OWNSUM = 1 ) then -- drawings from business
         --                                  --  FIXME: we need to check if this is in place of
         --                                  --  SEINCOME above, or as well as it.
         --                                  inc.gross := inc.gross + safe_add( job.OWNAMT,
         --job.OWNOTAMT );
         --                                  if( job.SENIREG = 1 ) then
         --                                          inc.ni := inc.ni + Safe_Assign(job.SENIRAMT
         --);
         --                                          inc.gross := inc.gross +
         --Safe_Assign(job.SENIRAMT );
         --                                  end if;
         --                                  if( job.SETAX = 1 ) then
         --                                          inc.it := inc.it + Safe_Assign(job.SETAXAMT
         --);
         --                                          inc.gross := inc.gross +
         --Safe_Assign(job.SETAXAMT );
         --                                  end if;
         --                                  if( job.SENILUMP = 1 ) then
         --                                          inc.ni := inc.ni + Safe_Assign(job.SENILAMT
         --);
         --                                          inc.gross := inc.gross +
         --Safe_Assign(job.SENILAMT );
         --                                  end if;
         --                          end if;
         --                          --  FIXME: I think we are losing various bits of SE NI here.
         --                          assert ( zero_Or_Missing ( job.UGROSS ), "job.UGROSS"
         --                                  & job.UGROSS'Img & " sernum " & string ( job.sernum ));
         --                          assert ( zero_Or_Missing ( job.NATINS ), "job.NATINS" &
         --job.NATINS'Img
         --                                  & " sernum " & string ( job.sernum ));
         --                          --   assert ( zero_Or_Missing ( job.TAXDAMT ), "job.TAXDAMT" &
         --job.TAXDAMT'Img
         --                          --        & " sernum " & string ( job.sernum ) & " etype = " &
         --job.ETYPE'Img  );
         --                  end if;
      end if;
      return inc;
   end Make_One_Earnings;

   function Make_One_Pension( pens : Pension_Rec ) return JobNetRec is
      outpens : JobNetRec;
   begin
      outpens.gross := Safe_Assign (pens.PENPAY);
      outpens.it    := Safe_Assign (pens.PTAMT);
      if (pens.PTINC = 2) then -- pension amount is net of tax
         outpens.gross := outpens.gross + outpens.it;
      end if;
      return outpens;
   end Make_One_Pension;

   function Make_Incomes( adult : Raw_Adult; dyear : Data_Years ) return Incomes_Array is
      inc          : Incomes_Array := (others => 0.0);
      earnRec      : JobNetRec;
      penRec       : JobNetRec;
   begin
      for jno in  1 .. adult.numJobs loop
         earnRec := Make_One_Earnings (adult.adult, adult.jobs (jno));
         if (earnRec.isSE) then
            inc (self_Employment) := inc (self_Employment) + earnRec.gross;
         else
            inc (wages) := inc (wages) + earnRec.gross;
         end if;
         inc (income_Tax)         := inc (income_Tax) + earnRec.it;
         inc (national_insurance) := inc (national_insurance) + earnRec.ni;
      end loop;
      --   inc(wages) := Safe_Assign(adult.adult.INEARNS);
      --   inc(self_employment) := Safe_Assign(adult.adult.INCSEO2 );
      inc (investment_Income) := Safe_Assign (adult.adult.ININV);
      for pno in  1 .. adult.numpensions loop
         penRec           := Make_One_Pension (adult.pensions (pno));
         inc (pensions)   := inc (pensions) + penRec.gross;
         inc (income_Tax) := inc (income_Tax) + penRec.it;
      end loop;
      -- maintenance
      inc (other_Income) := Safe_Add( adult.adult.MNTAMT1, adult.adult.MNTAMT2);
      Put
        ("PENINC = " &
         adult.adult.INPENINC'Img &
         " " &
         "inc( pensions ) = " &
         inc (pensions)'Img);
      return inc;
   end Make_Incomes;
   
   function Age_From_HDAGE( HDAGE : Integer ) return modhh.Adult_Age is
   begin
      case HDAGE is
         when 1 => return 16; --Age 16 to 24
         when 2 => return 25; --Age 25 to 34
         when 3 => return 35; -- 35 to 44
         when 4 => return 45; -- Age 45 to 54
         when 5 => return 55; --Age 55 to 64
         when 6 => return 65; --Age 65 and over
         when others =>
               return -1; -- raise an exception            
         end case;
   end Age_From_HDAGE;

   function Make_Adult(
                         interview_date : Time;
                         adult          : Raw_Adult;
                         dyear          : Data_Years) return modhh.Model_Adult is
      use modhh;
      mad : Model_Adult;
   begin
      put_line( "adult.adult.AGE " & adult.adult.AGE'Img );
      if( dyear = 2005 ) then
         mad.age := Age_From_HDAGE( adult.adult.HDAGE );
      else
         mad.age := adult.adult.AGE;
      end if;
      mad.sex := FRS_Enums.convert_gender( adult.adult.SEX );
      mad.ethnic_group := FRS_Enums.Convert_Ethnic_Group( adult.adult.ETHGRP );
      mad.marital_status := FRS_Enums.convert_marital_status(adult.adult.DVMARDF);
      Put ("R01 = " & adult.adult.R01'Img);
      if (not (adult.adult.R01 = MISS)) then --  missing if you *are HoH"
         mad.relToHoH := FRS_Enums.convert_Relationship_To_Head_Of_Household(adult.adult.R01);
      end if;
      if (adult.adult.EMPSTATB /= MISS) then
         mad.employment := FRS_Enums.convert_Employment_Status(adult.adult.EMPSTATB);
      end if;
      if (adult.adult.EMPSTATI /= MISS) then
         mad.ilo_employment := FRS_Enums.convert_ILO_Employment_Status(adult.adult.EMPSTATI);
      end if;

      for jno in  1 .. adult.numJobs loop
         if (adult.jobs (jno).INKIND10 = 1) then
            mad.has_company_car := True;
         end if;
      end loop;
      mad.incomes   := Make_Incomes (adult, dyear);
      Assign_Benefits (interview_date, mad, adult);
      mad.expenses  := Make_Expenses( adult);
      mad.finance   := Make_Finance (adult);
      mad.is_lodger := adult.adult.CONVBL = 1;
      return mad;
   end Make_Adult;

   function mapCapital (TOTSAV : Integer) return Amount is
   begin
      case TOTSAV is
      when 1 =>
         return 500.0; --  Less than 1, 500
      when 2 =>
         return 2_250.0; --  From 1,500 up to 3,000
      when 3 =>
         return 5_500.0;  --  From 3,000 up to 8,000
      when 4 =>
         return 14_000.0;  -- 4 From 8,000 up to 20,000
      when 5 =>
         return 22_500.0; --  5	From 20,000 up to 25,000
      when 6 =>
         return 27_500.0; --  6	From 25,000 up to 30,000
      when 7 =>
         return 32_500.0; --- From 30,000 up to 35,000
      when 8 =>
         return 37_500.0; --  8	From 35,000 up to 40,000
      when 9 =>
         return 50_000.0; --           9	Over 40, 000
      when others =>
         return 0.0;       --  10	Does not wish to say : fixme: we could infer from
                           --other sources;
      end case;
   end mapCapital;

   function Make_Is_School_Holidays (hh : modhh.Household_Rec) return Boolean is
      thisMonth  : constant Integer := Month (hh.interview_date);
      is_holiday : Boolean          := False;
   begin
      --  NI is 1st July - 1st September (week 26 to week 35)
      -- assume june-july for Scotland july-aug for everywhere else
      if (hh.standard_region = scotland) then
         is_holiday := (thisMonth >= 6) and (thisMonth <= 7);
      else
         is_holiday := (thisMonth >= 7) and (thisMonth <= 8);
      end if;
      return is_holiday;
   end Make_Is_School_Holidays;

   function Make_In_Formal_Child_Care (rawChild : Child_Rec) return Boolean is
   begin
      --  CHLOOK01	ADT_107X	Childcare from: close relative
      --  CHLOOK02	ADT_107X	Childcare from: other relative
      --  CHLOOK03	ADT_107X	Childcare from: friend/neighbour
      --  ADT_107X	Childcare from: childminder
      --  CHLOOK05	ADT_107X	Childcare from: nursery/school/playgroup
      --  CHLOOK06	ADT_107X	Childcare from: creche
      --  CHLOOK07	ADT_107X	Childcare from: employer provide nursery
      --  CHLOOK08	ADT_107X	Childcare from: nanny/au pair
      --  CHLOOK09	ADT_107X	Childcare from: before/after school or holiday play scheme
      --  CHLOOK10	ADT_107X	Childcare from: other
      return (rawChild.CHLOOK04 = 1) or
             (rawChild.CHLOOK05 = 1) or
             (rawChild.CHLOOK06 = 1) or
             (rawChild.CHLOOK07 = 1) or
             (rawChild.CHLOOK08 = 1) or
             (rawChild.CHLOOK08 = 1) or
             (rawChild.CHLOOK09 = 1);
   end Make_In_Formal_Child_Care;

   function Child_Care_Paid_In_Kind( rawChild : Child_Rec ) return Boolean is
   begin
      --  CHPAY1	ADN_10X	Whether payment in kind for childcare
      --  CHPAY2	ADN_10X	Whether childcare on an exchange basis
      --  CHPAY3	ADN_10X	Whether Payment made by "Other"
      return ((rawChild.CHPAY1 = 1) or (rawChild.CHPAY2 = 1) or (rawChild.CHPAY3 = 1));
   end Child_Care_Paid_In_Kind;

   function Make_Child_Care_Costs
     (mu                 : modhh.Model_Benefit_Unit;
      bu                 : Raw_Benefit_unit;
      is_school_holidays : Boolean)
      return               Amount
   is
      costs            : Amount         := 0.0;
      TERM_TIME_WEIGHT : constant Rate := (38.0 / 52.0);
      HOLIDAY_WEIGHT   : constant Rate := 1.0 - TERM_TIME_WEIGHT;
   begin
      --  CHAMT1		Costs of childcare during term time
      --  CHAMT2		Costs of childcare during holidays
      for chno in  1 .. bu.num_children loop
         --                	if( mu.children( chno ).in_formal_child_care )then
         if (not Child_Care_Paid_In_Kind (bu.children (chno).child)) then
            costs := costs + Safe_Mult( TERM_TIME_WEIGHT, bu.children (chno).child.CHAMT1 );
            costs := costs + Safe_Mult( HOLIDAY_WEIGHT, bu.children (chno).child.CHAMT2 );

            --                        	if( is_school_holidays ) then--
            --	                        	costs := safe_add( costs, bu.children (chno).Child.CHAMT2 );
            --                                else
            --	                        	costs := safe_add( costs, bu.children (chno).Child.CHAMT1 );
            --                                end if;
         end if;
      end loop;
      return costs;
   end Make_Child_Care_Costs;
   --
   -- 0304 version
   --

   function Make_Child(ch : Raw_Child) return modhh.Model_Child is
      use modhh;
      mch : Model_Child;
   begin
      mch.age                  := ch.child.AGE;
      mch.sex                  := FRS_Enums.convert_gender( ch.child.SEX );
      mch.in_formal_child_care := make_In_Formal_Child_Care( ch.child );
      -- Apparrently, not recorded ch.ethnic_group := FRS_Enums.Convert_Ethnic_Group( ch.child.ETHGRP );
      return mch;
   end Make_Child;

   function Someone_Employed (mu : modhh.Model_Benefit_Unit) return Boolean is
      use modhh;
   begin
      for hdsp in  head .. mu.last_adult loop
         case mu.adults (hdsp).employment is
            when full_time_employee           |
                 part_time_employee           |
                 ft_employee_temporarily_sick |
                 pt_employee_temporarily_sick |
                 industrial_action            |
                 work_related_govt_training   =>
               return True;
            when others =>
               null;
         end case;
      end loop;
      return False;
   end Someone_Employed;

   procedure Allocate_Child_Care_Costs
     (mu                 : in out modhh.Model_Benefit_Unit;
      bu                 : Raw_Benefit_unit;
      is_school_holidays : Boolean)
   is
   
      use modhh;
   
      costs               : Amount          := 0.0;
      child_care_provider : Head_Or_Spouse := head;
   begin
      if (Someone_Employed (mu)) then
         costs := make_Child_Care_Costs (mu, bu, is_school_holidays);
      end if;
      if ((mu.last_adult = spouse) and
          ((mu.adults (spouse).employment = self_employed) or
           (mu.adults (spouse).employment = full_time_employee)))
      then
         child_care_provider := spouse;
      end if;
      mu.adults (child_care_provider).expenses (childminding) := costs;
   end Allocate_Child_Care_Costs;

   --        	mu : in out Model_Benefit_Unit;

   function Make_Benefit_Unit ( interview_date : Time; bu : Raw_Benefit_unit; dyear : Data_Years) return modhh.Model_Benefit_Unit is
      use modhh;
      mb   : Model_Benefit_Unit;
      hdsp : Head_Or_Spouse := head;
   begin
      for adno in  1 .. bu.numAdults loop
         mb.adults (hdsp) := Make_Adult (interview_date, bu.adults (adno), dyear);
         if (adno = 1) then
            hdsp := spouse;
         end if;
      end loop;
      if (bu.numAdults = 1) then
         mb.last_adult := head;
      else
         mb.last_adult := spouse;
      end if;
      --
      -- FIXME: fix for missing ages in 05
      --
      if(( dyear = 2005 ) and ( bu.hbai.SERNUM /= MISSING_SERNUM )) then
         mb.adults( head ).age := Safe_Real_To_Int( bu.hbai.AGEHD );
         if( mb.last_adult = spouse ) then
            mb.adults( spouse ).age := Safe_Real_To_Int( bu.hbai.AGESP );
         end if;
      end if;
      mb.age_range_of_head := FRS_Enums.convert_age_group ( bu.benunit.BUAGEGR2 );
      mb.ethnic_group := FRS_Enums.Convert_Aggregated_Ethnic_Group( bu.benunit.BUETHGRP );
      mb.disablement_status := FRS_Enums.convert_BU_Disabled_Indicator ( bu.benunit.DISINDHB );


      mb.num_children      := bu.num_children;
      for chno in  1 .. bu.num_children loop
         mb.children (Integer (chno))  := Make_Child (bu.children (chno));
      end loop;
      --  allocate to head; doesn't matter Rately.
      --  mb.adults (head).capital_stock := mapCapital (bu.benunit.TOTSAV);
      mb.capital_stock := Safe_Assign( bu.benunit.totcapbu );
      if (bu.benunit.FAMTHBAI /= MISS) then
         mb.bu_type := FRS_Enums.convert_hbai_benefit_unit_type(bu.benunit.FAMTHBAI);
      end if;
      if (bu.benunit.ECSTATBU /= MISS) then
         mb.economic_status := FRS_Enums.convert_benefit_unit_economic_status(bu.benunit.ECSTATBU);
      end if;
      if (bu.benunit.DEPDEDS /= MISS) then
         mb.non_dependency_type := FRS_Enums.convert_non_dependency_class(bu.benunit.DEPDEDS);
      end if;
      return mb;
   end Make_Benefit_Unit;

   --
   --  responsibility for housing costs.
   --
   --  FIXME we need to infer this from HHLDR01 .. 09 and HHSTAT=1|2
   --  but eyballing the data shows it's practically all be 1
   --
   procedure Allocate_Housing_Costs_Responsibility
     (hh    : Raw_Household;
      mhh   : in out modhh.Household_Rec;
      year  : Data_Years)
   is
      use modhh;
   begin
      for adno in head .. mhh.benefit_units (1).last_adult loop
         mhh.benefit_units (1).adults (head).responsible_for_housing_costs := True;
      end loop;
   end Allocate_Housing_Costs_Responsibility;

   function Map( hh : Raw_Household; year : Data_Years ) return modhh.Household_Rec is
      mhh                : modhh.Household_Rec;
      is_school_holidays : Boolean  := False;
   begin
      mhh.sernum := hh.household.SERNUM;
      if (year = 2004) then
         mhh.grossing_factor := hh.household.GROSS3;
      else
         mhh.grossing_factor := hh.household.GROSS3;
      end if;

      --  mhh.acorn :=  Acorn_Number( hh.household.ACORN );
      --  date is mmddyyyy as longint
      New_Line;
      Put_Line("====  processing mhh.sernum = " & mhh.sernum'Img & " hh.household.INTDATE = " & Format( hh.household.INTDATE )); 
      mhh.interview_date    := hh.household.INTDATE;
      is_school_holidays    := Make_Is_School_Holidays (mhh);
      mhh.housing_costs     := Make_Housing_Costs (hh);
      mhh.num_benefit_units := hh.num_benefit_units;

      Put_Line("  hh.household.TENURE " & hh.household.TENURE'Img);
      
      mhh.tenure := FRS_Enums.convert_tenure_type(hh.household.TENURE);
      mhh.acorn := FRS_Enums.convert_acorn(hh.household.ACORN);
      mhh.composition := FRS_Enums.convert_household_composition(hh.household.HHCOMPS);
      mhh.income_band := FRS_Enums.convert_Household_Income_Band(hh.household.HHINCBND);
      mhh.standard_region := FRS_Enums.convert_standard_region( hh.household.GVTREGN );
      mhh.old_region := FRS_Enums.convert_old_region(hh.household.GOR);
      mhh.regional_stratifier := convert_regional_stratifier(hh.household.SSTRTREG);
      for buno in  1 .. hh.num_benefit_units loop
         mhh.benefit_units (Integer (buno))  := Make_Benefit_Unit ( mhh.interview_date, hh.benunits (buno), year);
         allocate_Child_Care_Costs
           (mhh.benefit_units (buno),
            hh.benunits (buno),
            is_school_holidays);
      end loop;
      allocate_Housing_Costs_Responsibility (hh, mhh, year);
      return mhh;
   end Map;

end Model.FRS_To_Model_Mapper;
