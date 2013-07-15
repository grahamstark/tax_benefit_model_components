with Ada.Containers.Ordered_Maps;

package BHPS.XLookup is
   
   type Summary_Status_Type is ( other, ok, dead, refused, institutionalised );

   type Wave_Location is record
      hid                           : Sernum_Value  := MISSING_SERNUM;    -- household_identification_number_wave_1 : Household identification number: Wave 1 
      pno                           : Integer       := MISS;              -- person_number_wave_1 : Person number: Wave 1
      individual_interview_ok       : Boolean := False;
      household_interview_ok        : Boolean := False;
      summary_status                : Summary_Status_Type := Summary_Status_Type'First;
   end record;
   
   type X_Wave_Lookup is tagged private;
   
   function Get_Household_Id( xwave : X_Wave_Lookup; wave : Waves; pid : Sernum_Value ) return Wave_Location;
   procedure Add_Record( xwave : in out X_Wave_Lookup; xw : Xwaveid_Rec );
   
private
      
   function Compare_Sernums_Lt( left, right: Sernum_Value ) return Boolean;
   function Compare_Values_Equal( left, right: Xwaveid_Rec ) return Boolean;
   
      
   package X_Wave_Index_Package is new Ada.Containers.Ordered_Maps( 
       Key_Type => Sernum_Value, 
       Element_Type => Xwaveid_Rec, 
       "=" => Compare_Values_Equal,
       "<" => Compare_Sernums_Lt ); 
    subtype X_Wave_Index is X_Wave_Index_Package.Map;

    type X_Wave_Lookup is tagged record
       index : X_Wave_Index;   
    end record;
   
end BHPS.XLookup;
