with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Line_Extractor;
with Ada.Calendar;
with Keyed_Text_Buffer;

generic
   --
   -- This; the floating type we use throughout. 
   --
   type Real_Type is digits<>;
   --
   --
   --
   type Counter_Type is delta<> digits<>;
   
package Key_Value_IO is
   
   subtype File_Type is Ada.Text_IO.File_Type;
   
   use Ada.Strings.Unbounded;
   use Line_Extractor;
   use Ada.Calendar;
   use Keyed_Text_Buffer;
   
   type Real_Key_Pair is record
      key : Unbounded_String;
      value : Real_Type;
   end record;
   
   type Counter_Key_Pair is record   
      key : Unbounded_String;
      value : Counter_Type;
   end record;
   
   type Integer_Key_Pair is record   
      key : Unbounded_String;
      value : Integer;
   end record;
   
   type String_Key_Pair is record   
      key : Unbounded_String;
      value : Unbounded_String;
   end record;
   
   type Boolean_Key_Pair is record   
      key : Unbounded_String;
      value : Boolean;
   end record;
   
   type Time_Key_Pair is record   
      key : Unbounded_String;
      value : Time;
   end record;
   
   
   
   function Extract( from : String; key : String ) return Real_Key_Pair;
   function Extract( from : String; key : String ) return Counter_Key_Pair;
   function Extract( from : String; key : String ) return Integer_Key_Pair;
   function Extract( from : String; key : String ) return String_Key_Pair;
   function Extract( from : String; key : String ) return Boolean_Key_Pair;

   
   function Read( f : File_Type; key : Unbounded_String ) return Real_Type;
   function Read( f : File_Type; key : Unbounded_String ) return Counter_Type;
   function Read( f : File_Type; key : Unbounded_String ) return Integer;
   function Read( f : File_Type; key : Unbounded_String ) return Unbounded_String;
   function Read( f : File_Type; key : Unbounded_String ) return String;
   function Read( f : File_Type; key : Unbounded_String ) return Boolean;
   function Read( f : File_Type; key : Unbounded_String ) return Time;

   function Read( f : File_Type; key : String ) return Real_Type;
   function Read( f : File_Type; key : String ) return Counter_Type;
   function Read( f : File_Type; key : String ) return Integer;
   function Read( f : File_Type; key : String ) return String;
   function Read( f : File_Type; key : String ) return Unbounded_String;
   function Read( f : File_Type; key : String ) return Boolean;
   function Read( f : File_Type; key : String ) return Time;

   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Real_Type;
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Counter_Type;
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Integer;
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Unbounded_String;
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return String;
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Boolean;
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Time;

   function Read( kvb : Text_Buffer; key : String ) return Real_Type;
   function Read( kvb : Text_Buffer; key : String ) return Counter_Type;
   function Read( kvb : Text_Buffer; key : String ) return Integer;
   function Read( kvb : Text_Buffer; key : String ) return String;
   function Read( kvb : Text_Buffer; key : String ) return Unbounded_String;
   function Read( kvb : Text_Buffer; key : String ) return Boolean;
   function Read( kvb : Text_Buffer; key : String ) return Time;

   
   procedure Write( f : File_Type; key : Unbounded_String; value : Real_Type );
   procedure Write( f : File_Type; key : Unbounded_String; value : Counter_Type );
   procedure Write( f : File_Type; key : Unbounded_String; value : Integer );
   procedure Write( f : File_Type; key : Unbounded_String; value : Unbounded_String );
   procedure Write( f : File_Type; key : Unbounded_String; value : String );
   procedure Write( f : File_Type; key : Unbounded_String; value : Boolean );
   procedure Write( f : File_Type; key : Unbounded_String; value : Time );

   procedure Write( f : File_Type; key : String; value : Real_Type );
   procedure Write( f : File_Type; key : String; value : Counter_Type );
   procedure Write( f : File_Type; key : String; value : Integer );
   procedure Write( f : File_Type; key : String; value : String );
   procedure Write( f : File_Type; key : String; value : Unbounded_String );
   procedure Write( f : File_Type; key : String; value : Boolean );
   procedure Write( f : File_Type; key : String; value : Time );

   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Real_Type );
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Counter_Type );
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Integer );
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Unbounded_String );
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : String );
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Boolean );
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Time );

   procedure Write( kvb : in out Text_Buffer; key : String; value : Real_Type );
   procedure Write( kvb : in out Text_Buffer; key : String; value : Counter_Type );
   procedure Write( kvb : in out Text_Buffer; key : String; value : Integer );
   procedure Write( kvb : in out Text_Buffer; key : String; value : String );
   procedure Write( kvb : in out Text_Buffer; key : String; value : Unbounded_String );
   procedure Write( kvb : in out Text_Buffer; key : String; value : Boolean );
   procedure Write( kvb : in out Text_Buffer; key : String; value : Time );


   
   KV_Exception : exception;
    
   generic
   
      type Enum_Type is (<>);
      
   package Enum_Key_Value_IO is
   
      type Enum_Key_Pair is record   
         key : Unbounded_String;
         value : Enum_Type;
      end record;
 
   
      function Read( f : File_Type; key : Unbounded_String ) return Enum_Type;
      function Read( f : File_Type; key : String ) return Enum_Type;
      procedure Write( f : File_Type; key : Unbounded_String; value : Enum_Type );
      procedure Write( f : File_Type; key : String; value : Enum_Type );
      procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Enum_Type );
      procedure Write( kvb : in out Text_Buffer; key : String; value : Enum_Type );
      
   end Enum_Key_Value_IO;

end Key_Value_IO;
