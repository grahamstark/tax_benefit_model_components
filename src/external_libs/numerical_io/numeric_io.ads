-------------------------------------------------------------------------------
--
--              Unit Name:      (Generic) package spec for Numeric_IO
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
--  This generic package provides a polite, refined input organ for
--  interactive data input.
--
--      The procedures are polite because they
--  Make building a multiple-choice menu easy;
--  Decode "loosely formatted" numeric input for floating numbers;
--  Prompt for a value;
--  Provide for a default value in case user inputs nothing;
--  Raise No-Entry in case the input stream is empty when called with
--  no default parameter.
--
--      Generic Polite_Get interacts with user to obtain a single
--  Item.  The type of Item, and a decoder that parses an Item from an
--  input stream, are provided at instantiation.
--
--      For each of integer and floating types, there are two
--  overloaded Get procedures.  One prompts and returns the value,
--  raising No_Entry in case nothing is entered; and the other allows
--  the program to offer a default that is returned in case the user
--  types no value.
--
--      A Menu procedure returns an upper case letter which is member
--  of a specified set of choices.  Choices are letters in an input
--  string; For Choices = "" (an empty set of choices), any letter is
--  acceptable.  Cases of the letters are not significant: neither the
--  case of the set of choices, nor the case of the user's response
--  affects the menu.
--
--      Aft is a function that yields the number of digits aft of the
--  decimal that are needed to render just the significant fraction of
--  a floating number.
--      Give Exp that will be the parameter of Float_Text_IO . Put
--  Aft (10.001, 0) == 3; Put (10.001, aft=>3, exp=>0) == "10.001"
--  Aft (10.001, 2) == 4; Put (10.001, aft=>4, exp=>2) == "1.0001E+1"
--
--      Real_Decode is a procedure that adds value to the standard GET
--  entry which decodes a string to a floating number.  The standard
--  version recognizes ONLY numbers formed as Ada literals, viz
--  i.i[Ei] for i an integer.  The Real_Decode entry here returns a
--  floating value (the type given by the generic parameter) of any of
--  the following input notations (including optional sign):
--
--     i.i  |  i.iei  |  i  |  i.  |  .i  |  iEi  |  i.Ei  |  .iei
--
--
--              Keywords:
--      Interactive Input
--
--  The idea for this package comes from the package SafeIO in the Simtel20
--  repository, by J A Anderson of Texas Instruments.
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
--      Creation Time:    5-JAN-1987 17:55
--            Revised:   19-MAR-1987 15:50      GENERIC Polite_Get in SPEC.
--                       13-OCT-1992            Prepared for widespread
--                                              release;  removed vms-specific
--                                              help facility.
--                       15-NOV-2003            Restructured to Ada-95 generic
--                                              package with children.
--
-------------------------------------------------------------------------------
with Ada.Text_Io ;

generic

   type Floating_Type is digits <> ;
   type Integer_Type  is range <> ;

   -- Users who employ an advanced user interface (eg windowing) can supply
   -- interacting string primitives to replace Ada.Text_IO:
   with procedure Interacting_Put (Item : in String) is Ada.Text_Io.Put ;
   with procedure Interacting_Put_Line (Item : in String) is Ada.Text_Io.Put_Line ;
   with procedure Interacting_Get_Line (Item : out String;
                                        Last : out Natural) is Ada.Text_Io.Get_Line ;
   with procedure Interacting_Skip_Line (Spacing : in Ada.Text_Io.Positive_Count := 1)
                                         is Ada.Text_Io.Skip_Line ;

package Numeric_Io is

   subtype Real is Floating_Type ;
   subtype Counting is Integer_Type ;

   package Real_Io is new Ada.Text_Io.Float_Io (Real) ;
   package Counting_IO is new Ada.Text_Io.Integer_Io (Counting) ;


   subtype Letter is Character range 'A' .. 'z';
   subtype Upper_Case_Letter is Letter range 'A' .. 'Z';

   No_Entry : exception;             --  Polite_Get got empty stream;
                                     --  User wants default Item

   Line_Terminator : constant String := Ascii.Cr & Ascii.Lf;

   generic
      type Item_Type (<>) is private;
      Input_Size : Positive := 132; -- max chars in an input line
      with procedure Decode (From : in String;
                             Item : out Item_Type;
                             Last : out Positive);
   procedure Polite_Get (Item : out Item_Type; Prompt : in String);

   -------------------------------------------------------------------------------

   --  Polite IO for real values --
   procedure Get (Prompt : in String; Item : out Real);

   procedure Get (Prompt : in String; Default : in Real; Item : out Real);

   function Aft (Item : in Real;
                 Exp  : in Ada.Text_Io.Field := Real_IO.Default_Exp)
                return Ada.Text_Io.Field;

   --  Give Exp that will be the parameter of Float_Text_IO.Put
   --  Aft (10.001, 0) == 3; Put (10.001, aft=>3, exp=>0) == "10.001"

   procedure Real_Decode (From : in String;
                          Item : out Real;
                          Last : out Positive);

   -------------------------------------------------------------------------------

   --  Polite IO for "Counting" numbers (integers) --
   procedure Get (Prompt  : in String; Item : out Counting);

   procedure Get (Prompt  : in String;
                  Default : in Counting;
                  Item    : out Counting);

   --  Polite selection from menu of SINGLE UPPER CASE Letters
   procedure Menu (Prompt : in String := "";
                   Choice : in String;
                   Item   : out Upper_Case_Letter);

   procedure Menu (Prompt  : in String := "";
                   Default : in Letter;
                   Choice  : in String;
                   Item    : out Upper_Case_Letter);

private
   You_Must_Line : constant String
                 := "There is no default; you must give a value. " ;
end Numeric_Io ;


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

