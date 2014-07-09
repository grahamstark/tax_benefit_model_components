------------------------------------------------------------------------------
--                                                                          --
--  Some general utility functions which don't fit elsewhere                --
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
--                                                                          --
--
--  $Revision: 6121 $
--  $Date: 2008-11-01 17:43:03 +0000 (Sat, 01 Nov 2008) $
--  $Author: graham_s $
--
pragma License( Modified_GPL );


package Utils is

   type Error_Type is ( No_Error, Format_Error, Out_Of_Range_Error, Other_Error );

   --
   -- Actually, a random Integer as a String
   --
   function Random_String return String;
   
   function Now_As_String return String;
   
   function Get_Stack_Trace( message : String := "" ) return String;
   
   --
   -- See (e.g.) http://coding.derkeiler.com/Archive/Ada/comp.lang.ada/2005-05/msg00281.html
   -- http://gcc.gnu.org/onlinedocs/gcc-3.3.6/gnat_rm/Storage_005fSize-Clauses.html
   --
   function Default_Stack_Size return Positive; -- Size_Type;
   
   Dir_Exception : Exception;
   
   --
   -- Slightly safer version of Ada.Directories.Create_Path
   -- catches Use_Error but throws a Dir_Exception on any other exception
   --
   procedure Make_Directory_Path( path : String );
   
   procedure Delete_File_If_Exists( name : String );
   
   --
   -- Zip the entire contents of a directory. Uses code from
   -- 
   procedure Zip_Directory(
      dir_name : String;
      zip_file_name : String );
      
end Utils;
