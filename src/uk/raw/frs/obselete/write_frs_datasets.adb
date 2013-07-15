--
--  $Author: graham_s $
--  $Date: 2008-08-20 08:18:39 +0100 (Wed, 20 Aug 2008) $
--  $Revision: 5684 $
--

with raw_frs_conversions_0304;
with raw_frs_conversions_0405;

procedure write_frs_datasets is
begin

   raw_frs_conversions_0304.write_everything_in_binary;
   raw_frs_conversions_0405.write_everything_in_binary;

end write_frs_datasets;
