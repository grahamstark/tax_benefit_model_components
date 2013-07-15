------------------------------------------------------------------------
--
--                       INDEXED_SEQUENTIAL_IO
--
--      $Id: indexed_sequential_io.adb,v 1.43 1999/10/08 20:54:35 matt Exp $
--
-- Copyright (C) 1999 Matthew J Heaney <matthew_heaney@acm.org>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or (at
-- your option) any later version.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-- USA
--
-- As a special exception, if other files instantiate this generic unit,
-- or you link this unit with other files to produce an executable, this
-- unit does not by itself cause the resulting executable to be covered
-- by the GNU General Public License.  This exception does not however
-- invalidate any other reasons why the executable file might be covered
-- by the GNU Public License.
--
------------------------------------------------------------------------

with Ada.Unchecked_Conversion;
with Ada.Text_IO; 

package body Indexed_Sequential_IO is

   -- The indexed sequential file is implemented using a B+ tree.  My
   -- primary references were:
   --
   -- File Structures, 2nd ed
   -- Michael J. Folk, Bill Zoellick
   -- Addison-Wesley 1992
   --
   -- Organization and Maintenance of Large Ordered Indexes
   -- R. Bayer, E. McCreight
   -- Acta Informatica, Vol 1 (1972), p 173-189
   --
   -- The Ubiquitous B-Tree
   -- Douglas Comer
   -- Computing Surveys, Vol 11, No 2 (June 1979), p. 121-137


   procedure Insert_In_Tree
     (File                 : in out Stream_IO.File_Type;
      Root_Page_File_Index : in     Stream_IO.Positive_Count;
      Root_Page            : in out Index_Page_Type;
      Insertion_Key        : in     Key_Type;
      Insertion_Item       : in     Item_Type;
      Promotion            :    out Boolean;
      Promoted_Key         : in out Key_Type;
      Promoted_Right_Child : in out Stream_IO.Positive_Count);

   procedure Remove_From_Tree
     (File            : in out Stream_IO.File_Type;
      Page_File_Index : in     Stream_IO.Positive_Count;
      Page            : in out Index_Page_Type;
      Key             : in     Key_Type;
      Underflow       :    out Boolean);


   use Stream_IO;

   --------------------
   -- Index Page I/O --
   --------------------

   procedure Write
     (File : in Stream_IO.File_Type;
      Page : in Index_Page_Type;
      To   : in Stream_IO.Positive_Count) is

      Size : constant Stream_Element_Offset :=
        Page'Size / Stream_Element_Array'Component_Size;

      subtype Page_As_Stream_Element_Array is
        Stream_Element_Array (1 .. Size);

      function To_Stream_Element_Array is
        new Ada.Unchecked_Conversion
        (Index_Page_Type,
         Page_As_Stream_Element_Array);
   begin
      Write (File, To_Stream_Element_Array (Page), To);
   end;


   procedure Append
     (File       : in out Stream_IO.File_Type;
      Page       : in     Index_Page_Type;
      File_Index :    out Stream_IO.Positive_Count) is

      Size : constant Stream_Element_Offset :=
        Page'Size / Stream_Element_Array'Component_Size;

      subtype Page_As_Stream_Element_Array is
        Stream_Element_Array (1 .. Size);

      function To_Stream_Element_Array is
        new Ada.Unchecked_Conversion
        (Index_Page_Type,
         Page_As_Stream_Element_Array);
   begin
      Set_Mode (File, Append_File);
      File_Index := Index (File);
      Write (File, To_Stream_Element_Array (Page));
   end;


   procedure Read
     (File : in     Stream_IO.File_Type;
      Page :    out Index_Page_Type;
      From : in     Stream_IO.Positive_Count) is

      Size : constant Stream_Element_Count :=
        Page'Size / Stream_Element_Array'Component_Size;

      Page_As_Stream_Elements : Stream_Element_Array (1 .. Size);
      for Page_As_Stream_Elements'Address use Page'Address;

      pragma Assert
        (Page_As_Stream_Elements'Size = Page'Size,
         "index page size /= stream element array size");

