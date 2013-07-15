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

   Ada_Main_Program_Name : constant String := "_ada_bhps_tabulator" & ASCII.NUL;
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
   u00001 : constant Version_32 := 16#00b6ed1e#;
   pragma Export (C, u00001, "bhps_tabulatorB");
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
   u00046 : constant Version_32 := 16#1358602f#;
   pragma Export (C, u00046, "ada__streamsS");
   u00047 : constant Version_32 := 16#8332779a#;
   pragma Export (C, u00047, "ada__tagsB");
   u00048 : constant Version_32 := 16#9de3f1eb#;
   pragma Export (C, u00048, "ada__tagsS");
   u00049 : constant Version_32 := 16#68f8d5f8#;
   pragma Export (C, u00049, "system__val_lluB");
   u00050 : constant Version_32 := 16#33f2fc0f#;
   pragma Export (C, u00050, "system__val_lluS");
   u00051 : constant Version_32 := 16#46a1f7a9#;
   pragma Export (C, u00051, "system__val_utilB");
   u00052 : constant Version_32 := 16#284c6214#;
   pragma Export (C, u00052, "system__val_utilS");
   u00053 : constant Version_32 := 16#b7fa72e7#;
   pragma Export (C, u00053, "system__case_utilB");
   u00054 : constant Version_32 := 16#8efd9783#;
   pragma Export (C, u00054, "system__case_utilS");
   u00055 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00055, "ada__stringsS");
   u00056 : constant Version_32 := 16#261c554b#;
   pragma Export (C, u00056, "ada__strings__unboundedB");
   u00057 : constant Version_32 := 16#762d3000#;
   pragma Export (C, u00057, "ada__strings__unboundedS");
   u00058 : constant Version_32 := 16#c8b98bb0#;
   pragma Export (C, u00058, "ada__strings__searchB");
   u00059 : constant Version_32 := 16#b5a8c1d6#;
   pragma Export (C, u00059, "ada__strings__searchS");
   u00060 : constant Version_32 := 16#96e9c1e7#;
   pragma Export (C, u00060, "ada__strings__mapsB");
   u00061 : constant Version_32 := 16#24318e4c#;
   pragma Export (C, u00061, "ada__strings__mapsS");
   u00062 : constant Version_32 := 16#fc369f43#;
   pragma Export (C, u00062, "system__bit_opsB");
   u00063 : constant Version_32 := 16#c30e4013#;
   pragma Export (C, u00063, "system__bit_opsS");
   u00064 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00064, "ada__charactersS");
   u00065 : constant Version_32 := 16#051b1b7b#;
   pragma Export (C, u00065, "ada__characters__latin_1S");
   u00066 : constant Version_32 := 16#c4857ee1#;
   pragma Export (C, u00066, "system__compare_array_unsigned_8B");
   u00067 : constant Version_32 := 16#f9da01c6#;
   pragma Export (C, u00067, "system__compare_array_unsigned_8S");
   u00068 : constant Version_32 := 16#9d3d925a#;
   pragma Export (C, u00068, "system__address_operationsB");
   u00069 : constant Version_32 := 16#e39f1e9c#;
   pragma Export (C, u00069, "system__address_operationsS");
   u00070 : constant Version_32 := 16#6d616d1b#;
   pragma Export (C, u00070, "ada__finalizationB");
   u00071 : constant Version_32 := 16#a11701ff#;
   pragma Export (C, u00071, "ada__finalizationS");
   u00072 : constant Version_32 := 16#f7ab51aa#;
   pragma Export (C, u00072, "system__finalization_rootB");
   u00073 : constant Version_32 := 16#229d45de#;
   pragma Export (C, u00073, "system__finalization_rootS");
   u00074 : constant Version_32 := 16#23d3fb02#;
   pragma Export (C, u00074, "system__atomic_countersB");
   u00075 : constant Version_32 := 16#d57a91a7#;
   pragma Export (C, u00075, "system__atomic_countersS");
   u00076 : constant Version_32 := 16#a6e358bc#;
   pragma Export (C, u00076, "system__stream_attributesB");
   u00077 : constant Version_32 := 16#e89b4b3f#;
   pragma Export (C, u00077, "system__stream_attributesS");
   u00078 : constant Version_32 := 16#b46168d5#;
   pragma Export (C, u00078, "ada__io_exceptionsS");
   u00079 : constant Version_32 := 16#7a8f4ce5#;
   pragma Export (C, u00079, "ada__text_ioB");
   u00080 : constant Version_32 := 16#78993766#;
   pragma Export (C, u00080, "ada__text_ioS");
   u00081 : constant Version_32 := 16#ac6da32f#;
   pragma Export (C, u00081, "ada__finalization__heap_managementB");
   u00082 : constant Version_32 := 16#2f0ed1e5#;
   pragma Export (C, u00082, "ada__finalization__heap_managementS");
   u00083 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00083, "system__address_imageB");
   u00084 : constant Version_32 := 16#820d6a31#;
   pragma Export (C, u00084, "system__address_imageS");
   u00085 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00085, "system__img_boolB");
   u00086 : constant Version_32 := 16#d63886e0#;
   pragma Export (C, u00086, "system__img_boolS");
   u00087 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00087, "system__ioB");
   u00088 : constant Version_32 := 16#bda30044#;
   pragma Export (C, u00088, "system__ioS");
   u00089 : constant Version_32 := 16#d21112bd#;
   pragma Export (C, u00089, "system__storage_poolsB");
   u00090 : constant Version_32 := 16#364ea36f#;
   pragma Export (C, u00090, "system__storage_poolsS");
   u00091 : constant Version_32 := 16#7a48d8b1#;
   pragma Export (C, u00091, "interfaces__c_streamsB");
   u00092 : constant Version_32 := 16#40dd1af2#;
   pragma Export (C, u00092, "interfaces__c_streamsS");
   u00093 : constant Version_32 := 16#8c3c7d53#;
   pragma Export (C, u00093, "system__crtlS");
   u00094 : constant Version_32 := 16#efe3a128#;
   pragma Export (C, u00094, "system__file_ioB");
   u00095 : constant Version_32 := 16#2e96f0e6#;
   pragma Export (C, u00095, "system__file_ioS");
   u00096 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00096, "interfaces__cB");
   u00097 : constant Version_32 := 16#a0f6ad03#;
   pragma Export (C, u00097, "interfaces__cS");
   u00098 : constant Version_32 := 16#2c5c6a91#;
   pragma Export (C, u00098, "interfaces__c__stringsB");
   u00099 : constant Version_32 := 16#603c1c44#;
   pragma Export (C, u00099, "interfaces__c__stringsS");
   u00100 : constant Version_32 := 16#a50435f4#;
   pragma Export (C, u00100, "system__crtl__runtimeS");
   u00101 : constant Version_32 := 16#03226e59#;
   pragma Export (C, u00101, "system__os_libB");
   u00102 : constant Version_32 := 16#a6d80a38#;
   pragma Export (C, u00102, "system__os_libS");
   u00103 : constant Version_32 := 16#4cd8aca0#;
   pragma Export (C, u00103, "system__stringsB");
   u00104 : constant Version_32 := 16#940bbdcf#;
   pragma Export (C, u00104, "system__stringsS");
   u00105 : constant Version_32 := 16#fcde1931#;
   pragma Export (C, u00105, "system__file_control_blockS");
   u00106 : constant Version_32 := 16#ebb6b8da#;
   pragma Export (C, u00106, "system__pool_globalB");
   u00107 : constant Version_32 := 16#f2b3b4b1#;
   pragma Export (C, u00107, "system__pool_globalS");
   u00108 : constant Version_32 := 16#2989cad8#;
   pragma Export (C, u00108, "system__memoryB");
   u00109 : constant Version_32 := 16#e96a4b1e#;
   pragma Export (C, u00109, "system__memoryS");
   u00110 : constant Version_32 := 16#54148977#;
   pragma Export (C, u00110, "base_model_typesB");
   u00111 : constant Version_32 := 16#a87c5016#;
   pragma Export (C, u00111, "base_model_typesS");
   u00112 : constant Version_32 := 16#35b254f4#;
   pragma Export (C, u00112, "ada__strings__boundedB");
   u00113 : constant Version_32 := 16#be5af970#;
   pragma Export (C, u00113, "ada__strings__boundedS");
   u00114 : constant Version_32 := 16#1fdd0ccb#;
   pragma Export (C, u00114, "ada__strings__superboundedB");
   u00115 : constant Version_32 := 16#265c07f4#;
   pragma Export (C, u00115, "ada__strings__superboundedS");
   u00116 : constant Version_32 := 16#14eb9c17#;
   pragma Export (C, u00116, "text_utilsB");
   u00117 : constant Version_32 := 16#3f594023#;
   pragma Export (C, u00117, "text_utilsS");
   u00118 : constant Version_32 := 16#833355f1#;
   pragma Export (C, u00118, "ada__characters__handlingB");
   u00119 : constant Version_32 := 16#3006d996#;
   pragma Export (C, u00119, "ada__characters__handlingS");
   u00120 : constant Version_32 := 16#7a69aa90#;
   pragma Export (C, u00120, "ada__strings__maps__constantsS");
   u00121 : constant Version_32 := 16#914b496f#;
   pragma Export (C, u00121, "ada__strings__fixedB");
   u00122 : constant Version_32 := 16#dc686502#;
   pragma Export (C, u00122, "ada__strings__fixedS");
   u00123 : constant Version_32 := 16#bd084245#;
   pragma Export (C, u00123, "ada__strings__hashB");
   u00124 : constant Version_32 := 16#fe83f2e7#;
   pragma Export (C, u00124, "ada__strings__hashS");
   u00125 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00125, "ada__containersS");
   u00126 : constant Version_32 := 16#54b8a3b7#;
   pragma Export (C, u00126, "ada__text_io__unbounded_ioS");
   u00127 : constant Version_32 := 16#97a2d3b4#;
   pragma Export (C, u00127, "ada__strings__unbounded__text_ioB");
   u00128 : constant Version_32 := 16#2124c8bb#;
   pragma Export (C, u00128, "ada__strings__unbounded__text_ioS");
   u00129 : constant Version_32 := 16#c9fdc962#;
   pragma Export (C, u00129, "system__concat_6B");
   u00130 : constant Version_32 := 16#e42b021f#;
   pragma Export (C, u00130, "system__concat_6S");
   u00131 : constant Version_32 := 16#def1dd00#;
   pragma Export (C, u00131, "system__concat_5B");
   u00132 : constant Version_32 := 16#33d839aa#;
   pragma Export (C, u00132, "system__concat_5S");
   u00133 : constant Version_32 := 16#3493e6c0#;
   pragma Export (C, u00133, "system__concat_4B");
   u00134 : constant Version_32 := 16#21be14b5#;
   pragma Export (C, u00134, "system__concat_4S");
   u00135 : constant Version_32 := 16#ae97ef6c#;
   pragma Export (C, u00135, "system__concat_3B");
   u00136 : constant Version_32 := 16#55cbf561#;
   pragma Export (C, u00136, "system__concat_3S");
   u00137 : constant Version_32 := 16#39591e91#;
   pragma Export (C, u00137, "system__concat_2B");
   u00138 : constant Version_32 := 16#d83105f7#;
   pragma Export (C, u00138, "system__concat_2S");
   u00139 : constant Version_32 := 16#654e2c4c#;
   pragma Export (C, u00139, "ada__containers__hash_tablesS");
   u00140 : constant Version_32 := 16#c24eaf4d#;
   pragma Export (C, u00140, "ada__containers__prime_numbersB");
   u00141 : constant Version_32 := 16#6d3af8ed#;
   pragma Export (C, u00141, "ada__containers__prime_numbersS");
   u00142 : constant Version_32 := 16#71efeffb#;
   pragma Export (C, u00142, "system__strings__stream_opsB");
   u00143 : constant Version_32 := 16#8453d1c6#;
   pragma Export (C, u00143, "system__strings__stream_opsS");
   u00144 : constant Version_32 := 16#c422e16c#;
   pragma Export (C, u00144, "ada__streams__stream_ioB");
   u00145 : constant Version_32 := 16#9fa60b9d#;
   pragma Export (C, u00145, "ada__streams__stream_ioS");
   u00146 : constant Version_32 := 16#595ba38f#;
   pragma Export (C, u00146, "system__communicationB");
   u00147 : constant Version_32 := 16#a1cf5921#;
   pragma Export (C, u00147, "system__communicationS");
   u00148 : constant Version_32 := 16#c8372456#;
   pragma Export (C, u00148, "ada__containers__red_black_treesS");
   u00149 : constant Version_32 := 16#1927e90e#;
   pragma Export (C, u00149, "ada__text_io__decimal_auxB");
   u00150 : constant Version_32 := 16#efbfa3ca#;
   pragma Export (C, u00150, "ada__text_io__decimal_auxS");
   u00151 : constant Version_32 := 16#d5f9759f#;
   pragma Export (C, u00151, "ada__text_io__float_auxB");
   u00152 : constant Version_32 := 16#f854caf5#;
   pragma Export (C, u00152, "ada__text_io__float_auxS");
   u00153 : constant Version_32 := 16#515dc0e3#;
   pragma Export (C, u00153, "ada__text_io__generic_auxB");
   u00154 : constant Version_32 := 16#a6c327d3#;
   pragma Export (C, u00154, "ada__text_io__generic_auxS");
   u00155 : constant Version_32 := 16#6d0081c3#;
   pragma Export (C, u00155, "system__img_realB");
   u00156 : constant Version_32 := 16#e449a6e9#;
   pragma Export (C, u00156, "system__img_realS");
   u00157 : constant Version_32 := 16#fcda293b#;
   pragma Export (C, u00157, "system__fat_llfS");
   u00158 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00158, "system__float_controlB");
   u00159 : constant Version_32 := 16#c31db437#;
   pragma Export (C, u00159, "system__float_controlS");
   u00160 : constant Version_32 := 16#06417083#;
   pragma Export (C, u00160, "system__img_lluB");
   u00161 : constant Version_32 := 16#00c9abbe#;
   pragma Export (C, u00161, "system__img_lluS");
   u00162 : constant Version_32 := 16#194ccd7b#;
   pragma Export (C, u00162, "system__img_unsB");
   u00163 : constant Version_32 := 16#d6f4978a#;
   pragma Export (C, u00163, "system__img_unsS");
   u00164 : constant Version_32 := 16#7391917c#;
   pragma Export (C, u00164, "system__powten_tableS");
   u00165 : constant Version_32 := 16#730c1f82#;
   pragma Export (C, u00165, "system__val_realB");
   u00166 : constant Version_32 := 16#ddc8801a#;
   pragma Export (C, u00166, "system__val_realS");
   u00167 : constant Version_32 := 16#0be1b996#;
   pragma Export (C, u00167, "system__exn_llfB");
   u00168 : constant Version_32 := 16#a265e9e4#;
   pragma Export (C, u00168, "system__exn_llfS");
   u00169 : constant Version_32 := 16#8da1623b#;
   pragma Export (C, u00169, "system__img_decB");
   u00170 : constant Version_32 := 16#8dccfed0#;
   pragma Export (C, u00170, "system__img_decS");
   u00171 : constant Version_32 := 16#276453b7#;
   pragma Export (C, u00171, "system__img_lldB");
   u00172 : constant Version_32 := 16#d0c3fe62#;
   pragma Export (C, u00172, "system__img_lldS");
   u00173 : constant Version_32 := 16#9777733a#;
   pragma Export (C, u00173, "system__img_lliB");
   u00174 : constant Version_32 := 16#32aea2da#;
   pragma Export (C, u00174, "system__img_lliS");
   u00175 : constant Version_32 := 16#7119cd54#;
   pragma Export (C, u00175, "system__val_decB");
   u00176 : constant Version_32 := 16#9f84d0b0#;
   pragma Export (C, u00176, "system__val_decS");
   u00177 : constant Version_32 := 16#420e5cd2#;
   pragma Export (C, u00177, "system__val_lldB");
   u00178 : constant Version_32 := 16#66665899#;
   pragma Export (C, u00178, "system__val_lldS");
   u00179 : constant Version_32 := 16#b75d1452#;
   pragma Export (C, u00179, "ada__text_io__enumeration_auxB");
   u00180 : constant Version_32 := 16#52f1e0af#;
   pragma Export (C, u00180, "ada__text_io__enumeration_auxS");
   u00181 : constant Version_32 := 16#f6fdca1c#;
   pragma Export (C, u00181, "ada__text_io__integer_auxB");
   u00182 : constant Version_32 := 16#b9793d30#;
   pragma Export (C, u00182, "ada__text_io__integer_auxS");
   u00183 : constant Version_32 := 16#ef6c8032#;
   pragma Export (C, u00183, "system__img_biuB");
   u00184 : constant Version_32 := 16#8f222330#;
   pragma Export (C, u00184, "system__img_biuS");
   u00185 : constant Version_32 := 16#10618bf9#;
   pragma Export (C, u00185, "system__img_llbB");
   u00186 : constant Version_32 := 16#cee533ce#;
   pragma Export (C, u00186, "system__img_llbS");
   u00187 : constant Version_32 := 16#f931f062#;
   pragma Export (C, u00187, "system__img_llwB");
   u00188 : constant Version_32 := 16#67891058#;
   pragma Export (C, u00188, "system__img_llwS");
   u00189 : constant Version_32 := 16#b532ff4e#;
   pragma Export (C, u00189, "system__img_wiuB");
   u00190 : constant Version_32 := 16#e163a4a2#;
   pragma Export (C, u00190, "system__img_wiuS");
   u00191 : constant Version_32 := 16#7993dbbd#;
   pragma Export (C, u00191, "system__val_intB");
   u00192 : constant Version_32 := 16#6b44dd34#;
   pragma Export (C, u00192, "system__val_intS");
   u00193 : constant Version_32 := 16#e6965fe6#;
   pragma Export (C, u00193, "system__val_unsB");
   u00194 : constant Version_32 := 16#59a84646#;
   pragma Export (C, u00194, "system__val_unsS");
   u00195 : constant Version_32 := 16#936e9286#;
   pragma Export (C, u00195, "system__val_lliB");
   u00196 : constant Version_32 := 16#b9c511ab#;
   pragma Export (C, u00196, "system__val_lliS");
   u00197 : constant Version_32 := 16#860a87d1#;
   pragma Export (C, u00197, "system__fat_lfltS");
   u00198 : constant Version_32 := 16#5c0e4566#;
   pragma Export (C, u00198, "system__val_boolB");
   u00199 : constant Version_32 := 16#d9739b15#;
   pragma Export (C, u00199, "system__val_boolS");
   u00200 : constant Version_32 := 16#982a2a82#;
   pragma Export (C, u00200, "bhpsB");
   u00201 : constant Version_32 := 16#0880c2b4#;
   pragma Export (C, u00201, "bhpsS");
   u00202 : constant Version_32 := 16#70eab0ea#;
   pragma Export (C, u00202, "ada__assertionsB");
   u00203 : constant Version_32 := 16#965d4398#;
   pragma Export (C, u00203, "ada__assertionsS");
   u00204 : constant Version_32 := 16#241bd2b4#;
   pragma Export (C, u00204, "system__assertionsB");
   u00205 : constant Version_32 := 16#804511a0#;
   pragma Export (C, u00205, "system__assertionsS");
   u00206 : constant Version_32 := 16#5b942b2e#;
   pragma Export (C, u00206, "system__concat_8B");
   u00207 : constant Version_32 := 16#c9f0f82d#;
   pragma Export (C, u00207, "system__concat_8S");
   u00208 : constant Version_32 := 16#ec38a9a5#;
   pragma Export (C, u00208, "system__concat_7B");
   u00209 : constant Version_32 := 16#3fb60411#;
   pragma Export (C, u00209, "system__concat_7S");
   u00210 : constant Version_32 := 16#1eab0e09#;
   pragma Export (C, u00210, "system__img_enum_newB");
   u00211 : constant Version_32 := 16#a4e63cfb#;
   pragma Export (C, u00211, "system__img_enum_newS");
   u00212 : constant Version_32 := 16#03a6cd25#;
   pragma Export (C, u00212, "bhps_enumsB");
   u00213 : constant Version_32 := 16#ac2cbfb4#;
   pragma Export (C, u00213, "bhps_enumsS");
   u00214 : constant Version_32 := 16#ee65d422#;
   pragma Export (C, u00214, "bhps_indexesB");
   u00215 : constant Version_32 := 16#0e1590e0#;
   pragma Export (C, u00215, "bhps_indexesS");
   u00216 : constant Version_32 := 16#7d76dade#;
   pragma Export (C, u00216, "ada__directoriesB");
   u00217 : constant Version_32 := 16#91bd08a5#;
   pragma Export (C, u00217, "ada__directoriesS");
   u00218 : constant Version_32 := 16#0f244912#;
   pragma Export (C, u00218, "ada__calendarB");
   u00219 : constant Version_32 := 16#0bc00dc5#;
   pragma Export (C, u00219, "ada__calendarS");
   u00220 : constant Version_32 := 16#22d03640#;
   pragma Export (C, u00220, "system__os_primitivesB");
   u00221 : constant Version_32 := 16#93307b22#;
   pragma Export (C, u00221, "system__os_primitivesS");
   u00222 : constant Version_32 := 16#58c58b5e#;
   pragma Export (C, u00222, "ada__calendar__formattingB");
   u00223 : constant Version_32 := 16#7ece677a#;
   pragma Export (C, u00223, "ada__calendar__formattingS");
   u00224 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00224, "ada__calendar__time_zonesB");
   u00225 : constant Version_32 := 16#74a1fd86#;
   pragma Export (C, u00225, "ada__calendar__time_zonesS");
   u00226 : constant Version_32 := 16#e559f18d#;
   pragma Export (C, u00226, "ada__directories__validityB");
   u00227 : constant Version_32 := 16#a2334639#;
   pragma Export (C, u00227, "ada__directories__validityS");
   u00228 : constant Version_32 := 16#e7905375#;
   pragma Export (C, u00228, "system__os_constantsS");
   u00229 : constant Version_32 := 16#e7698cad#;
   pragma Export (C, u00229, "system__regexpB");
   u00230 : constant Version_32 := 16#0caf03a9#;
   pragma Export (C, u00230, "system__regexpS");
   u00231 : constant Version_32 := 16#e8f058c7#;
   pragma Export (C, u00231, "format_utilsB");
   u00232 : constant Version_32 := 16#985e489e#;
   pragma Export (C, u00232, "format_utilsS");
   u00233 : constant Version_32 := 16#fd2ad2f1#;
   pragma Export (C, u00233, "gnatS");
   u00234 : constant Version_32 := 16#c72dc161#;
   pragma Export (C, u00234, "gnat__regpatS");
   u00235 : constant Version_32 := 16#b97b88d3#;
   pragma Export (C, u00235, "system__regpatB");
   u00236 : constant Version_32 := 16#a1bb6c74#;
   pragma Export (C, u00236, "system__regpatS");
   u00237 : constant Version_32 := 16#2b93a046#;
   pragma Export (C, u00237, "system__img_charB");
   u00238 : constant Version_32 := 16#bfd5afec#;
   pragma Export (C, u00238, "system__img_charS");
   u00239 : constant Version_32 := 16#b08adc6c#;
   pragma Export (C, u00239, "numeric_ioB");
   u00240 : constant Version_32 := 16#cffc501f#;
   pragma Export (C, u00240, "numeric_ioS");
   u00241 : constant Version_32 := 16#df592678#;
   pragma Export (C, u00241, "set_ofB");
   u00242 : constant Version_32 := 16#7e024410#;
   pragma Export (C, u00242, "set_ofS");
   u00243 : constant Version_32 := 16#7dbbd31d#;
   pragma Export (C, u00243, "text_ioS");
   u00244 : constant Version_32 := 16#684792a1#;
   pragma Export (C, u00244, "ada__text_io__editingB");
   u00245 : constant Version_32 := 16#b4c96878#;
   pragma Export (C, u00245, "ada__text_io__editingS");
   u00246 : constant Version_32 := 16#fae27217#;
   pragma Export (C, u00246, "utilsB");
   u00247 : constant Version_32 := 16#93874c25#;
   pragma Export (C, u00247, "utilsS");
   u00248 : constant Version_32 := 16#84ad4a42#;
   pragma Export (C, u00248, "ada__numericsS");
   u00249 : constant Version_32 := 16#036cdb71#;
   pragma Export (C, u00249, "system__random_numbersB");
   u00250 : constant Version_32 := 16#8a2f4f98#;
   pragma Export (C, u00250, "system__random_numbersS");
   u00251 : constant Version_32 := 16#8eee1ba4#;
   pragma Export (C, u00251, "zipB");
   u00252 : constant Version_32 := 16#9582cee7#;
   pragma Export (C, u00252, "zipS");
   u00253 : constant Version_32 := 16#59b0246a#;
   pragma Export (C, u00253, "zip__headersB");
   u00254 : constant Version_32 := 16#d257c337#;
   pragma Export (C, u00254, "zip__headersS");
   u00255 : constant Version_32 := 16#f7b54545#;
   pragma Export (C, u00255, "zip_streamsB");
   u00256 : constant Version_32 := 16#8dc9e11d#;
   pragma Export (C, u00256, "zip_streamsS");
   u00257 : constant Version_32 := 16#7e5e5931#;
   pragma Export (C, u00257, "zip__compressB");
   u00258 : constant Version_32 := 16#a63c5c22#;
   pragma Export (C, u00258, "zip__compressS");
   u00259 : constant Version_32 := 16#d2b24dfb#;
   pragma Export (C, u00259, "zip__compress__shrinkB");
   u00260 : constant Version_32 := 16#f8cc6b5d#;
   pragma Export (C, u00260, "zip__compress__shrinkS");
   u00261 : constant Version_32 := 16#dde34de3#;
   pragma Export (C, u00261, "system__exp_intB");
   u00262 : constant Version_32 := 16#3ac2c1f7#;
   pragma Export (C, u00262, "system__exp_intS");
   u00263 : constant Version_32 := 16#6f001a54#;
   pragma Export (C, u00263, "system__exp_unsB");
   u00264 : constant Version_32 := 16#74cc08d7#;
   pragma Export (C, u00264, "system__exp_unsS");
   u00265 : constant Version_32 := 16#aff5ad2a#;
   pragma Export (C, u00265, "zip__crcB");
   u00266 : constant Version_32 := 16#478d8151#;
   pragma Export (C, u00266, "zip__crcS");
   u00267 : constant Version_32 := 16#fc9bf0e8#;
   pragma Export (C, u00267, "zip__createB");
   u00268 : constant Version_32 := 16#64b6f235#;
   pragma Export (C, u00268, "zip__createS");
   u00269 : constant Version_32 := 16#cd508945#;
   pragma Export (C, u00269, "data_constantsB");
   u00270 : constant Version_32 := 16#06452ee2#;
   pragma Export (C, u00270, "data_constantsS");
   u00271 : constant Version_32 := 16#1944caf2#;
   pragma Export (C, u00271, "data_indexB");
   u00272 : constant Version_32 := 16#f58fa1c8#;
   pragma Export (C, u00272, "data_indexS");
   u00273 : constant Version_32 := 16#9f32cf9c#;
   pragma Export (C, u00273, "system__direct_ioB");
   u00274 : constant Version_32 := 16#acecc718#;
   pragma Export (C, u00274, "system__direct_ioS");
   u00275 : constant Version_32 := 16#dbf24c7a#;
   pragma Export (C, u00275, "gnat__string_splitB");
   u00276 : constant Version_32 := 16#73637f33#;
   pragma Export (C, u00276, "gnat__string_splitS");
   u00277 : constant Version_32 := 16#cab3f787#;
   pragma Export (C, u00277, "costs_tabulatorB");
   u00278 : constant Version_32 := 16#a23a68fd#;
   pragma Export (C, u00278, "costs_tabulatorS");
   u00279 : constant Version_32 := 16#c4bdc325#;
   pragma Export (C, u00279, "tabulator_commonsS");
   u00280 : constant Version_32 := 16#5bf4861b#;
   pragma Export (C, u00280, "costs_tabulator__text_ioB");
   u00281 : constant Version_32 := 16#93f713c7#;
   pragma Export (C, u00281, "costs_tabulator__text_ioS");
   u00282 : constant Version_32 := 16#d9962b48#;
   pragma Export (C, u00282, "io_commonsB");
   u00283 : constant Version_32 := 16#3750287e#;
   pragma Export (C, u00283, "io_commonsS");
   u00284 : constant Version_32 := 16#5180f6d1#;
   pragma Export (C, u00284, "ons_definitionsB");
   u00285 : constant Version_32 := 16#e065306a#;
   pragma Export (C, u00285, "ons_definitionsS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  ada.command_line%s
   --  gnat%s
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
   --  system.exp_int%s
   --  system.exp_int%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_char%s
   --  system.img_char%b
   --  system.img_dec%s
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_dec%b
   --  system.img_lld%s
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.img_lld%b
   --  system.img_real%s
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
   --  system.exp_uns%s
   --  system.exp_uns%b
   --  system.fat_lflt%s
   --  system.fat_llf%s
   --  system.img_biu%s
   --  system.img_biu%b
   --  system.img_llb%s
   --  system.img_llb%b
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_llw%s
   --  system.img_llw%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  system.img_wiu%s
   --  system.img_wiu%b
   --  system.val_bool%s
   --  system.val_dec%s
   --  system.val_int%s
   --  system.val_lld%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_lld%b
   --  system.val_dec%b
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.val_int%b
   --  system.val_bool%b
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
   --  system.concat_7%s
   --  system.concat_7%b
   --  system.concat_8%s
   --  system.concat_8%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.containers.hash_tables%s
   --  ada.containers.prime_numbers%s
   --  ada.containers.prime_numbers%b
   --  ada.containers.red_black_trees%s
   --  ada.io_exceptions%s
   --  ada.numerics%s
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
   --  system.regpat%s
   --  gnat.regpat%s
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  system.assertions%s
   --  system.assertions%b
   --  ada.assertions%s
   --  ada.assertions%b
   --  system.communication%s
   --  system.communication%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.random_numbers%s
   --  system.secondary_stack%s
   --  system.regpat%b
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
   --  system.random_numbers%b
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
   --  gnat.string_split%s
   --  gnat.string_split%b
   --  system.os_lib%s
   --  system.os_lib%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.file_control_block%s
   --  ada.streams.stream_io%s
   --  system.direct_io%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.direct_io%b
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
   --  ada.text_io.decimal_aux%s
   --  ada.text_io.editing%s
   --  ada.text_io.enumeration_aux%s
   --  ada.text_io.float_aux%s
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.text_io.float_aux%b
   --  ada.text_io.enumeration_aux%b
   --  ada.text_io.decimal_aux%b
   --  ada.text_io.integer_aux%s
   --  ada.text_io.integer_aux%b
   --  ada.text_io.editing%b
   --  ada.text_io.unbounded_io%s
   --  text_io%s
   --  base_model_types%s
   --  bhps_enums%s
   --  bhps_enums%b
   --  data_constants%s
   --  data_constants%b
   --  data_index%s
   --  numeric_io%s
   --  ons_definitions%s
   --  ons_definitions%b
   --  set_of%s
   --  set_of%b
   --  numeric_io%b
   --  tabulator_commons%s
   --  costs_tabulator%s
   --  costs_tabulator.text_io%s
   --  io_commons%s
   --  io_commons%b
   --  text_utils%s
   --  text_utils%b
   --  costs_tabulator.text_io%b
   --  costs_tabulator%b
   --  data_index%b
   --  base_model_types%b
   --  bhps_indexes%s
   --  bhps%s
   --  bhps%b
   --  bhps_tabulator%b
   --  utils%s
   --  format_utils%s
   --  format_utils%b
   --  bhps_indexes%b
   --  zip_streams%s
   --  zip_streams%b
   --  zip%s
   --  zip.compress%s
   --  zip.compress.shrink%s
   --  zip.crc%s
   --  zip.crc%b
   --  zip.compress.shrink%b
   --  zip.compress%b
   --  zip.headers%s
   --  zip.headers%b
   --  zip%b
   --  zip.create%s
   --  zip.create%b
   --  utils%b
   --  END ELABORATION ORDER


end ada_main;
