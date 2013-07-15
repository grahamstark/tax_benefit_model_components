with Integer_Items;            use Integer_Items;
with Indexed_Sequential_IO;

package Integer_Indexed_Sequential_IO is
  new Indexed_Sequential_IO
  (Item_Type      => Integer,
   Key_Type       => Integer,
   Index_Order    => 2,
   Sequence_Order => 2);

