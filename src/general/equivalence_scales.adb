with Maths_Functions;
with Base_Model_Types;

package body Equivalence_Scales is

   use Base_Model_Types;
   
   procedure Inc( a : in out Real; m : Real ) is
   begin
      a := a + m;
   end Inc;
   
   --  
   -- from: Equivalence scales: rationales, uses and assumptions
   -- Jenny Chanfreau and Tania Burchardt Table 1 p.5
   --
   function Calculate( 
      people      : Person_Array; 
      which_scale : Equivalence_Scale_Type ) return Real is

   package MF is new Maths_Functions( Real );
   use MF.Elementary_Functions;
      eq_scale    : Real := 0.0;
      add         : Real;
      pos_of_head : Person_Number := 1;
      np          : constant Real := Real( people'Length );
   begin
      --
      -- assume 1st person is head if none set .. 
      for pno in people'Range loop
         if people( pno ).ptype = head then
            pos_of_head := pno;
            exit;
         end if;
      end loop;
      -- idiot check for child as head
      if people( pos_of_head ).age < 16 then
         for pno in people'Range loop
            if people( pno ).age >= 16 then -- just take 1st over 15 if any
               pos_of_head := pno;
               exit;
            end if;
         end loop;
      end if;          
      case which_scale is
      when square_root =>
         return Sqrt( np ); 
      when oxford | modified_oecd => 
         for pno in people'Range loop
            if pno = pos_of_head then
               add := 1.0;
            else
               if people( pno ).age <= 14 then 
                  add := ( if which_scale = oxford then 0.5 else 0.3 );
               else
                  add := ( if which_scale = oxford then 0.7 else 0.5 );
               end if;
            end if;
            Inc( eq_scale, add );
         end loop;
      when mcclements =>
         declare
            num_extra_adults : Person_Count := 0;
         begin
            for pers of people loop               
               case pers.ptype is
               when dependent_child =>
                  case pers.age is
                  when 0 .. 1 => 
                     add := 0.148;
                  when 2 .. 4 => 
                     add := 0.295;
                  when 5 .. 7 => 
                     add :=  0.344;
                  when 8 .. 10 => 
                     add := 0.377;
                  when 11 .. 12 => 
                     add := 0.41;
                  when 13 .. 15 => 
                     add := 0.443;
                  when 16 .. Age_Range'Last => 
                     add := 0.59;
                  end case;
               when head =>
                  add := 1.0;
               when spouse_of_head =>
                  add := 0.64;
               when other_adult =>
                  Inc( num_extra_adults );
                  if num_extra_adults = 1 then
                     add := 0.75;
                  elsif num_extra_adults = 2 then
                     add := 0.69;
                  else
                     add := 0.59;
                  end if;
               end case;
               Inc( eq_scale, add );
            end loop;
         end;
      end case;         
      return eq_scale;   
   end Calculate;

end Equivalence_Scales;
