--
--  $Author: graham_s $
--  $Date: 2008-04-27 12:32:03 +0100 (Sun, 27 Apr 2008) $
--  $Revision: 5113 $
--
--
pragma License( Modified_GPL );

with Ada.Strings.Unbounded;
with Text_Utils;

package body Model.Output.Complete is

   use Text_Utils;

   function New_Output return Household_Result is
      diff : Household_Result;      
   begin
      return diff;
   end New_Output;
   
   procedure Accumulate( hh : Household_Rec; res : in out Household_Result ) is
   
   begin 
      for buno in 1.. hh.num_benefit_units loop
         declare
            bures : Benefit_Unit_Result renames res.benefit_units( buno );
            bu    : constant Model_Benefit_Unit := hh.benefit_units( buno );
          begin
            for adno in Head .. bu.last_adult loop
               Sum( bures.aggregate, bures.adults(adno));
            end loop;
            for chno in 1 .. bu.num_children loop
               Sum( bures.aggregate, bures.children(chno) );
            end loop;
            Sum( res.aggregate, bures.aggregate );
          end;
      end loop;
   end Accumulate;
   
   function To_String( res : One_Complete_Result ) return String is
   use Ada.Strings.Unbounded;
      outs : Unbounded_String := To_Unbounded_String( "" );   
   begin
      outs := outs & "net income " & Format( res.net_income ) & LINE_BREAK;
      outs := outs & "marginal rate " & Format( res.marginal_tax_rate ) & LINE_BREAK;
      outs := outs & "means tested benefits " & LINE_BREAK & To_String( res.means_tested ) & LINE_BREAK;
      outs := outs & "non-means tested benefits " & LINE_BREAK & To_String( res.non_means_tested ) & LINE_BREAK;
      outs := outs & "legal aid " & LINE_BREAK & To_String( res.legal_aid ) & LINE_BREAK;
      return To_String(outs);
   end To_String;
   
   function To_String( bu : Model_Benefit_Unit; res : Benefit_Unit_Result ) return String is
   use Ada.Strings.Unbounded;
      outs : Unbounded_String := To_Unbounded_String( "" );   
   begin
      outs := outs & "Aggregate Results " & LINE_BREAK & To_String( res.aggregate ) & LINE_BREAK;
      for adno in Head .. bu.last_adult loop
         outs := outs & "     Adult " & Head_Or_Spouse'Image( adno ) & LINE_BREAK;
         outs := outs & To_String( res.adults( adno ) );
         outs := outs & LINE_BREAK;
      end loop;
      return To_String(outs);
   end To_String;
   
   procedure Difference( res1 : in out One_Complete_Result; res2 : One_Complete_Result ) is
   begin
      res1.means_tested := Difference( res1.means_tested, res2.means_tested );
      res1.non_means_tested := Difference( res1.non_means_tested, res2.non_means_tested );
      res1.legal_aid := Difference( res1.legal_aid, res2.legal_aid );
   end Difference;
   
   procedure Sum( res1 : in out One_Complete_Result; res2 : One_Complete_Result ) is
   begin
      res1.means_tested := Sum( res1.means_tested, res2.means_tested );
      res1.non_means_tested := Sum( res1.non_means_tested, res2.non_means_tested );
      -- FIXME res1.legal_aid := Sum( res1.legal_aid, res2.legal_aid );
   end Sum;

   
   procedure Difference ( new_res : in out Household_Result; base : Household_Result ) is
   begin
      null;
   end Difference;
   
   procedure Sum( new_res : in out Household_Result; base : Household_Result ) is
   begin
      null;
   end Sum;
   
   function To_String( hh : Household_Rec; res : Household_Result ) return String is
   use Ada.Strings.Unbounded;
      outs : Unbounded_String := To_Unbounded_String( "" );   
   begin
      outs := outs & "Aggregate Results " & LINE_BREAK & To_String( res.aggregate ) & LINE_BREAK;
      for buno in 1 .. hh.num_benefit_units loop
         outs := outs & " Benefit Unit " & Positive'Image( buno ) &  LINE_BREAK;
         outs := outs & To_String( hh.benefit_units(buno), res.benefit_units( buno )) & LINE_BREAK;
      end loop;
      return To_String( outs );
   end To_String;
       
end Model.Output.Complete;
