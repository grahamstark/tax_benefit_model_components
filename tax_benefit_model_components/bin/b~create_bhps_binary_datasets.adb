pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~create_bhps_binary_datasets.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~create_bhps_binary_datasets.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "system__fat_lflt_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__fat_llf_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ada__containers_E");
   E092 : Short_Integer; pragma Import (Ada, E092, "ada__io_exceptions_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "ada__numerics_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "ada__strings_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "ada__strings__maps_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "ada__strings__maps__constants_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__tags_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__streams_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "interfaces__c_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "interfaces__c__strings_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "system__regpat_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "ada__calendar_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "ada__calendar__time_zones_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "system__assertions_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "system__random_numbers_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "system__finalization_root_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__finalization_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "ada__strings__unbounded_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "system__storage_pools_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "ada__directories_E");
   E051 : Short_Integer; pragma Import (Ada, E051, "ada__finalization__heap_management_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "gnat__string_split_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "system__os_lib_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "system__pool_global_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "system__file_control_block_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "ada__streams__stream_io_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "system__direct_io_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "system__file_io_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "system__regexp_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "system__strings__stream_ops_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "ada__text_io_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "ada__text_io__editing_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "ada__text_io__generic_aux_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "base_model_types_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "bhps_enums_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "data_constants_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "conversions_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "data_index_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "numeric_io_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "set_of_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "text_utils_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "bhps_indexes_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "bhps_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "bhps__print_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "bhps__xlookup_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "bhps__binary_io_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "bhps__binary_io__conversion_to_binary_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "utils_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "format_utils_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "zip_streams_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "zip_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "zip__compress_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "zip__compress__shrink_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "zip__crc_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "zip__headers_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "zip__create_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      E266 := E266 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "zip__create__finalize_spec");
      begin
         F1;
      end;
      E254 := E254 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "zip_streams__finalize_spec");
      begin
         F2;
      end;
      E213 := E213 - 1;
      E280 := E280 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "bhps__xlookup__finalize_spec");
      begin
         F3;
      end;
      E005 := E005 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "bhps__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "bhps_indexes__finalize_spec");
      begin
         F5;
      end;
      E158 := E158 - 1;
      E131 := E131 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "text_utils__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "base_model_types__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "ada__text_io__generic_aux__finalize_body");
      begin
         E164 := E164 - 1;
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__text_io__finalize_body");
      begin
         E094 := E094 - 1;
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__text_io__finalize_spec");
      begin
         F10;
      end;
      E215 := E215 - 1;
      E228 := E228 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__regexp__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "ada__streams__stream_io__finalize_body");
      begin
         E153 := E153 - 1;
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__direct_io__finalize_body");
      begin
         E272 := E272 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "system__file_io__finalize_body");
      begin
         E099 := E099 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "system__direct_io__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "ada__streams__stream_io__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "system__file_control_block__finalize_spec");
      begin
         E109 := E109 - 1;
         F17;
      end;
      E111 := E111 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "system__pool_global__finalize_spec");
      begin
         F18;
      end;
      E051 := E051 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "ada__finalization__heap_management__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "ada__directories__finalize_spec");
      begin
         F20;
      end;
      E075 := E075 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "ada__strings__unbounded__finalize_spec");
      begin
         F21;
      end;
      E064 := E064 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "system__finalization_root__finalize_spec");
      begin
         F22;
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
      System.Fat_Lflt'Elab_Spec;
      E207 := E207 + 1;
      System.Fat_Llf'Elab_Spec;
      E167 := E167 + 1;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Containers'Elab_Spec;
      E139 := E139 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E092 := E092 + 1;
      Ada.Numerics'Elab_Spec;
      E246 := E246 + 1;
      Ada.Strings'Elab_Spec;
      E073 := E073 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E134 := E134 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E054 := E054 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E217 := E217 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E223 := E223 + 1;
      System.Assertions'Elab_Spec;
      E049 := E049 + 1;
      E234 := E234 + 1;
      E103 := E103 + 1;
      E101 := E101 + 1;
      Ada.Tags'Elab_Body;
      E056 := E056 + 1;
      E079 := E079 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      System.Random_Numbers'Elab_Body;
      E248 := E248 + 1;
      System.Finalization_Root'Elab_Spec;
      E064 := E064 + 1;
      Ada.Finalization'Elab_Spec;
      E053 := E053 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E075 := E075 + 1;
      System.Storage_Pools'Elab_Spec;
      E072 := E072 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E051 := E051 + 1;
      Gnat.String_Split'Elab_Spec;
      E274 := E274 + 1;
      System.Os_Lib'Elab_Body;
      E106 := E106 + 1;
      System.Pool_Global'Elab_Spec;
      E111 := E111 + 1;
      System.File_Control_Block'Elab_Spec;
      E109 := E109 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.Direct_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E099 := E099 + 1;
      System.Direct_Io'Elab_Body;
      E272 := E272 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E153 := E153 + 1;
      System.Regexp'Elab_Spec;
      E228 := E228 + 1;
      Ada.Directories'Elab_Body;
      E215 := E215 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E151 := E151 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E094 := E094 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E164 := E164 + 1;
      E243 := E243 + 1;
      Base_Model_Types'Elab_Spec;
      E211 := E211 + 1;
      E268 := E268 + 1;
      E240 := E240 + 1;
      E238 := E238 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E131 := E131 + 1;
      E270 := E270 + 1;
      E158 := E158 + 1;
      Bhps_Indexes'Elab_Spec;
      BHPS'ELAB_SPEC;
      E005 := E005 + 1;
      BHPS.XLOOKUP'ELAB_SPEC;
      E280 := E280 + 1;
      BHPS.BINARY_IO'ELAB_SPEC;
      E276 := E276 + 1;
      Utils'Elab_Spec;
      E230 := E230 + 1;
      E213 := E213 + 1;
      E284 := E284 + 1;
      BHPS.BINARY_IO.CONVERSION_TO_BINARY'ELAB_BODY;
      E282 := E282 + 1;
      Zip_Streams'Elab_Spec;
      E254 := E254 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E264 := E264 + 1;
      E258 := E258 + 1;
      E256 := E256 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E252 := E252 + 1;
      E250 := E250 + 1;
      Zip.Create'Elab_Spec;
      E266 := E266 + 1;
      Utils'Elab_Body;
      E245 := E245 + 1;
      BHPS.PRINT'ELAB_BODY;
      E278 := E278 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_create_bhps_binary_datasets");

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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps_enums.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/data_constants.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/set_of.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/numeric_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/data_index.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/base_model_types.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps-xlookup.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps-binary_io.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/create_bhps_binary_datasets.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/format_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps_indexes.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/conversions.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps-binary_io-conversion_to_binary.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip_streams.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-crc.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress-shrink.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-headers.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-create.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/bhps-print.o
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
