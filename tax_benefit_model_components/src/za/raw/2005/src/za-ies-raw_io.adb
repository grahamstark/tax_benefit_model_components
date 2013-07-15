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

with Ada.Containers.Ordered_Maps;
with Ada.Text_IO;
with Ada.Direct_IO;
with Text_Utils;
with Ada.Directories;

package body ZA.IES.Raw_IO is

   -- RAW_DATA_DIR : constant String := "/mnt/data/za/ies/2005/raw/org0160/";
   RAW_DATA_DIR : constant String := "C:\IES\2005\RAW\ORG0160\";

   package Person_Income_IO is new Ada.Direct_IO ( Person_Income );
   package Person_Info_IO is new Ada.Direct_IO ( Person_Info );
   package Total_IES_IO is new Ada.Direct_IO ( Total_IES );
   package House_Info_IO is new Ada.Direct_IO ( House_Info );
   package Purchase_Place_IO is new Ada.Direct_IO ( Purchase_Place );
   package Supported_Persons_IO is new Ada.Direct_IO ( Supported_Persons );

   function Lenient_Int( s : String ) return Integer is
      use Ada.Text_IO;
   begin
      Put_Line( "converting |" & s & "| " );
      if( s = "     ." ) or ( s = "    ." ) or ( s = "   ." ) or ( s = "  ." ) or ( s = " ." ) then
         return 0;
      end if;
      return Integer'Value( s );
   end Lenient_Int;

    function Parse_Person_Info( s : String ) return Person_Info is
      use Ada.Text_IO;
      rec : Person_Info;
    begin
      Put_Line( "#1" & s( 1 .. 14 ) );
      rec.Uqno := Sernum_Value'Value( s( 1 .. 14 ) );
      rec.Personno := Integer'Value( s( 15 .. 16 ) );
      Put_Line( "#2" );
      rec.Gender := Convert_Gender_type( s( 17 .. 17 ) );
      rec.Agegrp := Convert_Age_Group_Type( s( 19 .. 20 ) );
      rec.Popgrp := Convert_Population_Group( s( 18 .. 18 ) );
      rec.Week2_spentw2 := Convert_Week2_spentw2_type( s( 21 .. 21 ) );
      rec.Week3_spentw3 := Convert_Week2_spentw2_type( s( 22 .. 22 ) );
      rec.Week4_spentw4 := Convert_Week2_spentw2_type( s( 23 .. 23 ) );
      rec.Week5_spentw5 := Convert_Week2_spentw2_type( s( 24 .. 24 ) );
      rec.Q11a01srcinc := Convert_Week2_spentw2_type( s( 25 .. 25 ) );
      rec.Q11a02srcinc := Convert_Week2_spentw2_type( s( 26 .. 26 ) );
      rec.Q11a03srcinc := Convert_Week2_spentw2_type( s( 27 .. 27 ) );
      rec.Q11a04srcinc := Convert_Week2_spentw2_type( s( 28 .. 28 ) );
      rec.Q11a05srcinc := Convert_Yes_No_Unspecified_Type( s( 29 .. 29 ) );
      rec.Q11a07srcinc := Convert_Week2_spentw2_type( s( 31 .. 31 ) );
      rec.Q11a08srcinc := Convert_Week2_spentw2_type( s( 32 .. 32 ) );
      rec.Q11a09srcinc := Convert_Week2_spentw2_type( s( 33 .. 33 ) );
      rec.Q11a10srcinc := Convert_Week2_spentw2_type( s( 34 .. 34 ) );
      rec.Q11a11srcinc := Convert_Week2_spentw2_type( s( 35 .. 35 ) );
      rec.Q11a12srcinc := Convert_Week2_spentw2_type( s( 36 .. 36 ) );
      rec.Q11a13srcinc := Integer'Value( s( 37 .. 37 ) );
      rec.Q12tobacco1 := Convert_Tobacco1_Type( s( 40 .. 40 ) );
      rec.Q12tobacco2 := Convert_Tobacco2_Type( s( 41 .. 41 ) );
      rec.Q12tobacco3 := Convert_Tobacco3_Type( s( 42 .. 42 ) );
      rec.Tobacco4 := Convert_Tobacco4_type( s( 43 .. 43 ) );
      rec.Tobacco5 := Convert_Tobacco5_type( s( 44 .. 44 ) );
      rec.Q13read := Convert_Week2_spentw2_type( s( 45 .. 45 ) );
      rec.Q14write := Convert_Week2_spentw2_type( s( 46 .. 46 ) );
      rec.Q15higheduc := Convert_Education_Level( s( 47 .. 48 ) );
      rec.Weight := Lenient_Convert( s( 49 .. 60 ) );
      Put_Line( "#3" );
      return rec;
   end Parse_Person_Info;


   function Parse_Supported_Persons( s : in String ) return Supported_Persons is
      use Ada.Text_IO;
      use Text_Utils;
      rec : Supported_Persons;
   begin
      Put_Line( "#1 " & s( 1 .. 14 ) );
      rec.Uqno := Sernum_Value'Value( s( 1 .. 14 ) );
      Put_Line( "#2 " & s( 15 .. 16 ) );
      rec.Personsupported := Integer'Value( s( 15 .. 16 ) );
      Put_Line( "#3 " & s( 17 .. 18 ) );
      rec.Agegrp := Convert_Support_Age_Group_Type( s( 20 .. 21 ) );
      rec.Q19dwelltype := Convert_Dwelling_Type( s( 17 .. 18 ) );
      rec.Q110gender := Convert_Gender2( s( 19 .. 19 ) );
      rec.Q112popgroup := Convert_Population_Group( s( 22 .. 22 ) );
      rec.Q113support1 := Convert_Yes_No_NA_Unspecified( s( 23 .. 23 ) );
      rec.Q113support2 := Convert_Yes_No_NA_Unspecified( s( 24 .. 24 ) );
      rec.Q113support3 := Convert_Yes_No_NA_Unspecified( s( 25 .. 25 ) );
      rec.Q113support4 := Convert_Yes_No_NA_Unspecified( s( 26 .. 26 ) );
      rec.Q113support5 := Convert_Yes_No_NA_Unspecified( s( 27 .. 27 ) );
      rec.Q113support6 := Convert_Yes_No_NA_Unspecified( s( 28 .. 28 ) );
      rec.Q113support7 := Convert_Yes_No_NA_Unspecified( s( 29 .. 29 ) );
      rec.Q113support8 := Convert_Yes_No_NA_Unspecified( s( 30 .. 30 ) );
      rec.Q113support9 := Convert_Yes_No_NA_Unspecified( s( 31 .. 31 ) );
      Put_Line( "#4 " & s( 32 .. 36 ) );
      rec.Q114finaid := Lenient_Int( s( 32 .. 36 ) );
      Put_Line( "#5 " );
      rec.Q115moneyuse1 := Convert_Yes_No_NA_Unspecified( s( 37 .. 37 ) );
      rec.Q115moneyuse2 := Convert_Yes_No_NA_Unspecified( s( 38 .. 38 ) );
      rec.Q115moneyuse3 := Convert_Yes_No_NA_Unspecified( s( 39 .. 39 ) );
      rec.Q115moneyuse4 := Convert_Yes_No_NA_Unspecified( s( 40 .. 40 ) );
      rec.Q115moneyuse5 := Convert_Yes_No_NA_Unspecified( s( 41 .. 41 ) );
      rec.Q115moneyuse6 := Convert_Yes_No_NA_Unspecified( s( 42 .. 42 ) );
      rec.Q115moneyuse7 := Convert_Yes_No_NA_Unspecified( s( 43 .. 43 ) );
      rec.Q115moneyuse8 := Convert_Yes_No_NA_Unspecified( s( 44 .. 44 ) );
      rec.Q115moneyuse9 := Convert_Yes_No_NA_Unspecified( s( 45 .. 45 ) );
      rec.Q115moneyuse10 := Convert_Yes_No_NA_Unspecified( s( 46 .. 46 ) );
      rec.Q115moneyuse11 := Convert_Yes_No_NA_Unspecified( s( 47 .. 47 ) );
      return rec;
   end Parse_Supported_Persons;

   function Parse_Purchase_Place( s : in String ) return Purchase_Place is
       rec : Purchase_Place;
   begin
      rec.Uqno := Sernum_Value'Value( s( 1 .. 14 ) );
      rec.Prodcode := Integer'Value( s( 15 .. 16 ) );
      rec.Q21aareapurch := Convert_Area_Of_Purchase( s( 17 .. 17 ) );
      rec.Q21btyperetailer := Convert_Retailer_Type( s( 18 .. 18 ) );
      rec.Weight := Lenient_Convert( s( 19 .. 30 ) );
      return rec;
   end Parse_Purchase_Place;

   function Parse_House_Info( s : in String ) return House_Info is
      use Ada.Text_IO;
       rec : House_Info;
   begin
      Put_Line( "#1" );
      rec.Uqno := Sernum_Value'Value( s( 1 .. 14 ) );
      rec.Prov := Convert_Province_Type( s( 15 .. 15 ) );
      rec.Settlement := Convert_Settlement_Type( s( 16 .. 16 ) );
      rec.Surveyyear := Integer'Value( s( 17 .. 20 ) );
      rec.Surveymonth := Convert_Survey_Month( s( 21 .. 22 ) );
      rec.Hsize := Integer'Value( s( 23 .. 24 ) );
      Put_Line( "#2" );
      rec.Popgrpofhead := Convert_Population_Group_Of_Head( s( 25 .. 25 ) );
      rec.Genderofhead := Convert_Gender_type( s( 26 .. 26 ) );
      rec.Q16support := Convert_Q16support_type( s( 27 .. 27 ) );
      rec.Q17numsupport := Integer'Value( s( 28 .. 29 ) );
      rec.Q31dwelltypemain := Convert_Main_Dwelling_Type( s( 30 .. 31 ) );
      rec.Q31dwelltypeoth := Convert_Main_Dwelling_Type( s( 32 .. 33 ) );
      rec.Q32materialwalls := Convert_Wall_Materials_Type( s( 34 .. 35 ) );
      rec.Q32materialroof := Convert_Wall_Materials_Type( s( 36 .. 37 ) );
      rec.Q33govgrant := Convert_Yes_No_Dont_Know_Type( s( 38 .. 38 ) );
      rec.Q35typetoilet := Convert_Toilet_Type( s( 39 .. 40 ) );
      rec.Q36sharetoilet := Convert_Q36sharetoilet_type( s( 41 .. 41 ) );
      rec.Q37streetlight := Convert_Week2_spentw2_type( s( 42 .. 42 ) );
      rec.Q38elecsupply := Convert_Week2_spentw2_type( s( 43 .. 43 ) );
      rec.Q39energycook := Convert_Energy_For_Cooking_Type( s( 44 .. 45 ) );
      Put_Line( "#3" );
      rec.Q39energyheat := Convert_Energy_For_Heat_Type( s( 46 .. 47 ) );
      rec.Q39energylight := Convert_Energy_For_Lighting_Type( s( 48 .. 49 ) );
      rec.Q310refuse := Convert_Refuse_Type( s( 50 .. 50 ) );
      rec.Radio := Convert_Ownership_Type( s( 51 .. 51 ) );
      rec.Stereo_hifi := Convert_Ownership_Type( s( 52 .. 52 ) );
      rec.Tape_recorder := Convert_Ownership_Type( s( 53 .. 53 ) );
      rec.Television := Convert_Ownership_Type( s( 54 .. 54 ) );
      rec.Video_cassette_recorder_dvd := Convert_Ownership_Type( s( 55 .. 55 ) );
      Put_Line( "#4" );
      rec.Refrigerator_freezer := Convert_Ownership_Type( s( 56 .. 56 ) );
      rec.Stove_gas_or_electric := Convert_Ownership_Type( s( 57 .. 57 ) );
      rec.Microwave := Convert_Ownership_Type( s( 58 .. 58 ) );
      rec.Washing_machine := Convert_Ownership_Type( s( 59 .. 59 ) );
      rec.Motor_vehicle := Convert_Ownership_Type( s( 60 .. 60 ) );
      rec.Motor_cycle_scooter := Convert_Ownership_Type( s( 61 .. 61 ) );
      rec.Sewing_knitting_machine := Convert_Ownership_Type( s( 62 .. 62 ) );
      rec.Donkey_cart_ox_cart := Convert_Ownership_Type( s( 63 .. 63 ) );
      rec.Plough := Convert_Ownership_Type( s( 64 .. 64 ) );
      rec.Tractor := Convert_Ownership_Type( s( 65 .. 65 ) );
      rec.Wheelbarrow := Convert_Ownership_Type( s( 66 .. 66 ) );
      rec.Grinding_mill := Convert_Ownership_Type( s( 67 .. 67 ) );
      rec.Bicycle := Convert_Ownership_Type( s( 68 .. 68 ) );
      rec.Computer := Convert_Ownership_Type( s( 69 .. 69 ) );
      rec.Canoe_boat := Convert_Ownership_Type( s( 70 .. 70 ) );
      rec.Motorboat := Convert_Ownership_Type( s( 71 .. 71 ) );
      rec.Camera := Convert_Ownership_Type( s( 72 .. 72 ) );
      rec.Bed := Convert_Ownership_Type( s( 73 .. 73 ) );
      rec.Cellular_telephone := Convert_Ownership_Type( s( 74 .. 74 ) );
      rec.Landline_telephone := Convert_Ownership_Type( s( 75 .. 75 ) );
      rec.Satellite_dish := Convert_Ownership_Type( s( 76 .. 76 ) );
      rec.Internet := Convert_Ownership_Type( s( 77 .. 77 ) );
      Put_Line( "#5" );
      rec.Q41aoccrooms := Lenient_Int( s( 78 .. 78 ) );
      rec.Q41anorooms := Lenient_Int( s( 79 .. 79 ) );
      rec.Q41boccrooms := Lenient_Int( s( 80 .. 80 ) );
      rec.Q41bnorooms := Lenient_Int( s( 81 .. 81 ) );
      rec.Q41coccrooms := Lenient_Int( s( 82 .. 82 ) );
      rec.Q41cnorooms := Lenient_Int( s( 83 .. 83 ) );
      rec.Q41dnorooms := Lenient_Int( s( 85 .. 85 ) );
      rec.Q41eoccrooms := Lenient_Int( s( 86 .. 86 ) );
      rec.Q41enorooms := Lenient_Int( s( 87 .. 87 ) );
      rec.Q41foccrooms := Lenient_Int( s( 88 .. 88 ) );
      rec.Q41fnorooms := Lenient_Int( s( 89 .. 89 ) );
      rec.Q42nocars := Lenient_Int( s( 91 .. 91 ) );
      rec.Q44value := Lenient_Int( s( 92 .. 98 ) );
      rec.Q44valueimputed := Lenient_Int( s( 99 .. 104 ) );
      rec.Q45ownrent := Convert_Tenure_Type( s( 105 .. 105 ) );
      Put_Line( "#6" );
      rec.Q41totoccrooms := Lenient_Int( s( 106 .. 107 ) );
      rec.Q41totnorooms := Lenient_Int( s( 108 .. 109 ) );
      rec.Consumptions := Lenient_Convert( s( 110 .. 116 ) );
      rec.Inkindconsumptions := Lenient_Convert( s( 117 .. 123 ) );
      rec.Income := Lenient_Convert( s( 124 .. 130 ) );
      rec.Inkindincome := Lenient_Convert( s( 131 .. 137 ) );
      rec.Resultcode := Convert_Resultcode_type( s( 138 .. 138 ) );
      rec.Weight := Lenient_Convert( s( 139 .. 150 ) );
      Put_Line( "#7" );
      return rec;
   end Parse_House_Info;

   function Parse_Total_IES( s : in String ) return Total_IES is
       rec : Total_IES;
   begin
      rec.Uqno := Sernum_Value'Value( s( 1 .. 14 ) );
      rec.Coicop := Convert_Coicop_Type( s( 15 .. 22 ) );
      rec.Valuemain := Lenient_Convert( s( 25 .. 32 ) );
      rec.Valuediary := Lenient_Convert( s( 33 .. 40 ) );
      rec.Value := Lenient_Convert( s( 41 .. 48 ) );
      rec.Valuemainannualized := Lenient_Convert( s( 49 .. 56 ) );
      rec.ValueDiaryannualized := Lenient_Convert( s( 57 .. 64 ) );
      rec.Valueannualized := Lenient_Convert( s( 65 .. 72 ) );
      rec.Weight := Lenient_Convert( s( 73 .. 84 ) );
      return rec;
   end Parse_Total_IES;

   function Parse_Person_Income( s : in String ) return Person_Income is
       rec : Person_Income;
   begin
      rec.Uqno := Sernum_Value'Value( s( 1 .. 14 ) );
      rec.Personno := Integer'Value( s( 15 .. 16 ) );
      rec.Coicop := Convert_Coicop_Type( s( 17 .. 24 ) );
      rec.Value := Lenient_Convert( s( 25 .. 31 ) );
      rec.Weight := Lenient_Convert( s( 32 .. 43 ) );
      return rec;
   end Parse_Person_Income;

   procedure Read_Purchase_Place( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
      bin_file    : Purchase_Place_IO.File_Type;
      text_file    : File_Type;
      s  : String( 1 .. 1000 );
      rec : Purchase_Place;
      last : Natural;
      index       : Index_Rec;
      line_number : Natural := 0;
   begin
      Purchase_Place_IO.Create( bin_file, Purchase_Place_IO.Out_File, RAW_DATA_DIR & "Purchase_Place.bin" );
      Put_Line( "Read_Purchase_Place started |" & RAW_DATA_DIR & "Purchase_Place.txt|" );
      Open( text_file, In_File, RAW_DATA_DIR & "Purchase_Place.txt" );
      while not( End_Of_File( text_file ) ) loop
         line_number := line_number + 1;
         Get_Line( text_file, s, last );
         rec := Parse_Purchase_Place( s );
         index := IES_Data_Index.Get_Index( indexmap, rec.Uqno );
         if( index.pointers( Purchase_Place_Rec ).start_pos = 0 ) then
            index.pointers( Purchase_Place_Rec ).start_pos := line_number;
            index.SERNUM := rec.Uqno;
         end if;
         index.pointers( Purchase_Place_Rec ).counter := index.pointers( Purchase_Place_Rec ).counter + 1;
         IES_Data_Index.Put_Index( indexmap, index );
         Purchase_Place_IO.Write( bin_file, rec );
      end loop;
      Put_Line( "Read_Purchase_Place ended" );
      Close( text_file );
      Purchase_Place_IO.Close( bin_file );
   end Read_Purchase_Place;

   procedure Read_House_Info( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
      bin_file    : House_Info_IO.File_Type;
      text_file    : File_Type;
      s  : String( 1 .. 1000 );
      rec : House_Info;
      last : Natural;
      index       : Index_Rec;
      line_number : Natural := 0;
   begin
      House_Info_IO.Create( bin_file, House_Info_IO.Out_File, RAW_DATA_DIR & "House_info.bin" );
      Put_Line( "Read_House_Info started |" & RAW_DATA_DIR & "House_info.txt|" );
      Open( text_file, In_File, RAW_DATA_DIR & "House_info.txt" );
      while not( End_Of_File( text_file ) ) loop
         line_number := line_number + 1;
         Get_Line( text_file, s, last );
         rec := Parse_House_Info( s );
         index := IES_Data_Index.Get_Index( indexmap, rec.Uqno );
         if( index.pointers( House_Info_Rec ).start_pos = 0 ) then
            index.pointers( House_Info_Rec ).start_pos := line_number;
            index.SERNUM := rec.Uqno;
         end if;
         index.pointers( House_Info_Rec ).counter := index.pointers( House_Info_Rec ).counter + 1;
         IES_Data_Index.Put_Index( indexmap, index );
         House_Info_IO.Write( bin_file, rec );
         if( line_number < 10 ) then
            Put_Line( To_String( rec ) );
         end if;
      end loop;
      Put_Line( "Read_House_Info ended" );
      Close( text_file );
      House_Info_IO.Close( bin_file );
   end Read_House_Info;

   procedure Read_Total_IES( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
      bin_file    : Total_IES_IO.File_Type;
      text_file    : File_Type;
      s  : String( 1 .. 1000 );
      rec : Total_IES;
      last : Natural;
      index       : Index_Rec;
      line_number : Natural := 0;
   begin
      Total_IES_IO.Create( bin_file, Total_IES_IO.Out_File, RAW_DATA_DIR & "Total_ies.bin" );
      Put_Line( "Read_Total_IES started |" & RAW_DATA_DIR & "Total_ies.txt|" );
      Open( text_file, In_File, RAW_DATA_DIR & "Total_ies.txt" );
      while not( End_Of_File( text_file ) ) loop
         line_number := line_number + 1;
         Get_Line( text_file, s, last );
         rec := Parse_Total_IES( s );
         index := IES_Data_Index.Get_Index( indexmap, rec.Uqno );
         if( index.pointers( Total_IES_Rec ).start_pos = 0 ) then
            index.pointers( Total_IES_Rec ).start_pos := line_number;
            index.SERNUM := rec.Uqno;
         end if;
         index.pointers( Total_IES_Rec ).counter := index.pointers( Total_IES_Rec ).counter + 1;
         IES_Data_Index.Put_Index( indexmap, index );
         Total_IES_IO.Write( bin_file, rec );
         if( line_number < 10 ) then
            Put_Line( To_String( rec ) );
         end if;
      end loop;
      Put_Line( "Read_Total_IES ended" );
      Close( text_file );
      Total_IES_IO.Close( bin_file );
   end Read_Total_IES;


   procedure Read_Person_Income( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
      bin_file    : Person_Income_IO.File_Type;
      text_file    : File_Type;
      s  : String( 1 .. 1000 );
      rec : Person_Income;
      last : Natural;
      index       : Index_Rec;
      line_number : Natural := 0;
   begin
      Person_Income_IO.Create( bin_file, Person_Income_IO.Out_File, RAW_DATA_DIR & "Person_income.bin" );
      Put_Line( "Read_Person_Income started |" & RAW_DATA_DIR & "Person_income.txt|" );
      Open( text_file, In_File, RAW_DATA_DIR & "Person_income.txt" );
      while not( End_Of_File( text_file ) ) loop
         line_number := line_number + 1;
         Get_Line( text_file, s, last );
         rec := Parse_Person_Income( s );
         index := IES_Data_Index.Get_Index( indexmap, rec.Uqno );
         if( index.pointers( Person_Income_Rec ).start_pos = 0 ) then
            index.pointers( Person_Income_Rec ).start_pos := line_number;
            index.SERNUM := rec.Uqno;
         end if;
         index.pointers( Person_Income_Rec ).counter := index.pointers( Person_Income_Rec ).counter + 1;
         IES_Data_Index.Put_Index( indexmap, index );
         Person_Income_IO.Write( bin_file, rec );
         if( line_number < 10 ) then
            Put_Line( To_String( rec ) );
         end if;
      end loop;
      Put_Line( "Read_Person_Income ended" );
      Close( text_file );
      Person_Income_IO.Close( bin_file );
   end Read_Person_Income;

   procedure Read_Person_Info( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
      bin_file    : Person_Info_IO.File_Type;
      text_file    : File_Type;
      s  : String( 1 .. 1000 );
      rec : Person_Info;
      last : Natural;
      index       : Index_Rec;
      line_number : Natural := 0;
   begin
      Person_Info_IO.Create( bin_file, Person_Info_IO.Out_File, RAW_DATA_DIR & "Person_info.bin" );
      Put_Line( "Read_Person_Info started |" & RAW_DATA_DIR & "Supported_persons.txt|" );
      Open( text_file, In_File, RAW_DATA_DIR & "Person_info.txt" );
      while not( End_Of_File( text_file ) ) loop
         line_number := line_number + 1;
         Get_Line( text_file, s, last );
         rec := Parse_Person_Info( s );
         index := IES_Data_Index.Get_Index( indexmap, rec.Uqno );
         if( index.pointers( Person_Info_Rec ).start_pos = 0 ) then
            index.pointers( Person_Info_Rec ).start_pos := line_number;
            index.SERNUM := rec.Uqno;
         end if;
         index.pointers( Person_Info_Rec ).counter := index.pointers( Person_Info_Rec ).counter + 1;
         IES_Data_Index.Put_Index( indexmap, index );
         Person_Info_IO.Write( bin_file, rec );
         if( line_number < 10 ) then
            Put_Line( To_String( rec ) );
         end if;
      end loop;
      Put_Line( "Read_Person_Info ended" );
      Close( text_file );
      Person_Info_IO.Close( bin_file );
   end Read_Person_Info;

   procedure Read_Supported_Persons( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
      bin_file    : Supported_Persons_IO.File_Type;
      text_file    : File_Type;
      s  : String( 1 .. 1000 );
      rec : Supported_Persons;
      last : Natural;
      index       : Index_Rec;
      line_number : Natural := 0;
   begin
      Supported_Persons_IO.Create( bin_file, Supported_Persons_IO.Out_File, RAW_DATA_DIR & "Supported_persons.bin" );
      Put_Line( "Read_Supported_Persons started |" & RAW_DATA_DIR & "Supported_persons.txt|" );
      Open( text_file, In_File, RAW_DATA_DIR & "Supported_persons.txt" );
      while not( End_Of_File( text_file ) ) loop
         line_number := line_number + 1;
         Get_Line( text_file, s, last );
         rec := Parse_Supported_Persons( s );
         index := IES_Data_Index.Get_Index( indexmap, rec.Uqno );
         if( index.pointers( Supported_Persons_Rec ).start_pos = 0 ) then
            index.pointers( Supported_Persons_Rec ).start_pos := line_number;
            index.SERNUM := rec.Uqno;
         end if;
         index.pointers( Supported_Persons_Rec ).counter := index.pointers( Supported_Persons_Rec ).counter + 1;
         IES_Data_Index.Put_Index( indexmap, index );
         Supported_Persons_IO.Write( bin_file, rec );
         if( line_number < 10 ) then
            Put_Line( To_String( rec ) );
         end if;
      end loop;
      Put_Line( "Read_Supported_Persons ended" );
      Close( text_file );
      Supported_Persons_IO.Close( bin_file );
   end Read_Supported_Persons;

   person_income_file : Person_Income_IO.File_Type;
   person_info_file : Person_Info_IO.File_Type;
   total_ies_file : Total_IES_IO.File_Type;
   house_info_file : House_Info_IO.File_Type;
   purchase_place_file : Purchase_Place_IO.File_Type;
   supported_persons_file : Supported_Persons_IO.File_Type;

   function Read_Household( index : in Index_Rec ) return Household is
      use Ada.Text_IO;
      hh : Household;
      position : Positive;
      highest_pno : Natural := 0;
   begin
      House_Info_IO.Read(
         house_info_file,
         hh.housing,
         House_info_io.Count( index.pointers( House_Info_Rec ).start_pos ));
      for p in 1 .. index.pointers( Person_Info_Rec ).counter loop
         position := index.pointers( Person_Info_Rec ).start_pos + p - 1;
         declare
            info : Person_Info;
         begin
            Person_Info_io.Read(
               person_info_file,
               info,
               Person_Info_IO.Count( position ));
            if( info.uqno = Sernum_Value'First ) then
               Put_Line( "zero sernum found in hh " );
            else
               null; -- hh.num_people := hh.num_people + 1;
            end if;
            if( info.personno > highest_pno ) then
               highest_pno := info.personno;
            end if;
            hh.person( info.personno ).info := info;
         end;
      end loop;
      hh.num_people := highest_pno; --  FIXME: what if non-contigious?
      for p in 1 .. index.pointers( Total_IES_Rec ).counter loop
         position := index.pointers( Total_IES_Rec ).start_pos + p - 1;
         declare
            IES : Total_IES;
         begin
            Total_IES_IO.Read(
               total_ies_file,
               IES,
               Total_IES_IO.Count( position ));
            hh.expenditure_and_income( IES.Coicop ) := IES;
         end;
      end loop;
      for p in 1 .. index.pointers( Person_Income_Rec ).counter loop
         position := index.pointers( Person_Income_Rec ).start_pos + p - 1;
         declare
            inc : Person_Income;
         begin
            Person_Income_IO.Read(
               Person_Income_file,
               inc,
               Person_Income_IO.Count( position ));
            hh.person( inc.personno ).person_income( inc.coicop ) := inc;
         end;
      end loop;
      for p in 1 .. index.pointers( Purchase_Place_Rec ).counter loop
         position := index.pointers( Purchase_Place_Rec ).start_pos + p - 1;
         declare
            place_of_purchase : Purchase_Place;
         begin
            Purchase_Place_IO.Read(
               Purchase_Place_file,
               place_of_purchase,
               Purchase_Place_IO.Count( position ));
            hh.place_of_purchase( place_of_purchase.Prodcode ) := place_of_purchase;
         end;
      end loop;
      for p in 1 .. index.pointers( Supported_Persons_Rec ).counter loop
         position := index.pointers( Supported_Persons_Rec ).start_pos + p - 1;
         declare
            supported : Supported_Persons;
         begin
            Supported_Persons_IO.Read(
               supported_persons_file,
               supported,
               Supported_Persons_IO.Count( position ));
            hh.supported( supported.personsupported ) := supported;
         end;
      end loop;
      return hh;
   end Read_Household;


   procedure Open_Files is
   begin
      Person_Income_IO.Open( Person_Income_file, Person_Income_IO.In_File, RAW_DATA_DIR & "Person_income.bin" );
      Person_Info_IO.Open( Person_Info_file, Person_Info_IO.In_File, RAW_DATA_DIR & "Person_info.bin" );
      Total_IES_IO.Open( Total_IES_file, Total_IES_IO.In_File, RAW_DATA_DIR & "Total_ies.bin" );
      House_Info_IO.Open( House_Info_file, House_Info_IO.In_File, RAW_DATA_DIR & "House_info.bin" );
      Purchase_Place_IO.Open( Purchase_Place_file, Purchase_Place_IO.In_File, RAW_DATA_DIR & "Purchase_Place.bin" );
      Supported_Persons_IO.Open( Supported_Persons_file, Supported_Persons_IO.In_File, RAW_DATA_DIR & "Supported_persons.bin" );
   end Open_Files;

   procedure Close_Files is
   begin
      Person_Income_IO.Close( Person_Income_file );
      Person_Info_IO.Close( Person_Info_file );
      Total_IES_IO.Close( Total_IES_file );
      House_Info_IO.Close( House_Info_file );
      Purchase_Place_IO.Close( Purchase_Place_file );
      Supported_Persons_IO.Close( Supported_Persons_file );
   end Close_Files;

   function Open_Index return Index_Map is
      index : Index_Map;
   begin
      IES_Data_Index.Restore_Complete_Index( RAW_DATA_DIR & "index.bin", index );
      return index;
   end Open_Index;

   procedure Close_Index( indexmap : in out Index_Map ) is
   begin
      IES_Data_Index.Store_Complete_Index( RAW_DATA_DIR & "index.bin", indexmap );
   end Close_Index;

   procedure Convert_To_Binary( indexmap : in out Index_Map ) is
      use Ada.Text_IO;
   begin
      Put_Line( "Convert_To_Binary started " );
      if( Ada.Directories.Exists( RAW_DATA_DIR & "index.bin" ))then
         Ada.Directories.Delete_File( RAW_DATA_DIR & "index.bin" );
      end if;
      Read_House_Info( indexmap );
      Read_Person_Info( indexmap );
      Read_Person_Income( indexmap );
      Read_Supported_Persons( indexmap );
      Read_Total_IES( indexmap );
      Read_Purchase_Place( indexmap );
      Put_Line( "Convert_To_Binary completed " );
   end Convert_To_Binary;

end ZA.IES.Raw_IO;
