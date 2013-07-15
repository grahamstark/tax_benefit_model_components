package body FRS_Enums.Templates is

   use type Templates_Parser.Vector_Tag;

    function get_acorn_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "No population data available";
       tag := tag & "Thriving-Wealthy suburbs, large detached houses";
       tag := tag & "Thriving-Villages with wealthy commuters";
       tag := tag & "Thriving-Mature affluent home owning areas";
       tag := tag & "Thriving-Affluent suburbs, older families";
       tag := tag & "Thriving-Mature, well-off suburbs";
       tag := tag & "Thriving-Agricultural villages, home-based workers";
       tag := tag & "Thriving-Hol retreats,oldr people, home based workers";
       tag := tag & "Thriving-Home owning areas, well-off older residents";
       tag := tag & "Thriving-Private flats, elderly people";
       tag := tag & "Expanding-Affluent working families with mortgages";
       tag := tag & "Expanding-Affluent wrkng cpls with mortgs,new homes";
       tag := tag & "Expanding-Transient wrkfrcs,livng at their place of wrk";
       tag := tag & "Expanding-Home owning family areas";
       tag := tag & "Expanding-Home owning family areas, older children";
       tag := tag & "Expanding-Families with mortgages, younger children";
       tag := tag & "Rising-Well off town and city areas";
       tag := tag & "Rising-Flats and mortgs, singles and young wrkng couples";
       tag := tag & "Rising-Furnshed flats and bedsits, ynger single people";
       tag := tag & "Rising-Aprtmnts, yng professional singles and couples";
       tag := tag & "Rising-Gentrified multi-ethnic areas";
       tag := tag & "Rising-Prosperous enclaves, highly qualified exectivs";
       tag := tag & "Rising-Academic cntrs, studnts and young professionals";
       tag := tag & "Rising-Affluent city centre areas, tenements and flats";
       tag := tag & "Rising-Partially gentrified multi-ethnic areas";
       tag := tag & "Rising-Converted flats and bedsits, single people";
       tag := tag & "Settling-Mature established home owning areas";
       tag := tag & "Settling-Rural areas, mixed occupations";
       tag := tag & "Settling-Established home owning areas";
       tag := tag & "Settling-Hme owng areas, council tenants, retired pple";
       tag := tag & "Settling-Estblshd home owning areas, skilled workers";
       tag := tag & "Settling-Home owners in oldr proprts, younger wrkrs";
       tag := tag & "Settling-Home owning areas with skilled workers";
       tag := tag & "Aspiring-Council areas, some new home owners";
       tag := tag & "Aspiring-Mature home owning areas, skilled workers";
       tag := tag & "Aspiring-Low rise estates,oldr wrkrs,new home ownrs";
       tag := tag & "Aspiring-Home ownng multi-ethnic areas,young famils";
       tag := tag & "Aspiring-Multi-occupied town cntrs, mixed occupations";
       tag := tag & "Aspiring-Multi-ethnic areas, white collar workers";
       tag := tag & "Striving-Home ownrs, small councl flats,singl pensnrs";
       tag := tag & "Striving-Council areas, older people, health problems";
       tag := tag & "Striving-Better-off council areas, new home owners";
       tag := tag & "Striving-Concil areas,yng famles,sme new hme oners";
       tag := tag & "Striving-Council areas, yng famls, many lone parents";
       tag := tag & "Striving-Multi-occupied terraces, multi-ethnic areas";
       tag := tag & "Striving-Low rise council housing, less well-off famls";
       tag := tag & "Striving-Council areas, residents with health problems";
       tag := tag & "Striving-Estates with high unemployment";
       tag := tag & "Striving-Council flats, elderly people, health problems";
       tag := tag & "Striving-Council flats, very high unemploymnt,singles";
       tag := tag & "Striving-Council areas,high unemploymnt, one parents";
       tag := tag & "Striving-Council flats,greatst hrdshp,many lone parnts";
       tag := tag & "Striving-Multi-ethnic, large families, overcrowding";
       tag := tag & "Striving-Multi-ethnic, severe unemplymnt,lone parents";
       tag := tag & "Striving-Multi-ethnic, high unemploymnt, overcrowding";
       tag := tag & "Area where code not yet assigned";
       return tag;
    end get_acorn_template;

    function get_adult_employment_status_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Self-Employed";
       tag := tag & "Full Time Employee";
       tag := tag & "Part Time Employee";
       tag := tag & "FT Employee temporarily Sick";
       tag := tag & "PT Employee temporarily Sick";
       tag := tag & "Industrial Action";
       tag := tag & "Unemployed";
       tag := tag & "Work related Govt training";
       tag := tag & "Retired";
       tag := tag & "Unoccupied under retirement age";
       tag := tag & "temporarily sick";
       tag := tag & "Long term sick";
       tag := tag & "Students in non advanced FE";
       tag := tag & "Unpaid Family Workers";
       return tag;
    end get_adult_employment_status_template;

    function get_age_group_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Age 16 to 24";
       tag := tag & "Age 25 to 34";
       tag := tag & "Age 35 to 44";
       tag := tag & "Age 45 to 54";
       tag := tag & "Age 55 to 59";
       tag := tag & "Age 60 to 64";
       tag := tag & "Age 65 to 74";
       tag := tag & "Age 75 to 84";
       tag := tag & "Age 85 or over";
       return tag;
    end get_age_group_template;

    function get_aggregated_ethnic_group_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "White";
       tag := tag & "Mixed";
       tag := tag & "Asian or Asian British";
       tag := tag & "Black or Black British";
       tag := tag & "Chinese or Other Ethnic group";
       return tag;
    end get_aggregated_ethnic_group_template;


    function get_benefit_types_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "DLA(self care)";
       tag := tag & "DLA(mobility)";
       tag := tag & "Child Benefit";
       tag := tag & "Pension credit";
       tag := tag & "Retirement Pension /OPP";
       tag := tag & "Widow's Pension/Bereavement Allowance";
       tag := tag & "Widowed Mothers/Widowed Parents Allowance";
       tag := tag & "War Disablement Pension";
       tag := tag & "War Widow's/Widower's Pension";
       tag := tag & "Severe Disability Allowance";
       tag := tag & "Disabled Person's Tax Credit";
       tag := tag & "Attendence Allowance";
       tag := tag & "Invalid Care Allowance";
       tag := tag & "Jobseeker's Allowance";
       tag := tag & "Industrial Injury Disablement Benefit";
       tag := tag & "Incapacity Benefit";
       tag := tag & "Working Families' Tax Credit";
       tag := tag & "Income Support";
       tag := tag & "New Deal";
       tag := tag & "Maternity Allowance";
       tag := tag & "Maternity Grant from Social Fund";
       tag := tag & "Funeral Grant from Social Fund";
       tag := tag & "Community Care grant from Social Fund";
       tag := tag & "Back to Work Bonus (received)";
       tag := tag & "Back to Work Bonus (accrued)";
       tag := tag & "Any other NI or State benefit";
       tag := tag & "Trade Union sick/strike pay";
       tag := tag & "Friendly Society Benefits";
       tag := tag & "Private sickness scheme benefits";
       tag := tag & "Accident insurance scheme benefits";
       tag := tag & "Hospital savings scheme benefits";
       tag := tag & "Government training allowances";
       tag := tag & "Guardians Allowance";
       tag := tag & "Social Fund Loan:Budgeting";
       tag := tag & "Social Fund Loan:Crisis";
       tag := tag & "Working Families' Tax Credit - Lump Sum";
       tag := tag & "Future: DLA Self Care";
       tag := tag & "Future: DLA Mobility";
       tag := tag & "Future: Attendance Allowance";
       tag := tag & "Disabled Person's Tax Credit - Lump Sum";
       tag := tag & "Child Maintenance Bonus";
       tag := tag & "Lone Parent Benefit run-on";
       tag := tag & "Widow's Payment";
       tag := tag & "Unemployment/Redundancy Insurance";
       tag := tag & "Winter Fuel Payments";
       tag := tag & "DWP direct payments - ISA";
       tag := tag & "DWP direct payments - JSA";
       tag := tag & "HB only or separately";
       tag := tag & "CTB only or separately";
       tag := tag & "HB/CTB paid together";
       tag := tag & "Permanent health insurance";
       tag := tag & "Any other sickness insurance";
       tag := tag & "Critical Illness Cover";
       tag := tag & "Working Tax Credit";
       tag := tag & "Child Tax Credit";
       tag := tag & "Working Tax Credit Lump Sum";
       tag := tag & "Child Tax Credit Lump Sum";
       return tag;
    end get_benefit_types_template;

    function get_benefit_unit_economic_status_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Self-employed";
       tag := tag & "1 or 2 adults in f/t employed work";
       tag := tag & "2 adults, one in f/t, other p/t";
       tag := tag & "2 adults, one f/t as employee, other not";
       tag := tag & "1 or 2 adults, at least 1 in p/t work";
       tag := tag & "1 or 2 adults, head or spouse aged 60+";
       tag := tag & "1 or 2 adults, hd or sp unemployed";
       tag := tag & "1 or 2 adults, hd or sp sick, < pen age";
       tag := tag & "Any other category";
       return tag;
    end get_benefit_unit_economic_status_template;

    function get_benefit_unit_type_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Any other category";
       tag := tag & "Pensioner couple";
       tag := tag & "Pensioner single";
       tag := tag & "Couple with children";
       tag := tag & "Couple without children";
       tag := tag & "Lone parent";
       tag := tag & "Single without children";
       return tag;
    end get_benefit_unit_type_template;

    function get_bu_disabled_indicator_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "1 Person in BU blind";
       tag := tag & "2 People in BU blind";
       tag := tag & "1 person in BU disabled";
       tag := tag & "2 People in BU disabled";
       tag := tag & "1 Person blind and 1 Person disabled";
       tag := tag & "No one blind or disabled";
       return tag;
    end get_bu_disabled_indicator_template;


    function get_employment_status_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Self-Employed";
       tag := tag & "Full Time Employee";
       tag := tag & "Part Time Employee";
       tag := tag & "FT Employee temporarily Sick";
       tag := tag & "PT Employee temporarily Sick";
       tag := tag & "Industrial Action";
       tag := tag & "Unemployed";
       tag := tag & "Work related Govt training";
       tag := tag & "Retired";
       tag := tag & "Unoccupied under retirement age";
       tag := tag & "temporarily sick";
       tag := tag & "Long term sick";
       tag := tag & "Students in non advanced FE";
       tag := tag & "Unpaid Family Workers";
       return tag;
    end get_employment_status_template;


    function get_ethnic_group_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "White - British";
       tag := tag & "Any other white background";
       tag := tag & "Mixed - White and Black Caribbean";
       tag := tag & "Mixed - White and Black African";
       tag := tag & "Mixed - White and Asian";
       tag := tag & "Any other mixed background";
       tag := tag & "Asian or Asian British - Indian";
       tag := tag & "Asian or Asian British - Pakistani";
       tag := tag & "Asian or Asian British - Bangladeshi";
       tag := tag & "Any other Asian/Asian British background";
       tag := tag & "Black or Black British - Caribbean";
       tag := tag & "Black or Black British - African";
       tag := tag & "Any other Black/Black British background";
       tag := tag & "Chinese";
       tag := tag & "Any other";
       return tag;
    end get_ethnic_group_template;

    function get_hbai_benefit_unit_type_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Any other category";
       tag := tag & "Pensioner couple";
       tag := tag & "Pensioner single";
       tag := tag & "Couple with children";
       tag := tag & "Couple without children";
       tag := tag & "Lone parent";
       tag := tag & "Single without children";
       return tag;
    end get_hbai_benefit_unit_type_template;


    function get_household_composition_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "One male adult, no children over pension age";
       tag := tag & "One female adult, no children over pension age";
       tag := tag & "One male adult, no children, under pension age";
       tag := tag & "One female adult, no children, under pension age";
       tag := tag & "Two adults, no children, both over pension age";
       tag := tag & "Two adults, no children, one over pension age";
       tag := tag & "Two adults, no children, both under pension age";
       tag := tag & "Three or more adults, no children";
       tag := tag & "One adult, one child";
       tag := tag & "One adult, two children";
       tag := tag & "One adult, three or more children";
       tag := tag & "Two adults, one child";
       tag := tag & "Two adults, two children";
       tag := tag & "Two adults, three or more children";
       tag := tag & "Three or more adults, one child";
       tag := tag & "Three or more adults, two children";
       tag := tag & "Three or more adults, three or more chidren";
       return tag;
    end get_household_composition_template;

    function get_household_income_band_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Under &#163;100 a week";
       tag := tag & "&#163;100 and less than &#163;200";
       tag := tag & "&#163;200 and less than &#163;300";
       tag := tag & "&#163;300 and less than &#163;400";
       tag := tag & "&#163;400 and less than &#163;500";
       tag := tag & "&#163;500 and less than &#163;600";
       tag := tag & "&#163;600 and less than &#163;700";
       tag := tag & "&#163;700 and less than &#163;800";
       tag := tag & "&#163;800 and less than &#163;900";
       tag := tag & "&#163;900 and less than &#163;1000";
       tag := tag & "Above &#163;1000";
       return tag;
    end get_household_income_band_template;

    function get_ilo_employment_status_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Full-time Employee";
       tag := tag & "Part-time Employee";
       tag := tag & "Full-time Self-Employed";
       tag := tag & "Part-time Self-Employed";
       tag := tag & "Unemployed";
       tag := tag & "Retired";
       tag := tag & "Student";
       tag := tag & "Looking after family/home";
       tag := tag & "Permanently sick/disabled";
       tag := tag & "Temporarily sick/injured";
       tag := tag & "Other Inactive";
       return tag;
    end get_ilo_employment_status_template;

    function get_marital_status_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Married";
       tag := tag & "Cohabiting";
       tag := tag & "Single";
       tag := tag & "Widowed";
       tag := tag & "Separated";
       tag := tag & "Divorced";
       return tag;
    end get_marital_status_template;

    function get_non_dependency_class_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Boarder";
       tag := tag & "Lodger";
       tag := tag & "Aged 18+ Working Full Time";
       tag := tag & "Aged 18+ on YTS/Jobskills";
       tag := tag & "Aged 18-24 on IS";
       tag := tag & "Aged 25+ on IS";
       tag := tag & "Student";
       tag := tag & "Others 18+";
       tag := tag & "Aged 16-17";
       return tag;
    end get_non_dependency_class_template;

    function get_old_region_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "North East";
       tag := tag & "North West";
       tag := tag & "Merseyside";
       tag := tag & "Yorks and Humberside";
       tag := tag & "East Midlands";
       tag := tag & "West Midlands";
       tag := tag & "Eastern";
       tag := tag & "London";
       tag := tag & "South East";
       tag := tag & "South West";
       tag := tag & "Wales";
       tag := tag & "Scotland";
       tag := tag & "Northern Ireland";
       return tag;
    end get_old_region_template;

    function get_pension_types_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Basic pension";
       tag := tag & "Basic increment";
       tag := tag & "Graduated pension";
       tag := tag & "Age Addition";
       tag := tag & "Increase of Pension for an Adult";
       tag := tag & "Increase of Pension for Children";
       tag := tag & "Invalidity addition";
       tag := tag & "Attendance allowance";
       tag := tag & "Additonl pension before contracted out dedct";
       tag := tag & "Contracted out deduction";
       tag := tag & "Add pension: after contracted out deduct";
       tag := tag & "Additional pension increments";
       tag := tag & "Upgrading of contracted out increments";
       tag := tag & "Care Component - High";
       tag := tag & "Care Component - Middle";
       tag := tag & "Care Component - Low";
       tag := tag & "Mobility Component - High";
       tag := tag & "Mobility Component - Low";
       tag := tag & "Pension Credit Guaranteed Element Amt";
       tag := tag & "Pension Credit Savings Element Amt";
       return tag;
    end get_pension_types_template;


    function get_regional_stratifier_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "North East Met";
       tag := tag & "North East Non Met";
       tag := tag & "North West Met";
       tag := tag & "North West Non Met";
       tag := tag & "Merseyside";
       tag := tag & "Yorks and Humberside Met";
       tag := tag & "Yorks and Humberside Non Met";
       tag := tag & "East Midlands";
       tag := tag & "West Midlands Met";
       tag := tag & "West Midlands Non Met";
       tag := tag & "Eastern Outer Metropolitan";
       tag := tag & "Eastern Other";
       tag := tag & "London - North East";
       tag := tag & "London - North West";
       tag := tag & "London - South East";
       tag := tag & "London - South West";
       tag := tag & "South East Outer Met";
       tag := tag & "South East Other";
       tag := tag & "South West";
       tag := tag & "Glamorgan, Gwent";
       tag := tag & "Clwyd, Gwynedd, Dyfed, Powys";
       tag := tag & "Highland Grampian, Tayside";
       tag := tag & "Fife, Central, Lothian";
       tag := tag & "Glasgow";
       tag := tag & "Strathclyde ex Glasgow";
       tag := tag & "Borders, Dumfries and Galloway";
       tag := tag & "North of the Caledonian Canal";
       tag := tag & "Northern Ireland";
       return tag;
    end get_regional_stratifier_template;

    function get_relationship_to_head_of_household_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Spouse";
       tag := tag & "Cohabitee";
       tag := tag & "Son/daughter (incl. adopted)";
       tag := tag & "Step-son/daughter";
       tag := tag & "Foster child";
       tag := tag & "Son-in-law/daughter-in-law";
       tag := tag & "Parent";
       tag := tag & "Step-parent";
       tag := tag & "Foster parent";
       tag := tag & "Parent-in-law";
       tag := tag & "Brother/sister (incl. adopted)";
       tag := tag & "Step-brother/sister";
       tag := tag & "Foster brother/sister";
       tag := tag & "Brother/sister-in-law";
       tag := tag & "Grand-child";
       tag := tag & "Grand-parent";
       tag := tag & "Other relative";
       tag := tag & "Other non-relative";
       return tag;
    end get_relationship_to_head_of_household_template;


    function get_standard_region_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "North East";
       tag := tag & "North West and Merseyside";
       tag := tag & "Yorks and Humberside";
       tag := tag & "East Midlands";
       tag := tag & "West Midlands";
       tag := tag & "Eastern";
       tag := tag & "London";
       tag := tag & "South East";
       tag := tag & "South West";
       tag := tag & "Wales";
       tag := tag & "Scotland";
       tag := tag & "Northern Ireland";
       return tag;
    end get_standard_region_template;

    function get_tenure_type_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Owns it outright";
       tag := tag & "Buying with the help of a mortgage";
       tag := tag & "Part own, part rent";
       tag := tag & "Rents";
       tag := tag & "Rent-free";
       tag := tag & "Squatting";
       return tag;
    end get_tenure_type_template;
    
    function get_gender_template return  Templates_Parser.Tag is
       tag : Templates_Parser.Tag;
    begin
       tag := tag & "Null or Missing";
       tag := tag & "Male";
       tag := tag & "Female";
       return tag;
    end get_gender_template;    

end FRS_Enums.Templates;
