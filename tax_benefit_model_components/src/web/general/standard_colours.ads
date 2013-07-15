with Colours;

package Standard_Colours is

   use Colours;

   type Standard_Colours_Type is (
   
         vw_red,
         vw_blue,
         pale_orange,
         dark_gray_blue,
         light_purple,
         sun_primary_2,
         vw_light_blue,
         pink,
         slate_blue,	
         light_turquoise,
         pale_blue,
         sun_primary_1,
         gray_blue,
      
         pale_brown,
         vw_med_blue,
         vw_dark_blue,
         vw_text_blue,
      
         scarlet,
         royal_blue,
         rich_purple,
      
         sun_secondary_1,
         sun_secondary_2,
         vw_gray_1,
         white,
         black );
        
   STD_COLOURS : constant array ( Standard_Colours_Type ) of Colour := (
      ( 16#b5#, 16#3a#, 16#30# ),
      ( 16#16#, 16#5b#, 16#9b# ),
      ( 16#ee#, 16#cc#, 16#aa# ),
      ( 16#66#, 16#66#, 16#99# ),
      ( 16#ea#, 16#9a#, 16#d7# ),
      ( 16#99#, 16#99#, 16#cc# ),
      ( 16#dd#, 16#bb#, 16#99# ),
      ( 16#ff#, 16#cc#, 16#bb# ),
      ( 16#38#, 16#82#, 16#99# ),
      ( 16#80#, 16#ba#, 16#cc# ),
      ( 16#aa#, 16#cc#, 16#ee# ),
      ( 16#bb#, 16#cc#, 16#ff# ),
      ( 16#99#, 16#bb#, 16#dd# ),
      
      ( 16#aa#, 16#cc#, 16#ee# ),
      ( 16#99#, 16#bb#, 16#dd# ),
      ( 16#66#, 16#99#, 16#cc# ),
      ( 16#15#, 16#24#, 16#84# ),
      
      ( 16#ee#, 16#44#, 16#22# ),
      ( 16#22#, 16#44#, 16#ee# ),
      ( 16#9b#, 16#44#, 16#e2# ),
      
      ( 16#66#, 16#66#, 16#66# ),
      ( 16#99#, 16#99#, 16#99# ),
      ( 16#cc#, 16#cc#, 16#cc# ),
      ( 16#ff#, 16#ff#, 16#ff# ),
      ( 16#00#, 16#00#, 16#00# )
   );
        
end Standard_Colours;

