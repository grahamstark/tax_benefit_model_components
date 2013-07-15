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

package body ZA.Model.Data.Examples is
   
   function Get_Example( which : Example_Types ) return Household is
      use Ada.Calendar;
      hh : Household;
   begin
      hh.info.interview_date := Time_Of( 2005, 6, 1 );
      hh.info.province := Gauteng;
      hh.info.tenure := rented_not_as_part_of_employment_contract_of_household_member;
      hh.info.dwelling := town_or_cluster_or_semi_detached_house_simplex_duplex_or_triplex;
      hh.info.urban_or_rural := urban;
      hh.info.weight := 1.0;
      case which is
         when single => 
            hh.info.num_people := 1;
            hh.info.num_families := 1;
            hh.family( 1 ).num_people := 1;
            hh.family( 1 ).num_adults := 1;
            hh.family( 1 ).num_children := 1;
            
            hh.family( 1 ).person( 1 ).age := 25;
            hh.family( 1 ).person( 1 ).gender := male;
            hh.family( 1 ).person( 1 ).race := indian_or_asian;
         when single_pensioner => 
            hh.info.num_people := 1;
            hh.info.num_families := 1;
            hh.family( 1 ).num_people := 1;
            hh.family( 1 ).num_adults := 1;
            hh.family( 1 ).num_children := 0;
            hh.family( 1 ).person( 1 ).age := 70;
            hh.family( 1 ).person( 1 ).gender := female;
            hh.family( 1 ).person( 1 ).race := african_or_black;
         when couple_pensioner => 
            hh.info.num_people := 2;
            hh.info.num_families := 1;
            hh.family( 1 ).num_people := 2;
            hh.family( 1 ).num_adults := 2;
            hh.family( 1 ).num_children := 0;
            hh.family( 1 ).person( 1 ).age := 70;
            hh.family( 1 ).person( 1 ).gender := male;
            hh.family( 1 ).person( 1 ).race := african_or_black;
            hh.family( 1 ).person( 2 ).age := 70;
            hh.family( 1 ).person( 2 ).gender := female;
            hh.family( 1 ).person( 2 ).race := african_or_black;
         when family_2_kids => 
            hh.info.num_people := 4;
            hh.info.num_families := 1;
            hh.family( 1 ).num_people := 4;
            hh.family( 1 ).num_adults := 2;
            hh.family( 1 ).num_children := 2;
            hh.family( 1 ).person( 1 ).age := 50;
            hh.family( 1 ).person( 1 ).gender := male;
            hh.family( 1 ).person( 1 ).race := african_or_black;
            hh.family( 1 ).person( 2 ).age := 50;
            hh.family( 1 ).person( 2 ).gender := female;
            hh.family( 1 ).person( 2 ).race := african_or_black;
            hh.family( 1 ).person( 3 ).age := 12;
            hh.family( 1 ).person( 3 ).gender := female;
            hh.family( 1 ).person( 3 ).race := african_or_black;
            hh.family( 1 ).person( 4 ).age := 12;
            hh.family( 1 ).person( 4 ).gender := female;
            hh.family( 1 ).person( 4 ).race := african_or_black;
      end case;
      
      Complete_Household_Information( hh );
     
      return hh;
   end Get_Example;

end ZA.Model.Data.Examples;
