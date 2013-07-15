------------------------------------------------------------------------
--
--                    INDEXED_SEQUENTIAL_IO.DEBUG_G
--
--      $Id: indexed_sequential_io-debug_g.adb,v 1.8 1999/10/08 05:59:49 matt Exp $
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

with Ada.Text_IO;

package body Indexed_Sequential_IO.Debug_G is

   use Stream_IO;

--    procedure Dump_Page_Info is
--       use Ada.Text_IO;

--       pragma Warnings (Off);
--       Index_Page : Index_Page_Type;
--       Page_As_Stream_Elements : Index_Page_As_Stream_Element_Array;
--       pragma Warnings (On);
--    begin
--       Put_Line
--         ("Index_Page_Type'Size =" &
--          Integer'Image (Index_Page_Type'Size));

--       Put_Line
--         ("Index_Page_Type'Object_Size =" &
--          Integer'Image (Index_Page_Type'Object_Size));

--       Put_Line
--         ("Index_Page'Size =" &
--          Integer'Image (Index_Page'Size));

--       Put_Line
--         ("Index_Page_Type.Length'Position =" &
--          Integer'Image (Index_Page.Length'Position));

--       Put_Line
--         ("Index_Page_Type.Keys'Position =" &
--          Integer'Image (Index_Page.Keys'Position));

--       Put_Line
--         ("Index_Page_Type.Children'Position =" &
--          Integer'Image (Index_Page.Children'Position));

--       Put_Line
--         ("Index_Page_Type.Is_Leaf'Position =" &
--          Integer'Image (Index_Page.Is_Leaf'Position));

--       Put_Line
--         ("Stream_Element'Size =" &
--          Integer'Image (Stream_Element'Size));

--       Put_Line
--         ("Stream_Element'Object_Size =" &
--          Integer'Image (Stream_Element'Object_Size));

--       Put_Line
--         ("Index_Page_Stream_Size =" &
--          Stream_Element_Offset'Image (Index_Page_Stream_Size));

--       Put_Line
--         ("Index_Page_As_Stream_Element_Array'Size =" &
--          Integer'Image (Index_Page_As_Stream_Element_Array'Size));

--       Put_Line
--         ("Index_Page_As_Stream_Element_Array'Object_Size =" &
--          Integer'Image (Index_Page_As_Stream_Element_Array'Object_Size));

--       Put_Line
--         ("Page_As_Stream_Elements'Size =" &
--          Integer'Image (Page_As_Stream_Elements'Size));

--    end Dump_Page_Info;





--    procedure Put
--      (File : in File_Type) is

--       procedure Put_Keys
--         (Page_File_Index : in Ada.Streams.Stream_IO.Count) is

--          Page : Page_Type;
--       begin
--          if Page_File_Index = 0 then
--             return;
--          end if;

--          Read (File.File, Page, Page_File_Index);
--          Put_Keys (Page.Children (0));

--          for Index in 1 .. Page.Length loop
--             Ada.Text_IO.Put (Get_Image (Page.Keys (Index)));
--             Put_Keys (Page.Children (Index));
--          end loop;
--       end Put_Keys;

--    begin -- Put

--       if File.Root_Page_File_Index = 0 then
--          Ada.Text_IO.Put_Line ("<empty>");
--       else
--          Set_Mode (File.Handle.File.File, In_File);
--          Put_Keys (File.Root_Page_File_Index);
--          Ada.Text_IO.New_Line;
--       end if;

