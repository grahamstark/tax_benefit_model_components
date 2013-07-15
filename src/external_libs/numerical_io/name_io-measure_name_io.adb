-------------------------------------------------------------------------------
--
--         Unit Name:      (Generic) package body for Name_IO.Measure_Name_IO
--
-------------------------------------------------------------------------------
--
--              Author:         John P Woodruff
--                              jpwoodruff@gmail.com
--
--              Copyright       (c) 2007 John Woodruff
--
-------------------------------------------------------------------------------
--
--  The present child package of Name_IO extends the types that can be
--  read to include the Measure type defined by D.K.

package body Name_IO.Measure_Name_IO is


   procedure Direct_Interaction is  new Scalar_IO.Polite_Get
     (Item_Type => Local_Measures.Measure,
      Decode    => Measure_IO.Get);

   procedure Interact_Directly (Prompt : in String;
                                Item   : out Local_Measures.Measure) is
   begin
      --  reverse the parameter order - to un-confuse overload (boring)
      Direct_Interaction (Prompt => Prompt, Item => Item);
   end Interact_Directly ;


   -- The two procedure params to Read are
     --  Decode, which (usually) takes its string input from the
     --          Inventory of named inputs, and
     --  Interact, which converses singlemindedly with the user (after
     --            an error or omission in the input Inventory)
   procedure Read_Measure is new Read
     (Item_Type => Local_Measures.Measure,
      Decode    => Measure_IO.Get,     -- gets from Inventory
      Interact  => Interact_Directly) ;


   ---------------------------------------------------------------------------
   --  Unlike the other instances of Name_IO, operations on Measures
   --  encounter Constraint_Error if units are mismatched.  Repair is
   --  effected here by interacting directly with the user in case of
   --  Con_Err.


   procedure Get (Name   : in Names_Type;
                  Item   : out Local_Measures.Measure;
                  Prompt : in String := "")  is
      Found : Boolean ;

      procedure Get_Until_Unit_OK is
         --  Direct interaction w user, complete only when unit is OK
      begin
         loop
            begin
               Ada.Text_IO.Put_Line ("Unit mismatch on input for " &
                                     Names_Type'Image(Name)) ;
               Interact_Directly (Prompt, Item) ;
               exit ;
            exception when Constraint_Error =>
               null ;
            end ;
         end loop ;
      end Get_Until_Unit_OK ;

   begin
      Read_Measure (Name, Found, Item, Prompt) ;
      if not Found  then
         raise No_Input ;
      end if ;
   exception when Constraint_Error =>
      Get_Until_Unit_OK ;
   end Get ;

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

