--  This  library  is  free software; you can redistribute it and/or  --
--  modify it under the terms of the GNU General Public  License  as  --
--  published by the Free Software Foundation; either version  2  of  --
--  the License, or (at your option) any later version. This library  --
--  is distributed in the hope that it will be useful,  but  WITHOUT  --
--  ANY   WARRANTY;   without   even   the   implied   warranty   of  --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU  --
--  General  Public  License  for  more  details.  You  should  have  --
--  received  a  copy  of  the GNU General Public License along with  --
--  this library; if not, write to  the  Free  Software  Foundation,  --
--  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.    --
--                                                                    --
--  As a special exception, if other files instantiate generics from  --
--  this unit, or you link this unit with other files to produce  an  --
--  executable, this unit does not by  itself  cause  the  resulting  --
--  executable to be covered by the GNU General Public License. This  --
--  exception  does not however invalidate any other reasons why the  --
--  executable file might be covered by the GNU Public License.       --
--____________________________________________________________________--
--
--
--
with Strings_Edit.Integer_Edit;

package body Colours is 
   
   package Byte_Edit is new Strings_Edit.Integer_Edit( Byte );

   --type Byte is range 1..128;
   --type Colour is (red, green, blue );
   --type RGB is array( Colour ) of Byte;
   function To_String( col : Colour ) return String is
      s : String( 1..6 );
      p : Natural := 1;
   begin
      Byte_Edit.Put( s, p, col( red ), 16 ); 
      Byte_Edit.Put( s, p, col( green ), 16 ); 
      Byte_Edit.Put( s, p, col( blue ), 16 ); 
      return s;
   end To_String;
   
   function From_String( colstr : String ) return Colour is
      col : Colour;
      offset : Natural := colstr'First-1;
   begin
      --
      -- pattern match: throw lots of exceptions here
      --
      if( colstr( colstr'First ) = '#') then
         offset := offset + 1;
      end if;
      col( red ) := Byte_Edit.Value( colstr(offset+1..offset+2), 16 );
      col( green ) := Byte_Edit.Value( colstr(offset+3..offset+4), 16 );
      col( blue ) := Byte_Edit.Value( colstr(offset+5..offset+6), 16 ); 
      return col;
   end From_String;
   
end Colours;
