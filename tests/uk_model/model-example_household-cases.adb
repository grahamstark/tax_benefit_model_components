package body Model.Example_Household.Cases is

   function Get_HH_Size( which : Example_Type ) return Person_Count is
      n : Person_Count := 1;
   begin
      case which is
      when 
         single_retired_person |
         young_single |
         old_sick_single_male |
         zero_income |
         care_home_resident => n := 1;
      when 
         cpag_terry_and_julie | -- 2012 edn p 478
         couple_bu_retired |
         young_couple |
         cpag_angelina_and_michael |
         caring_couple |
         working_single_parent => n := 2;
      when 
         hmrc_ni_example_1 |
         hmrc_ni_example_2 |
         hmrc_ni_example_4 |
         hmrc_ni_example_7 => n := 1;       
      end case;
      return n;
   end  Get_HH_Size;

   function Make_Retired_Adult( 
      hh           : Household;
      age          : Age_Range; 
      sex          : Gender_Type; 
      pid          : Sernum_Value; 
      relationship : Relationship_Type ) return Person is
      ad : Person;
   begin      
      ad.age := age;
      ad.sex := sex;
      ad.pid := pid;
      ad.wealth( financial ) := 10_000.0;
      ad.incomes( retirement_pension ) := 6_000.0/52.0;
      ad.employment := retired;  
      ad.relationship := relationship;
      return ad;
   end Make_Retired_Adult;
   
   function Make_Working_Adult( 
      hh        : Household;
      age       : Age_Range; 
      sex       : Gender_Type; 
      pid       : Sernum_Value;
      relationship : Relationship_Type ) return Person is
      ad : Person;   
   begin
      ad.age := age;
      ad.sex := sex;
      ad.pid := pid;
      ad.wealth( financial ) := 5_000.00;
      ad.incomes( wages ) := 1_000.00;
      ad.hours_worked := 40;
      ad.is_contracted_in_to_serps := True;   
      ad.age := age;
      ad.employment := full_time;  
      ad.relationship := relationship;
      return ad;
   end Make_Working_Adult;

   function Make_Child( 
      hh        : Household;
      age       : Age_Range; 
      sex       : Gender_Type; 
      pid       : Sernum_Value ) return Person is
      chld : Person;   
   begin
      chld.age := age;
      chld.sex := sex;
      chld.pid := pid;
      chld.age := age;
      chld.employment := in_education;  
      chld.relationship := child;
      return chld;
   end Make_Child;
   
   function Make_Household(
      which     : Example_Type;
      hid       : Sernum_Value;       
      start_pid : in out Sernum_Value;
      year      : Year_Number ) return Household is
   use Ada.Calendar;
      np   : Person_Count := Get_HH_Size( which );
      hh   : Household( np );
      pers : Person;
   begin
      hh.year := year;
      hh.hid := hid;
      hh.tenure := social_rented;
      case which is   
      when 
            hmrc_ni_example_1 |
            hmrc_ni_example_2 |
            hmrc_ni_example_4 | 
            hmrc_ni_example_7 =>
              hh.housing_costs( rent ) := 0.0;
              hh.wealth( property ) := 0.0;               
      when single_retired_person |
           couple_bu_retired |
           old_sick_single_male |
           care_home_resident =>
              hh.housing_costs( rent ) := 200.0;
              hh.wealth( property ) := 50_000.0;
      when young_single |
           young_couple |
           cpag_terry_and_julie |
           cpag_angelina_and_michael |
           zero_income |
           caring_couple |
           working_single_parent =>
              hh.housing_costs( rent ) := 200.0;
              hh.wealth( property ) := 50_000.0;
      end case;
      case which is
      when single_retired_person =>
         pers := Make_Retired_Adult( hh, 65, female, start_pid, head );
         hh.people( 1 ) := pers; 
      when old_sick_single_male =>
         hh.people( 1 ) := Make_Retired_Adult( hh, 90, male, start_pid, head );
      when couple_bu_retired     =>
         hh.people( 1 ) := Make_Retired_Adult( hh, 65, male, start_pid, head );
         hh.people( 1 ).marital_status := married_or_civil_partnership;
         start_pid := start_pid + 1;              
         hh.people( 2 ) := Make_Retired_Adult( hh, 65, female, start_pid, spouse );
         hh.people( 2 ).marital_status := married_or_civil_partnership;
      when cpag_terry_and_julie =>
         hh.people( 1 ) := Make_Retired_Adult( hh, 66, male, start_pid, head );
         hh.people( 1 ).incomes := ( others => 0.0 );
         hh.people( 1 ).incomes( retirement_pension ) := 163.0;
         hh.people( 1 ).incomes( private_pensions ) := 30.0;         
         start_pid := start_pid + 1;                       
         hh.people( 2 ) := Make_Retired_Adult( hh, 66, female, start_pid, spouse );
      when cpag_angelina_and_michael =>
         hh.people( 1 ) := Make_Retired_Adult( hh, 67, male, start_pid, head );
         hh.people( 1 ).incomes := ( others => 0.0 );
         hh.people( 1 ).incomes( retirement_pension ) := 102.15;
         hh.people( 1 ).incomes( private_pensions ) := 60.0;        
         hh.people( 1 ).marital_status := married_or_civil_partnership;

         start_pid := start_pid + 1;                       
         hh.people( 2 ) := Make_Retired_Adult( hh, 58, female, start_pid, spouse );         
         hh.people( 2 ).incomes( private_pensions ) := 60.0;
         hh.people( 2 ).marital_status := married_or_civil_partnership;

      when young_single =>
         hh.people( 1 ) := Make_Working_Adult( hh, 21, male, start_pid, head );
      when young_couple =>
         hh.people( 1 ) := Make_Working_Adult( hh, 21, male, start_pid, head );
         hh.people( 1 ).marital_status := married_or_civil_partnership;
         start_pid := start_pid + 1;                       
         hh.people( 2 ) := Make_Working_Adult( hh, 21, female, start_pid, spouse);
         hh.people( 2 ).marital_status := married_or_civil_partnership;
      when working_single_parent =>
         hh.people( 1 ) := Make_Working_Adult( hh, 30, female, start_pid, head );
         hh.people( 1 ).incomes( wages ) := 250.00;
         hh.people( 1 ).hours_worked := 20;
         start_pid := start_pid + 1;                       
         hh.people( 2 ) := Make_Child( hh, 12, female, start_pid );
       when zero_income =>   
         hh.people( 1 ) := Make_Retired_Adult( hh, 69, female, start_pid, head );
         hh.people( 1 ).incomes := ( others => 0.0 );
         hh.people( 1 ).incomes( retirement_pension ) := 0.0;
         hh.people( 1 ).incomes( private_pensions ) := 0.0;  
         hh.people( 1 ).employment := retired;
      when care_home_resident =>
         pers := Make_Retired_Adult( hh, 90, female, start_pid, head );
         hh.people( 1 ).incomes := ( others => 0.0 );
         hh.people( 1 ).incomes( retirement_pension ) := 100.0;
         hh.people( 1 ).incomes( private_pensions ) := 100.0;
         hh.people( 1 ).employment := retired;
      when caring_couple =>
         pers := Make_Retired_Adult( hh, 80, female, start_pid, head );
         hh.people( 1 ).incomes := ( others => 0.0 );
         hh.people( 1 ).incomes( retirement_pension ) := 100.0;
         hh.people( 1 ).incomes( private_pensions ) := 100.0;
         hh.people( 1 ).marital_status := married_or_civil_partnership;
         start_pid := start_pid + 1;                                
         hh.people( 2 ) := Make_Retired_Adult( hh, 80, male, start_pid, spouse );
         hh.people( 2 ).incomes := ( others => 0.0 );
         hh.people( 2 ).incomes( retirement_pension ) := 100.0;
         hh.people( 2 ).incomes( private_pensions ) := 100.0;
         hh.people( 2 ).marital_status := married_or_civil_partnership;
      when hmrc_ni_example_1 =>  -- P 20-26 of "National Insurance Contributions guidance for software developers "
         -- A 28 year old employee earns £112.53 a week and pays standard NICs
         hh.people( 1 ) := Make_Working_Adult( hh, 28, male, start_pid, head );
         hh.people( 1 ).marital_status := single;
         hh.people( 1 ).incomes := ( wages => 112.53, others => 0.0 );
      when hmrc_ni_example_2 => 
         -- A 44 year old employee earns £869 a week and pays standard NICs
         hh.people( 1 ) := Make_Working_Adult( hh, 44, male, start_pid, head );
         hh.people( 1 ).marital_status := single;
         hh.people( 1 ).incomes := ( wages => 869.00, others => 0.0 );
      when hmrc_ni_example_4 => 
         -- A 19 year old employee earns £834 a week and pays standard NICs
         hh.people( 1 ) := Make_Working_Adult( hh, 19, male, start_pid, head );
         hh.people( 1 ).marital_status := single;
         hh.people( 1 ).incomes := ( wages => 834.00, others => 0.0 );
      when hmrc_ni_example_7 => null;
         hh.people( 1 ) := Make_Working_Adult( hh, 19, male, start_pid, head );
         hh.people( 1 ).marital_status := single;
         hh.people( 1 ).incomes := ( wages => 52_000.0/52.0, others => 0.0 );
         -- example 7: An 18 year old director for the whole tax year earns £52,000. Pays standard
         -- NICs. Has paid no NICs to date.
      end case;
      return hh;
   end Make_Household;
   
   function Get_Household( which : Example_Type ) return Household is
   use Ada.Calendar;
      pid  : Sernum_Value;
      hid  : Sernum_Value;
      year : Year_Number := 2016;      
   begin
      case which is
      when single_retired_person =>
         pid := 1_000_001;
         hid := 1_000_000;
      when old_sick_single_male =>
         hid := 2_000_000;
         pid := 2_000_001;
      when couple_bu_retired     =>
         hid := 3_000_000;
         pid := 3_000_001;
      when cpag_terry_and_julie =>
         hid := 4_000_000;
         pid := 4_000_001;
      when cpag_angelina_and_michael =>
         hid := 5_000_000;
         pid := 5_000_001;
      when young_single =>
         hid := 6_000_000;
         pid := 6_000_001;
      when young_couple =>
         hid := 10_000_000;
         pid := 10_000_001;
       when zero_income =>   
         hid := 9_000_000;
         pid := 9_000_001;
      when care_home_resident =>
         hid := 19_000_001;
         pid := 19_000_001;
      when caring_couple =>
         hid := 29_000_000;
         pid := 29_000_001;
      when working_single_parent =>
         hid := 39_000_000;
         pid := 39_000_001;
      when hmrc_ni_example_1 => 
         hid := 40_000_000;
         pid := 40_000_001;
      when hmrc_ni_example_2 => 
         hid := 41_000_000;
         pid := 41_000_001;
      when hmrc_ni_example_4 => null;
         hid := 42_000_000;
         pid := 42_000_001;
      when hmrc_ni_example_7 => null;
         hid := 43_000_000;
         pid := 43_000_001;
      end case;
      return Make_Household( which, hid, pid, year );
   end Get_Household;

end Model.Example_Household.Cases;