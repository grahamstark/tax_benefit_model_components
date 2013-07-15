-------------------------------------------------------------------------------
--
--              Unit Name:      Package body for Name_IO
--
-------------------------------------------------------------------------------
-----------------------------
--     Sequence of actions --
-----------------------------
--      The package is a FINITE STATE MACHINE which can be used
--  successively to recognize different streams of data all with the
--  same collection of <Ada_Id>'s.  The sequence of actions on the state
--  machine are:
--
--      1) Initialize the input data by EITHER
--  1a) Accept_Input  --  called by user to provide a dynamic string
--  of type String_Pkg.String_Type which is the input to be parsed.
--  Use this procedure when there is a unique string of input to be
--  parsed.
--      or
--      1b) Acquire_Input --  given a Class_Name, this procedure will
--  invoke Input_Collection.Get_Contents to get its own dynamic string
--  of data that are to be parsed.  Use this method when this package
--  is used in an Object-Oriented program in which arbitrarily many
--  distinct objects of some type each need the same kind of input.
--
--      2) Arbitrarily many calls to the different Get's (but only one
--  for any particular Name parameter) -- called to obtain the value
--  that was bound to a particular <Ada_Id> Name in the input;
--
--      3) Forget_Contents -- called by user to signal that user has
--  obtained all the values that s/he intends to obtain.  After
--  forgetting, calls to Get raise No_Input until a new call of
--  Accept_Input or Acquire_Input has provided a new string.
--
--
-------------------------------
--         Technique         --
-------------------------------
--      Step 1: Accept (or acquire) input
--  Scan the sequence of {  <Ada_Id> [assignment] <Value> [;] };
--  Interpret <Ada_Id> as the 'Image of a literal in Names_Type;
--  Remove assignment ops, line-terminators, and semicolons;
--  Store the <value> string in an array, indexed by Names_Type.
--
--      Step 2: Deliver value to caller of Get
--  Pass the string <value> to an instance of Get (From: String, ... )
--  which matches the type of the Item that the caller is requesting.
--  Whatever Get (From: String ...) delivers is the value that the
--  input bound.
--
-------------------------------
--     Anachronism Alert     --
-------------------------------
--  Back in '86 and '87 the best string scanning packages I knew were
--  the collection in Simtel20, later PAL, later (oh who knows).  I
--  call it "ASR_String_Utilities" after the "Ada Software Repository"
--  but it was "marketed" under the name String_Utilities, and it is
--  actually pretty cool.  Nowadays a controlled type
--  Ada_Strings_Unbounded gets worked over using its own
--  standard-compliant operations.  So don't read this package for
--  esthetics!  But it seems to work OK...  JPW
--
--              Acknowledgment:
--      I first learned the technique used here in the package NAMELIST,
--  written by David Kwong...finished 10/86.
--      Received: from SIMTEL20.ARPA by lll-icdc.arpa ;
--      PD:<ADA.COMPONENTS>NAMELIST.SRC.0
--
--              Host system:
--      DEC MicroVAX2
--      DEC Ada Compiler 1.3 & 2.2
--      Rational Apex v3.0 et seq.
--      Gnat 3.13p et seq.
--
-------------------------------------------------------------------------------
--
with Asr_String_Utilities;
with Input_Collection;
with Ada.Io_Exceptions;
with Ada.Exceptions;

