generic 
   
   -- This is the floating type we use throughout. 
   --
   type Float_Type is digits<>;
   --
   --
   --
   type Counter_Type is delta<> digits<>;
   
package XML_Utils.Conversions is

   function Get_Attr_Value( n : domc.Node; key : String; default : Integer := 0 ) return Integer;
   function Get_Attr_Value( n : domc.Node; key : String; default : Float_Type := 0.0 ) return Float_Type;
   function Get_Attr_Value( n : domc.Node; key : String; default : Boolean := False ) return Boolean;
   function Get_Attr_Value( n : domc.Node; key : String; default : Counter_Type := 0.0 ) return Counter_Type;
   
end XML_Utils.Conversions;
