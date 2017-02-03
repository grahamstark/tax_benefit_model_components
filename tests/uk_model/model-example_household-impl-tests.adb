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
with Model.Example_Household.Cases;
with Ada.Containers;

with AUnit.Assertions;

package body Model.Example_Household.Impl.Tests is

   use AUnit.Assertions;             
   use Ada.Text_IO;
   use Ada.Containers;
   
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   procedure Test_Impls( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use Model.Example_Household.Cases;
   begin
      for ext in Example_Type loop
         declare
            hh  : Household := Get_Household( ext );
            mhh : Model_Household := ( hh with null record );
            ss  : Sernum_Set_List := mhh.Get_Default_Benefit_Unit_PIDs;
            sn  : Sernum_Set := ss.Element( 1 );
            pno : Person_Number;
         begin
            Assert( ss.Length = 1, "ss length always 1; was " & ss.Length'Img );
            case ext is
            when 
               single_retired_person|
               young_single|
               old_sick_single_male|
               zero_income|
               care_home_resident =>
                  Assert( sn.Length = 1, "sn for " & ext'Img & " /= 1; was " & sn.Length'Img );
            when   
               working_single_parent |
               couple_bu_retired|
               young_couple|
               cpag_terry_and_julie| -- 2012 edn p 478
               cpag_angelina_and_michael|
               caring_couple =>
                  Assert( sn.Length = 2, "sn for " & ext'Img & " /= 2; was " & sn.Length'Img );
            when hmrc_ni_example_1 |
                  hmrc_ni_example_2 |
                  hmrc_ni_example_4 |
                  hmrc_ni_example_7 |
                  se_example_1 |
                  se_example_2 =>
               Assert( sn.Length = 1, "sn for " & ext'Img & " /= 1; was " & sn.Length'Img );
                
            end case;
            pno := 1;
            for pid of sn loop
               declare
                  ex_pers : Person renames hh.people( pno ); 
                  m_pers  : Model_Person := Model_Person( mhh.Find_Person( pid ));
                  a_pers  : Model.Abstract_Household.Person'Class := mhh.Find_Person( pid ); -- it's a class because it's an interface
               begin
                  pno := pno + 1;
                  Assert( ex_pers.age = m_pers.Age, "age mismatch " & ex_pers.age'Img & " vs " & m_pers.age'Img );  
                  Assert( a_pers.age = m_pers.Age, "age mismatch " & a_pers.age'Img & " vs " & m_pers.age'Img );  
                  Assert( ex_pers.sex = m_pers.sex, "sex mismatch " & ex_pers.sex'Img & " vs " & m_pers.sex'Img );
                  Assert( ex_pers.relationship = m_pers.relationship, "relationship mismatch " & ex_pers.relationship'Img & " vs " & m_pers.relationship'Img );
                  Assert( ex_pers.marital_status = m_pers.marital_status, "marital_status mismatch " & ex_pers.marital_status'Img & " vs " & m_pers.marital_status'Img );
                  for i in ex_pers.incomes'Range loop
                     Assert( ex_pers.incomes(i) = m_pers.incomes(i), "incomes mismatch " & ex_pers.incomes(i)'Img & " vs " & m_pers.incomes(i)'Img );
                  end loop;   
                  for i in ex_pers.wealth'Range loop
                     Assert( ex_pers.wealth(i) = m_pers.wealth(i), "wealth mismatch " & ex_pers.wealth(i)'Img & " vs " & m_pers.wealth(i)'Img );
                  end loop;
                  Assert( ex_pers.employment = m_pers.employment, "employment mismatch " & ex_pers.employment'Img & " vs " & m_pers.employment'Img );
                  Assert( ex_pers.is_contracted_in_to_serps = m_pers.is_contracted_in_to_serps, "is_contracted_in_to_serps mismatch " & ex_pers.is_contracted_in_to_serps'Img & " vs " & m_pers.is_contracted_in_to_serps'Img );
                  Assert( ex_pers.hours_worked = m_pers.hours_worked, "hours_worked mismatch " & ex_pers.hours_worked'Img & " vs " & m_pers.hours_worked'Img );
                  Assert( ex_pers.average_wage_per_hour = m_pers.average_wage_per_hour, "average_wage_per_hour mismatch " & ex_pers.average_wage_per_hour'Img & " vs " & m_pers.average_wage_per_hour'Img );
               end;
            end loop;
         end;
      end loop;
   end Test_Impls;
   
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      null;
      Register_Routine (T, Test_Impls'Access, "Test_Impls");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( " Model.Example_Household.Impl.Tests" );
   end Name;

end  Model.Example_Household.Impl.Tests;
