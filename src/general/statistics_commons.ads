package Statistics_Commons is

   subtype Percentile is Integer range 1 .. 100;
   subtype Decile is Integer range 1 .. 10;
   subtype Quintile is Integer range 1 .. 5;
	
   type Simple_Measures is (
      mean,
      median, 
      average_deviation,
      standard_deviation,
      variance,
      skewness,
      kurtosis,
      minimum,
      maximum,
      percentile_5,
      percentile_95 );     
   
   type Interpolation_Method is ( exponential, linear );
      
end Statistics_Commons;
