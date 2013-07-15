--
--  $Author: graham_s $
--  $Date: 2008-12-21 16:44:34 +0000 (Sun, 21 Dec 2008) $
--  $Revision: 6530 $
--
pragma License( Modified_GPL );

with Ada.Text_IO;

package body Model.Uprate is
   --
   --
   --  type UprateTypes is ( wages, other_income, capital, stateBenefits );
   --  Data is from the January 2006 ET.
   --  the four items we use here are:
   --  Wages = 'lnnk'; ## Unit Wage Costs : whole economy SA: Index 2002=100: UK royj';
   --  other_income = 'ihxs' ## Gross national income per head at current market prices: SA
   --  Capital = 'ihxs'  ## Gross national income per head at current market prices: SA
   --  StateBenefits = 'cbzw'; ## All items exc mortgage int payments and indirect taxes (RPIY) (Jan 1987=100)
   --
   type MacroDB is array (UPRATE_YEARS, Month_Number) of Macro_Array;

   macro      : MacroDB;
   nw_house_price : NW_House_Price_Index ;

   function House_Price_Change( year : NW_House_Price_Years; month :  Month_Number ) return Rate is
      
      thisQuarter        : Quarter;
      oldPrice, newPrice : Rate;
   begin
      thisQuarter := ( month mod 4 ) + 1;
      oldPrice  :=  nw_house_price( year, thisQuarter );
      newPrice  := nw_house_price(LAST_NW_HOUSE_PRICE_YEAR, LAST_NW_HOUSE_PRICE_QUARTER );
      return newPrice / oldPrice;
   end House_Price_Change;

        --
        --  price change between the latest date available and the given date,
        --  for the given type. Only Y/M are used in time.
        --
   function Price_Change ( 
      from_date : Time; 
      utype : UprateTypes;
      to_date : Time := UPRATE_TARGET_DATE ) return Rate is
      use Ada.Text_IO;
      from_year          : Uprate_Years := Uprate_Years( Year( from_date ) );
      from_month         : Month_Number :=Month ( from_date);
      to_year            : Uprate_Years := Uprate_Years( Year( to_date ) );
      to_month           : Month_Number :=Month ( to_date);      
      oldPrice, newPrice : Rate;      
   begin
      oldPrice  := macro (from_year, from_month ) (utype);
      newPrice  := macro (to_year, to_month ) (utype);
      return newPrice / oldPrice;
   end Price_Change;

   --
   --  Return an array Rates giving the change in each of our uprate intems
   --  between the latest date we have an the given date (to the nearest month only).
   --  Value will be 1.1 if there has been a 10% increase.
   --
   function Changes ( from_date : Time; to_date : Time := UPRATE_TARGET_DATE ) return Macro_Array is
      changeArray : Macro_Array;
   begin
      for utype in UprateTypes loop
         changeArray( utype ) := Price_Change( from_date, utype, to_date );
      end loop;
      return changeArray;
   end changes;

