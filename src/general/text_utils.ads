pragma License( Modified_GPL );

with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;
with Ada.Strings.Bounded;
with Ada.Containers;
with Ada.Containers.Vectors;
with Ada.Containers.Hashed_Maps;

--
-- This contains a fairly random set of routines to handle strings.
--
package Text_Utils is

   --  pragma Preelaborate;   
   
   package ustr renames Ada.Strings.Unbounded;
   package stda renames Ada.Characters.Latin_1;
   DOS_LINE_BREAK  : constant String := (stda.CR, stda.LF);
   UNIX_LINE_BREAK : constant String (1 .. 1) := (1 => stda.LF); -- "positional aggregate cannot have one component" otherwise. Weird..
   LINE_BREAK : constant String(1 .. 1) := (1 => stda.LF);
   TAB : constant String (1 .. 1) := (1 => stda.HT );
   package String80 is new Ada.Strings.Bounded.Generic_Bounded_Length (80);
   -- FIXME make StdBounded_String a subtype and rename the package
   package Std_Bounded_String is new Ada.Strings.Bounded.Generic_Bounded_Length (2048);
   
   --
   -- remove "&" "," " " "+" from strings and replace with underscores
   --
   function Censor_String( s : String ) return String;
   function Censor_String( s : Ada.Strings.Unbounded.Unbounded_String ) return Ada.Strings.Unbounded.Unbounded_String;
   --
   -- [ => 'X' and ] => 'Y', since [] are invalid in html id fields for some
   -- bizzare reason
   --
   function Censor_Id( index_key : ustr.Unbounded_String ) return ustr.Unbounded_String;   
   function Censor_Id( index_key : String ) return String; 
   --
   -- and vice- versa
   -- 
   function UnCensor_Id( index_key : ustr.Unbounded_String ) return ustr.Unbounded_String;
   function UnCensor_Id( index_key : String ) return String;
  
   DIR_SEPARATOR : constant Character;
   pragma Import( C, Dir_Separator, "__gnat_dir_separator" );
   --  Running system default directory separator
   
   function TS( s : ustr.Unbounded_String ) return String renames ustr.To_String;
   function TuS( s : String ) return ustr.Unbounded_String renames ustr.To_Unbounded_String;

   function Indent( n : Natural; indent_size : Natural := 3 ) return String;

   --
   -- e.g. COUNCIL_HOUSE => Council House
   --   
   function Prettify_Image( s : String ) return String;
   
   --
   -- A couple of functions useful for e.g. Ada's Hashmaps
   --
   function Compare_String( left, right : ustr.Unbounded_String ) return Boolean;
   function Hash_String( s : ustr.Unbounded_String ) return Ada.Containers.Hash_Type;

   function Pad( s : String; to_len : Positive ) return String;
      
   function Read_Whole_File( filename : String ) return ustr.Unbounded_String;
   procedure Write_Whole_File( filename: String; content : ustr.Unbounded_String );
   
   function Delete_All_Instances( s : String; target : String ) return String;
   
   function Count_Of_Character( s : String; ch : Character ) return Natural;

   function Replace_In_String( s : String; was : String; to : String ) return String;
   function Replace_In_Unbounded_String( s : ustr.Unbounded_String; was : String; to : String ) return ustr.Unbounded_String;

   --
   -- also trims leading & trailing blanks
   -- 
   function Trim( s : String; extra : String := "" ) return String;
   
   use type ustr.Unbounded_String;
   package Unbounded_String_Vector_Package is new Ada.Containers.Vectors( 
      Element_Type => ustr.Unbounded_String, Index_Type => Positive );   
   type Unbounded_String_List is new Unbounded_String_Vector_Package.Vector with null record;
   function To_One_String( l : Unbounded_String_List ) return String;
   procedure Add_To( l : in out Unbounded_String_List; item : String );
   function Get( l : Unbounded_String_List; which : Positive ) return String;
   
   function Split( s : String; sep : Character ) return Unbounded_String_List;
   function Join( s : Unbounded_String_List; sep : Character ) return String;
   
   use type Std_Bounded_String.Bounded_String;
   package Bounded_String_Vector_Package is new Ada.Containers.Vectors( 
      Element_Type => Std_Bounded_String.Bounded_String, Index_Type => Positive );
   subtype Bounded_String_List is Bounded_String_Vector_Package.Vector;
   
   package String_Maps_Package is new Ada.Containers.Hashed_Maps(
       Key_Type        => ustr.Unbounded_String, 
       Element_Type    => ustr.Unbounded_String,
       Hash            => Hash_String,
       "="             => Compare_String,
       Equivalent_Keys => Compare_String
   );
   
   type Unbounded_String_Map is new String_Maps_Package.Map with null record;
   
   procedure Add_To( this : in out Unbounded_String_Map; key : String; value : String );
   function Get( this : Unbounded_String_Map; key : String ) return String;
   function To_String( this : Unbounded_String_Map ) return String;
   
end Text_Utils;
