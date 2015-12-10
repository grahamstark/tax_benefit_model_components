pragma License( Modified_GPL );


package body Keyed_Buffer is

   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   type Buffer is new Unbounded_String_Map with record
      order : Unbounded_String_List;  
   end record;
   
   procedure Insert( buff : in out Buffer; key : String; value : String ) is
   begin
      null;
   end Insert;
   
   procedure Append( buff : in out Buffer; key : String; value : String ) is
   begin
      null;
   end Append;
   
   procedure Print( 
      buff     : in out Buffer; 
      filename : String; 
      delim    : String := ","; 
      append   : Boolean := False ) is
   begin
      null;
   end Print;
   
end Keyed_Buffer;
