with Text_Utils;
with Ada.Strings;
with GNAT.Regpat;

package body Line_Extractor is

   use Text_Utils;
   
   DELIMITER : Character := '.';
   
   procedure Set_Delimiter( del : Character ) is
   begin
      DELIMITER := del; 
   end Set_Delimiter;

   function Get_Delimiter return Character is
   begin
      return DELIMITER; 
   end Get_Delimiter;

   function Make_Key( prefix : String; k : String; postfix : String  := "" ) return String is -- fred[k].postfix
   use Ada.Strings;
      s : Unbounded_String := TuS( prefix );
   begin 
      if( k /= "" )then
         s := s & "[" & k & "]";
      end if;
      if( postfix /= "" )then
         s := s & DELIMITER & postfix;
      end if;
      return TS( s );
   end Make_Key;

   function Make_Key( prefix : Unbounded_String; k : Unbounded_String; postfix : Unbounded_String  := Null_Unbounded_String ) return Unbounded_String is  -- fred[k].postfix
     s : Unbounded_String := prefix;
   begin 
      if( k /= Null_Unbounded_String )then
         s := s & "[" & k & "]";
      end if;
      if( postfix /= Null_Unbounded_String )then
         s := s & DELIMITER & postfix;
      end if;
      return s;
   end Make_Key;
   
   function Make_Key( prefix : Unbounded_String; count : Natural := 0; postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String is
      use Ada.Strings;
      s : Unbounded_String := prefix;
   begin 
      if( count > 0 )then
         s := s & "[" & Trim( TuS(Positive'Image( count )), Both ) & "]";
      end if;
      if( postfix /= Null_Unbounded_String )then
         s := s & DELIMITER & postfix;
      end if;
      return s;
   end Make_Key;

   function Make_Key_With_Year( 
      year_prefix : Unbounded_String;
      year : Year_Number;       
      prefix : Unbounded_String; 
      count : Natural := 0; 
      postfix : Unbounded_String := Null_Unbounded_String ) return Unbounded_String is
      use Ada.Strings;
      s : Unbounded_String := year_prefix;
   begin 
      s := s & "[" & Trim( TuS(Year_Number'Image( year )), Both ) & "]" & DELIMITER & prefix;
      
      if( count > 0 )then
         s := s & "[" & Trim( TuS(Positive'Image( count )), Both ) & "]";
      end if;
      if( postfix /= Null_Unbounded_String )then
         s := s & DELIMITER & postfix;
      end if;
      return s;
   end Make_Key_With_Year;
   
   function Make_Key_With_Year(
      year_prefix : String;
      year        : Year_Number;          
      prefix      : String; 
      count       : Natural := 0; 
      postfix     : String  := "" ) return String is
   begin
      return TS( Make_Key_With_Year( TuS( year_prefix ), year, Tus( prefix ), count, TuS( postfix )));
   end Make_Key_With_Year;

   function Make_Key( prefix : String; count : Natural := 0; postfix : String  := "" ) return String is
   begin
      return TS( Make_Key( Tus( prefix ), count, TuS( postfix )));
   end Make_Key;

   function Extract_Key( s : Unbounded_String ) return Unbounded_String is
      p : Natural; 
   begin
      p := Index( s, SEPARATOR );
      if( p = 0 ) then
         return MISSING;
      end if;
      return Unbounded_Slice( s, 1, p-1 );
   end Extract_Key;
   
   function Extract_Value( s : Unbounded_String ) return Unbounded_String is
      p : Natural; 
   begin
      p := Index( s, SEPARATOR );
      if( p = 0 ) then
         return MISSING;
      end if;
      return Unbounded_Slice( s, p+1, Length( s )-1 );
   end Extract_Value;
   
   procedure Strip_Escapes( s : in out Unbounded_String ) is
      p : Natural := 0;
   begin
      if( Length( s ) > 0 ) then
         loop
            p := p + 1;
            if( Element( s, p ) = '\' ) and ( p < Length( s ) ) and ( Element( s, p+1 ) /= '\' ) then
               Delete( s, p, p );
               -- p := p + 1;
            end if;
            exit when (p >= Length( s )-1);
         end loop;
         if( Element( s, Length( s )) = '\' ) then
            Delete( s, Length( s ), Length( s ) );
         end if;
      end if;
   end Strip_Escapes;
   
   function Last_Character( s : Unbounded_String ) return Character is
      l : Natural := Length( s );
   begin
      if( l = 0 ) then
         return ' ';
      end if;
      return Element( s, l );
   end  Last_Character;
   
   function Comment_Position( s : Unbounded_String ) return Natural is
      p : Natural := 1;
      l : Natural := Length( s );
      ch : Character;
   begin
      if( l = 0 ) then
         return 0;
      end if;
      loop
         ch := Element( s, p );
         if( ch = '\' ) then -- escape character
            p := p + 1;
         elsif ( ch = '#' ) then
            return p;
         end if;
         p := p + 1;
         exit when( p > l );
      end loop;
      return 0;
   end Comment_Position;
   
   procedure Delete_After_Comment( s : in out Unbounded_String ) is
      p : Natural := Comment_Position( s );
      l : Natural := Length( s );
   begin
   
      if( p > 1 ) then
         s := Unbounded_Slice( s, 1, p-1 );
      elsif( p = 1 ) and ( l = 1 ) then
         s := To_Unbounded_String( "" );      
      end if;
   end Delete_After_Comment;
   
   procedure Parse_Indexed_Key( 
      key             : in Unbounded_String;
      is_indexed_key  : out Boolean;
      base_key        : out Unbounded_String;
      index           : out Natural;
      postfix         : out Unbounded_String ) is
   use GNAT.Regpat;
      REGEXP  : constant String := "(.*)\[ *([0-9]+) *\]\.(.+)";
      matches : Match_Array( 0 .. 3 );
      matcher : Pattern_Matcher := Compile( REGEXP );
      pos     : Natural;
      skey    : String := To_String( key );
   begin
      if( Match( matcher, skey ) > 0 )then
         Match( matcher, skey, matches );
         is_indexed_key := True;
         base_key := To_Unbounded_String( skey( matches( 1 ).first ..  matches( 1 ).last ));
         index    := Natural'Value( skey( matches( 2 ).first ..  matches( 2 ).last )); 
         postfix  := To_Unbounded_String( skey( matches( 3 ).first ..  matches( 3 ).last ));
      else
         is_indexed_key := False;
         index := 0;
         postfix := Null_Unbounded_String;
         base_key := key;
      end if;
   end Parse_Indexed_Key;
   
   procedure Parse_By_Year_Indexed_Key( 
      key             : in Unbounded_String;
      year_prefix     : out Unbounded_String;
      has_year        : out Boolean;
      year            : out Year_Number;
      base_key        : out Unbounded_String;
      is_indexed_key  : out Boolean;
      index           : out Unbounded_String;
      postfix         : out Unbounded_String ) is
   use GNAT.Regpat;
      YEAR_ONLY_REGEXP       : constant String := "(.*)\[ *([0-9]+) *\]\.(.+)"; -- fred[1922].stuff
      YEAR_AND_INDEX_REGEXP  : constant String := "(.*)\[ *([0-9]{4}) *\]\.(.*)\[ *([0-9]+) *\]\.(.+)"; -- fred[1922].stuff[22].morestuff
      
      year_and_index_matcher : Pattern_Matcher := Compile( YEAR_AND_INDEX_REGEXP );
      year_matcher : Pattern_Matcher := Compile( YEAR_ONLY_REGEXP );
      pos     : Natural;
      skey    : String := To_String( key );
   begin
      if( Match( year_and_index_matcher, skey ) > 0 )then
         declare
            matches : Match_Array( 0 .. 5 );
         begin
            Match( year_and_index_matcher, skey, matches );
            is_indexed_key := True;
            year_prefix  := To_Unbounded_String( skey( matches( 1 ).first ..  matches( 1 ).last ));
            year     := Year_Number'Value( skey( matches( 2 ).first ..  matches( 2 ).last )); 
            base_key := To_Unbounded_String( skey( matches( 3 ).first ..  matches( 3 ).last ));
            index    := To_Unbounded_String( skey( matches( 4 ).first ..  matches( 4 ).last )); 
            postfix  := To_Unbounded_String( skey( matches( 5 ).first ..  matches( 5 ).last ));
            has_year := True;
         end;
      elsif( Match( year_matcher, skey ) > 0 )then
         declare
            matches : Match_Array( 0 .. 3 );
         begin
            Match( year_matcher, skey, matches );
            year_prefix := To_Unbounded_String( skey( matches( 1 ).first ..  matches( 1 ).last ));
            year     :=Year_Number'Value( skey( matches( 2 ).first ..  matches( 2 ).last )); 
            base_key  := To_Unbounded_String( skey( matches( 3 ).first ..  matches( 3 ).last ));
            is_indexed_key := False;
            postfix := Null_Unbounded_String;
         end;
         is_indexed_key := False;
         has_year := True;
         index := Null_Unbounded_String;
      else
         year := Year_Number'First;
         index :=  Null_Unbounded_String;
         has_year := False;
         postfix := Null_Unbounded_String;
         year_prefix := Null_Unbounded_String;
         base_key := key;
         is_indexed_key := False;
      end if;
   end Parse_By_Year_Indexed_Key;

   procedure Parse_By_Year_Indexed_Key( 
      key             : in Unbounded_String;
      year_prefix     : out Unbounded_String;
      has_year        : out Boolean;
      year            : out Year_Number;
      base_key        : out Unbounded_String;
      is_indexed_key  : out Boolean;
      index           : out Natural;
      postfix         : out Unbounded_String ) is
      iss : Unbounded_String;
   begin
      Parse_By_Year_Indexed_Key( 
         year_prefix     => year_prefix,
         key             => key,
         has_year        => has_year,
         year            => year,
         base_key        => base_key,
         is_indexed_key  => is_indexed_key,
         index           => iss,
         postfix         => postfix );
      if( is_indexed_key )then
         index := Natural'Value( TS( iss ));
      else
         index := 0;
      end if;
   end Parse_By_Year_Indexed_Key;
   
end Line_Extractor;
