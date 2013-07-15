--
--  $Revision: 5479 $
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  basic equivalence scale constants
--  see: www.dwp.gov.uk/asd/hbai/hbai2002/pdfs/Appx5.pdf
--
--  Modified 26/6/06. A McLements Scale sufficient to implement the scale in
--  the CDS 2006 Bill (with no non-spouse adult allowances).
--  The other scales are kept around only so as not to break existing code.
--
pragma License( Modified_GPL );

with Model.Household;


package Model.Equivalence_Scales is


        MAX_NUM_AGE_RANGES : constant := 8;

        subtype Num_Age_Ranges is Integer range 1 .. MAX_NUM_AGE_RANGES;

        type Child_Age_Limits is array ( Num_Age_Ranges ) of Model.Household.Child_Age;

        type Child_Age_Amounts is array ( Num_Age_Ranges ) of Rate;
        --
        --  this converts just enough of a McLements scale to handle the system used in English Criminal Legal Aid
        --
        type Basic_McLements_Scale_Rec is record
                adult,
                spouse : Rate;
                num_Child_Ranges : Num_Age_Ranges;
                child_Age_Limit  : Child_Age_Limits;
                child_Age_Amount : Child_Age_Amounts;
        end record;

        DEFAULT_MCLEMENTS_SCALE : constant Basic_McLements_Scale_Rec :=
          (
           adult => 0.61,
           spouse => 0.39,
           num_Child_Ranges => 7,
           child_Age_Limit => ( 1, 4, 7, 10, 12, 15, 21, others=>0 ), --  FIXME: top age set too high? Should be 18??
           child_Age_Amount => ( 0.09, 0.18, 0.21, 0.23, 0.25, 0.27, 0.36, others=>0.0 )
          );

        --
        --  McLements scale for a benfit using, ignoring any non-spouse adults
        --
        function Calculate_McLements_Scale ( bu : Model.Household.Model_Benefit_Unit;
                                            scale : Basic_McLements_Scale_Rec := DEFAULT_MCLEMENTS_SCALE ) return Rate;

        --
        --  the Nunber of 0-2 year olds, 8-9 year olds and so on.
        --
        function num_Children_In_Age_Ranges (
                                             children     : Model.Household.Child_Array;
                                             num_children : Model.Household.Child_Range;
                                             upper_limits     : Child_Age_Limits;
                                             num_Upper_Limits : Num_Age_Ranges ) return Child_Age_Limits;

        --
        --  quickie function: equivalise a Amount income using the default McLement's scale.
        --
        function equivalise_income( benunit : Model.Household.Model_Benefit_Unit;
                                    income : Amount ) return Amount;

        --  ============== functions below are kept only so current code still works;

        type Scale_Types is ( mcclements, oecd_modified, flat );

        type Person_Types is ( first_adult, spouse, other_second_adult, third_adult,
                               subsequent_adult, child_u_14, child_14_plus );

        type One_Equivalence_Scale is array ( Person_Types ) of Rate;
        type All_Equivalence_Scales is array ( Scale_Types ) of One_Equivalence_Scale;

        --  rebase mcc scale to 1.
        EQUIVALENCE_SCALE_VALUES : constant All_Equivalence_Scales :=
          ( mcclements => ( 1.0, 0.39/0.61, 0.46/0.61, 0.42/0.61, 0.36/0.61, 0.20/0.61, 0.30/0.61 ),
            oecd_modified => ( 1.0, 0.5, 0.50, 0.50, 0.50, 0.30, 0.3  ),
            flat => ( others => 1.0 ));

        --
        --  this returns 1.0 for a single person (not, for example 0.61 as mcc would want)
        --
        function calc_equivalence_scale( hh : Model.Household.Household_Rec; stype : Scale_Types ) return Rate;
        --
        --  this returns 1.0 for a single person (not, for example 0.61 as mcc would want)
        --
        function calc_equivalence_scale( bu : Model.Household.Model_Benefit_Unit; stype : Scale_Types ) return Rate;


end Model.Equivalence_Scales;
