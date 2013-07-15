--
-- $Revision $
-- $Author $
-- $Date $
--
pragma License( Modified_GPL );

with Legal_Aid_Output_Types; 
with Model.Output.Legal_Aid;     
--
--
--
--
package Model.Calculations.Legal_Aid.Costs_Model is

   use Model.Output.Legal_Aid;
   use Legal_Aid_Output_Types;

   subtype Age_Range is integer range 1 .. 8;

-- COST_HISTOGRAM
--   1 Divorce
--  2 Family, relationships, children, domestic violence
--  3 Personal injury/negligence
--  4 Other legal needs
--  5 Procedures

   type Population_State_Array is array( Legal_Aid_State, Age_Range, Gender ) of Rate;
  
   type Contribution_Proportion is record
      by_caseload : Rate := 1.0;
      by_value : Rate := 1.0;
   end record;

   function Get_Age_Range( age : integer ) return Age_Range;

   function Get_Offer_Rate(  state : Legal_Aid_State;
                             age : integer;
                             sex : Gender;
                             problem : LA_Problem_Type ) return Rate;

   function Get_Proportion_Of_Offers_That_Are_Economic( ptype : LA_Problem_Type; contribution : Amount;
        include_only_contrib_cases : boolean ) return Contribution_Proportion;

   function Get_Average_Cost( ptype : LA_Problem_Type ) return Amount;

   procedure Apply_Costs_Model( hh : Household_Rec; outp : in out LA_Output_Array );

   function Calculate_One_Position( age : integer; sex : Gender; state : Legal_Aid_State; contribution : Amount ) return LA_Takeup_Array;


   function Sum_Over_Problems( takeup : LA_Takeup_Array; ct : LA_Costs_System_Type := civil ) return LA_Costs_Component_Array;

   function Calc_Takeup_Probability( contrib : Amount; beta : Rate ) return Rate;


end Model.Calculations.Legal_Aid.Costs_Model;
