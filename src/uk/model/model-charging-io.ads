with Ada.Text_IO;
with Ada.Strings.Unbounded;

package Model.Charging.IO is

   subtype File_Type is Ada.Text_IO.File_Type;   
   use Ada.Strings.Unbounded;
   
   procedure Write( file :  File_Type; charge : Charges_Type; prefix : Unbounded_String; charge_num : Positive );
   function Read( file :  File_Type; prefix : Unbounded_String; charge_num : Positive ) return Charges_Type;
   
   procedure Write( file :  File_Type; target : Target_Type; prefix : Unbounded_String; target_num : Positive );
   function Read( file :  File_Type; prefix : Unbounded_String; target_num : Positive ) return Target_Type;
   
   procedure Write( file :  File_Type; application : Application_Type; prefix : Unbounded_String; application_num : Positive );
   function Read( file :  File_Type; prefix : Unbounded_String; application_num : Positive  ) return Application_Type;

   procedure Write( file :  File_Type; regime : Charging_Regime );
   function Read( file :  File_Type; peek_only : Boolean := false ) return Charging_Regime;
 
end Model.Charging.IO;
