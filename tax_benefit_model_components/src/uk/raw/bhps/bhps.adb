with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Assertions;
with Text_Utils;

package body BHPS is
   
   use Ada.Assertions;
   use Ada.Text_IO;
   
   function Year_From_Wave( wave : Waves ) return Year_Range is
   begin
      return Character'Pos( wave ) - Character'Pos( 'a' ) + FRS_Start_Year;
   end Year_From_Wave;

   
   function To_String( bu : BU_Allocation_Array ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;
   begin
      for b in Benefit_Unit_Number loop
         s := s & Boolean'Image( bu( b ).is_adult );
         s := s & " " & Benefit_Unit_Count'Image( bu( b ).buno );
         s := s & Benefit_Unit_Count'Image( bu( b ).bu_sequence );
         s := s & Child_Count'Image( bu( b ).chno );
         s := s & Head_Or_Spouse'Image( bu( b ).adno );
         s := s & Person_Count'Image( bu( b ).pno ) & LINE_BREAK;
      end loop;
      return To_String( s );      
   end To_String;
   

   function Hack_Bu_No( ad : Adult ) return Integer is
   begin
      case ad.indresp.butype is
      when
            single_woman_20_39 |
            single_woman_40_59 |
            single_woman_60_74 |
            single_woman_75_plus |
            single_man_lt_30 |
            single_man_30_54 |
            single_man_55_64 |
            single_man_65_plus |
            f_lone_parent_lt_60 |
            m_lone_parent_lt_65 |
            single_woman_lt_20 => return ad.indresp.pno;
      when dependent_child =>
         return ad.indresp.buno;
         
      when others =>
         
         return ad.indresp.buno;
      end case;
   end Hack_Bu_No;

  
   procedure Allocate_Household_Members( hh : in out Household; wave : Waves ) is
   use Adult_Map_Package;
   
      num_bus : Benefit_Unit_Count := 0;
      found_bu_numbers : Found_BU_Number_Array := ( others => 0 );
      
      function Get_Our_BU_Number( buno : Benefit_Unit_Number ) return Benefit_Unit_Number is
      begin
         for i in 1 .. num_bus loop
            if( buno = found_bu_numbers( i ))then
               return i;
            end if;
         end loop;
         num_bus := num_bus + 1;
         found_bu_numbers( num_bus ) := buno;
         return num_bus;
      end Get_Our_BU_Number;
      
      c                 : Adult_Cursor := hh.people.First;
      pers              : Adult;
      found_rel_to_head : Boolean;
      highest_buno      : Benefit_Unit_Count := 0;
      buno              : Integer;
   begin
      Find_Highest_Bu_Number:
      loop 
         pers := Element( c );
         if( pers.indall.buno > highest_buno )then
            -- Put_Line( "highest buno = " & pers.indall.buno'Img );
            highest_buno := pers.indall.buno;
         end if;
         exit when c =  hh.people.Last;
         Next( c );
      end loop Find_Highest_Bu_Number;
      
      c := hh.people.First;
      Allocate_To_BUs:
      loop
         pers := Element( c );
         hh.bu_relationships( pers.pno ).is_adult := ( pers.indall.age >= 16 ) or ( pers.indresp.pid = pers.indall.pid );
         hh.bu_relationships( pers.pno ).pno := pers.indall.pno;
         --
         -- hacks for miscoded bunos go here - this one has 2 should be 4 for pno 4
         --
         -- if( wave >= 'o' )then
         --    buno := Hack_Bu_No( pers );
         -- end if;
         if( wave = 'o' and hh.hid = 15052877 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15140946 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15176991 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15187799 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15187853 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15190838 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15281558 and pers.indall.pno >= 4 )then 
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15281469 and pers.indall.pno >= 4 )then 
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15321703 and pers.indall.pno = 4 )then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15368769 and ( pers.indall.pno = 4 or pers.indall.pno = 5 ))then
            buno := 4;
         elsif( wave = 'o' and hh.hid = 15391183 and pers.indall.pno = 5 )then
            buno := 5;
         elsif( wave = 'o' and hh.hid = 15402061 and ( pers.indall.pno = 6 or pers.indall.pno = 8 ))then
            buno := 6;
         elsif( wave = 'o' and hh.hid = 15440168 and pers.indall.pno = 3 )then
            buno := 3;
         elsif( wave = 'o' and hh.hid = 15471209 and pers.indall.pno = 3 )then
            buno := 1;
         elsif wave = 'o' and hh.hid = 15521702 and pers.pno = 3 then
            buno := 3;
         elsif wave = 'o' and hh.hid = 15539431 and pers.pno = 7 then
            buno := 1;
         elsif wave = 'o' and hh.hid = 15574571 and pers.pno = 4 then
            buno := 1; -- could be 4 - 3,4 are granchildren of 1,2 but 4 is 15 yo
         elsif wave = 'o' and hh.hid = 15627667 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'o' and hh.hid = 15658678 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'o' and hh.hid = 15804607 and pers.pno = 3 then
            buno := 1; -- 'parents' are 70,68 & grandparents...
         elsif wave = 'o'  and hh.hid = 15837785 then -- everyone
            buno := 2; -- make person 2 hoh & all 1 bu - 4 os step child 3 spouse 1,5 children
         elsif wave = 'o' and hh.hid = 15867668 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'o' and hh.hid = 15869385 and pers.pno = 6 then
            buno := 1; -- this makes NO sense person 6 reported as son-in-law of 3,4 aged 4 - must be norwich or something
         elsif wave = 'o' and hh.hid = 15897419 and ( pers.pno = 5 or pers.pno = 6 ) then 
            buno := 1; -- rels are other & undefined so just a guess
         elsif( wave = 'p' and hh.hid = 16072138 and pers.indall.pno = 6 )then
            buno := 1;
         elsif( wave = 'p' and hh.hid = 16132769 and pers.pno = 4 )then 
            buno := 1;
         elsif( wave = 'p' and hh.hid = 16179196 and pers.pno = 3 )then
            buno := 1;
         elsif( wave = 'p' and hh.hid = 16213319 and pers.pno = 3 )then
            buno := 3;
         elsif( wave = 'p' and hh.hid = 16254589 and pers.pno = 6 )then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16299833 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16299833 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16341198 and pers.pno /= 4 then
            buno := 2;
         elsif wave = 'p' and hh.hid = 16394712 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16402642 and pers.pno = 3 then
            buno := 3;
         elsif wave = 'p' and hh.hid = 16466896 and pers.pno = 4 then
            buno := 3; -- weird - 4 is recorded as son-in-law of 3 but is aged 4
         elsif wave = 'p' and hh.hid = 16481976 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16488709 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16521978 and ( pers.pno = 7 or pers.pno = 8 )then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16608461 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16805003 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16849434 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'p' and hh.hid = 16866304 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17125006 and pers.pno = 4 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17168236 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17236347 and pers.pno = 6 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17278856 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17316731 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17439558 and pers.pno = 4 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17464803 and(  pers.pno = 3 or pers.pno = 4 )then
            buno := 3; -- ?? 4 os grandchild of 1,2 and 3 is child of 1,2 and age 30 (but 4 is son-in-law of 3)
         elsif wave = 'q' and hh.hid = 17478332 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17503558 and pers.pno = 5 then
            buno := 1; -- could be 3 but no egoalt records for hh so who knows?
         elsif wave = 'q' and hh.hid = 17515211 and ( pers.pno = 7 or pers.pno = 8 ) then 
            buno := 1;
         elsif wave = 'q' and hh.hid = 17816181 and pers.pno = 4 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17822203 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'q' and hh.hid = 17864623 and pers.pno = 6 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18157904 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18252842 and pers.pno = 5 then 
            buno := 1;
         elsif wave = 'r' and hh.hid = 18259316 and pers.pno = 4 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18284817 and pers.pno = 3 then
            buno := 3;
         elsif wave = 'r' and hh.hid = 18292968 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18374417 and pers.pno = 8 then
            buno := 5;
         elsif wave = 'r' and hh.hid = 18416802 and pers.pno = 4 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18435963 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18460151 and pers.pno = 4 then
            buno := 3;
         elsif wave = 'r' and hh.hid = 18473121 and pers.pno = 5 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18610552 and pers.pno = 3 then 
            buno := 1;
         elsif wave = 'r' and hh.hid = 18815545 and pers.pno = 3 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18818749 and pers.pno = 8 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18821499 and pers.pno = 4 then
            buno := 1;
         elsif wave = 'r' and hh.hid = 18822398 and pers.pno = 4 then
            buno := 1; -- could be 3 ?
         elsif wave = 'r' and hh.hid = 18862934 and pers.pno = 6 then
            buno := 4;-- this is a guess could be 3,4,5 child is grandchild of 1 3-5 are children
         else
            buno := pers.indall.buno;
         end if;
         if( buno < 0 )then -- missing cases; just give everyone their own bu and move on
            highest_buno := highest_buno + 1;
            hh.bu_relationships( pers.pno ).buno := highest_buno;
            hh.bu_relationships( pers.pno ).adno := head;
            found_rel_to_head := True;
         else
            Put_Line( "pers.pno" & pers.pno'Img & "buno " & buno'Img & " butype " & pers.indresp.butype'Img & " age " & pers.indall.age'Img );
            hh.bu_relationships( pers.pno ).buno := buno;
            if buno = pers.indall.pno then -- see: Vol A appendix 2.2 : buno is pno of head of buno
               hh.bu_relationships( pers.pno ).adno := head; 
               found_rel_to_head := True;
            else
               -- Assert( pers.num_egoalts > 0, "no recorded egoalts for person " & pers.indall.pno'Img );
               found_rel_to_head := False;
               for i in 1 .. pers.num_egoalts loop
                  if pers.egoalt( i ).opno = buno then -- relationship to head of bu
                     if pers.egoalt( i ).rel = lawful_spouse or pers.egoalt( i ).rel = live_in_partner then
                        hh.bu_relationships( pers.pno ).adno := spouse;
                     else
                        hh.bu_relationships( pers.pno ).adno := neither;
                     end if;
                     found_rel_to_head := True;
                     exit;
                  end if;
               end loop;
            end if;
         end if;
         
         hh.bu_relationships( pers.pno ).bu_sequence := Get_Our_BU_Number( hh.bu_relationships( pers.pno ).buno );
         if( hh.bu_relationships( pers.pno ).bu_sequence > hh.num_benefit_units )then
            hh.num_benefit_units := hh.bu_relationships( pers.pno ).bu_sequence;
         end if;

         -- Assert( found_rel_to_head, "didn't find an egoalt record that would allow us to allocate person " &  pers.indall.pno'Img );
         exit when c = hh.people.Last;
         Next( c );
      end loop Allocate_To_BUs;
      -- Put_Line( To_String( hh.bu_relationships ));
   end Allocate_Household_Members;
   
   function Last_Head_Or_Spouse( bu : Benefit_Unit ) return Head_Or_Spouse_Id is
   begin
      return bu.last_adult_partner; 
   end Last_Head_Or_Spouse;
   
   function Num_With_Adult_Records( bu : Benefit_Unit ) return Adult_Count is
   begin
      return bu.num_adults;
   end Num_With_Adult_Records;
   
   function Num_Children( bu : Benefit_Unit ) return Child_Count is
   begin
      return bu.num_children;
   end Num_Children;
   
   function Num_People( bu : Benefit_Unit ) return Person_Count is
   begin
      return bu.num_people;
   end Num_People;
   
   -- Get_Dependent_Adullt ... 
   function Get_Head_Or_Spouse( bu : Benefit_Unit; which : Head_Or_Spouse_Id ) return Adult is
      ad : Adult;
   begin
      for i in Person_Number loop
         if( bu.bu_relationships( i ).adno = which )then
            return bu.people.Element( i );
         end if;
      end loop;
      return ad;
   end Get_Head_Or_Spouse;
   
   function Get_With_Adult_Records( bu : Benefit_Unit; which : Adult_Number ) return Adult is  
   begin
      return bu.people.Element( bu.adult_pos( which ));
   end Get_With_Adult_Records;
      
   function Get_Child( bu : Benefit_Unit; which : Child_Number ) return Adult is
      ad : Adult := bu.people.Element( bu.child_pos( which ));
   begin
      return ad;
   end Get_Child;      

   
   function Get_Child( bu : Benefit_Unit; which : Child_Number ) return Child is
      ad : Adult := bu.people.Element( bu.child_pos( which ));
      ch : Child;
   begin
      ch.pid := ad.pid;
      ch.pno := ad.pno;
      ch.age := ad.age;
      ch.wave :=ad.wave;
      ch.sex := ad.sex;
      ch.num_egoalts := ad.num_egoalts;
      ch.egoalt := ad.egoalt;
      ch.indall := ad.indall;
      ch.child_data := ad.child_data;
      ch.youth_data := ad.youth_data;
      ch.childad := ad.childad;
      ch.childnt := ad.childnt;
      return ch;
   end Get_Child;
   
   function Get_Benefit_Unit( 
      hh : Household_Access;
      which      : Benefit_Unit_Number;
      definition : BU_Allocation_Type := dss; 
      count_type : BU_Count_Type      := by_sequence ) return Benefit_Unit is
      bu : Benefit_Unit;
      ad : Adult;
   begin
      if( count_type = by_sequence )then
         for i in Benefit_Unit_Number loop
            if( hh.bu_relationships( i ).bu_sequence = which )then
               bu.num_people := bu.num_people + 1;
               bu.people_pos( bu.num_people ) := hh.bu_relationships( i ).pno;
               bu.bu_relationships( i ) := hh.bu_relationships( i );
               if( hh.bu_relationships( i ).is_adult )then
                  bu.num_adults := bu.num_adults + 1;
                  bu.adult_pos( bu.num_adults ) := hh.bu_relationships( i ).pno;
                  if( hh.bu_relationships( i ).adno = spouse )then
                     bu.last_adult_partner := spouse;
                  end if;
               else
                  bu.num_children := bu.num_children + 1;
                  bu.child_pos( bu.num_children ) := hh.bu_relationships( i ).pno;
               end if;
               -- Put_Line( "looking for person " &  hh.bu_relationships( i ).pno'Img );
               -- Put_Line( "Benefit Unit " & which'Img );
               ad := hh.people.Element( hh.bu_relationships( i ).pno );
               bu.people.Insert( ad.pno, ad );
            end if;
         end loop;
      end if;
      Assert( bu.num_people = Person_Count( bu.people.Length ), " hashmap count /= derived people count :" & 
         Person_Count'Image( bu.num_people ) & " : " & Person_Count'Image( Person_Count( bu.people.Length )));
      Assert( bu.num_people = bu.num_children + bu.num_adults, " ad+ch /= derived people count :" & 
         Person_Count'Image( bu.num_people ) & " : " & Person_Count'Image( bu.num_adults ) & ": " & 
         Person_Count'Image( bu.num_children ));
      return bu;
   end Get_Benefit_Unit;
   
   function Num_Benefit_Units(hh : Household ) return Benefit_Unit_Count is
   begin
      return hh.num_benefit_units;
   end Num_Benefit_Units; 
   
   function Num_People( hh : Household ) return Person_Count is
   begin
      return Person_Count( hh.people.Length );
   end Num_People;
   
   -- note: returns by bhps pno, even if the internal sequence is different
   function Get_Person( hh : Household; pno : Person_Number ) return Adult is
   begin
      return hh.people.Element( pno );
   end Get_Person;

   
   function Hhresp( hh : Household ) return Hhresp_Rec is
   begin
      return hh.hhresp;
   end Hhresp;
   
   function Hhsamp( hh : Household ) return Hhsamp_Rec is
   begin
      return hh.hhsamp;
   end Hhsamp;
   
   function Hid( hh : Household ) return Sernum_Value is
   begin
      return hh.hid;
   end Hid;
   
   function Compare_Pno_Lt( left, right: Integer ) return Boolean is
   begin
      return left < right;
   end Compare_Pno_Lt;
   
   function Compare_Sernum_Lt( left, right: Sernum_Value ) return Boolean is
   begin
      return left < right;
   end Compare_Sernum_Lt;
      
   
   function Compare_Adult_Record_Equal( left, right: Adult ) return Boolean is
   begin
      return left.pid /= right.pid;
   end Compare_Adult_Record_Equal;
   
   function Compare_Child_Record_Equal( left, right: Child ) return Boolean is
   begin
      return left.pid /= right.pid;
   end Compare_Child_Record_Equal;

   procedure Free( hh : in out Household_Access ) is
   begin
      Free_Household( hh );
   end Free;
   
   function Get_All_Person_Numbers( hh : Household ) return Found_Person_Number_Array is
   begin
      return hh.people_pos;
   end Get_All_Person_Numbers;

   
end BHPS;
