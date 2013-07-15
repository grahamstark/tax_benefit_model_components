with Ada.Strings.Unbounded;
with Text_Utils;

package body ZA.Household is

   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   function To_String( a : Housing_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
      id_n : constant String := Indent( num_indents );
   begin
      s := s & id_n & " ========== Housing";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      s := s & "=======" & LINE_BREAK;
      if( ((a.settl /= MISS) and ( a.settl /= 0 )) or include_missing ) then
         s := s & id_n & "settl (Settlement Type ) : " & Format( a.settl ) & LINE_BREAK;
      end if;
      if( (a.ownship /= Missing ) or include_missing) then
         s := s & id_n & "ownship (ownership of site and dwelling ) : " & Pretty_Print( a.ownship ) & LINE_BREAK;
      end if;
      if( (a.matroof /= Missing ) or include_missing) then
         s := s & id_n & "matroof (main type of material used for roofing ) : " & Pretty_Print( a.matroof ) & LINE_BREAK;
      end if;
      if( (a.matwall /= Missing ) or include_missing) then
         s := s & id_n & "matwall (main type of material used for the walls ) : " & Pretty_Print( a.matwall ) & LINE_BREAK;
      end if;
      if( ((a.dwevalue /= MISS) and ( a.dwevalue /= 0 )) or include_missing ) then
         s := s & id_n & "dwevalue (value of dwelling unit) : " & Format( a.dwevalue ) & LINE_BREAK;
      end if;
      if( ((a.livingr /= MISS) and ( a.livingr /= 0 )) or include_missing ) then
         s := s & id_n & "livingr (number of living roons incl. Kitchen) : " & Format( a.livingr ) & LINE_BREAK;
      end if;
      if( ((a.bedroom /= MISS) and ( a.bedroom /= 0 )) or include_missing ) then
         s := s & id_n & "bedroom (number of bedrooms) : " & Format( a.bedroom ) & LINE_BREAK;
      end if;
      s := s & id_n & "wattank (does hh have a rain water tank? ) : " & Boolean'Image( a.wattank ) & LINE_BREAK;
      if( (a.watsourc /= Missing ) or include_missing) then
         s := s & id_n & "watsourc (main source of drinking water ) : " & Pretty_Print( a.watsourc ) & LINE_BREAK;
      end if;
      if( (a.watmain /= Missing ) or include_missing) then
         s := s & id_n & "watmain (main source of other water  ) : " & Pretty_Print( a.watmain ) & LINE_BREAK;
      end if;
      if( (a.watadeq /= Missing ) or include_missing) then
         s := s & id_n & "watadeq (is water adequate? ) : " & Pretty_Print( a.watadeq ) & LINE_BREAK;
      end if;
      if( (a.watkm /= Missing ) or include_missing) then
         s := s & id_n & "watkm (distance to main source of water ) : " & Pretty_Print( a.watkm ) & LINE_BREAK;
      end if;
      if( (a.watpay /= Missing ) or include_missing) then
         s := s & id_n & "watpay (does hh pay for its water? ) : " & Pretty_Print( a.watpay ) & LINE_BREAK;
      end if;
      if( (a.elpubc /= Missing ) or include_missing) then
         s := s & id_n & "elpubc (does hh get its  cooking electricityfrom a public source?) : " & Pretty_Print( a.elpubc ) & LINE_BREAK;
      end if;
      if( (a.elgenc /= Missing ) or include_missing) then
         s := s & id_n & "elgenc (does hh get its cooking elctricity from a generator?) : " & Pretty_Print( a.elgenc ) & LINE_BREAK;
      end if;
      if( (a.elsolac /= Missing ) or include_missing) then
         s := s & id_n & "elsolac (does hh get its cooking elctricity from solar?) : " & Pretty_Print( a.elsolac ) & LINE_BREAK;
      end if;
      if( (a.cookgas /= Missing ) or include_missing) then
         s := s & id_n & "cookgas (does hh use gas for cooking?) : " & Pretty_Print( a.cookgas ) & LINE_BREAK;
      end if;
      if( (a.cookpar /= Missing ) or include_missing) then
         s := s & id_n & "cookpar (does hh use paraffin for cooking?) : " & Pretty_Print( a.cookpar ) & LINE_BREAK;
      end if;
      if( (a.cookwood /= Missing ) or include_missing) then
         s := s & id_n & "cookwood (does hh use wood for cooking?) : " & Pretty_Print( a.cookwood ) & LINE_BREAK;
      end if;
      if( (a.cookcoal /= Missing ) or include_missing) then
         s := s & id_n & "cookcoal (does hh use coal for cooking?) : " & Pretty_Print( a.cookcoal ) & LINE_BREAK;
      end if;
      if( (a.coocharc /= Missing ) or include_missing) then
         s := s & id_n & "coocharc (does hh use charcoal for cooking?) : " & Pretty_Print( a.coocharc ) & LINE_BREAK;
      end if;
      if( (a.cropwast /= Missing ) or include_missing) then
         s := s & id_n & "cropwast (does hh use crop waste as cooking energy source?) : " & Pretty_Print( a.cropwast ) & LINE_BREAK;
      end if;
      if( (a.cookdung /= Missing ) or include_missing) then
         s := s & id_n & "cookdung (does hh use animal dung as energy source for cooking?) : " & Pretty_Print( a.cookdung ) & LINE_BREAK;
      end if;
      if( (a.cookoth /= Missing ) or include_missing) then
         s := s & id_n & "cookoth (Other sources of energy for cooking) : " & Pretty_Print( a.cookoth ) & LINE_BREAK;
      end if;
      if( (a.heatelp /= Missing ) or include_missing) then
         s := s & id_n & "heatelp (heating electricity from a public source) : " & Pretty_Print( a.heatelp ) & LINE_BREAK;
      end if;
      if( (a.heatelg /= Missing ) or include_missing) then
         s := s & id_n & "heatelg (heating electricity from a public source) : " & Pretty_Print( a.heatelg ) & LINE_BREAK;
      end if;
      if( (a.heatelb /= Missing ) or include_missing) then
         s := s & id_n & "heatelb (heating electricity from a battery) : " & Pretty_Print( a.heatelb ) & LINE_BREAK;
      end if;
      if( (a.heatels /= Missing ) or include_missing) then
         s := s & id_n & "heatels (heating electricity from a solar) : " & Pretty_Print( a.heatels ) & LINE_BREAK;
      end if;
      if( (a.heatgas /= Missing ) or include_missing) then
         s := s & id_n & "heatgas (heating gas) : " & Pretty_Print( a.heatgas ) & LINE_BREAK;
      end if;
      if( (a.heatpar /= Missing ) or include_missing) then
         s := s & id_n & "heatpar (heating paraffin) : " & Pretty_Print( a.heatpar ) & LINE_BREAK;
      end if;
      if( (a.heatwood /= Missing ) or include_missing) then
         s := s & id_n & "heatwood (heating wood) : " & Pretty_Print( a.heatwood ) & LINE_BREAK;
      end if;
      if( (a.heatcoal /= Missing ) or include_missing) then
         s := s & id_n & "heatcoal (coal for heating) : " & Pretty_Print( a.heatcoal ) & LINE_BREAK;
      end if;
      if( (a.heatchar /= Missing ) or include_missing) then
         s := s & id_n & "heatchar (charcoal for heating) : " & Pretty_Print( a.heatchar ) & LINE_BREAK;
      end if;
      if( (a.heatcrop /= Missing ) or include_missing) then
         s := s & id_n & "heatcrop (cropwaste for heating) : " & Pretty_Print( a.heatcrop ) & LINE_BREAK;
      end if;
      if( (a.heatdung /= Missing ) or include_missing) then
         s := s & id_n & "heatdung (animal dung for heating) : " & Pretty_Print( a.heatdung ) & LINE_BREAK;
      end if;
      if( (a.heatoth /= Missing ) or include_missing) then
         s := s & id_n & "heatoth (other heating sources) : " & Pretty_Print( a.heatoth ) & LINE_BREAK;
      end if;
      if( (a.noheat /= Missing ) or include_missing) then
         s := s & id_n & "noheat (no heating source for the hh) : " & Pretty_Print( a.noheat ) & LINE_BREAK;
      end if;
      if( (a.lightelp /= Missing ) or include_missing) then
         s := s & id_n & "lightelp (public source electricity for) : " & Pretty_Print( a.lightelp ) & LINE_BREAK;
      end if;
      if( (a.lightelg /= Missing ) or include_missing) then
         s := s & id_n & "lightelg (generator electricity for lighting) : " & Pretty_Print( a.lightelg ) & LINE_BREAK;
      end if;
      if( (a.lightelb /= Missing ) or include_missing) then
         s := s & id_n & "lightelb (battery source of electricity for lighting) : " & Pretty_Print( a.lightelb ) & LINE_BREAK;
      end if;
      if( (a.lightels /= Missing ) or include_missing) then
         s := s & id_n & "lightels (solar electricity for lighting) : " & Pretty_Print( a.lightels ) & LINE_BREAK;
      end if;
      if( (a.lightgas /= Missing ) or include_missing) then
         s := s & id_n & "lightgas (use of gas for lighting) : " & Pretty_Print( a.lightgas ) & LINE_BREAK;
      end if;
      if( (a.lightpar /= Missing ) or include_missing) then
         s := s & id_n & "lightpar (use of paraffin for lighting) : " & Pretty_Print( a.lightpar ) & LINE_BREAK;
      end if;
      if( (a.lightcan /= Missing ) or include_missing) then
         s := s & id_n & "lightcan (use of candles for lighting) : " & Pretty_Print( a.lightcan ) & LINE_BREAK;
      end if;
      if( (a.lightoth /= Missing ) or include_missing) then
         s := s & id_n & "lightoth (use of other sources of lighting) : " & Pretty_Print( a.lightoth ) & LINE_BREAK;
      end if;
      if( (a.fwoods /= Missing ) or include_missing) then
         s := s & id_n & "fwoods (source of firewood ) : " & Pretty_Print( a.fwoods ) & LINE_BREAK;
      end if;
      if( (a.fwoodad /= Missing ) or include_missing) then
         s := s & id_n & "fwoodad (firewood adequacy ) : " & Pretty_Print( a.fwoodad ) & LINE_BREAK;
      end if;
      if( (a.fwoodkm /= Missing ) or include_missing) then
         s := s & id_n & "fwoodkm (distance to firewood source ) : " & Pretty_Print( a.fwoodkm ) & LINE_BREAK;
      end if;
      s := s & id_n & "fwoopay (does hh pay for its firewood? ) : " & Boolean'Image( a.fwoopay ) & LINE_BREAK;
      if( ((a.sanitin /= MISS) and ( a.sanitin /= 0 )) or include_missing ) then
         s := s & id_n & "sanitin (sanitation in the house) : " & Format( a.sanitin ) & LINE_BREAK;
      end if;
      if( ((a.saniton /= MISS) and ( a.saniton /= 0 )) or include_missing ) then
         s := s & id_n & "saniton (sanitation is on the site) : " & Format( a.saniton ) & LINE_BREAK;
      end if;
      if( ((a.sanitoff /= MISS) and ( a.sanitoff /= 0 )) or include_missing ) then
         s := s & id_n & "sanitoff (sanitation is off site) : " & Format( a.sanitoff ) & LINE_BREAK;
      end if;
      s := s & id_n & "sanitsh (sharing of sanitation ) : " & Boolean'Image( a.sanitsh ) & LINE_BREAK;
      if( ((a.sanitno /= MISS) and ( a.sanitno /= 0 )) or include_missing ) then
         s := s & id_n & "sanitno (number of hhs sharing the sanitation) : " & Format( a.sanitno ) & LINE_BREAK;
      end if;
      if( (a.toilkm /= Missing ) or include_missing) then
         s := s & id_n & "toilkm (distance to the nearest toilet ) : " & Pretty_Print( a.toilkm ) & LINE_BREAK;
      end if;
      if( ((a.toilbuck /= MISS) and ( a.toilbuck /= 0 )) or include_missing ) then
         s := s & id_n & "toilbuck (frequency of removing bucket toilet ) : " & Format( a.toilbuck ) & LINE_BREAK;
      end if;
      if( (a.refdisp /= Missing ) or include_missing) then
         s := s & id_n & "refdisp (method of disposing of refuse ) : " & Pretty_Print( a.refdisp ) & LINE_BREAK;
      end if;
      if( (a.reffreq /= Missing ) or include_missing) then
         s := s & id_n & "reffreq (frequency of refuse collection ) : " & Pretty_Print( a.reffreq ) & LINE_BREAK;
      end if;
      if( ((a.telcell /= MISS) and ( a.telcell /= 0 )) or include_missing ) then
         s := s & id_n & "telcell (ownership of a cell phone) : " & Format( a.telcell ) & LINE_BREAK;
      end if;
      if( ((a.teloth /= MISS) and ( a.teloth /= 0 )) or include_missing ) then
         s := s & id_n & "teloth (ownership and use of other telephone types) : " & Format( a.teloth ) & LINE_BREAK;
      end if;
      if( (a.telkm /= Missing ) or include_missing) then
         s := s & id_n & "telkm (distance to the nearest telephone ) : " & Pretty_Print( a.telkm ) & LINE_BREAK;
      end if;
      s := s & id_n & "landacc (access to land for farming ) : " & Boolean'Image( a.landacc ) & LINE_BREAK;
      if( ((a.landha /= MISS) and ( a.landha /= 0 )) or include_missing ) then
         s := s & id_n & "landha (size of land in hectares) : " & Format( a.landha ) & LINE_BREAK;
      end if;
      if( ((a.landdry /= MISS) and ( a.landdry /= 0 )) or include_missing ) then
         s := s & id_n & "landdry (size of dryland for cultivation) : " & Format( a.landdry ) & LINE_BREAK;
      end if;
      if( ((a.landirr /= MISS) and ( a.landirr /= 0 )) or include_missing ) then
         s := s & id_n & "landirr (size of irrigated land) : " & Format( a.landirr ) & LINE_BREAK;
      end if;
      if( (a.landirs /= Missing ) or include_missing) then
         s := s & id_n & "landirs (source of irrigation water ) : " & Pretty_Print( a.landirs ) & LINE_BREAK;
      end if;
      s := s & id_n & "landgr (availability of grazing land ) : " & Boolean'Image( a.landgr ) & LINE_BREAK;
      if( ((a.landcomh /= MISS) and ( a.landcomh /= 0 )) or include_missing ) then
         s := s & id_n & "landcomh (communal land for cultivation) : " & Format( a.landcomh ) & LINE_BREAK;
      end if;
      if( ((a.landcdry /= MISS) and ( a.landcdry /= 0 )) or include_missing ) then
         s := s & id_n & "landcdry (size of dry communal land) : " & Format( a.landcdry ) & LINE_BREAK;
      end if;
      if( ((a.landcirr /= MISS) and ( a.landcirr /= 0 )) or include_missing ) then
         s := s & id_n & "landcirr (size of irrigated communal land) : " & Format( a.landcirr ) & LINE_BREAK;
      end if;
      if( ((a.landiha /= MISS) and ( a.landiha /= 0 )) or include_missing ) then
         s := s & id_n & "landiha (size of communal irrigated land) : " & Format( a.landiha ) & LINE_BREAK;
      end if;
      if( ((a.landctr /= MISS) and ( a.landctr /= 0 )) or include_missing ) then
         s := s & id_n & "landctr (tribal communal land) : " & Format( a.landctr ) & LINE_BREAK;
      end if;
      s := s & id_n & "tribocch (occupancy of land alocated by a tribal authority ) : " & Boolean'Image( a.tribocch ) & LINE_BREAK;
      if( ((a.tribdry /= MISS) and ( a.tribdry /= 0 )) or include_missing ) then
         s := s & id_n & "tribdry (dry tribal land) : " & Format( a.tribdry ) & LINE_BREAK;
      end if;
      if( ((a.tribirr /= MISS) and ( a.tribirr /= 0 )) or include_missing ) then
         s := s & id_n & "tribirr (size of irrigated tribal land) : " & Format( a.tribirr ) & LINE_BREAK;
      end if;
      if( ((a.tribirs /= MISS) and ( a.tribirs /= 0 )) or include_missing ) then
         s := s & id_n & "tribirs (source of irrigation for tribal land) : " & Format( a.tribirs ) & LINE_BREAK;
      end if;
      if( ((a.tribcom /= MISS) and ( a.tribcom /= 0 )) or include_missing ) then
         s := s & id_n & "tribcom (communally used tribal land) : " & Format( a.tribcom ) & LINE_BREAK;
      end if;
      if( ((a.tribcdry /= MISS) and ( a.tribcdry /= 0 )) or include_missing ) then
         s := s & id_n & "tribcdry (size of dry-communally used tribal land) : " & Format( a.tribcdry ) & LINE_BREAK;
      end if;
      if( ((a.tribcir /= MISS) and ( a.tribcir /= 0 )) or include_missing ) then
         s := s & id_n & "tribcir (size of irrigated-communally used tribal land) : " & Format( a.tribcir ) & LINE_BREAK;
      end if;
      if( ((a.tribcirs /= MISS) and ( a.tribcirs /= 0 )) or include_missing ) then
         s := s & id_n & "tribcirs (source of irrigated-communally used tribal land) : " & Format( a.tribcirs ) & LINE_BREAK;
      end if;
      if( ((a.truha /= MISS) and ( a.truha /= 0 )) or include_missing ) then
         s := s & id_n & "truha (size of trust land allocated by government) : " & Format( a.truha ) & LINE_BREAK;
      end if;
      if( ((a.trudry /= MISS) and ( a.trudry /= 0 )) or include_missing ) then
         s := s & id_n & "trudry (size of dry trust land) : " & Format( a.trudry ) & LINE_BREAK;
      end if;
      if( ((a.truirr /= MISS) and ( a.truirr /= 0 )) or include_missing ) then
         s := s & id_n & "truirr (size of irrigated trust land) : " & Format( a.truirr ) & LINE_BREAK;
      end if;
      if( (a.trus /= Missing ) or include_missing) then
         s := s & id_n & "trus (source of irrigation water for trust land) : " & Pretty_Print( a.trus ) & LINE_BREAK;
      end if;
      s := s & id_n & "trugr (availability of trust land for grazing ) : " & Boolean'Image( a.trugr ) & LINE_BREAK;
      if( ((a.tenha /= MISS) and ( a.tenha /= 0 )) or include_missing ) then
         s := s & id_n & "tenha (size of land occupied by tenants) : " & Format( a.tenha ) & LINE_BREAK;
      end if;
      if( ((a.tendry /= MISS) and ( a.tendry /= 0 )) or include_missing ) then
         s := s & id_n & "tendry (size of dry land occupied by tenants) : " & Format( a.tendry ) & LINE_BREAK;
      end if;
      if( ((a.tenirr /= MISS) and ( a.tenirr /= 0 )) or include_missing ) then
         s := s & id_n & "tenirr (size of irrigated tenant land) : " & Format( a.tenirr ) & LINE_BREAK;
      end if;
      if( ((a.tenirs /= MISS) and ( a.tenirs /= 0 )) or include_missing ) then
         s := s & id_n & "tenirs (source of water for irrigating tenant land) : " & Format( a.tenirs ) & LINE_BREAK;
      end if;
      if( ((a.tengr /= MISS) and ( a.tengr /= 0 )) or include_missing ) then
         s := s & id_n & "tengr (availability of grazing land) : " & Format( a.tengr ) & LINE_BREAK;
      end if;
      if( (a.safeout /= Missing ) or include_missing) then
         s := s & id_n & "safeout (safety conditions outside dwelling ) : " & Pretty_Print( a.safeout ) & LINE_BREAK;
      end if;
      if( (a.safein /= Missing ) or include_missing) then
         s := s & id_n & "safein (safety conditions inside dwelling ) : " & Pretty_Print( a.safein ) & LINE_BREAK;
      end if;
      if( (a.safeprev /= Missing ) or include_missing) then
         s := s & id_n & "safeprev (comparison of safety with previous year ) : " & Pretty_Print( a.safeprev ) & LINE_BREAK;
      end if;
      s := s & id_n & "crimevic (has been victim of crime ) : " & Boolean'Image( a.crimevic ) & LINE_BREAK;
      if( (a.crime1 /= Missing ) or include_missing) then
         s := s & id_n & "crime1 (First victim ) : " & Pretty_Print( a.crime1 ) & LINE_BREAK;
      end if;
      if( (a.crime2 /= Missing ) or include_missing) then
         s := s & id_n & "crime2 (Second victim ) : " & Pretty_Print( a.crime2 ) & LINE_BREAK;
      end if;
      if( (a.crime3 /= Missing ) or include_missing) then
         s := s & id_n & "crime3 (Third victim ) : " & Pretty_Print( a.crime3 ) & LINE_BREAK;
      end if;
      if( (a.crime4 /= Missing ) or include_missing) then
         s := s & id_n & "crime4 (Fourth victim ) : " & Pretty_Print( a.crime4 ) & LINE_BREAK;
      end if;
      if( (a.crime5 /= Missing ) or include_missing) then
         s := s & id_n & "crime5 (Fifth victim ) : " & Pretty_Print( a.crime5 ) & LINE_BREAK;
      end if;
      if( (a.crime6 /= Missing ) or include_missing) then
         s := s & id_n & "crime6 (Sixth victim ) : " & Pretty_Print( a.crime6 ) & LINE_BREAK;
      end if;
      if( (a.pollute /= Missing ) or include_missing) then
         s := s & id_n & "pollute (Difficulty in breathing due to pollution ) : " & Pretty_Print( a.pollute ) & LINE_BREAK;
      end if;
      if( (a.feedab /= Missing ) or include_missing) then
         s := s & id_n & "feedab (ability to feed children ) : " & Pretty_Print( a.feedab ) & LINE_BREAK;
      end if;
      if( (a.satisf /= Missing ) or include_missing) then
         s := s & id_n & "satisf (satisfied with living conditions ) : " & Pretty_Print( a.satisf ) & LINE_BREAK;
      end if;
      if( (a.compliv /= Missing ) or include_missing) then
         s := s & id_n & "compliv (comparison of living conditions with the previous ) : " & Pretty_Print( a.compliv ) & LINE_BREAK;
      end if;
      s := s & id_n & "reshead (does head of hh reside at hh at least 4 nights a week ) : " & Boolean'Image( a.reshead ) & LINE_BREAK;
      if( (a.reashead /= Missing ) or include_missing) then
         s := s & id_n & "reashead (reason for head of hh not residing at hh ) : " & Pretty_Print( a.reashead ) & LINE_BREAK;
      end if;
      s := s & id_n & "misschn (Are there any children of the hh who are missing or street kids ) : " & Boolean'Image( a.misschn ) & LINE_BREAK;
      if( ((a.misschno /= MISS) and ( a.misschno /= 0 )) or include_missing ) then
         s := s & id_n & "misschno (number of missing children) : " & Format( a.misschno ) & LINE_BREAK;
      end if;
      if( (a.medsour /= Missing ) or include_missing) then
         s := s & id_n & "medsour (source of medical services ) : " & Pretty_Print( a.medsour ) & LINE_BREAK;
      end if;
      if( (a.medkm /= Missing ) or include_missing) then
         s := s & id_n & "medkm (distance to nearest medical service centre ) : " & Pretty_Print( a.medkm ) & LINE_BREAK;
      end if;
      if( (a.medtime /= Missing ) or include_missing) then
         s := s & id_n & "medtime (time to the medical service ) : " & Pretty_Print( a.medtime ) & LINE_BREAK;
      end if;
      if( ((a.meddi /= MISS) and ( a.meddi /= 0 )) or include_missing ) then
         s := s & id_n & "meddi (district where the medical service was obtained) : " & Format( a.meddi ) & LINE_BREAK;
      end if;
      if( (a.medpr /= Missing ) or include_missing) then
         s := s & id_n & "medpr (province where medical service was obtained) : " & Pretty_Print( a.medpr ) & LINE_BREAK;
      end if;
      if( ((a.hospdi /= MISS) and ( a.hospdi /= 0 )) or include_missing ) then
         s := s & id_n & "hospdi (district where public hospital is located) : " & Format( a.hospdi ) & LINE_BREAK;
      end if;
      if( (a.hosppr /= Missing ) or include_missing) then
         s := s & id_n & "hosppr (province where public hospital is located) : " & Pretty_Print( a.hosppr ) & LINE_BREAK;
      end if;
      if( (a.welfkm /= Missing ) or include_missing) then
         s := s & id_n & "welfkm (distance to the nearest welfare centre ) : " & Pretty_Print( a.welfkm ) & LINE_BREAK;
      end if;

      s := s & LINE_BREAK;
      return To_String( s );
   end To_String;
   

   function To_String( a : Demographics_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
      id_n : constant String := Indent( num_indents );
   begin
      s := s & id_n & " ========== Person";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      s := s & "=======" & LINE_BREAK;
      if( ((a.hhid /= MISS) and ( a.hhid /= 0 )) or include_missing ) then
         s := s & id_n & "hhid (Household Identification Number) : " & Format( a.hhid ) & LINE_BREAK;
      end if;
      if( ((a.pid /= MISS) and ( a.pid /= 0 )) or include_missing ) then
         s := s & id_n & "pid (Person Identification Number) : " & Format( a.pid ) & LINE_BREAK;
      end if;
      if( ((a.age /= MISS) and ( a.age /= 0 )) or include_missing ) then
         s := s & id_n & "age (Age in years) : " & Format( a.age ) & LINE_BREAK;
      end if;
      if( (a.relate /= Missing ) or include_missing) then
         s := s & id_n & "relate (Relationship of member to hh head ) : " & Pretty_Print( a.relate ) & LINE_BREAK;
      end if;
      if( ((a.spcod /= MISS) and ( a.spcod /= 0 )) or include_missing ) then
         s := s & id_n & "spcod (member's spouse' code if spouse is member of hh) : " & Format( a.spcod ) & LINE_BREAK;
      end if;
      if( ((a.fatcod /= MISS) and ( a.fatcod /= 0 )) or include_missing ) then
         s := s & id_n & "fatcod (member's father's PID if father is member of hh) : " & Format( a.fatcod ) & LINE_BREAK;
      end if;
      if( ((a.motcod /= MISS) and ( a.motcod /= 0 )) or include_missing ) then
         s := s & id_n & "motcod (member's mother's PID if mother is member of hh) : " & Format( a.motcod ) & LINE_BREAK;
      end if;
      if( (a.mstate /= Missing ) or include_missing) then
         s := s & id_n & "mstate (Marital status ) : " & Pretty_Print( a.mstate ) & LINE_BREAK;
      end if;
      if( (a.gender /= Missing ) or include_missing) then
         s := s & id_n & "gender (Gender of member) : " & Pretty_Print( a.gender ) & LINE_BREAK;
      end if;
      if( (a.prov /= Missing ) or include_missing) then
         s := s & id_n & "prov (Province where hh is located) : " & Pretty_Print( a.prov ) & LINE_BREAK;
      end if;
      if( ((a.district /= MISS) and ( a.district /= 0 )) or include_missing ) then
         s := s & id_n & "district (District where hh is located) : " & Format( a.district ) & LINE_BREAK;
      end if;
      if( ((a.ea /= MISS) and ( a.ea /= 0 )) or include_missing ) then
         s := s & id_n & "ea (Enumeration area where hh is located) : " & Format( a.ea ) & LINE_BREAK;
      end if;
      if( ((a.branchea /= MISS) and ( a.branchea /= 0 )) or include_missing ) then
         s := s & id_n & "branchea (Equivalent to EA) : " & Format( a.branchea ) & LINE_BREAK;
      end if;
      if( (a.dwe /= Missing ) or include_missing) then
         s := s & id_n & "dwe (Type of dwelling unit hh lives in) : " & Pretty_Print( a.dwe ) & LINE_BREAK;
      end if;
      if( (a.loc /= Missing ) or include_missing) then
         s := s & id_n & "loc (Location of household ) : " & Pretty_Print( a.loc ) & LINE_BREAK;
      end if;
      if( ((a.visit /= MISS) and ( a.visit /= 0 )) or include_missing ) then
         s := s & id_n & "visit (Visiting Point Number) : " & Format( a.visit ) & LINE_BREAK;
      end if;
      if( ((a.hhsize /= MISS) and ( a.hhsize /= 0 )) or include_missing ) then
         s := s & id_n & "hhsize (Household size) : " & Format( a.hhsize ) & LINE_BREAK;
      end if;
      if( (a.race /= Missing ) or include_missing) then
         s := s & id_n & "race (Race of member ) : " & Pretty_Print( a.race ) & LINE_BREAK;
      end if;
      s := s & id_n & "fataliv (Whether member's father is alive ) : " & Boolean'Image( a.fataliv ) & LINE_BREAK;
      s := s & id_n & "motaliv (Whether member's mother is alive ) : " & Boolean'Image( a.motaliv ) & LINE_BREAK;
      s := s & id_n & "membpr (whether member was present during interview) : " & Boolean'Image( a.membpr ) & LINE_BREAK;
      if( ((a.birth /= MISS) and ( a.birth /= 0 )) or include_missing ) then
         s := s & id_n & "birth (Year member was born) : " & Format( a.birth ) & LINE_BREAK;
      end if;
      if( ((a.wobirt /= MISS) and ( a.wobirt /= 0 )) or include_missing ) then
         s := s & id_n & "wobirt (Number of Women who ever gave birth) : " & Format( a.wobirt ) & LINE_BREAK;
      end if;
      if( ((a.childr /= MISS) and ( a.childr /= 0 )) or include_missing ) then
         s := s & id_n & "childr (Ideal number of children member would prefer) : " & Format( a.childr ) & LINE_BREAK;
      end if;
      if( (a.bornpr /= Missing ) or include_missing) then
         s := s & id_n & "bornpr (Province where member was born ) : " & Pretty_Print( a.bornpr ) & LINE_BREAK;
      end if;
      if( ((a.borndi /= MISS) and ( a.borndi /= 0 )) or include_missing ) then
         s := s & id_n & "borndi (District where member was born ) : " & Format( a.borndi ) & LINE_BREAK;
      end if;
      if( ((a.bornco /= MISS) and ( a.bornco /= 0 )) or include_missing ) then
         s := s & id_n & "bornco (Country where member was born ) : " & Format( a.bornco ) & LINE_BREAK;
      end if;
      if( ((a.migr /= MISS) and ( a.migr /= 0 )) or include_missing ) then
         s := s & id_n & "migr (Whether memmber has migrated into present area of residence since ) : " & Format( a.migr ) & LINE_BREAK;
      end if;
      if( (a.migrpr /= Missing ) or include_missing) then
         s := s & id_n & "migrpr (Province from which member migrated if member did migrate) : " & Pretty_Print( a.migrpr ) & LINE_BREAK;
      end if;
      if( ((a.migrdi /= MISS) and ( a.migrdi /= 0 )) or include_missing ) then
         s := s & id_n & "migrdi (District from which member migrated if member did migrate) : " & Format( a.migrdi ) & LINE_BREAK;
      end if;
      if( ((a.migrco /= MISS) and ( a.migrco /= 0 )) or include_missing ) then
         s := s & id_n & "migrco (Country from which member migrated if member did migrate) : " & Format( a.migrco ) & LINE_BREAK;
      end if;
      if( (a.predw /= Missing ) or include_missing) then
         s := s & id_n & "predw (Previous type of dwelling unit ) : " & Pretty_Print( a.predw ) & LINE_BREAK;
      end if;
      s := s & id_n & "creche (Whether children (below 6 years) are attending creche) : " & Boolean'Image( a.creche ) & LINE_BREAK;
      s := s & id_n & "study (whether member is studying) : " & Boolean'Image( a.study ) & LINE_BREAK;
      s := s & id_n & "liter (Whether member underwent adult litearcy programme) : " & Boolean'Image( a.liter ) & LINE_BREAK;
      s := s & id_n & "skill (Whether member has acquired any artisan or operator skill ) : " & Boolean'Image( a.skill ) & LINE_BREAK;
      if( ((a.sktyp /= MISS) and ( a.sktyp /= 0 )) or include_missing ) then
         s := s & id_n & "sktyp (Type of skill member posseses ) : " & Format( a.sktyp ) & LINE_BREAK;
      end if;
      s := s & id_n & "migwor (whether member is a migrant worker ) : " & Boolean'Image( a.migwor ) & LINE_BREAK;
      s := s & id_n & "feedsch (Whether children take part in feeding scheme at school) : " & Boolean'Image( a.feedsch ) & LINE_BREAK;
      if( ((a.educ /= MISS) and ( a.educ /= 0 )) or include_missing ) then
         s := s & id_n & "educ (Highest level of education attained ) : " & Format( a.educ ) & LINE_BREAK;
      end if;
      s := s & id_n & "edcont (Whether member would have wanted to continue with schooling) : " & Boolean'Image( a.edcont ) & LINE_BREAK;
      if( (a.edreas /= Missing ) or include_missing) then
         s := s & id_n & "edreas (Reason for not continuing with schooling) : " & Pretty_Print( a.edreas ) & LINE_BREAK;
      end if;
      if( ((a.edfees /= MISS) and ( a.edfees /= 0 )) or include_missing ) then
         s := s & id_n & "edfees (Tuition fees paid related to learning ) : " & Format( a.edfees ) & LINE_BREAK;
      end if;
      if( ((a.edtra /= MISS) and ( a.edtra /= 0 )) or include_missing ) then
         s := s & id_n & "edtra (Transport cost to school) : " & Format( a.edtra ) & LINE_BREAK;
      end if;
      if( ((a.edoth /= MISS) and ( a.edoth /= 0 )) or include_missing ) then
         s := s & id_n & "edoth (Other expenses related to education [boarding, textbooks, uniforms]) : " & Format( a.edoth ) & LINE_BREAK;
      end if;
      s := s & id_n & "ill (Whether member fell ill during the last month ) : " & Boolean'Image( a.ill ) & LINE_BREAK;
      s := s & id_n & "injury (Whether member got injured during last month ) : " & Boolean'Image( a.injury ) & LINE_BREAK;
      s := s & id_n & "discha (Whether member was discharged from hospital in last month ) : " & Boolean'Image( a.discha ) & LINE_BREAK;
      s := s & id_n & "consn (whether member consulted a nurse) : " & Boolean'Image( a.consn ) & LINE_BREAK;
      s := s & id_n & "conssp (whether member consulted a medical specialise) : " & Boolean'Image( a.conssp ) & LINE_BREAK;
      s := s & id_n & "consdo (whether member consulted a doctor) : " & Boolean'Image( a.consdo ) & LINE_BREAK;
      s := s & id_n & "consde (whether member consulted a dentist) : " & Boolean'Image( a.consde ) & LINE_BREAK;
      s := s & id_n & "consph (whether member consulted a pharmacist) : " & Boolean'Image( a.consph ) & LINE_BREAK;
      s := s & id_n & "consot (whether member consulted an occupational therapist) : " & Boolean'Image( a.consot ) & LINE_BREAK;
      s := s & id_n & "consfh (whether member consulted a faith healer) : " & Boolean'Image( a.consfh ) & LINE_BREAK;
      s := s & id_n & "constr (whether member consulted a traditional healer) : " & Boolean'Image( a.constr ) & LINE_BREAK;
      if( (a.conspla /= Missing ) or include_missing) then
         s := s & id_n & "conspla (Place where consultation took place) : " & Pretty_Print( a.conspla ) & LINE_BREAK;
      end if;
      s := s & id_n & "conspay (Whether member paid for the consultation ) : " & Boolean'Image( a.conspay ) & LINE_BREAK;
      s := s & id_n & "medaid (Whether member has access to medical aid ) : " & Boolean'Image( a.medaid ) & LINE_BREAK;
      s := s & id_n & "smoke (Whether member smokes or not ) : " & Boolean'Image( a.smoke ) & LINE_BREAK;
      if( ((a.smokag /= MISS) and ( a.smokag /= 0 )) or include_missing ) then
         s := s & id_n & "smokag (Age at which member started smoking ) : " & Format( a.smokag ) & LINE_BREAK;
      end if;
      if( (a.disab1 /= Missing ) or include_missing) then
         s := s & id_n & "disab1 (First type of disability that person has) : " & Pretty_Print( a.disab1 ) & LINE_BREAK;
      end if;
      if( ((a.disab2 /= MISS) and ( a.disab2 /= 0 )) or include_missing ) then
         s := s & id_n & "disab2 (Person with sight defect) : " & Format( a.disab2 ) & LINE_BREAK;
      end if;
      if( ((a.disab3 /= MISS) and ( a.disab3 /= 0 )) or include_missing ) then
         s := s & id_n & "disab3 (Person with hearing/speech defect) : " & Format( a.disab3 ) & LINE_BREAK;
      end if;
      s := s & id_n & "welf (Whether person used welfare services) : " & Boolean'Image( a.welf ) & LINE_BREAK;
      if( ((a.welfa /= MISS) and ( a.welfa /= 0 )) or include_missing ) then
         s := s & id_n & "welfa (first type of welfare service used) : " & Format( a.welfa ) & LINE_BREAK;
      end if;
      if( ((a.welfb /= MISS) and ( a.welfb /= 0 )) or include_missing ) then
         s := s & id_n & "welfb (second type of welfare service used) : " & Format( a.welfb ) & LINE_BREAK;
      end if;
      if( ((a.welfc /= MISS) and ( a.welfc /= 0 )) or include_missing ) then
         s := s & id_n & "welfc (third type of welfare service used) : " & Format( a.welfc ) & LINE_BREAK;
      end if;
      if( ((a.weight /= MISS) and ( a.weight /= 0 )) or include_missing ) then
         s := s & id_n & "weight (Not to be used) : " & Format( a.weight ) & LINE_BREAK;
      end if;
      if( ((a.iweigh /= MISS) and ( a.iweigh /= 0 )) or include_missing ) then
         s := s & id_n & "iweigh (Individual weight ) : " & Format( a.iweigh ) & LINE_BREAK;
      end if;
      if( ((a.sch1 /= MISS) and ( a.sch1 /= 0 )) or include_missing ) then
         s := s & id_n & "sch1 (No. of women who ever gave birth in the hh) : " & Format( a.sch1 ) & LINE_BREAK;
      end if;
      s := s & id_n & "sch2 (person has primary education ) : " & Boolean'Image( a.sch2 ) & LINE_BREAK;
      s := s & id_n & "sch3 (Person has secondary education ) : " & Boolean'Image( a.sch3 ) & LINE_BREAK;
      s := s & id_n & "sch4 (Person has matric ) : " & Boolean'Image( a.sch4 ) & LINE_BREAK;
      s := s & id_n & "sch5 (Person has no matric but Diploma ) : " & Boolean'Image( a.sch5 ) & LINE_BREAK;
      s := s & id_n & "sch6 (Person has University degree ) : " & Boolean'Image( a.sch6 ) & LINE_BREAK;
      if( (a.edcat /= Missing ) or include_missing) then
         s := s & id_n & "edcat (Education categories) : " & Pretty_Print( a.edcat ) & LINE_BREAK;
      end if;
      if( ((a.ed1 /= MISS) and ( a.ed1 /= 0 )) or include_missing ) then
         s := s & id_n & "ed1 (Education Spline - 7 years of schooling) : " & Format( a.ed1 ) & LINE_BREAK;
      end if;
      if( ((a.ed2 /= MISS) and ( a.ed2 /= 0 )) or include_missing ) then
         s := s & id_n & "ed2 (Education Spline- 7-12 years of schooling) : " & Format( a.ed2 ) & LINE_BREAK;
      end if;
      if( ((a.ed3 /= MISS) and ( a.ed3 /= 0 )) or include_missing ) then
         s := s & id_n & "ed3 (Education Spline - 12-14 years of schooling) : " & Format( a.ed3 ) & LINE_BREAK;
      end if;
      if( ((a.ed4 /= MISS) and ( a.ed4 /= 0 )) or include_missing ) then
         s := s & id_n & "ed4 (Education spline - 14 or more years of schooling) : " & Format( a.ed4 ) & LINE_BREAK;
      end if;
      s := s & id_n & "stude (Member is a student ) : " & Boolean'Image( a.stude ) & LINE_BREAK;
      s := s & id_n & "studft (Member is a full time student ) : " & Boolean'Image( a.studft ) & LINE_BREAK;
      s := s & id_n & "studpt (Member is a part time student ) : " & Boolean'Image( a.studpt ) & LINE_BREAK;
      s := s & id_n & "maried (whether member is married or not) : " & Boolean'Image( a.maried ) & LINE_BREAK;

      s := s & LINE_BREAK;
      return To_String( s );
   end To_String;
   

   function To_String( a : Work_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
      id_n : constant String := Indent( num_indents );
   begin
      s := s & id_n & " ========== Work";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      s := s & "=======" & LINE_BREAK;
      if( ((a.activ /= MISS) and ( a.activ /= 0 )) or include_missing ) then
         s := s & id_n & "activ (main activity in last 7 days) : " & Format( a.activ ) & LINE_BREAK;
      end if;
      if( ((a.work /= MISS) and ( a.work /= 0 )) or include_missing ) then
         s := s & id_n & "work (if not wking did you do any work in past yr) : " & Format( a.work ) & LINE_BREAK;
      end if;
      if( ((a.worlag /= MISS) and ( a.worlag /= 0 )) or include_missing ) then
         s := s & id_n & "worlag (how long member last worked) : " & Format( a.worlag ) & LINE_BREAK;
      end if;
      if( ((a.worhrs /= MISS) and ( a.worhrs /= 0 )) or include_missing ) then
         s := s & id_n & "worhrs (hours worked in last 7 days) : " & Format( a.worhrs ) & LINE_BREAK;
      end if;
      if( ((a.wormor /= MISS) and ( a.wormor /= 0 )) or include_missing ) then
         s := s & id_n & "wormor (would have liked more hrs) : " & Format( a.wormor ) & LINE_BREAK;
      end if;
      if( ((a.morehrs /= MISS) and ( a.morehrs /= 0 )) or include_missing ) then
         s := s & id_n & "morehrs (total hrs member would have liked) : " & Format( a.morehrs ) & LINE_BREAK;
      end if;
      if( ((a.trans1 /= MISS) and ( a.trans1 /= 0 )) or include_missing ) then
         s := s & id_n & "trans1 (1st option of mode of transport to work used) : " & Format( a.trans1 ) & LINE_BREAK;
      end if;
      if( ((a.trans2 /= MISS) and ( a.trans2 /= 0 )) or include_missing ) then
         s := s & id_n & "trans2 (second option of mode of transport to work used) : " & Format( a.trans2 ) & LINE_BREAK;
      end if;
      if( ((a.trans3 /= MISS) and ( a.trans3 /= 0 )) or include_missing ) then
         s := s & id_n & "trans3 (3rd option of mode of transport to work used) : " & Format( a.trans3 ) & LINE_BREAK;
      end if;
      if( ((a. timelv /= MISS) and ( a. timelv /= 0 )) or include_missing ) then
         s := s & id_n & " timelv (time member leaves home for work) : " & Format( a. timelv ) & LINE_BREAK;
      end if;
      if( ((a.timear /= MISS) and ( a.timear /= 0 )) or include_missing ) then
         s := s & id_n & "timear (time member arrives at work) : " & Format( a.timear ) & LINE_BREAK;
      end if;
      if( ((a.workdi /= MISS) and ( a.workdi /= 0 )) or include_missing ) then
         s := s & id_n & "workdi (district where member works) : " & Format( a.workdi ) & LINE_BREAK;
      end if;
      if( (a.workpr /= Missing ) or include_missing) then
         s := s & id_n & "workpr (province where member works) : " & Pretty_Print( a.workpr ) & LINE_BREAK;
      end if;
      if( ((a.wstat /= MISS) and ( a.wstat /= 0 )) or include_missing ) then
         s := s & id_n & "wstat (member's work status eg self employed) : " & Format( a.wstat ) & LINE_BREAK;
      end if;
      if( ((a.wostar /= MISS) and ( a.wostar /= 0 )) or include_missing ) then
         s := s & id_n & "wostar (year and month member started working for present employer) : " & Format( a.wostar ) & LINE_BREAK;
      end if;
      if( ((a.union /= MISS) and ( a.union /= 0 )) or include_missing ) then
         s := s & id_n & "union (membership of trade union) : " & Format( a.union ) & LINE_BREAK;
      end if;
      if( ((a.matern /= MISS) and ( a.matern /= 0 )) or include_missing ) then
         s := s & id_n & "matern (martenity condition at work) : " & Format( a.matern ) & LINE_BREAK;
      end if;
      if( ((a.occup /= MISS) and ( a.occup /= 0 )) or include_missing ) then
         s := s & id_n & "occup (member's occupation) : " & Format( a.occup ) & LINE_BREAK;
      end if;
      if( ((a.indust /= MISS) and ( a.indust /= 0 )) or include_missing ) then
         s := s & id_n & "indust (member's industry) : " & Format( a.indust ) & LINE_BREAK;
      end if;
      if( ((a.salary /= MISS) and ( a.salary /= 0 )) or include_missing ) then
         s := s & id_n & "salary (salary from main job) : " & Format( a.salary ) & LINE_BREAK;
      end if;
      if( ((a.salgp /= MISS) and ( a.salgp /= 0 )) or include_missing ) then
         s := s & id_n & "salgp (income group of member) : " & Format( a.salgp ) & LINE_BREAK;
      end if;
      if( ((a.paytyp /= MISS) and ( a.paytyp /= 0 )) or include_missing ) then
         s := s & id_n & "paytyp (how often does member receive this salary) : " & Format( a.paytyp ) & LINE_BREAK;
      end if;
      if( ((a.trkind /= MISS) and ( a.trkind /= 0 )) or include_missing ) then
         s := s & id_n & "trkind (value of transport received in kind) : " & Format( a.trkind ) & LINE_BREAK;
      end if;
      if( ((a. foodk /= MISS) and ( a. foodk /= 0 )) or include_missing ) then
         s := s & id_n & " foodk (value of food received in kind) : " & Format( a. foodk ) & LINE_BREAK;
      end if;
      if( ((a.othkin /= MISS) and ( a.othkin /= 0 )) or include_missing ) then
         s := s & id_n & "othkin (value of other receipts in kind) : " & Format( a.othkin ) & LINE_BREAK;
      end if;
      if( ((a.deduct /= MISS) and ( a.deduct /= 0 )) or include_missing ) then
         s := s & id_n & "deduct (total value of deductions) : " & Format( a.deduct ) & LINE_BREAK;
      end if;
      if( ((a.dedtyp /= MISS) and ( a.dedtyp /= 0 )) or include_missing ) then
         s := s & id_n & "dedtyp (how often are deductions made) : " & Format( a.dedtyp ) & LINE_BREAK;
      end if;
      if( ((a.woradd /= MISS) and ( a.woradd /= 0 )) or include_missing ) then
         s := s & id_n & "woradd (aditional work done) : " & Format( a.woradd ) & LINE_BREAK;
      end if;
      if( ((a.ownocc /= MISS) and ( a.ownocc /= 0 )) or include_missing ) then
         s := s & id_n & "ownocc (occupation of own a/c worker) : " & Format( a.ownocc ) & LINE_BREAK;
      end if;
      if( ((a.ownind /= MISS) and ( a.ownind /= 0 )) or include_missing ) then
         s := s & id_n & "ownind (industry of own a/c worker) : " & Format( a.ownind ) & LINE_BREAK;
      end if;
      if( ((a.formal /= MISS) and ( a.formal /= 0 )) or include_missing ) then
         s := s & id_n & "formal (is member's job/business formaly registered) : " & Format( a.formal ) & LINE_BREAK;
      end if;
      if( ((a.vat /= MISS) and ( a.vat /= 0 )) or include_missing ) then
         s := s & id_n & "vat (payment of value added tax) : " & Format( a.vat ) & LINE_BREAK;
      end if;
      if( ((a.owny1 /= MISS) and ( a.owny1 /= 0 )) or include_missing ) then
         s := s & id_n & "owny1 (gross income of own a/c worker) : " & Format( a.owny1 ) & LINE_BREAK;
      end if;
      if( ((a.owny1c /= MISS) and ( a.owny1c /= 0 )) or include_missing ) then
         s := s & id_n & "owny1c (gross income code of own a/c worker) : " & Format( a.owny1c ) & LINE_BREAK;
      end if;
      if( ((a.ownifr /= MISS) and ( a.ownifr /= 0 )) or include_missing ) then
         s := s & id_n & "ownifr (frequency of receipt of own a/c income) : " & Format( a.ownifr ) & LINE_BREAK;
      end if;
      if( ((a.expens /= MISS) and ( a.expens /= 0 )) or include_missing ) then
         s := s & id_n & "expens (expenses incurred during the course of own business) : " & Format( a.expens ) & LINE_BREAK;
      end if;
      if( ((a.upaidw /= MISS) and ( a.upaidw /= 0 )) or include_missing ) then
         s := s & id_n & "upaidw (number of unpaid workers) : " & Format( a.upaidw ) & LINE_BREAK;
      end if;
      if( ((a.upu15 /= MISS) and ( a.upu15 /= 0 )) or include_missing ) then
         s := s & id_n & "upu15 (number of unpaid workers aged under 15 yrs) : " & Format( a.upu15 ) & LINE_BREAK;
      end if;
      if( ((a.paidw /= MISS) and ( a.paidw /= 0 )) or include_missing ) then
         s := s & id_n & "paidw (total number of paid workers) : " & Format( a.paidw ) & LINE_BREAK;
      end if;
      if( ((a.pwu15 /= MISS) and ( a.pwu15 /= 0 )) or include_missing ) then
         s := s & id_n & "pwu15 (paid workers aged under 15 yrs) : " & Format( a.pwu15 ) & LINE_BREAK;
      end if;
      if( ((a.salari /= MISS) and ( a.salari /= 0 )) or include_missing ) then
         s := s & id_n & "salari (total salaries/commision paid by own a/c worker) : " & Format( a.salari ) & LINE_BREAK;
      end if;
      if( ((a.famw1 /= MISS) and ( a.famw1 /= 0 )) or include_missing ) then
         s := s & id_n & "famw1 (number of unpaid family members) : " & Format( a.famw1 ) & LINE_BREAK;
      end if;
      if( ((a.famw2  /= MISS) and ( a.famw2  /= 0 )) or include_missing ) then
         s := s & id_n & "famw2  (number of paid family members) : " & Format( a.famw2  ) & LINE_BREAK;
      end if;
      if( ((a.wor7d /= MISS) and ( a.wor7d /= 0 )) or include_missing ) then
         s := s & id_n & "wor7d (For persons who did work in past year was it done in the last 7 days) : " & Format( a.wor7d ) & LINE_BREAK;
      end if;
      if( ((a.woratt  /= MISS) and ( a.woratt  /= 0 )) or include_missing ) then
         s := s & id_n & "woratt  (was member attached to some work/business/etc) : " & Format( a.woratt  ) & LINE_BREAK;
      end if;
      if( ((a.worrea /= MISS) and ( a.worrea /= 0 )) or include_missing ) then
         s := s & id_n & "worrea (reason for not working in past 7 days) : " & Format( a.worrea ) & LINE_BREAK;
      end if;
      if( ((a.joboff /= MISS) and ( a.joboff /= 0 )) or include_missing ) then
         s := s & id_n & "joboff (will member accept suitable joboffer) : " & Format( a.joboff ) & LINE_BREAK;
      end if;
      if( ((a.worloo /= MISS) and ( a.worloo /= 0 )) or include_missing ) then
         s := s & id_n & "worloo (peroid member has spent searching for work) : " & Format( a.worloo ) & LINE_BREAK;
      end if;
      if( ((a.look1 /= MISS) and ( a.look1 /= 0 )) or include_missing ) then
         s := s & id_n & "look1 (first option of method of job search by member) : " & Format( a.look1 ) & LINE_BREAK;
      end if;
      if( ((a.look2 /= MISS) and ( a.look2 /= 0 )) or include_missing ) then
         s := s & id_n & "look2 (2nd option of method of job searching by member) : " & Format( a.look2 ) & LINE_BREAK;
      end if;
      if( ((a.look3 /= MISS) and ( a.look3 /= 0 )) or include_missing ) then
         s := s & id_n & "look3 (3rd option of method of job searching by member) : " & Format( a.look3 ) & LINE_BREAK;
      end if;
      if( ((a.workb4 /= MISS) and ( a.workb4 /= 0 )) or include_missing ) then
         s := s & id_n & "workb4 (has member worked before) : " & Format( a.workb4 ) & LINE_BREAK;
      end if;
      if( ((a.worpre  /= MISS) and ( a.worpre  /= 0 )) or include_missing ) then
         s := s & id_n & "worpre  (previous occupation of member) : " & Format( a.worpre  ) & LINE_BREAK;
      end if;
      if( ((a.reasnw /= MISS) and ( a.reasnw /= 0 )) or include_missing ) then
         s := s & id_n & "reasnw (reason for not working in past 7 days) : " & Format( a.reasnw ) & LINE_BREAK;
      end if;
      if( ((a.maint1 /= MISS) and ( a.maint1 /= 0 )) or include_missing ) then
         s := s & id_n & "maint1 (first option of how member maintains himself) : " & Format( a.maint1 ) & LINE_BREAK;
      end if;
      if( ((a.maint2 /= MISS) and ( a.maint2 /= 0 )) or include_missing ) then
         s := s & id_n & "maint2 (second option of how member maintains himself) : " & Format( a.maint2 ) & LINE_BREAK;
      end if;
      if( ((a.maint3 /= MISS) and ( a.maint3 /= 0 )) or include_missing ) then
         s := s & id_n & "maint3 (third option of how member maintains himself) : " & Format( a.maint3 ) & LINE_BREAK;
      end if;
      if( ((a.educ /= MISS) and ( a.educ /= 0 )) or include_missing ) then
         s := s & id_n & "educ (highest level of education attained) : " & Format( a.educ ) & LINE_BREAK;
      end if;
      if( ((a.codwor /= MISS) and ( a.codwor /= 0 )) or include_missing ) then
         s := s & id_n & "codwor (new codes for workers) : " & Format( a.codwor ) & LINE_BREAK;
      end if;
      if( ((a.codexu  /= MISS) and ( a.codexu  /= 0 )) or include_missing ) then
         s := s & id_n & "codexu  (code of the expanded unemployed) : " & Format( a.codexu  ) & LINE_BREAK;
      end if;
      if( ((a.codune /= MISS) and ( a.codune /= 0 )) or include_missing ) then
         s := s & id_n & "codune (code of the strictly unemployed) : " & Format( a.codune ) & LINE_BREAK;
      end if;
      if( ((a.codnea  /= MISS) and ( a.codnea  /= 0 )) or include_missing ) then
         s := s & id_n & "codnea  (code of the not economically active) : " & Format( a.codnea  ) & LINE_BREAK;
      end if;
      if( ((a.codocc /= MISS) and ( a.codocc /= 0 )) or include_missing ) then
         s := s & id_n & "codocc (code of the main occupation groups) : " & Format( a.codocc ) & LINE_BREAK;
      end if;
      if( ((a.codind  /= MISS) and ( a.codind  /= 0 )) or include_missing ) then
         s := s & id_n & "codind  (code of the main industry groups) : " & Format( a.codind  ) & LINE_BREAK;
      end if;
      if( ((a.codtim /= MISS) and ( a.codtim /= 0 )) or include_missing ) then
         s := s & id_n & "codtim (code of the time to work) : " & Format( a.codtim ) & LINE_BREAK;
      end if;
      if( ((a.eminc /= MISS) and ( a.eminc /= 0 )) or include_missing ) then
         s := s & id_n & "eminc (income of employee per month) : " & Format( a.eminc ) & LINE_BREAK;
      end if;
      if( ((a.emincc /= MISS) and ( a.emincc /= 0 )) or include_missing ) then
         s := s & id_n & "emincc (income group code of employee) : " & Format( a.emincc ) & LINE_BREAK;
      end if;
      if( ((a.owny2 /= MISS) and ( a.owny2 /= 0 )) or include_missing ) then
         s := s & id_n & "owny2 (income of own a/c employer per month) : " & Format( a.owny2 ) & LINE_BREAK;
      end if;
      if( ((a.owny2c /= MISS) and ( a.owny2c /= 0 )) or include_missing ) then
         s := s & id_n & "owny2c (income group code of own a/c employer) : " & Format( a.owny2c ) & LINE_BREAK;
      end if;
      if( ((a.weight /= MISS) and ( a.weight /= 0 )) or include_missing ) then
         s := s & id_n & "weight (weighting number) : " & Format( a.weight ) & LINE_BREAK;
      end if;
      if( ((a.timlvh /= MISS) and ( a.timlvh /= 0 )) or include_missing ) then
         s := s & id_n & "timlvh (the hour person leaves home for work) : " & Format( a.timlvh ) & LINE_BREAK;
      end if;
      if( ((a.timlvm /= MISS) and ( a.timlvm /= 0 )) or include_missing ) then
         s := s & id_n & "timlvm (minute person leaves home for work) : " & Format( a.timlvm ) & LINE_BREAK;
      end if;
      if( ((a.timarh /= MISS) and ( a.timarh /= 0 )) or include_missing ) then
         s := s & id_n & "timarh (hour person arrives at work) : " & Format( a.timarh ) & LINE_BREAK;
      end if;
      if( ((a.timarm /= MISS) and ( a.timarm /= 0 )) or include_missing ) then
         s := s & id_n & "timarm (minute person arrives at work) : " & Format( a.timarm ) & LINE_BREAK;
      end if;
      if( ((a.iweigh /= MISS) and ( a.iweigh /= 0 )) or include_missing ) then
         s := s & id_n & "iweigh (raising weight) : " & Format( a.iweigh ) & LINE_BREAK;
      end if;
      if( ((a.timwor /= MISS) and ( a.timwor /= 0 )) or include_missing ) then
         s := s & id_n & "timwor (time it takes person to get to work- hrs & min) : " & Format( a.timwor ) & LINE_BREAK;
      end if;
      if( ((a.hour /= MISS) and ( a.hour /= 0 )) or include_missing ) then
         s := s & id_n & "hour (hour part of time it takes to get to work) : " & Format( a.hour ) & LINE_BREAK;
      end if;
      if( ((a.minute /= MISS) and ( a.minute /= 0 )) or include_missing ) then
         s := s & id_n & "minute (minute part of time it takes person to get to work) : " & Format( a.minute ) & LINE_BREAK;
      end if;
      if( ((a.wormin /= MISS) and ( a.wormin /= 0 )) or include_missing ) then
         s := s & id_n & "wormin (time in minutes it takes person to get to work) : " & Format( a.wormin ) & LINE_BREAK;
      end if;
      if( ((a.worker /= MISS) and ( a.worker /= 0 )) or include_missing ) then
         s := s & id_n & "worker (a working person) : " & Format( a.worker ) & LINE_BREAK;
      end if;
      if( ((a.unem /= MISS) and ( a.unem /= 0 )) or include_missing ) then
         s := s & id_n & "unem (strictly unemployed) : " & Format( a.unem ) & LINE_BREAK;
      end if;
      if( ((a.unemnl /= MISS) and ( a.unemnl /= 0 )) or include_missing ) then
         s := s & id_n & "unemnl (unemployed not looking) : " & Format( a.unemnl ) & LINE_BREAK;
      end if;
      if( ((a.exunem /= MISS) and ( a.exunem /= 0 )) or include_missing ) then
         s := s & id_n & "exunem (expanded unemployed) : " & Format( a.exunem ) & LINE_BREAK;
      end if;
      if( ((a.stude /= MISS) and ( a.stude /= 0 )) or include_missing ) then
         s := s & id_n & "stude (main activ. going to school) : " & Format( a.stude ) & LINE_BREAK;
      end if;
      if( ((a.dabled /= MISS) and ( a.dabled /= 0 )) or include_missing ) then
         s := s & id_n & "dabled (permanently unable to work) : " & Format( a.dabled ) & LINE_BREAK;
      end if;
      if( ((a.pens /= MISS) and ( a.pens /= 0 )) or include_missing ) then
         s := s & id_n & "pens (pensioner) : " & Format( a.pens ) & LINE_BREAK;
      end if;
      if( ((a.housk /= MISS) and ( a.housk /= 0 )) or include_missing ) then
         s := s & id_n & "housk (housekeeping incl caring for sick etc) : " & Format( a.housk ) & LINE_BREAK;
      end if;
      if( ((a.other /= MISS) and ( a.other /= 0 )) or include_missing ) then
         s := s & id_n & "other (other activity) : " & Format( a.other ) & LINE_BREAK;
      end if;
      if( ((a.selfem /= MISS) and ( a.selfem /= 0 )) or include_missing ) then
         s := s & id_n & "selfem (self employed person) : " & Format( a.selfem ) & LINE_BREAK;
      end if;
      if( ((a.nea /= MISS) and ( a.nea /= 0 )) or include_missing ) then
         s := s & id_n & "nea (not economically active) : " & Format( a.nea ) & LINE_BREAK;
      end if;
      if( ((a.eactiv /= MISS) and ( a.eactiv /= 0 )) or include_missing ) then
         s := s & id_n & "eactiv (the economically active) : " & Format( a.eactiv ) & LINE_BREAK;
      end if;
      if( ((a.workag /= MISS) and ( a.workag /= 0 )) or include_missing ) then
         s := s & id_n & "workag (working age) : " & Format( a.workag ) & LINE_BREAK;
      end if;
      if( ((a.lstat  /= MISS) and ( a.lstat  /= 0 )) or include_missing ) then
         s := s & id_n & "lstat  (labour market status of person) : " & Format( a.lstat  ) & LINE_BREAK;
      end if;
      if( ((a.undemp /= MISS) and ( a.undemp /= 0 )) or include_missing ) then
         s := s & id_n & "undemp (under employed persons) : " & Format( a.undemp ) & LINE_BREAK;
      end if;
      if( ((a.bothem /= MISS) and ( a.bothem /= 0 )) or include_missing ) then
         s := s & id_n & "bothem (working both for self and someone else) : " & Format( a.bothem ) & LINE_BREAK;
      end if;
      if( ((a.workyr /= MISS) and ( a.workyr /= 0 )) or include_missing ) then
         s := s & id_n & "workyr ( persons who worked in past 1 yr ) : " & Format( a.workyr ) & LINE_BREAK;
      end if;
      if( ((a.empyed /= MISS) and ( a.empyed /= 0 )) or include_missing ) then
         s := s & id_n & "empyed (Person working for someone else, whether it is a company or person) : " & Format( a.empyed ) & LINE_BREAK;
      end if;
      if( ((a.unionm /= MISS) and ( a.unionm /= 0 )) or include_missing ) then
         s := s & id_n & "unionm (person is a union member) : " & Format( a.unionm ) & LINE_BREAK;
      end if;

      s := s & LINE_BREAK;
      return To_String( s );
   end To_String;
   
   function To_String( a : Income_Array; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
   begin
      s := s & INDENT(num_indents) & " ========== Incomes ";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      s := s & "=======" & LINE_BREAK;
      for i in a'Range loop
         if( ((a(i) /= MISS_R) and (a(i) /= 0.0)) or include_missing ) then
            s := s & Indent( num_indents ) & Pretty_Print( i ) & ": " & Format( a(i)) & LINE_BREAK; 
         end if;
      end loop;
      return To_String( s );
   end To_String;


   function To_String( a : Expenditure_Array; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
   begin
      s := s & INDENT(num_indents) & " ========== Expenditures";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      
      s := s & "=======" & LINE_BREAK;
      for i in a'Range loop
         if( ((a(i) /= MISS_R) and ( a(i) /= 0.0 )) or include_missing ) then
            s := s & Indent( num_indents ) & Pretty_Print( i ) & ": " & Format( a(i)) & LINE_BREAK; 
         end if;
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( person : Person_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
   begin
      s := s & INDENT(num_indents) & " ========== Person";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      s := s & Indent( num_indents ) & "age: " & Format( person.age ) & LINE_BREAK;
      s := s & Indent( num_indents ) & "gender : " & Pretty_Print( person.gender ) & LINE_BREAK;
      
      s := s & To_String( person.demographics, num_indents, loop_count, include_missing );
      s := s & To_String( person.work, num_indents, loop_count, include_missing );
      s := s & To_String( person.incomes, num_indents, loop_count, include_missing );
      return To_String( s );
   end To_String;
   
   function To_String( family : Family_Unit; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
   begin
      s := s & INDENT(num_indents) & " ========== Family Unit";
      if( loop_count > 0 ) then
        s := s & "[ " & Format( loop_count ) & " ] ";
      end if;
      s := s & Indent( num_indents ) & "Num People " & Format( family.num_people ) & LINE_BREAK;
       
      for i in 1 .. family.num_people loop
         s := s & To_String( family.person(i), num_indents+1, i, include_missing );
      end loop;
      return To_String( s );
   end To_String;
   
   function To_String( household : Household_Rec; num_indents : Natural; include_missing : Boolean := False ) return String is
      s : Unbounded_String;
   begin
         s := s & Indent( num_indents ) & "Household Reference Number: " & Very_Large_Positive_Type'Image( household.reference_number ) & LINE_BREAK;
         s := s & Indent( num_indents ) & "Counter (from 1):" & Format( household.counter  ) & LINE_BREAK;
         s := s & Indent( num_indents ) & "Num Family Units: " & Format( household.num_families  ) & LINE_BREAK;
         s := s & To_String( household.housing, num_indents, 0, include_missing );
         s := s & To_String( household.expenditure, num_indents, 0, include_missing );
         for i in 1 .. household.num_families loop
            s := s & To_String( household.family( i ), num_indents + 1, i, include_missing );
         end loop;
         return To_String( s );
   end To_String;
   
end ZA.Household;