--    end Put;



   procedure Put_Tree
     (File : in File_Type) is

      procedure Put_Sequence_Items
        (Page_File_Index : in Count;
         Level           : in Natural) is

         Page : Sequence_Page_Type;
      begin
         Read (File.File, Page, Page_File_Index);

         for I in 1 .. 3 * Level loop
            Ada.Text_IO.Put (' ');
         end loop;

         Ada.Text_IO.Put ('S');

         if Page.Length = 0 then
            Ada.Text_IO.Put ("<empty seq page>");
         else
            for I in 1 .. Page.Length loop
               Ada.Text_IO.Put (Get_Item_Image (Page.Items (I)));
            end loop;
         end if;

         Ada.Text_IO.New_Line;
      end Put_Sequence_Items;


      procedure Put_Index_Keys
        (Page_File_Index : in Count;
         Level           : in Natural) is

         Page : Index_Page_Type;
      begin
         Read (File.File, Page, Page_File_Index);

         for I in 1 .. 3 * Level loop
            Ada.Text_IO.Put (' ');
         end loop;

         if Page.Length = 0 then
            Ada.Text_IO.Put ("<empty index page>");
         else
            for I in 1 .. Page.Length loop
               Ada.Text_IO.Put (Get_Key_Image (Page.Keys (I)));
            end loop;
         end if;

         Ada.Text_IO.New_Line;

         if Page.Is_Leaf then

            for I in 0 .. Page.Length loop
               Put_Sequence_Items (Page.Children (I), Level + 1);
            end loop;

         else

            for I in 0 .. Page.Length loop
               Put_Index_Keys (Page.Children (I), Level + 1);
            end loop;

         end if;
      end Put_Index_Keys;

   begin -- Put_Tree

      Set_Mode (File.Handle.File.File, In_File);

      Put_Index_Keys (File.Root_Page_File_Index, Level => 0);

   end Put_Tree;


   function Is_In
     (File : File_Type;
      Key  : Key_Type) return Boolean is

      Index : Natural;
      Found : Boolean;

      File_Index    : Stream_IO.Count := File.Root_Page_File_Index;
      Index_Page    : Index_Page_Type;
      Sequence_Page : Sequence_Page_Type;

   begin

      Set_Mode (File.Handle.File.File, In_File);

      loop

         Read (File.File, Index_Page, From => File_Index);

         Search
           (Keys  => Index_Page.Keys (1 .. Index_Page.Length),
            Key   => Key,
            Index => Index);

         File_Index := Index_Page.Children (Index);

         exit when Index_Page.Is_Leaf;

      end loop;

      Read (File.File, Sequence_Page, From => File_Index);

      Search
        (Items => Sequence_Page.Items (1 .. Sequence_Page.Length),
         Key   => Key,
         Index => Index,
         Found => Found);

      return Found;

   end Is_In;


--    function Get_Number_Of_Items
--      (File : File_Type) return Natural is

--       Number_Of_Items : Natural := 0;

--       procedure Get_Length
--         (Page_File_Index : in Stream_IO.Count) is

--          Page : Page_Type;
--       begin
--          if Page_File_Index = 0 then
--             return;
--          end if;

--          Read (File.File, Page, Page_File_Index);
--          Number_Of_Items := Number_Of_Items + Page.Length;

--          for I in 0 .. Page.Length loop
--             Get_Length (Page.Children (I));
--          end loop;
--       end Get_Length;

--    begin
--       Set_Mode (File.Handle.File.File, In_File);
--       Get_Length (File.Root_Page_File_Index);
--       return Number_Of_Items;
--    end;


--    function Is_Correctly_Ordered
--      (File : File_Type) return Boolean is

--       Key : Key_Type := Key_Zero;
--       OK  : Boolean := True;

--       procedure Get_Keys
--         (Page_File_Index : in Stream_IO.Count) is

--          Page : Page_Type;
--       begin
--          if Page_File_Index = 0 then
--             return;
--          end if;

--          Read (File.File, Page, Page_File_Index);
--          Get_Keys (Page.Children (0));

--          if not OK then
--             return;
--          end if;

--          for Index in 1 .. Page.Length loop

--             OK := Page.Keys (Index) > Key;

--             exit when not OK;

--             Key := Page.Keys (Index);
--             Get_Keys (Page.Children (Index));

--          end loop;
--       end Get_Keys;

--    begin

--       Set_Mode (File.Handle.File.File, In_File);
--       Get_Keys (File.Root_Page_File_Index);

--       return OK;

