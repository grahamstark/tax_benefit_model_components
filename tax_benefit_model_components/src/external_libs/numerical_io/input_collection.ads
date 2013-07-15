-------------------------------------------------------------------------------
--
--              Unit Name:      Package spec for Input_Collection
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
--
------------------
--    Abstract: --
------------------
--      Input_Collection is a repository of user inputs that are to be
--  dispensed to individual objects when entries of instances of the
--  generic package Name_IO are invoked.  The input is obtained from
--  some file(s) and retained in this package until called for by some
--  object.
--
--      The user provides one or more text files structured like -->
--        <<    Class_Name
--              {Any "contents" readable by the Object}
--              END     >>
--
--      This package collects these and indexes them by Class_Name.
--  Usual operation might have numerous of these blocks with the same
--  Class_Name, with each of the blocks holding the input data for one
--  instance of the class.
--
--      Both Class_Name and END must be on a line by itself; otherwise
--  there are no rules imposed by this package about the form of the
--  input file(s), and the contents are delivered exactly as read from
--  the file (except that blank lines and Ada-style comments are
--  removed).
--
--      The intended user of this repository is an instance of
--  Name_IO, however any client package may call the Get_Contents
--  procedure, citing some Class_Name and receive the contents text.
--  If the same Class_Name occurs twice in the input file(s), then
--  successive calls to give_contents will deliver the inputs in FIFO
--  order.  If no input has been collected for an Class_Name, the
--  exception No_Input_For_Object is raised.  The Contents that is
--  delivered is a PERSISTENT string_Type.  When the user has finished
--  with it, s/he should do String_Pkg.Flush (Contents).  (Name_IO
--  does follow this advice.)
--
--
--              Keywords:
--      Object-Oriented Input
--
--              Host system:
--      DEC MicroVAX2
--      DEC Ada Compiler 1.3
--      Rational Apex v3.0 et seq.
--      Gnat 3.13p et seq.
--
-------------------------------------------------------------------------------
--
--              Revision History:
--
--      Creation Time:    1-MAY-1987 07:59
--
-------------------------------------------------------------------------------
--
with String_Pkg;

package Input_Collection is

    File_Read_Error, No_Input_For_Object : exception;

    subtype Data_Collection_Type is String_Pkg.String_Type;

    procedure Read_Collection_Files;
    
    procedure Read_File (File_Name : in String);

    procedure Get_Contents (Class_Name : in String;
                            Contents   : out Data_Collection_Type);
    --  Contents is a PERSISTENT string_Type;  do
    --  String_Pkg.Flush(Contents) when finished.

end Input_Collection;

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
