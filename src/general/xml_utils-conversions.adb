with Format_Utils;
with Text_Utils;
with Ada.Characters.Handling;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Text_IO;
with GNATColl.Traces;

package body XML_Utils.Conversions is
 
   package Format_Default is new Format_Utils( Float_Type=>Float_Type, Counter_Type => Counter_Type );

   use Format_Default;
   use Text_Utils;
   use Ada.Text_IO;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "XML_UTILS.Conversions" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   function Get_Attr_Value( n : domc.Node; key : String; default : Integer := 0 ) return Integer is
      use Ada.Characters.Handling;
      use Ada.Strings.Fixed;
      use Ada.Strings;
      v : constant String := Get_Attr_Value( n, key, Integer'Image( default ));
      s : constant String := Trim( v, Both );
   begin
      return Integer'Value( s );
   end Get_Attr_Value;
   
   function Get_Attr_Value( n : domc.Node; key : String; default : Float_Type := 0.0 ) return Float_Type is
       v : constant String := Get_Attr_Value( n, key,  Float_Type'Image( default ));
   begin
      Log( "Get_Attr_Value(Float); input string is |" & v & "|" ); 
      return Lenient_Convert( v );
   end Get_Attr_Value;
   
   function Get_Attr_Value( n : domc.Node; key : String; default : Boolean := False ) return Boolean is
      use Ada.Characters.Handling;
      use Ada.Strings.Fixed;
      use Ada.Strings;
      v : constant String := Get_Attr_Value( n, key, Trim( Boolean'Image( default ), both ));
      s : constant String := To_Upper( Trim( v, Both ));
      b : Boolean;
   begin
      Log( "Get_Attr_Value; boolean; got s as |" & s & "|" );
      b := ( s = "1" )  or ( s = "TRUE" ) or ( s = "YES" ) or ( s = "ON" );
      return b;
   end Get_Attr_Value;
   
   function Get_Attr_Value( n : domc.Node; key : String; default : Counter_Type := 0.0 ) return Counter_Type is
       v : constant String := Get_Attr_Value( n, key, Format( default ));
   begin
      return Lenient_Convert( v );
   end Get_Attr_Value;
   
end XML_Utils.Conversions;
