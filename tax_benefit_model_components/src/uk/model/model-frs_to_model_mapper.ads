--
--  $Author: graham_s $
--  $Date: 2008-08-20 08:46:59 +0100 (Wed, 20 Aug 2008) $
--  $Revision: 5687 $
--
--
pragma License( Modified_GPL );

with Base_Model_Types; 
with raw_frs; use raw_frs;
with Model.Household; 
with Data_Constants;  

package Model.FRS_To_Model_Mapper is
   
   package modhh renames Model.Household;

   use Base_Model_Types;
   use Data_Constants;

   function Map( hh : Raw_Household; year : Data_Years ) return modhh.Household_Rec;
   procedure Validate_Against_HBAI( hh : Raw_Household; mhh : modhh.Household_Rec );

end Model.FRS_To_Model_Mapper;
