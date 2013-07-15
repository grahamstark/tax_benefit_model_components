Items from public sources that have been reused in building Numeric_IO
& Name_IO

All the items in the Reused directory (except for set_of) originally
were publicly available in a variety of 1980’s vintage Ada reuse
repositories.  Starting with the SIMTEL20.ARPA repository, also known
as the Ada Software Repository, then in its successors the Public Ada
Library (PAL) library and the Walnut Creek disk that has been
distributed by SigAda.  In those good old days, just about everybody
had access to a single collection of abstract data types.

The package asr_string_utilities in this product was known as
string_utilities in the public repository; I re-labeled it to resolve
a clash with other packages using the same name.

These items have served well, although they are somewhat anachronistic
in Ada95’s day, what with Ada.Strings and his children, child packages
and controlled types.  (I have corrected a minor defect in
asr_string_utilities.get_segment).

The package Set_Of is a transcription of an example from Habermann’s
Ada for Experienced Programmers.  The package is a straightforward
rendition of the set semantics from the Pascal language.
