--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
pragma License( Modified_GPL );

with Model.Household;             use Model.Household;

with Model.calculator;               
with Model.Parameters;               
with model.Output;                   
with Ada.Text_IO;
with Model.Run_Settings;
with legal_aid_output_types;      use legal_aid_output_types;
with FRS_Enums; use FRS_Enums;
with scotland_specific_constants; use scotland_specific_constants;

pragma Elaborate_All (factor_table);      --  gks this forces all the code in declarations to be
                                          --called always.
                                          --  See :
                                          --http://gcc.gnu.org/onlinedocs/gnat_ugn_unw/Elaboration-C
                                          --od
                                          --e-in-Ada-95.html#Elaboration-Code-in-Ada-95

package body legal_aid_runner is
   CSV_HEADER : constant String :=
      "SERNUM,YEAR,GROSSING_FACTOR,BUNO,EQUIV_SCALE," &
"LASTATE_1, CAPITAL_STATE_1, MEANS_TEST_STATE_1, PASSPORT_STATE_1, GROSS_INCOME_TEST_STATE_1,GROSS_INCOME_1,NET_INCOME_1,INCOME_CONTRIB_1,CAPITAL_CONTRIB_1,ASSESSABLE_INCOME_1,DISPOSABLE_INCOME_1,ASSESSABLE_CAPITAL_1,"
      &
      "housing_costs_1,benefits_In_Kind_1,deductions_From_Income_1," &
      "p_indict_1, p_summ_1, p_moto_1, p_magis_1," &
