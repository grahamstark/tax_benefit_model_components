pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~convert_raw_frs_to_model_data.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~convert_raw_frs_to_model_data.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E300 : Short_Integer; pragma Import (Ada, E300, "system__fat_flt_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "system__fat_lflt_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__fat_llf_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "ada__containers_E");
   E074 : Short_Integer; pragma Import (Ada, E074, "ada__io_exceptions_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "ada__numerics_E");
   E091 : Short_Integer; pragma Import (Ada, E091, "ada__strings_E");
   E095 : Short_Integer; pragma Import (Ada, E095, "ada__strings__maps_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "ada__strings__maps__constants_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "ada__tags_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__streams_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "interfaces__c_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "interfaces__c__strings_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "interfaces__fortran_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "system__regpat_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "ada__calendar_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "ada__calendar__time_zones_E");
   E288 : Short_Integer; pragma Import (Ada, E288, "system__assertions_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "system__random_numbers_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "system__finalization_root_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__finalization_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "ada__strings__unbounded_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "system__storage_pools_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "ada__directories_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__finalization__heap_management_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "gnat__string_split_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "system__os_lib_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__pool_global_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "system__file_control_block_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "ada__streams__stream_io_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "system__direct_io_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "system__file_io_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "system__regexp_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__strings__stream_ops_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__text_io_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "ada__text_io__editing_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "ada__text_io__generic_aux_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "ada_containers__aunit_lists_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "aunit_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "aunit__memory_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "aunit__memory__utils_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "aunit__tests_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "aunit__time_measure_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "aunit__test_results_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "aunit__assertions_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "base_model_types_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "data_constants_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "conversions_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "conversions__frs_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "financial_functions_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "line_extractor_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "key_value_io_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "logger_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "numeric_io_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "optimiser_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "random_normal_draw_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "maths_functions_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "raw_frs_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "frs_binary_reads_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "set_of_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "t_utils_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "tax_utils_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "text_utils_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "time_format_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "utils_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "format_utils_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "zip_streams_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "zip_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "zip__compress_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "zip__compress__shrink_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "zip__crc_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "zip__headers_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "zip__create_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "frs_enums_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "model_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "model__incomes_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "model__uprate_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "model__household_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "model__frs_to_model_mapper_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      E331 := E331 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "model__household__finalize_spec");
      begin
         F1;
      end;
      E335 := E335 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "model__incomes__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "model__finalize_spec");
      begin
         E284 := E284 - 1;
         F3;
      end;
      E323 := E323 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "frs_enums__finalize_spec");
      begin
         F4;
      end;
      E254 := E254 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "zip__create__finalize_spec");
      begin
         F5;
      end;
      E242 := E242 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "zip_streams__finalize_spec");
      begin
         F6;
      end;
      E260 := E260 - 1;
      E090 := E090 - 1;
      E109 := E109 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "text_utils__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "conversions__frs__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "base_model_types__finalize_spec");
      begin
         F9;
      end;
      E270 := E270 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "aunit__assertions__finalize_spec");
      begin
         F10;
      end;
      E277 := E277 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "aunit__test_results__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "aunit__tests__finalize_spec");
      begin
         E280 := E280 - 1;
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__text_io__generic_aux__finalize_body");
      begin
         E152 := E152 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__text_io__finalize_body");
      begin
         E053 := E053 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "ada__text_io__finalize_spec");
      begin
         F15;
      end;
      E205 := E205 - 1;
      E214 := E214 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "system__regexp__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "ada__streams__stream_io__finalize_body");
      begin
         E143 := E143 - 1;
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "system__direct_io__finalize_body");
      begin
         E262 := E262 - 1;
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "system__file_io__finalize_body");
      begin
         E073 := E073 - 1;
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "system__direct_io__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "ada__streams__stream_io__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "system__file_control_block__finalize_spec");
      begin
         E084 := E084 - 1;
         F22;
      end;
      E086 := E086 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "system__pool_global__finalize_spec");
      begin
         F23;
      end;
      E055 := E055 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "ada__finalization__heap_management__finalize_spec");
      begin
         F24;
      end;
      declare
         procedure F25;
         pragma Import (Ada, F25, "ada__directories__finalize_spec");
      begin
         F25;
      end;
      E120 := E120 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "ada__strings__unbounded__finalize_spec");
      begin
         F26;
      end;
      E060 := E060 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "system__finalization_root__finalize_spec");
      begin
         F27;
      end;
      if LE_Set then
         declare
            LE : Ada.Exceptions.Exception_Occurrence;
            pragma Import (Ada, LE, "__gnat_library_exception");
            procedure Raise_From_Controlled_Operation (X : Ada.Exceptions.Exception_Occurrence;  From_Abort : Boolean);
            pragma Import (Ada, Raise_From_Controlled_Operation, "__gnat_raise_from_controlled_operation");
         begin
            Raise_From_Controlled_Operation (LE, False);
         end;
      end if;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Exception_Tracebacks : Integer;
      pragma Import (C, Exception_Tracebacks, "__gl_exception_tracebacks");
      Zero_Cost_Exceptions : Integer;
      pragma Import (C, Zero_Cost_Exceptions, "__gl_zero_cost_exceptions");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Exception_Tracebacks := 1;
      Zero_Cost_Exceptions := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Fat_Flt'Elab_Spec;
      E300 := E300 + 1;
      System.Fat_Lflt'Elab_Spec;
      E195 := E195 + 1;
      System.Fat_Llf'Elab_Spec;
      E155 := E155 + 1;
      System.Exception_Table'Elab_Body;
      E021 := E021 + 1;
      Ada.Containers'Elab_Spec;
      E117 := E117 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E074 := E074 + 1;
      Ada.Numerics'Elab_Spec;
      E234 := E234 + 1;
      Ada.Strings'Elab_Spec;
      E091 := E091 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E112 := E112 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      Interfaces.Fortran'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E201 := E201 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E209 := E209 + 1;
      System.Assertions'Elab_Spec;
      E288 := E288 + 1;
      E222 := E222 + 1;
      E299 := E299 + 1;
      E078 := E078 + 1;
      E076 := E076 + 1;
      Ada.Tags'Elab_Body;
      E045 := E045 + 1;
      E095 := E095 + 1;
      System.Soft_Links'Elab_Body;
      E011 := E011 + 1;
      System.Secondary_Stack'Elab_Body;
      E015 := E015 + 1;
      System.Random_Numbers'Elab_Body;
      E236 := E236 + 1;
      System.Finalization_Root'Elab_Spec;
      E060 := E060 + 1;
      Ada.Finalization'Elab_Spec;
      E057 := E057 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E120 := E120 + 1;
      System.Storage_Pools'Elab_Spec;
      E068 := E068 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E055 := E055 + 1;
      Gnat.String_Split'Elab_Spec;
      E258 := E258 + 1;
      System.Os_Lib'Elab_Body;
      E081 := E081 + 1;
      System.Pool_Global'Elab_Spec;
      E086 := E086 + 1;
      System.File_Control_Block'Elab_Spec;
      E084 := E084 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.Direct_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E073 := E073 + 1;
      System.Direct_Io'Elab_Body;
      E262 := E262 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E143 := E143 + 1;
      System.Regexp'Elab_Spec;
      E214 := E214 + 1;
      Ada.Directories'Elab_Body;
      E205 := E205 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E141 := E141 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E053 := E053 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E152 := E152 + 1;
      E216 := E216 + 1;
      E268 := E268 + 1;
      E266 := E266 + 1;
      E275 := E275 + 1;
      E273 := E273 + 1;
      Aunit.Tests'Elab_Spec;
      E280 := E280 + 1;
      Aunit.Time_Measure'Elab_Spec;
      E279 := E279 + 1;
      Aunit.Test_Results'Elab_Spec;
      Aunit.Test_Results'Elab_Body;
      E277 := E277 + 1;
      Aunit.Assertions'Elab_Spec;
      Aunit.Assertions'Elab_Body;
      E270 := E270 + 1;
      Base_Model_Types'Elab_Spec;
      E256 := E256 + 1;
      Conversions.Frs'Elab_Spec;
      Line_Extractor'Elab_Spec;
      E297 := E297 + 1;
      E295 := E295 + 1;
      E315 := E315 + 1;
      raw_frs'elab_spec;
      Frs_Binary_Reads'Elab_Spec;
      E264 := E264 + 1;
      E230 := E230 + 1;
      E228 := E228 + 1;
      E319 := E319 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E109 := E109 + 1;
      E313 := E313 + 1;
      E307 := E307 + 1;
      E090 := E090 + 1;
      E311 := E311 + 1;
      E309 := E309 + 1;
      Utils'Elab_Spec;
      E218 := E218 + 1;
      E329 := E329 + 1;
      E305 := E305 + 1;
      E260 := E260 + 1;
      E199 := E199 + 1;
      Zip_Streams'Elab_Spec;
      E242 := E242 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E252 := E252 + 1;
      E246 := E246 + 1;
      E244 := E244 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E240 := E240 + 1;
      E238 := E238 + 1;
      Zip.Create'Elab_Spec;
      E254 := E254 + 1;
      Utils'Elab_Body;
      E233 := E233 + 1;
      Raw_Frs'Elab_Body;
      E283 := E283 + 1;
      Frs_Enums'Elab_Spec;
      E323 := E323 + 1;
      Model'Elab_Spec;
      E284 := E284 + 1;
      Model.Incomes'Elab_Spec;
      E335 := E335 + 1;
      Model.Uprate'Elab_Spec;
      Model.Uprate'Elab_Body;
      E333 := E333 + 1;
      Model.Household'Elab_Spec;
      E331 := E331 + 1;
      Model.Frs_To_Model_Mapper'Elab_Body;
      E321 := E321 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_convert_raw_frs_to_model_data");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/data_constants.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/optimiser.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/financial_functions.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/random_normal_draw.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/frs_binary_reads.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/set_of.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/numeric_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tax_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/maths_functions.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/line_extractor.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/base_model_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/time_format.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/logger.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/format_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/t_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/key_value_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/conversions-frs.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/conversions.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip_streams.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-crc.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress-shrink.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-headers.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-create.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/raw_frs.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/frs_enums.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-incomes.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-uprate.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-household.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-frs_to_model_mapper.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/convert_raw_frs_to_model_data.o
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
   --   -lgnala
   --   -lgnalasup
   --   -lm
--  END Object file/option list   

end ada_main;
