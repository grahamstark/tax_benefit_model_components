--
--  $Author: graham_s $
--  $Date: 2008-07-19 21:27:20 +0100 (Sat, 19 Jul 2008) $
--  $Revision: 5478 $
--
pragma License( Modified_GPL );

with AUnit.Assertions;              
with Text_IO;                       
with Ada.Text_IO;
with Ada.Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded;


with Ada.Containers.Vectors;
with Ada.Exceptions;


with Base_Model_Types; 

with Tax_Utils;

with Numeric_Io;
with Numeric_Io.Matrix_Io;
with Name_Io;
with Input_Collection;
with Name_Io.Matrix_name_IO;
--  with Ada.Numerics.Generic_Real_Arrays;


--  with User_IO;
package body Input_Collection_Tests is

   use AUnit.Test_Cases.Registration;
   use AUnit.Assertions;
   use Text_IO;    
   use Ada.Exceptions;
   use Base_Model_Types;
   
   V_SIZE : constant := 500;
   type Incs is ( earn, se, invest );
   subtype Incs_Range is Incs range earn .. invest;
   type VIncs is  array (Incs_Range range <>) of Real;
   type VMatrix is  array ( Incs range <>, Incs range <> ) of Real;
   subtype Incs_V is VIncs( Incs );
   subtype Some_Incs is Incs range earn .. se;
   subtype Incs_V2 is VIncs( Some_Incs );
   
   
   type Vector is array (Positive range <>) of Real ;
   type Matrix is array (Positive range <>,Positive range <>) of Real ;

   -- an instance of matrix_quadratic deals in constrained vectors
   subtype Dimensionality is Positive range 1..V_SIZE ;

   subtype Vector_V is Vector (Dimensionality) ;
   
   
   subtype Matrix_V is Matrix (Dimensionality, Dimensionality);

   package Scalar_IO is new Numeric_IO (Real, Positive ) ;
   use Scalar_Io ;

   type Some_Enum is ( a, b, c, z, ma, rates, bands, bool );
   

   package Up_Taxes is new Tax_Utils( Rate_Type=>Rate, Amount_Type=>Amount );

   subtype Rate_Band is Up_Taxes.Rate_And_Band;
   subtype Rate_Bands is Up_Taxes.Rates_And_Bands;
   
   
   procedure Print_Rate_Bands( rbs : Rate_Bands ) is
      rb : Rate_Band;
   begin
      put( "rates = ");
      for p in 1 .. Up_Taxes.Get_Num_Rates_And_Bands( rbs ) loop
         rb := Up_Taxes.Get_Rate_And_Band( rbs, p );
         put( rb.rate'Img );      
      end loop;
      put( "; " );new_line;
      put( "bands = ");
      for p in 1 .. Up_Taxes.Get_Num_Rates_And_Bands( rbs ) loop
         rb := Up_Taxes.Get_Rate_And_Band( rbs, p );
         put( rb.band'Img );      
      end loop;
      put( "; " );new_line;
      
   end Print_Rate_Bands;
   
   procedure Test_Input_Collection( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
      
      package Nio is new Name_Io (Names_Type    => Some_Enum, -- Name_List.Input_Names_Type,
                                  Floating_Type => Base_Model_Types.Real,
                                  Integer_Type  => Positive,
                                  Scalar_Io     => Scalar_IO );
         
      
      
                                  
      package Mio is new Scalar_IO.Matrix_IO(
         Vector_Ix   => Positive,
         Vector_Type => Vector,
         Matrix_Ix1  => Positive,
         Matrix_Ix2  => Positive,
         Matrix_Type => Matrix) ;                                  
         
      package Incsio is new Scalar_IO.Matrix_IO(
         Vector_Ix   => Incs,
         Vector_Type => VIncs,
         Matrix_Ix1  => Incs,
         Matrix_Ix2  => Incs,
         Matrix_Type => VMatrix) ;                                  
     
         
         
     procedure Get_Bool is new Nio.Get_Item ( Boolean );
                     
     package NMio is new Nio.Matrix_name_IO
      (Matrix_Io  => Mio ) ; 
      
      x : Rate;
      y : Amount;
      s : String( 1 .. 40);   
      v : Vector_V;
      tmp_rates, tmp_bands : Vector_V;
      rb : Rate_Band;
      rbs : Rate_Bands;
      i   : Integer;
      bb  : Boolean;
   begin
      Input_Collection.Read_File( "tests/resources/test1.dat" );
      Nio.Acquire_Input( "test1" ); 
      Nio.Get( a, x );
      Nio.Get( b, y );
      
      Nio.Forget_Contents;
      Nio.Acquire_Input( "test2" ); 
      Nio.Get( z, x );
      NMio.get( ma, v );
      NMio.get( rates, tmp_rates );
      NMio.get( bands, tmp_bands );
      Get_Bool( bool, bb, "false" );
      put( "bool = " & bb'Img );
      bb := i = 1;
      Nio.Forget_Contents;
      put( "z = " & x'Img );
      for p in Dimensionality loop
         put( "v["& p'Img &" ] = " & v(p)'Img );new_line;
      end loop;
      
      for p in Dimensionality loop         
         exit when( tmp_bands(p) = 0.0 );
         rb.rate := tmp_rates(p);
         rb.band := tmp_bands(p);
         Up_Taxes.Set_Rate_And_Band( rbs, rb, p );      
      end loop;
      put( "made n bands: " & Up_Taxes.Get_Num_Rates_And_Bands( rbs )'Img );
      Print_Rate_Bands( rbs );
   end Test_Input_Collection;
   
   

   
   --------------------
   -- Register_Tests --
   --------------------
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine (T, Test_Input_Collection'Access, "Test Input Collection");
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
   
   function Name ( T : Test_Case ) return Message_String is
   begin
          return Format( "Components Tests." );
   end Name;

end Input_Collection_Tests;
