with XML_Utils;

generic

package Parameter_System.XML is

   use XML_Utils;
   
   function Load( root_elem  : domc.Node ) return Parameter_System_Rec;
   function Load( elem  : domc.Element ) return Parameter_Rec;
   function Load( xpath : String; from : domc.Document ) return Parameter_Rec;
   function Load( xpath : String; from : domc.Document ) return Parameter_System_Rec;
   function Make_X_Path_From_Path( path : String; is_for_parameter : Boolean := False ) return String;
 
end Parameter_System.XML;
