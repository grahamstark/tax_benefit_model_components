with Monitor;

package Test_Monitor is
   
   type Ev1 is ( event1, event2 );
   type St1 is ( stage1, stage2 );
   
   package M1 is new Monitor( Event_Type => Ev1, Stage_type => St1 );
   type Mon1 is new M1.Monitor_Type with null record;
   procedure Observe( m : M1.Monitor_Type );
         
end Test_Monitor;
