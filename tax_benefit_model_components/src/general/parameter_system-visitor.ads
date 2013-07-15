generic 
  
   
package Parameter_System.Visitor is

   type Visitor is interface;
   
   procedure Visit( 
      v        : in out Visitor; 
      sys      : in out Parameter_System_Rec; 
      is_start : Boolean := False ) is null;

   procedure Visit( 
      v        : in out Visitor; 
      sys      : in out Parameter_System_Reference_Rec; 
      is_start : Boolean := False ) is null;

   procedure Visit( 
      v        : in out Visitor; 
      param    : in out Parameter_Rec; 
      is_start : Boolean := False ) is abstract;
           
end Parameter_System.Visitor;   
   

