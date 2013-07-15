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

with Ada.Containers.Vectors;

with Costs_Tabulator;
with Inequality_Generator;
with Tabulator;
with Tabulator_Commons;
with T_Utils;
with Wider_IO_Commons;
with Poverty_Tabulator;

package ZA.Model.Calculator.Wider_Output is

   
   type Outputs_Rec is private;

   procedure Print_Outputs( filename : String; outputs : in out Outputs_Rec );
   
   procedure Initialise_Outputs( outputs : in out Outputs_Rec );

   procedure Add_To_Outputs( 
      hh_ref   : Positive;
      hh       : Household; 
      result_1 : Household_Result; 
      result_2 : Household_Result;
      outputs  : in out Outputs_Rec );

private      

   use Tabulator_Commons;
   
   subtype Wider_Scale_Range is Positive range 1 .. 7;
   
   type Wider_Gain_Lose_Scale is array( Wider_Scale_Range ) of Amount;
   
   Wider_Gain_Lose : constant Wider_Gain_Lose_Scale := 
      ( -50.0, -10.0, -1.0, 1.0, 10.0, 50.0, Amount'Last );

   --
   -- these aren't really needed for Wider
   --
   type Example is record
      hh_ref  : Positive;
      family  : Family_Unit_Count := 0; -- count since could meaningfully be zero
      person  : Person_Count := 0;
   end record;
   
   type Aggregate_Cell_Breakdown is record
      province   : Province_Array := ( Others => 0.0 ); 
      settlement : Settlement_Array := ( Others => 0.0 );
      race       : Population_Array := ( Others => 0.0 );
      tenure     : Tenure_Array := ( Others => 0.0 );
   end record;
   
   type Cell_Breakdown is record
      province   : Province_Type; 
      settlement : Settlement_Type;
      race       : Population_Group;
      tenure     : Tenure_Type;
   end record;
   
   procedure Increment_Cell_Breakdowns( 
      current_breakdown : in out Aggregate_Cell_Breakdown; 
      new_breakdown     : Cell_Breakdown;
      weight            : Amount );


   type Inequality_Record is record
      province     : Province_Type;
      race_of_head : Population_Group;
      income       : Amount;
      population   : Amount;
   end record;
   
   package Inequality_Package is new Ada.Containers.Vectors( 
      Element_Type => Inequality_Record, 
      Index_Type   => Positive );
   subtype Inequality_List is Inequality_Package.Vector;
   
   package Gain_Lose_By_Province_Package is new Tabulator(
         Data_Type                => Amount, 
         Example_Type             => Example,
         Row_Range                => Province_Type,
         Col_Range                => Wider_Scale_Range,
         Cell_Values_Range        => Summary_Items_Type,
         Values_Array             => Summary_Items_Array,
         Max_Examples             => 2,
         Scale_Array              => Wider_Gain_Lose_Scale,
         Cell_Breakdown           => Cell_Breakdown,
         Aggregate_Cell_Breakdown => Aggregate_Cell_Breakdown,
         Increment_Cell_Breakdown => Increment_Cell_Breakdowns
   );
   
   package Gain_Lose_By_Race_Package is new Tabulator(
         Data_Type                => Amount, 
         Example_Type             => Example,
         Row_Range                => Population_Group,
         Col_Range                => Wider_Scale_Range,
         Cell_Values_Range        => Summary_Items_Type,
         Values_Array             => Summary_Items_Array,
         Max_Examples             => 2,
         Scale_Array              => Wider_Gain_Lose_Scale,
         Cell_Breakdown           => Cell_Breakdown,
         Aggregate_Cell_Breakdown => Aggregate_Cell_Breakdown,
         Increment_Cell_Breakdown => Increment_Cell_Breakdowns
   );

   package Gain_Lose_By_Tenure_Package is new Tabulator(
         Data_Type                => Amount, 
         Example_Type             => Example,
         Row_Range                => Tenure_Type,
         Col_Range                => Wider_Scale_Range,
         Cell_Values_Range        => Summary_Items_Type,
         Values_Array             => Summary_Items_Array,
         Max_Examples             => 2,
         Scale_Array              => Wider_Gain_Lose_Scale,
         Cell_Breakdown           => Cell_Breakdown,
         Aggregate_Cell_Breakdown => Aggregate_Cell_Breakdown,
         Increment_Cell_Breakdown => Increment_Cell_Breakdowns
   );

   package Gain_Lose_By_Settlement_Package is new Tabulator(
         Data_Type                => Amount, 
         Example_Type             => Example,
         Row_Range                => Settlement_Type,
         Col_Range                => Wider_Scale_Range,
         Cell_Values_Range        => Summary_Items_Type,
         Values_Array             => Summary_Items_Array,
         Max_Examples             => 2,
         Scale_Array              => Wider_Gain_Lose_Scale,
         Cell_Breakdown           => Cell_Breakdown,
         Aggregate_Cell_Breakdown => Aggregate_Cell_Breakdown,
         Increment_Cell_Breakdown => Increment_Cell_Breakdowns
   );

   package Poverty_By_Province_Package is new Poverty_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Province_Type,
      People_Count => Person_Count
   );
   
   package Poverty_By_Race_Package is new Poverty_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Population_Group,
      People_Count => Person_Count
   );

   package Poverty_By_Tenure_Package is new Poverty_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Tenure_Type,
      People_Count => Person_Count 
   );
   
   package Poverty_By_Settlement_Package is new Poverty_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Settlement_Type,
      People_Count => Person_Count
   );
   
   package Household_Costs_By_Province is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Province_Type,
      Values_Range => All_Taxes_And_Benefits_Type,
      Values_Array => All_Taxes_And_Benefits_Array
   );
   
   package Household_Costs_By_Race is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Population_Group,
      Values_Range => All_Taxes_And_Benefits_Type,
      Values_Array => All_Taxes_And_Benefits_Array
   );

   package Household_Costs_By_Tenure is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Tenure_Type,
      Values_Range => All_Taxes_And_Benefits_Type,
      Values_Array => All_Taxes_And_Benefits_Array
   );

   package Household_Costs_By_Settlement is new Costs_Tabulator(
      Data_Type => Amount,
      Breakdown_Range => Settlement_Type,
      Values_Range => All_Taxes_And_Benefits_Type,
      Values_Array => All_Taxes_And_Benefits_Array
   );
    
   type Outputs_Rec is record
   
      all_net_incomes_1       : Inequality_List;
      all_net_incomes_2       : Inequality_List;
      
      costs_by_province_1     : Household_Costs_By_Province.Table_Type;
      costs_by_province_2     : Household_Costs_By_Province.Table_Type;
      costs_by_race_1         : Household_Costs_By_Race.Table_Type;
      costs_by_race_2         : Household_Costs_By_Race.Table_Type;
      costs_by_tenure_1       : Household_Costs_By_Tenure.Table_Type;
      costs_by_tenure_2       : Household_Costs_By_Tenure.Table_Type;
      costs_by_settlement_1   : Household_Costs_By_Settlement.Table_Type;
      costs_by_settlement_2   : Household_Costs_By_Settlement.Table_Type;

      poverty_by_province_1   : Poverty_By_Province_Package.Table_Type;
      poverty_by_province_2   : Poverty_By_Province_Package.Table_Type;
      poverty_by_race_1       : Poverty_By_Race_Package.Table_Type;
      poverty_by_race_2       : Poverty_By_Race_Package.Table_Type;
      poverty_by_tenure_1     : Poverty_By_Tenure_Package.Table_Type;
      poverty_by_tenure_2     : Poverty_By_Tenure_Package.Table_Type;
      poverty_by_settlement_1 : Poverty_By_Settlement_Package.Table_Type;
      poverty_by_settlement_2 : Poverty_By_Settlement_Package.Table_Type;

      
      gain_lose_by_settlement : Gain_Lose_By_Settlement_Package.Table_Type;
      gain_lose_by_province   : Gain_Lose_By_Province_Package.Table_Type;
      gain_lose_by_tenure     : Gain_Lose_By_Tenure_Package.Table_Type;
      gain_lose_by_race       : Gain_Lose_By_Race_Package.Table_Type;

   end record;
   
end  ZA.Model.Calculator.Wider_Output;
