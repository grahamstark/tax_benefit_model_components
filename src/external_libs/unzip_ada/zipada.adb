-- Draft of a zip archiving utility.
--
-- UZA v. 26: modified for new Zip_Stream

with Ada.Calendar;                      use Ada.Calendar;
with Ada.Command_Line;                  use Ada.Command_Line;
with Ada.Directories;                   use Ada.Directories;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Float_Text_IO;                 use Ada.Float_Text_IO;
with Ada.Streams;                       use Ada.Streams;
with Ada.Streams.Stream_IO;             use Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded;             use Ada.Strings.Unbounded;
with Ada.Characters.Handling;           use Ada.Characters.Handling;

with Interfaces;                        use Interfaces;

with Zip.Headers, Zip.Compress;
with Zip_Streams;                       use Zip_Streams;

with My_feedback;

procedure ZipAda is

  T0, T1 : Time;
  seconds: Duration;

  procedure Blurb is
  begin
    Put_Line("ZipAda * very minimalist standalone zipping tool.");
    Put_Line("Demo for Zip-Ada library, by G. de Montmollin");
    Put_Line("URL: http://unzip-ada.sf.net");
    New_Line;
  end Blurb;

  function S (Source : Unbounded_String) return String
    renames Ada.Strings.Unbounded.To_String;

  function CutName(n:String; l:Natural) return String is
    dots: constant String:= "...";
  begin
    if n'Length > l then
      return dots & n( n'Last - (l-1) + dots'Length .. n'Last );
    else
      return n;
    end if;
  end CutName;

  MyStream : aliased ZipFile_Stream;

  type Dir_entry;
  type p_Dir_entry is access Dir_entry;
  type Dir_entry is record
    head: Zip.Headers.Central_File_Header;
    name: Unbounded_String;
    next: p_Dir_entry:= null;
    stream : Zipstream_Class := MyStream'Unchecked_Access;
  end record;

  --  Final zipfile stream
  ZipFileStream : constant Zipstream_Class := MyStream'Unchecked_Access;

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

  procedure Process_entries(
    list: p_Dir_entry;
    compress: Zip.Compress.Compression_Method
  )
  is
    e: p_Dir_entry:= list;
    ed: Zip.Headers.End_of_Central_Dir;
    mem1, mem2 : Integer := 1;
    use Zip.Compress;
  begin
    --
    -- 1/ Compress each file into the archive:
    --
    while e /= null loop
      Put("Adding ");
      declare
        maxlen: constant:= 24;
        cut: constant String:= Cutname( S(e.name), maxlen );
      begin
        Put( cut );
        for l in cut'Length .. maxlen loop
          Put(' ');
        end loop;
      end;
      mem1 := Index (ZipFileStream);
      e.head.local_header_offset:= Unsigned_32(mem1)-1;
      -- Write the local header with incomplete informations
      Zip.Headers.Write (ZipFileStream, e.head.short_info);
      declare
         TempArray : constant Stream_Element_Array :=
           To_Stream_Element_Array (To_String (e.name));
      begin
         Write (ZipFileStream.all, TempArray);
      end;
      --
      Zip.Compress.Compress_data
      (
        input            => e.stream,
        output           => ZipFileStream,
        input_size_known => True,
        input_size       => e.head.short_info.dd.uncompressed_size,
        method           => compress,
        feedback         => My_feedback'Access,
        CRC              => e.head.short_info.dd.crc_32,
        output_size      => e.head.short_info.dd.compressed_size,
        zip_type         => e.head.short_info.zip_type
      );
      --
      if e.head.short_info.dd.uncompressed_size = 0 then
        Put("          ");
      end if;
      Put(' ');
      declare
        meth: constant String:=
          To_Lower(Zip.pkzip_method'Image(
            Zip.Method_from_code(e.head.short_info.zip_type)
          ));
      begin
        Put( meth );
        for l in meth'Length+1 .. Zip.pkzip_method'Width loop
          Put(' ');
        end loop;
      end;
      if e.head.short_info.dd.uncompressed_size > 0 then
        Put(", to ");
        Put(100.0 *
              Float(e.head.short_info.dd.compressed_size) /
              Float(e.head.short_info.dd.uncompressed_size),
          3,2,0
        );
        Put('%');
      end if;
      Put_Line(", done.");
      mem2 := Index (ZipFileStream);
      -- Go back to the local header to rewrite it with complete informations
      Set_Index (ZipFileStream, mem1);
      Zip.Headers.Write (ZipFileStream, e.head.short_info);
      -- Return to momentaneous end of file
      Set_Index (ZipFileStream, mem2);
      e:= e.next;
    end loop;
    --
    -- 2/ Almost done - write Central Directory:
    --
    ed.central_dir_offset:= Unsigned_32(mem2)-1;
    ed.total_entries:= 0;
    ed.central_dir_size:= 0;
    ed.main_comment_length:= 0;
    e:= list;
    while e /= null loop
      ed.total_entries:= ed.total_entries + 1;
      Zip.Headers.Write (ZipFileStream, e.head);
      declare
        TempArray : constant Stream_Element_Array :=
          To_Stream_Element_Array (To_String (e.name));
      begin
        Write (ZipFileStream.all, TempArray);
      end;
      ed.central_dir_size:=
        ed.central_dir_size +
        Zip.Headers.central_header_length +
        Unsigned_32(e.head.short_info.filename_length);
      e:= e.next;
    end loop;
    ed.disknum:= 0;
    ed.disknum_with_start:= 0;
    ed.disk_total_entries:= ed.total_entries;
    Zip.Headers.Write (ZipFileStream, ed);
  end Process_entries;

  list, curr: p_Dir_entry:= null;

  procedure Add_1_Stream(Stream : Zipstream_Class) is
    e: constant p_Dir_entry:= new Dir_entry;
  begin
    e.stream                                := Stream;  -- add stream to node
    e.head.made_by_version                  := 23; -- version 2.30
    e.head.comment_length                   := 0;
    e.head.disk_number_start                := 0;
    e.head.internal_attributes              := 0; -- 0: seems binary; 1, text
    e.head.external_attributes              := 0; --
    e.head.short_info.needed_extract_version:= 10; -- Value put by Zip/PKZip
    e.head.short_info.bit_flag              := 0;
    e.head.short_info.file_timedate         := GetTime (Stream);
    e.head.short_info.dd.uncompressed_size  := Unsigned_32 (Size (Stream));
    e.head.short_info.filename_length       := GetName (Stream)'Length;
    e.head.short_info.extra_field_length    := 0;
    e.name:= To_Unbounded_String (GetName (Stream));
    if curr = null then
      curr:= e;
      list:= e;
    else
      curr.next:= e;
      curr:= e;
    end if;
  end Add_1_Stream;

  function Add_zip_ext(s: String) return String is
  begin
    if s'Length < 4 or else
       To_Upper(s(s'Last-3..s'Last)) /= ".ZIP"
    then
      return s & ".zip";
    else
      return s;
    end if;
  end Add_zip_ext;

  zip_name_set: Boolean:= False;
  answer: Character;
  InStream : array(2..Argument_Count) of aliased ZipFile_Stream;

