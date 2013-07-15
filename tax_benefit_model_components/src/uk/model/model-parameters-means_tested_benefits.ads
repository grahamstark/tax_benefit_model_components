--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
--
-- FIXME: this needs massively expanded
--
--
pragma License( Modified_GPL );

with Ada.Containers.Ordered_Sets;
with T_Utils;

package Model.Parameters.Means_Tested_Benefits is

   type Pension_Credit_Type is (
      single,
      couple );
   package Pension_Credit_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Pension_Credit_Type );  
      
   subtype Pension_Credit_Array is Pension_Credit_Package.Amount_Array;
   subtype Pension_Credit_Set   is Pension_Credit_Package.Set;

   type Child_Tax_Credit_Element_Type is (
      family,
      family_with_young_child_addition,
      child,
      disability,
      severe_disability );

  
   package Child_Tax_Credit_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Child_Tax_Credit_Element_Type );  
      
   subtype Child_Tax_Credit_Array is Child_Tax_Credit_Package.Amount_Array;
   subtype Child_Tax_Credit_Set   is Child_Tax_Credit_Package.Set;

   -- not for IS/JSA : family, family_lp, disabled_child,

   type Premia is (
      family,
      higher_family,
      
      disabled_child,
      severe_disability_single,
      severe_disability_couple,
      
      enhanced_disability_single,
      enhanced_disability_child,
      enhanced_disability_couple,
      
      carer_single,
      carer_couple,
      
      family_lone_parent,
      disability_single,
      disability_couple,
      pensioner_single,
      enhanced_pensioner_single,
      higher_pensioner_single,
      pensioner_couple,
      enhanced_pensioner_couple,
      higher_pensioner_couple
      
      );
      
   subtype Highest_Only_Premia is Premia range family_lone_parent .. higher_pensioner_couple;
   subtype Include_All_Premia is Premia range family .. carer_couple;
   
   package Premia_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Premia );  
   subtype Premia_Array is Premia_Package.Amount_Array;
   subtype Premia_Set   is Premia_Package.Set;

      
   type Personal_Allowances is (
      single_u_18,
      single_18_24,
      single_25_and_over,
      lone_parent_u_18,
      lone_parent_18_24,
      lone_parent_25_and_over,
      couple_both_under_18,
      couple_one_under_18_one_18_24,
      couple_one_under_18_one_25_and_over,
      couple_both_18_and_over,
      
      couple_one_aged_60_64,
      couple_one_aged_65_or_over,
      single_aged_60_64,
      single_aged_65_or_over,
      
      dependent_child );

   package Personal_Allowances_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Personal_Allowances );  
   subtype Personal_Allowances_Array is Personal_Allowances_Package.Amount_Array;
   subtype Personal_Allowances_Set   is Personal_Allowances_Package.Set;

   type Housing_Benefit_Sys is record
      allowances       : Personal_Allowances_Array;
      premiums         : Premia_Array;
   end record;

   type Local_Tax_Benefit_Sys is record
      allowances       : Personal_Allowances_Array;
      premiums         : Premia_Array;
   end record;

   type Income_Support_JSA_Sys is record
      allowances       : Personal_Allowances_Array;
      premiums         : Premia_Array;
   end record;

   type Child_Tax_Credit_Sys is record
      elements       : Child_Tax_Credit_Array;
   end record;

   type Pension_Credit_Sys is record
      allowances       : Pension_Credit_Array;
      premiums         : Premia_Array;
   end record;

   type Means_Tested_Benefit_Types is ( Income_Support_JSA, Local_Tax_Benefit, Housing_Benefit, Child_Tax_Credit, Pension_Credit ); -- and so on

   type Means_Tested_Benefits_Sys is record
      child_tax_credit  : Child_Tax_Credit_Sys;
      housing_benefit   : Housing_Benefit_Sys;
      income_support    : Income_Support_JSA_Sys;
      local_tax_benefit : Local_Tax_Benefit_Sys;
      pension_credit    : Pension_Credit_Sys;
   end record;

   function Highest_Premium( values : Premia_Array; prems : Premia_Package.Set ) return Premia;

   function Get_2007_8_System return Means_Tested_Benefits_Sys;
   
   procedure Uprate( sys : in out Means_Tested_Benefits_Sys; m : Rate );
   
   procedure To_Annual( sys : in out Means_Tested_Benefits_Sys );
   
   procedure To_Weekly( sys : in out Means_Tested_Benefits_Sys );
 


--function Calc_Personal_Allowance( ) return Personal_Allowances;
--function Calc_Premia( ) return Personal_Allowances;


end Model.Parameters.Means_Tested_Benefits;
