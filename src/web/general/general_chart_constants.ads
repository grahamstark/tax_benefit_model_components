package General_Chart_Constants is

   -- all these must Match the Java enumerated types declared in be.uclouvain.charts
   type Chart_Type is ( bar, radar, polar, pie, time_series, lorenz, time_series_fan ); -- ...
   type Chart_Size is ( thumb, medium, large );
   type Chart_Style is ( orion, normal, other );
   type Pre_Or_Post is ( pre, post, both, abs_change, pct_change );
   
end General_Chart_Constants;
