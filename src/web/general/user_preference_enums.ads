package User_Preference_Enums is

   type Preference_Type is ( use_svg_graphics, other_preference );
   type Preference_Array is array( Preference_Type ) of Boolean;
   type User_Class is ( anon, registered, expert, admin, invalid, deleted );
 
end User_Preference_Enums;
