with Ada.Numerics.Generic_Real_Arrays;
with Ada.Strings.Unbounded;
--
-- sudo apt-get install liblapack-dev
-- sudo apt-get install libblas-dev
-- see: Microdata Adjustment by the Minimum Information Loss Principle Joachim Merz; FFB Discussion Paper No. 10 July 1994
-- 
generic

  type Data_Type is digits<>;
  Num_Controls       : Positive;
  Num_Observations   : Positive;
  Max_Breakdown_Size : Positive;

package Calmar is

   use Ada.Strings.Unbounded;
   --
   -- NOT USED from SAS version
   --
   type Method_Type is ( linear, raking_ratio, logit, truncated_linear );
   
   type Calmar_Error is ( 
      no_error, 
      mismatched_zeros, 
      marginal_totals_not_equal, 
      bounds_not_set, 
      no_convergence, 
      too_many_iterations );

   type Error_Record is record
      state : Calmar_Error := no_error;
      message : Unbounded_String;
   end record;

   type Control_Record is record
      max_iterations     : Positive := 50;
      stopping_tolerance : Data_Type := 0.0001;
      lower_bound        : Data_Type := Data_Type'First;  -- from SAS logit not used
      upper_bound        : Data_Type := Data_Type'First;  -- from SAS logit not used
      method             : Method_Type := linear;         -- from SAS  not used
   end record;
   

   subtype Controls_Range is Integer range 1 .. Num_Controls;
   subtype Observations_Range is  Integer range 1 .. Num_Observations;
   
   package Dataset_Package is new Ada.Numerics.Generic_Real_Arrays( 
      Real => Data_Type );
   use Dataset_Package;
   
   subtype Enum_Range is Positive range 1 .. Max_Breakdown_Size;
   type Enum_Matrix is array( Integer range <>, Integer range <> ) of Enum_Range;
   
   type Enum_Vector is array( Controls_Range ) of Enum_Range;
   
   type Dataset is new Enum_Matrix( Controls_Range, Observations_Range );
   type Control_Table is new Real_Matrix( Controls_Range, 1 .. Max_Breakdown_Size );
   type Data_Column is new Real_Vector( Observations_Range );
   
   procedure Calculate_Weights( 
      data              : in  Dataset;
      initial_weights   : in  Data_Column;
      marginal_totals   : in  Control_Table;
      size_of_each_enum : in  Enum_Vector;
      final_weights     : out Data_Column;
      ctl_rec           : in  Control_Record;
      error_state       : out Error_Record ); -- FIXME Or an exception?
      
   function Run_Integrity_Check( 
      data              : Dataset;
      weights           : Data_Column;
      marginal_totals   : Control_Table;
      size_of_each_enum : in Enum_Vector;
      ctl_rec           : in  Control_Record ) return Error_Record;

   function Accumulate(
      data              : Dataset;
      size_of_each_enum : in  Enum_Vector;
      weights           : Data_Column ) return Control_Table;
   --
   -- FOR the optimiser 
   --
   type Passed_Through_Data is private;
      
private      

   Information_Matrix_Size : constant Positive := Num_Controls * Max_Breakdown_Size;
   
   subtype Information_Matrix_Range is Integer range 1 .. Information_Matrix_Size;
   
   
   type Information_Matrix_Row is new Real_Vector( Information_Matrix_Range );
   type Information_Matrix_Type is array ( Observations_Range ) of Information_Matrix_Row;
   --
   -- an information matrix has just 1s and 0s
   --
   procedure Dataset_To_Information_Matrix( 
      data               : in  Dataset;
      marginal_totals    : in  Control_Table;
      size_of_each_enum  : in  Enum_Vector;
      information_matrix : out Information_Matrix_Type;
      matrix_size        : out Information_Matrix_Range );
      
   type Passed_Through_Data is record
      initial_weights    : Data_Column;
      control_totals      : Information_Matrix_Row;
      matrix_size        : Information_Matrix_Range;
      information_matrix : Information_Matrix_Type;
   end record;
      
          
end Calmar;
