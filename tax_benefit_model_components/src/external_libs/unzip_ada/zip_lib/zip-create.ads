-- Contributed by ITEC - NXP Semiconductors
--
-- June 2008

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Zip.Headers; use Zip.Headers;
with Zip.Compress; use Zip.Compress;
with Zip_Streams; use Zip_Streams;

package Zip.Create is

   type Zip_Create_info is private;

   procedure Create(Info        : out Zip_Create_info;
                    Z_Stream    : in Zipstream_Class;
                    Name        : String;
                    Compress    : Zip.Compress.Compression_Method);


   procedure Add_Stream (Info   : in out Zip_Create_info;
                         Stream : Zipstream_Class);

   procedure Finish (Info       : in out Zip_Create_info);

private

   type Dir_entry is record
      head : Zip.Headers.Central_File_Header;
      name : Unbounded_String;
   end record;

   type Dir_entries is array (Integer range <>) of Dir_entry;
   type Pdir_entries is access Dir_entries;

   type Zip_Create_info is record
      Stream   : Zipstream_Class;
      compress : Zip.Compress.Compression_Method;
      Contains : Pdir_entries;
   end record;

end Zip.Create;
