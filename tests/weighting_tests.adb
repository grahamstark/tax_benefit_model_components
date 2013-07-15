--
--  $Author: graham_s $
--  $Date: 2011-04-06 15:56:14 +0100 (Wed, 06 Apr 2011) $
--  $Revision: 11372 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;   
with Ada.Direct_IO;
with Ada.Command_Line;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Generic_Real_Arrays;
with Ada.Strings.Unbounded;
with Ada.Calendar;


with Maths_Functions;

with T_Utils;
with Text_Utils;
with Base_Model_Types;
with GNAT.Regpat;
with Ada.Text_IO;
with Maths_Functions.Weights_Generator;
with Text_Utils;
with Weighting_Commons;

package body Weighting_Tests is
   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   use Ada.Text_IO;
   use Base_Model_Types;
   use Text_Utils;
   
   package NMath is new Ada.Numerics.Generic_Elementary_Functions( Amount );
   use NMath;
   package MMath is new Maths_Functions( Amount );
   use MMath;   
   package WG is new MMath.Weights_Generator(    
      Num_Constraints => 4,
      Num_Observations => 20 );
   
   obs : constant WG.Dataset := (      
   ( 1.0, 1.0, 0.0, 0.0 ),
   ( 0.0, 1.0, 0.0, 0.0 ),
   ( 1.0, 0.0, 2.0, 0.0 ),
   ( 0.0, 0.0, 6.0, 1.0 ),
   ( 1.0, 0.0, 4.0, 1.0 ),
   ( 1.0, 1.0, 0.0, 0.0 ),
   ( 1.0, 0.0, 5.0, 0.0 ),
   ( 0.0, 0.0, 6.0, 1.0 ),
   ( 0.0, 1.0, 0.0, 0.0 ),
   ( 0.0, 0.0, 3.0, 1.0 ),
   ( 1.0, 0.0, 2.0, 0.0 ),
   ( 1.0, 1.0, 0.0, 1.0 ),
   ( 1.0, 0.0, 3.0, 1.0 ),
   ( 1.0, 0.0, 4.0, 0.0 ),
   ( 0.0, 0.0, 5.0, 0.0 ),
   ( 0.0, 1.0, 0.0, 1.0 ),
   ( 1.0, 0.0, 2.0, 1.0 ),
   ( 0.0, 0.0, 6.0, 0.0 ),
   ( 1.0, 0.0, 4.0, 1.0 ),
   ( 0.0, 1.0, 0.0, 0.0 ));

   initial_weights : constant WG.Col_Vector := ( 
      3.0,
      3.0,
      5.0,
      4.0,
      2.0,
      5.0,
      5.0,
      4.0,
      3.0,
      3.0,
      5.0,
      4.0,
      4.0,
      3.0,
      5.0,
      3.0,
      4.0,
      5.0,
      4.0,
      3.0 );
      
   actual_final_weights : constant WG.Col_Vector := ( 
      2.753,
      2.109,
      5.945,
      4.005,
      2.484,
      4.589,
      5.752,
      4.005,
      2.109,
      3.120,
      5.945,
      3.985,
      5.019,
      3.490,
      4.678,
      2.345,
      5.070,
      4.614,
      4.967,
      2.109 );

   target_populations : constant WG.Row_Vector := ( 50.0, 20.0, 230.0, 35.0 );
   
   
   procedure Set_Up (T : in out Test_Case) is
   begin
      null;
   end Set_Up;
   
      
   procedure Shut_Down( T : in out Test_Case) is
   begin
      null;
   end Shut_Down;

   procedure Test_Calmar_Iterative( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- reproduces the basic test case in Creedy NEW ZEALAND TREASURY WORKING PAPER 03/17
      -- using the package
      -- 
      use type Weighting_Commons.Distance_Function_Type;
      type CA is array( 1 .. 9 ) of WG.Col_Vector;
      type CB is array( 1 .. 9 ) of WG.Row_Vector;
      weights        : CA := ( others => ( others => 0.0 ));
      totals         : CB := ( others=>( others=>0.0 ));
      r_u            : Amount;
      r_l            : Amount;
      tol_x          : constant Amount := 0.001;
      tol_f          : constant Amount := 0.001;
      max_iterations : constant := 100;
      iterations     : Natural;
      error          : Eval_Error_Type;
      measure, n     : Natural := 1;
    begin
       for it in Weighting_Commons.Distance_Function_Type loop
          n := 1;          
          if( it = Weighting_Commons.constrained_chi_square ) or it = Weighting_Commons.d_and_s_constrained then
             n := 3;
          end if;
          for i in 1 .. n loop
             if( it = Weighting_Commons.constrained_chi_square )then
                if( i = 1 ) then
                   r_u := 3.0;
                   r_l := 0.2;
                elsif( i = 2 )then
                   r_u := 1.3;
                   r_l := 0.8;
                else
                   r_u := 1.25;
                   r_l := 0.8;
                end if;
             elsif( it = Weighting_Commons.d_and_s_constrained )then
                if( i = 1 ) then
                   r_u := 4.0;
                   r_l := 0.2;
                elsif( i = 2 )then
                   r_u := 3.0;
                   r_l := 0.2;
                else
                   r_u := 2.0;
                   r_l := 0.3;
                end if;
             end if;
             Put_Line( "ON MEASURE " & it'Img & " " & measure'Img );
             WG.Do_Reweighting(
               obs, 
               it,
               initial_weights,
               target_populations,
               tol_x,
               tol_f,
               max_iterations,
               r_u,
               r_l,
               weights( measure ),
               iterations,
               error );   
            Put_Line( "CALLED FOM WG :: " & it'Img & " measure = " & measure'Img );
            Put_Line( "ERROR " & error'Img & " iterations " & iterations'Img );
            measure := measure + 1;
         end loop;
      end loop;
      Put_Line( "N,BASE WEIGHT,CHI,D&S TYPE A,D&S TYPE B,CHI (3.0/0.2),CHI (1.3/0.8),CHI (1.25/0.8),D&S CONSTRAINED (4/0.2),D&S CONSTRAINED (3/0.2),D&S CONSTRAINED (2/0.2)" );
      for row in WG.Row_Range loop
         Put( row'Img & "," & initial_weights( row )'Img & ",");
         for measure in 1..9 loop
            Put( weights( measure )( row )'Img & "," );
         end loop;
         New_Line;
      end loop;
      for row in WG.Row_Range loop
         for measure in 1..9 loop
            for col in 1 ..4 loop
               totals( measure )( col ) := totals( measure )( col ) + ( obs( row, col ) * weights( measure )( row ));
            end loop;
         end loop;
      end loop;
      Put_Line( "TOTALS" );
      for col in WG.Col_Range loop
         Put( col'Img & ",,");
         for measure in 1..9 loop
            Put( totals( measure )( col )'Img & "," );
         end loop;
         New_Line;
      end loop;
      Put_Line( "BASIC WEIGHTS FROM SIMPLE CHI-SQUARE" );
      weights( 1 ) := WG.Do_Basic_Reweighting( obs, initial_weights, target_populations );
      for row in WG.Row_Range loop
         Put_Line( row'Img & "," & weights( 1 )( row )'Img  );
      end loop;
      
      
   end Test_Calmar_Iterative; 
   
   procedure M_Test( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      use MMath.Matrix_Functions;
      
      b  : constant Vector( 1 .. 2 ) := ( 5.0, 9.0 ); 
      aa : constant Matrix( 1 .. 1, 1 .. 3 ) := ( 1=> ( 1.0, 2.0, 3.0 )); 
      a  : constant Matrix( 1 .. 3, 1 .. 2 ) := (
         ( 1.0, 3.0 ), -- row 1
         ( 2.0, 8.0 ), -- row 2
         ( 4.0, 0.0 )); -- row 3
      c : constant Matrix := Transpose( a );
      d : Vector( 1 .. 3 );
      e : Matrix( 1 .. 3, 1 .. 1 );
   begin
      d := a * b;
      Put_Line( "A" );
      Put_Line( To_String( a ));
      Put_Line( "B" );
      Put_Line( To_String( b ));
      Put_Line( "D" );
      Put_Line( To_String( d ));
   end M_Test;
      --
    
   --------------------
   -- Register_Tests --
   --------------------
   procedure Register_Tests( t : in out Test_Case ) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Calmar_Iterative'Access, "test calmar 2" );
      Register_Routine (T, M_Test'Access, "M_Test" );
   end Register_Tests;

   ----------
   -- Name --
   ----------
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format("WSC Model calculations unit tests.");
   end Name;

end Weighting_Tests;
