with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Strings;
with Text_Utils;
with Ada.Text_IO;
with Ada.Exceptions;

package body ZA.Household.Gauss_IO is

   package st    renames Ada.Strings;
   package sf   renames Ada.Strings.Fixed;
   use Ada.Text_IO;
   use Ada.Exceptions;
   
   ABORT_ON_ERROR : constant BOOLEAN := False;
   
   subtype Gauss_Array_Range is Positive range 1 .. 3409;
   type Gauss_Array is new Amount_Array( Gauss_Array_Range );
   
   type Gauss_Rec is record
      household_reference : Very_Large_Positive_Type;
      benefit_unit_number : Positive;
      data : Gauss_Array;
   end record;

   type All_Gauss_Recs is array( Family_Unit_Count ) of Gauss_Rec;
   
   last_record : Gauss_Rec;
   last_pos : Natural := 0;
   recs : All_Gauss_Recs;

   function Read_Gauss_Rec( f : File_Type ) return Gauss_Rec is
        r : Gauss_Rec;
   begin
      Very_Large_Positive_Text_IO.Get( f, r.household_reference );
      Put_Line( " r.household_reference " &  r.household_reference'Img );
      Int_IO.Get( f, r.benefit_unit_number );
      for i in Gauss_Array'Range loop
         Real_IO.Get( f, r.data( i ) );
         -- Put_Line( " r.data("&i'Img& " ) = " & Format(r.data( i )) );
      end loop;
      Skip_Line( f );
      return r;
   end Read_Gauss_Rec;
   
   function To_String( r : Gauss_Rec ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;
      t : String( 1 .. 14 );
   begin
      
      s := s & "household_reference " & Very_Large_Positive_Type'Image( r.household_reference ) & LINE_BREAK;
      s := s & "benefit unit number " & Format( r.benefit_unit_number ) & LINE_BREAK;
      for i in Gauss_Array'Range loop
         t := Pad( Format( r.data(i) ), 14 );
         s := s & t;
         if(( i mod 20 ) = 0 )then
            s := s & LINE_BREAK;
         end if;
      end loop;
      return To_String( s );
      
   end To_String;
   
   function Convert_1_2_Boolean( i : Integer; which : Gauss_Array_Range := 1 ) return Boolean is
      a : Boolean := False;
   begin
      case i is 
         when 0 => a := False;
         when 1 => a := True;
         when 2 => a := False;
         when Others => 
            if( ABORT_ON_ERROR ) then
               Raise_Exception( Data_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for Convert_1_2_Boolean position " & which'Img );
            else
               Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for Convert_1_2_Boolean position " & which'Img );
            end if;    
      end case;
      return a;
   end Convert_1_2_Boolean;
   
   function Convert_0_1_Boolean( i : Integer; which : Gauss_Array_Range := 1 ) return Boolean is
      a : Boolean := False;
   begin
      case i is 
         when 1 => a := True;
         when 0 => a := False;
         when Others => 
            if( ABORT_ON_ERROR ) then
               Raise_Exception( Data_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for Convert_0_1_Boolean position " & which'Img );
            else
               Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for Convert_0_1_Boolean position " & which'Img );
            end if;    
         end case;
      return a;
   end Convert_0_1_Boolean;

   function Read_From_Raw( x : Gauss_Array; person_no : Person_Count ) return Housing_Rec is 
      a : Housing_Rec;
   begin
      a.settl := Integer( x( 2425 + person_no ) );
      a.ownship := Convert_Ownship_Type( Integer( x( 2433 + person_no ) ));
      a.matroof := Convert_Matroof_Type( Integer( x( 2441 + person_no ) ));
      a.matwall := Convert_Matwall_Type( Integer( x( 2449 + person_no ) ));
      a.dwevalue := Integer( x( 2457 + person_no ) );
      a.livingr := Integer( x( 2465 + person_no ) );
      a.bedroom := Integer( x( 2473 + person_no ) );
      a.wattank := Convert_1_2_Boolean( Integer( x( 2481 + person_no ) ), 2481);
      a.watsourc := Convert_Watsourc_Type( Integer( x( 2489 + person_no ) ));
      a.watmain := Convert_Watmain_Type( Integer( x( 2497 + person_no ) ));
      a.watadeq := Convert_Watadeq_Type( Integer( x( 2505 + person_no ) ));
      a.watkm := Convert_Watkm_Type( Integer( x( 2513 + person_no ) ));
      a.watpay := Convert_Yes_No_Sometimes_Type( Integer( x( 2521 + person_no ) ));
      a.elpubc := Convert_Yes_No_Sometimes_Type( Integer( x( 2529 + person_no ) ));
      a.elgenc := Convert_Yes_No_Sometimes_Type( Integer( x( 2537 + person_no ) ));
      a.elsolac := Convert_Yes_No_Sometimes_Type( Integer( x( 2545 + person_no ) ));
      a.cookgas := Convert_Yes_No_Sometimes_Type( Integer( x( 2553 + person_no ) ));
      a.cookpar := Convert_Yes_No_Sometimes_Type( Integer( x( 2561 + person_no ) ));
      a.cookwood := Convert_Yes_No_Sometimes_Type( Integer( x( 2569 + person_no ) ));
      a.cookcoal := Convert_Yes_No_Sometimes_Type( Integer( x( 2577 + person_no ) ));
      a.coocharc := Convert_Yes_No_Sometimes_Type( Integer( x( 2585 + person_no ) ));
      a.cropwast := Convert_Yes_No_Sometimes_Type( Integer( x( 2593 + person_no ) ));
      a.cookdung := Convert_Yes_No_Sometimes_Type( Integer( x( 2601 + person_no ) ));
      a.cookoth := Convert_Yes_No_Sometimes_Type( Integer( x( 2609 + person_no ) ));
      a.heatelp := Convert_Yes_No_Sometimes_Type( Integer( x( 2617 + person_no ) ));
      a.heatelg := Convert_Yes_No_Sometimes_Type( Integer( x( 2625 + person_no ) ));
      a.heatelb := Convert_Yes_No_Sometimes_Type( Integer( x( 2633 + person_no ) ));
      a.heatels := Convert_Yes_No_Sometimes_Type( Integer( x( 2641 + person_no ) ));
      a.heatgas := Convert_Yes_No_Sometimes_Type( Integer( x( 2649 + person_no ) ));
      a.heatpar := Convert_Yes_No_Sometimes_Type( Integer( x( 2657 + person_no ) ));
      a.heatwood := Convert_Yes_No_Sometimes_Type( Integer( x( 2665 + person_no ) ));
      a.heatcoal := Convert_Yes_No_Sometimes_Type( Integer( x( 2673 + person_no ) ));
      a.heatchar := Convert_Yes_No_Sometimes_Type( Integer( x( 2681 + person_no ) ));
      a.heatcrop := Convert_Yes_No_Sometimes_Type( Integer( x( 2689 + person_no ) ));
      a.heatdung := Convert_Yes_No_Sometimes_Type( Integer( x( 2697 + person_no ) ));
      a.heatoth := Convert_Yes_No_Sometimes_Type( Integer( x( 2705 + person_no ) ));
      a.noheat := Convert_Yes_No_Sometimes_Type( Integer( x( 2713 + person_no ) ));
      a.lightelp := Convert_Yes_No_Sometimes_Type( Integer( x( 2721 + person_no ) ));
      a.lightelg := Convert_Yes_No_Sometimes_Type( Integer( x( 2729 + person_no ) ));
      a.lightelb := Convert_Yes_No_Sometimes_Type( Integer( x( 2737 + person_no ) ));
      a.lightels := Convert_Yes_No_Sometimes_Type( Integer( x( 2745 + person_no ) ));
      a.lightgas := Convert_Yes_No_Sometimes_Type( Integer( x( 2753 + person_no ) ));
      a.lightpar := Convert_Yes_No_Sometimes_Type( Integer( x( 2761 + person_no ) ));
      a.lightcan := Convert_Yes_No_Sometimes_Type( Integer( x( 2769 + person_no ) ));
      a.lightoth := Convert_Yes_No_Sometimes_Type( Integer( x( 2777 + person_no ) ));
      a.fwoods := Convert_Fwoods_Type( Integer( x( 2785 + person_no ) ));
      a.fwoodad := Convert_Fwoodad_Type( Integer( x( 2793 + person_no ) ));
      a.fwoodkm := Convert_Fwoodkm_Type( Integer( x( 2801 + person_no ) ));
      a.fwoopay := Convert_1_2_Boolean( Integer( x( 2809 + person_no ) ), 2809);
      a.sanitin := Integer( x( 2817 + person_no ) );
      a.saniton := Integer( x( 2825 + person_no ) );
      a.sanitoff := Integer( x( 2833 + person_no ) );
      a.sanitsh := Convert_1_2_Boolean( Integer( x( 2841 + person_no ) ), 2841);
      a.sanitno := Integer( x( 2849 + person_no ) );
      a.toilkm := Convert_Toilkm_Type( Integer( x( 2857 + person_no ) ));
      a.toilbuck := Integer( x( 2865 + person_no ) );
      a.refdisp := Convert_Refdisp_Type( Integer( x( 2873 + person_no ) ));
      a.reffreq := Convert_Reffreq_Type( Integer( x( 2881 + person_no ) ));
      a.telcell := Integer( x( 2889 + person_no ) );
      a.teloth := Integer( x( 2897 + person_no ) );
      a.telkm := Convert_Telkm_Type( Integer( x( 2905 + person_no ) ));
      a.landacc := Convert_1_2_Boolean( Integer( x( 2913 + person_no ) ), 2913);
      a.landha := Integer( x( 2921 + person_no ) );
      a.landdry := Integer( x( 2929 + person_no ) );
      a.landirr := Integer( x( 2937 + person_no ) );
      a.landirs := Convert_Landirs_Type( Integer( x( 2945 + person_no ) ));
      a.landgr := Convert_1_2_Boolean( Integer( x( 2953 + person_no ) ), 2953);
      a.landcomh := Integer( x( 2961 + person_no ) );
      a.landcdry := Integer( x( 2969 + person_no ) );
      a.landcirr := Integer( x( 2977 + person_no ) );
      a.landiha := Integer( x( 2985 + person_no ) );
      a.landctr := Integer( x( 2993 + person_no ) );
      a.tribocch := Convert_1_2_Boolean( Integer( x( 3001 + person_no ) ), 3001);
      a.tribdry := Integer( x( 3009 + person_no ) );
      a.tribirr := Integer( x( 3017 + person_no ) );
      a.tribirs := Integer( x( 3025 + person_no ) );
      a.tribcom := Integer( x( 3033 + person_no ) );
      a.tribcdry := Integer( x( 3041 + person_no ) );
      a.tribcir := Integer( x( 3049 + person_no ) );
      a.tribcirs := Integer( x( 3057 + person_no ) );
      a.truha := Integer( x( 3065 + person_no ) );
      a.trudry := Integer( x( 3073 + person_no ) );
      a.truirr := Integer( x( 3081 + person_no ) );
      a.trus := Convert_Trus_Type( Integer( x( 3089 + person_no ) ));
      a.trugr := Convert_1_2_Boolean( Integer( x( 3097 + person_no ) ), 3097);
      a.tenha := Integer( x( 3105 + person_no ) );
      a.tendry := Integer( x( 3113 + person_no ) );
      a.tenirr := Integer( x( 3121 + person_no ) );
      a.tenirs := Integer( x( 3129 + person_no ) );
      a.tengr := Integer( x( 3137 + person_no ) );
      a.safeout := Convert_Safeout_Type( Integer( x( 3145 + person_no ) ));
      a.safein := Convert_Safein_Type( Integer( x( 3153 + person_no ) ));
      a.safeprev := Convert_Safeprev_Type( Integer( x( 3161 + person_no ) ));
      a.crimevic := Convert_1_2_Boolean( Integer( x( 3169 + person_no ) ), 3169);
      a.crime1 := Convert_Crime_Type( Integer( x( 3177 + person_no ) ));
      a.crime2 := Convert_Crime_Type( Integer( x( 3185 + person_no ) ));
      a.crime3 := Convert_Crime_Type( Integer( x( 3193 + person_no ) ));
      a.crime4 := Convert_Crime_Type( Integer( x( 3201 + person_no ) ));
      a.crime5 := Convert_Crime_Type( Integer( x( 3209 + person_no ) ));
      a.crime6 := Convert_Crime_Type( Integer( x( 3217 + person_no ) ));
      a.pollute := Convert_Pollute_Type( Integer( x( 3225 + person_no ) ));
      a.feedab := Convert_Feedab_Type( Integer( x( 3233 + person_no ) ));
      a.satisf := Convert_Satisf_Type( Integer( x( 3241 + person_no ) ));
      a.compliv := Convert_Compliv_Type( Integer( x( 3249 + person_no ) ));
      a.reshead := Convert_1_2_Boolean( Integer( x( 3257 + person_no ) ), 3257);
      a.reashead := Convert_Reashead_Type( Integer( x( 3265 + person_no ) ));
      a.misschn := Convert_1_2_Boolean( Integer( x( 3273 + person_no ) ), 3273);
      a.misschno := Integer( x( 3281 + person_no ) );
      a.medsour := Convert_Medsour_Type( Integer( x( 3289 + person_no ) ));
      a.medkm := Convert_Medkm_Type( Integer( x( 3297 + person_no ) ));
      a.medtime := Convert_Medtime_Type( Integer( x( 3305 + person_no ) ));
      a.meddi := Integer( x( 3313 + person_no ) );
      a.medpr := Convert_Province_Type( Integer( x( 3321 + person_no ) ));
      a.hospdi := Integer( x( 3329 + person_no ) );
      a.hosppr := Convert_Province_Type( Integer( x( 3337 + person_no ) ));
      a.welfkm := Convert_Welfkm_Type( Integer( x( 3345 + person_no ) ));
      return a;
   end Read_From_Raw;
   
   
   function Read_From_Raw( x : Gauss_Array; person_no : Person_Count ) return Expenditure_Array is 
      a : Expenditure_Array;
   begin
      a( medsernm ):= Amount( x( 2209 + person_no ) );
      a( fruit ):= Amount( x( 1945 + person_no ) );
      a( ptravis ):= Amount( x( 2241 + person_no ) );
      a( syrup ):= Amount( x( 1961 + person_no ) );
      a( remit ):= Amount( x( 2329 + person_no ) );
      a( womcloth ):= Amount( x( 2081 + person_no ) );
      a( hhserv ):= Amount( x( 2049 + person_no ) );
      a( communic ):= Amount( x( 2257 + person_no ) );
      a( consgood ):= Amount( x( 2041 + person_no ) );
      a( recreq ):= Amount( x( 2289 + person_no ) );
      a( chnfoot ):= Amount( x( 2153 + person_no ) );
      a( livestoc ):= Amount( x( 2377 + person_no ) );
      a( housm ):= Amount( x( 1873 + person_no ) );
      a( other ):= Amount( x( 2353 + person_no ) );
      a( tea ):= Amount( x( 1969 + person_no ) );
      a( fuel ):= Amount( x( 2073 + person_no ) );
      a( othfood ):= Amount( x( 1977 + person_no ) );
      a( personal ):= Amount( x( 2033 + person_no ) );
      a( indirinc ):= Amount( x( 2401 + person_no ) );
      a( miscel ):= Amount( x( 2321 + person_no ) );
      a( boycloth ):= Amount( x( 2105 + person_no ) );
      a( salcbev ):= Amount( x( 2017 + person_no ) );
      a( textile ):= Amount( x( 2177 + person_no ) );
      a( tobacco ):= Amount( x( 2025 + person_no ) );
      a( edfeegr ):= Amount( x( 2273 + person_no ) );
      a( vehrun ):= Amount( x( 2225 + person_no ) );
      a( sugar ):= Amount( x( 1953 + person_no ) );
      a( vehicle ):= Amount( x( 2217 + person_no ) );
      a( hweight ):= Amount( x( 2417 + person_no ) );
      a( equip ):= Amount( x( 2193 + person_no ) );
      a( fats ):= Amount( x( 1921 + person_no ) );
      a( milk ):= Amount( x( 1929 + person_no ) );
      a( cereal ):= Amount( x( 1897 + person_no ) );
      a( gfoot ):= Amount( x( 2129 + person_no ) );
      a( licence ):= Amount( x( 2305 + person_no ) );
      a( furn ):= Amount( x( 2169 + person_no ) );
      a( hotelfoo ):= Amount( x( 1985 + person_no ) );
      a( chncl ):= Amount( x( 2113 + person_no ) );
      a( menfoot ):= Amount( x( 2137 + person_no ) );
      a( loss ):= Amount( x( 2361 + person_no ) );
      a( meat ):= Amount( x( 1905 + person_no ) );
      a( computer ):= Amount( x( 2249 + person_no ) );
      a( taxpaid ):= Amount( x( 2337 + person_no ) );
      a( pubtraws ):= Amount( x( 2233 + person_no ) );
      a( subtoty ):= Amount( x( 2065 + person_no ) );
      a( veg ):= Amount( x( 1937 + person_no ) );
      a( hhexp ):= Amount( x( 2385 + person_no ) );
      a( womfoot ):= Amount( x( 2121 + person_no ) );
      a( subtot2 ):= Amount( x( 2313 + person_no ) );
      a( ownprod ):= Amount( x( 2369 + person_no ) );
      a( readmat ):= Amount( x( 2281 + person_no ) );
      a( dirinc ):= Amount( x( 2393 + person_no ) );
      a( hnalcbev ):= Amount( x( 1993 + person_no ) );
      a( handmade ):= Amount( x( 2161 + person_no ) );
      a( medserm ):= Amount( x( 2201 + person_no ) );
      a( fish ):= Amount( x( 1913 + person_no ) );
      a( subtot ):= Amount( x( 2057 + person_no ) );
      a( housy ):= Amount( x( 1881 + person_no ) );
      a( girlcl ):= Amount( x( 2089 + person_no ) );
      a( halcbev ):= Amount( x( 2009 + person_no ) );
      a( mcloth ):= Amount( x( 2097 + person_no ) );
      a( snalcbev ):= Amount( x( 2001 + person_no ) );
      a( recrgood ):= Amount( x( 2297 + person_no ) );
      a( edfeesel ):= Amount( x( 2265 + person_no ) );
      a( boyfoot ):= Amount( x( 2145 + person_no ) );
      a( domwag ):= Amount( x( 1889 + person_no ) );
      a( totinc ):= Amount( x( 2409 + person_no ) );
      a( fincharg ):= Amount( x( 2345 + person_no ) );
      a( applianc ):= Amount( x( 2185 + person_no ) );
      return a;
   end Read_From_Raw;


   function Read_From_Raw( x : Gauss_Array; person_no : Person_Count ) return Income_Array is 
        a : Income_Array := ( Others => 0.0 );
   begin
      a( indinc ):= Amount( x( 1841 + person_no ) );
      a( allow ):= Amount( x( 1721 + person_no ) );
      a( bonus ):= Amount( x( 1705 + person_no ) );
      a( linsur ):= Amount( x( 1569 + person_no ) );
      a( policy ):= Amount( x( 1553 + person_no ) );
      a( medben ):= Amount( x( 1529 + person_no ) );
      a( houben ):= Amount( x( 1513 + person_no ) );
      a( hobby ):= Amount( x( 1473 + person_no ) );
      a( otgift ):= Amount( x( 1665 + person_no ) );
      a( trafcl ):= Amount( x( 1593 + person_no ) );
      a( carsal ):= Amount( x( 1481 + person_no ) );
      a( wages ):= Amount( x( 1697 + person_no ) );
      a( clben ):= Amount( x( 1657 + person_no ) );
      a( cashbe ):= Amount( x( 1633 + person_no ) );
      a( othinc ):= Amount( x( 1681 + person_no ) );
      a( foodbe ):= Amount( x( 1641 + person_no ) );
      a( propcl ):= Amount( x( 1585 + person_no ) );
      a( funcla ):= Amount( x( 1577 + person_no ) );
      a( disabg ):= Amount( x( 1785 + person_no ) );
      a( oldage ):= Amount( x( 1777 + person_no ) );
      a( othseb ):= Amount( x( 1649 + person_no ) );
      a( alimon ):= Amount( x( 1809 + person_no ) );
      a( divid ):= Amount( x( 1761 + person_no ) );
      a( lump ):= Amount( x( 1545 + person_no ) );
      a( prop ):= Amount( x( 1489 + person_no ) );
      a( netacy ):= Amount( x( 1857 + person_no ) );
      a( famall ):= Amount( x( 1793 + person_no ) );
      a( pens ):= Amount( x( 1769 + person_no ) );
      a( inter ):= Amount( x( 1753 + person_no ) );
      a( profit ):= Amount( x( 1729 + person_no ) );
      a( saving ):= Amount( x( 1617 + person_no ) );
      a( income ):= Amount( x( 1849 + person_no ) );
      a( rent ):= Amount( x( 1737 + person_no ) );
      a( ttothinc ):= Amount( x( 1689 + person_no ) );
      a( bursar ):= Amount( x( 1625 + person_no ) );
      a( stokv ):= Amount( x( 1609 + person_no ) );
      a( gratui ):= Amount( x( 1601 + person_no ) );
      a( unembe ):= Amount( x( 1801 + person_no ) );
      a( otlump ):= Amount( x( 1561 + person_no ) );
      a( traben ):= Amount( x( 1521 + person_no ) );
      a( rental ):= Amount( x( 1505 + person_no ) );
      a( usedit ):= Amount( x( 1497 + person_no ) );
      a( hincom ):= Amount( x( 1865 + person_no ) );
      a( inckin ):= Amount( x( 1833 + person_no ) );
      a( remit ):= Amount( x( 1817 + person_no ) );
      a( royal ):= Amount( x( 1745 + person_no ) );
      a( commi ):= Amount( x( 1713 + person_no ) );
      a( lobola ):= Amount( x( 1673 + person_no ) );
      a( othben ):= Amount( x( 1537 + person_no ) );
      return a;
   end Read_From_Raw;

   function Read_From_Raw( x : Gauss_Array; person_no : Person_Count ) return Demographics_Rec is 
      a : Demographics_Rec;
   begin
      a.hhid := Integer( x( 9 + person_no ) );
      a.pid := Integer( x( 17 + person_no ) );
      a.age := Integer( x( 25 + person_no ) );
      a.relate := Convert_Relate_Type( Integer( x( 33 + person_no ) ));
      a.spcod := Integer( x( 41 + person_no ) );
      a.fatcod := Integer( x( 49 + person_no ) );
      a.motcod := Integer( x( 57 + person_no ) );
      a.mstate := Convert_Mstate_Type( Integer( x( 65 + person_no ) ));
      a.gender := Convert_Gender_Type( Integer( x( 73 + person_no ) ));
      a.prov := Convert_Province_Type( Integer( x( 81 + person_no ) ));
      a.district := Integer( x( 89 + person_no ) );
      a.ea := Integer( x( 97 + person_no ) );
      a.branchea := Integer( x( 105 + person_no ) );
      a.dwe := Convert_Dwe_Type( Integer( x( 113 + person_no ) ));
      a.loc := Convert_Loc_Type( Integer( x( 121 + person_no ) ));
      a.visit := Integer( x( 129 + person_no ) );
      a.hhsize := Integer( x( 137 + person_no ) );
      a.race := Convert_Race_Type( Integer( x( 145 + person_no ) ));
      a.fataliv := Convert_1_2_Boolean( Integer( x( 153 + person_no ) ), 153);
      a.motaliv := Convert_1_2_Boolean( Integer( x( 161 + person_no ) ), 161);
      a.membpr := Convert_1_2_Boolean( Integer( x( 169 + person_no ) ), 169);
      a.birth := Integer( x( 177 + person_no ) );
      a.wobirt := Integer( x( 185 + person_no ) );
      a.childr := Integer( x( 193 + person_no ) );
      a.bornpr := Convert_Province_Type( Integer( x( 201 + person_no ) ));
      a.borndi := Integer( x( 209 + person_no ) );
      a.bornco := Integer( x( 217 + person_no ) );
      a.migr := Integer( x( 225 + person_no ) );
      a.migrpr := Convert_Province_Type( Integer( x( 233 + person_no ) ));
      a.migrdi := Integer( x( 241 + person_no ) );
      a.migrco := Integer( x( 249 + person_no ) );
      a.predw := Convert_Predw_Type( Integer( x( 257 + person_no ) ));
      a.creche := Convert_1_2_Boolean( Integer( x( 265 + person_no ) ), 265);
      a.study := Convert_1_2_Boolean( Integer( x( 273 + person_no ) ), 273);
      a.liter := Convert_1_2_Boolean( Integer( x( 281 + person_no ) ), 281);
      a.skill := Convert_1_2_Boolean( Integer( x( 289 + person_no ) ), 289);
      a.sktyp := Integer( x( 297 + person_no ) );
      a.migwor := Convert_1_2_Boolean( Integer( x( 305 + person_no ) ), 305);
      a.feedsch := Convert_1_2_Boolean( Integer( x( 313 + person_no ) ), 313);
      a.educ := Integer( x( 321 + person_no ) );
      a.edcont := Convert_1_2_Boolean( Integer( x( 329 + person_no ) ), 329);
      a.edreas := Convert_Edreas_Type( Integer( x( 337 + person_no ) ));
      a.edfees := Integer( x( 345 + person_no ) );
      a.edtra := Integer( x( 353 + person_no ) );
      a.edoth := Integer( x( 361 + person_no ) );
      a.ill := Convert_1_2_Boolean( Integer( x( 369 + person_no ) ), 369);
      a.injury := Convert_1_2_Boolean( Integer( x( 377 + person_no ) ), 377);
      a.discha := Convert_1_2_Boolean( Integer( x( 385 + person_no ) ), 385);
      a.consn := Convert_1_2_Boolean( Integer( x( 393 + person_no ) ), 393);
      a.conssp := Convert_1_2_Boolean( Integer( x( 401 + person_no ) ), 401);
      a.consdo := Convert_1_2_Boolean( Integer( x( 409 + person_no ) ), 409);
      a.consde := Convert_1_2_Boolean( Integer( x( 417 + person_no ) ), 417);
      a.consph := Convert_1_2_Boolean( Integer( x( 425 + person_no ) ), 425);
      a.consot := Convert_1_2_Boolean( Integer( x( 433 + person_no ) ), 433);
      a.consfh := Convert_1_2_Boolean( Integer( x( 441 + person_no ) ), 441);
      a.constr := Convert_1_2_Boolean( Integer( x( 449 + person_no ) ), 449);
      a.conspla := Convert_Conspla_Type( Integer( x( 457 + person_no ) ));
      a.conspay := Convert_1_2_Boolean( Integer( x( 465 + person_no ) ), 465);
      a.medaid := Convert_1_2_Boolean( Integer( x( 473 + person_no ) ), 473);
      a.smoke := Convert_1_2_Boolean( Integer( x( 481 + person_no ) ), 481);
      a.smokag := Integer( x( 489 + person_no ) );
      a.disab1 := Convert_Disab1_Type( Integer( x( 497 + person_no ) ));
      a.disab2 := Integer( x( 505 + person_no ) );
      a.disab3 := Integer( x( 513 + person_no ) );
      a.welf := Convert_1_2_Boolean( Integer( x( 521 + person_no ) ), 521);
      a.welfa := Integer( x( 529 + person_no ) );
      a.welfb := Integer( x( 537 + person_no ) );
      a.welfc := Integer( x( 545 + person_no ) );
      a.weight := Integer( x( 553 + person_no ) );
      a.iweigh := Integer( x( 561 + person_no ) );
      a.sch1 := Integer( x( 569 + person_no ) );
      a.sch2 := Convert_0_1_Boolean( Integer( x( 577 + person_no ) ), 577);
      a.sch3 := Convert_0_1_Boolean( Integer( x( 585 + person_no ) ), 585);
      a.sch4 := Convert_0_1_Boolean( Integer( x( 593 + person_no ) ), 593);
      a.sch5 := Convert_0_1_Boolean( Integer( x( 601 + person_no ) ), 601);
      a.sch6 := Convert_0_1_Boolean( Integer( x( 609 + person_no ) ), 609);
      a.edcat := Convert_Edcat_Type( Integer( x( 617 + person_no ) ));
      a.ed1 := Integer( x( 625 + person_no ) );
      a.ed2 := Integer( x( 633 + person_no ) );
      a.ed3 := Integer( x( 641 + person_no ) );
      a.ed4 := Integer( x( 649 + person_no ) );
      a.stude := Convert_0_1_Boolean( Integer( x( 657 + person_no ) ), 657);
      a.studft := Convert_0_1_Boolean( Integer( x( 665 + person_no ) ), 665);
      a.studpt := Convert_0_1_Boolean( Integer( x( 673 + person_no ) ), 673);
      a.maried := Convert_1_2_Boolean( Integer( x( 681 + person_no ) ), 681);
      return a;
   end Read_From_Raw;


   function Read_From_Raw( x : Gauss_Array; person_no : Person_Count ) return Work_Rec is 
      a : Work_Rec;
   begin
      a.activ := Integer( x( 689 + person_no ) );
      a.work := Integer( x( 697 + person_no ) );
      a.worlag := Integer( x( 705 + person_no ) );
      a.worhrs := Integer( x( 713 + person_no ) );
      a.wormor := Integer( x( 721 + person_no ) );
      a.morehrs := Integer( x( 729 + person_no ) );
      a.trans1 := Integer( x( 737 + person_no ) );
      a.trans2 := Integer( x( 745 + person_no ) );
      a.trans3 := Integer( x( 753 + person_no ) );
      a. timelv := Integer( x( 761 + person_no ) );
      a.timear := Integer( x( 769 + person_no ) );
      a.workdi := Integer( x( 777 + person_no ) );
      a.workpr := Convert_Province_Type( Integer( x( 785 + person_no ) ));
      a.wstat := Integer( x( 793 + person_no ) );
      a.wostar := Integer( x( 801 + person_no ) );
      a.union := Integer( x( 809 + person_no ) );
      a.matern := Integer( x( 817 + person_no ) );
      a.occup := Integer( x( 825 + person_no ) );
      a.indust := Integer( x( 833 + person_no ) );
      a.salary := Integer( x( 841 + person_no ) );
      a.salgp := Integer( x( 849 + person_no ) );
      a.paytyp := Integer( x( 857 + person_no ) );
      a.trkind := Integer( x( 865 + person_no ) );
      a. foodk := Integer( x( 873 + person_no ) );
      a.othkin := Integer( x( 881 + person_no ) );
      a.deduct := Integer( x( 889 + person_no ) );
      a.dedtyp := Integer( x( 897 + person_no ) );
      a.woradd := Integer( x( 905 + person_no ) );
      a.ownocc := Integer( x( 913 + person_no ) );
      a.ownind := Integer( x( 921 + person_no ) );
      a.formal := Integer( x( 929 + person_no ) );
      a.vat := Integer( x( 937 + person_no ) );
      a.owny1 := Integer( x( 945 + person_no ) );
      a.owny1c := Integer( x( 953 + person_no ) );
      a.ownifr := Integer( x( 961 + person_no ) );
      a.expens := Integer( x( 969 + person_no ) );
      a.upaidw := Integer( x( 977 + person_no ) );
      a.upu15 := Integer( x( 985 + person_no ) );
      a.paidw := Integer( x( 993 + person_no ) );
      a.pwu15 := Integer( x( 1001 + person_no ) );
      a.salari := Integer( x( 1009 + person_no ) );
      a.famw1 := Integer( x( 1017 + person_no ) );
      a.famw2  := Integer( x( 1025 + person_no ) );
      a.wor7d := Integer( x( 1033 + person_no ) );
      a.woratt  := Integer( x( 1041 + person_no ) );
      a.worrea := Integer( x( 1049 + person_no ) );
      a.joboff := Integer( x( 1057 + person_no ) );
      a.worloo := Integer( x( 1065 + person_no ) );
      a.look1 := Integer( x( 1073 + person_no ) );
      a.look2 := Integer( x( 1081 + person_no ) );
      a.look3 := Integer( x( 1089 + person_no ) );
      a.workb4 := Integer( x( 1097 + person_no ) );
      a.worpre  := Integer( x( 1105 + person_no ) );
      a.reasnw := Integer( x( 1113 + person_no ) );
      a.maint1 := Integer( x( 1121 + person_no ) );
      a.maint2 := Integer( x( 1129 + person_no ) );
      a.maint3 := Integer( x( 1137 + person_no ) );
      a.educ := Integer( x( 1145 + person_no ) );
      a.codwor := Integer( x( 1153 + person_no ) );
      a.codexu  := Integer( x( 1161 + person_no ) );
      a.codune := Integer( x( 1169 + person_no ) );
      a.codnea  := Integer( x( 1177 + person_no ) );
      a.codocc := Integer( x( 1185 + person_no ) );
      a.codind  := Integer( x( 1193 + person_no ) );
      a.codtim := Integer( x( 1201 + person_no ) );
      a.eminc := Integer( x( 1209 + person_no ) );
      a.emincc := Integer( x( 1217 + person_no ) );
      a.owny2 := Integer( x( 1225 + person_no ) );
      a.owny2c := Integer( x( 1233 + person_no ) );
      a.weight := Integer( x( 1241 + person_no ) );
      a.timlvh := Integer( x( 1249 + person_no ) );
      a.timlvm := Integer( x( 1257 + person_no ) );
      a.timarh := Integer( x( 1265 + person_no ) );
      a.timarm := Integer( x( 1273 + person_no ) );
      a.iweigh := Integer( x( 1281 + person_no ) );
      a.timwor := Integer( x( 1289 + person_no ) );
      a.hour := Integer( x( 1297 + person_no ) );
      a.minute := Integer( x( 1305 + person_no ) );
      a.wormin := Integer( x( 1313 + person_no ) );
      a.worker := Integer( x( 1321 + person_no ) );
      a.unem := Integer( x( 1329 + person_no ) );
      a.unemnl := Integer( x( 1337 + person_no ) );
      a.exunem := Integer( x( 1345 + person_no ) );
      a.stude := Integer( x( 1353 + person_no ) );
      a.dabled := Integer( x( 1361 + person_no ) );
      a.pens := Integer( x( 1369 + person_no ) );
      a.housk := Integer( x( 1377 + person_no ) );
      a.other := Integer( x( 1385 + person_no ) );
      a.selfem := Integer( x( 1393 + person_no ) );
      a.nea := Integer( x( 1401 + person_no ) );
      a.eactiv := Integer( x( 1409 + person_no ) );
      a.workag := Integer( x( 1417 + person_no ) );
      a.lstat  := Integer( x( 1425 + person_no ) );
      a.undemp := Integer( x( 1433 + person_no ) );
      a.bothem := Integer( x( 1441 + person_no ) );
      a.workyr := Integer( x( 1449 + person_no ) );
      a.empyed := Integer( x( 1457 + person_no ) );
      a.unionm := Integer( x( 1465 + person_no ) );
      return a;
   end Read_From_Raw;

   
 
   procedure Read_From_Gauss_File( f : File_Type; hh : out Household_Rec; household_counter : in out Positive; is_end : out Boolean ) is
      use Expenditure_Type_Package;
      record_count : Positive := 1;
      expenditure : Expenditure_Array := ( others=>0.0 );
      pc : Person_Count;
   begin
      hh.expenditure := ( others => 0.0 );
      hh.num_families := 1;
      if( household_counter > 1 ) then
         recs(1) := last_record;
         record_count := record_count + 1;
      end if;
      loop
         recs( record_count ) := Read_Gauss_Rec( f );
         last_record := recs( record_count );
         Put_Line( "on record " & record_count'Img & " recs( record_count ).household_reference " & recs( record_count ).household_reference'Img );
         exit when ( record_count > 1 ) and then ( recs( record_count ).household_reference /= recs( record_count - 1 ).household_reference );
         if( household_counter < 5 ) then
            Put_line( To_String( recs( record_count ) ));
         end if;
         record_count := record_count + 1;
      end loop;
      Put_Line( "record_count " & Natural'Image( record_count ));
      hh.num_families := record_count-1;
      hh.reference_number := recs( 1 ).household_reference;
      hh.counter := household_counter;
      for tuno in 1 .. hh.num_families loop
          pc := 1;
          for pno in Person_Count loop -- person count from number of non-zero PIDs, which start at 18
             hh.family( tuno ).num_people := pno;
             exit when ( recs( tuno ).data( 17 + pno ) = 0.0 ) or ( pno = Person_Count'Last );
             pc := pc + 1;
          end loop;
          hh.family( tuno ).num_people := pc-1;
          hh.housing := Read_From_Raw( recs( tuno ).data, 1 );
          expenditure := Read_From_Raw( recs( tuno ).data, 1 );
          -- Put_Line( "expenditure(" & pno'Img & " ) = " & To_String( expenditure ) );
          hh.expenditure := hh.expenditure + expenditure;
          for pno in 1 .. hh.family( tuno ).num_people loop
             hh.family( tuno ).person( pno ).incomes := Read_From_Raw( recs( tuno ).data, pno );
             hh.family( tuno ).person( pno ).demographics := Read_From_Raw( recs( tuno ).data, pno );
             hh.family( tuno ).person( pno ).work := Read_From_Raw( recs( tuno ).data, pno );
             hh.family( tuno ).person( pno ).age := hh.family( tuno ).person( pno ).demographics.age;
             hh.family( tuno ).person( pno ).gender := hh.family( tuno ).person( pno ).demographics.gender;
          end loop;
      end loop;
      if( household_counter < 10 ) then
         Put_Line( "Household " & To_String( hh, 0, False ));
      end if;
      household_counter := household_counter + 1;
      is_end := End_Of_File( f ); 
   end Read_From_Gauss_File;
   
end ZA.Household.Gauss_IO;
