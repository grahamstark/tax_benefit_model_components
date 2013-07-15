-------------------------------------------------------------------------------
--
--              Unit Name:      (Generic) package body for Numeric_IO.Measure_IO
--
-------------------------------------------------------------------------------
--
--              Author:         John P Woodruff
--                              jpwoodruff@gmail.net
--
--              Copyright       (c) 2007 John Woodruff
--
-------------------------------------------------------------------------------

--  There is no good reason to use these procedures EXCEPT to
--  implement the Name_IO.Measures_IO functions.
--
--  They satisfy the req's for Name_IO's actual parameters, but the
--  far more complete set of operations in Kazakov's product should be
--  used in applications.

with Measures_Derived ;
with Measures_Irregular;
with Strings_Edit.Float_Edit;
with Measures_Edit;


package body Numeric_IO.Measure_IO is

   package  Strings_Edit_Local_Floats is new
     Strings_Edit.Float_Edit (Floating_type);

   package Local_Measures_Derived is new
     Measures_Derived (Local_Measures) ;

   package Local_Measures_Irregular is new
     Measures_Irregular ( Local_Measures_Derived) ;

   package Local_Measures_Edit is new
     Measures_Edit (Local_Measures_Irregular,
                    Strings_Edit_Local_Floats);

   ---------------------------------------------------------------------------
   --  This Put is the single overloaded text_io.put operation needed.
   --  It is used in error messages
   procedure Put (Item : in Local_Measures.Measure ;
                  Fore : in Field := Real_IO.Default_Fore;
                  Aft  : in Field := Real_IO.Default_Aft;
                  Exp  : in Field := Real_IO.Default_Exp)is

      use Local_Measures_Edit ;
   begin
      Put ( "Derived: "
            &  Image(item, Latin1 => False, Relsmall => 4)
            & "    In base units: "
            & Image(item, Derived => False, Relsmall => 4)) ;
   end Put ;

   ---------------------------------------------------------------------------

   procedure Get_Measure is new
     Polite_Get (Item_type => Local_Measures.Measure,
                 Decode    => Get) ;

   -------------------------------------------------------------------------
   --  This Get is the one that overloads ada.text_io.get.  It's at
   --  the bottom of the call stack within this package and is the
   --  only "get" that reaches out to Kazakov's implementation.  The
   --  other Get overloads in this package simply add value to the ui.
   procedure Get (From : in String;
                  Item : out Local_Measures.measure;
                  Last : out Positive) is
      Pointer : Positive := From'First ;
   begin
      Local_Measures_Edit.Get (Source  => From,   -- calls DK
                                        Pointer => Pointer,
                                        Value   => Item,
                                        Latin1  => False) ;
      Last := Pointer ;
   end Get;

   -------------------------------------------------------------------------

   procedure Get (Prompt  : in String;
                  Default : in Local_Measures.Measure;
                  Item    : out Local_Measures.Measure) is
      -- sew the default's image into the prompt and call through
      Def_Str : String
              := Local_Measures_Edit.Image
                    (default, Latin1 => False, Relsmall => 4);

   begin
      Get  (Prompt & " [" & Def_Str & "]", Item);
   exception
      when No_Entry =>
         Item := Default;
   end Get;

   -------------------------------------------------------------------------

   procedure Get (Prompt : in String;
                  Item   : out Local_Measures.Measure) is
   begin
      loop
         begin
            Get_Measure (Item, Prompt);  -- instance of polite_get
            exit;
         exception
            when No_Entry =>
               Interacting_Put_Line (You_Must_Line)  ;
         end;
      end loop;
   end Get;


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

