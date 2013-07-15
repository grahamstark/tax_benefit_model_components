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
   procedure Sort( data : in out Dataset );
   function Generate( data : Dataset ) return Measures_Array;
   function Nth_Percentile( data : Dataset; which : Percentile ) return Real;
   
private

   package Dataset_Package is new Ada.Containers.Vectors( Element_Type => Real, Index_Type => Positive );
   type Dataset is new Dataset_Package.Vector with null record;
   package Dataset_Sorter is new Dataset_Package.Generic_Sorting( "<" => "<" ); 

end Maths_Functions.Simple_Statistics;

