package body Google_Chart_Constants is
   
   -- See: http://code.google.com/apis/chart/types.html
   
   
   function To_String( t : Chart_Type ) return String is
   begin
      case t is 
         when line => return "lc";
         when sparkline => return "ls";
         when xy => return "lxy";
         when horizontal_bar => return "bhs";
         when vertical_bar => return "bvs";
         when horizontal_bar_grouped => return "bhg";
         when vertical_bar_grouped => return "bvg";
         when pie => return "p";
         when pie_3d => return "p3";
         when pie_concentric => return "chp";
         when venn_diagram => return "v";
         when scatter => return "s";
         when radar => return "r";
         when radar_spline => return "rs";
         when map => return "t";
      end case;
   end To_String;

   function Pretty_Print( t : Chart_Type ) return String is
   begin
      case t is 
         when line => return "Line";
         when sparkline => return "Spark Line";
         when xy => return "XY Chart";
         when horizontal_bar => return "Horizontal Bar";
         when vertical_bar => return "Vertical Bar";
         when horizontal_bar_grouped => return "Horizontal Bar Grouped";
         when vertical_bar_grouped => return "Vertical Bar Grouped";
         when pie => return "Pie";
         when pie_3d => return "Pie 3D";
         when pie_concentric => return "Concentric Pie";
         when venn_diagram => return "Venn Diagram";
         when scatter => return "Scatter Plot";
         when radar => return "Radar Plot";
         when radar_spline => return "Radar Plot With Splines";
         when map => return "Map";
     end case;
   end Pretty_Print;
   
   function Is_Vertical( ctype : Chart_Type ) return Boolean is 
   begin
      return ( ctype = line ) or ( ctype = sparkline ) or ( ctype = xy ) or 
             ( ctype = vertical_bar ) or ( ctype = vertical_bar_grouped );
   end Is_Vertical;
   
   function Is_Horizontal( ctype : Chart_Type ) return Boolean is
   begin
      return ( ctype = horizontal_bar_grouped ) or ( ctype = horizontal_bar );
   end Is_Horizontal;
   
   function Is_Pie( ctype : Chart_Type) return Boolean is 
   begin
      return ( ctype = pie ) or ( ctype = pie_3d );
   end Is_Pie;
   
   function Is_Bar( ctype : Chart_Type) return Boolean is 
   begin
       return ( ctype = horizontal_bar ) or ( ctype = vertical_bar ) or
              ( ctype = horizontal_bar_grouped ) or ( ctype = vertical_bar_grouped );
   end Is_Bar;
   
end Google_Chart_Constants;
