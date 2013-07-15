--
--  $Author: graham_s $
--  $Date: 2008-07-23 19:42:24 +0100 (Wed, 23 Jul 2008) $
--  $Revision: 5490 $
--
--
pragma License( Modified_GPL );

with Ada.Strings.Unbounded; 

package body Model.Parameters.Means_Tested_Benefits is

   function Highest_Premium( values : Premia_Array; prems : Premia_Set ) return Premia is
      highest_premium : Premia := Premia'First;
      highest_value  : Amount := 0.0;
   begin
      for p in Highest_Only_Premia loop
         if( Premia_Package.Set_Ops.Contains( prems, p )) then
            if( values(p) > highest_value ) then
               highest_premium := p;
               highest_value := values(p);
            end if;
         end if;
      end loop;
      return highest_premium;
   end Highest_Premium;

   --
   -- From CPAG 0708 Chapter 33 and benefit-rates 2008.pdf
   -- expressed the CPAG guide way with the couple bits as sums rather than
   -- as in the PDF
   -- 
   function Get_07_08_Premiums( ben_type : Means_Tested_Benefit_Types ) return  Premia_Array is
      premiums :  Premia_Array := ( others => 0.0 );
   begin
      if( ben_type /= Income_Support_JSA ) then
         premiums( disabled_child ) := 48.72;
         premiums(family) := 16.75;
         premiums( higher_family ) := 27.25;
         premiums( family_lone_parent ) := 5.45;
         premiums( enhanced_disability_child ) := 19.60;
      else
         premiums( disabled_child ) := 0.0;
         premiums(family) := 0.0;
         premiums( higher_family ) := 0.0;
         premiums( family_lone_parent ) := 0.0;
         premiums( enhanced_disability_child ) := 0.0;
      end if;
      
      premiums( severe_disability_single ) := 50.35;
      premiums( severe_disability_couple ) := 100.70;
      
      premiums( enhanced_disability_single ) := 12.60;
      premiums( enhanced_disability_couple ) := 18.15;
      
      premiums( carer_single ) := 27.75;
      premiums( carer_couple ) := 55.50;
      
      premiums( disability_single ) := 25.85;
      premiums( disability_couple ) := 36.85;
      
      if( ben_type = Income_Support_JSA ) then
         premiums( pensioner_single ) := 0.0;
         premiums( enhanced_pensioner_single ) := 0.0;
         premiums( higher_pensioner_single ) := 0.0;
      else
         premiums( pensioner_single ) := 47.20;
         premiums( enhanced_pensioner_single ) := 47.20;
         premiums( higher_pensioner_single ) := 47.20;
      end if;
      
      premiums( pensioner_couple ) := 94.40;
      premiums( enhanced_pensioner_couple ) := 94.40;
      premiums( higher_pensioner_couple ) := 94.40;
      
      return premiums;
   end Get_07_08_Premiums;

   function Get_07_08_Allowances( ben_type : Means_Tested_Benefit_Types ) return Personal_Allowances_Array is
      allowances : Personal_Allowances_Array := ( others => 0.0 );
   begin
      allowances( single_u_18 ) := 47.95;
      allowances( single_18_24 ) := 47.95;
      allowances( single_25_and_over ) := 60.50;
      allowances( lone_parent_u_18 ) := 47.95;
      allowances( lone_parent_18_24 ) := 47.95;
      allowances( lone_parent_25_and_over ) := 60.50;
      allowances( couple_both_under_18 ) := 47.95;
      allowances( couple_one_under_18_one_18_24 ) := 47.95;
      allowances( couple_one_under_18_one_25_and_over ) := 60.50;
      allowances( couple_both_18_and_over ) := 94.95;
      if(( ben_type = Housing_Benefit ) or ( ben_type = Local_Tax_Benefit )) then
         allowances( couple_one_aged_60_64 ) := 189.35;
         allowances( couple_one_aged_65_or_over ) := 215.50;
         allowances( single_aged_60_64 ) :=  124.05;
         allowances( single_aged_65_or_over ) := 143.80;
      else
         allowances( couple_one_aged_60_64 ) := 0.0;
         allowances( couple_one_aged_65_or_over ) := 0.0;
         allowances( single_aged_60_64 ) := 0.0;
         allowances( single_aged_65_or_over ) := 0.0;
      end if;
      if( ben_type = Income_Support_JSA ) then
         allowances( dependent_child ) := 0.0;
      else
         allowances( dependent_child ) := 52.59;
      end if;
      return allowances;
   end Get_07_08_Allowances;

   function Get_2007_8_System return Means_Tested_Benefits_Sys is
      sys : Means_Tested_Benefits_Sys;
   begin
   -- Income_Support_JSA, Local_Tax_Benefit, Housing_Benefit, Child_Tax_Credit, Pension_Credit ); -- and so on
      sys.income_support.allowances := Get_07_08_Allowances( Income_Support_JSA );
      sys.income_support.premiums := Get_07_08_Premiums( Income_Support_JSA );
     
      sys.housing_benefit.allowances := Get_07_08_Allowances( Housing_Benefit );
      sys.housing_benefit.premiums := Get_07_08_Premiums( Housing_Benefit );
      sys.local_tax_benefit.allowances := Get_07_08_Allowances( Local_Tax_Benefit );
      sys.local_tax_benefit.premiums := Get_07_08_Premiums( Local_Tax_Benefit );

      sys.child_tax_credit.elements( family ) := Annual_To_Weekly( 545.0 );
      sys.child_tax_credit.elements( family_with_young_child_addition ) := Annual_To_Weekly( 545.0 );
      sys.child_tax_credit.elements( child ) := Annual_To_Weekly( 2_085.00 );
      sys.child_tax_credit.elements( disability ) := Annual_To_Weekly( 2_540.00 );
      sys.child_tax_credit.elements( severe_disability ) := Annual_To_Weekly( 1_020.00 );

      sys.pension_credit.allowances( single ) :=  124.05;
      sys.pension_credit.allowances( couple ) :=  189.35;
      sys.pension_credit.premiums := Get_07_08_Premiums( Local_Tax_Benefit );
      return sys;
   end  Get_2007_8_System;
   
   procedure Multiply( sys : in out Means_Tested_Benefits_Sys; m : Rate ) is
   begin
      sys.child_tax_credit.elements := Child_Tax_Credit_Package.Mult( sys.child_tax_credit.elements, m ); 
      sys.housing_benefit.allowances := Personal_Allowances_Package.Mult( sys.housing_benefit.allowances, m );
      sys.housing_benefit.premiums := Premia_Package.Mult( sys.housing_benefit.premiums, m );
      sys.local_tax_benefit.allowances := Personal_Allowances_Package.Mult( sys.local_tax_benefit.allowances, m );
      sys.local_tax_benefit.premiums := Premia_Package.Mult( sys.local_tax_benefit.premiums, m );
      sys.income_support.allowances := Personal_Allowances_Package.Mult( sys.income_support.allowances, m );
      sys.income_support.premiums := Premia_Package.Mult( sys.income_support.premiums, m );
      sys.pension_credit.allowances := Pension_Credit_Package.Mult( sys.pension_credit.allowances, m );
      sys.pension_credit.premiums := Premia_Package.Mult( sys.pension_credit.premiums, m );
      -- and so on
   end Multiply;

   procedure Uprate( sys : in out Means_Tested_Benefits_Sys; m : Rate ) is
   begin
      sys.child_tax_credit.elements := Child_Tax_Credit_Package.Uprate( sys.child_tax_credit.elements, m ); 
      sys.housing_benefit.allowances := Personal_Allowances_Package.Uprate( sys.housing_benefit.allowances, m );
      sys.housing_benefit.premiums := Premia_Package.Uprate( sys.housing_benefit.premiums, m );
      sys.local_tax_benefit.allowances := Personal_Allowances_Package.Uprate( sys.local_tax_benefit.allowances, m );
      sys.local_tax_benefit.premiums := Premia_Package.Uprate( sys.local_tax_benefit.premiums, m );
      sys.income_support.allowances := Personal_Allowances_Package.Uprate( sys.income_support.allowances, m );
      sys.income_support.premiums := Premia_Package.Uprate( sys.income_support.premiums, m );
      sys.pension_credit.allowances := Pension_Credit_Package.Uprate( sys.pension_credit.allowances, m );
      sys.pension_credit.premiums := Premia_Package.Uprate( sys.pension_credit.premiums, m );
      -- and so on
   end Uprate;


   
   procedure To_Annual( sys : in out Means_Tested_Benefits_Sys ) is
   begin
      Multiply( sys, 52.0 );
   end To_Annual;
   
   procedure To_Weekly( sys : in out Means_Tested_Benefits_Sys ) is
   begin
      Multiply( sys, 1.0/52.0 );
   end To_Weekly;

end Model.Parameters.Means_Tested_Benefits;
