--  ________  ___   ______       ______     ___
-- /___..._/  |.|   |.___.\     /. __ .\  __|.|   ____
--    /../    |.|   |.____/     |.|__|.| /....|  __\..\
--  _/../___  |.|   |.|    ===  |..__..||. = .| | = ..|
-- /_______/  |_|  /__|        /__|  |_| \__\_|  \__\_|

-- Zip.Compress
---------------
--
-- Created 9-Dec-2007
--
-- This package facilitates the storage or compression of data.
--
-- Note that unlike decompression where the decoding is unique,
-- there are an undefinite number of ways of compressing data into
-- formats which include compression structures, like Deflate.
-- As a result, you may want to use your own way (e.g. interfacing
-- with zlib).
-- This package is only a portable one, and doesn't claim
-- to be the best or the fastest

with Zip.CRC, Zip.Compress.Shrink;
with Ada.Streams; use Ada.Streams;

package body Zip.Compress is

  use Zip_Streams;

  -------------------
  -- Compress_data --
  -------------------

  procedure Compress_data
   (input,
    output          : Zip_Streams.Zipstream_Class;
    input_size_known: Boolean;
    input_size      : File_size_type;
    method          : Compression_Method;
    feedback        : Feedback_proc;
    CRC             : out Interfaces.Unsigned_32;
    output_size     : out File_size_type;
    zip_type        : out Interfaces.Unsigned_16
   )
  is
    b: Zip.Byte;
    use Ada.Streams.Stream_IO, Interfaces;
    counted: File_size_type;
    user_aborting: Boolean;
    idx_in:  constant Positive:= Index(input);
    idx_out: constant Positive:= Index(output);
    compression_ok: Boolean;
  begin
    Zip.CRC.Init(CRC);
    case method is
      when Store =>
        zip_type:= 0; -- "Store" method
        counted:= 0;
        while not End_Of_Stream(input) loop
          if input_size_known and counted >= input_size then
            exit;
          end if;
            counted:= counted + 1;
            -- Copy data
            declare
               TempArray: Stream_Element_Array ( 1..1 );
               TempOffset : Stream_Element_Offset;
            begin
               Read (input.all, TempArray, TempOffset);
               b := Zip.Byte (TempArray(1));
               Write (output.all, TempArray);
            end;

            Zip.CRC.Update(CRC, (1=> b));
          -- Feedback
          if feedback /= null and then
            ((counted=1) or (counted mod (2**16)=0) or
            (input_size_known and counted = input_size))
          then
            if input_size_known then
              feedback(
                percents_done =>
                  Natural( (100.0 * Float(counted)) / Float(input_size) ),
                user_abort    => user_aborting );
            else
              feedback(
                percents_done => 0,
                user_abort    => user_aborting );
            end if;
            if user_aborting then
              raise User_abort;
            end if;
          end if;
        end loop;
        output_size:= counted;
        compression_ok:= True;
      when Shrink =>
        Zip.Compress.Shrink(
          input,
          output,
          input_size_known,
          input_size,
          feedback,
          CRC,
          output_size,
          compression_ok
        );
        zip_type:= 1; -- "Shrink" method
    end case;
    CRC:= Zip.CRC.Final(CRC);
    --
    -- Handle case where compression has been unefficient:
    -- data to be compressed is too "random"; then compressed data
    -- happen to be larger than uncompressed data
    --
    if not compression_ok then
      -- Go back to the beginning and just store the data
      Set_Index(input, idx_in);
      Set_Index(output, idx_out);
      Compress_Data
        ( input,
          output,
          input_size_known,
          input_size,
          Store,      -- Force the "store" method this time
          feedback,
          CRC,
          output_size,
          zip_type
        );
    end if;
  end Compress_data;

end Zip.Compress;
