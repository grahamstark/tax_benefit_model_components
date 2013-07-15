with Ada.Text_IO;

package body Test_Monitor is

   use Ada.Text_IO;
   
   procedure Observe( m : M1.Monitor_Type ) is
   begin
      Put_Line( "ABABAB" );
      m.Observe;
   end Observe;
         
end Test_Monitor;
