--
--  $Author: graham_s $
--  $Date: 2013-04-17 11:18:41 +0100 (Wed, 17 Apr 2013) $
--  $Revision: 16025 $
--
with Raw_FRS;          
with Ada.Direct_IO;
with Data_Constants;   
with Conversions.FRS; 

package FRS_Binary_Reads is

   use Conversions.FRS;
   use data_constants;
   use Raw_FRS;
   
   package Account_io is new Ada.Direct_IO (Account_Rec);
   package Adult_io is new Ada.Direct_IO (Adult_Rec);
   package Asset_io is new Ada.Direct_IO (Asset_Rec);
   package Benefit_io is new Ada.Direct_IO (Benefit_Rec);
   package Benunit_io is new Ada.Direct_IO (Benunit_Rec);
   package Care_io is new Ada.Direct_IO (Care_Rec);
   package Child_io is new Ada.Direct_IO (Child_Rec);
   package Endowment_io is new Ada.Direct_IO (Endowment_Rec);
   package ExtChild_io is new Ada.Direct_IO (ExtChild_Rec);
   package GovPay_io is new Ada.Direct_IO (GovPay_Rec);
   package Household_io is new Ada.Direct_IO (Household_Rec);
   package Insurance_io is new Ada.Direct_IO (Insurance_Rec);
   package Job_io is new Ada.Direct_IO (Job_Rec);
   package Maint_IO is new Ada.Direct_IO (Maint_Rec);
   package MortCont_io is new Ada.Direct_IO (MortCont_Rec);
   package Mortgage_io is new Ada.Direct_IO (Mortgage_Rec);
   package OddJob_io is new Ada.Direct_IO (OddJob_Rec);
   package Owner_io is new Ada.Direct_IO (Owner_Rec);
   package RentCont_io is new Ada.Direct_IO (RentCont_Rec);
   package Renter_io is new Ada.Direct_IO (Renter_Rec);
   package Pension_io is new Ada.Direct_IO (Pension_Rec);
   package PenProv_io is new Ada.Direct_IO (PenProv_Rec);
   package PenAmt_io is new Ada.Direct_IO (PenAmt_Rec);
   package ChildCare_IO is new Ada.Direct_IO ( ChildCare_Rec );
   package Vehicle_io is new Ada.Direct_IO (Vehicle_Rec);
   package Admin_io is new Ada.Direct_IO (Admin_Rec);
   package Hbai_io is new Ada.Direct_IO (Hbai_Rec);
   package Nimigr_IO is new Ada.Direct_IO (Nimigr_Rec);
   package Prscrptn_IO is new Ada.Direct_IO (Prscrptn_Rec);
   
   function Get_Household( index : Index_Rec ) return Raw_Household;

   procedure Open_Files ( year : Data_Years );

   procedure Close_Files;


end FRS_Binary_Reads;
