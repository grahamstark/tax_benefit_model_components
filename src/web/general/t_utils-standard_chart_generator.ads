with Ada.Strings.Unbounded;
with General_Chart_Constants;
with Standard_Colours;
with Colours;
with Ada.Calendar;

with Ada.Containers.Vectors;

generic

package T_Utils.Standard_Chart_Generator is

   -- PLOTTER_URL : constant String := "http://virtual-worlds.biz/plotter/plotter.php";
   -- PLOTTER_URL : constant String := "http://vw/plotter/plotter.php";
   
   use Ada.Strings.Unbounded;
   use General_Chart_Constants;
   use Colours;
   use Ada.Calendar;
   use Standard_Colours;
   
   DEFAULT_PRE_COLOUR_STRING : constant String := To_String( STD_COLOURS( vw_red ));
   DEFAULT_POST_COLOUR_STRING : constant String := To_String( STD_COLOURS( vw_blue ));
   
   function Make_Univariate_Chart( 
      plotter_url         : String;
      title               : String;
      subtitle            : String;
      data1               : Abs_Amount_Array;
      x_axis_label        : String;
      y_axis_label        : String;
      printer             : Pretty_Print_Item_Access_T;
      ctype               : Chart_Type;
      size                : Chart_Size;
      system              : Pre_Or_Post      := pre;
      style               : Chart_Style      := normal;
      data2               : Abs_Amount_Array := ZERO_Abs_Amount_Array;
      displayed_elements  : Set := EMPTY_SET ) return Unbounded_String;
      
-- set pre/post colour somewhere

end T_Utils.Standard_Chart_Generator;
