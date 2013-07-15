--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
pragma License( Modified_GPL );

with Model.Household;
with Model.Incomes;
with Model.Output.Means_Tested_Benefits;
with Model.Output.Non_Means_Tested_Benefits;
with Model.Output.Legal_Aid;


package Model.Output.Complete is
   
   use Model.Output.Means_Tested_Benefits;
   use Model.Output.Non_Means_Tested_Benefits;
   use Model.Output.Legal_Aid;
   use Model.Household;
   use Model.Incomes;
   
   type One_Complete_Result is record
   
      net_income : Amount;
      marginal_tax_rate : Rate;
      poverty_line      : Amount;
      
      incomes    : Incomes_Array; -- poss make this an array of just the calculated bits ???
      
      means_tested : One_Complete_Means_Tested_Output;
      non_means_tested : One_Complete_Non_Means_Tested_Output;
      legal_aid    : One_LA_Output;
      
   end record;
   
   
   type Adult_Result_Array is array (Head_Or_Spouse) of One_Complete_Result;
   type Child_Result_Array is array (1 .. MAX_NUM_CHILDREN) of One_Complete_Result;
   
   type Benefit_Unit_Result is record
      aggregate : One_Complete_Result;
      adults    : Adult_Result_Array;
      children  : Child_Result_Array;
   end record;
   
   
   type Benefit_Unit_Result_Array is array (1 .. MAX_NUM_BENEFIT_UNITS) of Benefit_Unit_Result;
   
   type Household_Result is record
      aggregate : One_Complete_Result;
      -- consumption ...... 
      benefit_units  : Benefit_Unit_Result_Array;      
   end record;
   
   procedure Difference( new_res : in out Household_Result; base : Household_Result );
   procedure Sum( new_res : in out Household_Result; base : Household_Result );
   
   procedure Difference( res1 : in out One_Complete_Result; res2 : One_Complete_Result );
   procedure Sum( res1 : in out One_Complete_Result; res2 : One_Complete_Result );
   
   function To_String( hh : Household_Rec; res : Household_Result ) return String;
   function To_String( bu : Model_Benefit_Unit; res : Benefit_Unit_Result ) return String;
   function To_String( res : One_Complete_Result ) return String;
      
   procedure Accumulate( hh : Household_Rec; res : in out Household_Result );
   
   function New_Output return Household_Result;
       
end Model.Output.Complete;
