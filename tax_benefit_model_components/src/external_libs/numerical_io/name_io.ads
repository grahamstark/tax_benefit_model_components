-------------------------------------------------------------------------------
--
--              Unit Name:      (Generic) package spec for Name_IO
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
-------------------
--     Abstract: --
-------------------
--      Name_IO implements name-directed input in a generic package.
--  The package is able to deliver values bound to variables from an input
--  stream that looks like:
--      A = 1.0 ;                               -- a floating scalar
--      V := 3, 4, 5 ;                          -- a three-vector
--      Filename => "Test.dat" ;                -- a string
--      Enum  = Users_Enumerated_Constant ;     -- Enumeration value
--
--      The format for the input to be parsed is a sequence of
--  {  <Ada_Id> [assignment] <Value> ; }.
--  <Ada_Id> is any legal Ada identifier.
--  The optional [assignment] can be any of "=", ":=", or "=>".
--  Semicolon separators are required between assignments.
--  The form of <Value> is determined by the type of
--  the variable, and is defined by Numeric_IO.Real_Decode for floating
--  values, and by Matrix_IO.Get for vectors and matrices.
--  (The semicolon forms a terminator on a string that will be
--  parsed as a value, without placing any lexical requirement on
--  value, allowing the generic get_item to deliver an enumerated value.)
--
--      The parameters to be provided at instantiation are an enumerated
--  type whose literals are <Ada_Id> and an optional Put_Error_Msg for
--  accepting error data.
--
--------------------------
--     Usage  Overview  --
--------------------------
--      The package is a FINITE STATE MACHINE which can be used
--  successively to recognize different streams of data all with the
--  same collection of <Ada_Id>'s.  The sequence of actions on the state
--  machine are:
--      1) initialize the input data by EITHER

--  1a) Accept_Input -- called by user to provide a dynamic string of
--  type String_Pkg.String_Type which is the input to be parsed.  Use
--  this procedure when your application does not want to read files
--  that an interacting user specifies.
--  1b) Acquire_Input --  given a Class_Name, this procedure will
--  invoke Input_Collection.Get_Contents to get its own dynamic string
--  of data that are to be parsed. Use this method when this package
--  is used in an Object-Oriented program in which arbitrarily many
--  distinct objects of some type each need the same kind of input,
--  and the data are to be read from one or more text files.
--  (There is more discussion of Object-Oriented input further on).
--      2) Arbitrarily many calls of Get  --  called to obtain the
--  value that was bound to a particular <Ada_Id> in the input;
--      3) Forget_Contents -- called by user to signal that user has
--  obtained all the values that s/he intends to obtain.  After
--  forgetting, calls to Get raise No_Input until a new call of
--  Accept_Input or Acquire_Input has provided a new string.
--
---------------------------
--     Getting Values    --
---------------------------
--      Five overloaded calls to Get are provided, for any
--  of Integer, Floating number, Vector, Matrix, and String values.
--  Each is called with a value of Name_Type (which is represented
--  by a literal that is expected to occur as <Ada_Id> in the input).
--      There are two ways to use any of the Get procedures
--
--     (a)      Get (Name => Name_List.A,
--                   Item => A ) ;
--      Returns a value for the variable A which appeared in the input
--  as a binding like 'A := 10.3';   If no binding exists in the input,
--  then raise No_Input.
--      Use this way in a program that has default values for some input,
--  which can be replaced at run time.  Assign the default value of A in
--  the exception handler for exception No_Input.
--
--     (b)      Get (Name   => Name_List.B,
--                   Item   => B,
--                   Prompt => "Please give value for B") ;
--      Returns the value of B which appeared in the input if the
--  binding exists, ELSE prompt Standard-Input for a value.  The
--  generic actual for Interactive_Get_Line can be used to interact on
--  some other user face.
--      Use this way if your program will not run unless user input is
--  given for some variable (and you expect to have a user handy ;-)
--
--      The Get which returns string has an additional out parameter,
--  Last : Natural, which means the index of the last character in the Item
--  which was copied from the input.
--  This Get resembles Text_IO . Get_Line in its handling of the
--  arbitrary length of an input string with a fixed length parameter.
--  In case Last = Item'Length, successive calls of Get return
--  sequential pieces of the input.
--
--      The generic procedure Get_Item may be instantiated with the user's
--  enumerated type, and calls to the instance will return values of that
--  type.  (Get_Item has a distinct name because otherwise it is a homograph
--  of the Get procedure already defined for Integer.)
--
--------------------------------------
--     A SUGGESTION ABOUT NAMES     --
--------------------------------------
--  A program that instantiates this package might wish to declare --
--      DECLARE
--          TYPE Input_Names_Type  IS  ( A, B, C ) ;
--          A   : Integer ;
--      ET CETERA  ----
--
--      This program is NOT a legal Ada program!  The declaration A  : Integer
--  is an illegal redeclaration of the enumeral A that occurs in the
--  preceeding line.  (ref LRM 8.3(17))
--
--      An acceptable alternative that retains the appearance of the NAME A
--  in agreement with the VARIABLE A is as follows :
--        DECLARE
--            PACKAGE Name_List IS
--                TYPE Input_Names_Type IS ( A, B, C ) ;
--            END Name_List ;
--            A   : Integer ;
--            PACKAGE NIO IS NEW Name_IO  (
--                Names_Type   => Name_List . Input_Names_Type ) ;
--        ET CETERA  -----
--
------------------------------------------
--    MORE ON OBJECT ORIENTED INPUT     --
------------------------------------------
--      This package may be used in conjunction with Package Input_Collection
--  to acquire input in a program where there are arbitrarily many distinct
--  objects of some (application defined) type which each needs some input.
--      Suppose you have an Object_Package with an interface procedure Create
--  which you call to create an instance of a private type.  You don't know
--  a priori how many instances there will be.  Nor do you wish to constrain
--  how the input will be taken.
--      Your Object_Package should instantiate this package with names
--  that define the input needed to specify an object of its private type.
--      Some part of your program (not necessarily the object package)
--  calls Input_Collection.Read_File arbitrarily many times to read
--  some input files.  (refer to the documentation in Input_Collection).
--      Let your Object_Package.Create call Name_IO.Acquire_Input ("OBJECT")
--  followed by calls to Get.  The effect of this call to Create will be
--  to process all the input for "OBJECT" that was in one of the input files.
--  If you call create repeatedly, it will process successive instances
--  of OBJECT that were defined in all the input files that had earlier
--  been given to Input_Collection.Read_File.
--      You may wish to call Set_Object_Instance_Name after a call to
--  Acquire_Input.  This will bind an instance name to the error messages
--  and prompts so the user can know which of several object inputs is
--  delivering a particular message.
--     <Well, that wasn't too bad for 1987. JPW>
--
-------------------------------------------------------------------------------
--
--              Keywords:
--      Name Directed IO
--
--              Host system:
--      DEC MicroVAX2
--      DEC Ada Compiler 1.3 & 2.2
--      Rational Apex v3.0 et seq.
--      Gnat 3.13p et seq.
--
-------------------------------------------------------------------------------
--
--              Revision History:
--
--      Creation Time:    7-MAY-1987 10:28
--
--                       10-JUN-1987 18:20  jw
--                       Added interactivity with prompting if no binding
--                       in input contents.
--
--                       12-OCT-1992  Prepared for wide release.
--                        9-JUL-1993  Generic proc Get_Item defined; returns
--                                    a value of an enumerated type.
--                                    (Thanks A P Ludwigsen)
--                       15-OCT-2003  Ada-95 generic child packages
--                                    and cosmetic touchup, but the
--                                    implementation still runs the
--                                    anachronistic "ASR_String_Utilities"
--
-------------------------------------------------------------------------------
--
with String_Pkg;
with Ada.Text_Io;
with Numeric_Io;


