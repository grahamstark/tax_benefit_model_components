--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
pragma License( Modified_GPL );

with Model.Output.Non_Means_Tested_Benefits;

package body Model.Calculations.Non_Means_Tested_Benefits is

   use Model.Output.Non_Means_Tested_Benefits;

   function Child_Benefit_Recipient( bu : Model_Benefit_Unit ) return Head_Or_Spouse is
   begin
      for hdsp in Head .. bu.last_adult loop
         if( bu.adults( hdsp ).sex = Female ) then
            return hdsp;
         end if;
      end loop;
      return Head;
   end Child_Benefit_Recipient;

   procedure Calculate_Child_Benefit( 
      bu : Model_Benefit_Unit; 
      params : Non_Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec ) is
      
      recipient : constant Head_Or_Spouse := Child_Benefit_Recipient( bu );
   begin
      if( bu.num_children > 0 ) then
         declare
            res : One_Complete_Non_Means_Tested_Output renames results.adults( recipient ).non_means_tested;
         begin
            res.child_benefit := params.child_benefit.first_child + 
               (Amount( bu.num_children-1 ) * params.child_benefit.subsequent_children);
         end;
      end if;
   end Calculate_Child_Benefit;
   
   procedure Calculate( 
      bu : Model_Benefit_Unit; 
      params : Non_Means_Tested_Benefits_Sys; 
      results : in out Benefit_Unit_Result; 
      run_settings : settings.Settings_Rec ) is
   begin
      Calculate_Child_Benefit( bu, params, results, run_settings );
   end Calculate;
   
   procedure Calculate( 
      hh : Household_Rec; 
      params : Non_Means_Tested_Benefits_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec ) is   
   begin
      for tuno in 1 .. hh.num_benefit_units loop
         Calculate( hh.benefit_units(tuno), params, results.benefit_units(tuno), run_settings );
      end loop;
   end Calculate;
        
end Model.Calculations.Non_Means_Tested_Benefits;
