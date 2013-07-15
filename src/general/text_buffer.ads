with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;

package Text_Buffer is

   use Ada.Strings.Unbounded;
   
   type Buffer is tagged private;
   
   function Load( filename : String ) return Buffer;
   
   function Get_Line( this_buffer : Buffer; line_no : Positive ) return String;
   function Get_Line( this_buffer : Buffer; line_no : Positive ) return Unbounded_String;
   function Num_Lines( this_buffer : Buffer ) return Positive;
   
private
 
   
   package Data_Lines_Package is new Ada.Containers.Vectors( 
      Element_Type => Ada.Strings.Unbounded.Unbounded_String, 
      Index_Type => Positive );  
   
   subtype Data_Lines is Data_Lines_Package.Vector;
   
   type Buffer is tagged record
      lines : Data_Lines;
   end record;
 
end Text_Buffer;
