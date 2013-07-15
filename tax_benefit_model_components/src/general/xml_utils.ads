with Sax.Readers;     
with DOM.Readers;     
with DOM.Core;  
with DOM.Core.Documents;    
with DOM.Core.Nodes;
with DOM.Core.Attrs;
with DOM.Core.Elements;
with Input_Sources.File;
with McKae.XML.XPath.XIA;
with Ada.Strings.Unbounded;

package XML_Utils is

   package docs    renames DOM.Core.Documents;
   package attrs   renames DOM.Core.Attrs;
   package domr    renames DOM.Readers; 
   package saxr    renames  Sax.Readers;
   package dnodes  renames DOM.Core.Nodes;
   package delems  renames DOM.Core.Elements;
   package domc    renames DOM.Core;
   package isf     renames Input_Sources.File;
   package xp      renames McKae.XML.XPath.XIA;

   function Get_Attr_Value( n : domc.Node; key : String; default : String := "" ) return String;
   function Get_Attr_Value( n : domc.Node; key : String; default : String := "" ) return Ada.Strings.Unbounded.Unbounded_String;
   function Get_First_Element( doc : domc.Document ) return domc.Element;
   function Get_Doc( filename : String; validate : Boolean := False ) return domc.Document;
   function To_String( node : domc.Node ) return String;
   function To_String( node : domc.Node ) return Ada.Strings.Unbounded.Unbounded_String;
   
end XML_Utils;
