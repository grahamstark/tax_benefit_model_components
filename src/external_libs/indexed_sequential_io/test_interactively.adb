with Integer_Indexed_Sequential_IO.Debug;
with Ada.Text_IO;

procedure Test_Interactively is

   File : Integer_Indexed_Sequential_IO.File_Type;

   Line : String (1 .. 80);
   Last : Natural;

   use Ada.Text_IO;
   use Integer_Indexed_Sequential_IO;


   procedure Read_Item is

      Item, Key : Integer;

   begin

      <<Get_Read_Key>> Put ("Key: ");  Get_Line (Line, Last);

      if Last = 0 then
         Put_Line ("No key specified; try again.");
         New_Line;
         goto Get_Read_Key;
      end if;

      begin
         Key := Integer'Value (Line (1 .. Last));
      exception
         when Constraint_Error =>
            Put_Line ("bad key");
            goto Get_Read_Key;
      end;

      begin
         Read (File, Key => Key, Item => Item);
         Put_Line ("read item is" & Integer'Image (Item));
      exception
         when Item_Not_Found =>
            Put_Line
              ("no item with key" &
               Integer'Image (Key) &
               " was found");
      end;

      New_Line;

   end Read_Item;


   procedure Read_All_Items is
      Item : Integer;
   begin
      Reset (File);

      if End_Of_File (File) then

         Put_Line ("<empty>");

      else

         while not End_Of_File (File) loop
            Read (File, Item);
            Put (Integer'Image (Item));
         end loop;

         New_Line;

      end if;

      New_Line;
   end Read_All_Items;


   I : Integer;

   use Debug;

begin

   Create (File);
   Put_Tree (File);
   New_Line;

   <<Get_Insertion_Value>> Put ("Insert: "); Get_Line (Line, Last);

   if Last = 0 then

      goto Get_Deletion_Value;

   elsif Line (1) = 'p' then

      Put_Tree (File);
      New_Line;
      goto Get_Insertion_Value;

   elsif Line (1) = 'r' then

      Read_Item;
      goto Get_Insertion_Value;

   elsif Line (1) = 'R' then

      Read_All_Items;
      goto Get_Insertion_Value;

   elsif Line (1) = 'x' then

      goto Exit_Program;

   else

      begin
         I := Integer'Value (Line (1 .. Last));
      exception
         when Constraint_Error =>
            Put_Line ("bad insertion value");
            goto Get_Insertion_Value;
      end;

      begin
         Write (File, I);
      exception
         when Constraint_Error =>
            Put_Line ("CE during Write");
      end;

      if not Is_In (File, I) then
         Put_Line
           ("Error: item" &
            Integer'Image (I) &
            " is not in the file.");
         New_Line;
      end if;

      declare
         J : Integer;
      begin
         Reset (File, I);
         Read (File, J);
         if I /= J then
            Put_Line
              ("Error: read item" & Integer'Image (J) &
               " which doesn't match key" & Integer'Image (I));
         end if;
      end;

      begin
         Put_Tree (File);
      exception
         when Constraint_Error =>
            Put_Line ("CE during Put_Tree");
      end;

      New_Line;
      goto Get_Insertion_Value;

   end if;



   <<Get_Deletion_Value>> Put ("Delete: "); Get_Line (Line, Last);

   if Last = 0 then

      goto Get_Insertion_Value;

   elsif Line (1) = 'r' then

      Read_Item;
      goto Get_Deletion_Value;

   elsif Line (1) = 'R' then

      Read_All_Items;
      goto Get_Deletion_Value;

   elsif Line (1) = 'p' then

      Put_Tree (File);
      New_Line;
      goto Get_Deletion_Value;

   elsif Line (1) = 'x' then

      goto Exit_Program;

   else

      begin
         I := Integer'Value (Line (1 .. Last));
      exception
         when Constraint_Error =>
            Put_Line ("bad deletion value");
            goto Get_Deletion_Value;
      end;


      begin
         Remove (File, I);
      exception
         when Constraint_Error =>
            Put_Line ("CE during Remove");
      end;


      if Is_In (File, I) then
         Put_Line
           ("Error: item" &
            Integer'Image (I) &
            " is in the file.");
         New_Line;
      end if;


      begin
         Put_Tree (File);
      exception
         when Constraint_Error =>
            Put_Line ("CE during Put_Tree");
      end;

      New_Line;
      goto Get_Deletion_Value;

   end if;


   <<Exit_Program>> Close (File);

end Test_Interactively;
