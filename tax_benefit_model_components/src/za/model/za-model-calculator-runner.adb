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
pragma License( Modified_GPL );

with Ada.Assertions;
with Ada.Text_IO;

with Costs_Tabulator;
with Inequality_Generator;
with Tabulator;
with Tabulator_Commons;
with ZA.Model.Data.Binary_IO;
with ZA.Model.Takeup;
with T_Utils;

package body ZA.Model.Calculator.Runner is

   package mio renames ZA.Model.Data.Binary_IO;
   package za_inequality is new Inequality_Generator( Amount=>Amount, Rate=>Rate );

   
   type Aggregate_Cell_Breakdown is record
      province   : Province_Array := ( Others => 0.0 ); 
      settlement : Settlement_Array := ( Others => 0.0 );
      race       : Population_Array := ( Others => 0.0 );
      gender     : Gender_Array := ( Others => 0.0 );
   end record;
   
   type Cell_Breakdown is record
      province   : Province_Type; 
      settlement : Settlement_Type;
      race       : Population_Group;
      gender     : Gender_Type;
   end record;
   
   procedure Increment_Cell_Breakdowns( 
      current_breakdown : in out Aggregate_Cell_Breakdown; 
      new_breakdown     : Cell_Breakdown;
      weight            : Amount ) is
   begin
      current_breakdown.province( new_breakdown.province ) := 
         current_breakdown.province( new_breakdown.province ) + weight;
      -- ... 
   end Increment_Cell_Breakdowns;
   
   type Example is record
      hhref  : Positive;
      family : Family_Unit_Count; -- count since could meaningfully be zero
      person : Person_Count;
   end record;

   subtype Large_Scale_Range is Positive range 1 .. 14;
   type Large_Gain_Lose_Scale is array( Large_Scale_Range ) of Amount;
   Large_Gain_Lose : constant Large_Gain_Lose_Scale := ( Amount'First, -100.0, -50.0, -10.0, -5.0, -2.5, -1.0, 0.0, 1.0, 2.5, 5.0, 10.0, 50.0, 100.0 );
   
   package Gain_Lose_By_Province is new Tabulator(
         Data_Type                => Amount, 
         Example_Type             => Example,
         Row_Range                => Province_Type,
         Col_Range                => Large_Scale_Range,
         Cell_Values_Range        => Calculated_Incomes,
         Values_Array             => Calculated_Incomes_Array,
         Max_Examples             => 2,
         Scale_Array              => Large_Gain_Lose_Scale,
         Cell_Breakdown           => Cell_Breakdown,
         Aggregate_Cell_Breakdown => Aggregate_Cell_Breakdown,
         Increment_Cell_Breakdown => Increment_Cell_Breakdowns
   );
   
   package Costs_Tabulator_By_Province is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Province_Type,
      Values_Range => Calculated_Incomes,
      Values_Array => Calculated_Incomes_Array
   );

   package Indir_Tabulator_By_Province is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Province_Type,
      Values_Range => All_Taxes_And_Benefits_Type,
      Values_Array => All_Taxes_And_Benefits_Array
   );

   procedure Run_Model( 
      params1 : Parameters; 
      params2 : Parameters;
      settings : Run_Settings ) is
      
   use za_inequality;
   use Ada.Text_IO;
   use Ada.Assertions;
   use Tabulator_Commons;
   use ZA.Model.Takeup;
   
      hh : Household;
      nhh : mio.Household_Count;
      results1, results2    : Household_Result;
      pers_tab1,
      pers_tab2,
      tab1,
      tab2,
      diff_tab      : Costs_Tabulator_By_Province.Table_Type;
      spec1,
      spec2,
      hh_level_costs1,
      hh_level_costs2          : Indir_Tabulator_By_Province.Table_Type;
      q             : Quantile;
      all_net_incomes   : Quantile_List;
      inequality_measures : Inequality_Array;
      lorenz        : Quantile_List;
      gl_1          : Gain_Lose_By_Province.Table_Type;
      ex            : Example;
      col           : Large_Scale_Range;
      breakdown     : Cell_Breakdown;
      expr          : Gain_Lose_By_Province.Table_Expression;
      control_rec   : Run_Settings := settings; -- local copy so we can overwrite the takeup probs
      all_tbs1      : All_Taxes_And_Benefits_Array;
      all_tbs2      : All_Taxes_And_Benefits_Array;
   begin
      mio.Set_Model_Data_Dir( control_rec.paths.data_dir );
      mio.Open_Files;
      nhh := mio.Num_Households;
      Put_Line( " household count " & Format( nhh ));
      for href in 1 .. nhh loop
         hh := mio.read( href );
         control_rec.case_takes_up := 
            Get_case_takes_up( control_rec.takeup_adjustment ); -- FIXME wo't work here for pobit case needs to be after calcs
         Uprate( hh, control_rec );
         --  and so on
         Apply_Income_Consumption_Adjustments( hh, control_rec );
         results1 := Calculate( hh, params1, control_rec );
         results2 := Calculate( hh, params2, control_rec );
         all_tbs1 := Map( results1 );
         all_tbs2 := Map( results2 );
         breakdown.province := hh.info.province;
         q.income := results1.net_income;
         if q.income > 0.0 then  -- negative because of indirect taxes
            q.population := hh.info.weight * Amount( hh.info.num_people );
            Quantile_Package.Append( all_net_incomes, q );
         end if;
         Costs_Tabulator_By_Province.Add_Observation( tab1,
             hh.info.province, 
             hh.info.weight, 
             results1.income( Calculated_Incomes ));
         Costs_Tabulator_By_Province.Add_Observation( tab2,
             hh.info.province, 
             hh.info.weight, 
             results2.income( Calculated_Incomes ));

         Indir_Tabulator_By_Province.Add_Observation( 
             hh_level_costs1,
             hh.info.province, 
             hh.info.weight, 
             all_tbs1 );
         Indir_Tabulator_By_Province.Add_Observation( 
             hh_level_costs2,
             hh.info.province, 
             hh.info.weight, 
             all_tbs2 );
            
          for fno in 1 .. hh.info.num_families loop
             ex.hhref := href;
             ex.family := fno;
             ex.person := 0;
             col := Gain_Lose_By_Province.Get_Col_Range(
                  results1.disposable_income,
                  results2.disposable_income,
                  Large_Gain_Lose,
                  pct_change );
             -- Put_Line( " col " & col'Img & " dis1 = " &
             --  Format( results1.disposable_income ) & " dis2 = " &
             --  Format( results1.disposable_income ));
             Gain_Lose_By_Province.Add_Observation( 
                  gl_1, 
                  hh.info.province, 
                  col, 
                  hh.info.weight, 
                  results1.income( Calculated_Incomes ),
                  results2.income( Calculated_Incomes ),
                  breakdown,
                  ex );
                  
             for pno in 1 .. hh.family( fno ).num_people loop
                Costs_Tabulator_By_Province.Add_Observation( pers_tab1,
                   hh.info.province, 
                   hh.info.weight, 
                   results1.family( fno ).person( pno ).income( Calculated_Incomes ));
                Costs_Tabulator_By_Province.Add_Observation( pers_tab2,
                   hh.info.province, 
                   hh.info.weight, 
                   results2.family( fno ).person( pno ).income( Calculated_Incomes ));
             end loop;
          end loop;
      end loop;
      Put_Line( "sys1 costs tab (HH Level) " );
      Put_Line( Costs_Tabulator_By_Province.To_Delimited( tab1 ) ); 
      Put_Line( "sys1 costs tab (Personal Level)" );
      Put_Line( Costs_Tabulator_By_Province.To_Delimited( pers_tab1 ) ); 

      Put_Line( "sys1 vat tab (HH Level) " );
      Put_Line( Indir_Tabulator_By_Province.To_Delimited( hh_level_costs1 ) ); 
      Put_Line( "sys2 vat tab (HH Level) " );
      Put_Line( Indir_Tabulator_By_Province.To_Delimited( hh_level_costs2 ) ); 

      mio.Close_Files;
      Put_Line( "sorting " );
      Sort_By_Income( all_net_incomes );
      Put_Line( "generating income measures " );
      inequality_measures := Generate( all_net_incomes );
      Put_Line( To_String( inequality_measures ));
      lorenz := Binify( all_net_incomes, 30 );
      expr := Gain_Lose_By_Province.Express_Table( 
         gl_1, current_cell, counter, Calculated_Incomes'First );
      Put_Line( Gain_Lose_By_Province.To_Delimited( expr ));
   end Run_Model;
    
end ZA.Model.Calculator.Runner;
