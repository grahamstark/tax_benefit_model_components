with Ada.Assertions;
with GNATColl.Traces;
with Ada.Containers;

package body Model.Calculator.Utils is

   use type Ada.Containers.Count_Type;
   use Ada.Assertions;
   
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
      for pid of bu.Get_Pids loop
         inc := inc + Calculate_Incomes( 
            bu.Get_Person( pid ).Get_Incomes,
            res.Get( pid ),
            which_to_include );
      end loop;
      return inc;
   end Calculate_Incomes;
   
   function Which_Incomes_Received( 
      non_calculated : Incomes_List;
      res            : mar.Personal_Result'Class ) return Incomes_Set is
      inct : Incomes_List := Combine_Incomes( non_calculated, res );
      s    : Incomes_Set;
   begin
      for i in inct'Range loop
         if inct( i ) /= 0.0 then
            s.Include( i );
         end if;
      end loop;
      return s;
   end Which_Incomes_Received; 
   
   function Get_Head_Of_Benefit_Unit( bu : mah.Benefit_Unit'Class ) return Sernum_Value is
      hids : Sernum_Set := bu.Get_Pids(
      start_age => 16,
      end_age   => Age_Range'Last,
      relationship_from => head, 
      relationship_to   => head );
      hpid : Sernum_Value := Sernum_Value'Last;
   begin
      Assert( hids.Length < 2, "no more than 1 head in BU; was " & hids.Length'Img );
      if hids.Length = 1 then
         hpid := hids.First_Element;
      else
         declare
            oldest : Age_Range := Age_Range'First;
         begin
            for pid of bu.Get_Pids loop
               declare
                  pers : mah.Person'Class := bu.Get_Person( pid );
               begin
                  if pers.age > oldest then
                     oldest := pers.age;
                     hpid := pers.pid;
                  end if;
               end;
            end loop;
         end;
      end if;
      Assert( hpid < Sernum_Value'Last, "didn't find a head for bu " );
      return hpid;
   end Get_Head_Of_Benefit_Unit;

   
end Model.Calculator.Utils;