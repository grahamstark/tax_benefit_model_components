with Model.Abstract_Result;

package Model.Example_Results.Impl is

  package mar renames Model.Abstract_Result;
  
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
  
   overriding procedure Zero( 
      result : in out Model_Personal_Result ); 
      
   type Model_Benefit_Unit_Result is new Benefit_Unit_Result and 
      mar.Benefit_Unit_Result with null record;
   
   overriding procedure Set( 
      result : in out Model_Benefit_Unit_Result;
      pid    : Sernum_Value; 
      value  : mar.Personal_Result'Class );
 
   overriding function Get( 
      result : Model_Benefit_Unit_Result; 
      pid    : Sernum_Value ) return mar.Personal_Result'Class;
      
   overriding procedure Set( 
      result : in out Model_Benefit_Unit_Result;
      pid    : Sernum_Value; 
      which  : Calculated_Incomes_Range; 
      value  : Amount;
      op     : Operation_Type := Replace );
      
   overriding procedure Set( 
      result : in out Model_Benefit_Unit_Result;
      pid    : Sernum_Value; 
      which  : Broad_Calculated_Type; 
      value  : Amount;
      op     : Operation_Type := Replace );
      
   overriding function Get( 
      result : Model_Benefit_Unit_Result; 
      which  : Broad_Calculated_Type ) return Amount;
      
   overriding procedure Zero( 
      result : in out Model_Benefit_Unit_Result );
      
   type Model_Household_Result is new Household_Result and 
      mar.Household_Result with null record;
    
   overriding procedure Set( 
      result : in out Model_Household_Result;
      which : Benefit_Unit_Number; 
      value : mar.Benefit_Unit_Result'Class ) ;
      
   overriding procedure Set( 
      result : in out Model_Household_Result;
      pid    : Sernum_Value; 
      value  : mar.Personal_Result'Class;
      op     : Operation_Type := Replace ) ;
      
   overriding function Get( 
      result : Model_Household_Result; 
      which  : Benefit_Unit_Number ) return mar.Benefit_Unit_Result'Class  ;
   
   overriding function Get( 
      result : Model_Household_Result; 
      which  : Broad_Calculated_Type ) return Amount ;
      
   overriding function Get_Personal( 
      result : Model_Household_Result; 
      pid    : Sernum_Value ) return mar.Personal_Result'Class ;
   
   procedure Zero( result : in out Model_Household_Result ) ;      

end  Model.Example_Results.Impl;