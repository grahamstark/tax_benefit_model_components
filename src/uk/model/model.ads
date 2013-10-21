--
-- This is the top-level package for the UK model. It does very little: just
-- imports some standard types and generic formatting and calculation routines, so these can  
-- be used easily in the model itself, which is (almost) all declared in child packages.
-- 
-- Putting anything else in here may cause nasty cross-dependencies.
--
--  $Author: graham_s $
--  $Date: 2013-05-29 17:00:40 +0100 (Wed, 29 May 2013) $
--  $Revision: 16150 $

pragma License( Modified_GPL );

with Ada.Numerics.Generic_Elementary_Functions;
with Base_Model_Types;
with Financial_Functions;
with Format_Utils;
with Key_Value_IO;
with Maths_Functions;
with Tax_Utils;
with Text_Utils;
-- 
pragma Elaborate_All (Text_Utils);
pragma Elaborate_All (Base_Model_Types);
pragma Elaborate_All (Format_Utils);

package Model is
   
   use Base_Model_Types;

   package UK_Format_Utils is new Format_Utils( Counter_Type => Counter_Type, Float_Type => Rate );
   package UK_Tax_Utils is new Tax_Utils( Amount_Type=>Amount, Rate_Type=>Rate );
   package UK_Key_Value_IO is new Key_Value_IO( Real_Type=>Amount,  Counter_Type=>Counter_Type );

   package Amount_Math is new Ada.Numerics.Generic_Elementary_Functions( Amount );
   use Amount_Math;
   package Maths_Funcs is new Maths_Functions( Amount );
   use Maths_Funcs;
   package Financial_Funcs is new Financial_Functions( Rate=>Rate, Amount=>Amount );
   use Financial_Funcs;

   use UK_Format_Utils;
   use UK_Tax_Utils;
   --
   -- Just a Bounded String used for labels
   --
   use Text_Utils.Std_Bounded_String;

end Model;
