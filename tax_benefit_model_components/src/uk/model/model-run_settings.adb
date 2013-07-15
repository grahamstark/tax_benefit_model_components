--
--  $Revision: 14080 $
--  $Author: graham_s $
--  $Date: 2012-02-22 14:33:32 +0000 (Wed, 22 Feb 2012) $
--
pragma License( Modified_GPL );

with Ada.Direct_IO;
with Ada.Text_IO;
with Text_Utils;

package body Model.Run_Settings is

   use Ada.Text_IO;
   use Text_Utils;
   
   procedure Write_State( filename : String; state : State_Type ) is
   use UK_Key_Value_IO;
   use Ada.Text_IO;
      file : Ada.Text_IO.File_Type;  
   begin
      Create( file, Out_File, filename );
      Write( file, "household", state.household );
      Write( file, "other_counter", state.other_counter );
      Write( file, "year", state.year );
      Write( file, "phase", Phase_Type'Image( state.phase ));
      Write( file, "health", Health_Type'Image( state.health ));
      Write( file, "error_code", state.error_code );
      Write( file, "message", state.message );
      Write( file, "read_error", state.read_error );
      Close( file );
   end Write_State;
   
   function Read_State( filename : String ) return State_Type is
   use UK_Key_Value_IO;
   use Ada.Text_IO;
      file : Ada.Text_IO.File_Type;  
      state : State_Type;
   begin
      Open( file, In_File, filename );
      state.household := Read( file, "household" );
      state.other_counter := Read( file, "other_counter" );
      state.year := Read( file, "year" );
      state.phase := Phase_Type'Value( Read( file, "phase" ));
      state.health := Health_Type'Value(Read( file, "health" ));
      state.error_code := Read( file, "error_code" );
      state.message := Read( file, "message" );
      state.read_error := Read( file, "read_error" );
      Close( file );
      return state;
   end Read_State;


   package Settings_io is new  Ada.Direct_IO ( Settings_Rec );
   
   function to_string( settings : Settings_Rec ) return String is
   begin
      return " id " & TS( settings.run_id ) &  
           " year " & settings.year'Img &
           " uprate_to_current " & settings.uprate_to_current'Img &
           " run type " & settings.run_type'Img &
           " off_diagonal_index " & settings.targetting_weights(off_diagonal_index) 'Img &
           " costs_index " & settings.targetting_weights(costs_index) 'Img &
           " targetting_index " & settings.targetting_weights(targetting_index) 'Img;
   end to_string;
   
   function Binary_Read_Settings ( filename : String ) return Settings_Rec is
          settings : Settings_Rec;
          file     : Settings_IO.File_Type;
   begin
       Ada.Text_IO.put( "opening file " & filename & " for reading " );
       Settings_IO.Open
              ( file,
                Settings_io.In_File,
                filename );
       Settings_IO.Read (file, settings );
       Settings_IO.close( file );
       return settings;
   end Binary_Read_Settings;
   
   procedure Binary_Write_Settings ( filename : String; settings : Settings_Rec ) is
          file     : Settings_IO.File_Type;
   begin
      Ada.Text_IO.Put( "opening file " & filename & " for writing " );
      Settings_io.Create
           ( file,
             Settings_io.Out_File,
             filename );
      Settings_io.Write(file, settings );
      Settings_io.close( file );
   
   end Binary_Write_Settings;
   
   function Basic_Update_Run_State(
      username      : Unbounded_String;
      run_id        : Natural;
      household     : Natural;
      year          : Year_Number;
      other_counter : Natural;
      phase         : Phase_Type;
      health        : Health_Type := normal ) return Boolean is
      use Text_Utils;
      aborting : Boolean := False; 
      run_state : State_Type;
   begin
      Ada.Text_IO.Put_Line( "run_id " & run_id'Img & " year " & year'Img & " household " & household'Img & " phase " & phase'Img );
      return aborting;
   end Basic_Update_Run_State;


end Model.Run_Settings;
