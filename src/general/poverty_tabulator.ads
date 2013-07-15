with Tabulator_Commons; use Tabulator_Commons;

generic
   
   type Data_Type is digits<>;
   
   type People_Count is range <>;
   --
   -- For example, region, or family type
   --
   type Breakdown_Range is (<>);       
   
package Poverty_Tabulator is
   
   type Poverty_Elements_Array is array( Poverty_Elements ) of Data_Type;
   type Cells_Type is array( Breakdown_Range ) of Poverty_Elements_Array;
   type Table_Type is record
      cells  : Cells_Type := ( others=>( others=>0.0 ));
      totals : Poverty_Elements_Array := ( others=>0.0 );
   end record;
   
   function Difference( newt : Table_Type; oldt : Table_Type ) return Table_Type;

   procedure Add_Observation( 
      table                  : in out Table_Type;
      poverty_gap_per_person : Data_Type;
      num_people             : People_Count;
      which_bd               : Breakdown_Range; 
      weight                 : Data_Type );
 
  procedure Complete_Table( table : in out Table_Type );

end Poverty_Tabulator;
