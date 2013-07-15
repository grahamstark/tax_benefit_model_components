--
--  $Author: graham_s $
--  $Date: 2011-06-08 12:45:07 +0100 (Wed, 08 Jun 2011) $
--  $Revision: 11953 $
--
--
pragma License( Modified_GPL );


with Model.Output.Means_Tested_Benefits;

package body Model.Calculations.Means_Tested_Benefits is

   use Model.Output.Means_Tested_Benefits;
   --
   -- CPAG0708 chap 33
   -- Actually, this is compelety hard-wired at present, no params needed
   --
   function Find_Entitled_Premia( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      which_benefit : Means_Tested_Benefit_Types ) return Premia_Set is
   use Premia_Package.Set_Ops;
      pv    : Amount := 0.0;
      entitled_prems :  Premia_Set;
      age_of_oldest   : constant Adult_Age := Age_Of_Oldest_Person( bu );
      age_of_youngest : constant Adult_Age := Age_Of_Youngest_Adult( bu );
   begin
      if( bu.num_children > 0 ) and not (( which_benefit = Income_Support_JSA ) or (( which_benefit = Pension_Credit ))) then
         if( bu.last_adult = Head ) then
            Include( entitled_prems, family_lone_parent );
         end if;
         if( Age_Of_Youngest_Person( bu ) < 1 ) then
            Include( entitled_prems, higher_family );
         else
            Include( entitled_prems, family );
         end if;
      end if;
      if( (bu.last_adult = Spouse) and then ( Is_Severely_Disabled( bu.adults( Head )) and Is_Severely_Disabled( bu.adults( Spouse )))) then
         Include( entitled_prems, severe_disability_couple );
      elsif( Has_Severely_Disabled_Member( bu ) ) then
         Include( entitled_prems, severe_disability_single );
      end if;
      
      if( (bu.last_adult = Spouse) and then ( Is_Disabled( bu.adults( Head )) and Is_Disabled( bu.adults( Spouse )))) then
         Include( entitled_prems, disability_couple );
      elsif( Has_Disabled_Member( bu ) ) then
         Include( entitled_prems, disability_single );
      end if;
      
      if( (bu.last_adult = Spouse) and then ( Is_Carer( bu.adults( Head )) and Is_Carer( bu.adults( Spouse )))) then
         Include( entitled_prems, carer_couple );
      elsif( Has_Disabled_Member( bu ) ) then
         Include( entitled_prems, carer_single );
      end if;
      -- FIXME: this currently ignores
      -- enhanced_disability_child
      -- enhanced_disability_single
      -- enhanced_disability_couple
      -- disabled_child
      
      --
      -- See CPAG 787: you only get these in Income Support? 
      -- 
      Log( Means_Tested, "age_of_oldest; "&Positive'Image(age_of_oldest));
      if( which_benefit = Income_Support_JSA ) then
         if bu.last_adult = Head then
            case age_of_oldest is
               when MIN_ADULT_AGE .. 59 => null;
               when 60 .. 74 =>  Include( entitled_prems, pensioner_single );
               when 75 .. 79 =>  Include( entitled_prems, enhanced_pensioner_single );
               when 80 .. MAX_ADULT_AGE => Include( entitled_prems, higher_pensioner_single );
            end case;
         else
            case age_of_oldest is
               when MIN_ADULT_AGE .. 59 => null;
               when 60 .. 74 =>  Include( entitled_prems, pensioner_couple );
               when 75 .. 79 =>  Include( entitled_prems, enhanced_pensioner_couple );
               when 80 .. MAX_ADULT_AGE => Include( entitled_prems, higher_pensioner_couple );
            end case;
         end if;
      end if;
      return entitled_prems;
   end Find_Entitled_Premia;
   
     --
     -- CPAG0708 chap 33
     --
   function Calculate_Premia_Value( values : Premia_Array;  premiums : Premia_Set ) return Amount is
   use Premia_Package.Set_Ops;   
      pv    : Amount := 0.0;
      highest_other : constant Premia := Highest_Premium( values, premiums );
   begin
      -- end if;
      for p in Include_All_Premia loop
         if( Contains( premiums, p )) then
            pv := pv + values(p);
         end if;
      end loop;
      if( highest_other >= Highest_Only_Premia'First ) then
         pv := pv + values( highest_other );
      end if;
      return pv;
   end Calculate_Premia_Value;
    
   function Find_Entitled_Personal_Allowances( 
      bu    : Model_Benefit_Unit; 
      which : Means_Tested_Benefit_Types ) return Personal_Allowances_Set is
   use Personal_Allowances_Package.Set_Ops;
      entitled_allowances : Personal_Allowances_Set;
      age_of_oldest   : constant Adult_Age := Age_Of_Oldest_Person( bu );
      age_of_youngest : constant Adult_Age := Age_Of_Youngest_Adult( bu );
   begin
      if( bu.last_adult = Spouse ) then
         case age_of_oldest is 
            when MIN_ADULT_AGE..17 => Include( entitled_allowances, couple_both_under_18 );
              
            when 18..24 =>
               if( age_of_youngest < 18 ) then
                  Include( entitled_allowances, couple_one_under_18_one_18_24 );
               else
                  Include( entitled_allowances, couple_both_18_and_over );
               end if;
            when 25..MAX_ADULT_AGE =>
               if( age_of_youngest < 18 ) then
                  Include( entitled_allowances, couple_one_under_18_one_25_and_over );
               else
                  Include( entitled_allowances, couple_both_18_and_over );
               end if;
         end case;
      else
         if( bu.num_children > 0 ) then
            case age_of_oldest is
               when MIN_ADULT_AGE..17 => Include( entitled_allowances, lone_parent_u_18 );
               when 18..24 => Include( entitled_allowances, lone_parent_18_24 );
               when 25..MAX_ADULT_AGE => Include( entitled_allowances, lone_parent_25_and_over );
            end case;
         else 
            case age_of_oldest is
               when MIN_ADULT_AGE..17 => Include( entitled_allowances, single_u_18 );
               when 18..24 => Include( entitled_allowances, single_18_24 );
               when 25..MAX_ADULT_AGE => Include( entitled_allowances, single_25_and_over );
            end case;
         end if;
      end if;
      -- override for hb / is
      if(( which = Housing_Benefit ) or ( which = Local_Tax_Benefit )) then
         if( bu.last_adult = Spouse ) then
            case age_of_oldest is
               when MIN_ADULT_AGE..59 => null;
               when 60..64 => 
                  Clear( entitled_allowances );
                  Include( entitled_allowances, couple_one_aged_60_64 );
               when 65..MAX_ADULT_AGE =>
                  Clear( entitled_allowances );
                  Include( entitled_allowances, couple_one_aged_65_or_over );
            end case;
         else
            case age_of_oldest is
               when MIN_ADULT_AGE..59 => null;
               when 60..64 => 
                  Clear( entitled_allowances );
                  Include( entitled_allowances, single_aged_60_64 );
               when 65..MAX_ADULT_AGE => 
                  Clear( entitled_allowances );
                  Include( entitled_allowances, single_aged_65_or_over );
            end case;
         end if;
      end if;
      if( bu.num_children > 0 ) then
          Include( entitled_allowances, dependent_child );
      end if;
      return entitled_allowances;
   end Find_Entitled_Personal_Allowances;
   
   function Calculate_Allowance_Value( 
      bu : Model_Benefit_Unit; 
      allowances : Personal_Allowances_Array; 
      entitled_allowances :  Personal_Allowances_Set ) return Amount is
      
   use  Personal_Allowances_Package.Set_Ops; 
      allowance : Amount :=  Personal_Allowances_Package.Sum( allowances, entitled_allowances );
   begin
      if( Contains( entitled_allowances, dependent_child ))then
         -- fix for allowing > 1 child allowance; we've already included 1 in the Sum above
         allowance := allowance + Amount( bu.num_children - 1 ) * allowances( dependent_child );
      end if;
      return allowance;
   end Calculate_Allowance_Value;
   
   function Is_Entitled_To_Pension_Credit( bu : Model_Benefit_Unit; params : Means_Tested_Benefits_Sys ) return Boolean is
      highest_age : constant Positive := Age_Of_Oldest_Person( bu );
   begin
      return ( highest_age >= 60 ); -- hours econ pos and so on parameterise!
   end Is_Entitled_To_Pension_Credit;


   procedure Calculate_Pension_Credit( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec ) is
      
   use Pension_Credit_Package.Set_Ops;   
   begin
      if Is_Entitled_To_Pension_Credit( bu, params ) then
         declare
            res : One_Pension_Credit_Result renames results.aggregate.means_tested.pension_credit;
         begin
            if( bu.last_adult = Spouse ) then
               Include( res.entitled_elements, couple );
            else
               Include( res.entitled_elements, single );
            end if;
            res.entitled_prems := Find_Entitled_Premia( bu, params, Pension_Credit );
            res.applicable_amount := 
               Pension_Credit_Package.Sum( params.pension_credit.allowances, res.entitled_elements ) +
               Calculate_Premia_Value( params.pension_credit.premiums, res.entitled_prems );
            
          end;
      end if;
   end Calculate_Pension_Credit;
   
   function Is_Entitled_To_Child_Tax_Credit( bu : Model_Benefit_Unit; params : Means_Tested_Benefits_Sys ) return Boolean is
   begin
      return ( bu.num_children > 0 );
   end Is_Entitled_To_Child_Tax_Credit;

   
   procedure Calculate_Child_Tax_Credit( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec ) is
      
   use Child_Tax_Credit_Package.Set_Ops;
      
   begin
      if( Is_Entitled_To_Child_Tax_Credit( bu, params ) ) then
         declare
            res : One_Child_Tax_Credit_Result renames results.aggregate.means_tested.child_tax_credit;
         begin
            if( Age_Of_Youngest_Person( bu ) = 0 ) then
               Include( res.entitled_elements, family_with_young_child_addition );
            else
               Include( res.entitled_elements, family );
            end if;
            -- FIXME disability severe disabily child additions
            --
            -- This is silly, but at least consistent..
            --
            res.applicable_amount := Child_Tax_Credit_Package.Sum( params.child_tax_credit.elements, res.entitled_elements )
               + (Amount( bu.num_children ) *  params.child_tax_credit.elements( child ));
            Include( res.entitled_elements, child );
         end;
      end if;
   end Calculate_Child_Tax_Credit;
   
   function Is_Entitled_To_Income_Support( bu : Model_Benefit_Unit; params : Means_Tested_Benefits_Sys ) return Boolean is
      lowest_age : constant Positive := Age_Of_Youngest_Adult( bu );
   begin
      return ( lowest_age < 60 ); -- hours econ pos and so on 
   end Is_Entitled_To_Income_Support;
   
   procedure Calculate_Income_Support( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec ) is
    begin
      if (Is_Entitled_To_Income_Support( bu, params )) then
         declare
            res : One_Means_Tested_Result renames results.aggregate.means_tested.income_support;
         begin
               res.entitled_prems := Find_Entitled_Premia( bu, params, Income_Support_JSA );
               res.entitled_allowances     := Find_Entitled_Personal_Allowances( bu, Income_Support_JSA  );
               res.applicable_amount := 
                  Calculate_Allowance_Value( bu, params.income_support.allowances, res.entitled_allowances ) +
                  Calculate_Premia_Value( params.income_support.premiums, res.entitled_prems );
         end;
      end if;
   end Calculate_Income_Support;
   
   procedure Calculate_Housing_Benefit(  
      hh : Household_Rec; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec ) is
   begin
      for buno in 1 .. hh.num_benefit_units loop
         declare
            bu  : constant Model_Benefit_Unit := hh.benefit_units(buno);
            res : One_Means_Tested_Result renames results.benefit_units(buno).aggregate.means_tested.housing_benefit;
         begin
            res.entitled_prems := 
               Find_Entitled_Premia( bu, params, housing_benefit );
            res.entitled_allowances := 
               Find_Entitled_Personal_Allowances( bu, housing_benefit );
            res.applicable_amount := 
               Calculate_Allowance_Value( bu, 
                  params.housing_benefit.allowances,
                  res.entitled_allowances ) +
               Calculate_Premia_Value( params.housing_benefit.premiums, 
                  res.entitled_prems );
         end;
      end loop;
   end Calculate_Housing_Benefit;
   
   procedure Calculate_Local_Tax_Benefit(  
      hh : Household_Rec; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec ) is
   begin
      for buno in 1 .. hh.num_benefit_units loop
         declare
            bu  : constant Model_Benefit_Unit := hh.benefit_units(buno);
            res : One_Means_Tested_Result renames results.benefit_units(buno).aggregate.means_tested.local_tax_benefit;
         begin
            res.entitled_prems := 
               Find_Entitled_Premia( bu, params, local_tax_benefit );
            res.entitled_allowances := 
               Find_Entitled_Personal_Allowances( bu, local_tax_benefit );
            res.applicable_amount := 
               Calculate_Allowance_Value( bu, 
                  params.local_tax_benefit.allowances,
                  res.entitled_allowances ) +
               Calculate_Premia_Value( params.local_tax_benefit.premiums, 
                  res.entitled_prems );
         end;
      end loop;
   end Calculate_Local_Tax_Benefit;
   
   procedure Calculate( 
      bu : Model_Benefit_Unit; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec ) is
   begin
      Calculate_Child_Tax_Credit( bu, params, results, run_settings );
      Calculate_Income_Support( bu, params, results, run_settings );
      Calculate_Pension_Credit( bu, params, results, run_settings );
   end Calculate;
   
   procedure Calculate( 
      hh : Household_Rec; 
      params : Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec ) is   
   begin
      for buno in 1 .. hh.num_benefit_units loop
         Calculate( hh.benefit_units(buno), params, results.benefit_units(buno), run_settings );
      end loop;
      Calculate_Housing_Benefit(  hh, params, results, run_settings );
      Calculate_Local_Tax_Benefit(  hh, params, results, run_settings );
   end Calculate;
        
end Model.Calculations.Means_Tested_Benefits;
