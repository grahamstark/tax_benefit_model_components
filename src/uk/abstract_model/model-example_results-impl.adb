with Model.Abstract_Result;

package body Model.Example_Results.Impl is

   function Initialise( hh : Example_Household.Household'Class ) return Model_Household_Result is
      np : Person_Count := hh.people'Length;
      res : Model_Household_Result( np );
   begin
      for pno in 1 .. np  loop
         res.people( pno ).pid := hh.people( pno ).pid;
         res.people( pno ).income := ( others => 0.0 );
         res.people( pno ).intermediate := ( others => 0.0 );
      end loop;
      return res;
   end Initialise;

   procedure Zero( 
      result : in out Model_Benefit_Unit_Result ) is
   begin
      for pno in result.people'Range loop
         result.people( pno ).income := ( others => 0.0 );
         result.people( pno ).intermediate := ( others => 0.0 );
      end loop;
   end Zero;

   procedure Zero( result : in out Model_Household_Result ) is
   begin
      for pno in result.people'Range loop
         result.people( pno ).income := ( others => 0.0 );
         result.people( pno ).intermediate := ( others => 0.0 );
      end loop;
   end Zero;

   --
   -- personal level
   --
   
   procedure Set( 
      result : in out Model_Personal_Result;
      which  : Calculated_Incomes_Range; 
      value  : Amount;
      op     : Operation_Type := replace ) is
   begin
      case op is
      when add =>
         Inc( result.income( which ), value );
      when replace =>
         result.income( which ) := value;
      when subtract =>
         Inc( result.income( which ), -value );
      when multiply =>
         result.income( which ) := result.income( which ) * value;
      when divide =>
         result.income( which ) := result.income( which ) / value;
      end case;
    end Set;
      
    function Get( 
      result : Model_Personal_Result; 
      which  : Calculated_Incomes_Range ) return Amount is
    begin
      return result.income( which );   
    end Get;
      
    procedure Set( 
      result : in out Model_Personal_Result;
      which  : Broad_Calculated_Type; 
      value  : Amount; 
      op     : Operation_Type := replace ) is
    begin
      case op is
      when add =>
         Inc( result.intermediate( which ), value );
      when replace =>
         result.intermediate( which ) := value;
      when subtract =>
         Inc( result.intermediate( which ), -value );
      when multiply =>
         result.intermediate( which ) := result.intermediate( which ) * value;
      when divide =>
         result.intermediate( which ) := result.intermediate( which ) / value;
      end case;
       
    end Set;
      
    function Get( 
      result : Model_Personal_Result; 
      which  : Broad_Calculated_Type ) return Amount is
    begin
      return result.intermediate( which );
    end Get;
    
    procedure Zero( 
      result : in out Model_Personal_Result ) is
    begin
       result.income := ( others => 0.0 );
       result.intermediate := ( others => 0.0 );
    end Zero;
    
    --
    -- benefit unit level; we assume a single benefit unit here
    --
    
    procedure Set( 
      result : in out Model_Benefit_Unit_Result;
      pid    : Sernum_Value; 
      value  : mar.Personal_Result'Class ) is
    begin
      for pno in result.people'Range loop
         if result.people( pno ).pid = pid then
            result.people( pno ) :=Personal_Result( value );
         end if;         
      end loop;
    end Set;
 
   function Get( 
      result : Model_Benefit_Unit_Result; 
      pid    : Sernum_Value ) return mar.Personal_Result'Class is
      found : Boolean;
      pres : Personal_Result := Personal_Result( result.Find( pid, found ));
      mpers : Model_Personal_Result := ( pres with null record );
   begin
      return mpers;
   end Get;
      
   procedure Set( 
      result : in out Model_Benefit_Unit_Result;
      pid    : Sernum_Value; 
      which  : Calculated_Incomes_Range; 
      value  : Amount;
      op     : Operation_Type := Replace ) is
      found : Boolean;
   begin
      for pno in result.people'Range loop
         if pid = result.people( pno ).pid then
            case op is
              when add =>
                 Inc( result.people( pno ).income( which ), value );
              when replace =>
                 result.people( pno ).income( which ) := value;
              when subtract =>
                 Inc( result.people( pno ).income( which ), -value );
              when multiply =>
                 result.people( pno ).income( which ) := result.people( pno ).income( which ) * value;
              when divide =>
                 result.people( pno ).income( which ) := result.people( pno ).income( which ) / value;
              end case;
         end if;
      end loop;
   end Set;

   
   procedure Set( 
      result : in out Model_Benefit_Unit_Result;
      pid    : Sernum_Value; 
      which  : Broad_Calculated_Type; 
      value  : Amount;
      op     : Operation_Type := Replace ) is
   begin
      for pno in result.people'Range loop
         if pid = result.people( pno ).pid then
            case op is
            when add =>
               Inc( result.people( pno ).intermediate( which ), value );
            when replace =>
               result.people( pno ).intermediate( which ) := value;
            when subtract =>
               Inc( result.people( pno ).intermediate( which ), -value );
            when multiply =>
               result.people( pno ).intermediate( which ) := result.people( pno ).intermediate( which ) * value;
            when divide =>
               result.people( pno ).intermediate( which ) := result.people( pno ).intermediate( which ) / value;
            end case;
         end if;
      end loop;
   end Set;
   
   function Get( 
      result : Model_Benefit_Unit_Result; 
      which  : Broad_Calculated_Type ) return Amount is 
      tot : Amount := 0.0;
   begin 
      for pers of result.people loop
         tot := tot + pers.intermediate( which );
      end loop;
      return tot;
   end Get;
   
    function Get( 
      result : Model_Household_Result; 
      which  : Broad_Calculated_Type ) return Amount is 
      tot : Amount := 0.0;
   begin 
      for pers of result.people loop
         tot := tot + pers.intermediate( which );
      end loop;
      return tot;
   end Get;
  

   function Get( 
      result : Model_Household_Result; 
      which  : Benefit_Unit_Number ) return mar.Benefit_Unit_Result'Class  is
      np : constant Person_Count := result.people'Length;
      bu : Model_Benefit_Unit_Result( np );
    begin
      for pno in 1 .. np loop
         bu.people( pno ) := result.people( pno );
      end loop;
      return bu;
    end Get;

   function Get_Personal( 
      result : Model_Household_Result; 
      pid    : Sernum_Value ) return mar.Personal_Result'Class is
      found : Boolean;
      pres : Personal_Result := Personal_Result( result.Find( pid, found ));
      mpers : Model_Personal_Result := ( pres with null record );
   begin
      return mpers;
   end Get_Personal;
   --
   -- since 1 bu by assumption
   --
   procedure Set( 
      result : in out Model_Household_Result;
      pid    : Sernum_Value;
      value  : mar.Personal_Result'Class;
      op     : Operation_Type := Replace ) is
   begin
      for pno in result.people'Range loop
         if result.people( pno ).pid = pid then 
            result.people( pno ) := Personal_Result( value );
          end if;
      end loop;
   end Set;
   
   procedure Set( 
      result : in out Model_Household_Result;
      which : Benefit_Unit_Number; 
      value : mar.Benefit_Unit_Result'Class ) is
   begin
      for pno in result.people'Range loop
         declare
            pid : Sernum_Value := result.people( pno ).pid;
            newp : Personal_Result := 
               Personal_Result( value.Get( pid ));
         begin
            result.people( pno ) := newp;
         end;
      end loop;
   end Set;

end  Model.Example_Results.Impl;