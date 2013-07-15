-------------------------------------------------------------------------------
--
--              Unit Name:      Package body for Input_Collection
--
-------------------------------------------------------------------------------
--
--  Abstract:
--
--    This package reads datasets from files (one file for each call
--  to read_file) and stores them on a list.  The list is the global
--  object "Entire_Collection" declared within this package body.
--  When a user package calls get_contents, the package replies with
--  the text that was stored under the requested name.
--
--      Read file expects that the files will hold a sequence of
--        <<    Class_Name
--              {Any "contents" readable by the Object}
--              END     >>
--  After contents have been returned, the dataset is deleted from the
--  list, so that subsequent request for same Name will return a
--  different dataset or else raise No_Input_For_Object.
--
--      Case is not significant in Class_Name or in "End".  Each must
--  occupy a line by itself (no content text on same line).  Optional
--  semicolons delimiting Name and End are immaterial.
--
--      This package imposes no rules on the content text, except that
--  blank lines and Ada-style comments are discarded.  Lines in the
--  input file retain their identity in the content text, with
--  "ASCII.CR ASCII.LF" at places in the content where line terminator
--  was found.
--
--      The package defines procedure Read_Collection_Files to provide
--  a more interactive operation for collecting files. If called,
--  Read_Collection_Files reads every file that is named on the
--  program's command line, then interacts (using Text_IO) with the
--  user to read additionally named files.  Read_Collection_Files
--  terminates when the user responds to "Please give some file names ..."
--  with a carriage-return.
--
--              Keywords:
--      Decentralized Input
--      Object-Oriented Input
--
--              Host system:
--      DEC MicroVAX2
--      DEC Ada Compiler 1.3
--      Rational Apex v3.0 et seq.
--      Gnat 3.13p  et seq.
--
-------------------------------------------------------------------------------
--
--              Revision History:
--
--      Creation Time:    1-MAY-1987 08:16
--
--                        16-DEC-1992 Removed elaboration of
--                                    read-collection-file;
--                                    file read must now be explicit.
--                        15-NOV-2003 Prepare release; implement comment
--                                    stripping
-------------------------------------------------------------------------------
--
with Ada.Text_Io;
with Case_Insensitive_String_Comparison;
with Lists;
with Asr_String_Utilities;
with Numeric_Io ;
with Ada.Command_Line;

