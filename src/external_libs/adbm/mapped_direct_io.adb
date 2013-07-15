
--  -----------------------------------------------------------------------  --
--
--  Author  : Pascal Obry
--  E-Mail  : pascal_obry@csi.com
--
--  -----------------------------------------------------------------------  --
--
--  $Id: mapped_direct_io.adb,v 1.6 1998/12/30 19:34:25 obry Exp $
--
--  -----------------------------------------------------------------------  --
--
--  Ada Body Generic Package
--
--       Module Name : Mapped_Direct_IO
--         File name : mapped_direct_io.adb
--
--       Created by  : Pascal Obry
--               on  : Wed Apr 26 09:13:28 1995
--
--  Last modified by :
--                     $Date: 1998/12/30 19:34:25 $
--                     $Revision: 1.6 $
--
--         Locked by : $Locker:  $
--
--  -----------------------------------------------------------------------  --


with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Sequential_IO;
with Ada.Unchecked_Deallocation;
with Ada.Strings.Unbounded;

package body Mapped_Direct_IO is

   use Ada;
   use Strings.Unbounded;

   ----------------
   -- Element_IO --
   ----------------

   package Element_IO is new Ada.Direct_IO (Element_Type);

   ---------------------
   -- Element_Handler --
   ---------------------

   package Element_Handler is

      type Mapped_Elements is private;

      procedure Create (File : in File_Type;
                        Size : in Positive := 10_000);

      function  Get (File  : in File_Type;
                     Index : in Positive) return Element_Type;

      procedure Set (File  : in File_Type;
                     Index : in Positive; To : in Element_Type);

      procedure Read_Mapped_Datas  (File : in File_Type);
      procedure Write_Mapped_Datas (File : in File_Type);

      procedure Free (File : in File_Type);

   private

      type Elements_Array;

      type Mapped_Elements is access Elements_Array;

      pragma Inline (Get, Set);

   end Element_Handler;

   type File_Type_Datas is record
      File : Element_IO.File_Type;
      Name : Unbounded_String;
      Mode : File_Mode;
      I    : Positive   := 1;
      Size : Natural    := 0;
      --  to map the file in memory
      Map          : Element_Handler.Mapped_Elements;
      Current_Size : Natural := 0;
   end record;

   package body Element_Handler is

      Read_Write_Buffer_Size : constant := 100;

      type Elements_Array is array (Positive range <>) of Element_Type;

      ----------
      -- Free --
      ----------

      procedure Free is
        new Ada.Unchecked_Deallocation (Elements_Array, Mapped_Elements);

      procedure Free (File : in File_Type) is
      begin
         Free (File.Map);
      end Free;

      ------------
      -- Growth --
      ------------

      procedure Growth (File : in     File_Type;
                        Add  : in out Positive) is

         New_Add  : constant Positive
                  := Positive'Max (Add, File.Current_Size / 2);

         New_Size : constant Positive
                  := File.Current_Size + New_Add;

         subtype New_Index is Positive range 1 .. New_Size;

         New_Datas : Mapped_Elements := new Elements_Array (New_Index);
      begin
         Add := New_Add;
         New_Datas (File.Map.all'Range) := File.Map.all;
         Free (File.Map);
         File.Map := New_Datas;
         File.Current_Size := New_Size;
      end Growth;

      -----------------------
      -- Read_Mapped_Datas --
      -----------------------

      procedure Read_Mapped_Datas (File : in File_Type) is

         subtype Tab_Datas is Element_Handler.Elements_Array (1 .. File.Size);

         package Tab_Elements_IO is new Ada.Sequential_IO (Tab_Datas);

         L_File  : Tab_Elements_IO.File_Type;

      begin
         Tab_Elements_IO.Open (L_File,
                               Tab_Elements_IO.In_File,
                               To_String (File.Name));
         Tab_Elements_IO.Read (L_File, File.Map.all);
         Tab_Elements_IO.Close (L_File);
      end Read_Mapped_Datas;

      ------------
      -- Create --
      ------------

      procedure Create (File : in File_Type;
                        Size : in Positive := 10_000) is
      begin
         File.Map          := new Elements_Array (1 .. Size);
         File.Current_Size := Size;
      end Create;

      ---------
      -- Get --
      ---------

      function  Get (File  : in File_Type;
                     Index : in Positive) return Element_Type is
      begin
         return File.Map (Index);
      end Get;

      ---------
      -- Set --
      ---------

      procedure Set (File  : in File_Type;
                     Index : in Positive;
                     To    : in Element_Type) is
      begin
         if Index > File.Current_Size then
            declare
               Add : Positive := Positive'Max (100, Index - File.Size + 100);
            begin
               Element_Handler.Growth (File, Add);
            end;
         end if;
         File.Map (Index) := To;
      end Set;

      ------------------------
      -- Write_Mapped_Datas --
      ------------------------

      procedure Write_Mapped_Datas (File : in File_Type) is

         subtype Tab_Datas is Element_Handler.Elements_Array (1 .. File.Size);

         package Tab_Elements_IO is new Ada.Sequential_IO (Tab_Datas);

         Disk_File : Tab_Elements_IO.File_Type;

      begin
         Tab_Elements_IO.Create (Disk_File,
                                 Tab_Elements_IO.Out_File,
                                 To_String (File.Name));
         Tab_Elements_IO.Write (Disk_File,
                                File.Map (1 .. File.Size));
         Tab_Elements_IO.Close (Disk_File);
      end Write_Mapped_Datas;

   end Element_Handler;


   ----------
   -- Free --
   ----------

   procedure Free is
     new Ada.Unchecked_Deallocation (File_Type_Datas, File_Type);

   --  File management

   ------------
   -- Create --
   ------------

   procedure Create (File : in out File_Type;
                     Mode : in File_Mode := Inout_File;
                     Name : in String := "";
                     Form : in String := "")
   is

      ----------------------
      -- Create_Size_File --
      ----------------------

      procedure Create_Size_File (File_Name : in String) is
         package Size_IO is new Direct_IO (Natural);
         use Size_IO;
         F : Size_IO.File_Type;
      begin
         Create (F, Name => File_Name & ".size", Mode => Out_File);
         Write (F, 0);
         Close (F);
      end Create_Size_File;

      L_Mode : constant Element_IO.File_Mode
             := Element_IO.File_Mode'Val (File_Mode'Pos (Mode));

   begin -- Create
      File      := new File_Type_Datas;
      File.Name := To_Unbounded_String (Name);
      File.Mode := Mode;
      File.Size := 0;
      File.I    := 1;
      Element_IO.Create (File.File, L_Mode, Name, Form);

      Element_Handler.Create (File);
      Create_Size_File (Name);
   end Create;

   ----------
   -- Open --
   ----------

   procedure Open   (File        : in out File_Type;
                     Mode        : in     File_Mode;
                     Name        : in     String;
                     Form        : in     String := "")
   is

      L_Mode : constant Element_IO.File_Mode
             := Element_IO.File_Mode'Val (File_Mode'Pos (Mode));

      ----------
      -- Size --
      ----------

      function Size (File_Name : in String)
                     return Natural is
         package Size_IO is new Direct_IO (Natural);
         use Size_IO;
         S : Natural;
         F : Size_IO.File_Type;
      begin
         Open (F, Name => File_Name & ".size", Mode => In_File);
         Read (F, S);
         Close (F);
         return S;
      end Size;

   begin -- Open
      File      := new File_Type_Datas;
      File.Mode := Mode;
      File.Name := To_Unbounded_String (Name);

      --  compute the number of elements
      File.Size := Size (Name);
      --  set the index
      File.I    := 1;

      --  read datas
      if File.Size /= 0 then
         Element_Handler.Create (File, File.Size);
         Element_Handler.Read_Mapped_Datas (File);
      else
         Element_Handler.Create (File);
      end if;

      --  open the file
      Element_IO.Open (File.File, L_Mode, Name, Form);
   end Open;

   -----------
   -- Close --
   -----------

   procedure Close  (File : in out File_Type) is

      ----------------
      -- Write_Size --
      ----------------

      procedure Write_Size (File_Name : in String) is
         package Size_IO is new Direct_IO (Natural);
         use Size_IO;
         F : Size_IO.File_Type;
      begin
         Create (F, Name => File_Name & ".size", Mode => Out_File);
         Write (F, File.Size);
         Close (F);
      end Write_Size;

   begin -- Close
      Element_IO.Close (File.File);
      if File.Mode /= In_File then
         Write_Size (To_String (File.Name));
         if File.Size /= 0 then
            Element_Handler.Write_Mapped_Datas (File);
         end if;
      end if;
      Element_Handler.Free (File);
      Free (File);
   end Close;

   ------------
   -- Delete --
   ------------

   procedure Delete (File : in out File_Type) is

      ----------------------
      -- Delete_Size_File --
      ----------------------

      procedure Delete_Size_File (File_Name : in String) is
         F : Text_IO.File_Type;
      begin
         Text_IO.Open (F,
                       Name => File_Name & ".size",
                       Mode => Text_IO.In_File);
         Text_IO.Delete (F);
      end Delete_Size_File;

   begin -- Delete
      Element_IO.Delete (File.File);
      Delete_Size_File (To_String (File.Name));
      Element_Handler.Free (File);
      Free (File);
   end Delete;

   -----------
   -- Reset --
   -----------

   procedure Reset  (File : in out File_Type; Mode : in File_Mode) is
   begin
      File.Mode := Mode;
      File.I    := 1;
   end Reset;

   -----------
   -- Reset --
   -----------

   procedure Reset  (File : in out File_Type) is
   begin
      File.I := 1;
   end Reset;


   ----------
   -- Mode --
   ----------

   function Mode    (File : in File_Type) return File_Mode is
   begin
      return File.Mode;
   end Mode;

   ----------
   -- Name --
   ----------

   function Name    (File : in File_Type) return String is
   begin
      return Element_IO.Name (File.File);
   end Name;

   ----------
   -- Form --
   ----------

   function Form    (File : in File_Type) return String is
   begin
      return Element_IO.Form (File.File);
   end Form;


   -------------
   -- Is_Open --
   -------------

   function Is_Open (File : in File_Type) return Boolean is
   begin
      if File = null or else not Element_IO.Is_Open (File.File) then
         return False;
      else
         return True;
      end if;
   end Is_Open;


   --  Input and output operations

   ----------
   -- Read --
   ----------

   procedure Read  (File : in File_Type;
                    Item : out Element_Type;
                    From : in Positive_Count) is
   begin -- Read
      if Positive (From) > File.Size then
         raise End_Error;
      elsif File.Mode = Out_File then
         raise Mode_Error;
      else
         Item := Element_Handler.Get (File, Positive (From));
         File.I := Positive (From) + 1;
      end if;
   end Read;

   ----------
   -- Read --
   ----------

   procedure Read  (File : in File_Type; Item : out Element_Type) is
   begin
      if File.I > File.Size then
         raise End_Error;
      elsif File.Mode = Out_File then
         raise Mode_Error;
      else
         Item := Element_Handler.Get (File, File.I);
         File.I := File.I + 1;
      end if;
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write (File : in File_Type;
                    Item : in  Element_Type;
                    To   : in Positive_Count)
   is
      P_To : Positive := Positive (To);
   begin
      if File.Mode = In_File then
         raise Mode_Error;
      else
         Element_Handler.Set (File, P_To, Item);
         File.I    := P_To + 1;
         File.Size := Positive'Max (File.Size, P_To);
      end if;
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write (File : in File_Type; Item : in Element_Type) is
   begin
      if File.Mode = In_File then
         raise Mode_Error;
      else
         Element_Handler.Set (File, File.I, Item);
         File.Size := Positive'Max (File.Size, File.I);
         File.I := File.I + 1;
      end if;
   end Write;

   ---------------
   -- Set_Index --
   ---------------

   procedure Set_Index (File : in File_Type; To : in Positive_Count) is
   begin
      File.I := Positive (To);
   end Set_Index;

   -----------
   -- Index --
   -----------

   function Index (File : in File_Type) return Positive_Count is
   begin
      return Positive_Count (File.I);
   end Index;

   ----------
   -- Size --
   ----------

   function Size  (File : in File_Type) return Count is
   begin
      return Count (File.Size);
   end Size;

   -----------------
   -- End_Of_File --
   -----------------

   function End_Of_File (File : in File_Type) return Boolean is
   begin
      if File.Mode = Out_File then
         raise Mode_Error;
      else
         return File.I > File.Size;
      end if;
   end End_Of_File;

end Mapped_Direct_IO;
