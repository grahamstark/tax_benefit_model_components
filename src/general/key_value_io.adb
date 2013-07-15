with Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;
with Ada.Strings;
with Text_Utils;
with Format_Utils;
with Ada.Exceptions;  use Ada.Exceptions;
with Ada.Calendar.Formatting;

package body Key_Value_IO is

   use Ada.Strings.Unbounded.Text_IO;
   use Ada.Strings;
   use Text_Utils;
   
  
   package Local_Format_Utils is new Format_Utils( Float_Type=>Real_Type, Counter_Type=>Counter_Type );
   use Local_Format_Utils;

 
   function Extract( from : Unbounded_String; key : Unbounded_String ) return String_Key_Pair is
      kv : String_Key_Pair;
   begin
      kv.key := Extract_Key( from );
      -- Ada.Text_IO.put_line( "from " & TS( from ) & " kv.key " & TS(kv.key) & " key " & TS(key) );
      if( kv.key /= key ) then
         Raise_Exception( KV_Exception'Identity, "key |" & TS(key) & " not found in string |" & TS(from) & "|" );
         -- Ada.Text_IO.put_line( "replaced key with " & TS( kv.key ));
      end if;
      kv.value := Extract_Value( from );
      return kv;
   end Extract;
 
   
   function Extract( from : Unbounded_String; key : Unbounded_String ) return Real_Key_Pair is
      kv : Real_Key_Pair := ( MISSING, -1.0 );
      ks : String_Key_Pair := Extract( from, key );
   begin
      if( ks.key = MISSING ) then
         Raise_Exception( KV_Exception'Identity, "key |" & TS(key) & " not found in string |" & TS(from) & "|" );
      end if;
      kv.key := ks.key;
      kv.value := Lenient_Convert( TS(ks.value) );
      return kv;
   end Extract;
   
   function Extract( from : Unbounded_String; key : Unbounded_String ) return Counter_Key_Pair is
      kv : Counter_Key_Pair := ( MISSING, -1.0 );
      ks : String_Key_Pair := Extract( from, key );
   begin
      if( ks.key = MISSING ) then
         Raise_Exception( KV_Exception'Identity, "key |" & TS(key) & " not found in string |" & TS(from) & "|" );
      end if;
      kv.key := ks.key;
      kv.value := Lenient_Convert( TS(ks.value) );
      return kv;
   end Extract;
   
   function Extract( from : Unbounded_String; key : Unbounded_String ) return Integer_Key_Pair is
      kv : Integer_Key_Pair := ( MISSING, -1 );
      ks : String_Key_Pair := Extract( from, key );
   begin
      if( ks.key = MISSING ) then
         Raise_Exception( KV_Exception'Identity, "key |" & TS(key) & " not found in string |" & TS(from) & "|" );
      end if;
      kv.key := ks.key;
      kv.value := Integer'Value( TS(ks.value) );
      return kv;
   end Extract;
   
   function Extract( from : Unbounded_String; key : Unbounded_String ) return Boolean_Key_Pair is
      kv : Boolean_Key_Pair := ( MISSING, False );
      ks : String_Key_Pair := Extract( from, key );
   begin
      if( ks.key = MISSING ) then
         Raise_Exception( KV_Exception'Identity, "key |" & TS(key) & " not found in string |" & TS(from) & "|" );
      end if;
      kv.key := ks.key;
      kv.value := Boolean'Value( TS(ks.value) );
      return kv;
   end Extract;
   
   function Extract( from : Unbounded_String; key : Unbounded_String ) return Time_Key_Pair is
      kv : Time_Key_Pair := ( MISSING, Time_Of( Year_Number'First, Month_Number'First, Day_Number'First, Day_Duration'First ));
      ks : String_Key_Pair := Extract( from, key );
   begin
      if( ks.key = MISSING ) then
         Raise_Exception( KV_Exception'Identity, "key |" & TS(key) & " not found in string |" & TS(from) & "|" );
      end if;
      kv.key := ks.key;
      kv.value := Ada.Calendar.Formatting.Value( TS( ks.value ));
      return kv;
   end Extract;
   
   
   function Extract( from : String; key : String ) return Real_Key_Pair is
   begin
      return Extract( TuS( from ), TuS( key ));
   end Extract;
   
   function Extract( from : String; key : String ) return Counter_Key_Pair is
   begin
      return Extract( TuS( from ), TuS( key ));
   end Extract;
   
   function Extract( from : String; key : String ) return Integer_Key_Pair is
   begin
      return Extract( TuS( from ), TuS( key ));
   end Extract;
   
   function Extract( from : String; key : String ) return String_Key_Pair is
   begin
      return Extract( TuS( from ), TuS( key ));
   end Extract;

   function Extract( from : String; key : String ) return Boolean_Key_Pair is
   begin
      return Extract( TuS( from ), TuS( key ));
   end Extract;
   
   function Read( f : File_Type; key : Unbounded_String ) return Real_Type is
      s  : Unbounded_String;
      kv : Real_Key_Pair;
   begin
      Get_Line( f, s );      
      kv := Extract( s, key );
      return kv.value;
   end Read;
   
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Unbounded_String is
   begin
      return kvb.Element( key );
   end Read;
   
   function Read( kvb : Text_Buffer; key : String ) return Unbounded_String is
   begin
      return Read( kvb, TuS( key ));
   end Read;
   
   function Read( kvb : Text_Buffer; key : String ) return String is
   begin
      return TS( Read( kvb, TuS( key )));
   end Read;
   
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return String is
   begin
      return TS( Read( kvb, key ));
   end Read;
   
   function Read( kvb : Text_Buffer; key : String ) return Time is
      s  : String := Read( kvb, key );
   begin
      return Ada.Calendar.Formatting.Value( s );
   end Read;
   
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Time is
      s  : String := Read( kvb, key );
   begin
      return Ada.Calendar.Formatting.Value( s );
   end Read;
   
   function Read( kvb : Text_Buffer; key : String ) return Real_Type is
      s  : String := Read( kvb, key );
   begin
      return Lenient_Convert( s );
   end Read;

   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Real_Type is
      s  : String := Read( kvb, key );
   begin
      return Lenient_Convert( s );
   end Read;
   
   function Read( kvb : Text_Buffer; key : String ) return Counter_Type is
      s  : String := Read( kvb, key );
   begin
      return Counter_Type'Value( s );
   end Read;

   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Counter_Type is
      s  : String := Read( kvb, key );
   begin
      return Counter_Type'Value( s );
   end Read;

   function Read( kvb : Text_Buffer; key : String ) return Integer is
      s  : String := Read( kvb, key );
   begin
      return Integer'Value( s );
   end Read;
   
   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Integer is
      s  : String := Read( kvb, key );
   begin
      return Integer'Value( s );
   end Read;

   function Read( kvb : Text_Buffer; key : String ) return Boolean is
      s  : String := Read( kvb, key );
   begin
      return Boolean'Value( s );
   end Read;

   function Read( kvb : Text_Buffer; key : Unbounded_String ) return Boolean is
      s  : String := Read( kvb, key );
   begin
      return Boolean'Value( s );
   end Read;
   

   function Read( f : File_Type; key : Unbounded_String ) return Time is
      s  : Unbounded_String;
      kv : Time_Key_Pair;
   begin
      Get_Line( f, s );      
      kv := Extract( s, key );
      return kv.value;
   end Read;
   
   function Read( f : File_Type; key : Unbounded_String ) return Integer is
      kv : Integer_Key_Pair;
      s  : Unbounded_String;
   begin
      Get_Line( f, s );      
      kv := Extract( s, key );
      return kv.value;
   end Read;   

   function Read( f : File_Type; key : Unbounded_String ) return Counter_Type is
      s  : Unbounded_String;
      kv : Counter_Key_Pair;
   begin
      Get_Line( f, s );      
      kv := Extract( s, key );
      return kv.value;
   end Read;   


   function Read( f : File_Type; key : Unbounded_String ) return Unbounded_String is
      s  : Unbounded_String;
      kv : String_Key_Pair;
   begin
      Get_Line( f, s );      
      kv := Extract( s, key );
      return kv.value;
   end Read;
   
   function Read( f : File_Type; key : Unbounded_String ) return Boolean is
      s  : Unbounded_String;
      kv : Boolean_Key_Pair;
   begin
      Get_Line( f, s );      
      kv := Extract( s, key );
      return kv.value;
   end Read;
   
   function Read( f : File_Type; key : String ) return Real_Type is
   begin
      return Read( f, TuS( key ) );
   end Read;

   function Read( f : File_Type; key : String ) return Time is
   begin
      return Read( f, TuS( key ) );
   end Read;
   
   function Read( f : File_Type; key : String ) return Counter_Type is
   begin
      return Read( f, TuS( key ) );
   end Read;
   
   function Read( f : File_Type; key : String ) return Integer is
   begin
      return Read( f, TuS( key ) );
   end Read;
   
   function Read( f : File_Type; key : String ) return String is
      us : Unbounded_String := Read( f, TuS( key ) );
   begin
      return TS( us );
   end Read;

   function Read( f : File_Type; key : String ) return Boolean is
   begin
      return Read( f, TuS( key ) );
   end Read;
   
   function Read( f : File_Type; key : String ) return Unbounded_String is
   begin
      return Read( f, TuS( key ));
   end Read;

   function Read( f : File_Type; key : Unbounded_String ) return String is
   begin
      return TS( read( f, key ));
   end Read;
 
   procedure Write( f : File_Type; key : Unbounded_String; value : Real_Type ) is
   begin
      Write( f, key, TuS(Real_Type'Image( value )));
   end Write;

   procedure Write( f : File_Type; key : Unbounded_String; value : Time ) is
   begin
      Write( f, key, TuS( Ada.Calendar.Formatting.Image( value )));
   end Write;
   
   procedure Write( f : File_Type; key : Unbounded_String; value : String ) is
   begin
      Write( f, key, TuS( value ));
   end Write;

   procedure Write( f : File_Type; key : String; value : Unbounded_String ) is
   begin
      Write( f, TuS( key ), value );
   end Write;
   
   procedure Write( f : File_Type; key : Unbounded_String; value : Counter_Type ) is
   begin
      Write( f, key, TuS(Counter_Type'Image( value )));
   end Write;
   
   procedure Write( f : File_Type; key : Unbounded_String; value : Integer ) is
   begin
      Write( f, key, TuS(Integer'Image( value )));
   end Write;
   
   procedure Write( f : File_Type; key : Unbounded_String; value : Boolean ) is
   begin
      Write( f, key, TuS(Boolean'Image( value )));
   end Write;
   
   procedure Write( f : File_Type; key : Unbounded_String; value : Unbounded_String ) is
   begin
      Put_Line( f, Trim( key, Both ) & SEPARATOR & Trim( value , Both ) & TERMINATOR );
   end Write;
   
   procedure Write( f : File_Type; key : String; value : Real_Type ) is
   begin
      Write( f, TuS( key ), value );
   end Write;
   
   procedure Write( f : File_Type; key : String; value : Time ) is
   begin
      Write( f, key, TuS( Ada.Calendar.Formatting.Image( value )));   
   end Write;
   
   procedure Write( f : File_Type; key : String; value : Counter_Type )is
   begin
      Write( f, TuS( key ), value );
   end Write;
   
   procedure Write( f : File_Type; key : String; value : Integer ) is
   begin
      Write( f, TuS( key ), value );
   end Write;
   
   procedure Write( f : File_Type; key : String; value : Boolean ) is
   begin
      Write( f, TuS( key ), value );
   end Write;
   
   procedure Write( f : File_Type; key : String; value : String ) is
   begin
      Write( f, TuS( key ), TuS( value ) );
   end Write;



   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Unbounded_String ) is
   begin
      kvb.Insert( Trim( key, Both ), Trim( value , Both ));
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : String ) is
   begin
      Write( kvb, key, TuS( value ));
   end Write;

   procedure Write( kvb : in out Text_Buffer; key : String; value : Unbounded_String ) is
   begin
      Write( kvb, TuS( key ), value );
   end Write;

   procedure Write( kvb : in out Text_Buffer; key : String; value : String ) is
   begin
      Write( kvb, TuS( key ), TuS( value ));
   end Write;


   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Real_Type ) is
   begin
      Write( kvb, key, TuS(Real_Type'Image( value )));
   end Write;

   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Time ) is
   begin
      Write( kvb, key, TuS( Ada.Calendar.Formatting.Image( value )));
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Counter_Type ) is
   begin
      Write( kvb, key, TuS(Counter_Type'Image( value )));
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Integer ) is
   begin
      Write( kvb, key, TuS(Integer'Image( value )));
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Boolean ) is
   begin
      Write( kvb, key, TuS(Boolean'Image( value )));
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : String; value : Real_Type ) is
   begin
      Write( kvb, TuS( key ), value );
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : String; value : Time ) is
   begin
      Write( kvb, key, TuS( Ada.Calendar.Formatting.Image( value )));   
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : String; value : Counter_Type )is
   begin
      Write( kvb, TuS( key ), value );
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : String; value : Integer ) is
   begin
      Write( kvb, TuS( key ), value );
   end Write;
   
   procedure Write( kvb : in out Text_Buffer; key : String; value : Boolean ) is
   begin
      Write( kvb, TuS( key ), value );
   end Write;
   
   
   package body Enum_Key_Value_IO is
   
      function Extract( from : Unbounded_String; key : Unbounded_String ) return Enum_Key_Pair is
         kv : Enum_Key_Pair;
         ks : String_Key_Pair := Extract( from, key );
      begin
         if( ks.key = MISSING ) then
            return kv;
         end if;
         kv.key := ks.key;
         kv.value := Enum_Type'Value( TS(ks.value) );
         return kv;
      end Extract;
      
      function Read( f : File_Type; key : Unbounded_String ) return Enum_Type is
         s  : Unbounded_String;
         kv : Enum_Key_Pair;
      begin
         Get_Line( f, s );      
         kv := Extract( s, key );
         return kv.value;
      end Read;
      
      function Read( f : File_Type; key : String ) return Enum_Type is
      begin
         return Read( f, TuS( key ));
      end Read;
      
      procedure Write( f : File_Type; key : Unbounded_String; value : Enum_Type ) is
      begin
         Write( f, key, TuS(Enum_Type'Image( value )));
      end Write;
      
      procedure Write( f : File_Type; key : String; value : Enum_Type ) is
      begin
         Write( f, TuS( key ), value );
      end Write;

      procedure Write( kvb : in out Text_Buffer; key : Unbounded_String; value : Enum_Type ) is
      begin
         Write( kvb, key, TuS(Enum_Type'Image( value )));
      end Write;
      
      procedure Write( kvb : in out Text_Buffer; key : String; value : Enum_Type ) is
      begin
         Write( kvb, TuS( key ), value );
      end Write;
    
   end Enum_Key_Value_IO;

end Key_Value_IO;
