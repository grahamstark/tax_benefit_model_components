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
with Ada.Strings.Unbounded;
with AWS.Parameters;
with AWS.Response;
with Templates_Parser;
with Text_Utils;

package Web_Utils is

   use Text_Utils;
   use Ada.Strings.Unbounded;
   
   GAIN_STRING       : constant String := "<span class='gain'>&uArr;</span>";
   LOSE_STRING       : constant String := "<span class='lose'>&dArr;</span>";
   NO_CHANGE_STRING  : constant String := "<span class='no-change'>&hArr;</span>";
   
   function To_Dir_Name( u : Unbounded_String ) return String;
   
   function Make_Menu( 
      root         : String; 
      item_name    : String; 
      names        : Unbounded_String_List;
      ids          : Unbounded_String_List;
      this_id      : Unbounded_String; 
      level        : Natural := 0 ) return Unbounded_String;  
   
   function Parse_Template(
      page : Unbounded_String;
      translations : Templates_Parser.Translate_Set ) return Unbounded_String;
      
   function Parse_Template(
      page : String;
      translations : Templates_Parser.Translate_Set ) return String;
     
   function Build_Input_Page( 
      page : String; 
      translations : Templates_Parser.Translate_Set;
      is_xml : Boolean := False ) return AWS.Response.Data;
      
   function Build_Input_Page( 
      page : Unbounded_String; 
      translations : Templates_Parser.Translate_Set;
      is_xml : Boolean := False ) return AWS.Response.Data;

   function Get_Param( 
      params : AWS.Parameters.List; 
      name : String; 
      which : Positive := 1 )  return Unbounded_String;

   function To_String( params : AWS.Parameters.List ) return String;
   
   procedure Print_Assoc( item : Templates_Parser.Association; quit : in out Boolean);
   procedure Dump_Translations is new Templates_Parser.For_Every_Association( Action => Print_Assoc );  
    
  
end Web_Utils;

