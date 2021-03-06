------------------------------------------------------------------------------
--  File:            Myteldat.adb or My_tell_data.adb
--  Description:     part of Unzipada demo
------------------------------------------------------------------------------

with UnZip, My_dots, Summary;

with Ada.Characters.Handling;           use Ada.Characters.Handling;
with Ada.Text_IO;                       use Ada.Text_IO;

with Interfaces;                        use Interfaces;

procedure My_tell_data
            ( name               : String;
              compressed_bytes   : UnZip.File_size_type;
              uncompressed_bytes : UnZip.File_size_type;
              method             : UnZip.pkzip_method ) is

  package MIO is new Modular_IO(UnZip.File_size_type);

  function CutName(n:String; l:Natural) return String is
    dots: constant String:= "...";
  begin
    if n'Length > l then
      return dots & n( n'Last - (l-1) + dots'Length .. n'Last );
    else
      return n;
    end if;
  end CutName;

begin
  New_Line;
  Put(' ');
  My_dots.done_dots:= 0;
  declare
    maxlen: constant:= 24;
    cut: constant String:= Cutname( name, maxlen );
  begin
    Put( cut );
    for l in cut'Length .. maxlen loop
      Put(' ');
    end loop;
  end;
  Put(' ');
  declare
    meth: constant String:= To_Lower(UnZip.pkzip_method'Image(method));
  begin
    Put( meth );
    for l in meth'Length .. UnZip.pkzip_method'Width loop
      Put(' ');
    end loop;
  end;
  MIO.Put(compressed_bytes  , 10);
  if uncompressed_bytes = 0 then
    Put(" :         ");
  else
    Put(" :");
    MIO.Put(
      UnZip.File_size_type(
        (100.0*Long_Float(compressed_bytes)) / Long_Float(uncompressed_bytes)
      ), 4);
    Put("% of ");
  end if;
  MIO.Put(uncompressed_bytes, 10);
  Put(' ');
  -- We summarize here the length of processed files
  Summary.total_uncompressed:=
    Summary.total_uncompressed + uncompressed_bytes;
  Summary.total_compressed:=
    Summary.total_compressed   + compressed_bytes;
  Summary.Total_Entries:=
    Summary.Total_Entries + 1;
end My_tell_data;
