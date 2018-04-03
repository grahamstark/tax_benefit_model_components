with Ada.Text_IO;
with Format_Utils;

package body Maths_Functions.Simple_Statistics is

   procedure Add( data : in out Dataset; v : Real ) is
   begin
      data.Append( v );
   end Add;
   
   procedure Remove_All( data : in out Dataset ) is
   begin
      data.Clear;
   end Remove_All;
   
   function Get( data : Dataset; n : Positive ) return Real is
   begin
      return data.Element( n );
   end Get;
   
   function Size( data : Dataset ) return Natural is
   begin
      return Natural( data.Length );
   end Size;
   
   procedure Sort( data : in out Dataset'Class ) is
   begin
      Dataset_Sorter.Sort( Dataset_Package.Vector( data ));
   end Sort;
   
   function Nth_Percentile( data : Dataset; which : Percentile ) return Real is
      N     : constant Natural := data.Size-1;
      RN    : constant Real := Real( N );
      PCT_1 : constant Real := RN / 100.0;
      RP    : constant Real := PCT_1 * Real( which );
      P     : constant Positive := Positive( RP ) + 1;
      RM    : constant Real := RP - Real'Floor( RP );
   begin
      if( which = 1 )then
         return data.Get( 1 );
      elsif( which = 100 )then
         return data.Get( N );
      else
         return data.Get( P ) * ( 1.0 - RM ) + data.Get( P + 1 ) * RM;
      end if;
   end Nth_Percentile;
   
   function Generate( data : Dataset ) return Measures_Array is
      use Elementary_Functions;
      use Dataset_Package;
      use Ada.Text_IO;
      v : Measures_Array := ( others => 0.0 );
      N : constant Natural := data.Size;
      RN : constant Real := Real( n );
      sum : Real := 0.0;
      x : Real;
      sdata : Dataset := data.Copy;
   begin
      if( n = 0 )then
         return v;
      end if;
      for i in 1 .. N loop
         x := sdata.Get( i );
         sum := sum + x;
      end loop;
      sdata.Sort;
      v( maximum ) := sdata.Get( N );
      v( minimum ) := sdata.Get( 1 );
      v( mean ) := sum / RN;
      if( n = 1 )then
         v( median ) := v( mean );
         return v;
      end if;
      for i in 1 .. n loop
         x := data.Get( i );
         declare
            a : constant Real := x - v( mean );
         begin
            v( average_deviation ) := v( average_deviation ) + abs( a );
            v( variance ) := v( variance ) + a**2;
            v( skewness ) := v( skewness ) + a**3;            
            v( kurtosis ) := v( kurtosis ) + a**4;            
         end;
      end loop;
      v( observations ) := RN;
      v( effective_sample_size ) := RN;
      v( average_deviation ) := v( average_deviation )/RN;
      v( variance ) := v( variance ) / (RN-1.0);
      v( standard_deviation ) := sqrt( v( variance ));
      if( v( variance ) /= 0.0 )then
         v( skewness ) := v( skewness )/( RN * ( v( standard_deviation )**3 ));
         v( kurtosis ) := v( kurtosis ) / ( RN * ( v( variance )**2 )) - 3.0;
      end if;
      if( N mod 2 ) = 0 then
         declare
            P  : constant Positive := N / 2;
            V1 : constant Real := sdata.Get( p );
            V2 : constant Real := sdata.Get( p+1 );
         begin
            v( median ) := ( V1 + V2 ) / 2.0;
         end;
      else
         declare
            P  : constant Positive := N / 2;
         begin
            v( median ) := sdata.Get( P );
         end;
      end if;
      if( n >= 100 )then
         v( percentile_5 ) := sdata.Nth_Percentile( 5 );
         v( percentile_95 ) := sdata.Nth_Percentile( 95 );
      end if;
      return v;
   end Generate;
      
end Maths_Functions.Simple_Statistics;
