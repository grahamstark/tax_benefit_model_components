--
--  $Author: graham_s $
--  $Date: 2008-12-18 23:18:00 +0000 (Thu, 18 Dec 2008) $
--  $Revision: 6512 $
--
pragma License( Modified_GPL );

with Ada.Exceptions;
with Ada.Text_IO;

package body ZA_Enums is
 
   use Ada.Exceptions;
   use Ada.Text_IO;
   ABORT_ON_ERROR : constant Boolean := False;
   
   function Pretty_Print( i : Ownship_Type ) return String is
   begin
      case i is
         when site_and_dwelling_fully_paid_off => return "Site & dwelling fully paid off";
         when site => return "Site";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Ownship_Type( i : Integer ) return Ownship_Type is
   begin
      case i is 
         when 1 => return site_and_dwelling_fully_paid_off;
         when 2 => return site;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Ownship_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Ownship_Type");
             end if;
      end case;
      return missing;
   end Convert_Ownship_Type;

   function Pretty_Print( i : Matroof_Type ) return String is
   begin
      case i is
         when cocrete => return "Cocrete";
         when prefab => return "Prefab";
         when zink => return "Zink";
         when wood => return "Wood";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Matroof_Type( i : Integer ) return Matroof_Type is
   begin
      case i is 
         when 2 => return cocrete;
         when 3 => return prefab;
         when 4 => return zink;
         when 5 => return wood;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Matroof_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Matroof_Type");
             end if;
      end case;
      return missing;
   end Convert_Matroof_Type;

   function Pretty_Print( i : Matwall_Type ) return String is
   begin
      case i is
         when bricks => return "Bricks";
         when concrete => return "Concrete";
         when prefab => return "Prefab";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Matwall_Type( i : Integer ) return Matwall_Type is
   begin
      case i is 
         when 1 => return bricks;
         when 2 => return concrete;
         when 3 => return prefab;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Matwall_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Matwall_Type");
             end if;
      end case;
      return missing;
   end Convert_Matwall_Type;

   function Pretty_Print( i : Watsourc_Type ) return String is
   begin
      case i is
         when running_tap_in_dwe => return "Running tap in dwe";
         when running_tap_on_site => return "Running tap on site";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Watsourc_Type( i : Integer ) return Watsourc_Type is
   begin
      case i is 
         when 1 => return running_tap_in_dwe;
         when 2 => return running_tap_on_site;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Watsourc_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Watsourc_Type");
             end if;
      end case;
      return missing;
   end Convert_Watsourc_Type;

   function Pretty_Print( i : Watmain_Type ) return String is
   begin
      case i is
         when running_tap_in_dwe => return "Running tap in dwe";
         when running_tap_on_site => return "Running tap on site";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Watmain_Type( i : Integer ) return Watmain_Type is
   begin
      case i is 
         when 1 => return running_tap_in_dwe;
         when 2 => return running_tap_on_site;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Watmain_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Watmain_Type");
             end if;
      end case;
      return missing;
   end Convert_Watmain_Type;

   function Pretty_Print( i : Watadeq_Type ) return String is
   begin
      case i is
         when always_adequate => return "Always adequate";
         when mostly_yes => return "Mostly yes";
         when mostly_not => return "Mostly not";
         when no => return "No";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Watadeq_Type( i : Integer ) return Watadeq_Type is
   begin
      case i is 
         when 1 => return always_adequate;
         when 2 => return mostly_yes;
         when 3 => return mostly_not;
         when 4 => return no;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Watadeq_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Watadeq_Type");
             end if;
      end case;
      return missing;
   end Convert_Watadeq_Type;

   function Pretty_Print( i : Watkm_Type ) return String is
   begin
      case i is
         when lt_100m => return "<100m";
         when v_100_200m => return "100-200m";
         when v_200_500m => return "200-500m";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Watkm_Type( i : Integer ) return Watkm_Type is
   begin
      case i is 
         when 1 => return lt_100m;
         when 2 => return v_100_200m;
         when 3 => return v_200_500m;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Watkm_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Watkm_Type");
             end if;
      end case;
      return missing;
   end Convert_Watkm_Type;

   function Pretty_Print( i : Yes_No_Sometimes_Type ) return String is
   begin
      case i is
         when yes => return "Yes";
         when no => return "No";
         when sometimes => return "Sometimes";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Yes_No_Sometimes_Type( i : Integer ) return Yes_No_Sometimes_Type is
   begin
      case i is 
         when 1 => return yes;
         when 2 => return no;
         when 3 => return sometimes;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Yes_No_Sometimes_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Yes_No_Sometimes_Type");
             end if;
      end case;
      return missing;
   end Convert_Yes_No_Sometimes_Type;

   function Pretty_Print( i : Fwoods_Type ) return String is
   begin
      case i is
         when woodlot => return "Woodlot";
         when commercial_plantations => return "Commercial plantations";
         when indegenous => return "Indegenous";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Fwoods_Type( i : Integer ) return Fwoods_Type is
   begin
      case i is 
         when 1 => return woodlot;
         when 2 => return commercial_plantations;
         when 3 => return indegenous;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Fwoods_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Fwoods_Type");
             end if;
      end case;
      return missing;
   end Convert_Fwoods_Type;

   function Pretty_Print( i : Fwoodad_Type ) return String is
   begin
      case i is
         when always => return "Always";
         when mostly_yes => return "Mostly yes";
         when mostly_no => return "Mostly no";
         when no => return "No";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Fwoodad_Type( i : Integer ) return Fwoodad_Type is
   begin
      case i is 
         when 1 => return always;
         when 2 => return mostly_yes;
         when 3 => return mostly_no;
         when 4 => return no;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Fwoodad_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Fwoodad_Type");
             end if;
      end case;
      return missing;
   end Convert_Fwoodad_Type;

   function Pretty_Print( i : Fwoodkm_Type ) return String is
   begin
      case i is
         when lt_100m => return "<100m";
         when v_100_200m => return "100-200m";
         when v_200_1km => return "200-1km";
         when gt_1km => return ">1km";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Fwoodkm_Type( i : Integer ) return Fwoodkm_Type is
   begin
      case i is 
         when 1 => return lt_100m;
         when 2 => return v_100_200m;
         when 3 => return v_200_1km;
         when 4 => return gt_1km;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Fwoodkm_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Fwoodkm_Type");
             end if;
      end case;
      return missing;
   end Convert_Fwoodkm_Type;

   function Pretty_Print( i : Toilkm_Type ) return String is
   begin
      case i is
         when lt_25m => return "<25m";
         when v_25_50m => return "25-50m";
         when v_51_100m => return "51-100m";
         when gt_100m => return ">100m";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Toilkm_Type( i : Integer ) return Toilkm_Type is
   begin
      case i is 
         when 1 => return lt_25m;
         when 2 => return v_25_50m;
         when 3 => return v_51_100m;
         when 4 => return gt_100m;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Toilkm_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Toilkm_Type");
             end if;
      end case;
      return missing;
   end Convert_Toilkm_Type;

   function Pretty_Print( i : Refdisp_Type ) return String is
   begin
      case i is
         when removed_by_local_authority => return "Removed by local authority";
         when communal => return "Communal";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Refdisp_Type( i : Integer ) return Refdisp_Type is
   begin
      case i is 
         when 1 => return removed_by_local_authority;
         when 2 => return communal;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Refdisp_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Refdisp_Type");
             end if;
      end case;
      return missing;
   end Convert_Refdisp_Type;

   function Pretty_Print( i : Reffreq_Type ) return String is
   begin
      case i is
         when v_1_week => return "1 week";
         when fortnight => return "Fortnight";
         when month => return "Month";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Reffreq_Type( i : Integer ) return Reffreq_Type is
   begin
      case i is 
         when 1 => return v_1_week;
         when 2 => return fortnight;
         when 3 => return month;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Reffreq_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Reffreq_Type");
             end if;
      end case;
      return missing;
   end Convert_Reffreq_Type;

   function Pretty_Print( i : Telkm_Type ) return String is
   begin
      case i is
         when lt_100m => return "<100m";
         when v_100_200m => return "100-200m";
         when v_200_1km => return "200-1km";
         when v_1_km => return "1-km";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Telkm_Type( i : Integer ) return Telkm_Type is
   begin
      case i is 
         when 1 => return lt_100m;
         when 2 => return v_100_200m;
         when 3 => return v_200_1km;
         when 4 => return v_1_km;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Telkm_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Telkm_Type");
             end if;
      end case;
      return missing;
   end Convert_Telkm_Type;

   function Pretty_Print( i : Landirs_Type ) return String is
   begin
      case i is
         when river => return "River";
         when spring => return "Spring";
         when dam_on_land => return "Dam/on land";
         when other_dam => return "Other dam";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Landirs_Type( i : Integer ) return Landirs_Type is
   begin
      case i is 
         when 1 => return river;
         when 2 => return spring;
         when 3 => return dam_on_land;
         when 4 => return other_dam;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Landirs_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Landirs_Type");
             end if;
      end case;
      return missing;
   end Convert_Landirs_Type;

   function Pretty_Print( i : Trus_Type ) return String is
   begin
      case i is
         when river => return "River";
         when spring => return "Spring";
         when dam_on_land => return "Dam/on land";
         when other_dam => return "Other dam";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Trus_Type( i : Integer ) return Trus_Type is
   begin
      case i is 
         when 1 => return river;
         when 2 => return spring;
         when 3 => return dam_on_land;
         when 4 => return other_dam;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Trus_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Trus_Type");
             end if;
      end case;
      return missing;
   end Convert_Trus_Type;

   function Pretty_Print( i : Safeout_Type ) return String is
   begin
      case i is
         when very_safe => return "Very safe";
         when rather_safe => return "Rather safe";
         when rather => return "Rather";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Safeout_Type( i : Integer ) return Safeout_Type is
   begin
      case i is 
         when 1 => return very_safe;
         when 2 => return rather_safe;
         when 3 => return rather;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Safeout_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Safeout_Type");
             end if;
      end case;
      return missing;
   end Convert_Safeout_Type;

   function Pretty_Print( i : Safein_Type ) return String is
   begin
      case i is
         when very_safe => return "Very safe";
         when rather_safe => return "Rather safe";
         when rather => return "Rather";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Safein_Type( i : Integer ) return Safein_Type is
   begin
      case i is 
         when 1 => return very_safe;
         when 2 => return rather_safe;
         when 3 => return rather;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Safein_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Safein_Type");
             end if;
      end case;
      return missing;
   end Convert_Safein_Type;

   function Pretty_Print( i : Safeprev_Type ) return String is
   begin
      case i is
         when safer => return "Safer";
         when same => return "Same";
         when less_safe => return "Less safe";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Safeprev_Type( i : Integer ) return Safeprev_Type is
   begin
      case i is 
         when 1 => return safer;
         when 2 => return same;
         when 3 => return less_safe;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Safeprev_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Safeprev_Type");
             end if;
      end case;
      return missing;
   end Convert_Safeprev_Type;

   function Pretty_Print( i : Crime_Type ) return String is
   begin
      case i is
         when assault => return "Assault";
         when robbery => return "Robbery";
         when rape => return "Rape";
         when murder => return "Murder";
         when abduction => return "Abduction";
         when other => return "Other";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Crime_Type( i : Integer ) return Crime_Type is
   begin
      case i is 
         when 1 => return assault;
         when 2 => return robbery;
         when 3 => return rape;
         when 4 => return murder;
         when 5 => return abduction;
         when 6 => return other;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Crime1_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Crime1_Type");
             end if;
      end case;
      return missing;
   end Convert_Crime_Type;


   function Pretty_Print( i : Pollute_Type ) return String is
   begin
      case i is
         when very_difficult => return "Very difficult";
         when difficult => return "Difficult";
         when slightly => return "Slightly";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Pollute_Type( i : Integer ) return Pollute_Type is
   begin
      case i is 
         when 1 => return very_difficult;
         when 2 => return difficult;
         when 3 => return slightly;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Pollute_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Pollute_Type");
             end if;
      end case;
      return missing;
   end Convert_Pollute_Type;

   function Pretty_Print( i : Feedab_Type ) return String is
   begin
      case i is
         when yes => return "Yes";
         when no => return "No";
         when not_applicable => return "Not applicable";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Feedab_Type( i : Integer ) return Feedab_Type is
   begin
      case i is 
         when 1 => return yes;
         when 2 => return no;
         when 3 => return not_applicable;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Feedab_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Feedab_Type");
             end if;
      end case;
      return missing;
   end Convert_Feedab_Type;

   function Pretty_Print( i : Satisf_Type ) return String is
   begin
      case i is
         when very_satisfied => return "Very satisfied";
         when satisfied => return "Satisfied";
         when neither => return "Neither";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Satisf_Type( i : Integer ) return Satisf_Type is
   begin
      case i is 
         when 1 => return very_satisfied;
         when 2 => return satisfied;
         when 3 => return neither;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Satisf_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Satisf_Type");
             end if;
      end case;
      return missing;
   end Convert_Satisf_Type;

   function Pretty_Print( i : Compliv_Type ) return String is
   begin
      case i is
         when things_are_better => return "Things are better";
         when worse => return "Worse";
         when neither => return "Neither";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Compliv_Type( i : Integer ) return Compliv_Type is
   begin
      case i is 
         when 1 => return things_are_better;
         when 2 => return worse;
         when 3 => return neither;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Compliv_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Compliv_Type");
             end if;
      end case;
      return missing;
   end Convert_Compliv_Type;

   function Pretty_Print( i : Reashead_Type ) return String is
   begin
      case i is
         when employment => return "Employment";
         when business => return "Business";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Reashead_Type( i : Integer ) return Reashead_Type is
   begin
      case i is 
         when 1 => return employment;
         when 2 => return business;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Reashead_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Reashead_Type");
             end if;
      end case;
      return missing;
   end Convert_Reashead_Type;

   function Pretty_Print( i : Medsour_Type ) return String is
   begin
      case i is
         when public_hospital => return "Public hospital";
         when public_clinic => return "Public clinic";
         when other_public => return "Other public";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Medsour_Type( i : Integer ) return Medsour_Type is
   begin
      case i is 
         when 1 => return public_hospital;
         when 2 => return public_clinic;
         when 3 => return other_public;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Medsour_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Medsour_Type");
             end if;
      end case;
      return missing;
   end Convert_Medsour_Type;

   function Pretty_Print( i : Medkm_Type ) return String is
   begin
      case i is
         when lt_1km => return "<1km";
         when v_1_5km => return "1-5km";
         when gt_5km => return ">5km";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Medkm_Type( i : Integer ) return Medkm_Type is
   begin
      case i is 
         when 1 => return lt_1km;
         when 2 => return v_1_5km;
         when 3 => return gt_5km;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Medkm_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Medkm_Type");
             end if;
      end case;
      return missing;
   end Convert_Medkm_Type;

   function Pretty_Print( i : Medtime_Type ) return String is
   begin
      case i is
         when v_1_4_hour => return "1/4 hour";
         when v_1_2_hour => return "1/2 hour";
         when v_1_hour => return "1 hour";
         when gt_1_hour => return ">1 hour";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Medtime_Type( i : Integer ) return Medtime_Type is
   begin
      case i is 
         when 1 => return v_1_4_hour;
         when 2 => return v_1_2_hour;
         when 3 => return v_1_hour;
         when 4 => return gt_1_hour;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Medtime_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Medtime_Type");
             end if;
      end case;
      return missing;
   end Convert_Medtime_Type;

   function Pretty_Print( i : Province_Type ) return String is
   begin
      case i is
         when western_cape => return "Western cape";
         when eastern_cape => return "Eastern cape";
         when northern_cape => return "Northern cape";
         when free_state => return "Free state";
         when kwazulu_natal => return "Kwazulu- natal";
         when north_west => return "North west";
         when gauteng => return "Gauteng";
         when mpumalanga => return "Mpumalanga";
         when northern_province => return "Northern province";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Province_Type( i : Integer ) return Province_Type is
   begin
      case i is 
         when 1 => return western_cape;
         when 2 => return eastern_cape;
         when 3 => return northern_cape;
         when 4 => return free_state;
         when 5 => return kwazulu_natal;
         when 6 => return north_west;
         when 7 => return gauteng;
         when 8 => return mpumalanga;
         when 9 => return northern_province;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Province_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Province_Type");
             end if;
      end case;
      return missing;
   end Convert_Province_Type;

   function Pretty_Print( i : Welfkm_Type ) return String is
   begin
      case i is
         when lt_1km => return "<1km";
         when v_1_5km => return "1-5km";
         when gt_5km => return ">5km";
         when dont => return "Don't";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Welfkm_Type( i : Integer ) return Welfkm_Type is
   begin
      case i is 
         when 1 => return lt_1km;
         when 2 => return v_1_5km;
         when 3 => return gt_5km;
         when 4 => return dont;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Welfkm_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Welfkm_Type");
             end if;
      end case;
      return missing;
   end Convert_Welfkm_Type;

   function Pretty_Print( i : Relate_Type ) return String is
   begin
      case i is
         when head_of_hh => return "Head of hh";
         when spouse => return "Spouse";
         when son_daughter => return "Son/daughter";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Relate_Type( i : Integer ) return Relate_Type is
   begin
      case i is 
         when 1 => return head_of_hh;
         when 2 => return spouse;
         when 3 => return son_daughter;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Relate_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Relate_Type");
             end if;
      end case;
      return missing;
   end Convert_Relate_Type;

   function Pretty_Print( i : Mstate_Type ) return String is
   begin
      case i is
         when never_married => return "Never married";
         when civil_married => return "Civil married";
         when traditional_married => return "Traditional married";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Mstate_Type( i : Integer ) return Mstate_Type is
   begin
      case i is 
         when 1 => return never_married;
         when 2 => return civil_married;
         when 3 => return traditional_married;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Mstate_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Mstate_Type");
             end if;
      end case;
      return missing;
   end Convert_Mstate_Type;

   function Pretty_Print( i : Gender_Type ) return String is
   begin
      case i is
         when male => return "Male";
         when female => return "Female";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Gender_Type( i : Integer ) return Gender_Type is
   begin
      case i is 
         when 1 => return male;
         when 2 => return female;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Gender_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Gender_Type");
             end if;
      end case;
      return missing;
   end Convert_Gender_Type;

   function Pretty_Print( i : Dwe_Type ) return String is
   begin
      case i is
         when formal => return "Formal";
         when traditional => return "Traditional";
         when flat => return "Flat";
         when townhouse => return "Townhouse";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Dwe_Type( i : Integer ) return Dwe_Type is
   begin
      case i is 
         when 1 => return formal;
         when 2 => return traditional;
         when 3 => return flat;
         when 4 => return townhouse;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Dwe_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Dwe_Type");
             end if;
      end case;
      return missing;
   end Convert_Dwe_Type;

   function Pretty_Print( i : Loc_Type ) return String is
   begin
      case i is
         when urban => return "Urban";
         when rural => return "Rural";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Loc_Type( i : Integer ) return Loc_Type is
   begin
      case i is 
         when 1 => return urban;
         when 2 => return rural;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Loc_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Loc_Type");
             end if;
      end case;
      return missing;
   end Convert_Loc_Type;

   function Pretty_Print( i : Race_Type ) return String is
   begin
      case i is
         when African => return "African";
         when Coloured => return "Coloured";
         when Indian => return "Indian";
         when White => return "White";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Race_Type( i : Integer ) return Race_Type is
   begin
      case i is 
         when 1 => return African;
         when 2 => return Coloured;
         when 3 => return Indian;
         when 4 => return White;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Race_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Race_Type");
             end if;
      end case;
      return missing;
   end Convert_Race_Type;

   function Pretty_Print( i : Predw_Type ) return String is
   begin
      case i is
         when formal => return "Formal";
         when backyard => return "Backyard";
         when squatter => return "Squatter";
         when hostel => return "Hostel";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Predw_Type( i : Integer ) return Predw_Type is
   begin
      case i is 
         when 1 => return formal;
         when 2 => return backyard;
         when 3 => return squatter;
         when 4 => return hostel;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Predw_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Predw_Type");
             end if;
      end case;
      return missing;
   end Convert_Predw_Type;

   function Pretty_Print( i : Edreas_Type ) return String is
   begin
      case i is
         when no_money => return "No money";
         when distance => return "Distance";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Edreas_Type( i : Integer ) return Edreas_Type is
   begin
      case i is 
         when 1 => return no_money;
         when 2 => return distance;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Edreas_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Edreas_Type");
             end if;
      end case;
      return missing;
   end Convert_Edreas_Type;

   function Pretty_Print( i : Conspla_Type ) return String is
   begin
      case i is
         when public_hospital => return "Public hospital";
         when public_clinic => return "Public clinic";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Conspla_Type( i : Integer ) return Conspla_Type is
   begin
      case i is 
         when 1 => return public_hospital;
         when 2 => return public_clinic;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Conspla_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Conspla_Type");
             end if;
      end case;
      return missing;
   end Convert_Conspla_Type;

   function Pretty_Print( i : Disab1_Type ) return String is
   begin
      case i is
         when none => return "None";
         when sight => return "Sight";
         when hearing => return "Hearing";
         when physical => return "Physical";
         when mental => return "Mental";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Disab1_Type( i : Integer ) return Disab1_Type is
   begin
      case i is 
         when 1 => return none;
         when 2 => return sight;
         when 3 => return hearing;
         when 4 => return physical;
         when 5 => return mental;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Disab1_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Disab1_Type");
             end if;
      end case;
      return missing;
   end Convert_Disab1_Type;

   function Pretty_Print( i : Edcat_Type ) return String is
   begin
      case i is
         when no_school => return "No school";
         when prima => return "Prima";
         when sec => return "Sec";
         when matric => return "Matric";
         when no_matr_plus_dip => return "No matr+dip";
         when mat_plus_d => return "Mat+d";
         when univ => return "Univ";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Edcat_Type( i : Integer ) return Edcat_Type is
   begin
      case i is 
         when 0 => return no_school;
         when 1 => return prima;
         when 2 => return sec;
         when 3 => return matric;
         when 4 => return no_matr_plus_dip;
         when 5 => return mat_plus_d;
         when 6 => return univ;
         --  when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Edcat_Type");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Edcat_Type");
             end if;
      end case;
      return missing;
   end Convert_Edcat_Type;

   function Pretty_Print( i : Expenditure_Type ) return String is
   begin
      case i is
         when housm => return "Expenditure on housing/month";
         when housy => return "Expenditure on housing/year";
         when domwag => return "Expenditure on domestic wages";
         when cereal => return "Expenditure on cereal products";
         when meat => return "Expenditure on meat";
         when fish => return "Expenditure on fish";
         when fats => return "Expenditure on butter/fata/oils/margarine ";
         when milk => return "Expenditure on milk";
         when veg => return "Expenditure on vegetables";
         when fruit => return "Expenditure on fruits";
         when sugar => return "Expenditure on sugar and related pdts";
         when syrup => return "Expenditure on syrup/jam/related pdts";
         when tea => return "Expenditure on coffee/tea/cocoa";
         when othfood => return "Expenditure on other food pdts";
         when hotelfoo => return "Expenditure on meals taken outside home";
         when hnalcbev => return "Expenditure on non alcoholic bev.- hotels";
         when snalcbev => return "Expenditure on non alcoholic bev.- hotels";
         when halcbev => return "Expenditure on  alcoholic bev.-hotels";
         when salcbev => return "Expenditure on alcoholic bev.-shops";
         when tobacco => return "Expenditure on tobacco/related items";
         when personal => return "Expenditure on personal care items";
         when consgood => return "Expenditure on other household consumer goods";
         when hhserv => return "Expenditure on household services";
         when subtot => return "Subtotal expenditure on hh expenses";
         when subtoty => return "Subtotal expenditure on hh expenses - year";
         when fuel => return "Expenditure on fuel/year";
         when womcloth => return "Expenditure on women's clothing year";
         when girlcl => return "Expenditure on  girls'clothing - year";
         when mcloth => return "Expenditure on men's clothing -year";
         when boycloth => return "Expenditure on boys' clothing -year";
         when chncl => return "Expenditure on children's clothing - year";
         when womfoot => return "Expenditure on women's footwear  -year";
         when gfoot => return "Expenditure on girls' footwear  -year";
         when menfoot => return "Expenditure on men's footwear - year";
         when boyfoot => return "Expenditure on boys' footwear - year";
         when chnfoot => return "Expenditure on children's clothing - year";
         when handmade => return "Expenditure on specially made clothing + repairs";
         when furn => return "Expenditure on furniture/fixture/floor- year";
         when textile => return "Expenditure on hh textiles - year";
         when applianc => return "Expenditure on hh appliances- year";
         when equip => return "Expenditure on other hh equipment- year";
         when medserm => return "Expenditure on health services year";
         when medsernm => return "Expenditure on health serv -non member - year";
         when vehicle => return "Expenditure on vehicles bought- year";
         when vehrun => return "Expenditure on ruunind private veh. - year";
         when pubtraws => return "Expenditure on public transport to work/sch - year";
         when ptravis => return "Expenditure on public transp while on visit - year";
         when computer => return "Expenditure on computer/telcom equipment- year";
         when communic => return "Expenditure on communication for hh purposes- year";
         when edfeesel => return "Expenditure on education paid  by self- year";
         when edfeegr => return "Expenditure on education paid by grant- year";
         when readmat => return "Expenditure on reading matter + stationery- year";
         when recreq => return "Expenditure on recreational equipment- year";
         when recrgood => return "Expenditure on other recreational goods";
         when licence => return "Expenditure on licences and other serv charges";
         when subtot2 => return "Sub total expenditure on c/f";
         when miscel => return "Expenditure on miscellaneous goods";
         when remit => return "Expenditure on remittances/donations";
         when taxpaid => return "Expenditure on income tax - year";
         when fincharg => return "Expenditure on finance and insurance charge - year";
         when other => return "Other expend.";
         when loss => return "Net loss - year";
         when ownprod => return "Value own production consumed by hh - year";
         when livestoc => return "Value of own livestock consumed by hh- year";
         when hhexp => return "Total expenditure- year";
         when dirinc => return "Total direct income- year";
         when indirinc => return "Total indirect income- year";
         when totinc => return "Total income- year (sum of var no. 74 & 75)";
         when hweight => return "Household weight";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Expenditure_Type( i : Integer ) return Expenditure_Type is
   begin
      case i is 
         when 1 => return housm;
         when 2 => return housy;
         when 3 => return domwag;
         when 4 => return cereal;
         when 5 => return meat;
         when 6 => return fish;
         when 7 => return fats;
         when 8 => return milk;
         when 9 => return veg;
         when 10 => return fruit;
         when 11 => return sugar;
         when 12 => return syrup;
         when 13 => return tea;
         when 14 => return othfood;
         when 15 => return hotelfoo;
         when 16 => return hnalcbev;
         when 17 => return snalcbev;
         when 18 => return halcbev;
         when 19 => return salcbev;
         when 20 => return tobacco;
         when 21 => return personal;
         when 22 => return consgood;
         when 23 => return hhserv;
         when 24 => return subtot;
         when 25 => return subtoty;
         when 26 => return fuel;
         when 27 => return womcloth;
         when 28 => return girlcl;
         when 29 => return mcloth;
         when 30 => return boycloth;
         when 31 => return chncl;
         when 32 => return womfoot;
         when 33 => return gfoot;
         when 34 => return menfoot;
         when 35 => return boyfoot;
         when 36 => return chnfoot;
         when 37 => return handmade;
         when 38 => return furn;
         when 39 => return textile;
         when 40 => return applianc;
         when 41 => return equip;
         when 42 => return medserm;
         when 43 => return medsernm;
         when 44 => return vehicle;
         when 45 => return vehrun;
         when 46 => return pubtraws;
         when 47 => return ptravis;
         when 48 => return computer;
         when 49 => return communic;
         when 50 => return edfeesel;
         when 51 => return edfeegr;
         when 52 => return readmat;
         when 53 => return recreq;
         when 54 => return recrgood;
         when 55 => return licence;
         when 56 => return subtot2;
         when 57 => return miscel;
         when 58 => return remit;
         when 59 => return taxpaid;
         when 60 => return fincharg;
         when 61 => return other;
         when 62 => return loss;
         when 63 => return ownprod;
         when 64 => return livestoc;
         when 65 => return hhexp;
         when 66 => return dirinc;
         when 67 => return indirinc;
         when 68 => return totinc;
         when 69 => return hweight;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Expenditure");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Expenditure");
             end if;
      end case;
      return missing;
   end Convert_Expenditure_Type;

   function Pretty_Print( i : Income_Type ) return String is
   begin
      case i is
         when hobby => return "Income from hobbies (rands)";
         when carsal => return "Income from car sale (rands)";
         when prop => return "Income from property sale (rands)";
         when usedit => return "Income from sale of used items";
         when rental => return "Income from letting out property";
         when houben => return "Housing benefits";
         when traben => return "Transport benefits";
         when medben => return "Medical benefits";
         when othben => return "Other benefits";
         when lump => return "Lump sum payment";
         when policy => return "Policy income";
         when otlump => return "Other lump sum payments";
         when linsur => return "Income from life insurance";
         when funcla => return "Income from funeral claims";
         when propcl => return "Income from property claims for damage caused";
         when trafcl => return "Income from traffic claims";
         when gratui => return "Income from gratuity payments";
         when stokv => return "Income from stokvels";
         when saving => return "Money in savings accounts with financial insitutions";
         when bursar => return "Unrefundable claims";
         when cashbe => return "Cash benefits";
         when foodbe => return "Food benefits";
         when othseb => return "Other housing benefits";
         when clben => return "Clothing benefits";
         when otgift => return "Other gifts";
         when lobola => return "Lobola income";
         when othinc => return "Other income";
         when ttothinc => return "Total other income";
         when wages => return "Wages income";
         when bonus => return "Bonus received";
         when commi => return "Commission received";
         when allow => return "Allowances due to employment ";
         when profit => return "Profit income";
         when rent => return "Rent income";
         when royal => return "Royalties";
         when inter => return "Interest income";
         when divid => return "Dividend income";
         when pens => return "Private pension income";
         when oldage => return "Old age pension income";
         when disabg => return "Disability grant received";
         when famall => return "Family allowances from state eg. chiul grants";
         when unembe => return "Unemployment benefits";
         when alimon => return "Alimony received";
         when remit => return "Remittances from family and non family  members";
         when income => return "Total regular income for the indiv. rands per year";
         when inckin => return "Income in kind (in rands)";
         when indinc => return "Persons income from employment";
         when income_from_employment => return "Person's income from emploment and own account activities";
         when netacy => return "Net income from own account activities";
         when hincom => return "Total household income (in rands)";
         when missing => return "Null or Missing";
      end case;
   end Pretty_Print;

   function Convert_Income_Type( i : Integer ) return Income_Type is
   begin
      case i is 
         when 8 => return hobby;
         when 9 => return carsal;
         when 10 => return prop;
         when 11 => return usedit;
         when 12 => return rental;
         when 13 => return houben;
         when 14 => return traben;
         when 15 => return medben;
         when 16 => return othben;
         when 17 => return lump;
         when 18 => return policy;
         when 19 => return otlump;
         when 20 => return linsur;
         when 21 => return funcla;
         when 22 => return propcl;
         when 23 => return trafcl;
         when 24 => return gratui;
         when 25 => return stokv;
         when 26 => return saving;
         when 27 => return bursar;
         when 28 => return cashbe;
         when 29 => return foodbe;
         when 30 => return othseb;
         when 31 => return clben;
         when 32 => return otgift;
         when 33 => return lobola;
         when 34 => return othinc;
         when 35 => return ttothinc;
         when 36 => return wages;
         when 37 => return bonus;
         when 38 => return commi;
         when 39 => return allow;
         when 40 => return profit;
         when 41 => return rent;
         when 42 => return royal;
         when 43 => return inter;
         when 44 => return divid;
         when 45 => return pens;
         when 46 => return oldage;
         when 47 => return disabg;
         when 48 => return famall;
         when 49 => return unembe;
         when 50 => return alimon;
         when 51 => return remit;
         when 52 => return income;
         when 107 => return inckin;
         when 108 => return indinc;
         when 109 => return income_from_employment;
         when 110 => return netacy;
         when 111 => return hincom;
         when 0 => return missing;
         when Others =>
             if( ABORT_ON_ERROR )then
                Raise_Exception( Enum_Conversion_Exception'Identity, "Unrecognised value: " & Integer'Image( i ) & " for enum Income");
             else
                Put_Line( "Unrecognised value: " & Integer'Image( i ) & " for enum Income");
             end if;
      end case;
      return missing;
   end Convert_Income_Type;
   
end ZA_Enums;
