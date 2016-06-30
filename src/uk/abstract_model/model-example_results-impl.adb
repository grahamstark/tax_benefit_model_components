with Model.Abstract_Result;

package body Model.Example_Results.Impl is

    procedure Set( 
      result : in out Model_Personal_Result;
      which  : Calculated_Incomes_Range; 
      value  : Amount; 
      op     : Operation_Type := replace );
      
    function Get( 
      result : Model_Personal_Result; 
      which  : Calculated_Incomes_Range ) return Amount;
      
    procedure Set( 
      result : in out Model_Personal_Result;
      which  : Broad_Calculated_Type; 
      value  : Amount; 
      op     : Operation_Type := replace ) ;
      
    function Get( 
      result : Model_Personal_Result; 
      which  : Broad_Calculated_Type ) return Amount;
  

end  Model.Example_Results.Impl;