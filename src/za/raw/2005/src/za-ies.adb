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

with Ada.Strings.Unbounded;
with Ada.Text_IO;

package body ZA.IES is

   use Ada.Text_IO;
   
    function Pretty_Print( i : Age_Group_Type ) return String is
    begin
         case i is
             when age_00_to_04_years => return "00  to  04 years";
             when age_05_to_09_years => return "05  to  09 years";
             when age_10_to_14_years => return "10  to  14 years";
             when age_15_to_19_years => return "15  to  19 years";
             when age_20_to_24_years => return "20  to  24 years";
             when age_25_to_29_years => return "25  to  29 years";
             when age_30_to_34_years => return "30  to  34 years";
             when age_35_to_39_years => return "35  to  39 years";
             when age_40_to_44_years => return "40  to  44 years";
             when age_45_to_49_years => return "45  to  49 years";
             when age_50_to_54_years => return "50  to  54 years";
             when age_55_to_59_years => return "55  to  59 years";
             when age_60_to_64_years => return "60  to  64 years";
             when age_65_to_69_years => return "65  to  69 years";
             when age_70_to_74_years => return "70  to  74 years";
             when age_75_to_79_years => return "75  to  79 years";
             when age_80_to_84_years => return "80  to  84 years";
             when age_85_plus => return "85 Plus";
             when unspecified => return "Unspecified ";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;
    
    function Convert_Age_Group_Type( i : String ) return Age_Group_Type is
    begin
         if i = "01" then
            return age_00_to_04_years;
         elsif i = "02" then
            return age_05_to_09_years;
         elsif i = "03" then
            return age_10_to_14_years;
         elsif i = "04" then
            return age_15_to_19_years;
         elsif i = "05" then
            return age_20_to_24_years;
         elsif i = "06" then
            return age_25_to_29_years;
         elsif i = "07" then
            return age_30_to_34_years;
         elsif i = "08" then
            return age_35_to_39_years;
         elsif i = "09" then
            return age_40_to_44_years;
         elsif i = "10" then
            return age_45_to_49_years;
         elsif i = "11" then
            return age_50_to_54_years;
         elsif i = "12" then
            return age_55_to_59_years;
         elsif i = "13" then
            return age_60_to_64_years;
         elsif i = "14" then
            return age_65_to_69_years;
         elsif i = "15" then
            return age_70_to_74_years;
         elsif i = "16" then
            return age_75_to_79_years;
         elsif i = "17" then
            return age_80_to_84_years;
         elsif i = "18" then
            return age_85_plus;
         elsif i = "99" then
            return unspecified;
        end if;
        return missing;
    end Convert_Age_Group_Type;
    
    function Pretty_Print( i : Support_Age_Group_Type ) return String is
    begin
         case i is
             when age_00_to_04_years => return "00 to 04 years";
             when age_05_to_09_years => return "05 to 09 years";
             when age_10_to_14_years => return "10 to 14 years";
             when age_15_to_19_years => return "15 to 19 years";
             when age_20_to_24_years => return "20 to 24 years";
             when age_25_to_29_years => return "25 to 29 years";
             when age_30_to_34_years => return "30 to 34 years";
             when age_35_to_39_years => return "35 to 39 years";
             when age_40_to_44_years => return "40 to 44 years";
             when age_45_to_49_years => return "45 to 49 years";
             when age_50_to_54_years => return "50 to 54 years";
             when age_60_to_64_years => return "60 to 64 years";
             when age_65_to_69_years => return "65 to 69 years";
             when age_70_to_74_years => return "70 to 74 years";
             when age_75_plus => return "age_75_plus";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;
    
    function Convert_Support_Age_Group_Type( i : String ) return Support_Age_Group_Type is
    begin
         if i = "01" then
            return age_00_to_04_years;
         elsif i = "02" then
            return age_05_to_09_years;
         elsif i = "03" then
            return age_10_to_14_years;
         elsif i = "04" then
            return age_15_to_19_years;
         elsif i = "05" then
            return age_20_to_24_years;
         elsif i = "06" then
            return age_25_to_29_years;
         elsif i = "07" then
            return age_30_to_34_years;
         elsif i = "08" then
            return age_35_to_39_years;
         elsif i = "09" then
            return age_40_to_44_years;
         elsif i = "10" then
            return age_45_to_49_years;
         elsif i = "11" then
            return age_50_to_54_years;
         elsif i = "13" then
            return age_60_to_64_years;
         elsif i = "14" then
            return age_65_to_69_years;
         elsif i = "15" then
            return age_70_to_74_years;
         elsif i = "16" then
            return age_75_plus;
         elsif i = "88" then
            return not_applicable;
         elsif i = "99" then
            return unspecified;
        end if;
        return missing;
    end Convert_Support_Age_Group_Type;
   

    function Pretty_Print( i : Gender_Type ) return String is
    begin
         case i is
             when male => return "Male";
             when female => return "Female";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Gender_Type( i : String ) return Gender_Type is
    begin
         if i = "1" then
            return male;
         elsif i = "2" then
            return female;
         elsif i = "9" then
            return unspecified;
        end if;
        Put_Line( " Convert_Gender_Type failed to match code(1,2,9) |" & i & "|" );
        return missing;
    end Convert_Gender_Type;


    function Pretty_Print( i : Week2_spentw2_Type ) return String is
    begin
         case i is
             when yes => return "Yes";
             when no => return "No";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Week2_spentw2_Type( i : String ) return Week2_spentw2_Type is
    begin
         if i = "1" then
            return yes;
         elsif i = "2" then
            return no;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Week2_spentw2_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Week2_spentw2_Type;


    function Pretty_Print( i : Yes_No_Unspecified_Type ) return String is
    begin
         case i is
             when yes => return "Yes";
             when no => return "No";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Yes_No_Unspecified_Type( i : String ) return Yes_No_Unspecified_Type is
    begin
         if i = "1" then
            return yes;
         elsif i = "2" then
            return no;
         elsif i = "9" then
            return unspecified;
         elsif i = "1" then
            return yes;
         elsif i = "2" then
            return no;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Yes_No_Unspecified_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Yes_No_Unspecified_Type;


    function Pretty_Print( i : Tobacco1_Type ) return String is
    begin
         case i is
             when smoking => return "Smoking";
             when not_smoking => return "Not smoking";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Tobacco1_Type( i : String ) return Tobacco1_Type is
    begin
         if i = "0" then
            return smoking;
         elsif i = "1" then
            return not_smoking;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Tobacco1_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Tobacco1_Type;


    function Pretty_Print( i : Tobacco2_Type ) return String is
    begin
         case i is
             when not_smoking_cigarettes => return "Not smoking cigarettes";
             when yes_cigarettes => return "Yes: Cigarettes";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Tobacco2_Type( i : String ) return Tobacco2_Type is
    begin
         if i = "0" then
            return not_smoking_cigarettes;
         elsif i = "1" then
            return yes_cigarettes;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Tobacco2_Type; failed to match code |" & i & "|" );
     return missing;
    end Convert_Tobacco2_Type;


    function Pretty_Print( i : Tobacco3_Type ) return String is
    begin
         case i is
             when not_smoking_cigars => return "Not smoking cigars";
             when yes_cigars => return "Yes: Cigars";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Tobacco3_Type( i : String ) return Tobacco3_Type is
    begin
         if i = "0" then
            return not_smoking_cigars;
         elsif i = "1" then
            return yes_cigars;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Tobacco3_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Tobacco3_Type;


    function Pretty_Print( i : Tobacco4_Type ) return String is
    begin
         case i is
             when not_using_other_tobacco_products => return "Not using other tobacco products";
             when yes_tobacco => return "Yes: Tobacco";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Tobacco4_Type( i : String ) return Tobacco4_Type is
    begin
         if i = "0" then
            return not_using_other_tobacco_products;
         elsif i = "1" then
            return yes_tobacco;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Tobacco4_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Tobacco4_Type;


    function Pretty_Print( i : Tobacco5_Type ) return String is
    begin
         case i is
             when not_using_other_items_for_smoking => return "Not using other items for smoking";
             when yes_other => return "Yes: Other";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Tobacco5_Type( i : String ) return Tobacco5_Type is
    begin
         if i = "0" then
            return not_using_other_items_for_smoking;
         elsif i = "1" then
            return yes_other;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Tobacco5_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Tobacco5_Type;


    function Pretty_Print( i : Education_Level ) return String is
    begin
         case i is
             when no_schooling => return "No schooling";
             when grade_r_or_0 => return "Grade R / 0";
             when grade_1_or_sub_a => return "Grade 1 / Sub A";
             when grade_2_or_sub_b => return "Grade 2 / Sub B";
             when grade_3_or_standard_1 => return "Grade 3 / Standard 1";
             when grade_4_or_standard_2 => return "Grade 4 / Standard 2";
             when grade_5_or_standard_3 => return "Grade 5 / Standard 3";
             when grade_6_or_standard_4 => return "Grade 6 / Standard 4";
             when grade_7_or_standard_5 => return "Grade 7 / Standard 5";
             when grade_8_or_standard_6_or_form_1 => return "Grade 8 / Standard 6 / Form 1";
             when grade_9_or_standard_7_or_form_2 => return "Grade 9 / Standard 7 / Form 2  ";
             when grade_10_or_standard_8_or_form_3 => return "Grade 10 / Standard 8 / Form 3";
             when grade_11_or_standard_9_or_form_4 => return "Grade 11 / Standard 9 / Form 4";
             when grade_12_or_standard_10_or_form_5_or_matric => return "Grade 12 / Standard 10 / Form 5/Matric";
             when ntc_l => return "NTC l";
             when ntc_ii => return "NTC II";
             when ntc_iii => return "NTC III";
             when diploma_or_certificate_with_less_than_grade_12_or_std_10 => return "Diploma / certificate with less than Grade 12 / Std 10 ";
             when diploma_with_less_than_grade_12_or_std_10 => return "Diploma with less than Grade 12 / Std 10";
             when certificate_with_grade_12_or_std_10 => return "Certificate with Grade 12 / Std 10";
             when diploma_with_grade_12_or_std_10 => return "Diploma with Grade 12 / Std 10";
             when bachelors_degree => return "Bachelors Degree";
             when bachelors_degree_and_diploma => return "Bachelors Degree and Diploma";
             when honours_degree => return "Honours Degree";
             when higher_degree_masters_doctorate => return "Higher Degree (Masters, Doctorate)";
             when xother => return "Other ";
             when dont_know_or_unspecified => return "Don't know/Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Education_Level( i : String ) return Education_Level is
    begin
         if i = "00" or i = " 0" then
            return no_schooling;
         elsif i = "01" or i = " 1" then
            return grade_r_or_0;
         elsif i = "02" or i = " 2" then
            return grade_1_or_sub_a;
         elsif i = "03" or i = " 3" then
            return grade_2_or_sub_b;
         elsif i = "04" or i = " 4" then
            return grade_3_or_standard_1;
         elsif i = "05" or i = " 5" then
            return grade_4_or_standard_2;
         elsif i = "06" or i = " 6" then
            return grade_5_or_standard_3;
         elsif i = "07" or i = " 7" then
            return grade_6_or_standard_4;
         elsif i = "08" or i = " 8" then
            return grade_7_or_standard_5;
         elsif i = "09" or i = " 9" then
            return grade_8_or_standard_6_or_form_1;
         elsif i = "10" then
            return grade_9_or_standard_7_or_form_2;
         elsif i = "11" then
            return grade_10_or_standard_8_or_form_3;
         elsif i = "12" then
            return grade_11_or_standard_9_or_form_4;
         elsif i = "13" then
            return grade_12_or_standard_10_or_form_5_or_matric;
         elsif i = "14" then
            return ntc_l;
         elsif i = "15" then
            return ntc_ii;
         elsif i = "16" then
            return ntc_iii;
         elsif i = "17" then
            return diploma_or_certificate_with_less_than_grade_12_or_std_10;
         elsif i = "18" then
            return diploma_with_less_than_grade_12_or_std_10;
         elsif i = "19" then
            return certificate_with_grade_12_or_std_10;
         elsif i = "20" then
            return diploma_with_grade_12_or_std_10;
         elsif i = "21" then
            return bachelors_degree;
         elsif i = "22" then
            return bachelors_degree_and_diploma;
         elsif i = "23" then
            return honours_degree;
         elsif i = "24" then
            return higher_degree_masters_doctorate;
         elsif i = "25" then
            return xother;
         elsif i = "26" then
            return dont_know_or_unspecified;
        end if;
       Put_Line( "Convert_Education_Level: failed to match code |" & i & "|" );
     return missing;
    end Convert_Education_Level;


    function Pretty_Print( i : Dwelling_Type ) return String is
    begin
         case i is
             when boarding_school_or_university_hostel => return "Boarding school/university hostel";
             when old_age_home => return "Old-age home";
             when frail_care_centre => return "Frail care centre";
             when home_for_the_disabled => return "Home for the disabled";
             when initiation_school => return "Initiation school";
             when prison => return "Prison";
             when retirement_village => return "Retirement village";
             when hospital_or_medical_facility_or_clinic => return "Hospital/medical facility/clinic";
             when private_house => return "Private house";
             when other_specify => return "Other, specify";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Dwelling_Type( i : String ) return Dwelling_Type is
    begin
         if i = "01" or i = " 1" then
            return boarding_school_or_university_hostel;
         elsif i = "02" or i = " 2" then
            return old_age_home;
         elsif i = "03" or i = " 3" then
            return frail_care_centre;
         elsif i = "04" or i = " 4" then
            return home_for_the_disabled;
         elsif i = "05" or i = " 5" then
            return initiation_school;
         elsif i = "06" or i = " 6" then
            return prison;
         elsif i = "07" or i = " 7" then
            return retirement_village;
         elsif i = "08" or i = " 8" then
            return hospital_or_medical_facility_or_clinic;
         elsif i = "09" or i = " 9" then
            return private_house;
         elsif i = "10" then
            return other_specify;
         elsif i = "99" then
            return unspecified;
        end if;
        Put_Line( "Convert_Dwelling_Type: failed to match code |" & i & "|" );
       return missing;
    end Convert_Dwelling_Type;


    function Pretty_Print( i : Gender2 ) return String is
    begin
         case i is
             when male => return "Male";
             when female => return "Female";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Gender2( i : String ) return Gender2 is
    begin
         if i = "1" then
            return male;
         elsif i = "2" then
            return female;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
        Put_Line( "Convert_Gender2 failed to match code |" & i & "|" );
        return missing;
    end Convert_Gender2;


    function Pretty_Print( i : Population_Group ) return String is
    begin
         case i is
             when african_or_black => return "African/Black";
             when coloured => return "Coloured";
             when indian_or_asian => return "Indian/Asian";
             when white => return "White";
             when xother => return "Other";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Population_Group( i : String ) return Population_Group is
    begin
         if i = "1" then
            return african_or_black;
         elsif i = "2" then
            return coloured;
         elsif i = "3" then
            return indian_or_asian;
         elsif i = "4" then
            return white;
         elsif i = "5" then
            return xother;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
        Put_Line( "Convert_Population_Group: failed to match code |" & i & "|" );
        return missing;
    end Convert_Population_Group;


    function Pretty_Print( i : Yes_No_NA_Unspecified ) return String is
    begin
         case i is
             when yes => return "Yes";
             when no => return "No";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Yes_No_NA_Unspecified( i : String ) return Yes_No_NA_Unspecified is
    begin
         if i = "1" then
            return yes;
         elsif i = "2" then
            return no;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
        Put_Line( "Convert_Yes_No_NA_Unspecified failed to match code |" & i & "|" );
        return missing;
    end Convert_Yes_No_NA_Unspecified;


    function Pretty_Print( i : Area_Of_Purchase ) return String is
    begin
         case i is
             when not_applicable => return "Not applicable";
             when in_the_town_or_city_where_the_household_lives => return "In the town/city where the household lives";
             when in_another_town_or_city_away_from_where_the_household_lives => return "In another town or city away from where the household lives";
             when in_the_rural_area => return "In the rural area";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Area_Of_Purchase( i : String ) return Area_Of_Purchase is
    begin
         if i = "0" then
            return not_applicable;
         elsif i = "1" then
            return in_the_town_or_city_where_the_household_lives;
         elsif i = "2" then
            return in_another_town_or_city_away_from_where_the_household_lives;
         elsif i = "3" then
            return in_the_rural_area;
        end if;
       Put_Line( "Convert_Area_Of_Purchase failed to match code |" & i & "| " );
     return missing;
    end Convert_Area_Of_Purchase;


    function Pretty_Print( i : Retailer_Type ) return String is
    begin
         case i is
             when formal_sector_chain_store => return "Formal sector – Chain store";
             when formal_sector_other_retailer => return "Formal sector – Other retailer";
             when informal_sector_street_trading => return "Informal sector – Street trading";
             when informal_sector_other => return "Informal sector – Other";
             when not_applicable => return "Not applicable";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Retailer_Type( i : String ) return Retailer_Type is
    begin
         if i = "1" then
            return formal_sector_chain_store;
         elsif i = "2" then
            return formal_sector_other_retailer;
         elsif i = "3" then
            return informal_sector_street_trading;
         elsif i = "4" then
            return informal_sector_other;
         elsif i = "8" then
            return not_applicable;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Q21btyperetailer_Typ failed to match code |" & i & "|" );
     return missing;
    end Convert_Retailer_Type;


    function Pretty_Print( i : Province_Type ) return String is
    begin
         case i is
             when western_cape => return "Western Cape";
             when eastern_cape => return "Eastern Cape";
             when northern_cape => return "Northern Cape";
             when free_state => return "Free State";
             when kwazulu_natal => return "KwaZulu-Natal";
             when north_west => return "North West";
             when gauteng => return "Gauteng";
             when mpumalanga => return "Mpumalanga";
             when limpopo => return "Limpopo";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Province_Type( i : String ) return Province_Type is
    begin
         if i = "1" then
            return western_cape;
         elsif i = "2" then
            return eastern_cape;
         elsif i = "3" then
            return northern_cape;
         elsif i = "4" then
            return free_state;
         elsif i = "5" then
            return kwazulu_natal;
         elsif i = "6" then
            return north_west;
         elsif i = "7" then
            return gauteng;
         elsif i = "8" then
            return mpumalanga;
         elsif i = "9" then
            return limpopo;
        end if;
       Put_Line( "Convert_Province failed to match code |" & i & "|" );
     return missing;
    end Convert_Province_Type;


    function Pretty_Print( i : Settlement_Type ) return String is
    begin
         case i is
             when urban => return "Urban";
             when rural => return "Rural";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Settlement_Type( i : String ) return Settlement_Type is
    begin
         if i = "1" then
            return urban;
         elsif i = "2" then
            return rural;
        end if;
       Put_Line( "Convert_Settlement_Type failed to match code |" & i & "| " );
     return missing;
    end Convert_Settlement_Type;


    function Pretty_Print( i : Survey_Month ) return String is
    begin
         case i is
             when january => return "January";
             when february => return "February";
             when march => return "March";
             when april => return "April";
             when may => return "May";
             when june => return "June";
             when july => return "July";
             when august => return "August";
             when september => return "September";
             when october => return "October";
             when november => return "November";
             when december => return "December";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Survey_Month( i : String ) return Survey_Month is
    begin
         if i = "1" or i = "01" then
            return january;
         elsif i = "2" or i = "02" then
            return february;
         elsif i = "3" or i = "03" then
            return march;
         elsif i = "4" or i = "04" then
            return april;
         elsif i = "5" or i = "05" then
            return may;
         elsif i = "6" or i = "06" then
            return june;
         elsif i = "7" or i = "07" then
            return july;
         elsif i = "8" or i = "08" then
            return august;
         elsif i = "9" or i = "09" then
            return september;
         elsif i = "10" then
            return october;
         elsif i = "11" then
            return november;
         elsif i = "12" then
            return december;
        end if;
       Put_Line( "Convert_Survey_Month failed to match code |" & i & "| " );
     return missing;
    end Convert_Survey_Month;


    function Pretty_Print( i : Population_Group_Of_Head ) return String is
    begin
         case i is
             when african_or_black => return "African/Black";
             when coloured => return "Coloured";
             when indian_or_asian => return "Indian/Asian";
             when white => return "White";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Population_Group_Of_Head( i : String ) return Population_Group_Of_Head is
    begin
         if i = "1" then
            return african_or_black;
         elsif i = "2" then
            return coloured;
         elsif i = "3" then
            return indian_or_asian;
         elsif i = "4" then
            return white;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Population_Group_Of_Head failed to match code |" & i & "| " );
     return missing;
    end Convert_Population_Group_Of_Head;


    function Pretty_Print( i : Q16support_Type ) return String is
    begin
         case i is
             when yes => return "Yes";
             when no => return "No";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Q16support_Type( i : String ) return Q16support_Type is
    begin
         if i = "1" then
            return yes;
         elsif i = "2" then
            return no;
        end if;
        Put_Line( "Convert_Q16support_Type failed to match code |" & i & "|" );
        return missing;
    end Convert_Q16support_Type;


    function Pretty_Print( i : Main_Dwelling_Type ) return String is
    begin
         case i is
             when dwelling_or_brick_structure_on_a_separate_stand_or_yard_or_on_farm => return "Dwelling or brick structure on a separate stand or yard or on farm";
             when traditional_dwelling_or_hut_or_structure_made_of_traditional_material => return "Traditional dwelling/hut/structure made of traditional material";
             when flat_or_apartment_in_a_block_of_flats => return "Flat or apartment in a block of flats";
             when town_or_cluster_or_semi_detached_house_simplex_duplex_or_triplex => return "Town/cluster/semi-detached house (simplex, duplex or triplex)";
             when unit_in_retirement_village => return "Unit in retirement village";
             when dwelling_or_flat_or_room_in_backyard => return "Dwelling/flat/room in backyard";
             when informal_dwelling_or_shack_in_backyard => return "Informal dwelling/shack in backyard  ";
             when informal_dwelling_or_shack_not_in_backyard_eg_in_an_informal_or_squatter_settlement_or_on_farm => return "Informal dwelling/shack not in backyard e.g. in an informal/squatter settlement or on farm";
             when room_or_flatlet_or_a_larger_dwelling_or_servants_quarters_or_granny_flat => return "Room/flatlet or a larger dwelling/servants quarters/granny flat";
             when caravan_or_tent => return "Caravan/tent";
             when workers_hostel => return "Workers’ hostel";
             when family_unit_formerly_workers_hostel => return "Family unit (formerly workers’ hostel)";
             when xother => return "Other";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Main_Dwelling_Type( s : String ) return Main_Dwelling_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "01" or i = "1" then
            return dwelling_or_brick_structure_on_a_separate_stand_or_yard_or_on_farm;
         elsif i = "02" or i = "2" then
            return traditional_dwelling_or_hut_or_structure_made_of_traditional_material;
         elsif i = "03" or i = "3" then
            return flat_or_apartment_in_a_block_of_flats;
         elsif i = "04" or i = "4" then
            return town_or_cluster_or_semi_detached_house_simplex_duplex_or_triplex;
         elsif i = "05" or i = "5" then
            return unit_in_retirement_village;
         elsif i = "06" or i = "6" then
            return dwelling_or_flat_or_room_in_backyard;
         elsif i = "07" or i = "7" then
            return informal_dwelling_or_shack_in_backyard;
         elsif i = "08" or i = "8" then
            return informal_dwelling_or_shack_not_in_backyard_eg_in_an_informal_or_squatter_settlement_or_on_farm;
         elsif i = "09" or i = "9" then
            return room_or_flatlet_or_a_larger_dwelling_or_servants_quarters_or_granny_flat;
         elsif i = "10" then
            return caravan_or_tent;
         elsif i = "11" then
            return workers_hostel;
         elsif i = "12" then
            return family_unit_formerly_workers_hostel;
         elsif i = "13" then
            return xother;
         elsif i = "99" then
            return unspecified;
        end if;
        Put_Line( "Convert_Main_Dwelling_Type failed to match code |" & i & "|" );
        return missing;
    end Convert_Main_Dwelling_Type;


    function Pretty_Print( i : Wall_Materials_Type ) return String is
    begin
         case i is
             when bricks => return "Bricks";
             when cement_block_or_concrete => return "Cement block/concrete";
             when corrugated_iron_or_zinc => return "Corrugated iron/zinc";
             when wood => return "Wood";
             when plastic => return "Plastic";
             when cardboard => return "Cardboard";
             when mixture_of_mud_and_cement => return "Mixture of mud and cement";
             when wattle_and_daub => return "Wattle and daub";
             when tile => return "Tile";
             when mud => return "Mud";
             when thatching => return "Thatching";
             when asbestos => return "Asbestos ";
             when xother => return "Other ";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Wall_Materials_Type( s : String ) return Wall_Materials_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "01" or i = "1"then
            return bricks;
         elsif i = "02" or i = "2" then
            return cement_block_or_concrete;
         elsif i = "03" or i = "3" then
            return corrugated_iron_or_zinc;
         elsif i = "04" or i = "4" then
            return wood;
         elsif i = "05" or i = "5" then
            return plastic;
         elsif i = "06" or i = "6" then
            return cardboard;
         elsif i = "07" or i = "7" then
            return mixture_of_mud_and_cement;
         elsif i = "08" or i = "8" then
            return wattle_and_daub;
         elsif i = "09" or i = "9" then
            return tile;
         elsif i = "10" then
            return mud;
         elsif i = "11" then
            return thatching;
         elsif i = "12" then
            return asbestos;
         elsif i = "13" then
            return xother;
         elsif i = "99" then
            return unspecified;
        end if;
       Put_Line( "Convert_Wall_Materials_Type: failed to match code |" & i & "|" );
     return missing;
    end Convert_Wall_Materials_Type;


    function Pretty_Print( i : Yes_No_Dont_Know_Type ) return String is
    begin
         case i is
             when yes => return "Yes";
             when no => return "No";
             when dont_know_or_unspecified => return "don’t know/Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Yes_No_Dont_Know_Type( i : String ) return Yes_No_Dont_Know_Type is
    begin
         if i = "1" then
            return yes;
         elsif i = "2" then
            return no;
         elsif i = "3" then
            return dont_know_or_unspecified;
        end if;
       Put_Line( "Convert_Yes_No_Dont_Know_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Yes_No_Dont_Know_Type;


    function Pretty_Print( i : Toilet_Type ) return String is
    begin
         case i is
             when flush_toilet_in_dwelling_with_offsite_disposal => return "Flush toilet in dwelling with offsite disposal";
             when flush_toilet_on_site_with_offsite_disposal => return "Flush toilet on site with offsite disposal";
             when flush_toilet_off_site_with_offsite_disposal => return "Flush toilet off site with offsite disposal";
             when flush_toilet_in_dwelling_with_onsite_disposal_septic_tank => return "Flush toilet in dwelling with onsite disposal (septic tank)";
             when flush_toilet_on_site_with_onsite_disposal_septic_tank => return "Flush toilet on site with onsite disposal (septic tank)";
             when flush_toilet_off_site_with_onsite_disposal_septic_tank => return "Flush toilet off site with onsite disposal (septic tank)";
             when chemical_toilet_on_site => return "Chemical toilet on site";
             when chemical_toilet_off_site => return "Chemical toilet off site";
             when pit_latrine_on_site_with_ventilation_pipe => return "Pit latrine on site with ventilation pipe";
             when pit_latrine_off_site_with_ventilation_pipe => return "Pit latrine off site with ventilation pipe";
             when pit_latrine_on_site_without_ventilation_pipe => return "Pit latrine on site without ventilation pipe";
             when pit_latrine_off_site_without_ventilation_pipe => return "Pit latrine off site without ventilation pipe";
             when bucket_toilet_on_site => return "Bucket toilet on site";
             when bucket_toilet_off_site => return "Bucket toilet off site";
             when none => return "None";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Toilet_Type( s : String ) return Toilet_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "11" then
            return flush_toilet_in_dwelling_with_offsite_disposal;
         elsif i = "12" then
            return flush_toilet_on_site_with_offsite_disposal;
         elsif i = "13" then
            return flush_toilet_off_site_with_offsite_disposal;
         elsif i = "21" then
            return flush_toilet_in_dwelling_with_onsite_disposal_septic_tank;
         elsif i = "22" then
            return flush_toilet_on_site_with_onsite_disposal_septic_tank;
         elsif i = "23" then
            return flush_toilet_off_site_with_onsite_disposal_septic_tank;
         elsif i = "32" then
            return chemical_toilet_on_site;
         elsif i = "33" then
            return chemical_toilet_off_site;
         elsif i = "42" then
            return pit_latrine_on_site_with_ventilation_pipe;
         elsif i = "43" then
            return pit_latrine_off_site_with_ventilation_pipe;
         elsif i = "52" then
            return pit_latrine_on_site_without_ventilation_pipe;
         elsif i = "53" then
            return pit_latrine_off_site_without_ventilation_pipe;
         elsif i = "62" then
            return bucket_toilet_on_site;
         elsif i = "63" then
            return bucket_toilet_off_site;
         elsif i = "73" then
            return none;
         elsif i = "99" then
            return unspecified;
        end if;
       Put_Line( "Convert_Toilet_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Toilet_Type;


    function Pretty_Print( i : Q36sharetoilet_Type ) return String is
    begin
         case i is
             when yes => return "Yes";
             when no => return "No";
             when unspecified_or_not_applicable => return "Unspecified/not applicable";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Q36sharetoilet_Type( s : String ) return Q36sharetoilet_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "1" then
            return yes;
         elsif i = "2" then
            return no;
         elsif i = "9" then
            return unspecified_or_not_applicable;
        end if;
       Put_Line( "Convert_Q36sharetoilet_Type: failed to match code |" & i & "|" );
     return missing;
    end Convert_Q36sharetoilet_Type;


    function Pretty_Print( i : Energy_For_Cooking_Type ) return String is
    begin
         case i is
             when electricity_from_mains => return "Electricity from mains";
             when electricity_from_generator => return "Electricity from generator";
             when gas => return "Gas";
             when paraffin => return "Paraffin";
             when wood => return "Wood";
             when coal => return "Coal";
             when animal_dung => return "Animal dung";
             when electricity_from_solar => return "Electricity from solar";
             when xother => return "Other";
             when none => return "None";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Energy_For_Cooking_Type( s : String ) return Energy_For_Cooking_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "01" or i = "1" then
            return electricity_from_mains;
         elsif i = "02" or i = "2" then
            return electricity_from_generator;
         elsif i = "03" or i = "3" then
            return gas;
         elsif i = "04" or i = "4" then
            return paraffin;
         elsif i = "05" or i = "5" then
            return wood;
         elsif i = "06" or i = "6" then
            return coal;
         elsif i = "08" or i = "8" then
            return animal_dung;
         elsif i = "09" or i = "9" then
            return electricity_from_solar;
         elsif i = "10" then
            return xother;
         elsif i = "11" then
            return none;
         elsif i = "99" then
            return unspecified;
        end if;
       Put_Line( "Convert_Energy_For_Cooking_Type: failed to match code |" & i & "|" );
     return missing;
    end Convert_Energy_For_Cooking_Type;


    function Pretty_Print( i : Energy_For_Heat_Type ) return String is
    begin
         case i is
             when electricity_from_mains => return "Electricity from mains";
             when electricity_from_generator => return "Electricity from generator";
             when gas => return "Gas";
             when paraffin => return "Paraffin";
             when wood => return "Wood";
             when coal => return "Coal";
             when candles => return "Candles";
             when animal_dung => return "Animal dung";
             when electricity_from_solar => return "Electricity from solar";
             when xother => return "Other";
             when none => return "None";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Energy_For_Heat_Type( s : String ) return Energy_For_Heat_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "01" or i = "1" then
            return electricity_from_mains;
         elsif i = "02" or i = "2" then
            return electricity_from_generator;
         elsif i = "03" or i = "3" then
            return gas;
         elsif i = "04" or i = "4" then
            return paraffin;
         elsif i = "05" or i = "5" then
            return wood;
         elsif i = "06" or i = "6" then
            return coal;
         elsif i = "07" or i = "7" then
            return candles;
         elsif i = "08" or i = "8" then
            return animal_dung;
         elsif i = "09" or i = "9" then
            return electricity_from_solar;
         elsif i = "10" then
            return xother;
         elsif i = "11" then
            return none;
         elsif i = "99" then
            return unspecified;
        end if;
       Put_Line( "Convert_Energy_For_Heat_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Energy_For_Heat_Type;


    function Pretty_Print( i : Energy_For_Lighting_Type ) return String is
    begin
         case i is
             when electricity_from_mains => return "Electricity from mains";
             when electricity_from_generator => return "Electricity from generator";
             when gas => return "Gas";
             when paraffin => return "Paraffin";
             when candles => return "Candles";
             when electricity_from_solar => return "Electricity from solar";
             when xother => return "Other";
             when none => return "None";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Energy_For_Lighting_Type( s : String ) return Energy_For_Lighting_Type is
      i : String := Text_Utils.Censor_String( s );
    begin
         if i = "01" or i = "1" then
            return electricity_from_mains;
         elsif i = "02" or i = "2" then
            return electricity_from_generator;
         elsif i = "03" or i = "3" then
            return gas;
         elsif i = "04" or i = "4" then
            return paraffin;
         elsif i = "07" or i = "7" then
            return candles;
         elsif i = "09" or i = "9" then
            return electricity_from_solar;
         elsif i = "10" then
            return xother;
         elsif i = "11" then
            return none;
         elsif i = "99" then
            return unspecified;
        end if;
       Put_Line( "Convert_Energy_For_Lighting_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Energy_For_Lighting_Type;


    function Pretty_Print( i : Refuse_Type ) return String is
    begin
         case i is
             when removed_by_local_authority_at_least_once_a_week => return "Removed by local authority at least once a week";
             when removed_by_local_authority_less_often_than_once_a_week => return "Removed by local authority less often than once a week";
             when removed_by_community_members_at_least_once_a_week => return "Removed by community members at least once a week";
             when removed_by_community_members_less_often_than_once_a_week => return "Removed by community members less often than once a week";
             when communal_refuse_dump_or_communal_container => return "Communal refuse dump/communal container";
             when own_refuse_dump => return "Own refuse dump";
             when no_rubbish_removal => return "No rubbish removal";
             when xother => return "Other";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Refuse_Type( i : String ) return Refuse_Type is
    begin
         if i = "1" then
            return removed_by_local_authority_at_least_once_a_week;
         elsif i = "2" then
            return removed_by_local_authority_less_often_than_once_a_week;
         elsif i = "3" then
            return removed_by_community_members_at_least_once_a_week;
         elsif i = "4" then
            return removed_by_community_members_less_often_than_once_a_week;
         elsif i = "5" then
            return communal_refuse_dump_or_communal_container;
         elsif i = "6" then
            return own_refuse_dump;
         elsif i = "7" then
            return no_rubbish_removal;
         elsif i = "8" then
            return xother;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Refuse_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Refuse_Type;


    function Pretty_Print( i : Ownership_Type ) return String is
    begin
         case i is
             when owns => return "Owns";
             when does_not_own_but_has_access_to => return "Does not own, but has access to";
             when neither_owns_nor_has_access => return "Neither owns nor has access";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Ownership_Type( i : String ) return Ownership_Type is
    begin
         if i = "1" then
            return owns;
         elsif i = "2" then
            return does_not_own_but_has_access_to;
         elsif i = "3" then
            return neither_owns_nor_has_access;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Ownership_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Ownership_Type;


    function Pretty_Print( i : Tenure_Type ) return String is
    begin
         case i is
             when owned_and_fully_paid_off => return "Owned and fully paid off";
             when owned_but_not_yet_fully_paid_off_eg_with_a_mortgage => return "Owned, but not yet fully paid off (e.g. with a mortgage)";
             when rented_as_part_of_employment_contract_of_household_member => return "Rented as part of employment contract of household member";
             when rented_not_as_part_of_employment_contract_of_household_member => return "Rented not as part of employment contract of household member";
             when occupied_rent_free_as_part_of_employment_contract_of_household_member => return "Occupied rent-free as part of employment contract of household member";
             when occupied_rent_free_not_as_part_of_employment_contract_of_household_member => return "Occupied rent-free not as part of employment contract of household member";
             when occupied_as_a_boarder_or_lodger => return "Occupied as a boarder/lodger";
             when xother => return "Other";
             when unspecified => return "Unspecified";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Tenure_Type( i : String ) return Tenure_Type is
    begin
         if i = "1" then
            return owned_and_fully_paid_off;
         elsif i = "2" then
            return owned_but_not_yet_fully_paid_off_eg_with_a_mortgage;
         elsif i = "3" then
            return rented_as_part_of_employment_contract_of_household_member;
         elsif i = "4" then
            return rented_not_as_part_of_employment_contract_of_household_member;
         elsif i = "5" then
            return occupied_rent_free_as_part_of_employment_contract_of_household_member;
         elsif i = "6" then
            return occupied_rent_free_not_as_part_of_employment_contract_of_household_member;
         elsif i = "7" then
            return occupied_as_a_boarder_or_lodger;
         elsif i = "8" then
            return xother;
         elsif i = "9" then
            return unspecified;
        end if;
       Put_Line( "Convert_Tenure_Type failed to match code |" & i & "|" );
     return missing;
    end Convert_Tenure_Type;


    function Pretty_Print( i : Resultcode_Type ) return String is
    begin
         case i is
             when completed => return "Completed";
             when non_contact => return "Non-contact";
             when refused => return "Refused";
             when partly_complete => return "Partly complete";
             when no_usable_information_comment => return "No usable information  COMMENT!";
             when vacant_dwelling => return "Vacant dwelling ";
             when listing_error => return "Listing error";
             when xother => return "Other";
             when ended_at_question_b => return "Ended at question B";
             when missing => return "Null or Missing";
         end case;
    end Pretty_Print;

    function Convert_Resultcode_Type( i : String ) return Resultcode_Type is
    begin
         if i = "1" then
            return completed;
         elsif i = "2" then
            return non_contact;
         elsif i = "3" then
            return refused;
         elsif i = "4" then
            return partly_complete;
         elsif i = "5" then
            return no_usable_information_comment;
         elsif i = "6" then
            return vacant_dwelling;
         elsif i = "7" then
            return listing_error;
         elsif i = "8" then
            return xother;
         elsif i = "9" then
            return ended_at_question_b;
        end if;
        Put_Line( "Convert_Resultcode_Type: failed to match code |" & i & "|" );
        return missing;
    end Convert_Resultcode_Type;
    
    function To_String( rec : Person_Info ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & " ==========  Person_Info =========== " & LINE_BREAK;
      s := s & " uqno " & Sernum_Value'Image( rec.uqno ) & LINE_BREAK;
      s := s & " Personno " & Format( rec.Personno ) & LINE_BREAK;
      s := s & " Gender " & Pretty_Print( rec.Gender ) & LINE_BREAK;
      s := s & " Agegrp " & Pretty_Print( rec.agegrp ) & LINE_BREAK;
      s := s & " Popgrp " & Pretty_Print( rec.Popgrp ) & LINE_BREAK;
      s := s & " Week2_spentw2 " & Pretty_Print( rec.Week2_spentw2 ) & LINE_BREAK;
      s := s & " Week3_spentw3 " & Pretty_Print( rec.Week3_spentw3 ) & LINE_BREAK;
      s := s & " Week4_spentw4 " & Pretty_Print( rec.Week4_spentw4 ) & LINE_BREAK;
      s := s & " Week5_spentw5 " & Pretty_Print( rec.Week5_spentw5 ) & LINE_BREAK;
      s := s & " Q11a01srcinc " & Pretty_Print( rec.Q11a01srcinc ) & LINE_BREAK;
      s := s & " Q11a02srcinc " & Pretty_Print( rec.Q11a02srcinc ) & LINE_BREAK;
      s := s & " Q11a03srcinc " & Pretty_Print( rec.Q11a03srcinc ) & LINE_BREAK;
      s := s & " Q11a04srcinc " & Pretty_Print( rec.Q11a04srcinc ) & LINE_BREAK;
      s := s & " Q11a05srcinc " & Pretty_Print( rec.Q11a05srcinc ) & LINE_BREAK;
      s := s & " Q11a07srcinc " & Pretty_Print( rec.Q11a07srcinc ) & LINE_BREAK;
      s := s & " Q11a08srcinc " & Pretty_Print( rec.Q11a08srcinc ) & LINE_BREAK;
      s := s & " Q11a09srcinc " & Pretty_Print( rec.Q11a09srcinc ) & LINE_BREAK;
      s := s & " Q11a10srcinc " & Pretty_Print( rec.Q11a10srcinc ) & LINE_BREAK;
      s := s & " Q11a11srcinc " & Pretty_Print( rec.Q11a11srcinc ) & LINE_BREAK;
      s := s & " Q11a12srcinc " & Pretty_Print( rec.Q11a12srcinc ) & LINE_BREAK;
      s := s & " Q11a13srcinc " & Format( rec.Q11a13srcinc ) & LINE_BREAK;
      s := s & " Q12tobacco1 " & Pretty_Print( rec.Q12tobacco1 ) & LINE_BREAK;
      s := s & " Q12tobacco2 " & Pretty_Print( rec.Q12tobacco2 ) & LINE_BREAK;
      s := s & " Q12tobacco3 " & Pretty_Print( rec.Q12tobacco3 ) & LINE_BREAK;
      s := s & " Tobacco4 " & Pretty_Print( rec.Tobacco4 ) & LINE_BREAK;
      s := s & " Tobacco5 " & Pretty_Print( rec.Tobacco5 ) & LINE_BREAK;
      s := s & " Q13read " & Pretty_Print( rec.Q13read ) & LINE_BREAK;
      s := s & " Q14write " & Pretty_Print( rec.Q14write ) & LINE_BREAK;
      s := s & " Q15higheduc " & Pretty_Print( rec.Q15higheduc ) & LINE_BREAK;
      s := s & " Weight " & Format( rec.Weight ) & LINE_BREAK;
      return To_String( s );
    end To_String;
    
    function To_String( rec : Supported_Persons ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & " ========== Supported_Persons =========== " & LINE_BREAK;
      s := s & " uqno " & Sernum_Value'Image( rec.uqno ) & LINE_BREAK;
      s := s & " Personsupported " & Format( rec.Personsupported ) & LINE_BREAK;
      s := s & " Agegrp " & Pretty_Print( rec.agegrp ) & LINE_BREAK;
      s := s & " Q19dwelltype " & Pretty_Print( rec.Q19dwelltype ) & LINE_BREAK;
      s := s & " Q110gender " & Pretty_Print( rec.Q110gender ) & LINE_BREAK;
      s := s & " Q112popgroup " & Pretty_Print( rec.Q112popgroup ) & LINE_BREAK;
      s := s & " Q113support1 " & Pretty_Print( rec.Q113support1 ) & LINE_BREAK;
      s := s & " Q113support2 " & Pretty_Print( rec.Q113support2 ) & LINE_BREAK;
      s := s & " Q113support3 " & Pretty_Print( rec.Q113support3 ) & LINE_BREAK;
      s := s & " Q113support4 " & Pretty_Print( rec.Q113support4 ) & LINE_BREAK;
      s := s & " Q113support5 " & Pretty_Print( rec.Q113support5 ) & LINE_BREAK;
      s := s & " Q113support6 " & Pretty_Print( rec.Q113support6 ) & LINE_BREAK;
      s := s & " Q113support7 " & Pretty_Print( rec.Q113support7 ) & LINE_BREAK;
      s := s & " Q113support8 " & Pretty_Print( rec.Q113support8 ) & LINE_BREAK;
      s := s & " Q113support9 " & Pretty_Print( rec.Q113support9 ) & LINE_BREAK;
      s := s & " Q114finaid " & Format( rec.Q114finaid ) & LINE_BREAK;
      s := s & " Q115moneyuse1 " & Pretty_Print( rec.Q115moneyuse1 ) & LINE_BREAK;
      s := s & " Q115moneyuse2 " & Pretty_Print( rec.Q115moneyuse2 ) & LINE_BREAK;
      s := s & " Q115moneyuse3 " & Pretty_Print( rec.Q115moneyuse3 ) & LINE_BREAK;
      s := s & " Q115moneyuse4 " & Pretty_Print( rec.Q115moneyuse4 ) & LINE_BREAK;
      s := s & " Q115moneyuse5 " & Pretty_Print( rec.Q115moneyuse5 ) & LINE_BREAK;
      s := s & " Q115moneyuse6 " & Pretty_Print( rec.Q115moneyuse6 ) & LINE_BREAK;
      s := s & " Q115moneyuse7 " & Pretty_Print( rec.Q115moneyuse7 ) & LINE_BREAK;
      s := s & " Q115moneyuse8 " & Pretty_Print( rec.Q115moneyuse8 ) & LINE_BREAK;
      s := s & " Q115moneyuse9 " & Pretty_Print( rec.Q115moneyuse9 ) & LINE_BREAK;
      s := s & " Q115moneyuse10 " & Pretty_Print( rec.Q115moneyuse10 ) & LINE_BREAK;
      s := s & " Q115moneyuse11 " & Pretty_Print( rec.Q115moneyuse11 ) & LINE_BREAK;
      return To_String( s );
    end To_String;
    
    function To_String( rec : Purchase_Place ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & " ========== Purchase_Place =========== " & LINE_BREAK;
      s := s & " uqno " & Sernum_Value'Image( rec.uqno ) & LINE_BREAK;
      s := s & " Prodcode " & Format( rec.Prodcode ) & LINE_BREAK;
      s := s & " Q21aareapurch " & Pretty_Print( rec.Q21aareapurch ) & LINE_BREAK;
      s := s & " Q21btyperetailer " & Pretty_Print( rec.Q21btyperetailer ) & LINE_BREAK;
      return To_String( s );
    end To_String;
    
    function To_String( rec : Person_Income ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & " ========== Person_Income =========== " & LINE_BREAK;
      s := s & " uqno " & Sernum_Value'Image( rec.uqno ) & LINE_BREAK;
      s := s & " Personno " & Format( rec.Personno ) & LINE_BREAK;
      s := s & " Coicop " & Pretty_Print( rec.Coicop ) & LINE_BREAK;
      s := s & " Value " & Format( rec.Value ) & LINE_BREAK;
      s := s & " Weight " & Format( rec.Weight ) & LINE_BREAK;
      return To_String( s );
    end To_String;
    
    function To_String( rec : Total_IES ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & " ========== Total_IES =========== " & LINE_BREAK;
      s := s & " uqno " & Sernum_Value'Image( rec.uqno ) & LINE_BREAK;
      s := s & "Coicop " & Pretty_Print( rec.Coicop ) & LINE_BREAK;
      s := s & " Valuemain " & Format( rec.Valuemain ) & LINE_BREAK;
      s := s & " Valuediary " & Format( rec.Valuediary ) & LINE_BREAK;
      s := s & " Value " & Format( rec.Value ) & LINE_BREAK;
      s := s & " Valuemainannualized " & Format( rec.Valuemainannualized ) & LINE_BREAK;
      s := s & " ValueDiaryannualized " & Format( rec.ValueDiaryannualized ) & LINE_BREAK;
      s := s & " Valueannualized " & Format( rec.Valueannualized ) & LINE_BREAK;
      s := s & " Weight " & Format( rec.Weight ) & LINE_BREAK;
      return To_String( s );
    end To_String;
    
    
    function To_String( rec : House_Info ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & " ========== House_Info =========== " & LINE_BREAK;
      s := s & " uqno " & Sernum_Value'Image( rec.uqno ) & LINE_BREAK;
      s := s & " Prov " & Pretty_Print( rec.Prov ) & LINE_BREAK;
      s := s & " Settlement " & Pretty_Print( rec.Settlement ) & LINE_BREAK;
      s := s & " Surveyyear " & Format( rec.Surveyyear ) & LINE_BREAK;
      s := s & " Surveymonth " & Pretty_Print( rec.Surveymonth ) & LINE_BREAK;
      s := s & " Hsize " & Format( rec.Hsize ) & LINE_BREAK;
      s := s & " Popgrpofhead " & Pretty_Print( rec.Popgrpofhead ) & LINE_BREAK;
      s := s & " Genderofhead " & Pretty_Print( rec.Genderofhead ) & LINE_BREAK;
      s := s & " Q16support " & Pretty_Print( rec.Q16support ) & LINE_BREAK;
      s := s & " Q17numsupport " & Format( rec.Q17numsupport ) & LINE_BREAK;
      s := s & " Q31dwelltypemain " & Pretty_Print( rec.Q31dwelltypemain ) & LINE_BREAK;
      s := s & " Q31dwelltypeoth " & Pretty_Print( rec.Q31dwelltypeoth ) & LINE_BREAK;
      s := s & " Q32materialwalls " & Pretty_Print( rec.Q32materialwalls ) & LINE_BREAK;
      s := s & " Q32materialroof " & Pretty_Print( rec.Q32materialroof ) & LINE_BREAK;
      s := s & " Q33govgrant " & Pretty_Print( rec.Q33govgrant ) & LINE_BREAK;
      s := s & " Q35typetoilet " & Pretty_Print( rec.Q35typetoilet ) & LINE_BREAK;
      s := s & " Q36sharetoilet " & Pretty_Print( rec.Q36sharetoilet ) & LINE_BREAK;
      s := s & " Q37streetlight " & Pretty_Print( rec.Q37streetlight ) & LINE_BREAK;
      s := s & " Q38elecsupply " & Pretty_Print( rec.Q38elecsupply ) & LINE_BREAK;
      s := s & " Q39energycook " & Pretty_Print( rec.Q39energycook ) & LINE_BREAK;
      s := s & " Q39energyheat " & Pretty_Print( rec.Q39energyheat ) & LINE_BREAK;
      s := s & " Q39energylight " & Pretty_Print( rec.Q39energylight ) & LINE_BREAK;
      s := s & " Q310refuse " & Pretty_Print( rec.Q310refuse ) & LINE_BREAK;
      s := s & " Radio " & Pretty_Print( rec.Radio ) & LINE_BREAK;
      s := s & " Stereo_hifi " & Pretty_Print( rec.Stereo_hifi ) & LINE_BREAK;
      s := s & " Tape_recorder " & Pretty_Print( rec.Tape_recorder ) & LINE_BREAK;
      s := s & " Television " & Pretty_Print( rec.Television ) & LINE_BREAK;
      s := s & " Video_cassette_recorder_dvd " & Pretty_Print( rec.Video_cassette_recorder_dvd ) & LINE_BREAK;
      s := s & " Refrigerator_freezer " & Pretty_Print( rec.Refrigerator_freezer ) & LINE_BREAK;
      s := s & " Stove_gas_or_electric " & Pretty_Print( rec.Stove_gas_or_electric ) & LINE_BREAK;
      s := s & " Microwave " & Pretty_Print( rec.Microwave ) & LINE_BREAK;
      s := s & " Washing_machine " & Pretty_Print( rec.Washing_machine ) & LINE_BREAK;
      s := s & " Motor_vehicle " & Pretty_Print( rec.Motor_vehicle ) & LINE_BREAK;
      s := s & " Motor_cycle_scooter " & Pretty_Print( rec.Motor_cycle_scooter ) & LINE_BREAK;
      s := s & " Sewing_knitting_machine " & Pretty_Print( rec.Sewing_knitting_machine ) & LINE_BREAK;
      s := s & " Donkey_cart_ox_cart " & Pretty_Print( rec.Donkey_cart_ox_cart ) & LINE_BREAK;
      s := s & " Plough " & Pretty_Print( rec.Plough ) & LINE_BREAK;
      s := s & " Tractor " & Pretty_Print( rec.Tractor ) & LINE_BREAK;
      s := s & " Wheelbarrow " & Pretty_Print( rec.Wheelbarrow ) & LINE_BREAK;
      s := s & " Grinding_mill " & Pretty_Print( rec.Grinding_mill ) & LINE_BREAK;
      s := s & " Bicycle " & Pretty_Print( rec.Bicycle ) & LINE_BREAK;
      s := s & " Computer " & Pretty_Print( rec.Computer ) & LINE_BREAK;
      s := s & " Canoe_boat " & Pretty_Print( rec.Canoe_boat ) & LINE_BREAK;
      s := s & " Motorboat " & Pretty_Print( rec.Motorboat ) & LINE_BREAK;
      s := s & " Camera " & Pretty_Print( rec.Camera ) & LINE_BREAK;
      s := s & " Bed " & Pretty_Print( rec.Bed ) & LINE_BREAK;
      s := s & " Cellular_telephone " & Pretty_Print( rec.Cellular_telephone ) & LINE_BREAK;
      s := s & " Landline_telephone " & Pretty_Print( rec.Landline_telephone ) & LINE_BREAK;
      s := s & " Satellite_dish " & Pretty_Print( rec.Satellite_dish ) & LINE_BREAK;
      s := s & " Internet " & Pretty_Print( rec.Internet ) & LINE_BREAK;
      s := s & " Q41aoccrooms " & Format( rec.Q41aoccrooms ) & LINE_BREAK;
      s := s & " Q41anorooms " & Format( rec.Q41anorooms ) & LINE_BREAK;
      s := s & " Q41boccrooms " & Format( rec.Q41boccrooms ) & LINE_BREAK;
      s := s & " Q41bnorooms " & Format( rec.Q41bnorooms ) & LINE_BREAK;
      s := s & " Q41coccrooms " & Format( rec.Q41coccrooms ) & LINE_BREAK;
      s := s & " Q41cnorooms " & Format( rec.Q41cnorooms ) & LINE_BREAK;
      s := s & " Q41dnorooms " & Format( rec.Q41dnorooms ) & LINE_BREAK;
      s := s & " Q41eoccrooms " & Format( rec.Q41eoccrooms ) & LINE_BREAK;
      s := s & " Q41enorooms " & Format( rec.Q41enorooms ) & LINE_BREAK;
      s := s & " Q41foccrooms " & Format( rec.Q41foccrooms ) & LINE_BREAK;
      s := s & " Q41fnorooms " & Format( rec.Q41fnorooms ) & LINE_BREAK;
      s := s & " Q42nocars " & Format( rec.Q42nocars ) & LINE_BREAK;
      s := s & " Q44value " & Format( rec.Q44value ) & LINE_BREAK;
      s := s & " Q44valueimputed " & Format( rec.Q44valueimputed ) & LINE_BREAK;
      s := s & " Q45ownrent " & Pretty_Print( rec.Q45ownrent ) & LINE_BREAK;
      s := s & " Q41totoccrooms " & Format( rec.Q41totoccrooms ) & LINE_BREAK;
      s := s & " Q41totnorooms " & Format( rec.Q41totnorooms ) & LINE_BREAK;
      s := s & " Consumptions " & Format( rec.Consumptions ) & LINE_BREAK;
      s := s & " Inkindconsumptions " & Format( rec.Inkindconsumptions ) & LINE_BREAK;
      s := s & " Income " & Format( rec.Income ) & LINE_BREAK;
      s := s & " Inkindincome " & Format( rec.Inkindincome ) & LINE_BREAK;
      s := s & " Resultcode " & Pretty_Print( rec.Resultcode ) & LINE_BREAK;
      s := s & " Weight " & Format( rec.Weight ) & LINE_BREAK; 
      s := s & " ==================== " & LINE_BREAK;
      return To_String( s );
    end To_String;
    
    function To_String( pers : Person_Rec ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
    begin
      s := s & To_String( pers.info );
      for i in pers.person_income'Range loop
         if( pers.person_income( i ).uqno /= Sernum_Value'First ) then
            s := s & To_String( pers.person_income( i ) );
         end if;
      end loop;
      return To_String( s );
    end To_String;
    
   function To_String( hh : Household ) return String is
      use Ada.Strings.Unbounded;
      use Text_Utils;
      s : Unbounded_String;
   begin
      s := s & " ========== Household =========== " & LINE_BREAK;
      s := s & To_String( hh.housing );
      for p in Person_Range'Range loop
         if( hh.person( p ).info.uqno /= Sernum_Value'First ) then
            s := s & " ========= PERSON " & Person_Range'Image( p ) & "==========" & LINE_BREAK;
            s := s & To_String( hh.person( p ));
         end if;
      end loop;
      s := s & " ====== EXPENDITURE ========= " & LINE_BREAK;
      for p in hh.expenditure_and_income'Range loop
         if( hh.expenditure_and_income( p ).uqno /= Sernum_Value'First ) then
            s := s & To_String( hh.expenditure_and_income( p ) );
         end if;
      end loop;
      s := s & " ====== SUPPORTED PEOPLE ========= " & LINE_BREAK;
      for p in hh.supported'Range loop
         if( hh.supported( p ).uqno /= Sernum_Value'First ) then
            s := s & To_String( hh.supported( p ) );
         end if;
      end loop;
      s := s & " ====== PLACE OF PURCHASE ========= " & LINE_BREAK;
      for p in hh.place_of_purchase'Range loop
         if( hh.place_of_purchase( p ).uqno /= Sernum_Value'First ) then
            s := s & To_String( hh.place_of_purchase( p ) );
         end if;
      end loop;
      return To_String( s );
   end To_String;
    
end ZA.IES;
 