begin
  for I in 1..Argument_Count loop
    declare
      arg    : constant String:= Argument(I);
      arg_zip: constant String:= Add_zip_ext(arg);
    begin
      if arg(1) = '-' then
        null; -- option!!
      elsif not zip_name_set then
        zip_name_set:= True;
        if Exists(arg_zip) then
          Put("Archive " & arg_zip & " already exists! Overwrite (y/n) ?");
          Get_Immediate(answer);
          answer:= To_Upper(answer);
          Put_Line(" -> " & answer);
          if answer/='Y' then
            Put_Line("Stopped.");
            return;
          end if;
        end if;
        ZipFileStream.SetName (arg_zip);
        Create (ZipFile_Stream (ZipFileStream.all), Out_File);
      else
        declare
          StreamFile : constant Zipstream_Class := InStream (I)'Unchecked_Access;
        begin
           StreamFile.SetName (arg);
           Open (ZipFile_Stream (StreamFile.all), In_File);
           Add_1_Stream (StreamFile);
        end;
      end if;
    end;
  end loop;
  Blurb;
  if Argument_Count > 1 then
    T0:= Clock;
    Process_entries(list, compress => Zip.Compress.Shrink);
    Close(ZipFile_Stream (ZipFileStream.all));
    T1:= Clock;
    seconds:= T1-T0;
    Put("Time elapsed : ");
    Put( Float( seconds ), 4, 2, 0 );
    Put_Line( " sec");
  else
    --  Put_Line("Location of this version: " & Command_Name);
    --  New_Line;
    Put_Line("Usage: zipada archive[.zip] file(s)");
  end if;
end ZipAda;
