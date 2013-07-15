--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--SUTILS.BDY
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
with Unchecked_Deallocation;

package body ASR_String_Utilities is

----------------------------------------------------------------

procedure Free_Scanner is
        new Unchecked_Deallocation(Scan_Record, Scanner);

----------------------------------------------------------------

function Is_Valid(
    T : in Scanner
    ) return BOOLEAN is

begin

    return T /= null;

end Is_Valid;

----------------------------------------------------------------

function Make_Scanner(
    S : in STRING
    ) return Scanner is

    T : Scanner := new Scan_Record;

begin

    T.text := SP.Make_Persistent(S);
    return T;

end Make_Scanner;

----------------------------------------------------------------

procedure Destroy_Scanner(
    T : in out Scanner
    ) is

begin

    if Is_Valid(T) then
        SP.Flush(T.text);
        ST.Destroy(T.mark);
        Free_Scanner(T);
    end if;

end Destroy_Scanner;

----------------------------------------------------------------

function More(
    T : in Scanner
    ) return BOOLEAN is

begin

    if Is_Valid(T) and then T.index <= SP.Length(T.text) then
        return TRUE;
    else
        return FALSE;
    end if;

end More;

----------------------------------------------------------------

function Get(
    T : in Scanner
    ) return CHARACTER is

begin

    if not More(T) then
        raise Out_Of_Bounds;
    end if;
    return SP.Fetch(T.text, T.index);

end Get;

----------------------------------------------------------------

procedure Forward(
    T : in Scanner
    ) is

begin

    if Is_Valid(T) then
        if SP.Length(T.text) >= T.index then
            T.index := T.index + 1;
        end if;
    end if;

end Forward;

----------------------------------------------------------------

procedure Backward(
    T : in Scanner
    ) is

begin

    if Is_Valid(T) then
        if T.index > 1 then
            T.index := T.index - 1;
        end if;
    end if;

end Backward;

----------------------------------------------------------------

procedure Next(
    T : in     Scanner;
    C :    out CHARACTER
    ) is

begin

    C := Get(T);
    T.index := T.index + 1;

end Next;

----------------------------------------------------------------

function Position(
    T : in Scanner
    ) return POSITIVE is

begin

    return T.index;

end Position;

----------------------------------------------------------------

procedure Mark(
    T : in Scanner
    ) is

begin

    if Is_Valid(T) then
        ST.Push(T.mark, T.index);
    end if;

end Mark;

----------------------------------------------------------------

procedure Unmark(
    T : in Scanner
    ) is

    Num : POSITIVE;

begin

    if Is_Valid(T) and then not ST.Is_Empty(T.mark) then
            ST.Pop(T.mark, Num);
    else
        raise Scanner_Not_Marked;
    end if;

end Unmark;

----------------------------------------------------------------

procedure Restore(
    T : in Scanner
    ) is

begin

    if Is_Valid(T) and then not ST.Is_Empty(T.mark) then
        ST.Pop(T.mark, T.index);
    else
        raise Scanner_Not_Marked;
    end if;

end Restore;

----------------------------------------------------------------

function Is_Any(
    T : in Scanner;
    Q : in STRING
    ) return BOOLEAN is

    N     : NATURAL;

begin

    if not More(T) then
        return FALSE;
    end if;
    SP.Mark;
    N := SP.Match_Any(T.text, Q, T.index);
    if N /= T.index then
        N := 0;
    end if;
    SP.Release;
    return N /= 0;

end Is_Any;

----------------------------------------------------------------

procedure Scan_Any(
    T      : in     Scanner;
    Q      : in     STRING;
    Found  :    out BOOLEAN;
    Result : in out SP.String_Type
    ) is

    S_Str : SP.String_Type;
    N     : NATURAL;

begin

    if Is_Any(T, Q) then
        N := SP.Match_None(T.text, Q, T.index);
        if N = 0 then
            N := SP.Length(T.text) + 1;
        end if;
        Result  := SP."&"(Result, SP.Substr(T.text, T.index, N - T.index));
        T.index := N;   
        Found   := TRUE;
    else
        Found := FALSE;
    end if;

end Scan_Any;

----------------------------------------------------------------

function Quoted_String(
    T : in Scanner
    ) return INTEGER is

    Count : INTEGER := 0;
    I     : POSITIVE;
    N     : NATURAL;

