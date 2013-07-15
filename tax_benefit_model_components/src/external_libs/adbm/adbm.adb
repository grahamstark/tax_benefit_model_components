
-------------------------------------------------------------------------------
--                                                                           --
--  Project   : Adbm
--
--  $Id: adbm.adb,v 1.11 1998/12/30 19:34:24 obry Exp $
--
--  Author    : Pascal Obry
--  e-mail    : pascal_obry@csi.com
--
--  Machine/System Compiled/Run on : SPARC SUN-OS, GNAT
--                                   SPARC Solaris 2.3, GNAT
--                                   PC/DOS, GNAT
--                                   Windows 95/NT, GNAT
--                                                                           --
-------------------------------------------------------------------------------



with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Ada.Unchecked_Deallocation;

with POSIX;
with POSIX_Permissions;
with POSIX_Files;

with Adbm_Direct_IO;
with Hashing_Functions_Pkg;


package body Adbm is

   use Ada.Strings.Unbounded;

   type String_Access is access String;

   subtype Hash_Indexes is Natural;
   subtype File_Position is Natural;

   type BTree_Item is record  --  all natural are pointer to a file 'Count'
      Key         : File_Position;
      Key_Length  : Positive;
      Value       : Element_Type;
      Left, Right : File_Position;
   end record;

   type Compare_Result is (Equal, Inferior, Superior);

   type File_Infos is record
      Index_Size          : Natural;
      Number_Item         : Natural;
      Number_Removed_Item : Natural;
   end record;

   package File_Of_Key is     new Adbm_Direct_IO (Character);
   package File_Of_Index is   new Adbm_Direct_IO (BTree_Item);
   package File_Of_Hashkey is new Adbm_Direct_IO (File_Position);
   package File_Of_Infos is   new Ada.Direct_IO  (File_Infos);

   use File_Of_Key, File_Of_Index, File_Of_Hashkey, File_Of_Infos;

   --  File sufixes
   Hash_Sufix  : constant String := "/db.hsh";
   Index_Sufix : constant String := "/db.idx";
   Key_Sufix   : constant String := "/db.key";
   Infos_Sufix : constant String := "/db.inf";


   --  FCB and functions
   type FCB is record
      Mode  : File_Mode;
      Name  : Unbounded_String;
      Form  : Unbounded_String;
      Infos : File_Infos;

      Hash_File  : File_Of_Hashkey.File_Type;
      Key_File   : File_Of_Key.File_Type;
      Index_File : File_Of_Index.File_Type;
      Infos_File : File_Of_Infos.File_Type;
   end record;

   ----------
   -- Free --
   ----------

   procedure Free is new Ada.Unchecked_Deallocation (FCB, File_Type);

   --------------
   -- New_File --
   --------------

   procedure New_File (File       : in out File_Type;
                       Mode       : in     File_Mode;
                       Name       : in     String;
                       Form       : in     String) is
   begin
      Free (File);
      File      := new FCB;
      File.Mode := Mode;
      File.Name := To_Unbounded_String (Name);
      File.Form := To_Unbounded_String (Form);
   end New_File;


   --  functions for the hash index table

   --------------------
   -- Get_Hash_Index --
   --------------------

   function Get_Hash_Index (File : in File_Type;
                            Item : in String) return Natural;
   pragma Inline (Get_Hash_Index);

   function Get_Hash_Index (File : in File_Type;
                            Item : in String) return Natural is

      function Get_Hash_Index is
        new Hashing_Functions_Pkg.Hash_String (File.Infos.Index_Size);

   begin
      return Get_Hash_Index (Item);
   end Get_Hash_Index;



   --  File management

   ------------
   -- Create --
   ------------

   procedure Create (File       : in out File_Type;
                     Mode       : in     File_Mode := Inout_File;
                     Name       : in     String    := "";
                     Form       : in     String    := "";
                     Index_Size : in     Positive  := 1_024) is

      Hash_Filename  : constant String := Name & Hash_Sufix;
      Index_Filename : constant String := Name & Index_Sufix;
      Key_Filename   : constant String := Name & Key_Sufix;
      Infos_Filename : constant String := Name & Infos_Sufix;

   begin
      New_File (File, Mode, Name, Form);

      File.Infos := (Index_Size          => Index_Size,
                     Number_Item         => 0,
                     Number_Removed_Item => 0);

      --  create the database directory
      POSIX_Files.Create_Directory (POSIX.To_POSIX_String (Name),
                                    POSIX_Permissions.Access_Permission_Set);

      Create (File => File.Hash_File,  Name => Hash_Filename);
      Create (File => File.Index_File, Name => Index_Filename);
      Create (File => File.Key_File,   Name => Key_Filename);
      Create (File => File.Infos_File, Name => Infos_Filename);

      --  create a empty hash table
      for I in 1 .. File.Infos.Index_Size loop
         Write (File => File.Hash_File, Item => File_Position'(0));
      end loop;
   end Create;

   ----------
   -- Open --
   ----------

   procedure Open   (File : in out File_Type;
                     Mode : in     File_Mode;
                     Name : in     String;
                     Form : in     String := "") is

      Hash_Filename  : constant String := Name & Hash_Sufix;
      Index_Filename : constant String := Name & Index_Sufix;
      Key_Filename   : constant String := Name & Key_Sufix;
      Infos_Filename : constant String := Name & Infos_Sufix;

   begin

      New_File (File, Mode, Name, Form);

      Open (File => File.Infos_File, Mode => Inout_File,
            Name => Infos_Filename);
      Read (File => File.Infos_File, Item => File.Infos);

      Open (File => File.Hash_File,
            Mode => Inout_File, Name => Hash_Filename);
      Open (File => File.Index_File,
            Mode => Inout_File, Name => Index_Filename);
      Open (File => File.Key_File,
            Mode => Inout_File, Name => Key_Filename);

   end Open;

   -----------
   -- Close --
   -----------

   procedure Close (File : in out File_Type) is

      procedure Free is
        new Ada.Unchecked_Deallocation (String, String_Access);

   begin
      --  write infos
      Write (File => File.Infos_File, Item => File.Infos, To => 1);

      Close (File => File.Hash_File);
      Close (File => File.Index_File);
      Close (File => File.Key_File);
      Close (File => File.Infos_File);

      Free (File);
   end Close;

   ------------
   -- Delete --
   ------------

   procedure Delete (File : in out File_Type) is
   begin
      Delete (File => File.Hash_File);
      Delete (File => File.Index_File);
      Delete (File => File.Key_File);
      Delete (File => File.Infos_File);

      POSIX_Files.Remove_Directory
        (POSIX.To_POSIX_String (To_String (File.Name)));

      Free (File);
   end Delete;

   -----------
   -- Reset --
   -----------

   procedure Reset  (File : in out File_Type; Mode : in File_Mode) is
   begin
      if File = null then
         raise Status_Error;
      else
         File.Mode := Mode;
      end if;
   end Reset;

   ----------
   -- Mode --
   ----------

   function Mode    (File : in File_Type) return File_Mode is
   begin
      if File = null then
         raise Status_Error;
      else
         return File.Mode;
      end if;
   end Mode;

   ----------
   -- Name --
   ----------

   function Name    (File : in File_Type) return String is
   begin
      if File = null then
         raise Status_Error;
      else
         return To_String (File.Name);
      end if;
   end Name;

   ----------
   -- Form --
   ----------

   function Form    (File : in File_Type) return String is
   begin
      if File = null then
         raise Status_Error;
      else
         return To_String (File.Form);
      end if;
   end Form;

   ----------------
   -- Index_Size --
   ----------------

   function Index_Size  (File : in File_Type) return Positive is
   begin
      if File = null then
         raise Status_Error;
      else
         return File.Infos.Index_Size;
      end if;
   end Index_Size;

   -------------
   -- Is_Open --
   -------------

   function Is_Open (File : in File_Type) return Boolean is
   begin
      return File /= null;
   end Is_Open;

   -------------
   -- Compare --
   -------------

   function Compare (File : in File_Type;
                     Key1 : in String; Key2 : in BTree_Item)
      return Compare_Result is

      Max_Char_To_Compare : Positive;
      Result              : Compare_Result;
      K                   : Natural;
      C                   : Character;
      Key                 : String (1 .. Key1'Length) := Key1;

   begin --  ??? can be optimized (result)
      if Key1'Length < Key2.Key_Length then
         Max_Char_To_Compare := Key1'Length;
      else
         Max_Char_To_Compare := Key2.Key_Length;
      end if;

      Result := Equal;
      K := 0;

      Set_Index (File.Key_File,
                 To => File_Of_Key.Positive_Count (Key2.Key));

      while Result = Equal and then K < Max_Char_To_Compare loop

         Read (File => File.Key_File,
               Item => C);

         if Key (K + 1) < C then
            Result := Inferior;
         elsif Key (K + 1) > C then
            Result := Superior;
         end if;

         K := K + 1;
      end loop;

      --  case when data have the same root but not the same size
      if Result = Equal then
         if Key1'Length < Key2.Key_Length then
            Result := Inferior;
         elsif Key1'Length > Key2.Key_Length then
            Result := Superior;
         end if;
      end if;

      return Result;
   end Compare;




   --  Public functions

   ------------
   -- Insert --
   ------------

   procedure Insert (File  : in     File_Type;
                     Key   : in     String;
                     Value : in out Element_Type;
                     Mode  : in     Insert_Mode := Insert_Item) is
      Key_Pos : Positive;
   begin
      if File.Mode = Out_File then
         raise Mode_Error;
      else
         Low_Level_Insert (File, Key, Value, Key_Pos, Mode);
      end if;
   end Insert;

   ------------
   -- Insert --
   ------------

   procedure Insert (File         : in File_Type;
                     Key          : in String;
                     Scalar_Value : in Element_Type) is
      V       : Element_Type := Scalar_Value;
      Key_Pos : Positive;
   begin
      if File.Mode = Out_File then
         raise Mode_Error;
      else
         Low_Level_Insert (File, Key, V, Key_Pos, Mode => Insert_Item);
      end if;
   end Insert;

   ---------------
   -- Key_Exist --
   ---------------

   function Key_Exist (File : in File_Type;
                       Key  : in String)
                       return Boolean is
      Found : Boolean;
      Value : Element_Type;
   begin
      Seek (File, Key, Value, Found);
      return Found;
   end Key_Exist;

   ----------
   -- Seek --
   ----------

   procedure Seek (File  : in     File_Type;
                   Key   : in     String;
                   Value :    out Element_Type;
                   Found :    out Boolean)
   is

      Hash_Index    : File_Of_Hashkey.Positive_Count;
      Index_Pointer : File_Position;
      BTItem        : BTree_Item;
      Is_Found      : Boolean;
      Result        : Compare_Result;

   begin
      if File.Mode = In_File then
         raise Mode_Error;
      end if;

      Hash_Index :=
        File_Of_Hashkey.Positive_Count (Get_Hash_Index (File, Key) + 1);
      Read (File => File.Hash_File, Item => Index_Pointer, From => Hash_Index);

      Is_Found := False;

      loop

         exit when Index_Pointer = 0;

         Read (File => File.Index_File,
               Item => BTItem,
               From => File_Of_Index.Positive_Count (Index_Pointer));

         Result := Compare (File, Key, BTItem);

         if Result = Equal then
            Value := BTItem.Value;
            Is_Found := True;
            exit;
         elsif Result = Inferior then
            Index_Pointer := BTItem.Left;
         else
            Index_Pointer := BTItem.Right;
         end if;

      end loop;

      Found := Is_Found;

   end Seek;

   ------------
   -- Remove --
   ------------

   procedure Remove (File : in File_Type;
                     Key  : in String)
   is

      type Branch is (Left, Right);

      Hash_Index      : File_Of_Hashkey.Positive_Count;
      Index_Pointer   : File_Position;
      Previous_Index  : File_Position := 0;
      BTItem          : BTree_Item;
      Previous_BTItem : BTree_Item;
      Is_Found        : Boolean;
      Result          : Compare_Result;
      On_Branch       : Branch := Left;

      ----------------------
      -- Write_Last_Right --
      ----------------------

      --  make item the last element of the right most branch of From node.
      procedure Write_Last_Right (From, Item : in File_Position) is
         BTItem        : BTree_Item;
         Index_Pointer : File_Position := From;
      begin
         Seek_Last_Right :
         loop
            Read (File => File.Index_File,
                  Item => BTItem,
                  From => File_Of_Index.Positive_Count (Index_Pointer));
            if BTItem.Right = 0 then
               BTItem.Right := Item;
               Write (File => File.Index_File,
                      Item => BTItem,
                      To   => File_Of_Index.Positive_Count (Index_Pointer));
               exit Seek_Last_Right;
            end if;
            Index_Pointer := BTItem.Right;
         end loop Seek_Last_Right;
      end Write_Last_Right;

      ---------------------
      -- Write_Last_Left --
      ---------------------

      --  make item the last element of the left most branch of From node.
      procedure Write_Last_Left (From, Item : in File_Position) is
         BTItem        : BTree_Item;
         Index_Pointer : File_Position := From;
      begin
         Seek_Last_Left :
         loop
            Read (File => File.Index_File,
                  Item => BTItem,
                  From => File_Of_Index.Positive_Count (Index_Pointer));
            if BTItem.Left = 0 then
               BTItem.Left := Item;
               Write (File => File.Index_File,
                      Item => BTItem,
                      To   => File_Of_Index.Positive_Count (Index_Pointer));
               exit Seek_Last_Left;
            end if;
            Index_Pointer := BTItem.Left;
         end loop Seek_Last_Left;
      end Write_Last_Left;

   begin
      if File.Mode = Out_File then
         raise Mode_Error;
      end if;

      Hash_Index :=
        File_Of_Hashkey.Positive_Count (Get_Hash_Index (File, Key) + 1);
      Read (File => File.Hash_File, Item => Index_Pointer, From => Hash_Index);

      Is_Found := False;

      loop

         exit when Index_Pointer = 0;

         Read (File => File.Index_File,
               Item => BTItem,
               From => File_Of_Index.Positive_Count (Index_Pointer));

         Result := Compare (File, Key, BTItem);

         if Result = Equal then

            if On_Branch = Left then

               --  it is the first item, so we modify the hash key
               if Previous_Index = 0 then
                  if BTItem.Left = 0 then
                     Write (File => File.Hash_File,
                            Item => BTItem.Right,
                            To   => Hash_Index);
                  else
                     Write (File => File.Hash_File,
                            Item => BTItem.Left,
                            To   => Hash_Index);
                  end if;
               else
                  if BTItem.Left /= 0 then
                     Previous_BTItem.Left := BTItem.Left;
                  else
                     Previous_BTItem.Left := BTItem.Right;
                  end if;

                  Write
                    (File => File.Index_File,
                     Item => Previous_BTItem,
                     To   => File_Of_Index.Positive_Count (Previous_Index));

               end if;

               --  is there something to prune
               if BTItem.Right /= 0 and then BTItem.Left /= 0 then
                  Write_Last_Right (From => BTItem.Left,
                                    Item => BTItem.Right);
               end if;

            else -- On_Branch = Right


               --  it is the first item, so we modify the hash key
               if Previous_Index = 0 then
                  if BTItem.Left = 0 then
                     Write (File => File.Hash_File,
                            Item => BTItem.Right,
                            To   => Hash_Index);
                  else
                     Write (File => File.Hash_File,
                            Item => BTItem.Left,
                            To   => Hash_Index);
                  end if;

               else

                  if BTItem.Right /= 0 then
                     Previous_BTItem.Right := BTItem.Right;
                  else
                     Previous_BTItem.Right := BTItem.Left;
                  end if;

                  Write
                    (File => File.Index_File,
                     Item => Previous_BTItem,
                     To   => File_Of_Index.Positive_Count (Previous_Index));
               end if;

               --  is there something to prune
               if BTItem.Right /= 0 and then BTItem.Left /= 0 then
                  Write_Last_Left (From => BTItem.Right,
                                   Item => BTItem.Left);
               end if;

            end if;

            Is_Found := True;
            exit;

         elsif Result = Inferior then
            Previous_Index  := Index_Pointer;
            Previous_BTItem := BTItem;
            On_Branch       := Left;
            Index_Pointer   := BTItem.Left;
         else
            Previous_Index  := Index_Pointer;
            Previous_BTItem := BTItem;
            On_Branch       := Right;
            Index_Pointer   := BTItem.Right;
         end if;

      end loop;

      if not Is_Found then
         raise Key_Not_Found;
      else
         File.Infos.Number_Item         := File.Infos.Number_Item - 1;
         File.Infos.Number_Removed_Item := File.Infos.Number_Removed_Item + 1;
      end if;
   end Remove;

   --------------------
   -- For_Every_Item --
   --------------------

   procedure For_Every_Item (File : in File_Type) is

      Stop     : Boolean       := False;
      Position : File_Position;

      -------------
      -- Process --
      -------------

      procedure Process (Position : in     File_Position;
                         Stop     :    out Boolean)
      is
         BTItem : BTree_Item;
      begin
         Read (File => File.Index_File,
               Item => BTItem,
               From => File_Of_Index.Positive_Count (Position));

         Read_Key :
         declare
            Key       : String (1 .. BTItem.Key_Length);
         begin
            Set_Index (File => File.Key_File,
                       To   => File_Of_Key.Positive_Count (BTItem.Key));
            for I in Key'Range loop
               Read (File => File.Key_File, Item => Key (I));
            end loop;

            --  Then we call the user function
            Action (Key, BTItem.Value, Stop);
         end Read_Key;

         if not Stop then

            if BTItem.Left /= 0 then
               Process (BTItem.Left, Stop);
            end if;

            if BTItem.Right /= 0 then
               Process (BTItem.Right, Stop);
            end if;
         end if;

      end Process;

   begin
      if File.Mode = In_File then
         raise Mode_Error;
      end if;

      Set_Index (File => File.Hash_File, To => 1);

      --  for every hash key entry
      for I in 1 .. File.Infos.Index_Size loop

         Read (File => File.Hash_File, Item => Position);

         if Position /= 0 then
            Process (Position, Stop);
         end if;

         exit when Stop;
      end loop;

   end For_Every_Item;

   ----------
   -- Size --
   ----------

   function Size (File : in File_Type) return Count is
   begin
      return Count (File.Infos.Number_Item);
   end Size;

   ------------------------------
   -- Fragmentation_Percentage --
   ------------------------------

   function Fragmentation_Percentage (File : in File_Type)
                                      return Percentage is
   begin
      if File.Infos.Number_Removed_Item = 0 then
         return 0;
      else
         return Percentage
           ((File.Infos.Number_Removed_Item * 100) /
            (File.Infos.Number_Removed_Item + File.Infos.Number_Item));
      end if;
   end Fragmentation_Percentage;

   -------------
   -- Compact --
   -------------

   procedure Compact (File       : in out File_Type;
                      Index_Size : in     Positive := 1_024)
   is

      File_Name : constant String         := Name (File);
      File_Form : constant String         := Form (File);
      File_Mode : constant Adbm.File_Mode := Mode (File);

      New_File  : File_Type;

      --------------------------
      -- Insert_Into_New_File --
      --------------------------

      procedure Insert_Into_New_File (Key   : in     String;
                                      Value : in     Element_Type;
                                      Stop  : in out Boolean)
      is
      begin
         Insert (New_File, Key, Scalar_Value => Value);
      end Insert_Into_New_File;

      procedure Reinsert_All is new For_Every_Item (Insert_Into_New_File);

   begin
      if File_Mode = In_File then
         raise Mode_Error;
      end if;

      Create (File       => New_File,
              Name       => "tmp_adbm",
              Mode       => In_File,
              Form       => File_Form,
              Index_Size => Index_Size);

      Reinsert_All (File);

      Close (New_File);

      Delete (File);

      POSIX_Files.Rename ("tmp_adbm", POSIX.To_POSIX_String (File_Name));

      Open (File, File_Mode, File_Name, File_Form);
   end Compact;

   --  Private part

   ----------------------
   -- Low_Level_Insert --
   ----------------------

   procedure Low_Level_Insert (File    : in     File_Type;
                               Key     : in     String;
                               Value   : in out Element_Type;
                               Key_Pos :    out Positive;
                               Mode    : in     Insert_Mode := Insert_Item) is

      Hash_Index    : File_Of_Hashkey.Positive_Count;
      Tree_Index    : File_Of_Index.Positive_Count;
      Index_Pointer : File_Position;
      Result        : Compare_Result;
      BTItem        : BTree_Item := (0, Key'Length, Value, 0, 0);
      BTCurItem     : BTree_Item;

      ---------------
      -- Write_Key --
      ---------------

      function Write_Key (Key : in String)
         return Positive is
         Key_Index : File_Of_Key.Positive_Count;
      begin
         Key_Index := Size (File => File.Key_File) + 1;
         Set_Index (File => File.Key_File, To => Key_Index);

         for I in Key'Range loop
            Write (File => File.Key_File, Item => Key (I));
         end loop;

         return Positive (Key_Index);
      end Write_Key;

   begin
      Hash_Index :=
        File_Of_Hashkey.Positive_Count (Get_Hash_Index (File, Key) + 1);
      Read (File => File.Hash_File, Item => Index_Pointer, From => Hash_Index);

      --  there is no data for this hash index
      if Index_Pointer = 0 then

         if Mode = Change_Item then
            raise Key_Not_Found;
         else
            BTItem.Key := Write_Key (Key);
            Key_Pos    := BTItem.Key;

            --  insert this item as root of the tree
            Tree_Index := Size (File.Index_File) + 1;
            Write (File => File.Index_File, Item => BTItem, To => Tree_Index);

            Write (File => File.Hash_File,
                   Item => Natural (Tree_Index),
                   To => Hash_Index);
            File.Infos.Number_Item := File.Infos.Number_Item + 1;
         end if;

      else

         Look_For_Item :
         loop

            Read (File => File.Index_File,
                  Item => BTCurItem,
                  From => File_Of_Index.Positive_Count (Index_Pointer));

            Result := Compare (File, Key, BTCurItem);

            case Result is

               when Equal =>
                  Key_Pos := BTCurItem.Key;
                  case Mode is
                     when Insert_Item =>
                        raise Duplicate_Key;
                     when Change_Item | Insert_Or_Change_Item =>
                        if BTCurItem.Value /= Value then
                           BTCurItem.Value := Value;
                           Write
                             (File => File.Index_File,
                              Item => BTCurItem,
                              To   =>
                                File_Of_Index.Positive_Count (Index_Pointer));
                           exit Look_For_Item;
                        end if;
                     when Insert_Or_Retrieve_Item =>
                        Value := BTCurItem.Value;
                        exit Look_For_Item;
                  end case;

               when Inferior =>

                  if BTCurItem.Left = 0 then
                     if Mode = Change_Item then
                        raise Key_Not_Found;
                     else
                        BTCurItem.Left := Natural (Size (File.Index_File) + 1);
                        Write
                          (File => File.Index_File,
                           Item => BTCurItem,
                           To   =>
                             File_Of_Index.Positive_Count (Index_Pointer));

                        BTItem.Key := Write_Key (Key);

                        Key_Pos := BTItem.Key;
                        Write
                          (File => File.Index_File,
                           Item => BTItem,
                           To   =>
                             File_Of_Index.Positive_Count (BTCurItem.Left));
                        File.Infos.Number_Item := File.Infos.Number_Item + 1;
                        exit Look_For_Item;
                     end if;

                  else
                     Index_Pointer := BTCurItem.Left;
                  end if;

               when Superior =>

                  if BTCurItem.Right = 0 then
                     if Mode = Change_Item then
                        raise Key_Not_Found;
                     else
                        BTCurItem.Right :=
                          Natural (Size (File.Index_File) + 1);
                        Write
                          (File => File.Index_File,
                           Item => BTCurItem,
                           To   =>
                             File_Of_Index.Positive_Count (Index_Pointer));

                        BTItem.Key := Write_Key (Key);

                        Key_Pos := BTItem.Key;
                        Write
                          (File => File.Index_File,
                           Item => BTItem,
                           To   =>
                             File_Of_Index.Positive_Count (BTCurItem.Right));
                        File.Infos.Number_Item := File.Infos.Number_Item + 1;
                        exit Look_For_Item;
                     end if;
                  else
                     Index_Pointer := BTCurItem.Right;
                  end if;

            end case;

         end loop Look_For_Item;

      end if;

   end Low_Level_Insert;

   ------------------------
   -- Low_Level_Read_Key --
   ------------------------

   procedure Low_Level_Read_Key (File : in     File_Type;
                                 From : in     Positive;
                                 Into : in out String) is
   begin
      Set_Index (File => File.Key_File,
                 To   => File_Of_Key.Positive_Count (From));
      for I in Into'Range loop
         Read (File => File.Key_File, Item => Into (I));
      end loop;
   end Low_Level_Read_Key;

end Adbm;
