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

with Inequality_Generator;
with Ada.Text_IO;
with Tabulator.Wider_IO;
with Costs_Tabulator.Wider_IO;
with Poverty_Tabulator.Wider_IO;
with Wider_IO_Commons;
with Text_Utils;

package body ZA.Model.Calculator.Wider_Output is

   use Ada.Text_IO;
   use Wider_IO_Commons;
   use Text_Utils;
   
   procedure Increment_Cell_Breakdowns( 
      current_breakdown : in out Aggregate_Cell_Breakdown; 
      new_breakdown     : Cell_Breakdown;
      weight            : Amount ) is
   begin
      current_breakdown.province( new_breakdown.province ) := 
         current_breakdown.province( new_breakdown.province ) + weight;
      current_breakdown.tenure( new_breakdown.tenure ) := 
         current_breakdown.tenure( new_breakdown.tenure ) + weight;
      current_breakdown.race( new_breakdown.race ) := 
         current_breakdown.race( new_breakdown.race ) + weight;
      current_breakdown.settlement( new_breakdown.settlement ) := 
         current_breakdown.settlement( new_breakdown.settlement ) + weight;
   end Increment_Cell_Breakdowns;
   
   type Gini_Target is ( complete, by_race, by_province );
   
   function Pretty_Print( t : Gini_Target ) return String is
   begin
      case t is
         when complete => return "no_breakdown";
         when by_race  => return "race";
         when by_province => return "province";
      end case;
   end Pretty_Print;
   
   package za_inequality is new Inequality_Generator( Amount=>Amount, Rate=>Rate );

   
   type Lorenz_And_Gini is record
      gini : Rate;
      lorenz : za_inequality.Quantile_List;
   end record;
   
   function Create_Lorenz_And_Gini( 
      all_points : Inequality_List; 
      target_type : Gini_Target;
      which_race : Population_Group := Population_Group'First;
      which_province : Province_Type := Province_Type'First;
      num_bins : Natural := 20 ) return Lorenz_And_Gini is
      
      points_for_output : za_inequality.Quantile_List;
      
      procedure Add_To_Disaggregated( c : Inequality_Package.Cursor ) is
         iq : Inequality_Record := Inequality_Package.Element( c );
         include_this_point : Boolean := False;
         quant : za_inequality.Quantile;
      begin
         if( iq.income > 0.0 ) then
            case target_type is
               when complete => include_this_point := True;
               when by_race => include_this_point := iq.race_of_head = which_race; 
               when by_province => include_this_point := iq.province = which_province;
            end case;
            if( include_this_point ) then
               quant.income := iq.income;
               quant.population := iq.population;
               za_inequality.Quantile_Package.Append( points_for_output, quant );
            end if;
         end if;
      end Add_To_Disaggregated;
      
      use Ada.Containers;
      lg : Lorenz_And_Gini;
      inequality_measures : za_inequality.Inequality_Array;
      lorenz        : za_inequality.Quantile_List;
   begin
      Inequality_Package.Iterate( all_points, Add_To_Disaggregated'Access );
      if( za_inequality.Quantile_Package.Length( points_for_output ) > 0 ) then
         za_inequality.Sort_By_Income( points_for_output );
         inequality_measures := za_inequality.Generate( points_for_output );
         lg.gini := inequality_measures( za_inequality.gini ) * 100.0;
         lg.lorenz := za_inequality.Binify( points_for_output, num_bins );
      end if;
      return lg;
   end Create_Lorenz_And_Gini;

   procedure Print_Gini( 
      f           : File_Type; 
      target_type : Gini_Target;
      breakdown   : String;
      sys_no      : System_Number; 
      lg          : Lorenz_And_Gini ) is
      use za_inequality;
      use Quantile_Package;
      quant : Quantile;
      top_quant : Quantile;
      num_bins    : constant Natural := Natural(Length( lg.lorenz ));
   begin
      Put( f, """lorenz""," );
      Put( f, """" & Pretty_Print( target_type ) & """," );
      Put( f, """" & breakdown & """," );
      Put( f, Rate'Image( lg.gini ) & "," );
      Put( f, "2009," );
      Put( f, System_Number'Image( sys_no ) & "," );
      Put_Line( f, Natural'Image( num_bins + 1 ) ); -- 1 extra for zero starting point
      top_quant := Element( lg.lorenz, num_bins );
      Put_Line( f, "0.0,0.0" ); -- starting point      
      for i in 1 .. num_bins loop
         quant := Element( lg.lorenz, i );
         Put_Line( 
            f, 
            Rate'Image( quant.population/top_quant.population ) & "," &
            Rate'Image( quant.income/top_quant.income ));
      end loop;
   end Print_Gini;
   
   procedure Print_All_Ginis( 
      f               : File_Type; 
      sys_no          : System_Number; 
      all_net_incomes : Inequality_List ) is
      lg : Lorenz_And_Gini;
   begin
      lg := Create_Lorenz_And_Gini( 
         all_net_incomes, 
         complete,
         Population_Group'First,
         Province_Type'First,
         20 );
      Print_Gini( 
         f, 
         complete, 
         "no_breakdown", 
         sys_no, 
         lg );
      for province in Province_Type'Range loop
         lg := Create_Lorenz_And_Gini( 
            all_net_incomes, 
            by_province,
            Population_Group'First,
            province,
            20 );
         Print_Gini( 
            f, 
            by_province, 
            Censor_String( Province_Type'Image( province )), 
            sys_no,
            lg );
      end loop;
      for race in Population_Group loop -- skip all the junk ones
         lg := Create_Lorenz_And_Gini( 
            all_net_incomes, 
            by_race,
            race,
            Province_Type'first,
            20 );
         Print_Gini( 
            f, 
            by_race, 
            Censor_String( Population_Group'Image( race )), 
            sys_no, 
            lg );
      end loop;

   end Print_All_Ginis;
   
   package Gain_Lose_By_Settlement_Printer is new 
      Gain_Lose_By_Settlement_Package.Wider_IO;
   package Gain_Lose_By_Tenure_Printer is new 
      Gain_Lose_By_Tenure_Package.Wider_IO;
   package Gain_Lose_By_Province_Printer is new 
      Gain_Lose_By_Province_Package.Wider_IO;
   package Gain_Lose_By_Race_Printer is new 
      Gain_Lose_By_Race_Package.Wider_IO;
      
   package Poverty_By_Province_Printer is new 
      Poverty_By_Province_Package.Wider_IO;
   package Poverty_By_Race_Printer is new 
      Poverty_By_Race_Package.Wider_IO;
   package Poverty_By_Tenure_Printer is new 
      Poverty_By_Tenure_Package.Wider_IO;
   package Poverty_By_Settlement_Printer is new 
      Poverty_By_Settlement_Package.Wider_IO;
   
   package Household_Costs_By_Province_Printer is new 
      Household_Costs_By_Province.Wider_IO;
   package Household_Costs_By_Race_Printer is new 
      Household_Costs_By_Race.Wider_IO;
   package Household_Costs_By_Tenure_Printer is new 
      Household_Costs_By_Tenure.Wider_IO;
   package Household_Costs_By_Settlement_Printer is new 
      Household_Costs_By_Settlement.Wider_IO;
      
   procedure Print_Outputs( 
      filename : String; 
      outputs  : in out Outputs_Rec ) is
      f : File_Type;
   begin
      Put_Line( "Output written to |" & filename & "|" );
      Create( f, Out_File, filename );
      
      Household_Costs_By_Province_Printer.Print(
         f,
         "budget_table_sys_1",
         outputs.costs_by_province_1,
         1,
         "province",
         "taxes",
         2009,
         1
         );
      Household_Costs_By_Tenure_Printer.Print(
         f,
         "budget_table_sys_1",
         outputs.costs_by_tenure_1,
         2,
         "tenure",
         "taxes",
         2009,
         1
         );
      Household_Costs_By_Tenure_Printer.Print(
         f,
         "budget_table_sys_1",
         outputs.costs_by_tenure_1,
         3,
         "tenure",
         "taxes",
         2009,
         1
         );
      Household_Costs_By_Race_Printer.Print(
         f,
         "budget_table_sys_1",
         outputs.costs_by_race_1,
         4,
         "race",
         "taxes",
         2009,
         1
         );
      --
      -- budget sys 2
      --
      Household_Costs_By_Province_Printer.Print(
         f,
         "budget_table_sys_2",
         outputs.costs_by_province_2,
         5,
         "province",
         "taxes",
         2009,
         2
         );
      Household_Costs_By_Race_Printer.Print(
         f,
         "budget_table_sys_2",
         outputs.costs_by_race_2,
         6,
         "race",
         "taxes",
         2009,
         2
         );
      Household_Costs_By_Tenure_Printer.Print(
         f,
         "budget_table_sys_2",
         outputs.costs_by_tenure_2,
         7,
         "tenure",
         "taxes",
         2009,
         2
         );
      Household_Costs_By_Settlement_Printer.Print(
         f,
         "budget_table_sys_1",
         outputs.costs_by_settlement_1,
         8,
         "location",
         "taxes",
         2009,
         1
         );
      Household_Costs_By_Settlement_Printer.Print(
         f,
         "budget_table_sys_2",
         outputs.costs_by_settlement_2,
         9,
         "location",
         "taxes",
         2009,
         2
         );
      --
      -- missing columns in poverty tables
      -- 
      Poverty_By_Race_Package.Complete_Table( outputs.poverty_by_race_1 );
      Poverty_By_Race_Package.Complete_Table( outputs.poverty_by_race_2 );
      Poverty_By_Province_Package.Complete_Table( outputs.poverty_by_Province_1 );
      Poverty_By_Province_Package.Complete_Table( outputs.poverty_by_Province_2 );
      Poverty_By_Tenure_Package.Complete_Table( outputs.poverty_by_Tenure_1 );
      Poverty_By_Tenure_Package.Complete_Table( outputs.poverty_by_Tenure_2 );
      Poverty_By_Settlement_Package.Complete_Table( outputs.poverty_by_Settlement_1 );
      Poverty_By_Settlement_Package.Complete_Table( outputs.poverty_by_Settlement_2 );
      
      --
      -- poverty sys 1
      --
      Poverty_By_Race_Printer.Print(
         f,
         "poverty_status_sys_1",
         outputs.poverty_by_race_1,
         10,
         "race",
         2009,
         1
         );
      Poverty_By_Province_Printer.Print(
         f,
         "poverty_status_sys_1",
         outputs.poverty_by_province_1,
         11,
         "province",
         2009,
         1
         );
      Poverty_By_Tenure_Printer.Print(
         f,
         "poverty_status_sys_1",
         outputs.poverty_by_tenure_1,
         12,
         "tenure",
         2009,
         1
         );
      Poverty_By_Settlement_Printer.Print(
         f,
         "poverty_status_sys_1",
         outputs.poverty_by_settlement_1,
         13,
         "location",
         2009,
         1
         );
         
      --
      -- poverty sys 2
      --
      Poverty_By_Race_Printer.Print(
         f,
         "poverty_status_sys_2",
         outputs.poverty_by_race_2,
         14,
         "race",
         2009,
         2
         );
      Poverty_By_Province_Printer.Print(
         f,
         "poverty_status_sys_2",
         outputs.poverty_by_province_2,
         15,
         "province",
         2009,
         2
         );
      Poverty_By_Tenure_Printer.Print(
         f,
         "poverty_status_sys_2",
         outputs.poverty_by_tenure_2,
         16,
         "tenure",
         2009,
         2
         );
      Poverty_By_Settlement_Printer.Print(
         f,
         "poverty_status_sys_2",
         outputs.poverty_by_settlement_2,
         17,
         "location",
         2009,
         2
         );
         
      --
      -- Gain/Lose tables
      -- 
      Gain_Lose_By_Race_Printer.Print( 
         f, 
         "gain_lose_by_race",
         outputs.gain_lose_by_race, 
         NO_CHANGE_COL, 
         "change_income", 
         "race", 
         2009, 
         18 );
         
      Gain_Lose_By_Province_Printer.Print( 
         f, 
         "gain_lose_by_province",
         outputs.gain_lose_by_province, 
         NO_CHANGE_COL, 
         "change_income", 
         "province", 
         2009, 
         19 );
         
      Gain_Lose_By_Tenure_Printer.Print( 
         f, 
         "gain_lose_by_tenure",
         outputs.gain_lose_by_tenure, 
         NO_CHANGE_COL, 
         "change_income", 
         "tenure", 
         2009, 
         21 );

      Gain_Lose_By_Settlement_Printer.Print( 
         f, 
         "gain_lose_by_location",
         outputs.gain_lose_by_settlement, 
         NO_CHANGE_COL, 
         "change_income", 
         "location", 
         2009, 
         22 );
      Print_All_Ginis( f, 1, outputs.all_net_incomes_1 );
      Print_All_Ginis( f, 2, outputs.all_net_incomes_2 );
      Close( f );
   end Print_Outputs;
   
   procedure Initialise_Outputs( outputs : in out Outputs_Rec ) is
   begin
     null;
   end Initialise_Outputs;

   procedure Add_To_Outputs( 
      hh_ref  : Positive;
      hh      : Household; 
      result_1    : Household_Result; 
      result_2    : Household_Result;
      outputs : in out Outputs_Rec ) is
      
      ir_1      : Inequality_Record;
      ir_2      : Inequality_Record;
      breakdown : Cell_Breakdown;
      column    : Wider_Scale_Range;
      exmpl     : Example;
      all_tbs_1      : All_Taxes_And_Benefits_Array;
      all_tbs_2      : All_Taxes_And_Benefits_Array;
      summary_1      : Summary_Items_Array;
      summary_2      : Summary_Items_Array;
      weighted_people : constant Amount := hh.info.weight * Amount( hh.info.num_people );
   begin
      ir_1.race_of_head := hh.family( 1 ).person( 1 ).race;
      ir_1.province := hh.info.province;
      ir_1.income := result_1.net_income * hh.info.weight;
      ir_1.population := weighted_people;
      ir_2.race_of_head := hh.family( 1 ).person( 1 ).race;
      ir_2.province := hh.info.province;
      ir_2.income := result_2.net_income * hh.info.weight;
      ir_2.population := weighted_people;
      
      Inequality_Package.Append( outputs.all_net_incomes_1, ir_1 );
      Inequality_Package.Append( outputs.all_net_incomes_2, ir_2 );

      breakdown.province := hh.info.province;
      breakdown.race := hh.family( 1 ).person( 1 ).race;
      breakdown.tenure := hh.info.tenure;
      breakdown.settlement := hh.info.urban_or_rural;
      
      all_tbs_1 := Map( result_1 );
      all_tbs_2 := Map( result_2 );
      summary_1 := Map( result_1 );
      summary_2 := Map( result_2 );
      --
      -- since all tables at household level, no other fields needed in example
      --
      exmpl.hh_ref := hh_ref;
      --
      -- Costs table
      --
      Household_Costs_By_Province.Add_Observation( 
             outputs.costs_by_province_1,
             hh.info.province, 
             hh.info.weight, 
             all_tbs_1 );
      Household_Costs_By_Race.Add_Observation( 
             outputs.costs_by_race_1,
             hh.family( 1 ).person( 1 ).race, 
             hh.info.weight, 
             all_tbs_1 );
      Household_Costs_By_Tenure.Add_Observation( 
             outputs.costs_by_tenure_1,
             hh.info.tenure, 
             hh.info.weight, 
             all_tbs_1 );
      Household_Costs_By_Settlement.Add_Observation( 
             outputs.costs_by_settlement_1,
             hh.info.urban_or_rural, 
             hh.info.weight, 
             all_tbs_1 );
             
      Household_Costs_By_Province.Add_Observation( 
             outputs.costs_by_province_2,
             hh.info.province, 
             hh.info.weight, 
             all_tbs_2 );
      Household_Costs_By_Race.Add_Observation( 
             outputs.costs_by_race_2,
             hh.family( 1 ).person( 1 ).race, 
             hh.info.weight, 
             all_tbs_2 );
      Household_Costs_By_Tenure.Add_Observation( 
             outputs.costs_by_tenure_2,
             hh.info.tenure, 
             hh.info.weight, 
             all_tbs_2 );
      Household_Costs_By_Settlement.Add_Observation( 
             outputs.costs_by_settlement_2,
             hh.info.urban_or_rural, 
             hh.info.weight, 
             all_tbs_2 );
             
      column := Gain_Lose_By_Province_Package.Get_Col_Range(
            result_1.net_income,
            result_2.net_income,
            Wider_Gain_Lose,
            pct_change );
            
      Gain_Lose_By_Province_Package.Add_Observation( 
            outputs.gain_lose_by_province, 
            hh.info.province, 
            column, 
            hh.info.weight, 
            summary_1,
            summary_2,
            breakdown,
            exmpl );
      Gain_Lose_By_Tenure_Package.Add_Observation( 
            outputs.gain_lose_by_Tenure, 
            hh.info.tenure, 
            column, 
            hh.info.weight, 
            summary_1,
            summary_2,
            breakdown,
            exmpl );
      Gain_Lose_By_Race_Package.Add_Observation( 
            outputs.gain_lose_by_race, 
            hh.family( 1 ).person( 1 ).race, 
            column, 
            hh.info.weight, 
            summary_1,
            summary_2,
            breakdown,
            exmpl );
      Gain_Lose_By_Settlement_Package.Add_Observation( 
            outputs.gain_lose_by_settlement, 
            hh.info.urban_or_rural, 
            column, 
            hh.info.weight, 
            summary_1,
            summary_2,
            breakdown,
            exmpl );
      --
      --
      --
      Poverty_By_Province_Package.Add_Observation( 
             outputs.poverty_by_province_1,
             result_1.poverty_gap,
             hh.info.num_people,
             hh.info.province, 
             hh.info.weight );
      Poverty_By_Tenure_Package.Add_Observation( 
             outputs.poverty_by_tenure_1,
             result_1.poverty_gap,
             hh.info.num_people,
             hh.info.tenure, 
             hh.info.weight );
      Poverty_By_Race_Package.Add_Observation( 
             outputs.poverty_by_race_1,
             result_1.poverty_gap,
             hh.info.num_people,
             hh.family( 1 ).person( 1 ).race, 
             hh.info.weight );
      Poverty_By_Settlement_Package.Add_Observation( 
             outputs.poverty_by_settlement_1,
             result_1.poverty_gap,
             hh.info.num_people,
             hh.info.urban_or_rural, 
             hh.info.weight );
      --
      -- 
      --
      Poverty_By_Province_Package.Add_Observation( 
             outputs.poverty_by_province_2,
             result_2.poverty_gap,
             hh.info.num_people,
             hh.info.province, 
             hh.info.weight );
      Poverty_By_Tenure_Package.Add_Observation( 
             outputs.poverty_by_tenure_2,
             result_2.poverty_gap,
             hh.info.num_people,
             hh.info.tenure, 
             hh.info.weight );
      Poverty_By_Race_Package.Add_Observation( 
             outputs.poverty_by_race_2,
             result_2.poverty_gap,
             hh.info.num_people,
             hh.family( 1 ).person( 1 ).race, 
             hh.info.weight );
      Poverty_By_Settlement_Package.Add_Observation( 
             outputs.poverty_by_settlement_2,
             result_2.poverty_gap,
             hh.info.num_people,
             hh.info.urban_or_rural, 
             hh.info.weight );
   end Add_To_Outputs;

end ZA.Model.Calculator.Wider_Output;
