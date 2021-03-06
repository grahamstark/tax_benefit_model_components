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

with Zip_Streams;

package Zip.Compress is

  type Compression_Method is
    (Store,
     Shrink
    );

  type Feedback_proc is access
    procedure ( percents_done: in Natural; user_abort: out Boolean );

  User_abort: exception;

  -- Compress data from an input stream to an output stream until
  -- End_Of_File(input) = True, or number of input bytes = input_size

  procedure Compress_data(
    input,
    output          : Zip_Streams.Zipstream_Class;
    input_size_known: Boolean;
    input_size      : File_size_type; -- ignored if unknown
    method          : Compression_Method;
    feedback        : Feedback_proc;
    CRC             : out Interfaces.Unsigned_32;
    output_size     : out File_size_type;
    zip_type        : out Interfaces.Unsigned_16
    -- ^ code corresponding to the compression method actually used
  );

end Zip.Compress;
