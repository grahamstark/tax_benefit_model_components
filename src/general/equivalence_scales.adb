package body Equivalence_Scales is
--  
-- from: Equivalence scales: rationales, uses and assumptions
-- Jenny Chanfreau and Tania Burchardt Table 1 p.5
--
   function Calculate( 
           peoples_ages : Ages_Array; 
           which_scale : Equivalence_Scale_Type := modified_oecd ) return Amount is
           position_of_spouse : Natural := 0 ) return Amount is
         eq : Amount := 1.0;
         pno : Positive := 1;
         add : Amount;
         np  : constant Amount := Amount( pers_list'Length ); 
   begin
      case which_scale is
         when square_root =>
            return Sqrt( np ); 
         when oxford | modified_oecd => 
            for pno in peoples_ages'Range loop
               if pno = 1 then
                  null; -- we actually have some all child BUs
               else
                  if peoples_ages( pno ).age <= 14 then 
                     add := ( if which_scale = oxford then 0.5 else 0.3 );
                  else
                     add := ( if which_scale = oxford then 0.7 else 0.5 );
                  end if;
               end if;
               Inc( eq, add );
               Inc( pno );
            end loop;
         when mcclements =>
            declare
               child_pids       : Sernum_Set := hh.structurer.Child_Pids;
               adult_pids       : Sernum_Set := hh.structurer.Adult_Pids;
               pers             : Person;
               num_extra_adults : Natural := 0;
            begin
               
               for struct of hh.structurer loop
                  pers := hh.people( struct.pid );                     
                  if struct.is_dependent_child then
                     case peoples_ages( pno ) is
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
                  else
                     if struct.is_head then
                        add := 1.0;
                     elsif struct.is_spouse_of_head then
                        add := 0.64;
                     else
                        Inc( num_extra_adults );
                        if num_extra_adults = 1 then
                           add := 0.75;
                        elsif num_extra_adults = 2 then
                           add := 0.69;
                        else
                           add := 0.59;
                        end if;
                     end if;
                  end if;
                  Inc( eq, add );
               end loop;
            end;
      end case;         
      return eq;   
   end Calculate;

end Equivalence_Scales;
