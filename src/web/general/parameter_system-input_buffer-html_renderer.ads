with Ada.Strings.Unbounded;
with Templates_Parser;
with Text_Utils;
with Parameter_System_Renderer_Commons;

generic

--
-- This child package produces a basic html page from a completed parameter system buffer.
-- Quite a lot of things are jammed on; at a mininum you'll need to make a copy
-- of the templates/ images/ and js/ directories of (e.g) web/wsc/ in the Wales project 
-- needs lots of work on customisation but this is enough for my limited purposes.
-- TODO, rename things now it's general to make everything clearer.
-- TODO: add some user permissions?
-- 
package Parameter_System.Input_Buffer.HTML_Renderer is
   
   use Templates_Parser;
   use Text_Utils;
   use Parameter_System_Renderer_Commons;
   
   procedure Create_HTML_Inputs( 
      html_cells       : in out Templates_Parser.Vector_Tag;
      buff             : Buffer;
      base_sys         : Parameter_System_Rec; 
      sys              : Parameter_System_Rec; 
      parameter_prefix : Unbounded_String;
      print_static_only : Boolean := False; 
      print_all         : Boolean := False );

   procedure Set_Paths(
      new_web_root                 : String;
      new_template_components_path : String;
      new_directory_separator      : Character );   

   --
   -- This does nothing at present - xhtml1 only
   --
   procedure Set_HTML_Type( t : HTML_Kind );

   function Create_Static_Page(
      buff                : Buffer;
      sys                 : Parameter_System_Rec; 
      parameter_prefix   : Unbounded_String ) return Unbounded_String;
  
   
   function Make_Parameter_Menu(
      start_year           : Year_Number;
      end_year             : Year_Number;
      this_year            : Year_Number;
      base_sys             : Parameter_System_Rec; 
      current_path         : Unbounded_String_List;
      prefix               : Unbounded_String;      
      lang                 : Languages ) return Unbounded_String;   
      
   --
   -- create a table with each row consisting of one of the records, and editing
   -- controls at the end which can change the number of rows
   -- see Callbacks.Msc.Array_Update_Callback for an example of a suitable Ajax callback for this
   -- an example use case is rate/band combos for income tax, where each rate/band
   -- pair is modelled as a mini-system and we use an integer as the index 
   --
   function Make_Indexed_Block(
      complete_sys      : Parameter_System_Rec;
      key               : Unbounded_String;
      buff              : Buffer;
      ajax_target_key   : Unbounded_String;
      print_static_only : Boolean := False; 
      print_all         : Boolean := False  ) return Unbounded_String;
      
   function Create_Complete_Translations( 
      title               : Unbounded_String;
      buff                : Buffer;
      model_menu          : Unbounded_String;
      breadcrumb          : Unbounded_String;
      base_sys            : Parameter_System_Rec; 
      sys                 : Parameter_System_Rec; 
      parameter_prefix    : Unbounded_String;
      main_error_message  : Unbounded_String;
      job_is_running      : Boolean;
      extra_translations  : Templates_Parser.Translate_Set ) return Translate_Set;
      
   function Create_Input_Page(
      title               : Unbounded_String;
      buff                : Buffer;
      model_menu          : Unbounded_String;
      breadcrumb          : Unbounded_String;
      base_sys            : Parameter_System_Rec; 
      sys                 : Parameter_System_Rec;
      parameter_prefix    : Unbounded_String;
      main_error_message  : Unbounded_String;
      job_is_running      : Boolean;
      extra_translations  : Templates_Parser.Translate_Set ) return Unbounded_String;
   
end Parameter_System.Input_Buffer.HTML_Renderer;
