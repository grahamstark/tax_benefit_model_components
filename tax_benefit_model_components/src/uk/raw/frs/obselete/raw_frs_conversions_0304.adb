--
--  $Author: graham_s $
--  $Date: 2011-02-25 14:55:37 +0000 (Fri, 25 Feb 2011) $
--  $Revision: 11107 $
--

with Base_Model_Types; use Base_Model_Types;
with raw_frs;          use raw_frs;
--
--  change these to 0203/0304 as needed; make sure to comment out loadVehicle in 0203
--
with FRS_Reader_0304;  use FRS_Reader_0304;
with frs_binary_reads; use frs_binary_reads;
with Conversions.FRS;        use Conversions.FRS;

with Ada.Text_IO; use Ada.Text_IO;

--
--  Conversion routine for frs data to binary
--  change _0304 to _0203 above as needed, and call write_everything_in_binary from somewhere.
--  For 0203, remove the call to Vehicles below as that data is not there.
--  Note that 0304 needs Takeup loads commented back in!!
--
package body raw_frs_conversions_0304 is

   procedure Write_Adults_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Adult_io.File_Type;
      adult   : Adult_Rec;
   begin
      Ada.Text_IO.Put ("opening |" & DATA_DIR & "Adult.dat" & "| OK");
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Adult.dat");

      Adult_io.Create (outfile, Adult_io.Out_File, DATA_DIR & "Adult.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         adult := loadAdult (infile);
         Ada.Text_IO.Put
           ("adult.sernum " &
            String (adult.SERNUM) &
            " tu " &
            adult.BENUNIT'Img &
            " person " &
            adult.PERSON'Img);
         Ada.Text_IO.New_Line;

         bin_write_Adult (outfile, adult);
      end loop;
      Ada.Text_IO.Close (infile);
      Adult_io.Close (outfile);

   end Write_Adults_In_Binary;

   procedure Write_Account_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Account_io.File_Type;
      account : Account_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Account.dat");
      Account_io.Create (outfile, Account_io.Out_File, DATA_DIR & "Account.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         account := loadAccount (infile);
         Ada.Text_IO.Put
           ("Accounts.sernum " &
            String (account.SERNUM) &
            " tu " &
            account.BENUNIT'Img &
            " person " &
            account.PERSON'Img);
         Ada.Text_IO.New_Line;

         bin_write_Account (outfile, account);
      end loop;
      Ada.Text_IO.Close (infile);
      Account_io.Close (outfile);

   end Write_Account_In_Binary;

   procedure Write_Asset_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Asset_io.File_Type;
      asset   : Asset_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Asset.dat");
      Asset_io.Create (outfile, Asset_io.Out_File, DATA_DIR & "Asset.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         asset := loadAsset (infile);
         Ada.Text_IO.Put
           ("Assets.sernum " &
            String (asset.SERNUM) &
            " tu " &
            asset.BENUNIT'Img &
            " person " &
            asset.PERSON'Img);
         Ada.Text_IO.New_Line;

         bin_write_Asset (outfile, asset);
      end loop;
      Ada.Text_IO.Close (infile);
      Asset_io.Close (outfile);

   end Write_Asset_In_Binary;

   procedure Write_BenUnit_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Benunit_io.File_Type;
      benunit : Benunit_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Benunit.dat");
      Benunit_io.Create (outfile, Benunit_io.Out_File, DATA_DIR & "Benunit.bin");
      Ada.Text_IO.Put ("Write_BenUnit_In_Binary; files opened ok ");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         Ada.Text_IO.Put ("loading benefit unit ");
         benunit := loadBenunit (infile);
         Ada.Text_IO.Put
           ("Benunits.sernum " & String (benunit.SERNUM) & " tu " & benunit.BENUNIT'Img);
         Ada.Text_IO.New_Line;

         bin_write_Benunit (outfile, benunit);
      end loop;
      Ada.Text_IO.Close (infile);
      Benunit_io.Close (outfile);

   end Write_BenUnit_In_Binary;

   procedure Write_Benefits_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Benefit_io.File_Type;
      benefit : Benefit_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Benefit.dat");
      Benefit_io.Create (outfile, Benefit_io.Out_File, DATA_DIR & "Benefit.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         benefit := loadBenefit (infile);
         Ada.Text_IO.Put
           ("Benunits.sernum " &
            String (benefit.SERNUM) &
            " tu " &
            benefit.BENUNIT'Img &
            " person " &
            benefit.PERSON'Img);
         Ada.Text_IO.New_Line;

         bin_write_Benefit (outfile, benefit);
      end loop;
      Ada.Text_IO.Close (infile);
      Benefit_io.Close (outfile);

   end Write_Benefits_In_Binary;

   procedure Write_Care_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Care_io.File_Type;
      care    : Care_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Care.dat");
      Care_io.Create (outfile, Care_io.Out_File, DATA_DIR & "Care.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         care := loadCare (infile);
         Ada.Text_IO.Put ("Care.sernum " & String (care.SERNUM) & " tu " & care.BENUNIT'Img);
         Ada.Text_IO.New_Line;

         bin_write_Care (outfile, care);
      end loop;
      Ada.Text_IO.Close (infile);
      Care_io.Close (outfile);

   end Write_Care_In_Binary;

   procedure Write_Child_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Child_io.File_Type;
      child   : Child_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Child.dat");
      Child_io.Create (outfile, Child_io.Out_File, DATA_DIR & "Child.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         child := loadChild (infile);
         Ada.Text_IO.Put ("Child.sernum " & String (child.SERNUM) & " tu " & child.BENUNIT'Img);
         Ada.Text_IO.New_Line;

         bin_write_Child (outfile, child);
      end loop;
      Ada.Text_IO.Close (infile);
      Child_io.Close (outfile);

   end Write_Child_In_Binary;

   procedure Write_Endowment_In_Binary is
      infile    : Ada.Text_IO.File_Type;
      outfile   : Endowment_io.File_Type;
      endowment : Endowment_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Endowment.dat");
      Endowment_io.Create (outfile, Endowment_io.Out_File, DATA_DIR & "Endowment.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         endowment := loadEndowment (infile);
         Ada.Text_IO.Put ("Endowment.sernum " & String (endowment.SERNUM));
         Ada.Text_IO.New_Line;

         bin_write_Endowment (outfile, endowment);
      end loop;
      Ada.Text_IO.Close (infile);
      Endowment_io.Close (outfile);

   end Write_Endowment_In_Binary;

   procedure Write_ExtChild_In_Binary is
      infile   : Ada.Text_IO.File_Type;
      outfile  : ExtChild_io.File_Type;
      extChild : ExtChild_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "ExtChild.dat");
      ExtChild_io.Create (outfile, ExtChild_io.Out_File, DATA_DIR & "ExtChild.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         extChild := loadExtChild (infile);
         Ada.Text_IO.Put
           ("Benunits.sernum " & String (extChild.SERNUM) & " tu " & extChild.BENUNIT'Img);
         Ada.Text_IO.New_Line;

         bin_write_ExtChild (outfile, extChild);
      end loop;
      Ada.Text_IO.Close (infile);
      ExtChild_io.Close (outfile);

   end Write_ExtChild_In_Binary;

   procedure Write_GovPay_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : GovPay_io.File_Type;
      GovPay  : GovPay_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "GovPay.dat");
      GovPay_io.Create (outfile, GovPay_io.Out_File, DATA_DIR & "GovPay.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         GovPay := loadGovPay (infile);
         Ada.Text_IO.Put ("Benunits.sernum " & String (GovPay.SERNUM) & " tu " & GovPay.BENUNIT'Img);
         Ada.Text_IO.New_Line;

         bin_write_GovPay (outfile, GovPay);
      end loop;
      Ada.Text_IO.Close (infile);
      GovPay_io.Close (outfile);

   end Write_GovPay_In_Binary;

   procedure Write_Household_In_Binary is
      infile    : Ada.Text_IO.File_Type;
      outfile   : Household_io.File_Type;
      household : Household_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Household.dat");
      Household_io.Create (outfile, Household_io.Out_File, DATA_DIR & "Household.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         household := loadHousehold (infile);
         Ada.Text_IO.Put ("Household.sernum " & String (household.SERNUM));
         Ada.Text_IO.New_Line;

         bin_write_Household (outfile, household);
      end loop;
      Ada.Text_IO.Close (infile);
      Household_io.Close (outfile);

   end Write_Household_In_Binary;

   procedure Write_Insurance_In_Binary is
      infile    : Ada.Text_IO.File_Type;
      outfile   : Insurance_io.File_Type;
      insurance : Insurance_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Insurance.dat");
      Insurance_io.Create (outfile, Insurance_io.Out_File, DATA_DIR & "Insurance.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         insurance := loadInsurance (infile);
         Ada.Text_IO.Put ("Insurance.sernum " & String (insurance.SERNUM));
         Ada.Text_IO.New_Line;

         bin_write_Insurance (outfile, insurance);
      end loop;
      Ada.Text_IO.Close (infile);
      Insurance_io.Close (outfile);

   end Write_Insurance_In_Binary;

   procedure Write_Job_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Job_io.File_Type;
      job     : Job_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Job.dat");
      Job_io.Create (outfile, Job_io.Out_File, DATA_DIR & "Job.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         job := loadJob (infile);
         Ada.Text_IO.Put ("Job.sernum " & String (job.SERNUM));
         Ada.Text_IO.New_Line;

         bin_write_Job (outfile, job);
      end loop;
      Ada.Text_IO.Close (infile);
      Job_io.Close (outfile);

   end Write_Job_In_Binary;

   procedure Write_Maint_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Maint_IO.File_Type;
      maint   : Maint_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Maint.dat");
      Maint_IO.Create (outfile, Maint_IO.Out_File, DATA_DIR & "Maint.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         maint := loadMaint (infile);
         Ada.Text_IO.Put ("Maint.sernum " & String (maint.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Maint (outfile, maint);
      end loop;
      Ada.Text_IO.Close (infile);
      Maint_IO.Close (outfile);

   end Write_Maint_In_Binary;

   procedure Write_MortCont_In_Binary is
      infile   : Ada.Text_IO.File_Type;
      outfile  : MortCont_io.File_Type;
      MortCont : MortCont_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "MortCont.dat");
      MortCont_io.Create (outfile, MortCont_io.Out_File, DATA_DIR & "MortCont.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         MortCont := loadMortCont (infile);
         Ada.Text_IO.Put ("MortCont.sernum " & String (MortCont.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_MortCont (outfile, MortCont);
      end loop;
      Ada.Text_IO.Close (infile);
      MortCont_io.Close (outfile);

   end Write_MortCont_In_Binary;

   procedure Write_Mortgage_In_Binary is
      infile   : Ada.Text_IO.File_Type;
      outfile  : Mortgage_io.File_Type;
      mortgage : Mortgage_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Mortgage.dat");
      Mortgage_io.Create (outfile, Mortgage_io.Out_File, DATA_DIR & "Mortgage.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         mortgage := loadMortgage (infile);
         Ada.Text_IO.Put ("mortgage.sernum " & String (mortgage.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Mortgage (outfile, mortgage);
      end loop;
      Ada.Text_IO.Close (infile);
      Mortgage_io.Close (outfile);

   end Write_Mortgage_In_Binary;

   procedure Write_OddJob_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : OddJob_io.File_Type;
      OddJob  : OddJob_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "OddJob.dat");
      OddJob_io.Create (outfile, OddJob_io.Out_File, DATA_DIR & "OddJob.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         OddJob := loadOddJob (infile);
         Ada.Text_IO.Put ("OddJob.sernum " & String (OddJob.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_OddJob (outfile, OddJob);
      end loop;
      Ada.Text_IO.Close (infile);
      OddJob_io.Close (outfile);

   end Write_OddJob_In_Binary;

   procedure Write_Owner_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Owner_io.File_Type;
      Owner   : Owner_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Owner.dat");
      Owner_io.Create (outfile, Owner_io.Out_File, DATA_DIR & "Owner.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         Owner := loadOwner (infile);
         Ada.Text_IO.Put ("Owner.sernum " & String (Owner.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Owner (outfile, Owner);
      end loop;
      Ada.Text_IO.Close (infile);
      Owner_io.Close (outfile);

   end Write_Owner_In_Binary;

   procedure Write_RentCont_In_Binary is
      infile   : Ada.Text_IO.File_Type;
      outfile  : RentCont_io.File_Type;
      RentCont : RentCont_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "RentCont.dat");
      RentCont_io.Create (outfile, RentCont_io.Out_File, DATA_DIR & "RentCont.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         RentCont := loadRentCont (infile);
         Ada.Text_IO.Put ("RentCont.sernum " & String (RentCont.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_RentCont (outfile, RentCont);
      end loop;
      Ada.Text_IO.Close (infile);
      RentCont_io.Close (outfile);

   end Write_RentCont_In_Binary;

   procedure Write_Renter_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Renter_io.File_Type;
      renter  : Renter_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Renter.dat");
      Renter_io.Create (outfile, Renter_io.Out_File, DATA_DIR & "Renter.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         renter := loadRenter (infile);
         Ada.Text_IO.Put ("Renter.sernum " & String (renter.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Renter (outfile, renter);
      end loop;
      Ada.Text_IO.Close (infile);
      Renter_io.Close (outfile);

   end Write_Renter_In_Binary;

   procedure Write_Vehicle_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Vehicle_io.File_Type;
      vehicle : Vehicle_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Vehicle.dat");
      Vehicle_io.Create (outfile, Vehicle_io.Out_File, DATA_DIR & "Vehicle.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         vehicle := loadVehicle (infile);
         Ada.Text_IO.Put ("Vehicle.sernum " & String (vehicle.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Vehicle (outfile, vehicle);
      end loop;
      Ada.Text_IO.Close (infile);
      Vehicle_io.Close (outfile);

   end Write_Vehicle_In_Binary;

   procedure Write_Pension_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Pension_io.File_Type;
      Pension : Pension_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "Pension.dat");
      Pension_io.Create (outfile, Pension_io.Out_File, DATA_DIR & "Pension.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         Pension := loadPension (infile);
         Ada.Text_IO.Put ("Pension.sernum " & String (Pension.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Pension (outfile, Pension);
      end loop;
      Ada.Text_IO.Close (infile);
      Pension_io.Close (outfile);

   end Write_Pension_In_Binary;

   procedure Write_PenProv_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : PenProv_io.File_Type;
      PenProv : PenProv_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "PenProv.dat");
      PenProv_io.Create (outfile, PenProv_io.Out_File, DATA_DIR & "PenProv.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         PenProv := loadPenProv (infile);
         Ada.Text_IO.Put ("PenProv.sernum " & String (PenProv.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_PenProv (outfile, PenProv);
      end loop;
      Ada.Text_IO.Close (infile);
      PenProv_io.Close (outfile);

   end Write_PenProv_In_Binary;

   procedure Write_PenAmt_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : PenAmt_io.File_Type;
      PenAmt : PenAmt_Rec;
   begin
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "PenAmt.dat");
      PenAmt_io.Create (outfile, PenAmt_io.Out_File, DATA_DIR & "PenAmt.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         PenAmt := loadPenAmt (infile);
         Ada.Text_IO.Put ("PenAmt.sernum " & String (PenAmt.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_PenAmt (outfile, PenAmt);
      end loop;
      Ada.Text_IO.Close (infile);
      PenAmt_io.Close (outfile);

   end Write_PenAmt_In_Binary;
   
   
   function loadOneIndex (file : Ada.Text_IO.File_Type) return Index_Rec is
      tmp : Index_Rec;

   begin
      tmp.SERNUM := Read_Sernum (file);
      Ada.Text_IO.Put ("loadOneIndex ; got sernum as " & String (tmp.SERNUM));
      for comp in  RecordComponents loop
         Ada.Text_IO.Put ("loadOneIndex; on record " & comp'Img);
         Int_IO.Get (file, tmp.pointers (comp).startPos);
         Ada.Text_IO.Put
           ("tmp.pointers ( " & comp'Img & " ).startPos=" & tmp.pointers (comp).startPos'Img);
         Int_IO.Get (file, tmp.pointers (comp).counter);
         Ada.Text_IO.Put
           ("tmp.pointers ( " & comp'Img & " ).counter=" & tmp.pointers (comp).counter'Img);
         Ada.Text_IO.New_Line;
      end loop;
      return tmp;
   end loadOneIndex;

   procedure Write_Index_In_Binary is
      infile  : Ada.Text_IO.File_Type;
      outfile : Index_io.File_Type;
      index   : Index_Rec;
   begin
      Ada.Text_IO.Put ("Write_Index_In_Binary; opening file " & DATA_DIR & "positions.dump");
      Ada.Text_IO.Open (infile, Ada.Text_IO.In_File, DATA_DIR & "positions.sorted");
      Index_io.Create (outfile, Index_io.Out_File, DATA_DIR & "index.bin");
      while not (Ada.Text_IO.End_Of_File (infile)) loop
         index := loadOneIndex (infile);
         Ada.Text_IO.Put ("Index.sernum " & String (index.SERNUM));
         Ada.Text_IO.New_Line;
         bin_write_Index (outfile, index);
      end loop;
      Ada.Text_IO.Close (infile);
      Index_io.Close (outfile);

   end Write_Index_In_Binary;

   procedure write_everything_in_binary is
   begin
      Write_Index_In_Binary;
      Write_Vehicle_In_Binary;
      Ada.Text_IO.Put ("write takeup in binary");
      Ada.Text_IO.New_Line;

      Write_Adults_In_Binary;
      Ada.Text_IO.Put ("Write_Adults_In_Binary");
      Write_Account_In_Binary;
      Ada.Text_IO.Put ("Write_Account_In_Binary;");
      Write_Asset_In_Binary;
      Ada.Text_IO.Put ("Write_Asset_In_Binary;");
      Write_BenUnit_In_Binary;
      Ada.Text_IO.Put ("Write_BenUnit_In_Binary;");

      Write_Benefits_In_Binary;
      Ada.Text_IO.Put ("Write_Benefits_In_Binary;");
      Write_Care_In_Binary;
      Ada.Text_IO.Put ("Write_Care_In_Binary;");
      Write_Child_In_Binary;
      Ada.Text_IO.Put ("Write_Child_In_Binary;");
      Write_Endowment_In_Binary;

      Write_ExtChild_In_Binary;
      Write_GovPay_In_Binary;
      Write_Household_In_Binary;
      Write_Insurance_In_Binary;
      Write_Job_In_Binary;
      Write_Maint_In_Binary;
      Write_MortCont_In_Binary;
      Write_Mortgage_In_Binary;
      Write_OddJob_In_Binary;
      Write_Owner_In_Binary;
      Write_PenProv_In_Binary;
      Write_PenAmt_In_Binary;

      Write_Pension_In_Binary;

      Write_RentCont_In_Binary;
      Write_Renter_In_Binary;

   end write_everything_in_binary;

   --  Job_io is n
   --  Maint_IO is
   --  MortCont_io
   --  RentCont_io
   --  OddJob_io i
   --  Owner_io is
   --  RentCont_io
   --  Renter_io i
   --  Vehicle_io

end raw_frs_conversions_0304;
