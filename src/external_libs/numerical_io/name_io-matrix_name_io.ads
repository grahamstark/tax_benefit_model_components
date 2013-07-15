-------------------------------------------------------------------------------
--
--         Unit Name:      (Generic) package spec for Name_IO.Matrix_Name_IO
--
-------------------------------------------------------------------------------
--
--              Author:         John P Woodruff
--                              jpwoodruff@irisinternet.net
--
--              Copyright       (c) 1987 John Woodruff
--
--                              Original work performed at
--                              Lawrence Livermore National Laboratory
--                              Material was released by LLNL in 1992
-------------------------------------------------------------------------------
--  This is an extension of the package Name_IO, which delivers input
--  from a file to callers of procedures Get.  Name_IO gets its input
--  from a file that is formatted like:
--
--        A  := 4.2 ;
--        Label := "Data for a computation" ;
--
--  The present child package of Name_IO extends the types that can be
--  read to include vector and matrix.
--
--       v := 1,,3 ;
--
--       mat :=
--             1 0 0
--             0 1 0
--             0 0 1 ;
--
--  Of course this package exploits the services of
--  Numeric_IO.Matrix_IO in exactly the same way as Name_IO uses
--  Numeric_IO.


with Numeric_Io.Matrix_Io ;
generic

   with package Matrix_Io is new Scalar_Io.Matrix_Io (<>);

package Name_Io.Matrix_name_IO is
   use Matrix_Io ;

   procedure Get (Name   : in Names_Type;
                  Item   : out Vector;
                  Prompt : in String := "");

   procedure Get (Name   : in Names_Type;
                  Item   : out Matrix;
                  Prompt : in String := "");

end Name_Io.Matrix_name_IO ;


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

