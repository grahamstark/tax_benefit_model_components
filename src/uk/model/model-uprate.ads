--
--  $Author: graham_s $
--  $Date: 2008-12-19 20:04:12 +0000 (Fri, 19 Dec 2008) $
--  $Revision: 6527 $
--
pragma License( Modified_GPL );

with Ada.Calendar;
with Data_Constants;

package Model.Uprate is

   use Ada.Calendar;

-- to autogenerate this file with new data
--
-- download  
--    'EMP' Employment and Earnings, 
--    'MM23'(Consumer Price Indices), 
--    'UKEA' (United Kingdom Economic Accounts)
-- from http://www.statistics.gov.uk/statbase/tsdlistfiles.asp
-- (The text versions)
-- 
-- find the file ../scripts/macrotests.rb
-- run and capture the bottom part of the screen dump.
-- Paste this in below

  -- Wages = 'lnnk'; ## Unit Wage Costs : whole economy SA: Index 2002=100: UK royj';
  -- OtherIncome = 'ihxs' ## Gross national income per head at current market prices: SA 
  -- Capital = 'ihxs'  ## Gross national income per head at current market prices: SA
  -- StateBenefits = 'cbzw'; ## All items exc mortgage int payments and indirect taxes (RPIY) (Jan 1987=100)
  -- Rent = 'dobp' ## RPI: housing: rent (Jan 1987=100)   
  -- Mortgages = 'dobq' ## RPI: housing: mortgage interest payments (Jan 1987=100) 
  -- CT = 'dobr' ## RPI: housing: council tax & rates (Jan 1987=100)
  -- Charges = 'dobs' ##RPI: housing: water & other charges (Jan 1987=100)  
  -- Repairs = 'dobt' ## RPI: housing: repairs & maintenance charges (Jan 1987=100)
  
  FIRST_AVAILABLE_UPRATE_YEAR : constant := 2002;
  LAST_AVAILABLE_UPRATE_YEAR : constant := 2008;
  
  subtype Uprate_Years is Positive range FIRST_AVAILABLE_UPRATE_YEAR .. LAST_AVAILABLE_UPRATE_YEAR;

   subtype NW_House_Price_Years is integer range 1952 .. 2008;
   
   subtype Quarter is integer range 1..4;
   
   type NW_House_Price_Index is array( NW_House_Price_Years, Quarter ) of Rate;
   
   
   UPRATE_TARGET_MONTH : constant Month_Number  := 7;
   UPRATE_TARGET_YEAR  : constant Uprate_Years  := 2008;
   UPRATE_TARGET_DATE  : constant Time := Time_Of( Year => UPRATE_TARGET_YEAR, Month =>UPRATE_TARGET_MONTH, Day => 1 );
   
   --
   --  FIXME : keep updated. Last update 21/8/08
   LAST_NW_HOUSE_PRICE_YEAR : constant NW_House_Price_Years := 2008;
   LAST_NW_HOUSE_PRICE_QUARTER : constant Quarter := 3;
   
   --
   --
   --
   type UprateTypes is ( 
      wages, 
      other_income, 
      capital, 
      stateBenefits, -- rpi xmip  CBZW
      rent,          -- 
      mortgages, 
      localTaxes, 
      charges, 
      repairs );
   type Macro_Array is array (UprateTypes) of Rate;
   
   --
   --  price change between the latest date available and the given date,
   --  for the given type. Only Y/M are used in Time.
   --
   function Price_Change( 
      from_date : Time; 
      utype : UprateTypes;
      to_date : Time := UPRATE_TARGET_DATE ) return Rate;
   --
   --  ditto for Nationwide House price index
   --
   function House_Price_Change( year : NW_House_Price_Years; month :  Month_Number ) return Rate;
   
   function Changes ( from_date : Time; to_date : Time := UPRATE_TARGET_DATE ) return Macro_Array;

end Model.Uprate;
