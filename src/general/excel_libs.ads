-- 
--  Implementation of the Excel financial functions pmt, fv, ppmt, ipmt.
--
--  Adapted from the Java POI Version org.apache.poi.ss.formula.functions.Finance
-- 
package Excel_Libs is
   
   
   --  Emulates ExcelCalc's PMT(interest_rate, number_payments, PV, FV, Type)
   --  function, which calculates the payments for a loan or the future value of an investment
   --  
   --  @param r
   --             - periodic interest rate represented as a decimal.
   --  @param nper
   --             - number of total payments  periods.
   --  @param pv
   --             - present value -- borrowed or invested principal.
   --  @param fv
   --             - future value of loan or annuity.
   --  @param type
   --             - when payment is made: beginning of period is 1; end, 0.
   --  @return <code>double<code> representing periodic payment amount.
   -- 
   -- see http:arachnoid.comlutuspfinance.html
   function PMT(
      r     : Long_Float;
      nper  : Integer;
      pv    : Long_Float;
      fv    : Long_Float := 1.0;
      itype : Integer := 1 ) return Long_Float;
   
   --
   -- Emulates Excel/Calc's FV(interest_rate, number_payments, payment, PV,
   -- Type) function, which calculates future value or principal at period N.
   -- 
   -- @param r
   --            - periodic interest rate represented as a decimal.
   -- @param nper
   --            - number of total payments / periods.
   -- @param pmt
   --            - periodic payment amount.
   -- @param pv
   --            - present value -- borrowed or invested principal.
   -- @param type
   --            - when payment is made: beginning of period is 1; end, 0.
   -- @return <code>double</code> representing future principal value.
   --
   -- http://en.wikipedia.org/wiki/Future_value
   function FV( 
      r      : Long_Float;
      nper   : Integer;
      pmt    : Long_Float;
      pv     : Long_Float;
      itype  : Integer := 1 ) return Long_Float;
   
   --
   -- Emulates Excel/Calc's IPMT(interest_rate, period, number_payments, PV,
   -- FV, Type) function, which calculates the portion of the payment at a
   -- given period that is the interest on previous balance.
   -- 
   -- @param r
   --            - periodic interest rate represented as a decimal.
   -- @param per
   --            - period (payment number) to check value at.
   -- @param nper
   --            - number of total payments / periods.
   -- @param pv
   --            - present value -- borrowed or invested principal.
   -- @param fv
   --            - future value of loan or annuity.
   -- @param type
   --            - when payment is made: beginning of period is 1; end, 0.
   -- @return <code>double</code> representing interest portion of payment.
   -- 
   -- @see #pmt(double, int, double, double, int)
   -- @see #fv(double, int, double, double, int)
   --
   -- http://doc.optadata.com/en/dokumentation/application/expression/functions/financial.html
   function IPMT(
       r     : Long_Float;
       per   : Integer;
       nper  : Integer; 
       pv    : Long_Float;
       ffv   : Long_Float := 0.0; 
       itype : Integer := 0 ) return Long_Float;
    
   --
   -- Emulates Excel/Calc's PPMT(interest_rate, period, number_payments, PV,
   -- FV, Type) function, which calculates the portion of the payment at a
   -- given period that will apply to principal.
   -- 
   -- @param r
   --            - periodic interest rate represented as a decimal.
   -- @param per
   --            - period (payment number) to check value at.
   -- @param nper
   --            - number of total payments / periods.
   -- @param pv
   --            - present value -- borrowed or invested principal.
   -- @param fv
   --            - future value of loan or annuity.
   -- @param type
   --            - when payment is made: beginning of period is 1; end, 0.
   -- @return <code>double</code> representing principal portion of payment.
   -- 
   -- @see #pmt(double, int, double, double, int)
   -- @see #ipmt(double, int, int, double, double, int)
   --
   function PPMT(       
      r     : Long_Float;
      per   : Integer;
      nper  : Integer; 
      pv    : Long_Float;
      ffv   : Long_Float := 0.0; 
      itype : Integer := 0
   ) return Long_Float;
   
end Excel_Libs;
