with Ada.Assertions;

package body Poverty_Tabulator is
   
   use Ada.Assertions;
   
   function Difference( newt : Table_Type; oldt : Table_Type ) return Table_Type is
      p : Table_Type;
   begin
      for b in Breakdown_Range loop
         Assert( newt.cells( b )( population ) = oldt.cells( b )( population ), 
            "population mismatch from Poverty_Tabulator new " & Data_Type'Image( newt.cells( b )( population )) &
            " old " & Data_Type'Image( oldt.cells( b )( population )) & "breakdown " & Breakdown_Range'Image( b ));
            
         p.cells( b )( population ) := newt.cells( b )( population );
         
         for e in people_in_poverty .. Poverty_Elements'Last loop
            p.cells( b )( e ) := newt.cells( b )( e ) - oldt.cells( b )( e );
         end loop;
      end loop;    
      for e in people_in_poverty .. Poverty_Elements'Last loop -- keep popn constant
         p.totals( e ) := newt.totals( e ) - oldt.totals( e );
      end loop;      
      p.totals( population ) := newt.totals( population );      
      return p;
   end Difference;

   procedure Add_Observation( 
      table                  : in out Table_Type;
      poverty_gap_per_person : Data_Type;
      num_people             : People_Count;
      which_bd               : Breakdown_Range; 
      weight                 : Data_Type ) is
      wp : constant Data_Type := weight * Data_Type( num_people );
   begin
      table.cells( which_bd )( population ) := 
         table.cells( which_bd )( population ) + wp;
      table.totals( population ) := 
         table.totals( population ) + wp;
      if( poverty_gap_per_person > 0.0 ) then
         table.cells( which_bd )( people_in_poverty ) := 
            table.cells( which_bd )( people_in_poverty ) + wp;      
         table.cells( which_bd )( poverty_gap_total ) := 
            table.cells( which_bd )( poverty_gap_total ) + 
               ( wp * poverty_gap_per_person );      
         table.totals( people_in_poverty ) := 
            table.totals( people_in_poverty ) + wp;      
         table.totals( poverty_gap_total ) := 
            table.totals( poverty_gap_total ) + 
               ( wp * poverty_gap_per_person );      
      end if;
   end Add_Observation;
 
   procedure Complete_Table( table : in out Table_Type ) is
   begin
      for b in Breakdown_Range loop
         if( table.cells( b )( population ) > 0.0 )then
            table.cells( b )( poverty_rate ) := 100.0 *
               table.cells( b )( people_in_poverty ) /
                  table.cells( b )( population );      
         end if;
         if( table.cells( b )( people_in_poverty ) > 0.0 )then
            table.cells( b )( poverty_gap_per_poor_person ) := 
               table.cells( b )( poverty_gap_total ) /
                  table.cells( b )( people_in_poverty );      
         end if;
      end loop;
      if( table.totals( population ) > 0.0 )then
         table.totals( poverty_rate ) := 100.0 *
            table.totals( people_in_poverty ) /
               table.totals( population );      
      end if;
      if( table.totals( people_in_poverty ) > 0.0 )then
         table.totals( poverty_gap_per_poor_person ) := 
            table.totals( poverty_gap_total ) /
               table.totals( people_in_poverty );      
      end if;
   end Complete_Table;

end Poverty_Tabulator;
