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
-- This is the top-level package for the ZA model. It does very little: just
-- imports some standard types and generic formatting and calculation routines, so these can  
-- be used easily in the model itself, which is (almost) all declared in child packages.
-- 
-- Putting anything else in here may cause nasty cross-dependencies.
--
--  $Author: graham_s $
--  $Date: 2008-11-01 21:53:28 +0000 (Sat, 01 Nov 2008) $
--  $Revision: 6124 $

pragma License( Modified_GPL );

with Ada.Text_IO.Editing;

with Base_Model_Types;
with Format_Utils;
with Text_Utils;
with Key_Value_IO;
-- 
pragma Elaborate_All (Text_Utils);
pragma Elaborate_All (Base_Model_Types);
pragma Elaborate_All (Format_Utils);
-- pragma Elaborate_All (Tax_Utils);


package ZA is

   subtype Sernum_String is String (1 .. 14);
   type Sernum_Value  is range 10_000_000_000_000 .. 99_999_999_999_999;
   -- nb actual range is actually is 10101001000501–98486025007901

   type Loggable_Modules is ( enumerated_types, conversions, income_tax, 
      indirect, model_data, benefits, marginal_rates, driver, 
      budget_constraint );
   
   use Base_Model_Types;
   
   package ZA_Format_Utils is new 
      Format_Utils( 
         Counter_Type => Counter_Type, 
         Float_Type => Rate,
         Default_Separator => ' ',
         Default_Radix_Mark => ',',
         Amount_Picture => 
            Ada.Text_IO.Editing.To_Picture( "-ZZZ_ZZZ_ZZZ_ZZZ_ZZZ_ZZ9") ); -- comma seperator
   package ZA_Key_Value_IO is new Key_Value_IO( Real_Type=>Amount,  Counter_Type=>Counter_Type );

   use ZA_Format_Utils;

   
   
end ZA;
