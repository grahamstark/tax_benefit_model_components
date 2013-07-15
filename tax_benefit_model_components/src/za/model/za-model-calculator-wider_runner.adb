--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

with Ada.Strings.Unbounded;
with Ada.Text_IO;

with ZA.Model.Data.Binary_IO;
with ZA.Model.Takeup;
with ZA.Model.Calculator.Wider_Output;
with ZA.Model.Settings;

package body ZA.Model.Calculator.Wider_Runner is

   package mio renames ZA.Model.Data.Binary_IO;
   package outp renames ZA.Model.Calculator.Wider_Output;
   package takeup renames ZA.Model.Takeup;
   
   use Ada.Text_IO;
   use Ada.Strings.Unbounded;
   
   JOB_START : constant := -88;
   JOB_END   : constant := -99;
   
   procedure Write_Progress( progress_file_name : String; n : Integer ) is
      f : File_Type;
   begin
      Create( f, Out_File, progress_file_name );
      Put_Line( f, "za" );
      Put_Line( f, Integer'Image( n ));
      Close( f );
   end Write_Progress;
   
   procedure Run_Model( 
      params1  : Parameters; 
      params2  : Parameters;
      settings : Run_Settings ) is

      hh       : Household;
      nhh      : mio.Household_Count;
      result_1 : Household_Result;
      result_2 : Household_Result;
      outputs  : outp.Outputs_Rec; 
      --
      -- local copy of run settings so we can edit it
      -- for takeup probabilities
      -- 
      control_rec : Run_Settings := settings;
      outfile_name : constant String := 
         To_String( control_rec.paths.output_dir & "tables_file.csv" );
      progress_file_name : constant String := 
         To_String( control_rec.paths.run_root & "progress.txt" );
   begin
      Write_Progress( progress_file_name, JOB_START );
      Put_Line( "writing to " & outfile_name );
      mio.Set_Model_Data_Dir( control_rec.paths.data_dir );
      mio.Open_Files;
      nhh := mio.Num_Households;
      Put_Line( " household count " & Format( nhh ));
      for href in 1 .. nhh loop
         hh := mio.read( href );
         -- Fix up the data
         -- 1) benefit takeup probabilities
         ---
         control_rec.case_takes_up := 
            takeup.Get_case_takes_up( control_rec.takeup_adjustment ); 
         -- FIXME won't work here for pobit case needs to be after calcs
         -- 2) uprate incomes (to roughly june 09)
         Uprate( hh, control_rec );
         -- 3) re-weight consumption and income variables
         Apply_Income_Consumption_Adjustments( hh, control_rec );
         --
         -- calculate 
         --
         result_1 := Calculate( hh, params1, control_rec );
         result_2 := Calculate( hh, params2, control_rec );
         --
         -- accumulate
         --
         outp.Add_To_Outputs( 
            href, hh, result_1, result_2, outputs );
         if(( href mod 50 ) = 0 )then
            Write_Progress( progress_file_name, Integer( href ));
         end if;
      end loop;
      --
      -- print
      --
      outp.Print_Outputs( 
         outfile_name,
         outputs );
      mio.Close_Files;
      Write_Progress( progress_file_name, JOB_END );
   end Run_Model;
   
end ZA.Model.Calculator.Wider_Runner;
