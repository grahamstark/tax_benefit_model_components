--------------------------------------------------------------------------------
--      Package spec for Generic Set type
--      Derived from Chapter 9.6 of Ada for Experienced Programmers, Habermann
--      and Chapter 13 of Programming in Ada, Barnes
--------------------------------------------------------------------------------
--      AUTHOR :        John Woodruff
--      DATE :          19 Dec 1985
--------------------------------------------------------------------------------
--      PURPOSE
--   This is an implementation of the generic Set type.  To use a set of any
-- discreet type in any Ada program:
-- Include the following among the declarations in your package visible part
--     With Set_Of;
--     Define some enumerated type (the basis type for some set variables) ;
--     Package Set_Name is New Set_of (Enumerated_type) ;
-- Declare instances of the newly instantiated type within the package body:
--     Set_Var : Set_Name.Set ;
--------------------------------------------------------------------------------
--
--
Generic Type Basis is (<>) ;
Package Set_of is
    Type Set is Private ;
    Type Sets_Members is array (Natural Range <>) of Basis ;

    Empty, Full: Constant Set ;         -- deferred to private part

    Function MakeSet (Members: Sets_Members) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:  { assume type basis_type is (a, b, c, d) ; }
    --    ABC_Set : Set := MakeSet ((a, b, c)) ;
    ----------------------------------------------------------------------------

    Function MakeSet (Se: Basis) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    D_Set   : Set := MakeSet (d)  ;
    ----------------------------------------------------------------------------

    Function "+" (S1, S2: Set) return Set ;             -- union
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := ABC_Set + D_Set              -- X_Set == {a,b,c,d}
    ----------------------------------------------------------------------------

    Function "+" (S1: Set; Se: Basis) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := ABC_Set + d                  -- X_Set == {a,b,c,d}
    ----------------------------------------------------------------------------

    Function "+" (Se: Basis; S1: Set) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := d + ABC_Set                  -- X_Set == {a,b,c,d}
    ----------------------------------------------------------------------------

    Function "-" (S1, S2: Set) return Set ;             -- set difference
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := ABC_Set - Set_Name.Empty     -- X_Set == {a,b,c}
    ----------------------------------------------------------------------------

    Function "-" (S1: Set; Se: Basis) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    Y_Set   : Set := ABC_Set - b                  -- Y_Set == {a,c}
    ----------------------------------------------------------------------------

    Function "-" (Se: Basis; S1: Set ) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    Y_Set   : Set := b - ABC_Set                  -- Y_Set == {}
    ----------------------------------------------------------------------------

    Function "*" (S1, S2: Set) return Set ;             -- intersection
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := ABC_Set * Set_Name.Empty     -- X_Set == Empty
    --    Y_Set   : Set := ABC_Set * Set_Name.Full      -- Y_Set == {a,b,c}
    ----------------------------------------------------------------------------

    Function "*" (S1: Set; Se: Basis) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := ABC_Set * b                  -- X_Set == {b}
    ----------------------------------------------------------------------------

    Function "*" (Se: Basis; S1: Set) return Set ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    X_Set   : Set := b * ABC_Set                  -- X_Set == {b}
    ----------------------------------------------------------------------------

    Function "<=" (S1, S2: Set) return Boolean ;        -- set inclusion
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    ABC_Set <= MakeSet ((a,b))                    -- False
    --    ABC_Set <= Full                               -- True
    ----------------------------------------------------------------------------

    Function ">=" (S1, S2: Set) return Boolean ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    ABC_Set >= MakeSet ((a,b))                    -- False
    --    ABC_Set >= Full                               -- False
    ----------------------------------------------------------------------------

    Function Member (Se: Basis; S1: Set) return Boolean;-- membership
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    Member (a, ABC_Set)                           -- true
    ----------------------------------------------------------------------------

    Function Member (S1: Set; Se: Basis) return Boolean;-- membership
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    Member (ABC_Set, d)                           -- false
    ----------------------------------------------------------------------------

    Function Size (S1: Set) return Integer ;
    ----------------------------------------------------------------------------
    --    Example Usage:
    --    Size (ABC_set)                                -- 3
    ----------------------------------------------------------------------------
Private
    Type SetArray is Array (Basis) of Boolean ;         -- Declare set as record
    Type Set is Record                                  -- ONLY so that default
        Field : SetArray := (others => False);          -- can be bound at type
        End Record ;                                    -- definition time.
    Empty : Constant Set := (Field => (others => False)) ;
    Full  : Constant Set := (Field => (others => True )) ;

-- |     optional     Pragma PACK (Set) ;
End Set_of ;

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

