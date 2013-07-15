-------------------------------------------------------------------------------
--
--              Unit Name:      (Generic) package spec for Numeric_IO.Matrix_IO
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
----------------------
--     Abstract     --
----------------------
--    Matrix_IO provides a full set of IO services based on text_io
--  that can read and write Vectors and Matrices.  The interface entry
--  names and parameter signatures exactly duplicate the procedures in
--  Ada.Text_IO.Float_Io.
--
--      Input is read using the Numeric_IO.Real_Decode procedure that
--  defines a user-friendly representation for real numbers.  Any of the
--  following notations return a legal Ada real number for any integer i:
--     i.i  |  i.iei  |  i  |  i.  |  .i  |  iEi  |  i.Ei  |  .iei
--
--      This package reads a vector as a sequence of real numbers.  In
--  case the parameter WIDTH is non-zero, then every element occupies
--  exactly WIDTH characters in the input.  Use this tactic when
--  reading input files written by some other program and formatted
--  into columns.
--
--    In the default case, WIDTH = 0, and each element is read
--  regardless of its spacing.  Elements of the vector are optionally
--  delimited by commas.  Individual elements may be defaulted by
--  elision: the input stream 1,,,4 results in the vector (1.0, 0.0,
--  0.0, 4.0).
--
--    Rows in a matrix are defined to be vectors separated by line
--  terminators.  The exception Data_Error is raised if too few
--  rows are input to a matrix get from a string.
--
--      Additional procedures are included that extend the interactive
--  GET procedures found in the parent of this package, including
--  prompting and optional default values.
--
--      The function Aft, which computes the number of digits needed to
--  represent the significant values of its argument, is provided for
--  both vector and matrix types.
--
--              Keywords:
--      Matrix_IO
--      Vector_IO
--      Interactive IO
--
--              Host system:
--      DEC MicroVAX2
--      DEC Ada Compiler 1.3 & 2.2
--      Rational Apex v3.0 et seq.
--      Gnat 3.13p
--
-------------------------------------------------------------------------------
--
--              Revision History:
--
--      Creation Time:   17-MAR-1987 14:12
--                       12-OCT-1992  Examined and prepared for export.
--                       15-NOV-2003  Generic child as discussed at parent
--
-------------------------------------------------------------------------------
--
generic
   type Vector_Ix is  (<>) ;
   type Vector_Type is array (Vector_Ix range <>) of Real ;

   type Matrix_Ix1 is (<>) ;
   type Matrix_Ix2 is (<>) ;
   type Matrix_Type is array (Matrix_Ix1 range <>, Matrix_Ix2 range <>) of Real ;

package Numeric_Io.Matrix_IO is
   subtype Vector is Vector_Type ;
   subtype Matrix is Matrix_Type ;

    subtype Field is Ada.Text_Io.Field ;

    Default_Fore : Field := Real_Io.Default_Fore;
    Default_Aft  : Field := Real_Io.Default_Aft;
    Default_Exp  : Field := Real_Io.Default_Exp;

-------------------------------------------------------------------------------
--  O P E R A T I O N S     O N     M A T R I C E S

    procedure Get (File  : in Ada.Text_Io.File_Type;
                   Item  : out Matrix;
                   Width : in Field := 0);

    procedure Get (Item : out Matrix; Width : in Field := 0);

    procedure Put (File : in Ada.Text_Io.File_Type;
                   Item : in Matrix;
                   Fore : in Field := Default_Fore;
                   Aft  : in Field := Default_Aft;
                   Exp  : in Field := Default_Exp);

    procedure Put (Item : in Matrix;
                   Fore : in Field := Default_Fore;
                   Aft  : in Field := Default_Aft;
                   Exp  : in Field := Default_Exp);

    procedure Get (From : in String; Item : out Matrix; Last : out Positive);

    procedure Put (To   : out String;
                   Item : in Matrix;
                   Aft  : in Field := Default_Aft;
                   Exp  : in Field := Default_Exp);

    --  Interactive procedure resembling POLITE_IO . GET
    procedure Get (Prompt : in String; Item : out Matrix);

    procedure Get (Prompt : in String; Default : in Matrix; Item : out Matrix);

    function Aft (Item : in Matrix; Exp : in Field := Default_Exp) return Field;

-------------------------------------------------------------------------------
--  O P E R A T I O N S     O N     V E C T O R S

    procedure Get (File  : in Ada.Text_Io.File_Type;
                   Item  : out Vector;
                   Width : in Field := 0);

    procedure Get (Item : out Vector; Width : in Field := 0);

    procedure Put (File : in Ada.Text_Io.File_Type;
                   Item : in Vector;
                   Fore : in Field := Default_Fore;
                   Aft  : in Field := Default_Aft;
                   Exp  : in Field := Default_Exp);

    procedure Put (Item : in Vector;
                   Fore : in Field := Default_Fore;
                   Aft  : in Field := Default_Aft;
                   Exp  : in Field := Default_Exp);

    procedure Get (From : in String; Item : out Vector; Last : out Positive);

    procedure Put (To   : out String;
                   Item : in Vector;
                   Aft  : in Field := Default_Aft;
                   Exp  : in Field := Default_Exp);

    --  Interactive POLITE procedures for vectors
    procedure Get (Prompt : in String; Item : out Vector);

    procedure Get (Prompt : in String; Default : in Vector; Item : out Vector);

    function Aft (Item : in Vector; Exp : in Field := Default_Exp) return Field;

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

