with Ada.Assertions;
with Ada.Text_IO;
with Ada.Calendar;

with Base_Model_Types;
with Text_Utils;

with Model_Types;
with Model.Calculator.Universal_Credit;
with Model.Calculator.Direct_Tax;
with Model.Calculator.Foster_Care_Sim;
with Model.Parameter_System.Defaults;
with Optimiser;

package body Model.Calculator.Driver is

   use Ada.Assertions;
   use Ada.Text_IO;
   use Example_Data;
   use Ada.Calendar;
   use Text_Utils;

   
   procedure Do_Main_Calculations(
      sys            : Model.Parameter_System.Complete_System;
      hh             : Example_Data.Household;
      results        : in out Model.Results.Household_Result ) is
   use Example_Data.Model_Household;
   use Model_Types;
   use Base_Model_Types;
      mhh : Model.Abstract_Household.Household'Class := Map_Household( hh );
   begin
      for buno in  1 .. mhh.Get_Num_Benefit_Units loop
         declare
            bu : Model.Abstract_Household.Benefit_Unit'Class := mhh.Get_Benefit_Unit( buno );
            bres : Model.Results.Benefit_Unit_Result renames results.bus( buno );
            housing : Housing_Array := ( others => 0.0 );
            tenure  : Tenure_Type := mhh.Get_Tenure_Type;
         begin
            if buno = 1 then
               housing( rent ) := mhh.Get_Housing_Cost( rent );
            elsif bu.Get_Num_People = 1 and buno > 1 then  -- Person( 1 ).Family_Relationship = foster_child then
               housing( rent ) := sys.uc.one_bedroom_in_shared_accommodation_rate;               
            end if;
            Put_Line( "bu " & buno'Img & " got rent as " & Format( housing( rent ))); 
            Model.Calculator.Universal_Credit.Calculate_Child_Benefit( sys.cb, bu, bres );
            for pno in 1 .. bu.Get_Num_People loop
               declare
                  pres :Model.Results.Personal_Result renames bres.pers( pno );
                  person : Model.Abstract_Household.Person'Class := bu.Get_Person( pno );
                  example_person : Example_Data.Person renames hh.benefit_units( buno ).people( pno );
               begin
                  Model.Calculator.Direct_Tax.Calculate_Income_Tax( sys.it, person, pres );
                  Model.Calculator.Direct_Tax.Calculate_National_Insurance( 
                     sys.ni,
                     sys.benefits.state_pension,                     
                     person, 
                     pres );
                  Model.Calculator.Foster_Care_Sim.Calculate_Student_Loan_Repayments( sys.sl, example_person, pres );
               end;
            end loop;
            Model.Calculator.Universal_Credit.Calculate_Universal_Credit( sys.uc, tenure, housing, bu, bres );
            Put_Line( To_String( bres.intermed, "" ));            
         end;
      end loop;
      Model.Calculator.Direct_Tax.Make_Household_Taxable_Income( mhh, results );
   end Do_Main_Calculations;
   
   procedure Calculate_Crude_Council_Tax(
      hh  : Household;
      res : in out Model.Results.Household_Result ) is
   use Model_Types;
      BAND_A : constant Rate := 2.0/3.0;
      WALES_AVERAGE_BAND_D_CT : constant Amount := 1_063.0;
   begin
      if( hh.num_benefit_units = 1 ) then
         if( hh.benefit_units( 1 ).people( 1 ).years_fostered > 0.0 )then
            if( res.bus( 1 ).pers( 1 ).incomes( housing_benefit ) = 0.0 )then
               if( hh.benefit_units( 1 ).people( 1 ).income( wages ) > 15_000.0 )then
                  res.bus( 1 ).pers( 1 ).incomes( local_taxes ) := WALES_AVERAGE_BAND_D_CT;
               else
                  res.bus( 1 ).pers( 1 ).incomes( local_taxes ) := WALES_AVERAGE_BAND_D_CT*BAND_A;
               end if;
            else
               res.bus( 1 ).pers( 1 ).incomes( local_taxes ) := 0.2*BAND_A*WALES_AVERAGE_BAND_D_CT;
               res.bus( 1 ).pers( 1 ).incomes( council_tax_benefit ) := 0.8*BAND_A*WALES_AVERAGE_BAND_D_CT;                  
            end if;
         end if;
      end if;
   end Calculate_Crude_Council_Tax;

   procedure Run_Model( 
      events       : Events_List; 
      system       : Model.Parameter_System.Complete_System;
      which_hh     : HH_Type;
      target_pid   : Positive;
      results      : out Model.Results.Household_Result;
      outfile_name : String  ) is
         
      use Model.Parameter_System;
      use Model.Results;
      use Model.Abstract_Household;
      use Example_Data;
      use Example_Data.Model_Household;
      use Example_Data.Examples;
      use Base_Model_Types;
      use Model_Types;
      use Text_Utils;

      budget_expenditures : Budget_By_Year( events'Range ) := ( others => ( others => 0.0 ));
      budget_receipts     : Budget_By_Year( events'Range ) := ( others => ( others => 0.0 ));
      f                   : File_Type;
      
         
      procedure Calculate_And_Print_Present_Values is
         gross_expenditures              : Budget_Array;
         gross_receipts                  : Budget_Array;
         net_expenditures                : Budget_Array;
         overall_gross_expenditures      : Amount;
         overall_gross_receipts          : Amount;
         overall_net_expenditures        : Amount;      
         gross_expenditures_zero         : Budget_Array;
         gross_receipts_zero             : Budget_Array;
         net_expenditures_zero           : Budget_Array;
         overall_gross_expenditures_zero : Amount;
         overall_gross_receipts_zero     : Amount;
         overall_net_expenditures_zero   : Amount;      
      begin
         Model.Results.NPVs( 
            budget_expenditures,
            budget_receipts,
            0.035,
            gross_expenditures,        
            gross_receipts,            
            net_expenditures,          
            overall_gross_expenditures,
            overall_gross_receipts,    
            overall_net_expenditures );  
         Model.Results.NPVs( 
            budget_expenditures,
            budget_receipts,
            0.0,
            gross_expenditures_zero,        
            gross_receipts_zero,            
            net_expenditures_zero,          
            overall_gross_expenditures_zero,
            overall_gross_receipts_zero,    
            overall_net_expenditures_zero );
         Put_Line( f, "Present Values  " );
         Put_Line( f, ",,Discounted 3.5%" );
         Put_Line( f, " ,Expenditure, Receipts, Net Expenditure" );
         for b in Budget_Array'Range loop
            Put_Line( f, Prettify_Image( Budget_Type'Image( b )) & "," & 
               Format( gross_expenditures( b )) & "," &
               Format( gross_receipts( b )) & "," &
               Format( net_expenditures( b )) & ",,");
         end loop;
         Put_Line( f, "Overall budgets" & "," & 
            Format( overall_gross_expenditures ) & "," &
            Format( overall_gross_receipts ) & "," &
            Format( overall_net_expenditures ) & "," );
         Put_Line( f, ",,Undiscounted" );
         Put_Line( f, " ,Expenditure, Receipts, Net Expenditure" );
         for b in Budget_Array'Range loop
            Put_Line( f, Prettify_Image( Budget_Type'Image( b )) & "," & 
               Format( gross_expenditures_zero( b )) & "," &
               Format( gross_receipts_zero( b )) & "," &
               Format( net_expenditures_zero( b )) & ",,");
         end loop;
         Put_Line( f, "Overall budgets" & "," &
            Format( overall_gross_expenditures_zero) & "," &
            Format( overall_gross_receipts_zero) & "," &
            Format( overall_net_expenditures_zero ));
      end Calculate_And_Print_Present_Values;

      parents_results     : Model.Results.Household_Result;
      household_has_split : Boolean := False;
      parents_household   : Example_Data.Household;
      Age_Only            : Events_Set;
      eh                  : Example_Data.Household := Example_Data.Household( Example_Data.Examples.Get_Household( which_hh ));
      found               : Boolean;
      target_person       : Example_Data.Person;
      target_buno         : Benefit_Unit_Number;
      target_pno          : Person_Number;
   begin
      Create( f, Out_File, outfile_name );
      Put( f, "Year," );
      Put( f, Example_Data.Event_String_Header( ',', 5 ));
      Put( f, Example_Data.Summary_String_Header( ',' ));
      Put( f , Model.Results.Budget_Header( ',', ": EXPENDITURE" ));
      Put( f , Model.Results.Budget_Header( ',', ": RECEIPTS" ));
      Put( f, Model.Results.Summary_String_Header( ',' ));
      Put( f, ",vat" );
      New_Line( f );
      results.Zero( including_stocks => true );
      parents_results.Zero( including_stocks => true );
      years:
      for year in events'Range loop
         -- budget_expenditures := ( others => 0.0 );
         -- budget_receipts := ( others => 0.0 );
         results.Zero( including_stocks => False );
         parents_results.Zero( including_stocks => False );
         Put_Line( "on year " & year'Img );
         if( household_has_split )then
            parents_household.Trigger_Events( parents_household, Age_Only, 1 );
         end if;
         eh.Trigger_Events( parents_household, events( year ), target_pid );
         if events( year ).Contains_Event( leave_household ) then
            household_has_split := True;
            Put_Line( "new household " & To_String( eh ));
            Put_Line( "old household " & To_String( parents_household ));
         end if;
         eh.Find_Person( target_pid, target_buno, target_pno, found );
         Assert( found, "PID " & target_pid'Img & " not found" );
         target_person := eh.benefit_units( target_buno ).people( target_pno );
         Put_Line( "main calculations on split off " );
         Do_Main_Calculations( system, eh, results );
         Model.Calculator.Foster_Care_Sim.Calculate_Foster_Care_Payments(
            system.fp, eh, results );
         if( household_has_split )then
            Put_Line( "main calculations on remaining" );
            Model.Calculator.Foster_Care_Sim. Calculate_Foster_Care_Payments(
               system.fp,
               parents_household,
               parents_results );
            Do_Main_Calculations( system, parents_household, parents_results );
         end if;
         Put_Line( "Age now " & eh.benefit_units( 1 ).people( 1 ).age'Img );
         if household_has_split and
            target_person.years_fostered = 0.0 and
            target_person.age < 25 then
            Model.Calculator.Foster_Care_Sim.Get_Student_Grants_And_Loans(
               system.sl,
               parents_household,
               events( year ),
               not household_has_split,
               target_person,
               parents_results.total_taxable_income,
               results.bus( target_buno ).pers( target_pno ));
         else
            Model.Calculator.Foster_Care_Sim.Get_Student_Grants_And_Loans(
               system.sl,
               eh,
               events( year ),
               not household_has_split,
               target_person,
               results.total_taxable_income,
               results.bus( target_buno ).pers( target_pno ));
         end if;
         Model.Calculator.Foster_Care_Sim.Calculate_Activity_Costs(
            system.sc,
            target_person,
            events( year ),
            results.bus( target_buno ).pers( target_pno ));
         -- CT of just the hh with the foster child, and just in the
         -- case 
         Calculate_Crude_Council_Tax( eh, results );
         Model.Calculator.Direct_Tax.Make_Household_Net_Income( 
            Map_Household( eh ), results ); 
         results.bus( target_buno ).pers( target_pno ).Assign_To_Budgets( 
            budget_expenditures( year ), budget_receipts( year ));
         if household_has_split then
            Model.Calculator.Direct_Tax.Make_Household_Net_Income( 
               Map_Household( parents_household ), parents_results );
         end if;
         declare
            vatr : constant Rate := system.indir.vat / ( 1.0 + system.indir.vat );
            vatable : constant Amount := 
               Example_Data.Vatable_Expenditure( 
                  target_person, 
                  results.bus( target_buno ).pers( target_pno ).net_income );             
         begin
            Put_Line( "net income " & Format( results.bus( target_buno ).pers( target_pno ).net_income ) & 
                      " vatable " & Format( vatable ) & 
                      " vatr " & Format( system.indir.vat ));
            results.vat := vatable * vatr;
            Inc( budget_receipts( year )( uk_government ), results.vat );
            Put_Line( "=>VAT "& Format( results.vat ));
         end;
         -- foster payments are allocated to 1st person 1st ben unit
         Inc( budget_expenditures( year)( childrens_services ), 
              results.bus( 1 ).pers( 1 ).incomes( foster_care_payments ));
         if( events( year ).Contains_Event( arbitrary_event ))then
            declare
               arb : Events_Set'Class := events( year ).Find_Events( arbitrary_event, found );
            begin
               for ev of arb loop 
                  Inc( budget_expenditures( year)( ev.cost_centre ), ev.value );
               end loop;
            end;
         end if;
         Put( f, year'Img & "," & To_String( events( year ), 5, ',' ));
         Put( f, target_person.Summary_String( ',' ));
         Put( f, To_String( budget_expenditures( year ), ',' ));
         Put( f, To_String( budget_receipts( year ), ',' ));
         Put( f, results.bus( target_buno ).pers( target_pno ).Summary_String( ',' ));
         Put_Line( f, To_String( results.vat ));
      end loop years;
      Calculate_And_Print_Present_Values;      
      Close( f );
   end Run_Model;

end Model.Calculator.Driver;
