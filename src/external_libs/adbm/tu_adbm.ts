
--  $Id: tu_adbm.ts,v 1.6 1997/07/19 08:55:24 pascal Exp $

context with Ada.Text_IO; use Ada.Text_IO;
        with Adbm;

define  package I_Adbm is new Adbm (Integer);
        use I_Adbm;

        afd   : I_Adbm.File_Type;
        V     : Integer;
        Found : Boolean;

        N     : Natural := 0;

        procedure Action (Key   : in     String;
                          Value : in     Integer;
                          Stop  : in out Boolean) is
        begin
           N := N + 1;
        end Action;

        procedure Call (S : in String) is
        begin
           null;
        end Call;

        procedure Call (I : in Integer) is
        begin
           null;
        end Call;

        procedure Call (M : in I_Adbm.File_Mode) is
        begin
           null;
        end Call;


        procedure Count_Item is new For_Every_Item (Action);

***** (1) Before open
test    null;
pass    Is_Open (afd) = False

***** (2) Before open
test    Call (Name (afd));
pass    exception I_Adbm.Status_Error;

***** (3) Before open
test    Call (Form (afd));
pass    exception I_Adbm.Status_Error;

***** (4) Before open
test    Call (Mode (afd));
pass    exception I_Adbm.Status_Error;

***** (5) Before open
test    Call (Index_Size (afd));
pass    exception I_Adbm.Status_Error;

***** (6) Before open
test    Reset (afd, I_Adbm.In_File);
pass    exception I_Adbm.Status_Error;

***** (7) Open file
test    Open (Name => "tu_adbm", File => afd, Mode => I_Adbm.In_File);
pass    exception I_Adbm.Name_Error
pass    Is_Open (afd) = False

***** (8) Create file
test    Create (Name => "tu_adbm", File => afd, Mode => I_Adbm.InOut_File);
pass    Name (afd) = "tu_adbm" and then
        Form (afd) = "" and then
        Is_Open (afd) = true and then
        Fragmentation_Percentage (afd) = 0 and then
        Index_Size (afd) = 1_024

***** (9) Add Datas
test    Insert (afd, "un", Scalar_Value => 1);
        Insert (afd, "deux", Scalar_Value => 2);
        Insert (afd, "trois", Scalar_Value => 3);
        Insert (afd, "quatre", Scalar_Value => 4);
        Insert (afd, "cinq", Scalar_Value => 5);
        Insert (afd, "six", Scalar_Value => 6);
pass    Size (afd) = 6 and then
        Fragmentation_Percentage (afd) = 0

***** (10) Check duplicate key
test    Insert (afd, "un", Scalar_Value => 1);
pass    exception Duplicate_Key

***** (11) Check duplicate key
test    Insert (afd, "deux", Scalar_Value => 2);
pass    exception Duplicate_Key

***** (12) Check duplicate key
test    Insert (afd, "trois", Scalar_Value => 3);
pass    exception Duplicate_Key

***** (13) Check duplicate key
test    Insert (afd, "six", Scalar_Value => 6);
pass    exception Duplicate_Key

***** (14) 
test    v := 19; Insert (afd, "six", V, Insert_Or_Retrieve_Item);
pass    V = 6

***** (15) Insert or retrieve
test    v := 321; Insert (afd, "six", V, Insert_Or_Change_Item);
pass    V = 321

***** (16) Insert or retrieve
test    Seek (afd, "six", V, Found);
pass    Found = True and then
        V = 321

***** (17) Insert or retrieve
test    v := 6; Insert (afd, "six", V, Insert_Or_Change_Item);
pass    V = 6

***** (18) Change Item
test    v := 6; Insert (afd, "mum", V, Change_Item);
pass    exception Key_Not_Found

***** (19) Check Item
test    null;
pass    not Key_Exist (afd, "mum")

***** (20) Change Item
test    v := 19; Insert (afd, "un", V, Change_Item);
pass    V = 19

***** (21) Change Item
test    v := 1; Insert (afd, "un", V, Change_Item);
pass    V = 1

***** (22) Count item
test    N := 0; Count_Item (afd);
pass    N = 6

***** (23) Check Datas 1
test    Seek (afd, "un", V, Found);
pass    Found = True and then
        V = 1

***** (24) Check Datas 2
test    Seek (afd, "deux", V, Found);
pass    Found = True and then
        V = 2

