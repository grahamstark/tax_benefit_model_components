--
--  $Author: graham_s $
--  $Date: 2009-05-29 16:55:27 +0100 (Fri, 29 May 2009) $
--  $Revision: 7270 $
--                                                                          --
-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
--
pragma License( Modified_GPL );

with Ada.Containers.Ordered_Sets;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

generic

   type Conditional is (<>); -- Any discrete type: integer, modular, or enumeration.
  
package T_Utils.Conditional_Amount_Calculator is

   package Conditional_Set_Ops is new Ada.Containers.Ordered_Sets( Element_Type => Conditional );
   
   subtype Conditional_Set is Conditional_Set_Ops.Set;
   
   CONDITIONAL_EMPTY_SET : Conditional_Set renames Conditional_Set_Ops.Empty_Set; -- constant
   
   type Applies_To_Rec is tagged record
      is_flat        : Boolean := False;
      amount_or_rate : Amount_Type := 1.0;
      applies_to     : Conditional_Set := CONDITIONAL_EMPTY_SET;
      which          : T;
   end record;
   
   type Abs_App_Array is array(  t range <> ) of Applies_To_Rec;

   subtype App_Array is Abs_App_Array( t );

   package Vector_Package is new Ada.Containers.Vectors( Index_Type=>Positive, Element_Type => T );
   subtype Applies_Vec is Vector_Package.Vector;
   
   function Calculate( values : Abs_Amount_Array; rules : Abs_App_Array ) return Amount_Type;
   function Calculate( values : Abs_Amount_Array; rules : Applies_Vec ) return Amount_Type;
   
end T_Utils.Conditional_Amount_Calculator;
