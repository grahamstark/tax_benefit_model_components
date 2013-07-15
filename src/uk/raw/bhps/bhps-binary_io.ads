with Ada.Direct_IO;
with BHPS.XLookup;
package BHPS.Binary_IO is

   type Record_Pointers is limited private;
   type Record_Pointers_Array is array( Waves_With_Data ) of Record_Pointers;
   
   procedure Open( ptrs : out Record_Pointers; wave : Waves );
   
   procedure Open( ptrs : out Record_Pointers_Array );
   
   procedure Close( ptrs : in out Record_Pointers; wave : Waves );
   procedure Close( ptrs : in out Record_Pointers_Array );

   function Load_XWave return BHPS.XLookup.X_Wave_Lookup;
   

   function Bin_Read_Indresp( ptrs : Record_Pointers; which : Positive ) return Indresp_Rec;
   function Bin_Read_Egoalt( ptrs : Record_Pointers; which : Positive ) return Egoalt_Rec;
   function Bin_Read_Hhresp( ptrs : Record_Pointers; which : Positive ) return Hhresp_Rec;
   function Bin_Read_Hhsamp( ptrs : Record_Pointers; which : Positive ) return Hhsamp_Rec;
   function Bin_Read_Income( ptrs : Record_Pointers; which : Positive ) return Income_Rec;
   function Bin_Read_Indall( ptrs : Record_Pointers; which : Positive ) return Indall_Rec;
   function Bin_Read_Jobhist( ptrs : Record_Pointers; which : Positive ) return Jobhist_Rec;
   function Bin_Read_Childad( ptrs : Record_Pointers; which : Positive ) return Childad_Rec;
   function Bin_Read_Childnt( ptrs : Record_Pointers; which : Positive ) return Childnt_Rec;
   function Bin_Read_Cohabit( ptrs : Record_Pointers; which : Positive ) return Cohabit_Rec;
   function Bin_Read_Indsamp( ptrs : Record_Pointers; which : Positive ) return Indsamp_Rec;
   function Bin_Read_Lifemst( ptrs : Record_Pointers; which : Positive ) return Lifemst_Rec;
   function Bin_Read_Marriag( ptrs : Record_Pointers; which : Positive ) return Marriag_Rec;
   function Bin_Read_Lifejob( ptrs : Record_Pointers; which : Positive ) return Lifejob_Rec;
   function Bin_Read_Youth( ptrs : Record_Pointers; which : Positive ) return Youth_Rec;
   function Bin_Read_Child( ptrs : Record_Pointers; which : Positive ) return Child_Rec;
   function Bin_Read_Jobhstd( ptrs : Record_Pointers; which : Positive ) return Jobhstd_Rec;
   function Bin_Read_Xwavedat( ptrs : Record_Pointers; which : Positive ) return Xwavedat_Rec;
   function Bin_Read_Xwaveid( ptrs : Record_Pointers; which : Positive ) return Xwaveid_Rec;
   function Bin_Read_Xwlsten( ptrs : Record_Pointers; which : Positive ) return Xwlsten_Rec;
   
   function Load_Household( 
      index : Index_Rec;
      ptrs  : Record_Pointers;
      wave  : Waves ) return Household;
      
   function Load_Adult( 
      index : Index_Rec;
      ptrs  : Record_Pointers;
      wave  : Waves ) return Adult;
      
   procedure Create_Individual_Indexes;

private

   package Egoalt_IO   is new Ada.Direct_IO( Egoalt_Rec );
   package Hhresp_IO   is new Ada.Direct_IO( Hhresp_Rec );
   package Hhsamp_IO   is new Ada.Direct_IO( Hhsamp_Rec );
   package Income_IO   is new Ada.Direct_IO( Income_Rec );
   package Indall_IO   is new Ada.Direct_IO( Indall_Rec );
   package Indresp_IO  is new Ada.Direct_IO( Indresp_Rec );
   package Jobhist_IO  is new Ada.Direct_IO( Jobhist_Rec );
   package Childad_IO  is new Ada.Direct_IO( Childad_Rec );
   package Childnt_IO  is new Ada.Direct_IO( Childnt_Rec );
   package Cohabit_IO  is new Ada.Direct_IO( Cohabit_Rec );
   package Indsamp_IO  is new Ada.Direct_IO( Indsamp_Rec );
   package Lifemst_IO  is new Ada.Direct_IO( Lifemst_Rec );
   package Marriag_IO  is new Ada.Direct_IO( Marriag_Rec );
   package Lifejob_IO  is new Ada.Direct_IO( Lifejob_Rec );
   package Youth_IO    is new Ada.Direct_IO( Youth_Rec );
   package Child_IO    is new Ada.Direct_IO( Child_Rec );
   package Jobhstd_IO  is new Ada.Direct_IO( Jobhstd_Rec );
   package Xivdata_IO  is new Ada.Direct_IO( Xivdata_Rec );
   package Xwavedat_IO is new Ada.Direct_IO( Xwavedat_Rec );
   package Xwaveid_IO  is new Ada.Direct_IO( Xwaveid_Rec );
   package Xwlsten_IO  is new Ada.Direct_IO( Xwlsten_Rec );
   
   type Record_Pointers is record
      egoalt_file   : Egoalt_IO.File_Type;
      hhresp_file   : Hhresp_IO.File_Type;
      hhsamp_file   : Hhsamp_IO.File_Type;
      income_file   : Income_IO.File_Type;
      indall_file   : Indall_IO.File_Type;
      indresp_file  : Indresp_IO.File_Type;
      jobhist_file  : Jobhist_IO.File_Type;
      childad_file  : Childad_IO.File_Type;
      childnt_file  : Childnt_IO.File_Type;
      cohabit_file  : Cohabit_IO.File_Type;
      indsamp_file  : Indsamp_IO.File_Type;
      lifemst_file  : Lifemst_IO.File_Type;
      marriag_file  : Marriag_IO.File_Type;
      lifejob_file  : Lifejob_IO.File_Type;
      youth_file    : Youth_IO.File_Type;
      child_file    : Child_IO.File_Type;
      jobhstd_file  : Jobhstd_IO.File_Type;
      xivdata_file  : Xivdata_IO.File_Type;
      xwavedat_file : Xwavedat_IO.File_Type;
      xwaveid_file  : Xwaveid_IO.File_Type;
      xwlsten_file  : Xwlsten_IO.File_Type;
   end record;
   
   type All_Years_Pointers is array( Waves_With_Data ) of Record_Pointers;
   
end BHPS.Binary_IO;
