--
--  $Author: graham_s $
--  $Date: 2013-06-10 10:37:23 +0100 (Mon, 10 Jun 2013) $
--  $Revision: 16196 $
--
pragma License( Modified_GPL );

with Model.Uprate;
with GNATColl.Traces;
with Ada.Calendar;     
with Text_Utils;       
with Ada.Direct_IO;
--
--
--
package body Model.Household is


   use Base_Model_Types;
   use Model.Uprate;
   use Ada.Calendar;
   use Text_Utils;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL.HOUSEHOLD" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
  

   function person_count (hh : Household_Rec) return Natural is
      count : Natural := 0;
   begin
      for buno in  1 .. hh.num_benefit_units loop
         for adno in  head .. hh.benefit_units (buno).last_adult loop
            count := count + 1;
         end loop;
         count := count + hh.benefit_units (buno).num_children;
      end loop;
      return count;
   end person_count;

   function Load (hhFile : hh_io.File_Type; hhseq : Positive) return Household_Rec is
      hh           : Household_Rec;
      currentHHPos : hh_io.Count;
   begin
      currentHHPos := hh_io.Count (hhseq);
      hh_io.Set_Index (hhFile, currentHHPos);
      hh_io.Read (hhFile, hh);
      --
      --  On load, we need to swap in the un-uprated one of our two new house price
      --  estimates, and use that to derive housing equity.
      --  On uprating, we just swap in the uprated version, rather than uprating using the
      --  macro variables ourselves.
      --
      hh.housing_costs.house_price := hh.housing_costs.estimated_house_price_actual;
      hh.housing_costs.home_equity := hh.housing_costs.house_price -
                                      hh.housing_costs.mortgages_outstanding;
      return hh;
   end load;

   --
   --  open files; load uprating information.
   --
   procedure Initialise
     (data_dir : Unbounded_String;
      hh_file : out hh_io.File_Type;
      frsYear : Data_Constants.Data_Years;
      sz      : out Natural;
      write   : Boolean := False)
   is
      filename : String := TS(data_dir) & "model_data_" & DATA_YEAR_STRINGS (frsYear) & ".bin";
   begin
      Log( "opening " & filename );
      if (write) then
         hh_io.Create
           (hh_file,
            hh_io.Out_File,
            filename );
         sz := 0;
      else
         hh_io.Open
           (hh_file,
            hh_io.In_File,
            filename
            );
         sz := Natural( hh_io.Size( hh_file ));
         
      end if;
      Log(  "opened " & filename & " got size as " & Natural'Image(sz) );
   end initialise;

   function hasDependents (bu : Model_Benefit_Unit) return Boolean is
   begin
      return (bu.num_children > 0) or (bu.last_adult = spouse);
   end hasDependents;

   function To_String( adult : Model_Adult ) return String is
      outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
   begin
      ustr.Append (outs, Indent(2) & "****************************" & stda.LF);
      ustr.Append
        (outs,
         Indent(2) &
         "age : " &
         adult.age'Img &
         " sex " &
         adult.sex'Img &
         " marital_status " &
         pretty_print (adult.marital_status) &
         " rel to HoH " &
         pretty_print (adult.relToHoH) &
         stda.LF);

      ustr.Append (outs, Indent(2) & "is_lodger=" & adult.is_lodger'Img & stda.LF);
      ustr.Append (outs, " employment=" & pretty_print (adult.employment));
      ustr.Append (outs, " ILO employment=" & pretty_print (adult.ilo_employment));
      ustr.Append (outs, " has_company_car=" & adult.has_company_car'Img);
      ustr.Append (outs, " capital_stock=" & adult.capital_stock'Img & stda.LF);
      ustr.Append (outs, " ethnic = " & pretty_print (adult.ethnic_group) & stda.LF);

      for i in  Income_Items loop
         if (adult.incomes (i) /= 0.0) then
            ustr.Append
              (outs,
               Indent(2)& i'Img & " :  " & Format_With_Commas(adult.incomes (i)) & stda.LF);
         end if;
      end loop;
      ustr.Append (outs, Indent(2) & "*** Expenses *** " & stda.LF);
      for i in  Expense_Items loop
         if (adult.expenses (i) /= 0.0) then
            ustr.Append
              (outs,
               Indent(2) & i'Img & " :  " & Format_With_Commas(adult.expenses (i)) & stda.LF);
         end if;
      end loop;
      ustr.Append (outs, Indent(2) & "*** Finance *** " & stda.LF);
      for i in  Finance_Items loop
         if (adult.finance (i) /= 0.0) then
            ustr.Append (outs, "        " & i'Img & " :  " & Format_With_Commas(adult.finance (i)) & stda.LF);
         end if;
      end loop;
      return ustr.To_String (outs);
   end To_String;

   function To_String( child : Model_Child ) return String is
      outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");

   begin
      ustr.Append
        (outs,
         Indent(2) &
         "age : " &
         child.age'Img &
         " sex " &
         child.sex'Img &
         " marital_status " &
         pretty_print (child.marital_status) &
         " rel to HoH " &
         pretty_print (child.relToHoH) &
         stda.LF);
      ustr.Append (outs, Indent(1) & "ethnic_group" & pretty_print (child.ethnic_group) & stda.LF);

      return ustr.To_String (outs);
   end To_String;

   function To_String( bu : Model_Benefit_Unit ) return String is
      outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");

   begin

      ustr.Append
        (outs,
         Indent(1) & "non_dependency_type = " & pretty_print (bu.non_dependency_type) & stda.LF);
      ustr.Append
        (outs,
         Indent(1) & "economic_status = " & pretty_print (bu.economic_status) & stda.LF);
      ustr.Append (outs, Indent(1) & "bu_type = " & pretty_print (bu.bu_type) & stda.LF);
      ustr.Append (outs, Indent(1) & "age_range_of_head = " & bu.age_range_of_head'Img & stda.LF);

      ustr.Append
        (outs,
         "    ----------------- " & stda.LF & "last adult " & bu.last_adult'Img & stda.LF);
      for ad in  head .. bu.last_adult loop
         ustr.Append
           (outs,
            "    adult : " & ad'Img & stda.LF & To_String (bu.adults (ad)) & stda.LF);
      end loop;
      ustr.Append
        (outs,
         "    ----------------- " & stda.LF & "num Children  " & bu.num_children'Img & stda.LF);
      for ch in  1 .. bu.num_children loop
         ustr.Append
           (outs,
            "    child : " & ch'Img & stda.LF & To_String (bu.children (ch)) & stda.LF);
      end loop;
      ustr.Append (outs, "    ----------------- " & stda.LF);
      return ustr.To_String (outs);
   end To_String;

   function Characteristics_To_String( hh : Household_Rec ) return String is   
         outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
   begin
      ustr.Append (outs, "hh");
      ustr.Append
        (outs, 
         Indent(1) &
         "interview_date=" & Format( hh.interview_date ) & LINE_BREAK );

      ustr.Append (outs, Indent(1) & "tenure " & pretty_print (hh.tenure) & stda.LF);
      ustr.Append (outs, Indent(1) & "acorn" & pretty_print (hh.acorn) & stda.LF);
      ustr.Append (outs, Indent(1) & "composition " & pretty_print (hh.composition) & stda.LF);
      ustr.Append (outs, Indent(1) & "income_band " & pretty_print (hh.income_band) & stda.LF);
      ustr.Append
        (outs,
         Indent(1) & "standard_region " & pretty_print (hh.standard_region) & stda.LF);
      ustr.Append (outs, Indent(1) & "old_region " & pretty_print (hh.old_region) & stda.LF);
      ustr.Append
        (outs,
         Indent(1) & "regional_stratifier " & pretty_print (hh.regional_stratifier) & stda.LF);

      ustr.Append (outs, Indent(1) & "grossing_factor=" & hh.grossing_factor'Img & stda.LF);
      ustr.Append (outs, Indent(1) & "tenure=" & pretty_print (hh.tenure) & stda.LF);

      ustr.Append (outs, "Housing costs ********** " & stda.LF);
      ustr.Append (outs, Indent(1) & "mortgages=" & Format_With_Commas(hh.housing_costs.mortgages) & stda.LF);

      ustr.Append (outs, Indent(1) & "rates=" & Format_With_Commas(hh.housing_costs.gross_council_tax));
      ustr.Append (outs, Indent(1) & "water_rates=" & Format_With_Commas(hh.housing_costs.water_rates) & stda.LF);
      ustr.Append (outs, Indent(1) & "ground_rent=" & Format_With_Commas(hh.housing_costs.ground_rent));
      ustr.Append
        (outs,
         Indent(1) & "service_charges=" & Format_With_Commas(hh.housing_costs.service_charges) & stda.LF);
      ustr.Append
        (outs,
         Indent(1) & "repairs_and_insurance=" & Format_With_Commas(hh.housing_costs.repairs_And_Insurance));
      ustr.Append (outs, Indent(1) & "rent=" & Format_With_Commas(hh.housing_costs.rent) & stda.LF);
      ustr.Append
        (outs,
         Indent(1) & "rent_rebates=" & Format_With_Commas(hh.housing_costs.rent_rebates));
      ustr.Append
        (outs,
         Indent(1) & "council_tax_rebates=" & Format_With_Commas(hh.housing_costs.council_tax_rebates) & stda.LF);
      ustr.Append (outs, Indent(1) & "home equity=" & Format_With_Commas(hh.housing_costs.home_equity) & stda.LF);
      ustr.Append (outs, Indent(1) & "house price=" & Format_With_Commas(hh.housing_costs.house_price) & stda.LF);
      ustr.Append
        (outs,
         Indent(1) & "costs_are_shared=" & hh.housing_costs.costs_are_shared'Img & stda.LF & stda.LF);
      return ustr.To_String( outs );
   end  Characteristics_To_String;

   function To_String( hh : Household_Rec ) return String is
   use ustr;
      outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
   begin
      outs := outs & Characteristics_To_String( hh );
      for bu in  1 .. hh.num_benefit_units loop
         ustr.Append
           (outs,
            " benefit unit : " & bu'Img & stda.LF & To_String (hh.benefit_units (bu)) & stda.LF);
      end loop;
      return ustr.To_String (outs);
   end To_String;

   --  wages, other_Income, capital, stateBenefits, rent,
   --                       mortgages, localTaxes, charges, repairs

   procedure Uprate_Housing (hcosts : in out Model_Housing_Costs; changes : Macro_Array) is
   begin
      hcosts.mortgages             := Amount (Rate (hcosts.mortgages) * changes (mortgages));
      hcosts.gross_council_tax     :=
        Amount (Rate (hcosts.gross_council_tax) * changes (localTaxes));
      hcosts.water_rates           := Amount (Rate (hcosts.water_rates) * changes (localTaxes));
      hcosts.ground_rent           := Amount (Rate (hcosts.ground_rent) * changes (charges));
      hcosts.service_charges       := Amount (Rate (hcosts.service_charges) * changes (charges));
      hcosts.repairs_And_Insurance :=
        Amount (Rate (hcosts.repairs_And_Insurance) * changes (repairs));
      hcosts.rent                  := Amount (Rate (hcosts.rent) * changes (rent));
      --  hcosts.-- := Amount( Rate(hcosts.-- * increase ) );
      hcosts.council_tax_rebates :=
        Amount (Rate (hcosts.council_tax_rebates) * changes (localTaxes));
      --
      --  Mortgages and housing equity: note that we have a precomputed
      --  uprated house price, so we just swap the precomputed uprated one in.
      --
      hcosts.mortgages_outstanding :=
        Amount (Rate (hcosts.mortgages_outstanding) * changes (mortgages));

      hcosts.house_price := hcosts.estimated_house_price_indexed;
      hcosts.home_equity := hcosts.house_price - hcosts.mortgages_outstanding;
   end Uprate_Housing;

   procedure Uprate_Expenses (inc : in out Expenses_Array; changes : Macro_Array) is
   begin
      for i in  Expense_Items loop
         inc (i) := Amount (Rate (inc (i)) * changes (wages));
      end loop;
   end Uprate_Expenses;

   procedure Uprate_Loans (inc : in out Finance_Array; changes : Macro_Array) is
   begin
      for i in  Finance_Items loop
         inc (i) := Amount (Rate (inc (i)) * changes (capital));
      end loop;
   end Uprate_Loans;

   procedure Uprate_Incomes (inc : in out Incomes_Array; changes : Macro_Array) is
   begin
      for i in  Benefits loop
         inc (i) := Amount (Rate (inc (i)) * changes (stateBenefits));
      end loop;
      for i in  wages .. self_Employment loop
         inc (i) := Amount (Rate (inc (i)) * changes (wages));
      end loop;
      for i in  investment_Income .. pensions loop
         inc (i) := Amount (Rate (inc (i)) * changes (wages));
      end loop;
      for i in  investment_Income .. pensions loop
         inc (i) := Amount (Rate (inc (i)) * changes (capital));
      end loop;
   end Uprate_Incomes;

   procedure Uprate_Household (
      hh : in out Household_Rec;
      to_date : Time := Model.Uprate.UPRATE_TARGET_DATE ) is
      changesArray : Macro_Array;
   begin
      --  type UprateTypes is ( wages, other_Income, capital, stateBenefits );

      changesArray := Model.Uprate.changes( hh.interview_date, to_date );
      Uprate_Housing( hh.housing_costs, changesArray );
      for buno in  1 .. hh.num_benefit_units loop
         declare
            bu : Model_Benefit_Unit renames hh.benefit_units (buno);
         begin
            bu.capital_stock := Amount( Rate(bu.capital_stock) * changesArray (capital));
            for adno in  head .. bu.last_adult loop
               declare
                  ad : Model_Adult renames bu.adults (adno);
               begin
                  Uprate_Incomes (ad.incomes, changesArray);
                  Uprate_Loans (ad.finance, changesArray);
                  Uprate_Expenses (ad.expenses, changesArray);
                  ad.capital_stock := Amount( Rate(ad.capital_stock) * changesArray (capital));
               end;
            end loop;
         end;
      end loop;
   end Uprate_Household;

   procedure Multiply_Adult (mad : in out Model_Adult; mult : Amount) is
   begin
      mad.finance (loan_repayments) := mad.finance (loan_repayments) * mult;
      for e in  Expense_Items loop
         mad.expenses (e) := mad.expenses (e) * mult;
      end loop;

      for e in  Income_Items loop
            mad.incomes (e) := mad.incomes (e) * mult;
      end loop;
   end Multiply_Adult;

   procedure Multiply_BenefitUnit (mb : in out Model_Benefit_Unit; mult : Amount) is
   begin
      for hdsp in  head .. mb.last_adult loop
         Multiply_Adult (mb.adults (hdsp), mult);
      end loop;
   end Multiply_BenefitUnit;

   procedure Multiply (mhh : in out Household_Rec; mult : Amount) is
   begin
      mhh.housing_costs.mortgages             := mhh.housing_costs.mortgages * mult;
      mhh.housing_costs.water_rates           := mhh.housing_costs.water_rates * mult;
      mhh.housing_costs.ground_rent           := mhh.housing_costs.ground_rent * mult;
      mhh.housing_costs.service_charges       := mhh.housing_costs.service_charges * mult;
      mhh.housing_costs.repairs_And_Insurance := mhh.housing_costs.repairs_And_Insurance * mult;
      mhh.housing_Costs.rent_rebates         := mhh.housing_Costs.rent_rebates * mult;
      mhh.housing_costs.council_tax_rebates := mhh.housing_costs.council_tax_rebates * mult;
      mhh.housing_costs.gross_council_tax   := mhh.housing_costs.gross_council_tax * mult;
      mhh.housing_costs.rent                := mhh.housing_costs.rent * mult;
      for buno in  1 .. mhh.num_benefit_units loop
         Multiply_BenefitUnit (mhh.benefit_units (buno), mult);
      end loop;
   end Multiply;

   procedure annualise (mhh : in out Household_Rec) is
   begin
      Multiply (mhh, 52.0);
   end annualise;
   
   --
   --  count of spouse plus num children, if any.
   --
   function Total_Num_Dependents( bu : Model_Benefit_Unit ) return Natural is
      n : Natural := 0;
   begin
      if( bu.last_adult = spouse ) then
         n := 1;
      end if;
      n := n + bu.num_children;
      return n;
   end Total_Num_Dependents;

      --
   -- FIXME: check these and get it properly from the categorical data!!!!
   --
   function Is_Disabled( ad : Model_Adult ) return Boolean is
   --
   -- p 784
   --
   begin
      return
      ((ad.incomes( disabled_persons_tax_credit ) > 0.0 ) or
       (ad.incomes( disability_living_allowance ) > 0.0 ) or
       (ad.incomes( war_disablement_pension ) > 0.0 ) or
       (ad.incomes( incapacity_benefit ) > 0.0 ) or
       (ad.incomes( industrial_injury_disablementBenefit ) > 0.0 ) );
   end Is_Disabled;
   
   function Is_Severely_Disabled( ad : Model_Adult ) return Boolean is
   --
   -- p 
   --
   begin
      return
      ((ad.incomes( severe_disability_allowance ) > 0.0 ) or
      (ad.incomes( constantattendance_allowance ) > 0.0 ) or
       (ad.incomes( attendance_allowance ) > 0.0 ));
   end Is_Severely_Disabled;
   
   --
   -- FIXME: add children to this???
   --
   function Has_Severely_Disabled_Member( bu : Model_Benefit_Unit ) return Boolean is
   begin
      for adno in Head .. bu.last_adult loop
         if( Is_Severely_Disabled( bu.adults( adno ))) then
            return True;
         end if;
      end loop;
      return False;
   end Has_Severely_Disabled_Member;
   
   function Has_Disabled_Member( bu : Model_Benefit_Unit ) return Boolean is
   begin
      for adno in Head .. bu.last_adult loop
         if( Is_Disabled( bu.adults( adno ))) then
            return True;
         end if;
      end loop;
      return False;
   end Has_Disabled_Member;
   
   function Is_Carer( ad : Model_Adult ) return Boolean is
   --
   -- cpag 0708 p793
   --
   begin
      return 
         ((ad.incomes( invalid_care_allowance ) > 0.0) );
   end Is_Carer;
   

   function Age_Of_Oldest_Person( bu : Model_Benefit_Unit ) return Adult_Age is
      oldest_age : Adult_Age := MIN_ADULT_AGE;
   begin
      for adno in Head .. bu.last_adult loop
         if( bu.adults( adno ).age > oldest_age ) then
            oldest_age := bu.adults( adno ).age;
         end if;
      end loop;
      return oldest_age;
   end Age_Of_Oldest_Person;
   
   function Age_Of_Youngest_Adult( bu : Model_Benefit_Unit ) return Adult_Age is
      youngest_age : Adult_Age := MAX_ADULT_AGE;
   begin
      for adno in Head .. bu.last_adult loop
         if( bu.adults( adno ).age < youngest_age ) then
            youngest_age := bu.adults( adno ).age;
         end if;
      end loop;
      return youngest_age;
   end Age_Of_Youngest_Adult;
   
   function Age_Of_Youngest_Person( bu : Model_Benefit_Unit ) return Natural is
      youngest_age : Natural := MAX_CHILD_AGE;
   begin
      --
      -- FIXME: could the child be older than the adult?? like students or something??
      -- 
      if( bu.num_children = 0 ) then 
         return Age_Of_Youngest_Adult( bu );
      end if;
      for chno in 1 .. bu.num_children loop
         if( bu.children( chno ).age < youngest_age ) then
            youngest_age := bu.children( chno ).age;
         end if;
      end loop;
      return youngest_age;
   end Age_Of_Youngest_Person;
   
   function Get_One_Model_Household(
      data_dir : Unbounded_String;
      hhref          : Positive; 
      year           : Data_Years; 
      annualise_data : Boolean; 
      uprate_data    : Boolean ) return Household_Rec is
      
      sz      : Positive;
      mhh     : Household_Rec;
      hh_file : hh_io.File_Type;
   begin
      initialise( data_dir, hh_file, year, sz, False );
      mhh := Load( hh_file, hhref );
      if( annualise_data ) then
         Annualise( mhh );
      end if;
      if( uprate_data ) then
         Uprate_Household( mhh );
      end if;
      hh_io.Close (hh_file);
      return mhh;
   end Get_One_Model_Household;
   
   function Map_From_Housing_Record_To_Array( mhr : Model_Housing_Costs ) return Housing_Costs_Elements_Array is
      mha : Housing_Costs_Elements_Array;
   begin
      mha( mortgages ) := mhr.mortgages;
      mha( gross_council_tax ) := mhr.gross_council_tax;
      mha( water_rates ) := mhr.water_rates;
      mha( ground_rent ) := mhr.ground_rent;
      mha( service_charges ) := mhr.service_charges;
      mha( repairs_And_Insurance ) := mhr.repairs_And_Insurance;
      mha( rent ) := mhr.rent;
      mha( council_tax_rebates ) := mhr.council_tax_rebates;
      mha( rent_rebates ) := mhr.rent_rebates;
      return mha;
   end Map_From_Housing_Record_To_Array;
   
   function Make_Gender_Set_Without_Missing return Gender_Set is
      use Gender_Package.Set_Ops;
      s :  Gender_Set;
   begin 
      return Gender_Package.Construct_Set( male, Gender'Last );
      -- for i in Gender'Range loop
         -- if( i /= Gender'First ) then
            -- Include( s, i );
         -- end if;
      -- end loop;
      -- return s;
   end Make_Gender_Set_Without_Missing;
   
   function Make_Employment_Set_Without_Missing return Employment_Set is
      use Employment_Package.Set_Ops;
      s :  Employment_Set;
   begin
      return Employment_Package.Construct_Set( full_time_employee, ILO_Employment_Status'Last);
      -- for i in ILO_Employment_Status'Range loop
         -- if( i /= ILO_Employment_Status'First ) then
            -- Include( s, i );
         -- end if;
      -- end loop;
      -- return s;
   end Make_Employment_Set_Without_Missing;

   function Pretty_Print( a : Aggregation_Level ) return String is
   begin
      case a is
         when individual_level => return "Individual Level";
         when benefit_unit_level => return "Benefit Unit Level";
         when household_level => return "Household Level";
      end case;
   end Pretty_Print;


end Model.Household;
