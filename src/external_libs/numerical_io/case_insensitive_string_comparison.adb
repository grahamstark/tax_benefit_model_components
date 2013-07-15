--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--CISC.BDY
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
package body case_insensitive_string_comparison is

--| Overview
--| Strings are compared one character at a time, stopping as soon as
--| possible. 

--| Programmer: M. Gordon

------------------------------------------------------------------------

Up_ConvertArray: array(Character) of Character;
Down_ConvertArray: array(Character) of Character;
Difference: constant := Character'pos('a') - Character'pos('A');

function toUpper(C: character) return character is
begin
    return Up_ConvertArray(C);

end toUpper;


function upCase(        --| Return copy of S with all characters lower case
    S: String
    ) return String
is
    R: String(S'Range) := S;

begin
    for i in R'Range loop
        R(i) := toUpper(R(i));
    end loop;
    return R;

end upCase;


procedure upCase(       --| Convert all characters in S to lower case
    S: in out String
    ) is

begin
    for i in S'Range loop
        S(i) := toUpper(S(i));
    end loop;

end upCase;

------------------------------------------------------------------------

function toLower(C: character) return character is
begin
    return Down_ConvertArray(C);

end toLower;


function downCase(      --| Return copy of S with all characters lower case
    S: String
    ) return String
is
    R: String(S'Range) := S;

begin
    for i in R'Range loop
        R(i) := toLower(R(i));
    end loop;
    return R;

end downCase;

procedure downCase(     --| Convert all characters in S to lower case
    S: in out String
    ) is

begin
    for i in S'Range loop
        S(i) := toLower(S(i));
    end loop;

end downCase;

------------------------------------------------------------------------

function compare(       --| Compare two strings
    P, Q: String
    ) return integer
is
    PI, QI: natural;
    PC, QC: character;

begin
    QI := Q'First;
    for PI in P'First .. P'Last loop
      if QI > Q'Last then
        return 1;       -- Q ran out before P did.
      end if;
      PC := toUpper(P(PI));
      QC := toUpper(Q(QI));
      if PC /= QC then
        return character'pos(PC) - character'pos(QC);
      end if;
      QI := QI + 1;
    end loop;
    return P'Length - Q'Length; -- Equal so far: longer string is greater

end compare;

------------------------------------------------------------------------

function equal(
    P, Q: String
    ) return boolean is
begin
    return compare(P, Q) = 0;

end equal;

------------------------------------------------------------------------

function less(
    P, Q: String
    ) return boolean is
begin
    return compare(P, Q) < 0;
end less;


function less_or_equal(
    P, Q: String
    ) return boolean is
begin
    return compare(P, Q) <= 0;
end less_or_equal;


------------------------------------------------------------------------

function greater(
    P, Q: String
    ) return boolean is
begin
    return compare(P, Q) > 0;
end greater;

function greater_or_equal(
    P, Q: String
    ) return boolean is
begin
    return compare(P, Q) >= 0;
end greater_or_equal;

------------------------------------------------------------------------

begin

  for I in Character loop
    case I is
      when 'a' .. 'z' => 
        Up_ConvertArray(I) := Character'val(Character'pos(I) - Difference);
      when others =>
        Up_ConvertArray(I) := I;
    end case;
  end loop;

  for I in Character loop
    case I is
      when 'A' .. 'Z' => 
        Down_ConvertArray(I) := Character'val(Character'pos(I) + Difference);
      when others =>
        Down_ConvertArray(I) := I;
    end case;
  end loop;

end case_insensitive_string_comparison;