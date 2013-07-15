-- Draft of a zip repacker utility.
-- Compression speed doesn't matter, only size performance.

with Ada.Calendar;                      use Ada.Calendar;
with Ada.Command_Line;                  use Ada.Command_Line;
with Ada.Directories;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Integer_Text_IO;               use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;                 use Ada.Float_Text_IO;
with Ada.Streams.Stream_IO;             use Ada.Streams.Stream_IO;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed, Ada.Strings;
with Ada.Strings.Unbounded;             use Ada.Strings.Unbounded;
with Ada.Characters.Handling;           use Ada.Characters.Handling;
with Ada.Unchecked_Deallocation;
with Ada.Numerics.Float_Random;         use Ada.Numerics.Float_Random;

with Interfaces;                        use Interfaces;

with Zip.Headers, Zip.Compress, UnZip;
with Zip_Streams;                       use Zip_Streams;

with GNAT.OS_Lib;

procedure ReZip is

  -- Copy a chunk from a stream into another one:
   procedure Copy_chunk(from : Zipstream_Class;
                        into : Ada.Streams.Stream_IO.File_Type; bytes: Natural) is
    buf: Zip.Byte_Buffer(1..32768);
    actually_read, remains: Natural;
  begin
    remains:= bytes;
    loop
      exit when remains = 0;
      Zip.BlockRead(from,buf(1..Integer'Min(remains, buf'Last)),actually_read);
      if actually_read = 0 then -- premature end, unexpected
        raise Zip.Zip_File_Error;
      end if;
      remains:= remains - actually_read;
      Zip.Byte_buffer'Write(Stream(into), buf(1..actually_read));
    end loop;
  end Copy_chunk;

  -- Copy a whole file into a stream:
  procedure Copy(from: String; into: Zipstream_Class) is
    f: Ada.Streams.Stream_IO.File_Type;
    buf: Zip.Byte_Buffer(1..32768);
    actually_read: Natural;
  begin
    Open(f, In_File, from);
    loop
      Zip.BlockRead(f,buf,actually_read);
      exit when actually_read = 0; -- this is expected
      Zip.Byte_buffer'Write(into, buf(1..actually_read));
    end loop;
    Close(f);
  end Copy;

  procedure Blurb is
  begin
    Put_Line("ReZip * Zip file recompression tool.");
    Put_Line("Author: Gautier de Montmollin");
    Put_Line("URL: http://unzip-ada.sf.net");
    New_Line;
  end Blurb;

  function S (Source : Ada.Strings.Unbounded.Unbounded_String) return String
    renames Ada.Strings.Unbounded.To_String;
  function U (Source : String) return Ada.Strings.Unbounded.Unbounded_String
    renames Ada.Strings.Unbounded.To_Unbounded_String;

  procedure Rip_data(
    archive      : Zip.Zip_info; -- from this archive...
    InputStream  : in Zipstream_Class;
    data_name    : String;       -- extract this data
    rip_rename   : String;       -- to this file (compressed)
    unzip_rename : String;       -- and this one (uncompressed)
    case_match   : Boolean;
    header       : out Zip.Headers.Local_File_Header
  )
  is
    file_index :  Ada.Streams.Stream_IO.Positive_Count;
    comp_size  :  Zip.File_size_type;
    uncomp_size:  Zip.File_size_type;
    file_out             : Ada.Streams.Stream_IO.File_Type;
  begin
    Zip.Find_Offset(
      info           => archive,
      name           => data_name,
      case_sensitive => case_match,
      file_index     => file_index,
      comp_size      => comp_size,
      uncomp_size    => uncomp_size
    );
    Set_Index(InputStream, Positive(file_index));
    Zip.Headers.Read_and_check(InputStream, header);
    -- Skip name and extra field
    Set_Index(InputStream,
      Index(InputStream) +
        Positive (header.extra_field_length +
        header.filename_length)
    );
    -- * Get the data, compressed
    Create(file_out, Out_File, rip_rename);
    Copy_Chunk(InputStream, file_out, Integer(comp_size));
    Close(file_out);
    if unzip_rename /= "" then
      -- * Get the data, uncompressed
      UnZip.Extract(
        from    => archive,
        what    => data_name,
        rename  => unzip_rename,
        options =>
        (
            UnZip.test_only => False,
            UnZip.junk_directories => False,
            UnZip.case_sensitive_match => case_match
        )
      );
    end if;
  end Rip_data;

  type Approach is (
    original,
    shrink,
    external_1, external_2, external_3, external_4,
    external_5, external_6, external_7, external_8
  );

  subtype External is Approach range external_1 .. Approach'Last;

  type Packer_info is record
    size : Zip.File_size_type;
    zfm  : Unsigned_16;
    count: Natural;
    saved: Zip.File_size_type;
    uncomp_size: Unsigned_64;
    -- summed uncompressed sizes might be more than 2**32
  end record;

  type Packer_info_array is array(Approach) of Packer_info;

  type Dir_entry;
  type p_Dir_entry is access Dir_entry;
  type Dir_entry is record
    head: Zip.Headers.Central_File_Header;
    name: Ada.Strings.Unbounded.Unbounded_String;
    next: p_Dir_entry:= null;
    chosen_approach: Approach:= original;
    info: Packer_info_array;
  end record;

  function Temp_name(
    compressed: Boolean;
    appr      : Approach
  )
    return String
  is
    initial: constant array(Boolean) of Character:= ('u','c');
  begin
    return
      "_!" & initial(compressed) &
      '!' & Trim(Integer'Image(Approach'Pos(appr)), Left) &
      "!_.tmp";
  end Temp_name;

  -- This might be better read from a config file...

  external_packer: constant array(External) of Unbounded_String:=
    (
      -- U("PKZip092.exe"),
      -- U("PKZip110.exe"),
      U("zip.exe"),
      U("7zip_210.exe"),
      U("kzip.exe"),
      U("kzip.exe"),
      U("kzip.exe"),
      U("kzip.exe"),
      U("kzip.exe"),
      U("kzip.exe")
      -- U("BJWFlate.exe")
    );

  external_options: constant array(External) of Unbounded_String:=
    (
      -- U("-ea4"),
      -- U("-es"),
      U("-9"),
      U("a -mx"),
      U("/rn /b0"),
      U("/rn /b128"),
      U("/rn /b256"),
      U("/rn /b512"),
      U("/rn /b1024"),
      U("/rn /b#RAND#")
      -- U("-n")
    );

  external_title: constant array(External) of Unbounded_String:=
    (
      -- U("PKZIP 0.92 (Reduce 4)"),
      -- U("PKZIP 1.10 (Shrink)"),
      U("Zip 2.32"),
      U("7-ZIP 2.10"),
      U("KZIP"),
      U("KZIP"),
      U("KZIP"),
      U("KZIP"),
      U("KZIP"),
      U("KZIP")
      -- U("BJWFlate 1.54")
    );

  function Img(a: Approach) return String is
  begin
    if a in External then
      return "External: " & S(external_title(a)) & ", " & S(external_options(a));
    else
      declare
        s: constant String:= Approach'Image(a);
      begin
        return s(s'First) & To_Lower(s(s'First+1..s'Last));
      end;
    end if;
  end Img;

  gen: Generator;

  procedure Call_external(packer: String; args: String) is
    use GNAT.OS_Lib;
    procedure Dispose is
      new Ada.Unchecked_Deallocation(Argument_List, Argument_List_Access);
    list: Argument_List_Access;
    ok: Boolean;
    expa: Unbounded_String:= U(args); -- expanded arguments
    repl: Unbounded_String;
    type Token is (rand);
    idx: Natural;
  begin
    for t in Token loop
      declare
        tok: constant String:= '#' & Token'Image(t) & '#';
      begin
        idx:= Index(args, tok);
        if idx > 0 then
          case t is
            when rand =>
              repl:=
                U(Trim(Integer'Image(Integer(
                  (Random(gen)**3) * 700.0
                )),Left));
          end case;
          Replace_Slice(expa, idx, idx + tok'Length - 1, S(repl));
        end if;
      end;
    end loop;
    Put_Line(packer & " [" & S(expa) & ']');
    list:= Argument_String_To_List(S(expa));
    GNAT.OS_Lib.Spawn(packer, list.all, ok);
    Dispose(list);
    if not ok then
      raise Program_Error;
    end if;
  end Call_external;

  procedure Process_External(
    packer  : String;
    options : String;
    out_name: String;
    info    : out Packer_info
  ) is
    temp_zip: constant String:= "$temp$.zip";
    data_name: constant String:= Temp_name(False,original);
    zi_ext: Zip.Zip_info;
    header: Zip.Headers.Local_File_Header;
    MyStream   : aliased ZipFile_Stream;
    StreamFile : constant Zipstream_Class := MyStream'Unchecked_Access;
  begin
    Call_external(packer, options & ' ' &temp_zip & ' ' & data_name);
      -- Now, rip
    SetName (StreamFile, temp_zip);
    Open (MyStream, In_File);
    Zip.Load( zi_ext, StreamFile, False );
    Rip_data(
      archive      => zi_ext,
      InputStream  => StreamFile,
      data_name    => data_name,
      rip_rename   => out_name,
      unzip_rename => "",
      case_match   => False, -- external packers are DOS/Windows
      header       => header
    );
    Close (MyStream);
    Ada.Directories.Delete_File(temp_zip);
    info.size       := header.dd.compressed_size;
    info.uncomp_size:= Unsigned_64(header.dd.uncompressed_size);
    -- uncomp_size should not matter (always the same).
    info.zfm        := header.zip_type;
  end Process_external;

  procedure Repack_contents(orig_name, repacked_name, log_name: String)
  is
    zi: Zip.Zip_info;
    MyStream   : aliased ZipFile_Stream;
    StreamFile : constant Zipstream_Class := MyStream'Unchecked_Access;

    list, e, curr: p_Dir_entry:= null;
    repacked_zip_file   : aliased ZipFile_Stream;
    Streamrepacked_zip_file : constant Zipstream_Class := repacked_zip_file'Unchecked_Access;
    total: Packer_info_array:= (others => (0,0,0,0,0));
    -- total(a).count counts the files where approach 'a' was optimal
    -- total(a).saved counts the saved bytes when approach 'a' was optimal
    total_choice: Packer_info:= (0,0,0,0,0);
    summary: Ada.Text_IO.File_Type;
    T0, T1 : Time;
    seconds: Duration;

    procedure Process_one(unique_name: String) is
      comp_size  :  Zip.File_size_type;
      uncomp_size:  Zip.File_size_type;
      File_in       : aliased ZipFile_Stream;
      StreamFile_in : constant Zipstream_Class := File_in'Unchecked_Access;
      File_out      : aliased ZipFile_Stream;
      StreamFile_out: constant Zipstream_Class := File_out'Unchecked_Access;
      use Zip.Compress;
      choice: Approach:= original;
    begin
      total_choice.count:= total_choice.count + 1;
      Put_Line(
        "Processing [" &
        unique_name & "]," &
        Integer'Image(total_choice.count) &
        " of" &
        Integer'Image(Zip.Entries(zi))
      );
      --
      e:= new Dir_entry;
      if curr = null then
        curr:= e;
        list:= e;
      else
        curr.next:= e;
        curr:= e;
      end if;
      e.name:= U(unique_name);
      e.head.made_by_version     := 23; -- version 2.30
      e.head.comment_length      := 0;
      e.head.disk_number_start   := 0;
      e.head.internal_attributes := 0; -- 0: seems binary; 1, text
      e.head.external_attributes := 0;
      --
      Put("    Phase 1:  dump & unzip -");
      Rip_data(
        archive      => zi,
        InputStream  => StreamFile,
        data_name    => unique_name,
        rip_rename   => Temp_name(True,original),
        unzip_rename => Temp_name(False,original),
        case_match   => True,
        header       => e.head.short_info
      );
      -- Get reliable data from zi
      Zip.Get_sizes(
        info           => zi,
        name           => unique_name,
        case_sensitive => True,
        comp_size      => comp_size,
        uncomp_size    => uncomp_size
      );
      Put_Line(" done");
      Put_Line("    Phase 2:  try different tactics...");
      --
      -- Try all approaches:
      --
      for a in Approach loop
        Put_Line("              -o-> " & Img(a));
        case a is
          when original =>
            -- This is from the original .zip - just record size and method
            e.info(a).size:= comp_size;
            e.info(a).zfm := e.head.short_info.zip_type;
          when shrink =>
            SetName (StreamFile_in, Temp_name(False,original));
            Open (File_in, In_File);
            SetName (StreamFile_out, Temp_name(True,a));
            Create (File_out, Out_File);
            Zip.Compress.Compress_data
            (
              input            => StreamFile_in,
              output           => StreamFile_out,
              input_size_known => True,
              input_size       => e.head.short_info.dd.uncompressed_size,
              method           => Zip.Compress.Shrink,
              feedback         => null,
              CRC              => e.head.short_info.dd.crc_32,
              -- we take the occasion to compute the CRC if not
              -- yet available (e.g. JAR)
              output_size      => e.info(a).size,
              zip_type         => e.info(a).zfm
            );
            Close(File_in);
            Close(File_out);
          when External =>
            Process_External(
              S(external_packer(a)),
              S(external_options(a)),
              Temp_name(True,a),
              e.info(a)
            );
            New_Line;
        end case;
        total(a).size:= total(a).size + e.info(a).size;
        if e.info(a).size < e.info(choice).size then
          -- Hurra, we found a smaller size!
          choice:= a;
        end if;
      end loop;
      total_choice.size:= total_choice.size + e.info(choice).size;
      total(choice).count:= total(choice).count + 1;
      total_choice.uncomp_size:=
        total_choice.uncomp_size + Unsigned_64(uncomp_size);
      total(choice).saved:=
        total(choice).saved + e.info(original).size - e.info(choice).size;
      total_choice.saved:=
        total_choice.saved + e.info(original).size - e.info(choice).size;
      --
      New_Line;
      Put(
        "    Phase 3:  Winner is " & Img(choice) &
        "; writing data -"
      );
      -- * Summary outputs
      Put(summary,"<tr><td><tt>" & unique_name & "</tt></td>");
      for a in Approach loop
        if choice = a then
          Put(summary,"<td bgcolor=lightgreen><b>");
        elsif e.info(a).size = e.info(choice).size then -- ex aequo
          Put(summary,"<td bgcolor=lightblue><b>");
        else
          Put(summary,"<td>");
        end if;
        Put(summary, Zip.File_size_type'Image(e.info(a).size));
        if choice = a then
          Put(summary,"</b>");
        end if;
        Put(summary,"</td>");
      end loop;
      -- Recall winner size:
      Put(summary,"<td>" & Img(choice) & "</td>");
      Put(summary,"<td bgcolor=lightgreen><b>");
      Put(summary, Zip.File_size_type'Image(e.info(choice).size));
      Put(summary,"</b></td><td>");
      if e.info(original).size > 0 then
        Put(
          summary,
          100.0 * Float(e.info(choice).size) / Float(e.info(original).size),
          3,2,0
        );
        Put(summary,"%");
      end if;
      Put(summary,"</td><td>");
      if uncomp_size > 0 then
        Put(
          summary,
          100.0 * Float(e.info(choice).size) / Float(uncomp_size),
          3,2,0
        );
        Put(summary,"%");
      end if;
      Put(summary,"</td></tr>");
      --
      -- Write winning data:
      --
      e.head.short_info.extra_field_length:= 0; -- We choose to ignore it...
      -- No data descriptor after data:
      e.head.short_info.bit_flag:=
        e.head.short_info.bit_flag and (16#FFFF# - 8);
      -- Set or adjust the pre-data data descriptor:
      -- NB: even if missing pre-data, CRC will have been computed
      --     at least with one internal method
      e.head.short_info.dd.uncompressed_size:= uncomp_size;
      -- Put the winning size and method
      e.head.short_info.dd.compressed_size:= e.info(choice).size;
      e.head.short_info.zip_type:= e.info(choice).zfm;
      e.head.local_header_offset:= Unsigned_32(Index(Streamrepacked_zip_file))-1;
      Zip.Headers.Write(Streamrepacked_zip_file, e.head.short_info);
      String'Write(Streamrepacked_zip_file, S(e.name));
      -- Copy the compressed data
      Copy( Temp_name(True,choice), Streamrepacked_zip_file );
      Put_Line(" done");
      New_Line;
    end Process_one;

    procedure Process_all is new Zip.Traverse(Process_one);

    ed: Zip.Headers.End_of_Central_Dir;

    function Webcolor(a: Approach) return String is
      v: Float;
      sr,sg,sb: String(1..10);
    begin
      if total_choice.saved > 0 then
        v:= Float(total(a).saved) / Float(total_choice.saved);
        -- contribution of approach 'a'
      else
        v:= 0.0;
      end if;
      Put(sr, 512 + Integer(144.0 + 111.0 * (1.0 - v)), 16);
      sb:= sr;
      Put(sg, 512 + Integer(238.0 + 17.0 * (1.0 - v)), 16);
      return
        sr(sr'Last-2..sr'Last-1) &
        sg(sg'Last-2..sg'Last-1) &
        sb(sb'Last-2..sb'Last-1);
    end Webcolor;

  begin
    T0:= Clock;
    SetName (StreamFile, orig_name);
    Open (MyStream, In_File);
    Zip.Load( zi, StreamFile, True );

    SetName (Streamrepacked_zip_file, repacked_name);
    Create(repacked_zip_file, Out_File);
    Create(summary, Out_File, log_name);
    Put_Line(summary,
      "<html><head><title>ReZip summary for file " & orig_name &
      "</title></head><body>"
    );
    Put_Line(summary, "<h2>ReZip summary for file " & orig_name & "</h2>");
    Put_Line(summary, "<table border=1 cellpadding=1 cellspacing=1>");
    Put(summary, "<tr bgcolor=lightyellow><td>File name</td>");
    for a in Approach loop
      Put(summary, "<td>" & Img(a) & "</td>");
    end loop;
    Put_Line(summary,
      "<td><b>Choice</b></td><td>Smallest<br>size</td>" &
      "<td>% of<br>original</td><td>% of<br>uncompressed</td></tr>"
    );
    --
    -- 1/ Recompress each file into the new archive:
    --
    Process_all(zi);
    --
    -- 2/ Almost done - write Central Directory:
    --
    ed.central_dir_offset:= Unsigned_32(Index(streamrepacked_zip_file))-1;
    ed.total_entries:= 0;
    ed.central_dir_size:= 0;
    ed.main_comment_length:= 0;
    -- Restart at the beginning of the list
    e:= list;
    while e /= null loop
      ed.total_entries:= ed.total_entries + 1;
      Zip.Headers.Write(Streamrepacked_zip_file, e.head);
      String'Write(Streamrepacked_zip_file, S(e.name));
      ed.central_dir_size:=
        ed.central_dir_size +
        Zip.Headers.central_header_length +
        Unsigned_32(e.head.short_info.filename_length);
      e:= e.next;
    end loop;
    ed.disknum:= 0;
    ed.disknum_with_start:= 0;
    ed.disk_total_entries:= ed.total_entries;
    Zip.Headers.Write(Streamrepacked_zip_file, ed);
    Close(repacked_zip_file);
    --
    -- Cleanup
    --
    for a in Approach loop
      Ada.Directories.Delete_File( Temp_name(True,a) );
      if a = original then -- also an uncompressed data file to delete
        Ada.Directories.Delete_File( Temp_name(False,a) );
      end if;
    end loop;
    -- Report total bytes
    Put(summary,"<tr><td><b>T<small>OTAL BYTES</small></b></td>");
    for a in Approach loop
      Put(summary,
        "<td bgcolor=#" & Webcolor(a) & ">" &
        Zip.File_size_type'Image(total(a).size) & "</td>"
      );
    end loop;
    Put(summary,
      "<td></td><td bgcolor=lightgreen><b>" & Zip.File_size_type'Image(total_choice.size) &
      "</b></td><td>"
    );
    if total(original).size > 0 then
      Put(summary,
        100.0 * Float(total_choice.size) / Float(total(original).size),
        3,2,0
      );
      Put(summary,"%");
    end if;
    Put(summary, "</td><td>");
    if total_choice.uncomp_size > 0 then
      Put(summary,
        100.0 * Float(total_choice.size) / Float(total_choice.uncomp_size),
        3,2,0
      );
      Put(summary,"%");
    end if;
    Put_Line(summary, "</td></tr>");
    -- Report total files per approach
    Put(summary,"<tr><td><b>T<small>OTAL FILES</small></b></td>");
    for a in Approach loop
      Put(summary,
        "<td bgcolor=#" & Webcolor(a) & ">" &
        Integer'Image(total(a).count) & "</td>"
      );
    end loop;
    Put(summary,
      "<td></td><td bgcolor=lightgreen><b>" & Integer'Image(total_choice.count) &
      "</b></td>" &
      "<td>"
    );
    Put_Line(summary, "</td></tr>");
    -- Report total saved bytes per approach
    Put(summary,"<tr><td><b>T<small>OTAL SAVED BYTES</small></b></td>");
    for a in Approach loop
      Put(summary,
        "<td bgcolor=#" & Webcolor(a) & ">" &
        Zip.File_size_type'Image(total(a).saved) & "</td>"
      );
    end loop;
    Put(summary,
      "<td></td><td bgcolor=lightgreen><b>" & Zip.File_size_type'Image(total_choice.saved) &
      "</b></td>" &
      "<td>"
    );
    if total(original).size > 0 then
      Put(summary,
        100.0 * Float(total_choice.saved) / Float(total(original).size),
        3,2,0
      );
      Put(summary,"%");
    end if;
    Put(summary, "</td><td>");
    if total_choice.uncomp_size > 0 then
      Put(summary,
        100.0 * Float(total_choice.saved) / Float(total_choice.uncomp_size),
        3,2,0
      );
      Put(summary,"%");
    end if;
    Put_Line(summary, "</td></tr></table><br>");
    T1:= Clock;
    seconds:= T1-T0;
    Put(summary, "Time elapsed : ");
    Put(summary,  Float( seconds ), 4, 2, 0 );
    Put_Line(summary,  " sec</body></html>");
    Close(summary);
    Put("Time elapsed : ");
    Put( Float( seconds ), 4, 2, 0 );
    Put_Line( " sec");
    Put_Line("All details for " & orig_name & " in " & log_name);
  end Repack_contents;

  function Add_zip_ext(s: String) return String is
  begin
    if Ada.Directories.Exists(s) then
      return s;
    elsif Ada.Directories.Exists(s & ".zip") then
      return s & ".zip";
    else
      return "";
    end if;
  end Add_zip_ext;

begin
  Blurb;
  if Argument_Count = 0 then
    Put_Line("Usage: rezip archive(s)[.zip]");
    return;
  end if;
  Reset(gen);
  for i in 1..Argument_Count loop
    declare
      arg      : constant String:= Argument(i);
      arg_zip  : constant String:= Add_zip_ext(arg);
      arg_rezip: constant String:= arg_zip & ".repacked.zip";
      arg_log  : constant String:= arg_zip & ".ReZip.html";
    begin
      Repack_contents(arg_zip, arg_rezip, arg_log);
      -- [_] here, as a post-processing, we could call deflopt
      -- and finally check with comp_zip. But maybe better in a batch...
    end;
  end loop;
end ReZip;
