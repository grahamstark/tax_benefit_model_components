--
--  $Revision: 5479 $
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--
--  basic equivalence scale constants
--  see: www.dwp.gov.uk/asd/hbai/hbai2002/pdfs/Appx5.pdf
--
pragma License( Modified_GPL );

with Model.Household; use Model.Household;
with Text_IO;

package body Model.Equivalence_Scales is

   --  type Child_Age_Limits is array ( Age_Range ) of Model.Household.Child_Age;

   --  type Child_Age_Amounts is array ( Age_Range ) of Rate;

   function num_Children_In_Age_Ranges
     (children         : Child_Array;
      num_children     : Child_Range;
      upper_limits     : Child_Age_Limits;
      num_Upper_Limits : Num_Age_Ranges)
      return             Child_Age_Limits
   is
      count : Child_Age_Limits := (others => 0);
   begin
      for ch in  1 .. num_children loop
         check_age_loop :
            for a in  1 .. num_Upper_Limits loop
               if (children (ch).age <= upper_limits (a)) then
                  count (a) := count (a) + 1;
                  exit check_age_loop;
               end if;
            end loop check_age_loop;
      end loop;
      return count;
   end num_Children_In_Age_Ranges;

   function equivalise_income (benunit : Model_Benefit_Unit; income : Amount) return Amount is
   use text_io;
      m  : constant Rate := Rate (income);
      eq : constant Rate := Model.Equivalence_Scales.Calculate_McLements_Scale (benunit);
   begin
      put( "last adult " & benunit.last_adult'Img & " bu.num_children " &  benunit.num_children'Img );
      put( "equivalise_income ; m = " & m'Img & " eq " & eq'Img );
      new_line;
      return Amount (m / eq);
   end equivalise_income;

   --
   --  McLements scale for a benfit using, ignoring any non-spouse adults
   --
   function Calculate_McLements_Scale
     (bu    : Model_Benefit_Unit;
      scale : Basic_McLements_Scale_Rec := DEFAULT_MCLEMENTS_SCALE)
      return  Rate
   is
   use text_io;
      eqs : Rate := scale.adult;
   begin
      --  text_io.put ("equivalence scales; basic adult scale = " & eqs'Img);
      if (bu.last_adult = spouse) then
         eqs := eqs + scale.spouse;
      end if;
      --  text_io.put ("equivalence scales; after adding spouse (if any) = " & eqs'Img);

      if (bu.num_children > 0) then
         declare
            in_age_range : constant Child_Age_Limits :=
               num_Children_In_Age_Ranges
                 (bu.children,
                  bu.num_children,
                  scale.child_Age_Limit,
                  scale.num_Child_Ranges);

         begin
            for a in  1 .. scale.num_Child_Ranges loop
               -- Text_IO.Put
                 -- ("range: " &
                  -- a'Img &
                  -- " in_age_range(a) " &
                  -- in_age_range (a)'Img &
                  -- "child_Age_Amount(a) " &
                  -- scale.child_Age_Amount (a)'Img);
               eqs := eqs + (Rate (in_age_range (a)) * scale.child_Age_Amount (a));
               -- Text_IO.Put ("eqs now " & eqs'Img);
               -- Text_IO.New_Line;
            end loop;
         end;
      end if;
      --  text_io.put ("equivalence scales; after adding kids (if any) = " & eqs'Img);
      --  Text_IO.New_Line;

      return eqs;
   end Calculate_McLements_Scale;

   -- ==============================================================================================
   --============
   --  these are obsolete!!
   -- ==============================================================================================
   --============
   function other_adult_scale (num_adults : Integer; stype : Scale_Types) return Rate is
      scale : Rate;
   begin
      case num_adults is
         when 2 =>
            scale := EQUIVALENCE_SCALE_VALUES (stype) (other_second_adult);
         when 3 =>
            scale := EQUIVALENCE_SCALE_VALUES (stype) (third_adult);
         when others =>
            scale := EQUIVALENCE_SCALE_VALUES (stype) (subsequent_adult);
      end case;
      return scale;
   end other_adult_scale;

   function child_scale
     (num_children : Integer;
      children     : Child_Array;
      stype        : Scale_Types)
      return         Rate
   is
      scale : Rate := 0.0;
   begin
      for chno in  1 .. num_children loop
         if (children (chno).age < 14) then
            scale := scale + EQUIVALENCE_SCALE_VALUES (stype) (child_u_14);
         else
            scale := scale + EQUIVALENCE_SCALE_VALUES (stype) (child_14_plus);
         end if;
      end loop;
      return scale;
   end child_scale;

   --  EQUIVALENCE_SCALE_VALUES : constant All_Model.Equivalence_Scales :=
   --  ( mcclements => ( 0.61, 0.39, 0.46, 0.42, 0.36, 0.20, 0.30 ),
   --    oecd_modified => ( 1.0, 0.5, 0.50, 0.50, 0.50, 0.30, 0.3  ),
   --    flat => ( others => 1.0 ));
   --
   --  this returns 1.0 for a single person (not, for example 0.61 as mcc would want)
   --
   function calc_equivalence_scale
     (hh    : Model.Household.Household_Rec;
      stype : Scale_Types)
      return  Rate
   is
      scale       : Rate    := 1.0;
      adult_count : Integer := 1;
   begin
      scale := calc_equivalence_scale (hh.benefit_units (1), stype);
      if (hh.benefit_units (1).last_adult = spouse) then
         adult_count := 2;
      end if;

      for buno in  2 .. hh.num_benefit_units loop
         for adno in  head .. hh.benefit_units (buno).last_adult loop
            adult_count := adult_count + 1;
            scale       := scale + other_adult_scale (adult_count, stype);
         end loop;
         scale := scale +
                  child_scale
                     (hh.benefit_units (buno).num_children,
                      hh.benefit_units (buno).children,
                      stype);
      end loop;
      return scale;
   end calc_equivalence_scale;
   --
   -- this returns 1.0 for a single person (not, for example 0.61 as mcc would want)
   --
   function calc_equivalence_scale
     (bu    : Model.Household.Model_Benefit_Unit;
      stype : Scale_Types)
      return  Rate
   is
      scale : Rate := 1.0;
   begin
      if (bu.last_adult = spouse) then
         scale := scale + EQUIVALENCE_SCALE_VALUES (stype) (spouse);
      end if;
      scale := scale + child_scale (bu.num_children, bu.children, stype);
      --  text_io.put
        -- ("calc_equivalent_scale; last_adult=" &
         -- bu.last_adult'Img &
         -- " num kids " &
         -- bu.num_children'Img &
         -- " scale= " &
         -- scale'Img);
      return scale;
   end calc_equivalence_scale;

end Model.Equivalence_Scales;
