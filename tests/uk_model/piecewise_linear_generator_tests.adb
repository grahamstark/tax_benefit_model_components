with AUnit.Assertions;   
with Base_Model_Types;
with Ada.Exceptions;           
with Ada.Text_IO;
with Tax_Utils;
with Piecewise_Linear_Generator;

package body Piecewise_Linear_Generator_Tests is
  
   use AUnit.Assertions;   
   use Ada.Exceptions;           
   use Ada.Text_IO;
   use Base_Model_Types;      
   use AUnit.Test_Cases.Registration;
   use AUnit.Test_Cases;

   type Person is record
      wage : Amount;
      age  : Age_Range;
   end record;
   
   package TUs is new Tax_Utils( Rate_Type => Rate, Amount_Type => Amount ); 

   type Net_Type is ( net_income, total_taxes, benefits_only );

   type Parameters is record
      ratebands    : TUs.Rates_and_Bands;
      it_allow     : Amount := 500.0;
      benefit1     : Amount := 150.0;
      benefit2     : Amount := 60.0;
      ben2_l_limit : Amount := 200.03;
      ben2_u_limit : Amount := 300.20;
   end record;
   
   type A_Array is array( 1 .. 2 ) of Amount;
   
   type Results is record
      tax : Amount := 0.0;
      benefit : A_Array;
      net_income : Amount := 0.0;
      mr : Rate := 0.0;
   end record;
   
   type Details is record
      res : Results;   
   end record;
   
   type Control_Record is record
      pers  : Person;
      pars  : Parameters;
      net_t : Net_Type;
   end record;
   
   function Calculate_Tax( 
      gross : Amount; 
      pars  : Parameters ) return Amount is
      net : Amount := Amount'Max( 0.0, gross - pars.it_allow );
      due : Amount := TUs.Calc_Tax_Due( pars.ratebands, net ).Due;
   begin
      return due;
   end Calculate_Tax;
      
   function Calculate_Benefit_0( gross : Amount; pars : Parameters ) return Amount is
      b : Amount := Amount'Max( 0.0, pars.benefit1 - gross ); 
   begin
      return b;
   end  Calculate_Benefit_0;
   
   function Calculate_Benefit_1( gross : Amount; pars : Parameters ) return Amount is
      b : Amount := ( if gross >= pars.ben2_l_limit then pars.benefit2 else 0.0 );
   begin
      if( gross > pars.ben2_u_limit )then
         b := b - 30.0;
      end if;
      return b;
   end  Calculate_Benefit_1;
   
   function Calculate_One_Position( 
      x        : Amount; 
      controls : Control_Record ) return Amount is
      r : Results;
      pers : Person := controls.pers;
   begin
      pers.wage := x;      
      r.tax :=Calculate_Tax( pers.wage, controls.pars );
      r.benefit(1) := Calculate_Benefit_0( pers.wage - r.tax, controls.pars );
      r.benefit(2) := Calculate_Benefit_1( pers.wage, controls.pars );
      r.net_income := pers.wage - r.tax + r.benefit(1) + r.benefit(2);
      case controls.net_t is
         when net_income => 
            return r.net_income;
         when total_taxes =>
            return r.tax;
         when benefits_only =>
            return r.benefit(1) + r.benefit(2);
         end case;
   end Calculate_One_Position;
   
   function Run_Inspector( 
      x, y     : Amount;
      controls : Control_Record )  return Details is
      d : Details;
   begin
      return d;   
   end Run_Inspector;
   
   package PLG is new Piecewise_Linear_Generator(
      Rate                   => Amount,
      TOLERANCE              => 0.0001,
      INCREMENT              => 0.0001,
      MAX_DEPTH              => 500,
      Control_Record         => Control_Record,
      Details                => Details,
      Calculate_One_Position => Calculate_One_Position,
      Run_Inspector          => Run_Inspector );
   
   procedure Test_BCs( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      plist : PLG.Points_List;
      controls : Control_Record;
      i : Positive := 1;
      type V8 is array( 1 .. 8 ) of Amount;
      rate : V8 := ( 0.1, 0.25, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2 );
      band : V8 := ( 2_500.0, 4_000.0, 5_000.0, 8_000.0, 9_000.0, 10_000.0, 12_000.0, 9_999_999_999_999_999_999.99 );
   begin
      controls.net_t := net_income;
      for i in 1 .. 8 loop
         declare
            rb : TUs.Rate_And_Band;
         begin
            rb.rate := rate( i );
            rb.band := band( i );
            controls.pars.ratebands.Set_Rate_And_Band( rb, i );  
         end;
      end loop;
      plist := PLG.Generate( controls, 0.0, 20_000.0 );
      for p of plist loop
         Put_Line( i'Img & " = " & PLG.To_String( p ));
         i := i + 1;
      end loop;
      
      i := 1;
      controls.net_t := total_taxes;
      plist := PLG.Generate( controls, 0.0, 20_000.0 );
      Put_Line( "Taxes" );
      for p of plist loop
         Put_Line( i'Img & " = " & PLG.To_String( p ));
         i := i + 1;
      end loop;
      
      i := 1;
      controls.net_t := benefits_only;
      plist := PLG.Generate( controls, 0.0, 20_000.0 );
      Put_Line( "Benefits" );
      for p of plist loop
         Put_Line( i'Img & " = " & PLG.To_String( p ));
         i := i + 1;
      end loop;
   end Test_BCs;
   
   --------------------
   -- Register_Tests --
   --------------------
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine (T, Test_BCs'Access, "Test BCs");
      null;
   end Register_Tests;
   
   procedure Set_Up (T : in out Test_Case) is
   begin
      null;
   end Set_Up;
   
   procedure Shut_Down(T : in out Test_Case) is
   begin
      Null;
   end Shut_Down;

   
   ----------
   -- Name --
   ----------
   
   function Name ( T : Test_Case ) return Message_String is
   begin
          return Format( "Piecewise_Linear_Generator.Tests");
   end Name;
end  Piecewise_Linear_Generator_Tests;