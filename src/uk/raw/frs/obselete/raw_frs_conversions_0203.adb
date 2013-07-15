--
--  $Author: graham_s $
--  $Date: 2011-02-25 14:55:37 +0000 (Fri, 25 Feb 2011) $
--  $Revision: 11107 $
--

with Text_IO;
with Base_Model_Types; use Base_Model_Types;
with Raw_FRS; use Raw_FRS;
--
--  change these to 0203/0304 as needed; make sure to comment out loadVehicle in 0203
--
with FRS_Reader_0203; use FRS_Reader_0203;
with frs_binary_reads; use frs_binary_reads;
with Conversions.FRS; use Conversions.FRS;

with Ada.Text_IO; use Ada.Text_IO;

--
--  Conversion routine for frs data to binary
--  change _0304 to _0203 above as needed, and call write_everything_in_binary from somewhere.
--  For 0203, remove the call to Vehicles below as that data is not there.
--  Note that 0304 needs Takeup loads commented back in!!
--
package body raw_frs_conversions_0203 is



        procedure Write_Adults_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Adult_io.FILE_TYPE;
                adult   : Adult_Rec;
        begin
                Text_IO.put( "opening |" & DATA_DIR & "Adult.dat" & "| OK" );
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                                DATA_DIR & "Adult.dat" );

                Adult_io.create( outfile,
                                  Adult_io.out_file,
                                  DATA_DIR & "Adult.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        adult := loadAdult ( infile );
                        Text_IO.put ( "adult.sernum " & String (adult.SERNUM) & " tu " & adult.BENUNIT'Img &
                                     " person " & adult.PERSON'Img );
                        Text_IO.New_Line;

                        bin_Write_Adult( outfile, adult );
                end loop;
                Ada.Text_IO.close ( infile );
                Adult_io.close( outfile );

        end Write_Adults_In_Binary;

        procedure Write_Account_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Account_io.FILE_TYPE;
                account   : Account_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Account.dat" );
                Account_io.create( outfile,
                                  Account_io.out_file,
                                  DATA_DIR & "Account.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        account := loadAccount ( infile );
                        Text_IO.put ( "Accounts.sernum " & String (Account.SERNUM) & " tu " & account.BENUNIT'Img &
                                     " person " & account.PERSON'Img );
                        Text_IO.New_Line;

                        bin_Write_Account( outfile, account );
                end loop;
                Ada.Text_IO.close ( infile );
                Account_io.close( outfile );

        end Write_Account_In_Binary;

        procedure Write_Asset_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Asset_io.FILE_TYPE;
                asset   : Asset_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Asset.dat" );
                Asset_io.create( outfile,
                                  Asset_io.out_file,
                                  DATA_DIR & "Asset.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        asset := loadAsset( infile );
                        Text_IO.put ( "Assets.sernum " & String (asset.SERNUM) & " tu " & asset.BENUNIT'Img &
                                     " person " & asset.PERSON'Img );
                        Text_IO.New_Line;

                        bin_Write_Asset( outfile, asset );
                end loop;
                Ada.Text_IO.close ( infile );
                Asset_io.close( outfile );

        end Write_Asset_In_Binary;

        procedure Write_BenUnit_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Benunit_io.FILE_TYPE;
                benunit  : Benunit_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Benunit.dat" );
                Benunit_io.create( outfile,
                                  Benunit_io.out_file,
                                  DATA_DIR & "Benunit.bin" );
                Ada.Text_IO.put( "Write_BenUnit_In_Binary; files opened ok " );
                while not (Ada.Text_IO.End_Of_File ( infile ) )loop
                        Ada.Text_IO.put( "loading benefit unit " );
                        benunit := loadBenunit ( infile );
                        Text_IO.put ( "Benunits.sernum " & String (benunit.SERNUM) & " tu " & benunit.BENUNIT'Img );
                        Text_IO.New_Line;

                        bin_Write_Benunit( outfile, benunit );
                end loop;
                Ada.Text_IO.close ( infile );
                Benunit_io.close( outfile );

        end Write_Benunit_In_Binary;

        procedure Write_Benefits_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Benefit_io.FILE_TYPE;
                benefit   : Benefit_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Benefit.dat" );
                Benefit_io.create( outfile,
                                  Benefit_io.out_file,
                                  DATA_DIR & "Benefit.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        benefit := loadBenefit( infile );
                        Text_IO.put ( "Benunits.sernum " & String (benefit.SERNUM) & " tu " & benefit.BENUNIT'Img &
                                     " person " & benefit.PERSON'Img );
                        Text_IO.New_Line;

                        bin_Write_Benefit( outfile, benefit );
                end loop;
                Ada.Text_IO.close ( infile );
                Benefit_io.close( outfile );

        end Write_Benefits_In_Binary;

        procedure Write_Care_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Care_io.FILE_TYPE;
                care   : Care_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Care.dat" );
                Care_io.create( outfile,
                                  Care_io.out_file,
                                  DATA_DIR & "Care.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        care := loadCare( infile );
                        Text_IO.put ( "Care.sernum " & String (care.SERNUM) & " tu " & care.BENUNIT'Img );
                        Text_IO.New_Line;

                        bin_Write_Care( outfile, care );
                end loop;
                Ada.Text_IO.close ( infile );
                Care_io.close( outfile );

        end Write_Care_In_Binary;

        procedure Write_Child_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Child_io.FILE_TYPE;
                child   : Child_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Child.dat" );
                Child_io.create( outfile,
                                  Child_io.out_file,
                                  DATA_DIR & "Child.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        Child := loadChild( infile );
                        Text_IO.put ( "Child.sernum " & String (child.SERNUM) & " tu " & child.BENUNIT'Img );
                        Text_IO.New_Line;

                        bin_Write_Child( outfile, Child );
                end loop;
                Ada.Text_IO.close ( infile );
                Child_io.close( outfile );

        end Write_Child_In_Binary;


        procedure Write_Endowment_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Endowment_io.FILE_TYPE;
                endowment   : Endowment_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Endowment.dat" );
                Endowment_io.create( outfile,
                                  Endowment_io.out_file,
                                  DATA_DIR & "Endowment.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        endowment := loadEndowment( infile );
                        Text_IO.put ( "Endowment.sernum " & String (endowment.SERNUM)  );
                        Text_IO.New_Line;

                        bin_Write_Endowment( outfile, Endowment );
                end loop;
                Ada.Text_IO.close ( infile );
                Endowment_io.close( outfile );

        end Write_Endowment_In_Binary;

        procedure Write_ExtChild_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : ExtChild_io.FILE_TYPE;
                extChild   : ExtChild_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "ExtChild.dat" );
                ExtChild_io.create( outfile,
                                  ExtChild_io.out_file,
                                  DATA_DIR & "ExtChild.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        extChild := loadextChild( infile );
                        Text_IO.put ( "Benunits.sernum " & String (extChild.SERNUM) & " tu " & extChild.BENUNIT'Img );
                        Text_IO.New_Line;

                        bin_Write_extChild( outfile, extChild );
                end loop;
                Ada.Text_IO.close ( infile );
                extChild_io.close( outfile );

        end Write_extChild_In_Binary;

        procedure Write_GovPay_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : GovPay_io.FILE_TYPE;
                GovPay   : GovPay_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "GovPay.dat" );
                GovPay_io.create( outfile,
                                  GovPay_io.out_file,
                                  DATA_DIR & "GovPay.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        GovPay := loadGovPay( infile );
                        Text_IO.put ( "Benunits.sernum " & String (GovPay.SERNUM) & " tu " & GovPay.BENUNIT'Img );
                        Text_IO.New_Line;

                        bin_Write_GovPay( outfile, GovPay );
                end loop;
                Ada.Text_IO.close ( infile );
                GovPay_io.close( outfile );

        end Write_GovPay_In_Binary;


        procedure Write_Household_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Household_io.FILE_TYPE;
                household   : Household_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Household.dat" );
                Household_io.create( outfile,
                                  Household_io.out_file,
                                  DATA_DIR & "Household.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        household := loadHousehold( infile );
                        Text_IO.put ( "Household.sernum " & String (Household.SERNUM)  );
                        Text_IO.New_Line;

                        bin_Write_Household( outfile, household );
                end loop;
                Ada.Text_IO.close ( infile );
                Household_io.close( outfile );

        end Write_Household_In_Binary;


        procedure Write_Insurance_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Insurance_io.FILE_TYPE;
                insurance   : Insurance_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Insurance.dat" );
                Insurance_io.create( outfile,
                                  Insurance_io.out_file,
                                  DATA_DIR & "Insurance.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        Insurance := loadInsurance( infile );
                        Text_IO.put ( "Insurance.sernum " & String (Insurance.SERNUM)  );
                        Text_IO.New_Line;

                        bin_Write_Insurance( outfile, Insurance );
                end loop;
                Ada.Text_IO.close ( infile );
                Insurance_io.close( outfile );

        end Write_Insurance_In_Binary;

        procedure Write_Job_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Job_io.FILE_TYPE;
                job   : Job_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Job.dat" );
                Job_io.create( outfile,
                                  Job_io.out_file,
                                  DATA_DIR & "Job.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        job := loadJob( infile );
                        Text_IO.put ( "Job.sernum " & String (Job.SERNUM)  );
                        Text_IO.New_Line;

                        bin_Write_Job( outfile, job );
                end loop;
                Ada.Text_IO.close ( infile );
                Job_io.close( outfile );

        end Write_Job_In_Binary;

        procedure Write_Maint_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Maint_IO.FILE_TYPE;
                maint   : Maint_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Maint.dat" );
                Maint_IO.create( outfile,
                                  Maint_IO.out_file,
                                  DATA_DIR & "Maint.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        maint := loadMaint( infile );
                        Text_IO.put ( "Maint.sernum " & String (Maint.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_Maint( outfile, Maint );
                end loop;
                Ada.Text_IO.close ( infile );
                Maint_IO.close( outfile );

        end Write_Maint_In_Binary;

        procedure Write_MortCont_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : MortCont_io.FILE_TYPE;
                MortCont   : MortCont_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "MortCont.dat" );
                MortCont_io.create( outfile,
                                  MortCont_io.out_file,
                                  DATA_DIR & "MortCont.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        mortCont := loadMortCont( infile );
                        Text_IO.put ( "MortCont.sernum " & String (MortCont.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_MortCont( outfile, mortCont );
                end loop;
                Ada.Text_IO.close ( infile );
                MortCont_io.close( outfile );

        end Write_MortCont_In_Binary;

        procedure Write_Mortgage_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Mortgage_io.FILE_TYPE;
                mortgage   : Mortgage_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Mortgage.dat" );
                Mortgage_io.create( outfile,
                                  Mortgage_io.out_file,
                                  DATA_DIR & "Mortgage.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        mortgage := loadMortgage( infile );
                        Text_IO.put ( "mortgage.sernum " & String (mortgage.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_Mortgage( outfile, mortgage );
                end loop;
                Ada.Text_IO.close ( infile );
                Mortgage_io.close( outfile );

        end Write_Mortgage_In_Binary;

        procedure Write_OddJob_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : OddJob_io.FILE_TYPE;
                OddJob   : OddJob_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "OddJob.dat" );
                OddJob_io.create( outfile,
                                  OddJob_io.out_file,
                                  DATA_DIR & "OddJob.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        oddJob := loadOddJob( infile );
                        Text_IO.put ( "OddJob.sernum " & String (oddJob.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_OddJob( outfile, OddJob );
                end loop;
                Ada.Text_IO.close ( infile );
                OddJob_io.close( outfile );

        end Write_OddJob_In_Binary;

        procedure Write_Owner_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Owner_io.FILE_TYPE;
                Owner   : Owner_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Owner.dat" );
                Owner_io.create( outfile,
                                  Owner_io.out_file,
                                  DATA_DIR & "Owner.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        owner := loadOwner( infile );
                        Text_IO.put ( "Owner.sernum " & String (owner.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_Owner( outfile, owner );
                end loop;
                Ada.Text_IO.close ( infile );
                Owner_io.close( outfile );

        end Write_Owner_In_Binary;

        procedure Write_RentCont_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : RentCont_io.FILE_TYPE;
                RentCont   : RentCont_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "RentCont.dat" );
                RentCont_io.create( outfile,
                                  RentCont_io.out_file,
                                  DATA_DIR & "RentCont.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        rentCont := loadRentCont( infile );
                        Text_IO.put ( "RentCont.sernum " & String (rentCont.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_RentCont( outfile, rentCont );
                end loop;
                Ada.Text_IO.close ( infile );
                RentCont_io.close( outfile );

        end Write_RentCont_In_Binary;

        procedure Write_Renter_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Renter_io.FILE_TYPE;
                renter   : Renter_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Renter.dat" );
                Renter_io.create( outfile,
                                  Renter_io.out_file,
                                  DATA_DIR & "Renter.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        renter := loadRenter( infile );
                        Text_IO.put ( "Renter.sernum " & String (renter.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_Renter( outfile, renter );
                end loop;
                Ada.Text_IO.close ( infile );
                Renter_io.close( outfile );

        end Write_Renter_In_Binary;

--          procedure Write_Vehicle_In_Binary is
--                  infile : Ada.Text_IO.FILE_TYPE;
--                  outfile : Vehicle_io.FILE_TYPE;
--                  vehicle   : Vehicle_Rec;
--          begin
--                  Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
--                      DATA_DIR & "Vehicle.dat" );
--                  Vehicle_io.create( outfile,
--                                    Vehicle_io.out_file,
--                                    DATA_DIR & "Vehicle.bin" );
--                  while not(Ada.Text_IO.End_Of_File ( infile ) )loop
--                          vehicle := loadVehicle( infile );
--                          Text_IO.put ( "Vehicle.sernum " & String (Vehicle.SERNUM)  );
--                          Text_IO.New_Line;
--                          bin_Write_Vehicle( outfile, vehicle );
--                  end loop;
--                  Ada.Text_IO.close ( infile );
--                  Vehicle_io.close( outfile );
--
--          end Write_Vehicle_In_Binary;

--          procedure Write_House_Price_Estimates_In_Binary is
--                  infile : Ada.Text_IO.FILE_TYPE;
--                  outfile : House_Price_Estimates_io.FILE_TYPE;
--                  House_Price_Estimate   : House_Price_Estimates_Rec;
--          begin
--                  Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
--                      DATA_DIR & "House_Price_Estimates.dat" );
--                  House_Price_Estimates_io.create( outfile,
--                                    House_Price_Estimates_io.out_file,
--                                    DATA_DIR & "House_Price_Estimates.bin" );
--                  while not(Ada.Text_IO.End_Of_File ( infile ) )loop
--                          House_Price_Estimate := loadHouse_Price_Estimates( infile );
--                          Text_IO.put ( "House_Price_Estimates.sernum " & String (House_Price_Estimate.SERNUM)  );
--                          Text_IO.New_Line;
--                          bin_Write_House_Price_Estimates( outfile, House_Price_Estimate );
--                  end loop;
--                  Ada.Text_IO.close ( infile );
--                  House_Price_Estimates_io.close( outfile );
--
--          end Write_House_Price_Estimates_In_Binary;


        procedure Write_Pension_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Pension_io.FILE_TYPE;
                Pension   : Pension_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "Pension.dat" );
                Pension_io.create( outfile,
                                  Pension_io.out_file,
                                  DATA_DIR & "Pension.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        Pension := loadPension( infile );
                        Text_IO.put ( "Pension.sernum " & String (Pension.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_Pension( outfile, Pension );
                end loop;
                Ada.Text_IO.close ( infile );
                Pension_io.close( outfile );

        end Write_Pension_In_Binary;


        procedure Write_PenProv_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : PenProv_io.FILE_TYPE;
                PenProv   : PenProv_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "PenProv.dat" );
                PenProv_io.create( outfile,
                                  PenProv_io.out_file,
                                  DATA_DIR & "PenProv.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        PenProv := loadPenProv( infile );
                        Text_IO.put ( "PenProv.sernum " & String (PenProv.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_PenProv( outfile, PenProv );
                end loop;
                Ada.Text_IO.close ( infile );
                PenProv_io.close( outfile );

        end Write_PenProv_In_Binary;

        procedure Write_HBAI_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : HBAI_io.FILE_TYPE;
                hbai   : HBAI_Rec;
        begin
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                                DATA_DIR & "HBAI.dat" );
                Text_IO.put ( "opened HBAI file "  );
                Text_IO.New_Line;
                HBAI_io.create( outfile,
                                  HBAI_io.out_file,
                               DATA_DIR & "HBAI.bin" );
                Text_IO.put ( "outfile created " );
                Text_IO.New_Line;

                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        hbai := loadHBAI( infile );
                        Text_IO.put ( "HBAI.sernum " & String (hbai.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_HBAI( outfile, hbai );
                end loop;
                Ada.Text_IO.close ( infile );
                HBAI_io.close( outfile );

        end Write_HBAI_In_Binary;

--          procedure Write_Takeup_Estimates_In_Binary is
--                  infile : Ada.Text_IO.FILE_TYPE;
--                  outfile : Takeup_Estimates_io.FILE_TYPE;
--                  Takeup_Estimates   : Takeup_Estimates_Rec;
--          begin
--                  Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
--                                  DATA_DIR & "Takeup_Estimates_Non_Indexed.dat" );
--                  Text_IO.put ( "opened Takeup_Estimates file "  );
--                  Text_IO.New_Line;
--                  Takeup_Estimates_io.create( outfile,
--                                    Takeup_Estimates_io.out_file,
--                                 DATA_DIR & "Takeup_Estimates_Non_Indexed.bin" );
--                  Text_IO.put ( "outfile created " );
--                  Text_IO.New_Line;
--
--                  while not(Ada.Text_IO.End_Of_File ( infile ) )loop
--                          Takeup_Estimates := loadTakeup_Estimates( infile );
--                          Text_IO.put ( "Takeup_Estimates.sernum " & String (Takeup_Estimates.SERNUM)  );
--                          bin_Write_Takeup_Estimates ( outfile, Takeup_Estimates );
--                          text_io.put( "written binary" );
--                          Text_IO.New_Line;
--                  end loop;
--                  Ada.Text_IO.close ( infile );
--                  Takeup_Estimates_io.close( outfile );
--                  Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
--                                  DATA_DIR & "Takeup_Estimates_Indexed.dat" );
--                  Text_IO.put ( "opened Takeup_Estimates file "  );
--                  Text_IO.New_Line;
--                  Takeup_Estimates_io.create( outfile,
--                                    Takeup_Estimates_io.out_file,
--                                 DATA_DIR & "Takeup_Estimates_Indexed.bin" );
--                  Text_IO.put ( "outfile created " );
--                  Text_IO.New_Line;
--
--                  while not(Ada.Text_IO.End_Of_File ( infile ) )loop
--                          Takeup_Estimates := loadTakeup_Estimates( infile );
--                          Text_IO.put ( "Takeup_Estimates.sernum " & String (Takeup_Estimates.SERNUM)  );
--                          Text_IO.New_Line;
--                          bin_Write_Takeup_Estimates( outfile, Takeup_Estimates );
--                  end loop;
--                  Ada.Text_IO.close ( infile );
--                  Takeup_Estimates_io.close( outfile );
--
--          end Write_Takeup_Estimates_In_Binary;


        function loadOneIndex (file : Ada.Text_IO.File_Type) return Index_Rec is
                tmp : Index_Rec;

        begin
                tmp.SERNUM := Read_Sernum (file);
                Text_IO.put("loadOneIndex ; got sernum as " & String(tmp.SERNUM));
                for comp in RecordComponents loop
                        Text_IO.put("loadOneIndex; on record " & comp'Img );
                        Int_IO.get ( file, tmp.pointers( comp ).startPos );
                        text_io.put( "tmp.pointers ( "&comp'Img&" ).startPos="&tmp.pointers ( comp ).startPos'Img );
                        Int_IO.get ( file, tmp.pointers ( comp ).counter );
                        text_io.put ( "tmp.pointers ( " & comp'Img & " ).counter=" & tmp.pointers ( comp ).counter'Img );
                        text_io.new_line;
                end loop;
                return tmp;
        end loadOneIndex;

        procedure Write_Index_In_Binary is
                infile : Ada.Text_IO.FILE_TYPE;
                outfile : Index_io.FILE_TYPE;
                index   : Index_Rec;
        begin
                Text_IO.put( "Write_Index_In_Binary; opening file "& DATA_DIR & "positions.dump" );
                Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                    DATA_DIR & "positions.dump" );
                Index_io.create( outfile,
                                  Index_io.out_file,
                                  DATA_DIR & "index.bin" );
                while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                        index := loadOneIndex( infile );
                        Text_IO.put ( "Index.sernum " & String (Index.SERNUM)  );
                        Text_IO.New_Line;
                        bin_Write_Index( outfile, index );
                end loop;
                Ada.Text_IO.close ( infile );
                Index_io.close( outfile );

        end Write_Index_In_Binary;

          procedure Write_Takeup_Estimates_In_Binary is
                  infile : Ada.Text_IO.FILE_TYPE;
                  outfile : Takeup_Estimates_io.FILE_TYPE;
                  Takeup_Estimates   : Takeup_Estimates_Rec;
          begin
                  Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                                  DATA_DIR & "Takeup_Estimates_Indexed.dat" );
                  Text_IO.put ( "opened Takeup_Estimates file "  );
                  Text_IO.New_Line;
                  Takeup_Estimates_io.create( outfile,
                                    Takeup_Estimates_io.out_file,
                                 DATA_DIR & "Takeup_Estimates_Indexed.bin" );
                  Text_IO.put ( "outfile created " );
                  Text_IO.New_Line;

                  while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                          Takeup_Estimates := loadTakeup_Estimates( infile );
                          Text_IO.put ( "Takeup_Estimates.sernum " & String (Takeup_Estimates.SERNUM)  );
                          Text_IO.New_Line;
                          bin_Write_Takeup_Estimates( outfile, Takeup_Estimates );
                  end loop;
                  Ada.Text_IO.close ( infile );
                  Takeup_Estimates_io.close( outfile );

          end Write_Takeup_Estimates_In_Binary;

          procedure Write_House_Price_Estimates_In_Binary is
                  infile : Ada.Text_IO.FILE_TYPE;
                  outfile : House_Price_Estimates_io.FILE_TYPE;
                  House_Price_Estimate   : House_Price_Estimates_Rec;
          begin
                  Ada.Text_IO.open ( infile, Ada.Text_IO.in_file,
                      DATA_DIR & "House_Price_Estimates.dat" );
                  House_Price_Estimates_io.create( outfile,
                                    House_Price_Estimates_io.out_file,
                                    DATA_DIR & "House_Price_Estimates.bin" );
                  while not(Ada.Text_IO.End_Of_File ( infile ) )loop
                          House_Price_Estimate := loadHouse_Price_Estimates( infile );
                          Text_IO.put ( "House_Price_Estimates.sernum " & String (House_Price_Estimate.SERNUM)  );
                          Text_IO.New_Line;
                          bin_Write_House_Price_Estimates( outfile, House_Price_Estimate );
                  end loop;
                  Ada.Text_IO.close ( infile );
                  House_Price_Estimates_io.close( outfile );

          end Write_House_Price_Estimates_In_Binary;



        procedure write_everything_in_binary is
        begin
                --  remove vehicle for 0203 (no such record).
                Write_Index_In_Binary;
                --  Write_Vehicle_In_Binary;
                --  Ada.Text_IO.put ( "write takeup in binary" );
                Ada.Text_IO.new_line;
                -- Write_Takeup_Estimates_In_Binary;

                Write_HBAI_In_Binary;
                Ada.Text_IO.put( "Write_HBAI_In_Binary" );
                Ada.Text_IO.put ( "write takeup in binary" );
                Ada.Text_IO.new_line;
                Write_Takeup_Estimates_In_Binary;
                Ada.Text_IO.put ( "Write_takup estimates_In_Binary" );
                Write_House_Price_Estimates_In_Binary;

                Write_Adults_In_Binary;
                Ada.Text_IO.put( "Write_Adults_In_Binary" );
                Write_Account_In_Binary;
                Ada.Text_IO.put( "Write_Account_In_Binary;" );
                Write_Asset_In_Binary;
                Ada.Text_IO.put( "Write_Asset_In_Binary;" );
                Write_BenUnit_In_Binary;
                Ada.Text_IO.put( "Write_BenUnit_In_Binary;" );

                Write_Benefits_In_Binary;
                Ada.Text_IO.put( "Write_Benefits_In_Binary;" );
                Write_Care_In_Binary;
                Ada.Text_IO.put( "Write_Care_In_Binary;" );
                Write_Child_In_Binary;
                Ada.Text_IO.put( "Write_Child_In_Binary;" );
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
                Write_Pension_In_Binary;

                Write_RentCont_In_Binary;
                Write_Renter_In_Binary;

                Write_Takeup_Estimates_In_Binary;
                Write_House_Price_Estimates_In_Binary;

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

end raw_frs_conversions_0203;
