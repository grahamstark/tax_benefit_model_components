--  Received: from SIMTEL20.ARPA by lll-icdc.arpa ; 21 Feb 87 06:04:05 PST
--  Subject: RAW PD:<ADA.COMPONENTS>NEWABS.SRC.0 

package case_insensitive_string_comparison is

--| Overview
--| This package provides a complete set of comparison functions on strings
--| where case is NOT important ("a" = "A").

--| Standard_Renaming: CISC or simply SC
--| Programmer: M. Gordon

------------------------------------------------------------------------

function toUpper(       --| Return upper case equivalent of C.
    C: character
    ) return character;

--| Effects: If C is in 'a'..'z' return the corresponding upper case
--| character.  Otherwise, return C.  This is implemented by a table
--| lookup for speed.

--| N/A: Raises, Requires, Modifies


procedure upCase(       --| Convert all characters in S to upper case
    S: in out String
    );

--| Effects: Convert all characters in S to upper case.
--| N/A: Raises, Requires, Modifies

    pragma inline(upCase);


function upCase(        --| Return copy of S with all characters upper case
    S: String
    ) return String;

--| Effects: Make a copy of S, convert all lower case characters to upper
--| case and return the copy.

--| N/A: Raises, Requires, Modifies

------------------------------------------------------------------------

function toLower(       --| Return lower case equivalent of C.
    C: character
    ) return character;

--| Effects: If C is in 'A'..'Z' return the corresponding lower case
--| character.  Otherwise, return C.  This is implemented by a table
--| lookup for speed.

--| N/A: Raises, Requires, Modifies


procedure downCase(     --| Convert all characters in S to lower case
    S: in out String
    );

--| Effects: Convert all characters in S to lower case.
--| N/A: Raises, Requires, Modifies

    pragma inline(downCase);


function downCase(      --| Return copy of S with all characters lower case
    S: String
    ) return String;

--| Effects: Make a copy of S, convert all lower case characters to lower
--| case and return the copy.

--| N/A: Raises, Requires, Modifies

------------------------------------------------------------------------

function compare(       --| Compare two strings
    P, Q: String
    ) return integer;

--| Effects: Return an integer less than zero if P < Q, zero if P = Q, and
--| an integer greater than zero if P > Q.

--| N/A: Raises, Requires, Modifies

------------------------------------------------------------------------

function equal(         --| Return True iff P = Q.
    P, Q: String
    ) return boolean;

--| N/A: Raises, Requires, Modifies, Effects

function less(          --| Return True iff P < Q.
    P, Q: String
    ) return boolean;
--| N/A: Raises, Requires, Modifies, Effects


function less_or_equal( --| Return True iff P <= Q.
    P, Q: String
    ) return boolean;

--| N/A: Raises, Requires, Modifies, Effects


function greater(       --| Return True iff P > Q.
    P, Q: String
    ) return boolean;

--| N/A: Raises, Requires, Modifies, Effects


function greater_or_equal(      --| Return True iff P >= Q.
    P, Q: String
    ) return boolean;

--| N/A: Raises, Requires, Modifies, Effects

------------------------------------------------------------------------

private
    pragma inline(equal, less, less_or_equal, greater, greater_or_equal);
    pragma inline(toUpper, toLower);

end case_insensitive_string_comparison;