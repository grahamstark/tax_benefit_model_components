with Model.Abstract_Result;

package Model.Example_Results.Impl is

   package mar renames Model.Abstract_Result;
   use mar;
   
   type Model_Personal_Result is new Personal_Result and mar.Personal_Result with null record;
   
   overriding procedure Set( 
      result : in out Model_Personal_Result;
      which  : Calculated_Incomes_Range; 
      value  : Amount; 
      op     : Operation_Type := replace );
      
   overriding function Get( 
      result : Model_Personal_Result; 
      which  : Calculated_Incomes_Range ) return Amount;
      
   overriding procedure Set( 
      result : in out Model_Personal_Result;
      which  : Broad_Calculated_Type; 
      value  : Amount; 
      op     : Operation_Type := replace ) ;
      
   overriding function Get( 
      result : Model_Personal_Result; 
      which  : Broad_Calculated_Type ) return Amount;
      
   overriding procedure Zero( result : in out Model_Personal_Result );
   
package Model.Example_Results.Impl;