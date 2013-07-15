with Ada.Unchecked_Deallocation;
with Ada.Streams;              use Ada.Streams;
with Interfaces;               use Interfaces;

package body Zip.Create is

   procedure Create(Info        : out Zip_Create_info;
                    Z_Stream    : in Zipstream_Class;
                    Name        : String;
                    Compress    : Zip.Compress.Compression_Method) is
   begin
      Info.Stream := Z_Stream;
      Info.Compress := Compress;
      if Name /= "" then
         Info.Stream.SetName (Name);
      end if;
   end Create;

   procedure Dispose is new
     Ada.Unchecked_Deallocation (Dir_entries, Pdir_entries);

   procedure Resize (A    : in out Pdir_entries;
                     Size : Integer) is
      Hlp : constant Pdir_entries := new Dir_entries (1 .. Size);
   begin
      if A = null then
         A := Hlp;
      else
         Hlp (1 .. Integer'Min (Size, A'Length)) :=
           A (1 .. Integer'Min (Size, A'Length));
         Dispose (A);
         A := Hlp;
      end if;
   end Resize;

   function To_Stream_Element_Array (S : String) return Stream_Element_Array is
      B : Stream_Element_Array (1 .. S'Length);
      I : Stream_Element_Offset := B'First;
      J : Positive := S'First;
   begin
      loop
         B (I) := Stream_Element (Character'Pos (S (J)));
         exit when J = S'Last;
         I := I + 1; J := J + 1;
      end loop;
      return B;
   end To_Stream_Element_Array;

   procedure Add_Stream (Info   : in out Zip_Create_info;
                         Stream : Zipstream_Class) is
      Last       : Integer := 1;
      mem1, mem2 : Integer := 1;
   begin
      if Info.Contains /= null then
         Last := Info.Contains'Length + 1;
      end if;
      Resize (Info.Contains, Last);
      --  Administration
      Info.Contains (Last).head.made_by_version      := 23; -- version 2.30
      Info.Contains (Last).head.comment_length       := 0;
      Info.Contains (Last).head.disk_number_start    := 0;
      Info.Contains (Last).head.internal_attributes  := 0; -- 0:binary; 1:text
      Info.Contains (Last).head.external_attributes               := 0;
      Info.Contains (Last).head.short_info.needed_extract_version :=
        10; -- Value put by Zip/PKZip
      Info.Contains (Last).head.short_info.bit_flag               := 0;
      Info.Contains (Last).head.short_info.file_timedate          :=
        GetTime (Stream);
      Info.Contains (Last).head.short_info.dd.uncompressed_size   :=
        Unsigned_32 (Size (Stream));
      Info.Contains (Last).head.short_info.filename_length        :=
        GetName (Stream)'Length;
      Info.Contains (Last).head.short_info.extra_field_length     := 0;
      Info.Contains (Last).name := To_Unbounded_String (GetName (Stream));

      mem1 := Index (Info.Stream);
      Info.Contains (Last).head.local_header_offset := Unsigned_32 (mem1) - 1;
      --  Write the local header with incomplete informations
      Zip.Headers.Write (Info.Stream, Info.Contains (Last).head.short_info);

      declare
         TempArray : constant Stream_Element_Array :=
           To_Stream_Element_Array (To_String (Info.Contains (Last).name));
      begin
         Write (Info.Stream.all, TempArray);
      end;
      --  Write compressed file
      Zip.Compress.Compress_data
        (input            => Stream,
         output           => Info.Stream,
         input_size_known => True,
         input_size       =>
           Info.Contains (Last).head.short_info.dd.uncompressed_size,
         method           => Info.Compress,
         feedback         => null,
         CRC              => Info.Contains (Last).head.short_info.dd.crc_32,
         output_size      => Info.Contains (Last).head.short_info.dd.compressed_size,
         zip_type         => Info.Contains (Last).head.short_info.zip_type);
      mem2 := Index (Info.Stream);
      --  Go back to the local header to rewrite it
      --  with complete informations
      Set_Index (Info.Stream, mem1);
      Zip.Headers.Write (Info.Stream, Info.Contains (Last).head.short_info);
      --  Return to momentaneous end of file
      Set_Index (Info.Stream, mem2);
   end Add_Stream;

   procedure Finish (Info : in out Zip_Create_info) is
      ed : Zip.Headers.End_of_Central_Dir;
   begin
      --
      --  2/ Almost done - write Central Directory:
      --
      ed.central_dir_offset := Unsigned_32 (Index (Info.Stream)) - 1;
      ed.total_entries := 0;
      ed.central_dir_size := 0;
      ed.main_comment_length := 0;
      for e in Info.Contains'Range loop
         ed.total_entries := ed.total_entries + 1;
         Zip.Headers.Write (Info.Stream, Info.Contains (e).head);
         declare
            TempArray : constant Stream_Element_Array :=
              To_Stream_Element_Array (To_String (Info.Contains (e).name));
         begin
            Write (Info.Stream.all, TempArray);
         end;
         ed.central_dir_size :=
           ed.central_dir_size +
             Zip.Headers.central_header_length +
               Unsigned_32 (Info.Contains (e).head.short_info.filename_length);
      end loop;
      Dispose (Info.Contains);
      ed.disknum := 0;
      ed.disknum_with_start := 0;
      ed.disk_total_entries := ed.total_entries;
      Zip.Headers.Write (Info.Stream, ed);
   end Finish;

end Zip.Create;
