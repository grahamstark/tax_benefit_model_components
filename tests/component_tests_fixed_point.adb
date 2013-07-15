--
--  $Author: graham_s $
--  $Date: 2007-12-14 15:21:59 +0000 (Fri, 14 Dec 2007) $
--  $Revision: 4444 $
--
with AUnit.Test_Cases.Registration; 
with AUnit.Assertions;              
with Text_IO;                       
with Ada.Text_IO;
with Piecewise_Linear_Generator;
with Ada.Containers.Vectors;
with Ada.Exceptions;
--  with User_IO;
package body component_tests is

   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   use Text_IO;    
   use Ada.Exceptions;
   
   type Amount is delta 0.0000001 digits 18;
   -- type Control_Index is range 1 .. 10;
   type Control_Record is record
      hhref : integer;
      which_bu : integer;
      which_person : integer;
   end record;
   
   type Details_Rec is record
      something : integer;
      something_else : Amount;
   end record;
   
   function Inspect_One( x, y : Amount; ctl  : Control_Record ) return Details_Rec is
      det  : Details_Rec;
   begin
      return det;   
   end Inspect_One;
   
   function Calculate_One( x   : Amount; ctl : Control_Record ) return Amount is
      y   : Amount;
   begin
      if( x < 2_000.0 ) then
         y := 2000.0;
      elsif( x < 5_000.0 ) then
         y := (x * 0.8) + 1_000.0;
      elsif( x < 20_000.0 ) then
         y := x * 0.6 + 1_500.0;
      elsif( x < 25_000.0 ) then
         y := x * 0.4 + 2_500.0;
      elsif( x < 28_000.0 ) then
         y := x * 0.35 + 2_500.0;
      else
         y :=  12300.0 + ((x-28_000.0) * 0.32) + 2_500.0;
      end if;
      return y;
   end Calculate_One;
   
 
   package pwlc1 is new Piecewise_Linear_Generator( 
      Amount => Amount,
      Rate => Long_Float,
      Control_Record => Control_Record,
      Start => 0.0,
      Stop => 45_000.0,
      Details => Details_Rec,
      MAX_DEPTH => 500,
      increment_multiple => 1_000.0,
      Calculate_One_Position => Calculate_One,
      Run_Inspector => Inspect_One ); 
      
   procedure test_generator_1( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
      procedure print( pos : pwlc1.points_list.Cursor ) is 
         p : pwlc1.point;
      begin
         p := pwlc1.points_list.element( pos );
         text_io.put( pwlc1.to_String( p )); text_io.new_line;
      end print;

   
      points   : pwlc1.points_list.Vector;
      details  : pwlc1.Details_List.Vector;
      control : constant Control_Record :=  ( hhref => 20, which_bu => 10, which_person=>1 );
   begin
      pwlc1.generate( points, control );
      pwlc1.points_list.iterate( points, print'Access );
   exception 
      when Error : others =>
         assert ( false, "test_generator_1: exception thrown " & Exception_Information(Error) );
   end test_generator_1;
   
   --------------------
   -- Register_Tests --
   --------------------
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
          Register_Routine (T, test_generator_1'Access, "Test Generator");
          null;
   end Register_Tests;
   
   procedure Set_Up (T : in out Test_Case) is
   begin
      Null;
   end Set_Up;
   
   procedure Shut_Down(T : in out Test_Case) is
   begin
      Null;
   end Shut_Down;

   
   ----------
   -- Name --
   ----------
   
   function Name ( T : Test_Case ) return String_Access is
   begin
          return new String'("Components Tests.");
   end Name;

end component_tests;
