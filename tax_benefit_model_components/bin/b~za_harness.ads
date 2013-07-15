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

   Ada_Main_Program_Name : constant String := "_ada_za_harness" & ASCII.NUL;
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
   u00001 : constant Version_32 := 16#da2e9bde#;
   pragma Export (C, u00001, "za_harnessB");
   u00002 : constant Version_32 := 16#7d892fe9#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#2d81b798#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#2d7781ef#;
   pragma Export (C, u00004, "aunitB");
   u00005 : constant Version_32 := 16#76cdf7c6#;
   pragma Export (C, u00005, "aunitS");
   u00006 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00006, "adaS");
   u00007 : constant Version_32 := 16#b6c145a2#;
   pragma Export (C, u00007, "aunit__memoryB");
   u00008 : constant Version_32 := 16#f51d518b#;
   pragma Export (C, u00008, "aunit__memoryS");
   u00009 : constant Version_32 := 16#23e1f70b#;
   pragma Export (C, u00009, "systemS");
   u00010 : constant Version_32 := 16#ace32e1e#;
   pragma Export (C, u00010, "system__storage_elementsB");
   u00011 : constant Version_32 := 16#d92c8a93#;
   pragma Export (C, u00011, "system__storage_elementsS");
   u00012 : constant Version_32 := 16#8979db55#;
   pragma Export (C, u00012, "aunit__reporterS");
   u00013 : constant Version_32 := 16#e4c5cfb2#;
   pragma Export (C, u00013, "ada__exceptionsB");
   u00014 : constant Version_32 := 16#04af002e#;
   pragma Export (C, u00014, "ada__exceptionsS");
   u00015 : constant Version_32 := 16#52aba3be#;
   pragma Export (C, u00015, "ada__exceptions__last_chance_handlerB");
   u00016 : constant Version_32 := 16#48e7b9e5#;
   pragma Export (C, u00016, "ada__exceptions__last_chance_handlerS");
   u00017 : constant Version_32 := 16#360d120c#;
   pragma Export (C, u00017, "system__soft_linksB");
   u00018 : constant Version_32 := 16#5da35d94#;
   pragma Export (C, u00018, "system__soft_linksS");
   u00019 : constant Version_32 := 16#92dc3a55#;
   pragma Export (C, u00019, "system__parametersB");
   u00020 : constant Version_32 := 16#204bcc0a#;
   pragma Export (C, u00020, "system__parametersS");
   u00021 : constant Version_32 := 16#1907a5d3#;
   pragma Export (C, u00021, "system__secondary_stackB");
   u00022 : constant Version_32 := 16#378fd0a5#;
   pragma Export (C, u00022, "system__secondary_stackS");
   u00023 : constant Version_32 := 16#4f750b3b#;
   pragma Export (C, u00023, "system__stack_checkingB");
   u00024 : constant Version_32 := 16#80434b27#;
   pragma Export (C, u00024, "system__stack_checkingS");
   u00025 : constant Version_32 := 16#53547b86#;
   pragma Export (C, u00025, "system__exception_tableB");
   u00026 : constant Version_32 := 16#b28f2bae#;
   pragma Export (C, u00026, "system__exception_tableS");
   u00027 : constant Version_32 := 16#ff3fa16b#;
   pragma Export (C, u00027, "system__htableB");
   u00028 : constant Version_32 := 16#cc3e5bd4#;
   pragma Export (C, u00028, "system__htableS");
   u00029 : constant Version_32 := 16#8b7dad61#;
   pragma Export (C, u00029, "system__string_hashB");
   u00030 : constant Version_32 := 16#057d2f9f#;
   pragma Export (C, u00030, "system__string_hashS");
   u00031 : constant Version_32 := 16#6a8a6a74#;
   pragma Export (C, u00031, "system__exceptionsB");
   u00032 : constant Version_32 := 16#b55fce9f#;
   pragma Export (C, u00032, "system__exceptionsS");
   u00033 : constant Version_32 := 16#b012ff50#;
   pragma Export (C, u00033, "system__img_intB");
   u00034 : constant Version_32 := 16#213a17c9#;
   pragma Export (C, u00034, "system__img_intS");
   u00035 : constant Version_32 := 16#dc8e33ed#;
   pragma Export (C, u00035, "system__tracebackB");
   u00036 : constant Version_32 := 16#4266237e#;
   pragma Export (C, u00036, "system__tracebackS");
   u00037 : constant Version_32 := 16#4900ab7d#;
   pragma Export (C, u00037, "system__unsigned_typesS");
   u00038 : constant Version_32 := 16#907d882f#;
   pragma Export (C, u00038, "system__wch_conB");
   u00039 : constant Version_32 := 16#9c0ad936#;
   pragma Export (C, u00039, "system__wch_conS");
   u00040 : constant Version_32 := 16#22fed88a#;
   pragma Export (C, u00040, "system__wch_stwB");
   u00041 : constant Version_32 := 16#b11bf537#;
   pragma Export (C, u00041, "system__wch_stwS");
   u00042 : constant Version_32 := 16#5d4d477e#;
   pragma Export (C, u00042, "system__wch_cnvB");
   u00043 : constant Version_32 := 16#82f45fe0#;
   pragma Export (C, u00043, "system__wch_cnvS");
   u00044 : constant Version_32 := 16#f77d8799#;
   pragma Export (C, u00044, "interfacesS");
   u00045 : constant Version_32 := 16#75729fba#;
   pragma Export (C, u00045, "system__wch_jisB");
   u00046 : constant Version_32 := 16#d686c4f4#;
   pragma Export (C, u00046, "system__wch_jisS");
   u00047 : constant Version_32 := 16#ada34a87#;
   pragma Export (C, u00047, "system__traceback_entriesB");
   u00048 : constant Version_32 := 16#71c0194a#;
   pragma Export (C, u00048, "system__traceback_entriesS");
   u00049 : constant Version_32 := 16#1358602f#;
   pragma Export (C, u00049, "ada__streamsS");
   u00050 : constant Version_32 := 16#8332779a#;
   pragma Export (C, u00050, "ada__tagsB");
   u00051 : constant Version_32 := 16#9de3f1eb#;
   pragma Export (C, u00051, "ada__tagsS");
   u00052 : constant Version_32 := 16#68f8d5f8#;
   pragma Export (C, u00052, "system__val_lluB");
   u00053 : constant Version_32 := 16#33f2fc0f#;
   pragma Export (C, u00053, "system__val_lluS");
   u00054 : constant Version_32 := 16#46a1f7a9#;
   pragma Export (C, u00054, "system__val_utilB");
   u00055 : constant Version_32 := 16#284c6214#;
   pragma Export (C, u00055, "system__val_utilS");
   u00056 : constant Version_32 := 16#b7fa72e7#;
   pragma Export (C, u00056, "system__case_utilB");
   u00057 : constant Version_32 := 16#8efd9783#;
   pragma Export (C, u00057, "system__case_utilS");
   u00058 : constant Version_32 := 16#01adf261#;
   pragma Export (C, u00058, "aunit__test_resultsB");
   u00059 : constant Version_32 := 16#e00b278d#;
   pragma Export (C, u00059, "aunit__test_resultsS");
   u00060 : constant Version_32 := 16#fe92b126#;
   pragma Export (C, u00060, "aunit__memory__utilsB");
   u00061 : constant Version_32 := 16#fb2f6c57#;
   pragma Export (C, u00061, "aunit__memory__utilsS");
   u00062 : constant Version_32 := 16#11329e00#;
   pragma Export (C, u00062, "ada_containersS");
   u00063 : constant Version_32 := 16#8fca4d3c#;
   pragma Export (C, u00063, "ada_containers__aunit_listsB");
   u00064 : constant Version_32 := 16#c8d9569a#;
   pragma Export (C, u00064, "ada_containers__aunit_listsS");
   u00065 : constant Version_32 := 16#c4150d4d#;
   pragma Export (C, u00065, "aunit__time_measureB");
   u00066 : constant Version_32 := 16#1ac42b03#;
   pragma Export (C, u00066, "aunit__time_measureS");
   u00067 : constant Version_32 := 16#0f244912#;
   pragma Export (C, u00067, "ada__calendarB");
   u00068 : constant Version_32 := 16#0bc00dc5#;
   pragma Export (C, u00068, "ada__calendarS");
   u00069 : constant Version_32 := 16#22d03640#;
   pragma Export (C, u00069, "system__os_primitivesB");
   u00070 : constant Version_32 := 16#93307b22#;
   pragma Export (C, u00070, "system__os_primitivesS");
   u00071 : constant Version_32 := 16#0d5f0aba#;
   pragma Export (C, u00071, "aunit__reporter__textB");
   u00072 : constant Version_32 := 16#8fccaf1c#;
   pragma Export (C, u00072, "aunit__reporter__textS");
   u00073 : constant Version_32 := 16#fd2ad2f1#;
   pragma Export (C, u00073, "gnatS");
   u00074 : constant Version_32 := 16#b48102f5#;
   pragma Export (C, u00074, "gnat__ioB");
   u00075 : constant Version_32 := 16#6227e843#;
   pragma Export (C, u00075, "gnat__ioS");
   u00076 : constant Version_32 := 16#b602a99c#;
   pragma Export (C, u00076, "system__exn_intB");
   u00077 : constant Version_32 := 16#616deb57#;
   pragma Export (C, u00077, "system__exn_intS");
   u00078 : constant Version_32 := 16#a6e358bc#;
   pragma Export (C, u00078, "system__stream_attributesB");
   u00079 : constant Version_32 := 16#e89b4b3f#;
   pragma Export (C, u00079, "system__stream_attributesS");
   u00080 : constant Version_32 := 16#b46168d5#;
   pragma Export (C, u00080, "ada__io_exceptionsS");
   u00081 : constant Version_32 := 16#221a4a57#;
   pragma Export (C, u00081, "aunit__runB");
   u00082 : constant Version_32 := 16#fa67f913#;
   pragma Export (C, u00082, "aunit__runS");
   u00083 : constant Version_32 := 16#3e4a3ee2#;
   pragma Export (C, u00083, "aunit__test_suitesB");
   u00084 : constant Version_32 := 16#b270132c#;
   pragma Export (C, u00084, "aunit__test_suitesS");
   u00085 : constant Version_32 := 16#ac6da32f#;
   pragma Export (C, u00085, "ada__finalization__heap_managementB");
   u00086 : constant Version_32 := 16#2f0ed1e5#;
   pragma Export (C, u00086, "ada__finalization__heap_managementS");
   u00087 : constant Version_32 := 16#6d616d1b#;
   pragma Export (C, u00087, "ada__finalizationB");
   u00088 : constant Version_32 := 16#a11701ff#;
   pragma Export (C, u00088, "ada__finalizationS");
   u00089 : constant Version_32 := 16#f7ab51aa#;
   pragma Export (C, u00089, "system__finalization_rootB");
   u00090 : constant Version_32 := 16#229d45de#;
   pragma Export (C, u00090, "system__finalization_rootS");
   u00091 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00091, "system__address_imageB");
   u00092 : constant Version_32 := 16#820d6a31#;
   pragma Export (C, u00092, "system__address_imageS");
   u00093 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00093, "system__img_boolB");
   u00094 : constant Version_32 := 16#d63886e0#;
   pragma Export (C, u00094, "system__img_boolS");
   u00095 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00095, "system__ioB");
   u00096 : constant Version_32 := 16#bda30044#;
   pragma Export (C, u00096, "system__ioS");
   u00097 : constant Version_32 := 16#d21112bd#;
   pragma Export (C, u00097, "system__storage_poolsB");
   u00098 : constant Version_32 := 16#364ea36f#;
   pragma Export (C, u00098, "system__storage_poolsS");
   u00099 : constant Version_32 := 16#a82b211a#;
   pragma Export (C, u00099, "aunit__optionsS");
   u00100 : constant Version_32 := 16#0782b454#;
   pragma Export (C, u00100, "aunit__test_filtersB");
   u00101 : constant Version_32 := 16#9a67cba8#;
   pragma Export (C, u00101, "aunit__test_filtersS");
   u00102 : constant Version_32 := 16#0475fd74#;
   pragma Export (C, u00102, "aunit__simple_test_casesB");
   u00103 : constant Version_32 := 16#b8d0680d#;
   pragma Export (C, u00103, "aunit__simple_test_casesS");
   u00104 : constant Version_32 := 16#8872fb1a#;
   pragma Export (C, u00104, "aunit__assertionsB");
   u00105 : constant Version_32 := 16#f4097c04#;
   pragma Export (C, u00105, "aunit__assertionsS");
   u00106 : constant Version_32 := 16#6b6cea8f#;
   pragma Export (C, u00106, "aunit__testsS");
   u00107 : constant Version_32 := 16#ebb6b8da#;
   pragma Export (C, u00107, "system__pool_globalB");
   u00108 : constant Version_32 := 16#f2b3b4b1#;
   pragma Export (C, u00108, "system__pool_globalS");
   u00109 : constant Version_32 := 16#2989cad8#;
   pragma Export (C, u00109, "system__memoryB");
   u00110 : constant Version_32 := 16#e96a4b1e#;
   pragma Export (C, u00110, "system__memoryS");
   u00111 : constant Version_32 := 16#8c3c7d53#;
   pragma Export (C, u00111, "system__crtlS");
   u00112 : constant Version_32 := 16#1b4527ff#;
   pragma Export (C, u00112, "gnat__source_infoS");
   u00113 : constant Version_32 := 16#2648146e#;
   pragma Export (C, u00113, "gnat__tracebackB");
   u00114 : constant Version_32 := 16#fa9a2780#;
   pragma Export (C, u00114, "gnat__tracebackS");
   u00115 : constant Version_32 := 16#83c02e81#;
   pragma Export (C, u00115, "ada__exceptions__tracebackB");
   u00116 : constant Version_32 := 16#efc10b76#;
   pragma Export (C, u00116, "ada__exceptions__tracebackS");
   u00117 : constant Version_32 := 16#1e730e4e#;
   pragma Export (C, u00117, "gnat__traceback__symbolicB");
   u00118 : constant Version_32 := 16#40bab342#;
   pragma Export (C, u00118, "gnat__traceback__symbolicS");
   u00119 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00119, "interfaces__cB");
   u00120 : constant Version_32 := 16#a0f6ad03#;
   pragma Export (C, u00120, "interfaces__cS");
   u00121 : constant Version_32 := 16#2c5c6a91#;
   pragma Export (C, u00121, "interfaces__c__stringsB");
   u00122 : constant Version_32 := 16#603c1c44#;
   pragma Export (C, u00122, "interfaces__c__stringsS");
   u00123 : constant Version_32 := 16#7e773317#;
   pragma Export (C, u00123, "system__dwarf_linesB");
   u00124 : constant Version_32 := 16#0b008d29#;
   pragma Export (C, u00124, "system__dwarf_linesS");
   u00125 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00125, "ada__stringsS");
   u00126 : constant Version_32 := 16#35b254f4#;
   pragma Export (C, u00126, "ada__strings__boundedB");
   u00127 : constant Version_32 := 16#be5af970#;
   pragma Export (C, u00127, "ada__strings__boundedS");
   u00128 : constant Version_32 := 16#96e9c1e7#;
   pragma Export (C, u00128, "ada__strings__mapsB");
   u00129 : constant Version_32 := 16#24318e4c#;
   pragma Export (C, u00129, "ada__strings__mapsS");
   u00130 : constant Version_32 := 16#fc369f43#;
   pragma Export (C, u00130, "system__bit_opsB");
   u00131 : constant Version_32 := 16#c30e4013#;
   pragma Export (C, u00131, "system__bit_opsS");
   u00132 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00132, "ada__charactersS");
   u00133 : constant Version_32 := 16#051b1b7b#;
   pragma Export (C, u00133, "ada__characters__latin_1S");
   u00134 : constant Version_32 := 16#1fdd0ccb#;
   pragma Export (C, u00134, "ada__strings__superboundedB");
   u00135 : constant Version_32 := 16#265c07f4#;
   pragma Export (C, u00135, "ada__strings__superboundedS");
   u00136 : constant Version_32 := 16#c8b98bb0#;
   pragma Export (C, u00136, "ada__strings__searchB");
   u00137 : constant Version_32 := 16#b5a8c1d6#;
   pragma Export (C, u00137, "ada__strings__searchS");
   u00138 : constant Version_32 := 16#c4857ee1#;
   pragma Export (C, u00138, "system__compare_array_unsigned_8B");
   u00139 : constant Version_32 := 16#f9da01c6#;
   pragma Export (C, u00139, "system__compare_array_unsigned_8S");
   u00140 : constant Version_32 := 16#9d3d925a#;
   pragma Export (C, u00140, "system__address_operationsB");
   u00141 : constant Version_32 := 16#e39f1e9c#;
   pragma Export (C, u00141, "system__address_operationsS");
   u00142 : constant Version_32 := 16#194ccd7b#;
   pragma Export (C, u00142, "system__img_unsB");
   u00143 : constant Version_32 := 16#d6f4978a#;
   pragma Export (C, u00143, "system__img_unsS");
   u00144 : constant Version_32 := 16#32cf7c31#;
   pragma Export (C, u00144, "system__object_readerB");
   u00145 : constant Version_32 := 16#8ceb6dee#;
   pragma Export (C, u00145, "system__object_readerS");
   u00146 : constant Version_32 := 16#7a48d8b1#;
   pragma Export (C, u00146, "interfaces__c_streamsB");
   u00147 : constant Version_32 := 16#40dd1af2#;
   pragma Export (C, u00147, "interfaces__c_streamsS");
   u00148 : constant Version_32 := 16#936e9286#;
   pragma Export (C, u00148, "system__val_lliB");
   u00149 : constant Version_32 := 16#b9c511ab#;
   pragma Export (C, u00149, "system__val_lliS");
   u00150 : constant Version_32 := 16#595856c4#;
   pragma Export (C, u00150, "za_suiteB");
   u00151 : constant Version_32 := 16#a997e030#;
   pragma Export (C, u00151, "zaS");
   u00152 : constant Version_32 := 16#58c58b5e#;
   pragma Export (C, u00152, "ada__calendar__formattingB");
   u00153 : constant Version_32 := 16#7ece677a#;
   pragma Export (C, u00153, "ada__calendar__formattingS");
   u00154 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00154, "ada__calendar__time_zonesB");
   u00155 : constant Version_32 := 16#74a1fd86#;
   pragma Export (C, u00155, "ada__calendar__time_zonesS");
   u00156 : constant Version_32 := 16#7993dbbd#;
   pragma Export (C, u00156, "system__val_intB");
   u00157 : constant Version_32 := 16#6b44dd34#;
   pragma Export (C, u00157, "system__val_intS");
   u00158 : constant Version_32 := 16#e6965fe6#;
   pragma Export (C, u00158, "system__val_unsB");
   u00159 : constant Version_32 := 16#59a84646#;
   pragma Export (C, u00159, "system__val_unsS");
   u00160 : constant Version_32 := 16#730c1f82#;
   pragma Export (C, u00160, "system__val_realB");
   u00161 : constant Version_32 := 16#ddc8801a#;
   pragma Export (C, u00161, "system__val_realS");
   u00162 : constant Version_32 := 16#0be1b996#;
   pragma Export (C, u00162, "system__exn_llfB");
   u00163 : constant Version_32 := 16#a265e9e4#;
   pragma Export (C, u00163, "system__exn_llfS");
   u00164 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00164, "system__float_controlB");
   u00165 : constant Version_32 := 16#c31db437#;
   pragma Export (C, u00165, "system__float_controlS");
   u00166 : constant Version_32 := 16#7391917c#;
   pragma Export (C, u00166, "system__powten_tableS");
   u00167 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00167, "ada__containersS");
   u00168 : constant Version_32 := 16#914b496f#;
   pragma Export (C, u00168, "ada__strings__fixedB");
   u00169 : constant Version_32 := 16#dc686502#;
   pragma Export (C, u00169, "ada__strings__fixedS");
   u00170 : constant Version_32 := 16#261c554b#;
   pragma Export (C, u00170, "ada__strings__unboundedB");
   u00171 : constant Version_32 := 16#762d3000#;
   pragma Export (C, u00171, "ada__strings__unboundedS");
   u00172 : constant Version_32 := 16#23d3fb02#;
   pragma Export (C, u00172, "system__atomic_countersB");
   u00173 : constant Version_32 := 16#d57a91a7#;
   pragma Export (C, u00173, "system__atomic_countersS");
   u00174 : constant Version_32 := 16#97a2d3b4#;
   pragma Export (C, u00174, "ada__strings__unbounded__text_ioB");
   u00175 : constant Version_32 := 16#2124c8bb#;
   pragma Export (C, u00175, "ada__strings__unbounded__text_ioS");
   u00176 : constant Version_32 := 16#7a8f4ce5#;
   pragma Export (C, u00176, "ada__text_ioB");
   u00177 : constant Version_32 := 16#78993766#;
   pragma Export (C, u00177, "ada__text_ioS");
   u00178 : constant Version_32 := 16#efe3a128#;
   pragma Export (C, u00178, "system__file_ioB");
   u00179 : constant Version_32 := 16#2e96f0e6#;
   pragma Export (C, u00179, "system__file_ioS");
   u00180 : constant Version_32 := 16#a50435f4#;
   pragma Export (C, u00180, "system__crtl__runtimeS");
   u00181 : constant Version_32 := 16#03226e59#;
   pragma Export (C, u00181, "system__os_libB");
   u00182 : constant Version_32 := 16#a6d80a38#;
   pragma Export (C, u00182, "system__os_libS");
   u00183 : constant Version_32 := 16#4cd8aca0#;
   pragma Export (C, u00183, "system__stringsB");
   u00184 : constant Version_32 := 16#940bbdcf#;
   pragma Export (C, u00184, "system__stringsS");
   u00185 : constant Version_32 := 16#fcde1931#;
   pragma Export (C, u00185, "system__file_control_blockS");
   u00186 : constant Version_32 := 16#684792a1#;
   pragma Export (C, u00186, "ada__text_io__editingB");
   u00187 : constant Version_32 := 16#b4c96878#;
   pragma Export (C, u00187, "ada__text_io__editingS");
   u00188 : constant Version_32 := 16#f6fdca1c#;
   pragma Export (C, u00188, "ada__text_io__integer_auxB");
   u00189 : constant Version_32 := 16#b9793d30#;
   pragma Export (C, u00189, "ada__text_io__integer_auxS");
   u00190 : constant Version_32 := 16#515dc0e3#;
   pragma Export (C, u00190, "ada__text_io__generic_auxB");
   u00191 : constant Version_32 := 16#a6c327d3#;
   pragma Export (C, u00191, "ada__text_io__generic_auxS");
   u00192 : constant Version_32 := 16#ef6c8032#;
   pragma Export (C, u00192, "system__img_biuB");
   u00193 : constant Version_32 := 16#8f222330#;
   pragma Export (C, u00193, "system__img_biuS");
   u00194 : constant Version_32 := 16#10618bf9#;
   pragma Export (C, u00194, "system__img_llbB");
   u00195 : constant Version_32 := 16#cee533ce#;
   pragma Export (C, u00195, "system__img_llbS");
   u00196 : constant Version_32 := 16#9777733a#;
   pragma Export (C, u00196, "system__img_lliB");
   u00197 : constant Version_32 := 16#32aea2da#;
   pragma Export (C, u00197, "system__img_lliS");
   u00198 : constant Version_32 := 16#f931f062#;
   pragma Export (C, u00198, "system__img_llwB");
   u00199 : constant Version_32 := 16#67891058#;
   pragma Export (C, u00199, "system__img_llwS");
   u00200 : constant Version_32 := 16#b532ff4e#;
   pragma Export (C, u00200, "system__img_wiuB");
   u00201 : constant Version_32 := 16#e163a4a2#;
   pragma Export (C, u00201, "system__img_wiuS");
   u00202 : constant Version_32 := 16#d5f9759f#;
   pragma Export (C, u00202, "ada__text_io__float_auxB");
   u00203 : constant Version_32 := 16#f854caf5#;
   pragma Export (C, u00203, "ada__text_io__float_auxS");
   u00204 : constant Version_32 := 16#6d0081c3#;
   pragma Export (C, u00204, "system__img_realB");
   u00205 : constant Version_32 := 16#e449a6e9#;
   pragma Export (C, u00205, "system__img_realS");
   u00206 : constant Version_32 := 16#fcda293b#;
   pragma Export (C, u00206, "system__fat_llfS");
   u00207 : constant Version_32 := 16#06417083#;
   pragma Export (C, u00207, "system__img_lluB");
   u00208 : constant Version_32 := 16#00c9abbe#;
   pragma Export (C, u00208, "system__img_lluS");
   u00209 : constant Version_32 := 16#54148977#;
   pragma Export (C, u00209, "base_model_typesB");
   u00210 : constant Version_32 := 16#a87c5016#;
   pragma Export (C, u00210, "base_model_typesS");
   u00211 : constant Version_32 := 16#b575f65d#;
   pragma Export (C, u00211, "text_utilsB");
   u00212 : constant Version_32 := 16#3f594023#;
   pragma Export (C, u00212, "text_utilsS");
   u00213 : constant Version_32 := 16#833355f1#;
   pragma Export (C, u00213, "ada__characters__handlingB");
   u00214 : constant Version_32 := 16#3006d996#;
   pragma Export (C, u00214, "ada__characters__handlingS");
   u00215 : constant Version_32 := 16#7a69aa90#;
   pragma Export (C, u00215, "ada__strings__maps__constantsS");
   u00216 : constant Version_32 := 16#bd084245#;
   pragma Export (C, u00216, "ada__strings__hashB");
   u00217 : constant Version_32 := 16#fe83f2e7#;
   pragma Export (C, u00217, "ada__strings__hashS");
   u00218 : constant Version_32 := 16#54b8a3b7#;
   pragma Export (C, u00218, "ada__text_io__unbounded_ioS");
   u00219 : constant Version_32 := 16#c9fdc962#;
   pragma Export (C, u00219, "system__concat_6B");
   u00220 : constant Version_32 := 16#e42b021f#;
   pragma Export (C, u00220, "system__concat_6S");
   u00221 : constant Version_32 := 16#def1dd00#;
   pragma Export (C, u00221, "system__concat_5B");
   u00222 : constant Version_32 := 16#33d839aa#;
   pragma Export (C, u00222, "system__concat_5S");
   u00223 : constant Version_32 := 16#3493e6c0#;
   pragma Export (C, u00223, "system__concat_4B");
   u00224 : constant Version_32 := 16#21be14b5#;
   pragma Export (C, u00224, "system__concat_4S");
   u00225 : constant Version_32 := 16#ae97ef6c#;
   pragma Export (C, u00225, "system__concat_3B");
   u00226 : constant Version_32 := 16#55cbf561#;
   pragma Export (C, u00226, "system__concat_3S");
   u00227 : constant Version_32 := 16#39591e91#;
   pragma Export (C, u00227, "system__concat_2B");
   u00228 : constant Version_32 := 16#d83105f7#;
   pragma Export (C, u00228, "system__concat_2S");
   u00229 : constant Version_32 := 16#654e2c4c#;
   pragma Export (C, u00229, "ada__containers__hash_tablesS");
   u00230 : constant Version_32 := 16#c24eaf4d#;
   pragma Export (C, u00230, "ada__containers__prime_numbersB");
   u00231 : constant Version_32 := 16#6d3af8ed#;
   pragma Export (C, u00231, "ada__containers__prime_numbersS");
   u00232 : constant Version_32 := 16#71efeffb#;
   pragma Export (C, u00232, "system__strings__stream_opsB");
   u00233 : constant Version_32 := 16#8453d1c6#;
   pragma Export (C, u00233, "system__strings__stream_opsS");
   u00234 : constant Version_32 := 16#c422e16c#;
   pragma Export (C, u00234, "ada__streams__stream_ioB");
   u00235 : constant Version_32 := 16#9fa60b9d#;
   pragma Export (C, u00235, "ada__streams__stream_ioS");
   u00236 : constant Version_32 := 16#595ba38f#;
   pragma Export (C, u00236, "system__communicationB");
   u00237 : constant Version_32 := 16#a1cf5921#;
   pragma Export (C, u00237, "system__communicationS");
   u00238 : constant Version_32 := 16#c8372456#;
   pragma Export (C, u00238, "ada__containers__red_black_treesS");
   u00239 : constant Version_32 := 16#1927e90e#;
   pragma Export (C, u00239, "ada__text_io__decimal_auxB");
   u00240 : constant Version_32 := 16#efbfa3ca#;
   pragma Export (C, u00240, "ada__text_io__decimal_auxS");
   u00241 : constant Version_32 := 16#8da1623b#;
   pragma Export (C, u00241, "system__img_decB");
   u00242 : constant Version_32 := 16#8dccfed0#;
   pragma Export (C, u00242, "system__img_decS");
   u00243 : constant Version_32 := 16#276453b7#;
   pragma Export (C, u00243, "system__img_lldB");
   u00244 : constant Version_32 := 16#d0c3fe62#;
   pragma Export (C, u00244, "system__img_lldS");
   u00245 : constant Version_32 := 16#7119cd54#;
   pragma Export (C, u00245, "system__val_decB");
   u00246 : constant Version_32 := 16#9f84d0b0#;
   pragma Export (C, u00246, "system__val_decS");
   u00247 : constant Version_32 := 16#420e5cd2#;
   pragma Export (C, u00247, "system__val_lldB");
   u00248 : constant Version_32 := 16#66665899#;
   pragma Export (C, u00248, "system__val_lldS");
   u00249 : constant Version_32 := 16#b75d1452#;
   pragma Export (C, u00249, "ada__text_io__enumeration_auxB");
   u00250 : constant Version_32 := 16#52f1e0af#;
   pragma Export (C, u00250, "ada__text_io__enumeration_auxS");
   u00251 : constant Version_32 := 16#860a87d1#;
   pragma Export (C, u00251, "system__fat_lfltS");
   u00252 : constant Version_32 := 16#5c0e4566#;
   pragma Export (C, u00252, "system__val_boolB");
   u00253 : constant Version_32 := 16#d9739b15#;
   pragma Export (C, u00253, "system__val_boolS");
   u00254 : constant Version_32 := 16#8b6e7c5c#;
   pragma Export (C, u00254, "format_utilsB");
   u00255 : constant Version_32 := 16#985e489e#;
   pragma Export (C, u00255, "format_utilsS");
   u00256 : constant Version_32 := 16#c72dc161#;
   pragma Export (C, u00256, "gnat__regpatS");
   u00257 : constant Version_32 := 16#b97b88d3#;
   pragma Export (C, u00257, "system__regpatB");
   u00258 : constant Version_32 := 16#a1bb6c74#;
   pragma Export (C, u00258, "system__regpatS");
   u00259 : constant Version_32 := 16#2b93a046#;
   pragma Export (C, u00259, "system__img_charB");
   u00260 : constant Version_32 := 16#bfd5afec#;
   pragma Export (C, u00260, "system__img_charS");
   u00261 : constant Version_32 := 16#1eab0e09#;
   pragma Export (C, u00261, "system__img_enum_newB");
   u00262 : constant Version_32 := 16#a4e63cfb#;
   pragma Export (C, u00262, "system__img_enum_newS");
   u00263 : constant Version_32 := 16#b08adc6c#;
   pragma Export (C, u00263, "numeric_ioB");
   u00264 : constant Version_32 := 16#cffc501f#;
   pragma Export (C, u00264, "numeric_ioS");
   u00265 : constant Version_32 := 16#df592678#;
   pragma Export (C, u00265, "set_ofB");
   u00266 : constant Version_32 := 16#7e024410#;
   pragma Export (C, u00266, "set_ofS");
   u00267 : constant Version_32 := 16#7dbbd31d#;
   pragma Export (C, u00267, "text_ioS");
   u00268 : constant Version_32 := 16#fae27217#;
   pragma Export (C, u00268, "utilsB");
   u00269 : constant Version_32 := 16#93874c25#;
   pragma Export (C, u00269, "utilsS");
   u00270 : constant Version_32 := 16#7d76dade#;
   pragma Export (C, u00270, "ada__directoriesB");
   u00271 : constant Version_32 := 16#91bd08a5#;
   pragma Export (C, u00271, "ada__directoriesS");
   u00272 : constant Version_32 := 16#e559f18d#;
   pragma Export (C, u00272, "ada__directories__validityB");
   u00273 : constant Version_32 := 16#a2334639#;
   pragma Export (C, u00273, "ada__directories__validityS");
   u00274 : constant Version_32 := 16#e7905375#;
   pragma Export (C, u00274, "system__os_constantsS");
   u00275 : constant Version_32 := 16#e7698cad#;
   pragma Export (C, u00275, "system__regexpB");
   u00276 : constant Version_32 := 16#0caf03a9#;
   pragma Export (C, u00276, "system__regexpS");
   u00277 : constant Version_32 := 16#84ad4a42#;
   pragma Export (C, u00277, "ada__numericsS");
   u00278 : constant Version_32 := 16#036cdb71#;
   pragma Export (C, u00278, "system__random_numbersB");
   u00279 : constant Version_32 := 16#8a2f4f98#;
   pragma Export (C, u00279, "system__random_numbersS");
   u00280 : constant Version_32 := 16#8eee1ba4#;
   pragma Export (C, u00280, "zipB");
   u00281 : constant Version_32 := 16#9582cee7#;
   pragma Export (C, u00281, "zipS");
   u00282 : constant Version_32 := 16#59b0246a#;
   pragma Export (C, u00282, "zip__headersB");
   u00283 : constant Version_32 := 16#d257c337#;
   pragma Export (C, u00283, "zip__headersS");
   u00284 : constant Version_32 := 16#f7b54545#;
   pragma Export (C, u00284, "zip_streamsB");
   u00285 : constant Version_32 := 16#8dc9e11d#;
   pragma Export (C, u00285, "zip_streamsS");
   u00286 : constant Version_32 := 16#7e5e5931#;
   pragma Export (C, u00286, "zip__compressB");
   u00287 : constant Version_32 := 16#a63c5c22#;
   pragma Export (C, u00287, "zip__compressS");
   u00288 : constant Version_32 := 16#d2b24dfb#;
   pragma Export (C, u00288, "zip__compress__shrinkB");
   u00289 : constant Version_32 := 16#f8cc6b5d#;
   pragma Export (C, u00289, "zip__compress__shrinkS");
   u00290 : constant Version_32 := 16#dde34de3#;
   pragma Export (C, u00290, "system__exp_intB");
   u00291 : constant Version_32 := 16#3ac2c1f7#;
   pragma Export (C, u00291, "system__exp_intS");
   u00292 : constant Version_32 := 16#6f001a54#;
   pragma Export (C, u00292, "system__exp_unsB");
   u00293 : constant Version_32 := 16#74cc08d7#;
   pragma Export (C, u00293, "system__exp_unsS");
   u00294 : constant Version_32 := 16#aff5ad2a#;
   pragma Export (C, u00294, "zip__crcB");
   u00295 : constant Version_32 := 16#478d8151#;
   pragma Export (C, u00295, "zip__crcS");
   u00296 : constant Version_32 := 16#fc9bf0e8#;
   pragma Export (C, u00296, "zip__createB");
   u00297 : constant Version_32 := 16#64b6f235#;
   pragma Export (C, u00297, "zip__createS");
   u00298 : constant Version_32 := 16#6bb9513b#;
   pragma Export (C, u00298, "key_value_ioB");
   u00299 : constant Version_32 := 16#9c968072#;
   pragma Export (C, u00299, "key_value_ioS");
   u00300 : constant Version_32 := 16#7835f61e#;
   pragma Export (C, u00300, "line_extractorB");
   u00301 : constant Version_32 := 16#cd5a6f5b#;
   pragma Export (C, u00301, "line_extractorS");
   u00302 : constant Version_32 := 16#4b180150#;
   pragma Export (C, u00302, "za__modelS");
   u00303 : constant Version_32 := 16#825c612e#;
   pragma Export (C, u00303, "loggerB");
   u00304 : constant Version_32 := 16#d3b895b5#;
   pragma Export (C, u00304, "loggerS");
   u00305 : constant Version_32 := 16#60e187c1#;
   pragma Export (C, u00305, "time_formatB");
   u00306 : constant Version_32 := 16#4909a02b#;
   pragma Export (C, u00306, "time_formatS");
   u00307 : constant Version_32 := 16#a0388edc#;
   pragma Export (C, u00307, "system__fat_fltS");
   u00308 : constant Version_32 := 16#7421e0fb#;
   pragma Export (C, u00308, "tax_utilsB");
   u00309 : constant Version_32 := 16#29c4855d#;
   pragma Export (C, u00309, "tax_utilsS");
   u00310 : constant Version_32 := 16#f3d8ffa9#;
   pragma Export (C, u00310, "za__model_typesB");
   u00311 : constant Version_32 := 16#969f1a4e#;
   pragma Export (C, u00311, "za__model_typesS");
   u00312 : constant Version_32 := 16#dbf24c7a#;
   pragma Export (C, u00312, "gnat__string_splitB");
   u00313 : constant Version_32 := 16#73637f33#;
   pragma Export (C, u00313, "gnat__string_splitS");
   u00314 : constant Version_32 := 16#763c483e#;
   pragma Export (C, u00314, "system__arith_64B");
   u00315 : constant Version_32 := 16#748dd1fb#;
   pragma Export (C, u00315, "system__arith_64S");
   u00316 : constant Version_32 := 16#96c125d4#;
   pragma Export (C, u00316, "system__val_enumB");
   u00317 : constant Version_32 := 16#98fbb59e#;
   pragma Export (C, u00317, "system__val_enumS");
   u00318 : constant Version_32 := 16#7b6656f9#;
   pragma Export (C, u00318, "t_utilsB");
   u00319 : constant Version_32 := 16#f82e69dc#;
   pragma Export (C, u00319, "t_utilsS");
   u00320 : constant Version_32 := 16#df476813#;
   pragma Export (C, u00320, "za__model__calculatorB");
   u00321 : constant Version_32 := 16#a007aa81#;
   pragma Export (C, u00321, "za__model__calculatorS");
   u00322 : constant Version_32 := 16#70eab0ea#;
   pragma Export (C, u00322, "ada__assertionsB");
   u00323 : constant Version_32 := 16#965d4398#;
   pragma Export (C, u00323, "ada__assertionsS");
   u00324 : constant Version_32 := 16#241bd2b4#;
   pragma Export (C, u00324, "system__assertionsB");
   u00325 : constant Version_32 := 16#804511a0#;
   pragma Export (C, u00325, "system__assertionsS");
   u00326 : constant Version_32 := 16#386c2686#;
   pragma Export (C, u00326, "indirect_tax_utilsB");
   u00327 : constant Version_32 := 16#b0bb83ee#;
   pragma Export (C, u00327, "indirect_tax_utilsS");
   u00328 : constant Version_32 := 16#5b942b2e#;
   pragma Export (C, u00328, "system__concat_8B");
   u00329 : constant Version_32 := 16#c9f0f82d#;
   pragma Export (C, u00329, "system__concat_8S");
   u00330 : constant Version_32 := 16#ec38a9a5#;
   pragma Export (C, u00330, "system__concat_7B");
   u00331 : constant Version_32 := 16#3fb60411#;
   pragma Export (C, u00331, "system__concat_7S");
   u00332 : constant Version_32 := 16#4c0bd0e0#;
   pragma Export (C, u00332, "za__model__takeupB");
   u00333 : constant Version_32 := 16#32f25d03#;
   pragma Export (C, u00333, "za__model__takeupS");
   u00334 : constant Version_32 := 16#ac5daf3d#;
   pragma Export (C, u00334, "ada__numerics__float_randomB");
   u00335 : constant Version_32 := 16#ac27f55b#;
   pragma Export (C, u00335, "ada__numerics__float_randomS");
   u00336 : constant Version_32 := 16#7f74ba19#;
   pragma Export (C, u00336, "za__model__dataB");
   u00337 : constant Version_32 := 16#2f0605e8#;
   pragma Export (C, u00337, "za__model__dataS");
   u00338 : constant Version_32 := 16#299e6ca7#;
   pragma Export (C, u00338, "coicop_definitionsB");
   u00339 : constant Version_32 := 16#0ccb6ddc#;
   pragma Export (C, u00339, "coicop_definitionsS");
   u00340 : constant Version_32 := 16#77d62882#;
   pragma Export (C, u00340, "za__model__settingsB");
   u00341 : constant Version_32 := 16#d91d348e#;
   pragma Export (C, u00341, "za__model__settingsS");
   u00342 : constant Version_32 := 16#e4a307eb#;
   pragma Export (C, u00342, "ada__command_lineB");
   u00343 : constant Version_32 := 16#df5044bd#;
   pragma Export (C, u00343, "ada__command_lineS");
   u00344 : constant Version_32 := 16#13f6473c#;
   pragma Export (C, u00344, "za__model__paramsB");
   u00345 : constant Version_32 := 16#4827fca9#;
   pragma Export (C, u00345, "za__model__paramsS");
   u00346 : constant Version_32 := 16#88e1d38c#;
   pragma Export (C, u00346, "za__model__resultsB");
   u00347 : constant Version_32 := 16#aa61c38b#;
   pragma Export (C, u00347, "za__model__resultsS");
   u00348 : constant Version_32 := 16#0bf612fc#;
   pragma Export (C, u00348, "za__model__calculator__testsB");
   u00349 : constant Version_32 := 16#4da1e67b#;
   pragma Export (C, u00349, "za__model__calculator__testsS");
   u00350 : constant Version_32 := 16#0ba8581c#;
   pragma Export (C, u00350, "ada__numerics__auxB");
   u00351 : constant Version_32 := 16#9f6e24ed#;
   pragma Export (C, u00351, "ada__numerics__auxS");
   u00352 : constant Version_32 := 16#19fe2194#;
   pragma Export (C, u00352, "system__machine_codeS");
   u00353 : constant Version_32 := 16#4d1f58df#;
   pragma Export (C, u00353, "calmarB");
   u00354 : constant Version_32 := 16#ab369a5d#;
   pragma Export (C, u00354, "calmarS");
   u00355 : constant Version_32 := 16#a9ec05db#;
   pragma Export (C, u00355, "interfaces__fortranB");
   u00356 : constant Version_32 := 16#ce264009#;
   pragma Export (C, u00356, "interfaces__fortranS");
   u00357 : constant Version_32 := 16#eb0f615c#;
   pragma Export (C, u00357, "interfaces__fortran__blasB");
   u00358 : constant Version_32 := 16#ac36d1d6#;
   pragma Export (C, u00358, "interfaces__fortran__blasS");
   u00359 : constant Version_32 := 16#50051ebe#;
   pragma Export (C, u00359, "interfaces__fortran__lapackS");
   u00360 : constant Version_32 := 16#2ea077fd#;
   pragma Export (C, u00360, "system__generic_array_operationsB");
   u00361 : constant Version_32 := 16#35e12c79#;
   pragma Export (C, u00361, "system__generic_array_operationsS");
   u00362 : constant Version_32 := 16#cab3f787#;
   pragma Export (C, u00362, "costs_tabulatorB");
   u00363 : constant Version_32 := 16#a23a68fd#;
   pragma Export (C, u00363, "costs_tabulatorS");
   u00364 : constant Version_32 := 16#c4bdc325#;
   pragma Export (C, u00364, "tabulator_commonsS");
   u00365 : constant Version_32 := 16#b03fcd11#;
   pragma Export (C, u00365, "inequality_generatorB");
   u00366 : constant Version_32 := 16#c3ccad90#;
   pragma Export (C, u00366, "inequality_generatorS");
   u00367 : constant Version_32 := 16#28ec52d1#;
   pragma Export (C, u00367, "za__model__calculator__budget_constraintsB");
   u00368 : constant Version_32 := 16#0ffd2704#;
   pragma Export (C, u00368, "za__model__calculator__budget_constraintsS");
   u00369 : constant Version_32 := 16#81670fa6#;
   pragma Export (C, u00369, "piecewise_linear_generatorB");
   u00370 : constant Version_32 := 16#0cf4bdda#;
   pragma Export (C, u00370, "piecewise_linear_generatorS");
   u00371 : constant Version_32 := 16#301c289b#;
   pragma Export (C, u00371, "za__model__calculator__runnerB");
   u00372 : constant Version_32 := 16#f2c47c16#;
   pragma Export (C, u00372, "za__model__calculator__runnerS");
   u00373 : constant Version_32 := 16#15dce40a#;
   pragma Export (C, u00373, "tabulatorB");
   u00374 : constant Version_32 := 16#c8d73323#;
   pragma Export (C, u00374, "tabulatorS");
   u00375 : constant Version_32 := 16#3c5e9912#;
   pragma Export (C, u00375, "za__model__data__binary_ioB");
   u00376 : constant Version_32 := 16#136fe85e#;
   pragma Export (C, u00376, "za__model__data__binary_ioS");
   u00377 : constant Version_32 := 16#9f32cf9c#;
   pragma Export (C, u00377, "system__direct_ioB");
   u00378 : constant Version_32 := 16#acecc718#;
   pragma Export (C, u00378, "system__direct_ioS");
   u00379 : constant Version_32 := 16#d769784f#;
   pragma Export (C, u00379, "za__model__calculator__wider_outputB");
   u00380 : constant Version_32 := 16#bf62ba09#;
   pragma Export (C, u00380, "za__model__calculator__wider_outputS");
   u00381 : constant Version_32 := 16#8625c6b1#;
   pragma Export (C, u00381, "costs_tabulator__wider_ioB");
   u00382 : constant Version_32 := 16#45650a93#;
   pragma Export (C, u00382, "costs_tabulator__wider_ioS");
   u00383 : constant Version_32 := 16#5ee23263#;
   pragma Export (C, u00383, "wider_io_commonsB");
   u00384 : constant Version_32 := 16#93ce7871#;
   pragma Export (C, u00384, "wider_io_commonsS");
   u00385 : constant Version_32 := 16#714669db#;
   pragma Export (C, u00385, "poverty_tabulatorB");
   u00386 : constant Version_32 := 16#b93cb6ad#;
   pragma Export (C, u00386, "poverty_tabulatorS");
   u00387 : constant Version_32 := 16#b32149e1#;
   pragma Export (C, u00387, "poverty_tabulator__wider_ioB");
   u00388 : constant Version_32 := 16#48ee3abb#;
   pragma Export (C, u00388, "poverty_tabulator__wider_ioS");
   u00389 : constant Version_32 := 16#5626b41a#;
   pragma Export (C, u00389, "tabulator__wider_ioB");
   u00390 : constant Version_32 := 16#8abee156#;
   pragma Export (C, u00390, "tabulator__wider_ioS");
   u00391 : constant Version_32 := 16#420e076e#;
   pragma Export (C, u00391, "za__model__data__examplesB");
   u00392 : constant Version_32 := 16#910017d6#;
   pragma Export (C, u00392, "za__model__data__examplesS");
   u00393 : constant Version_32 := 16#b74a0033#;
   pragma Export (C, u00393, "za__model__params__defaultsB");
   u00394 : constant Version_32 := 16#fb58193f#;
   pragma Export (C, u00394, "za__model__params__defaultsS");
   u00395 : constant Version_32 := 16#5656ab28#;
   pragma Export (C, u00395, "aunit__test_casesB");
   u00396 : constant Version_32 := 16#f847a7c5#;
   pragma Export (C, u00396, "aunit__test_casesS");
   u00397 : constant Version_32 := 16#fc3c9020#;
   pragma Export (C, u00397, "za__model__data__testsB");
   u00398 : constant Version_32 := 16#298cd728#;
   pragma Export (C, u00398, "za__model__data__testsS");
   u00399 : constant Version_32 := 16#83d04038#;
   pragma Export (C, u00399, "za__testsB");
   u00400 : constant Version_32 := 16#8b15d8cc#;
   pragma Export (C, u00400, "za__testsS");
   u00401 : constant Version_32 := 16#3751615b#;
   pragma Export (C, u00401, "za__iesB");
   u00402 : constant Version_32 := 16#71b7b257#;
   pragma Export (C, u00402, "za__iesS");
   u00403 : constant Version_32 := 16#344a04f9#;
   pragma Export (C, u00403, "za__ies__raw_ioB");
   u00404 : constant Version_32 := 16#48610f3e#;
   pragma Export (C, u00404, "za__ies__raw_ioS");
   u00405 : constant Version_32 := 16#1944caf2#;
   pragma Export (C, u00405, "data_indexB");
   u00406 : constant Version_32 := 16#f58fa1c8#;
   pragma Export (C, u00406, "data_indexS");
   u00407 : constant Version_32 := 16#2fbcaf4d#;
   pragma Export (C, u00407, "za__model_dataset_makerB");
   u00408 : constant Version_32 := 16#8a2d2451#;
   pragma Export (C, u00408, "za__model_dataset_makerS");
   u00409 : constant Version_32 := 16#f1815e5e#;
   pragma Export (C, u00409, "zmS");
   u00410 : constant Version_32 := 16#099675a9#;
   pragma Export (C, u00410, "zm__rawS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  ada.command_line%s
   --  gnat%s
   --  gnat.io%s
   --  gnat.io%b
   --  gnat.source_info%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.arith_64%s
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_int%s
   --  system.exn_int%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.exp_int%s
   --  system.exp_int%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.generic_array_operations%s
   --  system.generic_array_operations%b
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
   --  system.machine_code%s
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
   --  system.arith_64%b
   --  system.soft_links%s
   --  system.unsigned_types%s
   --  system.exp_uns%s
   --  system.exp_uns%b
   --  system.fat_flt%s
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
   --  system.val_enum%s
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
   --  system.val_enum%b
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
   --  ada.exceptions.traceback%s
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
   --  ada.numerics.aux%s
   --  ada.numerics.aux%b
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
   --  interfaces.fortran%s
   --  interfaces.fortran.blas%s
   --  interfaces.fortran.blas%b
   --  interfaces.fortran.lapack%s
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
   --  system.object_reader%s
   --  system.dwarf_lines%s
   --  system.random_numbers%s
   --  ada.numerics.float_random%s
   --  ada.numerics.float_random%b
   --  system.secondary_stack%s
   --  system.regpat%b
   --  interfaces.fortran%b
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
   --  system.dwarf_lines%b
   --  system.object_reader%b
   --  ada.calendar.formatting%b
   --  system.address_image%b
   --  ada.exceptions.traceback%b
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
   --  gnat.traceback%s
   --  gnat.traceback%b
   --  gnat.traceback.symbolic%s
   --  gnat.traceback.symbolic%b
   --  text_io%s
   --  ada_containers%s
   --  ada_containers.aunit_lists%s
   --  aunit%s
   --  aunit.memory%s
   --  aunit.memory%b
   --  aunit%b
   --  aunit.memory.utils%s
   --  aunit.memory.utils%b
   --  ada_containers.aunit_lists%b
   --  aunit.tests%s
   --  aunit.test_filters%s
   --  aunit.options%s
   --  aunit.time_measure%s
   --  aunit.time_measure%b
   --  aunit.test_results%s
   --  aunit.test_results%b
   --  aunit.assertions%s
   --  aunit.assertions%b
   --  aunit.reporter%s
   --  aunit.reporter.text%s
   --  aunit.reporter.text%b
   --  aunit.simple_test_cases%s
   --  aunit.simple_test_cases%b
   --  aunit.test_filters%b
   --  aunit.test_cases%s
   --  aunit.test_cases%b
   --  aunit.test_suites%s
   --  aunit.test_suites%b
   --  aunit.run%s
   --  aunit.run%b
   --  base_model_types%s
   --  calmar%s
   --  calmar%b
   --  data_index%s
   --  inequality_generator%s
   --  line_extractor%s
   --  key_value_io%s
   --  logger%s
   --  numeric_io%s
   --  piecewise_linear_generator%s
   --  piecewise_linear_generator%b
   --  set_of%s
   --  set_of%b
   --  numeric_io%b
   --  t_utils%s
   --  indirect_tax_utils%s
   --  indirect_tax_utils%b
   --  tabulator_commons%s
   --  costs_tabulator%s
   --  poverty_tabulator%s
   --  poverty_tabulator%b
   --  tabulator%s
   --  tax_utils%s
   --  tax_utils%b
   --  text_utils%s
   --  text_utils%b
   --  tabulator%b
   --  costs_tabulator%b
   --  line_extractor%b
   --  data_index%b
   --  base_model_types%b
   --  time_format%s
   --  time_format%b
   --  logger%b
   --  utils%s
   --  format_utils%s
   --  format_utils%b
   --  t_utils%b
   --  key_value_io%b
   --  inequality_generator%b
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
   --  coicop_definitions%s
   --  coicop_definitions%b
   --  za%s
   --  za.ies%s
   --  za.ies%b
   --  za.ies.raw_io%s
   --  za.ies.raw_io%b
   --  za.model_types%s
   --  za.model_types%b
   --  costs_tabulator.wider_io%s
   --  poverty_tabulator.wider_io%s
   --  tabulator.wider_io%s
   --  wider_io_commons%s
   --  wider_io_commons%b
   --  tabulator.wider_io%b
   --  poverty_tabulator.wider_io%b
   --  costs_tabulator.wider_io%b
   --  za.model%s
   --  za.model.params%s
   --  za.model.params%b
   --  za.model.params.defaults%s
   --  za.model.params.defaults%b
   --  za.model.takeup%s
   --  za.model.takeup%b
   --  za.model.settings%s
   --  za.model.settings%b
   --  za.model.data%s
   --  za.model.data%b
   --  za.model.data.binary_io%s
   --  za.model.data.binary_io%b
   --  za.model.data.examples%s
   --  za.model.data.examples%b
   --  za.model.data.tests%s
   --  za.model.data.tests%b
   --  za.model.results%s
   --  za.model.results%b
   --  za.model.calculator%s
   --  za.model.calculator%b
   --  za.model.calculator.budget_constraints%s
   --  za.model.calculator.budget_constraints%b
   --  za.model.calculator.runner%s
   --  za.model.calculator.runner%b
   --  za.model.calculator.tests%s
   --  za.model.calculator.wider_output%s
   --  za.model.calculator.wider_output%b
   --  za.model.calculator.tests%b
   --  za.model_dataset_maker%s
   --  za.model_dataset_maker%b
   --  za.tests%s
   --  za_suite%b
   --  za_harness%b
   --  zm%s
   --  zm.raw%s
   --  za.tests%b
   --  END ELABORATION ORDER


end ada_main;
