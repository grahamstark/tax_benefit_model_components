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

with AUnit.Test_Suites;

with ZA.Tests;
with ZA.Model.Data.Tests;
with ZA.Model.Calculator.Tests;

function ZA_Suite return AUnit.Test_Suites.Access_Test_Suite is
   use AUnit.Test_Suites;
   result : Access_Test_Suite := new Test_Suite;
begin
   Add_Test( result, new ZA.Tests.Test_Case );
   Add_Test( result, new ZA.Model.Data.Tests.Test_Case );
   Add_Test( result, new ZA.Model.Calculator.Tests.Test_Case );
   return result;
end ZA_Suite;
