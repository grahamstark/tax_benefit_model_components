with BHPS.Binary_IO.Conversion_To_Binary;
with Conversions;

procedure Create_BHPS_Binary_Datasets is
begin
   Conversions.Set_Assigned_Missing_Values( BHPS.MISS_R, BHPS.MISS );
	BHPS.Binary_IO.Conversion_To_Binary.Create_X;
	BHPS.Binary_IO.Conversion_To_Binary.Create;
end Create_BHPS_Binary_Datasets;
