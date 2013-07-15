--
--  $Author: graham_s $
--  $Date: 2009-07-19 22:29:02 +0100 (Sun, 19 Jul 2009) $
--  $Revision: 7707 $
--
--
-- 

with Model.Output.Means_Tested_Benefits;
with Model.Output.Non_Means_Tested_Benefits;
with Model.Output.Legal_Aid;

with Ada.Text_IO;

package body Model.Income_Measures is

   use Model.Parameters.Complete;
   use Model.Output.Complete;
   use Model.Output.Means_Tested_Benefits;
   use Model.Output.Legal_Aid;
   use Model.Output.Non_Means_Tested_Benefits;
   use Model.Incomes;
   
   use Ada.Text_IO; -- FIXME kill
         
   function Make_IS_Set return Incomes_Set is
   use Incomes_Package.Set_Ops;
      s : Incomes_Set;
   begin
      Include( s, income_support );
      Include( s, guaranteed_pension_credit );
      Include( s, income_related_jobseekers_allowance );
      return s;
   end Make_IS_Set;
   
   INCOME_SUPPORT_AND_FRIENDS : constant Incomes_Set := Make_IS_Set;
   use Incomes_Package.Set_Ops;
   
      
   function Is_On_Income_Support( bu : Model_Benefit_Unit ) return Boolean is
   begin
      for hdsp in head .. bu.last_adult loop
         if( Contains_Incomes( bu.adults( hdsp ).incomes, INCOME_SUPPORT_AND_FRIENDS )) then
            return true;
         end if;
      end loop;
      return false;
   end Is_On_Income_Support;

   procedure Add_Observation( outp : One_Complete_Income_Measure_Output; obs : in out Income_Measure_List.Vector ) is
   begin
      Income_Measure_List.append( obs, outp ); 
   end Add_Observation;
   
   which_income_to_compare_by : Income_Measure_Type := Gross;
   
   function Compare_Incomes( q_1, q_2 : One_Complete_Income_Measure_Output ) return boolean is
   begin
      return (q_1.incomes( which_income_to_compare_by ) < q_2.incomes( which_income_to_compare_by ));
   end Compare_Incomes;

   
   package Incomes_Sorter is new Income_Measure_List.Generic_Sorting( "<" => Compare_Incomes );
   
   
 
    
   function Calculate_Affordabilities( incs : Income_Measure_Array; poverty_line : Amount; cost : Amount ) return Affordability_Measure_Array is
   measures : Affordability_Measure_Array := ( others=> 999999.99 );   
   begin
      if( incs( gross ) /= 0.0 ) then
         measures( cost_gross_ratio ) :=  100.0 * cost / incs( gross );
      end if;
      measures( residual_income_level ) := incs( net ) - poverty_line - cost;
      if( incs( disposable ) /= 0.0 ) then
         measures( cost_disposable_ratio ) := 100.0 * cost / incs( disposable );
      end if;
      log( income_calcs, "incs( Gross ) " & format_with_commas(incs( gross )) & " incs( net ) " & format_with_commas(incs( net )) & 
         "poverty line " & format_with_commas( poverty_line ) & " disposable " & format_with_commas(measures( cost_disposable_ratio )));
      return measures;
   end Calculate_Affordabilities;
   
   procedure Calculate_Income_Measures(
      hh              : Household_Rec; 
      results         : Household_Result; 
      income_measures : in out Household_Incomes_Result;
      run_settings    : settings.Settings_Rec;
      grossing_factor : Amount) is   
      
   begin
      for buno in 1 .. hh.num_benefit_units loop
         declare 
            mt   : constant One_Complete_Means_Tested_Output := results.benefit_units( buno ).aggregate.means_tested;
            nmt  : constant One_Complete_Non_Means_Tested_Output := results.benefit_units( buno ).aggregate.non_means_tested;
            leg  : constant One_LA_Output  := results.benefit_units( buno ).aggregate.legal_aid;
            incs : One_Complete_Income_Measure_Output renames income_measures.benefit_units( buno );
            bu   : constant Model_Benefit_Unit := hh.benefit_units( buno );
         begin
            incs.poverty_line := 
               mt.child_tax_credit.applicable_amount + 
               Amount'Max( mt.income_support.applicable_amount, mt.pension_credit.applicable_amount ) + 
               nmt.child_benefit;
            incs.poverty_line := Amount( run_settings.inc_ctl.poverty_multiplier * Rate( incs.poverty_line ));
            log( income_calcs, "leg.disposable_income " & Amount'Image(leg.disposable_income) );
            incs.incomes( disposable ) :=  Amount'Max( 0.0, leg.disposable_income );
            incs.incomes( Net )      :=  Amount'Max( 0.0, leg.assessable_Income );
            
            incs.incomes( Gross )    :=  Amount'Max( 0.0, leg.gross_income );
            if( Is_On_Income_Support( bu ) ) then
               incs.incomes( Gross ) := incs.poverty_line;
               incs.incomes( Net ) := incs.poverty_line;
               incs.incomes( disposable ) := 0.0;
               incs.on_income_support := true;
            end if;
            incs.region := hh.regional_stratifier;
            incs.tenure := hh.tenure;
            incs.economic_status := bu.economic_status;
            incs.disablement_status := bu.disablement_status;
            incs.bu_type := bu.bu_type;
            incs.age_range_of_head := bu.age_range_of_head;
            incs.grossing_factor := grossing_factor;
            if( buno = 1 ) then
               income_measures.aggregate := incs;
            else
               Aggregate( income_measures.aggregate, incs );
            end if;
            for i in 1 .. incs.num_cost_measures loop
               incs.affordabilities( i ) := Calculate_Affordabilities( incs.incomes, incs.poverty_line, incs.costs(i));
            end loop;
          end;
      end loop;
      for i in 1 .. income_measures.aggregate.num_cost_measures loop
          income_measures.aggregate.affordabilities( i ) := Calculate_Affordabilities( 
               income_measures.aggregate.incomes, 
               income_measures.aggregate.poverty_line, 
               income_measures.aggregate.costs(i) );
      end loop;
      
   end Calculate_Income_Measures;


end Model.Income_Measures;


