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

with Optimiser;
with Ada.Exceptions;
with Text_IO;
with Excel_Libs;

package body Financial_Functions is
   
   function "*"( a : Amount; r : Rate ) return Amount is
   begin
      return Amount( r ) * a;
   end "*";
   
   function "/"( a : Amount; r : Rate ) return Amount is
   begin
      return a / Amount( r );
   end "/";

   function "*"( a : Rate; r : Amount ) return Amount is
   begin
      return Amount( r ) * a;
   end "*";
   
   function "/"( a : Rate; r : Amount ) return Amount is
   begin
      return a / Amount( r );
   end "/";
   
   procedure Pay_Down_Loan( capital : in out Amount; interest_rate : Rate; payment : Amount; other_charges : Amount := 0.0 ) is
      interest : constant Amount := capital * interest_rate;
      
   begin
      capital := capital - ( payment - interest - other_charges ); 
   end Pay_Down_Loan;
   
   
   function Net_Present_Value( payment : Amount; num_times : Positive; r : Rate ) return Amount is
      u : Rate := 1.0 / ( 1.0 + r );
   begin
      return payment * Amount(( u - u**(num_times+1))/( 1.0 - u ));
   end Net_Present_Value;
      
   function Monthly_Equivalent_Of_Annual_Interest( rate_as_annual_percentage : Rate ) return Rate is
   begin
      return rate_as_annual_percentage / 1_200.0;
   end monthly_equivalent_of_annual_interest;
   
   function Calculate_Loan( loan : Loan_Input ) return Loan_Output is
      outp : Loan_Output;
      x    : Rate := (1.0 + loan.interest_rate) ** loan.num_payments;
   begin
      outp.monthly_payment := Amount((loan.principal * Amount(x) * Amount(loan.interest_rate) ) / Amount(x-1.0));
      outp.total_payments  := outp.monthly_payment * Amount( loan.num_payments );
      outp.total_interest  := outp.total_payments - loan.principal;
      return outp;
   end Calculate_Loan;
   
   procedure Add_To_Payment_Stream( stream : in out Payment_Stream; period : Positive; payment : Amount ) is
   use Payment_Stream_Package;
      v : Amount := payment;
   begin
      if( Contains( Map(stream), period )) then
         v := v + Element( Map(stream), period );
         Replace( Map(stream), period, v );
      else
         Insert( Map(stream), period, v );   
      end if;
   end Add_To_Payment_Stream;
   
   function Net_Present_Value( stream : Payment_Stream; r : Rate ) return Amount is
   use Payment_Stream_Package;
      npv : Amount := 0.0;
      
      procedure accumulate( pos : Cursor ) is 
         x : constant Amount := Element( pos );
         p : constant Positive := Key( pos );
         d : constant Amount := Amount((1.0 + r) ** (-1*p));
      begin
         npv := npv + (x * d);
      end Accumulate;   
      
   begin
      iterate( stream, Accumulate'Access );
      return npv;
   end Net_Present_Value;
   
   function Abs_Present_Value( stream : Payment_Stream; r : Rate ) return Rate is
   begin
      return abs( Rate(Net_Present_Value( stream, r )));
   end Abs_Present_Value;
      
   package Apr_Finder is new Optimiser(
      MAX_ITERATIONS => 200,
      Tolerance => 0.0000001,
      Increment => 0.000001,
      Start     => -0.5,
      Stop      => 1.0,
      Real      => Rate,
      Control_Rec => Payment_Stream,
      Minimand => Abs_Present_Value );

   function Find_Apr( stream : Payment_Stream ) return Rate is
   use Apr_Finder;
   use Ada.Exceptions;
      err : Error_Conditions := NoError;
      x : Rate := 0.0;
      y : Rate := 0.0;
   begin
      Apr_Finder.optimise( stream, x, y, err ); 
      if( err /= NoError ) then
         Raise_Exception( Financial_Exception'Identity, 
               "APR Finder Failed " & err'Img );
      end if;
      if( abs(y) > 0.01 ) then
         Raise_Exception( Financial_Exception'Identity, 
               "No Root found " & y'Img );      
      end if;
      return x;
   end Find_Apr;
  
   function To_String( l : Loan_Output ) return String is
   begin
      return " monthly_payment " &  l.monthly_payment'Img &
             " total_interest " &  l.total_interest'Img &
             " total_payments " &  l.total_payments'Img;
   end To_String;
   
   procedure Pay_Down_Loan(
      loan            : in out Amount;
      interest_rate   : Rate;
      num_periods     : in out Natural;
      total_payment   : out Amount;
      capital_payment : out Amount ) is
   begin
      total_payment := -Amount( Excel_Libs.PMT(
         Long_Float( interest_rate ),
         num_periods,
         Long_Float( loan )));
      capital_payment := - Amount( Excel_Libs.PPMT(
         Long_Float( interest_rate ),
         1,
         num_periods,
         Long_Float( loan )));            
      loan := Amount'Max( 0.0, loan-capital_payment );
      num_periods := num_periods - 1;
   end Pay_Down_Loan;
   
end Financial_Functions;
