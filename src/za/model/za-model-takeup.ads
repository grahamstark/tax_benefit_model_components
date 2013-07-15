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

--
-- Very crude takeup correction using a random number generator
--  
pragma License( Modified_GPL );

package ZA.Model.Takeup is

   type Takeup_Ajustment_Type is ( no_takeup, crude_probability, probit );

   Takeup_Exception : Exception;
   
   type Benefit_Takeup_Array is array( Personal_State_Benefits_Range ) of Boolean;
   
   --
   -- crude fixit version: all benefits as a single array, purely random only
   --
   function Get_Case_Takes_Up( which_takeup : Takeup_Ajustment_Type ) return Benefit_Takeup_Array;
   
   --
   -- FIXME: needs household and full result passed in here
   --
   function Takes_Up( which_benefit : Personal_State_Benefits_Range; which_takeup : Takeup_Ajustment_Type ) return Boolean;

end ZA.Model.Takeup;


