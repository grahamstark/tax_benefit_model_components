--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
pragma License( Modified_GPL );

with Legal_Aid_Output_Types; 
with Model.Household;
--
--
package Model.Output.Legal_Aid is

   use Legal_Aid_Output_Types;
   
   type State_Array is array( Legal_Aid_State ) of Rate;
   
   type One_LA_Output is record
       assessable_Capital : Amount := 0.0;
       excess_Capital : Amount := 0.0;
       excess_Income : Amount := 0.0;
       allowances : Amount := 0.0;
       capital_except_equity : Amount := 0.0;
      
       capital_Allowances : Amount := 0.0;
       assessable_Income : Amount := 0.0;
       disposable_Capital : Amount := 0.0;
       disposable_Income : Amount := 0.0;
       gross_Income : Amount := 0.0;
       benefits_In_Kind : Amount := 0.0;
       deductions_From_Income : Amount := 0.0;
       la_State : Legal_Aid_State := na;
       income_Contribution : Amount := 0.0;
       capital_Contribution : Amount := 0.0;
       housing_Costs : Amount := 0.0;
       rent_Share_Deduction : Amount := 0.0;
       net_income : Amount := 0.0;
       child_Allowances,
       partners_Allowances   : Amount := 0.0;
      
       targetting_index : Amount := 0.0;
      
       equivalence_scale : Rate := 0.0;
      
       costs :  legal_aid_output_types.LA_Takeup_Array := ( others=>(others=>(others=>0.0)));
      
       --criminal_costs : Criminal_Cost_Type_Array := ( others=> 0.0);
      
       gross_income_test_state : Gross_Income_Test_State_Type := na;
      
       means_test_state : Legal_Aid_State := na;
       capital_state : Legal_Aid_State := na;
       passport_state : Legal_Aid_State := na;
   end record;
   
   function Recode_Gross_Income_Test_State_Type( gt : Gross_Income_Test_State_Type ) return Integer;
   function Recode_LA_State( st : Legal_Aid_State  ) return Integer;
   
   function To_Weekly( res : One_LA_Output ) return One_LA_Output;
   function To_Annual( res : One_LA_Output ) return One_LA_Output;

   --
   --  a record with differences (1-2) in all the numeric values.
   --
   function Difference ( res1, res2 : One_LA_Output ) return One_LA_Output;
   
   --
   --  a fresh output record
   --
   function New_Output return One_LA_Output;
   
   function To_String ( res : One_LA_Output ) return String;
   
   function to_CDA ( res : One_LA_Output ) return String;
   
   type LA_Output_Array is array (1 .. Model.Household.MAX_NUM_BENEFIT_UNITS) of One_LA_Output;


end Model.Output.Legal_Aid;
