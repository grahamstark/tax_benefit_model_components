--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
pragma License( Modified_GPL );

with base_model_types; use base_model_types;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;

--
--
--
package body Model.Output.Legal_Aid is

   --
   --  a fresh output record
   --
   function New_Output return One_LA_Output is
      diff : One_LA_Output;
   begin
      return diff;
   end New_Output;

   function To_String ( res : One_LA_Output ) return String is
   begin
      return LF & "Legal Aid State = " & res.la_State'Img &
      LF & LF &
      " assessable_Capital " & Format_With_Commas( res.assessable_Capital ) & LF &
      " excess_Capital " & Format_With_Commas( res.excess_Capital ) & LF &
      " excess_Income " & Format_With_Commas( res.excess_Income ) & LF &
      " allowances " & Format_With_Commas( res.allowances ) & LF &
      "    of which: child_Allowances " & Format_With_Commas( res.child_Allowances ) & LF &
      "    partners allowances " & Format_With_Commas( res. partners_Allowances ) & LF &
      " capital_Allowances " & Format_With_Commas( res.capital_Allowances ) & LF &
      " assessable_Income " & Format_With_Commas( res.assessable_Income ) & LF &
      " gross_Income " & Format_With_Commas( res.gross_Income ) & LF &
      " benefits_In_Kind " & Format_With_Commas( res.benefits_In_Kind ) & LF &
      " deductions_From_Income " & Format_With_Commas( res.deductions_From_Income ) & LF &
      " income_Contribution " & Format_With_Commas( res.income_Contribution ) & LF &
      " capital_Contribution " & Format_With_Commas( res.capital_Contribution ) & LF &
      " housing_Costs " & Format_With_Commas( res.housing_Costs ) & LF &
      " rent_Share_Deduction " & Format_With_Commas( res.rent_Share_Deduction ) & LF &
      " => disposable_Income " & Format_With_Commas( res.disposable_Income ) & LF &
      "    disposable_Capital " & Format_With_Commas( res.disposable_Capital ) & LF &
      " targetting_index " & Format_With_Commas( res.targetting_index ) & LF;
   end To_String;

   function To_CDA ( res : One_LA_Output ) return string is
   begin
       return res.assessable_Capital'Img &
       "," & res.excess_Capital'Img &
       "," & res.excess_Income'Img &
       "," & res.allowances'Img &
       "," & res.capital_Allowances'Img &
       "," & res.assessable_Income'Img &
       "," & res.disposable_Capital'Img &
       "," & res.gross_Income'Img &
       "," & res.benefits_In_Kind'Img &
       "," & res.deductions_From_Income'Img &
       "," & res.income_Contribution'Img &
       "," & res.capital_Contribution'Img &
       "," & res.housing_Costs'Img &
       "," & res.rent_Share_Deduction'Img &
       "," & res.targetting_index'Img &
       LF;
   end To_CDA;

   function Difference ( res1, res2 : One_LA_Output ) return One_LA_Output is
      diff : One_LA_Output;
   begin
      diff.assessable_Capital := res2.assessable_Capital - res1.assessable_Capital;
      diff.excess_Capital := res2.excess_Capital - res1.excess_Capital;
      diff.excess_Income := res2.excess_Income - res1.excess_Income;
      diff.allowances := res2.allowances - res1.allowances;
      diff.capital_Allowances := res2.capital_Allowances - res1.capital_Allowances;
      diff.assessable_Income := res2.assessable_Income - res1.assessable_Income;
      diff.disposable_Capital := res2.disposable_Capital - res1.disposable_Capital;
      diff.gross_Income := res2.gross_Income - res1.gross_Income;
      diff.benefits_In_Kind := res2.benefits_In_Kind - res1.benefits_In_Kind;
      diff.deductions_From_Income := res2.deductions_From_Income - res1.deductions_From_Income;
      --  diff.la_State := res2.la_State - res1.la_State;
      diff.income_Contribution := res2.income_Contribution - res1.income_Contribution;
      diff.capital_Contribution := res2.capital_Contribution - res1.capital_Contribution;
      diff.housing_Costs  := res2.housing_Costs - res1.housing_Costs;
      diff.rent_Share_Deduction := res2.rent_Share_Deduction - res1.rent_Share_Deduction;
      diff.targetting_index := res2.targetting_index - res1.targetting_index;
      return diff;
   end Difference;

   function Multiply_Flow_Variables( res : One_LA_Output; m : Rate ) return One_LA_Output is
      diff : One_LA_Output;
   begin
      diff.excess_Income := Amount( Rate( res.excess_Income ) * m );
      diff.allowances := Amount( Rate( res.allowances ) * m );
      diff.assessable_Income := Amount( Rate( res.assessable_Income ) * m );
      diff.gross_Income := Amount( Rate( res.gross_Income ) * m );
      diff.benefits_In_Kind := Amount( Rate( res.benefits_In_Kind ) * m );
      diff.deductions_From_Income := Amount( Rate( res.deductions_From_Income ) * m );
      --  diff.la_State := Amount( Rate( res.la_State ) * m );
      diff.income_Contribution := Amount( Rate( res.income_Contribution ) * m );
      diff.capital_Contribution := Amount( Rate( res.capital_Contribution ) * m );
      diff.housing_Costs  := Amount( Rate( res.housing_Costs ) * m );
      diff.rent_Share_Deduction := Amount( Rate( res.rent_Share_Deduction ) * m );
      return diff;
   end Multiply_Flow_Variables;
   
   function To_Weekly( res : One_LA_Output ) return One_LA_Output is
   begin
      return Multiply_Flow_Variables( res, 1.0/52.0 );
   end To_Weekly;
   
   function To_Annual( res : One_LA_Output ) return One_LA_Output is
   begin
      return Multiply_Flow_Variables( res, 52.0 );
   end To_Annual;
   
   
	function Recode_LA_State( st : Legal_Aid_State  ) return Integer is
   begin
      return Legal_Aid_State'Pos( st ) + 1;
   end Recode_LA_State;


   function Recode_Gross_Income_Test_State_Type( gt : Gross_Income_Test_State_Type ) return Integer is
   m : integer := MISS;
   begin
      case gt is
      when na => m := MISS;
      when below_mininum => m := 2;
      when means_tested => m := 3;
      when above_maximum => m := 4;
      when passported => m := 1;
      end case;
      return m;
   end Recode_Gross_Income_Test_State_Type;


end Model.Output.Legal_Aid;
