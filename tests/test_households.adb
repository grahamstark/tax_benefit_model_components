--
--  $Author: graham_s $
--  $Date: 2008-04-13 21:06:20 +0100 (Sun, 13 Apr 2008) $
--  $Revision: 4999 $
--
with Base_Model_Types; use Base_Model_Types;
with Model.Household;  use Model.Household;
with FRS_Enums;        use FRS_Enums;

package body test_households is

   function makeSomeExpenses return Expenses_Array is
      exp : Expenses_Array;
   begin
      exp := (travel_expenses => 100.0, maintenance_payments => 5000.0, friendly_societies => 300.0, others => 0.0);
      return exp;
   end makeSomeExpenses;

   function makeSomeFinances return Finance_Array is
      exp : Finance_Array;
   begin
      exp := (loan_repayments => 5000.0, fines_and_transfers => 120.0, others => 0.0);
      return exp;
   end makeSomeFinances;

   function rentHcosts return Model_Housing_Costs is
      housing_Costs : Model_Housing_Costs;
   begin
      housing_Costs.gross_council_tax     := 5000.0;
      housing_Costs.rent                  := 4000.0;
      housing_Costs.mortgages             := 6000.0;
      housing_Costs.water_rates           := 0.0;
      housing_Costs.ground_rent           := 500.0;
      housing_Costs.service_charges       := 1000.0;
      housing_Costs.repairs_And_Insurance := 1000.0;
      return housing_Costs;
   end rentHcosts;

   --
   -- housing costs of 5,520 for Framwwork doc example 3
   --
   function ownerHcosts return Model_Housing_Costs is
      housing_Costs : Model_Housing_Costs;
   begin
      housing_Costs.gross_council_tax     := 1_000.0;
      housing_Costs.rent                  := 0.0;
      housing_Costs.mortgages             := 4_520.0;
      housing_Costs.water_rates           := 0.0;
      housing_Costs.ground_rent           := 0.0;
      housing_Costs.service_charges       := 0.0;
      housing_Costs.repairs_And_Insurance := 0.0;
      return housing_Costs;
   end ownerHcosts;

   --  these are the equivalisation example households on pp 28- of CM6678.

   function make_crimimal_case_eq_1 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.housing_costs                                   := rentHcosts;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (spouse).sex           := female;
      hh.benefit_units (1).last_adult                    := head;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (head).incomes (wages) := 24_000.0;
      return hh;
   end make_crimimal_case_eq_1;

   function make_crimimal_case_eq_2 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (spouse).sex           := female;
      hh.benefit_units (1).last_adult                    := spouse;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (spouse).age           := 62;
      hh.benefit_units (1).adults (head).incomes (wages) := 24_000.0;
      return hh;
   end make_crimimal_case_eq_2;

   function make_crimimal_case_eq_3 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.benefit_units (1).last_adult                    := spouse;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (spouse).sex           := female;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (spouse).age           := 62;
      hh.benefit_units (1).adults (head).incomes (wages) := 24_000.0;
      hh.benefit_units (1).num_children                  := 1;
      hh.benefit_units (1).children (1).age              := 3;
      return hh;
   end make_crimimal_case_eq_3;

   function make_crimimal_case_eq_4 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.benefit_units (1).last_adult                    := spouse;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (spouse).age           := 62;
      hh.benefit_units (1).adults (head).incomes (wages) := 24_000.0;
      hh.benefit_units (1).num_children                  := 2;
      hh.benefit_units (1).children (1).age              := 6;
      hh.benefit_units (1).children (2).age              := 3;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (spouse).sex           := female;

      return hh;
   end make_crimimal_case_eq_4;

   --
   --  ==============  these are the hhlds on pp 7-8 of the English Civil Framwork doc
   --  (CM6678.)
   --
   function make_crimimal_case_1 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.benefit_units (1).last_adult                    := head;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (head).incomes (wages) := 24_000.0;
      hh.benefit_units (1).adults (head).sex             := female;
      return hh;
   end make_crimimal_case_1;

   function make_crimimal_case_2 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                                    := 1;
      hh.tenure                                               := buying_with_the_help_of_a_mortgage;
      hh.benefit_units (1).last_adult                         := spouse;
      hh.housing_costs                                        := ownerHcosts;
      hh.benefit_units (1).adults (head).sex                  := male;
      hh.benefit_units (1).adults (spouse).sex                := female;
      hh.benefit_units (1).adults (head).age                  := 62;
      hh.benefit_units (1).adults (spouse).age                := 62;
      hh.benefit_units (1).adults (head).incomes (wages)      := 24_000.0;
      hh.benefit_units (1).adults (head).incomes (income_Tax) := 6124.0;

      return hh;
   end make_crimimal_case_2;

   function make_crimimal_case_3 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                                    := 1;
      hh.tenure                                               := buying_with_the_help_of_a_mortgage;
      hh.benefit_units (1).last_adult                         := spouse;
      hh.housing_costs                                        := ownerHcosts;
      hh.benefit_units (1).adults (head).age                  := 62;
      hh.benefit_units (1).adults (spouse).age                := 62;
      hh.benefit_units (1).adults (head).incomes (wages)      := 24_000.0;
      hh.benefit_units (1).adults (head).incomes (income_Tax) := 6124.0;
      hh.benefit_units (1).adults (head).sex                  := male;
      hh.benefit_units (1).adults (spouse).sex                := female;
      hh.benefit_units (1).num_children                       := 1;
      hh.benefit_units (1).children (1).age                   := 3;
      return hh;
   end make_crimimal_case_3;

   function make_crimimal_case_4 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.benefit_units (1).last_adult                    := spouse;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (spouse).age           := 62;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (spouse).sex           := female;
      hh.benefit_units (1).adults (head).incomes (wages) := 24_000.0;
      hh.benefit_units (1).num_children                  := 2;
      hh.benefit_units (1).children (1).age              := 6;
      hh.benefit_units (1).children (2).age              := 3;
      return hh;
   end make_crimimal_case_4;

   function makeHH4 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.housing_costs                                   := rentHcosts;
      hh.benefit_units (1).last_adult                    := spouse;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (spouse).sex           := female;
      hh.benefit_units (1).adults (spouse).age           := 30;
      hh.benefit_units (1).adults (spouse).capital_stock := 40000.0;
      return hh;
   end makeHH4;

   function makeHH3 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                               := 1;
      hh.tenure                                          := rents;
      hh.housing_costs                                   := rentHcosts;
      hh.benefit_units (1).last_adult                    := spouse;
      hh.benefit_units (1).adults (head).sex             := male;
      hh.benefit_units (1).adults (head).age             := 62;
      hh.benefit_units (1).adults (spouse).age           := 30;
      hh.benefit_units (1).adults (spouse).sex           := female;
      hh.benefit_units (1).adults (spouse).capital_stock := 1871.0;
      return hh;
   end makeHH3;

   function makeHH2 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                     := 2;
      hh.tenure                                := rents;
      hh.housing_costs                         := rentHcosts;
      hh.benefit_units (1).last_adult          := spouse;
      hh.benefit_units (1).adults (head).age   := 20;
      hh.benefit_units (1).adults (spouse).age := 30;
      hh.benefit_units (1).adults (head).sex   := male;
      hh.benefit_units (1).adults (spouse).sex := female;

      hh.benefit_units (2).last_adult          := spouse;
      hh.benefit_units (2).adults (head).sex   := male;
      hh.benefit_units (2).adults (head).age   := 20;
      hh.benefit_units (2).adults (spouse).age := 30;
      hh.benefit_units (2).adults (spouse).sex := female;
      return hh;
   end makeHH2;

   function makeHH1 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                                          := 1;
      hh.tenure                                                     := buying_with_the_help_of_a_mortgage;
      hh.housing_costs                                              := rentHcosts;
      hh.benefit_units (1).last_adult                               := spouse;
      hh.benefit_units (1).adults (head).age                        := 20;
      hh.benefit_units (1).adults (spouse).age                      := 30;
      hh.benefit_units (1).adults (spouse).incomes (income_support) := 30.0;
      hh.benefit_units (1).adults (head).sex                        := male;
      hh.benefit_units (1).adults (spouse).sex                      := female;

      hh.benefit_units (1).num_children     := 3;
      hh.benefit_units (1).children (1).age := 8;
      hh.benefit_units (1).children (2).age := 19;
      hh.benefit_units (1).children (3).age := 16;
      return hh;
   end makeHH1;

   function makeHH0 return Household_Rec is
      hh : Household_Rec;
   begin
      hh.num_benefit_units                                    := 1;
      hh.benefit_units (1).last_adult                         := head;
      hh.tenure                                               := buying_with_the_help_of_a_mortgage;
      hh.housing_costs                                        := rentHcosts;
      hh.benefit_units (1).adults (head).incomes (wages)      := 10000.0;
      hh.benefit_units (1).adults (head).incomes (income_Tax) := 100.0;
      hh.benefit_units (1).adults (head).sex                  := male;

      hh.benefit_units (1).num_children      := 1;
      hh.benefit_units (1).adults (head).age := 20;
      hh.benefit_units (1).children (1).age  := 14;
      return hh;
   end makeHH0;

   --
   --  households from equivilisation examples from cmd 6678 pp 28-9
   --
   function make_Equiv_Example_Households return Test_Household_Array is
      equiv_HHs : Test_Household_Array;
   begin
      equiv_HHs (1) := make_crimimal_case_eq_1;
      equiv_HHs (2) := make_crimimal_case_eq_2;
      equiv_HHs (3) := make_crimimal_case_eq_3;
      equiv_HHs (4) := make_crimimal_case_eq_4;
      return equiv_HHs;
   end make_Equiv_Example_Households;

   --
   --  households from examples from cmd 6678 pp 7-8
   --
   function make_Criminal_Households return Test_Household_Array is
      criminal_HHs : Test_Household_Array;
   begin
      criminal_HHs (1) := make_crimimal_case_1;
      criminal_HHs (2) := make_crimimal_case_2;
      criminal_HHs (3) := make_crimimal_case_3;
      criminal_HHs (4) := make_crimimal_case_4;
      return criminal_HHs;
   end make_Criminal_Households;

   function makeExampleHouseholds return Test_Household_Array is
      testHHs : Test_Household_Array;
   begin
      testHHs (1) := makeHH0;
      testHHs (2) := makeHH1;
      testHHs (3) := makeHH2;
      testHHs (4) := makeHH3;
      testHHs (5) := makeHH4;
      return testHHs;
   end makeExampleHouseholds;

end test_households;
