--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--STRING.BDY
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
-- $Source: /nosc/work/abstractions/string/RCS/string.bdy,v $
-- $Revision: 1.3 $ -- $Date: 85/02/01 10:58:51 $ -- $Author: ron $

-- $Source: /nosc/work/abstractions/string/RCS/string.bdy,v $
-- $Revision: 1.3 $ -- $Date: 85/02/01 10:58:51 $ -- $Author: ron $
--  Revised 31-JUL-87 to 'simplify' use of heap -- jpw
--  a) entries on scope-stack are now lists, not (pointers to) lists;
--  b) create and make-persistent are now consistent in handling of
--     empty strings: both return null;
--  c) enter and release use abstract operators on stacks, where they
--     formerly used 2-level pointers.

with unchecked_deallocation;
with stack_pkg;
with string_lists ;
with case_insensitive_string_comparison;

package body string_pkg is

--| Overview:
--| The implementation for most operations is fairly straightforward.
--| The interesting aspects involve the allocation and deallocation of
--| heap space.  This is done as follows:
--|
--|     1. A stack of lists of string_type values is set up
--|        so that the top of the stack always refers to a list of values
--|        that were allocated since the last invocation of mark.
--|        The stack is called scopes, referring to the dynamic scopes
--|        defined by the invocations of mark and release.
--|        There is an implicit invocation of mark when the
--|        package body is elaborated; this is implemented with an explicit 
--|        invocation in the package initialization code.
--|
--|     2. At each invocation of mark, an empty list is pushed onto the stack.
--|
--|     3. At each invocation of release, all of the values in the
--|        list referred to by the top of the stack are
--|        returned to the heap.  Then the list is
--|        returned to the heap.  Finally, the stack is popped.

    package CISC renames case_insensitive_string_comparison;

    subtype string_list is string_lists.list ;
    package scope_stack_pkg is new stack_pkg(string_list);
    scopes: scope_stack_pkg.stack ;    -- See package body overview.

    use string_lists;
    use scope_stack_pkg;

    current_comparison_option: comparison_option := case_insensitive;

