with Ada.Strings.Unbounded;
with Subjects_And_Observers;
--
-- A little generic progress monitor based on the Observer/Observable pattern.
--
-- This is based on code from http://www.adapower.com/index.php?Command=Class&ClassID=Patterns&CID=272
-- which, frankly, I'm not sure I understand ...
-- 
-- The observers aren't called directly here, but are triggered whenever the state changes
-- execept for Id and Owner, which are assumed to be set at the start. You can manually call
-- monitor.Notify, also.
-- 
-- Use like:
-- monitor : aliased Model_Monitor;
-- web_obs : Web_Observer( monitor'Access );
-- where Model_Monitor and Web_Observer are concrete instantiations of 
-- Monitor_Type and Monitor_Observer.
--
generic
   
   type Stage_Type is (<>);
   type Health_Type is (<>);
   num_counters : Positive := 4;

package Monitor is
   
   use Subjects_And_Observers;
   
   type Abs_Counter_Array is array( Positive range <> ) of Integer;
   
   subtype Counter_Range is Positive range 1 .. Num_Counters;
   subtype Counter_Array is Abs_Counter_Array( Counter_Range );
   
   type Monitor_Type is new Root_Subject_Type with private;
   type Monitor_Observer( m : access Monitor_Type'Class ) is new Root_Observer_Type with private;
   procedure Update( observer : access Monitor_Observer );
   
   procedure Set( 
      m        : in out Monitor_Type; 
      stage    : Stage_Type; 
      health   : Health_Type; 
      counters : Counter_Array );
   
   procedure Assert( m : in out Monitor_Type; should_be_true : Boolean; error_message : String );
   function Is_Aborting( m : Monitor_Type ) return Boolean;
   procedure Set_Abort( m : in out Monitor_Type );
   
   procedure Set_Stage( m : in out Monitor_Type; stage : Stage_Type );
   function Get_Stage( m : Monitor_Type ) return Stage_Type;

   procedure Set_Health( m : in out Monitor_Type; health : Health_Type );
   function Get_Health( m : Monitor_Type ) return Health_Type;
   
   procedure Set_Counter( m : in out Monitor_Type; which : Counter_Range; c : Integer );
   function Get_Counter( m : Monitor_Type; which : Counter_Range ) return Integer;
   function Get_Counters( m : Monitor_Type ) return Counter_Array;

   procedure Set_Owner( m : in out Monitor_Type; owner : String );
   function Get_Owner( m : Monitor_Type ) return String;
   
   procedure Set_Message( m : in out Monitor_Type; message : String );
   function Get_Message( m : Monitor_Type ) return String;
   
   function Get_Stack_Trace( m : Monitor_Type ) return String;
    
   procedure Set_Id( m : in out Monitor_Type; id : Integer );
   function Get_Id( m : Monitor_Type ) return Integer;
   
   function Get_Is_In_Error( m : Monitor_Type ) return Boolean;
   
   procedure Reset( m : in out Monitor_Type );
   
private
   
   use Ada.Strings.Unbounded;
   
   type Monitor_Observer( m : access Monitor_Type'Class ) is
     new Root_Observer_Type( m ) with null record;
   
   type Monitor_Type is new Root_Subject_Type with record -- is tagged limited record 
      stage       : Stage_Type := Stage_Type'First;
      health      : Health_Type := Health_Type'First;
      is_aborting : Boolean := False;
      is_in_error : Boolean := False;
      counters    : Counter_Array := ( others => 0 );
      owner       : Unbounded_String := Null_Unbounded_String;
      id          : Integer := 0;
      message     : Unbounded_String := Null_Unbounded_String;
      stack_trace : Unbounded_String := Null_Unbounded_String;
   end record;
   
end Monitor;