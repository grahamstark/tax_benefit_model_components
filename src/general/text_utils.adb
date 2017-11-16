with Ada.Strings.Maps;
with Ada.Strings.Fixed;
with Ada.Strings.Hash;  
with Ada.Characters.Handling;
with Ada.Text_IO.Unbounded_IO;
with Ada.Text_IO;

package body Text_Utils is
  
   use Ada.Strings;
   use Ada.Strings.Maps;
   use Ada.Strings.Fixed;
   use Ada.Strings.Unbounded;
   use Ada.Characters.Handling;
   package st    renames Ada.Strings;
  
   NASTY_REPLACE : constant Character_Mapping := To_Mapping( " ,&+()[]!:#.-", 
                                                    "_____________" );
                                                    
   INVALID_ID_REPLACE : constant Character_Mapping := To_Mapping( "[]", "XY" );
   INVALID_ID_INSERT  : constant Character_Mapping := To_Mapping( "XY", "[]" );
   
   function Split( s : String; sep : Character ) return Unbounded_String_List is
   use Unbounded_String_Vector_Package;
      l : Unbounded_String_List;
      start : Positive := s'First;
      ts : String := Trim( s, ""&sep );
   begin
      for p in ts'Range loop
         if( ts(p) = sep )then
            declare
               tok : String := ts( start .. p-1 ); 
            begin
               if( tok'Length > 0 )then -- skip all blanks
                  l.Append( ustr.To_Unbounded_String( tok ));
               end if;
            end;
            start := p+1;
         end if;
      end loop;
      if( start < s'Last ) then
         l.Append( ustr.To_Unbounded_String( ts( start .. ts'Last )));
      end if;
      return l;
   end Split;
   
   function Join( s : Unbounded_String_List; sep : Character ) return String is
      l : Unbounded_String;
      n : constant Natural := Natural( s.length );
   begin
      -- l := l & sep;
      for i in 1 .. n loop
         l := l & s.Element( i );
         if( i < n )then
            l := l & sep;
         end if;
      end loop;
      return TS( l );
   end Join;

   procedure Add_To( l : in out Unbounded_String_List; item : String ) is
   begin
      l.Append( TuS( item ));
   end Add_To;
   
   function Get( l : Unbounded_String_List; which : Positive ) return String is
   begin
      return TS( l.Element( which ));
   end Get;
   
   function Get( this : Unbounded_String_Map; key : String ) return String is
      uk : constant ustr.Unbounded_String := ustr.To_Unbounded_String( key );
   begin
      if( not this.Contains( uk ))then
         return "";
      end if;
      return ustr.To_String( this.Element( uk ));
   end Get;
   
   procedure Add_To( this : in out Unbounded_String_Map; key : String; value : String ) is
   begin
      this.Insert( TuS( key ), TuS( value ));
   end Add_To;
   
   function Trim( s : String; extra : String := "" ) return String is   
      TRIM_DELETE  : constant Character_Set := To_Set( " "  & extra & stda.HT & stda.CR & stda.LF & stda.VT );
   begin
      return Trim( s, TRIM_DELETE, TRIM_DELETE );
   end Trim;
   
   function Pad( s : String; to_len : Positive ) return String is
      t : String( 1 .. to_len );
   begin
      -- see (e.g): http://en.wikibooks.org/wiki/Ada_Programming/Strings
      Move(
         Source  => s,
         Target  => t,
         Drop    => st.Right,
         Justify => st.Left,
         Pad     => st.Space );
      return t;
   end Pad;
   
   function Count_Of_Character( s : String; ch : Character ) return Natural is
      count : Natural := 0;
   begin
      for i in s'range loop
         if( s(i) = ch ) then count := count + 1; end if;
      end loop;
      return count;
   end Count_Of_Character;
   
   function Delete_All_Instances( s : String; target : String ) return String is
      us : Unbounded_String := To_Unbounded_String( s );
      pos : Natural;
      len : constant Natural := target'Length;
   begin
      loop
         pos := Index( us, target );
         if( pos > 0 )then
            Delete( us, pos, pos+len-1 );
         end if;
         exit when( pos = 0 );
      end loop;
      return To_String( us );
   end Delete_All_Instances;
   
   function Replace_In_String( s : String; was : String; to : String ) return String is
   --
   -- also trims leading & trailing blanks
   -- 
      outs : String( s'First .. s'Last ) := s;
      REPLACEMENTS : constant Character_Mapping := To_Mapping( was, to );
   begin        
      return Translate( Trim( outs, Both ), REPLACEMENTS );        
   end Replace_In_String;   

   function Replace_In_Unbounded_String( s : Unbounded_String; was : String; to : String ) return Unbounded_String is
   --
   -- also trims leading & trailing blanks
   -- 
      outs : Unbounded_String := s;
      REPLACEMENTS : constant Character_Mapping := To_Mapping( was, to );
   begin        
      return Translate( Trim( outs, Both ), REPLACEMENTS );        
   end Replace_In_Unbounded_String;   
   
   function Censor_String( s : String ) return String is
      outs : String( s'First .. s'Last ) := s;
   begin        
      return To_Lower(Translate( Trim( outs, Both ), NASTY_REPLACE ));        
   end Censor_String;   
   
   function Censor_String( s : Unbounded_String ) return Unbounded_String is
      outs : Unbounded_String := s;
   begin
      return TuS(To_Lower(TS(Translate( Trim( outs, Both ), NASTY_REPLACE )))); 
   end Censor_String;
   
   --
   -- [ => 'X' and ] => 'Y'
   --
   function Censor_Id( index_key :Unbounded_String ) return Unbounded_String is   
   begin
      return TuS( TS(Translate( Trim( index_key, Both ), INVALID_ID_REPLACE ))); 
   end Censor_Id;
 
   function Censor_Id( index_key : String ) return String is 
   begin
      return Translate( Trim( index_key, Both ), INVALID_ID_REPLACE ); 
   end Censor_Id;
   
   function UnCensor_Id( index_key :Unbounded_String ) return Unbounded_String is 
   begin
      return TuS( TS( Translate( Trim( index_key, Both ), INVALID_ID_INSERT ))); 
   end UnCensor_Id;

   function UnCensor_Id( index_key : String ) return String is 
   begin
      return Translate( Trim( index_key, Both ), INVALID_ID_INSERT ); 
   end UnCensor_Id;
  
   function Indent( n : Natural; indent_size : Natural := 3 ) return String is
   begin
      return ( indent_size * n ) * ' ';
   end Indent;
   
   function Compare_String( left, right : ustr.Unbounded_String ) return Boolean is
   begin
      return left = right;
   end Compare_String;
   
   function Hash_String( s : ustr.Unbounded_String ) return Ada.Containers.Hash_Type is
   begin
      return Ada.Strings.Hash( To_String( s ));
   end Hash_String;
   
   procedure Write_Whole_File( filename: String; content : ustr.Unbounded_String ) is
      use Ada.Text_IO;
      f : File_Type;
   begin
      Create( f, Out_File, filename );
      Ada.Text_IO.Unbounded_IO.Put_Line( f, content );
      Close( f );
   end Write_Whole_File; 
   
   function Read_Whole_File( filename : String ) return Unbounded_String is
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
      s : Unbounded_String := To_Unbounded_String( "" );
      line : Unbounded_String;
      file : Ada.Text_IO.File_Type;
   begin
      Open( file, In_File, filename );
      loop
         exit when End_Of_File( file );
         line := Ada.Text_IO.Unbounded_IO.Get_Line( file );
         s := s & line;
         s := s & LINE_BREAK;
      end loop;   
      Close( file );         
      return s;
    end Read_Whole_File;
    
    function Join( l : Unbounded_String_List; delim : String := TAB ) return String is
       use Unbounded_String_Vector_Package;
       s : Unbounded_String;
       
       procedure Print_One( c : Cursor ) is
       begin
          s := s & Element( c );
          if c /= l.Last then
             s := s & delim;
          end if;
       end Print_One;
       
    begin
        Iterate( l, Print_One'Access );
        return TS( s );
    end Join;
    
    function To_One_String( l : Unbounded_String_List ) return String is
       use Unbounded_String_Vector_Package;
       s : Unbounded_String;
       i : Natural := 0;
       
       procedure Print_One( c : Cursor ) is
          v : Unbounded_String := Element( c );
       begin          
          i := i + 1;
          s := s & i'Img & "= |" & v & "| " & LINE_BREAK;
       end Print_One;
       
     begin
        Iterate( l, Print_One'Access );
        return TS( s );
     end To_One_String;
    
    function To_String( this : Unbounded_String_Map ) return String is
       use String_Maps_Package;
       s : Unbounded_String;
       
       procedure Print_One( c : Cursor ) is
          k : Unbounded_String := Key( c );
          v : Unbounded_String := Element( c );
       begin          
          s := s & k & "=" & v & LINE_BREAK;
       end Print_One;
       
     begin
        Iterate( this, Print_One'Access );
        return TS( s );
     end To_String;

   --
   -- e.g. COUNCIL_HOUSE => Council House
   --   
   function Prettify_Image( s : String ) return String is
      ss : String := Replace_In_String( To_Lower( s ), "_", " " );  
   begin
      ss( 1 ) := To_Upper( ss( 1 ));
      for i in 2 .. ss'Length loop
         if( ss( i-1 ) = ' ' and ss( i ) /= ' ' )then
            ss( i ) := To_Upper( ss( i ));
         end if;
      end loop;
      return ss;
   end Prettify_Image;
 
end Text_Utils;
