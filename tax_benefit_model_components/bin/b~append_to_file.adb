pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~append_to_file.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~append_to_file.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exception_table_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "ada__containers_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "ada__io_exceptions_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "ada__strings_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "ada__strings__maps_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "ada__strings__maps__constants_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "ada__tags_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "ada__streams_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "interfaces__c_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "interfaces__c__strings_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "ada__calendar_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__calendar__time_zones_E");
   E009 : Short_Integer; pragma Import (Ada, E009, "system__secondary_stack_E");
   E093 : Short_Integer; pragma Import (Ada, E093, "system__finalization_root_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "ada__finalization_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__strings__unbounded_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "system__storage_pools_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "ada__directories_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "ada__finalization__heap_management_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "system__os_lib_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "system__pool_global_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "system__file_control_block_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "ada__streams__stream_io_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "system__file_io_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "system__regexp_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__strings__stream_ops_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "ada__text_io_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "text_utils_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      E142 := E142 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "text_utils__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_body");
      begin
         E140 := E140 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__text_io__finalize_spec");
      begin
         F3;
      end;
      E047 := E047 - 1;
      E138 := E138 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__regexp__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__streams__stream_io__finalize_body");
      begin
         E169 := E169 - 1;
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__file_io__finalize_body");
      begin
         E119 := E119 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "ada__streams__stream_io__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__file_control_block__finalize_spec");
      begin
         E131 := E131 - 1;
         F8;
      end;
      E133 := E133 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__pool_global__finalize_spec");
      begin
         F9;
      end;
      E084 := E084 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ada__finalization__heap_management__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "ada__directories__finalize_spec");
      begin
         F11;
      end;
      E107 := E107 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "ada__strings__unbounded__finalize_spec");
      begin
         F12;
      end;
      E093 := E093 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "system__finalization_root__finalize_spec");
      begin
         F13;
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
      System.Exception_Table'Elab_Body;
      E019 := E019 + 1;
      Ada.Containers'Elab_Spec;
      E145 := E145 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E116 := E116 + 1;
      Ada.Strings'Elab_Spec;
      E075 := E075 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E080 := E080 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E087 := E087 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E049 := E049 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E055 := E055 + 1;
      E123 := E123 + 1;
      E121 := E121 + 1;
      Ada.Tags'Elab_Body;
      E089 := E089 + 1;
      E077 := E077 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Secondary_Stack'Elab_Body;
      E009 := E009 + 1;
      System.Finalization_Root'Elab_Spec;
      E093 := E093 + 1;
      Ada.Finalization'Elab_Spec;
      E086 := E086 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E107 := E107 + 1;
      System.Storage_Pools'Elab_Spec;
      E101 := E101 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E084 := E084 + 1;
      System.Os_Lib'Elab_Body;
      E128 := E128 + 1;
      System.Pool_Global'Elab_Spec;
      E133 := E133 + 1;
      System.File_Control_Block'Elab_Spec;
      E131 := E131 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E119 := E119 + 1;
      Ada.Streams.Stream_Io'Elab_Body;
      E169 := E169 + 1;
      System.Regexp'Elab_Spec;
      E138 := E138 + 1;
      Ada.Directories'Elab_Body;
      E047 := E047 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E167 := E167 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E140 := E140 + 1;
      Text_Utils'Elab_Spec;
      Text_Utils'Elab_Body;
      E142 := E142 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_append_to_file");

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
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/text_utils.o
   --   /home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/append_to_file.o
   --   -L/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/bin/
   --   -L/opt/ada_libraries/lib/aunit/native-full/
   --   -L/opt/ada_libraries/lib/xmlada/static/
   --   -L/opt/ada_libraries/lib/aws/native/static/
   --   -L/opt/gnat/2011/lib/gcc/x86_64-pc-linux-gnu/4.5.3/adalib/
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
