package body Standard_UK_Enums.Utils is
   
   function Get_Disabled_Benefits return Incomes_Set is
      s : Incomes_Set;
   begin
      s.Include( severe_disablement_allowance );
      s.Include( attendance_allowance );
      s.Include( disabled_living_allowance );
      return s;
   end Get_Disabled_Benefits;

   function Get_Care_Benefits return Incomes_Set is
      s : Incomes_Set;
   begin
      s.Include( attendance_allowance );
      return s;
   end Get_Care_Benefits;
  
end Standard_UK_Enums.Utils; 