pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~create_model_datasets.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~create_model_datasets.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "system__fat_flt_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "system__fat_lflt_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__fat_llf_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__containers_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "ada__io_exceptions_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "ada__numerics_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "ada__strings_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "ada__strings__maps_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "ada__strings__maps__constants_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "ada__tags_E");
   E092 : Short_Integer; pragma Import (Ada, E092, "ada__streams_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "interfaces__c_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "interfaces__c__strings_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "system__regpat_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__calendar_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "ada__calendar__time_zones_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "system__assertions_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "system__random_numbers_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "system__finalization_root_E");
   E091 : Short_Integer; pragma Import (Ada, E091, "ada__finalization_E");
   E085 : Short_Integer; pragma Import (Ada, E085, "ada__strings__unbounded_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "system__storage_pools_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "ada__directories_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__finalization__heap_management_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "gnat__string_split_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "system__os_lib_E");
   E130 : Short_Integer; pragma Import (Ada, E130, "system__pool_global_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "system__file_control_block_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "ada__streams__stream_io_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "system__direct_io_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__file_io_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "system__regexp_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "system__strings__stream_ops_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__text_io_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "ada__text_io__editing_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__text_io__generic_aux_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "base_model_types_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "data_index_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "line_extractor_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "key_value_io_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "logger_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "numeric_io_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "set_of_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "t_utils_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "tax_utils_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "text_utils_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "time_format_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "utils_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "format_utils_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "zip_streams_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "zip_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "zip__compress_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "zip__compress__shrink_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "zip__crc_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "zip__headers_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "zip__create_E");
   E261 : Short_Integer; pragma Import (Ada, E261, "coicop_definitions_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "za_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "za__ies_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "za__ies__raw_io_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "za__model_types_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "za__model_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "za__model__takeup_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "za__model__settings_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "za__model__data_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "za__model__data__binary_io_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "za__model_dataset_maker_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "za__model__finalize_spec");
      begin
         E278 := E278 - 1;
         F1;
      end;
      E285 := E285 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "za__model_types__finalize_spec");
      begin
         F2;
      end;
      E273 := E273 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "za__ies__raw_io__finalize_spec");
      begin
         F3;
      end;
      E261 := E261 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "coicop_definitions__finalize_spec");
      begin
         F4;
      end;
      E253 := E253 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "zip__create__finalize_spec");
      begin
         F5;
      end;
      E241 := E241 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "zip_streams__finalize_spec");
      begin
         F6;
      end;
      E161 := E161 - 1;
      E167 := E167 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "text_utils__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "base_model_types__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__text_io__generic_aux__finalize_body");
      begin
         E138 := E138 - 1;
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__text_io__finalize_body");
      begin
         E103 := E103 - 1;
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "ada__text_io__finalize_spec");
      begin
         F11;
      end;
      E227 := E227 - 1;
      E232 := E232 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__regexp__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__streams__stream_io__finalize_body");
      begin
         E190 := E190 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "system__direct_io__finalize_body");
      begin
         E275 := E275 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__file_io__finalize_body");
      begin
         E118 := E118 - 1;
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "system__direct_io__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "ada__streams__stream_io__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "system__file_control_block__finalize_spec");
      begin
         E128 := E128 - 1;
         F18;
      end;
      E130 := E130 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "system__pool_global__finalize_spec");
      begin
         F19;
      end;
      E105 := E105 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "ada__finalization__heap_management__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "ada__directories__finalize_spec");
      begin
         F21;
      end;
      E085 := E085 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "ada__strings__unbounded__finalize_spec");
      begin
         F22;
      end;
      E094 := E094 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "system__finalization_root__finalize_spec");
      begin
         F23;
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
      E283 := E283 + 1;
      System.Fat_Lflt'Elab_Spec;
      E206 := E206 + 1;
      System.Fat_Llf'Elab_Spec;
      E155 := E155 + 1;
      System.Exception_Table'Elab_Body;
      E021 := E021 + 1;
      Ada.Containers'Elab_Spec;
      E072 := E072 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E099 := E099 + 1;
      Ada.Numerics'Elab_Spec;
      E233 := E233 + 1;
      Ada.Strings'Elab_Spec;
      E073 := E073 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E170 := E170 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E092 := E092 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E054 := E054 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E060 := E060 + 1;
      System.Assertions'Elab_Spec;
      E303 := E303 + 1;
      E214 := E214 + 1;
      E122 := E122 + 1;
      E120 := E120 + 1;
      Ada.Tags'Elab_Body;
      E045 := E045 + 1;
      E077 := E077 + 1;
      System.Soft_Links'Elab_Body;
      E011 := E011 + 1;
      System.Secondary_Stack'Elab_Body;
      E015 := E015 + 1;
      System.Random_Numbers'Elab_Body;
      E235 := E235 + 1;
      System.Finalization_Root'Elab_Spec;
      E094 := E094 + 1;
      Ada.Finalization'Elab_Spec;
      E091 := E091 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E085 := E085 + 1;
      System.Storage_Pools'Elab_Spec;
      E113 := E113 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E105 := E105 + 1;
      Gnat.String_Split'Elab_Spec;
      E263 := E263 + 1;
      System.Os_Lib'Elab_Body;
      E125 := E125 + 1;
      System.Pool_Global'Elab_Spec;
      E130 := E130 + 1;
      System.File_Control_Block'Elab_Spec;
      E128 := E128 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.Direct_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E118 := E118 + 1;
      System.Direct_Io'Elab_Body;
      E275 := E275 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E190 := E190 + 1;
      System.Regexp'Elab_Spec;
      E232 := E232 + 1;
      Ada.Directories'Elab_Body;
      E227 := E227 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E188 := E188 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E103 := E103 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E138 := E138 + 1;
      E134 := E134 + 1;
      Base_Model_Types'Elab_Spec;
      Line_Extractor'Elab_Spec;
      E222 := E222 + 1;
      E220 := E220 + 1;
      E271 := E271 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E167 := E167 + 1;
      E257 := E257 + 1;
      E277 := E277 + 1;
      E161 := E161 + 1;
      E282 := E282 + 1;
      E280 := E280 + 1;
      Utils'Elab_Spec;
      E210 := E210 + 1;
      E269 := E269 + 1;
      E255 := E255 + 1;
      Zip_Streams'Elab_Spec;
      E241 := E241 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E251 := E251 + 1;
      E245 := E245 + 1;
      E243 := E243 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E239 := E239 + 1;
      E237 := E237 + 1;
      Zip.Create'Elab_Spec;
      E253 := E253 + 1;
      Utils'Elab_Body;
      E225 := E225 + 1;
      Coicop_Definitions'Elab_Spec;
      E261 := E261 + 1;
      ZA'ELAB_SPEC;
      E052 := E052 + 1;
      E259 := E259 + 1;
      ZA.IES.RAW_IO'ELAB_SPEC;
      ZA.IES.RAW_IO'ELAB_BODY;
      E273 := E273 + 1;
      ZA.MODEL_TYPES'ELAB_SPEC;
      E285 := E285 + 1;
      ZA.MODEL'ELAB_SPEC;
      E278 := E278 + 1;
      ZA.MODEL.TAKEUP'ELAB_SPEC;
      ZA.MODEL.TAKEUP'ELAB_BODY;
      E293 := E293 + 1;
      E289 := E289 + 1;
      E287 := E287 + 1;
      ZA.MODEL.DATA.BINARY_IO'ELAB_BODY;
      E297 := E297 + 1;
      E299 := E299 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_create_model_datasets");

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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/tax_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/line_extractor.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/data_index.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/base_model_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/time_format.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/logger.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/format_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/t_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/key_value_io.o
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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-takeup.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-settings.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model-data-binary_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/za-model_dataset_maker.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/create_model_datasets.o
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
