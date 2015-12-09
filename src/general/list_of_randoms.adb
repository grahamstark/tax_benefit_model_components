with Maths_Functions;
with Ada.Numerics.Float_Random;
with Ada.Text_IO;
with GNATColl.Traces;

--
-- fixme this is a complete mess now
--
package body List_Of_Randoms is
   
   Random_Gen : Ada.Numerics.Float_Random.Generator;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "LIST_OF_RANDOMS" );
   
   procedure Set_Capacity( r : in out Random_List; capacity : R_Counter ) is
   begin
      r.capacity := capacity;
      r.Reset;
   end Set_Capacity;
   
   function Get_Capacity( r : Random_List ) return R_Counter is
   begin
      return r.capacity;
   end Get_Capacity;

   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   function Make_Copy( from : Random_List ) return Random_List is
      to : Random_List;
   begin
      to.capacity := from.capacity;
      to.r_pos := from.r_pos;
      to.r_vals := from.r_vals;
      to.n_pos := from.n_pos;
      to.n_vals := from.n_vals;
      return to;
   end Make_Copy;
   
   procedure Reset_Pos( r : in out Random_List ) is
   begin
      r.r_pos := 0;
      r.n_pos := 0;
   end Reset_Pos;
   
   procedure Reset( r : in out Random_List ) is
   begin
      r.Reset_Pos;
      -- MF.Random_Number_Generator.Reset;
      -- Ada.Numerics.Float_Random.Reset( Random_Gen );
      if r.capacity > 1 then
         for i in 1 .. r.capacity loop
            r.n_vals( i ) := MF.Random_Normal_Generator.Draw;
            r.r_vals( i ) := Real( Ada.Numerics.Float_Random.Random( Random_Gen ));
         end loop;
      else
         r.n_vals( 1 ) := 0.0;
         r.r_vals( 1 ) := 0.0;
      end if;
   end Reset;
   
   procedure Next( r : in out Random_List; v : out Real; wrap : Boolean := True ) is
   begin
      if r.capacity = 1 then 
         v := 0.0;
      else
         if( r.r_pos = r.capacity ) and wrap then
            r.r_pos := 0;
         end if;
         r.r_pos := r.r_pos + 1;
         v := r.r_vals( r.r_pos );
      end if;
   end Next;
   
      -- needs ada 2012 since r is changed 
   function Next( r : in out Random_List; wrap : Boolean := True ) return Real is
      v : Real;
   begin
      if r.capacity = 1 then 
         return 0.0; 
      end if;
      r.Next( v, wrap );
      return v;
   end Next;
   
   function Capacity return R_Counter is
   begin
      return Position_Type'Last;
   end Capacity;
   
   function Normal_At_Pos(  r : in out Random_List; pos : R_Counter ) return Real  is
   begin
      return r.n_vals( pos );
   end Normal_At_Pos;
   
   function Random_At_Pos(  r : in out Random_List; pos : R_Counter ) return Real is
   begin
      return r.r_vals( pos );
   end Random_At_Pos;
   
   function Next_Normal( r : in out Random_List; wrap : Boolean := True ) return Real is
      v : Real;
   begin
      if r.capacity = 1 then 
         return 0.0; 
      end if;
      r.Next_Normal( v, wrap );
      return v;
   end Next_Normal;

   procedure Next_Normal( r : in out Random_List; v : out Real; wrap : Boolean := True ) is
   begin
      if r.capacity = 1 then 
         v := 0.0;
      else      
         if( r.n_pos = r.capacity ) and wrap then
            r.n_pos := 0;
         end if;
         r.n_pos := r.n_pos + 1;
         v := r.n_vals( r.n_pos );
      end if;
   end Next_Normal;

   package RIO is new Ada.Text_IO.Float_IO( Real );
   
   procedure Store( r : Random_List; filename : String ) is
      use Ada.Text_IO;
      f : File_Type;
   begin
      Create( f, Out_File, filename );
      for i in 1 .. r.capacity loop
         RIO.Put( f, r.r_vals( i ));
         Put( f, " " );
         RIO.Put( f, r.n_vals( i ));
         New_Line( f );
      end loop;
      Close( f );
   end Store;
   
   procedure Load( r : in out Random_List; filename : String ) is
      use Ada.Text_IO;
      f : File_Type;
   begin
      Log( "List of Randoms; Load; entered" );
      -- shared = no allows a 2nd process to open the file
      Open( f, In_File, filename, "shared=no" );
      Log( "List of Randoms; Load; file opened" );
      for i in 1 .. r.capacity loop
         RIO.Get( f, r.r_vals( i ));
         if( i mod 100 = 0 )then
            Log( "List of Randoms; Read: " & i'Img );
         end if;
         RIO.Get( f, r.n_vals( i ));
      end loop;
      Close( f );
      Log( "List of Randoms; Load; file closed" );
   end Load;
   
end List_Of_Randoms;