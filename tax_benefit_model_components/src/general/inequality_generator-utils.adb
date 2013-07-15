with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;
with Ada.Strings;
with Ada.Strings.Unbounded;

with Ada.Text_IO.Editing;

with Ada.Text_IO.Unbounded_IO;
with Format_Utils;
with GNAT.String_Split;

package body Inequality_Generator.Utils is
   
   use Ada.Strings.Fixed;
   use Ada.Strings;
   use Ada.Text_IO;
   use Ada.Strings.Unbounded;
   use Ada.Text_IO.Unbounded_IO;
   use Ada.Characters.Latin_1;
   use GNAT.String_Split;
   
   type Counter_Type is delta 0.01 digits 18;
   
   package Local_Format_Utils is new 
      Format_Utils( 
         Counter_Type       => Counter_Type, 
         Float_Type         => Amount,
         Default_Separator  => ' ',
         Default_Radix_Mark => ',',
         Amount_Picture     => 
            Ada.Text_IO.Editing.To_Picture( "-ZZZ_ZZZ_ZZZ_ZZZ_ZZZ_ZZ9") ); -- comma seperator

   use Local_Format_Utils;

   
   function Convert( slices : Slice_Set; which : Natural ) return Amount is
      wn : Slice_Number := Slice_Number( which );
      r  : Amount;
   begin
      if( Slice( slices, wn )'Length = 0 ) or ( Slice( slices, wn ) = " " )then 
         return 0.0; 
      end if;
      r := Lenient_Convert( Slice( slices , wn ));
      return r;
   end Convert;
   
   function TDA_Tokenize( s : String ) return Slice_Set is
      
      DELIMS : constant String := "," & HT & LF & CR;
      slices : Slice_Set;
      last   : Natural := s'Last;
   begin
      if( s( last ) = LF ) then last := last - 1; end if;
      Create( slices, Trim( s( 1 .. last ), Both ), DELIMS, Single );
      return slices;
   end TDA_Tokenize;


   function Read_From_File( 
      filename      : String; 
      weight_column : Positive; 
      income_column : Positive ) return Quantile_List is
      line        : Unbounded_String;
      file        : File_Type;
      slices      : Slice_Set;
      ql          : Quantile_List;
      q           : Quantile;
      weight      : Amount;
      income      : Amount;
      line_number : Natural := 0; -- count 1st line (the header) as 0 and data lines from 1
   begin
      Open( file, in_file, filename );
      while not( End_Of_File( file ))loop
         Get_Line( file, line );
         if( line_number > 0 ) then
            slices := TDA_Tokenize( To_String( line ));
            weight := Convert( slices, weight_column );
            q.population := weight;
            income := Convert( slices, income_column );
            -- if( income <= 0.0 )then
            --   income := 0.000001;
            -- end if;
            q.income := income;
            q.index  := line_number;
            Put_Line( Integer'Image( line_number ) & " " & To_String( q ));
            ql.Append( q );
         end if;
         line_number := line_number + 1;
      end loop;
      Close( file );
      return ql;
   end Read_From_File;

end Inequality_Generator.Utils;