***** (25) Check Datas 3
test    Seek (afd, "trois", V, Found);
pass    Found = True and then
        V = 3

***** (26) Check Datas 4
test    Seek (afd, "quatre", V, Found);
pass    Found = True and then
        V = 4

***** (27) Check Datas 5
test    Seek (afd, "cinq", V, Found);
pass    Found = True and then
        V = 5

***** (28) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = True and then
        V = 6

***** (29) Check wrong Datas 
test    Seek (afd, "un-", V, Found);
pass    Found = False

***** (30) Check wrong Datas 
test    Seek (afd, "toto", V, Found);
pass    Found = False




***** (31) Remove 2
test    Remove (afd, "deux");
pass    Size (afd) = 5 and then
        Fragmentation_Percentage (afd) = Percentage (100 / 6)

***** (32) Count item
test    N := 0; Count_Item (afd);
pass    N = 5

***** (33) Check Datas 1
test    Seek (afd, "un", V, Found);
pass    Found = True and then
        V = 1

***** (34) Check Datas 2
test    Seek (afd, "deux", V, Found);
pass    Found = False

***** (35) Check Datas 3
test    Seek (afd, "trois", V, Found);
pass    Found = True and then
        V = 3

***** (36) Check Datas 4
test    Seek (afd, "quatre", V, Found);
pass    Found = True and then
        V = 4

***** (37) Check Datas 5
test    Seek (afd, "cinq", V, Found);
pass    Found = True and then
        V = 5

***** (38) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = True and then
        V = 6

***** (39) Check wrong Datas 
test    Seek (afd, "un-", V, Found);
pass    Found = False

***** (40) Check wrong Datas 
test    Seek (afd, "toto", V, Found);
pass    Found = False



***** (41) Remove 4
test    Remove (afd, "quatre");
pass    Size (afd) = 4

***** (42) Count item
test    N := 0; Count_Item (afd);
pass    N = 4 and then
        Fragmentation_Percentage (afd) = Percentage (200 / 6)

***** (43) Check Datas 1
test    Seek (afd, "un", V, Found);
pass    Found = True and then
        V = 1

***** (44) Check Datas 2
test    Seek (afd, "deux", V, Found);
pass    Found = False

***** (45) Check Datas 3
test    Seek (afd, "trois", V, Found);
pass    Found = True and then
        V = 3

***** (46) Check Datas 4
test    Seek (afd, "quatre", V, Found);
pass    Found = False

***** (47) Check Datas 5
test    Seek (afd, "cinq", V, Found);
pass    Found = True and then
        V = 5

***** (48) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = True and then
        V = 6

***** (49) Check wrong Datas 
test    Seek (afd, "un-", V, Found);
pass    Found = False

***** (50) Check wrong Datas 
test    Seek (afd, "toto", V, Found);
pass    Found = False



***** (51) Remove 1, 3, 6
test    Remove (afd, "un");
        Remove (afd, "trois");
        Remove (afd, "six");
pass    Size (afd) = 1 and then
        Fragmentation_Percentage (afd) = Percentage (500 / 6)

***** (52) Compact file
test    Compact (afd, 100);
pass    Size (afd) = 1 and then
        Fragmentation_Percentage (afd) = 0 and then
        Index_Size (afd) = 100

***** (53) Count item
test    N := 0; Count_Item (afd);
pass    N = 1

***** (54) Exist datas 1
test    null;
pass    not Key_Exist (afd, "un")

***** (55) Exist datas 2
test    null;
pass    not Key_Exist (afd, "deux")

***** (56) Exist datas 3
test    null;
pass    not Key_Exist (afd, "trois")

***** (57) Exist datas 4
test    null;
pass    not Key_Exist (afd, "quatre")

***** (58) Exist datas 5
test    null;
pass    Key_Exist (afd, "cinq")

***** (59) Exist datas 6
test    null;
pass    not Key_Exist (afd, "six")

***** (60) Check Datas 1
test    Seek (afd, "un", V, Found);
pass    Found = False

***** (61) Check Datas 2
test    Seek (afd, "deux", V, Found);
pass    Found = False

***** (62) Check Datas 3
test    Seek (afd, "trois", V, Found);
pass    Found = False

***** (63) Check Datas 4
test    Seek (afd, "quatre", V, Found);
pass    Found = False

