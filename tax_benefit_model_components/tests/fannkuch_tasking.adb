with Ada.Text_IO;
with Ada.Command_Line; 

-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- 
-- contributed by Graham Stark (graham.stark@virtual-worlds.biz)
-- modified by [??]
-- 
-- gnatmake -gnatp -O3 -fomit-frame-pointer -lpthread -funroll-loops  -f src/fannkuch.adb -o bin/fannkuch
--
-- see: http://shootout.alioth.debian.org/u32/benchmark.php?test=fannkuch&lang=all
--
procedure Fannkuch_Tasking is

   use Ada.Text_IO;
   MAX_TO_PRINT : constant := 30;
   DEBUG : constant Boolean := False;
   package I_IO is new  Ada.Text_IO.Integer_IO( Positive );
  
   task type Fannkuch_Worker( num_elements : Positive ) is
      entry Start( worker_number : Positive );
      entry Stop( max_flips : out Positive );
   end Fannkuch_Worker;
   
   task body Fannkuch_Worker is
   
      subtype I_Range is Positive range 1 .. num_elements;
      type Int_Array is array( I_Range ) of I_Range;
      
      max_num_flips : Positive := 1;
      num_fannkuchs : Natural := 1;
      wno : Positive;
      
      procedure Swap( a : in out Int_Array; p1 : in I_Range; p2 : in I_Range ) is
         tmp : I_Range := a( p1 );
      begin
         a( p1 ) := a( p2 );
         a( p2 ) := tmp;
      end Swap;
      
      procedure Reverse_Array( a : in out Int_Array; end_pos : in I_Range ) is
         b : Int_Array := a;
      begin
         for p in 1 .. end_pos loop
            a( p ) := b( end_pos - p + 1 );
         end loop;
      end Reverse_Array;
         
      procedure Print( a : in Int_Array ) is
      begin
         for i in a'Range loop
            I_IO.Put( a(i), Width => 1 );
         end loop;
         New_Line;
      end Print;

      procedure Do_One_Fannkuch( a : in out Int_Array; num_flips : out Natural ) is
      begin
         num_flips := 0; 
         loop
            exit when( a( 1 ) = 1 );
            Reverse_Array( a, a( 1 ));
            num_flips := num_flips + 1;
         end loop;
         if( num_flips > max_num_flips )then 
            max_num_flips := num_flips; 
         end if; 
         if( wno = 1 ) and then ( num_fannkuchs < MAX_TO_PRINT )then
            Print( a );
            num_fannkuchs := num_fannkuchs + 1;
         end if;
      end Do_One_Fannkuch;
      
      procedure Permute( a : in Int_Array; start_pos : in I_Range ) is
         local_a : Int_Array := a;
         num_flips : Natural;
      begin
         if( start_pos = local_a'Last )then
            Do_One_Fannkuch( local_a, num_flips );
         else
            for p in start_pos .. local_a'Last loop
               Swap( local_a, start_pos, p );
               Permute( local_a, start_pos + 1 );
            end loop;
         end if;
      end Permute;

      a : Int_Array;
   begin
      accept Start( worker_number : in Positive ) do
         if( DEBUG )then
            Put_Line( "Worker " & Positive'Image( worker_number ) & "STARTS" );
         end if;
         wno := worker_number;
      end Start;
      -- Initialise the array. So for example, worker3 starts 3,1,2,4,5,6,7,8,9... 
      -- and worker8 starts 8,1,2,3,4,5,6,7,9 ...  
      -- The leading digit stays unchanged throughout.
      a( 1 ) := wno;
      for i in 2 .. a'Last loop
         if( i <= wno )then
            a( i ) := i-1;
         else
            a( i ) := i;
         end if;
      end loop;
      Permute( a, 2 );
      accept Stop( max_flips : out Positive ) do
         max_flips := max_num_flips;    
         if( DEBUG )then
            Put_Line( "Worker " & Positive'Image( wno ) & "Stops; Max Flips"
                      &  Positive'Image( max_num_flips ));
         end if;
      end Stop;
   end Fannkuch_Worker;
   
   procedure Run( size : in Positive ) is
      --
      -- one worker per digit. We permute starting with the 2nd digit
      -- (so all worker#1 jobs stop right away)
      -- 
      type Workers_Array is array( 1 .. SIZE ) of Fannkuch_Worker( 
         num_elements => size ); 
   
      workers : Workers_Array;
      max_num_flips : Natural := 0;
      mf : Natural := 0;
    begin
      for p in Workers_Array'Range loop
         workers( p ).Start( p );
      end loop;
      for p in Workers_Array'Range loop
         workers( p ).Stop( mf );
         if( mf > max_num_flips )then 
            max_num_flips := mf; 
         end if; 
      end loop;
      Put( "Pfannkuchen(" );
      I_IO.Put( size, 0 );
      Put( ") = " );
      I_IO.Put( max_num_flips, 0 );
      New_Line;
   end Run;

use Ada.Command_Line;
   size : Natural := 7;
begin
   if( Argument_Count > 0 )then
      size := Natural'Value( Argument( 1 ) );
   end if;   
   Run( size );
end Fannkuch_Tasking;
