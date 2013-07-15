generic

package Inequality_Generator.Utils is

   function Read_From_File( 
      filename : String; 
      weight_column : Positive; 
      income_column : Positive ) return Quantile_List; 

end Inequality_Generator.Utils;
