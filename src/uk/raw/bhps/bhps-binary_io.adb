with Ada.Text_IO;
with Ada.Assertions;
with Ada.Directories;
with BHPS.Print;

package body BHPS.Binary_IO is  

   use Ada.Assertions;
  
   BASE_DATA_DIR : constant String := "/mnt/data/bhps/bin/";
   SEP : constant Character := '/';
   
   procedure Open( ptrs: out Record_Pointers; wave : Waves ) is
   begin
      case wave is
         when 'a' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
         when 'b' =>
            Childad_IO.Open( ptrs.childad_file, Childad_IO.In_File, BASE_DATA_DIR & wave & SEP & "childad.bin" );
            Childnt_IO.Open( ptrs.childnt_file, Childnt_IO.In_File, BASE_DATA_DIR & wave & SEP & "childnt.bin" );
            Cohabit_IO.Open( ptrs.cohabit_file, Cohabit_IO.In_File, BASE_DATA_DIR & wave & SEP & "cohabit.bin" );
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Lifemst_IO.Open( ptrs.lifemst_file, Lifemst_IO.In_File, BASE_DATA_DIR & wave & SEP & "lifemst.bin" );
            Marriag_IO.Open( ptrs.marriag_file, Marriag_IO.In_File, BASE_DATA_DIR & wave & SEP & "marriag.bin" );
         when 'c' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Lifejob_IO.Open( ptrs.lifejob_file, Lifejob_IO.In_File, BASE_DATA_DIR & wave & SEP & "lifejob.bin" );
         when 'd' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'e' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'f' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'g' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'h' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'i' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'j' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'k' =>
            Childad_IO.Open( ptrs.childad_file, Childad_IO.In_File, BASE_DATA_DIR & wave & SEP & "childad.bin" );
            Childnt_IO.Open( ptrs.childnt_file, Childnt_IO.In_File, BASE_DATA_DIR & wave & SEP & "childnt.bin" );
            Cohabit_IO.Open( ptrs.cohabit_file, Cohabit_IO.In_File, BASE_DATA_DIR & wave & SEP & "cohabit.bin" );
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Lifemst_IO.Open( ptrs.lifemst_file, Lifemst_IO.In_File, BASE_DATA_DIR & wave & SEP & "lifemst.bin" );
            Marriag_IO.Open( ptrs.marriag_file, Marriag_IO.In_File, BASE_DATA_DIR & wave & SEP & "marriag.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'l' =>
            Child_IO.Open( ptrs.child_file, Child_IO.In_File, BASE_DATA_DIR & wave & SEP & "child.bin" );
            Childad_IO.Open( ptrs.childad_file, Childad_IO.In_File, BASE_DATA_DIR & wave & SEP & "childad.bin" );
            Childnt_IO.Open( ptrs.childnt_file, Childnt_IO.In_File, BASE_DATA_DIR & wave & SEP & "childnt.bin" );
            Cohabit_IO.Open( ptrs.cohabit_file, Cohabit_IO.In_File, BASE_DATA_DIR & wave & SEP & "cohabit.bin" );
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Lifemst_IO.Open( ptrs.lifemst_file, Lifemst_IO.In_File, BASE_DATA_DIR & wave & SEP & "lifemst.bin" );
            Marriag_IO.Open( ptrs.marriag_file, Marriag_IO.In_File, BASE_DATA_DIR & wave & SEP & "marriag.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'm' =>
            Child_IO.Open( ptrs.child_file, Child_IO.In_File, BASE_DATA_DIR & wave & SEP & "child.bin" );
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'n' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'o' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'p' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Jobhstd_IO.Open( ptrs.jobhstd_file, Jobhstd_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhstd.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'q' =>
            Child_IO.Open( ptrs.child_file, Child_IO.In_File, BASE_DATA_DIR & wave & SEP & "child.bin" );
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Jobhstd_IO.Open( ptrs.jobhstd_file, Jobhstd_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhstd.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when 'r' =>
            Egoalt_IO.Open( ptrs.egoalt_file, Egoalt_IO.In_File, BASE_DATA_DIR & wave & SEP & "egoalt.bin" );
            Hhresp_IO.Open( ptrs.hhresp_file, Hhresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhresp.bin" );
            Hhsamp_IO.Open( ptrs.hhsamp_file, Hhsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "hhsamp.bin" );
            Income_IO.Open( ptrs.income_file, Income_IO.In_File, BASE_DATA_DIR & wave & SEP & "income.bin" );
            Indall_IO.Open( ptrs.indall_file, Indall_IO.In_File, BASE_DATA_DIR & wave & SEP & "indall.bin" );
            Indresp_IO.Open( ptrs.indresp_file, Indresp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indresp.bin" );
            Indsamp_IO.Open( ptrs.indsamp_file, Indsamp_IO.In_File, BASE_DATA_DIR & wave & SEP & "indsamp.bin" );
            Jobhist_IO.Open( ptrs.jobhist_file, Jobhist_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhist.bin" );
            Jobhstd_IO.Open( ptrs.jobhstd_file, Jobhstd_IO.In_File, BASE_DATA_DIR & wave & SEP & "jobhstd.bin" );
            Youth_IO.Open( ptrs.youth_file, Youth_IO.In_File, BASE_DATA_DIR & wave & SEP & "youth.bin" );
         when others => null;
      end case;
      -- Xivdata_IO.Open( ptrs.xivdata_file, Xivdata_IO.In_File, BASE_DATA_DIR & wave & SEP & "xivdata.bin" );
      -- Xwavedat_IO.Open( ptrs.xwavedat_file, Xwavedat_IO.In_File, BASE_DATA_DIR & 'x' & SEP & "xwavedat.bin" );
      -- Xwaveid_IO.Open( ptrs.xwaveid_file, Xwaveid_IO.In_File, BASE_DATA_DIR & 'x' & SEP & "xwaveid.bin" );
      -- Xwlsten_IO.Open( ptrs.xwlsten_file, Xwlsten_IO.In_File, BASE_DATA_DIR & 'x' & SEP & "xwlsten.bin" );
   end Open;        

   function Bin_Read_Indresp( ptrs : Record_Pointers; which : Positive ) return Indresp_Rec is
      var : Indresp_Rec;
   begin
      Indresp_IO.Read( ptrs.indresp_file, var, Indresp_IO.Count( which ));
      return var;
   end Bin_Read_Indresp;
   

   function Bin_Read_Egoalt( ptrs : Record_Pointers; which : Positive ) return Egoalt_Rec is
      var : Egoalt_Rec;
   begin
      Egoalt_IO.Read( ptrs.egoalt_file, var, Egoalt_IO.Count( which ));
      return var;
   end Bin_Read_Egoalt;


   function Bin_Read_Hhresp( ptrs : Record_Pointers; which : Positive ) return Hhresp_Rec is
      var : Hhresp_Rec;
   begin
      Hhresp_IO.Read( ptrs.hhresp_file, var, Hhresp_IO.Count( which ));
      return var;
   end Bin_Read_Hhresp;


   function Bin_Read_Hhsamp( ptrs : Record_Pointers; which : Positive ) return Hhsamp_Rec is
      var : Hhsamp_Rec;
   begin
      Hhsamp_IO.Read( ptrs.hhsamp_file, var, Hhsamp_IO.Count( which ));
      return var;
   end Bin_Read_Hhsamp;


   function Bin_Read_Income( ptrs : Record_Pointers; which : Positive ) return Income_Rec is
      var : Income_Rec;
   begin
      Income_IO.Read( ptrs.income_file, var, Income_IO.Count( which ));
      return var;
   end Bin_Read_Income;


   function Bin_Read_Indall( ptrs : Record_Pointers; which : Positive ) return Indall_Rec is
      var : Indall_Rec;
   begin
      Indall_IO.Read( ptrs.indall_file, var, Indall_IO.Count( which ));
      return var;
   end Bin_Read_Indall;


   function Bin_Read_Jobhist( ptrs : Record_Pointers; which : Positive ) return Jobhist_Rec is
      var : Jobhist_Rec;
   begin
      Jobhist_IO.Read( ptrs.jobhist_file, var, Jobhist_IO.Count( which ));
      return var;
   end Bin_Read_Jobhist;


   function Bin_Read_Childad( ptrs : Record_Pointers; which : Positive ) return Childad_Rec is
      var : Childad_Rec;
   begin
      Childad_IO.Read( ptrs.childad_file, var, Childad_IO.Count( which ));
      return var;
   end Bin_Read_Childad;


   function Bin_Read_Childnt( ptrs : Record_Pointers; which : Positive ) return Childnt_Rec is
      var : Childnt_Rec;
   begin
      Childnt_IO.Read( ptrs.childnt_file, var, Childnt_IO.Count( which ));
      return var;
   end Bin_Read_Childnt;


   function Bin_Read_Cohabit( ptrs : Record_Pointers; which : Positive ) return Cohabit_Rec is
      var : Cohabit_Rec;
   begin
      Cohabit_IO.Read( ptrs.cohabit_file, var, Cohabit_IO.Count( which ));
      return var;
   end Bin_Read_Cohabit;


   function Bin_Read_Indsamp( ptrs : Record_Pointers; which : Positive ) return Indsamp_Rec is
      var : Indsamp_Rec;
   begin
      Indsamp_IO.Read( ptrs.indsamp_file, var, Indsamp_IO.Count( which ));
      return var;
   end Bin_Read_Indsamp;


   function Bin_Read_Lifemst( ptrs : Record_Pointers; which : Positive ) return Lifemst_Rec is
      var : Lifemst_Rec;
   begin
      Lifemst_IO.Read( ptrs.lifemst_file, var, Lifemst_IO.Count( which ));
      return var;
   end Bin_Read_Lifemst;


   function Bin_Read_Marriag( ptrs : Record_Pointers; which : Positive ) return Marriag_Rec is
      var : Marriag_Rec;
   begin
      Marriag_IO.Read( ptrs.marriag_file, var, Marriag_IO.Count( which ));
      return var;
   end Bin_Read_Marriag;


   function Bin_Read_Lifejob( ptrs : Record_Pointers; which : Positive ) return Lifejob_Rec is
      var : Lifejob_Rec;
   begin
      Lifejob_IO.Read( ptrs.lifejob_file, var, Lifejob_IO.Count( which ));
      return var;
   end Bin_Read_Lifejob;


   function Bin_Read_Youth( ptrs : Record_Pointers; which : Positive ) return Youth_Rec is
      var : Youth_Rec;
   begin
      Youth_IO.Read( ptrs.youth_file, var, Youth_IO.Count( which ));
      return var;
   end Bin_Read_Youth;


   function Bin_Read_Child( ptrs : Record_Pointers; which : Positive ) return Child_Rec is
      var : Child_Rec;
   begin
      Child_IO.Read( ptrs.child_file, var, Child_IO.Count( which ));
      return var;
   end Bin_Read_Child;


   function Bin_Read_Jobhstd( ptrs : Record_Pointers; which : Positive ) return Jobhstd_Rec is
      var : Jobhstd_Rec;
   begin
      Jobhstd_IO.Read( ptrs.jobhstd_file, var, Jobhstd_IO.Count( which ));
      return var;
   end Bin_Read_Jobhstd;


   function Bin_Read_Xwavedat( ptrs : Record_Pointers; which : Positive ) return Xwavedat_Rec is
      var : Xwavedat_Rec;
   begin
      Xwavedat_IO.Read( ptrs.xwavedat_file, var, Xwavedat_IO.Count( which ));
      return var;
   end Bin_Read_Xwavedat;


   function Bin_Read_Xwaveid( ptrs : Record_Pointers; which : Positive ) return Xwaveid_Rec is
      var :Xwaveid_Rec;
   begin
      Xwaveid_IO.Read( ptrs.xwaveid_file, var, Xwaveid_IO.Count( which ));
      return var;
   end Bin_Read_Xwaveid;


   function Bin_Read_Xwlsten( ptrs : Record_Pointers; which : Positive ) return Xwlsten_Rec is
      var :Xwlsten_Rec;
   begin
      Xwlsten_IO.Read( ptrs.xwlsten_file, var, Xwlsten_IO.Count( which ));
      return var;
   end Bin_Read_Xwlsten;

   
   

   procedure Close( ptrs : in out Record_Pointers; wave : Waves ) is
   begin
      case wave is
         when 'a' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
         when 'b' =>
            Childad_IO.Close( ptrs.childad_file );
            Childnt_IO.Close( ptrs.childnt_file );
            Cohabit_IO.Close( ptrs.cohabit_file );
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Lifemst_IO.Close( ptrs.lifemst_file );
            Marriag_IO.Close( ptrs.marriag_file );
         when 'c' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Lifejob_IO.Close( ptrs.lifejob_file );
         when 'd' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'e' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'f' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'g' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'h' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'i' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'j' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'k' =>
            Childad_IO.Close( ptrs.childad_file );
            Childnt_IO.Close( ptrs.childnt_file );
            Cohabit_IO.Close( ptrs.cohabit_file );
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Lifemst_IO.Close( ptrs.lifemst_file );
            Marriag_IO.Close( ptrs.marriag_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'l' =>
            Child_IO.Close( ptrs.child_file );
            Childad_IO.Close( ptrs.childad_file );
            Childnt_IO.Close( ptrs.childnt_file );
            Cohabit_IO.Close( ptrs.cohabit_file );
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Lifemst_IO.Close( ptrs.lifemst_file );
            Marriag_IO.Close( ptrs.marriag_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'm' =>
            Child_IO.Close( ptrs.child_file );
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'n' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'o' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'p' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Jobhstd_IO.Close( ptrs.jobhstd_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'q' =>
            Child_IO.Close( ptrs.child_file );
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Jobhstd_IO.Close( ptrs.jobhstd_file );
            Youth_IO.Close( ptrs.youth_file );
         when 'r' =>
            Egoalt_IO.Close( ptrs.egoalt_file );
            Hhresp_IO.Close( ptrs.hhresp_file );
            Hhsamp_IO.Close( ptrs.hhsamp_file );
            Income_IO.Close( ptrs.income_file );
            Indall_IO.Close( ptrs.indall_file );
            Indresp_IO.Close( ptrs.indresp_file );
            Indsamp_IO.Close( ptrs.indsamp_file );
            Jobhist_IO.Close( ptrs.jobhist_file );
            Jobhstd_IO.Close( ptrs.jobhstd_file );
            Youth_IO.Close( ptrs.youth_file );
         when others => null;
      end case;       
      -- Xivdata_IO.Close( ptrs.xivdata_file );
      -- Xwavedat_IO.Close( ptrs.xwavedat_file );
      -- Xwaveid_IO.Close( ptrs.xwaveid_file );
      -- Xwlsten_IO.Close( ptrs.xwlsten_file );

   end Close; 
   
   procedure Close( ptrs : in out Record_Pointers_Array ) is
   begin
      for wave in Waves_With_Data loop
         Close( ptrs( wave ), wave );
      end loop;
   end Close;
   
   procedure Open( ptrs : out Record_Pointers_Array ) is
   begin
      for wave in Waves_With_Data loop
         Open( ptrs( wave ), wave );
      end loop;
   end Open;
      
   

      
   function Load_Adult( 
      index : Index_Rec;
      ptrs  : Record_Pointers;
      wave  : Waves ) return Adult is
   use Ada.Text_IO;
      ad          : Adult;
      egoalt      : Egoalt_Rec;
      indall      : Indall_Rec;
      indresp     : Indresp_Rec;
      jobhist     : Jobhist_Rec;
      cohabit     : Cohabit_Rec;
      indsamp     : Indsamp_Rec;
      lifemst     : Lifemst_Rec;
      lifejob     : Lifejob_Rec;
      jobhstd     : Jobhstd_Rec;
      child_data  : Child_Rec;   
      youth_data  : Youth_Rec;
      childad     : Childad_Rec; -- adopted
      childnt     : Childnt_Rec;
      income      : Income_Rec;
      file_pos    : Integer;
   begin
      if( index.pointers( indall_component ).counter = 0 )then
         return ad;
      end if;
      Assert( index.pointers( indall_component ).counter = 1, 
       "Must be 1 indall for everyone; was " & 
           Natural'Image( index.pointers( indall_component ).counter ));
      indall := Bin_Read_Indall( ptrs, index.pointers( indall_component ).start_pos );
      -- Put_Line( "allocating person " & indall.pno'Img & " to buno " & indall.buno'Img & " age " &indall.age'Img );
      Assert( indall.pid = index.SERNUM, "indall.pid /= index.SERNUM for seq = " & 
         Sernum_Value'Image( indall.pid ) & " vs " & 
         Sernum_Value'Image( index.SERNUM ));
      if( indall.age >= 0 ) then -- fixme: crude test for 'missing
         ad.age := indall.age;
         ad.pno := indall.pno;
         ad.sex := indall.hgsex;
         ad.pid := indall.pid;
         ad.wave := wave;
         ad.indall := indall;
      else
         return ad;
      end if;
      if( index.pointers( indsamp_component ).start_pos > 0 )then
         indsamp := Bin_Read_Indsamp( ptrs, index.pointers( indsamp_component ).start_pos );
            -- Put_Line( "indsamp.pno = " & Natural'Image( indsamp.pno ));
         ad.indsamp := indsamp;
         Assert( indsamp.pid =
                 ad.pid,
                 "indsamp/indall pno mismatch" & ad.pid'Img & " vs " 
                 & BHPS.Print.To_String( indsamp, 1, 0 ));
      end if;

      if index.pointers( indresp_component ).counter > 0 then
         indresp := Bin_Read_Indresp( ptrs, index.pointers( indresp_component ).start_pos );
         ad.indresp := indresp;
         Assert( indresp.pid =
                 ad.pid,
                 "indresp/indall pno mismatch" );
      end if;
      if index.pointers( cohabit_component ).counter > 0 then
         cohabit := Bin_Read_Cohabit( ptrs, index.pointers( cohabit_component ).start_pos );
         ad.cohabit := cohabit;
         Assert( cohabit.pid =
                 ad.pid,
                 "cohabit/indall pno mismatch" );
      end if;
      if index.pointers( lifemst_component ).counter > 0 then
         lifemst := Bin_Read_Lifemst( ptrs, index.pointers( lifemst_component ).start_pos );
         ad.lifemst := lifemst;
         Assert( lifemst.pid =
                 ad.pid,
                 "lifemst/indall pno mismatch" );
      end if;
      for p in 1 .. index.pointers( lifejob_component ).counter loop
         file_pos := index.pointers( lifejob_component ).start_pos + Integer( p ) - 1;
         lifejob := Bin_Read_Lifejob( ptrs, file_pos );
         ad.num_lifejobs := lifejob.ljseq;
         ad.lifejob( lifejob.ljseq ) := lifejob;
         Assert( lifejob.pid =
                 ad.pid,
                 "lifejob/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( jobhist_component ).counter loop
         file_pos := index.pointers( jobhist_component ).start_pos + Integer( p ) - 1;
         jobhist := Bin_Read_Jobhist( ptrs, file_pos );
         ad.num_jobhists := ad.num_jobhists + 1;
         ad.jobhist( ad.num_jobhists ) := jobhist;
         Assert( jobhist.pid =
                 ad.pid,
                 "jobhist/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( jobhstd_component ).counter loop
         file_pos := index.pointers( jobhstd_component ).start_pos + Integer( p ) - 1;
         jobhstd := Bin_Read_Jobhstd( ptrs, file_pos );
         ad.num_jobhstds := ad.num_jobhstds + 1;
         ad.jobhstd( ad.num_jobhstds ) := jobhstd;
         Assert( jobhstd.pid =
                 ad.pid,
                 "jobhstd/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( income_component ).counter loop
         file_pos := index.pointers( income_component ).start_pos + Integer( p ) - 1;
         income := Bin_Read_Income( ptrs, file_pos );
         ad.num_incomes := ad.num_incomes + 1;
         ad.incomes( ad.num_incomes ) := income;
         Assert( income.pid =
                 ad.pid,
                 "income/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( egoalt_component ).counter loop
         file_pos := index.pointers( egoalt_component ).start_pos + Integer( p ) - 1;
         egoalt := Bin_Read_Egoalt( ptrs, file_pos );
         -- Put_Line( "egoalt.pno = " & Natural'Image( egoalt.pno ));
         ad.num_egoalts := ad.num_egoalts + 1;
         ad.egoalt( ad.num_egoalts ) := egoalt;
         Assert( egoalt.pid =
                 ad.pid,
                 "egoalt/indall pno mismatch" );
      end loop;
      if index.pointers( child_component ).counter > 0 then
         child_data := Bin_Read_Child( ptrs, index.pointers( child_component ).start_pos );
         ad.child_data := child_data;
         Assert( child_data.pid =
                 ad.pid,
                 "child_data/indall pno mismatch" );
      end if;
      if index.pointers( youth_component ).counter > 0 then
         youth_data := Bin_Read_Youth( ptrs, index.pointers( youth_component ).start_pos );
         ad.youth_data := youth_data;
         Assert( youth_data.pid =
                 ad.pid,
                 "youth_data/indall pno mismatch" );
      end if;
      if index.pointers( childad_component ).counter > 0 then
         childad := Bin_Read_Childad( ptrs, index.pointers( childad_component ).start_pos );
         ad.childad := childad;
         -- Put_Line( BHPS.Print.To_String( childad, 1, 0 ));
         Assert( childad.pid =
                 ad.pid,
                 "childad/indall pno mismatch; childad.pid " & childad.pid'Img & 
                 " ad.pid " & ad.pid'Img );
      end if;
      if index.pointers( childnt_component ).counter > 0 then
         childnt := Bin_Read_Childnt( ptrs, index.pointers( childnt_component ).start_pos );
         ad.childnt := childnt;
         Assert( childnt.pid =
                 ad.pid,
                 "childnt/indall pno mismatch" );
      end if;
      return ad;  
   end Load_Adult;
   
   procedure Create_Individual_Indexes is
   use Ada.Text_IO;
   use BHPS_Indexes.BHPS_Index_Package;
   use Ada.Directories;
   begin
      for wave in Waves_With_Data loop
         Put_Line( "Create_Individual_Indexes; on wave " & wave );
         declare
            index_file_name : constant String := "/mnt/data/bhps/bin/" & wave & "/individual_index.bin";
            ptrs : Record_Pointers;
            index_map   : BHPS_Index;
         begin
            Open( ptrs, wave );
            Delete_File( index_file_name );
            Restore_Complete_Index( index_file_name, index_map ); 
            if( Egoalt_IO.Is_Open( ptrs.egoalt_file ))then
               declare
                  egoalt : Egoalt_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     egoalt := Bin_Read_Egoalt( ptrs, p );
                     index := Get_Index( index_map, egoalt.pid );
                     if( index.pointers( egoalt_component ).start_pos = 0 )then
                        index.pointers( egoalt_component ).start_pos := p;
                        index.sernum := egoalt.pid;
                     end if;
                     index.pointers( egoalt_component ).counter := index.pointers( egoalt_component ).counter + 1;  
                     Put_Index( index_map, index );
                     exit when Egoalt_IO.End_Of_File( ptrs.egoalt_file );  
                  end loop;
               end;
            end if;
   
            if( Income_IO.Is_Open( ptrs.income_file ))then
               declare
                  income : Income_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     income := Bin_Read_Income( ptrs, p );
                     index := Get_Index( index_map, income.pid );
                     if( index.pointers( income_component ).start_pos = 0 )then
                        index.pointers( income_component ).start_pos := p;
                        index.sernum := income.pid;
                     end if;
                     index.pointers( income_component ).counter := index.pointers( income_component ).counter + 1;  
                     Put_Index( index_map, index );
                     exit when Income_IO.End_Of_File( ptrs.income_file );  
                  end loop;
               end;
               
            end if;
   
            if( Indall_IO.Is_Open( ptrs.indall_file ))then
               declare
                  indall : Indall_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     indall := Bin_Read_Indall( ptrs, p );
                     index := Get_Index( index_map, indall.pid );
                     index.pointers( indall_component ).start_pos := p;
                     index.pointers( indall_component ).counter := 1;  
                     index.sernum := indall.pid;
                     Put_Index( index_map, index );
                     exit when Indall_IO.End_Of_File( ptrs.indall_file );  
                 end loop;
              end; -- declare
            end if;
            
            if( Indresp_IO.Is_Open( ptrs.indresp_file ))then
               declare
                  indresp : Indresp_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     indresp := Bin_Read_Indresp( ptrs, p );
                     index := Get_Index( index_map, indresp.pid );
                     index.pointers( indresp_component ).start_pos := p;
                     index.pointers( indresp_component ).counter := 1;  
                     index.sernum := indresp.pid;
                     Put_Index( index_map, index );
                     exit when Indresp_IO.End_Of_File( ptrs.indresp_file );  
                 end loop;
              end; -- declare
            end if;
            
            if( Jobhist_IO.Is_Open( ptrs.jobhist_file ))then
               declare
                  jobhist : Jobhist_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     jobhist := Bin_Read_Jobhist( ptrs, p );
                     index := Get_Index( index_map, jobhist.pid );
                     if( index.pointers( jobhist_component ).start_pos = 0 )then
                        index.pointers( jobhist_component ).start_pos := p;
                        index.sernum := jobhist.pid;
                     end if;
                     index.pointers( jobhist_component ).counter := index.pointers( jobhist_component ).counter + 1;  
                     Put_Index( index_map, index );
                     exit when Jobhist_IO.End_Of_File( ptrs.jobhist_file );  
                  end loop;
               end;
            end if;
            
            if( Childad_IO.Is_Open( ptrs.childad_file ))then
               declare
                  childad : Childad_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     childad := Bin_Read_Childad( ptrs, p );
                     index := Get_Index( index_map, childad.pid );
                     index.pointers( childad_component ).start_pos := p;
                     index.pointers( childad_component ).counter := 1;  
                     index.sernum := childad.pid;
                     Put_Index( index_map, index );
                     exit when Childad_IO.End_Of_File( ptrs.childad_file );  
                 end loop;
              end; -- declare
            end if;
            
            if( Childnt_IO.Is_Open( ptrs.childnt_file ))then
               declare
                  childnt : Childnt_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     childnt := Bin_Read_Childnt( ptrs, p );
                     index := Get_Index( index_map, childnt.pid );
                     index.pointers( childnt_component ).start_pos := p;
                     index.pointers( childnt_component ).counter := 1;  
                     index.sernum := childnt.pid;
                     Put_Index( index_map, index );
                     exit when Childnt_IO.End_Of_File( ptrs.childnt_file );  
                 end loop;
              end; -- declare

            end if;
            
            if( Cohabit_IO.Is_Open( ptrs.cohabit_file ))then
               declare
                  cohabit : Cohabit_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     cohabit := Bin_Read_Cohabit( ptrs, p );
                     index := Get_Index( index_map, cohabit.pid );
                     index.pointers( cohabit_component ).start_pos := p;
                     index.pointers( cohabit_component ).counter := 1;  
                     index.sernum := cohabit.pid;
                     Put_Index( index_map, index );
                     exit when Cohabit_IO.End_Of_File( ptrs.cohabit_file );  
                 end loop;
              end; -- declare

            end if;
            
            if( Indsamp_IO.Is_Open( ptrs.indsamp_file ))then
               declare
                  indsamp : Indsamp_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     indsamp := Bin_Read_Indsamp( ptrs, p );
                     index := Get_Index( index_map, indsamp.pid );
                     index.pointers( indsamp_component ).start_pos := p;
                     index.pointers( indsamp_component ).counter := 1;  
                     index.sernum := indsamp.pid;
                     Put_Index( index_map, index );
                     exit when Indsamp_IO.End_Of_File( ptrs.indsamp_file );  
                 end loop;
              end; -- declare

            end if;
            
            if( Lifemst_IO.Is_Open( ptrs.lifemst_file ))then
               declare
                  lifemst : Lifemst_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     lifemst := Bin_Read_Lifemst( ptrs, p );
                     index := Get_Index( index_map, lifemst.pid );
                     index.pointers( lifemst_component ).start_pos := p;
                     index.pointers( lifemst_component ).counter := 1;  
                     index.sernum := lifemst.pid;
                     Put_Index( index_map, index );
                     exit when Lifemst_IO.End_Of_File( ptrs.lifemst_file );  
                 end loop;
              end; -- declare
               
            end if;
            
            if( Marriag_IO.Is_Open( ptrs.marriag_file ))then
               declare
                  marriag : Marriag_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     marriag := Bin_Read_Marriag( ptrs, p );
                     index := Get_Index( index_map, marriag.pid );
                     index.pointers( marriag_component ).start_pos := p;
                     index.pointers( marriag_component ).counter := 1;  
                     index.sernum := marriag.pid;
                     Put_Index( index_map, index );
                     exit when Marriag_IO.End_Of_File( ptrs.marriag_file );  
                 end loop;
              end; -- declare

            end if;
            
            if( Lifejob_IO.Is_Open( ptrs.lifejob_file ))then
               declare
                  lifejob : Lifejob_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     lifejob := Bin_Read_Lifejob( ptrs, p );
                     index := Get_Index( index_map, lifejob.pid );
                     if( index.pointers( lifejob_component ).start_pos = 0 )then
                        index.pointers( lifejob_component ).start_pos := p;
                        index.sernum := lifejob.pid;
                     end if;
                     index.pointers( lifejob_component ).counter := index.pointers( lifejob_component ).counter + 1;  
                     Put_Index( index_map, index );
                     exit when Lifejob_IO.End_Of_File( ptrs.lifejob_file );  
                  end loop;
               end;
            end if;
            
            if( Youth_IO.Is_Open( ptrs.youth_file ))then
               declare
                  youth : Youth_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     youth := Bin_Read_Youth( ptrs, p );
                     index := Get_Index( index_map, youth.pid );
                     index.pointers( youth_component ).start_pos := p;
                     index.pointers( youth_component ).counter := 1;  
                     index.sernum := youth.pid;
                     Put_Index( index_map, index );
                     exit when Youth_IO.End_Of_File( ptrs.youth_file );  
                 end loop;
              end; -- declare
            end if;
            
            if( Child_IO.Is_Open( ptrs.child_file ))then
               declare
                  child : Child_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     child := Bin_Read_Child( ptrs, p );
                     index := Get_Index( index_map, child.pid );
                     index.pointers( child_component ).start_pos := p;
                     index.pointers( child_component ).counter := 1;  
                     index.sernum := child.pid;
                     Put_Index( index_map, index );
                     exit when Child_IO.End_Of_File( ptrs.child_file );  
                 end loop;
              end; -- declare
            end if;
            
            if( Jobhstd_IO.Is_Open( ptrs.jobhstd_file ))then
               declare
                  jobhstd : Jobhstd_Rec;
                  p      : Natural := 0;
                  index  : Index_Rec;
               begin
                  loop
                     p := p + 1;
                     jobhstd := Bin_Read_Jobhstd( ptrs, p );
                     index := Get_Index( index_map, jobhstd.pid );
                     if( index.pointers( jobhstd_component ).start_pos = 0 )then
                        index.pointers( jobhstd_component ).start_pos := p;
                        index.sernum := jobhstd.pid;
                     end if;
                     index.pointers( jobhstd_component ).counter := index.pointers( jobhstd_component ).counter + 1;  
                     Put_Index( index_map, index );
                     exit when Jobhstd_IO.End_Of_File( ptrs.jobhstd_file );  
                  end loop;
               end;
            end if;
            Close( ptrs, wave );
            Store_Complete_Index( index_file_name, index_map );
         end; -- declares
      end loop;
   end Create_Individual_Indexes;
   

   function Load_Household( 
      index : Index_Rec;
      ptrs  : Record_Pointers;
      wave  : Waves ) return Household is
   use Ada.Text_IO;
      
      hh          : Household;
      ad          : Adult;
      egoalt      : Egoalt_Rec;
      indall      : Indall_Rec;
      indresp     : Indresp_Rec;
      jobhist     : Jobhist_Rec;
      cohabit     : Cohabit_Rec;
      indsamp     : Indsamp_Rec;
      lifemst     : Lifemst_Rec;
      lifejob     : Lifejob_Rec;
      jobhstd     : Jobhstd_Rec;
      child_data  : Child_Rec;   
      youth_data  : Youth_Rec;
      childad     : Childad_Rec; -- adopted
      childnt     : Childnt_Rec;
      income      : Income_Rec;
      file_pos    : Integer;
   begin
      Assert( index.pointers( hhsamp_component ).counter = 1,
         " hhsamp_component pointer should be 1 was " & 
         Integer'Image( index.pointers( hhsamp_component ).counter )); 
      hh.hhsamp := Bin_Read_hhsamp( ptrs, index.pointers( hhsamp_component ).start_pos );
      if( index.pointers( hhresp_component ).counter = 1 )then
         -- hhlds with a hsamp but no hresp are non-responsive households;
         -- as far as I understand this
         hh.hhresp := Bin_Read_HHresp( ptrs, index.pointers( hhresp_component ).start_pos );
         hh.hid := hh.hhresp.hid;
      else
         return hh;
      end if;  
      for p in 1 .. index.pointers( indall_component ).counter loop
         file_pos := index.pointers( indall_component ).start_pos + Integer( p ) - 1;
         indall := Bin_Read_Indall( ptrs, file_pos );
         -- Put_Line( "allocating person " & indall.pno'Img & " to buno " & indall.buno'Img & " age " &indall.age'Img );
         Assert( indall.hid = index.SERNUM, "indall.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( indall.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         if( indall.age >= 0 ) then -- fixme: crude test for 'missing
            ad.age := indall.age;
            ad.pno := indall.pno;
            ad.pid := indall.pid;
            ad.wave := wave;
            ad.indall := indall;
            hh.people.Insert( ad.pno, ad );
         end if;
         hh.people_pos( p ) := ad.pno;
      end loop;
      for p in 1 .. index.pointers( indsamp_component ).counter loop
         file_pos := index.pointers( indsamp_component ).start_pos + Integer( p ) - 1;
         indsamp := Bin_Read_Indsamp( ptrs, file_pos );
         if( hh.people.Contains( indsamp.pno ))then
            Assert( indsamp.hid = index.SERNUM, "indsamp.hid /= index.SERNUM for seq = " & 
               Sernum_Value'Image( indsamp.hid ) & " vs " & 
               Sernum_Value'Image( index.SERNUM ));
            -- Put_Line( "indsamp.pno = " & Natural'Image( indsamp.pno ));
            ad := hh.people.Element( indsamp.pno );
            ad.indsamp := indsamp;
            hh.people.Replace(  indsamp.pno, ad );
            Assert( indsamp.pid =
                    ad.pid,
                    "indsamp/indall pno mismatch" );
         end if;
      end loop;
      for p in 1 .. index.pointers( indresp_component ).counter loop
         file_pos := index.pointers( indresp_component ).start_pos + Integer( p ) - 1;
         indresp := Bin_Read_Indresp( ptrs, file_pos );
         Assert( indresp.hid = index.SERNUM, "indresp.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( indresp.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "indresp.pno = " & Natural'Image( indresp.pno ));
         ad := hh.people.Element( indresp.pno );
         ad.indresp := indresp;
         hh.people.Replace(  indresp.pno, ad );
         Assert( indresp.pid =
                 ad.pid,
                 "indresp/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( cohabit_component ).counter loop
         file_pos := index.pointers( cohabit_component ).start_pos + Integer( p ) - 1;
         cohabit := Bin_Read_Cohabit( ptrs, file_pos );
         Assert( cohabit.hid = index.SERNUM, "cohabit.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( cohabit.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "cohabit.pno = " & Natural'Image( cohabit.pno ));
         ad := hh.people.Element( cohabit.pno );
         ad.cohabit := cohabit;
         hh.people.Replace(  cohabit.pno, ad );
         Assert( cohabit.pid =
                 ad.pid,
                 "cohabit/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( lifemst_component ).counter loop
         file_pos := index.pointers( lifemst_component ).start_pos + Integer( p ) - 1;
         lifemst := Bin_Read_Lifemst( ptrs, file_pos );
         Assert( lifemst.hid = index.SERNUM, "lifemst.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( lifemst.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "lifemst.pno = " & Natural'Image( lifemst.pno ));
         ad := hh.people.Element( lifemst.pno );
         ad.lifemst := lifemst;
         hh.people.Replace(  lifemst.pno, ad );
         Assert( lifemst.pid =
                 ad.pid,
                 "lifemst/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( lifejob_component ).counter loop
         file_pos := index.pointers( lifejob_component ).start_pos + Integer( p ) - 1;
         lifejob := Bin_Read_Lifejob( ptrs, file_pos );
         Assert( lifejob.hid = index.SERNUM, "lifejob.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( lifejob.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "lifejob.pno = " & Natural'Image( lifejob.pno ));
         ad := hh.people.Element( lifejob.pno );
         -- Put_Line( "lifejob.ljseq " & lifejob.ljseq'Img );
         ad.num_lifejobs := lifejob.ljseq;
         ad.lifejob( lifejob.ljseq ) := lifejob;
         hh.people.Replace( lifejob.pno, ad );
         Assert( lifejob.pid =
                 ad.pid,
                 "lifejob/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( jobhist_component ).counter loop
         file_pos := index.pointers( jobhist_component ).start_pos + Integer( p ) - 1;
         jobhist := Bin_Read_Jobhist( ptrs, file_pos );
         Assert( jobhist.hid = index.SERNUM, "jobhist.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( jobhist.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "jobhist.pno = " & Natural'Image( jobhist.pno ));
         ad := hh.people.Element( jobhist.pno );
         -- Put_Line( "jobhist.jspno " & jobhist.jspno'Img );
         ad.num_jobhists := ad.num_jobhists + 1;
         ad.jobhist( ad.num_jobhists ) := jobhist;
         hh.people.Replace( jobhist.pno, ad );
         Assert( jobhist.pid =
                 ad.pid,
                 "jobhist/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( jobhstd_component ).counter loop
         file_pos := index.pointers( jobhstd_component ).start_pos + Integer( p ) - 1;
         jobhstd := Bin_Read_Jobhstd( ptrs, file_pos );
         Assert( jobhstd.hid = index.SERNUM, "jobhstd.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( jobhstd.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "jobhstd.pno = " & Natural'Image( jobhstd.pno ));
         ad := hh.people.Element( jobhstd.pno );
         -- Put_Line( "jobhstd.jspno " & jobhstd.jspno'Img );
         ad.num_jobhstds := ad.num_jobhstds + 1;
         ad.jobhstd( ad.num_jobhstds ) := jobhstd;
         
         hh.people.Replace( jobhstd.pno, ad );
         Assert( jobhstd.pid =
                 ad.pid,
                 "jobhstd/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( income_component ).counter loop
         file_pos := index.pointers( income_component ).start_pos + Integer( p ) - 1;
         income := Bin_Read_Income( ptrs, file_pos );
         Assert( income.hid = index.SERNUM, "income.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( income.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "income.pno = " & Natural'Image( income.pno ));
         ad := hh.people.Element( income.pno );
         -- Put_Line( "income.fiseq " & income.fiseq'Img );
         ad.num_incomes := ad.num_incomes + 1;
         ad.incomes( ad.num_incomes ) := income;
         hh.people.Replace( income.pno, ad );
         Assert( income.pid =
                 ad.pid,
                 "income/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( egoalt_component ).counter loop
         file_pos := index.pointers( egoalt_component ).start_pos + Integer( p ) - 1;
         egoalt := Bin_Read_Egoalt( ptrs, file_pos );
         Assert( egoalt.hid = index.SERNUM, "egoalt.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( egoalt.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "egoalt.pno = " & Natural'Image( egoalt.pno ));
         -- egoalts sometimes exist for people rejected for having
         -- missing ages / bunos above, so we need this check here
         if( hh.people.Contains( egoalt.pno ))then
            ad := hh.people.Element( egoalt.pno );
            -- Put_Line( "egoalt.pno " & egoalt.pno'Img );
            ad.num_egoalts := ad.num_egoalts + 1;
            ad.egoalt( ad.num_egoalts ) := egoalt;
            hh.people.Replace( egoalt.pno, ad );
            Assert( egoalt.pid =
                    ad.pid,
                    "egoalt/indall pno mismatch" );
         end if;
      end loop;
      for p in 1 .. index.pointers( child_component ).counter loop
         file_pos := index.pointers( child_component ).start_pos + Integer( p ) - 1;
         child_data := Bin_Read_Child( ptrs, file_pos );
         Assert( child_data.hid = index.SERNUM, "child_data.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( child_data.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "child_data.pno = " & Natural'Image( child_data.pno ));
         ad := hh.people.Element( child_data.pno );
         ad.child_data := child_data;
         hh.people.Replace( child_data.pno, ad );
         Assert( child_data.pid =
                 ad.pid,
                 "child_data/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( youth_component ).counter loop
         file_pos := index.pointers( youth_component ).start_pos + Integer( p ) - 1;
         youth_data := Bin_Read_Youth( ptrs, file_pos );
         Assert( youth_data.hid = index.SERNUM, "youth_data.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( youth_data.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "youth_data.pno = " & Natural'Image( youth_data.pno ));
         ad := hh.people.Element( youth_data.pno );
         ad.youth_data := youth_data;
         hh.people.Replace( youth_data.pno, ad );
         Assert( youth_data.pid =
                 ad.pid,
                 "youth_data/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( childad_component ).counter loop
         file_pos := index.pointers( childad_component ).start_pos + Integer( p ) - 1;
         childad := Bin_Read_Childad( ptrs, file_pos );
         Assert( childad.hid = index.SERNUM, "childad.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( childad.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "childad.pno = " & Natural'Image( childad.pno ));
         ad := hh.people.Element( childad.pno );
         ad.childad := childad;
         hh.people.Replace( childad.pno, ad );
         Assert( childad.pid =
                 ad.pid,
                 "childad/indall pno mismatch" );
      end loop;
      for p in 1 .. index.pointers( childnt_component ).counter loop
         file_pos := index.pointers( childnt_component ).start_pos + Integer( p ) - 1;
         childnt := Bin_Read_Childnt( ptrs, file_pos );
         Assert( childnt.hid = index.SERNUM, "childnt.hid /= index.SERNUM for seq = " & 
            Sernum_Value'Image( childnt.hid ) & " vs " & 
            Sernum_Value'Image( index.SERNUM ));
         -- Put_Line( "childnt.pno = " & Natural'Image( childnt.pno ));
         ad := hh.people.Element( childnt.pno );
         ad.childnt := childnt;
         hh.people.Replace( childnt.pno, ad );
         Assert( childnt.pid =
                 ad.pid,
                 "childnt/indall pno mismatch" );
      end loop;
      Allocate_Household_Members( hh, wave ); 
      return hh;
   end Load_Household;
   
  function Load_XWave return BHPS.XLookup.X_Wave_Lookup is
     use BHPS.XLookup;
     use Xwaveid_IO;
     xwavel : X_Wave_Lookup;
     file : File_Type;
     xw : Xwaveid_Rec;
  begin
     Open( file, In_File, BASE_DATA_DIR & 'x' & SEP & "xwaveid.bin" );
     for p in 1 .. Size( file ) loop
        Read( file, xw );
        xwavel.Add_Record( xw );
     end loop;
     Close( file );
     return xwavel;
  end  Load_XWave;
   
end BHPS.Binary_IO;
