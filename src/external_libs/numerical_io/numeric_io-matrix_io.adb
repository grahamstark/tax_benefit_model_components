-------------------------------------------------------------------------------
--
--              Unit Name:      Package body for Numeric_IO.Matrix_IO
--
-------------------------------------------------------------------------------
with String_Pkg;
with Ada.Io_Exceptions ;

package body Numeric_Io.Matrix_IO is

   generic
      -- Note that in general the index of vectors and the index of
      --  (rows of) matrices are distinct, even though the semantics
      --  of each is identical.  Thus the action of filling either a
      --  vector or a row is accomplished by the procedures in this
      --  generic package.  The two instances are used for vectors and
      --  rows respectively.
      type Internal_Index is (<>) ;
      type Internal_Array is array (Internal_Index range <>) of Real ;

   package Implementation is

      procedure Get (From : in String;
                     Item : out Internal_Array;
                     Last : out Positive) ;

      procedure Get (File  : in Ada.Text_Io.File_Type;
                     Item  : out Internal_Array;
                     Width : in Field := 0) ;

      procedure Put (To   : out String;
                     Item : in Internal_Array;
                     Aft  : in Field := Default_Aft;
                     Exp  : in Field := Default_Exp) ;

      function Aft (Item : in Internal_array; Exp : in Field := Default_Exp)
                   return Field ;
   end Implementation ;

   package body Implementation is separate ;

   -------------------------------------------------------------------------------

   package Vector_Instance is new Implementation
     (Internal_Index => Vector_Ix, Internal_Array => Vector) ;
   procedure Interactive_Vector_Get is
      new Polite_Get (Item_Type => Vector, Decode => Get);

   type Row_Type is array (Matrix_Ix2 range <>) of Real ;
   package Matrix_Row_Instance is new Implementation
     (Internal_Index => Matrix_Ix2, Internal_Array => Row_Type) ;
   procedure Interactive_Row_Get is
      new Polite_Get (Item_Type => Row_Type, Decode => Matrix_Row_Instance.Get);

