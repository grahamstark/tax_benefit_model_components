with Maths_Functions;

generic
   
   type Real is digits<>;
   -- if capacity is 1 this always returns 0; useful for having a 'no random' list
   max_capacity : Positive;
   
package List_Of_Randoms is
   
   type Random_List is tagged private;
   
   subtype Zero_To_One is Real range 0.0 .. 1.0;
   
   subtype R_Counter is Natural range 0 .. max_capacity;
   subtype R_Range is R_Counter range 1 .. max_capacity;
   
   
   -- procedure Set_Capacity( r : in out Random_List; capacity : R_Range );   
   -- function Get_Capacity( r : Random_List ) return R_Counter;
   
   procedure Reset_Pos( r : in out Random_List );
   procedure Reset( r : in out Random_List );
   procedure Next( r : in out Random_List; v : out Zero_To_One; wrap : Boolean := True );
   procedure Next_Normal( r : in out Random_List; v : out Real; wrap : Boolean := True );
   
   -- needs ada 2012 since r is changed 
   function Next( r : in out Random_List; wrap : Boolean := True ) return Zero_To_One;
   function Next_Normal( r : in out Random_List; wrap : Boolean := True ) return Real;
   
   function Normal_At_Pos(  r : in out Random_List; pos : R_Counter ) return Zero_To_One;   
   function Random_At_Pos(  r : in out Random_List; pos : R_Counter ) return Real;

   procedure Store( r : Random_List; filename : String );
   procedure Load( r : in out Random_List; filename : String );
   function Make_Copy( from : Random_List ) return Random_List;
   
   function Capacity( r : Random_List ) return Positive;
   
private   
   
   package MF is new Maths_Functions( Real );
   use MF;
   
   subtype R_Vector is MF.Vector( R_Range );
   
   type Random_List is tagged record
      r_pos    : R_Counter := 0;
      r_vals   : R_Vector;
      n_pos    : R_Counter := 0;
      n_vals   : R_Vector;
   end record;
   
end List_Of_Randoms;
