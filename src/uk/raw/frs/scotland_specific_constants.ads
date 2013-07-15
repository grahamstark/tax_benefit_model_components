-- 
--  Bit of a hack, but a simple file with household references
--  and regions for Scotland.
--
--  $Author: graham_s $
--  $Date: 2008-11-13 23:23:58 +0000 (Thu, 13 Nov 2008) $
--  $Revision: 6180 $
--
with FRS_Enums; 
with Data_Constants;

package Scotland_Specific_Constants is

   use FRS_Enums;
   use Data_Constants;

   type Start_Stop_Pos is (start_pos, end_pos);

   type File_Positions_Array is array (DATA_YEARS, Start_Stop_Pos) of Integer;

   FILE_POSITIONS : constant File_Positions_Array := (
      2003 => (  22_149,  26_943 ), 
      2004 => (  21_592,  26_114 ), 
      2005 => (  21_694,  26_134 ) );

   subtype Scottish_Regional_Stratifier is FRS_Enums.Regional_Stratifier range
     highland_grampian_tayside .. north_of_the_caledonian_canal;
     
   function Get_Int_Value_Of_Stratifier( strat : Regional_Stratifier ) return Integer;
 
end Scotland_Specific_Constants;
