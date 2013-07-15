with Maths_Functions;
with Ada.Numerics.Float_Random;
with Ada.Text_IO;

package body List_Of_Randoms is
   
   Random_Gen : Ada.Numerics.Float_Random.Generator;
   
   function Make_Copy( from : Random_List ) return Random_List is
      to : Random_List;
   begin
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
      for i in R_Range loop
         r.n_vals( i ) := MF.Random_Normal_Generator.Draw;
         r.r_vals( i ) := Real( Ada.Numerics.Float_Random.Random( Random_Gen ));
      end loop;
      
   end Reset;
   
   procedure Next( r : in out Random_List; v : out Real; wrap : Boolean := True ) is
   begin
      if( r.r_pos = capacity ) and wrap then
         r.r_pos := 0;
      end if;
      r.r_pos := r.r_pos + 1;
      v := r.r_vals( r.r_pos );
   end Next;
   
   procedure Next_Normal( r : in out Random_List; v : out Real; wrap : Boolean := True ) is
   begin
      
      if( r.n_pos = capacity ) and wrap then
         r.n_pos := 0;
      end if;
      r.n_pos := r.n_pos + 1;
      v := r.n_vals( r.n_pos );
   end Next_Normal;

   package RIO is new Ada.Text_IO.Float_IO( Real );
   
   procedure Store( r : Random_List; filename : String ) is
      use Ada.Text_IO;
      f : File_Type;
   begin
      Create( f, Out_File, filename );
      for i in R_Range loop
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
      Open( f, In_File, filename );
      for i in R_Range loop
         RIO.Get( f, r.r_vals( i ));
         RIO.Get( f, r.n_vals( i ));
      end loop;
      Close( f );
   end Load;
   
end List_Of_Randoms;
