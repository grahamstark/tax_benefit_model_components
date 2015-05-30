with Ada.Assertions;
with GNATColl.Traces;

package body Model.Calculator.Utils is
  
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.CALCULATOR.UTILS" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   procedure Log( s : String; m : Amount ) is
   begin
      GNATColl.Traces.Trace( log_trace, s & " = " & Format( m ));
   end Log;
 
   function Combine_Incomes(
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_List is
      il : Incomes_List;
   begin
     for i in Incomes_List'Range loop
        if( i in Calculated_Incomes_Range )then
           il( i ) := res.Get( i );
        else
           il( i ) := non_calculated( i );
        end if;
     end loop;
     return il;
   end Combine_Incomes;
 
   function Calculate_Incomes(
      non_calculated   : Incomes_List;
      res              : mar.Personal_Result'Class;
      which_to_include : Incomes_List ) return Amount is
      inct : Incomes_List := Combine_Incomes( non_calculated, res );
      inc  : Amount := 0.0;
   begin
      for i in inct'Range loop
         inc := inc + ( inct( i ) * which_to_include( i ));
      end loop;
      return inc;
   end Calculate_Incomes;
   
  function Calculate_Incomes(
      bu               : mah.Benefit_Unit'Class;
      res              : mar.Benefit_Unit_Result'Class;
      which_to_include : Incomes_List ) return Amount is
      inc  : Amount := 0.0;
   begin
      for pno in 1 .. bu.Get_Num_People loop
         inc := inc + Calculate_Incomes( 
            bu.Get_Person( pno ).Get_Incomes,
            res.Get( pno ),
            which_to_include );
      end loop;
      return inc;
   end Calculate_Incomes;
   
end Model.Calculator.Utils;