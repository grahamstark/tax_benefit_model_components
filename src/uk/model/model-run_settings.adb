--
--  $Revision: 15566 $
--  $Author: graham_s $
--  $Date: 2012-10-03 16:53:47 +0100 (Wed, 03 Oct 2012) $
--
pragma License( Modified_GPL );

with Ada.Direct_IO;
with Ada.Text_IO;
with Text_Utils;
with GNATColl.Traces;

package body Model.Run_Settings is

   use Ada.Text_IO;
   use Text_Utils;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "CONNECTION_POOL" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
  
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
      Write( file, "other_counter2", state.other_counter2 );
      Write( file, "other_counter3", state.other_counter3 );
      Write( file, "other_counter4", state.other_counter4 );
      
      Close( file );
   end Write_State;
 
   function To_String( state : State_Type ) return String is
      s : Unbounded_String;
   begin
      s := s & "household: " & state.household'Img & LINE_BREAK;
      s := s & "other_counter: " & state.other_counter'Img & LINE_BREAK;
      s := s & "year: " & state.year'Img & LINE_BREAK;
      s := s & "session_id: " & state.session_id & LINE_BREAK;
      s := s & "phase: " & Phase_Type'Image( state.phase ) & LINE_BREAK;
      s := s & "health: " & Health_Type'Image( state.health ) & LINE_BREAK;
      s := s & "error_code: " & state.error_code'Img & LINE_BREAK;
      s := s & "message: " & state.message & LINE_BREAK;
      s := s & "read_error: " & state.read_error'Img & LINE_BREAK;
      s := s & "other_counter2: " & state.other_counter2'Img & LINE_BREAK;
      s := s & "other_counter3: " & state.other_counter3'Img & LINE_BREAK;
      s := s & "other_counter4: " & state.other_counter4'Img & LINE_BREAK;
      return TS( s );
   end To_String;

   
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
      state.other_counter2 := Read( file, "other_counter2" );
      state.other_counter3 := Read( file, "other_counter3" );
      state.other_counter4 := Read( file, "other_counter4" );
      Close( file );
      return state;
   end Read_State;


   package Settings_io is new  Ada.Direct_IO ( Settings_Rec );
   
   function to_string( settings : Settings_Rec ) return String is
   begin
      return " id " & TS( settings.run_id ) &  
           " year " & settings.year'Img &
           " uprate_to_current " & settings.uprate_to_current'Img &
           -- " run type " & settings.run_type'Img &
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
      health        : Health_Type := normal;
      other_counter2 : Natural := 0;
      other_counter3 : Natural := 0;
      other_counter4 : Natural := 0 ) return Boolean is
      use Text_Utils;
      aborting : Boolean := False; 
      run_state : State_Type;
   begin
      Ada.Text_IO.Put_Line( "run_id " & run_id'Img & " year " & year'Img & " household " & household'Img & " phase " & phase'Img );
      return aborting;
   end Basic_Update_Run_State;


end Model.Run_Settings;
