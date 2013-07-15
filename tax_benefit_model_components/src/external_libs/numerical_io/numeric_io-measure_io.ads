-------------------------------------------------------------------------------
--
--              Unit Name:      (Generic) package spec for Numeric_IO.Measure_IO
--
-------------------------------------------------------------------------------
--
--              Author:         John P Woodruff
--                              jpwoodruff@gmail.net
--
--              Copyright       (c) 2007 John Woodruff
--
-------------------------------------------------------------------------------
--
----------------------
--     Abstract     --
----------------------

--  This child package of Numeric_IO exists solely to serve
--  Name_IO.Measure_Name_IO. It declares only those procedures as are
--  needed as generic parameters in the Name_IO service.
--
--  Details of numeric formatting are not necessarily the same as in
--  other child packages of Numeric_IO because Kazakov's Measures_Edit
--  package implements all formatting decisions for measures with
--  units.
--
--  "No user servicable parts inside"

with Measures ;

generic

   with package Local_Measures is new Measures(Real);

package Numeric_IO.Measure_IO is
   use Ada.Text_IO ;
   -- plagarize matrix - minimally
   -- only what's needed for implementing name_IO.

   --  Put goes to std out, formatted two ways.  Good for tests
   --  and error msgs, but DK's functions rule.
   procedure Put (Item : in Local_Measures.Measure ;
                  Fore : in Field := Real_IO.Default_Fore;
                  Aft  : in Field := Real_IO.Default_Aft;
                  Exp  : in Field := Real_IO.Default_Exp);


   -- overload of ada.text_io.get will satisfy name_io:
   procedure Get (From : in String;
                  Item : out Local_Measures.Measure;
                  Last : out Positive);

   -- interactive ops for error diag & input repair
   procedure Get (Prompt : in String;
                  Item   : out Local_Measures.Measure) ;


   procedure Get (Prompt  : in String;
                  Default : in Local_Measures.Measure;
                  Item    : out Local_Measures.Measure);

end Numeric_IO.Measure_IO ;

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

