with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;

with FRS_Enums;
with Model.Household;
with T_Utils;

package Model.Income_Measure_Types is

   use Model.Household;
   use FRS_Enums;

   NUM_INCOME_BRACKETS : constant Positive := 50;
   
   subtype Income_Brackets is Positive range 1 .. NUM_INCOME_BRACKETS;
   
   INCOME_INCREMENT : constant Amount := 1_000.0;
   
   MAX_NUM_COSTS : constant := 50;
   
   subtype Costs_Range is Natural range 0 .. MAX_NUM_COSTS;
   type Costs_Array is array( Costs_Range ) of Amount;

   type Affordability_Measure_Type is ( residual_income_level, cost_disposable_ratio, cost_gross_ratio );
   function Pretty_Print( measure : Affordability_Measure_Type ) return String;
 
   
   package Affordability_Measure_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Affordability_Measure_Type );  
   subtype Affordability_Measure_Array is Affordability_Measure_Package.Amount_Array;
   subtype Affordability_Measure_Set   is Affordability_Measure_Package.Set;
  
   type Income_Measure_Type is ( Gross, Net, Disposable );
   
   package Income_Measure_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Income_Measure_Type );  
   subtype Income_Measure_Array is Income_Measure_Package.Amount_Array;
   subtype Income_Measure_Set   is Income_Measure_Package.Set;
   
   type All_Affordabilities is array ( Costs_Range ) of Affordability_Measure_Array;

   type One_Complete_Income_Measure_Output is record
      poverty_line : Amount := 0.0;
      affordabilities : All_Affordabilities := ( others=>(others=>0.0) );
      incomes         : Income_Measure_Array := ( others=>0.0 );
      num_cost_measures : Costs_Range := Costs_Range'Last; 
      costs           : Costs_Array := ( others => 0.0 );
      tenure          : Tenure_Type;
      region          : Regional_Stratifier; 
      economic_status : Benefit_Unit_Economic_Status;
      disablement_status     : BU_Disabled_Indicator;
      bu_type         : HBAI_Benefit_Unit_Type;
      age_range_of_head  : Age_Group;    
      grossing_factor : Amount;
      on_income_support : Boolean := false;
   end record;
   
   function Get_Income_Range( m : Amount ) return Income_Brackets;
   
   package Income_Measure_List is new Ada.Containers.Vectors( Element_Type => One_Complete_Income_Measure_Output, Index_Type => Positive );
   
   type Benefit_Unit_Incomes_Array is array (1 .. MAX_NUM_BENEFIT_UNITS) of One_Complete_Income_Measure_Output;
   
   type Household_Incomes_Result is record
      aggregate : One_Complete_Income_Measure_Output;
      net_housing_costs   : Amount := 0.0;
      gross_housing_costs : Amount := 0.0;
      benefit_units  : Benefit_Unit_Incomes_Array;      
   end record;
   
   function To_String( res : One_Complete_Income_Measure_Output ) return String;
   function To_String( hh : Household_Rec; res : Household_Incomes_Result ) return String; 
   --
   --  a record with differences (2-1) in all the numeric values.
   --
   function Difference( res1, res2 : One_Complete_Income_Measure_Output ) return One_Complete_Income_Measure_Output;
   procedure Aggregate( res1 : in out One_Complete_Income_Measure_Output; res2 : One_Complete_Income_Measure_Output );
   --
   --  a fresh output record
   --
   function New_Output return Household_Incomes_Result;

   --
   -- Output routines: ??? move to own package ??? 
   -- ?? add examples ?? make basic cell a record
   -- 
   MAX_SLOTS : constant := 6;
   DEFAULT_SUMMARY_SLOT : constant := 3;
   
   subtype Slot_Range is Integer range 1 .. MAX_SLOTS;
   package Slots_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Slot_Range );
   subtype Basic_Breakdown is Slots_Package.Amount_Array;
   
   type Basic_Cell is array( Affordability_Measure_Type, Costs_Range ) of Basic_Breakdown;
   
   type Col_Totals_Type is array( Affordability_Measure_Type, Costs_Range ) of Amount;
   
   --
   -- assorted formatting bibs and bobs FIXME we need all these??
   --
   function Pretty_Print( slot : Slot_Range ) return String; 
   function Affordability_Measure_Type_Name( measure : Affordability_Measure_Type ) return String;
   function Affordability_Units_Name( measure : Affordability_Measure_Type ) return String;
   function Slot_Range_Str( measure : Affordability_Measure_Type; slot : Slot_Range ) return String;
   function Slot_Range_Str_Residual_Income( slot : Slot_Range ) return String;
   function Slot_Range_Str_Ratio( slot : Slot_Range ) return String;
   function Income_Measure_Type_Name_Short_Version( measure : Income_Measure_Type ) return String;
   function Income_Measure_Type_Name( measure : Income_Measure_Type ) return String;
   

end Model.Income_Measure_Types;
