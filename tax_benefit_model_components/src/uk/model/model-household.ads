--
--  $Author: graham_s $
--  $Date: 2008-12-21 16:44:34 +0000 (Sun, 21 Dec 2008) $
--  $Revision: 6530 $
--
pragma License( Modified_GPL );

with Ada.Calendar;     
with Ada.Direct_IO;
with Ada.Strings.Unbounded;
with Model.Uprate;
with FRS_Enums;        
with Data_Constants;
with T_Utils;
with Model.Incomes;

package Model.Household is

   use Ada.Calendar;
   use FRS_Enums;   
   use Data_Constants;
   use Model.Incomes;
   use Ada.Strings.Unbounded;

   MAX_NUM_BENEFIT_UNITS : constant := 9;
   MAX_NUM_CHILDREN      : constant := 9;
   MAX_CHILD_AGE         : constant := 21;   -- FIXME: Should this be 18??
   MIN_ADULT_AGE         : constant := 16;
   MAX_ADULT_AGE         : constant := 140;


   type Head_Or_Spouse is (head, spouse);

   subtype Decile_Number is Integer range 1 .. 10;
   package Decile_Number_Package is new T_Utils(     
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => Decile_Number ); 

   subtype Child_Range is Integer range 0 .. MAX_NUM_CHILDREN;
   
   subtype Person_Age is Natural range 0 .. MAX_ADULT_AGE;
   
   subtype Child_Age is Person_Age range 0 .. MAX_CHILD_AGE;

   subtype Adult_Age is Person_Age range MIN_ADULT_AGE .. Person_Age'Last;
   
   type Aggregation_Level is ( individual_level, benefit_unit_level, household_level );

   type Model_Housing_Costs is
      record
         mortgages             : Amount := 0.0; --s
         gross_council_tax     : Amount := 0.0;
         water_rates           : Amount := 0.0; --  should be nil in NI
         ground_rent           : Amount := 0.0;
         service_charges       : Amount := 0.0;
         repairs_And_Insurance : Amount := 0.0;
         rent                  : Amount := 0.0; --  see 167
         --  rent share see 169/2
         council_tax_rebates           : Amount   := 0.0;
         rent_rebates                  : Amount   := 0.0;
         costs_are_shared              : Boolean := False;  --  probably from HHSTAT
         home_equity                   : Amount   := 0.0;
         house_price                   : Amount   := 0.0;
         mortgages_outstanding         : Amount   := 0.0;
         estimated_house_price_actual  : Amount   := 0.0;
         estimated_house_price_indexed : Amount   := 0.0;
      end record;
      
       
   type Model_Adult is
      record
         age            : Adult_Age                := MAX_ADULT_AGE;
         sex            : Gender                   := Missing;
         marital_status : FRS_Enums.Marital_Status := Missing;
         ethnic_group   : FRS_Enums.Ethnic_Group   := Missing;
         
         -- MARITAL
         relToHoH : FRS_Enums.Relationship_To_Head_Of_Household := Missing;
         -- RELP1(HD
         responsible_for_housing_costs : Boolean := False;

         finance : Finance_Array  := ( Others => 0.0 );
         incomes : Incomes_Array := ( Others => 0.0 );

         expenses : Expenses_Array := ( others => 0.0 );
         is_lodger      : Boolean                     := False;
         employment     : FRS_Enums.Employment_Status := Missing;
         ilo_employment : FRS_Enums.ILO_Employment_Status := Missing;

         has_company_car : Boolean := False;
         capital_stock   : Amount   := 0.0;
         --  religion      : Religion_Type    := no_answer;
      end record;

   type Adult_Array is array (Head_Or_Spouse) of Model_Adult;
   

   type Model_Child is
      record
         age                  : Child_Age                                   := 0;
         sex                  : Gender                                      := male;
         marital_status       : FRS_Enums.Marital_Status                    := Missing;
         relToHoH             : FRS_Enums.Relationship_To_Head_Of_Household := Missing;
         ethnic_group         : FRS_Enums.Ethnic_Group                      := Missing;
         in_formal_child_care : Boolean                                     := False;
      end record;
   
   type Child_Array is array ( 1 .. MAX_NUM_CHILDREN ) of Model_Child;

   type Model_Benefit_Unit is
      record
         last_adult          : Head_Or_Spouse                         := head;
         adults              : Adult_Array;
         num_children        : Child_Range                            := 0;
         children            : Child_Array;
         decile              : Decile_Number                          := 5;
         non_dependency_type : FRS_Enums.Non_Dependency_Class         := Missing;
         economic_status     : FRS_Enums.Benefit_Unit_Economic_Status := Missing; -- ECSTATBU
         bu_type             : FRS_Enums.HBAI_Benefit_Unit_Type       := Missing; -- FAMTYPBU

         age_range_of_head   : FRS_Enums.Age_Group := Missing;
         ethnic_group        : FRS_Enums.Aggregated_Ethnic_Group := Missing;
         disablement_status  : FRS_Enums.BU_Disabled_Indicator := Missing;
         capital_stock       : Amount := 0.0;
     end record;

   subtype Benefit_Unit_Range is Positive range 1 .. MAX_NUM_BENEFIT_UNITS;
   type Benefit_Unit_Array is array ( Benefit_Unit_Range ) of Model_Benefit_Unit;

   type Household_Rec is
      record
         sernum              : Sernum_Value;
         interview_date      : Time;
         grossing_factor     : Rate                            := 1.0;
         tenure              : FRS_Enums.Tenure_Type           := Missing;
         acorn               : FRS_Enums.Acorn                 := Missing;
         composition         : FRS_Enums.Household_Composition := Missing;
         income_band         : FRS_Enums.Household_Income_Band := Missing;
         standard_region     : FRS_Enums.Standard_Region       := Missing;
         old_region          : FRS_Enums.Old_Region            := Missing;
         regional_stratifier : FRS_Enums.Regional_Stratifier   := Missing;

         housing_costs       : Model_Housing_Costs;
         num_benefit_units   : Positive := 1;
         benefit_units       : Benefit_Unit_Array;
      end record;

   procedure Uprate_Household( 
      hh : in out Household_Rec;
      to_date : Time := Model.Uprate.UPRATE_TARGET_DATE );

   procedure Annualise( mhh : in out Household_Rec );

   function To_String( hh : Household_Rec) return String;
   function To_String( bu : Model_Benefit_Unit ) return String;
   function To_String( child : Model_Child ) return String;
   function To_String( adult : Model_Adult ) return String;
   function Characteristics_To_String( hh : Household_Rec ) return String;
   
   function hasDependents( bu : Model_Benefit_Unit ) return Boolean;

   package hh_io is new Ada.Direct_IO( Household_Rec );
   
   MAX_ADULTS_IN_HHLD   : constant :=  MAX_NUM_BENEFIT_UNITS * 2;
   MAX_CHILDREN_IN_HHLD : constant :=  MAX_NUM_BENEFIT_UNITS * MAX_NUM_CHILDREN;
   MAX_PEOPLE_IN_HHLD   : constant :=  MAX_ADULTS_IN_HHLD + MAX_CHILDREN_IN_HHLD;
   
   subtype Household_Child_Range is Natural range 0 .. MAX_CHILDREN_IN_HHLD;
   subtype Household_Adult_Range is Natural range 0 .. MAX_ADULTS_IN_HHLD;
   subtype Household_People_Range is Natural range 0 .. MAX_PEOPLE_IN_HHLD;
   --
   --  read (but don't uprate or annualise) a single household
   --  from the open hhFile
   -- 
   function Load( hhFile : hh_io.File_Type; hhseq : Positive ) return Household_Rec;

   procedure Initialise
     (data_dir : Unbounded_String;
      hh_file : out hh_io.File_Type;
      frsYear : Data_Years;
      sz      : out Natural;
      write   : Boolean := False);
   
   --
   -- get a single, one off household. This opens and then closes
   -- the infiles. Useful for example popups and unit tests.
   -- 
   function Get_One_Model_Household
     ( data_dir : Unbounded_String;
       hhref          : Positive;
       year           : Data_Years;
       annualise_data : Boolean;
       uprate_data    : Boolean 
       ) return Household_Rec;

   function Person_Count( hh : Household_Rec ) return Natural;
   
   --
   --  count of spouse plus num children, if any.
   --
   function Total_Num_Dependents( bu : Model_Benefit_Unit ) return Natural;

   --
   -- FIXME: check these and get it properly from the categorical data!!!!
   --
   function Is_Disabled( ad : Model_Adult ) return Boolean;
   function Is_Severely_Disabled( ad : Model_Adult ) return Boolean;
   function Has_Severely_Disabled_Member( bu : Model_Benefit_Unit ) return Boolean;
   function Has_Disabled_Member( bu : Model_Benefit_Unit ) return Boolean;
   function Is_Carer( ad : Model_Adult ) return Boolean;
   function Age_Of_Oldest_Person( bu : Model_Benefit_Unit ) return Adult_Age;
   function Age_Of_Youngest_Adult( bu : Model_Benefit_Unit ) return Adult_Age;
   function Age_Of_Youngest_Person( bu : Model_Benefit_Unit ) return Natural;
   
   subtype Gender_Set is Gender_Package.Set;
   --
   -- ILO here since they have a single 'student' flag we can easily use
   --
   package Employment_Package renames ILO_Employment_Status_Package; 
   subtype Employment_Set is Employment_Package.Set;
   
   package Agg_Level_Package is new T_Utils( 
         T=> Aggregation_Level, 
         Amount_Type=>Amount, 
         Rate_Type=>Rate, 
         Counter_Type=>Counter_Type );
   function Pretty_Print( a : Aggregation_Level ) return String;
   --
   -- useful for some aggregation functions
   --
   type Housing_Costs_Elements is (
       mortgages, gross_council_tax,  water_rates,  ground_rent,  service_charges,  repairs_And_Insurance,  rent, council_tax_rebates,  rent_rebates );

   type Housing_Costs_Elements_Array is array( Housing_Costs_Elements ) of Amount;
   
   function Map_From_Housing_Record_To_Array( mhr : Model_Housing_Costs ) return Housing_Costs_Elements_Array;
   
   function Make_Gender_Set_Without_Missing return Gender_Set;
   function Make_Employment_Set_Without_Missing return Employment_Set;

end Model.Household;
