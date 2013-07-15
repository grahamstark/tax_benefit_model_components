
-------------------------------------------------------------------------------
--                                                                           --
--  Project   : Adbm
--
--  $Id: adbm.ads,v 1.8 1998/12/30 19:34:25 obry Exp $
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

with IO_Exceptions;

generic

   type Element_Type is private;

package Adbm is

   use IO_Exceptions;

   type File_Type is limited private;

   type File_Mode is (In_File, Inout_File, Out_File);

   type Insert_Mode is (Insert_Item, Change_Item,
                        Insert_Or_Change_Item, Insert_Or_Retrieve_Item);
   --  Insert_Item   : if the key already exist Duplicate_Key exception
   --                 will be raised.
   --
   --  Change_Item   : Change the value of the item. Key_Not_Found will
   --                  be raised if the key doesn't exist.
   --
   --  Insert_Or_Change_Item, Insert_Or_Retrieve_Item : no exception raised.
   --

   type Count is range 0 .. Natural'Last;
   subtype Positive_Count is Count range 1 .. Count'Last;


   --  File management

   procedure Create (File       : in out File_Type;
                     Mode       : in     File_Mode := Inout_File;
                     Name       : in     String    := "";
                     Form       : in     String    := "";
                     Index_Size : in     Positive  := 1_024);

   procedure Open   (File : in out File_Type;
                     Mode : in File_Mode;
                     Name : in String;
                     Form : in String := "");

   procedure Close  (File : in out File_Type);
   procedure Delete (File : in out File_Type);
   procedure Reset  (File : in out File_Type; Mode : in File_Mode);

   function Mode       (File : in File_Type) return File_Mode;
   function Name       (File : in File_Type) return String;
   function Form       (File : in File_Type) return String;
   function Index_Size (File : in File_Type) return Positive;

   function Is_Open (File : in File_Type) return Boolean;


   --  Input and output operations

   procedure Insert (File  : in     File_Type;
                     Key   : in     String;
                     Value : in out Element_Type;
                     Mode  : in     Insert_Mode := Insert_Item);

   procedure Insert (File         : in File_Type;
                     Key          : in String;
                     Scalar_Value : in Element_Type);

   function Key_Exist (File : in File_Type;
                       Key  : in String)
                       return Boolean;

   procedure Seek (File  : in     File_Type;
                   Key   : in     String;
                   Value :    out Element_Type;
                   Found :    out Boolean);

   procedure Remove (File : in File_Type;
                     Key  : in String);

   generic
      with procedure Action (Key   : in     String;
                             Value : in     Element_Type;
                             Stop  : in out Boolean);
   procedure For_Every_Item (File : in File_Type);

   function Size (File : in File_Type) return Count;


   subtype Percentage is Natural range 0 .. 100;

   function Fragmentation_Percentage (File : in File_Type)
                                      return Percentage;

   procedure Compact (File       : in out File_Type;
                      Index_Size : in     Positive := 1_024);


   --  Exceptions

   Duplicate_Key : exception;
   Key_Not_Found : exception;

   Status_Error  : exception renames IO_Exceptions.Status_Error;
   Mode_Error    : exception renames IO_Exceptions.Mode_Error;
   Name_Error    : exception renames IO_Exceptions.Name_Error;
   Use_Error     : exception renames IO_Exceptions.Use_Error;
   Device_Error  : exception renames IO_Exceptions.Device_Error;
   End_Error     : exception renames IO_Exceptions.End_Error;
   Data_Error    : exception renames IO_Exceptions.Data_Error;

private

   type FCB;
   type File_Type is access FCB;

   procedure Low_Level_Insert  (File    : in     File_Type;
                                Key     : in     String;
                                Value   : in out Element_Type;
                                Key_Pos :    out Positive;
                                Mode    : in     Insert_Mode := Insert_Item);
   --  raised exceptions : Duplicate_Key, Key_Not_Found

   procedure Low_Level_Read_Key (File : in     File_Type;
                                 From : in     Positive;
                                 Into : in out String);

end Adbm;