package body Name_Io is

   package Integer_Io is new Ada.Text_Io.Integer_Io (Integer_type);

   package Sp renames String_Pkg;
   package Su renames Asr_String_Utilities;

   package Scan is             --  tool for lexing substrings
      new Su.Generic_String_Utilities (Generic_String_Type => Sp.String_Type,
                                       To_Generic          => Sp.Create,
                                       From_Generic        => Sp.Value);

   -------------------------------------------------------------------------------

   --  Following strings are keys that define token types
   --  that scan can recognize
   Semicolon   : constant String := ";";
   Punctuation : constant String :=
     " ,"                   --  delimiters
     & Line_Terminator         --  matrix row separators
     & Semicolon;

   Assignment_Chars : constant String
                    := " :=>"   -- any subset for assignment
                       & Line_Terminator;
   --  The token called Ada_id is letters + digits + understroke
   --  beginning with a letter.

   -------------------------------------------------------------------------------

   --  The result of a successful scan of an input binding (which looks like
   --  <Ada_Id> [assignment] <Value> [;]  ) is an entry in the Input_Inventory

   type Value_Input_Type is
      record
         Present    : Boolean := False;
         Input_Text : Sp.String_Type;
      end record;
   type Input_Inventory_Type is array (Names_Type) of Value_Input_Type;

   --  After scanning, Input_Inventory has an entry for every input binding.
   --  Calls to Get will extract the value from the Input_Text according to
   --  the type (which the client of this package expects).
   Input_Inventory : Input_Inventory_Type;

   -------------------------------------------------------------------------------
   --      Input that a particular execution that this name_io is scanning
   --  may optionally be identified by a 'context' to enhance messages
   --  to the user.
   --      Context has two parts, a current class name and a current instance.
   --  Class_Name is given to Acquire_Input in the event that this package
   --  is to acquire its contents from Input_Collection (citing a Class_Name).
   --  The alternative, for the caller to provide Contents to the Accept_Input
   --  entry, does not define a Class.
   --      In case contents came from a Class, the user can further label
   --  which instance of the abstract data type Class is current at the time
   --  of the scan by calling Set_Object_Instance_Name.
   --
   --  <When I polished my way through these packages in 2003, I was
   --  amused by the terminology I had written with the original back
   --  in '87.  Only one phrase was what I would call egregious but
   --  many of the others seem quaint so I left most of them.  (The
   --  egregious identifier is now spelled "class"). JPW >

   Current_Class    : Sp.String_Type --  for error messages
                    := Sp.Make_Persistent ("");
   Current_Instance : Sp.String_Type := Sp.Make_Persistent ("");

   --  When prompting user for values that Get cannot find in Contents,
   --  we identify the context only once.
   Context_Has_Been_Shown : Boolean := False;

   -------------------------------------------------------------------------------

   procedure Set_Object_Instance_Name (Instance_Name : in String) is
   begin
      Current_Instance := Sp.Make_Persistent (Instance_Name);
   end Set_Object_Instance_Name;

   -------------------------------------------------------------------------------

   procedure Show_Context is
      Context : Sp.String_Type;
   begin
      Sp.Mark;
      Context := Sp.Create ("Some input data are incomplete");
      if not Sp.Is_Empty (Current_Class) then
         Context := Sp."&" (Context, " for ");
         Context := Sp."&" (Context, Current_Class);
         if not Sp.Is_Empty (Current_Instance) then
            Context := Sp."&" (Context, " named ");
            Context := Sp."&" (Context, Current_Instance);
         end if;
      end if;

      Put_Error_Msg (Sp.Value (Context));
      Sp.Release;
   end Show_Context;

   -------------------------------------------------------------------------------

   procedure Show_Error_Context is
      Context : Sp.String_Type;
   begin
      if not Sp.Is_Empty (Current_Class) then
         Sp.Mark;
         Context := Sp.Create ("in the input for class " &
                               Sp.Value (Current_Class));
         if not Sp.Is_Empty (Current_Instance) then
            Context := Sp."&" (Context, " named ");
            Context := Sp."&" (Context, Current_Instance);
         end if;
         Put_Error_Msg (Sp.Value (Context));
         Sp.Release;
      end if;
   end Show_Error_Context;

   -------------------------------------------------------------------------------

   procedure Scan_Value (Name_Scanner : in out Su.Scanner;
                         Value_String : out Sp.String_Type) is
      Found     : Boolean;
      Unused    : Sp.String_Type;
      Untrimmed : Sp.String_Type;

      --  Extract the string <value> from  { [assignment] <Value> [;] }
      --  <Value> is either a quoted string which is to be delivered to eventual
      --  caller of get intact, OR it is a string made up of Numeric_Chars
      --  that will eventually be parsed by a Get (From: String ...) procedure.

      --  Because of Matrix_IO vector component defaulting specification, a string
      --  may hold fewer items than the vector'length;  this procedure trims
      --  trailing punctuation so that get vector ends gracefully.

      --  <Another annachronism -- back when, there was just one
      --  package for all Item types, including matrices.  So it was
      --  pretty normal for this procedure to acknowledge their
      --  existance.  Nowadays we have generic child packages, and
      --  wish that a parent didn't predict its child's existence.  So
      --  deal with it  :-]  JPW>

      procedure Scan_Object (Name_Scanner : in out Su.Scanner;
                             Value        : in out Sp.String_Type;
                             Found        : in out Boolean) is

         --  Punctuation is allowed in numeric strings in accordance with Matrix_IO
         --  meanings:  Commas separate and define defaults in vector get;
         --  <CR><LF> delimit rows in matrix get.

         --  Each object must be terminated with a semi-colon.
      begin
         Scan.Scan_Not_Sequence
           (Semicolon, Name_Scanner, Found, Value, Skip => True);
         if not Found then
            Value := Sp.Create ("");
         end if;
      end Scan_Object;

   begin                             --     Scan_Value
                                     --  throw away any of  {= | := | =>}
      Scan.Scan_Sequence
        (Assignment_Chars, Name_Scanner, Found, Unused, Skip => True);

      Su.Skip_Space (Name_Scanner);
      if Su.Is_Quoted (Name_Scanner) then
         Scan.Scan_Quoted (Name_Scanner, Found, Value_String, Skip => True);
      else
         Scan_Object (Name_Scanner, Untrimmed, Found);

         --  trim the terminating punctuation so that matrix_io can
         --  get value of a (possibly defaulted) vector.
         if Found then
            declare
               Trim_End : Positive := Sp.Length (Untrimmed);
               Trim : String (1 .. Trim_End) := Sp.Value (Untrimmed);

               function Is_Punctuation (Test : Character) return Boolean is
               begin
                  for Ix in Punctuation'First .. Punctuation'Last loop
                     if Test = Punctuation (Ix) then
                        return True;
                     end if;
                  end loop;
                  return False;          -- only if loop is exhausted
               end Is_Punctuation;

            begin
               while Trim_End > 1 and then
                 Is_Punctuation (Trim (Trim_End)) loop
                  Trim_End := Trim_End - 1;
               end loop;
               Value_String := Sp.Create (Trim (1 .. Trim_End));
            end;
         end if;
      end if;
      --  discard line terminator after string
      Scan.Scan_Sequence
        (Punctuation, Name_Scanner, Found, Unused, Skip => True);
   end Scan_Value;

   -------------------------------------------------------------------------------

   procedure Fwd_To_Ada_Id (Name_Scanner : in out Su.Scanner) is
   begin
      --  recover by going forward to next Ada_id
      while Su.More (Name_Scanner) and then
        not Su.Is_Ada_Id (Name_Scanner) loop
         Su.Forward (Name_Scanner);
      end loop;
   end Fwd_To_Ada_Id;


   procedure Pass_Foreign_Chars
     (Name_Scanner    : in out Su.Scanner; Found : out Boolean) is
      Just_Before_Err : Natural := Su.Position (Name_Scanner);
      Just_After_Err  : Natural := Su.Position (Name_Scanner);
      Err_Context     : Sp.String_Type;
   begin
      Found := False;                -- unless contradicted
      Su.Skip_Space (Name_Scanner);
      if Su.More (Name_Scanner) and then not Su.Is_Ada_Id (Name_Scanner) then
         --  A foreign char exists in input where an Ada Id is required.
         Found := True;

         --  Make an error message complaining about the foreign char:
         Put_Error_Msg ("Unrecognizable character <" &
                        Su.Get (Name_Scanner)            --  the foreign char
                        & "> in the input near ");
         Su.Mark (Name_Scanner);    --  this is a 'location' mark
         for Ix in 1 .. 10 loop
            Su.Forward (Name_Scanner);
         end loop;
         Just_After_Err := Su.Position (Name_Scanner);
         Su.Restore (Name_Scanner); --  back to loc of SU.Mark
         Su.Mark (Name_Scanner);
         for Ix in 1 .. 10 loop
            Su.Backward (Name_Scanner);
         end loop;
         Just_Before_Err := Su.Position (Name_Scanner);
         Su.Restore (Name_Scanner);

         Err_Context := Scan.Get_Segment
           (Name_Scanner, Just_Before_Err, Just_After_Err);
         Put_Error_Msg (Sp.Value (Err_Context));
         Show_Error_Context;

         --  Error message complete;  prepare for next scan
         Fwd_To_Ada_Id (Name_Scanner);
      end if;
   end Pass_Foreign_Chars;


   procedure Scan_Value_String (Variable : in Names_Type;
                                Name_Scanner : in out Su.Scanner) is
      Value_String : Sp.String_Type;
      Trouble      : Boolean;
   begin
      Scan_Value (Name_Scanner, Value_String);
      --  If the value string is not immediately followed by another
      --  Ada_Id, then there are some foreign chars,
      --  possibly even embedded in the value;
      Pass_Foreign_Chars (Name_Scanner, Trouble);
      if Trouble then
         Input_Inventory (Variable).Present := False;
      else
         if Input_Inventory (Variable).Present then
            --  we just encountered a REBINDING of variable in input
            Sp.Flush (Input_Inventory (Variable).Input_Text);
         end if;
         Input_Inventory (Variable).Present := True;
         Input_Inventory (Variable).Input_Text :=
           Sp.Make_Persistent (Value_String);
      end if;
   end Scan_Value_String;

   -------------------------------------------------------------------------------

   procedure Accept_Input (Contents : in out String_Pkg.String_Type) is
      Name_Scanner : Su.Scanner;
      Literal      : Sp.String_Type;
      Recognized   : Boolean;
      Variable     : Names_Type;
      Found        : Boolean;

   begin
      Sp.Mark;
      Name_Scanner := Scan.Make_Scanner (Contents);
      while Su.More (Name_Scanner) loop
         Pass_Foreign_Chars (Name_Scanner, Found);
         Scan.Scan_Ada_Id (Name_Scanner, Found, Literal, Skip => True);
         if Found then
            --  An Ada_Id has been scanned;
            --  do we recognize it as a member of Names?
            begin
               Variable := Names_Type'Value (Sp.Value (Literal));
               Recognized := True;
            exception
               when Constraint_Error =>
                  --  caused by Literal not in Names_Type
                  Recognized := False;
                  Put_Error_Msg ("Failed to recognize the name " &
                                 Sp.Value (Literal));
                  Show_Error_Context;
            end;

            if Recognized then
               --  Acquire the { [assignment] <Value> [;] }
               Scan_Value_String (Variable, Name_Scanner);
            else
               --  The unrecognized name has already been reported as error
               Fwd_To_Ada_Id (Name_Scanner);
            end if;
         end if;
      end loop;
      Su.Destroy_Scanner (Name_Scanner);
      Sp.Flush (Contents);
      Sp.Release;
   end Accept_Input;

   -------------------------------------------------------------------------------

   procedure Acquire_Input (Class_Name : in String) is
      Contents : Sp.String_Type;
   begin
      Forget_Contents;               --  dispose old inventory
      Current_Class := Sp.Make_Persistent (Class_Name);
      Input_Collection.Get_Contents (Class_Name, Contents);
      Accept_Input (Contents);
   exception
      when Input_Collection.No_Input_For_Object =>
         null;
   end Acquire_Input;

   -------------------------------------------------------------------------------

   procedure Forget_Contents is
   begin
      for Ix in Names_Type loop
         if Input_Inventory (Ix).Present then
            Sp.Flush (Input_Inventory (Ix).Input_Text);
            Input_Inventory (Ix).Present := False;
         end if;
      end loop;
      Sp.Flush (Current_Class);
      Sp.Flush (Current_Instance);
      Context_Has_Been_Shown := False;
   end Forget_Contents;

   -------------------------------------------------------------------------------

   --  After all the Contents have been scanned by Accept_Input, all the
   --  input bindings are stored in Input_Inventory.
   --  Calls to Get for any numeric type will parse the Input_Inventory
   --  Input_Text and return the value which is decoded from that text
   --  according to the Decode which is type consistent with the value.
   --
   --  For the Get which cites a Prompt, if the input_inventory fails
   --  to yield up a value, we make an attempt to acquire the value
   --  from interaction with a presumable human.

   -------------------------------------------------------------------------------

   --  Here is the body (template) of the generic Read which is specified
   --  just above.  It first tries to take an Item out of the input inventory
   --  by decoding the string which is stored there indexed by name.

   --  In the event that the input in NOT Present in input inventory,
   --  then Attempt Interaction.  If prompt is given, Attempt_Interact
   --  will get an Item from (the generic procedure that is "usually")
   --  Standard-Input.

   --  < The specification for the interactive read was moved to
   --  private part in 2003 to accomodate the needs of the child
   --  package.  But I think the comment is so implementation specific
   --  I'll leave this comment here where the entire business
   --  originally lived.  JPW >

   procedure Read (Name   : in Names_Type;
                   Found  : out Boolean;
                   Item   : out Item_Type;
                   Prompt : in String := "") is
      Last : Natural;

      procedure Attempt_Interact is
      begin
         if Prompt'Length = 0 then
            Found := False;
         else
            if not Context_Has_Been_Shown then
               Show_Context;
               Context_Has_Been_Shown := True;
            end if;
            --  Since there is no default offered to the Polite interactive
            --  procedure that will be the actual here, the user has no
            --  alternative to giving an Item;  therefore we know Found
            Found := True;
            Interact (Prompt, Item);
         end if;
      end Attempt_Interact;

   begin
      if Input_Inventory (Name).Present then
         Found := True;
         Decode (Sp.Value (Input_Inventory (Name).Input_Text), Item, Last);
      else
         Attempt_Interact;
      end if;
   exception
      when Ada.Io_Exceptions.Data_Error =>
         --  Make an error message that exhibits the strings which
         --  could not be parsed.  It was supposed to be a value
         --  which is type consistent with the type of Item:
         Put_Error_Msg ("Unable to determine the value of " &
                        Names_Type'Image (Name) & " = " &
                        Sp.Value (Input_Inventory (Name).Input_Text));
         Show_Error_Context;
         Input_Inventory (Name).Present := False;
         Sp.Flush (Input_Inventory (Name).Input_Text);
         Attempt_Interact;
      when Ada.Io_Exceptions.End_Error =>
         Input_Inventory (Name).Present := False;
         Attempt_Interact;
   end Read;

   -----------------------------------------------------------------------------
   --  Each numeric type has an instance of READ.
   --  < And for those tempted to look ahead, we will find similar in
   --  the child package name_io.matrix_name_io.  JPW >
   procedure Read_Integer is new Read (Item_Type => Integer_type,
                                       Decode    => Integer_Io.Get,
                                       Interact  => scalar_Io.Get);

   procedure Read_Float is new Read (Item_Type => Floating_Type,
                                     Decode    => scalar_Io.Real_Decode,
                                     Interact  => scalar_Io.Get);

   -------------------------------------------------------------------------------

   procedure Get (Name   : in Names_Type;
                  Item   : out Integer_type;
                  Prompt : in String := "") is
      Found : Boolean;
   begin
      Read_Integer (Name, Found, Item, Prompt);
      if not Found then
         Ada.Exceptions.Raise_Exception( No_Input'Identity, 
            "Get( Integer ) failed to find |" & Names_Type'Image( Name ) & "|" );
         -- raise No_Input;
      end if;
   end Get;

   -------------------------------------------------------------------------------

   procedure Get (Name   : in Names_Type;
                  Item   : out Floating_type;
                  Prompt : in String := "") is
      Found : Boolean;
   begin
      Read_Float (Name, Found, Item, Prompt);
      if not Found then
         Ada.Exceptions.Raise_Exception( No_Input'Identity, 
            "Get( Floating_Type ) failed to find |" & Names_Type'Image( Name ) & "|" );
         -- raise No_Input;
      end if;
   end Get;

   -------------------------------------------------------------------------------

   procedure Get_Item (Name   : in Names_Type;
                       Item   : out Item_Type;
                       Prompt : in String := "") is
      Found : Boolean;

      package Item_Io is new Ada.Text_Io.Enumeration_Io (Item_Type);

      procedure Polite_Interact is
         new scalar_Io.Polite_Get
        (Item_Type => Item_Type, Decode => Item_Io.Get);

      procedure Interact_Polite (Prompt : in String; Item : out Item_Type) is
      begin
         --  reverse the parameter order for use in generic actual (boring)
         Polite_Interact (Prompt => Prompt, Item => Item);
      end Interact_Polite;

      procedure Read_Value is new Read (Item_Type => Item_Type,
                                        Decode => Item_Io.Get,
                                        Interact => Interact_Polite);
   begin
      Read_Value (Name, Found, Item);
      if not Found then
         Ada.Exceptions.Raise_Exception( No_Input'Identity, 
            "Get( Item_Type ) failed to find |" & Names_Type'Image( Name ) & "|" );
         -- raise No_Input;
      end if;
   end Get_Item;


   -------------------------------------------------------------------------------

   procedure Read_String (Name   : in Names_Type;
                          Found  : out Boolean;
                          Item   : out String;
                          Last   : out Natural;
                          Prompt : in String := "") is

      --  Read_String behaves like Text_IO.Get_Line.  If called with
      --  a relatively short Item, then Read_String delivers as many
      --  characters as Item can hold;  if called again then Read_String
      --  will deliver some more characters starting where it left off.
      --  The value of Last will be the index of the last character
      --  in Item that was copied from the input.

      --  Read_String works like a store-house.  It owns some Stock-in-hand,
      --  either from the input binding accomplished by Accept_Input or
      --  (if no binding was made) on its first call it stocks up by
      --  interacting on Standard-Input.
      --  Each call to Read_String delivers Item from Stock, until the
      --  stock has been exhausted.


      Stock_In_Hand : Natural := Sp.Length
        (Input_Inventory (Name).Input_Text);
      Can_Deliver   : Natural := Item'Length;
      No_Response   : exception;     -- no input in response to prompt


      procedure Save_Tail is
         --  retain tail of input text in case of further calls
         Nonpersistent_Value : Sp.String_Type;
      begin
         --  replace persistent Input_Text with a persistent substr
         --  using a non-persistent temporary value:
         --
         --  < In 2003, I whistled a little tune about controlled
         --  types here. JPW >
         Nonpersistent_Value :=
           Sp.Substr (Input_Inventory (Name).Input_Text, Can_Deliver + 1,
                      Stock_In_Hand - Can_Deliver);
         --  Flush the earlier text, making room for new
         Sp.Flush (Input_Inventory (Name).Input_Text);
         Input_Inventory (Name).Input_Text :=
           Sp.Make_Persistent (Nonpersistent_Value);
      end Save_Tail;


      procedure Deliver_From_Stock is
      begin
         Found := True;
         Sp.Mark;
         if Stock_In_Hand > Can_Deliver then
            --  Too little space in Item to accept entire input so
            --  deliver what will fit.
            Item := Sp.Value (Sp.Substr (Input_Inventory (Name).Input_Text,
                                         1, Can_Deliver));
            Last := Can_Deliver;
            Save_Tail;
         else        --  Item can accomodate entire input
            Item (Item'First .. Item'First + Stock_In_Hand - 1) :=
              Sp.Value (Input_Inventory (Name).Input_Text);
            Last := Item'First + Stock_In_Hand - 1;
            Input_Inventory (Name).Present := False;
         end if;
         Sp.Release;
      end Deliver_From_Stock;


      procedure Stock_Up_Interactive is
         Max_Line  : Natural := 132;
         Some_Line : String (1 .. Max_Line);
         Last      : Natural;
      begin
         if not Context_Has_Been_Shown then
            Show_Context;
            Context_Has_Been_Shown := True;
         end if;
         Interacting_Put (Prompt & " ->  ");
         Interacting_Get_Line (Some_Line, Last);
         if Last > 0 then
            Stock_In_Hand := Last;
            Input_Inventory (Name).Present := True;
            Input_Inventory (Name).Input_Text :=
              Sp.Make_Persistent (Some_Line (1 .. Last));
         else
            raise No_Response;
         end if;
      end Stock_Up_Interactive;



   begin
      if Input_Inventory (Name).Present then
         Deliver_From_Stock;
      else
         if Prompt'Length /= 0 then
            begin
               Stock_Up_Interactive;
               Deliver_From_Stock;
            exception
               when No_Response =>
                  Found := False;
                  Last := Item'First - 1;
            end;
         else        --  there was no prompt in the call
            Found := False;
            Last := Item'First - 1; --  conforms to text_io.getline convention
         end if;
      end if;
   end Read_String;

   -------------------------------------------------------------------------------

   procedure Get (Name   : in Names_Type;
                  Item   : out String;
                  Last   : out Natural;
                  Prompt : in String := "") is
      Found : Boolean;
   begin
      Read_String (Name, Found, Item, Last, Prompt);
      if not Found then
         raise No_Input;
      end if;
   end Get;

end Name_Io;


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