begin


   macro( 2002, 1 ) := ( 97.4, 4420.0, 4420.0, 165.0, 248.7, 189.1, 201.2, 268.9, 244.8 );
   macro( 2002, 2 ) := ( 97.4, 4420.0, 4420.0, 165.4, 248.8, 189.9, 201.2, 268.9, 245.0 );
   macro( 2002, 3 ) := ( 97.4, 4420.0, 4420.0, 166.1, 248.5, 191.1, 201.2, 268.9, 245.4 );
   macro( 2002, 4 ) := ( 98.3, 4457.0, 4457.0, 166.9, 252.8, 192.0, 217.1, 273.6, 247.6 );
   macro( 2002, 5 ) := ( 98.3, 4457.0, 4457.0, 167.3, 253.0, 193.2, 217.1, 273.6, 248.6 );
   macro( 2002, 6 ) := ( 98.3, 4457.0, 4457.0, 167.2, 253.1, 194.9, 217.1, 273.6, 249.6 );
   macro( 2002, 7 ) := ( 98.5, 4568.0, 4568.0, 167.0, 253.0, 196.2, 217.1, 273.6, 251.0 );
   macro( 2002, 8 ) := ( 98.5, 4568.0, 4568.0, 167.6, 253.1, 197.5, 217.1, 273.6, 251.5 );
   macro( 2002, 9 ) := ( 98.5, 4568.0, 4568.0, 168.7, 253.2, 198.9, 217.1, 273.6, 253.1 );
   macro( 2002, 10 ) := ( 99.0, 4589.0, 4589.0, 169.1, 253.5, 200.5, 217.1, 273.6, 254.9 );
   macro( 2002, 11 ) := ( 99.0, 4589.0, 4589.0, 169.6, 253.8, 201.1, 217.1, 273.6, 255.7 );
   macro( 2002, 12 ) := ( 99.0, 4589.0, 4589.0, 169.8, 253.7, 203.0, 217.1, 273.6, 256.6 );
   
   macro( 2003, 1 ) := ( 99.1, 4680.0, 4680.0, 169.8, 253.6, 204.4, 217.1, 273.6, 259.6 );
   macro( 2003, 2 ) := ( 99.1, 4680.0, 4680.0, 170.6, 253.4, 205.9, 217.1, 273.6, 260.2 );
   macro( 2003, 3 ) := ( 99.1, 4680.0, 4680.0, 171.4, 253.2, 202.7, 217.1, 273.6, 260.8 );
   macro( 2003, 4 ) := ( 100.0, 4696.0, 4696.0, 171.8, 255.8, 203.8, 242.9, 285.8, 262.8 );
   macro( 2003, 5 ) := ( 100.0, 4696.0, 4696.0, 171.9, 255.7, 205.3, 242.9, 285.8, 263.4 );
   macro( 2003, 6 ) := ( 100.0, 4696.0, 4696.0, 171.7, 255.9, 206.7, 242.9, 285.8, 264.5 );
   macro( 2003, 7 ) := ( 100.6, 4768.0, 4768.0, 171.6, 256.7, 208.2, 242.9, 285.8, 265.5 );
   macro( 2003, 8 ) := ( 100.6, 4768.0, 4768.0, 172.2, 256.7, 202.8, 242.9, 285.8, 266.4 );
   macro( 2003, 9 ) := ( 100.6, 4768.0, 4768.0, 173.2, 257.0, 204.0, 242.9, 285.8, 267.3 );
   macro( 2003, 10 ) := ( 100.2, 4880.0, 4880.0, 173.1, 257.5, 205.6, 242.9, 285.8, 271.4 );
   macro( 2003, 11 ) := ( 100.2, 4880.0, 4880.0, 173.1, 257.5, 207.4, 242.9, 285.8, 272.1 );
   macro( 2003, 12 ) := ( 100.2, 4880.0, 4880.0, 173.5, 257.6, 218.8, 242.9, 285.8, 272.7 );
   
   macro( 2004, 1 ) := ( 100.2, 4899.0, 4899.0, 173.2, 257.9, 220.4, 242.9, 285.8, 276.3 );
   macro( 2004, 2 ) := ( 100.2, 4899.0, 4899.0, 173.9, 258.0, 222.0, 242.9, 285.8, 276.5 );
   macro( 2004, 3 ) := ( 100.2, 4899.0, 4899.0, 174.3, 258.0, 232.9, 242.9, 285.8, 277.0 );
   macro( 2004, 4 ) := ( 100.9, 5006.0, 5006.0, 174.9, 261.0, 234.8, 257.7, 301.6, 278.9 );
   macro( 2004, 5 ) := ( 100.9, 5006.0, 5006.0, 175.6, 261.1, 237.3, 257.7, 301.6, 280.4 );
   macro( 2004, 6 ) := ( 100.9, 5006.0, 5006.0, 175.6, 261.5, 249.6, 257.7, 301.6, 281.1 );
   macro( 2004, 7 ) := ( 101.3, 5022.0, 5022.0, 175.1, 262.3, 261.7, 257.7, 301.6, 282.2 );
   macro( 2004, 8 ) := ( 101.3, 5022.0, 5022.0, 175.7, 262.6, 264.1, 257.7, 301.6, 283.1 );
   macro( 2004, 9 ) := ( 101.3, 5022.0, 5022.0, 176.1, 262.7, 273.7, 257.7, 301.6, 283.9 );
   macro( 2004, 10 ) := ( 102.4, 5162.0, 5162.0, 176.6, 264.3, 276.0, 257.7, 301.6, 286.5 );
   macro( 2004, 11 ) := ( 102.4, 5162.0, 5162.0, 176.9, 264.6, 278.7, 257.7, 301.6, 287.2 );
   macro( 2004, 12 ) := ( 102.4, 5162.0, 5162.0, 177.9, 264.8, 280.9, 257.7, 301.6, 288.2 );
   
   macro( 2005, 1 ) := ( 103.1, 5170.0, 5170.0, 176.7, 265.7, 283.0, 257.7, 301.6, 291.3 );
   macro( 2005, 2 ) := ( 103.1, 5170.0, 5170.0, 177.4, 265.9, 285.1, 257.7, 301.6, 292.0 );
   macro( 2005, 3 ) := ( 103.1, 5170.0, 5170.0, 178.3, 265.9, 287.2, 257.7, 301.6, 293.5 );
   macro( 2005, 4 ) := ( 103.8, 5253.0, 5253.0, 179.0, 270.4, 289.4, 268.1, 335.7, 294.6 );
   macro( 2005, 5 ) := ( 103.8, 5253.0, 5253.0, 179.4, 270.6, 291.4, 268.1, 335.7, 296.2 );
   macro( 2005, 6 ) := ( 103.8, 5253.0, 5253.0, 179.5, 270.6, 293.5, 268.1, 335.7, 297.3 );
   macro( 2005, 7 ) := ( 104.7, 5217.0, 5217.0, 179.5, 272.2, 295.6, 268.1, 335.7, 299.2 );
   macro( 2005, 8 ) := ( 104.7, 5217.0, 5217.0, 179.8, 272.5, 297.7, 268.1, 335.7, 300.2 );
   macro( 2005, 9 ) := ( 104.7, 5217.0, 5217.0, 180.5, 272.7, 290.2, 268.1, 335.7, 300.9 );
   macro( 2005, 10 ) := ( 105.5, 5262.0, 5262.0, 180.7, 272.8, 292.0, 268.1, 335.7, 303.0 );
   macro( 2005, 11 ) := ( 105.5, 5262.0, 5262.0, 180.9, 273.0, 294.0, 268.1, 335.7, 303.9 );
   macro( 2005, 12 ) := ( 105.5, 5262.0, 5262.0, 181.5, 273.2, 296.1, 268.1, 335.7, 304.1 );
   
   macro( 2006, 1 ) := ( 105.5, 5328.0, 5328.0, 180.7, 273.6, 298.2, 268.1, 335.7, 307.9 );
   macro( 2006, 2 ) := ( 105.5, 5328.0, 5328.0, 181.4, 273.8, 300.1, 268.1, 335.7, 308.3 );
   macro( 2006, 3 ) := ( 105.5, 5328.0, 5328.0, 182.2, 273.8, 302.4, 268.1, 335.7, 308.7 );
   macro( 2006, 4 ) := ( 106.4, 5369.0, 5369.0, 183.2, 278.0, 304.3, 280.6, 354.1, 310.5 );
   macro( 2006, 5 ) := ( 106.4, 5369.0, 5369.0, 184.5, 278.3, 306.3, 280.7, 354.1, 311.3 );
   macro( 2006, 6 ) := ( 106.4, 5369.0, 5369.0, 185.2, 278.5, 308.1, 280.7, 354.1, 311.9 );
   macro( 2006, 7 ) := ( 106.9, 5439.0, 5439.0, 185.2, 280.5, 310.1, 280.7, 354.1, 313.4 );
   macro( 2006, 8 ) := ( 106.9, 5439.0, 5439.0, 186.0, 280.6, 312.5, 280.7, 354.1, 314.3 );
   macro( 2006, 9 ) := ( 106.9, 5439.0, 5439.0, 186.4, 280.6, 327.8, 280.7, 354.1, 315.4 );
   macro( 2006, 10 ) := ( 107.3, 5491.0, 5491.0, 186.7, 280.8, 330.3, 280.7, 354.1, 317.1 );
   macro( 2006, 11 ) := ( 107.3, 5491.0, 5491.0, 187.5, 281.3, 332.8, 280.7, 354.1, 317.6 );
   macro( 2006, 12 ) := ( 107.3, 5491.0, 5491.0, 188.6, 281.5, 347.6, 280.7, 354.1, 318.9 );
   
   macro( 2007, 1 ) := ( 108.1, 5524.0, 5524.0, 187.3, 282.5, 351.7, 280.7, 354.1, 324.1 );
   macro( 2007, 2 ) := ( 108.1, 5524.0, 5524.0, 188.4, 282.6, 365.7, 280.7, 354.1, 324.8 );
   macro( 2007, 3 ) := ( 108.1, 5524.0, 5524.0, 189.5, 282.5, 368.6, 280.7, 354.1, 325.6 );
   macro( 2007, 4 ) := ( 108.0, 5680.0, 5680.0, 190.0, 286.7, 370.9, 292.0, 377.2, 327.4 );
   macro( 2007, 5 ) := ( 108.0, 5680.0, 5680.0, 190.7, 287.2, 374.4, 292.0, 377.2, 328.2 );
   macro( 2007, 6 ) := ( 108.0, 5680.0, 5680.0, 191.4, 287.6, 388.3, 292.0, 377.2, 329.2 );
   macro( 2007, 7 ) := ( 108.8, 5698.0, 5698.0, 190.1, 289.8, 391.3, 292.0, 377.2, 329.6 );
   macro( 2007, 8 ) := ( 108.8, 5698.0, 5698.0, 190.9, 289.6, 406.8, 292.0, 377.2, 330.4 );
   macro( 2007, 9 ) := ( 108.8, 5698.0, 5698.0, 191.6, 289.9, 409.5, 292.0, 377.2, 331.1 );
   macro( 2007, 10 ) := ( 109.5, 5885.0, 5885.0, 192.3, 291.2, 411.3, 292.0, 377.2, 333.5 );
   macro( 2007, 11 ) := ( 109.5, 5885.0, 5885.0, 193.2, 291.7, 413.9, 292.0, 377.2, 334.6 );
   macro( 2007, 12 ) := ( 109.5, 5885.0, 5885.0, 194.4, 291.6, 416.5, 292.0, 377.2, 335.4 );
   
   macro( 2008, 1 ) := ( 110.9, 5980.0, 5980.0, 193.5, 293.1, 406.5, 292.0, 377.2, 339.5 ); 
   macro( 2008, 2 ) := ( 110.9, 5980.0, 5980.0, 195.2, 293.1, 408.9, 292.0, 377.2, 339.7 );
   macro( 2008, 3 ) := ( 110.9, 5980.0, 5980.0, 196.3, 293.1, 398.2, 292.0, 377.2, 340.0 );
   macro( 2008, 4 ) := ( 110.9, 5980.0, 5980.0, 197.5, 297.8, 400.4, 302.6, 401.7, 341.2 );
   macro( 2008, 5 ) := ( 110.9, 5980.0, 5980.0, 199.0, 298.2, 389.2, 302.6, 401.7, 342.1 );
   macro( 2008, 6 ) := ( 110.9, 5980.0, 5980.0,  200.8, 298.5, 391.4, 302.6, 401.7, 343.0 );
   macro( 2008, 7 ) := ( 110.9, 5980.0, 5980.0,  200.4, 299.0, 393.5, 302.6, 401.7, 348.4 );


   
   
   -- from: http://www.nationwide.co.uk/hpi/historical.htm (house price series since 1952)
        
   nw_house_price( 1952 , 4 ) := 100.0;
   nw_house_price( 1953 , 1 ) := 100.0;
   nw_house_price( 1953 , 2 ) := 100.0;
   nw_house_price( 1953 , 3 ) := 99.5;
   nw_house_price( 1953 , 4 ) := 99.0;
   nw_house_price( 1954 , 1 ) := 98.5;
   nw_house_price( 1954 , 2 ) := 99.0;
   nw_house_price( 1954 , 3 ) := 98.5;
   nw_house_price( 1954 , 4 ) := 98.0;
   nw_house_price( 1955 , 1 ) := 100.5;
   nw_house_price( 1955 , 2 ) := 102.5;
   nw_house_price( 1955 , 3 ) := 102.5;
   nw_house_price( 1955 , 4 ) := 102.5;
   nw_house_price( 1956 , 1 ) := 104.4;
   nw_house_price( 1956 , 2 ) := 105.9;
   nw_house_price( 1956 , 3 ) := 105.9;
   nw_house_price( 1956 , 4 ) := 105.9;
   nw_house_price( 1957 , 1 ) := 106.9;
   nw_house_price( 1957 , 2 ) := 106.9;
   nw_house_price( 1957 , 3 ) := 107.4;
   nw_house_price( 1957 , 4 ) := 107.4;
   nw_house_price( 1958 , 1 ) := 108.4;
   nw_house_price( 1958 , 2 ) := 108.4;
   nw_house_price( 1958 , 3 ) := 108.9;
   nw_house_price( 1958 , 4 ) := 109.4;
   nw_house_price( 1959 , 1 ) := 109.9;
   nw_house_price( 1959 , 2 ) := 111.3;
   nw_house_price( 1959 , 3 ) := 112.3;
   nw_house_price( 1959 , 4 ) := 114.8;
   nw_house_price( 1960 , 1 ) := 115.8;
   nw_house_price( 1960 , 2 ) := 118.2;
   nw_house_price( 1960 , 3 ) := 121.7;
   nw_house_price( 1960 , 4 ) := 123.2;
   nw_house_price( 1961 , 1 ) := 127.1;
   nw_house_price( 1961 , 2 ) := 129.1;
   nw_house_price( 1961 , 3 ) := 130.5;
   nw_house_price( 1961 , 4 ) := 134.5;
   nw_house_price( 1962 , 1 ) := 135.0;
   nw_house_price( 1962 , 2 ) := 137.4;
   nw_house_price( 1962 , 3 ) := 139.9;
   nw_house_price( 1962 , 4 ) := 141.4;
   nw_house_price( 1963 , 1 ) := 145.3;
   nw_house_price( 1963 , 2 ) := 149.3;
   nw_house_price( 1963 , 3 ) := 150.7;
   nw_house_price( 1963 , 4 ) := 155.7;
   nw_house_price( 1964 , 1 ) := 158.6;
   nw_house_price( 1964 , 2 ) := 163.5;
   nw_house_price( 1964 , 3 ) := 166.0;
   nw_house_price( 1964 , 4 ) := 168.5;
   nw_house_price( 1965 , 1 ) := 172.9;
   nw_house_price( 1965 , 2 ) := 176.8;
   nw_house_price( 1965 , 3 ) := 178.8;
   nw_house_price( 1965 , 4 ) := 180.8;
   nw_house_price( 1966 , 1 ) := 183.3;
   nw_house_price( 1966 , 2 ) := 188.2;
   nw_house_price( 1966 , 3 ) := 188.2;
   nw_house_price( 1966 , 4 ) := 189.7;
   nw_house_price( 1967 , 1 ) := 192.6;
   nw_house_price( 1967 , 2 ) := 195.6;
   nw_house_price( 1967 , 3 ) := 199.0;
   nw_house_price( 1967 , 4 ) := 203.0;
   nw_house_price( 1968 , 1 ) := 206.4;
   nw_house_price( 1968 , 2 ) := 211.3;
   nw_house_price( 1968 , 3 ) := 214.3;
   nw_house_price( 1968 , 4 ) := 216.3;
   nw_house_price( 1969 , 1 ) := 219.2;
   nw_house_price( 1969 , 2 ) := 222.2;
   nw_house_price( 1969 , 3 ) := 223.6;
   nw_house_price( 1969 , 4 ) := 228.1;
   nw_house_price( 1970 , 1 ) := 231.5;
   nw_house_price( 1970 , 2 ) := 235.5;
   nw_house_price( 1970 , 3 ) := 238.4;
   nw_house_price( 1970 , 4 ) := 242.4;
   nw_house_price( 1971 , 1 ) := 250.7;
   nw_house_price( 1971 , 2 ) := 259.6;
   nw_house_price( 1971 , 3 ) := 277.3;
   nw_house_price( 1971 , 4 ) := 292.6;
   nw_house_price( 1972 , 1 ) := 317.7;
   nw_house_price( 1972 , 2 ) := 346.8;
   nw_house_price( 1972 , 3 ) := 391.1;
   nw_house_price( 1972 , 4 ) := 416.7;
   nw_house_price( 1973 , 1 ) := 444.0;
   nw_house_price( 1973 , 2 ) := 467.1;
   nw_house_price( 1973 , 3 ) := 485.7;
   nw_house_price( 1973 , 4 ) := 516.6;
   nw_house_price( 1974 , 1 ) := 525.1;
   nw_house_price( 1974 , 2 ) := 530.3;
   nw_house_price( 1974 , 3 ) := 536.7;
   nw_house_price( 1974 , 4 ) := 539.9;
   nw_house_price( 1975 , 1 ) := 549.4;
   nw_house_price( 1975 , 2 ) := 567.4;
   nw_house_price( 1975 , 3 ) := 580.6;
   nw_house_price( 1975 , 4 ) := 597.0;
   nw_house_price( 1976 , 1 ) := 609.2;
   nw_house_price( 1976 , 2 ) := 620.9;
   nw_house_price( 1976 , 3 ) := 634.6;
   nw_house_price( 1976 , 4 ) := 645.7;
   nw_house_price( 1977 , 1 ) := 656.3;
   nw_house_price( 1977 , 2 ) := 671.1;
   nw_house_price( 1977 , 3 ) := 686.0;
   nw_house_price( 1977 , 4 ) := 695.5;
   nw_house_price( 1978 , 1 ) := 730.9;
   nw_house_price( 1978 , 2 ) := 766.4;
   nw_house_price( 1978 , 3 ) := 841.6;
   nw_house_price( 1978 , 4 ) := 889.7;
   nw_house_price( 1979 , 1 ) := 941.1;
   nw_house_price( 1979 , 2 ) := 1008.9;
   nw_house_price( 1979 , 3 ) := 1083.5;
   nw_house_price( 1979 , 4 ) := 1161.8;
   nw_house_price( 1980 , 1 ) := 1199.4;
   nw_house_price( 1980 , 2 ) := 1234.8;
   nw_house_price( 1980 , 3 ) := 1249.7;
   nw_house_price( 1980 , 4 ) := 1242.8;
   nw_house_price( 1981 , 1 ) := 1255.1;
   nw_house_price( 1981 , 2 ) := 1274.5;
   nw_house_price( 1981 , 3 ) := 1279.3;
   nw_house_price( 1981 , 4 ) := 1258.7;
   nw_house_price( 1982 , 1 ) := 1278.7;
   nw_house_price( 1982 , 2 ) := 1305.2;
   nw_house_price( 1982 , 3 ) := 1320.6;
   nw_house_price( 1982 , 4 ) := 1352.9;
   nw_house_price( 1983 , 1 ) := 1391.4;
   nw_house_price( 1983 , 2 ) := 1448.4;
   nw_house_price( 1983 , 3 ) := 1490.2;
   nw_house_price( 1983 , 4 ) := 1513.9;
   nw_house_price( 1984 , 1 ) := 1569.5;
   nw_house_price( 1984 , 2 ) := 1630.7;
   nw_house_price( 1984 , 3 ) := 1653.0;
   nw_house_price( 1984 , 4 ) := 1721.2;
   nw_house_price( 1985 , 1 ) := 1755.9;
   nw_house_price( 1985 , 2 ) := 1807.4;
   nw_house_price( 1985 , 3 ) := 1835.3;
   nw_house_price( 1985 , 4 ) := 1874.2;
   nw_house_price( 1986 , 1 ) := 1885.3;
   nw_house_price( 1986 , 2 ) := 1957.7;
   nw_house_price( 1986 , 3 ) := 2023.1;
   nw_house_price( 1986 , 4 ) := 2094.1;
   nw_house_price( 1987 , 1 ) := 2162.2;
   nw_house_price( 1987 , 2 ) := 2273.5;
   nw_house_price( 1987 , 3 ) := 2350.1;
   nw_house_price( 1987 , 4 ) := 2345.9;
   nw_house_price( 1988 , 1 ) := 2384.8;
   nw_house_price( 1988 , 2 ) := 2588.0;
   nw_house_price( 1988 , 3 ) := 2874.6;
   nw_house_price( 1988 , 4 ) := 3027.7;
   nw_house_price( 1989 , 1 ) := 3148.7;
   nw_house_price( 1989 , 2 ) := 3292.0;
   nw_house_price( 1989 , 3 ) := 3320.5;
   nw_house_price( 1989 , 4 ) := 3252.4;
   nw_house_price( 1990 , 1 ) := 3151.5;
   nw_house_price( 1990 , 2 ) := 3119.5;
   nw_house_price( 1990 , 3 ) := 3027.7;
   nw_house_price( 1990 , 4 ) := 2904.6;
   nw_house_price( 1991 , 1 ) := 2885.0;
   nw_house_price( 1991 , 2 ) := 2931.0;
   nw_house_price( 1991 , 3 ) := 2903.8;
   nw_house_price( 1991 , 4 ) := 2836.7;
   nw_house_price( 1992 , 1 ) := 2760.1;
   nw_house_price( 1992 , 2 ) := 2785.3;
   nw_house_price( 1992 , 3 ) := 2763.1;
   nw_house_price( 1992 , 4 ) := 2653.4;
   nw_house_price( 1993 , 1 ) := 2651.3;
   nw_house_price( 1993 , 2 ) := 2745.9;
   nw_house_price( 1993 , 3 ) := 2736.8;
   nw_house_price( 1993 , 4 ) := 2700.0;
   nw_house_price( 1994 , 1 ) := 2714.6;
   nw_house_price( 1994 , 2 ) := 2716.5;
   nw_house_price( 1994 , 3 ) := 2736.0;
   nw_house_price( 1994 , 4 ) := 2756.3;
   nw_house_price( 1995 , 1 ) := 2701.8;
   nw_house_price( 1995 , 2 ) := 2730.8;
   nw_house_price( 1995 , 3 ) := 2715.0;
   nw_house_price( 1995 , 4 ) := 2693.7;
   nw_house_price( 1996 , 1 ) := 2716.8;
   nw_house_price( 1996 , 2 ) := 2804.8;
   nw_house_price( 1996 , 3 ) := 2856.4;
   nw_house_price( 1996 , 4 ) := 2917.9;
   nw_house_price( 1997 , 1 ) := 2951.8;
   nw_house_price( 1997 , 2 ) := 3088.9;
   nw_house_price( 1997 , 3 ) := 3213.2;
   nw_house_price( 1997 , 4 ) := 3270.1;
   nw_house_price( 1998 , 1 ) := 3326.9;
   nw_house_price( 1998 , 2 ) := 3449.5;
   nw_house_price( 1998 , 3 ) := 3510.1;
   nw_house_price( 1998 , 4 ) := 3507.2;
   nw_house_price( 1999 , 1 ) := 3568.8;
   nw_house_price( 1999 , 2 ) := 3702.8;
   nw_house_price( 1999 , 3 ) := 3827.2;
   nw_house_price( 1999 , 4 ) := 3947.5;
   nw_house_price( 2000 , 1 ) := 4109.4;
   nw_house_price( 2000 , 2 ) := 4294.7;
   nw_house_price( 2000 , 3 ) := 4280.6;
   nw_house_price( 2000 , 4 ) := 4317.3;
   nw_house_price( 2001 , 1 ) := 4441.5;
   nw_house_price( 2001 , 2 ) := 4635.1;
   nw_house_price( 2001 , 3 ) := 4815.5;
   nw_house_price( 2001 , 4 ) := 4894.0;
   nw_house_price( 2002 , 1 ) := 5043.3;
   nw_house_price( 2002 , 2 ) := 5474.1;
   nw_house_price( 2002 , 3 ) := 5861.7;
   nw_house_price( 2002 , 4 ) := 6132.0;
   nw_house_price( 2003 , 1 ) := 6343.4;
   nw_house_price( 2003 , 2 ) := 6631.4;
   nw_house_price( 2003 , 3 ) := 6863.0;
   nw_house_price( 2003 , 4 ) := 7082.0;
   nw_house_price( 2004 , 1 ) := 7416.4;
   nw_house_price( 2004 , 2 ) := 7852.1;
   nw_house_price( 2004 , 3 ) := 8117.6;
   nw_house_price( 2004 , 4 ) := 8063.7;
   nw_house_price( 2005 , 1 ) := 8081.0;
   nw_house_price( 2005 , 2 ) := 8329.8;
   nw_house_price( 2005 , 3 ) := 8336.8;
   nw_house_price( 2005 , 4 ) := 8324.1;
   nw_house_price( 2006 , 1 ) := 8479.2;
   nw_house_price( 2006 , 2 ) := 8728.6;
   nw_house_price( 2006 , 3 ) := 8909.7;
   nw_house_price( 2006 , 4 ) := 9100.4;
   nw_house_price( 2007 , 1 ) := 9284.9;
   nw_house_price( 2007 , 2 ) := 9615.8;
   nw_house_price( 2007 , 3 ) := 9738.6;
   nw_house_price( 2007 , 4 ) := 9729.5;
   nw_house_price( 2008 , 1 ) := 9486.4;
   nw_house_price( 2008 , 2 ) := 9230.0;
   -- not from data
   nw_house_price( 2008 , 3 ) := 9230.0;

end Model.Uprate;
