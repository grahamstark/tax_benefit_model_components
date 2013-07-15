with Ada.Containers.Ordered_Sets;
with Ada.Containers.Vectors;
with T_Utils;
with FRS_Enums;
with Model.Household;
with Model.Incomes;
with Ada.Strings.Unbounded;

package Model.Charging is

   use FRS_Enums;
   use Model.Household;
   use Model.Incomes;
   use Ada.Strings.Unbounded;
   -- move to FRS_Enums????
   
   type Periods is ( school_day, daily, working_week, weekly, school_week, monthly, termly, annual );
   package Periods_Package is new T_Utils( Rate_Type=>Rate, Amount_Type=>Amount, Counter_Type=>Counter_Type, T => Periods );
   subtype Period_Array is Periods_Package.Rate_Array;
   
   function Pretty_Print( p : Periods ) return String;
   
   DAYS_PER_PERIOD : constant Period_Array := ( 
      school_day=>1.0, daily=>1.0, working_week=>5.0, weekly=>7.0,  school_week=>5.0, monthly=>Rate(365.0)/Rate(12.0), termly=>91.0, annual=>365.0 );
   PERIODS_PER_YEAR : constant Period_Array := ( 
      school_day=>273.0, daily=>365.0, working_week=>48.0, weekly=>Rate(365.0)/Rate(7.0), school_week=>39.0, monthly=>12.0, termly=>3.0, annual=>1.0 );
      -- sort of...
   
   ASSUMED_PAYMENT_YEARS : constant := 5;

   type Join_Type is ( j_and, j_or );
   
   type Charges_Type is record
      name     : Unbounded_String := To_Unbounded_String( "" );
      id       : Unbounded_String := To_Unbounded_String( "" );
      charge_amount   : Amount := 0.0;
      discount : Rate := 0.0; 
      period   : Periods := daily;
      frequency : Rate := 0.0; -- period = daily frequency = 10.0 => 1ce every 10 days and so on; 0.5 = twice a day 
      interest_rate : Rate := 0.0;  
      join     : Join_Type := j_and;
   end record;
   
   package Charges_Package is new Ada.Containers.Vectors( Element_Type => Charges_Type, Index_Type => Positive );
   subtype Charges_List is Charges_Package.Vector; 
   
   type Target_Type is record
      name        : Unbounded_String := To_Unbounded_String( "" );
      id          : Unbounded_String := To_Unbounded_String( "" );
      min_age     : Person_Age := Person_Age'First;
      max_age     : Person_Age := Person_Age'Last;
      genders     : Gender_Set;
      benefits    : Broad_Benefits_Set;
      employment  : Employment_Set;
      max_charges : Positive := 99;
      charges     : Charges_List;
      isExclusive : Boolean := False; -- so only this applies, any subsequent hits discarded
   end record;
   
   package Target_Package is new Ada.Containers.Vectors( Element_Type => Target_Type, Index_Type => Positive );
   subtype Target_List is Target_Package.Vector; 
   
   type Application_Type is record
      name : Unbounded_String    := To_Unbounded_String( "" );
      id   : Unbounded_String    := To_Unbounded_String( "" );
      description : Unbounded_String := To_Unbounded_String( "" );
      max_people   : Household_People_Range := Household_People_Range'Last;
      max_children : Household_Child_Range  := Household_Child_Range'Last;
      max_adults   : Household_Adult_Range  := Household_Adult_Range'Last; -- we have a last-adult enumeration instead in the hhld 
      targets      : Target_List;
   end record;

   package Application_Package is new Ada.Containers.Vectors( Element_Type => Application_Type, Index_Type => Positive );
   subtype Application_List is Application_Package.Vector; 
   
   
   
   type Charging_Regime is record
      name : Unbounded_String := To_Unbounded_String( "" );
      description : Unbounded_String := To_Unbounded_String( "" );
      id   : Unbounded_String := To_Unbounded_String( "" );
      applications : Application_List;
   end record;
   
   BLANK_CHARGING_REGIME : constant Charging_Regime := (
      name => To_Unbounded_String( "" ),
      description => To_Unbounded_String( "" ),
      id => To_Unbounded_String( "" ),
      applications => Application_Package.Empty_Vector );

   
   package Charging_Regime_Package is new Ada.Containers.Vectors( Element_Type => Charging_Regime, Index_Type => Positive );
   subtype Charging_Regime_List is Charging_Regime_Package.Vector; 
   
   
   function To_String( ch : Charges_Type ) return String;
   function To_String( tt : Target_Type ) return String;
   function To_String( ap : Application_Type ) return String;
   function To_String( cr : Charging_Regime ) return String;
   
   function Annualised_Equivalent( charge : Charges_Type ) return Amount;
   
   function Hits_Target( ad : Model_Adult; tt : Target_Type ) return Boolean; 
   function Hits_Target( ch : Model_Child; tt : Target_Type ) return Boolean; 
   
   --
   -- fixme: we need to return a proper output record, not just a Amount amount
   -- which members were assumed charged and how much, which reasons
   -- for stopping charging; discounts
   --
   function Get_Charge_For_Family( bu : Model_Benefit_Unit; cr : Charging_Regime ) return Amount_List;
   
   function Charge_Person( ad : Model_Adult; tt : Target_Type ) return Amount;
   function Charge_Person( ch : Model_Child; tt : Target_Type ) return Amount;
   
   function Combine_Booleans( b1 : Boolean; b2 : Boolean; op : Join_Type ) return Boolean; 
   
end Model.Charging;
     
