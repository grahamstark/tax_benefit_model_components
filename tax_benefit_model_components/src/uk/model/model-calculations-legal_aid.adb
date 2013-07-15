--
--  $Author: graham_s $
--  $Date: 2010-06-11 14:34:34 +0100 (Fri, 11 Jun 2010) $
--  $Revision: 8926 $
--
pragma License( Modified_Gpl );

with Legal_Aid_Output_Types;                   use Legal_Aid_Output_Types;
with Text_IO;                                  use Text_IO;
with Model.Equivalence_Scales;
with Model.Calculations.Legal_Aid.Costs_Model;

package body Model.Calculations.Legal_Aid is

   use Model.Calculations.Legal_Aid.Costs_Model;

   -- see sec 109 of manual
   ASSUMED_INTEREST_RATE : constant Rate := 0.0125; -- CHECK Correct as of apr 03??

   --
   --  capital imputation: if any and there's a capital limit in place
   --  1.25% of the lesser of limit and capital. If a gross inpcome test, just pass in everything
   --
   function Calc_Assumed_Investment_Income_PA
    ( capital_stock              : Amount;
      reported_investment_income : Amount;
      capital_lower_limit        : Amount;
      eligible_proportion        : Rate; -- the 1.0 or whatever from the incomes lists
      is_gross_test              : Boolean )
      return                       Amount
   is
      income_from_savings : Rate          := Rate( reported_investment_income );
      free_capital        : constant Rate := Rate (Amount'Min( capital_stock, capital_lower_limit ));
   begin
      if( not is_gross_test ) then
         if( capital_lower_limit > 0.0 ) then
            income_from_savings := free_capital * ASSUMED_INTEREST_RATE;
         end if;
      end if;
      income_from_savings := income_from_savings * eligible_proportion;
      return Amount( income_from_savings );
   end Calc_Assumed_Investment_Income_PA;

   --
   --  calculates a simple measure of the "error" between 2 systems
   --  error is: high if you gain & are rich
   --           high if you lose & are poor
   --           zero if no change
   --           higher for further moves( e.g full->none > full->partial
   --  the only measure used currently is equivalent decile, since number of children etc.
   --  is subsumed in that.
   --
   function Error_Index
    ( bu   : Model_Benefit_Unit;
      res1 : One_LA_Output;
      res2 : One_LA_Output )
      return Amount
   is
      mis, dist : Amount := 0.0;
      state1    : Amount;
      state2    : Amount;
      decile    : Amount;
   begin
      mis    := 0.0;
      state1 := Amount (Legal_Aid_State'Pos( res1.la_State ));
      state2 := Amount (Legal_Aid_State'Pos( res2.la_State ));
      decile := Amount( bu.decile );
      --  put( "Error Index : state1 = " & state1'Img & " state2=" & state2'Img & " decile " & decile'Img );
      if state1 > state2 then -- gain; since pos goes FULL, PARTIAL, NONE, less is more  * )
         dist := state1 - state2; -- worse the further you move *)
         mis  := decile * dist;  --  worse the richer you are *)
      elsif state2 > state1 then
         dist := state2 - state1;
         mis  := (10.0 - decile ) * dist; -- worse the poorer you are *)
      end if;
      -- put( " returning mis = " & mis'Img );
      return mis;
   end Error_Index;

   --
   --  crude measure of how well targetted we are : higher for for full entitlement with low deciles
   --  and vice - versa
   --  returns a number from 0( bad targetting ) to 3( perfect targetting ).
   --
   function Calc_Targetting_Index( state : Legal_Aid_State; decile : Decile_Number ) return Amount is
      index : Amount;
   begin
      case state is
         when fully_entitled | passported =>
            if( decile < 3 ) then
               index := 3.0;
            elsif( decile < 5 ) then
               index := 2.0;
            elsif( decile < 7 ) then
               index := 1.0;
            else
               index := 0.0;
            end if;

         when partially_entitled =>
            if( decile < 3 ) then
               index := 2.0;
            elsif( decile < 5 ) then
               index := 3.0;
            elsif( decile < 7 ) then
               index := 1.0;
            else
               index := 0.0;
            end if;
         when disqualified =>
            if( decile < 3 ) then
               index := 0.0;
            elsif( decile < 5 ) then
               index := 1.0;
            elsif( decile < 7 ) then
               index := 2.0;
            else
               index := 3.0;
            end if;
         when na =>
            null;       -- fixme raise an error?
      end case;
      return index;
   end Calc_Targetting_Index;

   --  see http://www.dss.gov.uk/asd/hbai/incd-6.html
   --  5 bn total value of company cars and fuel
   --   see:
   --  http://www.dwp.gov.uk/asd/hbai/quality_review/Quality_Review_Final_Report.pdf
   --
   --  We know nothing of this from the FRS. Wild guess at �3,000 p.a..
   --
   function Value_Of_Company_Car( inc : Amount ) return Amount is
      v : Amount := 0.0;
   begin
      if( inc > COMP_CAR_THRESHHOLD) then
         v := 3000.0;
      end if;
      return v;
   end Value_Of_Company_Car;

   function Calc_Benefits_In_Kind( adult : Model_Adult; sys : Legal_Aid_Sys ) return Amount is
      lvs              : Amount := 0.0;
      taxFreeLVs       : Amount := 0.0;
      benefits_In_Kind : Amount := 0.0;
      taxable_income   : Amount := 0.0;
   begin
      --
      -- FIXME: this is not at all taxable income
      --
      taxable_income := Calc_One_Income( adult.incomes, TAXABLE_INCOMES_LIST);
      lvs            := 0.0;
      taxFreeLVs     := adult.incomes( luncheon_Vouchers ) - DAILY_LUNCHEON_VOUCHER_MINIMUM;
      -- put
      -- (" taxFreeLVs " &
      -- taxFreeLVs'Img &
      -- " adult.incomes(luncheon_vouchers ) = " &
      -- adult.incomes( luncheon_vouchers )'Img );
      lvs              := Amount'Max (0.0, taxFreeLVs );
      benefits_In_Kind := benefits_In_Kind + lvs;
      --  company cars
      if( adult.has_company_car ) then
         benefits_In_Kind := benefits_In_Kind + Value_Of_Company_Car( taxable_income );
      end if;
      return benefits_In_Kind;
   end Calc_Benefits_In_Kind;

   procedure Calc_Benefits_In_Kind( bu : Model_Benefit_Unit; sys : Legal_Aid_Sys; res : in out One_LA_Output ) is
   begin
      for ad in  head .. bu.last_adult loop
         
         res.benefits_In_Kind := res.benefits_In_Kind + Calc_Benefits_In_Kind( bu.adults( ad ), sys );
      end loop;
   end Calc_Benefits_In_Kind;

   procedure Make_Personal_Income( adult : Model_Adult; sys : Legal_Aid_Sys; laResults : in out One_LA_Output ) is
      netIncome : Amount := 0.0;
   begin
      log( legal_aid_calcs, "Incomes " & Model.Incomes.To_String( Adult.Incomes ) );
      log( legal_aid_calcs, "Inc List " & Model.Incomes.To_String( sys.incomesList ) );
      netIncome                   := Calc_One_Income( adult.incomes, sys.incomesList );
      log( legal_aid_calcs, "Net Income " & Amount'Image( netIncome ) );
      laResults.assessable_Income := laResults.assessable_Income + netIncome;
   end Make_Personal_Income;

   --
   --  apply maxima/flat rate amounts to a housing costs record
   --  housing_Costs = housing_Costs record from Household_Rec
   --
   function Flatten_Housing_Costs( housing_Costs : Model_Housing_Costs; sys : Legal_Aid_Sys ) return Model_Housing_Costs is
      outputCosts : Model_Housing_Costs;
   begin
      outputCosts.mortgages             := Expenses_Op( housing_Costs.mortgages, sys.housing_allowances.mortgages );
      outputCosts.gross_council_tax     := Expenses_Op( housing_Costs.gross_council_tax, sys.housing_allowances.council_tax );
      outputCosts.water_rates           := Expenses_Op( housing_Costs.water_rates, sys.housing_allowances.water_rates );
      outputCosts.ground_rent           := Expenses_Op( housing_Costs.ground_rent, sys.housing_allowances.ground_rent );
      outputCosts.service_charges       := Expenses_Op( housing_Costs.service_charges, sys.housing_allowances.service_charges );
      outputCosts.repairs_And_Insurance := Expenses_Op( housing_Costs.repairs_And_Insurance, sys.housing_allowances.repairs_and_insurance );
      outputCosts.rent                  := Expenses_Op( housing_Costs.rent, sys.housing_allowances.rent );
      --  rent share see 169/2
      outputCosts.council_tax_rebates := Expenses_Op( housing_Costs.council_tax_rebates, sys.housing_allowances.council_tax_rebates );
      outputCosts.rent_rebates        := Expenses_Op( housing_Costs.rent_rebates, sys.housing_allowances.rent_rebates );

      return outputCosts;
   end Flatten_Housing_Costs;

   --
   --  housing costs for the householder( benefit unit 1, always, in this model.
   --  Manual sec[ ]
   --
   function Householders_Housing_Costs( tenure : Tenure_Type; housing_Costs : Model_Housing_Costs ) return Amount is
      costs           : Amount := 0.0;
      net_council_tax : Amount := 0.0;
      net_rent        : Amount := 0.0;
   begin
      net_council_tax := housing_Costs.gross_council_tax - housing_Costs.council_tax_rebates;
      if( net_council_tax < 0.0 ) then
         net_council_tax := 0.0;
      end if;
      net_rent := housing_Costs.rent - housing_Costs.rent_rebates;
      if( net_rent < 0.0 ) then
         net_rent := 0.0;
      end if;
      case tenure is
         when owns_it_outright =>
            costs := net_council_tax +
                     housing_Costs.water_rates +
                     housing_Costs.ground_rent +
                     housing_Costs.service_charges +
                     housing_Costs.repairs_And_Insurance;
         when buying_with_the_help_of_a_mortgage =>
            costs := net_council_tax +
                     housing_Costs.mortgages +
                     housing_Costs.water_rates +
                     housing_Costs.ground_rent +
                     housing_Costs.service_charges +
                     housing_Costs.repairs_And_Insurance;
         when part_own_part_rent =>
            costs :=
              net_council_tax +
              net_rent +
              housing_Costs.mortgages +
              housing_Costs.water_rates +
              housing_Costs.ground_rent +
              housing_Costs.service_charges +
              housing_Costs.repairs_And_Insurance;
         when rents =>
            costs := net_council_tax + net_rent + housing_Costs.water_rates + housing_Costs.service_charges;
         when rent_free =>
            costs := net_council_tax + net_rent + housing_Costs.water_rates + housing_Costs.service_charges;
         when others =>
            costs := 0.0;
      end case;
      -- put ( "Householders_Housing_Costs: returning " & costs'Img );
      -- new_line;
      return costs;
   end Householders_Housing_Costs;

   --
   --  See manual section [].
   --  Deductions from assumed rent paid by 1st benefit unit where there
   --  is more than 1 bu
   --
   function Calc_Rent_Share_Deduction
    ( hh    : Household_Rec;
      sys   : Legal_Aid_Sys;
      cType : Claim_Type )
      return  Amount
   is
      rent_Share_Deduction : Amount := 0.0;
      ad                   : Model_Adult;
      ded                  : Amount := 0.0;
   begin
      for buno in  2 .. hh.num_benefit_units loop
         -- Put ("on bu " & buno'Img );
         for adno in  head .. hh.benefit_units( buno ).last_adult loop
            ad := hh.benefit_units( buno ).adults( adno );
            --  Put ("on ad " & adno'Img );
            if( not ((ad.is_lodger ) or
                    ( ad.employment = work_related_govt_training ) or
                    ( ad.relToHoH = spouse ) or
                    ( ad.relToHoH = cohabitee )))
            then
               ded :=( sys.share_deduction * sys.lower_limit( income, cType ));
               --  Put ("adding a deduction of " & ded'Img );
               rent_Share_Deduction := rent_Share_Deduction + ded;
            end if;
         end loop;
      end loop;
      --  put ("returning with rent share = " & rent_Share_Deduction'Img );
      -- new_line;
      return rent_Share_Deduction;
   end Calc_Rent_Share_Deduction;

   --
   --  Housing costs for all benefit units and tenure types.
   --  Sets the housing_Costs field in each benefit unit's output record.
   --  Manual sec[ ]
   procedure Calc_Housing_Costs
    ( hh    : Household_Rec;
      sys   : Legal_Aid_Sys;
      res   : in out LA_Output_Array;
      ctype : Claim_Type )
   is
      housing_Costs : Model_Housing_Costs;
   begin
      housing_Costs := Flatten_Housing_Costs( hh.housing_costs, sys );

      res ( 1 ).housing_Costs := Householders_Housing_Costs( hh.tenure, housing_Costs );
      -- put( "res(1 ).housing_Costs = " & res(1 ).housing_Costs'Img );
      if( not hasDependents( hh.benefit_units (1 ))) then --  this is the English restriction.
         res( 1 ).housing_Costs := Amount'Min( res (1 ).housing_Costs, sys.single_persons_housing_costs_max );
      end if;
      --  put( "res(1 ).housing_Costs after sys.single_persons_housing_costs_max = " & res(1 ).housing_Costs'Img );
      --  non dep deductions see 169/2
      if ((( hh.tenure = part_own_part_rent ) or( hh.tenure = rents )) and
         ( hh.num_benefit_units > 1 ) and
         ( not hh.housing_costs.costs_are_shared ))
      then
         res( 1 ).rent_Share_Deduction := Calc_Rent_Share_Deduction( hh, sys, ctype );
      end if;
      --
      --  housing costs for secondary benefit units, if they are sharing costs or boarders
      for buno in  2 .. hh.num_benefit_units loop
         for adno in  head .. hh.benefit_units( buno ).last_adult loop
            if( hh.benefit_units( buno ).adults( adno ).is_lodger or hh.housing_costs.costs_are_shared ) then
               --  note that this is net rent!!! make sure we've taken any
               --  HB away already
               res( buno ).housing_Costs := hh.benefit_units( buno ).adults( adno ).expenses( shared_rent );
            end if;
         end loop;
      end loop;
   end Calc_Housing_Costs;

   --
   --  Is an adult passported?
   --  This version just checks adult benefit receipts against the passport
   --  list. Previous versions had states checks( is pensioner, etc.).
   --  Manual sec[ ]
   function Passport_Person( ad : Model_Adult; sys : Legal_Aid_Sys ) return Boolean is
   begin
      for inc in  Benefits loop
         if( sys.passport_benefits( inc ) and ad.incomes( inc ) /= 0.0 ) then
            return True;
         end if;
      end loop;
      return False;
   end Passport_Person;

   --
   --  Does benefit unit passport, on assumption that they are not assessed
   --  individually?
   --  manual sec []
   function Passport_Benefit_Unit( benunit : Model_Benefit_Unit; sys : Legal_Aid_Sys ) return Boolean is
   begin
      for adno in  head .. benunit.last_adult loop
         if (Passport_Person( benunit.adults( adno ), sys )) then
            return True;
         end if;
      end loop;
      return False;
   end Passport_Benefit_Unit;

   --
   --   income: joint assesable income
   --   capsys: Capital_Sys class
   --   Manual sec [ ]
   function Earned_Capital_Disregard( inc : Amount; capsys : Capital_Sys ) return Amount is
   begin
      for p in  1 .. capsys.num_disregards loop
         if( inc <= capsys.income_limit( p )) then
            return capsys.disregard( p );
         end if;
      end loop;
      return 0.0;
   end Earned_Capital_Disregard;

   --
   --   allowances for partners, children
   --   benenunit : a benefit unit class
   --   allows Allowance_Sys
   --   res one result
   --   simply assume for now allowances for everyone in the benefit
   --   unit, and none for anyone else. Maybe we can improve on this
   --   FIXME: is this right for <= 17 year olds? It actually gives more Amount
   --   to 16 yos than older people.
   --   Manual sec [ ]
   --   FIXME: we might want income/capital specific versions of this
   procedure Calc_Allowances( benunit : Model_Benefit_Unit; allows : Allowance_Sys; res : in out One_LA_Output ) is
      maxAll : Integer := 0;
   begin
      res.child_Allowances := Calc_Child_Allowances( benunit, allows.child_age_limit, allows.child_allowance );
      res.allowances       := res.allowances + res.child_Allowances;
      if( benunit.last_adult = spouse ) then -- 170/1(b )
         if ((benunit.adults( head ).age > 17 ) and( benunit.adults( spouse ).age > 17 )) then
            res.partners_Allowances := allows.partners_allowance;
         else
            if( allows.num_child_age_limits > 0 ) then
               maxAll                  := allows.num_child_age_limits;
               res.partners_Allowances := allows.child_allowance( maxAll );
            end if;
         end if;
      end if;
      --
      --  FIXME: auto-equivalised personal allowance
      --
      res.allowances := res.allowances + res.partners_Allowances;
      if( allows.living_allowance > 0.0 ) then
         res.allowances := res.allowances + Amount (Rate( allows.living_allowance ) * res.equivalence_scale );
      end if;
      --   possibly a big Green Form thingy in here
   end Calc_Allowances;

   --
   --   Capital allowances for the benefit unit. Presently zero for all but pensioners;
   --   income - related for pensioners. But we can model more than this.
   --   reads disposable income from the results record and adds capital
   --   allowances to the results rec.
   --   Manual sec []
   procedure Calc_Capital_Allowances( bu : Model_Benefit_Unit; sys : Legal_Aid_Sys; res : in out One_LA_Output ) is
      penType : Pensioner_State := nonPensioner;
      alim    : Integer         := 0;
   begin
      --
      --  does anyone qualify as a pensioner?
      --
      for adno in  head .. bu.last_adult loop
         Log( legal_aid_calcs, "SEX" & bu.adults( adno ).sex'Img );
         alim := sys.pensioner_age_limit( bu.adults( adno ).sex );
         if( bu.adults( adno ).age >= alim ) then
            if( penType = nonPensioner ) then
               penType := pensioner;
            end if;
         end if;
      end loop;
      res.capital_Allowances := Earned_Capital_Disregard( res.disposable_Income, sys.capital_disregard( penType ));
   end Calc_Capital_Allowances;

   --
   --  ?? make this generic ??
   --
   function Calc_Personal_Expenses( expenses : Expenses_Array; sys : Legal_Aid_Sys ) return Amount is
      expsum : Amount := 0.0;
      val    : Amount := 0.0;
      exp    : One_Expense;
   begin
      for k in  Expense_Items loop
         exp    := sys.allowable_expenses( k );
         val    := expenses( k );
         expsum := expsum + Expenses_Op( val, exp );
      end loop;
      return expsum;
   end Calc_Personal_Expenses;

   --
   --  ?? make generic ??
   --
   function Calc_Finance_Expenses( finance : Finance_Array; sys : Legal_Aid_Sys ) return Amount is
      expsum : Amount := 0.0;
      val    : Amount := 0.0;
      exp    : One_Expense;
   begin
      for k in  Finance_Items loop
         exp    := sys.allowable_finance( k );
         val    := finance( k );
         expsum := expsum + Expenses_Op( val, exp );
      end loop;
      return expsum;
   end Calc_Finance_Expenses;

   procedure Calc_Gross_Income( bu : Model_Benefit_Unit; sys : Legal_Aid_Sys; res : in out One_LA_Output ) is
   begin
      for adno in  head .. bu.last_adult loop
         res.gross_Income := res.gross_Income + Calc_One_Income( bu.adults( adno ).incomes, sys.gross_IncomesList );
      end loop;
      res.gross_Income := res.gross_Income + res.benefits_In_Kind;

   end Calc_Gross_Income;
   --
   --  accumulate  and disposable incomes for one benefit unit
   --
   --  sys - la system
   --  bu - a benefit unit
   --  res - result for one bu
   procedure Calc_Benefit_Unit_Incomes( bu : Model_Benefit_Unit; sys : Legal_Aid_Sys; res : in out One_LA_Output ) is
   begin
      for adno in  head .. bu.last_adult loop
         res.deductions_From_Income := res.deductions_From_Income +
                                       Calc_Personal_Expenses( bu.adults( adno ).expenses, sys ) +
                                       Calc_Finance_Expenses( bu.adults( adno ).finance, sys );
         if( bu.adults( adno ).ilo_employment = student ) then
            res.deductions_From_Income := res.deductions_From_Income + Amount( sys.allowable_expenses( student_expenses ).amount );
         end if;
         --  this adds benefits in kind,  and assesable income
         Make_Personal_Income( bu.adults( adno ), sys, res );
      end loop;
      --
      --  equivalise assesable income for
      --  english style criminal test, but take off unequivalised costs. See: CMD6678 pp7-8
      --
      -- if( sys.equivalise_incomes ) then
      --        res.assessable_Income := Amount( Rate( res.assessable_Income )/res.equivalence_scale );
      -- end if;
      res.net_income        := res.assessable_Income + res.benefits_In_Kind - res.deductions_From_Income - res.housing_Costs;
      res.disposable_Income := res.assessable_Income +
                               res.benefits_In_Kind -
                               res.deductions_From_Income -
                               res.allowances -
                               res.housing_Costs;

      --  res.disposable_Income := Amount'Max(0.0, res.disposable_Income );
      --  allow disposable income to go negative, as negative disposable
      --  income is allowed against capital
      --  res.gross_Income := res.gross_Income + res.benefits_In_Kind;
      if( sys.equivalise_incomes ) then
         res.gross_Income := Amount (Rate( res.gross_Income ) / res.equivalence_scale );
      end if;

   end Calc_Benefit_Unit_Incomes;

   function Calc_Dependent_Count_Allowances( dependent_allowances : Basic_Array; numDependents : Integer ) return Amount is
      allow, total_allows : Amount            := 0.0;
      last          : constant Integer := dependent_allowances'Last;
   begin

      for i in  1 .. numDependents loop
         if( i < last ) then
            allow := dependent_allowances( i );
         else
            allow := dependent_allowances( last - 1 );
         end if;
         total_allows := total_allows + allow;
      end loop;
      return total_allows;
   end Calc_Dependent_Count_Allowances;

   --
   --   accumulate capital stock for one bu
   --   manual sec []
   --   sys - la system
   --   bu - a benefit unit
   --   res - result for one bu
   function Calc_Benefit_Unit_Capital( bu : Model_Benefit_Unit; sys : Legal_Aid_Sys ) return Amount is
      assessibleCapital : Amount := 0.0;
   begin
      --          for adno in head .. bu.last_adult loop
      --                 assessibleCapital := assessibleCapital +
      --                       bu.adults(adno ).capital_stock;
      --                  --  deductions from capital go here
      --          end loop;
      --      return assessibleCapital;
      return bu.capital_stock;
   end Calc_Benefit_Unit_Capital;

   --
   --  capital is accumulated capital stock and( for bu 1 ) any housing equity. THere is
   --  as seperate disregard for equity, and it isn't turned on in the base NI system.
   --
   procedure Calc_Benefit_Unit_Gross_Capital
    ( hh   : Household_Rec;
      buno : Integer;
      sys  : Legal_Aid_Sys;
      res  : in out One_LA_Output )
   is
      capital, equity : Amount := 0.0;
   begin

      capital := Calc_Benefit_Unit_Capital( hh.benefit_units( buno ), sys );
      if ((buno = 1 ) and( sys.housing_equity_is_capital )) then
         equity  := Amount'Max (0.0, hh.housing_costs.home_equity - sys.housing_equity_disregard );
         capital := capital + equity;
      end if;
      res.assessable_Capital    := capital + equity;
      res.capital_except_equity := capital;
   end Calc_Benefit_Unit_Gross_Capital;

   --
   --  capital is accumulated capital stock and( for bu 1 ) any housing equity. THere is
   --  as seperate disregard for equity, and it isn't turned on in the base NI system.
   --
   procedure Calc_Benefit_Unit_Net_Capital( res : in out One_LA_Output ) is

   begin

      if( res.disposable_Income < 0.0 ) then -- allow negative disposable incomes as offset against capital
         res.disposable_Capital := res.disposable_Capital + res.disposable_Income;
      end if;
      res.disposable_Capital := Amount'Max (0.0, res.assessable_Capital - res.capital_Allowances );
   end Calc_Benefit_Unit_Net_Capital;

   procedure Add_Investment_Income( bu : Model_Benefit_Unit; sys : Legal_Aid_Sys; res : in out One_LA_Output ) is
      total_investment_income : Amount := 0.0;
   begin
      total_investment_income := safe_add( bu.adults( head ).incomes( investment_Income ), bu.adults( spouse ).incomes( investment_Income ));

      res.net_income   := res.net_income +
                          Calc_Assumed_Investment_Income_PA
                            ( res.capital_except_equity,
                              total_investment_income,
                              sys.lower_limit( capital, normal_claim ),
                              sys.incomesList( investment_Income ),
                              False );
      res.gross_Income := res.gross_Income +
                          Calc_Assumed_Investment_Income_PA
                            ( res.capital_except_equity,
                              total_investment_income,
                              sys.lower_limit( capital, normal_claim ),
                              sys.gross_IncomesList( investment_Income ),
                              True );
   end Add_Investment_Income;

   --
   --
   --
   --
   function Calc_Contribution( contSys : One_Contribution; inc : Amount ) return Amount is
      use UK_Tax_Utils;

      result : Tax_Result;
   begin
      case contSys.cont_type is
         when proportion =>
            result := Calc_Tax_Due( contSys.contributions, inc );
         when fixed =>
            result := Stepped_Tax_Calculation( contSys.contributions, inc );

      end case;
      return result.due;
   end Calc_Contribution;

   function Is_Above_Gross_Income_Cap
    ( bu           : Model_Benefit_Unit;
      gross_Income : Amount;
      sys          : Legal_Aid_Sys )
      return         Boolean
   is
      gross_income_limit : Amount := sys.gross_income_limit;
   begin
      --  FIXME: above 4 kids allowances
      if( sys.gross_income_limit <= 0.0 ) then
         return False;
      end if;
      if( sys.equivalise_gross_income_limit ) then
         gross_income_limit := gross_income_limit *
                               Amount (Model.Equivalence_Scales.calc_equivalence_scale( bu, Model.Equivalence_Scales.mcclements ));
         --  text_io.put("equivalised gross income limit from " &
         --               sys.gross_income_limit'Img & " to " & gross_income_limit'Img );
      end if;
      if( gross_Income > gross_income_limit ) then
         return True;
      end if;
      return False;
   end Is_Above_Gross_Income_Cap;

   function Is_Below_Gross_Income_Cap_Minimum
    ( bu           : Model_Benefit_Unit;
      gross_Income : Amount;
      sys          : Legal_Aid_Sys )
      return         Boolean
   is
      gross_income_limit : Amount := sys.gross_income_limit;
   begin
      --  FIXME: above 4 kids allowances
      if ((sys.gross_Income_lower_limit <= 0.0 ) or( sys.gross_Income_lower_limit = Amount'Last )) then
         return False;
      end if;
      if( gross_Income <= sys.gross_Income_lower_limit ) then
         return True;
      end if;
      return False;
   end Is_Below_Gross_Income_Cap_Minimum;

   --
   --
   --
   procedure Calc_Capital_Limits
    ( bu           : Model_Benefit_Unit;
      sys          : Legal_Aid_Sys;
      ctype        : Claim_Type;
      upper, lower : in out Amount )
   is
      num_dependents : Integer;

   begin
      upper := sys.upper_limit( capital, ctype );
      lower := sys.lower_limit( capital, ctype );
      if ((sys.sys_type = green_form ) or( sys.sys_type = abwor )) then
         num_dependents := Total_Num_Dependents( bu );
         if( num_dependents > 0 ) then
            lower := lower + Calc_Dependent_Count_Allowances( sys.allow( capital ).dependent_allowances, num_dependents );

         end if;
         upper := lower; -- both thresholds are the same for gf/abwor
      end if;
   end Calc_Capital_Limits;

   --
   --  Calc Legal Aid for a single benefit unit. Housing needs to be
   --  alread calculated before calling this, as that
   --  needs to be done at the household level.
   --
   --  sys - legal aid system (Legal_Aid_Sys class )
   --  bu - model benefit unit   (Benefit Unit class )
   --  res - OneResult class. Needs to be initialised on entry
   --  Claim_Type - Civil or PersonalInjury
   --
   procedure Calc_One_BU_Legal_Aid
    ( hh    : Household_Rec;
      buno  : Integer;
      res   : in out One_LA_Output;
      sys   : Legal_Aid_Sys;
      ctype : Claim_Type )
   is

      upper_limit, lower_limit : Amount   := 0.0;
      aboveGross               : Boolean := False;
      bu                       : Model_Benefit_Unit;
      belowGrossMinimum        : Boolean := False;
   begin
      bu := hh.benefit_units( buno );
      --  res := newOutput;
      res.equivalence_scale := Model.Equivalence_Scales.Calculate_McLements_Scale( hh.benefit_units( buno ));
      if (Passport_Benefit_Unit( bu, sys )) then
         res.passport_state := passported;
      else
         res.passport_state := na;

      end if;
      --  apply means tests to non-passported cases, except
      --  in greenform, where you can be disqualified even if notionally passported.

      Calc_Benefits_In_Kind( bu, sys, res );
      Calc_Gross_Income( bu, sys, res );
      Calc_Benefit_Unit_Gross_Capital( hh, buno, sys, res );
      Add_Investment_Income( bu, sys, res );
      Calc_Allowances( bu, sys.allow( income ), res );
      Calc_Capital_Allowances( bu, sys, res );
      Calc_Benefit_Unit_Incomes( bu, sys, res );
      Calc_Benefit_Unit_Net_Capital( res );
      --
      --  FIXME this is messy and unnessesary: move these to 1 routine.
      --
      aboveGross        := Is_Above_Gross_Income_Cap( bu, res.gross_Income, sys );
      belowGrossMinimum := Is_Below_Gross_Income_Cap_Minimum( bu, res.gross_Income, sys );
      --  put( " gross_Income " & res.gross_Income'Img & " aboveGross= " & aboveGross'Img );
      res.gross_income_test_state := na;
      if( aboveGross ) then
         res.gross_income_test_state := above_maximum;
      elsif( belowGrossMinimum ) then-- above threshold
         res.gross_income_test_state := below_mininum;
      else
         res.gross_income_test_state := means_tested;
      end if;
      --  FIXME we use hh/buno here so we can pass in housing equity. Design fault
      if( res.disposable_Income > sys.upper_limit( income, ctype )) then
         res.means_test_state := disqualified;
      elsif( res.disposable_Income > sys.lower_limit( income, ctype )) then
         res.means_test_state    := partially_entitled;
         res.excess_Income       := res.disposable_Income - sys.lower_limit( income, ctype );
         res.income_Contribution := Calc_Contribution( sys.contributions( income ), res.excess_Income );
      else
         res.means_test_state := fully_entitled;
      end if;
      --
      --  Expicit calculation of limits here as green form/abwor
      --  has them dependent on number of dependents.
      --
      Calc_Capital_Limits( bu, sys, ctype, upper_limit, lower_limit );
      --  text_io.put( "res.disposable_Capital " & res.disposable_Capital'Img &
      --           " capital upper_limit " & upper_limit'Img &
      --           " lower_limit " & lower_limit'Img );
      if( res.disposable_Capital > upper_limit ) then
         res.capital_state := disqualified;

      elsif( res.disposable_Capital > lower_limit ) then

         res.capital_state        := partially_entitled;
         res.excess_Capital       := res.disposable_Capital - sys.lower_limit( capital, ctype );
         res.capital_Contribution := Calc_Contribution( sys.contributions( capital ), res.excess_Capital );
      --  text_io.put( "res.capital_Contribution " & res.capital_Contribution'Img &
      --             " res.capital_state " & res.capital_state'Img );
      else
         res.capital_state := fully_entitled;
      end if;
      --  text_io.put( " res.capital_state " & res.capital_state'Img );

      if( sys.sys_type = green_form ) then
         --  this is a hack. If passported and
         --  on green form/abwor, use that as a temporary income state
         --  and compare with capital, which can disqualify even notionally
         --  passported people. Rately, we don't need to bother with the income tests
         --  in these cases.
         if( res.capital_state = disqualified ) then
            res.la_State := disqualified;
         elsif( res.passport_state = passported ) then  -- stored passport from initial test
            res.la_State := passported;
         else
            if( res.means_test_state > res.capital_state ) then
               res.la_State := res.means_test_state;
            else
               res.la_State := res.capital_state;
            end if;
         end if;
      else
         if( res.passport_state = passported ) then
            res.la_State := passported;
         elsif( res.gross_income_test_state = below_mininum ) then
            res.la_State := fully_entitled;
         elsif( res.gross_income_test_state = above_maximum ) then
            res.la_State := disqualified;
         else
            --  position is the worse of res.capital_state
            --  and income state. States are arranged from best to worse
            --
            if( res.means_test_state >= res.capital_state ) then
               res.la_State := res.means_test_state;
            else
               res.la_State := res.capital_state;
            end if;
         end if;
      end if;
      if( res.la_State /= partially_entitled ) then
         res.capital_Contribution := 0.0;
         res.income_Contribution  := 0.0;
      end if;
      res.targetting_index := Calc_Targetting_Index( res.la_State, bu.decile );

      --  new_line;
      --  put ( "output state " & res.la_State'Img );
      --  new_line;

   end Calc_One_BU_Legal_Aid;

   --
   --
   --
   --
   function Calc_One_HH_Legal_Aid
    ( hh     : Household_Rec;
      sys    : Legal_Aid_Sys;
      cType  : Claim_Type;
      uprate : Boolean )
      return   LA_Output_Array
   is
      res : LA_Output_Array;

   begin
      Calc_Housing_Costs( hh, sys, res, ctype );
      for buNo in  1 .. hh.num_benefit_units loop
         --  text_io.put( "Calc_One_HH_Legal_Aid; sys_type = |" & sys.sys_type'Img&" | uprate = " &uprate'Img );text_io.new_line;
         calc_One_BU_Legal_Aid( hh, buNo, res( buNo ), sys, ctype );
      end loop;
      Costs_Model.Apply_Costs_Model( hh, res );
      return res;
   end Calc_One_HH_Legal_Aid;

   procedure Calculate
    ( hh           : Household_Rec;
      params       : Legal_Aid_Sys;
      results      : in out Household_Result;
      run_settings : settings.Settings_Rec )
   is
      outs : LA_Output_Array := Calc_One_HH_Legal_Aid( hh, params, normal_claim, False );
   begin
      for buNo in  1 .. hh.num_benefit_units loop
--         if( is_annual_system( params.sys_type )) then
--            outs( buNo ) := To_Weekly( outs( buNo ));
--         end if;
         results.benefit_units( buNo ).aggregate.legal_aid := outs( buNo );
      end loop;
   end Calculate;

end Model.Calculations.Legal_Aid;
