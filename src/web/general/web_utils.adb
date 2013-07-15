------------------------------------------------------------------------------
--                                                                          --
--  Some support functions for OSCR's interface which don't fit elsewhere   --
--                                                                          --
-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
--                                                                          --

with Ada.Characters.Handling;
with Ada.Directories;
with Ada.Text_IO;
with Templates_Parser.Query;

package body Web_Utils is

   use Text_Utils;

   function To_Dir_Name( u : Unbounded_String ) return String is
   begin
      return Ada.Characters.Handling.To_Lower(
         To_String( 
            Text_Utils.Censor_String( u )
         )
      );
   end To_Dir_Name;
   
   function Make_Menu( 
      root         : String; 
      item_name    : String; 
      names        : Unbounded_String_List; 
      ids          : Unbounded_String_List; 
      this_id      : Unbounded_String; 
      level        : Natural := 0 ) return Unbounded_String is
      
      -- package usvp renames Unbounded_String_Vector_Package;
      outs : Unbounded_String;
      NUM_ITEMS : constant Positive := Positive( names.Length );
   begin
      outs := TuS( "<div class='subnav" );
      if( level > 0 ) then
         outs := outs & Censor_String( Positive'Image( level ) );
      end if;
      outs := outs & "'><ul>" & LINE_BREAK;
      Each_Element:
      for i in 1 .. NUM_ITEMS loop
         declare
             name : Unbounded_String := names.Element( i );
             id : Unbounded_String := ids.Element( i );
             relative_dir : String := root & "/?" & item_name & "=" & TS(id);               
         begin
            outs := outs & "     <li>" & LINE_BREAK;
            if( id /= this_id ) then
               outs := outs & "              <a href='" & relative_dir & "'>" & name & "</a>" & LINE_BREAK;
            else
               outs := outs & "              <span class='current'>" & name & "</span>" & LINE_BREAK;
            end if;
            outs := outs & "     </li>" & LINE_BREAK;         
         end;
      end loop Each_Element;
      outs := outs & "</ul></div>" & LINE_BREAK;   
      return outs;
   end Make_Menu;

   function Build_Input_Page( 
      page : String; 
      translations : Templates_Parser.Translate_Set; 
      is_xml : Boolean := False ) return AWS.Response.Data is
      use Ada.Strings.Unbounded;
      use AWS.Parameters;
      s : Unbounded_String;
   begin
      s := Templates_Parser.Parse( page & ".thtml", translations );
      if( is_xml )then
         return AWS.Response.Build( "text/xhtml", s );
      else
         return AWS.Response.Build( "text/html", s );
      end if;
   end Build_Input_Page;
   
   function Build_Input_Page( 
      page : Unbounded_String; 
      translations : Templates_Parser.Translate_Set; 
      is_xml : Boolean := False ) return AWS.Response.Data is
   begin
      return Build_Input_Page( TS( page ), translations, is_xml );
   end Build_Input_Page;
   
   function Parse_Template(
      page : Unbounded_String;
      translations : Templates_Parser.Translate_Set ) return Unbounded_String is
   begin
      return Templates_Parser.Parse( TS(page & ".thtml"), translations );
   end Parse_Template;
   
   procedure Print_Assoc( item : Templates_Parser.Association; quit : in out Boolean) is
      use Templates_Parser;
      use Templates_Parser.Query;
      use Ada.Text_IO;
   begin
      Put( " key = |" & Variable( item ) & "|" );
      if( Kind( item ) = Std ) then
         Put( " value = |" & Get( item ) & "| ");
       end if;
       quit := False;
      New_Line;
   end Print_Assoc;
   
   
   function Parse_Template(
      page : String;
      translations : Templates_Parser.Translate_Set ) return String is
   begin
      return Templates_Parser.Parse( page & ".thtml", translations );
   end Parse_Template;
   
   function Get_Param( 
      params : AWS.Parameters.List; 
      name : String; 
      which : Positive := 1 ) return Unbounded_String is
      use Ada.Strings.Unbounded;
      use AWS.Parameters;
   begin
      return To_Unbounded_String( Get( params, name, which ) );
   end Get_Param;
   
   function To_String( params : AWS.Parameters.List ) return String is
       use Ada.Strings.Unbounded;
       use Text_Utils;
       s : Unbounded_String;
   begin
      for i in 1 .. AWS.Parameters.Count( params ) loop
         s := s & "param["&i'Img&" ]: key = " & 
            "|"&AWS.Parameters.Get_Name( params, i ) & "| value |" &
            AWS.Parameters.Get_Value( params, i ) & "| " & LINE_BREAK;
      end loop;
      return To_String( s );
   end To_String;

end Web_Utils;

