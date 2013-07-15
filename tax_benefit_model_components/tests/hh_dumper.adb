--
--  $Author: graham_s $
--  $Date: 2008-08-17 14:44:05 +0100 (Sun, 17 Aug 2008) $
--  $Revision: 5659 $
--
with AUnit.Test_Cases.Registration; use AUnit.Test_Cases.Registration;
with AUnit.Assertions;              use AUnit.Assertions;

--  with frs_reader_0203;
with model_household;             use model_household;
with FRS_To_Model_Mapper;
with la_parameters;               use la_parameters;
with Base_Model_Types;            use Base_Model_Types;
with Text_IO;
with format_utils;
with FRS_Enums;                   use FRS_Enums;
with format_utils;
with html_utils;
with scotland_specific_constants; use scotland_specific_constants;
with run_settings;
with legal_aid_runner; use legal_aid_runner;

package body hh_dumper is

   type grossed_ungrossed is (grossed, ungrossed);

   type Region_Counts is
     array (FRS_Enums.Standard_Region, 2003 .. 2004, grossed_ungrossed) of real;
   type Income_Counts is
     array (model_household.Income_Items, 2003 .. 2004, grossed_ungrossed) of real;
   type Tenure_Counts is array (FRS_Enums.Tenure_Type, 2003 .. 2004, grossed_ungrossed) of real;

   defaultParameters : Legal_Aid_Sys;
   newParameters     : Legal_Aid_Sys;

   procedure Set_Up (T : in out Test_Case) is
   begin

      defaultParameters := get_default_system;
      newParameters     := get_default_system;
      --  newParameters.upper_limit( income, normalClaim ) :=  8681.0*1.10;
   end Set_Up;

   procedure generate_tables ( outf : Text_Io.File_Type; scotland_only : Boolean) is
      sz             : Integer       := 0;
      mhh            : model_household.Model_Household_Rec;
      hh_file        : hh_io.File_Type;
      reg_counts     : Region_Counts := (others => (others => (others => 0.0)));
      inc_counts     : Income_Counts := (others => (others => (others => 0.0)));
      ten_counts     : Tenure_Counts := (others => (others => (others => 0.0)));
      in_scotland    : Boolean       := False;
      startHH, endHH : Integer;
   begin
      for year in  2003 .. 2004 loop
         model_household.initialise (hh_file, year, sz);
         if (scotland_only) then
            startHH := FILE_POSITIONS (year, start_pos);
            endHH   := FILE_POSITIONS (year, end_pos);
         else
            startHH := 1;
            endHH   := sz;
         end if;
         for href in  startHH .. endHH loop
            mhh := model_household.load (hh_file, href);
            if (not scotland_only) then
               if ((mhh.standard_region = scotland) and (not in_scotland)) then
                  in_scotland := True;
                  text_IO.Put ( outf, "<p> YEAR " & year'Img & "  1ST SCOTTISH HOUSEHOLD " & href'Img&"</p>");
                  Text_IO.New_Line( outf );
               end if;
               if ((mhh.standard_region /= scotland) and (in_scotland)) then
                  in_scotland := False;
                  text_IO.Put ( outf, "<p> YEAR " & year'Img & "  LAST SCOTTISH HOUSEHOLD " & href'Img&"</p>");
                  Text_IO.New_Line( outf );
               end if;
            end if;

            reg_counts (mhh.standard_region, year, grossed)   :=
              reg_counts (mhh.standard_region, year, grossed) + mhh.grossing_factor;
            reg_counts (mhh.standard_region, year, ungrossed) :=
              reg_counts (mhh.standard_region, year, ungrossed) + 1.0;
            ten_counts (mhh.tenure, year, grossed)            :=
              ten_counts (mhh.tenure, year, grossed) + mhh.grossing_factor;
            ten_counts (mhh.tenure, year, ungrossed)          :=
              ten_counts (mhh.tenure, year, ungrossed) + 1.0;
            for buno in  1 .. mhh.num_benefit_units loop
               for adno in  head .. mhh.benefit_units (buno).last_adult loop

                  for inc in  Income_Items'First .. Income_Items'Last loop
                  -- if( (mhh.benefit_units (buno).adults (adno).age > 60 ) and ( inc = income_support )) then
                        -- inc_to_add = guaranteed_pension_credit;
                  -- else
                     -- inc_to_add := inc;
                  -- end if;
                     if (mhh.benefit_units (buno).adults (adno).incomes (inc) /= 0.0) then
                        inc_counts (inc, year, grossed)   := inc_counts (inc, year, grossed) +
                                                             mhh.grossing_factor;
                        inc_counts (inc, year, ungrossed) := inc_counts (inc, year, ungrossed) +
                                                             1.0;
                     end if;
                  end loop; -- incomes
               end loop; -- ads
            end loop; -- bus
         end loop; -- hhld
         hh_io.Close (hh_file);
      end loop; -- year

      for year in  2003 .. 2004 loop
         text_IO.Put ( outf, "<h2>YEAR  " & year'Img & "</h2>");
         Text_IO.New_Line( outf );

         text_IO.Put ( outf, "<h3>TENURE</h3>");
         Text_IO.New_Line( outf );
         text_IO.Put ( outf, "<table class='datatable' width='90%'>");
         Text_IO.New_Line( outf );

         for t in  FRS_Enums.Tenure_Type'First .. FRS_Enums.Tenure_Type'Last loop
            Text_IO.Put
              ( outf, "<tr><th>" &
               FRS_Enums.pretty_print (t) &
               "</th><td>" &
               format_utils.format_with_commas (ten_counts (t, year, grossed)) &
               "</td><td>" &
               format_utils.format_with_commas (ten_counts (t, year, ungrossed)) &
               "</td></tr>");
            Text_IO.New_Line( outf );
         end loop;
         text_IO.Put ( outf, "</table>");
         Text_IO.New_Line( outf );
         text_IO.Put ( outf, "<h3>REGION</h3>");
         Text_IO.New_Line( outf );
         text_IO.Put ( outf, "<table class='datatable'  width='90%'>");
         Text_IO.New_Line( outf );
         for t in  FRS_Enums.Standard_Region'First .. FRS_Enums.Standard_Region'Last loop
            Text_IO.Put
                ( outf,
                 "<tr><th>" &
               FRS_Enums.pretty_print (t) &
               "</th><td>" &
               format_utils.format_with_commas (reg_counts (t, year, grossed)) &
               "</td><td>" &
               format_utils.format_with_commas (reg_counts (t, year, ungrossed)) &
               "</td></tr>");
            Text_IO.New_Line( outf );
         end loop;
         Text_IO.New_Line( outf );
         text_IO.Put ( outf, "</table>");
         Text_IO.New_Line( outf );
         text_IO.Put ( outf, "<h3>Incomes</h3>");
         Text_IO.New_Line( outf );
         text_IO.Put ( outf, "<table class='datatable'  width='90%'>");
         Text_IO.New_Line( outf );
         for t in  Income_Items'First .. Income_Items'Last loop
            Text_IO.Put
              ( outf, "<tr><th>" &
               t'Img &
               "</th><td>" &
               format_utils.format_with_commas (inc_counts (t, year, grossed)) &
               "</td><td>" &
               format_utils.format_with_commas (inc_counts (t, year, ungrossed)) &
               "</td></tr>");
            Text_IO.New_Line( outf );
         end loop;
         text_IO.Put ( outf, "</table>");
         Text_IO.New_Line( outf );
         Text_IO.New_Line( outf );
      end loop;

   end generate_tables;


   --
   --  very basic legal aid only run, returning an error index
   --  computed from the differences between the la_States under sys1 and 2
   --  measure depends on the target option in the run settings.
   --

   NUM_UPPER_LIMITS : constant integer := 50;
   INCREMENT : constant Amount := 500.0;
   type all_breakdowns_array is array(1..NUM_UPPER_LIMITS) of FourFT2.Cell_Contents;


   procedure print_Breakdown_Line(
      outf : Text_IO.File_Type;
      title : String;
      all_breakdowns : all_breakdowns_array;
      whichBreakdown, whichRow : integer ) is
   begin
      text_io.put( outf, """" );
      text_io.put( outf, title );
      text_io.put( outf, """" );
      text_io.put( outf, "," );
      for i in 1 .. NUM_UPPER_LIMITS loop
         text_io.put( outf, all_breakdowns(i)( whichBreakdown )( whichRow )'Img );
         text_IO.Put ( outf,  "," );
      end loop;
      Text_IO.New_Line( outf );
   end print_Breakdown_Line;

   procedure print_breakdowns ( all_breakdowns : all_breakdowns_array; base_upper_limit : Amount ) is
      outf : Text_IO.File_Type;
      upper_limit : Amount := base_upper_limit;
      p : integer;
   begin
      Text_IO.create( outf, text_io.out_file, "upper_limit.csv" );
      text_IO.Put ( outf,  "upper limit," );
      for i in 1 .. NUM_UPPER_LIMITS loop

         text_IO.Put ( outf,  upper_limit'Img );
         text_io.put ( outf, "," );
         upper_limit := upper_limit + INCREMENT;
      end loop;
      Text_IO.New_Line ( outf );
      Text_IO.New_Line ( outf );
      text_io.put( outf, "ETHNIC " );
      Text_IO.New_Line( outf );
      p := 0;
      for eth in Aggregated_Ethnic_Group'First .. Aggregated_Ethnic_Group'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            1,
            p );
      end loop;

      text_io.put( outf, "GENDER " );
      text_io.new_line( outf );
      p := 0;
      for eth in Gender'First .. Gender'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            2,
            p );
      end loop;

      text_io.put( outf, "MARITAL STATUS " );
      text_io.new_line( outf );
      p := 0;
      for eth in Marital_Status'First .. Marital_Status'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            3,
            p );
      end loop;

      text_io.put( outf, "TENURE TYPE" );
      text_io.new_line( outf );
      p := 0;
      for eth in Tenure_Type'First .. Tenure_Type'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            4,
            p );
      end loop;

      text_io.put( outf, "ECONOMIC STATUS" );
      text_io.new_line( outf );
      p := 0;
      for eth in Benefit_Unit_Economic_Status'First .. Benefit_Unit_Economic_Status'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            5,
            p );
      end loop;

      text_io.put( outf, "BENEFIT UNIT TYPE" );
      text_io.new_line( outf );
      p := 0;
      for eth in HBAI_Benefit_Unit_Type'First .. HBAI_Benefit_Unit_Type'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            6,
            p );
      end loop;

      text_io.put( outf, "AGE GROUP" );
      text_io.new_line( outf );
      p := 0;
      for eth in Age_Group'First .. Age_Group'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            7,
            p );
      end loop;

      text_io.put( outf, "DISABLED INDICATOR" );
      text_io.new_line( outf );
      p := 0;
      for eth in BU_Disabled_Indicator'First .. BU_Disabled_Indicator'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            9,
            p );
      end loop;

      text_io.put( outf, "DISABLED INDICATOR" );
      text_io.new_line( outf );
      p := 0;
      for eth in Scottish_Regional_Stratifier'First .. Scottish_Regional_Stratifier'Last loop
         p := p + 1;
         print_Breakdown_Line(
            outf,
            FRS_Enums.pretty_print( eth ),
            all_breakdowns,
            11,
            p );
      end loop;

      text_io.new_line( outf );
      Text_IO.close( outf );
   end print_breakdowns;


   procedure test_Read_Model (T : in out AUnit.Test_Cases.Test_Case'Class) is
      outf : Text_IO.File_Type;
   begin
      Text_IO.create( outf, text_io.out_file, "model_data_dump.html" );

      text_IO.Put ( outf, html_utils.HTML_HEADER_STRING);
      text_IO.Put ( outf, "<h1>UK</h1>");
      generate_tables ( outf, False);
      text_IO.Put ( outf, "<h1>Scotland</h1>");
      generate_tables ( outf, True);
      text_IO.Put ( outf, "</body></html>");
      Text_IO.New_Line( outf );

      Text_IO.Close( outf );

   end test_Read_Model;



   --------------------
   -- Register_Tests --
   --------------------

   procedure Register_Tests (T : in out Test_Case) is
   begin
      Register_Routine (T, test_Read_Model'Access, "test_Read_Model ");
   end Register_Tests;

   ----------
   -- Name --
   ----------

   function Name (T : Test_Case) return String_Access is
   begin
      return new String'("Raw FRS Conversions");
   end Name;

end hh_dumper;
