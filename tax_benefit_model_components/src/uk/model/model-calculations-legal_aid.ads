--
--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
pragma License( Modified_GPL );
 
with Model.Output.Legal_Aid; 
with FRS_Enums; 
with Model.Parameters.Legal_Aid;
with Model.Output.Complete;
with Model.Run_Settings;

package Model.Calculations.Legal_Aid is

   use Model.Output.Legal_Aid;
   use FRS_Enums;
   use Model.Parameters.Legal_Aid;
   use Model.Output.Complete;
   package settings renames Model.Run_Settings;
   --
   --  The interface to this module.
   --  uprate - switch for using uprated cost estimates - see tg's note
   function Calc_One_HH_Legal_Aid
     (hh     : Household_Rec;
      sys    : Legal_Aid_Sys;
      ctype  : Claim_Type;
      uprate : Boolean)
      return   LA_Output_Array;
      
      
    procedure Calculate( 
      hh : Household_Rec; 
      params : Legal_Aid_Sys; 
      results : in out Household_Result; 
      run_settings : settings.Settings_Rec );  

   --
   -- calculates a simple measure of the "error" between 2 systems
   -- error is: high if you gain & are rich
   --           high if you lose & are poor
   --           zero if no change
   --           higher for further moves (e.g full->none > full->partial
   -- the only measure used currently is equivalent decile, since number of children etc.
   -- is subsumed in that.
   --
   function Error_Index
     (bu   : Model_Benefit_Unit;
      res1 : One_LA_Output;
      res2 : One_LA_Output)
      return Amount;

   --
   --  These are made public only so we can unit test them. Please don't
   --  use directly.
   --
   function Earned_Capital_Disregard (inc : Amount; capsys : Capital_Sys) return Amount;
   
   procedure Calc_Allowances
     (benunit : Model_Benefit_Unit;
      allows  : Allowance_Sys;
      res     : in out One_LA_Output);
   
   function Passport_Person (ad : Model_Adult; sys : Legal_Aid_Sys) return Boolean;
   
   function Passport_Benefit_Unit
     (benunit : Model_Benefit_Unit;
      sys     : Legal_Aid_Sys)
      return    Boolean;
      
      
   procedure Make_Personal_Income
     (adult     : Model_Adult;
      sys       : Legal_Aid_Sys;
      laResults : in out One_LA_Output);
      
   function Calc_Rent_Share_Deduction
     (hh    : Household_Rec;
      sys   : Legal_Aid_Sys;
      cType : Claim_Type)
      return  Amount;
      
   function Householders_Housing_Costs
     (tenure        : Tenure_Type;
      housing_Costs : Model_Housing_Costs)
      return          Amount;
      
   procedure Calc_Housing_Costs
     (hh    : Household_Rec;
      sys   : Legal_Aid_Sys;
      res   : in out LA_Output_Array;
      ctype : Claim_Type);
      
   procedure Calc_Capital_Allowances
     (bu  : Model_Benefit_Unit;
      sys : Legal_Aid_Sys;
      res : in out One_LA_Output);

   procedure calc_One_BU_Legal_Aid
     (hh    : Household_Rec;
      buno  : Integer;
      res   : in out One_LA_Output;
      sys   : Legal_Aid_Sys;
      ctype : Claim_Type);

   procedure Calc_Benefits_In_Kind
     (bu  : Model_Benefit_Unit;
      sys : Legal_Aid_Sys;
      res : in out One_LA_Output);

   procedure Calc_Gross_Income
     (bu  : Model_Benefit_Unit;
      sys : Legal_Aid_Sys;
      res : in out One_LA_Output);

   --
   --  capital imputation: if any and there's a capital limit in place
   --  1.25% of the lesser of limit and capital. If a gross income test, just pass in everything
   --
   function Calc_Assumed_Investment_Income_PA
     (capital_stock              : Amount;
      reported_investment_income : Amount;
      capital_lower_limit        : Amount;
      eligible_proportion        : Rate; -- the 1.0 or whatever from the incomes lists
      is_gross_test              : Boolean)
      return                       Amount;

end Model.Calculations.Legal_Aid;