generic
   type Names_Type is (<>);

   type Floating_Type is digits <> ;
   type Integer_Type is range <> ;

   with package Scalar_Io is new Numeric_Io (Floating_Type, Integer_Type) ;

   with procedure Put_Error_Msg (Item : in String) is Ada.Text_Io.Put_Line;
   with procedure Interacting_Put (Item : in String) is Ada.Text_Io.Put ;
   with procedure Interacting_Get_Line (Item : out String;
                                        Last : out Natural) is Ada.Text_Io.Get_Line ;

package Name_Io is

   No_Input : exception;    -- no binding in file AND no prompt

   procedure Acquire_Input (Class_Name : in String);

   procedure Accept_Input (Contents : in out String_Pkg.String_Type);

   procedure Set_Object_Instance_Name (Instance_Name : in String);

   procedure Forget_Contents;

   procedure Get (Name   : in Names_Type;
                  Item   : out Integer_type;
                  Prompt : in String := "");

   procedure Get (Name   : in Names_Type;
                  Item   : out Scalar_io.Real;
                  Prompt : in String := "");

   procedure Get (Name   : in Names_Type;
                  Item   : out String;
                  Last   : out Natural;
                  Prompt : in String := "");

   generic
      type Item_Type is (<>);
   procedure Get_Item (Name   : in Names_Type;
                       Item   : out Item_Type;
                       Prompt : in String := "");


private
    Line_Terminator : String renames Scalar_Io.Line_Terminator ;

   generic
      type Item_Type (<>) is private;
      with procedure Decode (From : in String;
                             Item : out Item_Type;
                             Last : out Natural);
      with procedure Interact
        (Prompt : in String := ""; Item : out Item_Type);

   procedure Read (Name   : in Names_Type;
                   Found  : out Boolean;
                   Item   : out Item_Type;
                   Prompt : in String := "");

   procedure Show_Error_Context ;

end Name_Io;


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

