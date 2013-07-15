--
-- $Revision: 5684 $
-- $Author $
-- $Date $
--
with raw_frs; use raw_frs;
with Ada.Text_IO;

with Base_Model_Types; use Base_Model_Types;

package FRS_Reader_0405 is

   DATA_DIR : constant String :=
      "/home/graham_s/VirtualWorlds/projects/scottish_legal_aid/data/0405/converted/";

   function loadAccount (file : Ada.Text_IO.File_Type) return Account_Rec;
   function loadAdult (file : Ada.Text_IO.File_Type) return Adult_Rec;
   function loadAsset (file : Ada.Text_IO.File_Type) return Asset_Rec;
   function loadBenefit (file : Ada.Text_IO.File_Type) return Benefit_Rec;
   function loadBenunit (file : Ada.Text_IO.File_Type) return Benunit_Rec;
   function loadCare (file : Ada.Text_IO.File_Type) return Care_Rec;
   function loadChild (file : Ada.Text_IO.File_Type) return Child_Rec;
   function loadEndowment (file : Ada.Text_IO.File_Type) return Endowment_Rec;
   function loadExtChild (file : Ada.Text_IO.File_Type) return ExtChild_Rec;
   function loadGovPay (file : Ada.Text_IO.File_Type) return GovPay_Rec;
   function loadHousehold (file : Ada.Text_IO.File_Type) return Household_Rec;
   function loadInsurance (file : Ada.Text_IO.File_Type) return Insurance_Rec;
   function loadJob (file : Ada.Text_IO.File_Type) return Job_Rec;
   function loadMaint (file : Ada.Text_IO.File_Type) return Maint_Rec;
   function loadMortCont (file : Ada.Text_IO.File_Type) return MortCont_Rec;
   function loadMortgage (file : Ada.Text_IO.File_Type) return Mortgage_Rec;
   function loadOddJob (file : Ada.Text_IO.File_Type) return OddJob_Rec;
   function loadOwner (file : Ada.Text_IO.File_Type) return Owner_Rec;
   function loadRentCont (file : Ada.Text_IO.File_Type) return RentCont_Rec;
   function loadRenter (file : Ada.Text_IO.File_Type) return Renter_Rec;
   function loadPenProv (file : Ada.Text_IO.File_Type) return PenProv_Rec;
   function loadPension (file : Ada.Text_IO.File_Type) return Pension_Rec;
   function loadPenAmt (file : Ada.Text_IO.File_Type) return PenAmt_Rec;

end FRS_Reader_0405;
