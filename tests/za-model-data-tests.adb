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
with Ada.Text_Io.Editing;

with AUnit.Assertions;

with ZA.Model.Data.Binary_IO;

package body ZA.Model.Data.Tests is

   use AUnit.Assertions;             
   use Ada.Text_IO;
   
   package mio renames ZA.Model.Data.Binary_IO;
         
   procedure Set_Up ( T : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   function Count_People( hh : Household ) return Person_Count is
      c : Person_Count := 0;
   begin
      for fno in 1 .. hh.info.num_families loop
         for pno in 1 .. hh.family( fno ).num_people loop
            c := c + 1;
         end loop;
      end loop;
      return c;
   end Count_People;

   type Tenure_Count is array( Tenure_Type ) of Amount;
   type Province_Count is array( Province_Type ) of Amount;
   
   type Sex_by_Province_By_Race_HH_Table is array( Gender_Type, Population_Group, Province_Type ) of Amount;
   type Sex_by_Province_By_Race_Pers_Table is array( Gender_Type, Population_Group, Province_Type ) of Amount;
   type By_Sex_Table is array( Gender_Type ) of Amount;
   type By_Race_Table is array( Population_Group ) of Amount;
   type Exp_by_Race_Table is array( Population_Group ) of Consumption_Array;
   type Incomes_by_Race_Table is array( Population_Group ) of Income_Array;
   type Expenses_by_Race_Table is array( Population_Group ) of Personal_Expenses_Array;
   
   procedure Test_Read_Model_Datasets( T : in out AUnit.Test_Cases.Test_Case'Class ) is
      hh : Household;
      nhh : mio.Household_Count;
      tencount : Tenure_Count := ( others=>0.0 );
      provcount : Province_Count := ( others=>0.0 );
      by_person : Sex_by_Province_By_Race_Pers_Table := ( Others=>(Others=>(Others=>0.0 )));
      expenditure_value_by_race : Exp_by_Race_Table := ( Others=>(Others=>0.0)); 
      income_by_race : Incomes_By_Race_Table := ( Others=>(Others=>0.0));
      expenses_by_race : Expenses_By_Race_Table := ( Others=>(Others=>0.0));
      total_expenses : Personal_Expenses_Array := ( Others=>0.0 );
      total_income : Income_Array := ( Others=>0.0 );
      household_count : Amount := 0.0;
      person_count : Amount := 0.0;
      weighted_count : Amount := 0.0;
      expenditure_value : Consumption_Array := ( Others=>0.0 );
      households_by_race : By_Race_Table := ( Others => 0.0 );
      
      procedure Print_Results( express_per_household : Boolean := False ) is
      begin
         Put_Line( " Household_count " & Format_With_Commas( household_count ));
         Put_Line( " Person_count " & Format_With_Commas( person_count ));
         for t in Tenure_Type loop
            Put_Line( Pretty_Print( t ) & " : " &  Format_With_Commas( tencount( t ))); 
         end loop;
         for p in Province_Type loop
            Put_Line( Pretty_Print( p ) & " : " & Format_With_Commas( provcount( p ))); 
         end loop;
         for sex in Gender_Type loop
            for pop in Population_Group loop
               for prov in Province_Type loop
                  Put( Pretty_Print( sex ) & ", " );
                  Put( Pretty_Print( pop ) & ", ");
                  Put( Pretty_Print( prov ) & " = " );
                  Put_Line( Format_With_Commas(  by_person( sex, pop, prov ) ));
               end loop;
               New_Line;
            end loop;
            New_Line;
         end loop;
         if( express_per_household ) then
            for pop in Population_Group loop
               if( households_by_race( pop ) /= 0.0 ) then
                  for i in expenditure_value'Range loop
                     expenditure_value(i) := 
                        expenditure_value( i ) / household_count;
                     expenditure_value_by_race( pop )( i ) := 
                        expenditure_value_by_race( pop )( i ) / households_by_race( pop );
                  end loop;
                  for i in Personal_Expenses_Type'Range loop
                     -- expenses_value(i) := expenses_value( i ) / household_count;
                     expenses_by_race( pop )( i ) := 
                        expenses_by_race( pop )( i ) / households_by_race( pop );
                  end loop;
                  for i in Personal_Incomes_Type'Range loop
                     -- incomes_value(i) := incomes_value( i ) / household_count;
                     income_by_race( pop )( i ) := 
                        income_by_race( pop )( i ) / households_by_race( pop );
                  end loop;
               end if;
            end loop;
         end if;
         for pop in Population_Group loop
            New_Line;                  
            for i in expenditure_value'Range loop
               Put_Line( Pretty_Print( pop ) & "  " & Pretty_Print( i ) & " : " & 
                  Format_With_Commas( expenditure_value_by_race( pop )( i ))); 
            end loop;
            New_Line;
            for i in Personal_Expenses_Type'Range loop
               Put_Line( Pretty_Print( pop ) & "  " & Pretty_Print( i ) & 
                  " : " & Format_With_Commas( expenses_by_race( pop )( i ))); 
            end loop;
            New_Line;
            for i in Personal_Incomes_Type'Range loop
               Put_Line( Pretty_Print( pop ) & "  " & Pretty_Print( i ) & 
                  " : " & Format_With_Commas( income_by_race( pop )( i ))); 
            end loop;
            New_Line;                  
         end loop;
         Put_Line( "Total (not per household) Expenses " );         
         for i in Personal_Expenses_Type'Range loop
               Put_Line( Pretty_Print( i ) & 
                  " : " & Format_With_Commas( total_expenses( i ))); 
         end loop;
         New_Line;
         Put_Line( "Total (not per household) Incomes " );         
         for i in Personal_Incomes_Type'Range loop
            Put_Line( Pretty_Print( i ) & 
               " : " & Format_With_Commas( total_income( i ))); 
         end loop;
         New_Line;                  

         
      end Print_Results;
      
      settings : Run_Settings;
      agg_earn : Amount;
      heads_race : Population_Group;
   begin
      mio.Open_Files;
      nhh := mio.Num_Households;
      Put_Line( " household count " & Format( nhh ));
      for href in 1 .. nhh loop
         hh := mio.read( href );
         Assert( Count_People( hh ) = hh.info.num_people, "people count differs for hh " & href'Img );
         -- Uprate( hh, settings );
         -- Apply_Income_Consumption_Adjustments( hh, settings );
         heads_race := hh.family( 1 ).person( 1 ).race;
         -- if( href mod 100 = 0 ) then
         --   Put_Line( To_String( hh ));
         -- end if;
         agg_earn := 0.0;
         
         for fno in 1 .. hh.info.num_families loop
            for pno in 1 .. hh.family( fno ).num_people loop
               agg_earn := agg_earn + hh.family( fno ).person( pno ).income( salaries_and_wages ); 
            end loop;
         end loop;
         
         Put( Sernum_Value'Image( hh.info.uqno ) & " : " &
              Format( agg_earn ) & " : " & 
              Format( hh.info.consumption( income_from_salaries_and_wages )));
         if( agg_earn /= hh.info.consumption( income_from_salaries_and_wages )) then
            Put( " DIFFERENT" );
            -- Put_Line( To_String( hh ));
         end if;
         New_Line;
         for fno in 1 .. hh.info.num_families loop
            for pno in 1 .. hh.family( fno ).num_people loop
               declare
                  race   : Population_Group := hh.family( fno ).person( pno ).race;
                  gender : Gender_Type := hh.family( fno ).person( pno ).gender;
               begin
                  by_person( gender, race, hh.info.province ) := 
                        by_person( gender, race, hh.info.province ) + hh.info.weight;
                  for i in hh.family( fno ).person( pno ).income'Range loop
                     income_by_race( heads_race )( i ) := income_by_race( heads_race )( i ) + 
                        ( hh.family( fno ).person( pno ).income( i ) * hh.info.weight );
                     total_income( i ) := 
                        total_income( i ) + ( hh.family( fno ).person( pno ).income( i ) * hh.info.weight );
                  end loop;
                  for i in hh.family( fno ).person( pno ).expenses'Range loop
                     expenses_by_race( heads_race )( i ) := expenses_by_race( heads_race )( i ) + 
                        ( hh.family( fno ).person( pno ).expenses( i ) * hh.info.weight ); 
                     total_expenses( i ) := 
                        total_expenses( i ) + ( hh.family( fno ).person( pno ).expenses( i ) * hh.info.weight );
                  end loop;
               end;
            end loop;
         end loop;
         for i in hh.info.consumption'Range loop
            expenditure_value_by_race( heads_race )( i ) := 
            expenditure_value_by_race( heads_race )( i ) + 
               ( hh.info.consumption( i )*hh.info.weight );
         end loop;
         weighted_count := (Amount( hh.info.num_people) * hh.info.weight);
         tencount( hh.info.tenure ) := tencount( hh.info.tenure ) + hh.info.weight;
         provcount( hh.info.province ) := provcount( hh.info.province ) + weighted_count;
         household_count := household_count + hh.info.weight;
         person_count := person_count + weighted_count;
         households_by_race( heads_race ) := 
            households_by_race( heads_race ) + hh.info.weight;
      end loop;
      mio.Close_Files;
      Print_Results;
   end Test_Read_Model_Datasets;
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      null;
      -- Register_Routine (T, Test_Read_Model_Datasets'Access, "Test_Read_Model_Datasets");
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format( "South Africa calculations unit tests." );
   end Name;

end ZA.Model.Data.Tests;