begin

    if not More(T) then
        return Count;
    end if;
    I := T.index;
    while Is_Any(T, """") loop
        T.index := T.index + 1;
        if not More(T) then
            T.index := I;
            return 0;
        end if;
        SP.Mark;
        N := SP.Match_Any(T.text, """", T.index);
        SP.Release;
        if N = 0 then
            T.index := I;
            return 0;
        end if;
        T.index := N + 1;
    end loop;
    Count := T.index - I;
    T.index := I;
    return Count;

end Quoted_String;

----------------------------------------------------------------

function Enclosed_String(
    B : in CHARACTER;
    E : in CHARACTER;
    T : in Scanner
    ) return NATURAL is

    Count : NATURAL := 1;
    I     : POSITIVE;
    Inx_B : NATURAL;
    Inx_E : NATURAL;
    Depth : NATURAL := 1;

begin

    if not Is_Any(T, B & "") then
        return 0;
    end if;
    I := T.index;
    T.index := T.index + 1;
    while Depth /= 0 loop
        if not More(T) then
            T.index := I;
            return 0;
        end if;
        SP.Mark;
        Inx_B   := SP.Match_Any(T.text, B & "", T.index);
        Inx_E   := SP.Match_Any(T.text, E & "", T.index);
        SP.Release;
        if Inx_E = 0 then
            T.index := I;
            return 0;
        end if;
        if Inx_B /= 0 and then Inx_B < Inx_E then
            Depth := Depth + 1;
        else
            Inx_B := Inx_E;
            Depth := Depth - 1;
        end if;
        T.index := Inx_B + 1;
    end loop;
    Count := T.index - I;
    T.index := I;
    return Count;

end Enclosed_String;

----------------------------------------------------------------

function Is_Word(
    T : in Scanner
    ) return BOOLEAN is

begin

    if not More(T) then
        return FALSE;
    else
        return not Is_Any(T, White_Space);
    end if;

end Is_Word;

----------------------------------------------------------------

function Is_Number(
    T : in Scanner
    ) return BOOLEAN is

begin

    return Is_Any(T, Number);

end Is_Number;

----------------------------------------------------------------

function Get_Number(
    T      : in     Scanner
    ) return STRING is

    C     : CHARACTER;
    F     : BOOLEAN;
    S_Str : SP.String_Type;

begin

    SP.Mark;
    while Is_Number(T) loop
        Scan_Any(T, Number, F, S_Str);
        if More(T) then
            C := Get(T);
            if C = '_' then
                T.index := T.index + 1;
                if Is_Number(T) then
                    S_Str := SP."&"(S_Str, "_");
                else
                    T.index := T.index - 1;
                end if;
            end if;
        end if;
    end loop;
    declare
        S : STRING (1 .. SP.Length(S_Str));
    begin
        S := SP.Value(S_Str);
        SP.Release;
        return S;
    end;

end Get_Number;

----------------------------------------------------------------

procedure Scan_Number(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out INTEGER;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Number(T) then
        begin
            Mark(T);
            Result := INTEGER'Value(Get_Number(T));
            Unmark(T);
        exception
            when CONSTRAINT_ERROR =>
                Restore(T);
                raise Number_Too_Large;
        end;
        Found := TRUE;
    else
        Found := FALSE;         
    end if;

end Scan_Number;

----------------------------------------------------------------

function Is_Signed_Number(
    T : in Scanner
    ) return BOOLEAN is

    I : POSITIVE;
    C : CHARACTER;
    F : BOOLEAN;

begin

    if not More(T) then
        return FALSE;
    end if;
    I := T.index;
    C := Get(T);
    if C = '+' or C = '-' then
        T.index := T.index + 1;
    end if;
    F := Is_Any(T, Number);
    T.index := I;
    return F;

end Is_Signed_Number;

----------------------------------------------------------------

function Get_Signed_Number(
    T      : in     Scanner
    ) return STRING is

    C     : CHARACTER;

begin

    C := Get(T);
    if C = '+' or C = '-' then
        T.index := T.index + 1;
        return C & Get_Number(T);
    else
        return Get_Number(T);
    end if;     

end Get_Signed_Number;

----------------------------------------------------------------

procedure Scan_Signed_Number(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out INTEGER;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Signed_Number(T) then
        begin
            Mark(T);
            Result := INTEGER'Value(Get_Signed_Number(T));
            Unmark(T);
        exception
            when CONSTRAINT_ERROR =>
                Restore(T);
                raise Number_Too_Large;
        end;
        Found := TRUE;
    else
        Found := FALSE;
    end if;

end Scan_Signed_Number;

----------------------------------------------------------------

function Is_Space(
    T : in Scanner
    ) return BOOLEAN is

begin

    return Is_Any(T, White_Space);

end Is_Space;

----------------------------------------------------------------

procedure Skip_Space(
    T : in Scanner
    ) is

    S_Str : SP.String_Type;
    Found : BOOLEAN;

begin

    SP.Mark;
    Scan_Any(T, White_Space, Found, S_Str);
    SP.Release;

end Skip_Space;

----------------------------------------------------------------

function Is_Ada_Id(
    T : in Scanner
    ) return BOOLEAN is

begin

    return Is_Any(T, Alphabetic);

end Is_Ada_Id;

----------------------------------------------------------------

function Is_Quoted(
    T : in Scanner
    ) return BOOLEAN is

begin

    if Quoted_String(T) = 0 then
        return FALSE;
    else
        return TRUE;
    end if;

end Is_Quoted;

----------------------------------------------------------------

function Is_Enclosed(
    B : in CHARACTER;
    E : in CHARACTER;
    T : in Scanner
    ) return BOOLEAN is

begin

    if Enclosed_String(B, E, T) = 0 then
        return FALSE;
    else
        return TRUE;
    end if;

end Is_Enclosed;

----------------------------------------------------------------

function Is_Sequence(
    Chars  : in STRING;
    T      : in Scanner
    ) return BOOLEAN is

begin

    return Is_Any(T, Chars);

end Is_Sequence;

----------------------------------------------------------------

function Is_Not_Sequence(
    Chars  : in STRING;
    T      : in Scanner
    ) return BOOLEAN is

    N : NATURAL;

begin

    if not More(T) then
        return FALSE;
    end if;
    SP.Mark;
    N := SP.Match_Any(T.text, Chars, T.index);
    if N = T.index then
        N := 0;
    end if;
    SP.Release;
    return N /= 0;

end Is_Not_Sequence;

----------------------------------------------------------------

function Is_Literal(
    Chars  : in STRING;
    T      : in Scanner
    ) return BOOLEAN is

    N : NATURAL;

begin

    if not More(T) then
        return FALSE;
    end if;
    N := SP.Match_S(T.text, Chars, T.index);
    if N /= T.index then
        N := 0;
    end if;
    return N /= 0;

end Is_Literal;

----------------------------------------------------------------

function Is_Not_Literal(
    Chars : in STRING;
    T     : in Scanner
    ) return BOOLEAN is

    N     : NATURAL;

begin

    if not More(T) then
        return FALSE;
    end if;
    SP.Mark;
    N := SP.Match_S(T.text, Chars, T.index);
    if N = T.index then
        N := 0;
    end if;
    SP.Release;
    return N /= 0;

end Is_Not_Literal;

----------------------------------------------------------------

function Match_Character(
    T    : in CHARACTER;
    Char : in STRING
    ) return BOOLEAN is

begin
        
    for j in Char'range loop
        if T = Char(j) then
            return TRUE;
        end if;
    end loop;
    return FALSE;

end Match_Character;

----------------------------------------------------------------

function Strip_Leading(
    Text : in STRING;
    Char : in STRING := " " & ASCII.HT
    ) return STRING is

begin

    for i in Text'range loop
        if not Match_Character(Text(i), Char) then
            return Text(i .. Text'last);
        end if;
    end loop;
    return "";

end Strip_Leading;

----------------------------------------------------------------

function Strip_Trailing(
    Text : in STRING;
    Char : in STRING := " " & ASCII.HT
    ) return STRING is

begin

    for i in reverse Text'range loop
        if not Match_Character(Text(i), Char) then
            return Text(Text'first .. i);
        end if;
    end loop;
    return "";

end Strip_Trailing;

----------------------------------------------------------------

function Strip(
    Text : in STRING;
    Char : in STRING := " " & ASCII.HT
    ) return STRING is

begin 

    return Strip_Leading(STRING'(Strip_Trailing(Text, Char)), Char);

end Strip;

----------------------------------------------------------------

function Justify_String(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER;
    Mode : in Justification_Mode
    ) return STRING is

    Out_String  : STRING (1 .. Len) := (others => Char);
    Temp_String : SP.String_Type;
    Index       : INTEGER;

begin

    SP.Mark;
    Temp_String := SP.Create(Out_String & Text & Out_String); 
    case Mode is
        when LEFT =>
            Index := Len + 1;
        when RIGHT =>
            Index := SP.Length(Temp_String) - Len*2 + 1;
        when CENTER =>
            Index := (SP.Length(Temp_String) - Len)/2 + 2;
        when others =>
            Index := Len + 1;
    end case;
    Out_String := SP.Value(SP.Substr(Temp_String, Index, Len));
    SP.Release;
    return Out_String;

end Justify_String;

----------------------------------------------------------------

function Left_Justify(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return STRING is

begin

    return Justify_String(Text, Len, Char, LEFT);

end Left_Justify;

----------------------------------------------------------------

function Right_Justify(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return STRING is

begin

    return Justify_String(Text, Len, Char, RIGHT);

end Right_Justify;

----------------------------------------------------------------

function Center(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return STRING is

begin

    return Justify_String(Text, Len, Char, CENTER);

end Center;

----------------------------------------------------------------

function Expand(
    Text : in STRING;
    Len  : in POSITIVE
    ) return STRING is

    Out_String : STRING (1 .. Len);
    Count      : INTEGER := 0;
    Size       : INTEGER;
    Inx1, Inx2 : INTEGER;
    S_Str      : SP.String_Type;

begin

    if Len <= Text'length then
        return Justify_String(Text, Len, ' ', LEFT);
    end if;
    for i in Text'range loop
        if Text(i) = ' ' then
            Count := Count + 1;
        end if;
    end loop;
    if Count = 0 then
        return Justify_String(Text, Len, ' ', LEFT);
    end if;
    SP.Mark;
    S_Str := SP.Create(Text);
    Size := (Len - Text'length)/ Count;
    Inx1 := Count/2 - ((Len - Text'length) rem Count)/2 + 1;
    Inx2 := Inx1 + ((Len - Text'length) rem Count) - 1;
    declare
        Fill : STRING(1 .. Size) := (others => ' ');
    begin
        for i in reverse 1 .. SP.Length(S_Str) loop
            if SP.Fetch(S_Str, i) = ' ' then
                S_Str := SP.Insert(S_Str, Fill, i);
                if Inx1 <= Count and Count <= Inx2 then
                    S_Str := SP.Insert(S_Str, " ", i);
                end if;
            Count := Count - 1;
            end if;
        end loop;
    end;
    Out_String := SP.Value(S_Str);
    SP.Release;
    return Out_String;

end Expand;

----------------------------------------------------------------

function Format(
    Text    : in STRING;
    Len     : in POSITIVE;
    Del     : in CHARACTER := ' ';
    Justify : in Justification_Mode := NONE
    ) return SL.List is

    Temp_String : SP.String_Type;
    S_Str       : SP.String_Type;
    Out_List    : SL.List := SL.Create;
    Index1      : INTEGER;
    Index2      : INTEGER;

begin

    SP.Mark;
    Temp_String := SP.Create(Text);
    while SP.Length(Temp_String) > 0 loop 
        if SP.Length(Temp_String) > Len then
            Index1 := Len;
            Index2 := Index1;
            if Del /= ASCII.NUL then
                for i in reverse 2 .. Index1 + 1 loop
                    if SP.Fetch(Temp_String, i) = Del then
                        Index1 := i - 1;                    
                        Index2 := i;                
                        exit;
                    end if;
                end loop;
            end if;
        else
            Index1 := SP.Length(Temp_String);
            Index2 := Index1;
        end if;
        S_Str := SP.Substr(Temp_String, 1, Index1);
        Temp_String := SP.Substr(Temp_String, Index2 + 1, SP.Length(Temp_String) - Index2);
        case Justify is
            when LEFT | NONE =>
                SL.Attach(Out_List, SP.Make_Persistent(
                    STRING'(Justify_String(SP.Value(S_Str), Len, ' ', LEFT))));
            when RIGHT =>
                SL.Attach(Out_List, SP.Make_Persistent(
                    STRING'(Justify_String(SP.Value(S_Str), Len, ' ', RIGHT))));
            when CENTER =>
                SL.Attach(Out_List, SP.Make_Persistent(
                    STRING'(Justify_String(SP.Value(S_Str), Len, ' ', CENTER))));
            when EXPAND =>
                if SP.Length(Temp_String) > 0 then
                    SL.Attach(Out_List, SP.Make_Persistent(
                        STRING'(Expand(SP.Value(S_Str), Len))));
                else
                    SL.Attach(Out_List, SP.Make_Persistent(
                        STRING'(Justify_String(SP.Value(S_Str), Len, ' ', LEFT))));
                end if;
        end case;
    end loop;
    SP.Release;
    return Out_List;

end Format;

----------------------------------------------------------------

function Image(
    Num  : in INTEGER;
    Len  : in NATURAL   := 0;
    Fill : in CHARACTER := ' '
    ) return STRING is

    S_Str  : SP.String_Type;
    Places : INTEGER := Len;
    Size   : INTEGER;

begin

    SP.Mark;
    S_Str := SP.Create(INTEGER'image(Num));
    if SP.Fetch(S_Str, 1) = ' ' then
        S_Str := SP.Substr(S_Str, 2, SP.Length(S_Str) - 1);
    end if;
    Size   := SP.Length(S_Str);
    if Len = 0 then
        Places := Size;
    end if;
    declare
        Temp_Text : STRING (1 .. Places);
    begin
        for i in 1 .. Places - Size loop
            Temp_Text(i) := Fill;
        end loop;
        Temp_Text(Places - Size + 1 .. Temp_Text'last) := SP.Value(S_Str);
        SP.Release;
        return Temp_Text;
    end;
    return "";

end Image;

----------------------------------------------------------------

function Value(
    Text : in STRING
    ) return INTEGER is

    Found      : BOOLEAN;
    Underscore : BOOLEAN := TRUE;

begin

    return INTEGER'Value(Text);

exception
    when CONSTRAINT_ERROR =>
        for i in Text'range loop
            Found := FALSE;
            for j in Number'range loop
                if Text(i) = Number(j) then
                    Underscore := FALSE;
                    Found := TRUE;
                    exit;
                end if;
            end loop;
            if not Found then
                if Text(i) /= '_' then
                    raise Non_Numeric_String;
                elsif Underscore then
                    raise Non_Numeric_String;
                else
                    Underscore := TRUE;
                end if;
            end if;
        end loop;
        raise Number_Too_Large;

end Value;

----------------------------------------------------------------

function Match(
    Pattern    : in STRING;
    Target     : in STRING;
    Wildcard   : in CHARACTER := '*';
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
    ) return BOOLEAN is

    type State_Type is (NONE, TEXT, WILD);

    List     : SL.List := SL.Create;
    Iterator : SL.ListIter;
    Inx      : INTEGER;
    R_Str    : SP.String_Type;
    S_Str    : SP.String_Type;
    Found    : BOOLEAN;
    Previous : State_Type;
    Current  : State_Type;
    Old_Opt  : SP.Comparison_Option;

begin

    Inx := Pattern'first;
    SP.Mark;
    for i in Pattern'range loop
        if Pattern(i) = Wildcard then
            if i > Inx then
                SL.Attach(List, SP.Create(Pattern(Inx .. i - 1)));
            end if;
            SL.Attach(List, SP.Create("" & Wildcard));
            Inx := i + 1;
        end if;
    end loop;
    if Inx <= Pattern'last then
        SL.Attach(List, SP.Create(Pattern(Inx .. Pattern'last)));
    end if;

    Iterator := SL.MakeListIter(List);
    Found := SL.More(Iterator);
    Current := NONE;    
    Inx := Target'first;
    Old_Opt := SP.Get_Comparison_Option;
    SP.Set_Comparison_Option(Comparison);
    while SL.More(Iterator) loop
        SL.Next(Iterator, S_Str);
        Previous := Current;
        if SP.Equal(S_Str, "" & Wildcard) then
            Current := WILD;
        else
            Current := TEXT;
        end if;
        if Current = TEXT then
            Found := FALSE;
            SP.Mark;
            if Previous = NONE and then
               Target'length >= Inx + SP.Length(S_Str) - 1 and then 
               SP.Equal(S_Str, SP.Create(Target(Inx .. Inx + SP.Length(S_Str) - 1))) then
                Inx   := Inx + SP.Length(S_Str);
                Found := TRUE;
            elsif Previous = WILD then
                for i in Inx .. Target'last - SP.Length(S_Str) + 1 loop
                    SP.Mark;
                    if SP.Equal(S_Str, SP.Create(Target(i .. i + SP.Length(S_Str) - 1))) then
                        Inx   := i + SP.Length(S_Str);
                        Found := TRUE;
                    end if;
                    SP.Release;
                end loop;
            end if;
            SP.Release;
        end if;
        exit when not Found;
    end loop;
    if Current = TEXT then
        Found := Inx >= Target'length;
    end if;
    SP.Release;
    SL.Destroy(List);
    SP.Set_Comparison_Option(Old_Opt);
    return Found;

end Match;

----------------------------------------------------------------
pragma page;
package body Generic_String_Utilities is

----------------------------------------------------------------

function Make_Scanner(
    S : in Generic_String_Type
    ) return Scanner is

begin

    return Make_Scanner(From_Generic(S));

end Make_Scanner;

----------------------------------------------------------------

function Get_String(
    T    : in Scanner
    ) return Generic_String_Type is

begin

    if Is_Valid(T) then
        return To_Generic(SP.Value(T.text));
    else
        return To_Generic("");
    end if;

end Get_String;

----------------------------------------------------------------

function Get_Remainder(
    T : in Scanner
    ) return Generic_String_Type is

    S_Str : SP.String_Type;

begin

    if More(T) then
        SP.Mark;
        S_Str := SP.Substr(T.text, T.index, SP.Length(T.text) - T.index + 1);
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            return To_Generic(S);
        end;
    else
        return To_Generic("");
    end if;

end Get_Remainder;

----------------------------------------------------------------

function Get_Segment(
    T    : in Scanner;
    From : in POSITIVE;
    To   : in POSITIVE
    ) return Generic_String_Type is

begin

    if Is_Valid(T) and then
       From < To and then 
       To <= (SP.Length(T.text) + 1)  then
-----------------------------------------------------------------
--  predicate was        To <= SP.Length(T.text) then
--  changed to allow a request that will deliver the last char in string
--  jpw 5May87
-----------------------------------------------------------------
        return To_Generic(SP.Value(T.text)(From .. To - 1));
    else
        return To_Generic("");
    end if;
    

end Get_Segment;

----------------------------------------------------------------

procedure Scan_Word(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    S_Str : SP.String_Type;
    N     : NATURAL;

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Word(T) then
        Found   := TRUE;
        SP.Mark;
        N := SP.Match_Any(T.text, White_Space, T.index);
        if N = 0 then
            N := SP.Length(T.text) + 1;
        end if;
        S_Str := SP.Substr(T.text, T.index, N - T.index);
        T.index := N;   
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            Result  := To_Generic(S);
        end;
    else
        Found   := FALSE;
    end if;

end Scan_Word;

----------------------------------------------------------------

procedure Scan_Number(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Number(T) then
        Found := TRUE;
        Result := To_Generic(Get_Number(T));
    else
        Found := FALSE;
    end if;

end Scan_Number;

----------------------------------------------------------------

procedure Scan_Signed_Number(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Signed_Number(T) then
        Found := TRUE;
        Result := To_Generic(Get_Signed_Number(T));
    else
        Found := FALSE;
    end if;

end Scan_Signed_Number;

----------------------------------------------------------------

procedure Scan_Space(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type
    ) is

    S_Str : SP.String_Type;

begin

    if Is_Any(T, White_Space) then
        SP.Mark;
        Scan_Any(T, White_Space, Found, S_Str);
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            Result := To_Generic(S);
        end;
    else
        Found := FALSE;
    end if;

end Scan_Space;

----------------------------------------------------------------

procedure Scan_Ada_Id(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    S_Str : SP.String_Type;
    Num   : NATURAL;
    Mark  : POSITIVE;

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Ada_Id(T) then
        SP.Mark;
        Mark := T.index;
        Scan_Any(T, Alphabetic & Number & '_', Found, S_Str);
        Num := SP.Match_S(S_Str, "__");
        if Num /= 0 then
            S_Str := SP.Substr(S_Str, 1, Num -1);
            Mark := Mark + Num - 1;
        else
            Num := SP.Length(S_Str);
            if SP.Fetch(S_Str, Num) = '_' then
                S_Str := SP.Substr(S_Str, 1, Num - 1);
                Mark := Mark + Num - 1;
            else
                Mark := Mark + Num;
            end if;
        end if;
        T.index := Mark;
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            Result := To_Generic(S);
        end;
    else
        Found := FALSE;
    end if;

end Scan_Ada_Id;

----------------------------------------------------------------

procedure Scan_Quoted(
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    S_Str : SP.String_Type;
    Count : INTEGER;

begin
--  jpw 30jun93
--  the assertion (in the spec) that double quotes are replaced by single quotes
--  was never implemented.  Annotated lines by jpw corrects this oversight.
    if Skip then
        Skip_Space(T);
    end if;
    Count := Quoted_String(T);
    if Count /= 0 then
        Found := TRUE;
        Count := Count - 2;
        T.index := T.index + 1;
        if Count /= 0 then
            SP.Mark;
            S_Str := SP.Substr(T.text, T.index, POSITIVE(Count));
            declare
		USE SP ;				--  jpw
                S : STRING (1 .. SP.Length(S_Str));
		i : integer  := S'First ;		--  jpw
		single_quote : Boolean ;		--  jpw
		Empty        : String (1..0) ;		--  jpw
		corrected    : String_Type := Create (Empty) ;
            begin
                S := SP.Value(S_Str);
		while i <= S'Length LOOP		--  jpw
		    single_quote := False ;
		    corrected := corrected & s(i..i) ;
		    IF s(i) = Ascii.Quotation THEN
			single_quote := True ;
		    END IF ;
		    i := i + 1 ;
		    IF single_quote THEN
			IF i <= S'Last AND THEN s(i) = Ascii.Quotation THEN
			--  two adjacent " chars ... elide second
			    i := i + 1 ;
			END IF ;
		    END IF ;
		END LOOP ; 				--  jpw (end of test loop)
		declare					--  jpw coerces Corrected string-type
		    S_Corrected : String (1..Length (Corrected)) ;
		begin
		    S_Corrected := SP.Value (Corrected) ;
		    SP.Release;
		    Result := To_Generic(S_Corrected);
		end ;
            end;
        else
            Result := To_Generic("");
        end if;
        T.index := T.index + Count + 1;
    else
        Found := FALSE;
    end if;

end Scan_Quoted;

----------------------------------------------------------------

procedure Scan_Enclosed(
    B      : in     CHARACTER;
    E      : in     CHARACTER;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    S_Str : SP.String_Type;
    Count : NATURAL;

begin

    if Skip then
        Skip_Space(T);
    end if;
    Count := Enclosed_String(B, E, T);
    if Count /= 0 then
        Found := TRUE;
        Count := Count - 2;
        T.index := T.index + 1;
        if Count /= 0 then
            SP.Mark;
            S_Str := SP.Substr(T.text, T.index, POSITIVE(Count));
            declare
                S : STRING (1 .. SP.Length(S_Str));
            begin
                S := SP.Value(S_Str);
                SP.Release;
                Result := To_Generic(S);
            end;
        else
            Result := To_Generic("");
        end if;
        T.index := T.index + Count + 1;
    else
        Found := FALSE;
    end if;

end Scan_Enclosed;

----------------------------------------------------------------

function Is_Sequence(
    Chars  : in Generic_String_Type;
    T      : in Scanner
    ) return BOOLEAN is

begin

    return Is_Any(T, From_Generic(Chars));

end Is_Sequence;

----------------------------------------------------------------

procedure Scan_Sequence(
    Chars  : in     Generic_String_Type;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    Scan_Sequence(From_Generic(Chars), T, Found, Result, Skip);

end Scan_Sequence;

----------------------------------------------------------------

procedure Scan_Sequence(
    Chars  : in     STRING;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    I     : POSITIVE;
    Count : INTEGER := 0;
    S_Str : SP.String_Type;

begin

    if Skip then
        Skip_Space(T);
    end if;
    if not Is_Valid(T) then
        Found := FALSE;
        return;
    end if;
    I := T.index;
    while Is_Any(T, Chars) loop
        T.index := T.index + 1;
        Count := Count + 1;
    end loop;
    if Count /= 0 then
        Found  := TRUE;
        SP.Mark;
        S_Str := SP.Substr(T.text, I, POSITIVE(Count));
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            Result := To_Generic(S);
        end;
    else
        Found := FALSE;
    end if;

end Scan_Sequence;

----------------------------------------------------------------

function Is_Not_Sequence(
    Chars  : in Generic_String_Type;
    T      : in Scanner
    ) return BOOLEAN is

begin

    return Is_Not_Sequence(From_Generic(Chars), T);

end Is_Not_Sequence;

----------------------------------------------------------------

procedure Scan_Not_Sequence(
    Chars  : in     STRING;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    S_Str : SP.String_Type;
    N     : NATURAL;

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Not_Sequence(Chars, T) then
        Found   := TRUE;
        SP.Mark;
        N := SP.Match_Any(T.text, Chars, T.index);
        S_Str := SP.Substr(T.text, T.index, N - T.index);
        T.index := N;
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            Result := To_Generic(S);
        end;
    else
        Found := FALSE;
    end if;

end Scan_Not_Sequence;

----------------------------------------------------------------

procedure Scan_Not_Sequence(
    Chars  : in     Generic_String_Type;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    Scan_Not_Sequence(From_Generic(Chars), T, Found, Result, Skip);

end Scan_Not_Sequence;

----------------------------------------------------------------

function Is_Literal(
    Chars  : in Generic_String_Type;
    T      : in Scanner
    ) return BOOLEAN is

begin

    return Is_Literal(From_Generic(Chars), T);

end Is_Literal;

----------------------------------------------------------------

procedure Scan_Literal(
    Chars  : in     STRING;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Literal(Chars, T) then
        T.index := T.index + Chars'length;
        Found   := TRUE;
    else
        Found   := FALSE;
    end if;

end Scan_Literal;

----------------------------------------------------------------

procedure Scan_Literal(
    Chars  : in     Generic_String_Type;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    Scan_Literal(From_Generic(Chars), T, Found, Skip);

end Scan_Literal;

----------------------------------------------------------------

function Is_Not_Literal(
    Chars : in Generic_String_Type;
    T     : in Scanner
    ) return BOOLEAN is

begin

    return Is_Not_Literal(From_Generic(Chars), T);

end Is_Not_Literal;

----------------------------------------------------------------

procedure Scan_Not_Literal(
    Chars  : in     STRING;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

    S_Str : SP.String_Type;
    N     : NATURAL;

begin

    if Skip then
        Skip_Space(T);
    end if;
    if Is_Not_Literal(Chars, T) then
        Found   := TRUE;
        SP.Mark;
        N := SP.Match_S(T.text, Chars, T.index);
        S_Str := SP.Substr(T.text, T.index, N - T.index);
        T.index := N;
        declare
            S : STRING (1 .. SP.Length(S_Str));
        begin
            S := SP.Value(S_Str);
            SP.Release;
            Result := To_Generic(S);
        end;
    else
        Found := FALSE;
    end if;

end Scan_Not_Literal;

----------------------------------------------------------------

procedure Scan_Not_Literal(
    Chars  : in     Generic_String_Type;
    T      : in     Scanner;
    Found  :    out BOOLEAN;
    Result :    out Generic_String_Type;
    Skip   : in     BOOLEAN := FALSE
    ) is

begin

    Scan_Not_Literal(From_Generic(Chars), T, Found, Result, Skip);

end Scan_Not_Literal;

----------------------------------------------------------------

function Strip_Leading(
    Text : in Generic_String_Type;
    Char : in STRING := " " & ASCII.HT
    ) return STRING is

begin

    return Strip_Leading(From_Generic(Text), Char);

end Strip_Leading;

----------------------------------------------------------------

function Strip_Leading(
    Text : in STRING;
    Char : in STRING := " " & ASCII.HT
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Strip_Leading(Text, Char)));

end Strip_Leading;

----------------------------------------------------------------

function Strip_Leading(
    Text : in Generic_String_Type;
    Char : in STRING := " " & ASCII.HT
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Strip_Leading(From_Generic(Text), Char)));

end Strip_Leading;

----------------------------------------------------------------

function Strip_Trailing(
    Text : in Generic_String_Type;
    Char : in STRING := " " & ASCII.HT
    ) return STRING is

begin

    return Strip_Trailing(From_Generic(Text), Char);

end Strip_Trailing;

----------------------------------------------------------------

function Strip_Trailing(
    Text : in STRING;
    Char : in STRING := " " & ASCII.HT
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Strip_Trailing(Text, Char)));

end Strip_Trailing;

----------------------------------------------------------------

function Strip_Trailing(
    Text : in Generic_String_Type;
    Char : in STRING := " " & ASCII.HT
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Strip_Trailing(From_Generic(Text), Char)));

end Strip_Trailing;

----------------------------------------------------------------

function Strip( 
    Text : in Generic_String_Type;
    Char : in STRING := " " & ASCII.HT
    ) return STRING is

begin

    return Strip_Leading(STRING'(Strip_Trailing(From_Generic(Text), Char)), Char);

end Strip;

----------------------------------------------------------------

function Strip(
    Text : in STRING;
    Char : in STRING := " " & ASCII.HT
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Strip_Leading(STRING'(Strip_Trailing(Text, Char)), Char)));

end Strip;

----------------------------------------------------------------

function Strip(
    Text : in Generic_String_Type;
    Char : in STRING := " " & ASCII.HT
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Strip_Leading(STRING'(Strip_Trailing(From_Generic(Text), Char)), Char)));

end Strip;

----------------------------------------------------------------

function Left_Justify(
    Text : in Generic_String_Type;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return STRING is

begin

    return Justify_String(From_Generic(Text), Len, Char, LEFT);

end Left_Justify;

----------------------------------------------------------------

function Left_Justify(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(Justify_String(Text, Len, Char, LEFT));

end Left_Justify;

----------------------------------------------------------------

function Left_Justify(
    Text : in Generic_String_Type;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(Justify_String(From_Generic(Text), Len, Char, LEFT));

end Left_Justify;

----------------------------------------------------------------

function Right_Justify(
    Text : in Generic_String_Type;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return STRING is

begin

    return Justify_String(From_Generic(Text), Len, Char, RIGHT);

end Right_Justify;

----------------------------------------------------------------

function Right_Justify(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(Justify_String(Text, Len, Char, RIGHT));

end Right_Justify;

----------------------------------------------------------------

function Right_Justify(
    Text : in Generic_String_Type;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(Justify_String(From_Generic(Text), Len, Char, RIGHT));

end Right_Justify;

----------------------------------------------------------------

function Center(
    Text : in Generic_String_Type;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return STRING is

begin

    return Justify_String(From_Generic(Text), Len, Char, CENTER);

end Center;

----------------------------------------------------------------

function Center(
    Text : in STRING;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(Justify_String(Text, Len, Char, CENTER));

end Center;

----------------------------------------------------------------

function Center(
    Text : in Generic_String_Type;
    Len  : in POSITIVE;
    Char : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(Justify_String(From_Generic(Text), Len, Char, CENTER));

end Center;

----------------------------------------------------------------

function Expand(
    Text : in Generic_String_Type;
    Len  : in POSITIVE
    ) return STRING is

begin

    return Expand(From_Generic(Text), Len);

end Expand;

----------------------------------------------------------------

function Expand(
    Text : in STRING;
    Len  : in POSITIVE
    ) return Generic_String_Type is

begin

    return To_Generic(Expand(Text, Len));

end Expand;

----------------------------------------------------------------

function Expand(
    Text : in Generic_String_Type;
    Len  : in POSITIVE
    ) return Generic_String_Type is

begin

    return To_Generic(Expand(From_Generic(Text), Len));

end Expand;

----------------------------------------------------------------

function Format(
    Text    : in Generic_String_Type;
    Len     : in POSITIVE;
    Del     : in CHARACTER := ' ';
    Justify : in Justification_Mode := NONE
    ) return SL.List is

begin

    return Format(From_Generic(Text), Len, Del, Justify);

end Format;

----------------------------------------------------------------

function Image(
    Num  : in INTEGER;
    Len  : in NATURAL   := 0;
    Fill : in CHARACTER := ' '
    ) return Generic_String_Type is

begin

    return To_Generic(STRING'(Image(Num, Len, Fill)));

end Image;

----------------------------------------------------------------

function Value(
    Text : in Generic_String_Type
    ) return INTEGER is

begin

    return Value(STRING'(From_Generic(Text)));

end Value;

----------------------------------------------------------------

function Match(
    Pattern    : in Generic_String_Type;
    Target     : in STRING;
    Wildcard   : in CHARACTER := '*';
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
    ) return BOOLEAN is

begin

    return Match(From_Generic(Pattern),
                 Target,
                 Wildcard,
                 Comparison);

end Match;

----------------------------------------------------------------

function Match(
    Pattern    : in STRING;
    Target     : in Generic_String_Type;
    Wildcard   : in CHARACTER := '*';
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
    ) return BOOLEAN is

begin

    return Match(Pattern,
                 From_Generic(Target),
                 Wildcard,
                 Comparison);

end Match;

----------------------------------------------------------------

function Match(
    Pattern    : in Generic_String_Type;
    Target     : in Generic_String_Type;
    Wildcard   : in CHARACTER := '*';
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
    ) return BOOLEAN is

begin

    return Match(From_Generic(Pattern),
                 From_Generic(Target),
                 Wildcard,
                 Comparison);

end Match;

----------------------------------------------------------------


end Generic_String_Utilities;

end ASR_String_Utilities;
