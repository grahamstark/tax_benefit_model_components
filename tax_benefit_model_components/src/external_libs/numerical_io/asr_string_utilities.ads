--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--SUTILS.SPC
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
with String_Pkg;
with Stack_Pkg;
with String_Lists;

package ASR_String_Utilities is

--| Functions for scanning tokens from strings.
pragma page;
--| Overview
--| This package provides a set of functions used to scan tokens from
--| strings.  After the function make_Scanner is called to convert a string
--| into a string Scanner, the following functions may be called to scan
--| various tokens from the string:
--|-
--| Make_Scanner        Given a string returns a Scanner
--| Make_Scanner*       Given a string returns a Scanner
--| More                Return TRUE iff unscanned characters remain
--| Forward             Bump the Scanner
--| Backward            Bump back the Scanner
--| Get                 Return character 
--| Next                Return character and bump the Scanner
--| Get_String*         Return Generic_String_Type in Scanner
--| Get_Remainder*      Return Generic_String_Type in Scanner from current Index
--| Get_Segment*        Return Generic_String_Type in Scanner as specified
--| Mark                Mark the current Index for Restore 
--| Unmark              Remove the previous mark from the Scanner
--| Restore             Restore the previously marked Index
--| Position            Return the current position of the Scanner
--| Destroy_Scanner     Free storage used by Scanner
--| Is_Word             Return TRUE iff Scanner is at a non-blank character
--| Scan_Word*          Return sequence of non blank characters
--| Is_Number           Return TRUE iff Scanner is at a digit
--| Scan_Number*        Return sequence of decimal digits
--| Scan_Number         Return integer number
--| Is_Signed_Number    Return TRUE iff Scanner is at a digit or sign
--| Scan_Signed_Number* Return sequence of decimal digits with optional sign (+/-)
--| Scan_Signed_Number  Return integer number
--| Is_Space            Return TRUE iff Scanner is at a space or tab
--| Scan_Space*         Return sequence of spaces or tabs
--| Skip_Space          Advance Scanner past white space
--| Is_Ada_Id           Return TRUE iff Scanner is at first character of a possible Ada id
--| Scan_Ada_Id*        Scan up to the character which are valid Ada identifier
--| Is_Quoted           Return TRUE iff Scanner is at a double quote
--| Scan_Quoted*        Scan quoted string, embedded quotes doubled
--| Is_Enclosed         Return TRUE iff Scanner is at an enclosing character
--| Scan_Enclosed*      Scan enclosed string, embedded enclosing character doubled
--| Is_Sequence         Return TRUE iff Scanner is at some character in sequence
--| Is_Sequence*        Return TRUE iff Scanner is at some character in sequence
--| Scan_Sequenc* (2)   Scan user specified sequence of chars
--| Is_Not_Sequence     Return TRUE iff Scanner is not at the characters in sequence
--| Is_Not_Sequence*    Return TRUE iff Scanner is not at the characters in sequence
--| Scan_Not_Sequence* (2)
--|                     Scan string up to but not including a given sequence of chars
--| Is_Literal          Return TRUE iff Scanner is at literal
--| Is_Literal*         Return TRUE iff Scanner is at literal
--| Scan_Literal* (2)   Scan user specified literal
--| Is_Not_Literal      Return TRUE iff Scanner is not a given literal
--| Is_Not_Literal*     Return TRUE iff Scanner is not a given literal
--| Scan_Not_Literal* (2)
--|                     Scan string up to but not including a given literal
--| Strip_Leading       Strip leading characters from a given string
--| Strip_Leading* (3)  Strip leading characters from a given string
--| Strip_Trailing      Strip trailing characters from a given string
--| Strip_Trailing* (3) Strip trailing characters from a given string
--| Strip               Strip both leading and trailing characters
--| Strip* (3)          Strip both leading and trailing characters
--| Left_Justify        Left justify a given string
--| Left_Justify* (3)   Left justify a given string
--| Right_Justify       Right justify a given string
--| Right_Justify* (3)  Right justify a given string
--| Center              Center a given string
--| Center* (3)         Center a given string
--| Expand              Fill and justify a given string 
--| Expand* (3)         Fill and justify a given string
--| Format              Format a given string
--| Format*             Format a given string
--| Image               Convert an integer to a string
--| Image*              Convert an integer to a string
--| Value               Convert a string to an integer
--| Value*              Convert a string to an integer
--| Match               Return TRUE if a string matches another 
--| Match* (3)          Return TRUE if a string matches another 
--|
--|     nb : Operations followed by an asterisk (*) are generic operations
--|+
pragma page;
----------------------------------------------------------------

