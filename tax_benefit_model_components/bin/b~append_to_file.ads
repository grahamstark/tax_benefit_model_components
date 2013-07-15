pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2011 (20110419)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_append_to_file" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#0bb50069#;
   pragma Export (C, u00001, "append_to_fileB");
   u00002 : constant Version_32 := 16#7d892fe9#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#2d81b798#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#e4a307eb#;
   pragma Export (C, u00005, "ada__command_lineB");
   u00006 : constant Version_32 := 16#df5044bd#;
   pragma Export (C, u00006, "ada__command_lineS");
   u00007 : constant Version_32 := 16#23e1f70b#;
   pragma Export (C, u00007, "systemS");
   u00008 : constant Version_32 := 16#1907a5d3#;
   pragma Export (C, u00008, "system__secondary_stackB");
   u00009 : constant Version_32 := 16#378fd0a5#;
   pragma Export (C, u00009, "system__secondary_stackS");
   u00010 : constant Version_32 := 16#92dc3a55#;
   pragma Export (C, u00010, "system__parametersB");
   u00011 : constant Version_32 := 16#204bcc0a#;
   pragma Export (C, u00011, "system__parametersS");
   u00012 : constant Version_32 := 16#360d120c#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#5da35d94#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#e4c5cfb2#;
   pragma Export (C, u00014, "ada__exceptionsB");
   u00015 : constant Version_32 := 16#04af002e#;
   pragma Export (C, u00015, "ada__exceptionsS");
   u00016 : constant Version_32 := 16#52aba3be#;
   pragma Export (C, u00016, "ada__exceptions__last_chance_handlerB");
   u00017 : constant Version_32 := 16#48e7b9e5#;
   pragma Export (C, u00017, "ada__exceptions__last_chance_handlerS");
   u00018 : constant Version_32 := 16#53547b86#;
   pragma Export (C, u00018, "system__exception_tableB");
   u00019 : constant Version_32 := 16#b28f2bae#;
   pragma Export (C, u00019, "system__exception_tableS");
   u00020 : constant Version_32 := 16#ff3fa16b#;
   pragma Export (C, u00020, "system__htableB");
   u00021 : constant Version_32 := 16#cc3e5bd4#;
   pragma Export (C, u00021, "system__htableS");
   u00022 : constant Version_32 := 16#8b7dad61#;
   pragma Export (C, u00022, "system__string_hashB");
   u00023 : constant Version_32 := 16#057d2f9f#;
   pragma Export (C, u00023, "system__string_hashS");
   u00024 : constant Version_32 := 16#6a8a6a74#;
   pragma Export (C, u00024, "system__exceptionsB");
   u00025 : constant Version_32 := 16#b55fce9f#;
   pragma Export (C, u00025, "system__exceptionsS");
   u00026 : constant Version_32 := 16#b012ff50#;
   pragma Export (C, u00026, "system__img_intB");
   u00027 : constant Version_32 := 16#213a17c9#;
   pragma Export (C, u00027, "system__img_intS");
   u00028 : constant Version_32 := 16#ace32e1e#;
   pragma Export (C, u00028, "system__storage_elementsB");
   u00029 : constant Version_32 := 16#d92c8a93#;
   pragma Export (C, u00029, "system__storage_elementsS");
   u00030 : constant Version_32 := 16#dc8e33ed#;
   pragma Export (C, u00030, "system__tracebackB");
   u00031 : constant Version_32 := 16#4266237e#;
   pragma Export (C, u00031, "system__tracebackS");
   u00032 : constant Version_32 := 16#4900ab7d#;
   pragma Export (C, u00032, "system__unsigned_typesS");
   u00033 : constant Version_32 := 16#907d882f#;
   pragma Export (C, u00033, "system__wch_conB");
   u00034 : constant Version_32 := 16#9c0ad936#;
   pragma Export (C, u00034, "system__wch_conS");
   u00035 : constant Version_32 := 16#22fed88a#;
   pragma Export (C, u00035, "system__wch_stwB");
   u00036 : constant Version_32 := 16#b11bf537#;
   pragma Export (C, u00036, "system__wch_stwS");
   u00037 : constant Version_32 := 16#5d4d477e#;
   pragma Export (C, u00037, "system__wch_cnvB");
   u00038 : constant Version_32 := 16#82f45fe0#;
   pragma Export (C, u00038, "system__wch_cnvS");
   u00039 : constant Version_32 := 16#f77d8799#;
   pragma Export (C, u00039, "interfacesS");
   u00040 : constant Version_32 := 16#75729fba#;
   pragma Export (C, u00040, "system__wch_jisB");
   u00041 : constant Version_32 := 16#d686c4f4#;
   pragma Export (C, u00041, "system__wch_jisS");
   u00042 : constant Version_32 := 16#ada34a87#;
   pragma Export (C, u00042, "system__traceback_entriesB");
   u00043 : constant Version_32 := 16#71c0194a#;
   pragma Export (C, u00043, "system__traceback_entriesS");
   u00044 : constant Version_32 := 16#4f750b3b#;
   pragma Export (C, u00044, "system__stack_checkingB");
   u00045 : constant Version_32 := 16#80434b27#;
   pragma Export (C, u00045, "system__stack_checkingS");
   u00046 : constant Version_32 := 16#7d76dade#;
   pragma Export (C, u00046, "ada__directoriesB");
   u00047 : constant Version_32 := 16#91bd08a5#;
   pragma Export (C, u00047, "ada__directoriesS");
   u00048 : constant Version_32 := 16#0f244912#;
   pragma Export (C, u00048, "ada__calendarB");
   u00049 : constant Version_32 := 16#0bc00dc5#;
   pragma Export (C, u00049, "ada__calendarS");
   u00050 : constant Version_32 := 16#22d03640#;
   pragma Export (C, u00050, "system__os_primitivesB");
   u00051 : constant Version_32 := 16#93307b22#;
   pragma Export (C, u00051, "system__os_primitivesS");
   u00052 : constant Version_32 := 16#58c58b5e#;
   pragma Export (C, u00052, "ada__calendar__formattingB");
   u00053 : constant Version_32 := 16#7ece677a#;
   pragma Export (C, u00053, "ada__calendar__formattingS");
   u00054 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00054, "ada__calendar__time_zonesB");
   u00055 : constant Version_32 := 16#74a1fd86#;
   pragma Export (C, u00055, "ada__calendar__time_zonesS");
   u00056 : constant Version_32 := 16#7993dbbd#;
   pragma Export (C, u00056, "system__val_intB");
   u00057 : constant Version_32 := 16#6b44dd34#;
   pragma Export (C, u00057, "system__val_intS");
   u00058 : constant Version_32 := 16#e6965fe6#;
   pragma Export (C, u00058, "system__val_unsB");
   u00059 : constant Version_32 := 16#59a84646#;
   pragma Export (C, u00059, "system__val_unsS");
   u00060 : constant Version_32 := 16#46a1f7a9#;
   pragma Export (C, u00060, "system__val_utilB");
   u00061 : constant Version_32 := 16#284c6214#;
   pragma Export (C, u00061, "system__val_utilS");
   u00062 : constant Version_32 := 16#b7fa72e7#;
   pragma Export (C, u00062, "system__case_utilB");
   u00063 : constant Version_32 := 16#8efd9783#;
   pragma Export (C, u00063, "system__case_utilS");
   u00064 : constant Version_32 := 16#730c1f82#;
   pragma Export (C, u00064, "system__val_realB");
   u00065 : constant Version_32 := 16#ddc8801a#;
   pragma Export (C, u00065, "system__val_realS");
   u00066 : constant Version_32 := 16#0be1b996#;
   pragma Export (C, u00066, "system__exn_llfB");
   u00067 : constant Version_32 := 16#a265e9e4#;
   pragma Export (C, u00067, "system__exn_llfS");
   u00068 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00068, "system__float_controlB");
   u00069 : constant Version_32 := 16#c31db437#;
   pragma Export (C, u00069, "system__float_controlS");
   u00070 : constant Version_32 := 16#7391917c#;
   pragma Export (C, u00070, "system__powten_tableS");
   u00071 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00071, "ada__charactersS");
   u00072 : constant Version_32 := 16#833355f1#;
   pragma Export (C, u00072, "ada__characters__handlingB");
   u00073 : constant Version_32 := 16#3006d996#;
   pragma Export (C, u00073, "ada__characters__handlingS");
   u00074 : constant Version_32 := 16#051b1b7b#;
   pragma Export (C, u00074, "ada__characters__latin_1S");
   u00075 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00075, "ada__stringsS");
   u00076 : constant Version_32 := 16#96e9c1e7#;
   pragma Export (C, u00076, "ada__strings__mapsB");
   u00077 : constant Version_32 := 16#24318e4c#;
   pragma Export (C, u00077, "ada__strings__mapsS");
   u00078 : constant Version_32 := 16#fc369f43#;
   pragma Export (C, u00078, "system__bit_opsB");
   u00079 : constant Version_32 := 16#c30e4013#;
   pragma Export (C, u00079, "system__bit_opsS");
   u00080 : constant Version_32 := 16#7a69aa90#;
   pragma Export (C, u00080, "ada__strings__maps__constantsS");
   u00081 : constant Version_32 := 16#e559f18d#;
   pragma Export (C, u00081, "ada__directories__validityB");
   u00082 : constant Version_32 := 16#a2334639#;
   pragma Export (C, u00082, "ada__directories__validityS");
   u00083 : constant Version_32 := 16#ac6da32f#;
   pragma Export (C, u00083, "ada__finalization__heap_managementB");
   u00084 : constant Version_32 := 16#2f0ed1e5#;
   pragma Export (C, u00084, "ada__finalization__heap_managementS");
   u00085 : constant Version_32 := 16#6d616d1b#;
   pragma Export (C, u00085, "ada__finalizationB");
   u00086 : constant Version_32 := 16#a11701ff#;
   pragma Export (C, u00086, "ada__finalizationS");
   u00087 : constant Version_32 := 16#1358602f#;
   pragma Export (C, u00087, "ada__streamsS");
   u00088 : constant Version_32 := 16#8332779a#;
   pragma Export (C, u00088, "ada__tagsB");
   u00089 : constant Version_32 := 16#9de3f1eb#;
   pragma Export (C, u00089, "ada__tagsS");
   u00090 : constant Version_32 := 16#68f8d5f8#;
   pragma Export (C, u00090, "system__val_lluB");
   u00091 : constant Version_32 := 16#33f2fc0f#;
   pragma Export (C, u00091, "system__val_lluS");
   u00092 : constant Version_32 := 16#f7ab51aa#;
   pragma Export (C, u00092, "system__finalization_rootB");
   u00093 : constant Version_32 := 16#229d45de#;
   pragma Export (C, u00093, "system__finalization_rootS");
   u00094 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00094, "system__address_imageB");
   u00095 : constant Version_32 := 16#820d6a31#;
   pragma Export (C, u00095, "system__address_imageS");
   u00096 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00096, "system__img_boolB");
   u00097 : constant Version_32 := 16#d63886e0#;
   pragma Export (C, u00097, "system__img_boolS");
   u00098 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00098, "system__ioB");
   u00099 : constant Version_32 := 16#bda30044#;
   pragma Export (C, u00099, "system__ioS");
   u00100 : constant Version_32 := 16#d21112bd#;
   pragma Export (C, u00100, "system__storage_poolsB");
   u00101 : constant Version_32 := 16#364ea36f#;
   pragma Export (C, u00101, "system__storage_poolsS");
   u00102 : constant Version_32 := 16#914b496f#;
   pragma Export (C, u00102, "ada__strings__fixedB");
   u00103 : constant Version_32 := 16#dc686502#;
   pragma Export (C, u00103, "ada__strings__fixedS");
   u00104 : constant Version_32 := 16#c8b98bb0#;
   pragma Export (C, u00104, "ada__strings__searchB");
   u00105 : constant Version_32 := 16#b5a8c1d6#;
   pragma Export (C, u00105, "ada__strings__searchS");
   u00106 : constant Version_32 := 16#261c554b#;
   pragma Export (C, u00106, "ada__strings__unboundedB");
   u00107 : constant Version_32 := 16#762d3000#;
   pragma Export (C, u00107, "ada__strings__unboundedS");
   u00108 : constant Version_32 := 16#c4857ee1#;
   pragma Export (C, u00108, "system__compare_array_unsigned_8B");
   u00109 : constant Version_32 := 16#f9da01c6#;
   pragma Export (C, u00109, "system__compare_array_unsigned_8S");
   u00110 : constant Version_32 := 16#9d3d925a#;
   pragma Export (C, u00110, "system__address_operationsB");
   u00111 : constant Version_32 := 16#e39f1e9c#;
   pragma Export (C, u00111, "system__address_operationsS");
   u00112 : constant Version_32 := 16#23d3fb02#;
   pragma Export (C, u00112, "system__atomic_countersB");
   u00113 : constant Version_32 := 16#d57a91a7#;
   pragma Export (C, u00113, "system__atomic_countersS");
   u00114 : constant Version_32 := 16#a6e358bc#;
   pragma Export (C, u00114, "system__stream_attributesB");
   u00115 : constant Version_32 := 16#e89b4b3f#;
   pragma Export (C, u00115, "system__stream_attributesS");
   u00116 : constant Version_32 := 16#b46168d5#;
   pragma Export (C, u00116, "ada__io_exceptionsS");
   u00117 : constant Version_32 := 16#8c3c7d53#;
   pragma Export (C, u00117, "system__crtlS");
   u00118 : constant Version_32 := 16#efe3a128#;
   pragma Export (C, u00118, "system__file_ioB");
   u00119 : constant Version_32 := 16#2e96f0e6#;
   pragma Export (C, u00119, "system__file_ioS");
   u00120 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00120, "interfaces__cB");
   u00121 : constant Version_32 := 16#a0f6ad03#;
   pragma Export (C, u00121, "interfaces__cS");
   u00122 : constant Version_32 := 16#2c5c6a91#;
   pragma Export (C, u00122, "interfaces__c__stringsB");
   u00123 : constant Version_32 := 16#603c1c44#;
   pragma Export (C, u00123, "interfaces__c__stringsS");
   u00124 : constant Version_32 := 16#7a48d8b1#;
   pragma Export (C, u00124, "interfaces__c_streamsB");
   u00125 : constant Version_32 := 16#40dd1af2#;
   pragma Export (C, u00125, "interfaces__c_streamsS");
   u00126 : constant Version_32 := 16#a50435f4#;
   pragma Export (C, u00126, "system__crtl__runtimeS");
   u00127 : constant Version_32 := 16#03226e59#;
   pragma Export (C, u00127, "system__os_libB");
   u00128 : constant Version_32 := 16#a6d80a38#;
   pragma Export (C, u00128, "system__os_libS");
   u00129 : constant Version_32 := 16#4cd8aca0#;
   pragma Export (C, u00129, "system__stringsB");
   u00130 : constant Version_32 := 16#940bbdcf#;
   pragma Export (C, u00130, "system__stringsS");
   u00131 : constant Version_32 := 16#fcde1931#;
   pragma Export (C, u00131, "system__file_control_blockS");
   u00132 : constant Version_32 := 16#ebb6b8da#;
   pragma Export (C, u00132, "system__pool_globalB");
   u00133 : constant Version_32 := 16#f2b3b4b1#;
   pragma Export (C, u00133, "system__pool_globalS");
   u00134 : constant Version_32 := 16#2989cad8#;
   pragma Export (C, u00134, "system__memoryB");
   u00135 : constant Version_32 := 16#e96a4b1e#;
   pragma Export (C, u00135, "system__memoryS");
   u00136 : constant Version_32 := 16#e7905375#;
   pragma Export (C, u00136, "system__os_constantsS");
   u00137 : constant Version_32 := 16#e7698cad#;
   pragma Export (C, u00137, "system__regexpB");
   u00138 : constant Version_32 := 16#0caf03a9#;
   pragma Export (C, u00138, "system__regexpS");
   u00139 : constant Version_32 := 16#7a8f4ce5#;
   pragma Export (C, u00139, "ada__text_ioB");
   u00140 : constant Version_32 := 16#78993766#;
   pragma Export (C, u00140, "ada__text_ioS");
   u00141 : constant Version_32 := 16#b575f65d#;
   pragma Export (C, u00141, "text_utilsB");
   u00142 : constant Version_32 := 16#3f594023#;
   pragma Export (C, u00142, "text_utilsS");
   u00143 : constant Version_32 := 16#bd084245#;
   pragma Export (C, u00143, "ada__strings__hashB");
   u00144 : constant Version_32 := 16#fe83f2e7#;
   pragma Export (C, u00144, "ada__strings__hashS");
   u00145 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00145, "ada__containersS");
   u00146 : constant Version_32 := 16#54b8a3b7#;
   pragma Export (C, u00146, "ada__text_io__unbounded_ioS");
   u00147 : constant Version_32 := 16#97a2d3b4#;
   pragma Export (C, u00147, "ada__strings__unbounded__text_ioB");
   u00148 : constant Version_32 := 16#2124c8bb#;
   pragma Export (C, u00148, "ada__strings__unbounded__text_ioS");
   u00149 : constant Version_32 := 16#c9fdc962#;
   pragma Export (C, u00149, "system__concat_6B");
   u00150 : constant Version_32 := 16#e42b021f#;
   pragma Export (C, u00150, "system__concat_6S");
   u00151 : constant Version_32 := 16#def1dd00#;
   pragma Export (C, u00151, "system__concat_5B");
   u00152 : constant Version_32 := 16#33d839aa#;
   pragma Export (C, u00152, "system__concat_5S");
   u00153 : constant Version_32 := 16#3493e6c0#;
   pragma Export (C, u00153, "system__concat_4B");
   u00154 : constant Version_32 := 16#21be14b5#;
   pragma Export (C, u00154, "system__concat_4S");
   u00155 : constant Version_32 := 16#ae97ef6c#;
   pragma Export (C, u00155, "system__concat_3B");
   u00156 : constant Version_32 := 16#55cbf561#;
   pragma Export (C, u00156, "system__concat_3S");
   u00157 : constant Version_32 := 16#39591e91#;
   pragma Export (C, u00157, "system__concat_2B");
   u00158 : constant Version_32 := 16#d83105f7#;
   pragma Export (C, u00158, "system__concat_2S");
   u00159 : constant Version_32 := 16#654e2c4c#;
   pragma Export (C, u00159, "ada__containers__hash_tablesS");
   u00160 : constant Version_32 := 16#c24eaf4d#;
   pragma Export (C, u00160, "ada__containers__prime_numbersB");
   u00161 : constant Version_32 := 16#6d3af8ed#;
   pragma Export (C, u00161, "ada__containers__prime_numbersS");
   u00162 : constant Version_32 := 16#35b254f4#;
   pragma Export (C, u00162, "ada__strings__boundedB");
   u00163 : constant Version_32 := 16#be5af970#;
   pragma Export (C, u00163, "ada__strings__boundedS");
   u00164 : constant Version_32 := 16#1fdd0ccb#;
   pragma Export (C, u00164, "ada__strings__superboundedB");
   u00165 : constant Version_32 := 16#265c07f4#;
   pragma Export (C, u00165, "ada__strings__superboundedS");
   u00166 : constant Version_32 := 16#71efeffb#;
   pragma Export (C, u00166, "system__strings__stream_opsB");
   u00167 : constant Version_32 := 16#8453d1c6#;
   pragma Export (C, u00167, "system__strings__stream_opsS");
   u00168 : constant Version_32 := 16#c422e16c#;
   pragma Export (C, u00168, "ada__streams__stream_ioB");
   u00169 : constant Version_32 := 16#9fa60b9d#;
   pragma Export (C, u00169, "ada__streams__stream_ioS");
   u00170 : constant Version_32 := 16#595ba38f#;
   pragma Export (C, u00170, "system__communicationB");
   u00171 : constant Version_32 := 16#a1cf5921#;
   pragma Export (C, u00171, "system__communicationS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  ada.command_line%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.standard_library%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.unsigned_types%s
   --  system.val_int%s
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.val_int%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  system.address_image%s
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.concat_5%s
   --  system.concat_5%b
   --  system.concat_6%s
   --  system.concat_6%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.containers.hash_tables%s
   --  ada.containers.prime_numbers%s
   --  ada.containers.prime_numbers%b
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.hash%s
   --  ada.strings.hash%b
   --  ada.strings.maps%s
   --  ada.strings.fixed%s
   --  ada.strings.maps.constants%s
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.superbounded%s
   --  ada.strings.bounded%s
   --  ada.strings.bounded%b
   --  ada.tags%s
   --  ada.streams%s
   --  interfaces.c%s
   --  interfaces.c.strings%s
   --  system.crtl.runtime%s
   --  system.os_constants%s
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  system.communication%s
   --  system.communication%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.secondary_stack%s
   --  interfaces.c.strings%b
   --  interfaces.c%b
   --  ada.tags%b
   --  ada.strings.superbounded%b
   --  ada.strings.fixed%b
   --  ada.strings.maps%b
   --  system.soft_links%b
   --  ada.command_line%b
   --  ada.characters.handling%b
   --  system.secondary_stack%b
   --  ada.calendar.formatting%b
   --  system.address_image%b
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  ada.directories%s
   --  ada.directories.validity%s
   --  ada.directories.validity%b
   --  ada.finalization.heap_management%s
   --  ada.finalization.heap_management%b
   --  system.os_lib%s
   --  system.os_lib%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.file_control_block%s
   --  ada.streams.stream_io%s
   --  system.file_io%s
   --  system.file_io%b
   --  ada.streams.stream_io%b
   --  system.regexp%s
   --  system.regexp%b
   --  ada.directories%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.strings.unbounded.text_io%s
   --  ada.strings.unbounded.text_io%b
   --  ada.text_io.unbounded_io%s
   --  text_utils%s
   --  text_utils%b
   --  append_to_file%b
   --  END ELABORATION ORDER


end ada_main;
