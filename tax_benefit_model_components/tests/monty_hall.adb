with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Assertions;

procedure Monty_Hall is

   use Ada.Text_IO;
   use Ada.Assertions;
   
   type Prize_Type is ( goat, car );
   
   type Strategy_Type is ( stick, switch, random );
   
   subtype Num_Doors_Type is Positive range 3 .. Positive'Last; 
   
   package Random_Integers is new Ada.Numerics.Discrete_Random( Integer );
   integer_generator : Random_Integers.Generator;
   
   function Random_Integer return Integer is
   begin
      return Random_Integers.Random( integer_generator );
   end Random_Integer;
      
   
   function Play( strategy : Strategy_Type; num_doors : Num_Doors_Type ) return Prize_Type is
      subtype Doors_Range is Positive range 1 .. num_doors;
      prize : Prize_Type;
      -- 
      -- All the Doors; all but a random one have goats in them
      -- You don't really need an array here but it's easier to read this way
      --
      doors : array( Doors_Range ) of Prize_Type := ( others => goat );
      package All_Doors_Choices is new Ada.Numerics.Discrete_Random( Doors_Range );
      initial_choice_generator : All_Doors_Choices.Generator;
      initial_choice : Doors_Range;
      montys_choice  : Doors_Range;
      car_position   : Doors_Range;
      slots_occupied : Doors_Range := 2;
   begin
      All_Doors_Choices.Reset( initial_choice_generator, Random_Integer ); 
      -- hack because random generator has to be locally declared and always
      -- produces the same sequence without the Random_Integer
      initial_choice := All_Doors_Choices.Random( initial_choice_generator );
      car_position := All_Doors_Choices.Random( initial_choice_generator );
      doors( car_position ) := car;
      --
      -- Monty can show any box except the chosen one or the one with
      -- the car in it. So there are n-2 if the chosen one doesn't have the car
      -- and n-1 otherwise
      -- 
      if( initial_choice = car_position ) then
         slots_occupied := 1;
      end if;
      declare
         subtype Montys_Range is Positive range 1 .. ( num_doors - slots_occupied );
         package Montys_Choices is new Ada.Numerics.Discrete_Random( Montys_Range );
         montys_choice_generator : Montys_Choices.Generator;
         montys_choice_pos : Montys_Range;
         p : Montys_Range := 1;
      begin
         Montys_Choices.Reset( montys_choice_generator, Random_Integer );
         --
         -- Monty chooses a door from the n-1 or n-2 free doors
         -- 
         montys_choice_pos := Montys_Choices.Random( montys_choice_generator );
         --
         -- Work out the actual door that corresponds to by skipping the car door and 
         -- the contestant's door
         -- 
         for i in Doors_Range loop
            if(( i /= car_position ) and ( i /= initial_choice )) then
               if( p = montys_choice_pos ) then
                  montys_choice := i;
                  exit;
               end if;
               p := p + 1;
            end if;
         end loop;
         Assert( doors( montys_choice ) = goat );
         case strategy is 
            when switch =>
               declare
                  --
                  -- when switching,  
                  -- contestant chooses a random door other than Monty's and his original
                  -- so there's definitely n-2 to choose from (i.e. always the other one when 3 doors)
                  -- 
                  subtype Switching_Range is Positive range 1 .. ( num_doors - 2 );
                  package Switching_Choices is new Ada.Numerics.Discrete_Random( Switching_Range );
                  switching_choices_generator : Switching_Choices.Generator;
                  switching_choice_pos : Switching_Range;
                  s : Switching_Range := 1;
               begin
                  Switching_Choices.Reset( switching_choices_generator, Random_Integer );
                  --
                  -- Contestant chooses a door from the n-2 available
                  --
                  switching_choice_pos := Switching_Choices.Random( switching_choices_generator );
                  --
                  -- As before, work out the actual door that that corresponds to, by skipping over the 
                  -- previous choice and Monty's choice
                  -- 
                  for i in Doors_Range loop
                     if(( i /= montys_choice ) and ( i /= initial_choice )) then
                        if( s = switching_choice_pos ) then
                           prize := doors( i );
                           exit;                     
                        end if;
                        s := s + 1;
                     end if;
                  end loop;               
               end; -- declare switch choices
            when random =>
               declare
                  --
                  -- when random  
                  -- contestant chooses a random door other than Monty's 
                  -- so there's n-1 to choose from 
                  -- 
                  subtype Switching_Range is Positive range 1 .. ( num_doors - 1 );
                  package Switching_Choices is new Ada.Numerics.Discrete_Random( Switching_Range );
                  switching_choices_generator : Switching_Choices.Generator;
                  switching_choice_pos : Switching_Range;
                  s : Switching_Range := 1;
               begin
                  Switching_Choices.Reset( switching_choices_generator, Random_Integer );
                  --
                  -- Contestant chooses a door from the n-1 available
                  --
                  switching_choice_pos := Switching_Choices.Random( switching_choices_generator );
                  --
                  -- As before, work out the actual door that that corresponds to, by skipping over Monty's choice
                  -- 
                  for i in Doors_Range loop
                     if( i /= montys_choice ) then
                        if( s = switching_choice_pos ) then
                           prize := doors( i );
                           exit;                     
                        end if;
                        s := s + 1;
                     end if;
                  end loop;               
               end; -- declare random choices
            when stick =>
               prize := doors( initial_choice );
         end case;
      end; -- declare monty's choice
      return prize;
   end Play;

   subtype Door_Tests_Type is Num_Doors_Type range 3 .. 50; 
   prize : Prize_Type;
   prizes : array( Door_Tests_Type, Strategy_Type, Prize_Type ) of Natural := ( others => ( others=> (others => 0 )));
   type Percentage is delta 0.01 digits 5;
   wins_pct : Percentage;
   wins : array( Strategy_Type ) of Natural := ( 0, 0, 0 );
begin
   for num_doors in Door_Tests_Type loop
      for strategy in Strategy_Type loop
         for i in 1 .. 100_000 loop
            prize := play( strategy, num_doors );
            prizes( num_doors, strategy, prize ) := prizes( num_doors, strategy, prize ) + 1;
         end loop;
      end loop;
   end loop;
   
   Put_Line( "100,000 iterations; 3 .. 50 doors " );
   for num_doors in Door_Tests_Type loop
      for strategy in Strategy_Type loop
         wins_pct := Percentage( Float( prizes( num_doors, strategy, car ))/1_000.0);
         Put_Line( " for doors = " & Door_Tests_Type'Image( num_doors ) &
                   " strategy = "  & Strategy_Type'Image( strategy ) &
                   " wins = " & Natural'Image(  prizes( num_doors, strategy, car ) ) & " (" & 
                   Percentage'Image( wins_pct ) & "%) " );
      end loop;
   end loop;
   
   --
   -- try with 1,000 doors
   --
   for strategy in Strategy_Type loop
         for i in 1 .. 10_000_000 loop
            prize := play( strategy, 1_000 );
            if( prize = car ) then
               wins( strategy ) := wins( strategy ) + 1;
            end if;            
         end loop;
   end loop;
   Put_Line( " wins from 1,000 doors 10,000,000 iterations" ); 
   Put_Line( " switch " & Natural'Image( wins( switch )) ); 
   Put_Line( " stick " & Natural'Image( wins( stick )) );
   Put_Line( " random " & Natural'Image( wins( random )) );
end Monty_Hall;
