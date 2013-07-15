package BHPS.Print is
   
   function Format( v : Sernum_Value ) return String;


   function To_String( a : Egoalt_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Hhresp_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Hhsamp_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Income_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Indall_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Indresp_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Jobhist_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Childad_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Childnt_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Cohabit_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Indsamp_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Lifemst_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Marriag_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Lifejob_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Youth_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Child_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Jobhstd_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Xivdata_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Xwavedat_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Xwaveid_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;

   function To_String( a : Xwlsten_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;


end BHPS.Print;
