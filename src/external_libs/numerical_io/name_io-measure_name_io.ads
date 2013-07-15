-------------------------------------------------------------------------------
--
--         Unit Name:      (Generic) package spec for Name_IO.Measure_Name_IO
--
-------------------------------------------------------------------------------
--
--              Author:         John P Woodruff
--                              jpwoodruff@gmail.com
--
--              Copyright       (c) 2007 John Woodruff
--
---------------------------------------------------------------------------
--  This is an extension of the package Name_IO that provides input
--  for the Measures class written by Dmitry Kazakov.  The full
--  functionality defined by Name_IO (and enhanced by
--  Name_IO.Matrix_Name_IO) is replicated here for measures that
--  include physical dimensionality (units).
--
--  Persons writing codes to manipulate physical quantities should
--  consult the documentation of Kazakov's work for the domain of
--  Measures, and should use this instance of Name_IO according to the
--  documentation in the parent package Name_IO.
--
--  Only scalar quantities have units defined in these packages.  The
--  services of Name_IO.Matrix_Name_IO are independent of this
--  package.
--
--  The details of format recognition of numeric values in this
--  package are defined by Kazakov's Measures, and thus may differ in
--  detail from the formatting of numerical values given by other
--  Name_IO services.



with Numeric_IO.Measure_IO ;

generic

   with package Measure_IO is new Numeric_IO.Measure_IO (<>) ;

package Name_IO.Measure_Name_IO is

   use Measure_IO ;

   procedure Get (Name   : in Names_Type;
                  Item   : out Local_Measures.Measure;
                  Prompt : in String := "");

end Name_IO.Measure_Name_IO ;


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