------------------------------------
--    Get a MATRIX from a FILE    --
------------------------------------

   procedure Get (File  : in Ada.Text_Io.File_Type;
                  Item  : out Matrix;
                  Width : in Field := 0) is
      Row_Value : Row_type (Item'Range (2)) ;
   begin
      for Row_Ix in Item'Range (1) loop
         Matrix_Row_Instance.Get (File, Row_Value, Width);      --  Acquire a "vector"
         for Ix in Row_Value'Range loop
            Item (Row_Ix, Ix) := Row_Value (Ix);
         end loop;
      end loop;
   end Get;

   -------------------------------------------------------------------------------
   --  GET a MATRIX from a Current_Input

   procedure Get (Item : out Matrix; Width : in Field := 0) is
   begin
      Get (File => Ada.Text_Io.Standard_Input, Item => Item, Width => Width) ;
   end Get ;

   -------------------------------------------------------------------------------
   --  Put a MATRIX to a FILE

   procedure Put (File : in Ada.Text_Io.File_Type;
                  Item : in Matrix;
                  Fore : in Field := Default_Fore;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp) is
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (2) loop
            Real_Io.Put
              (File, Item (I, J), Aft => Aft, Fore => Fore, Exp => Exp);
         end loop;
         Ada.Text_Io.New_Line (File);
      end loop;
      Ada.Text_Io.New_Line (File);
   end Put;

   -------------------------------------------------------------------------------
   --  Put a MATRIX to Current_Output

   procedure Put (Item : in Matrix;
                  Fore : in Field := Default_Fore;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp) is
   begin
      Put (File => Ada.Text_Io.Standard_Output,
           Item => Item,
           Fore => Fore,
           Aft  => Aft,
           Exp  => Exp) ;
   end Put ;

   -------------------------------------------------------------------------------
   --  Get a MATRIX from a STRING

   procedure Get (From : in String; Item : out Matrix; Last : out Positive) is
      Char_Ix    : Positive   := From'First;
      --  The From string has rows delimited by <CR><LF>
      Start_Row  : Positive   := From'First;    --  ix of beginning of a row
      End_Row    : Positive   := From'First;    --  ix of end of row
      Target_Row : Matrix_Ix1 := Item'First (1);         --  being read
      Row_Value  : Row_type (Item'Range (2)) ;
      --  Rows in the matrix are separated by 'carriage-return'&'line_feed'

   begin
      while Target_Row <= Item'Last (1) loop
         --  Find the substring in FROM that holds the target row's value
         while Char_Ix < From'Last and then
           From (Char_Ix + 1) /= Line_Terminator(1) loop
            Char_Ix := Char_Ix + 1;
         end loop;
         End_Row := Char_Ix;
         --  Read the substring (which is a vector value) into Row_Value.
         Matrix_Row_Instance.Get (From (Start_Row .. End_Row), Row_Value, Last);
         for Ix in Row_Value'Range loop
            Item (Target_Row, Ix) := Row_Value (Ix);
         end loop;
         exit when Target_Row = Item'Last(1) ;  -- item is complete

         -- go past the <CR><LF> that separates rows
         -- to find the beginning of the next row
         Start_Row := End_Row + 1;
         while Start_Row <= From'Last and then
           (From (Start_Row) = Line_Terminator(1) or
            From (Start_Row) = Line_Terminator(2)) loop
            Start_Row := Start_Row + 1;
         end loop;

         Target_Row := Matrix_Ix1'Succ (Target_Row) ;
         Char_Ix := Start_Row;
         exit when Char_Ix > From'Last;
      end loop;
      if Target_Row < Item'Last (1) then
         --  we ran out of characters before filling all the rows.
         --  An argument can be made against raising a predefined
         --  exception here, but it won't do to declare a specific
         --  exception owing to RM 11.2(8) <it couldn't be handled>
         raise Ada.Io_Exceptions.Data_Error ;
      end if;
   end Get;

   -------------------------------------------------------------------------------
   --  Put a MATRIX to a STRING

   procedure Put (To   : out String;
                  Item : in Matrix;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp) is

      use String_Pkg;
      Build_String : String_Type;
      Row_Value    : Row_type (Item'Range (2)) ;
      Single_Row   : String (1 .. (To'Length / Item'Length (1)) -
                             Line_Terminator'Length);
      Pad_Nuls     : Integer;
      Null_Char    : String (1 .. 1) := (others => Ascii.Nul);
   begin
      Mark;   -- heap management in "dynamic" string_pkg (predates Ada95)
      Build_String := Create ("");
      for I in Item'Range (1) loop
         --  Make and format a Row_Value into string Single_Row:
         for Ix in Item'Range (2) loop
            Row_Value (Ix) := Item (I, Ix);
         end loop;
         Matrix_Row_Instance.Put (Single_Row, Row_Value, Aft, Exp);
         --  Put the formatted row into the dynamic string
         Build_String := Build_String & Single_Row;
         --  Successive rows are placed on distinct lines:
         Build_String := Build_String & Line_Terminator;
      end loop;

      Pad_Nuls := Length (Build_String);
      while Pad_Nuls < To'Length loop
         Build_String := Build_String & Null_Char;
         Pad_Nuls := Pad_Nuls + 1;
      end loop;
      To (To'Range) := Value (Build_String);

      Release;  -- heap management
   end Put;

   -------------------------------------------------------------------------------
   --  Interactive procedure resembling POLITE_IO . GET

   procedure Get (Prompt : in String; Item : out Matrix) is
      Row_Value : Row_type (Item'Range (2)) ;
   begin
      begin
         Interactive_Row_Get (Prompt => Prompt, Item => Row_Value);
         for Ix in Row_Value'Range loop
            Item (item'First(1), Ix) := Row_Value (Ix);
         end loop;

         for Row_Ix in Matrix_Ix1'Succ (Item'First(1)) .. Item'Last (1) loop
            declare
               Row_Name : String := Matrix_Ix1'Image (Row_Ix);
            begin
               loop
                  begin
                     Interactive_Row_Get (Prompt => "Now the value for row " &
                                            Row_Name &
                                            ", please :",
                                          Item => Row_Value);
                     exit ;
                  exception
                     when No_Entry =>
                        Interacting_Put_Line ("No default is permitted for row " &
                                              Row_Name) ;
                  end ;
               end loop ;
               for Ix in Row_Value'Range loop
                  Item (Row_Ix, Ix) := Row_Value (Ix);
               end loop;
            end ;
         end loop ;
      exception
         when No_Entry =>
            Interacting_Put_Line (You_Must_Line) ;
      end ;
   end Get;

   -------------------------------------------------------------------------------
   --  Interactive Get with a default value:

   procedure Get (Prompt  : in String;
                  Default : in Matrix;
                  Item    : out Matrix) is
      Signif             : constant Positive := Aft (Default);
      Length_For_Element : constant Positive := Signif + 9 ;
      Def_Str            : String (1 .. Length_For_Element * Default'Length (1) *
                                   Default'Length (2));
      Row_Value          : Row_type (Item'Range (2)) ;
   begin
      Put (Def_Str, Default, Exp => 3, Aft => Signif);
      Interactive_Row_Get (Row_Value, Prompt & " [" & Line_Terminator &
                           Def_Str & "]" & Line_Terminator);
      for Ix in Row_Value'Range loop
         Item (Matrix_Ix1'First, Ix) := Row_Value (Ix);
      end loop;
      for Row_Ix in Matrix_Ix1'Succ (Matrix_Ix1'First) .. Item'Last (1) loop
         declare
            Row_Name : String := Matrix_Ix1'Image (Row_Ix);
         begin
            loop
               begin  -- insist that rows after the first may not default
                  Interactive_Row_Get (Row_Value,
                                       "Now the value for row " &
                                       Row_Name & ", please :");
                  exit;  -- From insistent loop, after accepting one row
               exception
                  when No_Entry =>
                     Interacting_Put_Line
                       ("Default can ONLY be accepted before ANY row is given.");
               end;
            end loop;  -- insistent loop has accepted a single row.
                       --  Move the values in the row just accepted into the Item
            for Ix in Row_Value'Range loop
               Item (Row_Ix, Ix) := Row_Value (Ix);
            end loop;
         end ;    -- scope of name denoting this row
      end loop;   -- all rows accounted for....
   exception
      when No_Entry =>
         Item := Default;   --  Acceptable only at the beginning
   end Get;

   -------------------------------------------------------------------------------
   --  Compute significant digits required for output

   function Aft (Item : in Matrix; Exp : in Field := Default_Exp)
                return Field is
      --  Aft is an aid to formatting a matrix;
      --  It computes the value for the (scalar) AFT parameter that will
      --  write just the significant part of each element in a matrix
      --  while maintaining columns in alignment.
      Single    : Positive;
      Enough    : Natural := 0;
      Row_Value : Row_type (Item'Range (2)) ;
   begin
      for I in Item'Range (1) loop
         for J in Item'Range (2) loop
            Row_Value (J) := Item (I, J);
         end loop;
         Single := Matrix_Row_Instance.Aft (Row_Value, Exp);
         if Enough < Single then
            Enough := Single;
         end if;
      end loop;

      return Enough;
   end Aft;

   -------------------------------------------------------------------------------
   --  O P E R A T I O N S     O N     V E C T O R S

   --  Get a Vector from a FILE
   procedure Get (File  : in Ada.Text_Io.File_Type;
                  Item  : out Vector;
                  Width : in Field := 0)
     renames Vector_Instance.Get ;

   -------------------------------------------------------------------------------
   --  Get a VECTOR from Current_Input

   procedure Get (Item : out Vector; Width : in Field := 0) is
   begin
      Get (File  => Ada.Text_Io.Standard_Input,
           Item  => Item,
           Width => Width) ;
   end Get ;

   -------------------------------------------------------------------------------
   --  Put a VECTOR to a FILE

   procedure Put (File : in Ada.Text_Io.File_Type;
                  Item : in Vector;
                  Fore : in Field := Default_Fore;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp) is
   begin
      for I in Item'Range (1) loop
         Real_Io.Put (File, Item (I), Aft => Aft, Fore => Fore, Exp => Exp);
      end loop;
   end Put;

   -------------------------------------------------------------------------------
   --  Put a VECTOR to Current_Output

   procedure Put (Item : in Vector;
                  Fore : in Field := Default_Fore;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp) is
   begin
      Put (File => Ada.Text_Io.Standard_Output,
           Item => Item,
           Fore => Fore,
           Aft  => Aft,
           Exp  => Exp) ;
   end Put ;

   -------------------------------------------------------------------------------
   --  Get a VECTOR from a STRING

   procedure Get (From : in String; Item : out Vector; Last : out Positive)
     renames Vector_Instance.Get ;

   -------------------------------------------------------------------------------
   --  Put a VECTOR to a STRING
   procedure Put (To   : out String;
                  Item : in Vector;
                  Aft  : in Field := Default_Aft;
                  Exp  : in Field := Default_Exp)
     renames Vector_Instance.Put ;

   -------------------------------------------------------------------------------
   --  Interactive GET of a VECTOR

   procedure Get (Prompt : in String; Item : out Vector) is
   begin
      loop
         begin
            Interactive_Vector_Get (Item, Prompt);
            exit;
         exception
            when No_Entry =>
               Interacting_Put_Line (You_Must_Line) ;
         end;
      end loop;
   end Get;

   -------------------------------------------------------------------------------
   --  Interactive GET with DEFAULT

   procedure Get (Prompt  : in String;
                  Default : in Vector;
                  Item    : out Vector) is
      Signif  : Positive := Aft (Default);
      Def_Str : String (1 .. (Signif + 8) *
                        Default'Length);  -- formatted default
   begin
      Put (Def_Str, Default, Exp => 3, Aft => Aft (Default));
      Interactive_Vector_Get (Item,
                              Prompt & " [" & Def_Str & "]" & Line_Terminator);
   exception
      when No_Entry =>
         Item := Default;
   end Get;

   -------------------------------------------------------------------------------
   --  Compute significant digits for a VECTOR

   function Aft (Item : in Vector; Exp : in Field := Default_Exp)
                return Field
     renames Vector_Instance.Aft ;

end Numeric_Io.Matrix_IO ;


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

