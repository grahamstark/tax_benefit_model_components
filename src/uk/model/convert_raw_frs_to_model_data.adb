with Base_Model_Types;
with Raw_FRS;
with Model.Household;
with Data_Constants;
with Model.FRS_To_Model_Mapper;
with Conversions;
with Conversions.FRS;
with FRS_Binary_Reads;
with Ada.Text_IO;
with Text_Utils;

procedure Convert_Raw_FRS_To_Model_Data is

   use Conversions;
   use Conversions.FRS;
   use FRS_Binary_Reads;
   use Data_Constants;
   use FRS_Index_Package;
   use Ada.Text_IO;
   use Text_Utils;
   
   package modhh renames Model.Household;
   package raw_to_mod renames Model.FRS_To_Model_Mapper;

   index_map   : FRS_Index;
   index       : Index_Rec;
   hh_file     : modhh.HH_IO.File_Type;
   size        : Natural := 0;
   this_year   : Data_Years;
   p           : Natural := 0;
   
   procedure Convert_Household( pos : Cursor ) is
      use modhh;
      mhh         : Household_Rec;
      rawhh       : Raw_FRS.Raw_Household;
   begin
         index := Element( pos );
         rawhh := Get_Household( index );
         mhh   := raw_to_mod.Map( rawhh, this_year );
         p := p + 1;
         if( p <= 0 ) then
            Put_Line( "raw household " & Natural'Image(p) );
            Put_Line( Raw_FRS.To_String( rawhh ));
            Put_Line( "model household "  & Natural'Image(p));
            Put_Line( To_String( mhh ));
         end if;
         raw_to_mod.Validate_Against_HBAI( rawhh, mhh );
         hh_io.Write( hh_file, mhh );
   end Convert_Household;

begin
   put_line( "started" );
   for year in Data_Years loop
      p := 0;
      -- if( year = 2005 ) then
      this_year := year; -- semi global for the iterate function
      put_line( "on year " & year'Img );
      Restore_Complete_Index( BASE_DATA_DIR & DATA_YEAR_STRINGS(year) & "/bin/index.bin", index_map );
      put_line( "index restored " & year'Img );
      modhh.Initialise(
         TuS( "/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/model_datasets/" ), 
         hh_file, year, size, True );
      put_line( "model data initialised " & year'Img );
      FRS_Binary_Reads.Open_Files( year );
      Iterate( index_map, Convert_Household'Access );
      FRS_Binary_Reads.Close_Files;
      modhh.HH_IO.Close( hh_file );
      -- end if;
   end loop;
   put_line( "done" );
end Convert_Raw_FRS_To_Model_Data;
