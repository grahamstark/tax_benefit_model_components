--
--  $Author: graham_s $
--  $Date: 2008-08-20 08:18:39 +0100 (Wed, 20 Aug 2008) $
--  $Revision: 5684 $
--
with raw_frs; use raw_frs;

package raw_frs_printer is

        function To_String( hh : Raw_Household ) return String;
        function To_String (v : Job_Rec) return String;
        function To_String (v : Benunit_Rec) return String;
        --  function To_String( hprice : House_Price_Estimates_Rec ) return String;
        --  function To_String( takeup : Takeup_Estimates_Rec ) return String;

end raw_frs_printer;

