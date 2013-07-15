with Piecewise_Linear_Generator;
with ZA.Model.Settings;
with  Ada.Text_IO;

package body ZA.Model.Calculator.Budget_Constraints--
-- copyright(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////

 is

   use ZA.Model.Settings;
   use Ada.Text_IO;
   
   type Control_Record is record
      hh              : Household;
      original_income : Amount;
      which_family    : Family_Unit_Range;
      which_person    : Person_Range;  
      which_income    : Personal_Incomes_Type := salaries_and_wages;
      settings        : Run_Settings;
      params          : Parameters;
   end record;
   
   function Calculate_One( x : Rate; ctl : Control_Record ) return Rate is
      results : Household_Result;
      hh_copy : Household := ctl.hh;
   begin
      hh_copy.family( ctl.which_family ).person( ctl.which_person ).income( ctl.which_income ) := Amount( x );
      results := Calculate( hh_copy, ctl.params, ctl.settings );
      Log( budget_constraint, "results for gross " & Format( x ));
      Log( budget_constraint, To_String( results ));
      return Rate( results.disposable_income );
   end Calculate_One;
   
   function Inspect_One( x, y : Rate; 
      controls : Control_Record ) return Unbounded_String is
   begin
      return To_Unbounded_String( "FIXME NOT IMPLEMENTED" );
   end Inspect_One;
   
   package ZA_BC is new  Piecewise_Linear_Generator( 
      Rate => Rate,
      Control_Record => Control_Record,
      Details => Unbounded_String,
      Increment => 0.001,
      Tolerance => 0.02,
      Max_Depth => 500,
      Calculate_One_Position => Calculate_One,
      Run_Inspector => Inspect_One ); 
   
      
  START : constant Rate := 0.0; -- FIXME calculate these based on hh characteristics
  STOP  : constant Rate := 1_000_000.0;
      
  function Generate_Budget_Constraint( 
      hh           : Household;
      params       : Parameters;
      settings     : Run_Settings;
      which_family : Family_Unit_Range;
      which_person : Person_Range ) return Gross_And_Net_List is
      g_and_l_list : Gross_And_Net_List;
      control      : Control_Record;
      points       : ZA_BC.Points_List;
      point        : ZA_BC.Point;
      g_and_l      : Gross_And_Net;
      l            : Natural;
  begin
      control.hh := hh;
      control.settings := settings;
      control.which_family := which_family;
      control.which_person := which_person;
      control.original_income := 
         hh.family( which_family ).person( which_person ).income( salaries_and_wages );
      control.params := params;
      points := ZA_BC.Generate( control, START, STOP );
      l := Natural( points.Length );
      for pos in 1 .. l loop
         point := points.Element( pos );
         g_and_l.net := Amount( point.y );
         g_and_l.gross := Amount( point.x );
         g_and_l_list.Append( g_and_l );
      end loop;
      return g_and_l_list;
  end Generate_Budget_Constraint;

end ZA.Model.Calculator.Budget_Constraints;
