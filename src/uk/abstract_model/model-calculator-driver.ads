with Model.Parameter_System;
with Model.Results;
with Model.Abstract_Household;
with Example_Data;
with Example_Data.Model_Household;
with Example_Data.Examples;
with Base_Model_Types;
with Model_Types;

package Model.Calculator.Driver is

   use Example_Data.Examples;
   use Example_Data;
   
   procedure Run_Model(
      events       : Events_List;
      system       : Model.Parameter_System.Complete_System;
      which_hh     : HH_Type;
      target_pid   : Positive;
      results      : out Model.Results.Household_Result;
      outfile_name : String );

private

   procedure Do_Main_Calculations(
      sys            : Model.Parameter_System.Complete_System;
      hh             : Example_Data.Household;
      results        : in out Model.Results.Household_Result );

end Model.Calculator.Driver;
