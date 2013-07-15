-------------------------------------------------------------------------------
--
--        Unit Name:      Separate body for Numeric_IO.Matrix_IO.Implementation
--
-------------------------------------------------------------------------------
separate (Numeric_Io.Matrix_Io)

package body Implementation is

   procedure Count_Defaulting_Commas (From     : in String;
                                      Defaults : in out Integer ;
                                      Last     : out Positive) is
   begin
      Last := From'First ;
      while Last <= From'Last loop
         if From(Last)  = ' ' then
            Last := Last + 1;
         elsif From (Last) = ',' then
            Defaults := Defaults + 1 ;
            Last := Last + 1;
         else exit ;
         end if ;
      end loop ;
   end Count_Defaulting_Commas ;

   -------------------------------------------------------------------------------
   --  Body of GET VECTOR from STRING:
   --  THIS is the procedure that performs PARSING for all the input procedures
   -------------------------------------------------------------------------------

   procedure Get (From : in String;
                  Item : out Internal_Array;
                  Last : out Positive) is

      Ix : Internal_Index  := Item'First;
      Examine : Natural := From'First ;
      Num_Defaults : Integer := 0 ;  -- comma ahead of value denotes default
   begin
      Count_Defaulting_Commas (From, Num_Defaults, Examine) ;
      --  There may be some commas (Num_Defaults of them) before the
      --  first number.  If there are, we understand the user to mean
      --  each of these to follow a (defaulted) value "0.0"
      while  Num_Defaults > 0 and Ix < Item'Last loop
         Item(Ix) := 0.0 ;
         Ix := Internal_Index'Succ(Ix) ;
         Num_Defaults := Num_Defaults - 1 ;
      end loop ;
      if Num_Defaults > 0 then
         --  the preceding loop completely filled the Item.  So
         --  input was *nothing but* commas
         Item(Item'Last) := 0.0 ;
         Last := Examine - 1 ;
      else
         loop
            --  After the final "leading" comma we expect to read numbers
            --  to fill in the Item.
            real_Decode
              (From (Examine .. From'Last), Item (Ix), Examine);
            if Ix = Item'Last then
               exit ;
            else
               Ix := Internal_Index'Succ(Ix) ;
            end if ;
            --    There might be comma(s) following any number.  One such
            --  comma is the optional delimiter, but if there are more
            --  than one comma that means there are default values 0.0 in
            --  the Item.
            Num_Defaults := 0 ;
            Count_Defaulting_Commas (From(Examine + 1 .. From'Last),
                                     Num_Defaults,
                                     Examine) ;
            while  Num_Defaults > 1 -- a single comma is a separator, not a default
              and Ix <= Item'Last loop
               Item(Ix) := 0.0 ;  -- such default(s) are inside the input string
               if Ix = Item'Last then
                  exit ;  -- might end on default values
               else
                  Ix := Internal_Index'Succ(Ix) ;
                  Num_Defaults := Num_Defaults - 1 ;
               end if ;
            end loop ;
            --   The loop needs to iterate if the input string has more
            -- chars to read.
            if Examine > From'Last then
               --   But maybe the comma consumption exhausted the inputs,
               -- in which case we need to default to the end of the
               -- product array:
               for Remaining in Ix .. Item'Last loop
                  Item(Remaining) := 0.0 ;
               end loop ;
               exit ;
            end if ;
         end loop ;
         Last := Examine ;
      end if ;
   end Get ;

   -------------------------------------------------------------------------------

   procedure Get (File  : in Ada.Text_Io.File_Type;
                  Item  : out Internal_Array;
                  Width : in Field := 0) is
   begin
      if Width = 0 then
         --  The input is a line of real numbers, each in the format
         --  recognized by numeric_io.  Comma delimiters and element
         --  defaults are as discussed immediately above.
         --  Matrices that are (width=0) are IMPLICITLY row per line.
         declare
            Line : String (1 .. 132);
            Line_Len : Natural;
            Last : Natural;
         begin
            Ada.Text_Io.Get_Line (File, Line, Line_Len);
            Get (Line (1 .. Line_Len), Item, Last);
         end;
      else
         --  Elements of input occur in rigid columnwise fields with
         --  column-width according to the parameter in this call.
         --  Columnwise formatted matrixes have one row per line
         --  EXPLICITLY; NO element defaulting
         declare
            Element  : String (1 .. Width);
            Last : Positive;
         begin
            for Ix in Item'Range loop
               Ada.Text_Io.Get (File, Element);
               Real_Decode (Element, Item (Ix), Last);
            end loop;
            Ada.Text_Io.Skip_Line (File);
         end;
      end if;
   end Get;

   -------------------------------------------------------------------------------

   procedure Put (To   : out String;
                  Item : in Internal_Array;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp) is
      use String_Pkg;
      --  Format elements one at a time into Single_value, and
      --  separate each with ", "
      Single_Size  : Natural := To'Length / Item'Length;
      Separator    : constant String := ", ";
      --  Catenate all into a dynamic string,
      Build_String : String_Type;
      --  Then finish off with a few nuls because of round off of
      --  length of each single_value
      Pad_Nuls     : Integer;
      Null_Char    : String (1 .. 1) := (others => Ascii.Nul);
   begin
      Mark;   -- heap management in "dynamic" string_pkg (predates Ada95)
      Build_String := Create ("");
      for I in Item'Range (1) loop
         if I < Item'Last (1) then    --  all but last gets ','
            declare
               Single_Value : String (1 .. Single_Size - Separator'Length);
            begin
               Real_Io.Put
                 (Single_Value, Item (I), Aft => Aft, Exp => Exp);
               Build_String := Build_String & Single_Value;
               Build_String := Build_String & Separator;
            end;
         else
            declare
               Single_Value : String (1 .. Single_Size);
            begin
               Real_Io.Put
                 (Single_Value, Item (I), Aft => Aft, Exp => Exp);
               Build_String := Build_String & Single_Value;
            end;
         end if;
      end loop;

      Pad_Nuls := Length (Build_String);
      while Pad_Nuls < To'Length loop
         Build_String := Build_String & Null_Char;
         Pad_Nuls := Pad_Nuls + 1;
      end loop;
      To (To'Range) := Value (Build_String);
      Release;

   end Put;

   -------------------------------------------------------------------------------

   function Aft (Item : in Internal_Array; Exp : in Field := Default_Exp)
                return Field is
      --  Aft is an aid to formatting a vector:
      --  It computes the value for the (scalar) AFT parameter that will
      --  write just the significant part of each element in a vector.
      --  All elements will have the same number of significant digits.
      Single : Positive;
      Enough : Natural := 0;
   begin
      for I in Item'Range loop
         Single := Aft (Item (I), Exp);
         if Enough < Single then
            Enough := Single;
         end if;
      end loop;

      return Enough;
   end Aft;

end Implementation ;

-------------------------------------------------------------------------------
--  This is free software; you can redistribute it and/or modify it
--  under terms of the GNU General Public License as published by the
--  Free Software Foundation; either version 2, or (at your option)
--  any later version.  This software is distributed in the hope that
--  it will be useful, but WITH OUT ANY WARRANTY; without even the
--  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--  PURPOSE. See the GNU General Public License for more details. Free
--  Software Foundation, 59 Temple Place - Suite 330, Boston, MA
--  02111-1307, USA.
--
--  As a special exception, if other files instantiate generics from
--  this unit, or you link this unit with other files to produce an
--  executable, this unit does not by itself cause the resulting
--  executable to be covered by the GNU General Public License. This
--  exception does not however invalidate any other reasons why the
--  executable file might be covered by the GNU Public License.

--  This software was prepared as an account of work sponsored by an
--  agency of the United States Government.  Neither the United States
--  Government nor the University of California nor any of their
--  employees makes any warranty, express or implied, or assumes any
--  liability or responsibility for the accuracy, completeness, or
--  usefulness of any information disclosed.
-------------------------------------------------------------------------------