White_Space   : constant STRING := " " & ASCII.HT;
Number        : constant STRING := "0123456789";
Alphabetic    : constant STRING := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
Alphameric    : constant STRING := Alphabetic & Number;

----------------------------------------------------------------

package SL renames String_Lists;

package SP renames String_Pkg;

----------------------------------------------------------------

type Scanner is private;        --| Scanner type

type Justification_Mode is (NONE, LEFT, RIGHT, CENTER, EXPAND);

----------------------------------------------------------------

Out_Of_Bounds      : exception; --| Raised when a operation is attempted on a
                                --| Scanner that has passed the end
Scanner_Not_Marked : exception; --| Raised when a Unmark or Restore is attemped
                                --| on a Scanner that has not been marked
Non_Numeric_String : exception; --| Raised when an attempt is made to take the
                                --| value of a string that is not a number
Number_Too_Large   : exception; --| Raised when an attempt is made to scan a
                                --| number outside the implemented range
pragma page;
----------------------------------------------------------------

function Make_Scanner(                  --| Construct a Scanner from S.
    S : in STRING                       --| String to be scanned.
    ) return Scanner;

--| Effects: Construct a Scanner from S.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function More(                          --| Check if Scanner is exhausted
    T : in Scanner                      --| Scanner to check
    ) return BOOLEAN;

--| Effects: Return TRUE iff additional characters remain to be scanned.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Forward(                      --| Bump scanner
    T : in Scanner                      --| Scanner
    );

--| Effects: Update the scanner position.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Backward(                     --| Bump back scanner
    T : in Scanner                      --| Scanner
    );

--| Effects: Update the scanner position.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Get(                           --| Return character
    T : in     Scanner                  --| Scanner to check
    ) return CHARACTER;

--| Raises: Out_Of_Bounds
--| Effects: Return character at the current Scanner position.
--| The scanner position remains unchanged.
--| N/A: Modifies, Errors
pragma page;
----------------------------------------------------------------

procedure Next(                         --| Return character and bump scanner
    T : in     Scanner;                 --| Scanner to check
    C :    out CHARACTER                --| Character to be returned
    );

--| Raises: Out_Of_Bounds
--| Effects: Return character at the current Scanner position and update
--| the position.
--| N/A: Modifies, Errors

----------------------------------------------------------------

function Position(                      --| Return current Scanner position
    T : in Scanner                      --| Scanner to check
    ) return POSITIVE;

--| Raises: Out_Of_Bounds
--| Effects: Return a positive integer indicating the current Scanner position,
--| N/A: Modifies, Errors

----------------------------------------------------------------

procedure Mark(
    T : in Scanner
    );

--| Effects: Mark the current index for possible future use
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Unmark(
    T : in Scanner
    );

--| Raises: Scanner_Not_Marked
--| Effects: removes previous mark from the scanner without change to the index
--| N/A: Modifies, Errors

----------------------------------------------------------------

procedure Restore(
    T : in Scanner
    );

--| Raises: Scanner_Not_Marked
--| Effects: Restore the index to the previously marked value
--| N/A: Modifies, Errors

----------------------------------------------------------------

procedure Destroy_Scanner(              --| Free Scanner storage
    T : in out Scanner                  --| Scanner to be freed
    );

