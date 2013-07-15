--
-- This is the top-level package for the ZM model. It does very little: just
-- imports some standard types and generic formatting and calculation routines, so these can  
-- be used easily in the model itself, which is (almost) all declared in child packages.
-- 
-- Putting anything else in here may cause nasty cross-dependencies.
--
pragma License( Modified_GPL );

with Ada.Text_IO.Editing;

with Base_Model_Types;
with Format_Utils;
with Text_Utils;
with Key_Value_IO;
-- 
pragma Elaborate_All (Text_Utils);
pragma Elaborate_All (Base_Model_Types);
pragma Elaborate_All (Format_Utils);
-- pragma Elaborate_All (Tax_Utils);


package ZM is

   subtype Sernum_String is String (1 .. 18);
   type Sernum_Value  is range  100_000_000_000_000_000 .. 999_999_999_999_999_999;
   -- nb actual range is actually is 110_100_101_012_110_006 .. 990_714_712_022_150_091

   type Loggable_Modules is ( dummy );
   
   use Base_Model_Types;
   
   package ZM_Format_Utils is new 
      Format_Utils( 
         Counter_Type => Counter_Type, 
         Float_Type => Rate,
         Default_Separator => ',',
         Default_Radix_Mark => '.',
         Amount_Picture => 
            Ada.Text_IO.Editing.To_Picture( "-ZZZ_ZZZ_ZZZ_ZZZ_ZZZ_ZZ9") ); -- comma seperator
   package ZM_Key_Value_IO is new Key_Value_IO( Real_Type=>Amount,  Counter_Type=>Counter_Type );

   use ZM_Format_Utils;
   
end ZM;