package body Input_Collection is

   Line_Terminator     : constant String  := Ascii.Cr & Ascii.Lf;

   Input_Size          : constant Integer := 132;

   Insignificant_Chars : constant String
                       := " " & Ascii.Ht & ";" & Line_Terminator;

   package Cisc renames Case_Insensitive_String_Comparison;
   package Su   renames Asr_String_Utilities;

   -------------------------------------------------------------------------------
   --  Data from several files are stored on a list of Dataset_Type
   --  until they have been requested by a Get_Contents call
   type Dataset_Type is
      record
         Name, Contents : String_Pkg.String_Type;
      end record;

   --  A dataset is distinguished ONLY by its name, not by contents
   function Same_Dataset (X, Y : in Dataset_Type) return Boolean;

   package Collection_List is
      new Lists (Equal => Same_Dataset, Itemtype => Dataset_Type);

   --  There is just one LIST which holds the entire collection of datasets
   --  until each is gotten
   Entire_Collection : Collection_List.List
     := Collection_List.Create ;

   function Same_Dataset (X, Y : in Dataset_Type) return Boolean is
   begin
      return Cisc.Equal (Su.Strip (String_Pkg.Value (X.Name),
                                   Char => Insignificant_Chars),
                         Su.Strip (String_Pkg.Value (Y.Name),
                                   Char => Insignificant_Chars));
   end Same_Dataset;

   ---------------------------------------------------------------------------

   procedure Read_One_File (Name : in String) is
      File_Name : String (1 .. 255) := (others => Ascii.Nul);
      Length    : Natural           := Name'Length;
   begin
      --  Persistent attempt to read file
      File_Name (1 .. Name'Length) := Name;
      loop
         begin
            Read_File (File_Name (1 .. Length));
            Ada.Text_Io.Put_Line ("Successfully accepted input from " &
                                  File_Name (1 .. Length));
            exit;
         exception
            when File_Read_Error =>
               Ada.Text_Io.Put_Line ("Unable to read input file " &
                                     File_Name (1 .. Length));
               Ada.Text_Io.Put_Line
                 ("Please correct the name of that input file (or return)");
               Ada.Text_Io.Get_Line (File_Name, Length);
               if Length = 0 then
                  Ada.Text_Io.Put_Line ("No attempt to read this file.");
                  exit;
               end if;
         end;
      end loop;
   end Read_One_File;

   
   procedure Read_Collection_Files is
      File_Name : String (1 .. 255) := (others => Ascii.Nul);
      Length    : Natural           := File_Name'Length;

      package Cli renames Ada.Command_Line;




   begin
      --  Input_Collection will acquire all the data for this run;
      --  each component object should eventually Get_Contents from
      --  the collection to specify its own initial conditions.  (The
      --  usual consumer of these contents, viz instances of Name_IO,
      --  does this through calls to Acquire_Input).

      --  Expect the file names to be on the execute line:
      if Cli.Argument_Count > 0 then
         --  Some file names on command line
         for Ix in 1 .. Cli.Argument_Count loop
            declare
               One_File : String (Cli.Argument (Ix)'Range) :=
                 Cli.Argument (Ix);
            begin
               Read_One_File (One_File);
            end;
         end loop;
      else
         Ada.Text_Io.Put_Line
           ("Please give some file names concluding with carriage return.");
         loop
            Ada.Text_Io.Get_Line (File_Name, Length);
            if Length > 0 then
               Read_One_File (File_Name (1 .. Length));
               Ada.Text_Io.Put_Line ("Give name of one more input file  ");
            else
               Ada.Text_Io.Put_Line ("That concludes the reading of input files.");
               exit;
            end if;
         end loop;
      end if;

   end Read_Collection_Files;

   -------------------------------------------------------------------------------

   --  Recognize_dataset is the package that defines the parser;
   --  incoming lines are parsed to a sequence of
   --  One name, followed by
   --  arbitrarily many content lines, followed by
   --  END
   package Recognize_Dataset is
      procedure Process_Line (Line : in String);
   end Recognize_Dataset;

   package body Recognize_Dataset is
      Set_Is_Open     : Boolean := False;    -- true between name and end
      Current_Dataset : Dataset_Type;        -- contains lines tagged w name

      function Read_End (Line : String) return Boolean is
      begin
         return Cisc.Equal ("end", Su.Strip
                            (Line, Char => Insignificant_Chars));
      end Read_End;

      procedure Process_Line (Line : in String) is
         use String_Pkg;
      begin
         if not Set_Is_Open then
            --  Recognize a new dataset beginning:
            Set_Is_Open := True;
            Current_Dataset.Name :=
              Make_Persistent (Su.Strip
                               (Line, Char => Insignificant_Chars));
            Current_Dataset.Contents := Create ("");
         else
            --  Recognize "end" after a name has been recognized:
            if Read_End (Line) then
               Set_Is_Open := False;
               --  Dataset is complete; attach to collection to await
               --  "get" request
               Current_Dataset.Contents :=
                 Make_Persistent (Current_Dataset.Contents);
               Collection_List.Attach (Entire_Collection, Current_Dataset);
            else
               --  Accrete another line of contents:
               Current_Dataset.Contents := Current_Dataset.Contents & Line;
            end if;
         end if;
      end Process_Line;

   end Recognize_Dataset;

   -------------------------------------------------------------------------------

   function Next_Line
     (File           : in Ada.Text_IO.File_Type :=  Ada.Text_Io.Standard_Input;
      Guessed_Length : Positive                 := 256) return String is
      -- 1999 gleaning from comp.lang.ada: Martin Carlisle, JP Rosen.
      Answer         : String(1..Guessed_Length);
      Last           : Natural;
   begin
      Ada.Text_IO.Get_Line(File => File,
                           Item => Answer,
                           Last => Last);
      if Last = Answer'Last then
         return Answer & Next_Line (File, 2*Guessed_Length);
      else
         return Answer(1..Last);
      end if;
   end Next_Line;

   -------------------------------------------------------------------------------

   procedure Read_File (File_Name : in String) is
      use Ada.Text_Io ;
      File_Handle : File_Type;
   begin
      Open (File => File_Handle, Mode => In_File, Name => File_Name);
      String_Pkg.Mark;

      while not End_Of_File (File_Handle) loop
         declare
            This_Line : constant String
              := Next_Line (File_Handle, Guessed_Length => Input_Size) ;
            Exclude_Comment : Natural := This_Line'First ;
            Found_Comment   : Boolean := False ;
         begin
            if This_Line'Length > 0 then
               -- a non-blank line gets its comment stripped,
               -- then gets "processed"
               while Exclude_Comment <= This_Line'Last - 1 and
                 not Found_Comment loop
                  if This_Line (Exclude_Comment) = '-' and then
                    This_Line (Exclude_Comment + 1) = '-' then
                     Found_Comment := True ;
                  else
                     Exclude_Comment := Exclude_Comment + 1 ;
                  end if ;
               end loop ;
               if This_Line'First /= Exclude_Comment then
                  --  this is *not* a 'comment begins at column 1' line
                  --  so there is data to recognize
                  if Found_Comment then
                     Recognize_Dataset.Process_Line
                       (This_Line(This_Line'First .. Exclude_Comment-1)
                        & Line_Terminator);
                  else
                     -- be sure to get the terminal ';'
                     Recognize_Dataset.Process_Line
                       (This_Line(This_Line'First .. Exclude_Comment)
                        & Line_Terminator);
                  end if ;
               end if ;
            end if ;
         end ;
      end loop ;
      Close (File_Handle);
      String_Pkg.Release;
   exception
      when Name_Error =>
         raise File_Read_Error;
   end Read_File;

   -------------------------------------------------------------------------------

   procedure Get_Contents (Class_Name : in String;
                           Contents   : out Data_Collection_Type) is
      use Collection_List;
      Iter    : Listiter;
      Dataset : Dataset_Type;
      Found   : Boolean := False;
   begin
      Iter := Makelistiter (Entire_Collection);
      while More (Iter) loop
         Next (Iter, Dataset);
         if Cisc.Equal (Su.Strip (Class_Name, Char => Insignificant_Chars),
                        Su.Strip (String_Pkg.Value (Dataset.Name),
                                  Char => Insignificant_Chars)) then
            Contents := Dataset.Contents;
            Deleteitem (Entire_Collection, Dataset);
            String_Pkg.Flush (Dataset.Name);
            --  note that contents is still persistent!
            --  it is users responsibility to flush contents when finished.
            Found := True;
            exit;
         end if;
      end loop;
      if not Found then
         raise No_Input_For_Object;
      end if;
   end Get_Contents;

end Input_Collection;

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
