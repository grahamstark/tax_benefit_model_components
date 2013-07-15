--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

package body ZA.Model.Data.Binary_IO is
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;

   package Person_IO is new Ada.Direct_IO( Person_Rec );
   package Household_IO is new Ada.Direct_IO( Household_Info ); 
   package Person_Pos_IO is new Ada.Direct_IO( Positive );
   
   person_file : Person_IO.File_Type;
   household_file : Household_IO.File_Type;
   index_file : Person_Pos_IO.File_Type;
   last_person_pos : Positive := 1;
   model_data_dir : Unbounded_String := To_Unbounded_String( "/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/model_datasets/za/" );
   
   procedure Set_Model_Data_Dir( s : String ) is
   begin
      model_data_dir := To_Unbounded_String( s );
   end Set_Model_Data_Dir;

   procedure Set_Model_Data_Dir( s : Unbounded_String ) is
   begin
      model_data_dir := s;
   end Set_Model_Data_Dir;
   
   procedure Open_Files is
      dir : String := To_String( model_data_dir );
   begin
      Put_Line( "Opening from dir " &  To_String( model_data_dir ));
      Person_Pos_IO.Open( index_file, Person_Pos_IO.In_File, dir & "index.bin" );
      Person_IO.Open( person_file, Person_IO.In_File, dir & "person.bin" );
      Household_IO.Open( household_file, Household_IO.In_File, dir & "household.bin" );
   end Open_Files;
   
   procedure Close_Files is
   begin
      Person_IO.Close( Person_file );
      Household_IO.Close( household_file );
      Person_Pos_IO.Close( index_file );
   end Close_Files;
   
   function Num_Households return Household_Count is
   begin
      return Household_Count( Person_Pos_IO.Size( index_file ));
   end Num_Households;
   
   procedure Create_Files is
      dir : String := To_String( model_data_dir );
   begin
      Person_Pos_IO.Create( index_file, Person_Pos_IO.Out_File, dir & "index.bin" );
      Person_IO.Create( person_file, Person_IO.Out_File, dir & "person.bin" );
      Household_IO.Create( household_file, Household_IO.Out_File, dir & "household.bin" );
   end Create_Files;
   
  
   procedure Write( hh : Household ) is
   begin
      Household_IO.Write( household_file, hh.info );
      Person_Pos_IO.Write( index_file, last_person_pos );
      for fno in 1 .. hh.info.num_families loop
         for pno in 1 .. hh.family( fno ).num_people loop
            Person_IO.Write( person_file, hh.family( fno ).person( pno ));
         end loop;
      end loop;
      last_person_pos := last_person_pos + Positive( hh.info.num_people );
   end Write;
   
   function Read( href : Household_Count ) return Household is
      use Ada.Text_IO;
      type Ach is access Household;
      hh   : Household;
      info : Household_Info;
      person_start_pos : Positive;
      ha : AcH;
      person : Person_Rec;
   begin
      Household_IO.Read( 
         household_file, 
         hh.info, 
         Household_IO.Count( href ));
      Person_Pos_IO.Read( 
         index_file, 
         person_start_pos, 
         Person_Pos_IO.Count( href ));
      for pno in 1 .. hh.info.num_people loop
         declare
            seek_to : Person_IO.Count := Person_IO.Count( 
               person_start_pos + Positive( pno ) -1 );
         begin
            Person_IO.Read( 
               person_file, 
               person, 
               seek_to );
            hh.family( person.family_unit ).person( person.family_person_num ) := person;
            -- Put_Line( "FU " & person.family_unit'Img );
            -- Put_Line( "PN " & person.family_unit'Img );
            
            if( person.is_classed_as_adult ) then
               hh.family( person.family_unit ).num_adults := 
                  hh.family( person.family_unit ).num_adults + 1;
            else
               hh.family( person.family_unit ).num_children := 
                  hh.family( person.family_unit ).num_children + 1;
            end if;
            hh.family( person.family_unit ).num_people := 
               hh.family( person.family_unit ).num_people + 1;            
         end;
      end loop;
      Complete_Household_Information( hh );
      return hh;
   end Read;

end ZA.Model.Data.Binary_IO;
