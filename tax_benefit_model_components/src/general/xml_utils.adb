with Format_Utils;
with String_Stream;
with Ada.Text_IO;
package body XML_Utils is

	use Ada.Text_IO;
	
   function To_String( node : domc.Node ) return Ada.Strings.Unbounded.Unbounded_String is
   	output : aliased String_Stream.String_Stream_Type;	
   begin
   	String_Stream.Open( output, "" );
   	dnodes.Write( 
   		Stream                => output'Access, 
   		N                     => node,
   		Print_Comments        => False,
   		Print_XML_Declaration => False,
   		With_URI              => False );
   	return output.str;
   end To_String;
   
   
   function To_String( node : domc.Node ) return String is
   begin
   	return Ada.Strings.Unbounded.To_String( To_String( node ));
   end To_String;


    function Get_Attr_Value( n : domc .Node; key : String; default : String := "" ) return String is
      use domc;
      a : domc.Attr;
   begin
      a := dnodes.Get_Named_Item( dnodes.Attributes( n ), key );
      if( a /= null )then
      	-- Put_Line( "got attr("& key & ") as " & attrs.Value( a ));
         return attrs.Value( a );
      end if;
      return default;
   end Get_Attr_Value;
   
   function Get_Attr_Value( n : domc.Node; key : String; default : String := "" ) return Ada.Strings.Unbounded.Unbounded_String is
   begin
      return Ada.Strings.Unbounded.To_Unbounded_String( Get_Attr_Value( n, key, default ));
   end Get_Attr_Value;
 
   function Get_First_Element( doc : domc.Document ) return domc.Element is
      use domc;
      use dnodes;
      children :  domc.Node_List := Child_Nodes( doc );
      ds : Node;
   begin
      for cno in 1 .. dnodes.Length( children ) loop
         ds := dnodes.Item( children, cno - 1 );
         if( Node_Type( ds ) = Element_Node )then
            return ds;
         end if;
      end loop;
      return null;
   end Get_First_Element;

    
   function Get_Doc( filename : String; validate : Boolean := False ) return domc.Document is
      doc : domc.Document;
      input : isf.File_Input;
      reader : domr.Tree_Reader;
      
   begin
      isf.Set_Public_Id( input, filename );
      isf.Open( filename, input );
      domr.Set_Feature( reader, saxr.Validation_Feature, validate );
      domr.Parse( reader, input );
      isf.Close( input );
      doc := domr.Get_Tree( reader );
      return doc;   
   end Get_Doc;

end XML_Utils;
