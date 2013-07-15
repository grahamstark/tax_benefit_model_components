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

with Ada.Numerics.Float_Random;
with Ada.Exceptions;

package body ZA.Model.Takeup is
   use Ada.Numerics.Float_Random;
   use Ada.Exceptions;
   --
   -- from run conducted on 16/08/2009 revision: 7941
   -- tab_indir14.csv
   -- 
   Base_Model_Caseload : constant Benefits_Array := (
      
      disability_grants    =>    850_982.65,
      old_age_pensions     =>  2_960_151.66,
      family_allowances    => 12_735_738.98,
      other_state_benefits =>    212_858.86 );
      
   -- from tables 6.3, 6.4 of social security chapter
   -- of 09/10 Budget docs April 2009 column
   Base_Actual_Caseload : constant Benefits_Array := (
      
      disability_grants    => 1_404_884.0,
      old_age_pensions     => 2_324_615.0,
      family_allowances    => 9_061_711.0,
      other_state_benefits => 105_909.0 );

   Propn : Benefits_Array;
   
   r_generator : Generator;
   
   function Takes_Up( 
      which_benefit : Personal_State_Benefits_Range; 
      which_takeup : Takeup_Ajustment_Type ) return Boolean is
      
   begin
      case which_takeup is
      when crude_probability =>
         if( Propn( which_benefit ) >= 1.0 ) then 
            return True;
         end if;
         return ( Amount( Random( r_generator )) < Propn( which_benefit ));
      when no_takeup =>
         return True;
      when probit =>
         Raise_Exception( Takeup_Exception'Identity, "Takes_Up: Probit is not implemented yet" );
         -- TODO
      end case;
   end Takes_Up;
   
   function Get_case_takes_up( which_takeup : Takeup_Ajustment_Type ) return Benefit_Takeup_Array is
      a : Benefit_Takeup_Array;
   begin
      for b in Personal_State_Benefits_Range loop
         a( b ) := Takes_Up( b, which_takeup  );
      end loop;
      return a;
   end Get_case_takes_up;

begin
   Reset( r_generator );
   for b in Benefits_Array'Range loop
      Propn( b ) := Base_Actual_Caseload( b ) / Base_Model_Caseload( b );
   end loop;
end ZA.Model.Takeup;

