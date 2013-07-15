with Ada.Text_IO;
with Ada.Containers;
with Text_Utils;

package body Model.Run_Settings.IO is

   use Ada.Text_IO;
   use UK_Key_Value_IO;
   use Text_Utils;

   procedure Write( file :  File_Type; icr : Incomes_Control_Record ) is
      key : constant Unbounded_String := TuS("incomes_control_record.");  
   begin
      Write( file,  key & "aggregate_incomes_to",  Aggregation_Level'Image( icr.aggregate_incomes_to ));
      Write( file,  key & "produce_results_for",  Aggregation_Level'Image( icr.produce_results_for ));
      Write( file, key & "exclude_is_cases", icr.exclude_is_cases );
      Write( file, key & "exclude_net_incomes_below_poverty_line", icr.exclude_net_incomes_below_poverty_line  );
      Write( file, key & "exclude_net_incomes_below_poverty_line", icr.poverty_multiplier );
      Write( file, key & "include_only_non_zero_costs", icr.include_only_non_zero_costs );
      Write( file, key & "include_housing", icr.include_housing );
      Write( file, key & "include_child_care_costs_in_allowances", icr.include_child_care_costs_in_allowances );
      Write( file, key & "summary_slot", icr.summary_slot );
   end Write;
   
   function Read( file :  File_Type ) return Incomes_Control_Record is
      icr : Incomes_Control_Record;
      key : constant Unbounded_String := TuS("incomes_control_record.");
   begin
      icr.aggregate_incomes_to := Aggregation_Level'Value( Read( file, key & "aggregate_incomes_to" ));
      icr.produce_results_for  := Aggregation_Level'Value( Read( file, key & "produce_results_for" ));
      icr.exclude_is_cases     := Read( file, key & "exclude_is_cases" );
      icr.exclude_net_incomes_below_poverty_line := Read( file, key & "exclude_net_incomes_below_poverty_line" );
      icr.poverty_multiplier   :=  Read( file, key & "exclude_net_incomes_below_poverty_line" );
      icr.include_only_non_zero_costs := Read( file, key & "include_only_non_zero_costs" );
      icr.include_housing := Read( file, key & "include_housing" );
      icr.include_child_care_costs_in_allowances := Read( file, key & "include_child_care_costs_in_allowances" );
      icr.summary_slot := Read( file, key & "summary_slot" );
      return icr;
   end Read;
   
end Model.Run_Settings.IO;
