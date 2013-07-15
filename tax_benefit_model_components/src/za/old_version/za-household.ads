with ZA_Enums;
with Base_Model_Types;
with Ada.Text_IO;


package ZA.Household is

   use ZA_Enums;
   
   subtype Person_Count is Positive range 1 .. 8;
   subtype Family_Unit_Count is Positive range 1 .. 60;
   subtype Age_Range is Natural range 0 .. 150;
   subtype Child_Age_Range is Age_Range range 0 .. 16; -- CHECK
   
   subtype Income_Array is Income_Package.Amount_Array;
   subtype Expenditure_Array is Expenditure_Type_Package.Amount_Array;
   
   function  To_String( a : Income_Array; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;
   function  To_String( a : Expenditure_Array; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;
 
   type Housing_Rec is record
      settl          : Integer       := MISS;              --  Settlement Type (11-14=urban areas, 21-24=semi-urban areas, 31-38=rural 
      ownship        : Ownship_Type  := missing;  --  ownership of site and dwelling (1=site & dwelling fully paid off, 2=site)
      matroof        : Matroof_Type  := missing;  --  main type of material used for roofing (2=cocrete, 3=prefab, 4=zink, 5=wood)
      matwall        : Matwall_Type  := missing;  --  main type of material used for the walls (1=bricks, 2=concrete, 3=prefab)
      dwevalue       : Integer       := MISS;              --  value of dwelling unit
      livingr        : Integer       := MISS;              --  number of living roons incl. Kitchen
      bedroom        : Integer       := MISS;              --  number of bedrooms
      wattank        : Boolean       := False;  --  does hh have a rain water tank? (1=yes, 2=no)
      watsourc       : Watsourc_Type := missing;  --  main source of drinking water (1=running tap in dwe, 2=running tap on site) 
      watmain        : Watmain_Type  := missing;  --  main source of other water  (1=running tap in dwe, 2=running tap on site)
      watadeq        : Watadeq_Type  := missing;  --  is water adequate? (1=always adequate, 2=mostly yes, 3=mostly not, 4=no)
      watkm          : Watkm_Type    := missing;  --  distance to main source of water (1=<100m, 2=100-200m, 3=200-500m)
      watpay         : Yes_No_Sometimes_Type:= missing;  --  does hh pay for its water? (1=yes, 2=no, 3=sometimes)
      elpubc         : Yes_No_Sometimes_Type:= missing;  --  does hh get its  cooking electricityfrom a public source?
      elgenc         : Yes_No_Sometimes_Type:= missing;  --  does hh get its cooking elctricity from a generator?
      elsolac        : Yes_No_Sometimes_Type:= missing;  --  does hh get its cooking elctricity from solar?
      cookgas        : Yes_No_Sometimes_Type:= missing;  --  does hh use gas for cooking?
      cookpar        : Yes_No_Sometimes_Type:= missing;  --  does hh use paraffin for cooking?
      cookwood       : Yes_No_Sometimes_Type:= missing;  --  does hh use wood for cooking?
      cookcoal       : Yes_No_Sometimes_Type:= missing;  --  does hh use coal for cooking?
      coocharc       : Yes_No_Sometimes_Type:= missing;  --  does hh use charcoal for cooking?
      cropwast       : Yes_No_Sometimes_Type:= missing;  --  does hh use crop waste as cooking energy source?
      cookdung       : Yes_No_Sometimes_Type:= missing;  --  does hh use animal dung as energy source for cooking?
      cookoth        : Yes_No_Sometimes_Type:= missing;  --  Other sources of energy for cooking
      heatelp        : Yes_No_Sometimes_Type:= missing;  --  heating electricity from a public source
      heatelg        : Yes_No_Sometimes_Type:= missing;  --  heating electricity from a public source
      heatelb        : Yes_No_Sometimes_Type:= missing;  --  heating electricity from a battery
      heatels        : Yes_No_Sometimes_Type:= missing;  --  heating electricity from a solar
      heatgas        : Yes_No_Sometimes_Type:= missing;  --  heating gas
      heatpar        : Yes_No_Sometimes_Type:= missing;  --  heating paraffin
      heatwood       : Yes_No_Sometimes_Type:= missing;  --  heating wood
      heatcoal       : Yes_No_Sometimes_Type:= missing;  --  coal for heating
      heatchar       : Yes_No_Sometimes_Type:= missing;  --  charcoal for heating
      heatcrop       : Yes_No_Sometimes_Type:= missing;  --  cropwaste for heating
      heatdung       : Yes_No_Sometimes_Type:= missing;  --  animal dung for heating
      heatoth        : Yes_No_Sometimes_Type:= missing;  --  other heating sources
      noheat         : Yes_No_Sometimes_Type:= missing;  --  no heating source for the hh
      lightelp       : Yes_No_Sometimes_Type:= missing;  --  public source electricity for
      lightelg       : Yes_No_Sometimes_Type:= missing;  --  generator electricity for lighting
      lightelb       : Yes_No_Sometimes_Type:= missing;  --  battery source of electricity for lighting
      lightels       : Yes_No_Sometimes_Type:= missing;  --  solar electricity for lighting
      lightgas       : Yes_No_Sometimes_Type:= missing;  --  use of gas for lighting
      lightpar       : Yes_No_Sometimes_Type:= missing;  --  use of paraffin for lighting
      lightcan       : Yes_No_Sometimes_Type:= missing;  --  use of candles for lighting
      lightoth       : Yes_No_Sometimes_Type:= missing;  --  use of other sources of lighting
      fwoods         : Fwoods_Type   := missing;  --  source of firewood (1=woodlot, 2=commercial plantations, 3=indegenous)
      fwoodad        : Fwoodad_Type  := missing;  --  firewood adequacy (1=always, 2=mostly yes, 3=mostly no, 4=no)
      fwoodkm        : Fwoodkm_Type  := missing;  --  distance to firewood source (1=<100m, 2=100-200m, 3=200-1km, 4=>1km)
      fwoopay        : Boolean       := False;  --  does hh pay for its firewood? (1=always, 2=sometimes, 3=not at all)
      sanitin        : Integer       := MISS;              --  sanitation in the house
      saniton        : Integer       := MISS;              --  sanitation is on the site
      sanitoff       : Integer       := MISS;              --  sanitation is off site
      sanitsh        : Boolean       := False;  --  sharing of sanitation (1=yes, 2=no)
      sanitno        : Integer       := MISS;              --  number of hhs sharing the sanitation
      toilkm         : Toilkm_Type   := missing;  --  distance to the nearest toilet (1=<25m, 2=25-50m, 3=51-100m, 4=>100m)
      toilbuck       : Integer       := MISS;              --  frequency of removing bucket toilet 
      refdisp        : Refdisp_Type  := missing;  --  method of disposing of refuse (1=removed by local authority, 2=communal)
      reffreq        : Reffreq_Type  := missing;  --  frequency of refuse collection (1=1 week, 2=fortnight, 3=month) 
      telcell        : Integer       := MISS;              --  ownership of a cell phone
      teloth         : Integer       := MISS;              --  ownership and use of other telephone types
      telkm          : Telkm_Type    := missing;  --  distance to the nearest telephone (1=<100m, 2=100-200m, 3=200-1km, 4=1-km)
      landacc        : Boolean       := False;  --  access to land for farming (1=yes, 2=no)
      landha         : Integer       := MISS;              --  size of land in hectares
      landdry        : Integer       := MISS;              --  size of dryland for cultivation
      landirr        : Integer       := MISS;              --  size of irrigated land
      landirs        : Landirs_Type  := missing;  --  source of irrigation water (1=river, 2=spring, 3=dam/on land, 4=other dam)
      landgr         : Boolean       := False;  --  availability of grazing land (1=yes, 2=no)
      landcomh       : Integer       := MISS;              --  communal land for cultivation
      landcdry       : Integer       := MISS;              --  size of dry communal land
      landcirr       : Integer       := MISS;              --  size of irrigated communal land
      landiha        : Integer       := MISS;              --  size of communal irrigated land
      landctr        : Integer       := MISS;              --  tribal communal land
      tribocch       : Boolean       := False;  --  occupancy of land alocated by a tribal authority (1=yes, 2=no)
      tribdry        : Integer       := MISS;              --  dry tribal land
      tribirr        : Integer       := MISS;              --  size of irrigated tribal land
      tribirs        : Integer       := MISS;              --  source of irrigation for tribal land
      tribcom        : Integer       := MISS;              --  communally used tribal land
      tribcdry       : Integer       := MISS;              --  size of dry-communally used tribal land
      tribcir        : Integer       := MISS;              --  size of irrigated-communally used tribal land
      tribcirs       : Integer       := MISS;              --  source of irrigated-communally used tribal land
      truha          : Integer       := MISS;              --  size of trust land allocated by government
      trudry         : Integer       := MISS;              --  size of dry trust land
      truirr         : Integer       := MISS;              --  size of irrigated trust land
      trus           : Trus_Type     := missing;  --  source of irrigation water for trust land(1=river, 2=spring, 3=dam/on land, 4=other dam)
      trugr          : Boolean       := False;  --  availability of trust land for grazing (1=yes, 2=no)
      tenha          : Integer       := MISS;              --  size of land occupied by tenants
      tendry         : Integer       := MISS;              --  size of dry land occupied by tenants
      tenirr         : Integer       := MISS;              --  size of irrigated tenant land
      tenirs         : Integer       := MISS;              --  source of water for irrigating tenant land
      tengr          : Integer       := MISS;              --  availability of grazing land
      safeout        : Safeout_Type  := missing;  --  safety conditions outside dwelling (1=very safe, 2=rather safe, 3=rather )
      safein         : Safein_Type   := missing;  --  safety conditions inside dwelling (1=very safe, 2=rather safe, 3=rather )
      safeprev       : Safeprev_Type := missing;  --  comparison of safety with previous year (1=safer, 2=same, 3=less safe)
      crimevic       : Boolean       := False;  --  has been victim of crime (1=yes, 2=no)
      crime1         : Crime_Type   := missing;  --  First victim (1=assault, 2=robbery, 3=rape, 4=murder, 5=abduction, 6=other)
      crime2         : Crime_Type   := missing;  --  Second victim (1=assault, 2=robbery, 3=rape, 4=murder, 5=abduction, 6=other)
      crime3         : Crime_Type   := missing;  --  Third victim (1=assault, 2=robbery, 3=rape, 4=murder, 5=abduction, 6=other)
      crime4         : Crime_Type   := missing;  --  Fourth victim (1=assault, 2=robbery, 3=rape, 4=murder, 5=abduction, 6=other)
      crime5         : Crime_Type   := missing;  --  Fifth victim (1=assault, 2=robbery, 3=rape, 4=murder, 5=abduction, 6=other)
      crime6         : Crime_Type   := missing;  --  Sixth victim (1=assault, 2=robbery, 3=rape, 4=murder, 5=abduction, 6=other)
      pollute        : Pollute_Type  := missing;  --  Difficulty in breathing due to pollution (1=very difficult, 2=difficult, 3=slightly )
      feedab         : Feedab_Type   := missing;  --  ability to feed children (1=yes, 2=no, 3=not applicable)
      satisf         : Satisf_Type   := missing;  --  satisfied with living conditions (1=very satisfied, 2=satisfied, 3=neither )
      compliv        : Compliv_Type  := missing;  --  comparison of living conditions with the previous (1=things are better, 2=worse, 3=neither)
      reshead        : Boolean       := False;  --  does head of hh reside at hh at least 4 nights a week (1=yes, 2=no)
      reashead       : Reashead_Type := missing;  --  reason for head of hh not residing at hh (1=employment, 2=business )
      misschn        : Boolean       := False;  --  Are there any children of the hh who are missing or street kids (1=yes, 2=no)
      misschno       : Integer       := MISS;              --  number of missing children
      medsour        : Medsour_Type  := missing;  --  source of medical services (1=public hospital, 2=public clinic, 3=other public )
      medkm          : Medkm_Type    := missing;  --  distance to nearest medical service centre (1=<1km, 2=1-5km, 3=>5km)
      medtime        : Medtime_Type  := missing;  --  time to the medical service (1=1/4 hour, 2=1/2 hour, 3=1 hour, 4=>1 hour)
      meddi          : Integer       := MISS;              --  district where the medical service was obtained
      medpr          : Province_Type := missing;  --  province where medical service was obtained
      hospdi         : Integer       := MISS;              --  district where public hospital is located
      hosppr         : Province_Type := missing;  --  province where public hospital is located
      welfkm         : Welfkm_Type   := missing;  --  distance to the nearest welfare centre (1=<1km, 2=1-5km, 3=>5km, 4=don't )
   end record;


   function To_String( a : Housing_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;
   
  type Demographics_Rec is record
      hhid           : Integer       := MISS;              --  Household Identification Number
      pid            : Integer       := MISS;              --  Person Identification Number
      age            : Integer       := MISS;              --  Age in years
      relate         : Relate_Type   := missing;  --  Relationship of member to hh head (1=head of hh, 2=spouse, 3=son/daughter)
      spcod          : Integer       := MISS;              --  member's spouse' code if spouse is member of hh
      fatcod         : Integer       := MISS;              --  member's father's PID if father is member of hh
      motcod         : Integer       := MISS;              --  member's mother's PID if mother is member of hh
      mstate         : Mstate_Type   := missing;  --  Marital status (1=never married, 2=civil married, 3=traditional married)
      gender         : Gender_Type   := missing;  --  Gender of member(1=male, 2=female)
      prov           : Province_Type := missing;  --  Province where hh is located
      district       : Integer       := MISS;              --  District where hh is located
      ea             : Integer       := MISS;              --  Enumeration area where hh is located
      branchea       : Integer       := MISS;              --  Equivalent to EA
      dwe            : Dwe_Type      := missing;  --  Type of dwelling unit hh lives in(1=formal, 2=traditional, 3=flat, 4=townhouse)
      loc            : Loc_Type      := missing;  --  Location of household (1=urban, 2=rural)
      visit          : Integer       := MISS;              --  Visiting Point Number
      hhsize         : Integer       := MISS;              --  Household size
      race           : Race_Type     := missing;  --  Race of member (1=African, 2=Coloured, 3=Indian, 4=White)
      fataliv        : Boolean       := False;  --  Whether member's father is alive (1=yes, 2=no)
      motaliv        : Boolean       := False;  --  Whether member's mother is alive (1=yes, 2=no)
      membpr         : Boolean       := False;  --  whether member was present during interview(1=yes, 2=no)
      birth          : Integer       := MISS;              --  Year member was born
      wobirt         : Integer       := MISS;              --  Number of Women who ever gave birth
      childr         : Integer       := MISS;              --  Ideal number of children member would prefer
      bornpr         : Province_Type := missing;  --  Province where member was born (see province codes below)
      borndi         : Integer       := MISS;              --  District where member was born (see district codes)
      bornco         : Integer       := MISS;              --  Country where member was born (see country codes)
      migr           : Integer       := MISS;              --  Whether memmber has migrated into present area of residence since 
      migrpr         : Province_Type := missing;  --  Province from which member migrated if member did migrate
      migrdi         : Integer       := MISS;              --  District from which member migrated if member did migrate
      migrco         : Integer       := MISS;              --  Country from which member migrated if member did migrate
      predw          : Predw_Type    := missing;  --  Previous type of dwelling unit (1=formal, 2=backyard, 3=squatter, 4=hostel)
      creche         : Boolean       := False;  --  Whether children (below 6 years) are attending creche(1=yes, 2=no)
      study          : Boolean       := False;  --  whether member is studying(1=yes f/t, 2=yes p/t, 3=no)
      liter          : Boolean       := False;  --  Whether member underwent adult litearcy programme(1=yes, 2=no)
      skill          : Boolean       := False;  --  Whether member has acquired any artisan or operator skill (1=yes, 2=no)
      sktyp          : Integer       := MISS;              --  Type of skill member posseses (see occupation codes)
      migwor         : Boolean       := False;  --  whether member is a migrant worker (1=yes, 2=no)
      feedsch        : Boolean       := False;  --  Whether children take part in feeding scheme at school(1=yes, 2=no)
      educ           : Integer       := MISS;              --  Highest level of education attained (no. of years spent in school and
      edcont         : Boolean       := False;  --  Whether member would have wanted to continue with schooling(1=yes, 2=no)
      edreas         : Edreas_Type   := missing;  --  Reason for not continuing with schooling(1=no money, 2=distance), 
      edfees         : Integer       := MISS;              --  Tuition fees paid related to learning 
      edtra          : Integer       := MISS;              --  Transport cost to school
      edoth          : Integer       := MISS;              --  Other expenses related to education [boarding, textbooks, uniforms]
      ill            : Boolean       := False;  --  Whether member fell ill during the last month (1=yes, 2=no)
      injury         : Boolean       := False;  --  Whether member got injured during last month (1=yes, 2=no)
      discha         : Boolean       := False;  --  Whether member was discharged from hospital in last month (1=yes, 2=no)
      consn          : Boolean       := False;  --  whether member consulted a nurse
      conssp         : Boolean       := False;  --  whether member consulted a medical specialise
      consdo         : Boolean       := False;  --  whether member consulted a doctor
      consde         : Boolean       := False;  --  whether member consulted a dentist
      consph         : Boolean       := False;  --  whether member consulted a pharmacist
      consot         : Boolean       := False;  --  whether member consulted an occupational therapist
      consfh         : Boolean       := False;  --  whether member consulted a faith healer
      constr         : Boolean       := False;  --  whether member consulted a traditional healer
      conspla        : Conspla_Type  := missing;  --  Place where consultation took place(1=public hospital, 2=public clinic)
      conspay        : Boolean       := False;  --  Whether member paid for the consultation (1=yes, 2=no)
      medaid         : Boolean       := False;  --  Whether member has access to medical aid (1=yes, 2=no)
      smoke          : Boolean       := False;  --  Whether member smokes or not (1=yes, 2=no)
      smokag         : Integer       := MISS;              --  Age at which member started smoking 
      disab1         : Disab1_Type   := missing;  --  First type of disability that person has(1=none, 2=sight, 3=hearing, 4=physical, 5=mental) 
      disab2         : Integer       := MISS;              --  Person with sight defect
      disab3         : Integer       := MISS;              --  Person with hearing/speech defect
      welf           : Boolean       := False;  --  Whether person used welfare services(1=yes, 2=no)
      welfa          : Integer       := MISS;              --  first type of welfare service used
      welfb          : Integer       := MISS;              --  second type of welfare service used
      welfc          : Integer       := MISS;              --  third type of welfare service used
      weight         : Integer       := MISS;              --  Not to be used
      iweigh         : Integer       := MISS;              --  Individual weight (weight/1000)
      sch1           : Integer       := MISS;              --  No. of women who ever gave birth in the hh
      sch2           : Boolean       := False;  --  person has primary education (1=yes, 0=no)
      sch3           : Boolean       := False;  --  Person has secondary education (1=yes, 0=no)
      sch4           : Boolean       := False;  --  Person has matric (1=yes, 0=no)
      sch5           : Boolean       := False;  --  Person has no matric but Diploma (1=yes, 0=no)
      sch6           : Boolean       := False;  --  Person has University degree (1=yes, 0=no)
      edcat          : Edcat_Type    := missing;  --  Education categories(0=no school, 1=prima, 2=sec, 3=matric, 4=no matr+dip, 5=mat+d, 6=univ)
      ed1            : Integer       := MISS;              --  Education Spline - 7 years of schooling
      ed2            : Integer       := MISS;              --  Education Spline- 7-12 years of schooling
      ed3            : Integer       := MISS;              --  Education Spline - 12-14 years of schooling
      ed4            : Integer       := MISS;              --  Education spline - 14 or more years of schooling
      stude          : Boolean       := False;  --  Member is a student (1=yes, 0=no)
      studft         : Boolean       := False;  --  Member is a full time student (1=yes, 0=no)
      studpt         : Boolean       := False;  --  Member is a part time student (1=yes, 0=no)
      maried         : Boolean       := False;  --  whether member is married or not(1=yes, 2=no)
   end record;


   function To_String( a : Demographics_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;
   

   type Work_Rec is record
      activ          : Integer       := MISS;              --  main activity in last 7 days
      work           : Integer       := MISS;              --  if not wking did you do any work in past yr
      worlag         : Integer       := MISS;              --  how long member last worked
      worhrs         : Integer       := MISS;              --  hours worked in last 7 days
      wormor         : Integer       := MISS;              --  would have liked more hrs
      morehrs        : Integer       := MISS;              --  total hrs member would have liked
      trans1         : Integer       := MISS;              --  1st option of mode of transport to work used
      trans2         : Integer       := MISS;              --  second option of mode of transport to work used
      trans3         : Integer       := MISS;              --  3rd option of mode of transport to work used
       timelv        : Integer       := MISS;              --  time member leaves home for work
      timear         : Integer       := MISS;              --  time member arrives at work
      workdi         : Integer       := MISS;              --  district where member works
      workpr         : Province_Type := missing;  --  province where member works
      wstat          : Integer       := MISS;              --  member's work status eg self employed
      wostar         : Integer       := MISS;              --  year and month member started working for present employer
      union          : Integer       := MISS;              --  membership of trade union
      matern         : Integer       := MISS;              --  martenity condition at work
      occup          : Integer       := MISS;              --  member's occupation
      indust         : Integer       := MISS;              --  member's industry
      salary         : Integer       := MISS;              --  salary from main job
      salgp          : Integer       := MISS;              --  income group of member
      paytyp         : Integer       := MISS;              --  how often does member receive this salary
      trkind         : Integer       := MISS;              --  value of transport received in kind
       foodk         : Integer       := MISS;              --  value of food received in kind
      othkin         : Integer       := MISS;              --  value of other receipts in kind
      deduct         : Integer       := MISS;              --  total value of deductions
      dedtyp         : Integer       := MISS;              --  how often are deductions made
      woradd         : Integer       := MISS;              --  aditional work done
      ownocc         : Integer       := MISS;              --  occupation of own a/c worker
      ownind         : Integer       := MISS;              --  industry of own a/c worker
      formal         : Integer       := MISS;              --  is member's job/business formaly registered
      vat            : Integer       := MISS;              --  payment of value added tax
      owny1          : Integer       := MISS;              --  gross income of own a/c worker
      owny1c         : Integer       := MISS;              --  gross income code of own a/c worker
      ownifr         : Integer       := MISS;              --  frequency of receipt of own a/c income
      expens         : Integer       := MISS;              --  expenses incurred during the course of own business
      upaidw         : Integer       := MISS;              --  number of unpaid workers
      upu15          : Integer       := MISS;              --  number of unpaid workers aged under 15 yrs
      paidw          : Integer       := MISS;              --  total number of paid workers
      pwu15          : Integer       := MISS;              --  paid workers aged under 15 yrs
      salari         : Integer       := MISS;              --  total salaries/commision paid by own a/c worker
      famw1          : Integer       := MISS;              --  number of unpaid family members
      famw2          : Integer       := MISS;              --  number of paid family members
      wor7d          : Integer       := MISS;              --  For persons who did work in past year was it done in the last 7 days
      woratt         : Integer       := MISS;              --  was member attached to some work/business/etc
      worrea         : Integer       := MISS;              --  reason for not working in past 7 days
      joboff         : Integer       := MISS;              --  will member accept suitable joboffer
      worloo         : Integer       := MISS;              --  peroid member has spent searching for work
      look1          : Integer       := MISS;              --  first option of method of job search by member
      look2          : Integer       := MISS;              --  2nd option of method of job searching by member
      look3          : Integer       := MISS;              --  3rd option of method of job searching by member
      workb4         : Integer       := MISS;              --  has member worked before
      worpre         : Integer       := MISS;              --  previous occupation of member
      reasnw         : Integer       := MISS;              --  reason for not working in past 7 days
      maint1         : Integer       := MISS;              --  first option of how member maintains himself
      maint2         : Integer       := MISS;              --  second option of how member maintains himself
      maint3         : Integer       := MISS;              --  third option of how member maintains himself
      educ           : Integer       := MISS;              --  highest level of education attained
      codwor         : Integer       := MISS;              --  new codes for workers
      codexu         : Integer       := MISS;              --  code of the expanded unemployed
      codune         : Integer       := MISS;              --  code of the strictly unemployed
      codnea         : Integer       := MISS;              --  code of the not economically active
      codocc         : Integer       := MISS;              --  code of the main occupation groups
      codind         : Integer       := MISS;              --  code of the main industry groups
      codtim         : Integer       := MISS;              --  code of the time to work
      eminc          : Integer       := MISS;              --  income of employee per month
      emincc         : Integer       := MISS;              --  income group code of employee
      owny2          : Integer       := MISS;              --  income of own a/c employer per month
      owny2c         : Integer       := MISS;              --  income group code of own a/c employer
      weight         : Integer       := MISS;              --  weighting number
      timlvh         : Integer       := MISS;              --  the hour person leaves home for work
      timlvm         : Integer       := MISS;              --  minute person leaves home for work
      timarh         : Integer       := MISS;              --  hour person arrives at work
      timarm         : Integer       := MISS;              --  minute person arrives at work
      iweigh         : Integer       := MISS;              --  raising weight
      timwor         : Integer       := MISS;              --  time it takes person to get to work- hrs & min
      hour           : Integer       := MISS;              --  hour part of time it takes to get to work
      minute         : Integer       := MISS;              --  minute part of time it takes person to get to work
      wormin         : Integer       := MISS;              --  time in minutes it takes person to get to work
      worker         : Integer       := MISS;              --  a working person
      unem           : Integer       := MISS;              --  strictly unemployed
      unemnl         : Integer       := MISS;              --  unemployed not looking
      exunem         : Integer       := MISS;              --  expanded unemployed
      stude          : Integer       := MISS;              --  main activ. going to school
      dabled         : Integer       := MISS;              --  permanently unable to work
      pens           : Integer       := MISS;              --  pensioner
      housk          : Integer       := MISS;              --  housekeeping incl caring for sick etc
      other          : Integer       := MISS;              --  other activity
      selfem         : Integer       := MISS;              --  self employed person
      nea            : Integer       := MISS;              --  not economically active
      eactiv         : Integer       := MISS;              --  the economically active
      workag         : Integer       := MISS;              --  working age
      lstat          : Integer       := MISS;              --  labour market status of person
      undemp         : Integer       := MISS;              --  under employed persons
      bothem         : Integer       := MISS;              --  working both for self and someone else
      workyr         : Integer       := MISS;              --   persons who worked in past 1 yr (Q3.25)
      empyed         : Integer       := MISS;              --  Person working for someone else, whether it is a company or person
      unionm         : Integer       := MISS;              --  person is a union member
   end record;

   function To_String( a : Work_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;
   
   type Person_Rec is record
      age          : Age_Range := Age_Range'First;  -- dup of record in personal 
      gender       : Gender_Type := missing; -- dup of record in personal
      work         : Work_Rec;
      incomes      : Income_Array;
      demographics : Demographics_Rec;
   end record;  -- ??? Smaller child record ??

   function To_String( person : Person_Rec; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;

   type Person_Array is array( Person_Count ) of Person_Rec;
   
   type Family_Unit is record
      family_unit_number : Positive := 1;
      num_people : Person_Count := Person_Count'First;
      person     : Person_Array;
   end record;
   
   function To_String( family : Family_Unit; num_indents : Natural; loop_count : Natural := 0; include_missing : Boolean := False ) return String;
   
   type Family_Unit_Array is array( Family_Unit_Count ) of Family_Unit;
  
   type Household_Rec is record
      reference_number : Very_Large_Positive_Type := 1;
      counter      : Positive := 1;
      expenditure  : Expenditure_Array;
      housing      : Housing_Rec;
      num_families : Family_Unit_Count := Family_Unit_Count'First;
      family       : Family_Unit_Array;
   end record;
   
   function To_String( household : Household_Rec; num_indents : Natural; include_missing : Boolean := False ) return String;
  
end ZA.Household;
