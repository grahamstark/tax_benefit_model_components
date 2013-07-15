with ZA_Enums;
with Base_Model_Types;
with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Text_Utils;
package body ZA.Household.Binary_IO is


   BASE_DATA_DIR : constant String := "/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/model_datasets/za/";
   
   package Expenditure_IO is new Ada.Direct_IO( Expenditure_Array );
   package Housing_Rec_IO is new Ada.Direct_IO( Housing_Rec );
   package Person_Rec_IO is new Ada.Direct_IO( Person_Rec );
   package Index_IO is new Ada.Direct_IO( Household_Index );
   
   expenditure_file : Expenditure_IO.File_Type;
   housing_file : Housing_Rec_IO.File_Type;
   person_file : Person_Rec_IO.File_Type;
   index_file : Index_IO.File_Type;
   
   function To_String( index : Household_Index ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & "HH Reference : " & Very_Large_Positive_Type'Image( index.reference_number ) & LINE_BREAK;
      s := s & "Num Families " & Family_Unit_Count'Image( index.num_families ) &  LINE_BREAK;
      s := s & "start_pos " & Positive'Image( index.start_pos ) &  LINE_BREAK;
      for tuno in 1 .. index.num_families loop
         s := s & Indent(2) & "== family start["& Positive'Image( tuno ) & " ] = " & 
              " start_pos: " & Positive'Image( index.family_starts( tuno ).startPos ) &
              " counter: " & Positive'Image( index.family_starts( tuno ).counter ) & LINE_BREAK;
         
      end loop;
      return To_String( s );
   end To_String;

   -- type Family_Unit_Index_Array is array( Family_Unit_Count ) of Record_Indicator;
   -- 
   -- type Household_Index is record
      -- reference_number : Very_Large_Positive_Type := 1;
      -- num_families : Family_Unit_Count := Family_Unit_Count'First;
      -- startPos : Natural := 0;
      -- family_starts : Family_Unit_Index_Array;
   -- end record;
   
   function Read_Index( which : Positive ) return Household_Index is
      index : Household_Index;
   begin
      Index_IO.Set_Index( index_file, Index_IO.Count( which ) );
      Index_IO.Read ( index_file, index );
      Ada.Text_IO.Put_Line( " index record( " & which'Img & ") " & To_String( index ) );
      return index;
   end Read_Index;


   function Read_Household( which : Positive ) return Household_Rec is
      hh : Household_Rec;
      index : constant Household_Index := Read_Index( which );
   begin
      Housing_Rec_IO.Set_Index( housing_file, Housing_Rec_IO.Count( which ) );
      Housing_Rec_IO.Read( housing_file, hh.housing );
      Expenditure_IO.Set_Index( expenditure_file, Expenditure_IO.Count( which ) );
      Expenditure_IO.Read( expenditure_file, hh.expenditure );
      hh.reference_number := index.reference_number;
      hh.num_families := index.num_families;
      for tuno in 1 .. hh.num_families loop  
         hh.family( tuno ).num_people := index.family_starts( tuno ).counter;
         Person_Rec_IO.Set_Index( person_file, Person_Rec_IO.Count( index.family_starts( tuno ).startPos ) );
         for pno in 1 .. hh.family( tuno ).num_people loop
               Person_Rec_IO.Read( person_file, hh.family( tuno ).person( pno ));
               hh.family( tuno ).person( pno ).age := hh.family( tuno ).person( pno ).demographics.age;
               hh.family( tuno ).person( pno ).gender := hh.family( tuno ).person( pno ).demographics.gender;
         end loop;
      end loop;
      return hh;
   end Read_Household;   
   
   procedure Write_Household( hh : Household_Rec; index : in out Household_Index ) is
      last_family  : Record_Indicator;
   begin
      if( index.reference_number > 1 ) then
         last_family := index.family_starts( index.num_families );
         index.family_starts( 1 ).startPos := last_family.startPos + last_family.counter;
      else -- 1st household
         index.family_starts( 1 ).startPos := 1;
      end if;
      index.reference_number := hh.reference_number;
      index.num_families := hh.num_families;
      for tuno in 1 .. hh.num_families loop
         index.family_starts( tuno ).counter := hh.family( tuno ).num_people;
         for pno in 1 .. hh.family( tuno ).num_people loop
            Person_Rec_IO.Write( person_file, hh.family( tuno ).person( pno ) );
         end loop;
         if( tuno > 1 ) then
            index.family_starts( tuno ).startPos := 
               index.family_starts( tuno-1 ).startPos + hh.family( tuno-1 ).num_people;
         end if;
      end loop;
      for tuno in hh.num_families + 1..Family_Unit_Count'Last loop
         index.family_starts( tuno ) := ( startPos=>0, others=>0 );
      end loop;      
      Expenditure_IO.Write( expenditure_file, hh.expenditure );
      Housing_Rec_IO.Write( housing_file, hh.housing );
      Index_IO.Write( index_file, index );
      index.start_pos := index.start_pos + 1;      
   end Write_Household;
   
   procedure Open_Files_For_Reading is
   begin
      Expenditure_IO.Open( expenditure_file, Expenditure_IO.In_File, BASE_DATA_DIR & "expenditure_file.bin" );
      Housing_Rec_IO.Open( housing_file, Housing_Rec_IO.In_File, BASE_DATA_DIR & "housing_file.bin" );
      Person_Rec_IO.Open( person_file, Person_Rec_IO.In_File, BASE_DATA_DIR & "person_file.bin" );
      Index_IO.Open( index_file, Index_IO.In_File, BASE_DATA_DIR & "index_file.bin" );
   end Open_Files_For_Reading;
   
   procedure Open_Files_For_Writing is
   begin
      Expenditure_IO.Create( expenditure_file, Expenditure_IO.Out_File, BASE_DATA_DIR & "expenditure_file.bin" );
      Housing_Rec_IO.Create( housing_file, Housing_Rec_IO.Out_File, BASE_DATA_DIR & "housing_file.bin" );
      Person_Rec_IO.Create( person_file, Person_Rec_IO.Out_File, BASE_DATA_DIR & "person_file.bin" );
      Index_IO.Create( index_file, Index_IO.Out_File, BASE_DATA_DIR & "index_file.bin" );
   end Open_Files_For_Writing;
   
   procedure Close_Files is
   begin
      Expenditure_IO.Close( expenditure_file );
      Housing_Rec_IO.Close( housing_file );
      Person_Rec_IO.Close( person_file );
      Index_IO.Close( index_file );
   end Close_Files;
   
   function No_More_Households return Boolean is
   begin
      return Index_IO.End_Of_File( index_file );
   end No_More_Households;
   
end ZA.Household.Binary_IO;
