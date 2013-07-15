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
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Hash;
with Ada.Containers;
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Unbounded.Text_IO;
with Text_Utils;
with Line_Extractor;
with Keyed_Text_Buffer;

package body Translate_Utils is

   use Ada.Strings.Unbounded;
   use Line_Extractor;
   use Keyed_Text_Buffer;   
   use Text_Utils;
   
   MISSING_INDICATOR : constant String := "";
   
    
   type Lookups_Array is array( Languages ) of Text_Buffer;
   
   lookups : Lookups_Array;
   
   function Lookup_V( key : T;  lang : Languages ) return String is
   begin
      return Lookup( Censor_String( T'Image( key )), lang );
   end Lookup_V;

   
 
   function Lookup( key : String; lang : Languages ) return Templates_Parser.Association is
   begin
      return Lookup( To_Unbounded_String( key ), lang );      
   end Lookup;  
   
   function Lookup( key : Unbounded_String; lang : Languages ) return Templates_Parser.Association is
      use String_Maps_Package;
      skey : String := To_String( key );
   begin
      if( Contains( lookups( lang ), key )) then
         return Templates_Parser.Assoc( skey, Element( lookups( lang ), key ));
      elsif lang = Languages'First then
         return Templates_Parser.Assoc( skey, skey ); 
      else
         for l in Languages loop
            if( l /= lang ) then
               if(  Contains( lookups( l ), key )) then
                  return Templates_Parser.Assoc( skey, Element( lookups( l ), key ));
               end if;
            end if;
         end loop;
      end if;
      return Templates_Parser.Assoc( skey, skey );
   end Lookup;
   
   function Lookup( key : Unbounded_String; lang : Languages ) return String is
      use String_Maps_Package;
      skey : String := To_String( key );
   begin
     if( Contains( lookups( lang ), key )) then
         return To_String( Element( lookups( lang ), key ));
      elsif lang = Languages'First then
         return To_String( key ); 
     else
         for l in Languages loop
            if( l /= lang ) then
               if(  Contains( lookups( l ), key )) then
                  return To_String( Element( lookups( l ), key ));
               end if;
            end if;
         end loop;
      end if;
      return skey;
   end Lookup;
   
   function Lookup( key : String; lang : Languages ) return String is
   begin
      return Lookup( To_Unbounded_String( key ), lang );
   end Lookup;
   --
   -- FIXME wrong way round
   --
   function Lookup( key : Unbounded_String; lang : Languages ) return Unbounded_String is
   begin
      return To_Unbounded_String( Lookup( key, lang ));
   end Lookup;
  
  
   
   procedure Load( filename : String; lang : Languages ) is
      use String_Maps_Package;
      new_lookups : Text_Buffer;
   
      procedure Include_All( pos : Cursor ) is
         k : Unbounded_String := Key( pos );
         v : Unbounded_String := new_lookups.Element( k );
      begin
         lookups( lang ).Include( k, v );
      end Include_All;
 
   begin
      new_lookups := Keyed_Text_Buffer.Load( filename, Keyed_Text_Buffer.multiline );
      new_lookups.Iterate( Include_All'Access );
   end Load;

end Translate_Utils;
