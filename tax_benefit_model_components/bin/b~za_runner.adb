pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~za_runner.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~za_runner.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E267 : Short_Integer; pragma Import (Ada, E267, "system__fat_flt_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "system__fat_lflt_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "system__fat_llf_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exception_table_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "ada__containers_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "ada__io_exceptions_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "ada__numerics_E");
   E046 : Short_Integer; pragma Import (Ada, E046, "ada__strings_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings__maps_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "ada__strings__maps__constants_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__tags_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "ada__streams_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "interfaces__c_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "interfaces__c__strings_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "system__regpat_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "ada__calendar_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "ada__calendar__time_zones_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "system__assertions_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "system__random_numbers_E");
   E009 : Short_Integer; pragma Import (Ada, E009, "system__secondary_stack_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "system__finalization_root_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "ada__finalization_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__strings__unbounded_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "system__storage_pools_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "ada__directories_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "ada__finalization__heap_management_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "gnat__string_split_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__os_lib_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "system__pool_global_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "system__file_control_block_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "ada__streams__stream_io_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "system__direct_io_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "system__file_io_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "system__regexp_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "system__strings__stream_ops_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__text_io_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__text_io__editing_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "ada__text_io__generic_aux_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "base_model_types_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "inequality_generator_E");
   E261 : Short_Integer; pragma Import (Ada, E261, "line_extractor_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "key_value_io_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "logger_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "numeric_io_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "set_of_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "t_utils_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "indirect_tax_utils_E");
   E312 : Short_Integer; pragma Import (Ada, E312, "costs_tabulator_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "poverty_tabulator_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "tabulator_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "tax_utils_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "text_utils_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "time_format_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "utils_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "format_utils_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "zip_streams_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "zip_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "zip__compress_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "zip__compress__shrink_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "zip__crc_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "zip__headers_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "zip__create_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "coicop_definitions_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "za_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "za__model_types_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "costs_tabulator__wider_io_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "poverty_tabulator__wider_io_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "tabulator__wider_io_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "wider_io_commons_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "za__model_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "za__model__params_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "za__model__params__defaults_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "za__model__params__wider_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "za__model__takeup_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "za__model__settings_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "za__model__data_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "za__model__data__binary_io_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "za__model__results_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "za__model__calculator_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "za__model__calculator__wider_output_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "za__model__calculator__wider_runner_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "za__model__calculator__wider_output__finalize_body");
      begin
         E307 := E307 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "za__model__calculator__wider_output__finalize_spec");
      begin
         F2;
      end;
      E303 := E303 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "za__model__results__finalize_spec");
      begin
         F3;
      end;
      E301 := E301 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "za__model__params__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "za__model__finalize_spec");
      begin
         E262 := E262 - 1;
         F5;
      end;
      E271 := E271 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "za__model_types__finalize_spec");
      begin
         F6;
      end;
      E297 := E297 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "coicop_definitions__finalize_spec");
      begin
         F7;
      end;
      E257 := E257 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "zip__create__finalize_spec");
      begin
         F8;
      end;
      E245 := E245 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "zip_streams__finalize_spec");
      begin
         F9;
      end;
      E165 := E165 - 1;
      E171 := E171 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "text_utils__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "base_model_types__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "ada__text_io__generic_aux__finalize_body");
      begin
         E142 := E142 - 1;
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__text_io__finalize_body");
      begin
         E107 := E107 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__text_io__finalize_spec");
      begin
         F14;
      end;
      E231 := E231 - 1;
      E236 := E236 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__regexp__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "ada__streams__stream_io__finalize_body");
      begin
         E194 := E194 - 1;
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "system__direct_io__finalize_body");
      begin
         E331 := E331 - 1;
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "system__file_io__finalize_body");
      begin
         E122 := E122 - 1;
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "system__direct_io__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "ada__streams__stream_io__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "system__file_control_block__finalize_spec");
      begin
         E132 := E132 - 1;
         F21;
      end;
      E134 := E134 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "system__pool_global__finalize_spec");
      begin
         F22;
      end;
      E109 := E109 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "ada__finalization__heap_management__finalize_spec");
      begin
         F23;
      end;
      declare
         procedure F24;
         pragma Import (Ada, F24, "ada__directories__finalize_spec");
      begin
         F24;
      end;
      E048 := E048 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "ada__strings__unbounded__finalize_spec");
      begin
         F25;
      end;
      E073 := E073 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "system__finalization_root__finalize_spec");
      begin
         F26;
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
      E267 := E267 + 1;
      System.Fat_Lflt'Elab_Spec;
      E210 := E210 + 1;
      System.Fat_Llf'Elab_Spec;
      E159 := E159 + 1;
      System.Exception_Table'Elab_Body;
      E019 := E019 + 1;
      Ada.Containers'Elab_Spec;
      E101 := E101 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E078 := E078 + 1;
      Ada.Numerics'Elab_Spec;
      E237 := E237 + 1;
      Ada.Strings'Elab_Spec;
      E046 := E046 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E174 := E174 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E071 := E071 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E083 := E083 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E089 := E089 + 1;
      System.Assertions'Elab_Spec;
      E283 := E283 + 1;
      E218 := E218 + 1;
      E126 := E126 + 1;
      E124 := E124 + 1;
      Ada.Tags'Elab_Body;
      E058 := E058 + 1;
      E052 := E052 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Secondary_Stack'Elab_Body;
      E009 := E009 + 1;
      System.Random_Numbers'Elab_Body;
      E239 := E239 + 1;
      System.Finalization_Root'Elab_Spec;
      E073 := E073 + 1;
      Ada.Finalization'Elab_Spec;
      E070 := E070 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E048 := E048 + 1;
      System.Storage_Pools'Elab_Spec;
      E117 := E117 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E109 := E109 + 1;
      Gnat.String_Split'Elab_Spec;
      E273 := E273 + 1;
      System.Os_Lib'Elab_Body;
      E129 := E129 + 1;
      System.Pool_Global'Elab_Spec;
      E134 := E134 + 1;
      System.File_Control_Block'Elab_Spec;
      E132 := E132 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.Direct_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E122 := E122 + 1;
      System.Direct_Io'Elab_Body;
      E331 := E331 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E194 := E194 + 1;
      System.Regexp'Elab_Spec;
      E236 := E236 + 1;
      Ada.Directories'Elab_Body;
      E231 := E231 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E192 := E192 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E107 := E107 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E142 := E142 + 1;
      E138 := E138 + 1;
      Base_Model_Types'Elab_Spec;
      Line_Extractor'Elab_Spec;
      E226 := E226 + 1;
      E224 := E224 + 1;
      E285 := E285 + 1;
      E321 := E321 + 1;
      E269 := E269 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E171 := E171 + 1;
      E325 := E325 + 1;
      E312 := E312 + 1;
      E261 := E261 + 1;
      E165 := E165 + 1;
      E266 := E266 + 1;
      E264 := E264 + 1;
      Utils'Elab_Spec;
      E214 := E214 + 1;
      E277 := E277 + 1;
      E259 := E259 + 1;
      E319 := E319 + 1;
      Zip_Streams'Elab_Spec;
      E245 := E245 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E255 := E255 + 1;
      E249 := E249 + 1;
      E247 := E247 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E243 := E243 + 1;
      E241 := E241 + 1;
      Zip.Create'Elab_Spec;
      E257 := E257 + 1;
      Utils'Elab_Body;
      E229 := E229 + 1;
      Coicop_Definitions'Elab_Spec;
      E297 := E297 + 1;
      ZA'ELAB_SPEC;
      E081 := E081 + 1;
      ZA.MODEL_TYPES'ELAB_SPEC;
      E271 := E271 + 1;
      E317 := E317 + 1;
      E327 := E327 + 1;
      E323 := E323 + 1;
      E315 := E315 + 1;
      ZA.MODEL'ELAB_SPEC;
      E262 := E262 + 1;
      ZA.MODEL.PARAMS'ELAB_SPEC;
      E301 := E301 + 1;
      E333 := E333 + 1;
      E335 := E335 + 1;
      ZA.MODEL.TAKEUP'ELAB_SPEC;
      ZA.MODEL.TAKEUP'ELAB_BODY;
      E291 := E291 + 1;
      E299 := E299 + 1;
      E295 := E295 + 1;
      ZA.MODEL.DATA.BINARY_IO'ELAB_BODY;
      E329 := E329 + 1;
      ZA.MODEL.RESULTS'ELAB_SPEC;
      ZA.MODEL.RESULTS'ELAB_BODY;
      E303 := E303 + 1;
      ZA.MODEL.CALCULATOR'ELAB_BODY;
      E279 := E279 + 1;
      ZA.MODEL.CALCULATOR.WIDER_OUTPUT'ELAB_SPEC;
      ZA.MODEL.CALCULATOR.WIDER_OUTPUT'ELAB_BODY;
      E307 := E307 + 1;
      E305 := E305 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_za_runner");

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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/wider_io_commons.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tabulator-wider_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/poverty_tabulator-wider_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/costs_tabulator-wider_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-params.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-params-defaults.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-params-wider.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-takeup.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-settings.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data-binary_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-results.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator-wider_output.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-calculator-wider_runner.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za_runner.o
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