--       pragma Assert
--         (Index_Page_Type'Object_Size =
--          Index_Page_As_Stream_Element_Array'Object_Size,
--          "index page object size /= stream elem array object size");

      Last : Ada.Streams.Stream_Element_Offset;
   begin
      pragma Assert( Is_Open( file ), "file not open" );
      Ada.Text_IO.Put_Line( "last " & Last'Img & " From " & From'Img );
      Read (File, Page_As_Stream_Elements, Last, From);
      pragma Assert (Last = Page_As_Stream_Elements'Last);
   end;



   -----------------------
   -- Sequence Page I/O --
   -----------------------

   procedure Write
     (File : in Stream_IO.File_Type;
      Page : in Sequence_Page_Type;
      To   : in Stream_IO.Positive_Count) is

      Size : constant Stream_Element_Offset :=
        Page'Size / Stream_Element_Array'Component_Size;

      subtype Page_As_Stream_Element_Array is
        Stream_Element_Array (1 .. Size);

      function To_Stream_Element_Array is
        new Ada.Unchecked_Conversion
        (Sequence_Page_Type,
         Page_As_Stream_Element_Array);
   begin
      Write (File, To_Stream_Element_Array (Page), To);
   end;


   procedure Append
     (File       : in out Stream_IO.File_Type;
      Page       : in     Sequence_Page_Type;
      File_Index :    out Stream_IO.Positive_Count) is

      Size : constant Stream_Element_Offset :=
        Page'Size / Stream_Element_Array'Component_Size;

      subtype Page_As_Stream_Element_Array is
        Stream_Element_Array (1 .. Size);

      function To_Stream_Element_Array is
        new Ada.Unchecked_Conversion
        (Sequence_Page_Type,
         Page_As_Stream_Element_Array);
   begin
      Set_Mode (File, Append_File);
      File_Index := Index (File);
      Write (File, To_Stream_Element_Array (Page));
   end;


   procedure Read
     (File : in     Stream_IO.File_Type;
      Page :    out Sequence_Page_Type;
      From : in     Stream_IO.Positive_Count) is

      Size : constant Stream_Element_Offset :=
        Page'Size / Stream_Element_Array'Component_Size;

      Page_As_Stream_Elements : Stream_Element_Array (1 .. Size);
      for Page_As_Stream_Elements'Address use Page'Address;

      pragma Assert
        (Page_As_Stream_Elements'Size = Page'Size,
         "sequence page size /= stream element array size");

--       pragma Assert
--         (Sequence_Page_Type'Object_Size =
--          Sequence_Page_As_Stream_Element_Array'Object_Size,
--          "sequence page object size /= stream element array object size");

      Last : Ada.Streams.Stream_Element_Offset;
   begin
      Read (File, Page_As_Stream_Elements, Last, From);
      pragma Assert (Last = Page_As_Stream_Elements'Last);
   end;



   procedure Create
     (File : in out File_Type;
      Name : in     String := "") is

      Sequence_Page_File_Index : Stream_IO.Positive_Count;

   begin

      Create (File.File, Out_File, Name);
      pragma Assert (Index (File.File) = 1);

      -- Allocate disk space for root (index) page file index by writing a
      -- dummy file index value.

      Count'Write (Stream (File.File), 0);


      -- Allocate disk space for an empty sequence page.

      File.Sequence_Page.Length := 0;
      File.Sequence_Page.Next := 0;

      Append
        (File       => File.File,
         Page       => File.Sequence_Page,
         File_Index => Sequence_Page_File_Index);


      -- Allocate disk space for the root index page itself, and get the
      -- file index of the root page.

      File.Root_Page.Length := 0;
      File.Root_Page.Is_Leaf := True;
      File.Root_Page.Children (0) := Sequence_Page_File_Index;

      Append
        (File       => File.File,
         Page       => File.Root_Page,
         File_Index => File.Root_Page_File_Index);


      -- Now write the file index of the root page.

      Reset (File.File);
      Count'Write (Stream (File.File), File.Root_Page_File_Index);

      File.End_Of_File_Status := Undefined;

   end Create;


   procedure Open
     (File : in out File_Type;
      Name : in     String) is
   begin

      Open (File.File, In_File, Name);
      pragma Assert (Index (File.File) = 1);
      -- Count'Read (Stream (File.File), File.Root_Page_File_Index);

      Read (File.File, File.Root_Page, File.Root_Page_File_Index);

      File.End_Of_File_Status := Undefined;

   end Open;


   procedure Close
     (File : in out File_Type) is
   begin
      Stream_IO.Close (File.File);
   end;


   function Is_Open
     (File : File_Type) return Boolean is
   begin
      return Stream_IO.Is_Open (File.File);
   end;


   procedure Reset
     (File : in out File_Type) is

      File_Index : Stream_IO.Positive_Count :=
        File.Root_Page.Children (0);

      Index_Page : Index_Page_Type;

   begin

      Set_Mode (File.File, In_File);

      if not File.Root_Page.Is_Leaf then

         loop

            Read
              (File => File.File,
               Page => Index_Page,
               From => File_Index);

            File_Index := Index_Page.Children (0);

            exit when Index_Page.Is_Leaf;

         end loop;

      end if;

      Read
        (File => File.File,
         Page => File.Sequence_Page,
         From => File_Index);

      File.Index := 1;

      if File.Index > File.Sequence_Page.Length then
         File.End_Of_File_Status := Yes;
      else
         File.End_Of_File_Status := No;
      end if;

   end Reset;


   procedure Reset
     (File : in out File_Type;
      Key  : in     Key_Type) is

      Index : Natural;
      Found : Boolean;

      File_Index : Stream_IO.Positive_Count;

      Index_Page : Index_Page_Type;

      Sequence_Page : Sequence_Page_Type renames File.Sequence_Page;

   begin -- Reset

      Set_Mode (File.File, In_File);

      Search
        (Keys  => File.Root_Page.Keys (1 .. File.Root_Page.Length),
         Key   => Key,
         Index => Index);

      File_Index := File.Root_Page.Children (Index);

      if not File.Root_Page.Is_Leaf then

         loop

            Read
              (File => File.File,
               Page => Index_Page,
               From => File_Index);

            Search
              (Keys  => Index_Page.Keys (1 .. Index_Page.Length),
               Key   => Key,
               Index => Index);

            File_Index := Index_Page.Children (Index);

            exit when Index_Page.Is_Leaf;

         end loop;

      end if;

      Read
        (File => File.File,
         Page => Sequence_Page,
         From => File_Index);

      Search
        (Items => Sequence_Page.Items (1 .. Sequence_Page.Length),
         Key   => Key,
         Index => Index,
         Found => Found);

      if Found then

         File.Index := Index;

         File.End_Of_File_Status := No;

      elsif Index = Sequence_Page.Length then

         -- The Key is larger than every other key on this page, meaning
         -- that we're pointed at the largest key smaller then Key.  We
         -- want Reset to designate the smallest key larger than Key, but
         -- that's on the next sequence page.

         if Sequence_Page.Next = 0 then

            File.End_Of_File_Status := Yes;

         else

            Read
              (File => File.File,
               Page => Sequence_Page,
               From => Sequence_Page.Next);

            File.Index := 1;

            File.End_Of_File_Status := No;

         end if;

      else

         -- The Key is not larger than every other key on this sequence
         -- page.  But because of the nature of Search, Index designates
         -- the largest key smaller than Key.  As explained above, we want
         -- Reset to designate the smallest key larger than Key.

         File.Index := Index + 1;

         File.End_Of_File_Status := No;

      end if;

   end Reset;



   procedure Read
     (File : in     File_Type;
      Item :    out Item_Type) is

      I : Positive renames File.Handle.File.Index;

   begin

      pragma Assert (File.End_Of_File_Status = No);

      Item := File.Sequence_Page.Items (I);

      I := I + 1;

      if I > File.Sequence_Page.Length then

         if File.Sequence_Page.Next = 0 then

            File.Handle.File.End_Of_File_Status := Yes;

         else

            Read
              (File => File.File,
               Page => File.Handle.File.Sequence_Page,
               From => File.Sequence_Page.Next);

            I := 1;

         end if;

      end if;

   end Read;


   function End_Of_File
     (File : File_Type) return Boolean is
   begin
      pragma Assert (File.End_Of_File_Status /= Undefined);
      return File.End_Of_File_Status = Yes;
   end;



   procedure Read
     (File : in     File_Type;
      Key  : in     Key_Type;
      Item :    out Item_Type) is

      Index : Natural;
      Found : Boolean;

      File_Index : Stream_IO.Positive_Count;

      Index_Page : Index_Page_Type;

      Sequence_Page : Sequence_Page_Type;

   begin

      Set_Mode (File.Handle.File.File, In_File);

      Search
        (Keys  => File.Root_Page.Keys (1 .. File.Root_Page.Length),
         Key   => Key,
         Index => Index);

      File_Index := File.Root_Page.Children (Index);

      if not File.Root_Page.Is_Leaf then

         loop

            Read
              (File => File.File,
               Page => Index_Page,
               From => File_Index);

            Search
              (Keys  => Index_Page.Keys (1 .. Index_Page.Length),
               Key   => Key,
               Index => Index);

            File_Index := Index_Page.Children (Index);

            exit when Index_Page.Is_Leaf;

         end loop;

      end if;

      Read
        (File => File.File,
         Page => Sequence_Page,
         From => File_Index);

      Search
        (Items => Sequence_Page.Items (1 .. Sequence_Page.Length),
         Key   => Key,
         Index => Index,
         Found => Found);

      if not Found then
         raise Item_Not_Found;
      end if;

      Item := Sequence_Page.Items (Index);

   end Read;



   procedure Do_Write
     (File : in out File_Type;
      Item : in     Item_Type) is

      Promotion : Boolean;

      Key_Promoted_From_Below         : Key_Type;
      Right_Child_Promoted_From_Below : Stream_IO.Positive_Count;

   begin

      File.End_Of_File_Status := Undefined;

      Set_Mode (File.File, In_File);

      Insert_In_Tree
        (File                 => File.File,
         Root_Page_File_Index => File.Root_Page_File_Index,
         Root_Page            => File.Root_Page,
         Insertion_Key        => Get_Key (Item),
         Insertion_Item       => Item,
         Promotion            => Promotion,
         Promoted_Key         => Key_Promoted_From_Below,
         Promoted_Right_Child => Right_Child_Promoted_From_Below);

      if not Promotion then
         return;
      end if;


      -- There's been a promotion, up from the root page, which means the
      -- height of the tree has just increased.  Create a new root page, to
      -- store the promoted item.

      File.Root_Page.Keys (1) := Key_Promoted_From_Below;

      File.Root_Page.Children (0) := File.Root_Page_File_Index;
      File.Root_Page.Children (1) := Right_Child_Promoted_From_Below;

      File.Root_Page.Length := 1;

      File.Root_Page.Is_Leaf := False;


      -- Write the new root page to disk, and record its file index.
      Append (File.File, File.Root_Page, File.Root_Page_File_Index);

      -- Write the file index of the new root page to disk.
      Reset (File.File);
      Count'Write (Stream (File.File), File.Root_Page_File_Index);

      Flush (File.File);

   end Do_Write;


   procedure Write
     (File : in File_Type;
      Item : in Item_Type) is
   begin
      Do_Write (File.Handle.File.all, Item);
   end;


   procedure Do_Remove
     (File : in out File_Type;
      Key  : in     Key_Type) is

      Underflow : Boolean;

   begin

      File.End_Of_File_Status := Undefined;

      Set_Mode (File.File, In_File);

      Remove_From_Tree
        (File            => File.File,
         Page_File_Index => File.Root_Page_File_Index,
         Page            => File.Root_Page,
         Key             => Key,
         Underflow       => Underflow);

      if Underflow then

         if File.Root_Page.Length = 0
           and not File.Root_Page.Is_Leaf
         then

            --
            -- Reduce the height of the tree.
            --

            File.Root_Page_File_Index := File.Root_Page.Children (0);
            --
            -- This throws away whatever page was designated by
            -- Root_Page_File_Index, leaving a "hole" in the file.

            Reset (File.File, Out_File);

            Count'Write (Stream (File.File), File.Root_Page_File_Index);


            Set_Mode (File.File, In_File);

            Read
              (File => File.File,
               Page => File.Root_Page,
               From => File.Root_Page_File_Index);

         else

            --
            -- Just save the root page, without reducing the height.
            --

            Set_Mode (File.File, Out_File);

            Write (File.File, File.Root_Page, File.Root_Page_File_Index);

         end if;

      end if;


      Set_Mode (File.File, Out_File);

      Flush (File.File);

   end Do_Remove;


   procedure Remove
     (File : in File_Type;
      Key  : in Key_Type) is
   begin
      Do_Remove (File.Handle.File.all, Key);
   end;




   -------------------------
   -- Index Set Insertion --
   -------------------------

   procedure Insert_In_Split_Index_Page
     (File                  : in out Stream_IO.File_Type;
      Page_File_Index       : in     Stream_IO.Positive_Count;
      Page                  : in out Index_Page_Type;
      Index                 : in     Natural;
      Insertion_Key         : in     Key_Type;
      Insertion_Right_Child : in     Stream_IO.Positive_Count;
      Promoted_Key          :    out Key_Type;
      Promoted_Right_Child  :    out Stream_IO.Positive_Count) is

      New_Right_Sibling : Index_Page_Type;
      -- This is the page whose file index is Promoted_Right_Child.

   begin

      New_Right_Sibling.Is_Leaf := Page.Is_Leaf;

      if Index < Index_Order then

         Promoted_Key := Page.Keys (Index_Order);


         New_Right_Sibling.Keys (1 .. Index_Order) :=
           Page.Keys (Index_Order + 1 .. Index_Page_Size);

         New_Right_Sibling.Children (0 .. Index_Order) :=
           Page.Children (Index_Order .. Index_Page_Size);


         Page.Keys (Index + 1 .. Index_Order) :=
           Insertion_Key &
           Page.Keys (Index + 1 .. Index_Order - 1);

         Page.Children (Index + 1 .. Index_Order) :=
           Insertion_Right_Child &
           Page.Children (Index + 1 .. Index_Order - 1);


      elsif Index = Index_Order then

         Promoted_Key := Insertion_Key;


         New_Right_Sibling.Keys (1 .. Index_Order) :=
           Page.Keys (Index_Order + 1 .. Index_Page_Size);

         New_Right_Sibling.Children (0 .. Index_Order) :=
           Insertion_Right_Child &
           Page.Children (Index_Order + 1 .. Index_Page_Size);


      else

         Promoted_Key := Page.Keys (Index_Order + 1);


         New_Right_Sibling.Keys (1 .. Index_Order) :=
           Page.Keys (Index_Order + 2 .. Index) &
           Insertion_Key &
           Page.Keys (Index + 1 .. Index_Page_Size);

         New_Right_Sibling.Children (0 .. Index_Order) :=
           Page.Children (Index_Order + 1 .. Index) &
           Insertion_Right_Child &
           Page.Children (Index + 1 .. Index_Page_Size);


      end if;

      Page.Length := Index_Order;
      New_Right_Sibling.Length := Index_Order;

      Append (File, New_Right_Sibling, Promoted_Right_Child);
      Write (File, Page, Page_File_Index);

   end Insert_In_Split_Index_Page;


   procedure Insert_In_Index_Page
     (File                  : in out Stream_IO.File_Type;
      Page_File_Index       : in     Stream_IO.Positive_Count;
      Page                  : in out Index_Page_Type;
      Index                 : in     Natural;
      Insertion_Key         : in     Key_Type;
      Insertion_Right_Child : in     Stream_IO.Positive_Count) is

   begin

      Page.Keys (Index + 1 .. Page.Length + 1) :=
        Insertion_Key &
        Page.Keys (Index + 1 .. Page.Length);

      Page.Children (Index + 1 .. Page.Length + 1) :=
        Insertion_Right_Child &
        Page.Children (Index + 1 .. Page.Length);

      Page.Length := Page.Length + 1;


      Set_Mode (File, Out_File);
      Write (File, Page, Page_File_Index);

   end Insert_In_Index_Page;


   procedure Insert_In_Index_Page_And_Right_Sibling
     (File                  : in out Stream_IO.File_Type;
      Parent_File_Index     : in     Stream_IO.Positive_Count;
      Parent                : in out Index_Page_Type;
      Left_Index            : in     Child_Range;
      Left                  : in out Index_Page_Type;
      Right                 : in out Index_Page_Type;
      Index                 : in     Natural;
      Insertion_Key         : in     Key_Type;
      Insertion_Right_Child : in     Stream_IO.Positive_Count) is

      pragma Assert (Left.Length = Index_Page_Size);

      Parent_Key : Key_Type renames
        Parent.Keys (Left_Index + 1);

      Empty_Slots_Count : constant Positive :=
        Index_Page_Size - Right.Length;
      -- The total number of free slots in the right sibling.

      Move_Count : constant Positive :=
        Integer'Max (1, Empty_Slots_Count / 2);
      -- The number of items we can move (from the left sibling, the
      -- parent, and the insertion item itself) into the right sibling.

      Parent_Key_Index : constant Positive :=
        Index_Page_Size - Move_Count + 1;
      -- The index of the key that moves up, into the parent.

      Left_File_Index : Stream_IO.Count renames
        Parent.Children (Left_Index);

      Right_File_Index : Stream_IO.Count renames
        Parent.Children (Left_Index + 1);

   begin

      if Index < Parent_Key_Index then

         -- The insertion key goes in the left sibling.

         Right.Keys (1 .. Right.Length + Move_Count) :=
           Left.Keys (Parent_Key_Index + 1 .. Index_Page_Size) &
           Parent_Key &
           Right.Keys (1 .. Right.Length);

         Right.Children (0 .. Right.Length + Move_Count) :=
           Left.Children (Parent_Key_Index .. Index_Page_Size) &
           Right.Children (0 .. Right.Length);

         Parent_Key := Left.Keys (Parent_Key_Index);

         Left.Keys (Index + 1 .. Parent_Key_Index) :=
           Insertion_Key &
           Left.Keys (Index + 1 .. Parent_Key_Index - 1);

         Left.Children (Index + 1 .. Parent_Key_Index) :=
           Insertion_Right_Child &
           Left.Children (Index + 1 .. Parent_Key_Index - 1);

      elsif Index = Parent_Key_Index then

         -- The insertion key moves up into the parent.

         Right.Keys (1 .. Right.Length + Move_Count) :=
           Left.Keys (Index + 1 .. Index_Page_Size) &
           Parent_Key &
           Right.Keys (1 .. Right.Length);

         Right.Children (0 .. Right.Length + Move_Count) :=
           Insertion_Right_Child &
           Left.Children (Index + 1 .. Index_Page_Size) &
           Right.Children (0 .. Right.Length);

         Parent_Key := Insertion_Key;

      else

         -- The insertion key goes in the right sibling.

         Right.Keys (1 .. Right.Length + Move_Count) :=
           Left.Keys (Parent_Key_Index + 2 .. Index) &
           Insertion_Key &
           Left.Keys (Index + 1 .. Index_Page_Size) &
           Parent_Key &
           Right.Keys (1 .. Right.Length);

         Right.Children (0 .. Right.Length + Move_Count) :=
           Left.Children (Parent_Key_Index + 1 .. Index) &
           Insertion_Right_Child &
           Left.Children (Index + 1 .. Index_Page_Size) &
           Right.Children (0 .. Right.Length);

         Parent_Key := Left.Keys (Parent_Key_Index + 1);

      end if;

      Left.Length := Left.Length - Move_Count + 1;
      Right.Length := Right.Length + Move_Count;


      Set_Mode (File, Out_File);

      Write (File, Parent, Parent_File_Index);
      Write (File, Left, Left_File_Index);
      Write (File, Right, Right_File_Index);

   end Insert_In_Index_Page_And_Right_Sibling;


   procedure Insert_In_Index_Page_And_Left_Sibling
     (File                  : in out Stream_IO.File_Type;
      Parent_File_Index     : in     Stream_IO.Positive_Count;
      Parent                : in out Index_Page_Type;
      Left                  : in out Index_Page_Type;
      Right_Index           : in     Natural;
      Right                 : in out Index_Page_Type;
      Index                 : in     Natural;
      Insertion_Key         : in     Key_Type;
      Insertion_Right_Child : in     Stream_IO.Positive_Count) is

      pragma Assert (Right.Length = Index_Page_Size);

      Parent_Key : Key_Type renames
        Parent.Keys (Right_Index);

      Empty_Slots_Count : constant Positive :=
        Index_Page_Size - Left.Length;
      --
      -- The total number of free slots in the left sibling.

      Move_Count : constant Positive :=
        Integer'Max (1, Empty_Slots_Count / 2);
      --
      -- The number of items that actually move.

      Parent_Key_Index : constant Natural := Move_Count - 1;
      --
      -- Index position of key on right page that will move up into parent
      -- page.

      Left_File_Index : Stream_IO.Count renames
        Parent.Children (Right_Index - 1);

      Right_File_Index : Stream_IO.Count renames
        Parent.Children (Right_Index);

   begin

      if Index < Parent_Key_Index then

         -- Insertion_Key goes in left sibling.

         Left.Keys (Left.Length + 1 .. Left.Length + Move_Count) :=
           Parent_Key &
           Right.Keys (1 .. Index) &
           Insertion_Key &
           Right.Keys (Index + 1 .. Move_Count - 2);

         Left.Children (Left.Length + 1 .. Left.Length + Move_Count) :=
           Right.Children (0 .. Index) &
           Insertion_Right_Child &
           Right.Children (Index + 1 .. Move_Count - 2);

         Parent_Key := Right.Keys (Move_Count - 1);

         Right.Keys (1 .. Right.Length - Move_Count + 1) :=
           Right.Keys (Move_Count .. Right.Length);

         Right.Children (0 .. Right.Length - Move_Count + 1) :=
           Right.Children (Move_Count - 1 .. Right.Length);

      elsif Index = Parent_Key_Index then

         -- Insertion_Key goes in parent page.

         Left.Keys (Left.Length + 1 .. Left.Length + Move_Count) :=
           Parent_Key &
           Right.Keys (1 .. Move_Count - 1);

         Left.Children (Left.Length + 1 .. Left.Length + Move_Count) :=
           Right.Children (0 .. Move_Count - 1);

         Parent_Key := Insertion_Key;

         Right.Keys (1 .. Right.Length - Move_Count + 1) :=
           Right.Keys (Move_Count .. Right.Length);

         Right.Children (0 .. Right.Length - Move_Count + 1) :=
           Insertion_Right_Child &
           Right.Children (Move_Count .. Right.Length);

      else

         -- Insertion_Key goes in right sibling.

         Left.Keys (Left.Length + 1 .. Left.Length + Move_Count) :=
           Parent_Key &
           Right.Keys (1 .. Move_Count - 1);

         Left.Children (Left.Length + 1 .. Left.Length + Move_Count) :=
           Right.Children (0 .. Move_Count - 1);

         Parent_Key := Right.Keys (Move_Count);

         Right.Keys (1 .. Right.Length - Move_Count + 1) :=
           Right.Keys (Move_Count + 1 .. Index) &
           Insertion_Key &
           Right.Keys (Index + 1 .. Right.Length);

         Right.Children (0 .. Right.Length - Move_Count + 1) :=
           Right.Children (Move_Count .. Index) &
           Insertion_Right_Child &
           Right.Children (Index + 1 .. Right.Length);

      end if;

      Left.Length := Left.Length + Move_Count;
      Right.Length := Right.Length - Move_Count + 1;


      Set_Mode (File, Out_File);

      Write (File, Parent, Parent_File_Index);
      Write (File, Left, Left_File_Index);
      Write (File, Right, Right_File_Index);

   end Insert_In_Index_Page_And_Left_Sibling;


   procedure Insert_In_Sequence_Set
     (File                 : in out Stream_IO.File_Type;
      Parent_File_Index    : in     Stream_IO.Positive_Count;
      Parent               : in out Index_Page_Type;
      Child_Index          : in     Child_Range;
      Insertion_Key        : in     Key_Type;
      Insertion_Item       : in     Item_Type;
      Promotion            :    out Boolean;
      Promoted_Key         : in out Key_Type;
      Promoted_Right_Child : in out Stream_IO.Positive_Count);


   procedure Insert_In_Subtree
     (File                 : in out Stream_IO.File_Type;
      Parent_File_Index    : in     Stream_IO.Positive_Count;
      Parent               : in out Index_Page_Type;
      Page_Index           : in     Child_Range;
      Insertion_Key        : in     Key_Type;
      Insertion_Item       : in     Item_Type;
      Promotion            :    out Boolean;
      Promoted_Key         : in out Key_Type;
      Promoted_Right_Child : in out Stream_IO.Positive_Count) is

      Sibling : Index_Page_Type;

      function Get_Sibling
        (Sibling_Index : Child_Range) return Positive is
      begin
         Set_Mode (File, In_File);
         Read (File, Sibling, Parent.Children (Sibling_Index));
         return Sibling.Length;
      end;

      Page_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Page_Index);

      Page : Index_Page_Type;

      Search_Index : Natural;

      Key_Promoted_From_Below         : Key_Type;
      Right_Child_Promoted_From_Below : Stream_IO.Positive_Count;

   begin

      Read (File, Page, Page_File_Index);

      Search
        (Keys  => Page.Keys (1 .. Page.Length),
         Key   => Insertion_Key,
         Index => Search_Index);

      if Page.Is_Leaf then

         Insert_In_Sequence_Set
           (File                 => File,
            Parent_File_Index    => Page_File_Index,
            Parent               => Page,
            Child_Index          => Search_Index,
            Insertion_Key        => Insertion_Key,
            Insertion_Item       => Insertion_Item,
            Promotion            => Promotion,
            Promoted_Key         => Key_Promoted_From_Below,
            Promoted_Right_Child => Right_Child_Promoted_From_Below);

      else

         Insert_In_Subtree
           (File                 => File,
            Parent_File_Index    => Page_File_Index,
            Parent               => Page,
            Page_Index           => Search_Index,
            Insertion_Key        => Insertion_Key,
            Insertion_Item       => Insertion_Item,
            Promotion            => Promotion,
            Promoted_Key         => Key_Promoted_From_Below,
            Promoted_Right_Child => Right_Child_Promoted_From_Below);

      end if;


      if not Promotion then
         return;
      end if;


      -- The key was inserted in the child subtree, but a split occurred
      -- and another key was promoted up from below.  Insertion of the
      -- key is handled as follows:
      --
      -- 1) Insert the promoted key in this page if there's room.
      --
      -- 2) Insert the key in a sibling if there's room.
      --
      -- 3) Otherwise, split this page and promote the middle key up into
      -- our parent.
      --
      -- The idea is that we want to delay splitting a node for as long as
      -- possible.  This increases the space efficiency, and minimizes the
      -- height of the tree.

      if Page.Length < Index_Page_Size then

         Insert_In_Index_Page
           (File                  => File,
            Page_File_Index       => Page_File_Index,
            Page                  => Page,
            Index                 => Search_Index,
            Insertion_Key         => Key_Promoted_From_Below,
            Insertion_Right_Child => Right_Child_Promoted_From_Below);

         Promotion := False;


      elsif Page_Index = 0 then

          -- This is the left-most child of the parent, and therefore has no
          -- left sibling.  Redistribute with the right sibling if possible.

         if Get_Sibling (1) < Index_Page_Size then

            Insert_In_Index_Page_And_Right_Sibling
              (File                  => File,
               Parent_File_Index     => Parent_File_Index,
               Parent                => Parent,
               Left_Index            => Page_Index,
               Left                  => Page,
               Right                 => Sibling,
               Index                 => Search_Index,
               Insertion_Key         => Key_Promoted_From_Below,
               Insertion_Right_Child => Right_Child_Promoted_From_Below);

            Promotion := False;

         else

            Insert_In_Split_Index_Page
              (File                  => File,
               Page_File_Index       => Page_File_Index,
               Page                  => Page,
               Index                 => Search_Index,
               Insertion_Key         => Key_Promoted_From_Below,
               Insertion_Right_Child => Right_Child_Promoted_From_Below,
               Promoted_Key          => Promoted_Key,
               Promoted_Right_Child  => Promoted_Right_Child);

          end if;


      elsif Page_Index = Parent.Length then

         -- This is the right-most child of the parent, and therefore has no
         -- right sibling.  Redistribute with the left sibling if possible.

         if Get_Sibling (Page_Index - 1) < Index_Page_Size then

            Insert_In_Index_Page_And_Left_Sibling
              (File                  => File,
               Parent_File_Index     => Parent_File_Index,
               Parent                => Parent,
               Left                  => Sibling,
               Right_Index           => Page_Index,
               Right                 => Page,
               Index                 => Search_Index,
               Insertion_Key         => Key_Promoted_From_Below,
               Insertion_Right_Child => Right_Child_Promoted_From_Below);

            Promotion := False;

         else

            Insert_In_Split_Index_Page
              (File                  => File,
               Page_File_Index       => Page_File_Index,
               Page                  => Page,
               Index                 => Search_Index,
               Insertion_Key         => Key_Promoted_From_Below,
               Insertion_Right_Child => Right_Child_Promoted_From_Below,
               Promoted_Key          => Promoted_Key,
               Promoted_Right_Child  => Promoted_Right_Child);

         end if;

      elsif Get_Sibling (Page_Index - 1) < Index_Page_Size then

         -- There's room in the left sibling.

         Insert_In_Index_Page_And_Left_Sibling
           (File                  => File,
            Parent_File_Index     => Parent_File_Index,
            Parent                => Parent,
            Left                  => Sibling,
            Right_Index           => Page_Index,
            Right                 => Page,
            Index                 => Search_Index,
            Insertion_Key         => Key_Promoted_From_Below,
            Insertion_Right_Child => Right_Child_Promoted_From_Below);

         Promotion := False;

      elsif Get_Sibling (Page_Index + 1) < Index_Page_Size then

         -- There's room in the right sibling.

         Insert_In_Index_Page_And_Right_Sibling
           (File                  => File,
            Parent_File_Index     => Parent_File_Index,
            Parent                => Parent,
            Left_Index            => Page_Index,
            Left                  => Page,
            Right                 => Sibling,
            Index                 => Search_Index,
            Insertion_Key         => Key_Promoted_From_Below,
            Insertion_Right_Child => Right_Child_Promoted_From_Below);

         Promotion := False;

      else

         Insert_In_Split_Index_Page
           (File                  => File,
            Page_File_Index       => Page_File_Index,
            Page                  => Page,
            Index                 => Search_Index,
            Insertion_Key         => Key_Promoted_From_Below,
            Insertion_Right_Child => Right_Child_Promoted_From_Below,
            Promoted_Key          => Promoted_Key,
            Promoted_Right_Child  => Promoted_Right_Child);

      end if;

   end Insert_In_Subtree;


   procedure Insert_In_Tree
     (File                 : in out Stream_IO.File_Type;
      Root_Page_File_Index : in     Stream_IO.Positive_Count;
      Root_Page            : in out Index_Page_Type;
      Insertion_Key        : in     Key_Type;
      Insertion_Item       : in     Item_Type;
      Promotion            :    out Boolean;
      Promoted_Key         : in out Key_Type;
      Promoted_Right_Child : in out Stream_IO.Positive_Count) is

      Search_Index : Natural;

      Key_Promoted_From_Below         : Key_Type;
      Right_Child_Promoted_From_Below : Stream_IO.Positive_Count;

   begin

      Search
        (Keys  => Root_Page.Keys (1 .. Root_Page.Length),
         Key   => Insertion_Key,
         Index => Search_Index);

      if Root_Page.Is_Leaf then

         Insert_In_Sequence_Set
           (File                 => File,
            Parent_File_Index    => Root_Page_File_Index,
            Parent               => Root_Page,
            Child_Index          => Search_Index,
            Insertion_Key        => Insertion_Key,
            Insertion_Item       => Insertion_Item,
            Promotion            => Promotion,
            Promoted_Key         => Key_Promoted_From_Below,
            Promoted_Right_Child => Right_Child_Promoted_From_Below);

      else

         Insert_In_Subtree
           (File                 => File,
            Parent_File_Index    => Root_Page_File_Index,
            Parent               => Root_Page,
            Page_Index           => Search_Index,
            Insertion_Key        => Insertion_Key,
            Insertion_Item       => Insertion_Item,
            Promotion            => Promotion,
            Promoted_Key         => Key_Promoted_From_Below,
            Promoted_Right_Child => Right_Child_Promoted_From_Below);

      end if;


      if not Promotion then
         return;
      end if;


      if Root_Page.Length < Index_Page_Size then

         Insert_In_Index_Page
           (File                  => File,
            Page_File_Index       => Root_Page_File_Index,
            Page                  => Root_Page,
            Index                 => Search_Index,
            Insertion_Key         => Key_Promoted_From_Below,
            Insertion_Right_Child => Right_Child_Promoted_From_Below);

         Promotion := False;

      else

         Insert_In_Split_Index_Page
           (File                  => File,
            Page_File_Index       => Root_Page_File_Index,
            Page                  => Root_Page,
            Index                 => Search_Index,
            Insertion_Key         => Key_Promoted_From_Below,
            Insertion_Right_Child => Right_Child_Promoted_From_Below,
            Promoted_Key          => Promoted_Key,
            Promoted_Right_Child  => Promoted_Right_Child);

      end if;

   end Insert_In_Tree;



   ----------------------------
   -- Sequence Set Insertion --
   ----------------------------

   procedure Insert_In_Sequence_Page
     (File            : in out Stream_IO.File_Type;
      Page_File_Index : in     Stream_IO.Positive_Count;
      Page            : in out Sequence_Page_Type;
      Index           : in     Natural;
      Item            : in     Item_Type) is

   begin

      Page.Items (Index + 1 .. Page.Length + 1) :=
        Item &
        Page.Items (Index + 1 .. Page.Length);

      Page.Length := Page.Length + 1;

      Set_Mode (File, Out_File);
      Write (File, Page, Page_File_Index);

   end Insert_In_Sequence_Page;


   procedure Insert_In_Sequence_Page_And_Right_Sibling
     (File              : in out Stream_IO.File_Type;
      Parent_File_Index : in     Stream_IO.Positive_Count;
      Parent            : in out Index_Page_Type;
      Left_Index        : in     Natural;
      Left              : in out Sequence_Page_Type;
      Right             : in out Sequence_Page_Type;
      Index             : in     Natural;
      Item              : in     Item_Type) is

      pragma Assert (Left.Length = Sequence_Page_Size);

      Parent_Key : Key_Type renames
        Parent.Keys (Left_Index + 1);

      Empty_Slots_Count : constant Positive :=
        Sequence_Page_Size - Right.Length;
      -- Total number of free slots in the right sibling.

      Move_Count : constant Positive :=
        Integer'Max (1, Empty_Slots_Count / 2);
      -- Total number of items we move into right sibling.

      Left_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Left_Index);

      Right_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Left_Index + 1);

      Right_First : constant Positive :=
        Sequence_Page_Size - Move_Count + 1;

   begin

      if Index < Right_First then

         Right.Items (1 .. Right.Length + Move_Count) :=
           Left.Items (Right_First .. Sequence_Page_Size) &
           Right.Items (1 .. Right.Length);

         Left.Items (Index + 1 .. Right_First) :=
           Item &
           Left.Items (Index + 1 .. Right_First - 1);

      else

         Right.Items (1 .. Right.Length + Move_Count) :=
           Left.Items (Right_First + 1 .. Index) &
           Item &
           Left.Items (Index + 1 .. Sequence_Page_Size) &
           Right.Items (1 .. Right.Length);

      end if;

      Left.Length := Sequence_Page_Size - Move_Count + 1;
      Right.Length := Right.Length + Move_Count;

      Parent_Key := Get_Key (Right.Items (1));

      Set_Mode (File, Out_File);

      Write (File, Parent, Parent_File_Index);
      Write (File, Left, Left_File_Index);
      Write (File, Right, Right_File_Index);

   end Insert_In_Sequence_Page_And_Right_Sibling;


   procedure Insert_In_Sequence_Page_And_Left_Sibling
     (File              : in out Stream_IO.File_Type;
      Parent_File_Index : in     Stream_IO.Positive_Count;
      Parent            : in out Index_Page_Type;
      Left              : in out Sequence_Page_Type;
      Right_Index       : in     Positive;
      Right             : in out Sequence_Page_Type;
      Index             : in     Natural;
      Item              : in     Item_Type) is

      pragma Assert (Right.Length = Sequence_Page_Size);

      Left_Index : constant Natural :=
        Right_Index - 1;

      Left_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Left_Index);

      Right_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Right_Index);

      Move_Count : constant Positive :=
        (Sequence_Page_Size - Left.Length + 1) / 2;

   begin

      if Index < Move_Count then

         Left.Items (Left.Length + 1 .. Left.Length + Move_Count) :=
           Right.Items (1 .. Index) &
           Item &
           Right.Items (Index + 1 .. Move_Count - 1);

         Right.Items (1 .. Sequence_Page_Size - Move_Count + 1) :=
           Right.Items (Move_Count .. Sequence_Page_Size);

      else

         Left.Items (Left.Length + 1 .. Left.Length + Move_Count) :=
           Right.Items (1 .. Move_Count);

         Right.Items (1 .. Sequence_Page_Size - Move_Count + 1) :=
           Right.Items (Move_Count + 1 .. Index) &
           Item &
           Right.Items (Index + 1 .. Sequence_Page_Size);

      end if;


      Left.Length := Left.Length + Move_Count;
      Right.Length := Sequence_Page_Size - Move_Count + 1;

      Parent.Keys (Right_Index) := Get_Key (Right.Items (1));

      Set_Mode (File, Out_File);

      Write (File, Parent, Parent_File_Index);
      Write (File, Left, Left_File_Index);
      Write (File, Right, Right_File_Index);

   end Insert_In_Sequence_Page_And_Left_Sibling;


   procedure Insert_In_Split_Sequence_Page
     (File                 : in out Stream_IO.File_Type;
      Page_File_Index      : in     Stream_IO.Positive_Count;
      Page                 : in out Sequence_Page_Type;
      Index                : in     Natural;
      Item                 : in     Item_Type;
      Promoted_Key         :    out Key_Type;
      Promoted_Right_Child :    out Stream_IO.Positive_Count) is

      New_Right_Sibling : Sequence_Page_Type;
      -- Sequence page whose file index is Promoted_Right_Child.

   begin

      if Index < Sequence_Order then

         New_Right_Sibling.Items (1 .. Sequence_Order + 1) :=
           Page.Items (Sequence_Order .. Sequence_Page_Size);

         Page.Items (Index + 1 .. Sequence_Order) :=
           Item &
           Page.Items (Index + 1 .. Sequence_Order - 1);

      else

         New_Right_Sibling.Items (1 .. Sequence_Order + 1) :=
           Page.Items (Sequence_Order + 1 .. Index) &
           Item &
           Page.Items (Index + 1 .. Sequence_Page_Size);

      end if;

      Page.Length := Sequence_Order;
      New_Right_Sibling.Length := Sequence_Order + 1;

      New_Right_Sibling.Next := Page.Next;
      Append (File, New_Right_Sibling, Promoted_Right_Child);

      Page.Next := Promoted_Right_Child;
      Write (File, Page, Page_File_Index);

      Promoted_Key := Get_Key (New_Right_Sibling.Items (1));

   end Insert_In_Split_Sequence_Page;


   procedure Insert_In_Sequence_Set
     (File                 : in out Stream_IO.File_Type;
      Parent_File_Index    : in     Stream_IO.Positive_Count;
      Parent               : in out Index_Page_Type;
      Child_Index          : in     Child_Range;
      Insertion_Key        : in     Key_Type;
      Insertion_Item       : in     Item_Type;
      Promotion            :    out Boolean;
      Promoted_Key         : in out Key_Type;
      Promoted_Right_Child : in out Stream_IO.Positive_Count) is

      Sibling : Sequence_Page_Type;

      function Get_Sibling
        (Sibling_Index : Child_Range) return Positive is
      begin
         Set_Mode (File, In_File);
         Read (File, Sibling, Parent.Children (Sibling_Index));
         return Sibling.Length;
      end;

      Search_Index : Natural;
      Found        : Boolean;

      Page_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Child_Index);

      Page : Sequence_Page_Type;

   begin

      Read (File, Page, Page_File_Index);

      Search
        (Items => Page.Items (1 .. Page.Length),
         Key   => Insertion_Key,
         Index => Search_Index,
         Found => Found);

      if Found then

         Page.Items (Search_Index) := Insertion_Item;

         Set_Mode (File, Out_File);
         Write (File, Page, Page_File_Index);

         Promotion := False;

         return;

      end if;

      if Page.Length < Sequence_Page_Size then

         Insert_In_Sequence_Page
           (File            => File,
            Page_File_Index => Page_File_Index,
            Page            => Page,
            Index           => Search_Index,
            Item            => Insertion_Item);

         Promotion := False;

      elsif Parent.Length = 0 then

         -- The parent of this sequence page must be the root of the B tree
         -- (since only the root can have fewer than Index_Order items).

         pragma Assert (Parent.Is_Leaf);

         Insert_In_Split_Sequence_Page
           (File                 => File,
            Page_File_Index      => Page_File_Index,
            Page                 => Page,
            Index                => Search_Index,
            Item                 => Insertion_Item,
            Promoted_Key         => Promoted_Key,
            Promoted_Right_Child => Promoted_Right_Child);

         Promotion := True;

      elsif Child_Index = 0 then

         if Get_Sibling (1) < Sequence_Page_Size then

            Insert_In_Sequence_Page_And_Right_Sibling
              (File              => File,
               Parent_File_Index => Parent_File_Index,
               Parent            => Parent,
               Left_Index        => Child_Index,
               Left              => Page,
               Right             => Sibling,
               Index             => Search_Index,
               Item              => Insertion_Item);

            Promotion := False;

         else

            Insert_In_Split_Sequence_Page
              (File                 => File,
               Page_File_Index      => Page_File_Index,
               Page                 => Page,
               Index                => Search_Index,
               Item                 => Insertion_Item,
               Promoted_Key         => Promoted_Key,
               Promoted_Right_Child => Promoted_Right_Child);

            Promotion := True;

         end if;

      elsif Child_Index = Parent.Length then

         if Get_Sibling (Child_Index - 1) < Sequence_Page_Size then

            Insert_In_Sequence_Page_And_Left_Sibling
              (File              => File,
               Parent_File_Index => Parent_File_Index,
               Parent            => Parent,
               Left              => Sibling,
               Right_Index       => Child_Index,
               Right             => Page,
               Index             => Search_Index,
               Item              => Insertion_Item);

            Promotion := False;

         else

            Insert_In_Split_Sequence_Page
              (File                 => File,
               Page_File_Index      => Page_File_Index,
               Page                 => Page,
               Index                => Search_Index,
               Item                 => Insertion_Item,
               Promoted_Key         => Promoted_Key,
               Promoted_Right_Child => Promoted_Right_Child);

            Promotion := True;

         end if;

      elsif Get_Sibling (Child_Index - 1) < Sequence_Page_Size then

         Insert_In_Sequence_Page_And_Left_Sibling
           (File              => File,
            Parent_File_Index => Parent_File_Index,
            Parent            => Parent,
            Left              => Sibling,
            Right_Index       => Child_Index,
            Right             => Page,
            Index             => Search_Index,
            Item              => Insertion_Item);

         Promotion := False;

      elsif Get_Sibling (Child_Index + 1) < Sequence_Page_Size then

         Insert_In_Sequence_Page_And_Right_Sibling
           (File              => File,
            Parent_File_Index => Parent_File_Index,
            Parent            => Parent,
            Left_Index        => Child_Index,
            Left              => Page,
            Right             => Sibling,
            Index             => Search_Index,
            Item              => Insertion_Item);

         Promotion := False;

      else

         Insert_In_Split_Sequence_Page
           (File                 => File,
            Page_File_Index      => Page_File_Index,
            Page                 => Page,
            Index                => Search_Index,
            Item                 => Insertion_Item,
            Promoted_Key         => Promoted_Key,
            Promoted_Right_Child => Promoted_Right_Child);

         Promotion := True;

      end if;

   end Insert_In_Sequence_Set;




   -----------------------
   -- Index Set Removal --
   -----------------------

   procedure Redistribute_Keys_From_Right_To_Left
     (Parent      : in out Index_Page_Type;
      Left        : in out Index_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Index_Page_Type) is

      -- Description:
      --
      -- Move some extra keys from the right page onto its left sibling.
      --
      -- This is a redistribution, so it modifies the parent (Parent) and
      -- both children (Left, Right).  It does NOT write the pages to disk.


      pragma Assert (Left.Length = Index_Order - 1);

      Extra_Keys_Count : constant Positive :=
        Right.Length - Index_Order;
      --
      -- Total number of keys "available" for moving from the right page,
      -- without violating constraint that there are at least Index_Order
      -- key in a page.

      Move_Count : constant Positive :=
        Integer'Max (1, Extra_Keys_Count / 2);
      --
      -- Move half of what's available on the right to the left; this
      -- evenly distributes the keys.

   begin

      Left.Length := Index_Order + Move_Count - 1;

      Left.Keys (Index_Order .. Left.Length) :=
        Parent.Keys (Right_Index) &
        Right.Keys (1 .. Move_Count - 1);

      Left.Children (Index_Order .. Left.Length) :=
        Right.Children (0 .. Move_Count - 1);


      Parent.Keys (Right_Index) := Right.Keys (Move_Count);


      Right.Keys (1 .. Right.Length - Move_Count) :=
        Right.Keys (Move_Count + 1 .. Right.Length);

      Right.Children (0 .. Right.Length - Move_Count) :=
        Right.Children (Move_Count .. Right.Length);

      Right.Length := Right.Length - Move_Count;

   end Redistribute_Keys_From_Right_To_Left;


   procedure Redistribute_Keys_From_Left_To_Right
     (Parent      : in out Index_Page_Type;
      Left        : in out Index_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Index_Page_Type) is

      -- Description:
      --
      -- Move some extra keys from the left page onto its right sibling.
      --
      -- This is a redistribution, so it modifies the parent (Parent) and
      -- both siblings (Left, Right).  It does NOT write the pages to disk.


      pragma Assert (Right.Length = Index_Order - 1);

      Parent_Key : Key_Type renames Parent.Keys (Right_Index);

      Extra_Keys_Count : constant Positive :=
        Left.Length - Index_Order;
      --
      -- Total number of keys "available" for moving from the left page,
      -- without violating constraint that there are at least Index_Order
      -- keys in a page.

      Move_Count : constant Positive :=
        Integer'Max (1, Extra_Keys_Count / 2);
      --
      -- Move half of what's available on the left to the right; this
      -- evenly distributes the keys.

   begin

      Right.Keys (1 .. Right.Length + Move_Count) :=
        Left.Keys (Left.Length - Move_Count + 2 .. Left.Length) &
        Parent_Key &
        Right.Keys (1 .. Right.Length);

      Right.Children (0 .. Right.Length + Move_Count) :=
        Left.Children (Left.Length - Move_Count + 1 .. Left.Length) &
        Right.Children (0 .. Right.Length);

      Right.Length := Right.Length + Move_Count;


      Parent_Key := Left.Keys (Left.Length - Move_Count + 1);


      Left.Length := Left.Length - Move_Count;

   end Redistribute_Keys_From_Left_To_Right;


   procedure Concatenate
     (Parent      : in out Index_Page_Type;
      Left        : in out Index_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Index_Page_Type) is

      -- Description:
      --
      -- Combines a pair of sibling index pages into one, by demoting the
      -- Index'th key from the Parent page and copying all the keys from
      -- the Right page into the Left.
      --
      -- This means that the file will now contain a "hole" where the Right
      -- (index set) page used to be.
      --
      -- The Parent page and both siblings (Right, Left) are all modified.
      -- This subprogram does NOT write the pages to disk.

   begin

      Left.Keys (Left.Length + 1 .. Index_Page_Size) :=
        Parent.Keys (Right_Index) &
        Right.Keys (1 .. Right.Length);

      Left.Children (Left.Length + 1 .. Index_Page_Size) :=
        Right.Children (0 .. Right.Length);

      Left.Length := Index_Page_Size;


      Parent.Keys (Right_Index .. Parent.Length - 1) :=
        Parent.Keys (Right_Index + 1 .. Parent.Length);

      Parent.Children (Right_Index .. Parent.Length - 1) :=
        Parent.Children (Right_Index + 1 .. Parent.Length);

      Parent.Length := Parent.Length - 1;

   end Concatenate;


   procedure Redistribute_Or_Concatenate_With_Right_Sibling
     (File       : in out Stream_IO.File_Type;
      Parent     : in out Index_Page_Type;
      Left_Index : in     Natural;
      Left       : in out Index_Page_Type;
      Underflow  : in out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Left page, by either moving some extra
      -- keys from its right sibling, or by combining the siblings together
      -- to form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page and both of its children are all modified.  This
      -- subprogram writes the children to disk (as necessary), but it does
      -- NOT write the Parent page to disk.


      pragma Assert (Left.Length < Index_Order);

      Left_File_Index : constant Stream_IO.Positive_Count :=
        Parent.Children (Left_Index);

      Right_Index : constant Positive :=
        Left_Index + 1;

      Right_File_Index : constant Stream_IO.Positive_Count :=
        Parent.Children (Right_Index);

      Right : Index_Page_Type;

   begin

      Set_Mode (File, In_File);
      Read (File, Right, Right_File_Index);

      Set_Mode (File, Out_File);

      if Right.Length > Index_Order then

         -- There are some extra keys available in the right sibling, so
         -- move some of them onto the left page.
         --
         Redistribute_Keys_From_Right_To_Left
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);


         Underflow := False;
         -- Let the caller know that the Parent page hasn't underflowed.


         Write (File, Right, Right_File_Index);

      else

         -- There aren't any extra keys in the right sibling.  So move all
         -- the keys from the right into the left, and throw away the right
         -- page.
         --
         Concatenate
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := Parent.Length < Index_Order;
         -- Let the caller know whether the Parent page has underflowed.

         --
         -- Note that we don't write the Right page to disk, because that
         -- page is gone.  All of its items were moved to the Left page as
         -- a result of the concatentation.
         --

      end if;

      Write (File, Left, Left_File_Index);

    end Redistribute_Or_Concatenate_With_Right_Sibling;



   procedure Redistribute_Or_Concatenate_With_Left_Sibling
     (File        : in out Stream_IO.File_Type;
      Parent      : in out Index_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Index_Page_Type;
      Underflow   : in out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Right page, by either moving some extra
      -- keys from its left sibling, or by combining the siblings together
      -- to form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page and both of its children are all modified.  This
      -- subprogram writes the children to disk (as necessary), but it does
      -- NOT write the Parent page to disk.


      pragma Assert (Right.Length < Index_Order);

      Left_Index : constant Natural :=
        Right_Index - 1;

      Left_File_Index : constant Stream_IO.Positive_Count :=
        Parent.Children (Left_Index);

      Left : Index_Page_Type;

   begin

      Set_Mode (File, In_File);
      Read (File, Left, Left_File_Index);

      Set_Mode (File, Out_File);

      if Left.Length > Index_Order then

         -- There are some keys available in the left sibling.  Move some
         -- of the them into the right sibling.
         --
         Redistribute_Keys_From_Left_To_Right
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := False;
         -- Let the caller know that the Parent hasn't underflowed.

         Write (File, Right, Parent.Children (Right_Index));

      else

         -- There aren't any extra items available in the left sibling.
         -- Move all of the keys in the right child into the left.
         --
         Concatenate
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := Parent.Length < Index_Order;
         -- Let the caller know whether the Parent has underflowed.

         --
         -- Note that we don't write the Right page to disk, because that
         -- page is gone.  All of its items were moved to the Left page as
         -- a result of the concatentation.
         --

      end if;

      Write (File, Left, Left_File_Index);

   end Redistribute_Or_Concatenate_With_Left_Sibling;


   procedure Redistribute_Or_Concatenate_With_Either_Sibling
     (File         : in out Stream_IO.File_Type;
      Parent       : in out Index_Page_Type;
      Middle_Index : in     Positive;
      Child        : in out Index_Page_Type;
      Underflow    : in out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Child page (located somewhere in the
      -- middle of its parent, "middle" meaning not at either extreme), by
      -- either moving some extra keys from one of its two siblings, or by
      -- combining the siblings (Child and its left sibling) together to
      -- form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page, the Child page, and one of its sibling pages are
      -- all modified.  This subprogram writes the children to disk (as
      -- necessary), but it does NOT write the Parent page to disk.


      pragma Assert (Child.Length < Index_Order);

      Child_File_Index : constant Stream_IO.Positive_Count :=
        Parent.Children (Middle_Index);

      Right_Index : constant Positive :=
        Middle_Index + 1;

      Right_File_Index : constant Stream_IO.Positive_Count :=
        Parent.Children (Right_Index);

      Right : Index_Page_Type;

   begin

      Set_Mode (File, In_File);
      Read (File, Right, Right_File_Index);

      if Right.Length > Index_Order then

         -- The right sibling has some extra keys.  Repair the underflow in
         -- Child by moving some keys from its Right sibling.
         --
         Redistribute_Keys_From_Right_To_Left
           (Parent      => Parent,
            Right_Index => Right_Index,
            Right       => Right,
            Left        => Child);

         Underflow := False;
         -- Let the caller know that the Parent page hasn't underflowed.

         Set_Mode (File, Out_File);
         Write (File, Right, Right_File_Index);
         Write (File, Child, Child_File_Index);

      else

         -- There aren't any extra keys in the Child's right sibling, so
         -- repair the underflow by moving some items from the left.
         --
         Redistribute_Or_Concatenate_With_Left_Sibling
           (File        => File,
            Parent      => Parent,
            Right_Index => Middle_Index,
            Right       => Child,
            Underflow   => Underflow);

      end if;

   end Redistribute_Or_Concatenate_With_Either_Sibling;



   procedure Redistribute_Or_Concatenate_Keys
     (File      : in out Stream_IO.File_Type;
      Parent    : in out Index_Page_Type;
      Child     : in out Index_Page_Type;
      Index     : in     Natural;
      Underflow : in out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Child page, by either moving some extra
      -- items from one of its two siblings, or by combining the siblings
      -- together to form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page, the Child page, and one of its sibling pages are
      -- all modified.  This subprogram writes the children to disk (as
      -- necessary).  It does NOT write the Parent page to disk.

   begin

      if Index = 0 then

         -- The left-most child underflowed.  We have no choice but to
         -- redistribute or concatenate with right sibling.

         Redistribute_Or_Concatenate_With_Right_Sibling
           (File       => File,
            Parent     => Parent,
            Left_Index => Index,
            Left       => Child,
            Underflow  => Underflow);

      elsif Index = Parent.Length then

         -- The right-most child has an underflow.  We have no choice but
         -- to redistribute or concatenate with the left sibling.

         Redistribute_Or_Concatenate_With_Left_Sibling
           (File        => File,
            Parent      => Parent,
            Right_Index => Index,
            Right       => Child,
            Underflow   => Underflow);

      else

         pragma Assert (Parent.Length > 1);

         -- Neither the left-most nor right-most child has underflowed.
         -- Try both neighbors to find one that has some extra items.

         Redistribute_Or_Concatenate_With_Either_Sibling
           (File         => File,
            Parent       => Parent,
            Middle_Index => Index,
            Child        => Child,
            Underflow    => Underflow);

      end if;


   end Redistribute_Or_Concatenate_Keys;



   ---------------------------
   -- Sequence Set Removal --
   ---------------------------

   procedure Redistribute_Items_From_Right_To_Left
     (Parent      : in out Index_Page_Type;
      Left        : in out Sequence_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Sequence_Page_Type) is

      -- Description:
      --
      -- Move some extra items from the right page onto its left sibling.
      --
      -- This is a redistribution, so it modifies the Parent and both
      -- children (Left, Right).  It does NOT write the pages to disk.


      Count : constant Positive :=
        (Right.Length - Sequence_Order + 1) / 2;
      --
      -- Move half of what's available on the right to the left; this
      -- evenly distributes the items.

   begin

      Left.Length := Sequence_Order + Count - 1;

      Left.Items (Sequence_Order .. Left.Length) :=
        Right.Items (1 .. Count);

      Right.Items (1 .. Right.Length - Count) :=
        Right.Items (Count + 1 .. Right.Length);

      Right.Length := Right.Length - Count;


      Parent.Keys (Right_Index) := Get_Key (Right.Items (1));

   end Redistribute_Items_From_Right_To_Left;


   procedure Redistribute_Items_From_Left_To_Right
     (Parent      : in out Index_Page_Type;
      Left        : in out Sequence_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Sequence_Page_Type) is

      -- Description:
      --
      -- Move some extra items from the left page onto its right sibling.
      --
      -- This is a redistribution, so it modifies the Parent and both
      -- children (Left, Right).  It does NOT write the pages to disk.


      Count : constant Positive :=
        (Left.Length - Sequence_Order + 1) / 2;
      --
      -- Move half of what's available on the left to the right; this
      -- evenly distributes the items.

   begin

      Right.Items (1 .. Right.Length + Count) :=
        Left.Items (Left.Length - Count + 1 .. Left.Length) &
        Right.Items (1 .. Right.Length);

      Right.Length := Right.Length + Count;

      Left.Length := Left.Length - Count;


      Parent.Keys (Right_Index) := Get_Key (Right.Items (1));

   end Redistribute_Items_From_Left_To_Right;


   procedure Concatenate_Items
     (Parent      : in out Index_Page_Type;
      Left        : in out Sequence_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Sequence_Page_Type) is

      -- Description:
      --
      -- Combine a pair of sibling sequence pages into one, by copying all
      -- the items from the Right page into the Left, and removing the
      -- reference to the Right page from the Parent.
      --
      -- This means that the file will now contain a "hole" where the Right
      -- (sequence) page used to be.
      --
      -- The Parent and Left pages are both modified (and Right is thrown
      -- away).  This subprogram does NOT write the pages to disk.

   begin

      Left.Items (Left.Length + 1 .. Sequence_Page_Size - 1) :=
        Right.Items (1 .. Right.Length);

      Left.Length := Sequence_Page_Size - 1;

      Left.Next := Right.Next;


      Parent.Keys (Right_Index .. Parent.Length - 1) :=
        Parent.Keys (Right_Index + 1 .. Parent.Length);

      Parent.Children (Right_Index .. Parent.Length - 1) :=
        Parent.Children (Right_Index + 1 .. Parent.Length);

      Parent.Length := Parent.Length - 1;


   end Concatenate_Items;


   procedure Redistribute_Or_Concatenate_Items_With_Right_Sibling
     (File       : in out Stream_IO.File_Type;
      Parent     : in out Index_Page_Type;
      Left_Index : in     Natural;
      Left       : in out Sequence_Page_Type;
      Underflow  :    out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Left page, by either moving from extra
      -- items from its right sibling, or by combining the siblings
      -- together to form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page and both of its children are all modified.  This
      -- subprogram writes the children to disk (as necessary), but it does
      -- NOT write the Parent page to disk.


      Left_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Left_Index);

      Right_Index : constant Positive :=
        Left_Index + 1;

      Right_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Right_Index);

      Right : Sequence_Page_Type;

   begin

      Set_Mode (File, In_File);
      Read (File, Right, Right_File_Index);

      Set_Mode (File, Out_File);

      if Right.Length > Sequence_Order then

         -- There are some extra items available in the right sibling.

         Redistribute_Items_From_Right_To_Left
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := False;
         -- Let caller know Parent hasn't underflowed.

         Write (File, Right, Right_File_Index);

      else

         -- There aren't any extra items in the right sibling.  So move
         -- all the items from the right into the left.

         Concatenate_Items
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := Parent.Length < Index_Order;
         -- Let caller know whether Parent page has underflowed.

      end if;

      Write (File, Left, Left_File_Index);

   end Redistribute_Or_Concatenate_Items_With_Right_Sibling;



   procedure Redistribute_Or_Concatenate_Items_With_Left_Sibling
     (File        : in out Stream_IO.File_Type;
      Parent      : in out Index_Page_Type;
      Right_Index : in     Positive;
      Right       : in out Sequence_Page_Type;
      Underflow   :    out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Right page, by either moving some extra
      -- items from its left sibling, or by combining the siblings together
      -- to form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has been
      -- underflowed.
      --
      -- The Parent page and both of its children are all modified.  This
      -- subprogram writes the children to disk (as necessary), but it does
      -- NOT write the Parent page to disk.



      Left_Index : constant Natural :=
        Right_Index - 1;

      Left_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Left_Index);

      Left : Sequence_Page_Type;

      Right_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Right_Index);

   begin

      Set_Mode (File, In_File);
      Read (File, Left, Left_File_Index);

      Set_Mode (File, Out_File);

      if Left.Length > Sequence_Order then

         -- There are some items available in the left sibling.  Move
         -- some of the them into the right sibling.

         Redistribute_Items_From_Left_To_Right
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := False;
         -- Let caller know that Parent hasn't underflowed.

         Write (File, Right, Right_File_Index);

      else

         -- There aren't any extra items available in the left sibling.
         -- Move all of the items in the right child into the left.

         Concatenate_Items
           (Parent      => Parent,
            Left        => Left,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := Parent.Length < Index_Order;
         -- Let caller know whether Parent has underflowed.

      end if;

      Write (File, Left, Left_File_Index);

   end Redistribute_Or_Concatenate_Items_With_Left_Sibling;


   procedure Redistribute_Or_Concatenate_Items_With_Either_Sibling
     (File         : in out Stream_IO.File_Type;
      Parent       : in out Index_Page_Type;
      Middle_Index : in     Positive;
      Middle       : in out Sequence_Page_Type;
      Underflow    :    out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Middle page, by either moving some
      -- extra keys from one of its two siblings, or by combining the
      -- siblings (Middle and its left sibling) together to form a single
      -- page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page, the Middle page, and one of its sibling pages are
      -- all modified.  This subprogram writes the children to disk (as
      -- necessary), but it does NOT write the Parent page to disk.


      Right_Index : constant Positive :=
        Middle_Index + 1;

      Right_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Right_Index);

      Right : Sequence_Page_Type;

      Middle_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Middle_Index);

   begin

      Set_Mode (File, In_File);
      Read (File, Right, Right_File_Index);

      if Right.Length > Sequence_Order then

         -- The right sibling has some extra items.

         Redistribute_Items_From_Right_To_Left
           (Parent      => Parent,
            Left        => Middle,
            Right_Index => Right_Index,
            Right       => Right);

         Underflow := False;
         -- Let caller know that Parent hasn't underflowed.

         Set_Mode (File, Out_File);
         Write (File, Right, Right_File_Index);
         Write (File, Middle, Middle_File_Index);

      else

         Redistribute_Or_Concatenate_Items_With_Left_Sibling
           (File        => File,
            Parent      => Parent,
            Right_Index => Middle_Index,
            Right       => Middle,
            Underflow   => Underflow);

      end if;

   end Redistribute_Or_Concatenate_Items_With_Either_Sibling;



   procedure Redistribute_Or_Concatenate_Items
     (File              : in out Stream_IO.File_Type;
      Parent            : in out Index_Page_Type;
      Child_Index       : in     Child_Range;
      Child             : in out Sequence_Page_Type;
      Underflow         :    out Boolean) is

      -- Description:
      --
      -- Repair an underflow in the Child page, by either moving some extra
      -- items from one of its two siblings, or by combining the siblings
      -- together to form a single page.
      --
      -- The Underflow flag indicates whether the Parent page has
      -- underflowed.
      --
      -- The Parent page, the Child page, and one of its sibling pages are
      -- all modified.  This subprogram writes the children to disk (as
      -- necessary).  It does NOT write the Parent page to disk.

   begin

      if Child_Index = 0 then

         -- The left-most child underflowed.  We have no choice but to
         -- redistribute or concatenate with right sibling.

         Redistribute_Or_Concatenate_Items_With_Right_Sibling
           (File       => File,
            Parent     => Parent,
            Left_Index => Child_Index,
            Left       => Child,
            Underflow  => Underflow);

      elsif Child_Index = Parent.Length then

         -- The right-most child has an underflow.  We have no choice but
         -- to redistribute or concatenate with the left sibling.

         Redistribute_Or_Concatenate_Items_With_Left_Sibling
           (File        => File,
            Parent      => Parent,
            Right_Index => Child_Index,
            Right       => Child,
            Underflow   => Underflow);

      else

         pragma Assert (Parent.Length > 1);

         -- Neither the left-most nor right-most child has underflowed.
         -- Try both neighbors to find one that has some extra items.

         Redistribute_Or_Concatenate_Items_With_Either_Sibling
           (File         => File,
            Parent       => Parent,
            Middle_Index => Child_Index,
            Middle       => Child,
            Underflow    => Underflow);

      end if;

   end Redistribute_Or_Concatenate_Items;


   procedure Remove_From_Sequence_Page
     (Page      : in out Sequence_Page_Type;
      Key       : in     Key_Type;
      Underflow :    out Boolean) is

      -- Description:
      --
      -- Removes the item having the Key from the sequence Page.
      --
      -- The Underflow flag indicates whether the Page has underflowed.
      --
      -- The Page is NOT written to disk.


      Index : Natural;
      Found : Boolean;

   begin

      Search
        (Items => Page.Items (1 .. Page.Length),
         Key   => Key,
         Index => Index,
         Found => Found);

      if not Found then

         Underflow := False;

         return;

      end if;


      Page.Items (Index .. Page.Length - 1) :=
        Page.Items (Index + 1 .. Page.Length);

      Page.Length := Page.Length - 1;


      Underflow := Page.Length < Sequence_Order;
      -- Let caller know whether Page has underflowed.

   end Remove_From_Sequence_Page;


   procedure Remove_From_Sequence_Set
     (File              : in out Stream_IO.File_Type;
      Parent_File_Index : in     Stream_IO.Positive_Count;
      Parent            : in out Index_Page_Type;
      Index             : in     Natural;
      Key               : in     Key_Type;
      Underflow         :    out Boolean) is

      -- Description:
      --
      -- Removes the item having the Key from Index'th (sequence page)
      -- child of the (index page) Parent, and repairs the underflow in the
      -- child as necessary.
      --
      -- The Underflow flag indicates whether Parent has underflowed (as a
      -- result of repairing the underflow in its child).
      --
      -- The modified child is written to disk.  The Parent page is written
      -- to disk only if it was modified and hasn't underflowed.


      Page_File_Index : Stream_IO.Positive_Count renames
        Parent.Children (Index);

      Page : Sequence_Page_Type;

   begin

      Read (File, Page, Page_File_Index);

      Remove_From_Sequence_Page
        (Page      => Page,
         Key       => Key,
         Underflow => Underflow);

      if not Underflow then

         -- No, the sequence Page hasn't underflowed, but it was still
         -- modified.

         Set_Mode (File, Out_File);
         Write (File, Page, Page_File_Index);


      elsif Parent.Length = 0 then

         pragma Assert (Parent.Is_Leaf);

         -- The Parent must be the root page of the index set.  Its
         -- state hasn't changed, so don't bother reporting underflow.

         Underflow := False;
         -- Let caller know Parent wasn't changed.


         Set_Mode (File, Out_File);
         Write (File, Page, Page_File_Index);

      else

         -- The sequence Page has siblings, so repair its underflow.

         Redistribute_Or_Concatenate_Items
           (File              => File,
            Parent            => Parent,
            Child_Index       => Index,
            Child             => Page,
            Underflow         => Underflow);

         -- The Underflow flag now indicates whether the Parent has
         -- underflowed (as a result of repairing the underflow in its
         -- child).
         --
         -- No, we don't need to write the Page to disk, because that's
         -- what Redist_Or_Concat_Items does.

         if not Underflow then
            Write (File, Parent, Parent_File_Index);
         end if;

      end if;

   end Remove_From_Sequence_Set;



   procedure Remove_From_Tree
     (File            : in out Stream_IO.File_Type;
      Page_File_Index : in     Stream_IO.Positive_Count;
      Page            : in out Index_Page_Type;
      Key             : in     Key_Type;
      Underflow       :    out Boolean) is

      -- Description:
      --
      -- Remove the Key from the tree whose root is Page.
      --
      -- The Underflow flag indicates whether Page has underflowed (as a
      -- result of the removal).
      --
      -- If the Page has been modified, but hasn't underflowed, then it
      -- writes the page to disk.


      Search_Index : Natural;

      Child : Index_Page_Type;

   begin

      Search
        (Keys  => Page.Keys (1 .. Page.Length),
         Key   => Key,
         Index => Search_Index);

      if Page.Is_Leaf then

         Remove_From_Sequence_Set
           (File              => File,
            Parent_File_Index => Page_File_Index,
            Parent            => Page,
            Index             => Search_Index,
            Key               => Key,
            Underflow         => Underflow);

      else

--       Set_Mode (File, In_File);
         Read (File, Child, Page.Children (Search_Index));

         Remove_From_Tree
           (File            => File,
            Page_File_Index => Page.Children (Search_Index),
            Page            => Child,
            Key             => Key,
            Underflow       => Underflow);

         -- The Underflow flag indicates whether an underflow has occured
         -- in the Child page.

         if Underflow then

            -- Repair the underflow in the Child page.

            Redistribute_Or_Concatenate_Keys
              (File      => File,
               Parent    => Page,
               Child     => Child,
               Index     => Search_Index,
               Underflow => Underflow);

            -- Note that the Underflow flag now indicates whether an
            -- underflow has occured in Page (as a result of repairing the
            -- underflow in its Child.)

            if not Underflow then
               Write (File, Page, Page_File_Index);
            end if;

         end if;

      end if;

   end Remove_From_Tree;


   procedure Search
     (Keys  : in     Key_Array_Base;
      Key   : in     Key_Type;
      Index :    out Natural) is

      Upper : Positive := Keys'Length + 1;

      Middle : Positive range 1 .. Keys'Length;

   begin

      Index := 0;

      while Upper - Index > 1 loop

         Middle := (Index + Upper) / 2;

         if Keys (Middle) <= Key then

            Index := Middle;

         else

            Upper := Middle;

         end if;

      end loop;

   end Search;


   procedure Search
     (Items : in     Item_Array_Base;
      Key   : in     Key_Type;
      Index :    out Natural;
      Found :    out Boolean) is

      Lower : Natural := 0;
      Upper : Positive := Items'Length + 1;

      Middle : Positive range 1 .. Items'Length;

      Middle_Key : Key_Type;

   begin

      while Upper - Lower > 1 loop

         Middle := (Lower + Upper) / 2;

         Middle_Key := Get_Key (Items (Middle));

         if Middle_Key < Key then

            Lower := Middle;

         elsif Middle_Key = Key then

            Index := Middle;
            Found := True;

            return;

         else

            Upper := Middle;

         end if;

      end loop;

      Index := Lower;
      Found := False;

   end Search;

end Indexed_Sequential_IO;


