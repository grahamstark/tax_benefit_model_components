pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~za_harness.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~za_harness.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E018 : Short_Integer; pragma Import (Ada, E018, "system__soft_links_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "system__fat_flt_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "system__fat_lflt_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "system__fat_llf_E");
   E026 : Short_Integer; pragma Import (Ada, E026, "system__exception_table_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "ada__containers_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "ada__io_exceptions_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "ada__numerics_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "ada__strings_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "ada__strings__maps_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "ada__strings__maps__constants_E");
   E051 : Short_Integer; pragma Import (Ada, E051, "ada__tags_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "ada__streams_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "interfaces__c_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "interfaces__c__strings_E");
   E356 : Short_Integer; pragma Import (Ada, E356, "interfaces__fortran_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "system__regpat_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "ada__calendar_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "ada__calendar__time_zones_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "system__assertions_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "system__object_reader_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "system__dwarf_lines_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "system__random_numbers_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "system__secondary_stack_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "system__finalization_root_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "ada__finalization_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "ada__strings__unbounded_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "system__storage_pools_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "ada__directories_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "ada__finalization__heap_management_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "gnat__string_split_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "system__os_lib_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "system__pool_global_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "system__file_control_block_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "ada__streams__stream_io_E");
   E378 : Short_Integer; pragma Import (Ada, E378, "system__direct_io_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "system__file_io_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "system__regexp_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "system__strings__stream_ops_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "ada__text_io_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "ada__text_io__editing_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "ada__text_io__generic_aux_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada_containers__aunit_lists_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "aunit_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "aunit__memory_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "aunit__memory__utils_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "aunit__tests_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "aunit__test_filters_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "aunit__time_measure_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "aunit__test_results_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "aunit__assertions_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "aunit__reporter_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "aunit__reporter__text_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "aunit__simple_test_cases_E");
   E396 : Short_Integer; pragma Import (Ada, E396, "aunit__test_cases_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "aunit__test_suites_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "aunit__run_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "base_model_types_E");
   E354 : Short_Integer; pragma Import (Ada, E354, "calmar_E");
   E406 : Short_Integer; pragma Import (Ada, E406, "data_index_E");
   E366 : Short_Integer; pragma Import (Ada, E366, "inequality_generator_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "line_extractor_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "key_value_io_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "logger_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "numeric_io_E");
   E370 : Short_Integer; pragma Import (Ada, E370, "piecewise_linear_generator_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "set_of_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "t_utils_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "indirect_tax_utils_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "costs_tabulator_E");
   E386 : Short_Integer; pragma Import (Ada, E386, "poverty_tabulator_E");
   E374 : Short_Integer; pragma Import (Ada, E374, "tabulator_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "tax_utils_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "text_utils_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "time_format_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "utils_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "format_utils_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "zip_streams_E");
   E281 : Short_Integer; pragma Import (Ada, E281, "zip_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "zip__compress_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "zip__compress__shrink_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "zip__crc_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "zip__headers_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "zip__create_E");
   E339 : Short_Integer; pragma Import (Ada, E339, "coicop_definitions_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "za_E");
   E402 : Short_Integer; pragma Import (Ada, E402, "za__ies_E");
   E404 : Short_Integer; pragma Import (Ada, E404, "za__ies__raw_io_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "za__model_types_E");
   E382 : Short_Integer; pragma Import (Ada, E382, "costs_tabulator__wider_io_E");
   E388 : Short_Integer; pragma Import (Ada, E388, "poverty_tabulator__wider_io_E");
   E390 : Short_Integer; pragma Import (Ada, E390, "tabulator__wider_io_E");
   E384 : Short_Integer; pragma Import (Ada, E384, "wider_io_commons_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "za__model_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "za__model__params_E");
   E394 : Short_Integer; pragma Import (Ada, E394, "za__model__params__defaults_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "za__model__takeup_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "za__model__settings_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "za__model__data_E");
   E376 : Short_Integer; pragma Import (Ada, E376, "za__model__data__binary_io_E");
   E392 : Short_Integer; pragma Import (Ada, E392, "za__model__data__examples_E");
   E398 : Short_Integer; pragma Import (Ada, E398, "za__model__data__tests_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "za__model__results_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "za__model__calculator_E");
   E368 : Short_Integer; pragma Import (Ada, E368, "za__model__calculator__budget_constraints_E");
   E372 : Short_Integer; pragma Import (Ada, E372, "za__model__calculator__runner_E");
   E349 : Short_Integer; pragma Import (Ada, E349, "za__model__calculator__tests_E");
   E380 : Short_Integer; pragma Import (Ada, E380, "za__model__calculator__wider_output_E");
   E408 : Short_Integer; pragma Import (Ada, E408, "za__model_dataset_maker_E");
   E400 : Short_Integer; pragma Import (Ada, E400, "za__tests_E");
   E409 : Short_Integer; pragma Import (Ada, E409, "zm_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "za__tests__finalize_body");
      begin
         E400 := E400 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "za__tests__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "za__model__calculator__tests__finalize_body");
      begin
         E349 := E349 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "za__model__calculator__wider_output__finalize_body");
      begin
         E380 := E380 - 1;
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "za__model__calculator__wider_output__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "za__model__calculator__tests__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "za__model__calculator__runner__finalize_body");
      begin
         E372 := E372 - 1;
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "za__model__calculator__budget_constraints__finalize_body");
      begin
         E368 := E368 - 1;
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "za__model__calculator__budget_constraints__finalize_spec");
      begin
         F9;
      end;
      E347 := E347 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "za__model__results__finalize_spec");
      begin
         F10;
      end;
      E398 := E398 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "za__model__data__tests__finalize_spec");
      begin
         F11;
      end;
      E345 := E345 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "za__model__params__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "za__model__finalize_spec");
      begin
         E302 := E302 - 1;
         F13;
      end;
      E311 := E311 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "za__model_types__finalize_spec");
      begin
         F14;
      end;
      E404 := E404 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "za__ies__raw_io__finalize_spec");
      begin
         F15;
      end;
      E339 := E339 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "coicop_definitions__finalize_spec");
      begin
         F16;
      end;
      E297 := E297 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "zip__create__finalize_spec");
      begin
         F17;
      end;
      E285 := E285 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "zip_streams__finalize_spec");
      begin
         F18;
      end;
      E210 := E210 - 1;
      E212 := E212 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "text_utils__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "base_model_types__finalize_spec");
      begin
         F20;
      end;
      E084 := E084 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "aunit__test_suites__finalize_spec");
      begin
         F21;
      end;
      E396 := E396 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "aunit__test_cases__finalize_spec");
      begin
         F22;
      end;
      E101 := E101 - 1;
      E103 := E103 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "aunit__simple_test_cases__finalize_spec");
      begin
         F23;
      end;
      E072 := E072 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "aunit__reporter__text__finalize_spec");
      begin
         F24;
      end;
      E105 := E105 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "aunit__assertions__finalize_spec");
      begin
         F25;
      end;
      E059 := E059 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "aunit__test_results__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "aunit__test_filters__finalize_spec");
      begin
         F27;
      end;
      declare
         procedure F28;
         pragma Import (Ada, F28, "aunit__tests__finalize_spec");
      begin
         E106 := E106 - 1;
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "ada__text_io__generic_aux__finalize_body");
      begin
         E191 := E191 - 1;
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "ada__text_io__finalize_body");
      begin
         E177 := E177 - 1;
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "ada__text_io__finalize_spec");
      begin
         F31;
      end;
      E271 := E271 - 1;
      E276 := E276 - 1;
      declare
         procedure F32;
         pragma Import (Ada, F32, "system__regexp__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "ada__streams__stream_io__finalize_body");
      begin
         E235 := E235 - 1;
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "system__direct_io__finalize_body");
      begin
         E378 := E378 - 1;
         F34;
      end;
      declare
         procedure F35;
         pragma Import (Ada, F35, "system__file_io__finalize_body");
      begin
         E179 := E179 - 1;
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "system__direct_io__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "ada__streams__stream_io__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "system__file_control_block__finalize_spec");
      begin
         E185 := E185 - 1;
         F38;
      end;
      E108 := E108 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "system__pool_global__finalize_spec");
      begin
         F39;
      end;
      E086 := E086 - 1;
      declare
         procedure F40;
         pragma Import (Ada, F40, "ada__finalization__heap_management__finalize_spec");
      begin
         F40;
      end;
      declare
         procedure F41;
         pragma Import (Ada, F41, "ada__directories__finalize_spec");
      begin
         F41;
      end;
      E171 := E171 - 1;
      declare
         procedure F42;
         pragma Import (Ada, F42, "ada__strings__unbounded__finalize_spec");
      begin
         F42;
      end;
      E090 := E090 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "system__finalization_root__finalize_spec");
      begin
         F43;
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
      E307 := E307 + 1;
      System.Fat_Lflt'Elab_Spec;
      E251 := E251 + 1;
      System.Fat_Llf'Elab_Spec;
      E206 := E206 + 1;
      System.Exception_Table'Elab_Body;
      E026 := E026 + 1;
      Ada.Containers'Elab_Spec;
      E167 := E167 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E080 := E080 + 1;
      Ada.Numerics'Elab_Spec;
      E277 := E277 + 1;
      Ada.Strings'Elab_Spec;
      E125 := E125 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E215 := E215 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E049 := E049 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      Interfaces.Fortran'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E068 := E068 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E155 := E155 + 1;
      System.Assertions'Elab_Spec;
      E325 := E325 + 1;
      System.Object_Reader'Elab_Spec;
      System.Dwarf_Lines'Elab_Spec;
      E258 := E258 + 1;
      E356 := E356 + 1;
      E122 := E122 + 1;
      E120 := E120 + 1;
      Ada.Tags'Elab_Body;
      E051 := E051 + 1;
      E129 := E129 + 1;
      System.Soft_Links'Elab_Body;
      E018 := E018 + 1;
      System.Secondary_Stack'Elab_Body;
      E022 := E022 + 1;
      System.Random_Numbers'Elab_Body;
      E279 := E279 + 1;
      System.Dwarf_Lines'Elab_Body;
      E124 := E124 + 1;
      System.Object_Reader'Elab_Body;
      E145 := E145 + 1;
      System.Finalization_Root'Elab_Spec;
      E090 := E090 + 1;
      Ada.Finalization'Elab_Spec;
      E088 := E088 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E171 := E171 + 1;
      System.Storage_Pools'Elab_Spec;
      E098 := E098 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E086 := E086 + 1;
      Gnat.String_Split'Elab_Spec;
      E313 := E313 + 1;
      System.Os_Lib'Elab_Body;
      E182 := E182 + 1;
      System.Pool_Global'Elab_Spec;
      E108 := E108 + 1;
      System.File_Control_Block'Elab_Spec;
      E185 := E185 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.Direct_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E179 := E179 + 1;
      System.Direct_Io'Elab_Body;
      E378 := E378 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E235 := E235 + 1;
      System.Regexp'Elab_Spec;
      E276 := E276 + 1;
      Ada.Directories'Elab_Body;
      E271 := E271 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E233 := E233 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E177 := E177 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E191 := E191 + 1;
      E187 := E187 + 1;
      E008 := E008 + 1;
      E005 := E005 + 1;
      E061 := E061 + 1;
      E064 := E064 + 1;
      Aunit.Tests'Elab_Spec;
      E106 := E106 + 1;
      Aunit.Test_Filters'Elab_Spec;
      Aunit.Time_Measure'Elab_Spec;
      E066 := E066 + 1;
      Aunit.Test_Results'Elab_Spec;
      Aunit.Test_Results'Elab_Body;
      E059 := E059 + 1;
      Aunit.Assertions'Elab_Spec;
      Aunit.Assertions'Elab_Body;
      E105 := E105 + 1;
      Aunit.Reporter'Elab_Spec;
      E012 := E012 + 1;
      Aunit.Reporter.Text'Elab_Spec;
      Aunit.Reporter.Text'Elab_Body;
      E072 := E072 + 1;
      Aunit.Simple_Test_Cases'Elab_Spec;
      E103 := E103 + 1;
      E101 := E101 + 1;
      Aunit.Test_Cases'Elab_Spec;
      E396 := E396 + 1;
      Aunit.Test_Suites'Elab_Spec;
      E084 := E084 + 1;
      E082 := E082 + 1;
      Base_Model_Types'Elab_Spec;
      E354 := E354 + 1;
      Line_Extractor'Elab_Spec;
      E370 := E370 + 1;
      E266 := E266 + 1;
      E264 := E264 + 1;
      E327 := E327 + 1;
      E386 := E386 + 1;
      E309 := E309 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E212 := E212 + 1;
      E374 := E374 + 1;
      E363 := E363 + 1;
      E301 := E301 + 1;
      E406 := E406 + 1;
      E210 := E210 + 1;
      E306 := E306 + 1;
      E304 := E304 + 1;
      Utils'Elab_Spec;
      E255 := E255 + 1;
      E319 := E319 + 1;
      E299 := E299 + 1;
      E366 := E366 + 1;
      Zip_Streams'Elab_Spec;
      E285 := E285 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E295 := E295 + 1;
      E289 := E289 + 1;
      E287 := E287 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E283 := E283 + 1;
      E281 := E281 + 1;
      Zip.Create'Elab_Spec;
      E297 := E297 + 1;
      Utils'Elab_Body;
      E269 := E269 + 1;
      Coicop_Definitions'Elab_Spec;
      E339 := E339 + 1;
      ZA'ELAB_SPEC;
      E151 := E151 + 1;
      E402 := E402 + 1;
      ZA.IES.RAW_IO'ELAB_SPEC;
      ZA.IES.RAW_IO'ELAB_BODY;
      E404 := E404 + 1;
      ZA.MODEL_TYPES'ELAB_SPEC;
      E311 := E311 + 1;
      E384 := E384 + 1;
      E390 := E390 + 1;
      E388 := E388 + 1;
      E382 := E382 + 1;
      ZA.MODEL'ELAB_SPEC;
      E302 := E302 + 1;
      ZA.MODEL.PARAMS'ELAB_SPEC;
      E345 := E345 + 1;
      E394 := E394 + 1;
      ZA.MODEL.TAKEUP'ELAB_SPEC;
      ZA.MODEL.TAKEUP'ELAB_BODY;
      E333 := E333 + 1;
      E341 := E341 + 1;
      E337 := E337 + 1;
      ZA.MODEL.DATA.BINARY_IO'ELAB_BODY;
      E376 := E376 + 1;
      E392 := E392 + 1;
      ZA.MODEL.DATA.TESTS'ELAB_SPEC;
      E398 := E398 + 1;
      ZA.MODEL.RESULTS'ELAB_SPEC;
      ZA.MODEL.RESULTS'ELAB_BODY;
      E347 := E347 + 1;
      ZA.MODEL.CALCULATOR'ELAB_BODY;
      E321 := E321 + 1;
      ZA.MODEL.CALCULATOR.BUDGET_CONSTRAINTS'ELAB_SPEC;
      ZA.MODEL.CALCULATOR.BUDGET_CONSTRAINTS'ELAB_BODY;
      E368 := E368 + 1;
      ZA.MODEL.CALCULATOR.RUNNER'ELAB_BODY;
      E372 := E372 + 1;
      ZA.MODEL.CALCULATOR.TESTS'ELAB_SPEC;
      ZA.MODEL.CALCULATOR.WIDER_OUTPUT'ELAB_SPEC;
      ZA.MODEL.CALCULATOR.WIDER_OUTPUT'ELAB_BODY;
      E380 := E380 + 1;
      ZA.MODEL.CALCULATOR.TESTS'ELAB_BODY;
      E349 := E349 + 1;
      E408 := E408 + 1;
      ZA.TESTS'ELAB_SPEC;
      ZM'ELAB_SPEC;
      E409 := E409 + 1;
      ZA.TESTS'ELAB_BODY;
      E400 := E400 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_za_harness");

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
   --   /opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/g-trasym.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/calmar.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/piecewise_linear_generator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/set_of.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/numeric_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/indirect_tax_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tabulator_commons.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/poverty_tabulator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tax_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tabulator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/costs_tabulator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/line_extractor.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/data_index.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/base_model_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/time_format.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/logger.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/format_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/t_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/key_value_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/inequality_generator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip_streams.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-crc.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress-shrink.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-headers.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-create.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/coicop_definitions.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-ies.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-ies-raw_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/wider_io_commons.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tabulator-wider_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/poverty_tabulator-wider_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/costs_tabulator-wider_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-params.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-params-defaults.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-takeup.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-settings.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data-binary_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data-examples.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data-tests.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-results.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator-budget_constraints.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator-runner.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator-wider_output.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator-tests.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model_dataset_maker.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za_suite.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za_harness.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zm.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zm-raw.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-tests.o
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
   --   -lgnala
   --   -lgnalasup
   --   -lm
--  END Object file/option list   

end ada_main;
