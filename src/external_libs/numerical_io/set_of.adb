Package Body Set_of is
--------------------------------------------------------------------------------
--      AUTHOR :        John Woodruff
--      DATE :          19 Dec 1985
--------------------------------------------------------------------------------
    Function MakeSet (Members: Sets_Members) return Set is
        S : Set ;
    Begin
        For i in Members'first .. Members'last loop
            S.Field (Members(i)) := True ;
        End loop ;
        Return S ;
    End MakeSet ;

    Function MakeSet (Se: Basis) return Set is
        S : Set ;
    Begin
        S.Field (Se) := True ;
        Return S ;
    End MakeSet ;

    Function "+" (S1, S2: Set) return Set is
        S : Set ;
    Begin
        For I in Basis'FIRST..Basis'LAST loop
            S.Field(I) := S1.Field(I) or S2.Field(I) ;
        End loop ;
        Return S  ;
    End "+" ;

    Function "+" (S1: Set; Se: Basis) return Set is
        S : Set := S1 ;
    Begin
        S.Field (Se) := True ;
        Return S  ;
    End "+" ;

    Function "+" (Se: Basis; S1: Set) return Set is
        S : Set := S1 ;
    Begin
        S.Field (Se) := True ;
        Return S  ;
    End "+" ;

    Function "-" (S1, S2: Set) return Set is            -- set difference
        S : Set := S1 ;
    Begin
        For I in Basis'FIRST..Basis'LAST loop
            if S2.Field(I) then S.Field(I) := False ;  end if ;
        End loop ;
        Return S  ;
    End "-" ;

    Function "-" (S1: Set; Se: Basis) return Set is
        S : Set := S1 ;
    Begin
        S.Field (Se) := False  ;
        Return S  ;
    End "-" ;

    Function "-" (Se: Basis; S1: Set) return Set is
        S : Set ;  -- default is empty.
    Begin
        If Not Member (Se, S1) then
            S.Field (Se) := True ;
        End if ;
        Return S  ;
    End "-" ;

    Function "*" (S1, S2: Set) return Set is            -- intersection
        S : Set ;
    Begin
        For I in Basis'FIRST..Basis'LAST loop
            S.Field(I) := S1.Field(I) And S2.Field(I) ;
        End loop ;
        Return S  ;
    End "*" ;

    Function "*" (S1: Set; Se: Basis) return Set is             -- intersection
        S : Set ;
    Begin
        If Member (Se, S1) then
            S.Field(Se)  := True  ;
        End if ;
        Return S  ;
    End "*" ;

    Function "*" (Se: Basis; S1: Set) return Set is             -- intersection
        S : Set ;
    Begin
        If Member (Se, S1) then
            S.Field(Se)  := True  ;
        End if ;
        Return S  ;
    End "*" ;

    Function "<=" (S1, S2: Set) return Boolean is       -- set inclusion
    Begin
        Return S1 * S2 = S1 ;
    End  "<=" ;

    Function ">=" (S1, S2: Set) return Boolean is
    Begin
        Return S2 <= S1 ;
    End ">=" ;

    Function Member (Se: Basis; S1: Set) return Boolean is
    Begin
        Return S1.Field(Se) ;
    End Member ;

    Function Member (S1: Set; Se: Basis) return Boolean is
    Begin
        Return S1.Field(Se) ;
    End Member ;

    Function Size (S1: Set) return Integer is
        Count : Integer := 0  ;
    Begin
        For I in Basis'FIRST..Basis'LAST  loop
            If S1.Field(I)  then Count := Count + 1 ;  end if ;
        End loop ;
        Return Count ;
    End Size ;

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

