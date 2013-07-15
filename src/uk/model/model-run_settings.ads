--
--  $Revision: 15910 $
--  $Date: 2013-03-04 17:51:29 +0000 (Mon, 04 Mar 2013) $
--  $Author: graham_s $
--
pragma License( Modified_GPL );

with Ada.Calendar;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with Data_Constants;

with Model.Household;
with Model.Income_Measure_Types;
with Monitor;

with Text_Utils;

package Model.Run_Settings is

   use Ada.Calendar;
   use Ada.Strings.Unbounded;
   use Base_Model_Types;
   use Model.Household;
   use Text_Utils;
   
   package mimt renames Model.Income_Measure_Types;
   
   type Target_Type is (off_diagonal_index, costs_index, targetting_index);
   type Target_Array is array (Target_Type) of Rate;
   --                       0           1           2               3             4             5            6
   type Phase_Type is ( not_started, queued, run_starting, pre_calculations, running, generating_output, complete );
   subtype Running_Phase is Phase_Type range run_starting .. generating_output;

   type Health_Type is ( normal, aborted, in_error, queued );
   
   package Model_Monitor_Package is new Monitor( 
      Stage_Type => Phase_Type, 
      Health_Type => Health_Type, 
      num_counters => 6 );   
   
   subtype Model_Monitor is Model_Monitor_Package.Monitor_Type;
   subtype Model_Observer is Model_Monitor_Package.Monitor_Observer;
   
   type State_Type is record
      username       : Unbounded_String;
      run_id         : Natural := 0;
      session_id     : Unbounded_String; -- for example, if the model is started from a web server
      household      : Natural := 0;
      other_counter  : Natural := 0; -- num tables generated, or whatever
      other_counter2 : Natural := 0; -- num tables generated, or whatever
      other_counter3 : Natural := 0; -- num tables generated, or whatever
      other_counter4 : Natural := 0; -- num tables generated, or whatever
      
      year           : Year_Number := Year_Number'First;
      phase          : Phase_Type  := not_started;
      health         : Health_Type := normal;
      error_code     : Integer := 0;
      message        : Unbounded_String;
      read_error     : Boolean := False;
   end record;
   
   procedure Write_State( filename : String; state : State_Type );
   function Read_State( filename : String ) return State_Type;
   function To_String( state : State_Type ) return String;

   --
   -- FIXME replace with calls/overrides to Model_Monitor'Class above
   -- 
   type Run_Observer_Access is access function(
      username          : Unbounded_String;
      run_id            : Natural;
      household         : Natural;
      year              : Year_Number;
      other_item_count  : Natural; -- num tables, for example
      phase             : Phase_Type;
      health            : Health_Type := normal;
      other_item_count2 : Natural := 0;
      other_item_count3 : Natural := 0;
      other_item_count4 : Natural := 0 ) return Boolean;

   --
   -- sub record of things just for OSCR project
   --
   type Incomes_Control_Record is tagged record
         aggregate_incomes_to : Aggregation_Level :=  benefit_unit_level;
         produce_results_for  : Aggregation_Level :=  benefit_unit_level;
         exclude_is_cases     : Boolean := True;
         exclude_net_incomes_below_poverty_line : Boolean := True;
         poverty_multiplier   : Rate := 1.0;
         include_only_non_zero_costs : Boolean := true;
         include_housing : Boolean := True;
         include_child_care_costs_in_allowances : Boolean := True;
         -- outfile : Ada.Text_IO.File_Type;
         summary_slot : mimt.Slot_Range := mimt.DEFAULT_SUMMARY_SLOT;
      end record;
   
   type Settings_Rec is tagged record
      run_id              : Unbounded_String          := To_Unbounded_String("");
      year                : Data_Constants.Data_Years := Data_Constants.Data_Years'First;
      uprate_to_current   : Boolean                   := True;
      -- run_type            : System_Type               := civil;
      targetting_weights  : Target_Array              := (others => 1.0 / 3.0);
      split_benefit_units : Boolean                   := False;
      save_file_name      : Unbounded_String          := To_Unbounded_String("default_save_file");
      start_year          : Data_Constants.Data_Years := Data_Constants.Data_Years'First; -- 0304
      end_year            : Data_Constants.Data_Years := Data_Constants.Data_Years'Last; -- 0405
      inc_ctl             : Incomes_Control_Record;
      scotland_only       : Boolean                   := True;
   end record;
   function Binary_Read_Settings( filename : String ) return Settings_Rec;
   procedure Binary_Write_Settings( filename : String; settings : Settings_Rec );
   function To_String( settings : Settings_Rec ) return String;

   --
   -- Null records, useful for some DB and session handling
   -- chores.
   --
   BLANK_STATE_TYPE : constant State_Type := ( 
      run_id         => 0,
      username       => Null_Unbounded_String,
      session_id     => Null_Unbounded_String,
      household      => 0,
      other_counter  => 0,
      other_counter2 => 0,
      other_counter3 => 0,
      other_counter4 => 0,
      year           => Data_Constants.Data_Years'First,
      phase          => not_started,
      health         => normal,
      error_code     => 0,
      message        => Null_Unbounded_String,
      read_error     => False
   );

   BLANK_INCOMES_CONTROL_RECORD : constant Incomes_Control_Record := (  
         aggregate_incomes_to => benefit_unit_level,
         produce_results_for  => benefit_unit_level,
         exclude_is_cases     => True,
         exclude_net_incomes_below_poverty_line => True,
         poverty_multiplier => 1.0,
         include_only_non_zero_costs => true,
         include_housing => True,
         include_child_care_costs_in_allowances => True,
         summary_slot => mimt.DEFAULT_SUMMARY_SLOT
   );
   
   BLANK_SETTINGS_REC : constant Settings_Rec := (
         run_id              => To_Unbounded_String(""),
         year                => Data_Constants.Data_Years'First,
         uprate_to_current   => True,
         targetting_weights  =>  (others => 1.0 / 3.0),
         split_benefit_units => False,
         save_file_name      => To_Unbounded_String(""),
         start_year          => Data_Constants.Data_Years'First, -- 0304
         end_year            => Data_Constants.Data_Years'Last, -- 0405
         inc_ctl             => BLANK_INCOMES_CONTROL_RECORD,
         scotland_only       => True
   );

   
   function Basic_Update_Run_State(
      username       : Unbounded_String;
      run_id         : Natural;
      household      : Natural;
      year           : Year_Number;
      other_counter  : Natural;
      phase          : Phase_Type;
      health         : Health_Type := normal;
      other_counter2 : Natural := 0;
      other_counter3 : Natural := 0;
      other_counter4 : Natural := 0 ) return Boolean;

end Model.Run_Settings;
