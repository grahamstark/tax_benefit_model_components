--
--  $Author: graham_s $
--  $Date: 2011-08-25 16:37:04 +0100 (Thu, 25 Aug 2011) $
--  $Revision: 12611 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;   

with BHPS;
with BHPS_Enums;
with BHPS.Print;
with BHPS.Binary_IO;
with BHPS.XLookup;
with BHPS_Indexes;
with BHPS.State_Changes;
with BHPS.Binary_IO.Conversion_To_Binary;
with T_Utils;
with Base_Model_Types;
with GNAT.Regpat;
with Ada.Text_IO;

package body BHPS_Tests is
   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   use Ada.Text_IO;
   use BHPS.Print;
   use Base_Model_Types;
   
   package By_Region is new T_Utils( T=>BHPS_Enums.Region2_Type, Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type );
   
   procedure Set_Up (T : in out Test_Case) is
   begin
      null;
   end Set_Up;
   
   procedure Shut_Down( T : in out Test_Case) is
   begin
      null;
   end Shut_Down;
   
   procedure Test_Lookup(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
   use BHPS.XLookup;
   use BHPS; 
   use BHPS.Binary_IO;
   use BHPS.Print;
   use BHPS_Indexes;
      f       : File_Type;
      index   : X_Wave_Lookup := Load_XWave;
      indall  : Indall_Rec;   
      ptrs    : Record_Pointers;
      indresp : Indresp_Rec;
      hhid    : Sernum_Value;
   begin
      Create( f, Out_File, "tmp/index_tests.txt" );
      for wave in Waves_With_Data loop
         Open( ptrs, wave );
         Put_Line( "opening wave |" & wave & "| " );
         for pno in 1 .. 50 loop
            indresp := Bin_Read_Indresp( ptrs, pno );
            Put_Line( f, "wave " & wave & " indresp.pid " & indresp.pid'Img & " indresp.hid " & indresp.hid'Img );
            for owave in Waves loop
               hhid := index.Get_Household_Id( owave, indresp.pid ).hid; 
               if( owave = wave )then
                  Assert( hhid = indresp.hid, " hhid /= indresp.hid for wave " & wave & " hhid " & hhid'Img & " indresp.hid " & indresp.hid'Img );
               end if;
               Put_Line( f, "--- owave " & owave & " hhid " & hhid'Img );
            end loop;
         end loop;
         Close( ptrs, wave );
      end loop;
      Close( f );
    end Test_Lookup;

   procedure RE_Tests(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use GNAT.Regpat;
      JUNK_VAL_RE : constant Pattern_Matcher := Compile( "^(-+)$" ); -- some like '---' which I treat as missing 
      s1 : constant String := "----";
      matches : Match_Array( 0 .. 1 );
   begin
      Match( JUNK_VAL_RE, s1, matches);
      Assert( matches( 0 ) /= No_Match, "JUNK_VAL_RE should match '----' but fails" );
      Put_Line( "matched string is |" & s1( matches (1).first .. matches (1).last ) & "| " );
      Match( JUNK_VAL_RE, "2----", matches);
      Assert( matches( 0 ) = No_Match, "JUNK_VAL_RE should not match '2----' but does" );
   end RE_Tests;
      
   procedure Test_Dump_Indresp(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use BHPS; 
      use BHPS.Binary_IO;
      use BHPS.Print;
      
      f    : File_Type;
      ptrs : Record_Pointers;
      indresp : Indresp_Rec;
   begin
      Create( f, Out_File, "tmp/indresp_dump.txt" );
      for wave in Waves_With_Data loop
         Open( ptrs, wave );
         Put_Line( "opening wave |" & wave & "| " );
         for pno in 1 .. 50 loop
            indresp := Bin_Read_Indresp( ptrs, pno );
            Put_Line( f, To_String( indresp, 0, 0 ));
         end loop;
         Close( ptrs, wave );
      end loop;
      Close( f );
   end Test_Dump_Indresp;

   procedure Test_Dump_Indall(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use BHPS; 
      use BHPS.Binary_IO;
      use BHPS.Print;
      
      f    : File_Type;
      ptrs : Record_Pointers;
      indall : Indall_Rec;
   begin
      Create( f, Out_File, "tmp/indall_dump.txt" );
      for wave in Waves_With_Data loop
         Open( ptrs, wave );
         Put_Line( "opening wave |" & wave & "| " );
         for pno in 1 .. 50 loop
            indall := Bin_Read_Indall( ptrs, pno );
            Put_Line( f, To_String( indall, 0, 0 ));
         end loop;
         Close( ptrs, wave );
      end loop;
      Close( f );
   end Test_Dump_Indall;

   procedure Test_Dump_Child(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      use BHPS; 
      use BHPS.Binary_IO;
      use BHPS.Print;
      
      f    : File_Type;
      ptrs : Record_Pointers;
      indresp : Childnt_Rec;
   begin
      Create( f, Out_File, "tmp/childnt_dump.txt" );
      for wave in Waves_With_Data loop
         if( wave = 'b' or wave = 'k' or wave = 'l' )then
            Open( ptrs, wave );
            Put_Line( "opening wave |" & wave & "| " );
            for pno in 1 .. 50 loop
               indresp := Bin_Read_Childnt( ptrs, pno );
               Put_Line( f, To_String( indresp, 0, 0 ));
            end loop;
            Close( ptrs, wave );
         end if;
      end loop;
      Close( f );
   end Test_Dump_Child;
   
   -- Table 21
   -- Scotland Wales 1999/2000 oversample 
   -- 
   -- Addresses Issued 2475 2475
   -- Vacant/Non-residential/Foreign 302 295
   -- Multi-Households Addition to Sample 226 11
   -- Effective Sample Size 2399 2191
   -- Refusal to Field Agency/Research Centre 28 (1%) 33 (1%)
   -- Household Refusal to Interviewer 668 (28%) 580 (26%)
   -- Household Non-contact 189 (8%) 91 (4%)
   -- Language/Age/Infirmity Problems 55 (2%) 59 (3%)
   -- Complete Household Interview 1241 (52%) 1152 (53%)
   -- Complete Household Coverage (inc. proxies) 1276 (53%) 1186 (54%)
   -- Partial Household Coverage 1459 (61%) 1428 (65%)
   -- 
   
   procedure Test_Read_People( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   use BHPS; 
   use BHPS.Binary_IO;
   use BHPS.Print;
   use BHPS_Indexes;
   use BHPS_Index_Package;
   use BHPS_Map_Package;

      ptrs                 : Record_Pointers;
      total_num_people     : Natural := 0;
      wave                 : Waves;
      weighted_population  : Amount := 0.0;
   
      procedure Load_Adult( c : Index_Cursor ) is
         index : Index_Rec := Element( c );
         num_people : Person_Count := 0;
         ad         : Adult := Load_Adult( index, ptrs, wave );
         weight     : Amount;
      begin
         Put_Line( "on person " & Sernum_Value'Image( index.SERNUM ));
         if wave = 'a' then -- enumeration, not respondent : we need a respondent flag!
            weight := ad.indall.xewght;
         else
            weight := ad.indall.xewght;
         end if;
         Put_Line( "weight is " & Amount'Image( weight ));
         if( ad.pid > 0 )then
            weighted_population := weighted_population + weight;
            total_num_people := total_num_people + 1;
         end if;
      end Load_Adult;

      f                    : File_Type;
      index_map            : BHPS_Index;
   begin
      for wave in Waves_With_Data loop
         total_num_people  := 0;
         weighted_population := 0.0;
         Dump_Index( "/mnt/data/bhps/bin/" & wave & "/individual_index.bin", "index_" & wave & ".dump" );
         Restore_Complete_Index( "/mnt/data/bhps/bin/" & wave & "/individual_index.bin", index_map ); 
         Open( ptrs, wave );
         Put_Line( "on wave " & wave );
         index_map.Iterate( Load_Adult'Access );
         Put_Line( "total person population wave " & wave & " : " & 
            Natural'Image( total_num_people ) & 
            " weighted " & Amount'Image( weighted_population ));
         Close( ptrs, wave );
      end loop;
   end Test_Read_People;
   

   procedure Test_Read_Households( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   use BHPS; 
   use BHPS.Binary_IO;
   use BHPS.Print;
   use BHPS_Indexes;
   use BHPS_Index_Package;
   use BHPS_Map_Package;
      
      f                    : File_Type;
      ptrs                 : Record_Pointers;
      index_map            : BHPS_Index;
      -- all_adults           : Complete_Adult_Map;
      -- last_all_adults      : Complete_Adult_Map;
      hh                   : Household_Access;
      total_num_households : Natural := 0;
      total_num_people     : Natural := 0;
      total_num_children   : Natural := 0;
      wave                 : Waves;
      weighted_population  : Amount := 0.0;
      weighted_households  : Amount := 0.0;
      weighted_by_region   : By_Region.Amount_Array;
      count_by_region      : By_Region.Integer_Array;
      
      
      procedure Load_Household( c : Index_Cursor ) is
         index : Index_Rec := Element( c );
         num_people : Person_Count := 0;
         bu         : Benefit_Unit;
         ad         : Adult;
         weight     : Amount;
         hh_weight  : Amount;
         ch         : Child;
         num_bus    : Benefit_Unit_Count := 0;
         ppos       : Found_Person_Number_Array;
      begin
         Put_Line( "on hhld " & Sernum_Value'Image( index.SERNUM ));
         hh.all := Load_Household( index, ptrs, wave );
         ppos := hh.Get_All_Person_Numbers;
         for pno in 1 .. hh.Num_People loop
            ad := hh.Get_Person( ppos( pno ));
            -- all_adults.Insert( ad.pid, ad );
         end loop;
         num_bus := hh.Num_Benefit_Units;
         for b in 1 .. num_bus loop
            bu := Get_Benefit_Unit( hh, b );
            num_people := num_people + bu.Num_People;
            for adno in 1 .. bu.Num_With_Adult_Records loop
               ad := bu.Get_With_Adult_Records( adno );
               if wave = 'a' then -- enumeration, not respondent : we need a respondent flag!
                  weight := ad.indall.xewght;
               else
                  weight := ad.indall.xewght;
               end if;
               Put_Line( "weight is " & Amount'Image( weight ));
               weighted_population := weighted_population + weight;
               total_num_people := total_num_people + 1;
               -- if( total_num_people < 10 )then
                  -- Put_Line( To_String( ad.indall, 0 ));
               -- end if;
               -- Assert( weight > 0.0, "weight should be +ive; was " & Amount'Image( weight ));
               -- Assert( ad.age >= 16, "age should be >= 16 was " & Age_Range'Image( ad.age ));
            end loop;
            for chno in 1 .. bu.Num_Children loop
               ch := bu.Get_Child( chno );
               if wave = 'a' then -- enumeration, not respondent : we need a respondent flag!
                  weight := ch.indall.XEWGHT;
               else
                  weight := ch.indall.XEWGHT;
               end if;
               weighted_population := weighted_population + weight;
               total_num_people := total_num_people + 1;
               total_num_children := total_num_children + 1;
               Put_Line( "weight is " & Amount'Image( weight ));
               -- if( total_num_children < 20 )then
                  -- Put_Line( To_String( ch.indall, 0 ));
               -- end if;
               -- Assert( weight > 0.0, "weight should be +ive; was " & Amount'Image( weight ));
               Assert( ch.age < 16, "age should be < 16 was " & Age_Range'Image( ch.age ));
            end loop;
            Assert( bu.Num_Children + bu.Num_With_Adult_Records = bu.num_people, 
               "child+adult mismatch for bu " & Benefit_Unit_Count'Image( b ) &
               " child " & Person_Count'Image( bu.Num_Children ) &
               " adult " & Person_Count'Image( bu.Num_With_Adult_Records ) &
               " total " & Person_Count'Image( bu.Num_People ));
         end loop;
         if( wave = 'a' )then
            hh_weight := hh.hhresp.hhwght;
         else
            hh_weight := hh.hhresp.xhwght;
         end if;
         total_num_households := total_num_households + 1;
         if( total_num_households < 20 )then
            Put_Line( To_String( hh.hhresp, 0 ));
         end if;
         Put_Line( "hh_weight = " & Amount'Image( hh_weight ));
         weighted_households :=  weighted_households + hh_weight;
         weighted_by_region( hh.hhresp.region2 ) := weighted_by_region( hh.hhresp.region2 ) + hh_weight;
         count_by_region( hh.hhresp.region2 ) :=  count_by_region( hh.hhresp.region2 ) + 1;    
         Assert( num_people = hh.Num_People, " mismatch between person counts " & 
            Person_Count'Image( num_people ) & " : " & Person_Count'Image( hh.Num_People ));
      end Load_Household;
      
   begin
      hh := new Household;
      for wave in Waves_With_Data loop
         total_num_people  := 0;
         total_num_households  := 0;
         total_num_children := 0;
         weighted_population := 0.0;
         weighted_households := 0.0;
         weighted_by_region   := ( others => 0.0 );
         count_by_region      := ( others => 0 );
         -- last_all_adults := all_adults;
         -- all_adults.Clear;
         -- Dump_Index( "/mnt/data/bhps/bin/" & wave & "/index.bin", "index_" & wave & ".dump" );
         Restore_Complete_Index( "/mnt/data/bhps/bin/" & wave & "/index.bin", index_map ); 
         Open( ptrs, wave );
         Put_Line( "on wave " & wave );
         index_map.Iterate( Load_Household'Access );
         Put_Line( "total person population wave " & wave & " : " & 
            Natural'Image( total_num_people ) & 
            " weighted " & Amount'Image( weighted_population ));
         Put_Line( "total household population wave " & wave & " : " & 
            Natural'Image( total_num_households ) & 
            " weighted " & Amount'Image( weighted_households ));
         Put_Line( "by region (counts):" & By_Region.To_String( count_by_region ));
         Put_Line( "by region (weighted):" & By_Region.To_String( weighted_by_region ));
         Close( ptrs, wave );
      end loop;
      Free( hh ); 
   end Test_Read_Households;
   
   
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests (T : in out Test_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, RE_Tests'Access, "RE_Test" );
      Register_Routine (T, Test_Dump_Indresp'Access, "Test_Dump_Indresp" );
      Register_Routine (T, Test_Dump_Indall'Access, "Test_Dump_IndAll" );
      Register_Routine (T, Test_Dump_Child'Access, "Test_Dump_Child" );
      Register_Routine (T, Test_Lookup'Access, "Test_Lookup" );
      Register_Routine (T, Test_Read_People'Access, "Test_Read_People" );
      Register_Routine (T, Test_Read_Households'Access, "Test_Read_Household" );
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( T : Test_Case ) return Message_String is
   begin
      return Format("BHPS calculations unit tests.");
   end Name;

end BHPS_Tests;