-------------------------------------------------------------------------------
--  
-- Utility functions/procedures:

    function enter(s: string_type)
        return string_type;

      --| Raises: illegal_alloc
      --| Effects:
      --| Stores s, the address of s.all, in current scope list (top(scopes)),
      --| and returns s.  Useful for functions that create and return new
      --| string_type values.
      --| Raises illegal_alloc if the scopes stack is empty.


    function string_equal(s1, s2: string)
        return boolean;

      --| Effects: 
      --| If current_comparison_option = case_sensitive, then return 
      --| (s1 = s2); otherwise, return string_lower(s1) = string_lower(s2).

    function string_less(s1, s2: string)
        return boolean;

      --| Effects: 
      --| If current_comparison_option = case_sensitive, then return 
      --| (s1 < s2); otherwise, return string_lower(s1) < string_lower(s2).

    function string_less_or_equal(s1, s2: string)
        return boolean; 

      --| Effects: 
      --| If current_comparison_option = case_sensitive, then return 
      --| (s1 <= s2); otherwise, return string_lower(s1) <= string_lower(s2).

    function match_string(s1, s2: string; start: positive := 1)
        return natural;

      --| Raises: no_match
      --| Effects:
      --| Returns the minimum index, i, in s1'range such that
      --| s1(i..i + s2'length - 1) = s2.  Returns 0 if no such index.
      --| Requires:
      --| s1'first = 1.

-------------------------------------------------------------------------------
--  
-- Constructors:

    function create(s: string)
        return string_type is
        subtype constr_str is string(1..s'length);
        dec_s: constr_str := s;
    begin
        if s'length > 0 then
            return enter(new constr_str'(dec_s));
        else            -- changed! formerly returned access (s(1..0)), NOT null
            return null ;
        end if ;
    end create;


    function "&"(s1, s2: string_type)
        return string_type is
    begin
        return create(value(s1) & value(s2)) ;
    end "&";

    function "&"(s1: string_type; s2: string)
        return string_type is
    begin
        return create(value(s1) & s2); 
    end "&";

    function "&"(s1: string; s2: string_type)
        return string_type is
    begin
        return create(s1 & value(s2)); 
    end "&";
    
    function substr(s: string_type; i: positive; len: natural)
        return string_type is
    begin
        if len = 0 then return null; end if; 
        return create(s(i..(i + len - 1)));
    exception
        when constraint_error =>      -- on array fetch or null deref
            raise bounds;
    end substr;

    function splice(s: string_type; i: positive; len: natural)
        return string_type is
    begin
        if len = 0 then return create(value(s)) ; end if;
        if i + len - 1 > length(s) then raise bounds; end if; 

        return create(s(1..(i - 1)) & s((i + len)..length(s)));
    end splice;

    function insert(s1, s2: string_type; i: positive)
        return string_type is
    begin
        if i > length(s1) + 1 then raise bounds; end if;

        if s1 = null then return create(value(s2)); end if;
        if s2 = null then return create(value(s1)); end if;

        return create(s1(1..(i - 1)) & s2.all & s1(i..s1'last));
    end insert;

    function insert(s1: string_type; s2: string; i: positive)
        return string_type is
    begin
        if i > length(s1) + 1 then raise bounds; end if;
        if s1 = null then return create(s2); end if;

        return create(s1(1..(i - 1)) & s2 & s1(i..s1'last));
    end insert;

    function insert(s1: string; s2: string_type; i: positive)
        return string_type is
    begin
        if i not in s1'first..s1'last + 1 then raise bounds; end if;
        if s2 = null then return create(s1); end if; 

        return create(s1(s1'first..(i - 1)) & s2.all & s1(i..s1'last));
    end insert;

    function lower(s: string)
        return string_type is  
    begin
        return create(CISC.downcase(s));
    end lower;

    function lower(s: string_type)
        return string_type is
    begin
        if s = null then return null; end if; 
        return create(CISC.downcase(s.all));
    end lower;

    function upper(s: string)
        return string_type is
    begin
        return create(CISC.upcase(s));
    end upper;

    function upper(s: string_type)
        return string_type is
    begin
        if s = null then return null; end if; 
        return create(CISC.upcase(s.all));
    end upper;
    
-------------------------------------------------------------------------------
--  
-- Heap Management:

    function make_persistent(s: string_type)
        return string_type is
        subtype constr_str is string(1..length(s));
    begin
        if length(s) = 0  then return null;
        else return new constr_str'(s.all);
        end if; 
    end make_persistent; 
    
    function make_persistent(s: string)
        return string_type is
        subtype constr_str is string(1..s'length);
        dec_s: constr_str := s;
    begin
        if s'length = 0  then return null; 
        else return new constr_str'(dec_s); end if; 
    end make_persistent; 

    procedure real_flush is new unchecked_deallocation(string,
                                                       string_type);
      --| Return space used by argument to heap.
      --| This procedure is actually the body for the flush procedure,
      --| but a generic instantiation cannot be used as a body for another
      --| procedure.  You tell me why.

    procedure destroy_scopelist is 
                new string_lists.destroydeep (real_flush) ;


    procedure flush(s: in out string_type) is
    begin
        real_flush(s); 
    end flush;

    procedure mark is
    begin
        push(scopes, string_lists.create);
    end mark;

    procedure release is
        iter     : string_lists.ListIter;
        top_list : string_list;
        s        : string_type;
    begin
        pop(scopes, top_list);
        destroy_scopelist  (top_list) ;
    exception
        when empty_stack =>
            raise illegal_dealloc;
    end release;
    
-------------------------------------------------------------------------------
--  
-- Queries:

    function is_empty(s: string_type)
        return boolean is
    begin
        return length(s) = 0 ;
    end is_empty;

    function length(s: string_type)
        return natural is
    begin
        if s = null then return 0; end if; 
        return(s.all'length);
    end length;

    function value(s: string_type)
        return string is
    begin
        if s = null then return "" ;  end if; 
        return s.all;
    end value;

    function fetch(s: string_type; i: positive)
        return character is
    begin
        if is_empty(s) or else (i not in s'range) then raise bounds; end if; 
        return s(i);
    end fetch;

    procedure set_comparison_option(choice: comparison_option) is
    begin
        current_comparison_option := choice; 
    end set_comparison_option;

    function get_comparison_option
        return comparison_option is
    begin
        return current_comparison_option; 
    end get_comparison_option;

    function equal(s1, s2: string_type)
        return boolean is
    begin
        if is_empty(s1) then return is_empty(s2); end if; 
        return (s2 /= null) and then string_equal(s1.all, s2.all);
    end equal;

    function equal(s1: string_type; s2: string)
        return boolean is
    begin
        if s1 = null then return s2 = ""; end if;
        return string_equal(s1.all, s2);
    end equal;

    function equal(s1: string; s2: string_type)
        return boolean is
    begin
        if s2 = null then return s1 = ""; end if;
        return string_equal(s1, s2.all);
    end equal;

    function "<"(s1, s2: string_type)
        return boolean is
    begin
        if is_empty(s1) then
            return (not is_empty(s2));
        else
            return (s1.all < s2) ;
        end if; 
    end "<";

    function "<"(s1: string_type; s2: string)
        return boolean is 
    begin
        if s1 = null then return s2 /= ""; end if; 
        return string_less(s1.all, s2);
    end "<";

    function "<"(s1: string; s2: string_type)
        return boolean is 
    begin
        if s2 = null then return false; end if; 
        return string_less(s1, s2.all);
    end "<";

    function "<="(s1, s2: string_type)
        return boolean is 
    begin
        if is_empty(s1) then return true; end if; 
        return (s1.all <= s2); 
    end "<=";

    function "<="(s1: string_type; s2: string)
        return boolean is 
    begin
        if s1 = null then return true; end if; 
        return string_less_or_equal(s1.all, s2);
    end "<=";

    function "<="(s1: string; s2: string_type)
        return boolean is 
    begin
        if s2 = null then return s1 = ""; end if; 
        return string_less_or_equal(s1, s2.all); 
    end "<=";

    function match_c(s: string_type; c: character; start: positive := 1)
        return natural is
    begin
        if s = null then return 0; end if; 
        for i in start..s.all'last loop
            if s(i) = c then
                return i;
            end if;
        end loop;
        return 0;
    end match_c;

    function match_not_c(s: string_type; c: character; start: positive := 1)
        return natural is
    begin
        if s = null then return 0; end if; 
        for i in start..s.all'last loop
            if s(i) /= c then
                return i;
            end if;
        end loop;
    return 0;
    end match_not_c;

    function match_s(s1, s2: string_type; start: positive := 1)
        return natural is
    begin
        if (s1 = null) or else (s2 = null) then return 0; end if; 
        return match_string(s1.all, s2.all, start);
    end match_s;

    function match_s(s1: string_type; s2: string; start: positive := 1)
        return natural is
    begin
        if s1 = null then return 0; end if; 
        return match_string(s1.all, s2, start);
    end match_s;

    function match_any(s, any: string_type; start: positive := 1)
        return natural is
    begin
        if any = null then raise any_empty; end if; 
        return match_any(s, any.all, start);
    end match_any;

    function match_any(s: string_type; any: string; start: positive := 1)
        return natural is
    begin
        if any = "" then raise any_empty; end if;
        if s = null then return 0; end if;

        for i in start..s.all'last loop
            for j in any'range loop
                if s(i) = any(j) then
                    return i;
                end if;
            end loop;
        end loop;
        return 0;
    end match_any;

    function match_none(s, none: string_type; start: positive := 1)
        return natural is
    begin
        if is_empty(s) then return 0; end if; 
        if is_empty(none) then return 1; end if; 

        return match_none(s, none.all, start);
    end match_none;

    function match_none(s: string_type; none: string; start: positive := 1)
        return natural is
        found: boolean;
    begin
        if is_empty(s) then return 0; end if; 

        for i in start..s.all'last loop
            found := true;
            for j in none'range loop
                if s(i) = none(j) then
                    found := false;
                    exit;
                end if;
            end loop;
            if found then return i; end if;
        end loop;
        return 0;
    end match_none;


-------------------------------------------------------------------------------
--  
-- Utilities:

    function enter(s: string_type)
        return string_type is
        top_list: string_list;
    begin
        if s /= null then
            pop (scopes, top_list) ;
            attach (s, top_list) ;
            push (scopes, top_list) ;
        end if ;
        return s;
    exception
        when empty_stack =>
            raise illegal_alloc;
    end enter;

    function string_equal(s1, s2: string)
        return boolean is
    begin
        if current_comparison_option = case_sensitive then
            return s1 = s2;
        else
            return CISC.equal(S1, S2);
        end if;

    end string_equal;

    function string_less(s1, s2: string)
        return boolean is
    begin
        if current_comparison_option = case_sensitive then 
            return s1 < s2;
        else
            return CISC.less(S1, S2);
        end if;

    end string_less;

    function string_less_or_equal(s1, s2: string)
        return boolean is
    begin
        if current_comparison_option = case_sensitive then 
            return s1 <= s2;
        else
            return CISC.less_or_equal(S1, S2);
        end if;

    end string_less_or_equal;

    function match_string(s1, s2: string; start: positive := 1)
        return natural is
        offset: natural;
    begin
        offset := s2'length - 1;
        for i in start..(s1'last - offset) loop
            if s1(i..(i + offset)) = s2 then
                return i;
            end if;
        end loop;
        return 0; 
    exception when constraint_error =>    -- on offset := s2'length (= 0)
        return 0; 
    end match_string;

-------------------------------------------------------------------------------

begin    -- Initialize the scopes stack with an implicit mark.
    scopes := create;
    mark;
end string_pkg;