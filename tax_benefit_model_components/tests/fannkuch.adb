with Ada.Text_IO;
with Ada.Command_Line; 

-- The Computer Language Benchmarks Game
-- http://shootout.alioth.debian.org/
-- 
-- contributed by Graham Stark (graham.stark@virtual-worlds.biz)
-- modified by [??]
-- 
-- To multithread - 
--    -- 1st 1 .. n = p;
--    --   p threads
--    -- initialise 1 .. n, excluding p
--    -- start from 2; set (1) = p
--    
-- gcc -c -gnatwu -O2 -gnatn -funroll-loops -gnatp fannkuch.adb
-- gnatmake -gnatp -O3 -fomit-frame-pointer -lpthread -funroll-loops  -f src/fannkuch.adb -o bin/fannkuch
--
-- see: http://shootout.alioth.debian.org/u32/benchmark.php?test=fannkuch&lang=all
--
procedure Fannkuch is

   use Ada.Text_IO;
   MAX_TO_PRINT : constant := 30;
   
   procedure Calculate_All( array_size : Positive; max_num_flips: in out Natural ) is

      type I_Range is new Positive range 1 .. array_size;
      
      num_fannkucks : Natural := 0;
      
      type Int_Array is array( I_Range ) of I_Range;

      procedure Swap( a : in out Int_Array; p1 : I_Range; p2 : I_Range ) is
         tmp : I_Range;
      begin
         tmp := a( p1 );
         a( p1 ) := a( p2 );
         a( p2 ) := tmp;
      end Swap;

      procedure Reverse_Array( a : in out Int_Array; end_pos : I_Range ) is
         b : Int_Array := a;
      begin
         for p in 1 .. end_pos loop
            a( p ) := b( end_pos - p + 1 );
         end loop;
      end Reverse_Array;
      
      procedure Print( a : in Int_Array ) is
      begin
         for i in a'Range loop
            Put( I_Range'Image( a(i) ));
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
         if( num_flips > max_num_flips ) then 
            max_num_flips := num_flips; 
         end if; 
         num_fannkucks := num_fannkucks + 1;
         if( num_fannkucks <= MAX_TO_PRINT ) then
            Print( a );         
         end if;
      end Do_One_Fannkuch;
   
      
      procedure Permute( a : in Int_Array; start_pos : I_Range ) is
         local_a : Int_Array := a;
         num_flips : Natural;
      begin
         if( start_pos = local_a'Last ) then
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
      for i in a'range loop
         a( i ) := i;
      end loop;
      Permute( a, 1 ); 
   end Calculate_All;

use Ada.Command_Line;

   max_num_flips : Natural := 0;
   size : Natural := 7;
begin
   if( Argument_Count > 0 ) then
      size := Natural'Value( Argument( 1 ));
   end if;
   Calculate_All( size, max_num_flips );
   Put_line( "For size = " & Natural'Image( size ) & 
             "Max Num Flips = " & Natural'Image( max_num_flips ));
end Fannkuch;
