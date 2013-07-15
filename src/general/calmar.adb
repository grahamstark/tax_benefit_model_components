with Ada.Numerics.Generic_Elementary_Functions;   

package body Calmar is

   package Numerics is new Ada.Numerics.Generic_Elementary_Functions( 
      Float_Type => Data_Type );

   function Accumulate(
      data              : Dataset;
      size_of_each_enum : in  Enum_Vector;
      weights           : Data_Column ) return Control_Table is
      ct : Control_Table := ( Others=>( Others=>0.0 ));
      p  : Enum_Range;
   begin
      for ctl in Controls_Range loop
         for obs in Observations_Range loop
            p := data( ctl, obs );
            ct( ctl, p ) := ct( ctl, p ) + weights( obs );
         end loop;
      end loop;
      return ct;
   end Accumulate;
       
   
   function Entopy_Minimand( 
      lamdas : Information_Matrix_Row;
      data   : Passed_Through_Data ) return Information_Matrix_Row is
      use Numerics; 
      use Dataset_Package;
      x : Information_Matrix_Row := ( Others=>0.0 );
      ip : Data_Type := 0.0;
    begin
      for ctl in 1 .. data.matrix_size loop
         for obs in Observations_Range loop
            ip := lamdas * data.information_matrix( obs );
            x( ctl ) := x( ctl ) +
               data.information_matrix( obs )( ctl ) * 
               data.initial_weights( ctl ) *
               Exp( ip - 1.0 );
         end loop;
         x( ctl ) := x( ctl ) - data.control_totals( ctl );
      end loop;
      return x;
   end Entopy_Minimand;

   function Run_Integrity_Check( 
      data              : Dataset;
      weights           : Data_Column;
      marginal_totals   : Control_Table;
      size_of_each_enum : in  Enum_Vector;
      ctl_rec           : in  Control_Record ) return Error_Record is
      new_totals : constant Control_Table := 
         Accumulate( data, size_of_each_enum, weights );
      old_sum, new_sum : Data_Type := 0.0;
      error_state      : Error_Record;
   begin
      for ctl in Controls_Range loop
         old_sum := 0.0;
         new_sum := 0.0;
         for p in 1 .. size_of_each_enum( ctl ) loop
            if( marginal_totals( ctl, p ) /= 0.0 ) and then
              ( new_totals( ctl, p ) = 0.0 ) then
               error_state.state := mismatched_zeros;
               error_state.message := error_state.message &
               "Run_Integrity_Check: ERROR: variable " & Positive'Image( ctl ) & 
                 " Slot " & Positive'Image( p ) & 
                 " is zero in the new data and positive in the control totals";
               return error_state;
            elsif( marginal_totals( ctl, p ) = 0.0 ) and then
              ( new_totals( ctl, p ) /= 0.0 ) then
               error_state.state := mismatched_zeros;
               error_state.message := error_state.message &
               "Run_Integrity_Check: ERROR: variable " & Positive'Image( ctl ) & 
                 " Slot " & Positive'Image( p ) & 
                 " is zero in the control totals and positive in the control totals";
                 return error_state;
            end if;
            old_sum := old_sum + marginal_totals( ctl, p );
            new_sum := new_sum + new_totals( ctl, p );            
         end loop;
         if(( abs( old_sum - new_sum ) / old_sum ) > ctl_rec.stopping_tolerance ) then
            error_state.state := marginal_totals_not_equal;
            error_state.message := error_state.message &
               "Run_Integrity_Check: ERROR: marginal totals not sufficiently close for variable " &
            Positive'Image( ctl ) &
            "    old value " & Data_Type'Image( old_sum ) &
               " new value " & Data_Type'Image( new_sum );
            return error_state;
         end if;
      end loop;
      return error_state;
   end Run_Integrity_Check;

   procedure Calculate_Weights( 
      data              : in  Dataset;
      initial_weights   : in  Data_Column;
      marginal_totals   : in  Control_Table;
      size_of_each_enum : in Enum_Vector;
      final_weights     : out Data_Column;
      ctl_rec           : in  Control_Record;
      error_state       : out Error_Record  ) is
   begin
      error_state := Run_Integrity_Check( 
         data, 
         initial_weights, 
         marginal_totals,
         size_of_each_enum,
         ctl_rec );
      if( error_state.state /= no_error ) then
         return;
      end if;
   end  Calculate_Weights;
   
   procedure Dataset_To_Information_Matrix( 
      data              : in Dataset;
      marginal_totals   : in  Control_Table;
      size_of_each_enum : in Enum_Vector;
      information_matrix : out Information_Matrix_Type;
      matrix_size       : out Information_Matrix_Range ) is
      p : Information_Matrix_Range;
   begin
      matrix_size := 1;
      information_matrix := ( Others=>( Others => 0.0 ));
      for obs in Observations_Range loop
         for ctl in Controls_Range loop
            p := matrix_size + data( obs, ctl ) - 1;
            information_matrix( obs )( p ) := 1.0;
            matrix_size := matrix_size + size_of_each_enum( ctl );
         end loop;
      end loop;
      matrix_size := matrix_size - 1;
   end Dataset_To_Information_Matrix;

end Calmar;