--    end Is_Correctly_Ordered;


   procedure Get
     (File  : in     File_Type;
      Items :    out Item_Array;
      Last  :    out Natural) is

   begin

      Reset (File.Handle.File.all);

      Last := Items'First - 1;

      while not End_Of_File (File) loop

         Last := Last + 1;
         Read (File, Items (Last));

      end loop;

   end Get;



   package Page_Management is

      function New_Index_Page return Index_Page_Access;

      function New_Sequence_Page return Sequence_Page_Access;

      procedure Free_Page (Page : in out Page_Access);

   end Page_Management;
   use Page_Management;


   procedure Free_Tree
     (Page : in out Page_Access) is
   begin

      case Page.Kind is
         when Index_Kind =>

            for I in 0 .. Page.Length loop
               Free_Tree (Page.Children (I));
            end loop;

         when Sequence_Kind =>

            null;

      end case;

      Free_Page (Page);

   end Free_Tree;


   procedure Copy
     (From : in     File_Type;
      To   : in out Tree_Type) is


      function Copy_Sequence_Page
        (Page_File_Index : in Ada.Streams.Stream_IO.Positive_Count)
         return Sequence_Page_Access is

         Page : Sequence_Page_Type;
         Node : Sequence_Page_Access;
      begin
         Read (From.File, Page, Page_File_Index);

         Node := New_Sequence_Page;

         Node.Length := Page.Length;

         Node.Items (1 .. Node.Length) :=
           Page.Items (1 .. Page.Length);

         return Node;
      end Copy_Sequence_Page;



      function Copy_Index_Page
        (Page_File_Index : in Ada.Streams.Stream_IO.Positive_Count)
        return Index_Page_Access is

         Page : Index_Page_Type;
         Node : Index_Page_Access;
      begin
         Read (From.File, Page, Page_File_Index);

         Node := New_Index_Page;

         Node.Length := Page.Length;

         Node.Keys (1 .. Node.Length) :=
           Page.Keys (1 .. Page.Length);

         if Page.Is_Leaf then

            for I in 0 .. Node.Length loop
               Node.Children (I) :=
                 Copy_Sequence_Page (Page.Children (I));
            end loop;

         else

            for I in 0 .. Node.Length loop
               Node.Children (I) :=
                 Copy_Index_Page (Page.Children (I));
            end loop;

         end if;

         return Node;
      end Copy_Index_Page;

   begin

      if To.Root /= null then
         Free_Tree (To.Root);
      end if;

      Set_Mode (From.Handle.File.File, In_File);
      To.Root := Copy_Index_Page (From.Root_Page_File_Index);

   end Copy;


   procedure Put
     (Tree : in Tree_Type) is

      procedure Put_Items
        (Page  : in Sequence_Page_Access;
         Level : in Natural) is
      begin
         for I in 1 .. 3 * Level loop
            Ada.Text_IO.Put (' ');
         end loop;

         Ada.Text_IO.Put ('S');

         if Page.Length = 0 then
            Ada.Text_IO.Put ("<empty seq page>");
         else
            for I in 1 .. Page.Length loop
               Ada.Text_IO.Put (Get_Item_Image (Page.Items (I)));
            end loop;
         end if;

         Ada.Text_IO.New_Line;
      end Put_Items;


      procedure Put_Keys
        (Page  : in Index_Page_Access;
         Level : in Natural) is
      begin

         for I in 1 .. 3 * Level loop
            Ada.Text_IO.Put (' ');
         end loop;

         if Page.Length = 0 then
            Ada.Text_IO.Put ("<empty index page>");
         else
            for I in 1 .. Page.Length loop
               Ada.Text_IO.Put (Get_Key_Image (Page.Keys (I)));
            end loop;
         end if;

         Ada.Text_IO.New_Line;

         if Page.Children (0).Kind = Index_Kind then

            for I in 0 .. Page.Length loop
               Put_Keys (Page.Children (I), Level + 1);
            end loop;

         else

            for I in 0 .. Page.Length loop
               Put_Items (Page.Children (I), Level + 1);
            end loop;

         end if;

      end Put_Keys;


   begin -- Put

      Put_Keys (Tree.Root, Level => 0);

   end Put;



   package body Page_Management is

      Index_Page_Free_List : Index_Page_Access;

      Sequence_Page_Free_List : Sequence_Page_Access;


      function New_Index_Page return Index_Page_Access is
         Page : Index_Page_Access;
      begin
         if Index_Page_Free_List = null then
            Page := new Page_Type (Index_Kind);
         else
            Page := Index_Page_Free_List;
            Index_Page_Free_List := Index_Page_Free_List.Children (0);
            Page.Children (0) := null;
         end if;

         return Page;
      end New_Index_Page;


      function New_Sequence_Page return Sequence_Page_Access is
         Page : Sequence_Page_Access;
      begin
         if Sequence_Page_Free_List = null then
            Page := new Page_Type (Sequence_Kind);
         else
            Page := Sequence_Page_Free_List;
            Sequence_Page_Free_List := Sequence_Page_Free_List.Next;
            Page.Next := null;
         end if;

         return Page;
      end New_Sequence_Page;



      procedure Free_Page (Page : in out Page_Access) is
      begin

         if Page /= null then

            case Page.Kind is
               when Index_Kind =>

                  Page.Children (0) := Index_Page_Free_List;
                  Index_Page_Free_List := Page;

               when Sequence_Kind =>

                  Page.Next := Sequence_Page_Free_List;
                  Sequence_Page_Free_List := Page;

            end case;

            Page := null;

         end if;

      end Free_Page;

   end Page_Management;



end Indexed_Sequential_IO.Debug_G;
