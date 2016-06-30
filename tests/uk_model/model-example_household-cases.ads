package Model.Example_Household.Cases is

   type Example_Type is (
      single_retired_person,
      couple_bu_retired,
      young_single,
      young_couple,
      old_sick_single_male,
      cpag_terry_and_julie, -- 2012 edn p 478
      cpag_angelina_and_michael,
      zero_income,
      care_home_resident,
      caring_couple,
      working_single_parent );
   
   function Get_Household( which : Example_Type ) return Household;
   
end Model.Example_Household.Cases;