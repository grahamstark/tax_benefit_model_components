with Utils;
with Ada.Text_IO;
with GNATColl.Traces;

package body Monitor is
   
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MONITOR" );

   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   procedure Set( m : in out Monitor_Type; stage : Stage_Type; health : Health_Type; counters : Counter_Array ) is
   begin
      m.stage := stage;
      m.health := health;
      m.counters := counters;
      m.Notify;
   end Set;
   
   procedure Assert( m : in out Monitor_Type; should_be_true : Boolean; error_message : String ) is
   begin
      m.is_in_error := should_be_true = False;
      if( m.is_in_error )then
         declare
            trace : constant String := Utils.Get_Stack_Trace;
         begin
            Log( "failed assertion with message " & error_message & " trace " & trace );
            m.message := To_Unbounded_String( error_message );
            m.stack_trace := To_Unbounded_String( trace );
            m.is_aborting := True;
            m.Notify;
         end;
      end if;
   end Assert;
   
   function Is_Aborting( m : Monitor_Type ) return Boolean is
   begin
      return m.is_aborting;
   end Is_Aborting;

   procedure Set_Abort( m : in out Monitor_Type ) is
   begin
      m.is_aborting := True;
      m.Notify;
   end Set_Abort;
   
   
   procedure Set_Stage( m : in out Monitor_Type; stage : Stage_Type ) is
   begin
      m.stage := stage;
      m.Notify;
   end Set_Stage;
   
   function Get_Stage( m : Monitor_Type ) return Stage_Type is
   begin
      return m.stage;
   end Get_Stage;

   procedure Set_Health( m : in out Monitor_Type; health : Health_Type ) is
   begin
      m.health := health;
      m.Notify;
   end Set_Health;
   
   function Get_Health( m : Monitor_Type ) return Health_Type is
   begin
      return m.health;
   end Get_Health;
   
   procedure Set_Counter( m : in out Monitor_Type; which : Counter_Range; c : Integer ) is
   begin
      m.counters( which ) := c;
      m.Notify;
   end Set_Counter;
   
   function Get_Counter( m : Monitor_Type; which : Counter_Range ) return Integer is
   begin
      return m.counters( which );
   end Get_Counter;
   
   procedure Set_Owner( m : in out Monitor_Type; owner : String ) is
   begin
      m.owner := To_Unbounded_String( owner );
   end Set_Owner;
   
   function Get_Owner( m : Monitor_Type ) return String is
   begin
      return To_String( m.owner );
   end Get_Owner;
   
   procedure Set_Id( m : in out Monitor_Type; id : Integer ) is
   begin
      m.id := id;
   end Set_Id;
   
   function Get_Id( m : Monitor_Type ) return Integer is
   begin
      return m.id;
   end Get_Id;

   function Get_Is_In_Error( m : Monitor_Type ) return Boolean is
   begin
      Log( "Get_Is_In_Error; " & m.is_in_error'Img );
      return m.is_in_error;
   end Get_Is_In_Error;
   
   procedure Set_Message( m : in out Monitor_Type; message : String ) is
   begin
      m.message := To_Unbounded_String( message );
   end Set_Message;
   
   function Get_Message( m : Monitor_Type ) return String is
   begin
      return To_String( m.message );
   end Get_Message;
   
   function Get_Stack_Trace( m : Monitor_Type ) return String is
   begin
      return To_String( m.stack_trace );
   end Get_Stack_Trace;
    

   procedure Reset( m : in out Monitor_Type ) is
   begin
      m.stage := Stage_Type'First;
      m.health := Health_Type'First;
      m.is_aborting := False;
      m.is_in_error := False;
      m.counters    := ( others => 0 );
      -- keep ownership
      -- owner       : Unbounded_String := Null_Unbounded_String;
      -- id          : Integer := 0;
      m.message     := Null_Unbounded_String;
      m.stack_trace := Null_Unbounded_String;
   end Reset;
   
   procedure Update( observer : access Monitor_Observer ) is
   begin
      Put_Line( "owner = " & To_String( observer.m.all.owner ));
      Put_Line( "Id= " & Integer'Image( observer.m.all.id ));
      Put_Line( "Stage_Type = " & Stage_Type'Image( observer.m.all.stage ));
      Put_Line( "Health_Type = " & Health_Type'Image( observer.m.all.health ));
      Put_Line( "In Error = " & Boolean'Image( observer.m.all.is_in_error ));
      Put_Line( "Is Aborting = " & Boolean'Image( observer.m.all.is_aborting ));
      for i in Counter_Range loop
         Put_Line( "Counter[" & Integer'Image( i ) & " ] = " & Integer'Image( observer.m.all.counters( i )));
      end loop;
      Put_Line( "message = " & To_String( observer.m.all.message ));
      Put_Line( "stack trace = " & To_String( observer.m.all.stack_trace ));
   end Update;
   
end Monitor;
