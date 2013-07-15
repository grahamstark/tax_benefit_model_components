with Ada.Strings.Unbounded;
with Google_Chart_Constants;

generic

package T_Utils.Google_Chart_Generator is

   use Ada.Strings.Unbounded;
   use Google_Chart_Constants;
   
   THUMBNAIL_SIZE_STR : constant String := "chs=50x50";
   FULL_SIZE_STR      : constant String := "chs=600x400";
   
   function Make_Univariate_Chart( 
      title               : String;
      data                : Abs_Amount_Array;
      printer             : Pretty_Print_Item_Access_T;
      ctype               : Chart_Type;
      is_thumbnail        : Boolean;
      displayed_elements  : Set := EMPTY_SET ) return Unbounded_String;      
      

end T_Utils.Google_Chart_Generator;
