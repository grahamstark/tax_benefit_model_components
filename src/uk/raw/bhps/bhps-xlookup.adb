package body BHPS.XLookup is

   function Compare_Sernums_Lt( left, right: Sernum_Value ) return Boolean is
   begin
       return left < right;  
   end Compare_Sernums_Lt;
   
   function Compare_Values_Equal( left, right: Xwaveid_Rec ) return Boolean is
   begin
      return False;
   end Compare_Values_Equal;
      
  function Get_Household_Id( xwave : X_Wave_Lookup; wave : Waves; pid : Sernum_Value ) return Wave_Location is
     xw  : Xwaveid_Rec;
     loc : Wave_Location;
  begin
     if not xwave.index.Contains( pid ) then
        return loc;
     end if;
     xw := xwave.index.Element( pid );
     case wave is
        when 'a' => 
           loc.hid := xw.ahid;
           loc.pno := xw.apno;
           loc.individual_interview_ok :=  xw.aivfio = full_interview or xw.aivfio = proxy; 
           loc.household_interview_ok := xw.aivfho in all_eligible_hh_intervd .. hh_comp_plus_ques_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           else
              loc.summary_status := other;
           end if; -- can't be dead 1st time out!
           -- loc.individual_interview_outcome := xw.aivfio;
           -- loc.household_interview_outcome := xw.aivfho;
        when 'b' =>
           loc.hid := xw.bhid;
           loc.pno := xw.bpno;
           loc.individual_interview_ok :=  xw.bivfio = full_interview or xw.bivfio = proxy_interview or xw.bivfio = telephone_intvw; 
           loc.household_interview_ok := xw.bivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.bivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.bivfio = institutnsd_or_nc_hh or xw.bivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'c' =>
           loc.hid := xw.chid;
           loc.pno := xw.cpno;
           loc.individual_interview_ok :=  xw.civfio = full_interview or xw.civfio = proxy_interview or xw.civfio = telephone_intvw; 
           loc.household_interview_ok := xw.civfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.civfio = dead )then
              loc.summary_status := dead;
           elsif( xw.civfio = institutnsd_or_nc_hh or xw.civfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'd' =>
           loc.hid := xw.dhid;
           loc.pno := xw.dpno;
           loc.individual_interview_ok :=  xw.divfio = full_interview or xw.divfio = proxy_interview or xw.divfio = telephone_intvw; 
           loc.household_interview_ok := xw.divfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.divfio = dead )then
              loc.summary_status := dead;
           elsif( xw.divfio = institutnsd_or_nc_hh or xw.divfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'e' =>
           loc.hid := xw.ehid;
           loc.pno := xw.epno;
           loc.individual_interview_ok :=  xw.eivfio = full_interview or xw.eivfio = proxy_interview or xw.eivfio = telephone_intvw; 
           loc.household_interview_ok := xw.eivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.eivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.eivfio = institutnsd_or_nc_hh or xw.eivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'f' =>
           loc.hid := xw.fhid;
           loc.pno := xw.fpno;
           loc.individual_interview_ok :=  xw.fivfio = full_interview or xw.fivfio = proxy_interview or xw.fivfio = telephone_intvw; 
           loc.household_interview_ok := xw.fivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.fivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.fivfio = institutnsd_or_nc_hh or xw.fivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'g' =>
           loc.hid := xw.ghid;
           loc.pno := xw.gpno;
           loc.individual_interview_ok :=  xw.givfio = full_interview or xw.givfio = proxy_interview or xw.givfio = telephone_intvw; 
           loc.household_interview_ok := xw.givfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.givfio = dead )then
              loc.summary_status := dead;
           elsif( xw.givfio = institutnsd_or_nc_hh or xw.givfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'h' =>
           loc.hid := xw.hhid;
           loc.pno := xw.hpno;
           loc.individual_interview_ok :=  xw.hivfio = full_interview or xw.hivfio = proxy_interview or xw.hivfio = telephone_intvw; 
           loc.household_interview_ok := xw.hivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.hivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.hivfio = institutnsd_or_nc_hh or xw.hivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'i' =>
           loc.hid := xw.ihid;
           loc.pno := xw.ipno;
           loc.individual_interview_ok :=  xw.iivfio = full_interview or xw.iivfio = proxy_interview or xw.iivfio = telephone_intvw; 
           loc.household_interview_ok := xw.iivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.iivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.iivfio = institutnsd_or_nc_hh or xw.iivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'j' =>
           loc.hid := xw.jhid;
           loc.pno := xw.jpno;
           loc.individual_interview_ok :=  xw.jivfio = full_interview or xw.jivfio = proxy_interview or xw.jivfio = telephone_intvw; 
           loc.household_interview_ok := xw.jivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.jivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.jivfio = institutnsd_or_nc_hh or xw.jivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'k' =>
           loc.hid := xw.khid;
           loc.pno := xw.kpno;
           loc.individual_interview_ok :=  xw.kivfio = full_interview or xw.kivfio = proxy_interview or xw.kivfio = telephone_intvw; 
           loc.household_interview_ok := xw.kivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.kivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.kivfio = institutnsd_or_nc_hh or xw.kivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'l' =>
           loc.hid := xw.lhid;
           loc.pno := xw.lpno;
           loc.individual_interview_ok :=  xw.livfio = full_interview or xw.livfio = proxy_interview or xw.livfio = telephone_intvw; 
           loc.household_interview_ok := xw.livfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.livfio = dead )then
              loc.summary_status := dead;
           elsif( xw.livfio = institutnsd_or_nc_hh or xw.livfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'm' =>
           loc.hid := xw.mhid;
           loc.pno := xw.mpno;
           loc.individual_interview_ok :=  xw.mivfio = full_interview or xw.mivfio = proxy_interview or xw.mivfio = telephone_intvw; 
           loc.household_interview_ok := xw.mivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.mivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.mivfio = institutnsd_or_nc_hh or xw.mivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'n' =>
           loc.hid := xw.nhid;
           loc.pno := xw.npno;
           loc.individual_interview_ok :=  xw.nivfio = full_interview or xw.nivfio = proxy_interview or xw.nivfio = telephone_intvw; 
           loc.household_interview_ok := xw.nivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.nivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.nivfio = institutnsd_or_nc_hh or xw.nivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'o' =>
           loc.hid := xw.ohid;
           loc.pno := xw.opno;
           loc.individual_interview_ok :=  xw.oivfio = full_interview or xw.oivfio = proxy_interview or xw.oivfio = telephone_intvw; 
           loc.household_interview_ok := xw.oivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.oivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.oivfio = institutnsd_or_nc_hh or xw.oivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'p' =>
           loc.hid := xw.phid;
           loc.pno := xw.ppno;
           loc.individual_interview_ok :=  xw.pivfio = full_interview or xw.pivfio = proxy_interview or xw.pivfio = telephone_intvw; 
           loc.household_interview_ok := xw.pivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.pivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.pivfio = institutnsd_or_nc_hh or xw.pivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'q' =>
           loc.hid := xw.qhid;
           loc.pno := xw.qpno;
           loc.individual_interview_ok :=  xw.qivfio = full_interview or xw.qivfio = proxy_interview or xw.qivfio = telephone_intvw; 
           loc.household_interview_ok := xw.qivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.qivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.qivfio = institutnsd_or_nc_hh or xw.qivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when 'r' =>
           loc.hid := xw.rhid;
           loc.pno := xw.rpno;
           loc.individual_interview_ok :=  xw.rivfio = full_interview or xw.rivfio = proxy_interview or xw.rivfio = telephone_intvw; 
           loc.household_interview_ok := xw.rivfho in all_eligible_hh_intv .. youth_interview_only;
           if( loc.individual_interview_ok ) then
              loc.summary_status := ok;
           elsif( xw.rivfio = dead )then
              loc.summary_status := dead;
           elsif( xw.rivfio = institutnsd_or_nc_hh or xw.rivfio = chd_instit_or_nc_hh )then
              loc.summary_status := institutionalised;
           else
              loc.summary_status := other;
           end if;
        when others => null;
     end case;
     return loc;
  end Get_Household_Id;
  
  procedure Add_Record( xwave : in out X_Wave_Lookup; xw : Xwaveid_Rec ) is
  begin
     xwave.index.Insert( xw.pid, xw );
  end Add_Record;
  
   
end BHPS.XLookup;
