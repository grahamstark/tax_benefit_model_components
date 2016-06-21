package body Model.Example_Household.Cases;

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
      end case
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
      ad.income( retirement_pension ) := 6_000.0/52.0;
      ad.employment_status := retired;  
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
      ad.year := year;
      ad.wealth( financial ) := 5_000;
      ad.income( wages ) := 1_000.00;
      ad.age := age;
      ad.employment_status := full_time;  
      ad.relationship := relationship;
      return ad;
   end Make_Working_Adult;

   function Make_Child( 
      hh        : Household;
      age       : Age_Range; 
      sex       : Gender_Type; 
      pid       : Sernum_Value ) return Person is
      child : Person;   
   begin
      child.age := age;
      child.sex := sex;
      child.pid := pid;
      child.age := age;
      child.employment_status := in_education;  
      child.relationship := child;
      return child;
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
      when single_retired_person |
           couple_bu_retired |
           old_sick_single_male |
           care_home_resident =>
              hh.housing_costs( rent ) := 200.0;
              hh.wealth( housing ) := 50_000.0;
      when young_single |
           young_couple |
           cpag_terry_and_julie |
           cpag_angelina_and_michael |
           zero_income |
           caring_couple |
           working_single_parent =>
              hh.housing_costs( rent ) := 200.0;
              hh.wealth( housing ) := 50_000.0;
      end case;
      case which is
      when single_retired_person =>
         pers := Make_Retired_Adult( hh, 65, female, start_pid );
         hh.person( 1 ) := pers; 
      when old_sick_single_male =>
         hh.person( 1 ) := Make_Retired_Adult( hh, 90, male, start_pid, head );
      when couple_bu_retired     =>
         hh.person( 1 ) := Make_Retired_Adult( hh, 65, male, start_pid, head );
         start_pid := start_pid + 1;              
         hh.people( 2 ) := Make_Retired_Adult( hh, 65, female, start_pid, spouse );
      when cpag_terry_and_julie =>
         hh.people( 1 ) := Make_Retired_Adult( hh, 66, male, start_pid, True, excellent, year );
         hh.people( 1 ).income := ( others => 0.0 );
         hh.people( 1 ).income( retirement_pension ) := 163.0;
         hh.people( 1 ).income( private_pensions ) := 30.0;         
         start_pid := start_pid + 1;                       
         hh.people( 2 ) := Make_Retired_Adult( hh, 66, female, start_pid, True, excellent, year );
      when cpag_angelina_and_michael =>
         pers := Make_Retired_Adult( hh, 67, male, start_pid, True, excellent, year );
         pers.income := ( others => 0.0 );
         pers.income( retirement_pension ) := 102.15;
         pers.income( private_pensions ) := 60.0;
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                       
         pers := Make_Retired_Adult( hh, 58, female, start_pid, True, excellent, year );         
         pers.income( private_pensions ) := 60.0;
         hh.add_Person( 
            The_Person         => pers, 
            BUNo               => 1, 
            Is_Head            => False, 
            Is_Spouse_of_Head  => True, 
            Is_Dependent_Child => False );
         start_pid := start_pid + 1;                       
      when young_single =>
         pers := Make_Working_Adult( hh, 21, male, start_pid, False, excellent, year );
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                       
      when young_couple =>
         pers := Make_Working_Adult( hh, 21, male, start_pid, True, excellent, year );
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                       
         pers := Make_Working_Adult( hh, 21, female, start_pid, True, excellent, year );
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => False, 
            Is_Spouse_of_Head => True, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                       
      when working_single_parent =>
         pers := Make_Working_Adult( hh, 30, female, start_pid, True, excellent, year );
         pers.income( wages ) := 250.00;
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                       
         pers := Make_Child( hh, 12, female, start_pid, True, excellent, year );
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => False, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> True );
            
         start_pid := start_pid + 1;                       
       when zero_income =>   
         pers := Make_Retired_Adult( hh, 69, female, start_pid, False, excellent, year );
         pers.income := ( others => 0.0 );
         pers.income( retirement_pension ) := 0.0;
         pers.income( private_pensions ) := 0.0;  
         pers.income( alimony_and_child_support_received ) := 0.0;  
         pers.income( attendance_allowance ) := 0.0;  
         pers.employment_status := retired;
         start_pid := start_pid + 1;                       
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
      when care_home_resident =>
         hh.hdata.is_care_home := True;
         pers := Make_Retired_Adult( hh, 90, female, start_pid, False, poor, year );
         pers.income := ( others => 0.0 );
         pers.income( retirement_pension ) := 100.0;
         pers.income( private_pensions ) := 100.0;
         pers.years_in_residential_care := 1;
         pers.employment_status := retired;
         
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                                
      when caring_couple =>
         hh.hdata.is_care_home := True;
         pers := Make_Retired_Adult( hh, 80, female, start_pid, True, poor, year );
         pers.income := ( others => 0.0 );
         pers.income( retirement_pension ) := 100.0;
         pers.income( private_pensions ) := 100.0;
         pers.years_in_residential_care := 0;
         pers.hours_of_care_given := 60.0;
         pers.hours_of_care_received := 0.0;
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => True, 
            Is_Spouse_of_Head => False, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                                
         pers := Make_Retired_Adult( hh, 80, male, start_pid, True, poor, year );
         pers.income := ( others => 0.0 );
         pers.income( retirement_pension ) := 100.0;
         pers.income( private_pensions ) := 100.0;
         pers.years_in_residential_care := 0;
         pers.hours_of_care_given := 0.0;
         pers.hours_of_care_received := 60.0;
         hh.add_Person( 
            The_Person        => pers, 
            BUNo              => 1, 
            Is_Head           => False, 
            Is_Spouse_of_Head => True, 
            Is_Dependent_Child=> False );         
         start_pid := start_pid + 1;                                
      end case;
      return hh;
   end Make_Household;
   
   function Get_Household( which : Example_Type ) return Household is
   use Ada.Calendar;
      pid  : Sernum_Value;
      hid  : Sernum_Value;
      year : Year_Number := 2015;      
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
      end case;
      return Make_Household( which, hid, pid, year );
   end Get_Household;

end Model.Example_Household.Cases;