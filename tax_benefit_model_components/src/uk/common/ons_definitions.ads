package ONS_Definitions is

   subtype Age_Range is Integer range 0 .. 150;
   
   type Age_Band is ( 
      age_under_1,
      age_1_to_4 ,
      age_5_to_14,
      age_15_to_24,
      age_25_to_34,
      age_35_to_44,
      age_45_to_54,
      age_55_to_64,
      age_65_to_74,
      age_75_to_84,
      age_85_plus );


   function Get_Age_Band( age : Age_Range ) return Age_Band;   

end ONS_Definitions;
