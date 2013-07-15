-- Contributed by ITEC - NXP Semiconductors
--
-- June 2008
--
-- Tests the direction: File ---Compress---> Zip as a stream
--
--  Stream 1 (ZipFileStream1) => Zip stream created as Unbounded_String in memory then later save to disk.
--  Stream 2 (ZipFileStream2) => Zip stream created as new zip-file directly on disk.

--  File1 (StreamFile1) => Stream pointing to a Unbounded_String which has the context of a file from a disk.
--  File2 (StreamFile2) => Stream pointing to a file directly from disk.

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Zip_Streams; use Zip_Streams;
with RW_File; use RW_File;
with Zip.Compress;
with Zip.Create;   use Zip.Create;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

procedure ZipTest is

   MyStreama : aliased Unbounded_Stream;
   ZipFileStream1 : constant Zipstream_Class := MyStreama'Unchecked_Access;

   MyStreamb : aliased ZipFile_Stream;
   ZipFileStream2 : constant Zipstream_Class := MyStreamb'Unchecked_Access;

   Info1 : Zip_Create_info;
   Info2 : Zip_Create_info;

   UnbZipFile : Unbounded_String;

   UnbFile1 : Unbounded_String;
   MyStream1 : aliased Unbounded_Stream;
   StreamFile1 : constant Zipstream_Class := MyStream1'Unchecked_Access;

   MyStream2 : aliased ZipFile_Stream;
   StreamFile2 : constant Zipstream_Class := MyStream2'Unchecked_Access;
begin
   Create (Info2, ZipFileStream2, "aaa2.zip", Zip.Compress.Shrink);
   Create (ZipFile_Stream (ZipFileStream2.all), Out_File);
   Create (Info1, ZipFileStream1, "aaa.zip", Zip.Compress.Shrink);

   --  read the file1.txt in unbounded string
   RW_File.Read_File ("file1.txt", UnbFile1);
   --  set a stream to the unbounded string
   Set (Unbounded_Stream (StreamFile1.all), UnbFile1);
   StreamFile1.SetName ("file1.txt");

   --  read the file2.txt in unbounded string
   StreamFile2.SetName ("file2.txt");
   Open (ZipFile_Stream (StreamFile2.all), In_File);

   --  Add stream to the list
   Add_Stream (Info2, StreamFile1);
   Add_Stream (Info2, StreamFile2);
   --  Reset Streams
   Set_Index (StreamFile1, 1);
   Set_Index (StreamFile2, 1);
   --  Add stream to the list
   Add_Stream (Info1, StreamFile1);
   Add_Stream (Info1, StreamFile2);

   Finish (Info1);
   Finish (Info2);

   Close (ZipFile_Stream (ZipFileStream2.all));

   Get (Unbounded_Stream (ZipFileStream1.all), UnbZipFile);
   RW_File.Write_File (ZipFileStream1.GetName, UnbZipFile);

end ZipTest;
