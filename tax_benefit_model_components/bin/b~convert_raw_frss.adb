pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~convert_raw_frss.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~convert_raw_frss.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "system__fat_flt_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "system__fat_lflt_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "system__fat_llf_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__containers_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "ada__io_exceptions_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "ada__numerics_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "ada__strings_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "ada__strings__maps_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "ada__strings__maps__constants_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "ada__tags_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "ada__streams_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "interfaces__c_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "interfaces__c__strings_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "interfaces__fortran_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "system__regpat_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__calendar__time_zones_E");
   E294 : Short_Integer; pragma Import (Ada, E294, "system__assertions_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "system__random_numbers_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "system__finalization_root_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "ada__finalization_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "ada__strings__unbounded_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "system__storage_pools_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__directories_E");
   E085 : Short_Integer; pragma Import (Ada, E085, "ada__finalization__heap_management_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "gnat__string_split_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__os_lib_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "system__pool_global_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "system__file_control_block_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "ada__streams__stream_io_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "system__direct_io_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "system__file_io_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__regexp_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "system__strings__stream_ops_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "ada__text_io_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "ada__text_io__editing_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "ada__text_io__generic_aux_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "ada_containers__aunit_lists_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "aunit_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "aunit__memory_E");
   E281 : Short_Integer; pragma Import (Ada, E281, "aunit__memory__utils_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "aunit__tests_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "aunit__time_measure_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "aunit__test_results_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "aunit__assertions_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "base_model_types_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "data_constants_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "conversions_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "conversions__frs_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "financial_functions_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "line_extractor_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "key_value_io_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "logger_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "numeric_io_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "optimiser_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "random_normal_draw_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "maths_functions_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "raw_conversions_library_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "raw_frs_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "frs_binary_reads_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "set_of_E");
   E339 : Short_Integer; pragma Import (Ada, E339, "t_utils_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "tax_utils_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "text_utils_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "time_format_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "utils_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "format_utils_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "zip_streams_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "zip_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "zip__compress_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "zip__compress__shrink_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "zip__crc_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "zip__headers_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "zip__create_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "frs_enums_E");
   E290 : Short_Integer; pragma Import (Ada, E290, "model_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "model__incomes_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "model__uprate_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "model__household_E");
   E343 : Short_Integer; pragma Import (Ada, E343, "model__income_measure_types_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "model__parameters_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "model__parameters__legal_aid_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "model__run_settings_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      E343 := E343 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "model__income_measure_types__finalize_spec");
      begin
         F1;
      end;
      E331 := E331 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "model__household__finalize_spec");
      begin
         F2;
      end;
      E341 := E341 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "model__incomes__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "model__finalize_spec");
      begin
         E290 := E290 - 1;
         F4;
      end;
      E335 := E335 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "frs_enums__finalize_spec");
      begin
         F5;
      end;
      E256 := E256 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "zip__create__finalize_spec");
      begin
         F6;
      end;
      E244 := E244 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "zip_streams__finalize_spec");
      begin
         F7;
      end;
      E262 := E262 - 1;
      E146 := E146 - 1;
      E152 := E152 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "text_utils__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "conversions__frs__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "base_model_types__finalize_spec");
      begin
         F10;
      end;
      E276 := E276 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "aunit__assertions__finalize_spec");
      begin
         F11;
      end;
      E283 := E283 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "aunit__test_results__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "aunit__tests__finalize_spec");
      begin
         E286 := E286 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__text_io__generic_aux__finalize_body");
      begin
         E180 := E180 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "ada__text_io__finalize_body");
      begin
         E143 := E143 - 1;
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "ada__text_io__finalize_spec");
      begin
         F16;
      end;
      E052 := E052 - 1;
      E139 := E139 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "system__regexp__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "ada__streams__stream_io__finalize_body");
      begin
         E171 := E171 - 1;
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "system__direct_io__finalize_body");
      begin
         E264 := E264 - 1;
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "system__file_io__finalize_body");
      begin
         E120 := E120 - 1;
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "system__direct_io__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "ada__streams__stream_io__finalize_spec");
      begin
         F22;
      end;
      declare
         procedure F23;
         pragma Import (Ada, F23, "system__file_control_block__finalize_spec");
      begin
         E132 := E132 - 1;
         F23;
      end;
      E134 := E134 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "system__pool_global__finalize_spec");
      begin
         F24;
      end;
      E085 := E085 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "ada__finalization__heap_management__finalize_spec");
      begin
         F25;
      end;
      declare
         procedure F26;
         pragma Import (Ada, F26, "ada__directories__finalize_spec");
      begin
         F26;
      end;
      E108 := E108 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "ada__strings__unbounded__finalize_spec");
      begin
         F27;
      end;
      E094 := E094 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "system__finalization_root__finalize_spec");
      begin
         F28;
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
      E302 := E302 + 1;
      System.Fat_Lflt'Elab_Spec;
      E212 := E212 + 1;
      System.Fat_Llf'Elab_Spec;
      E183 := E183 + 1;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Containers'Elab_Spec;
      E050 := E050 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E117 := E117 + 1;
      Ada.Numerics'Elab_Spec;
      E236 := E236 + 1;
      Ada.Strings'Elab_Spec;
      E076 := E076 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E081 := E081 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E088 := E088 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      Interfaces.Fortran'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E056 := E056 + 1;
      System.Assertions'Elab_Spec;
      E294 := E294 + 1;
      E224 := E224 + 1;
      E301 := E301 + 1;
      E124 := E124 + 1;
      E122 := E122 + 1;
      Ada.Tags'Elab_Body;
      E090 := E090 + 1;
      E078 := E078 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      System.Random_Numbers'Elab_Body;
      E238 := E238 + 1;
      System.Finalization_Root'Elab_Spec;
      E094 := E094 + 1;
      Ada.Finalization'Elab_Spec;
      E087 := E087 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E108 := E108 + 1;
      System.Storage_Pools'Elab_Spec;
      E102 := E102 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E085 := E085 + 1;
      Gnat.String_Split'Elab_Spec;
      E260 := E260 + 1;
      System.Os_Lib'Elab_Body;
      E129 := E129 + 1;
      System.Pool_Global'Elab_Spec;
      E134 := E134 + 1;
      System.File_Control_Block'Elab_Spec;
      E132 := E132 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.Direct_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E120 := E120 + 1;
      System.Direct_Io'Elab_Body;
      E264 := E264 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E171 := E171 + 1;
      System.Regexp'Elab_Spec;
      E139 := E139 + 1;
      Ada.Directories'Elab_Body;
      E052 := E052 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E169 := E169 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E143 := E143 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E180 := E180 + 1;
      E218 := E218 + 1;
      E274 := E274 + 1;
      E272 := E272 + 1;
      E281 := E281 + 1;
      E279 := E279 + 1;
      Aunit.Tests'Elab_Spec;
      E286 := E286 + 1;
      Aunit.Time_Measure'Elab_Spec;
      E285 := E285 + 1;
      Aunit.Test_Results'Elab_Spec;
      Aunit.Test_Results'Elab_Body;
      E283 := E283 + 1;
      Aunit.Assertions'Elab_Spec;
      Aunit.Assertions'Elab_Body;
      E276 := E276 + 1;
      Base_Model_Types'Elab_Spec;
      E258 := E258 + 1;
      Conversions.Frs'Elab_Spec;
      Line_Extractor'Elab_Spec;
      E268 := E268 + 1;
      E266 := E266 + 1;
      E317 := E317 + 1;
      raw_frs'elab_spec;
      Frs_Binary_Reads'Elab_Spec;
      E270 := E270 + 1;
      E232 := E232 + 1;
      E230 := E230 + 1;
      E321 := E321 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E152 := E152 + 1;
      E315 := E315 + 1;
      E309 := E309 + 1;
      E146 := E146 + 1;
      E313 := E313 + 1;
      E311 := E311 + 1;
      Utils'Elab_Spec;
      E220 := E220 + 1;
      E339 := E339 + 1;
      E307 := E307 + 1;
      E262 := E262 + 1;
      E216 := E216 + 1;
      Zip_Streams'Elab_Spec;
      E244 := E244 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E254 := E254 + 1;
      E248 := E248 + 1;
      E246 := E246 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E242 := E242 + 1;
      E240 := E240 + 1;
      Zip.Create'Elab_Spec;
      E256 := E256 + 1;
      Utils'Elab_Body;
      E235 := E235 + 1;
      Raw_Frs'Elab_Body;
      E289 := E289 + 1;
      Frs_Enums'Elab_Spec;
      E335 := E335 + 1;
      Model'Elab_Spec;
      E290 := E290 + 1;
      Model.Incomes'Elab_Spec;
      E341 := E341 + 1;
      Model.Uprate'Elab_Spec;
      Model.Uprate'Elab_Body;
      E333 := E333 + 1;
      Model.Household'Elab_Spec;
      E331 := E331 + 1;
      Model.Income_Measure_Types'Elab_Spec;
      E343 := E343 + 1;
      E345 := E345 + 1;
      Model.Parameters.Legal_Aid'Elab_Body;
      E347 := E347 + 1;
      Model.Run_Settings'Elab_Spec;
      Model.Run_Settings'Elab_Body;
      E323 := E323 + 1;
      E005 := E005 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_convert_raw_frss");

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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/convert_raw_frss.o
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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-income_measure_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-parameters.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-parameters-legal_aid.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/model-run_settings.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/raw_conversions_library.o
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
