with Integer_Indexed_Sequential_IO.Debug;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO;
with Ada.Exceptions;  use Ada.Exceptions;

procedure Test_Indexed_Sequential_IO is

   subtype Integer_2_Digit is
     Integer range 10 .. 99;

   package Random_Integers is
     new Ada.Numerics.Discrete_Random (Integer_2_Digit);


   subtype Count_Type is Positive range 1 .. 100;

   package Random_Counts is
      new Ada.Numerics.Discrete_Random (Count_Type);


   File : Integer_Indexed_Sequential_IO.File_Type;
   use Integer_Indexed_Sequential_IO;

   Items : Debug.Item_Array (1 .. 100);
   Last  : Natural;

   procedure Check_Items is
   begin
      Debug.Get (File, Items, Last);

      for I in 2 .. Last loop
         pragma Assert (Items (I) > Items (I-1));
         null;
      end loop;
   end Check_Items;


   G1   : Random_Integers.Generator;
   G2   : Random_Counts.Generator;
   Item : Integer;
   Tree : Debug.Tree_Type;

   type State_Type is (Writing, Removing, Emptying);
   State : State_Type;

   use Ada.Text_IO;
   use Integer_Indexed_Sequential_IO.Debug;
   use Random_Integers, Random_Counts;

begin

-- Create (File, Name => "testfile.dat");
   Create (File);

   Put ("Test");

   Outer:
   for Outer_Test_Index in Integer range 1 .. 10 loop

      Put (Integer'Image (Outer_Test_Index));

      Inner:
      for Inner_Test_Index in 1 .. 100 loop

         State := Writing;

         for Write_Index in 1 .. Random (G2) loop

            Item := Random (G1);
            Copy (From => File, To => Tree);
            Write (File, Item);
            pragma Assert (Is_In (File, Item));
            --         pragma Assert (Is_Correctly_Ordered (File));
            Check_Items;

         end loop;

         State := Removing;

         for Remove_Index in 1 .. Random (G2) loop

            Reset (File);
            exit when End_Of_File (File);

            Copy (From => File, To => Tree);

            Debug.Get (File, Items, Last);

--          Item := Random (G1);
            Item := Items ((Random (G2) mod Last) + 1);
            pragma Assert (Is_In (File, Item));
            Remove (File, Item);
            pragma Assert (not Is_In (File, Item));
            --         pragma Assert (Is_Correctly_Ordered (File));
            Check_Items;

         end loop;

      end loop Inner;

--      Put_Line ("emptying file");

      State := Emptying;

      loop

         Reset (File);
         exit when End_Of_File (File);

         Copy (From => File, To => Tree);

         Debug.Get (File, Items, Last);

         Item := Items ((Random (G2) mod Last) + 1);

         Remove (File, Item);
         pragma Assert (not Is_In (File, Item));
         --         pragma Assert (Is_Correctly_Ordered (File));
         Check_Items;

      end loop;

--      Put_Line ("done emptying file");

   end loop Outer;


   -- Complete the Puts of the outer test index.
   New_Line;

-- Close (File);

   Put_Line ("Test passed.");

exception
   when E: others =>

      New_Line (2);
      Put_Line (Exception_Name (E) & " error while " & State_Type'Image (State));

      declare
         Message : constant String := Exception_Message (E);
      begin
         if Message'Length > 0 then
            Put_Line ("Message: '" & Message & "'");
         end if;
      end;

      New_Line;

      Put_Line ("Items:");
      for I in 1 .. Last loop
         Put (Integer'Image (Items (I)));
      end loop;
      New_Line (2);

      Put_Line ("Old tree:");
      New_Line;

      Put (Tree);
      New_Line;

      Put_Line ("Item:" & Integer'Image (Item));
      New_Line;

      Put_Line ("New tree:");
      New_Line;

      Put_Tree (File);
      New_Line;

end Test_Indexed_Sequential_IO;
