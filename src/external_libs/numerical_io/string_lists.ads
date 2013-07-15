--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--SLISTS.SPC
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
with String_Pkg;
with Lists;

package String_Lists is new Lists(
            ItemType => String_Pkg.String_Type,
            Equal    => String_Pkg.Equal);
