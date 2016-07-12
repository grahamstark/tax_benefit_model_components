--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

--
--  $Author: graham_s $
--  $Date: 2010-02-11 19:11:22 +0000 (Thu, 11 Feb 2010) $
--  $Revision: 8612 $
--
pragma License( Modified_GPL );

with Ada.Text_IO;
with Ada.Containers;
with Model.Example_Household.Cases;
with Model.Example_Household.Impl;
with Model.Abstract_Household;
with AUnit.Assertions;

package body Model.Example_Results.Impl.Tests is

   use AUnit.Assertions;             
   use Ada.Text_IO;                          
   use Ada.Containers;
   use Model.Example_Household;
   
   
   procedure Test_Set_Pers( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Cases;
   begin
      Each_HHLd:
      for ht in Example_Type loop
         declare
            hh : Household := Cases.Get_Household( ht );
            mp : Person_Count := hh.people'Length;
            res : Model_Household_Result := Initialise( hh );
            m   : Amount := Amount( Example_Type'Pos( ht ));
         begin
            Assert( res.people'Length = hh.people'Length, " res size mismatch " &
              res.people'Length'Img & " vs " &
              hh.people'Length'Img );
            Each_Person:
            --
            -- individual level gets & sets
            -- 
            for pno in res.people'Range loop
               Assert( hh.people( pno ).pid = res.people( pno ).pid, 
                  "pid mismatch for hh " & ht'Img & " " & hh.people( pno ).pid'Img & 
                  " vs " & res.people( pno ).pid'Img );
               res.people( pno ).income := ( others => 999.0 );
               res.people( pno ).intermediate := ( others =>  1000.0 );
               declare
                  pid : Sernum_Value := hh.people( pno ).pid;
                  ires : mar.Personal_Result'Class := res.Get_Personal( pid );
               begin
                  Assert( ( for all it in Calculated_Incomes_Range => ires.Get( it ) = 999.0 ), "set mismatch " );
                  Assert( ( for all it in Broad_Calculated_Type => ires.Get( it ) = 1000.0 ), "set mismatch " );
                  for op in Operation_Type loop
                     ires.Set( attendance_allowance, 999.0, replace );
                     ires.Set( attendance_allowance, 2.0, op );
                     ires.Set( net_income, 1000.0, replace );
                     ires.Set( net_income, 3.0, op );
                     res.Set( pid, ires );
                     declare
                        t : Amount renames ires.Get( attendance_allowance );
                        tstr : constant String := Format( t );
                        ta : Amount renames ires.Get( net_income );
                        tastr : constant String := Format( ta );
                        tad : Amount renames res.people( pno ).intermediate( net_income );
                        tadstr : constant String := Format( ta );                        
                     begin
                        case op is
                        when add =>
                           Assert( t = 1001.0, " add; should be 1001.0 was: " & tstr );  
                           Assert( ta = 1003.0, " add; should be 1003.0 was: " & tastr );  
                           Assert( tad = 1003.0, " add; should be 1003.0 was: " & tadstr );  
                        when replace =>
                           Assert( t = 2.0, " replace; should be 2.0 was: " & tstr );  
                           Assert( ta = 3.0, " replace; should be 3.0 was: " & tastr );  
                           Assert( tad = 3.0, " replace; should be 3.0 was: " & tadstr );  
                        when subtract =>
                           Assert( t = 997.0, " subtract; should be 997.0 was: " & tstr );  
                           Assert( ta = 997.0, " subtract; should be 997.0 was: " & tastr );  
                           Assert( tad = 997.0, " subtract; should be 997.0 was: " & tadstr );  
                        when multiply =>
                           Assert( Nearly_Equal( t, 1998.0 ), " multipy; should be 1998.0 was: " & tstr );  
                           Assert( Nearly_Equal( ta, 3000.0 ), " multipy; should be 3000.0 was: " & tastr );  
                           Assert( Nearly_Equal( tad, 3000.0 ), " multipy; should be 3000.0 was: " & tadstr );  
                        when divide =>
                           Assert( Nearly_Equal( t, 499.5 ), " divide; should be 499.5 was: " & tstr );  
                           Assert( Nearly_Equal( ta, 1000.0/3.0 ), " divide; should be 3333.333 was: " & tastr );  
                           Assert( Nearly_Equal( tad, 1000.0/3.0 ), " divide; should be 3333.333 was: " & tadstr );  
                        end case;
                     end;
                  end loop;
               end;
            end loop Each_Person;
            --
            -- benefit level gets & sets
            -- 
            declare
               use Model.Example_Household.Impl;
               mhh   : Model_Household := ( hh with null record );
               bures : mar.Benefit_Unit_Result'Class := ( res.Get( 1 ));
               pids  : Sernum_Set := mhh.Get_Pids;
            begin
               Assert( pids.Length > 0, "zero pids for bu" ); 
               for pid of pids loop
                  declare
                     ires : mar.Personal_Result'Class :=  bures.Get( pid );
                  begin
                     null;
                  end;
               end loop;    
            end;
         end;

      end loop Each_HHLd;
   end Test_Set_Pers;

   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Set_Pers'Access, "Test_Set_Pers");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Results.Impl.Tests" );
   end Name;

end Model.Example_Results.Impl.Tests;