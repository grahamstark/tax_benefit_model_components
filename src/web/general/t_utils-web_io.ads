with AWS.Parameters;
with Ada.Strings.Unbounded;
with HTML_Utils;

--
-- This contains some code to write checkboxes / selects for a discrete type (usually an enumerated type) 
-- and some simple CGI handling using AWS.
--
generic

package T_Utils.Web_IO is

   use Ada.Strings.Unbounded;
   
   type Box_Type is ( checkbox, radio ); -- move me
   
   -- Handle is a simple piece of code to check a CGI submission for values of the enumerated type and return a set
   -- of which ones are present (using 'IMAGE as the value).
   function Handle( 
      varname : String; 
      params  : AWS.Parameters.List ) return Set;

   function Make_Discrete_Select_Boxes(
      group_id            : String;
      varname             : String;
      selected_elements   : Set; 
      printer             : Pretty_Print_Item_Access_T; -- a function to display a nice string for each value of T
      displayed_elements  : Set := EMPTY_SET;           -- empty = print everything; otherwise print just what's in the set  
      container_css_class : String := ""                -- css class for the div containg everything
      ) return Unbounded_String;      
      
   function Make_Select(
      varname             : String;
      selected_element    : T; 
      printer             : Pretty_Print_Item_Access_T; -- a function to display a nice string for each value of T
      displayed_elements  : Set := EMPTY_SET            -- empty = print everything; otherwise print just what's in the set  
      ) return Unbounded_String;              

end T_Utils.Web_IO;
