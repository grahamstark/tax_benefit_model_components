
--  -----------------------------------------------------------------------  --
--
--  Author  : Pascal Obry
--  E-Mail  : pascal_obry@csi.com
--
--  -----------------------------------------------------------------------  --
--
--  $Id: mapped_direct_io.ads,v 1.4 1998/12/30 19:34:25 obry Exp $
--
--  -----------------------------------------------------------------------  --
--
--  Ada Specification Generic Package
--
--       Module Name : Mapped_Direct_IO
--         File name : mapped_direct_io.ads
--
--       Created by  : Pascal Obry
--               on  : Wed Apr 26 09:09:33 1995
--
--  Last modified by :
--                     $Date: 1998/12/30 19:34:25 $
--                     $Revision: 1.4 $
--
--         Locked by : $Locker:  $
--
--  -----------------------------------------------------------------------  --
--
--  Description :
--
--
--  This module provide the same interface than Ada.Direct_IO, but in this
--  version the datas are mapped in memory for fast access.
--
--  -----------------------------------------------------------------------  --


with Ada.IO_Exceptions;

generic

   type Element_Type is private;

package Mapped_Direct_IO is

   type File_Type is limited private;

   type File_Mode is (In_File, Inout_File, Out_File);
   type Count     is range 0 .. Long_Integer'Last;
   subtype Positive_Count is Count range 1 .. Count'Last;

   --  File management

   procedure Create (File : in out File_Type;
                     Mode : in File_Mode := Inout_File;
                     Name : in String := "";
                     Form : in String := "");

   procedure Open   (File : in out File_Type;
                     Mode : in File_Mode;
                     Name : in String;
                     Form : in String := "");

   procedure Close  (File : in out File_Type);
   procedure Delete (File : in out File_Type);
   procedure Reset  (File : in out File_Type; Mode : in File_Mode);
   procedure Reset  (File : in out File_Type);

   function Mode    (File : in File_Type) return File_Mode;
   function Name    (File : in File_Type) return String;
   function Form    (File : in File_Type) return String;

   function Is_Open (File : in File_Type) return Boolean;

   --  Input and output operations

   procedure Read  (File : in File_Type;
                    Item : out Element_Type;
                    From : in Positive_Count);

   procedure Read  (File : in File_Type; Item : out Element_Type);

   procedure Write (File : in File_Type;
                    Item : in  Element_Type;
                    To   : in Positive_Count);

   procedure Write (File : in File_Type; Item : in Element_Type);

   procedure Set_Index (File : in File_Type; To : in Positive_Count);

   function Index (File : in File_Type) return Positive_Count;
   function Size  (File : in File_Type) return Count;

   function End_Of_File (File : in File_Type) return Boolean;

   --  Exceptions

   Status_Error : exception renames Ada.IO_Exceptions.Status_Error;
   Mode_Error   : exception renames Ada.IO_Exceptions.Mode_Error;
   Name_Error   : exception renames Ada.IO_Exceptions.Name_Error;
   Use_Error    : exception renames Ada.IO_Exceptions.Use_Error;
   Device_Error : exception renames Ada.IO_Exceptions.Device_Error;
   End_Error    : exception renames Ada.IO_Exceptions.End_Error;
   Data_Error   : exception renames Ada.IO_Exceptions.Data_Error;

private

   type File_Type_Datas;
   type File_Type is access File_Type_Datas;

   pragma Inline (End_Of_File);
   pragma Inline (Form);
   pragma Inline (Index);
   pragma Inline (Is_Open);
   pragma Inline (Mode);
   pragma Inline (Name);
   pragma Inline (Set_Index);
   pragma Inline (Size);
   pragma Inline (Write);

end Mapped_Direct_IO;
