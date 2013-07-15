-------------------------------------------------------------------------------
--
--              Unit Name:      Package body for Numeric_IO
--
-------------------------------------------------------------------------------

with Set_Of;

package body Numeric_Io is

   Extra_Characters : exception;

   use Real_Io;
   use Counting_Io;

   package Integer_Io is new Ada.Text_Io.Integer_Io (Integer);

   package Alphabet is new Set_Of (Letter);

   --  Menu selection returns a letter that is in the Alphabet of this call.
   All_Letters         : constant Alphabet.Set := Alphabet.Full;
   Particular_Alphabet : Alphabet.Set;

   -------------------------------------------------------------------------------

   --  Menu_Decode extracts a letter (which is a member of this
   --  call's Particular_Alphabet) from users input.
   procedure Menu_Decode (From : in String;
                          Item : out Letter;
                          Last : out Positive) is

      I : Positive := From'First;

      function Upper (Any_Case : in Letter) return Upper_Case_Letter is
      begin
         if 'a' <= Any_Case and then Any_Case <= 'z' then
            return Character'Val (Character'Pos (Any_Case) -
                                  Character'Pos ('a') +
                                  Character'Pos ('A'));
         else
            return Any_Case;
         end if;
      end Upper;

   begin
      while I < From'Last and then From (I) = ' ' loop
         I := I + 1;
      end loop;
      Last := I;
      if Alphabet.Member (Particular_Alphabet, From (I)) then
         Item := Upper (From (I));
      else
         raise Ada.Text_Io.Data_Error;
      end if;
   end Menu_Decode;

   -------------------------------------------------------------------------------

   procedure Real_Decode (From : in String;
                          Item : out Real;
                          Last : out Positive) is

      --  This procedure attempts to decode the input as a real
      --  number, forgiving certain flaws.  Ada defines a real to be
      --  <digits>.<digits>{E +/- int}; this procedure allows either
      --  leading or trailing <digits> to be omitted, or allows an
      --  integer to be input where the intended item is that
      --  integer's value.

      Failed_Exponent : exception;

      --  No_Trailing_Digit attempts to salvage a value from input
      --  i.   |   i.e<int>

      procedure No_Trailing_Digit (From  : in String;
                                   Value : in out Real;  -- might be scaled
                                   Last  : out Positive) is
         Try_Exp : Integer;
         Check   : Positive := From'First;
      begin
         --  If anything is left after a legal integer,
         --  it may be <value>.E<int>
         Last := Check - 1;         -- in case we DONT have ".E<int>"
         if From (Check) = '.' then
            --  At least the decimal pt belongs; maybe there is a scaling exp.
            Last := Check;
            Check := Check + 1;
         end if;

         --  Even without decimal, we may have iE<neg_int>
         if Check < From'Last and then      -- a scaling exp at least fits;
           (From (Check) = 'e' or From (Check) = 'E') then
            begin
               Integer_Io.Get (From (Check + 1 .. From'Last),
                               Try_Exp, Check);
               Value := Value * (10.0 ** Try_Exp);
               Last := Check;             -- We have consumed some chars
            exception
               --  Avoid attempt to rescue by hypothesis Case 4
               when Ada.Text_IO.Data_Error =>
                  raise Failed_Exponent;
            end;
         end if;
      end No_Trailing_Digit;


      --  Two kinds of strings that cannot be read as Real OR Integer
      --  can be repaired to yield useful input:
      --    .i  |  -.i     >  Fail because no leading digit before fraction
      --                   >  We attempt to insert '0' before '.'
      --    iE<bad-exp>    >  Fails because value overflows integer, or
      --                   >  bad-exp < 0.  We insert ".0" to make
      --                   >  i.0E<exp> a readable real number.
      --
      procedure Repair (From : in String;
                        Item : out Real;
                        Last : out Positive) is

         Repaired : String (From'First .. From'Last + 2);
         --  long enough to accomodate repairs
         Final    : Positive;
         Over_Estimate :
           Positive;  -- amount by which GET (Last) will be too high
      begin
         for Ix in From'Range loop           --  index the chars in original string
            if From (Ix) = '.' then
               -- REPAIR  >> .i --> 0.i  |  -.i --> -0.i
               Repaired (Ix) := '0';
               Over_Estimate := 1;
               for Balance in Ix .. From'Last loop
                  --  copy rest of from
                  Repaired (Balance + 1) := From (Balance);
               end loop;
               Repaired (Repaired'Last) := ' ';  --  conform to constraint
               exit;

            elsif From (Ix) = 'e' or From (Ix) = 'E' then
               --  REPAIR  >>  iE<bad-exp>  -->  i.0E<exp>
               --  bad-exp < 0, or overflew integer (>1e10)
               Repaired (Ix) := '.';
               Repaired (Ix + 1) := '0';
               Over_Estimate := 2;
               for Balance in Ix .. From'Last loop
                  Repaired (Balance + 2) := From (Balance);
               end loop;
               exit;

            else            --  Chars ahead of flaw are copied directly
               Repaired (Ix) := From (Ix);
            end if;
         end loop;
         Real_Io.Get (Repaired, Item, Final);
         --  If this raises an exception, there is no further action;
         --  the user has input a -really- illegal input string
         Last := Final - Over_Estimate;
      end Repair;

      -------------------------------------------------------------------------------
      --      B O D Y    O F    R E A L    D E C O D E

   begin
      --  Case 1: From contains an Ada real literal:  no special treatment
      Real_Io.Get (From, Item, Last);
   exception
      when Ada.Text_Io.Data_Error =>
         declare
            Try_Int : Integer;
            Final   : Integer := 1;
            Value   : Real;
         begin
            --  Case 2: If the input is an integer,
            --  then return its value as a real.
            --  Note that 5e2 is a legal integer == 500
            Integer_Io.Get (From, Try_Int, Final);
            Last := Final;
            Value := Real (Try_Int);
            if Final < From'Last then
               --  Case 3: There are chars following a legal integer;
               --  test hypothesis that input was like "5.E2"
               No_Trailing_Digit
                 (From (Final + 1 .. From'Last), Value, Last);
            end if;
            Item := Value;
         exception
            when Ada.Text_Io.Data_Error =>
               --  Case 4: Unable to read an integer off the head of 'From';
               --  We want to repair cases like .i and like iE-j
               Repair (From, Item, Last);
            when Failed_Exponent =>
               raise Ada.Text_Io.Data_Error;
         end;
   end Real_Decode;

   -------------------------------------------------------------------------------

   --  Aft is an aid to formatting REAL numbers:
   --  It computes the value for the AFT parameter that will
   --  write just the significant part of the real number.

   function Aft (Item : in Real;
                 Exp  : in Ada.Text_Io.Field := Real_Io.Default_Exp)
                return Ada.Text_Io.Field is
      Work_String : String (1 .. 3 * Default_Aft);  -- enough space
      Zeros       : Natural  := 0;
      Inspect     : Positive := Work_String'Length;
   begin
      Real_Io.Put (Work_String, Item, Exp => Exp);
      --  Scan backward through the image of Item,
      if Exp > 0 then
         --  first locate the mantissa
         while Work_String (Inspect) /= 'E' loop
            Inspect := Inspect - 1;
         end loop;
         Inspect := Inspect - 1;
      end if;

      --  then count off non-significant zeros
      while Work_String (Inspect) = '0' loop
         Zeros := Zeros + 1;
         Inspect := Inspect - 1;
      end loop;

      if Zeros >= Default_Aft then
         return 1;          -- assure output will show x.0
      else
         return Default_Aft - Zeros;
      end if;
   end Aft;

   -------------------------------------------------------------------------------

   --  Polite_Get is the GENERIC TEMPLATE that processes strings for any
   --  kind of DECODE procedure
   procedure Polite_Get (Item : out Item_Type; Prompt : in String) is
      subtype Mystring is String (1 .. Input_Size);
      Something : Mystring;
      Last1     : Natural;

      procedure Get_Something (Some_Line : out String; Last : out Natural) is
         Last1 : Natural;
         Last2 : Natural;
         More  : Mystring;  -- in case of > Input_Size chars input.
      begin
         Interacting_Get_Line (Some_Line, Last1);
         if Last1 = 0 then
            raise No_Entry;
         end if;
         if Last1 = Input_Size then
            declare
               Line_Too_Long : Boolean := False ;
               --  if still more chars, then error;  skip_line while not yet eol
            begin
               Last2 := Last1 ;
               while Last2 > 0 loop
                  Interacting_Get_Line (More, Last2);
                  if Last2 > 0 then
                     Line_Too_Long := True ;
                     if Last2 = Input_Size then
                        Interacting_Skip_Line;
                     end if;
                  -- else some_line *just* filled input_size, so no err
                  end if;
               end loop ;
               if Line_Too_Long then Raise Extra_Characters; end if ;
            end ;
         end if;
         Last := Last1;
      end Get_Something;


   begin
      Interacting_Put (Prompt & " ->  ");
  Main:
      loop
         begin
            Get_Something (Something, Last1);
            Decode (Something (Something'First .. Last1), Item, Last1);
            exit;          --  when decode raises nothing
         exception
            when Extra_Characters =>
               Interacting_Put ("Input is too long; retry please  ");
            when Ada.Text_Io.Data_Error =>
               declare
                  I : Positive := Something'First;
               begin
                  while I < Something'Last and then
                    Something (I) = ' ' loop
                     I := I + 1;
                  end loop;
                  --  Removed VMS-specific help facility
                  Interacting_Put ("ERROR, Please Re-Enter: ");
               end;
            when No_Entry =>
               raise;
         end;
      end loop Main;
   end Polite_Get;

   -------------------------------------------------------------------------------
   --  S E R V I C E S   O N   R E A L   N U M B E R S

   procedure Get_Real is new Polite_Get (Item_Type => Real,
                                         Decode    => Real_Decode);

   procedure Get (Prompt : in String; Item : out Real) is
   begin
      loop
         begin
            Get_Real (Item, Prompt);
            exit;
         exception
            when No_Entry =>
               Interacting_Put_Line (You_Must_Line)  ;
         end;
      end loop;
   end Get;

   -------------------------------------------------------------------------------

   procedure Get (Prompt  : in String;
                  Default : in Real;
                  Item    : out Real) is
      Def_Str : String (1 .. 20);  -- for printing default prompt
      Signif : Integer := 1;    -- non-blank part of def_str

   begin
      Real_Io.Put (Def_Str, Default, Exp => 0, Aft => Real'Digits - 1);
      --  The text representing Default is in the RIGHT side of Def_Str
      while Def_Str (Signif) = ' ' loop
         Signif := Signif + 1;
      end loop;
      Get
        (Prompt & " [" & Def_Str (Signif .. Def_Str'Last) & "]", Item);
   exception
      when No_Entry =>
         Item := Default;
   end Get;

   -------------------------------------------------------------------------------
   --  S E R V I C E S   O N   I N T E G E R S

   procedure Get_Counting is new Polite_Get (Item_Type => Counting,
                                             Decode => Counting_Io.Get);

   -------------------------------------------------------------------------------

   procedure Get (Prompt : in String;
                  Item   : out Counting) is
   begin
      loop
         begin
            Get_Counting (Item, Prompt);
            exit;
         exception
            when No_Entry =>
               Interacting_Put_Line (You_Must_Line) ;
         end;
      end loop;
   end Get;

   -------------------------------------------------------------------------------

   procedure Get (Prompt  : in String;
                  Default : in Counting;
                  Item    : out Counting) is
      Def_Str : String (1 .. 10);
      Signif : Integer := 1;
   begin
      Counting_Io.Put (Def_Str, Default);
      while Def_Str (Signif) = ' ' loop
         Signif := Signif + 1;
      end loop;
      Get_Counting (Item, Prompt & " [" &
                    Def_Str (Signif .. Def_Str'Last) & "]");
   exception
      when No_Entry =>
         Item := Default;
   end Get;

   -------------------------------------------------------------------------------
   --  S E R V I C E S    O N    M E N U S

   procedure Get_Menu_Item is
      new Polite_Get (Decode => Menu_Decode, Item_Type => Letter);

   -------------------------------------------------------------------------------

   procedure Both_Cases (Letters : in String;
                         All_Set : in out Alphabet.Set) is
      use Alphabet;
      --  Place both the upper and the lower case form of each letter
      --  in the input string into the set;  For non-letter characters,
      --  do nothing.
   begin
      for Ix in Letters'Range loop
         --  Union the char into the set
         All_Set := All_Set + Letters (Ix);

         if Letters (Ix) in 'a' .. 'z' then
            --  ALSO Union its upper case equivalent
            All_Set := All_Set + Character'Val
              (Character'Pos (Letters (Ix)) -
               Character'Pos ('a') +
               Character'Pos ('A'));
         elsif Letters (Ix) in 'A' .. 'Z' then
            --  ALSO Union its lower case equivalent
            All_Set := All_Set + Character'Val
              (Character'Pos (Letters (Ix)) -
               Character'Pos ('A') +
               Character'Pos ('a'));
         end if;
      end loop;
   end Both_Cases;
   -------------------------------------------------------------------------------

   procedure Menu (Prompt : in String := "";
                   Choice : in String;
                   Item   : out Upper_Case_Letter) is
   begin
      if Choice'Length = 0 then
         Particular_Alphabet := All_Letters;
      else
         Particular_Alphabet := Alphabet.Empty;
         Both_Cases (Choice, Particular_Alphabet);
      end if;
      loop
         begin
            Get_Menu_Item (Item, Prompt);
            exit;
         exception
            when No_Entry =>
               Interacting_Put_Line (You_Must_Line) ;
            when others   =>
               Interacting_Put_Line ("ERROR, Please Re-Enter: ");
         end;
      end loop;
   end Menu;

   -------------------------------------------------------------------------------

   procedure Menu (Prompt  : in String := "";
                   Default : in Letter;
                   Choice  : in String;
                   Item    : out Upper_Case_Letter) is
   begin
      if Choice'Length = 0 then
         Particular_Alphabet := All_Letters;
      else
         Particular_Alphabet := Alphabet.Empty;
         Both_Cases (Choice, Particular_Alphabet);
      end if;
      Get_Menu_Item (Item, Prompt & " [" & Default & "]");
   exception
      when No_Entry =>
         if Default in 'A' .. 'Z' then
            Item := Default;
         else
            Item := Character'Val
              (Character'Pos (Default) -
               Character'Pos ('a') + Character'Pos ('A'));
         end if;
   end Menu;


end Numeric_Io ;

-------------------------------------------------------------------------------
--  This is free software; you can redistribute it and/or modify it
--  under terms of the GNU General Public License as published by the
--  Free Software Foundation; either version 2, or (at your option)
--  any later version.  This software is distributed in the hope that
--  it will be useful, but WITH OUT ANY WARRANTY; without even the
--  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--  PURPOSE. See the GNU General Public License for more details. Free
--  Software Foundation, 59 Temple Place - Suite 330, Boston, MA
--  02111-1307, USA.
--
--  As a special exception, if other files instantiate generics from
--  this unit, or you link this unit with other files to produce an
--  executable, this unit does not by itself cause the resulting
--  executable to be covered by the GNU General Public License. This
--  exception does not however invalidate any other reasons why the
--  executable file might be covered by the GNU Public License.

--  This software was prepared as an account of work sponsored by an
--  agency of the United States Government.  Neither the United States
--  Government nor the University of California nor any of their
--  employees makes any warranty, express or implied, or assumes any
--  liability or responsibility for the accuracy, completeness, or
--  usefulness of any information disclosed.
-------------------------------------------------------------------------------
