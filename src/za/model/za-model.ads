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
pragma License( Modified_GPL );

with Tax_Utils;
with Logger;
with ZA.Model_Types;

pragma Elaborate_All (Logger);

package ZA.Model is

   use ZA.Model_Types;

   package ZA_Logger is new Logger( Target_Type => Loggable_Modules );
   use ZA_Logger;
   
   package ZA_Tax_Utils is new Tax_Utils( Amount_Type=>Amount, Rate_Type=>Rate );
   
   use ZA_Tax_Utils;
   
end ZA.Model;
