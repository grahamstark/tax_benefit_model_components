-------------------------------------------------------------------------------
--
--           Unit Name:      Package body for Name_IO.Matrix_Name_IO
--
-------------------------------------------------------------------------------
--
--      The package is a FINITE STATE MACHINE which can be used
--  successively to recognize different streams of data all with the
--  same collection of <Ada_Id>'s.  The sequence of actions on the state
--  machine are:
--      1) Initialize the input data by EITHER
--  1a) Accept_Input  --  called by user to provide a dynamic string
--  of type String_Pkg.String_Type which is the input to be parsed.
--  Use this procedure when there is a unique string of input to be
--  parsed.
--  1b) Acquire_Input --  given a Object_Name, this procedure will
--  invoke Input_Collection.Get_Contents to get its own dynamic string
--  of data that are to be parsed.  Use this method when this package
--  is used in an Object-Oriented program in which arbitrarily many
--  distinct objects of some type each need the same kind of input.
--      2) Arbitrarily many calls of Get  --  called to obtain the
--  value that was bound to a particular <Ada_Id> in the input;
--      3) Forget_Contents -- called by user to signal that user has
--  obtained all the values that s/he intends to obtain.  After
--  forgetting, calls to Get raise No_Input until a new call of
--  Accept_Input or Acquire_Input has provided a new string.
--
--
--              Technique
--      Step 1: Accept (or acquire) input
--  Scan the sequence of {  <Ada_Id> [assignment] <Value> [;] };
--  Interpret <Ada_Id> as the 'Image of a literal in Names_Type;
--  Remove assignment ops, line-terminators, and semicolons;
--  Store the <value> string in an array, indexed by Names_Type.
--
--      Step 2: Deliver value to caller of Get
--  Pass the string <value> to an instance of Get (From: String, ... )
--  which matches the type of the Item that the caller is requesting.
--  Whatever Get (From: String ...) delivers is the value that the
--  input bound.
--
--              Acknowledgment:
--      I first learned the technique used here in the package NAMELIST,
--  written by David Kwong...finished 10/86.
--      Received: from SIMTEL20.ARPA by lll-icdc.arpa ;
--      PD:<ADA.COMPONENTS>NAMELIST.SRC.0
--  This revision takes input from a string_type (instead of text_io read),
--  and uses the polite_io and matrix_io get routines to recognize
--  floating input.
--
--              Host system:
--      DEC MicroVAX2
--      DEC Ada Compiler 1.3 & 2.2
--
-------------------------------------------------------------------------------
--
with Ada.Io_Exceptions ;

package body Name_Io.Matrix_name_IO is

   procedure Read_Vector is new Name_Io.Read (Item_Type => Vector,
                                              Decode    => Matrix_Io.Get,
                                              Interact  => Matrix_Io.Get);

   procedure Read_Matrix is new Read (Item_Type => Matrix,
                                      Decode    => Matrix_Io.Get,
                                      Interact  => Matrix_Io.Get);

   -------------------------------------------------------------------------------

   -------------------------------------------------------------------------------

   procedure Get (Name : in Names_Type;
                  Item : out Vector;
                  Prompt : in String := "") is
      Found : Boolean;
   begin
      Read_Vector (Name, Found, Item, Prompt);
      if not Found then
         raise No_Input;
      end if;
   end Get;

   -------------------------------------------------------------------------------

   procedure Get (Name   : in Names_Type;
                  Item   : out Matrix;
                  Prompt : in String := "") is

      Found : Boolean;
   begin
      begin
         Read_Matrix (Name, Found, Item, Prompt);
      exception
         when Ada.Io_Exceptions.Data_Error =>
            Put_Error_Msg ("The matrix " & Names_Type'Image (Name) &
                           " has too few rows ");
            Show_Error_Context;
            if Prompt'Length > 0 then
               Matrix_Io.Get (Prompt, Item);
            else            -- user gives no interactivity
               raise No_Input;
            end if;
      end;

      if not Found then
         raise No_Input;
      end if;
   end Get;


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

