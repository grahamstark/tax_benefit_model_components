package body ONS_Definitions is

   function Get_Age_Band( age : Age_Range ) return Age_Band is
      r : Age_Band;
   begin
      case age is
         when 0        => r := age_under_1;
         when 1 .. 4   => r := age_1_to_4 ;
         when 5 .. 14  => r := age_5_to_14;
         when 15 .. 24 => r := age_15_to_24;
         when 25 .. 34 => r := age_25_to_34;
         when 35 .. 44 => r := age_35_to_44;
         when 45 .. 54 => r := age_45_to_54;
         when 55 .. 64 => r := age_55_to_64;
         when 65 .. 74 => r := age_65_to_74;
         when 75 .. 84 => r := age_75_to_84;
         when 85 .. Age_Range'Last => r := age_85_plus;
      end case;
      return r;
   end Get_Age_Band;
   
end ONS_Definitions;
