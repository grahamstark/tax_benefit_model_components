--
--  $Author: graham_s $
--  $Date: 2008-07-21 21:25:02 +0100 (Mon, 21 Jul 2008) $
--  $Revision: 5479 $
--
--
pragma License( Modified_GPL );

package body Model.Calculations is

  --  handle a single expense or allowance
  --  val - expense amount
  --  exp - this proportion eligible (0-1.0), or maximum value (0- inf)
  --       and boolean is_flat: allow a percentage or FLAT - allow up to prop as a maximum
   function Expenses_Op (val : Amount; exp : One_Expense) return Amount is
      outv : Rate := 0.0;
      rv   : Rate := 0.0;
   begin
      rv := Rate (val);
      if (not exp.is_flat) then
         outv := rv * Rate (exp.amount);
      elsif (rv > exp.amount) then
         outv := exp.amount;
      else
         outv := rv;
      end if;
      return Amount (outv);
   end Expenses_Op;

   --   children array of Household_Rec.child objects
   --   bands - age bands
   --
   function Calc_Child_Allowances( benunit : Model.Household.Model_Benefit_Unit; bands : Child_Age_Array;rates : Child_Amount_Array ) return Amount is
      allow : Amount  := 0.0;
      p     : Integer := 1;
   begin
      for chno in  1 .. benunit.num_children loop
         p := 1;
         while (bands (p) < benunit.children (chno).age) loop
            p := p + 1;
         end loop;
         allow := allow + rates (p);
      end loop;
      return allow;
   end Calc_Child_Allowances;

        
end Model.Calculations;
