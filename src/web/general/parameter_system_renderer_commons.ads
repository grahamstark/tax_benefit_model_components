package Parameter_System_Renderer_Commons is
   
   type HTML_Kind is ( html5, xhtml1 );
   
   type Ajax_Action_Type is ( 
      insert_above, 
      insert_below, 
      delete, 
      save, 
      copy,
      error_check );
      
end Parameter_System_Renderer_Commons;
