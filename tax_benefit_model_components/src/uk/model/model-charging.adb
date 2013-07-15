with Financial_Functions;
with Text_Utils;

package body Model.Charging is

   use Text_Utils;   

   package Finance is new Financial_Functions( Rate=>Rate, Amount=>Amount );

   function Combine_Booleans( b1 : Boolean; b2 : Boolean; op : Join_Type ) return Boolean is
   begin
        if( op = j_and ) then
                return (b1 and b2);
        else
                return (b1 or b2);        
        end if;
   end Combine_Booleans;

   function Annualised_Equivalent( charge : Charges_Type ) return Amount is
      cost : Amount := 0.0;
      fraction_of_year_pp : constant Rate := Rate( DAYS_PER_PERIOD( charge.period ))/365.0; 
   begin
      if( charge.period = annual ) and ( charge.frequency > 1.0 ) then
         declare
            freq : Positive := Positive( charge.frequency );
            period : constant Positive := Positive'Min( freq, ASSUMED_PAYMENT_YEARS ) * 12;  
            loan : constant Finance.Loan_Input := ( 
               principal => charge.charge_amount, 
               interest_rate => Finance.monthly_equivalent_of_annual_interest(charge.interest_rate), 
               num_payments => period );
            cost_of_loan : Finance.Loan_Output := Finance.Calculate_Loan( loan );
         begin
            cost := Amount(12.0) * cost_of_loan.monthly_payment;
            
         end;
      else
         cost := Amount( ( Rate(charge.charge_amount ) * PERIODS_PER_YEAR( charge.period )) / 
                        charge.frequency );
         ---cost := Amount( (Rate(charge.charge_amount ) * Rate( charge.frequency )));
      end if;
      return cost;
   end Annualised_Equivalent;
   
   --
   -- This is ANDing, if the sets are set at all
   --
   function Hits_Target( ad : Model_Adult; tt : Target_Type ) return Boolean is
      use Gender_Package.Set_Ops;
      use Employment_Package.Set_Ops;
      use Broad_Benefits_Package.Set_Ops;
      hit : Boolean := False;
   begin
      if( ad.age >= tt.min_age ) and ( ad.age <= tt.max_age ) then hit := True; end if;
      log( charging_model, "Hits_Target age test " & Boolean'Image( hit ) );

      if( not Is_Empty( tt.genders ))then
         if( Contains( tt.genders, ad.sex ) )then 
            hit := hit and True;
         else
            hit := False;
         end if;
      end if;
      log( charging_model, "Hits_Target gender test " & Boolean'Image( hit ) );
      
      if( not Is_Empty( tt.employment )) then
         if( Contains( tt.employment, ad.ilo_employment )) then 
            hit := hit and True; 
         else
            hit := False;
         end if;
      end if;
      
      if( not Is_Empty( tt.benefits ))then
         if( Contains_Broad_Benefits( ad.incomes, tt.benefits )) then 
            hit := hit and True;
         else
            hit := False;
         end if;
      end if;
      log( charging_model, "Hits_Target at end" & Boolean'Image( hit ) );
      return hit;
   end Hits_Target;
   
   function Hits_Target( ch : Model_Child; tt : Target_Type ) return Boolean is
      use Gender_Package.Set_Ops;
      hit : Boolean := False;
   begin
      if( ch.age >= tt.min_age ) and ( ch.age <= tt.max_age ) then hit := True; end if;
      if( not Is_Empty( tt.genders ))then
         if( Contains( tt.genders, ch.sex ))then 
            hit := hit and True;
         else
            hit := False;
         end if;
      end if;
      return hit;      
   end Hits_Target;

   
   function To_String( ch : Charges_Type ) return String is
      outs : Unbounded_String;
   begin
      outs := outs & "        -- CHARGE --" & LINE_BREAK;

      outs := outs & "        " & ch.name & LINE_BREAK;
      outs := outs & "        amount " & Format( ch.charge_amount );
      outs := outs & " discount " & Format( ch.discount ); 
      outs := outs & " period " & Periods'Image( ch.period );
      outs := outs & " frequency " & Format( ch.frequency ); -- period = daily frequency = 10 => 1ce every 10 days and so on
      outs := outs & " interest_rate " & Format( ch.interest_rate );
      outs := outs & " join " & Join_Type'Image( ch.join );
      outs := outs & LINE_BREAK;
      outs := outs & "        --END CHARGE--" & LINE_BREAK;
      return To_String( outs );
   end To_String;
   
   function To_String( tt : Target_Type ) return String is
      outs : Unbounded_String;
      n : constant Natural := Natural( Charges_Package.Length( tt.charges ));
   begin
      outs := outs & "    --TARGET--" & LINE_BREAK;
      outs := outs & "    " & tt.name & LINE_BREAK;
      outs := outs & "    min_age  " & Natural'Image( tt.min_age  );
      outs := outs & " max_age  " & Natural'Image( tt.max_age  );
      outs := outs & LINE_BREAK;
      outs := outs & "    genders  " & Gender_Package.To_String( tt.genders  );
      outs := outs & LINE_BREAK;
      outs := outs & "    benefits " & Broad_Benefits_Package.To_String( tt.benefits );
      outs := outs & LINE_BREAK;
      outs := outs & "    employment  " & Employment_Package.To_String( tt.employment );
      outs := outs & LINE_BREAK;
      outs := outs & "    max_charges " & Positive'Image( tt.max_charges );
      outs := outs & LINE_BREAK;
      for i in 1..n loop
         outs := outs & "        charge["& Natural'Image(i) & " ] " & LINE_BREAK & To_String(Charges_Package.Element( tt.charges, i )) & LINE_BREAK;
      end loop;
      outs := outs & "    --END TARGET--" & LINE_BREAK;
      return To_String( outs );
   end To_String;
   
   function To_String( ap : Application_Type ) return String is
      outs : Unbounded_String;
      n : constant Natural := Natural( Target_Package.Length( ap.targets ));
   begin
      outs := outs & "  --APPLICATION--" & LINE_BREAK;
      outs := outs & "  " & ap.name & LINE_BREAK;
      outs := outs & " max_children" &Child_Range'Image( ap.max_children );
      outs := outs & " max_adults" & Natural'Image( ap.max_adults );
      outs := outs & ap.name & LINE_BREAK;
      for i in 1..n loop
         outs := outs & "    targets["& Natural'Image(i) & " ] " & LINE_BREAK & To_String(Target_Package.Element( ap.targets, i )) & LINE_BREAK;
      end loop;
      outs := outs & "  --END APPLICATION--" & LINE_BREAK;
      return To_String( outs );
   end To_String;
   
   function To_String( cr : Charging_Regime ) return String is
      outs : Unbounded_String;
      n : constant Natural := Natural( Application_Package.Length( cr.applications ));
   begin
      outs := outs & "--CHARGING REGIME--" & LINE_BREAK;
      outs := outs & cr.name & LINE_BREAK;
      for i in 1..n loop
         outs := outs & "  application["& Natural'Image(i) & " ] " & LINE_BREAK & To_String(Application_Package.Element( cr.applications, i )) & LINE_BREAK;
      end loop;
      outs := outs & "--END CHARGING REGIME--" & LINE_BREAK;
      return To_String( outs );
   end To_String;

   function Charge_Person( ad : Model_Adult; tt : Target_Type ) return Amount is
      amt : Amount := 0.0;
      n : constant Natural := Natural( Charges_Package.Length( tt.charges ));
      charge : Charges_Type;
   begin
      if( Hits_Target( ad, tt ) ) then
         log( charging_model, "Charge_Person: adult version A Hit " );
         for i in 1..n loop
            charge := Charges_Package.Element( tt.charges, i );
            amt := amt + Annualised_Equivalent( charge );
         end loop;
      end if;
      return amt;
   end Charge_Person;
   
   function Charge_Person( ch : Model_Child; tt : Target_Type ) return Amount is
      amt : Amount := 0.0;
      n : constant Natural := Natural( Charges_Package.Length( tt.charges ));
      charge : Charges_Type;
   begin
      if( Hits_Target( ch, tt ) ) then
         for i in 1..n loop
            charge := Charges_Package.Element( tt.charges, i );
            amt := amt + Annualised_Equivalent( charge );
         end loop;
      end if;
      return amt;
   end Charge_Person;
   
   
   function Pretty_Print( p : Periods ) return String is
   begin
      case p is
         when school_day => return "School Day";
         when daily => return "24-Hour Day";
         when working_week => return "Working Week";
         when weekly => return "Week";
         when school_week => return "School Week";
         when monthly => return "Calendar Month";
         when termly => return "School Term";
         when annual => return "Calendar Year";
      end case;
   end Pretty_Print;
   
   function Get_Application_Cost( bu : Model_Benefit_Unit; ap : Application_Type ) return Amount is
      total_amt : Amount := 0.0;
      this_amt  : Amount := 0.0;
      n : constant Natural := Natural( Target_Package.Length( ap.targets ));
      num_children_charged : Natural := 0;
      num_adults_charged : Natural := 0;
      num_people_charged : Natural := 0;
      tt : Target_Type;
   begin
      ad_loop: for adno in head .. bu.last_adult loop
         this_amt := 0.0;
         ad_target_loop: for i in 1 .. n loop
            tt := Target_Package.Element( ap.targets, i );
            this_amt := this_amt + Charge_Person( bu.adults( adno ), tt );
            log( charging_model, "Get_Application_Cost adult loop; amount " & Amount'Image( this_amt ) );
            if ( tt.isExclusive ) and ( this_amt > 0.0) then
               exit ad_target_loop;
            end if;
         end loop ad_target_loop;
         if( this_amt > 0.0 ) then            
            num_adults_charged := num_adults_charged + 1;
            num_people_charged := num_people_charged + 1;
            if( num_adults_charged > ap.max_adults ) then
               exit ad_loop;
            end if;
            if( num_people_charged > ap.max_people ) then
               exit ad_loop;
            end if;
            total_amt := total_amt + this_amt;
         end if;
      end loop ad_loop;
      ch_loop: for chno in 1..bu.num_children loop
         this_amt := 0.0;
         ch_target_loop: for i in 1 .. n loop
            tt := Target_Package.Element( ap.targets, i );
            this_amt := this_amt + Charge_Person( bu.children( chno ), tt );
            log( charging_model, "Get_Application_Cost child loop; amount " & Amount'Image( this_amt ) );
            if ( tt.isExclusive ) and ( this_amt > 0.0) then
               exit ch_target_loop;
            end if;
         end loop ch_target_loop;
         if( this_amt > 0.0 ) then
            num_children_charged := num_children_charged + 1;
            num_people_charged := num_people_charged + 1;
            if( num_children_charged > ap.max_children ) then
               exit ch_loop;
            end if;
            if( num_people_charged > ap.max_people ) then
               exit ch_loop;
            end if;
            total_amt := total_amt + this_amt;                        
         end if;
      end loop ch_loop;
      return total_amt;   
   end Get_Application_Cost;
   
   function Get_Charge_For_Family( bu : Model_Benefit_Unit;  cr : Charging_Regime ) return Amount_List is
      amt : Amount := 0.0;
      n  : constant Natural := Natural( Application_Package.Length( cr.applications ));
      ap : Application_Type;
      m  : Amount_List;
   begin
      for i in 1 .. n loop
         log( charging_model, "Get_Charge_For_Family; iteration " & Positive'Image(i) );
         ap := Application_Package.Element( cr.applications, i );
         amt := Get_Application_Cost( bu, ap );
         Amount_Package.Append( m, amt );
      end loop;
      return m;
   end Get_Charge_For_Family;


   
end Model.Charging;
     
