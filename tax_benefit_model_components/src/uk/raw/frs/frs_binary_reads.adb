--
--  $Author: graham_s $
--  $Date: 2008-08-30 13:44:44 +0100 (Sat, 30 Aug 2008) $
--  $Revision: 5796 $
--
with Ada.Direct_IO;
with raw_frs;          use raw_frs;
with Ada.Exceptions;   use Ada.Exceptions;
with AUnit.Assertions; 
with Ada.Text_IO;

package body frs_binary_reads is

   use AUnit.Assertions;

   current_year : Data_Years;

   Account_File    : Account_io.File_Type;
   Adult_File      : Adult_io.File_Type;
   Asset_File      : Asset_io.File_Type;
   Benefit_File    : Benefit_io.File_Type;
   Benunit_File    : Benunit_io.File_Type;
   Care_File       : Care_io.File_Type;
   Child_File      : Child_io.File_Type;
   Endowment_File  : Endowment_io.File_Type;
   ExtChild_File   : ExtChild_io.File_Type;
   GovPay_File     : GovPay_io.File_Type;
   Household_File  : Household_io.File_Type;
   Hbai_File       : Hbai_io.File_Type;
   Insurance_File  : Insurance_io.File_Type;
   Job_File        : Job_io.File_Type;
   Maint_File      : Maint_IO.File_Type;
   MortCont_File   : MortCont_io.File_Type;
   Mortgage_File   : Mortgage_io.File_Type;
   OddJob_File     : OddJob_io.File_Type;
   Owner_File      : Owner_io.File_Type;
   RentCont_File   : RentCont_io.File_Type;
   Renter_File     : Renter_io.File_Type;
   Vehicle_File    : Vehicle_io.File_Type;
   Pension_File    : Pension_io.File_Type;
   PenAmt_File     : PenAmt_io.File_Type;
   PenProv_File    : PenProv_io.File_Type;
   ChildCare_File  : ChildCare_IO.File_Type;
   Admin_File      : Admin_IO.File_Type;

   procedure Close_Files is
   begin
      Account_io.Close (Account_File);
      Adult_io.Close (Adult_File);
      Asset_io.Close (Asset_File);
      Benefit_io.Close (Benefit_File);
      Benunit_io.Close (Benunit_File);
      Care_io.Close (Care_File);
      Child_io.Close (Child_File);
      Endowment_io.Close (Endowment_File);
      ExtChild_io.Close (ExtChild_File);
      GovPay_io.Close (GovPay_File);
      Household_io.Close (Household_File);
      Hbai_io.Close (Hbai_File);
      if( current_year /= 2005 ) then
         Insurance_io.Close (Insurance_File);
      end if;
      Job_io.Close (Job_File);
      Maint_IO.Close (Maint_File);
      MortCont_io.Close (MortCont_File);
      Mortgage_io.Close (Mortgage_File);
      OddJob_io.Close (OddJob_File);
      Owner_io.Close (Owner_File);
      RentCont_io.Close (RentCont_File);
      Renter_io.Close (Renter_File);
      if( current_year /= 2004 ) then
         Vehicle_io.Close (Vehicle_File);
      end if;
      Pension_io.Close (Pension_File);
      PenAmt_io.Close (PenAmt_File);
      PenProv_io.Close (PenProv_File);
      if( current_year = 2005 ) then                       
         ChildCare_io.Close( ChildCare_File );                         
      end if;

   end Close_Files;

   --
   -- 
   --
   procedure Open_Files( year : Data_Years ) is
   begin
      current_year := year;  -- year we're on as global variable
      Ada.Text_IO.Put (BASE_DATA_DIR & String (DATA_year_strings (year)) & "/bin/accounts.bin");
                                                   
      Account_io.Open                              
        (Account_File,                             
         Account_io.In_File,                       
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/accounts.bin");
      Adult_io.Open                                
        (Adult_File,                               
         Adult_io.In_File,                         
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/adult.bin");
      Ada.Text_IO.Put (BASE_DATA_DIR & String (DATA_year_strings (year)) &  "/bin/adult.bin");
      Asset_io.Open                                
        (Asset_File,                               
         Asset_io.In_File,                         
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/assets.bin");
      Benefit_io.Open                              
        (Benefit_File,                             
         Benefit_io.In_File,                       
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/benefits.bin");
      Benunit_io.Open                              
        (Benunit_File,                             
         Benunit_io.In_File,                       
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/benunit.bin");
      Ada.Text_IO.Put (BASE_DATA_DIR & String (DATA_year_strings (year)) & "/bin/benunit.bin");
      Care_io.Open                                 
        (Care_File,                                
         Care_io.In_File,                          
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/care.bin");
      Child_io.Open                                
        (Child_File,                               
         Child_io.In_File,                         
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/child.bin");
      Endowment_io.Open                            
        (Endowment_File,                           
         Endowment_io.In_File,                     
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/endowmnt.bin");
      ExtChild_io.Open                             
        (ExtChild_File,                            
         ExtChild_io.In_File,                      
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/extchild.bin");
      GovPay_io.Open                               
        (GovPay_File,                              
         GovPay_io.In_File,                        
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/govpay.bin");
      Household_io.Open                            
        (Household_File,                           
         Household_io.In_File,                     
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/househol.bin");
      Hbai_io.Open                            
        (Hbai_File,                           
         Hbai_io.In_File,                     
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/hbai.bin");
      if( year /= 2005 ) then
         Insurance_io.Open                            
           (Insurance_File,                           
            Insurance_io.In_File,                     
            BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/insuranc.bin");
      end if;
      Job_io.Open                                  
        (Job_File,                                 
         Job_io.In_File,                           
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/job.bin");
      Ada.Text_IO.Put (BASE_DATA_DIR & String (DATA_year_strings (year)) & "/bin/job.bin");
      Maint_IO.Open                                
        (Maint_File,                               
         Maint_IO.In_File,                         
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/maint.bin");
      MortCont_io.Open                             
        (MortCont_File,                            
         MortCont_io.In_File,                      
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/mortcont.bin");
      Mortgage_io.Open                             
        (Mortgage_File,                            
         Mortgage_io.In_File,                      
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/mortgage.bin");
      OddJob_io.Open                               
        (OddJob_File,                              
         OddJob_io.In_File,                        
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/oddjob.bin");
      Owner_io.Open                                
        (Owner_File,                               
         Owner_io.In_File,                         
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/owner.bin");
                                                   
      Pension_io.Open                              
        (Pension_File,                             
         Pension_io.In_File,                       
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/pension.bin");
                                                   
      PenProv_io.Open                              
        (PenProv_File,                             
         PenProv_io.In_File,                       
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/penprov.bin");
                                                   
      PenAmt_io.Open                               
        (PenAmt_File,                              
         PenAmt_io.In_File,                        
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/penamt.bin");
                                                   
      RentCont_io.Open                             
        (RentCont_File,                            
         RentCont_io.In_File,                      
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/rentcont.bin");
      Renter_io.Open                               
        (Renter_File,                              
         Renter_io.In_File,                        
         BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/renter.bin");
      if (year /= 2004) then                        
         Vehicle_io.Open                           
           (Vehicle_File,                          
            Vehicle_io.In_File,                    
            BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/vehicle.bin");
      end if;                                      
      if( year = 2005 ) then                       
         ChildCare_io.Open                         
           (ChildCare_File,                        
            ChildCare_io.In_File,                  
            BASE_DATA_DIR & String (DATA_YEAR_STRINGS (year)) & "/bin/chldcare.bin");
      end if;
   end Open_Files;

   function Bin_Read_Adult (file : Adult_io.File_Type; cpos : Positive) return Adult_Rec is
      var : Adult_Rec;
   begin
      Adult_io.Read (file, var, Adult_io.Count (cpos));
      return var;
   end Bin_Read_Adult;

   procedure Bin_Write_Adult (file : Adult_io.File_Type; rec : Adult_Rec) is
   begin
      Adult_io.Write (file, rec);
   end Bin_Write_Adult;

   function Bin_Read_Account (file : Account_io.File_Type; cpos : Positive) return Account_Rec is
      var : Account_Rec;
   begin
      Account_io.Read (file, var, Account_io.Count (cpos));
      return var;
   end Bin_Read_Account;

   procedure Bin_Write_Pension (file : Pension_io.File_Type; rec : Pension_Rec) is
   begin
      Pension_io.Write (file, rec);
   end Bin_Write_Pension;

   function Bin_Read_Pension (file : Pension_io.File_Type; cpos : Positive) return Pension_Rec is
      var : Pension_Rec;
   begin
      Pension_io.Read (file, var, Pension_io.Count (cpos));
      return var;
   end Bin_Read_Pension;

   procedure Bin_Write_PenAmt (file : PenAmt_io.File_Type; rec : PenAmt_Rec) is
   begin
      PenAmt_io.Write (file, rec);
   end Bin_Write_PenAmt;

   function Bin_Read_PenAmt (file : PenAmt_io.File_Type; cpos : Positive) return PenAmt_Rec is
      var : PenAmt_Rec;
   begin
      PenAmt_io.Read (file, var, PenAmt_io.Count (cpos));
      return var;
   end Bin_Read_PenAmt;

   procedure Bin_Write_PenProv (file : PenProv_io.File_Type; rec : PenProv_Rec) is
   begin
      PenProv_io.Write (file, rec);
   end Bin_Write_PenProv;

   function Bin_Read_PenProv (file : PenProv_io.File_Type; cpos : Positive) return PenProv_Rec is
      var : PenProv_Rec;
   begin
      PenProv_io.Read (file, var, PenProv_io.Count (cpos));
      return var;
   end Bin_Read_PenProv;



   procedure Bin_Write_Account (file : Account_io.File_Type; rec : Account_Rec) is
   begin
      Account_io.Write (file, rec);
   end Bin_Write_Account;

   function Bin_Read_Asset (file : Asset_io.File_Type; cpos : Positive) return Asset_Rec is
      var : Asset_Rec;
   begin
      Asset_io.Read (file, var, Asset_io.Count (cpos));
      return var;
   end Bin_Read_Asset;

   procedure Bin_Write_Asset (file : Asset_io.File_Type; rec : Asset_Rec) is
   begin
      Asset_io.Write (file, rec);
   end Bin_Write_Asset;

   function Bin_Read_Benefit (file : Benefit_io.File_Type; cpos : Positive) return Benefit_Rec is
      var : Benefit_Rec;
   begin
      Benefit_io.Read (file, var, Benefit_io.Count (cpos));
      return var;
   end Bin_Read_Benefit;

   procedure Bin_Write_Benefit (file : Benefit_io.File_Type; rec : Benefit_Rec) is
   begin
      Benefit_io.Write (file, rec);
   end Bin_Write_Benefit;

   function Bin_Read_Benunit (file : Benunit_io.File_Type; cpos : Positive) return Benunit_Rec is
      var : Benunit_Rec;
   begin
      Benunit_io.Read (file, var, Benunit_io.Count (cpos));
      return var;
   end Bin_Read_Benunit;

   procedure Bin_Write_Benunit (file : Benunit_io.File_Type; rec : Benunit_Rec) is
   begin
      Benunit_io.Write (file, rec);
   end Bin_Write_Benunit;

   function Bin_Read_Care (file : Care_io.File_Type; cpos : Positive) return Care_Rec is
      var : Care_Rec;
   begin
      Care_io.Read (file, var, Care_io.Count (cpos));
      return var;
   end Bin_Read_Care;

   procedure Bin_Write_Care (file : Care_io.File_Type; rec : Care_Rec) is
   begin
      Care_io.Write (file, rec);
   end Bin_Write_Care;

   function Bin_Read_Child (file : Child_io.File_Type; cpos : Positive) return Child_Rec is
      var : Child_Rec;
   begin
      Child_io.Read (file, var, Child_io.Count (cpos));
      return var;
   end Bin_Read_Child;

   procedure Bin_Write_Child (file : Child_io.File_Type; rec : Child_Rec) is
   begin
      Child_io.Write (file, rec);
   end Bin_Write_Child;

   function Bin_Read_Endowment
     (file : Endowment_io.File_Type;
      cpos : Positive)
      return Endowment_Rec
   is
      var : Endowment_Rec;
   begin
      Endowment_io.Read (file, var, Endowment_io.Count (cpos));
      return var;
   end Bin_Read_Endowment;

   procedure Bin_Write_Endowment (file : Endowment_io.File_Type; rec : Endowment_Rec) is
   begin
      Endowment_io.Write (file, rec);
   end Bin_Write_Endowment;

   function Bin_Read_ExtChild
     (file : ExtChild_io.File_Type;
      cpos : Positive)
      return ExtChild_Rec
   is
      var : ExtChild_Rec;
   begin
      ExtChild_io.Read (file, var, ExtChild_io.Count (cpos));
      return var;
   end Bin_Read_ExtChild;

   procedure Bin_Write_ExtChild (file : ExtChild_io.File_Type; rec : ExtChild_Rec) is
   begin
      ExtChild_io.Write (file, rec);
   end Bin_Write_ExtChild;

   function Bin_Read_GovPay (file : GovPay_io.File_Type; cpos : Positive) return GovPay_Rec is
      var : GovPay_Rec;
   begin
      GovPay_io.Read (file, var, GovPay_io.Count (cpos));
      return var;
   end Bin_Read_GovPay;

   procedure Bin_Write_GovPay (file : GovPay_io.File_Type; rec : GovPay_Rec) is
   begin
      GovPay_io.Write (file, rec);
   end Bin_Write_GovPay;

   function Bin_Read_Household
     (file : Household_io.File_Type;
      cpos : Positive)
      return Household_Rec
   is
      var : Household_Rec;
   begin
      Household_io.Read (file, var, Household_io.Count (cpos));
      return var;
   end Bin_Read_Household;

   procedure Bin_Write_Household (file : Household_io.File_Type; rec : Household_Rec) is
   begin
      Household_io.Write (file, rec);
   end Bin_Write_Household;

   function Bin_Read_Insurance
     (file : Insurance_io.File_Type;
      cpos : Positive)
      return Insurance_Rec
   is
      var : Insurance_Rec;
   begin
      Insurance_io.Read (file, var, Insurance_io.Count (cpos));
      return var;
   end Bin_Read_Insurance;

   procedure Bin_Write_Insurance (file : Insurance_io.File_Type; rec : Insurance_Rec) is
   begin
      Insurance_io.Write (file, rec);
   end Bin_Write_Insurance;

   function Bin_Read_Job (file : Job_io.File_Type; cpos : Positive) return Job_Rec is
      var : Job_Rec;
   begin
      Job_io.Read (file, var, Job_io.Count (cpos));
      return var;
   end Bin_Read_Job;

   procedure Bin_Write_Job (file : Job_io.File_Type; rec : Job_Rec) is
   begin
      Job_io.Write (file, rec);
   end Bin_Write_Job;

   function Bin_Read_Maint (file : Maint_IO.File_Type; cpos : Positive) return Maint_Rec is
      var : Maint_Rec;
   begin
      Maint_IO.Read (file, var, Maint_IO.Count (cpos));
      return var;
   end Bin_Read_Maint;

   procedure Bin_Write_Maint (file : Maint_IO.File_Type; rec : Maint_Rec) is
   begin
      Maint_IO.Write (file, rec);
   end Bin_Write_Maint;

   function Bin_Read_MortCont
     (file : MortCont_io.File_Type;
      cpos : Positive)
      return MortCont_Rec
   is
      var : MortCont_Rec;
   begin
      MortCont_io.Read (file, var, MortCont_io.Count (cpos));
      return var;
   end Bin_Read_MortCont;

   procedure Bin_Write_MortCont (file : MortCont_io.File_Type; rec : MortCont_Rec) is
   begin
      MortCont_io.Write (file, rec);
   end Bin_Write_MortCont;

   function Bin_Read_Mortgage
     (file : Mortgage_io.File_Type;
      cpos : Positive)
      return Mortgage_Rec
   is
      var : Mortgage_Rec;
   begin
      Mortgage_io.Read (file, var, Mortgage_io.Count (cpos));
      return var;
   end Bin_Read_Mortgage;

   procedure Bin_Write_Mortgage (file : Mortgage_io.File_Type; rec : Mortgage_Rec) is
   begin
      Mortgage_io.Write (file, rec);
   end Bin_Write_Mortgage;

   function Bin_Read_OddJob (file : OddJob_io.File_Type; cpos : Positive) return OddJob_Rec is
      var : OddJob_Rec;
   begin
      OddJob_io.Read (file, var, OddJob_io.Count (cpos));
      return var;
   end Bin_Read_OddJob;

   procedure Bin_Write_OddJob (file : OddJob_io.File_Type; rec : OddJob_Rec) is
   begin
      OddJob_io.Write (file, rec);
   end Bin_Write_OddJob;

   function Bin_Read_Owner (file : Owner_io.File_Type; cpos : Positive) return Owner_Rec is
      var : Owner_Rec;
   begin
      Owner_io.Read (file, var, Owner_io.Count (cpos));
      return var;
   end Bin_Read_Owner;
   
   function Bin_Read_Hbai (file : Hbai_io.File_Type; cpos : Positive) return Hbai_Rec is
      var : Hbai_Rec;
   begin
      Hbai_io.Read (file, var, Hbai_io.Count (cpos));
      return var;
   end Bin_Read_Hbai;

   procedure Bin_Write_Owner (file : Owner_io.File_Type; rec : Owner_Rec) is
   begin
      Owner_io.Write (file, rec);
   end Bin_Write_Owner;

   function Bin_Read_RentCont
     (file : RentCont_io.File_Type;
      cpos : Positive)
      return RentCont_Rec
   is
      var : RentCont_Rec;
   begin
      RentCont_io.Read (file, var, RentCont_io.Count (cpos));
      return var;
   end Bin_Read_RentCont;

   procedure Bin_Write_RentCont (file : RentCont_io.File_Type; rec : RentCont_Rec) is
   begin
      RentCont_io.Write (file, rec);
   end Bin_Write_RentCont;

   function Bin_Read_Renter (file : Renter_io.File_Type; cpos : Positive) return Renter_Rec is
      var : Renter_Rec;
   begin
      Renter_io.Read (file, var, Renter_io.Count (cpos));
      return var;
   end Bin_Read_Renter;

   procedure Bin_Write_Renter (file : Renter_io.File_Type; rec : Renter_Rec) is
   begin
      Renter_io.Write (file, rec);
   end Bin_Write_Renter;

   function Bin_Read_Vehicle (file : Vehicle_io.File_Type; cpos : Positive) return Vehicle_Rec is
      var : Vehicle_Rec;
   begin
      Vehicle_io.Read (file, var, Vehicle_io.Count (cpos));
      return var;
   end Bin_Read_Vehicle;

   procedure Bin_Write_Vehicle (file : Vehicle_io.File_Type; rec : Vehicle_Rec) is
   begin
      Vehicle_io.Write (file, rec);
   end Bin_Write_Vehicle;

   --
   --  panic measure to match against Tony's takeup estimates
   --  which seem to be in a different order sometimes (e.g. hh 5000903071
   --  in 0304).
   --
   function find_by_age_and_sex (benunit : Raw_Benefit_unit; age, sex : Integer) return Integer is
   begin
      for adno in  1 .. benunit.numAdults loop
         if (benunit.adults (adno).adult.AGE = age)
           and then (benunit.adults (adno).adult.SEX = sex)
         then
            return adno;
         end if;
      end loop;
      return -1;
   end find_by_age_and_sex;

   function find_by_age_and_sex (children : Child_Array; age, sex : Integer) return Integer is
   begin
      for chno in  1 .. MAX_NUM_CHILDREN loop
         if (children (chno).child.AGE = age) and then (children (chno).child.SEX = sex) then
            return chno;
         end if;
      end loop;
      return -1;
   end find_by_age_and_sex;

   function Get_Household( index : Index_Rec ) return Raw_Household is
      type BuCounterArray is array (1 .. MAX_NUM_BENEFIT_UNITS) of Integer;
      type Person_Mapping is
         record
            buno : Integer;
            adno : Integer;
         end record;
      type Person_Mapping_Array is array (1 .. MAX_NUM_PERSONS) of Person_Mapping;

      personMapping : Person_Mapping_Array := (others => (buno => 0, adno => 0));

      hh      : Raw_Household;
      ptr     : Integer;
      benunit : Benunit_Rec;
      hbai    : Hbai_Rec;
      buno    : Integer;
   begin
      Ada.Text_IO.Put_Line("getHousehold; entered");
      Ada.Text_IO.Put_Line("read index; hh start pos is " & index.pointers (householdRec).startPos'Img);
      Ada.Text_IO.Put_line( "complete index is " & To_String( index ));
      hh.household := Bin_Read_Household (Household_File, index.pointers (householdRec).startPos);
      Ada.Text_IO.Put_Line( "read hh record; sernum = " & String (hh.household.SERNUM'Img));
      if (index.pointers (renterRec).startPos > 0) then
         hh.renter := Bin_Read_Renter (Renter_File, index.pointers (renterRec).startPos);
         Assert
           (hh.renter.SERNUM = hh.household.SERNUM,
            "renter sernum mismatch renter" &
            hh.renter.SERNUM'Img &
            " hh " &
            hh.household.SERNUM'Img);
      end if;
      
      Ada.Text_IO.Put_Line( "read index record");

      if (index.pointers (ownerRec).startPos > 0) then
         hh.owner := Bin_Read_Owner (Owner_File, index.pointers (ownerRec).startPos);
         Assert
           (hh.owner.SERNUM = hh.household.SERNUM,
            "owner sernum mismatch " &
            hh.owner.SERNUM'Img &
            " hh " &
            hh.household.SERNUM'Img);

      end if;
      Ada.Text_IO.Put
        (" index.pointers ( vehicleRec ).startPos " & index.pointers (vehicleRec).startPos'Img);
      if (index.pointers (vehicleRec).startPos > 0) then
         hh.numVehicles := index.pointers (vehicleRec).counter;
         for p in  1 .. index.pointers (vehicleRec).counter loop
            ptr             := index.pointers (vehicleRec).startPos + Integer (p) - 1;
            hh.vehicles (p) := Bin_Read_Vehicle (Vehicle_File, ptr);
            Assert
              (hh.vehicles (p).SERNUM = hh.household.SERNUM,
               "veh sernum mismatch " &
               hh.vehicles (p).SERNUM'Img &
               " hh " &
               hh.household.SERNUM'Img );
         end loop;
      end if;
      Ada.Text_IO.Put_Line( "Vehicle OK");

      if (index.pointers (mortgageRec).startPos > 0) then
         hh.numMortgages := index.pointers (mortgageRec).counter;
         for p in  1 .. index.pointers (mortgageRec).counter loop
            ptr              := index.pointers (mortgageRec).startPos + Integer (p) - 1;
            hh.mortgages (p) := Bin_Read_Mortgage (Mortgage_File, ptr);
            Assert
              (hh.mortgages (p).SERNUM = hh.household.SERNUM,
               "mort sernum mismatch mort" &
               hh.mortgages (p).SERNUM'Img &
               " hh " &
               hh.household.SERNUM'Img);
         end loop;
      end if;
      
       
      Ada.Text_IO.Put_Line( "Mortgage OK");
      if (index.pointers (mortContRec).startPos > 0) then
         hh.numMortConts := index.pointers (mortContRec).counter;
         for p in  1 .. index.pointers (mortContRec).counter loop
            ptr                        := index.pointers (mortContRec).startPos +
                                          Integer (p) -
                                          1;
            hh.mortCont (Integer (p))  := Bin_Read_MortCont (MortCont_File, ptr);
            Assert
              (hh.mortCont (p).SERNUM = hh.household.SERNUM,
               "mort mortCont mismatch mort" &
               hh.mortCont (p).SERNUM'Img &
               " hh " &
               hh.household.SERNUM'Img);
         end loop;
      end if;
      Ada.Text_IO.Put_Line( "Mortcont OK");
      Ada.Text_IO.Put
        ("index.pointers ( rentcontRec ).startPos=" & index.pointers (rentContRec).startPos'Img);
      Ada.Text_IO.Put
        ("  index.pointers ( rentcontRec ).counter=" & index.pointers (rentContRec).counter'Img);
      Ada.Text_IO.New_Line;
      if (index.pointers (rentContRec).startPos > 0) then
         hh.numRentConts := index.pointers (rentContRec).counter;
         for p in  1 .. index.pointers (rentContRec).counter loop
            ptr                        := index.pointers (rentContRec).startPos +
                                          Integer (p) -
                                          1;
            hh.rentCont (Integer (p))  := Bin_Read_RentCont (RentCont_File, ptr);
            Assert
              (hh.rentCont (p).SERNUM = hh.household.SERNUM,
               "mort rentCont mismatch mort" &
               hh.rentCont (p).SERNUM'Img &
               " hh " &
               hh.household.SERNUM'Img);
         end loop;
      end if;
      Ada.Text_IO.Put_Line( "RentCont OK");

      if (index.pointers (benunitRec).startPos > 0) then
         hh.num_benefit_units := index.pointers (benunitRec).counter;
         for p in  1 .. index.pointers (benunitRec).counter loop
            ptr                        := index.pointers (benunitRec).startPos +
                                          Integer (p) -
                                          1;
            benunit                    := Bin_Read_Benunit (Benunit_File, ptr);
            buno                       := Integer (benunit.BENUNIT);
            hh.benunits (buno).benunit := benunit;
            Assert
              (hh.benunits (buno).benunit.SERNUM = hh.household.SERNUM,
               " benunits sernum mismatch" &
               hh.benunits (p).benunit.SERNUM'Img &
               " hh " &
               hh.household.SERNUM'Img );
         end loop;
      end if;
      
      if (index.pointers (hbaiRec).startPos > 0 ) then
         hh.num_benefit_units := index.pointers (hbaiRec).counter;
         for p in  1 .. index.pointers (hbaiRec).counter loop
            ptr := index.pointers (hbaiRec).startPos + p - 1;
            hbai := Bin_Read_Hbai (Hbai_File, ptr);
            buno := hbai.BENUNIT;
            hh.benunits (buno).hbai := hbai;
            
            Assert
              (hh.benunits (buno).hbai.SERNUM = hh.household.SERNUM,
               " hbais sernum mismatch" &
               hh.benunits(p).hbai.SERNUM'Img &
               " hh " &
               hh.household.SERNUM'Img );
             --
             -- FIXME lots of fixes here to ensure we've matched HBAI benunit to frs benunit
             -- 
         end loop;
      end if;


      Ada.Text_IO.Put_Line( "BenUnits OK");

      if (index.pointers (careRec).startPos > 0) then
         declare
            buCounter : BuCounterArray := (others => 0);
            care      : Care_Rec;
         begin
            for p in  1 .. index.pointers (careRec).counter loop
               ptr                                          := index.pointers (careRec).startPos +
                                                               Integer (p) -
                                                               1;
               care                                         := Bin_Read_Care (Care_File, ptr);
               buno                                         := Integer (care.BENUNIT);
               buCounter (buno)                             := buCounter (buno) + 1;
               hh.benunits (buno).cares (buCounter (buno))  := care;
               Assert
                 (hh.benunits (buno).cares (buCounter (buno)).SERNUM =
                  hh.household.SERNUM,
                  "benunit sernum mismatch" &
                  hh.benunits (p).cares (buCounter (buno)).SERNUM'Img &
                  " hh " &
                  hh.household.SERNUM'Img);
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "Care OK");

      if (index.pointers (extChildRec).startPos > 0) then
         declare
            buCounter : BuCounterArray := (others => 0);
            extChild  : ExtChild_Rec;
         begin
            for p in  1 .. index.pointers (extChildRec).counter loop
               ptr                                             :=
                 index.pointers (extChildRec).startPos + Integer (p) - 1;
               extChild                                        :=
                  Bin_Read_ExtChild (ExtChild_File, ptr);
               buno                                            := Integer (extChild.BENUNIT);
               buCounter (buno)                                := buCounter (buno) + 1;
               hh.benunits (buno).extchild (buCounter (buno))  := extChild;
               Assert
                 (hh.benunits (buno).extchild (buCounter (buno)).SERNUM =
                  hh.household.SERNUM,
                  " benunits sernum ");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "read extchild OK");
      if (index.pointers (childRec).startPos > 0) then
         declare
            child : Child_Rec;
            chno  : Child_Count;
         begin
            for p in  1 .. index.pointers (childRec).counter loop
               ptr                                      := index.pointers (childRec).startPos +
                                                           Integer (p) -
                                                           1;
               child                                    := Bin_Read_Child (Child_File, ptr);
               buno                                     := Integer (child.BENUNIT);
               hh.benunits (buno).num_children           := hh.benunits (buno).num_children + 1;
               chno                                     :=
                 Child_Count (hh.benunits (buno).num_children);
               hh.benunits (buno).children (chno).child := child;
               Assert
                 (child.SERNUM = hh.household.SERNUM,
                  "child sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "child");
      if (index.pointers (adultRec).startPos > 0) then
         declare
            adult  : Adult_Rec;
            adNo   : Integer;
            person : Integer;
         begin
            for p in  1 .. index.pointers (adultRec).counter loop
               ptr    := index.pointers (adultRec).startPos + Integer (p) - 1;
               adult  := Bin_Read_Adult (Adult_File, ptr);
               buno   := Integer (adult.BENUNIT);
               person := Integer (adult.PERSON);
               if (hh.benunits (buno).numAdults = 0) then
                  adNo                         := 1;
                  hh.benunits (buno).numAdults := 1;
               else
                  adNo                         := 2;
                  hh.benunits (buno).numAdults := 2;
               end if;
               personMapping (person).buno            := buno;
               personMapping (person).adno            := adNo;
               hh.benunits (buno).adults (adNo).adult := adult;
               Assert
                 (adult.SERNUM = hh.household.SERNUM,
                  "adult sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "adult OK");
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put
        (" index.pointers (jobRec).startPos " &
         index.pointers (jobRec).startPos'Img &
         " index.pointers (jobRec).counter " &
         index.pointers (jobRec).counter'Img);
      if (index.pointers (jobRec).startPos > 0) then
         declare
            job    : Job_Rec;
            person : Integer;
            jobNo  : Job_Count;
            adNo   : Integer;
         begin
            for p in  1 .. index.pointers (jobRec).counter loop
               ptr    := index.pointers (jobRec).startPos + Integer (p) - 1;
               job    := Bin_Read_Job (Job_File, ptr);
               buno   := Integer (job.BENUNIT);
               person := Integer (job.PERSON);
               jobNo  := Job_Count (job.JOBTYPE); -- 1..3
               --  this is safe since the jobs are always in ascending
               --  order
               buno                                          := personMapping (person).buno;
               adNo                                          := personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numJobs      := jobNo;
               hh.benunits (buno).adults (adNo).jobs (jobNo) := job;
               Assert (job.SERNUM = hh.household.SERNUM, "job sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "job OK");

      if (index.pointers (accountRec).startPos > 0) then
         declare
            accounts   : Account_Rec;
            person     : Integer;
            accountsNo : Account_Count;
            adNo       : Integer;
         begin
            for p in  1 .. index.pointers (accountRec).counter loop
               ptr                                                    :=
                 index.pointers (accountRec).startPos + Integer (p) - 1;
               accounts                                               :=
                  Bin_Read_Account (Account_File, ptr);
               buno                                                   :=
                 Integer (accounts.BENUNIT);
               person                                                 := Integer (accounts.PERSON);
               buno                                                   :=
                 personMapping (person).buno;
               adNo                                                   :=
                 personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numAccounts           :=
                 hh.benunits (buno).adults (adNo).numAccounts + 1;
               accountsNo                                             :=
                 Account_Count (hh.benunits (buno).adults (adNo).numAccounts);
               hh.benunits (buno).adults (adNo).accounts (accountsNo) := accounts;
               Assert
                 (accounts.SERNUM = hh.household.SERNUM,
                  "accounts sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "accounts OK");

      if (index.pointers (assetRec).startPos > 0) then
         declare
            assets   : Asset_Rec;
            person   : Integer;
            assetsNo : Asset_Count;
            adNo     : Integer;
         begin
            for p in  1 .. index.pointers (assetRec).counter loop
               ptr                                                :=
                 index.pointers (assetRec).startPos + Integer (p) - 1;
               assets                                             :=
                  Bin_Read_Asset (Asset_File, ptr);
               buno                                               := Integer (assets.BENUNIT);
               person                                             := Integer (assets.PERSON);
               buno                                               := personMapping (person).buno;
               adNo                                               := personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numAssets         :=
                 hh.benunits (buno).adults (adNo).numAssets + 1;
               assetsNo                                           :=
                 Asset_Count (hh.benunits (buno).adults (adNo).numAssets);
               hh.benunits (buno).adults (adNo).assets (assetsNo) := assets;
               Assert
                 (assets.SERNUM = hh.household.SERNUM,
                  "assets sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "assets OK");

      if (index.pointers (benefitRec).startPos > 0) then
         declare
            benefits   : Benefit_Rec;
            person     : Integer;
            benefitsNo : Benefit_Count;
            adNo       : Integer;
         begin
            for p in  1 .. index.pointers (benefitRec).counter loop
               ptr      := index.pointers (benefitRec).startPos + Integer (p) - 1;
               benefits := Bin_Read_Benefit (Benefit_File, ptr);

               buno   := Integer (benefits.BENUNIT);
               person := Integer (benefits.PERSON);
               buno   := personMapping (person).buno;
               adNo   := personMapping (person).adno;
               if ((buno = 0) or (adNo = 0)) then
                  --  FIXME:: THIS IS A HACK: Children's benefits assign to adult(1,1) for now
                  --  Since child records don't have benefit slots.
                  adNo := 1;
                  buno := 1;
               end if;
               Ada.Text_IO.Put
                 ("benefits: sernum = " &
                  benefits.SERNUM'Img &
                  "adno " &
                  adNo'Img &
                  "buno " &
                  buno'Img);
               hh.benunits (buno).adults (adNo).numBenefits           :=
                 hh.benunits (buno).adults (adNo).numBenefits + 1;
               benefitsNo                                             :=
                 Benefit_Count (hh.benunits (buno).adults (adNo).numBenefits);
               hh.benunits (buno).adults (adNo).benefits (benefitsNo) := benefits;
               Assert
                 (benefits.SERNUM = hh.household.SERNUM,
                  "benefits sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "benefits OK");

      if (index.pointers (govPayRec).startPos > 0) then
         declare
            govPays   : GovPay_Rec;
            person    : Integer;
            govPaysNo : GovPay_Count;
            adNo      : Integer;
         begin
            for p in  1 .. index.pointers (govPayRec).counter loop
               ptr                                                 :=
                 index.pointers (govPayRec).startPos + Integer (p) - 1;
               govPays                                             :=
                  Bin_Read_GovPay (GovPay_File, ptr);
               buno                                                := Integer (govPays.BENUNIT);
               person                                              := Integer (govPays.PERSON);
               buno                                                := personMapping (person).buno;
               adNo                                                := personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numGovpays         :=
                 hh.benunits (buno).adults (adNo).numGovpays + 1;
               govPaysNo                                           :=
                 GovPay_Count (hh.benunits (buno).adults (adNo).numGovpays);
               hh.benunits (buno).adults (adNo).govpay (govPaysNo) := govPays;
               Assert
                 (govPays.SERNUM = hh.household.SERNUM,
                  "govPays sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "govPays OK");

      if (index.pointers (maintRec).startPos > 0) then
         declare
            maintenance : Maint_Rec;
            person      : Integer;
            maintNo     : Maintenance_Count;
            adNo        : Integer;
         begin
            for p in  1 .. index.pointers (maintRec).counter loop
               ptr         := index.pointers (maintRec).startPos + Integer (p) - 1;
               maintenance := Bin_Read_Maint (Maint_File, ptr);
               buno        := Integer (maintenance.BENUNIT);
               person      := Integer (maintenance.PERSON);
               --  this is safe since the jobs are always in ascending
               --order
               buno                                                    :=
                 personMapping (person).buno;
               adNo                                                    :=
                 personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numMaintenances        :=
                 hh.benunits (buno).adults (adNo).numMaintenances + 1;
               maintNo                                                 :=
                 Maintenance_Count (hh.benunits (buno).adults (adNo).numMaintenances);
               hh.benunits (buno).adults (adNo).maintenances (maintNo) := maintenance;
               Assert
                 (maintenance.SERNUM = hh.household.SERNUM,
                  "maintenance sernum mismatch");
            end loop;
         end;
      end if;
      Ada.Text_IO.Put_Line( "Maints OK");

      if (index.pointers (oddJobRec).startPos > 0) then
         declare
            oddJobs   : OddJob_Rec;
            person    : Integer;
            oddJobsNo : OddJob_Count;
            adNo      : Integer;
         begin
            for p in  1 .. index.pointers (oddJobRec).counter loop
               ptr     := index.pointers (oddJobRec).startPos + Integer (p) - 1;
               oddJobs := Bin_Read_OddJob (OddJob_File, ptr);
               buno    := Integer (oddJobs.BENUNIT);
               person  := Integer (oddJobs.PERSON);
               --  this is safe since the jobs are always in ascending
               --order
               buno                                                 := personMapping (person).buno;
               adNo                                                 := personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numOddJobs          :=
                 hh.benunits (buno).adults (adNo).numOddJobs + 1;
               oddJobsNo                                            :=
                 OddJob_Count (hh.benunits (buno).adults (adNo).numOddJobs);
               hh.benunits (buno).adults (adNo).oddJobs (oddJobsNo) := oddJobs;
               Assert
                 (oddJobs.SERNUM = hh.household.SERNUM,
                  "oddjobs sernum mismatch");

            end loop;
         end;
      end if;

      if (index.pointers (pensionRec).startPos > 0) then
         declare
            pensions   : Pension_Rec;
            person     : Integer;
            pensionsNo : Pension_Count;
            adNo       : Integer;
         begin
            for p in  1 .. index.pointers (pensionRec).counter loop
               ptr      := index.pointers (pensionRec).startPos + Integer (p) - 1;
               pensions := Bin_Read_Pension (Pension_File, ptr);
               buno     := Integer (pensions.BENUNIT);
               person   := Integer (pensions.PERSON);
               --  this is safe since the jobs are always in ascending
               --order
               buno                                                   :=
                 personMapping (person).buno;
               adNo                                                   :=
                 personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numpensions           :=
                 hh.benunits (buno).adults (adNo).numpensions + 1;
               pensionsNo                                             :=
                 Pension_Count (hh.benunits (buno).adults (adNo).numpensions);
               hh.benunits (buno).adults (adNo).pensions (pensionsNo) := pensions;
               Assert
                 (pensions.SERNUM = hh.household.SERNUM,
                  "pensions sernum mismatch");
            end loop;
         end;
      end if;

      if (index.pointers (PenProvRec).startPos > 0) then
         declare
            PenProvs   : PenProv_Rec;
            person     : Integer;
            PenProvsNo : Pension_Count;
            adNo       : Integer;
         begin
            for p in  1 .. index.pointers (PenProvRec).counter loop
               ptr      := index.pointers (PenProvRec).startPos + Integer (p) - 1;
               PenProvs := Bin_Read_PenProv (PenProv_File, ptr);
               buno     := Integer (PenProvs.BENUNIT);
               person   := Integer (PenProvs.PERSON);
               --  this is safe since the jobs are always in ascending
               --order
               buno                                                   :=
                 personMapping (person).buno;
               adNo                                                   :=
                 personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numPenProvs           :=
                 hh.benunits (buno).adults (adNo).numPenProvs + 1;
               PenProvsNo                                             :=
                 Pension_Count (hh.benunits (buno).adults (adNo).numPenProvs);
               hh.benunits (buno).adults (adNo).PenProvs (PenProvsNo) := PenProvs;
               Assert
                 (PenProvs.SERNUM = hh.household.SERNUM,
                  "PenProvs sernum mismatch");
            end loop;
         end;
      end if;

      if (index.pointers (PenAmtRec).startPos > 0) then
         declare
            PenAmts   : PenAmt_Rec;
            person     : Integer;
            PenAmtsNo : Pension_Count;
            adNo       : Integer;
         begin
            for p in  1 .. index.pointers (PenAmtRec).counter loop
               ptr      := index.pointers (PenAmtRec).startPos + Integer (p) - 1;
               PenAmts := Bin_Read_PenAmt (PenAmt_File, ptr);
               buno     := Integer (PenAmts.BENUNIT);
               person   := Integer (PenAmts.PERSON);
               --  this is safe since the jobs are always in ascending
               --order
               buno                                                   :=
                 personMapping (person).buno;
               adNo                                                   :=
                 personMapping (person).adno;
               hh.benunits (buno).adults (adNo).numPenAmts           :=
                 hh.benunits (buno).adults (adNo).numPenAmts + 1;
               PenAmtsNo                                             :=
                 Pension_Count (hh.benunits (buno).adults (adNo).numPenAmts);
               hh.benunits (buno).adults (adNo).PenAmts (PenAmtsNo) := PenAmts;
               Assert
                 (PenAmts.SERNUM = hh.household.SERNUM,
                  "PenAmts sernum mismatch");
            end loop;
         end;
      end if;

      return hh;

   end Get_Household;

end frs_binary_reads;
