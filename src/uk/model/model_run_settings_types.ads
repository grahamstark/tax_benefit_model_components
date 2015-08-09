--
-- Types for the general run settings thing, moved out to cut down dependencies
-- in full models.
--
package Model_Run_Settings_Types is

   type Target_Type is ( off_diagonal_index, costs_index, targetting_index );
  
   type Phase_Type is ( 
      not_started, 
      queued, 
      run_starting, 
      pre_calculations, 
      running, 
      post_calculations, 
      generating_output, 
      complete );

   subtype Running_Phase is Phase_Type range run_starting .. generating_output;

   type Health_Type is ( normal, aborted, in_error, queued );
     
end Model_Run_Settings_Types;