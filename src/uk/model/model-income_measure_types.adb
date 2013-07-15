package body Model.Income_Measure_Types is

  function Pretty_Print( slot : Slot_Range ) return String is
   begin
      case slot is
         when 1 => return "more than 1%";
         when 2 => return "more than 10%";
         when 3 => return "more than a third";
         when 4 => return "more than one-half";
         when 5 => return "up to 100%";
         when 6 => return "all";
      end case;
   end Pretty_Print;
   
   
   function Affordability_Measure_Type_Name( measure : Affordability_Measure_Type ) return String is
   begin
      case measure is
         when residual_income_level => return "Residual Income (£s p.a.)";
         when cost_disposable_ratio => return "Cost/Disposable Income Ratio";
         when cost_gross_ratio =>      return "Cost/Gross Income Ratio";
      end case;
   end Affordability_Measure_Type_Name;
   
   function Pretty_Print( measure : Affordability_Measure_Type ) return String is
   begin
      return Affordability_Measure_Type_Name( measure );
   end Pretty_Print;

    
    function Affordability_Units_Name( measure : Affordability_Measure_Type ) return String is
    begin
      case measure is
         when residual_income_level => return "(£s p.a.)";
         when cost_disposable_ratio => return "Percentage Share";
         when cost_gross_ratio =>      return "Percentage Share";
      end case;
    end Affordability_Units_Name;
    
   function Slot_Range_Str( measure : Affordability_Measure_Type; slot : Slot_Range ) return String is
   begin
      if( measure = residual_income_level ) then
         case slot is
            when 1 => return " < - 5,000 ";
            when 2 => return " -5,000 - -10,00.01";
            when 3 => return " -1,000 - 0.01";
            when 4 => return " 0 - 999.99";
            when 5 => return " 1,000-9,999.99";
            when 6 => return " 10,000 and above";
         end case;
      else
         case slot is
            when 1 => return "< 1%";
            when 2 => return "1%-9.99%";
            when 3 => return "10%-33.33%";
            when 4 => return "33.34%-49.99%";
            when 5 => return "50%-99.99%";
            when 6 => return "100% and over";
         end case;
      end if;
   end Slot_Range_Str;
   
   function Slot_Range_Str_Residual_Income( slot : Slot_Range ) return String is
   begin
      return Slot_Range_Str( residual_income_level, slot );
   end Slot_Range_Str_Residual_Income;
   
   function Slot_Range_Str_Ratio( slot : Slot_Range ) return String is
   begin
      return Slot_Range_Str( cost_disposable_ratio, slot );
   end Slot_Range_Str_Ratio;
   

   
      --
   --  a record with differences (2-1) in all the numeric values.
   --
   function Difference( res1, res2 : One_Complete_Income_Measure_Output ) return One_Complete_Income_Measure_Output is
      diff : One_Complete_Income_Measure_Output;
   begin
       return diff;
   end Difference;
   
   function Sum( res1, res2 : One_Complete_Income_Measure_Output ) return One_Complete_Income_Measure_Output is
      diff : One_Complete_Income_Measure_Output;
   begin
      return diff;
   end Sum;
   
   procedure Aggregate( res1 : in out One_Complete_Income_Measure_Output; res2 : One_Complete_Income_Measure_Output ) is
   use Income_Measure_Package;
   
   begin
      res1.poverty_line := res1.poverty_line + res2.poverty_line;
      res1.incomes :=  res1.incomes + res2.incomes;
      for i in 1 .. res2.num_cost_measures loop
         res1.costs(i) := res1.costs(i) + res2.costs(i);
      end loop;
   end Aggregate;
   
   function Income_Measure_Type_Name( measure : Income_Measure_Type ) return String is
   begin
      case measure is
         when Gross => return "Gross Income"; 
         when Net => return "Net Income";
         when Disposable => return "Disposable Income";
      end case;
   end Income_Measure_Type_Name;
   
   function Income_Measure_Type_Name_Short_Version( measure : Income_Measure_Type ) return String is
   begin
      case measure is
         when Gross => return "Gross"; 
         when Net => return "Net";
         when Disposable => return "Disposable";
      end case;
   end Income_Measure_Type_Name_Short_Version;
      
   function Get_Income_Range( m : Amount ) return Income_Brackets is
      lim : Amount := 0.0;
   begin
      for i in Income_Brackets'First .. Income_Brackets'Last loop
            lim := lim + INCOME_INCREMENT;
            if( m < lim ) then 
               return i;
            end if;
      end loop;
      return Income_Brackets'Last;
   end Get_Income_Range;
   
  function To_String( res : One_Complete_Income_Measure_Output ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
      outs : Unbounded_String := To_Unbounded_String( "" ); 
   begin
      outs := outs & "poverty line: " & format( res.poverty_line ) & LINE_BREAK;
      outs := outs & "incomes: " & Income_Measure_Package.To_String( res.incomes ) & LINE_BREAK;
      outs := outs & " affordabilites " & LINE_BREAK;
      for i in  1 .. res.num_cost_measures loop
         outs := outs & "cost " & format_with_commas(res.costs(i)) & " affordabilities: " & Affordability_Measure_Package.To_String( res.affordabilities(i) ) & LINE_BREAK;
      end loop;
      return To_String( outs );
   end To_String;
   
   
   function To_String( hh : Household_Rec; res : Household_Incomes_Result ) return String is
      use Text_Utils;
      use Ada.Strings.Unbounded;
      outs : Unbounded_String := To_Unbounded_String( "" ); 
   begin
      outs := outs & "net housing costs: " & format( res.net_housing_costs ) & LINE_BREAK;
      outs := outs & "gross housing costs: " & format( res.gross_housing_costs ) & LINE_BREAK;
      outs := outs & "Aggregate Results " & LINE_BREAK & To_String( res.aggregate ) & LINE_BREAK;
      for buno in 1 .. hh.num_benefit_units loop
         outs := outs & " Benefit Unit " & Positive'Image( buno ) &  LINE_BREAK;
         outs := outs & To_String( res.benefit_units( buno )) & LINE_BREAK;
      end loop;
      return To_String( outs );
   end To_String;
    
      --
   --  a fresh output record
   --
   function New_Output return Household_Incomes_Result is
      diff : Household_Incomes_Result;
   begin
      
      return diff;
   end New_Output;

   
end Model.Income_Measure_Types;   