--| Effects: Free space occupied by the Scanner.
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Number(                     --| Return TRUE iff Scanner is at a decimal digit
    T : in Scanner                      --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff Scan_Number would return a non-null string.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Number(                  --| Scan sequence of digits
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff one or more digits found
    Result :    out INTEGER;            --| Number scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of digits.
--| If at least one is found, return Found => TRUE, Result => <the digits>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Signed_Number(              --| Check if Scanner is at a decimal digit or
                                        --| sign (+/-)
    T : in Scanner                      --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff Scan_Signed_Number would return a non-null string.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Signed_Number(           --| Scan signed sequence of digits 
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff one or more digits found
    Result :    out INTEGER;            --| Number scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of digits preceeded with optional sign.
--| If at least one digit is found, return Found => TRUE, Result => <digits>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Word(                       --| Check if Scanner is at the start of a word.
    T : in Scanner                      --| Scanner to check
    ) return BOOLEAN;

--| Effects: Return TRUE iff Scanner is at the start of a word.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Space(                      --| Check if T is at a space or tab
    T : in Scanner                      --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff Scan_Space would return a non-null string.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Skip_Space(                   --| Skip white space
    T : in Scanner                      --| String to be scanned
    );

--| Effects: Scan T past all white space (spaces and tabs).  
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Ada_Id(                     --| Check if T is at an Ada identifier
    T : in Scanner                      --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff Scan_Ada_Id would return a non-null string.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Quoted(                     --| Check if T is at a double quote
    T : in Scanner                      --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is at a quoted string (eg. ... "Hello" ...).
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Enclosed(                   --| Check if T is at an enclosing character
    B : in CHARACTER;                   --| Enclosing open character
    E : in CHARACTER;                   --| Enclosing close character
    T : in Scanner                      --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T as encosed by B and E (eg. ... [ABC] ...).
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Sequence(                   --| Check if T is at some sequence characters 
    Chars : in STRING;                  --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is at some character of Chars.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Not_Sequence(               --| Check if T is at some sequence of characters 
    Chars : in STRING;                  --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is not at some character of Chars.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Literal(                    --| Check if T is at literal Chars
    Chars : in STRING;                  --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is at literal Chars.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Is_Not_Literal(                --| Check if T is not at literal Chars
    Chars : in STRING;                  --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is not at literal Chars
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Strip_Leading(         --| Strip leading characters from a given string
    Text : in STRING;           --| Input string
    Char : in STRING := " " & ASCII.HT
                                --| Character(s) to be stripped
    ) return STRING;            --| Result string 

--| Effects: The specified leading characters are stripped from the input text
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip_Trailing(        --| Strip trailing characters from a given string
    Text : in STRING;           --| Input string
    Char : in STRING := " " & ASCII.HT
                                --| Character(s) to be stripped
    ) return STRING;            --| Result string 

--| Effects: The given trailing characters are stripped from the input text
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip(                 --| Strip both leading and trailing characters  
                                --| from a given string
    Text : in STRING;           --| Input string
    Char : in STRING := " " & ASCII.HT
                                --| Character(s) to be stripped
    ) return STRING;            --| Result string 

--| Effects: The specified characters are stripped from the input text in both
--| leading and trailing positions
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Left_Justify(          --| Left justify a given string
    Text : in STRING;           --| Input string
    Len  : in POSITIVE;         --| Output string length
    Char : in CHARACTER := ' '  --| Fill character
    ) return STRING;            --| Result string 

--| Effects: The specified input string is placed left justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Right_Justify(         --| Right justify a given string
    Text : in STRING;           --| Input string
    Len  : in POSITIVE;         --| Output string length
    Char : in CHARACTER := ' '  --| Fill character
    ) return STRING;            --| Result string 

--| Effects: The specified input string is placed right justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Center(                --| Center a given string
    Text : in STRING;           --| Input string
    Len  : in POSITIVE;         --| Output string length
    Char : in CHARACTER := ' '  --| Fill character
    ) return STRING;            --| Result string 

--| Effects: The specified input string is placed centered and padded if needed
--| with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Expand(                --| Expand a given string to Len
    Text : in STRING;           --| Input string
    Len  : in POSITIVE          --| Output string length
    ) return STRING;            --| Result string 

--| Effects: The specified input string is expanded to Len with blanks.
--| (eg. "Expand this string to 40 chars" when Len equals 40 will be
--| "Expand   this   string   to   40   chars")
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Format(                --| Format a given string
    Text    : in STRING;        --| Input string
    Len     : in POSITIVE;      --| Length of each folded line
    Del     : in CHARACTER := ' ';
                                --| Delimiting character
    Justify : in Justification_Mode := NONE
                                --| Justification mode
    ) return SL.List;

--| Effects: The specified string is folded into as many lines of Len as needed.
--| The character Del indicated an element of the input string where the
--| line may be "broken".  Returned list consists of persistent string types
--| thus must be flushed (or DestroyDeep with Flush).
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Image(                 --| Convert an integer to a string
    Num  : in INTEGER;          --| Input number
    Len  : in NATURAL   := 0;   --| Length of the output string
    Fill : in CHARACTER := ' '  --| Fill character
    ) return STRING;

--| Effects: The specified integer is converted into a string of length Len.
--| Len of 0 implies that the converted integer fills the string.
--| If Len (other thatn 0) is too small to contain the converted string
--| the number is truncated.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Value(                 --| Convert a string to an integer
    Text : in STRING            --| String to be converted
    ) return INTEGER;

--| Raises: Non_Numeric_String, Number_Too_Large
--| Effects: The specified string is converted into an equivalent integer.
--| The string must have the syntax of an Ada INTEGER (LRM 2.4.1)
--| N/A: Modifies, Errors

----------------------------------------------------------------

function Match(                 --| Match two strings
    Pattern    : in STRING;     --| String to match
    Target     : in STRING;     --| String to be searched
    Wildcard   : in CHARACTER := '*';
                                --| Wildcard character
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
                                --| Case sensitivity in comparison
    ) return BOOLEAN;

--| Effects: The specified Pattern containing Wildcard character(s) are
--| searched on Target.  If Target satisfies the condition in Pattern
--| returns TRUE.
--| (eg. Match("A*B*", "AzzzBzzz") will return TRUE
--|      Match("A*B*", "zzzABzzz") will return FALSE)
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------
pragma page;
generic

    type Generic_String_Type is private;
    with function To_Generic (X : in STRING) return Generic_String_Type;
    with function From_Generic (X : in Generic_String_Type) return STRING;

package Generic_String_Utilities is

----------------------------------------------------------------

function Make_Scanner(                  --| Construct a Scanner from S.
    S : in Generic_String_Type          --| String to be scanned.
    ) return Scanner;

--| Effects: Construct a Scanner from S.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Get_String(                    --| Return contents of Scanner
    T    : in Scanner                   --| Scanner
    ) return Generic_String_Type;

--| Effects: Return a Generic_String_Type corresponding to the contents
--| of the Scanner
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Get_Remainder(                 --| Return contents of Scanner from index
    T : in Scanner
    ) return Generic_String_Type;

--| Effects: Return a Generic_String_Type starting at the current index
--| of the Scanner
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Get_Segment(                   --| Return contents of Scanner
    T    : in Scanner;                  --| Scanner
    From : in POSITIVE;                 --| Starting position
    To   : in POSITIVE                  --| Ending position
    ) return Generic_String_Type;

--| Effects: Return a Generic_String_Type corresponding to the contents
--| of the Scanner starting at From and end at but NOT including To.
--| (eg. Given a scanner T that contains : $123.45
--|  Get_Segment(T, 2, 5) will return a Generic_String_Type containing 123
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Word(                    --| Scan sequence of non blank characters
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a word found
    Result :    out Generic_String_Type;--| Word scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of non blank 
--| characters.  If at least one is found, return Found => TRUE, 
--| Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.

--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------
pragma page;
procedure Scan_Number(                  --| Scan sequence of digits
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff one or more digits found
    Result :    out Generic_String_Type;--| Number scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of digits.
--| If at least one is found, return Found => TRUE, Result => <the digits>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Signed_Number(           --| Scan signed sequence of digits 
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff one or more digits found
    Result :    out Generic_String_Type;--| Number scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of digits preceeded with optional sign.
--| If at least one digit is found, return Found => TRUE, 
--| Result => <the digits>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Space(                   --| Scan sequence of white space characters
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff space found
    Result :    out Generic_String_Type --| Spaces scanned from string
    );

--| Effects: Scan T past all white space (spaces
--| and tabs.  If at least one is found, return Found => TRUE,
--| Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

procedure Scan_Ada_Id(                  --| Scan Ada identifier
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff an Ada identifier found
    Result :    out Generic_String_Type;--| Identifier scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a valid Ada identifier.
--| If one is found, return Found => TRUE, Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Quoted(                  --| Scan a quoted string
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a quoted string found
    Result :    out Generic_String_Type;--| Quoted string scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan at T for an opening quote
--| followed by a sequence of characters and ending with a closing
--| quote.  If successful, return Found => TRUE, Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| A pair of quotes within the quoted string is converted to a single quote.
--| The outer quotes are stripped. 
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Enclosed(                --| Scan an enclosed string
    B      : in CHARACTER;              --| Enclosing open character
    E      : in CHARACTER;              --| Enclosing close character
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a quoted string found
    Result :    out Generic_String_Type;--| Quoted string scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan at T for an enclosing character
--| followed by a sequence of characters and ending with an enclosing character.
--| If successful, return Found => TRUE, Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| The enclosing characters are stripped. 
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Sequence(                   --| Check if T is at some sequence characters 
    Chars : in Generic_String_Type;     --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is at some character of Chars.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Sequence(                --| Scan arbitrary sequence of characters
    Chars  : in     Generic_String_Type;--| Characters that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Result :    out Generic_String_Type;--| Sequence scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of characters C such that C appears in 
--| Char.  If at least one is found, return Found => TRUE, 
--| Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Sequence(                --| Scan arbitrary sequence of characters
    Chars  : in     STRING;             --| Characters that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Result :    out Generic_String_Type;--| Sequence scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of characters C such that C appears in 
--| Char.  If at least one is found, return Found => TRUE, 
--| Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Not_Sequence(               --| Check if T is not at some seuqnce of character 
    Chars : in Generic_String_Type;     --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is not at some character of Chars.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Not_Sequence(            --| Scan arbitrary sequence of characters
    Chars  : in     Generic_String_Type;--| Characters that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Result :    out Generic_String_Type;--| Sequence scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of characters C such that C does not appear
--| in Chars.  If at least one such C is found, return Found => TRUE, 
--| Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Not_Sequence(            --| Scan arbitrary sequence of characters
    Chars  : in     STRING;             --| Characters that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Result :    out Generic_String_Type;--| Sequence scanned from string
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a sequence of characters C such that C does not appear
--| in Chars.  If at least one such C is found, return Found => TRUE, 
--| Result => <the characters>.
--| Otherwise return Found => FALSE and Result is unpredictable.
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Literal(                    --| Check if T is at literal Chars
    Chars : in Generic_String_Type;     --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is at literal Chars.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Literal(                 --| Scan arbitrary literal
    Chars  : in     STRING;             --| Literal that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a litral Chars such that Char matches the sequence
--| of characters in T.  If found, return Found => TRUE, 
--| Otherwise return Found => FALSE
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Literal(                 --| Scan arbitrary literal
    Chars  : in     Generic_String_Type;--| Literal that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a litral Chars such that Char matches the sequence
--| of characters in T.  If found, return Found => TRUE, 
--| Otherwise return Found => FALSE
--| N/A: Raises, Modifies, Errors
pragma page;
----------------------------------------------------------------

function Is_Not_Literal(                --| Check if T is not at literal Chars
    Chars : in Generic_String_Type;     --| Characters to be scanned
    T     : in Scanner                  --| The string being scanned
    ) return BOOLEAN;

--| Effects: Return TRUE iff T is not at literal Chars
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Not_Literal(             --| Scan arbitrary literal
    Chars  : in     STRING;             --| Literal that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Result :    out Generic_String_Type;--| String up to literal
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a litral Chars such that Char does not match the
--| sequence of characters in T.  If found, return Found => TRUE, 
--| Otherwise return Found => FALSE
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

procedure Scan_Not_Literal(             --| Scan arbitrary literal
    Chars  : in     Generic_String_Type;--| Literal that should be scanned
    T      : in     Scanner;            --| String to be scanned
    Found  :    out BOOLEAN;            --| TRUE iff a sequence found
    Result :    out Generic_String_Type;--| String up to literal
    Skip   : in     BOOLEAN := FALSE    --| Skip white spaces before scan
    );

--| Effects: Scan T for a litral Chars such that Char does not match the
--| sequence of characters in T.  If found, return Found => TRUE, 
--| Otherwise return Found => FALSE
--| N/A: Raises, Modifies, Errors

pragma page;
----------------------------------------------------------------

function Strip_Leading(                 --| Strip leading characters from a given string
    Text : in Generic_String_Type;      --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return STRING;                    --| Result string 

--| Effects: The specified leading characters are stripped from the input text.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip_Leading(                 --| Strip leading characters from a given string
    Text : in STRING;                   --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified leading characters are stripped from the input text.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip_Leading(                 --| Strip leading characters from a given string
    Text : in Generic_String_Type;      --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified leading characters are stripped from the input text.
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Strip_Trailing(                --| Strip trailing characters from a given string
    Text : in Generic_String_Type;      --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return STRING;                    --| Result string 

--| Effects: The specified trailing characters are stripped from the input text.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip_Trailing(                --| Strip trailing characters from a given string
    Text : in STRING;                   --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified trailing characters are stripped from the input text.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip_Trailing(                --| Strip trailing characters from a given string
    Text : in Generic_String_Type;      --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified trailing characters are stripped from the input text.
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Strip(                         --| Strip both leading and trailing
                                        --| characters from a given string
    Text : in Generic_String_Type;      --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return STRING;                    --| Result string 

--| Effects: The specified characters if any are stripped from the input text
--| in both leading and trailing positions.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip(                         --| Strip both leading and trailing
                                        --| characters from a given string
    Text : in STRING;                   --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified characters if any are stripped from the input text
--| in both leading and trailing positions.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Strip(                         --| Strip both leading and trailing
                                        --| characters from a given string
    Text : in Generic_String_Type;      --| Input string
    Char : in STRING := " " & ASCII.HT  --| Character(s) to be stripped
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified characters if any are stripped from the input text
--| in both leading and trailing positions.
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Left_Justify(                  --| Left justify a given string
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return STRING;                    --| Result string 

--| Effects: The specified input string is placed left justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Left_Justify(                  --| Left justify a given string
    Text : in STRING;                   --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is placed left justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Left_Justify(                  --| Left justify a given string
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is placed left justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Right_Justify(                 --| Right justify a given string
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return STRING;                    --| Result string 

--| Effects: The specified input string is placed right justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Right_Justify(                 --| Right justify a given string
    Text : in STRING;                   --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is placed left justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Right_Justify(                 --| Right justify a given string
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is placed left justified and padded if
--| needed with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Center(                        --| Center a given string
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return STRING;                    --| Result string 

--| Effects: The specified input string is placed centered and padded if needed
--| with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Center(                        --| Center a given string
    Text : in STRING;                   --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is placed centered and padded if needed
--| with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Center(                        --| Center a given string
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE;                 --| Output string length
    Char : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is placed centered and padded if needed
--| with the fill character.
--| The Len specifies the result string length.
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Expand(                        --| Expand a given string to Len
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE                  --| Output string length
    ) return STRING;                    --| Result string 

--| Effects: The specified input string is expanded to Len with blanks.
--| (eg. "Expand this string to 40 chars" when Len equals 40 will be
--| "Expand   this   string   to   40   chars")
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Expand(                        --| Expand a given string to Len
    Text : in STRING;                   --| Input string
    Len  : in POSITIVE                  --| Output string length
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is expanded to Len with blanks.
--| (eg. "Expand this string to 40 chars" when Len equals 40 will be
--| "Expand   this   string   to   40   chars")
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Expand(                        --| Expand a given string to Len
    Text : in Generic_String_Type;      --| Input string
    Len  : in POSITIVE                  --| Output string length
    ) return Generic_String_Type;       --| Result string 

--| Effects: The specified input string is expanded to Len with blanks.
--| (eg. "Expand this string to 40 chars" when Len equals 40 will be
--| "Expand   this   string   to   40   chars")
--| N/A: Modifies, Raises, Errors
pragma page;
----------------------------------------------------------------

function Format(                        --| Format a given string
    Text    : in Generic_String_Type;   --| Input string
    Len     : in POSITIVE;              --| Length of each folded line
    Del     : in CHARACTER := ' ';      --| Delimiting character
    Justify : in Justification_Mode := NONE
                                        --| Justification mode
    ) return SL.List;

--| Effects: The specified string is folded into as many lines of Len as needed.
--| The character Del indicated an element of the input string where the
--| line may be "broken".  Returned list consists of persistent string types
--| thus must be flushed (or DestroyDeep with Flush).
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Image(                         --| Convert an integer to a string
    Num  : in INTEGER;                  --| Input number
    Len  : in NATURAL   := 0;           --| Length of the output string
    Fill : in CHARACTER := ' '          --| Fill character
    ) return Generic_String_Type;

--| Effects: The specified integer is converted into a string of length Len.
--| Len of 0 implies that the converted integer fills the string.
--| If Len (other thatn 0) is too small to contain the converted string
--| the number is truncated.
--| N/A: Modifies, Raises, Errors

----------------------------------------------------------------

function Value(                         --| Convert a string to an integer
    Text : in Generic_String_Type       --| Input string
    ) return INTEGER;

--| Raises: Non_Numeric_String, Number_Too_Large
--| Effects: The specified string is converted into an equivalent integer.
--| The string must have the syntax of an Ada INTEGER (LRM 2.4.1)
--| N/A: Modifies, Errors

----------------------------------------------------------------

function Match(                 --| Match two strings
    Pattern    : in Generic_String_Type;
                                --| String to match
    Target     : in STRING;     --| String to be searched
    Wildcard   : in CHARACTER := '*';
                                --| Wildcard character
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
                                --| Case sensitivity in comparison
    ) return BOOLEAN;

--| Effects: The specified Pattern containing Wildcard character(s) are
--| searched on Target.  If Target satisfies the condition in Pattern
--| returns TRUE.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Match(                 --| Match two strings
    Pattern    : in STRING;     --| String to match
    Target     : in Generic_String_Type;
                                --| String to be searched
    Wildcard   : in CHARACTER := '*';
                                --| Wildcard character
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
                                --| Case sensitivity in comparison
    ) return BOOLEAN;

--| Effects: The specified Pattern containing Wildcard character(s) are
--| searched on Target.  If Target satisfies the condition in Pattern
--| returns TRUE.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

function Match(                 --| Match two strings
    Pattern    : in Generic_String_Type;
                                --| String to match
    Target     : in Generic_String_Type;
                                --| String to be searched
    Wildcard   : in CHARACTER := '*';
                                --| Wildcard character
    Comparison : in SP.Comparison_Option := SP.CASE_SENSITIVE
                                --| Case sensitivity in comparison
    ) return BOOLEAN;

--| Effects: The specified Pattern containing Wildcard character(s) are
--| searched on Target.  If Target satisfies the condition in Pattern
--| returns TRUE.
--| N/A: Raises, Modifies, Errors

----------------------------------------------------------------

end Generic_String_Utilities;


private
    package ST is new Stack_Pkg(POSITIVE);

    type Scan_Record is
        record
            text  : SP.String_Type;     --| Copy of string being scanned
            index : POSITIVE := 1;      --| Current position of Scanner
            mark  : ST.Stack := ST.Create;
                                        --| Marks
        end record;

    type Scanner is access Scan_Record;
end ASR_String_Utilities;
