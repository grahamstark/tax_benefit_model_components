with Ada.Strings.Unbounded;
with General_Chart_Constants;
with Standard_Colours;
with Colours;
with Ada.Calendar;

with Ada.Containers.Vectors;

generic
   
   type Index_Type is (<>);
   type Real_Type is digits <>;
   type Time_Series_Array is array( Index_Type ) of Real_Type;
   num_systems : Positive := 1;
package Time_Series_Chart_Generator is

   -- PLOTTER_URL : constant String := "http://virtual-worlds.biz/plotter/plotter.php";
   -- PLOTTER_URL : constant String := "http://vw/plotter/plotter.php";
   
   use Ada.Strings.Unbounded;
   use General_Chart_Constants;
   use Colours;
   use Ada.Calendar;
   use Standard_Colours;
   
   type Time_Series_Chart is tagged private;

   function Construct( 
      plotter_url         : String;
      title               : String;
      subtitle            : String;
      start_year          : Year_Number;
      x_axis_label        : String;
      y_axis_label        : String;
      ctype               : Chart_Type;
      system              : Pre_Or_Post ) return Time_Series_Chart;
   
   procedure Add_Data_Series( 
      chart        : in out Time_Series_Chart;
      data         : Time_Series_Array;
      label        : String;
      colour       : Standard_Colours_Type;
      which_system : Positive := 1  );  
      
   function To_URL( chart : Time_Series_Chart; size : Chart_Size; is_svg : Boolean ) return Unbounded_String;
      
      
-- set pre/post colour somewhere

private

   type Data_Item is record
      data     : Time_Series_Array;
      colour   : Standard_Colours_Type;
      label    : Unbounded_String;
   end record;
   
   package Data_List_Package is new Ada.Containers.Vectors( 
      Element_Type => Data_Item,
      Index_Type => Positive );
   subtype Data_List is Data_List_Package.Vector;
   type Data_List_Array is array( 1 .. num_systems ) of Data_List;
   
   type Time_Series_Chart is tagged record
      data     : Data_List_Array;
      title    : Unbounded_String;
      subtitle : Unbounded_String;
      x_axis_label        : Unbounded_String;
      y_axis_label        : Unbounded_String;
      plotter_url         : Unbounded_String;
      ctype               : Chart_Type;
      style               : Chart_Style  := normal;
      start_year          : Year_Number;
      system              : Pre_Or_Post;
   end record;

end Time_Series_Chart_Generator;
