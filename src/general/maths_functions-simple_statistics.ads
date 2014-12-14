with Statistics_Commons;
with Ada.Containers.Vectors;

generic package Maths_Functions.Simple_Statistics is

   use Statistics_Commons;
   type Dataset is tagged private;
   
   type Measures_Array is array( Simple_Measures ) of Real;
   
   procedure Add( data : in out Dataset; v : Real );
   procedure Remove_All( data : in out Dataset );
   function Get( data : Dataset; n : Positive ) return Real;
   function Size( data : Dataset ) return Natural;
   procedure Sort( data : in out Dataset'Class );
   function Generate( data : Dataset ) return Measures_Array;
   function Nth_Percentile( data : Dataset; which : Percentile ) return Real;

   --
   -- make an array periods long interpolating between two values
   -- v1 - 1st value
   -- v2 - final value
   -- v2_v1_distance e.g. 10 years 
   -- periods array will be this long, starting from 1
   -- method - LINEAR/EXPONENTIAL (exp is very rough for small nos of periods)
   -- return vector( 1 .. periods ) 
   --
   function Interpolate( 
      v1             : Real; 
      v2_v1_distance : Positive;
      v2             : Real; 
      periods        : Positive; 
      method         : Interpolation_Method ) return Vector;
   
private

   package Dataset_Package is new Ada.Containers.Vectors( Element_Type => Real, Index_Type => Positive );
   type Dataset is new Dataset_Package.Vector with null record;
   package Dataset_Sorter is new Dataset_Package.Generic_Sorting( "<" => "<" ); 

end Maths_Functions.Simple_Statistics;

