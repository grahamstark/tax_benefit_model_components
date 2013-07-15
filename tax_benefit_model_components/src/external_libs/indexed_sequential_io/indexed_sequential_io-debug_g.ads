------------------------------------------------------------------------
--
--                    INDEXED_SEQUENTIAL_IO.DEBUG_G
--
--      $Id: indexed_sequential_io-debug_g.ads,v 1.4 1999/10/08 05:59:47 matt Exp $
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

generic

   with function Get_Key_Image
     (Key : Key_Type) return String is <>;

   with function Get_Item_Image
     (Item : Item_Type) return String is <>;

package Indexed_Sequential_IO.Debug_G is

--   procedure Dump_Page_Info;

--    procedure Put
--      (File : in File_Type);

   procedure Put_Tree
     (File : in File_Type);

   function Is_In
     (File : File_Type;
      Key  : Key_Type) return Boolean;

--    function Get_Number_Of_Items
--      (File : File_Type) return Natural;


   type Item_Array is
      array (Positive range <>) of Item_Type;

   procedure Get
     (File  : in     File_Type;
      Items :    out Item_Array;
      Last  :    out Natural);



   type Tree_Type is limited private;

   procedure Copy
     (From : in     File_Type;
      To   : in out Tree_Type);

   procedure Put
     (Tree : in Tree_Type);

private

   type Page_Kind is (Index_Kind, Sequence_Kind);

   type Page_Type (Kind : Page_Kind);
   type Page_Access is access Page_Type;

   type Child_Array is
      array (0 .. Index_Page_Size) of Page_Access;

   subtype Index_Page_Access is
     Page_Access (Index_Kind);

   subtype Sequence_Page_Access is
     Page_Access (Sequence_Kind);

   type Page_Type (Kind : Page_Kind) is
      limited record
         Length : Natural;

         case Kind is
            when Index_Kind =>
               Keys     : Key_Array_Base (1 .. Index_Page_Size);
               Children : Child_Array;

            when Sequence_Kind =>
               Items : Item_Array_Base (1 .. Sequence_Page_Size);
               Next  : Sequence_Page_Access;

         end case;
      end record;

   type Tree_Type is
      limited record
         Root : Index_Page_Access;
      end record;

end Indexed_Sequential_IO.Debug_G;
