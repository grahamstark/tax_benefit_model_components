with Ada.Text_IO;

package Model.Run_Settings.IO is
   subtype File_Type is Ada.Text_IO.File_Type; 
   
   procedure Write( file :  File_Type; icr : Incomes_Control_Record );
   function Read( file :  File_Type ) return Incomes_Control_Record;
   
end Model.Run_Settings.IO;
