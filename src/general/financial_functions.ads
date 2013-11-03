--
-- copyrigh(c) 2007 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////
-- $Revision: 11819 $
-- $Author: graham_s $
-- $Date: 2011-06-01 11:27:12 +0100 (Wed, 01 Jun 2011) $
--
--
--
-- Some very simple finance calculation things
-- 
pragma License( Modified_GPL );

with Ada.Containers.Ordered_maps;

generic 
   --
   -- This is the floating type we use throughout. 
   --
   type Rate is digits<>;
   
   type Amount is digits<>;
   
                 
package Financial_Functions is


   type Payment_Stream is tagged private;
   
   procedure Add_To_Payment_Stream( stream : in out Payment_Stream; period : Positive; payment : Amount );

   type Loan_Output is record
      monthly_payment : Amount := 0.0;
      total_interest  : Amount := 0.0;
      total_payments  : Amount := 0.0;
   end record;
   
   type Loan_Input is record
      principal       : Amount := 0.0;
      interest_rate   : Rate  := 0.0;
      num_payments    : Positive := 1;
   end record;
   
   function Calculate_Loan( loan : Loan_Input ) return Loan_Output;
   
   function Monthly_Equivalent_Of_Annual_Interest( rate_as_annual_percentage : Rate ) return Rate;
   
   --
   -- PV of the stream
   --
   function Net_Present_Value( stream : Payment_Stream; r : Rate ) return Amount;
   
   function Net_Present_Value( payment : Amount; num_times : Positive; r : Rate ) return Amount;
   
   --
   -- return a number like 0.052 for 5.2%
   --
   function Find_Apr( stream : Payment_Stream ) return Rate;
   
   Financial_Exception : exception;
   
   function To_String( l : Loan_Output ) return String;
   
   
private

   package Payment_Stream_Package is new Ada.Containers.Ordered_Maps( 
      Element_Type => Amount, 
      Key_Type => Positive );
   
   type Payment_Stream is new Payment_Stream_Package.Map with null record;
      
end Financial_Functions;

