--
--  $Author: graham_s $
--  $Date: 2008-04-09 12:43:43 +0100 (Wed, 09 Apr 2008) $
--  $Revision: 4916 $
--

with Templates_Parser;

package FRS_Enums.Templates is

   function get_acorn_template return  Templates_Parser.Tag;
   function get_adult_employment_status_template return  Templates_Parser.Tag;
   function get_age_group_template return  Templates_Parser.Tag;
   function get_aggregated_ethnic_group_template return  Templates_Parser.Tag;
   function get_benefit_types_template return  Templates_Parser.Tag;
   function get_benefit_unit_economic_status_template return  Templates_Parser.Tag;
   function get_benefit_unit_type_template return  Templates_Parser.Tag;
   function get_bu_disabled_indicator_template return  Templates_Parser.Tag;
   function get_employment_status_template return  Templates_Parser.Tag;
   function get_ethnic_group_template return  Templates_Parser.Tag;
   function get_hbai_benefit_unit_type_template return  Templates_Parser.Tag;
   function get_household_composition_template return  Templates_Parser.Tag;
   function get_household_income_band_template return  Templates_Parser.Tag;
   function get_ilo_employment_status_template return  Templates_Parser.Tag;
   function get_marital_status_template return  Templates_Parser.Tag;
   function get_non_dependency_class_template return  Templates_Parser.Tag;
   function get_old_region_template return  Templates_Parser.Tag;
   function get_pension_types_template return  Templates_Parser.Tag;
   function get_regional_stratifier_template return  Templates_Parser.Tag;
   function get_relationship_to_head_of_household_template return  Templates_Parser.Tag;
   function get_standard_region_template return  Templates_Parser.Tag;
   function get_tenure_type_template return  Templates_Parser.Tag;
   function get_gender_template return  Templates_Parser.Tag;

end FRS_Enums.Templates;
