with Indexed_Sequential_IO.Debug_G;

package Integer_Indexed_Sequential_IO.Debug is
  new Integer_Indexed_Sequential_IO.Debug_G
  (Get_Key_Image  => Integer'Image,
   Get_Item_Image => Integer'Image);




