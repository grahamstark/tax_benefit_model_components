pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~create_inequality_statistics.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~create_inequality_statistics.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "system__fat_lflt_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "system__fat_llf_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__containers_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "ada__io_exceptions_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "ada__numerics_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "ada__strings_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "ada__strings__maps_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "ada__strings__maps__constants_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__tags_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__streams_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "interfaces__c_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "interfaces__c__strings_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "system__regpat_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "ada__calendar_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "ada__calendar__time_zones_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__assertions_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "system__random_numbers_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "system__finalization_root_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__finalization_E");
   E085 : Short_Integer; pragma Import (Ada, E085, "ada__strings__unbounded_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "system__storage_pools_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "ada__directories_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "ada__finalization__heap_management_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "gnat__string_split_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__os_lib_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "system__pool_global_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "system__file_control_block_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "ada__streams__stream_io_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "system__file_io_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "system__regexp_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "system__strings__stream_ops_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "ada__text_io_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "ada__text_io__editing_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "ada__text_io__generic_aux_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "inequality_generator_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "inequality_generator__utils_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "numeric_io_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "set_of_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "text_utils_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "utils_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "format_utils_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "zip_streams_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "zip_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "zip__compress_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "zip__compress__shrink_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "zip__crc_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "zip__headers_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "zip__create_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      E243 := E243 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "zip__create__finalize_spec");
      begin
         F1;
      end;
      E231 := E231 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "zip_streams__finalize_spec");
      begin
         F2;
      end;
      E185 := E185 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "text_utils__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ada__text_io__generic_aux__finalize_body");
      begin
         E131 := E131 - 1;
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__text_io__finalize_body");
      begin
         E096 := E096 - 1;
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ada__text_io__finalize_spec");
      begin
         F6;
      end;
      E218 := E218 - 1;
      E223 := E223 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__regexp__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "ada__streams__stream_io__finalize_body");
      begin
         E208 := E208 - 1;
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__file_io__finalize_body");
      begin
         E111 := E111 - 1;
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__streams__stream_io__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "system__file_control_block__finalize_spec");
      begin
         E121 := E121 - 1;
         F11;
      end;
      E123 := E123 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "system__pool_global__finalize_spec");
      begin
         F12;
      end;
      E098 := E098 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__finalization__heap_management__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ada__directories__finalize_spec");
      begin
         F14;
      end;
      E085 := E085 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "ada__strings__unbounded__finalize_spec");
      begin
         F15;
      end;
      E069 := E069 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "system__finalization_root__finalize_spec");
      begin
         F16;
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
      E250 := E250 + 1;
      System.Fat_Llf'Elab_Spec;
      E073 := E073 + 1;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Containers'Elab_Spec;
      E056 := E056 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E094 := E094 + 1;
      Ada.Numerics'Elab_Spec;
      E070 := E070 + 1;
      Ada.Strings'Elab_Spec;
      E075 := E075 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E174 := E174 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E059 := E059 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Regpat'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E049 := E049 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E216 := E216 + 1;
      System.Assertions'Elab_Spec;
      E047 := E047 + 1;
      E171 := E171 + 1;
      E115 := E115 + 1;
      E113 := E113 + 1;
      Ada.Tags'Elab_Body;
      E061 := E061 + 1;
      E079 := E079 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      System.Random_Numbers'Elab_Body;
      E225 := E225 + 1;
      System.Finalization_Root'Elab_Spec;
      E069 := E069 + 1;
      Ada.Finalization'Elab_Spec;
      E058 := E058 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E085 := E085 + 1;
      System.Storage_Pools'Elab_Spec;
      E106 := E106 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E098 := E098 + 1;
      Gnat.String_Split'Elab_Spec;
      E245 := E245 + 1;
      System.Os_Lib'Elab_Body;
      E118 := E118 + 1;
      System.Pool_Global'Elab_Spec;
      E123 := E123 + 1;
      System.File_Control_Block'Elab_Spec;
      E121 := E121 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E111 := E111 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E208 := E208 + 1;
      System.Regexp'Elab_Spec;
      E223 := E223 + 1;
      Ada.Directories'Elab_Body;
      E218 := E218 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E206 := E206 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E096 := E096 + 1;
      Ada.Text_Io.Editing'Elab_Spec;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E131 := E131 + 1;
      E127 := E127 + 1;
      E182 := E182 + 1;
      E180 := E180 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E185 := E185 + 1;
      Utils'Elab_Spec;
      E167 := E167 + 1;
      E249 := E249 + 1;
      E247 := E247 + 1;
      Zip_Streams'Elab_Spec;
      E231 := E231 + 1;
      Zip'Elab_Spec;
      Zip.Compress'Elab_Spec;
      E241 := E241 + 1;
      E235 := E235 + 1;
      E233 := E233 + 1;
      Zip.Headers'Elab_Spec;
      Zip.Headers'Elab_Body;
      E229 := E229 + 1;
      E227 := E227 + 1;
      Zip.Create'Elab_Spec;
      E243 := E243 + 1;
      Utils'Elab_Body;
      E212 := E212 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_create_inequality_statistics");

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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/format_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/inequality_generator-utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/inequality_generator.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/create_inequality_statistics.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip_streams.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-crc.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress-shrink.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-compress.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-headers.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/zip-create.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/utils.o
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
