with Ada.Text_IO;
with Line_Extractor;
with Ada.Text_IO.Unbounded_IO;
with Line_Extractor;
with Ada.Strings.Unbounded.Text_IO;

package body Keyed_Text_Buffer is
   
   use Line_Extractor;
   
   procedure Merge( to : in out Text_Buffer; to_add : Text_Buffer ) is
      
      use Text_Utils.String_Maps_Package;
      
      procedure Add( c : Cursor ) is
         new_pos : Cursor;
         inserted : Boolean;
      begin
         to.Insert( Key( c ), Element( c ), new_pos, inserted );
      end Add;
      
   begin
      to_add.Iterate( Add'Access );
   end Merge;
   
   function Parse( data : String; sep : Character ) return Text_Buffer is
   use Text_Utils;
      key, value   : Unbounded_String;
      buffer       : Text_Buffer;
      list         : Unbounded_String_List := Split( data, sep );
      n            : Natural := Natural( list.Length );
      line         : Unbounded_String;
      eq_pos       : Natural;
      line_length  : Natural;
   begin
      for i in 1 .. n loop
         line := list.Element( i );
         line_length := Length( line );
         if( line_length > 2 ) then -- smallest you could have: "a=b"
            eq_pos := Index( line, "=" );
            if( eq_pos > 1 ) then
               key := Trim(Unbounded_Slice( line, 1, eq_pos - 1 ), Ada.Strings.Both);
               value := Trim(Unbounded_Slice( line, eq_pos + 1, line_length ), Ada.Strings.Both );
               if( Length( Key ) > 0 ) and ( Length( value ) > 0 ) then
                  buffer.Include( key, value ); -- this replaces dups
               end if;
            end if;
         end if;
      end loop;
      return buffer;      
   end Parse;
   
   function Parse( data : Unbounded_String; sep : Character ) return Text_Buffer is
   begin
      return Parse( To_String( data ), sep );
   end Parse;
   
   function Load_Multiline( filename : String ) return Text_Buffer is
      
      package usut renames Ada.Strings.Unbounded.Text_IO;
      
      in_file      : Ada.Text_IO.File_Type;
      this_line, 
      line         : Unbounded_String := To_Unbounded_String( "" );
      eq_pos       : Natural;
      line_length  : Natural;
      key, value   : Unbounded_String;
      buffer       : Text_Buffer;
   begin
      Ada.Text_IO.Open( in_file, Ada.Text_IO.In_File, filename );
      while not( Ada.Text_IO.End_Of_File( in_file ) ) loop
         loop
            usut.Get_Line( in_file, this_line );
            Trim( this_line, Ada.Strings.Both );
            Delete_After_Comment( this_line );            
            line := line & this_line;
            exit when Last_Character( this_line ) /= '\';
         end loop;
         Strip_Escapes( line );
         line_length := Length( line );
         if( line_length > 2 ) then -- smallest you could have: "a=b"
            eq_pos := Index( line, "=" );
            if( eq_pos > 1 ) then
               key := Trim(Unbounded_Slice( line, 1, eq_pos - 1 ), Ada.Strings.Both);
               value := Trim(Unbounded_Slice( line, eq_pos + 1, line_length ), Ada.Strings.Both );
               if( Length( Key ) > 0 ) and ( Length( value ) > 0 ) then
                  buffer.Include( key, value ); -- this replaces dups
               end if;
            end if;
         end if;
         line := To_Unbounded_String( "" );
      end loop;
      Ada.Text_IO.Close( in_file );
      return buffer;
    end Load_Multiline;
 
    
    function Load_Single_Lines( filename : String ) return Text_Buffer is
       use Text_Utils;
       use String_Maps_Package;
       use Ada.Text_IO; 
       use Line_Extractor;
       use Ada.Text_IO.Unbounded_IO;
       
       b : Text_Buffer;
       k : Unbounded_String;
       v : Unbounded_String;
       s : Unbounded_String;
       file : File_Type;
    begin
       Open( file, In_File, filename );
       loop
          Get_Line( file, s );
          Trim( s, Ada.Strings.Both );
          Delete_After_Comment( s );  
          if Length( s ) > 3 then -- least it could be is 'a=b;'
             k := Trim( Extract_Key( s ), Ada.Strings.Both );
             v := Trim( Extract_Value( s ), Ada.Strings.Both );
             Put_Line( "k = " & TS( k ));
             b.Insert( k, v );
          end if;
          exit when End_Of_File( file );
       end loop;
       Close( file );
       return b;
   end Load_Single_Lines;
   
   function Get( this_buffer : Text_Buffer; key : String ) return String is
   begin
      return To_String( this_buffer.Element( To_Unbounded_String( key )));
   end Get;
   
   function Get( this_buffer : Text_Buffer; key : Unbounded_String ) return Unbounded_String is
   begin
      return this_buffer.Element( key );
   end Get;
   
   function Load( filename : String; which_load : Load_Type ) return Text_Buffer is
   begin
      case which_load is
      when single_line_delimited => return Load_Single_Lines( filename );
      when multiline => return Load_Multiline( filename );
      end case;
   end Load;

end Keyed_Text_Buffer;
