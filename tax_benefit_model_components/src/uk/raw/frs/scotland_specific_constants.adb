package body scotland_specific_constants is

   --
   --  recode the stratifier so Grampian is 1
   --
   function Get_Int_Value_Of_Stratifier( strat : Regional_Stratifier ) return integer is
   begin
      if ( strat < highland_grampian_tayside ) or ( strat = northern_ireland ) then
         return 0;
      end if;
      return 1 + Regional_Stratifier'Pos( strat ) - ( Regional_Stratifier'Pos( highland_grampian_tayside ));
   end Get_Int_Value_Of_Stratifier;


end scotland_specific_constants;
