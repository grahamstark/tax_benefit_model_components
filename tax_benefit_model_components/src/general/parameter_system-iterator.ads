-- with Parameter_System.Visitor;
-- use Parameter_System.Visitor;

generic 
   
   with procedure Visit( 
      sys      : in out Parameter_System_Rec );

   with procedure Visit( 
      sys      : in out Parameter_System_Reference_Rec );

   with procedure Visit( 
      param    : in out Parameter_Rec );

package Parameter_System.Iterator is
   
   procedure Iterate( 
      sys      : in out Parameter_System_Rec ); 

     
end Parameter_System.Iterator;
