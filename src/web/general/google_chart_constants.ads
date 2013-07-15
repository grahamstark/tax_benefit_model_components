package Google_Chart_Constants is
   
   -- See: http://code.google.com/apis/chart/types.html
   
   type Chart_Type is (
      line,
      sparkline,
      xy,
      horizontal_bar,
      vertical_bar,
      horizontal_bar_grouped,
      vertical_bar_grouped,
      pie,
      pie_3d,
      pie_concentric,
      venn_diagram,
      scatter,
      radar,
      radar_spline,
      map
   );
   
   function To_String( t : Chart_Type ) return String;
   function Pretty_Print( t : Chart_Type ) return String;
   
   function Is_Vertical( ctype : Chart_Type ) return Boolean;
   function Is_Horizontal( ctype : Chart_Type ) return Boolean;
   function Is_Pie( ctype : Chart_Type ) return Boolean;
   function Is_Bar( ctype : Chart_Type) return Boolean;
   
end Google_Chart_Constants;
