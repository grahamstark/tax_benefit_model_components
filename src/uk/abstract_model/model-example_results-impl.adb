with Model.Abstract_Result;

package body Model.Example_Results.Impl is

    procedure Set( 
      result : in out Model_Personal_Result;
      which  : Calculated_Incomes_Range; 
      value  : Amount;
      op     : Operation_Type := replace ) is
    begin
      case op is
      when add =>
         Inc( result.income( which ), value );
      when replace =>
         result.income( which ) := value;
      when subtract =>
         Inc( result.income( which ), -value );
      when multiply =>
         result.income( which ) := result.income( which ) * value;
      when divide =>
         result.income( which ) := result.income( which ) / value;
      end case;
    end Set;
      
    function Get( 
      result : Model_Personal_Result; 
      which  : Calculated_Incomes_Range ) return Amount is
    begin
      return result.income( which );   
    end Get;
      
    procedure Set( 
      result : in out Model_Personal_Result;
      which  : Broad_Calculated_Type; 
      value  : Amount; 
      op     : Operation_Type := replace ) is
    begin
      case op is
      when add =>
         Inc( result.intermediate( which ), value );
      when replace =>
         result.intermediate( which ) := value;
      when subtract =>
         Inc( result.intermediate( which ), -value );
      when multiply =>
         result.intermediate( which ) := result.intermediate( which ) * value;
      when divide =>
         result.intermediate( which ) := result.intermediate( which ) / value;
      end case;
       
    end Set;
      
    function Get( 
      result : Model_Personal_Result; 
      which  : Broad_Calculated_Type ) return Amount is
    begin
      return result.intermediate( which );
    end Get;
    
    procedure Zero( 
      result : in out Model_Personal_Result ) is
    begin
       result.income := ( others => 0.0 );
       result.intermediate := ( others => 0.0 );
    end Zero;

end  Model.Example_Results.Impl;