"LASTATE_2, CAPITAL_STATE_2, MEANS_TEST_STATE_2, PASSPORT_STATE_2, GROSS_INCOME_TEST_STATE_2,GROSS_INCOME_2,NET_INCOME_2,INCOME_CONTRIB_2,CAPITAL_CONTRIB_2,ASSESSABLE_INCOME_2,DISPOSABLE_INCOME_2,ASSESSABLE_CAPITAL_2,"
      &
      "housing_costs_2,benefits_In_Kind_2,deductions_From_Income_2," &
      "p_indict_2, p_summ_2, p_moto_2, p_magis_2," &
      "RELIGION, SEX_HEAD, " &
      "MARR_STAT,TENURE_TYPE,ECONOMIC_STATUS,BEN_UNIT_TYPE,AGE_OF_HEAD,HBAI_DECILE";
   --
   --  Retrieve a predefined system.
   --  FIXME: jammed on to return scottish civil curremt system
   --
   procedure getBaseSystem
     (settings : Model.Run_Settings.Settings_Rec;
      sys      : in out Legal_Aid_Sys;
      ctype    : in out Claim_Type)
   is
      year     : Integer;
      sys_type : System_Type;
   begin
      sys   := la_parameters.get_default_system;
      ctype := normal_claim;
      --
      -- if (settings.uprate_to_current) then
      -- year := la_parameters.LATEST_AVAILABLE_YEAR;
      -- else
      -- year := settings.year;
      -- end if;
      -- --
      -- --  the pi case isn't really a seperate system, just a flag to use personal injury
      -- --allowances
      -- --  in the civil system, so...
      -- --
      -- if (settings.run_type = ni_personal_injury) then
      -- sys_type := defaultNI;
      -- ctype    := personal_injury_claim;
      -- else
      -- sys_type := settings.run_type;
      -- ctype    := normal_claim;
      -- end if;
      -- sys := la_parameters.Get_System (sys_type, year);
      -- --        defaultNI, defaultEnglish, green_form, ni_personal_injury, abwor
   end getBaseSystem;

   function get_one_Model.Household
     (settings : Model.Run_Settings.Settings_Rec;
      hhref    : Integer;
      year     : Integer)
      return     Model.Household.Household_Rec
   is
      --  hh  : Raw_Household;
      sz      : Integer;
      mhh     : Model.Household.Household_Rec;
      hh_file : hh_io.File_Type;
   -- multiplier        : Amount     := 52.0;
   begin
      Model.Household.initialise (hh_file, year, sz, False);
      mhh := Model.Household.load (hh_file, hhref);
      --  if ((settings.run_type = green_form) or (settings.run_type = abwor)) then
      --          multiplier := 1.0;
      --  end if;
      --  sz  := frs_binary_reads.openFiles (settings.year);
      --  hh  := frs_binary_reads.getHousehold (hhref);
      --  mhh := frs_to_model_mapper.map (hh, settings.year);

      if (la_parameters.is_annual_system (settings.run_type)) then
         Model.Household.annualise (mhh);
      end if;

      if (settings.uprate_to_current) then
         uprateHousehold (mhh);
      end if;
      hh_io.Close (hh_file);
      --  frs_binary_reads.CloseFiles;
      return mhh;
   end get_one_Model.Household;

   function do_one_household
     (newParameters : Legal_Aid_Sys;
      settings      : Model.Run_Settings.Settings_Rec;
      hhref         : Integer;
      year          : Integer)
      return          Model_Outputs
   is
      mhh                : Model.Household.Household_Rec;
      output             : Model_Outputs;
      default_parameters : Legal_Aid_Sys;
      ctype              : Claim_Type := normal_claim;
   begin
      getBaseSystem (settings, default_parameters, ctype);
      mhh := get_one_Model.Household (settings, hhref, year);
      -- for bu in 1 .. mhh.num_benefit_units loop
      --  checkIncomeEquivalences ( mhh.benefit_units(bu),
      --hh.benunits(integer(bu)).benunit );
      -- end loop;
      output (1) := calcOneHHLegalAid (mhh, default_parameters, ctype, settings.uprate_to_current);
      output (2) := calcOneHHLegalAid (mhh, newParameters, ctype, settings.uprate_to_current);
      return output;
   end do_one_household;

   function costs_to_values_array(takeup : LA_Takeup_Array)
      return    FourFT2.Values_Array
   is
      sums   : constant LA_Costs_Component_Array := costs_model.Sum_Over_Problems( takeup );
      values : FourFT2.Values_Array := (others => 0.0);
      p : integer := 9;
   begin
      values (1) := sums( expected_offers );
      values (2) := sums( expected_takeup );
      values (3) := sums( expected_gross_costs );
      values (4) := sums( expected_net_costs );
      values (5) := sums( contributions );
      values (6) := sums( Expenses_From_Opponents );
      values (7) := sums( Amounts_Awarded );
      values (8) := sums( Total_Income );
      
      for ctype in LA_Problem_Type loop
         values(p) := takeup( civil, Total_Income, ctype );
         p := p + 1;
      end loop;
      for ctype in LA_Problem_Type loop
         values(p) := takeup( civil, expected_gross_costs, ctype );
         p := p + 1;
      end loop;
      
      
      return values;
   end costs_to_values_array;

   procedure dump_profile
     (outfile    : Text_IO.File_Type;
      mhh        : Model.Household.Household_Rec;
      breakdowns : FourFT2.breakdowns;
      output     : Model_Outputs;
      year, bu   : Integer)
   is
   begin

      Text_IO.Put
        (outfile,
         mhh.sernum &
         ',' &
         year'Img &
         "," &
         format_utils.format (mhh.grossing_factor) &
         "," &
         bu'Img &
         "," &
         format_utils.format (output (1) (bu).equivalence_scale) &
         ",");

      for sys_no in  1 .. 2 loop
         Text_IO.Put
           (outfile,
            model_output.recode_LA_State (output (sys_no) (bu).la_State)'Img &
            "," &
            model_output.recode_LA_State (output (sys_no) (bu).capital_state)'Img &
            "," &
            model_output.recode_LA_State (output (sys_no) (bu).means_test_state)'Img &
            "," &
            model_output.recode_LA_State (output (sys_no) (bu).passport_state)'Img &
            "," &
            model_output.recode_Gross_Income_Test_State_Type
               (output (sys_no) (bu).gross_income_test_state)'Img &
            "," &
            output (sys_no) (bu).gross_Income'Img &
            "," &
            output (sys_no) (bu).net_income'Img &
            "," &
            output (sys_no) (bu).income_Contribution'Img &
            "," &
            output (sys_no) (bu).capital_Contribution'Img &
            "," &
            output (sys_no) (bu).assessable_Income'Img &
            "," &
            output (sys_no) (bu).disposable_Income'Img &
            "," &
            output (sys_no) (bu).assessable_Capital'Img &
            "," &
            output (sys_no) (bu).housing_Costs'Img &
            "," &
            output (sys_no) (bu).benefits_In_Kind'Img &
            "," &
            output (sys_no) (bu).deductions_From_Income'Img &
            ",");
      end loop;
      for bd_no in  1 .. 8 loop
         Text_IO.Put (outfile, breakdowns (bd_no)'Img);
         if (bd_no < 8) then
            Text_IO.Put (outfile, ",");
         end if;
      end loop;
      Text_IO.Put (outfile, Text_Utils.DOS_NEW_LINE);
   end dump_profile;

   function make_breakdowns
     (hh   : Model.Household.Household_Rec;
      bu   : Model_Benefit_Unit;
      headOrSpouse : Head_Or_Spouse := Head;
      child_number  : integer := -1 )
      return FourFT2.breakdowns
   is
      breakdowns : FourFT2.breakdowns := (others => 1);
      eth : Ethnic_Group := bu.adults ( headOrSpouse ).ethnic_group;
      sex : Gender := bu.adults ( headOrSpouse ).sex;
      marstat : Marital_Status := bu.adults ( headOrSpouse ).marital_status;
   -- default to one to tables don't explode when we add this record
   begin
      if( child_number > 0 ) then
         eth := bu.children ( child_number ).ethnic_group;
         sex := bu.children( child_number ).sex;
         marstat := bu.children( child_number ).marital_status;
      end if;
      breakdowns (1) := FRS_Enums.Ethnic_Group'Pos ( eth ) + 1;
      breakdowns (2) := FRS_Enums.Gender'Pos ( sex ) + 1;
      breakdowns (3) := FRS_Enums.Marital_Status'Pos ( marstat ) + 1;
      breakdowns (4) := FRS_Enums.Tenure_Type'Pos (hh.tenure) + 1;
      breakdowns (5) := FRS_Enums.Benefit_Unit_Economic_Status'Pos (bu.economic_status) + 1;
      breakdowns (6) := FRS_Enums.HBAI_Benefit_Unit_Type'Pos (bu.bu_type) + 1;
      breakdowns (7) := FRS_Enums.Age_Group'Pos (bu.age_range_of_head) + 1;

      -- Revised Age of Head of BU (Pub.)

      breakdowns (8) := bu.decile;

      breakdowns (9) := FRS_Enums.BU_Disabled_Indicator'Pos (bu.disablement_status) + 1;

      breakdowns (10) := FRS_Enums.Standard_Region'Pos (hh.standard_region) + 1;
      if (SCOTLAND_ONLY) then
         breakdowns (11) :=
           scotland_specific_constants.get_int_value_of_stratifier (hh.regional_stratifier) + 1;
      else
         breakdowns (11) := FRS_Enums.Standard_Region'Pos (hh.standard_region) + 1;
      end if;

      for i in  1 .. 11 loop
         Text_IO.Put (i'Img & " = " & breakdowns (i)'Img);
         Text_IO.New_Line;
      end loop;

      return breakdowns;
   end make_breakdowns;
   
   function do_this_hh( href : Integer; year : Integer ) return Boolean is
   begin
            if( ENG_AND_WALES_ONLY ) then
                if( ( href >= FILE_POSITIONS (year, start_pos)) and
                    (href <= FILE_POSITIONS (year, end_pos) ) ) then
                    return false;
                end if;
            end if;
            return true;
   end do_this_hh;

   -- FIXME: stack overflow hack
   table                  : Output_Tables;

   function doRun
     (newParameters : Legal_Aid_Sys;
      id            : String;
      settings      : Model.Run_Settings.Settings_Rec)
      return          Output_Tables -- FourFT2.Table_Rec
   is
      -- hh                : Raw_Household;
      sz                     : Integer                   := 0;
      mhh                    : Model.Household.Household_Rec;
      output                 : Model_Outputs;
      row, col               : Integer;
      breakdowns             : FourFT2.breakdowns;
      default_parameters     : Legal_Aid_Sys;
      ctype                  : Claim_Type                := normal_claim;
      outfile                : Text_IO.File_Type;
      hh_file                : hh_io.File_Type;
      values1, values2       : FourFT2.Values_Array      := (others => 0.0);
      num_years              : real                      :=
         real (settings.end_year - settings.start_year + 1);
      grossing_factor        : real                      := 0.0;
      counts_grossing_factor : real                      := 0.0;
      exampleDetail          : FourFT2.Example_Component := (others => 0);
      startHH, endHH         : Integer;
   begin
      table ( household ) := FourFT2.BLANK_TABLE;
      table ( benefit_unit ) := FourFT2.BLANK_TABLE;
      table ( adult ) := FourFT2.BLANK_TABLE;
      table ( person ) := FourFT2.BLANK_TABLE;

      Text_IO.Create (outfile, Text_IO.Out_File, id & "__profiles.csv");
      Text_IO.Put
        ("doRun: using years " & settings.start_year'Img & " to " & settings.end_year'Img);
      for year in  settings.start_year .. settings.end_year loop
         Model.Household.initialise (hh_file, year, sz, False);

         if (SCOTLAND_ONLY) then
            startHH := FILE_POSITIONS (year, start_pos);
            endHH   := FILE_POSITIONS (year, end_pos);
         else
            startHH := 1;
            endHH   := sz;
         end if;

         default_parameters := la_parameters.get_default_system;

         -- getBaseSystem (settings, default_parameters, ctype);
         --  sz := frs_binary_reads.openFiles (settings.year);
         Text_IO.Put (outfile, CSV_HEADER & Text_Utils.stda.LF);
         for href in  startHH .. endHH loop
            if( do_this_hh( href, year ) ) then
                    mhh := Model.Household.load (hh_file, href);
                    -- 
                    -- This is a hack: grossing factor is just the actual number
                    -- divided by however many years we're running over. This is what
                    -- the Northern Ireland office do, so at least we're no worse than
                    --them
                    --
                    grossing_factor        := mhh.grossing_factor / num_years;
                    counts_grossing_factor := grossing_factor; -- mhh.grossing_factor;
                    Text_IO.Put ("grossing factor = " & grossing_factor'Img);
                    if (la_parameters.is_annual_system (settings.run_type)) then
                       Model.Household.annualise (mhh);
                    end if;
                    if (settings.uprate_to_current) then
                       Text_IO.Put ("uprating ");
                       Text_IO.New_Line;
                       uprateHousehold (mhh);
                    end if;
                    Text_IO.Put (Model.Household.To_String (mhh));
                    output (1) :=
                       calcOneHHLegalAid (mhh, default_parameters, ctype, settings.uprate_to_current);
        
                    output (2) :=
                       calcOneHHLegalAid (mhh, newParameters, ctype, settings.uprate_to_current);
                    for bu in  1 .. mhh.num_benefit_units loop
                       breakdowns := make_breakdowns (mhh, mhh.benefit_units (bu));
        
                       Write (logger, "RESULTS: SYS1 " & model_output.To_String (output (1) (bu)));
                       Write (logger, "RESULTS: SYS2 " & model_output.To_String (output (2) (bu)));
        
                       row := Legal_Aid_State'Pos (output (1) (bu).la_State) + 1;
                       col := Legal_Aid_State'Pos (output (2) (bu).la_State) + 1;
                       --
                       -- accumulate costs information in the table cells values
                       -- array
                       --
                       values1 := costs_to_values_array (output (1) (bu).costs );
                       values2 := costs_to_values_array (output (2) (bu).costs);
                       exampleDetail (1) := href;
                       exampleDetail (2) := year;
                       Text_IO.Put ("adding hhref=" & href'Img & " year " & year'Img & " to examples ");
                       if( bu = 1 ) then
                               FourFT2.add
                                 (table( Household ),
                                  row,
                                  col,
                                  grossing_factor,
                                  counts_grossing_factor,
                                  values1,
                                  values2,
                                  breakdowns,
                                  exampleDetail);
                
                       end if;
                       FourFT2.add
                         (table( Benefit_Unit ),
                          row,
                          col,
                          grossing_factor,
                          counts_grossing_factor,
                          values1,
                          values2,
                          breakdowns,
                          exampleDetail);
                       for adno in Head .. mhh.benefit_units (bu).last_adult loop
                                breakdowns := make_breakdowns (mhh, mhh.benefit_units (bu), adno );
                                                        FourFT2.add(table( Adult ),
                                        row,
                                        col,
                                        grossing_factor,
                                        counts_grossing_factor,
                                        values1,
                                        values2,
                                        breakdowns,
                                      exampleDetail);
        
                              FourFT2.add(table( Person ),
                                row,
                                col,
                                grossing_factor,
                                counts_grossing_factor,
                                values1,
                                values2,
                                breakdowns,
                                exampleDetail);
                       end loop; -- adult
                       for chno in 1 .. mhh.benefit_units (bu).num_children loop
                             breakdowns := make_breakdowns (mhh, mhh.benefit_units (bu), head, chno );
                             FourFT2.add(table( Person ),
                                 row,
                                 col,
                                 grossing_factor,
                                 counts_grossing_factor,
                                 values1,
                                 values2,
                                 breakdowns,
                                 exampleDetail );
                       end loop; -- child loop
                       dump_profile (outfile, mhh, breakdowns, output, year, bu);
                   end loop; -- ben unit loop
               end if; -- we're doing this household
         end loop; -- households
         hh_io.Close (hh_file);
      end loop; -- over years
      Write (logger, FourFT2.toCDA (table( Benefit_Unit )));
      -- frs_binary_reads.CloseFiles;
      Text_IO.Close (outfile);
      return table;
   end doRun;

end legal_aid_runner;
