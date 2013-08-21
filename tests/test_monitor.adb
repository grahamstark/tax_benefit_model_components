with Ada.Text_IO;

package body Test_Monitor is

   use Ada.Text_IO;
   
   procedure Observe( m : in out M1.Monitor_Type ) is
   begin
      Put_Line( "ABABAB" );
      m.Assert( true, "" );
   end Observe;
         
end Test_Monitor;
