------------------------------------------------------------------------------
--                                                                          --
--  Simple Map thing for basic language lookups                             --
--                                                                          --
-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with this;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--
--
with Templates_Parser;
with Ada.Strings.Unbounded;
--
-- languages as an enumeration: en,nl,fr and so on
-- the first language is taken as the default - if we're in that language a value for the key is not found,
-- then the key itself is returned - this is what GETTEXT does, I think
--
generic

   type Languages is (<>);
   
package Translate_Utils is

   function Lookup( key : String; lang : Languages ) return Templates_Parser.Association;
   function Lookup( key : Ada.Strings.Unbounded.Unbounded_String; lang : Languages ) return Templates_Parser.Association;
   function Lookup( key : Ada.Strings.Unbounded.Unbounded_String; lang : Languages ) return String;
   function Lookup( key : String; lang : Languages ) return String;
   
   --
   -- Looks up a lowercased, trimmed version of T'Image of some discrete type
   --
   generic
      type T is (<>);
   function Lookup_V( key : T;  lang : Languages ) return String;
   
   procedure Load( filename : String; lang : Languages );

end Translate_Utils;
