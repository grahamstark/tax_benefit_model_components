------------------------------------------------------------------------
--
--                       INDEXED_SEQUENTIAL_IO
--
--      $Id: indexed_sequential_io.ads,v 1.15 1999/10/08 20:58:50 matt Exp $
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

with Ada.Streams.Stream_IO;
with Ada.IO_Exceptions;

generic

   type Item_Type is private;

   type Key_Type is private;

   Index_Order : in Positive;
   -- Defined as the minimum number of keys per index page.

   Sequence_Order : in Positive;
   -- Defined as the minimum number of items per sequence page.

   with function Get_Key (Item : Item_Type) return Key_Type is <>;

   with function "=" (L, R : Key_Type) return Boolean is <>;
   with function "<" (L, R : Key_Type) return Boolean is <>;
   with function "<=" (L, R : Key_Type) return Boolean is <>;

package Indexed_Sequential_IO is

   pragma Elaborate_Body;


   type File_Type is limited private;


   procedure Create
     (File : in out File_Type;
      Name : in     String := "");

   procedure Open
     (File : in out File_Type;
      Name : in     String);

   procedure Close
     (File : in out File_Type);

   function Is_Open
     (File : File_Type) return Boolean;


   procedure Reset
     (File : in out File_Type);
   -- Move to the beginning of the file, to start sequential processing.

   procedure Reset
     (File : in out File_Type;
      Key  : in     Key_Type);
   -- Move to the location in the file containing the smallest key greater
   -- than or equal to Key, to start sequential processing.

   function End_Of_File
     (File : File_Type) return Boolean;
   -- Indicates whether end-of-file has been reached (you have to check
   -- this prior to calling Read).  EOF status is updated by calls to Reset
   -- and Read; its value is meaningless otherwise.

   procedure Read
     (File : in     File_Type;
      Item :    out Item_Type);
   -- To read the items in the file sequentially.  You start sequential
   -- processing by first calling Reset, and you can't Read unless not
   -- End_Of_File.



   procedure Read
     (File : in     File_Type;
      Key  : in     Key_Type;
      Item :    out Item_Type);
   -- To read an item non-sequentially.  If no item with that Key is found,
   -- then Item_Not_Found is raised.
   --
   -- Note that this read does NOT cancel sequential processing already in
   -- progress, nor does it affect the stream pointer in any way.
   --
   -- If you want a read-by-key that does affect stream pointer, then just
   -- do a Reset (File, Key) followed immediately by a Read (File, Item).



   procedure Write
     (File : in File_Type;
      Item : in Item_Type);
   -- Write the item to the file.  If an item with the same key already
   -- exists in the file, then the already-existing item is replaced by
   -- Item.
   --
   -- Write'ing to the file cancels any sequential processing already in
   -- progress.  If you want to resume sequential processing, then you have
   -- to call Reset prior to calling Read (File, Item) again.



   procedure Remove
     (File : in File_Type;
      Key  : in Key_Type);
   -- Removes the item with the Key from the file.  If the key isn't in the
   -- file, then Remove does nothing.
   --
   -- Remove'ing from the file cancels any sequential processing already in
   -- progress.  If you want to resume sequential processing, then you have
   -- to call Reset prior to calling Read (File, Item) again.



   Item_Not_Found : exception;
   Status_Error   : exception renames Ada.IO_Exceptions.Status_Error;
   Mode_Error     : exception renames Ada.IO_Exceptions.Mode_Error;
   Name_Error     : exception renames Ada.IO_Exceptions.Name_Error;
   Use_Error      : exception renames Ada.IO_Exceptions.Use_Error;
   Device_Error   : exception renames Ada.IO_Exceptions.Device_Error;
   End_Error      : exception renames Ada.IO_Exceptions.End_Error;
   Data_Error     : exception renames Ada.IO_Exceptions.Data_Error;

private

   use Ada.Streams;


   Index_Page_Size : constant Positive := 2 * Index_Order;
   -- Defined as the maximum number of keys per index page.

   Sequence_Page_Size : constant Positive := 2 * Sequence_Order;
   -- Defined as the maximum number of items per sequence page.


   type Item_Array_Base is
      array (Positive range <>) of Item_Type;

   type Key_Array_Base is
      array (Positive range <>) of Key_Type;


   subtype Child_Range is
     Natural range 0 .. Index_Page_Size;

   type File_Index_Array is
      array (Child_Range) of Stream_IO.Positive_Count;


   type Index_Page_Type is
      limited record
         Length   : Natural;
         Keys     : Key_Array_Base (1 .. Index_Page_Size);
         Children : File_Index_Array;
         Is_Leaf  : Boolean;
      end record;

   type Sequence_Page_Type is
      limited record
         Length : Natural;
         Items  : Item_Array_Base (1 .. Sequence_Page_Size);
         Next   : Stream_IO.Count;
      end record;



   type Handle_Type (File : access File_Type) is
      limited null record;


   type End_Of_File_Status_Type is (Yes, No, Undefined);

   type File_Type is
      limited record
         Handle               : Handle_Type (File_Type'Access);
         File                 : Stream_IO.File_Type;
         Root_Page_File_Index : Stream_IO.Positive_Count := Stream_IO.Positive_Count'First;
         Root_Page            : Index_Page_Type;
         Sequence_Page        : Sequence_Page_Type;
         Index                : Positive;   -- for sequential processing
         End_Of_File_Status   : End_Of_File_Status_Type;
      end record;


   procedure Read
     (File : in     Stream_IO.File_Type;
      Page :    out Index_Page_Type;
      From : in     Stream_IO.Positive_Count);

   procedure Read
     (File : in     Stream_IO.File_Type;
      Page :    out Sequence_Page_Type;
      From : in     Stream_IO.Positive_Count);


   procedure Search
     (Keys  : in     Key_Array_Base;
      Key   : in     Key_Type;
      Index :    out Natural);

   procedure Search
     (Items : in     Item_Array_Base;
      Key   : in     Key_Type;
      Index :    out Natural;
      Found :    out Boolean);

end Indexed_Sequential_IO;