***** (64) Check Datas 5
test    Seek (afd, "cinq", V, Found);
pass    Found = True and then
        V = 5

***** (65) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = False

***** (66) Check wrong Datas 
test    Seek (afd, "toto", V, Found);
pass    Found = False

***** (67) Remove not existing data
test    Remove (afd, "un");
pass    exception Key_Not_Found

***** (68) Remove 5
test    Remove (afd, "cinq");
pass    Size (afd) = 0 and then
        Fragmentation_Percentage (afd) = Percentage (100)

***** (69) Count item
test    N := 0; Count_Item (afd);
pass    N = 0

***** (70) Check Datas 1
test    Seek (afd, "un", V, Found);
pass    Found = False

***** (71) Check Datas 2
test    Seek (afd, "deux", V, Found);
pass    Found = False

***** (72) Check Datas 3
test    Seek (afd, "trois", V, Found);
pass    Found = False

***** (73) Check Datas 4
test    Seek (afd, "quatre", V, Found);
pass    Found = False

***** (74) Check Datas 5
test    Seek (afd, "cinq", V, Found);
pass    Found = False

***** (75) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = False

***** (76) Exist datas 1
test    null;
pass    not Key_Exist (afd, "un")

***** (77) Exist datas 2
test    null;
pass    not Key_Exist (afd, "deux")

***** (78) Exist datas 3
test    null;
pass    not Key_Exist (afd, "trois")

***** (79) Exist datas 4
test    null;
pass    not Key_Exist (afd, "quatre")

***** (80) Exist datas 5
test    null;
pass    not Key_Exist (afd, "cinq")

***** (81) Exist datas 6
test    null;
pass    not Key_Exist (afd, "six")

***** (82) Add Datas
test    Insert (afd, "azerty", Scalar_Value => 123);
        Insert (afd, "querty", Scalar_Value => 99);
pass    Size (afd) = 2

***** (83) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = False

***** (84) Check Datas "azerty"
test    Seek (afd, "azerty", V, Found);
pass    Found = True and then
        V = 123

***** (85) Check Datas "querty"
test    Seek (afd, "querty", V, Found);
pass    Found = True and then
        V = 99



***** (86) Close file
test    Close (afd);
pass    Is_Open (afd) = False

***** (87) Open file
test    Open (Name => "tu_adbm", File => afd, Mode => I_Adbm.Out_File);
pass    Is_Open (afd) = True and then
        Size (afd) = 2 and then
        Fragmentation_Percentage (afd) = Percentage (100 / 3)

***** (88) Count item
test    N := 0; Count_Item (afd);
pass    N = 2

***** (89) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    Found = False

***** (90) Check Datas "azerty"
test    Seek (afd, "azerty", V, Found);
pass    Found = True and then
        V = 123

***** (91) Check Datas "querty"
test    Seek (afd, "querty", V, Found);
pass    Found = True and then
        V = 99

***** (92) Exist datas querty
test    null;
pass    Key_Exist (afd, "querty")

***** (93) Exist datas querty
test    null;
pass    not Key_Exist (afd, "six")

***** (94) Exist datas querty
test    null;
pass    not Key_Exist (afd, "querty-")


***** (95) Insert a data with wrong mode
test    Insert (afd, "toto", Scalar_Value => 897);
pass    exception I_Adbm.Mode_Error


***** (96) Close file
test    Close (afd);
pass    Is_Open (afd) = False

***** (97) Open file
test    Open (Name => "tu_adbm", File => afd, Mode => I_Adbm.In_File);
pass    Is_Open (afd) = True and then
        Size (afd) = 2 and then
        Fragmentation_Percentage (afd) = Percentage (100 / 3)

***** (98) Check Datas 6
test    Seek (afd, "six", V, Found);
pass    exception I_Adbm.Mode_Error

***** (99) Insert a data
test    Insert (afd, "toto", Scalar_Value => 897);
pass    Size (afd) = 3 and then
        Fragmentation_Percentage (afd) = Percentage (100 / 4)



***** (100) Delete file
test    Delete (afd);
pass    Is_Open (afd) = False


***** (101) Open file that does not exist
test    Open (Name => "tu_adbm", File => afd, Mode => I_Adbm.In_File);
pass    exception I_Adbm.Name_Error
pass    Is_Open (afd) = False
