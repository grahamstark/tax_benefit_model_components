--
--  $Author: graham_s $
--  $Date: 2008-08-20 08:18:39 +0100 (Wed, 20 Aug 2008) $
--  $Revision: 5684 $
--
with Text_Utils; use Text_Utils;

package body raw_frs_printer is

        -- function To_String( hprice : House_Price_Estimates_Rec ) return String is
        -- begin
                -- return
                -- INDENT & "SERNUM = " & hprice.SERNUM & ";" & stda.LF &
                -- INDENT & "hh_sequence = " & hprice.hh_sequence'Img & ";" & stda.LF &
                -- INDENT & "OWNER = " & hprice.OWNER'Img & ";" & stda.LF &
                -- INDENT & "OWNED_OUTRIGHT = " & hprice.OWNED_OUTRIGHT'Img & ";" & stda.LF &
                -- INDENT & "OWNED_W_MORTGAGE = " & hprice.OWNED_W_MORTGAGE'Img & ";" & stda.LF &
                -- INDENT & "BOUGHT_FROM_NIHE = " & hprice.BOUGHT_FROM_NIHE'Img & ";" & stda.LF &
                -- INDENT & "PNVALS = " & hprice.PNVALS'Img & ";" & stda.LF &
                -- INDENT & "PNVALAS = " & hprice.PNVALAS'Img & ";" & stda.LF &
                -- INDENT & "PHVALS = " & hprice.PHVALS'Img & ";" & stda.LF &
                -- INDENT & "PHVALAS = " & hprice.PHVALAS'Img & ";" & stda.LF &
                -- INDENT & "PVALS = " & hprice.PVALS'Img & ";" & stda.LF &
                -- INDENT & "PNVAL05 = " & hprice.PNVAL05'Img & ";" & stda.LF &
                -- INDENT & "PNVAL05A = " & hprice.PNVAL05A'Img & ";" & stda.LF &
                -- INDENT & "PHVAL05A = " & hprice.PHVAL05A'Img & ";" & stda.LF &
                -- INDENT & "PVAL05 = " & hprice.PVAL05'Img & ";" & stda.LF;
        -- end To_String;
--
--
        -- function To_String( takeup : Takeup_Estimates_Rec ) return String is
        -- begin
                -- return
                -- INDENT & "SERNUM = " & takeup.SERNUM & ";" & stda.LF &
                -- INDENT & "hh_sequence = " & takeup.hh_sequence'Img & ";" & stda.LF &
                -- INDENT & "BENUNIT = " & takeup.BENUNIT'Img & ";" & stda.LF &
                -- INDENT & "HPERSON = " & takeup.HPERSON'Img & ";" & stda.LF &
                -- INDENT & "AGE = " & takeup.AGE'Img & ";" & stda.LF &
                -- INDENT & "AAMODV = " & takeup.AAMODV'Img & ";" & stda.LF &
                -- INDENT & "SEX = " & takeup.SEX'Img & ";" & stda.LF &
                -- INDENT & "ADULT = " & takeup.ADULT'Img & ";" & stda.LF &
                -- INDENT & "PDIV = " & takeup.PDIV'Img & ";" & stda.LF &
                -- INDENT & "PFAM = " & takeup.PFAM'Img & ";" & stda.LF &
                -- INDENT & "PPIN = " & takeup.PPIN'Img & ";" & stda.LF &
                -- INDENT & "POTH = " & takeup.POTH'Img & ";" & stda.LF &
                -- INDENT & "PCRI = " & takeup.PCRI'Img & ";" & stda.LF &
                -- INDENT & "PMISC = " & takeup.PMISC'Img & ";" & stda.LF &
                -- INDENT & "CLA05B = " & takeup.CLA05B'Img & ";" & stda.LF &
                -- INDENT & "PIN05B = " & takeup.PIN05B'Img & ";" & stda.LF &
                -- INDENT & "ABW05B = " & takeup.ABW05B'Img & ";" & stda.LF &
                -- INDENT & "LAA05B = " & takeup.LAA05B'Img & ";" & stda.LF &
                -- INDENT & "CLADIVR = " & takeup.CLADIVR'Img & ";" & stda.LF &
                -- INDENT & "CLADIVT = " & takeup.CLADIVT'Img & ";" & stda.LF &
                -- INDENT & "CLADIVB = " & takeup.CLADIVB'Img & ";" & stda.LF &
                -- INDENT & "CLAFAMR = " & takeup.CLAFAMR'Img & ";" & stda.LF &
                -- INDENT & "CLAFAMT = " & takeup.CLAFAMT'Img & ";" & stda.LF &
                -- INDENT & "CLAFAMB = " & takeup.CLAFAMB'Img & ";" & stda.LF &
                -- INDENT & "CLAPINR = " & takeup.CLAPINR'Img & ";" & stda.LF &
                -- INDENT & "CLAPINT = " & takeup.CLAPINT'Img & ";" & stda.LF &
                -- INDENT & "CLAPINB = " & takeup.CLAPINB'Img & ";" & stda.LF &
                -- INDENT & "CLAOTHR = " & takeup.CLAOTHR'Img & ";" & stda.LF &
                -- INDENT & "CLAOTHT = " & takeup.CLAOTHT'Img & ";" & stda.LF &
                -- INDENT & "CLAOTHB = " & takeup.CLAOTHB'Img & ";" & stda.LF &
                -- INDENT & "CLACRIR = " & takeup.CLACRIR'Img & ";" & stda.LF &
                -- INDENT & "CLACRIT = " & takeup.CLACRIT'Img & ";" & stda.LF &
                -- INDENT & "CLACRIB = " & takeup.CLACRIB'Img & ";" & stda.LF &
                -- INDENT & "CLAMISR = " & takeup.CLAMISR'Img & ";" & stda.LF &
                -- INDENT & "CLAMIST = " & takeup.CLAMIST'Img & ";" & stda.LF &
                -- INDENT & "CLAMISB = " & takeup.CLAMISB'Img & ";" & stda.LF &
                -- INDENT & "ABWDIVR = " & takeup.ABWDIVR'Img & ";" & stda.LF &
                -- INDENT & "ABWDIVT = " & takeup.ABWDIVT'Img & ";" & stda.LF &
                -- INDENT & "ABWDIVB = " & takeup.ABWDIVB'Img & ";" & stda.LF &
                -- INDENT & "ABWFAMR = " & takeup.ABWFAMR'Img & ";" & stda.LF &
                -- INDENT & "ABWFAMT = " & takeup.ABWFAMT'Img & ";" & stda.LF &
                -- INDENT & "ABWFAMB = " & takeup.ABWFAMB'Img & ";" & stda.LF &
                -- INDENT & "ABWOTHR = " & takeup.ABWOTHR'Img & ";" & stda.LF &
                -- INDENT & "ABWOTHT = " & takeup.ABWOTHT'Img & ";" & stda.LF &
                -- INDENT & "ABWOTHB = " & takeup.ABWOTHB'Img & ";" & stda.LF &
                -- INDENT & "ABWCRIR = " & takeup.ABWCRIR'Img & ";" & stda.LF &
                -- INDENT & "ABWCRIT = " & takeup.ABWCRIT'Img & ";" & stda.LF &
                -- INDENT & "ABWCRIB = " & takeup.ABWCRIB'Img & ";" & stda.LF &
                -- INDENT & "ABWMISR = " & takeup.ABWMISR'Img & ";" & stda.LF &
                -- INDENT & "ABWMIST = " & takeup.ABWMIST'Img & ";" & stda.LF &
                -- INDENT & "ABWMISB = " & takeup.ABWMISB'Img & ";" & stda.LF &
                -- INDENT & "LAADIVR = " & takeup.LAADIVR'Img & ";" & stda.LF &
                -- INDENT & "LAADIVT = " & takeup.LAADIVT'Img & ";" & stda.LF &
                -- INDENT & "LAADIVB = " & takeup.LAADIVB'Img & ";" & stda.LF &
                -- INDENT & "LAAFAMR = " & takeup.LAAFAMR'Img & ";" & stda.LF &
                -- INDENT & "LAAFAMT = " & takeup.LAAFAMT'Img & ";" & stda.LF &
                -- INDENT & "LAAFAMB = " & takeup.LAAFAMB'Img & ";" & stda.LF &
                -- INDENT & "LAAPINR = " & takeup.LAAPINR'Img & ";" & stda.LF &
                -- INDENT & "LAAPINT = " & takeup.LAAPINT'Img & ";" & stda.LF &
                -- INDENT & "LAAPINB = " & takeup.LAAPINB'Img & ";" & stda.LF &
                -- INDENT & "LAAOTHR = " & takeup.LAAOTHR'Img & ";" & stda.LF &
                -- INDENT & "LAAOTHT = " & takeup.LAAOTHT'Img & ";" & stda.LF &
                -- INDENT & "LAAOTHB = " & takeup.LAAOTHB'Img & ";" & stda.LF &
                -- INDENT & "LAACRIR = " & takeup.LAACRIR'Img & ";" & stda.LF &
                -- INDENT & "LAACRIT = " & takeup.LAACRIT'Img & ";" & stda.LF &
                -- INDENT & "LAACRIB = " & takeup.LAACRIB'Img & ";" & stda.LF &
                -- INDENT & "LAAMISR = " & takeup.LAAMISR'Img & ";" & stda.LF &
                -- INDENT & "LAAMIST = " & takeup.LAAMIST'Img & ";" & stda.LF &
                -- INDENT & "LAAMISB = " & takeup.LAAMISB'Img & ";" & stda.LF;
        -- end To_String;


        function To_String (v : Account_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM));
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCOUNT = " & v.ACCOUNT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCINT = " & v.ACCINT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCTAX = " & v.ACCTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "INVTAX = " & v.INVTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "NSAMT = " & v.NSAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Adult_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABS1NO = " & v.ABS1NO'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABS2NO = " & v.ABS2NO'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABSPAR = " & v.ABSPAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABSPAY = " & v.ABSPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABSWHY = " & v.ABSWHY'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABSWK = " & v.ABSWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "X_ACCESS = " & v.X_ACCESS'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCFTPT = " & v.ACCFTPT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJB = " & v.ACCJB'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCSSAMT = " & v.ACCSSAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCSSPD = " & v.ACCSSPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADEDUC = " & v.ADEDUC'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADEMA = " & v.ADEMA'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADEMAAMT = " & v.ADEMAAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADEMAPD = " & v.ADEMAPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "AGE = " & v.AGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLOW1 = " & v.ALLOW1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLOW2 = " & v.ALLOW2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLOW3 = " & v.ALLOW3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLOW4 = " & v.ALLOW4'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPAY1 = " & v.ALLPAY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPAY2 = " & v.ALLPAY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPAY3 = " & v.ALLPAY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPAY4 = " & v.ALLPAY4'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPD1 = " & v.ALLPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPD2 = " & v.ALLPD2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPD3 = " & v.ALLPD3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ALLPD4 = " & v.ALLPD4'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYACC = " & v.ANYACC'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYED = " & v.ANYED'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYMON = " & v.ANYMON'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN1 = " & v.ANYPEN1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN2 = " & v.ANYPEN2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN3 = " & v.ANYPEN3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN4 = " & v.ANYPEN4'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN5 = " & v.ANYPEN5'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN6 = " & v.ANYPEN6'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYPEN7 = " & v.ANYPEN7'Img & stda.LF);
                ustr.Append (outs, INDENT & "APAMT = " & v.APAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "APDAMT = " & v.APDAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "APDIR = " & v.APDIR'Img & stda.LF);
                ustr.Append (outs, INDENT & "APDPD = " & v.APDPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "APPD = " & v.APPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "B2QFUT1 = " & v.B2QFUT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "B2QFUT2 = " & v.B2QFUT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "B2QFUT3 = " & v.B2QFUT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "B3QFUT1 = " & v.B3QFUT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "B3QFUT2 = " & v.B3QFUT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "B3QFUT3 = " & v.B3QFUT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "B3QFUT4 = " & v.B3QFUT4'Img & stda.LF);
                ustr.Append (outs, INDENT & "B3QFUT5 = " & v.B3QFUT5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q1 = " & v.BEN1Q1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q2 = " & v.BEN1Q2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q3 = " & v.BEN1Q3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q4 = " & v.BEN1Q4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q5 = " & v.BEN1Q5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q6 = " & v.BEN1Q6'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN1Q7 = " & v.BEN1Q7'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN2Q1 = " & v.BEN2Q1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN2Q2 = " & v.BEN2Q2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN2Q3 = " & v.BEN2Q3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN3Q1 = " & v.BEN3Q1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN3Q2 = " & v.BEN3Q2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN3Q3 = " & v.BEN3Q3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN3Q4 = " & v.BEN3Q4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN3Q5 = " & v.BEN3Q5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN4Q1 = " & v.BEN4Q1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN4Q2 = " & v.BEN4Q2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN4Q3 = " & v.BEN4Q3'Img & stda.LF);
                --ustr.Append (outs, INDENT & "BEN4Q4 = " & v.BEN4Q4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN5Q1 = " & v.BEN5Q1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN5Q2 = " & v.BEN5Q2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN5Q3 = " & v.BEN5Q3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN5Q4 = " & v.BEN5Q4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN5Q5 = " & v.BEN5Q5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN5Q6 = " & v.BEN5Q6'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q1 = " & v.BEN7Q1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q2 = " & v.BEN7Q2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q3 = " & v.BEN7Q3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q4 = " & v.BEN7Q4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q5 = " & v.BEN7Q5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q6 = " & v.BEN7Q6'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q7 = " & v.BEN7Q7'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q8 = " & v.BEN7Q8'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN7Q9 = " & v.BEN7Q9'Img & stda.LF);
                ustr.Append (outs, INDENT & "BTWACC = " & v.BTWACC'Img & stda.LF);
                ustr.Append (outs, INDENT & "CLAIMANT = " & v.CLAIMANT'Img & stda.LF);
                ustr.Append (outs, INDENT & "COHABIT = " & v.COHABIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "COMBID = " & v.COMBID'Img & stda.LF);
                ustr.Append (outs, INDENT & "CONVBL = " & v.CONVBL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CVHT = " & v.CVHT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CVPAY = " & v.CVPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "CVPD = " & v.CVPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "DENTIST = " & v.DENTIST'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEPEND = " & v.DEPEND'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF1 = " & v.DISDIF1'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF2 = " & v.DISDIF2'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF3 = " & v.DISDIF3'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF4 = " & v.DISDIF4'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF5 = " & v.DISDIF5'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF6 = " & v.DISDIF6'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF7 = " & v.DISDIF7'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISDIF8 = " & v.DISDIF8'Img & stda.LF);
                ustr.Append (outs, INDENT & "DOB = " & v.DOB'Img & stda.LF);
                ustr.Append (outs, INDENT & "DPTCBOTH = " & v.DPTCBOTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "DPTCLUM = " & v.DPTCLUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "DVIL03A = " & v.DVIL03A'Img & stda.LF);
                ustr.Append (outs, INDENT & "DVIL04A = " & v.DVIL04A'Img & stda.LF);
                ustr.Append (outs, INDENT & "DVJB12ML = " & v.DVJB12ML'Img & stda.LF);
                ustr.Append (outs, INDENT & "DVMARDF = " & v.DVMARDF'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED1AMT = " & v.ED1AMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED1BORR = " & v.ED1BORR'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED1INT = " & v.ED1INT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED1MONYR = " & v.ED1MONYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED1PD = " & v.ED1PD'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED1SUM = " & v.ED1SUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED2AMT = " & v.ED2AMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED2BORR = " & v.ED2BORR'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED2INT = " & v.ED2INT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED2MONYR = " & v.ED2MONYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED2PD = " & v.ED2PD'Img & stda.LF);
                ustr.Append (outs, INDENT & "ED2SUM = " & v.ED2SUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDATTN1 = " & v.EDATTN1'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDATTN2 = " & v.EDATTN2'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDATTN3 = " & v.EDATTN3'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDHR = " & v.EDHR'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDTIME = " & v.EDTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "ELIGADLT = " & v.ELIGADLT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ELIGCHLD = " & v.ELIGCHLD'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPPAY1 = " & v.EMPPAY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPPAY2 = " & v.EMPPAY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPPAY3 = " & v.EMPPAY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPSTAT = " & v.EMPSTAT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDYR = " & v.ENDYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "EPCUR = " & v.EPCUR'Img & stda.LF);
                ustr.Append (outs, INDENT & "ES2000 = " & v.ES2000'Img & stda.LF);
                ustr.Append (outs, INDENT & "ETHGRP = " & v.ETHGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "EVERWRK = " & v.EVERWRK'Img & stda.LF);
                ustr.Append (outs, INDENT & "EXTHBCT1 = " & v.EXTHBCT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "EXTHBCT2 = " & v.EXTHBCT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "EXTHBCT3 = " & v.EXTHBCT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "EYETEST = " & v.EYETEST'Img & stda.LF);
                ustr.Append (outs, INDENT & "FARE = " & v.FARE'Img & stda.LF);
                ustr.Append (outs, INDENT & "FOLLOW = " & v.FOLLOW'Img & stda.LF);
                ustr.Append (outs, INDENT & "FTED = " & v.FTED'Img & stda.LF);
                ustr.Append (outs, INDENT & "FTWK = " & v.FTWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "FUTURE = " & v.FUTURE'Img & stda.LF);
                ustr.Append (outs, INDENT & "GOVPIS = " & v.GOVPIS'Img & stda.LF);
                ustr.Append (outs, INDENT & "GOVPJSA = " & v.GOVPJSA'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRANT = " & v.GRANT'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTAMT1 = " & v.GRTAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTAMT2 = " & v.GRTAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTDIR1 = " & v.GRTDIR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTDIR2 = " & v.GRTDIR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTNUM = " & v.GRTNUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTSCE1 = " & v.GRTSCE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTSCE2 = " & v.GRTSCE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTVAL1 = " & v.GRTVAL1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTVAL2 = " & v.GRTVAL2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GTA = " & v.GTA'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBOTHAMT = " & v.HBOTHAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBOTHBU = " & v.HBOTHBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBOTHPD = " & v.HBOTHPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBOTHWK = " & v.HBOTHWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBOTWAIT = " & v.HBOTWAIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HEALTH = " & v.HEALTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHOLDER = " & v.HHOLDER'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOSP = " & v.HOSP'Img & stda.LF);
                ustr.Append (outs, INDENT & "HPROB = " & v.HPROB'Img & stda.LF);
                ustr.Append (outs, INDENT & "HRPID = " & v.HRPID'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCDUR = " & v.INCDUR'Img & stda.LF);
                ustr.Append (outs, INDENT & "INJLONG = " & v.INJLONG'Img & stda.LF);
                ustr.Append (outs, INDENT & "INJWK = " & v.INJWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "INVESTS = " & v.INVESTS'Img & stda.LF);
                ustr.Append (outs, INDENT & "IOUT = " & v.IOUT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISA1TYPE = " & v.ISA1TYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISA2TYPE = " & v.ISA2TYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISA3TYPE = " & v.ISA3TYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "JOBAWAY = " & v.JOBAWAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "LAREG = " & v.LAREG'Img & stda.LF);
                ustr.Append (outs, INDENT & "LIKEWK = " & v.LIKEWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "LN1RPINT = " & v.LN1RPINT'Img & stda.LF);
                ustr.Append (outs, INDENT & "LN2RPINT = " & v.LN2RPINT'Img & stda.LF);
                ustr.Append (outs, INDENT & "LOAN = " & v.LOAN'Img & stda.LF);
                ustr.Append (outs, INDENT & "LOANNUM = " & v.LOANNUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "LOOK = " & v.LOOK'Img & stda.LF);
                ustr.Append (outs, INDENT & "LOOKWK = " & v.LOOKWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "LSTWRK1 = " & v.LSTWRK1'Img & stda.LF);
                ustr.Append (outs, INDENT & "LSTWRK2 = " & v.LSTWRK2'Img & stda.LF);
                ustr.Append (outs, INDENT & "LSTYR = " & v.LSTYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTAMT1 = " & v.MNTAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTAMT2 = " & v.MNTAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTCT = " & v.MNTCT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTFOR1 = " & v.MNTFOR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTFOR2 = " & v.MNTFOR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTGOV1 = " & v.MNTGOV1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTGOV2 = " & v.MNTGOV2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTPAY = " & v.MNTPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTPD1 = " & v.MNTPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTPD2 = " & v.MNTPD2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTREC = " & v.MNTREC'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTTOTA1 = " & v.MNTTOTA1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTTOTA2 = " & v.MNTTOTA2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTUS1 = " & v.MNTUS1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTUS2 = " & v.MNTUS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTUSAM1 = " & v.MNTUSAM1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTUSAM2 = " & v.MNTUSAM2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTUSPD1 = " & v.MNTUSPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTUSPD2 = " & v.MNTUSPD2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MS = " & v.MS'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATID1 = " & v.NATID1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATID2 = " & v.NATID2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATID3 = " & v.NATID3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATID4 = " & v.NATID4'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATID5 = " & v.NATID5'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATID6 = " & v.NATID6'Img & stda.LF);
                ustr.Append (outs, INDENT & "NDEAL = " & v.NDEAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "NEWDTYPE = " & v.NEWDTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHS1 = " & v.NHS1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHS2 = " & v.NHS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHS3 = " & v.NHS3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIAMT = " & v.NIAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIETHGRP = " & v.NIETHGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIEXTHBB = " & v.NIEXTHBB'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID1 = " & v.NINATID1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID2 = " & v.NINATID2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID3 = " & v.NINATID3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID4 = " & v.NINATID4'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID5 = " & v.NINATID5'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID6 = " & v.NINATID6'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID7 = " & v.NINATID7'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINATID8 = " & v.NINATID8'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIPD = " & v.NIPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIREG = " & v.NIREG'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIREL = " & v.NIREL'Img & stda.LF);
                ustr.Append (outs, INDENT & "NITRAIN = " & v.NITRAIN'Img & stda.LF);
                ustr.Append (outs, INDENT & "NITTWMOD = " & v.NITTWMOD'Img & stda.LF);
                ustr.Append (outs, INDENT & "NLPER = " & v.NLPER'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOLK1 = " & v.NOLK1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOLK2 = " & v.NOLK2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOLK3 = " & v.NOLK3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOLOOK = " & v.NOLOOK'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOWANT = " & v.NOWANT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NSSEC = " & v.NSSEC'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMJOB = " & v.NUMJOB'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMJOB2 = " & v.NUMJOB2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ODDJOB = " & v.ODDJOB'Img & stda.LF);
                ustr.Append (outs, INDENT & "OLDSTUD = " & v.OLDSTUD'Img & stda.LF);
                ustr.Append (outs, INDENT & "ONEWAY = " & v.ONEWAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTABSPAR = " & v.OTABSPAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTAMT = " & v.OTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTAPAMT = " & v.OTAPAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTAPPD = " & v.OTAPPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHTAX = " & v.OTHTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTINVA = " & v.OTINVA'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAREAMT = " & v.PAREAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAREPD = " & v.PAREPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENLUMP = " & v.PENLUMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "PPNUMC = " & v.PPNUMC'Img & stda.LF);
                --ustr.Append (outs, INDENT & "PPREB = " & v.PPREB'Img & stda.LF);
                --ustr.Append (outs, INDENT & "PPREBDAT = " & v.PPREBDAT'Img & stda.LF);
                --ustr.Append (outs, INDENT & "PPREBGOV = " & v.PPREBGOV'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRIT = " & v.PRIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRSCRPT = " & v.PRSCRPT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PSSAMT = " & v.PSSAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PSSDATE = " & v.PSSDATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "PTWK = " & v.PTWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "R01 = " & v.R01'Img & stda.LF);
                ustr.Append (outs, INDENT & "R02 = " & v.R02'Img & stda.LF);
                ustr.Append (outs, INDENT & "R03 = " & v.R03'Img & stda.LF);
                ustr.Append (outs, INDENT & "R04 = " & v.R04'Img & stda.LF);
                ustr.Append (outs, INDENT & "R05 = " & v.R05'Img & stda.LF);
                ustr.Append (outs, INDENT & "R06 = " & v.R06'Img & stda.LF);
                ustr.Append (outs, INDENT & "R07 = " & v.R07'Img & stda.LF);
                ustr.Append (outs, INDENT & "R08 = " & v.R08'Img & stda.LF);
                ustr.Append (outs, INDENT & "R09 = " & v.R09'Img & stda.LF);
                ustr.Append (outs, INDENT & "R10 = " & v.R10'Img & stda.LF);
                ustr.Append (outs, INDENT & "R11 = " & v.R11'Img & stda.LF);
                ustr.Append (outs, INDENT & "R12 = " & v.R12'Img & stda.LF);
                ustr.Append (outs, INDENT & "R13 = " & v.R13'Img & stda.LF);
                ustr.Append (outs, INDENT & "R14 = " & v.R14'Img & stda.LF);
                ustr.Append (outs, INDENT & "REDAMT = " & v.REDAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "REDANY = " & v.REDANY'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTPROF = " & v.RENTPROF'Img & stda.LF);
                ustr.Append (outs, INDENT & "RETIRE = " & v.RETIRE'Img & stda.LF);
                ustr.Append (outs, INDENT & "RETIRE1 = " & v.RETIRE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "RETREAS = " & v.RETREAS'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYAL1 = " & v.ROYAL1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYAL2 = " & v.ROYAL2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYAL3 = " & v.ROYAL3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYAL4 = " & v.ROYAL4'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYYR1 = " & v.ROYYR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYYR2 = " & v.ROYYR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYYR3 = " & v.ROYYR3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROYYR4 = " & v.ROYYR4'Img & stda.LF);
                ustr.Append (outs, INDENT & "RSTRCT = " & v.RSTRCT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEX = " & v.SEX'Img & stda.LF);
                ustr.Append (outs, INDENT & "SFLNTYP1 = " & v.SFLNTYP1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SFLNTYP2 = " & v.SFLNTYP2'Img & stda.LF);
                --ustr.Append (outs, INDENT & "SFRPIS = " & v.SFRPIS'Img & stda.LF);
                --ustr.Append (outs, INDENT & "SFRPJSA = " & v.SFRPJSA'Img & stda.LF);
                ustr.Append (outs, INDENT & "SFTYPE1 = " & v.SFTYPE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SFTYPE2 = " & v.SFTYPE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SIC = " & v.SIC'Img & stda.LF);
                ustr.Append (outs, INDENT & "SLREPAMT = " & v.SLREPAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SLREPAY = " & v.SLREPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "SLREPPD = " & v.SLREPPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "SOC2000 = " & v.SOC2000'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPCREG1 = " & v.SPCREG1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPCREG2 = " & v.SPCREG2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPCREG3 = " & v.SPCREG3'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPECS = " & v.SPECS'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPOUT = " & v.SPOUT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SRENTAMT = " & v.SRENTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SRENTPD = " & v.SRENTPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "START = " & v.START'Img & stda.LF);
                ustr.Append (outs, INDENT & "STARTYR = " & v.STARTYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXCRED1 = " & v.TAXCRED1'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXCRED2 = " & v.TAXCRED2'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXCRED3 = " & v.TAXCRED3'Img & stda.LF);
                --ustr.Append (outs, INDENT & "TAXFUT1 = " & v.TAXFUT1'Img & stda.LF);
                --ustr.Append (outs, INDENT & "TAXFUT2 = " & v.TAXFUT2'Img & stda.LF);
                --ustr.Append (outs, INDENT & "TAXFUT3 = " & v.TAXFUT3'Img & stda.LF);
                --ustr.Append (outs, INDENT & "TAXFUT4 = " & v.TAXFUT4'Img & stda.LF);
                ustr.Append (outs, INDENT & "TDAYWRK = " & v.TDAYWRK'Img & stda.LF);
                ustr.Append (outs, INDENT & "TEA = " & v.TEA'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOPUPL = " & v.TOPUPL'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTINT = " & v.TOTINT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TRAIN = " & v.TRAIN'Img & stda.LF);
                ustr.Append (outs, INDENT & "TRAV = " & v.TRAV'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWCODE1 = " & v.TTWCODE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWCODE2 = " & v.TTWCODE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWCODE3 = " & v.TTWCODE3'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWCOST = " & v.TTWCOST'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWFAR = " & v.TTWFAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWFRQ = " & v.TTWFRQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWMOD = " & v.TTWMOD'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWPAY = " & v.TTWPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWPSS = " & v.TTWPSS'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWREC = " & v.TTWREC'Img & stda.LF);
                ustr.Append (outs, INDENT & "TUBORR = " & v.TUBORR'Img & stda.LF);
                ustr.Append (outs, INDENT & "TYPEED = " & v.TYPEED'Img & stda.LF);
                ustr.Append (outs, INDENT & "UNPAID1 = " & v.UNPAID1'Img & stda.LF);
                ustr.Append (outs, INDENT & "UNPAID2 = " & v.UNPAID2'Img & stda.LF);
                ustr.Append (outs, INDENT & "VOUCHER = " & v.VOUCHER'Img & stda.LF);
                ustr.Append (outs, INDENT & "W1 = " & v.W1'Img & stda.LF);
                ustr.Append (outs, INDENT & "W2 = " & v.W2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WAIT = " & v.WAIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WAR1 = " & v.WAR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WAR2 = " & v.WAR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WFTCBOTH = " & v.WFTCBOTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "WFTCLUM = " & v.WFTCLUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORESP = " & v.WHORESP'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOSECTB = " & v.WHOSECTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRDE1 = " & v.WHYFRDE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRDE2 = " & v.WHYFRDE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRDE3 = " & v.WHYFRDE3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRDE4 = " & v.WHYFRDE4'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRDE5 = " & v.WHYFRDE5'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRDE6 = " & v.WHYFRDE6'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFREY1 = " & v.WHYFREY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFREY2 = " & v.WHYFREY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFREY3 = " & v.WHYFREY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFREY4 = " & v.WHYFREY4'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFREY5 = " & v.WHYFREY5'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFREY6 = " & v.WHYFREY6'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRPR1 = " & v.WHYFRPR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRPR2 = " & v.WHYFRPR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRPR3 = " & v.WHYFRPR3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRPR4 = " & v.WHYFRPR4'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRPR5 = " & v.WHYFRPR5'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYFRPR6 = " & v.WHYFRPR6'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV1 = " & v.WHYTRAV1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV2 = " & v.WHYTRAV2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV3 = " & v.WHYTRAV3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV4 = " & v.WHYTRAV4'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV5 = " & v.WHYTRAV5'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV6 = " & v.WHYTRAV6'Img & stda.LF);
                ustr.Append (outs, INDENT & "WMKIT = " & v.WMKIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WORKING = " & v.WORKING'Img & stda.LF);
                ustr.Append (outs, INDENT & "WPA = " & v.WPA'Img & stda.LF);
                ustr.Append (outs, INDENT & "WPBA = " & v.WPBA'Img & stda.LF);
                ustr.Append (outs, INDENT & "YSTRTWK = " & v.YSTRTWK'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "ABLE = " & v.ABLE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACTACCI = " & v.ACTACCI'Img & stda.LF);
                ustr.Append (outs, INDENT & "BNTXCRED = " & v.BNTXCRED'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREAB = " & v.CAREAB'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREAH = " & v.CAREAH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARECB = " & v.CARECB'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARECH = " & v.CARECH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARECL = " & v.CARECL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREFR = " & v.CAREFR'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREOT = " & v.CAREOT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARERE = " & v.CARERE'Img & stda.LF);
                ustr.Append (outs, INDENT & "CURACTI = " & v.CURACTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPOCCP = " & v.EMPOCCP'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPSTATB = " & v.EMPSTATB'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPSTATC = " & v.EMPSTATC'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPSTATI = " & v.EMPSTATI'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSBNDCTI = " & v.FSBNDCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "FWMLKVAL = " & v.FWMLKVAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "GILTCTI = " & v.GILTCTI'Img & stda.LF);
                --ustr.Append (outs, INDENT & "GROSSold = " & v.GROSSold'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBSUPRAN = " & v.HBSUPRAN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDAGE = " & v.HDAGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDBEN = " & v.HDBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDINDINC = " & v.HDINDINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURAB = " & v.HOURAB'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURAH = " & v.HOURAH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCARE = " & v.HOURCARE'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCB = " & v.HOURCB'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCH = " & v.HOURCH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCL = " & v.HOURCL'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURFR = " & v.HOURFR'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUROT = " & v.HOUROT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURRE = " & v.HOURRE'Img & stda.LF);
                ustr.Append (outs, INDENT & "HPERSON = " & v.HPERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "IAGEGR2 = " & v.IAGEGR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "IAGEGRP = " & v.IAGEGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCSEO2 = " & v.INCSEO2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INDINC = " & v.INDINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "INDISBEN = " & v.INDISBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "INEARNS = " & v.INEARNS'Img & stda.LF);
                ustr.Append (outs, INDENT & "ININV = " & v.ININV'Img & stda.LF);
                ustr.Append (outs, INDENT & "INIRBEN = " & v.INIRBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "INNIRBEN = " & v.INNIRBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "INOTHBEN = " & v.INOTHBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "INPENINC = " & v.INPENINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "INRINC = " & v.INRINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "INRPINC = " & v.INRPINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTVLIC = " & v.INTVLIC'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTXCRED = " & v.INTXCRED'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISACTI = " & v.ISACTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "MARITAL = " & v.MARITAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "NETOCPEN = " & v.NETOCPEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINCSEO2 = " & v.NINCSEO2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINDINC = " & v.NINDINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINEARNS = " & v.NINEARNS'Img & stda.LF);
                ustr.Append (outs, INDENT & "NININV = " & v.NININV'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINPENIN = " & v.NINPENIN'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINSEIN2 = " & v.NINSEIN2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NSBOCTI = " & v.NSBOCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "OCCUPNUM = " & v.OCCUPNUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTBSCTI = " & v.OTBSCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "PEPSCTI = " & v.PEPSCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "POACCTI = " & v.POACCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRBOCTI = " & v.PRBOCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "RELHRP = " & v.RELHRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "SAYECTI = " & v.SAYECTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "SCLBCTI = " & v.SCLBCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEINCAM2 = " & v.SEINCAM2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SMPADJ = " & v.SMPADJ'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSCTI = " & v.SSCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSPADJ = " & v.SSPADJ'Img & stda.LF);
                ustr.Append (outs, INDENT & "STSHCTI = " & v.STSHCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "SUPERAN = " & v.SUPERAN'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXPAYER = " & v.TAXPAYER'Img & stda.LF);
                ustr.Append (outs, INDENT & "TESSCTI = " & v.TESSCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTGRANT = " & v.TOTGRANT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTHOURS = " & v.TOTHOURS'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTOCCP = " & v.TOTOCCP'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWCOSTS = " & v.TTWCOSTS'Img & stda.LF);
                ustr.Append (outs, INDENT & "TTWMODE = " & v.TTWMODE'Img & stda.LF);
                ustr.Append (outs, INDENT & "UNTRCTI = " & v.UNTRCTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "UPERSON = " & v.UPERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "WIDOCCP = " & v.WIDOCCP'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSS2 = " & v.GROSS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "B3QFUT6 = " & v.B3QFUT6'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEN3Q6 = " & v.BEN3Q6'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTCLUM1 = " & v.CTCLUM1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTCLUM2 = " & v.CTCLUM2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CUPCHK = " & v.CUPCHK'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDATT = " & v.EDATT'Img & stda.LF);
                ustr.Append (outs, INDENT & "EDTYP = " & v.EDTYP'Img & stda.LF);
                ustr.Append (outs, INDENT & "LKTIME = " & v.LKTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCAPP = " & v.NTCAPP'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCDAT = " & v.NTCDAT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCINC = " & v.NTCINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCORIG1 = " & v.NTCORIG1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCORIG2 = " & v.NTCORIG2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCORIG3 = " & v.NTCORIG3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCORIG4 = " & v.NTCORIG4'Img & stda.LF);
                ustr.Append (outs, INDENT & "NTCORIG5 = " & v.NTCORIG5'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXCRED4 = " & v.TAXCRED4'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXCRED5 = " & v.TAXCRED5'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXFUT = " & v.TAXFUT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WINTFUEL = " & v.WINTFUEL'Img & stda.LF);
                ustr.Append (outs, INDENT & "WTCLUM1 = " & v.WTCLUM1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WTCLUM2 = " & v.WTCLUM2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WTCLUM3 = " & v.WTCLUM3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADDDA = " & v.ADDDA'Img & stda.LF);
                ustr.Append (outs, INDENT & "BASACTI = " & v.BASACTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREFL = " & v.CAREFL'Img & stda.LF);
                ustr.Append (outs, INDENT & "GEBACTI = " & v.GEBACTI'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSS3 = " & v.GROSS3'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURTOT = " & v.HOURTOT'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Asset_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "ASSETYPE = " & v.ASSETYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEQ = " & v.SEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCNAME = " & v.ACCNAME'Img & stda.LF);
                ustr.Append (outs, INDENT & "AMOUNT = " & v.AMOUNT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANYMON = " & v.ANYMON'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOWMANY = " & v.HOWMANY'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOWMUCH = " & v.HOWMUCH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOWMUCHE = " & v.HOWMUCHE'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTRO = " & v.INTRO'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISSDATE = " & v.ISSDATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISSVAL = " & v.ISSVAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "PD = " & v.PD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Benefit_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENEFIT = " & v.BENEFIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "BANKSTMT = " & v.BANKSTMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENAMT = " & v.BENAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENAMTDK = " & v.BENAMTDK'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENLETTR = " & v.BENLETTR'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENPD = " & v.BENPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "BOOKCARD = " & v.BOOKCARD'Img & stda.LF);
                ustr.Append (outs, INDENT & "CCTC = " & v.CCTC'Img & stda.LF);
                ustr.Append (outs, INDENT & "COMBAMT = " & v.COMBAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "COMBBK = " & v.COMBBK'Img & stda.LF);
                ustr.Append (outs, INDENT & "COMBPD = " & v.COMBPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOWBEN = " & v.HOWBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOTUSAMT = " & v.NOTUSAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOTUSPD = " & v.NOTUSPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMWEEKS = " & v.NUMWEEKS'Img & stda.LF);
                ustr.Append (outs, INDENT & "ORDBKNO = " & v.ORDBKNO'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRES = " & v.PRES'Img & stda.LF);
                ustr.Append (outs, INDENT & "USUAL = " & v.USUAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "VAR1 = " & v.VAR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "VAR2 = " & v.VAR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "VAR3 = " & v.VAR3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOREC1 = " & v.WHOREC1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOREC2 = " & v.WHOREC2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOREC3 = " & v.WHOREC3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOREC4 = " & v.WHOREC4'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOREC5 = " & v.WHOREC5'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYSLIPB = " & v.PAYSLIPB'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Benunit_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                --ustr.Append (outs, INDENT & "FSMAPPLY = " & v.FSMAPPLY'Img & stda.LF);
                --ustr.Append (outs, INDENT & "FSMTKUP = " & v.FSMTKUP'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCCHNGE = " & v.INCCHNGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCHILOW = " & v.INCHILOW'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDINC = " & v.KIDINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHHCHILD = " & v.NHHCHILD'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTSAV = " & v.TOTSAV'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACTACCB = " & v.ACTACCB'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADULTB = " & v.ADULTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "BOARDER = " & v.BOARDER'Img & stda.LF);
                ustr.Append (outs, INDENT & "BPENINC = " & v.BPENINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "BSEINC = " & v.BSEINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUAGEGR2 = " & v.BUAGEGR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUAGEGRP = " & v.BUAGEGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUDISBEN = " & v.BUDISBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUEARNS = " & v.BUEARNS'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUETHGRP = " & v.BUETHGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUINC = " & v.BUINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUINV = " & v.BUINV'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUIRBEN = " & v.BUIRBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUKIDS = " & v.BUKIDS'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUNIRBEN = " & v.BUNIRBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUOTHBEN = " & v.BUOTHBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "BURENT = " & v.BURENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "BURINC = " & v.BURINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "BURPINC = " & v.BURPINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUTVLIC = " & v.BUTVLIC'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUTXCRED = " & v.BUTXCRED'Img & stda.LF);
                ustr.Append (outs, INDENT & "CURACTB = " & v.CURACTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEPCHLDB = " & v.DEPCHLDB'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEPDEDS = " & v.DEPDEDS'Img & stda.LF);
                ustr.Append (outs, INDENT & "DISINDHB = " & v.DISINDHB'Img & stda.LF);
                ustr.Append (outs, INDENT & "ECOTYPBU = " & v.ECOTYPBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "ECSTATBU = " & v.ECSTATBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "FAMTHBAI = " & v.FAMTHBAI'Img & stda.LF);
                ustr.Append (outs, INDENT & "FAMTYPBS = " & v.FAMTYPBS'Img & stda.LF);
                ustr.Append (outs, INDENT & "FAMTYPBU = " & v.FAMTYPBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "FAMTYPE = " & v.FAMTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSBNDCTB = " & v.FSBNDCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSMBU = " & v.FSMBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSMLKBU = " & v.FSMLKBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "FWMLKBU = " & v.FWMLKBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "GILTCTB = " & v.GILTCTB'Img & stda.LF);
                --ustr.Append (outs, INDENT & "GROSS2OLD = " & v.GROSS2OLD'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBINDBU = " & v.HBINDBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISACTB = " & v.ISACTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "KID04 = " & v.KID04'Img & stda.LF);
                ustr.Append (outs, INDENT & "KID1115 = " & v.KID1115'Img & stda.LF);
                ustr.Append (outs, INDENT & "KID1618 = " & v.KID1618'Img & stda.LF);
                ustr.Append (outs, INDENT & "KID510 = " & v.KID510'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU0 = " & v.KIDSBU0'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU1 = " & v.KIDSBU1'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU10 = " & v.KIDSBU10'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU11 = " & v.KIDSBU11'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU12 = " & v.KIDSBU12'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU13 = " & v.KIDSBU13'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU14 = " & v.KIDSBU14'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU15 = " & v.KIDSBU15'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU16 = " & v.KIDSBU16'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU17 = " & v.KIDSBU17'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU18 = " & v.KIDSBU18'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU2 = " & v.KIDSBU2'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU3 = " & v.KIDSBU3'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU4 = " & v.KIDSBU4'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU5 = " & v.KIDSBU5'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU6 = " & v.KIDSBU6'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU7 = " & v.KIDSBU7'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU8 = " & v.KIDSBU8'Img & stda.LF);
                ustr.Append (outs, INDENT & "KIDSBU9 = " & v.KIDSBU9'Img & stda.LF);
                ustr.Append (outs, INDENT & "LASTWORK = " & v.LASTWORK'Img & stda.LF);
                ustr.Append (outs, INDENT & "LODGER = " & v.LODGER'Img & stda.LF);
                ustr.Append (outs, INDENT & "NSBOCTB = " & v.NSBOCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTBSCTB = " & v.OTBSCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "PEPSCTB = " & v.PEPSCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "POACCTB = " & v.POACCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRBOCTB = " & v.PRBOCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "SAYECTB = " & v.SAYECTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "SCLBCTB = " & v.SCLBCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSCTB = " & v.SSCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "STSHCTB = " & v.STSHCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "SUBLTAMT = " & v.SUBLTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TESSCTB = " & v.TESSCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTCAPBU = " & v.TOTCAPBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTSAVBU = " & v.TOTSAVBU'Img & stda.LF);
                ustr.Append (outs, INDENT & "TUBURENT = " & v.TUBURENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "UNTRCTB = " & v.UNTRCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "YOUNGCH = " & v.YOUNGCH'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSS2 = " & v.GROSS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADDDABU = " & v.ADDDABU'Img & stda.LF);
                ustr.Append (outs, INDENT & "BASACTB = " & v.BASACTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUETHGR2 = " & v.BUETHGR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHDDABU = " & v.CHDDABU'Img & stda.LF);
                ustr.Append (outs, INDENT & "GEBACTB = " & v.GEBACTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSS3 = " & v.GROSS3'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Care_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NEEDPER = " & v.NEEDPER'Img & stda.LF);
                ustr.Append (outs, INDENT & "DAYNIGHT = " & v.DAYNIGHT'Img & stda.LF);
                ustr.Append (outs, INDENT & "FREQ = " & v.FREQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR01 = " & v.HOUR01'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR02 = " & v.HOUR02'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR03 = " & v.HOUR03'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR04 = " & v.HOUR04'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR05 = " & v.HOUR05'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR06 = " & v.HOUR06'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR07 = " & v.HOUR07'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR08 = " & v.HOUR08'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR09 = " & v.HOUR09'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR10 = " & v.HOUR10'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR11 = " & v.HOUR11'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR12 = " & v.HOUR12'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR13 = " & v.HOUR13'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR14 = " & v.HOUR14'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR15 = " & v.HOUR15'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR16 = " & v.HOUR16'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR17 = " & v.HOUR17'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR18 = " & v.HOUR18'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR19 = " & v.HOUR19'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUR20 = " & v.HOUR20'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO01 = " & v.WHOLOO01'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO02 = " & v.WHOLOO02'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO03 = " & v.WHOLOO03'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO04 = " & v.WHOLOO04'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO05 = " & v.WHOLOO05'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO06 = " & v.WHOLOO06'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO07 = " & v.WHOLOO07'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO08 = " & v.WHOLOO08'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO09 = " & v.WHOLOO09'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO10 = " & v.WHOLOO10'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO11 = " & v.WHOLOO11'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO12 = " & v.WHOLOO12'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO13 = " & v.WHOLOO13'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO14 = " & v.WHOLOO14'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO15 = " & v.WHOLOO15'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO16 = " & v.WHOLOO16'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO17 = " & v.WHOLOO17'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO18 = " & v.WHOLOO18'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO19 = " & v.WHOLOO19'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOLOO20 = " & v.WHOLOO20'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Child_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADEDUC = " & v.ADEDUC'Img & stda.LF);
                ustr.Append (outs, INDENT & "AGE = " & v.AGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENCCDIS = " & v.BENCCDIS'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARE = " & v.CARE'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF1 = " & v.CDISDIF1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF2 = " & v.CDISDIF2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF3 = " & v.CDISDIF3'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF4 = " & v.CDISDIF4'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF5 = " & v.CDISDIF5'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF6 = " & v.CDISDIF6'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF7 = " & v.CDISDIF7'Img & stda.LF);
                ustr.Append (outs, INDENT & "CDISDIF8 = " & v.CDISDIF8'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHAMT1 = " & v.CHAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHAMT2 = " & v.CHAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHAMTERN = " & v.CHAMTERN'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHAMTTST = " & v.CHAMTTST'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHDLA1 = " & v.CHDLA1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHDLA2 = " & v.CHDLA2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEALTH = " & v.CHEALTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEARNS1 = " & v.CHEARNS1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEARNS2 = " & v.CHEARNS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEMA = " & v.CHEMA'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEMAAMT = " & v.CHEMAAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEMAPD = " & v.CHEMAPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHFAR = " & v.CHFAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHHR1 = " & v.CHHR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHHR2 = " & v.CHHR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK01 = " & v.CHLOOK01'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK02 = " & v.CHLOOK02'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK03 = " & v.CHLOOK03'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK04 = " & v.CHLOOK04'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK05 = " & v.CHLOOK05'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK06 = " & v.CHLOOK06'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK07 = " & v.CHLOOK07'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK08 = " & v.CHLOOK08'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK09 = " & v.CHLOOK09'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHLOOK10 = " & v.CHLOOK10'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHPAY1 = " & v.CHPAY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHPAY2 = " & v.CHPAY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHPAY3 = " & v.CHPAY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHPDERN = " & v.CHPDERN'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHPDTST = " & v.CHPDTST'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHPROB = " & v.CHPROB'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHSAVE = " & v.CHSAVE'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHWKERN = " & v.CHWKERN'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHWKTST = " & v.CHWKTST'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHYRERN = " & v.CHYRERN'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHYRTST = " & v.CHYRTST'Img & stda.LF);
                ustr.Append (outs, INDENT & "COHABIT = " & v.COHABIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CONVBL = " & v.CONVBL'Img & stda.LF);
                ustr.Append (outs, INDENT & "COST = " & v.COST'Img & stda.LF);
                ustr.Append (outs, INDENT & "CVHT = " & v.CVHT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CVPAY = " & v.CVPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "CVPD = " & v.CVPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "DENTIST = " & v.DENTIST'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEPEND = " & v.DEPEND'Img & stda.LF);
                ustr.Append (outs, INDENT & "DOB = " & v.DOB'Img & stda.LF);
                ustr.Append (outs, INDENT & "ELIGADLT = " & v.ELIGADLT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ELIGCHLD = " & v.ELIGCHLD'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDYR = " & v.ENDYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "EYETEST = " & v.EYETEST'Img & stda.LF);
                ustr.Append (outs, INDENT & "FTED = " & v.FTED'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRANT = " & v.GRANT'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTAMT1 = " & v.GRTAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTAMT2 = " & v.GRTAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTDIR1 = " & v.GRTDIR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTDIR2 = " & v.GRTDIR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTNUM = " & v.GRTNUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTSCE1 = " & v.GRTSCE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTSCE2 = " & v.GRTSCE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTVAL1 = " & v.GRTVAL1'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRTVAL2 = " & v.GRTVAL2'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHOLDER = " & v.HHOLDER'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOSP = " & v.HOSP'Img & stda.LF);
                ustr.Append (outs, INDENT & "LAREG = " & v.LAREG'Img & stda.LF);
                ustr.Append (outs, INDENT & "LEGDEP = " & v.LEGDEP'Img & stda.LF);
                ustr.Append (outs, INDENT & "MS = " & v.MS'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHS1 = " & v.NHS1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHS2 = " & v.NHS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHS3 = " & v.NHS3'Img & stda.LF);
                ustr.Append (outs, INDENT & "PARENT1 = " & v.PARENT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "PARENT2 = " & v.PARENT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRIT = " & v.PRIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRSCRPT = " & v.PRSCRPT'Img & stda.LF);
                ustr.Append (outs, INDENT & "R01 = " & v.R01'Img & stda.LF);
                ustr.Append (outs, INDENT & "R02 = " & v.R02'Img & stda.LF);
                ustr.Append (outs, INDENT & "R03 = " & v.R03'Img & stda.LF);
                ustr.Append (outs, INDENT & "R04 = " & v.R04'Img & stda.LF);
                ustr.Append (outs, INDENT & "R05 = " & v.R05'Img & stda.LF);
                ustr.Append (outs, INDENT & "R06 = " & v.R06'Img & stda.LF);
                ustr.Append (outs, INDENT & "R07 = " & v.R07'Img & stda.LF);
                ustr.Append (outs, INDENT & "R08 = " & v.R08'Img & stda.LF);
                ustr.Append (outs, INDENT & "R09 = " & v.R09'Img & stda.LF);
                ustr.Append (outs, INDENT & "R10 = " & v.R10'Img & stda.LF);
                ustr.Append (outs, INDENT & "R11 = " & v.R11'Img & stda.LF);
                ustr.Append (outs, INDENT & "R12 = " & v.R12'Img & stda.LF);
                ustr.Append (outs, INDENT & "R13 = " & v.R13'Img & stda.LF);
                ustr.Append (outs, INDENT & "R14 = " & v.R14'Img & stda.LF);
                ustr.Append (outs, INDENT & "REGISTR1 = " & v.REGISTR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "REGISTR2 = " & v.REGISTR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "REGISTR3 = " & v.REGISTR3'Img & stda.LF);
                ustr.Append (outs, INDENT & "REGISTR4 = " & v.REGISTR4'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEX = " & v.SEX'Img & stda.LF);
                ustr.Append (outs, INDENT & "SMKIT = " & v.SMKIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SMLIT = " & v.SMLIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPCREG1 = " & v.SPCREG1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPCREG2 = " & v.SPCREG2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPCREG3 = " & v.SPCREG3'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPECS = " & v.SPECS'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPOUT = " & v.SPOUT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SRENTAMT = " & v.SRENTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SRENTPD = " & v.SRENTPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "STARTYR = " & v.STARTYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTSAVE = " & v.TOTSAVE'Img & stda.LF);
                ustr.Append (outs, INDENT & "TRAV = " & v.TRAV'Img & stda.LF);
                ustr.Append (outs, INDENT & "TYPEED = " & v.TYPEED'Img & stda.LF);
                ustr.Append (outs, INDENT & "VOUCHER = " & v.VOUCHER'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV1 = " & v.WHYTRAV1'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV2 = " & v.WHYTRAV2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV3 = " & v.WHYTRAV3'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV4 = " & v.WHYTRAV4'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV5 = " & v.WHYTRAV5'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYTRAV6 = " & v.WHYTRAV6'Img & stda.LF);
                ustr.Append (outs, INDENT & "WMKIT = " & v.WMKIT'Img & stda.LF);
                --ustr.Append (outs, INDENT & "WRK = " & v.WRK'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREAB = " & v.CAREAB'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREAH = " & v.CAREAH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARECB = " & v.CARECB'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARECH = " & v.CARECH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARECL = " & v.CARECL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREFR = " & v.CAREFR'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREOT = " & v.CAREOT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CARERE = " & v.CARERE'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHEARNS = " & v.CHEARNS'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHINCDV = " & v.CHINCDV'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRINC = " & v.CHRINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSMLKVAL = " & v.FSMLKVAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSMVAL = " & v.FSMVAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "FWMLKVAL = " & v.FWMLKVAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDAGECH = " & v.HDAGECH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURAB = " & v.HOURAB'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURAH = " & v.HOURAH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCB = " & v.HOURCB'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCH = " & v.HOURCH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURCL = " & v.HOURCL'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURFR = " & v.HOURFR'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOUROT = " & v.HOUROT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURRE = " & v.HOURRE'Img & stda.LF);
                ustr.Append (outs, INDENT & "HPERSON = " & v.HPERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "IAGEGR2 = " & v.IAGEGR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "IAGEGRP = " & v.IAGEGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "RELHRP = " & v.RELHRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTGNTCH = " & v.TOTGNTCH'Img & stda.LF);
                ustr.Append (outs, INDENT & "UPERSON = " & v.UPERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHAMT3 = " & v.CHAMT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHAMT4 = " & v.CHAMT4'Img & stda.LF);
                ustr.Append (outs, INDENT & "CLONE = " & v.CLONE'Img & stda.LF);
                ustr.Append (outs, INDENT & "REGISTR5 = " & v.REGISTR5'Img & stda.LF);
                ustr.Append (outs, INDENT & "CAREFL = " & v.CAREFL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHDDA = " & v.CHDDA'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOURTOT = " & v.HOURTOT'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Endowment_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTSEQ = " & v.MORTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDOWSEQ = " & v.ENDOWSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCININT = " & v.INCININT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MENPOLAM = " & v.MENPOLAM'Img & stda.LF);
                ustr.Append (outs, INDENT & "MENPOLPD = " & v.MENPOLPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MENSTYR = " & v.MENSTYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : ExtChild_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "EXTSEQ = " & v.EXTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHHAMT = " & v.NHHAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHHFEE = " & v.NHHFEE'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHHINTRO = " & v.NHHINTRO'Img & stda.LF);
                ustr.Append (outs, INDENT & "NHHPD = " & v.NHHPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : GovPay_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENEFIT = " & v.BENEFIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "GOVPAY = " & v.GOVPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Household_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSS2 = " & v.GROSS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACORN = " & v.ACORN'Img & stda.LF);
                ustr.Append (outs, INDENT & "BEDROOM = " & v.BEDROOM'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNITS = " & v.BENUNITS'Img & stda.LF);
                ustr.Append (outs, INDENT & "BILLRATE = " & v.BILLRATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUSROOM = " & v.BUSROOM'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE1 = " & v.CHARGE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE2 = " & v.CHARGE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE3 = " & v.CHARGE3'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE4 = " & v.CHARGE4'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE5 = " & v.CHARGE5'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE6 = " & v.CHARGE6'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE7 = " & v.CHARGE7'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE8 = " & v.CHARGE8'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHARGE9 = " & v.CHARGE9'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHINS = " & v.CHINS'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT1 = " & v.CHRGAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT2 = " & v.CHRGAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT3 = " & v.CHRGAMT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT4 = " & v.CHRGAMT4'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT5 = " & v.CHRGAMT5'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT6 = " & v.CHRGAMT6'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT7 = " & v.CHRGAMT7'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT8 = " & v.CHRGAMT8'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGAMT9 = " & v.CHRGAMT9'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD1 = " & v.CHRGPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD2 = " & v.CHRGPD2'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD3 = " & v.CHRGPD3'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD4 = " & v.CHRGPD4'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD5 = " & v.CHRGPD5'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD6 = " & v.CHRGPD6'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD7 = " & v.CHRGPD7'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD8 = " & v.CHRGPD8'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHRGPD9 = " & v.CHRGPD9'Img & stda.LF);
                ustr.Append (outs, INDENT & "CONTV1 = " & v.CONTV1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CONTV2 = " & v.CONTV2'Img & stda.LF);
                ustr.Append (outs, INDENT & "COVOTHS = " & v.COVOTHS'Img & stda.LF);
                ustr.Append (outs, INDENT & "CSEWAMT = " & v.CSEWAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CSEWAMT1 = " & v.CSEWAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "CT25D50D = " & v.CT25D50D'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTAMT = " & v.CTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTANNUAL = " & v.CTANNUAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTBAND = " & v.CTBAND'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTBWAIT = " & v.CTBWAIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTCONDOC = " & v.CTCONDOC'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTDISC = " & v.CTDISC'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTINSTAL = " & v.CTINSTAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTLVBAND = " & v.CTLVBAND'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTLVCHK = " & v.CTLVCHK'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTREB = " & v.CTREB'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTREBAMT = " & v.CTREBAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTREBPD = " & v.CTREBPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTTIME = " & v.CTTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "CWATAMT = " & v.CWATAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CWATAMT1 = " & v.CWATAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "DATYRAGO = " & v.DATYRAGO'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENTRY1 = " & v.ENTRY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENTRY2 = " & v.ENTRY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENTRY3 = " & v.ENTRY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENTRY4 = " & v.ENTRY4'Img & stda.LF);
                ustr.Append (outs, INDENT & "ESTRTANN = " & v.ESTRTANN'Img & stda.LF);
                ustr.Append (outs, INDENT & "FLOOR = " & v.FLOOR'Img & stda.LF);
                ustr.Append (outs, INDENT & "GIVEHELP = " & v.GIVEHELP'Img & stda.LF);
                ustr.Append (outs, INDENT & "GVTREGN = " & v.GVTREGN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR01 = " & v.HHLDR01'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR02 = " & v.HHLDR02'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR03 = " & v.HHLDR03'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR04 = " & v.HHLDR04'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR05 = " & v.HHLDR05'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR06 = " & v.HHLDR06'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR07 = " & v.HHLDR07'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR08 = " & v.HHLDR08'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR09 = " & v.HHLDR09'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR10 = " & v.HHLDR10'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR11 = " & v.HHLDR11'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR12 = " & v.HHLDR12'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR13 = " & v.HHLDR13'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR14 = " & v.HHLDR14'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHLDR97 = " & v.HHLDR97'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHSTAT = " & v.HHSTAT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HRPNUM = " & v.HRPNUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTDATE = " & v.INTDATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "LAC = " & v.LAC'Img & stda.LF);
                ustr.Append (outs, INDENT & "MAINACC = " & v.MAINACC'Img & stda.LF);
                ustr.Append (outs, INDENT & "MNTHCODE = " & v.MNTHCODE'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONLIVE = " & v.MONLIVE'Img & stda.LF);
                ustr.Append (outs, INDENT & "NEEDHELP = " & v.NEEDHELP'Img & stda.LF);
                ustr.Append (outs, INDENT & "NICOUN = " & v.NICOUN'Img & stda.LF);
                ustr.Append (outs, INDENT & "NINRV = " & v.NINRV'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIRATE = " & v.NIRATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "NORATE = " & v.NORATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ONBSROOM = " & v.ONBSROOM'Img & stda.LF);
                ustr.Append (outs, INDENT & "ORGSEWAM = " & v.ORGSEWAM'Img & stda.LF);
                ustr.Append (outs, INDENT & "ORGWATAM = " & v.ORGWATAM'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYRATE = " & v.PAYRATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "PREMIUM = " & v.PREMIUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "PTBSROOM = " & v.PTBSROOM'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROOMS = " & v.ROOMS'Img & stda.LF);
                ustr.Append (outs, INDENT & "ROOMSHAR = " & v.ROOMSHAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTANNUAL = " & v.RTANNUAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTCHECK = " & v.RTCHECK'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTCONDOC = " & v.RTCONDOC'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTDEDUC = " & v.RTDEDUC'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTINSTAL = " & v.RTINSTAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTREB = " & v.RTREB'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTREBAMT = " & v.RTREBAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTREBPD = " & v.RTREBPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "RTTIME = " & v.RTTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "SAMPQTR = " & v.SAMPQTR'Img & stda.LF);
                ustr.Append (outs, INDENT & "SCHMEAL = " & v.SCHMEAL'Img & stda.LF);
                ustr.Append (outs, INDENT & "SCHMILK = " & v.SCHMILK'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEWAMT = " & v.SEWAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEWANUL = " & v.SEWANUL'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEWERPAY = " & v.SEWERPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEWSEP = " & v.SEWSEP'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEWTIME = " & v.SEWTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "SHELTER = " & v.SHELTER'Img & stda.LF);
                ustr.Append (outs, INDENT & "SOBUY = " & v.SOBUY'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSTRTREG = " & v.SSTRTREG'Img & stda.LF);
                --ustr.Append (outs, INDENT & "STDREGN = " & v.STDREGN'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRAMT1 = " & v.STRAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRAMT2 = " & v.STRAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRCOV = " & v.STRCOV'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRMORT = " & v.STRMORT'Img & stda.LF);
                ustr.Append (outs, INDENT & "STROTHS = " & v.STROTHS'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRPD1 = " & v.STRPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRPD2 = " & v.STRPD2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SUBALLOW = " & v.SUBALLOW'Img & stda.LF);
                ustr.Append (outs, INDENT & "SUBLET = " & v.SUBLET'Img & stda.LF);
                ustr.Append (outs, INDENT & "SUBLETY = " & v.SUBLETY'Img & stda.LF);
                ustr.Append (outs, INDENT & "SUBRENT = " & v.SUBRENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TENURE = " & v.TENURE'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTADULT = " & v.TOTADULT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTCHILD = " & v.TOTCHILD'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTDEPDK = " & v.TOTDEPDK'Img & stda.LF);
                ustr.Append (outs, INDENT & "TVLIC = " & v.TVLIC'Img & stda.LF);
                ustr.Append (outs, INDENT & "TYPEACC = " & v.TYPEACC'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATAMT = " & v.WATAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATANUL = " & v.WATANUL'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATERMET = " & v.WATERMET'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATERPAY = " & v.WATERPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATRB = " & v.WATRB'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATTIME = " & v.WATTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "WELFMILK = " & v.WELFMILK'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB01 = " & v.WHOCTB01'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB02 = " & v.WHOCTB02'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB03 = " & v.WHOCTB03'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB04 = " & v.WHOCTB04'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB05 = " & v.WHOCTB05'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB06 = " & v.WHOCTB06'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB07 = " & v.WHOCTB07'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB08 = " & v.WHOCTB08'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB09 = " & v.WHOCTB09'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB10 = " & v.WHOCTB10'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB11 = " & v.WHOCTB11'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB12 = " & v.WHOCTB12'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB13 = " & v.WHOCTB13'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTB14 = " & v.WHOCTB14'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTBNS = " & v.WHOCTBNS'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHOCTBOT = " & v.WHOCTBOT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP01 = " & v.WHORSP01'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP02 = " & v.WHORSP02'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP03 = " & v.WHORSP03'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP04 = " & v.WHORSP04'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP05 = " & v.WHORSP05'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP06 = " & v.WHORSP06'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP07 = " & v.WHORSP07'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP08 = " & v.WHORSP08'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP09 = " & v.WHORSP09'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP10 = " & v.WHORSP10'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP11 = " & v.WHORSP11'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP12 = " & v.WHORSP12'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP13 = " & v.WHORSP13'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHORSP14 = " & v.WHORSP14'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOCT = " & v.WHYNOCT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WMINTRO = " & v.WMINTRO'Img & stda.LF);
                ustr.Append (outs, INDENT & "WSEWAMT = " & v.WSEWAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WSEWANUL = " & v.WSEWANUL'Img & stda.LF);
                ustr.Append (outs, INDENT & "WSEWTIME = " & v.WSEWTIME'Img & stda.LF);
                ustr.Append (outs, INDENT & "YEARCODE = " & v.YEARCODE'Img & stda.LF);
                ustr.Append (outs, INDENT & "YEARLIVE = " & v.YEARLIVE'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACTACCH = " & v.ACTACCH'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADULTH = " & v.ADULTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CURACTH = " & v.CURACTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CWATAMTD = " & v.CWATAMTD'Img & stda.LF);
                --ustr.Append (outs, INDENT & "DEPBAND = " & v.DEPBAND'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEPCHLDH = " & v.DEPCHLDH'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMP = " & v.EMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPHRP = " & v.EMPHRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDOWPAY = " & v.ENDOWPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "EQUIVAHC = " & v.EQUIVAHC'Img & stda.LF);
                ustr.Append (outs, INDENT & "EQUIVBHC = " & v.EQUIVBHC'Img & stda.LF);
                ustr.Append (outs, INDENT & "FSBNDCTH = " & v.FSBNDCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "GBHSCOST = " & v.GBHSCOST'Img & stda.LF);
                ustr.Append (outs, INDENT & "GILTCTH = " & v.GILTCTH'Img & stda.LF);
                --ustr.Append (outs, INDENT & "GROSS2OLD = " & v.GROSS2OLD'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSSCT = " & v.GROSSCT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBENINC = " & v.HBENINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBINDHH = " & v.HBINDHH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HCBAND = " & v.HCBAND'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDHHINC = " & v.HDHHINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HEARNS = " & v.HEARNS'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHAGEGR2 = " & v.HHAGEGR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHAGEGRP = " & v.HHAGEGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHCOMP = " & v.HHCOMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHCOMPS = " & v.HHCOMPS'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHDISBEN = " & v.HHDISBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHETHGRP = " & v.HHETHGRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHINC = " & v.HHINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHINCBND = " & v.HHINCBND'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHINV = " & v.HHINV'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHIRBEN = " & v.HHIRBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHKIDS = " & v.HHKIDS'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHNIRBEN = " & v.HHNIRBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHOTHBEN = " & v.HHOTHBEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHRENT = " & v.HHRENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHRINC = " & v.HHRINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHRPINC = " & v.HHRPINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHSIZE = " & v.HHSIZE'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHTVLIC = " & v.HHTVLIC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHTXCRED = " & v.HHTXCRED'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOTHINC = " & v.HOTHINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HPENINC = " & v.HPENINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "HRBAND = " & v.HRBAND'Img & stda.LF);
                ustr.Append (outs, INDENT & "HSEINC = " & v.HSEINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "ISACTH = " & v.ISACTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "LONDON = " & v.LONDON'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTCOST = " & v.MORTCOST'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTINT = " & v.MORTINT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTPAY = " & v.MORTPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "NDDCTB = " & v.NDDCTB'Img & stda.LF);
                ustr.Append (outs, INDENT & "NDDISHC = " & v.NDDISHC'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIHSCOST = " & v.NIHSCOST'Img & stda.LF);
                ustr.Append (outs, INDENT & "NSBOCTH = " & v.NSBOCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTBSCTH = " & v.OTBSCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "PACCTYPE = " & v.PACCTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENAGE = " & v.PENAGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENHRP = " & v.PENHRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "PEPSCTH = " & v.PEPSCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "POACCTH = " & v.POACCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRBOCTH = " & v.PRBOCTH'Img & stda.LF);
                --ustr.Append (outs, INDENT & "PTENTYPE = " & v.PTENTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "SAYECTH = " & v.SAYECTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "SCLBCTH = " & v.SCLBCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "SERVPAY = " & v.SERVPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "SICK = " & v.SICK'Img & stda.LF);
                ustr.Append (outs, INDENT & "SICKHRP = " & v.SICKHRP'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSCTH = " & v.SSCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "STRUINS = " & v.STRUINS'Img & stda.LF);
                ustr.Append (outs, INDENT & "STSHCTH = " & v.STSHCTH'Img & stda.LF);
                --ustr.Append (outs, INDENT & "TENTYPE = " & v.TENTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "TESSCTH = " & v.TESSCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "TUHHRENT = " & v.TUHHRENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TUWATSEW = " & v.TUWATSEW'Img & stda.LF);
                ustr.Append (outs, INDENT & "UNTRCTH = " & v.UNTRCTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATSEWRT = " & v.WATSEWRT'Img & stda.LF);
                ustr.Append (outs, INDENT & "CENTFUEL = " & v.CENTFUEL'Img & stda.LF);
                ustr.Append (outs, INDENT & "CENTHEAT = " & v.CENTHEAT'Img & stda.LF);
                ustr.Append (outs, INDENT & "GOR = " & v.GOR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON01 = " & v.MODCON01'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON02 = " & v.MODCON02'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON03 = " & v.MODCON03'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON04 = " & v.MODCON04'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON05 = " & v.MODCON05'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON06 = " & v.MODCON06'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON07 = " & v.MODCON07'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON08 = " & v.MODCON08'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON09 = " & v.MODCON09'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON10 = " & v.MODCON10'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON11 = " & v.MODCON11'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON12 = " & v.MODCON12'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON13 = " & v.MODCON13'Img & stda.LF);
                ustr.Append (outs, INDENT & "MODCON14 = " & v.MODCON14'Img & stda.LF);
                ustr.Append (outs, INDENT & "USEVCL = " & v.USEVCL'Img & stda.LF);
                ustr.Append (outs, INDENT & "ADDDAHH = " & v.ADDDAHH'Img & stda.LF);
                ustr.Append (outs, INDENT & "BASACTH = " & v.BASACTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHDDAHH = " & v.CHDDAHH'Img & stda.LF);
                ustr.Append (outs, INDENT & "GEBACTH = " & v.GEBACTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "GROSS3 = " & v.GROSS3'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDTAX = " & v.HDTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHETHGR2 = " & v.HHETHGR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "PTENTYP2 = " & v.PTENTYP2'Img & stda.LF);
                ustr.Append (outs, INDENT & "TENTYP2 = " & v.TENTYP2'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;
        function To_String (v : Insurance_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "INSSEQ = " & v.INSSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS1 = " & v.NUMPOLS1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS2 = " & v.NUMPOLS2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS3 = " & v.NUMPOLS3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS4 = " & v.NUMPOLS4'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS5 = " & v.NUMPOLS5'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS6 = " & v.NUMPOLS6'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS7 = " & v.NUMPOLS7'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS8 = " & v.NUMPOLS8'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMPOLS9 = " & v.NUMPOLS9'Img & stda.LF);
                ustr.Append (outs, INDENT & "POLAMT = " & v.POLAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "POLMORE = " & v.POLMORE'Img & stda.LF);
                ustr.Append (outs, INDENT & "POLPAY = " & v.POLPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "POLPD = " & v.POLPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Job_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "JOBTYPE = " & v.JOBTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "AGREEHRS = " & v.AGREEHRS'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONAMT1 = " & v.BONAMT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONAMT2 = " & v.BONAMT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONAMT3 = " & v.BONAMT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONAMT4 = " & v.BONAMT4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONAMT5 = " & v.BONAMT5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONAMT6 = " & v.BONAMT6'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONTAX1 = " & v.BONTAX1'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONTAX2 = " & v.BONTAX2'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONTAX3 = " & v.BONTAX3'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONTAX4 = " & v.BONTAX4'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONTAX5 = " & v.BONTAX5'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONTAX6 = " & v.BONTAX6'Img & stda.LF);
                ustr.Append (outs, INDENT & "BONUS = " & v.BONUS'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUSACCTS = " & v.BUSACCTS'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHECKTAX = " & v.CHECKTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "CHKINCOM = " & v.CHKINCOM'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDOTH = " & v.DEDOTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC1 = " & v.DEDUC1'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC2 = " & v.DEDUC2'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC3 = " & v.DEDUC3'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC4 = " & v.DEDUC4'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC5 = " & v.DEDUC5'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC6 = " & v.DEDUC6'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC7 = " & v.DEDUC7'Img & stda.LF);
                ustr.Append (outs, INDENT & "DEDUC8 = " & v.DEDUC8'Img & stda.LF);
                ustr.Append (outs, INDENT & "DIRCTR = " & v.DIRCTR'Img & stda.LF);
                ustr.Append (outs, INDENT & "DIRNI = " & v.DIRNI'Img & stda.LF);
                ustr.Append (outs, INDENT & "DVTOTHRU = " & v.DVTOTHRU'Img & stda.LF);
                ustr.Append (outs, INDENT & "DVUSHR = " & v.DVUSHR'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPANY = " & v.EMPANY'Img & stda.LF);
                ustr.Append (outs, INDENT & "EMPOWN = " & v.EMPOWN'Img & stda.LF);
                ustr.Append (outs, INDENT & "ETYPE = " & v.ETYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "EVEROT = " & v.EVEROT'Img & stda.LF);
                ustr.Append (outs, INDENT & "FTPT = " & v.FTPT'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRSOFAR = " & v.GRSOFAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRWAGE = " & v.GRWAGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHA1 = " & v.HHA1'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHA2 = " & v.HHA2'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHA3 = " & v.HHA3'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHC1 = " & v.HHC1'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHC2 = " & v.HHC2'Img & stda.LF);
                ustr.Append (outs, INDENT & "HHC3 = " & v.HHC3'Img & stda.LF);
                ustr.Append (outs, INDENT & "HOHINC = " & v.HOHINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCLPAY1 = " & v.INCLPAY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCLPAY2 = " & v.INCLPAY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCLPAY3 = " & v.INCLPAY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCLPAY4 = " & v.INCLPAY4'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCLPAY5 = " & v.INCLPAY5'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCLPAY6 = " & v.INCLPAY6'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND01 = " & v.INKIND01'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND02 = " & v.INKIND02'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND03 = " & v.INKIND03'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND04 = " & v.INKIND04'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND05 = " & v.INKIND05'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND06 = " & v.INKIND06'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND07 = " & v.INKIND07'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND08 = " & v.INKIND08'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND09 = " & v.INKIND09'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND10 = " & v.INKIND10'Img & stda.LF);
                ustr.Append (outs, INDENT & "INKIND11 = " & v.INKIND11'Img & stda.LF);
                ustr.Append (outs, INDENT & "INSTYPE1 = " & v.INSTYPE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INSTYPE2 = " & v.INSTYPE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "JOBBUS = " & v.JOBBUS'Img & stda.LF);
                ustr.Append (outs, INDENT & "LIKEHR = " & v.LIKEHR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MADEMP = " & v.MADEMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "MATEMP = " & v.MATEMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "MATSTP = " & v.MATSTP'Img & stda.LF);
                ustr.Append (outs, INDENT & "MILEAMT = " & v.MILEAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MOTAMT = " & v.MOTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATINS = " & v.NATINS'Img & stda.LF);
                ustr.Append (outs, INDENT & "NATURE = " & v.NATURE'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIDAMT = " & v.NIDAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIDPD = " & v.NIDPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "NMCHC = " & v.NMCHC'Img & stda.LF);
                ustr.Append (outs, INDENT & "NMPER = " & v.NMPER'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOMOR1 = " & v.NOMOR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOMOR2 = " & v.NOMOR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "NOMOR3 = " & v.NOMOR3'Img & stda.LF);
                ustr.Append (outs, INDENT & "NUMEMP = " & v.NUMEMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED1 = " & v.OTHDED1'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED2 = " & v.OTHDED2'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED3 = " & v.OTHDED3'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED4 = " & v.OTHDED4'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED5 = " & v.OTHDED5'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED6 = " & v.OTHDED6'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED7 = " & v.OTHDED7'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED8 = " & v.OTHDED8'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHDED9 = " & v.OTHDED9'Img & stda.LF);
                ustr.Append (outs, INDENT & "OWNAMT = " & v.OWNAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "OWNOTAMT = " & v.OWNOTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "OWNOTHER = " & v.OWNOTHER'Img & stda.LF);
                ustr.Append (outs, INDENT & "OWNSUM = " & v.OWNSUM'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYAMT = " & v.PAYAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYDAT = " & v.PAYDAT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYE = " & v.PAYE'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYPD = " & v.PAYPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYSLIP = " & v.PAYSLIP'Img & stda.LF);
                ustr.Append (outs, INDENT & "PAYUSL = " & v.PAYUSL'Img & stda.LF);
                ustr.Append (outs, INDENT & "POTHR = " & v.POTHR'Img & stda.LF);
                ustr.Append (outs, INDENT & "PRBEFORE = " & v.PRBEFORE'Img & stda.LF);
                ustr.Append (outs, INDENT & "PROFDOCS = " & v.PROFDOCS'Img & stda.LF);
                ustr.Append (outs, INDENT & "PROFIT1 = " & v.PROFIT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "PROFIT2 = " & v.PROFIT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "PROFNI = " & v.PROFNI'Img & stda.LF);
                ustr.Append (outs, INDENT & "PROFTAX = " & v.PROFTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "RSPOTH = " & v.RSPOTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "SE1 = " & v.SE1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SE2 = " & v.SE2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEEND = " & v.SEEND'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEINCAMT = " & v.SEINCAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SEINCWM = " & v.SEINCWM'Img & stda.LF);
                ustr.Append (outs, INDENT & "SELWKS = " & v.SELWKS'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENIIAMT = " & v.SENIIAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENIINC = " & v.SENIINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENILAMT = " & v.SENILAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENILUMP = " & v.SENILUMP'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENIRAMT = " & v.SENIRAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENIREG = " & v.SENIREG'Img & stda.LF);
                ustr.Append (outs, INDENT & "SENIRPD = " & v.SENIRPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "SETAX = " & v.SETAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "SETAXAMT = " & v.SETAXAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SMPAMT = " & v.SMPAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SMPRATE = " & v.SMPRATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "SOLE = " & v.SOLE'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSPAMT = " & v.SSPAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXAMT = " & v.TAXAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXDAMT = " & v.TAXDAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "TAXDPD = " & v.TAXDPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "TOTUS1 = " & v.TOTUS1'Img & stda.LF);
                ustr.Append (outs, INDENT & "UBONAMT = " & v.UBONAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "UBONINC = " & v.UBONINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC1 = " & v.UDEDUC1'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC2 = " & v.UDEDUC2'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC3 = " & v.UDEDUC3'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC4 = " & v.UDEDUC4'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC5 = " & v.UDEDUC5'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC6 = " & v.UDEDUC6'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC7 = " & v.UDEDUC7'Img & stda.LF);
                ustr.Append (outs, INDENT & "UDEDUC8 = " & v.UDEDUC8'Img & stda.LF);
                ustr.Append (outs, INDENT & "UGROSS = " & v.UGROSS'Img & stda.LF);
                ustr.Append (outs, INDENT & "UINCPAY1 = " & v.UINCPAY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "UINCPAY2 = " & v.UINCPAY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "UINCPAY3 = " & v.UINCPAY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "UINCPAY4 = " & v.UINCPAY4'Img & stda.LF);
                ustr.Append (outs, INDENT & "UINCPAY5 = " & v.UINCPAY5'Img & stda.LF);
                ustr.Append (outs, INDENT & "UINCPAY6 = " & v.UINCPAY6'Img & stda.LF);
                ustr.Append (outs, INDENT & "UMILEAMT = " & v.UMILEAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "UMOTAMT = " & v.UMOTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "UNETT = " & v.UNETT'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED1 = " & v.UOTHDED1'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED2 = " & v.UOTHDED2'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED3 = " & v.UOTHDED3'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED4 = " & v.UOTHDED4'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED5 = " & v.UOTHDED5'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED6 = " & v.UOTHDED6'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED7 = " & v.UOTHDED7'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED8 = " & v.UOTHDED8'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDED9 = " & v.UOTHDED9'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHDTOT = " & v.UOTHDTOT'Img & stda.LF);
                ustr.Append (outs, INDENT & "UOTHR = " & v.UOTHR'Img & stda.LF);
                ustr.Append (outs, INDENT & "UPD = " & v.UPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "USMPAMT = " & v.USMPAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "USMPRATE = " & v.USMPRATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "USSPAMT = " & v.USSPAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "USUHR = " & v.USUHR'Img & stda.LF);
                ustr.Append (outs, INDENT & "UTAXAMT = " & v.UTAXAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATDID = " & v.WATDID'Img & stda.LF);
                ustr.Append (outs, INDENT & "WATPREV = " & v.WATPREV'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHERE = " & v.WHERE'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOPRO = " & v.WHYNOPRO'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU01 = " & v.WHYNOU01'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU02 = " & v.WHYNOU02'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU03 = " & v.WHYNOU03'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU04 = " & v.WHYNOU04'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU05 = " & v.WHYNOU05'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU06 = " & v.WHYNOU06'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU07 = " & v.WHYNOU07'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU08 = " & v.WHYNOU08'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU09 = " & v.WHYNOU09'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU10 = " & v.WHYNOU10'Img & stda.LF);
                ustr.Append (outs, INDENT & "WORKACC = " & v.WORKACC'Img & stda.LF);
                ustr.Append (outs, INDENT & "WORKMTH = " & v.WORKMTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "WORKYR = " & v.WORKYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HDQHRS = " & v.HDQHRS'Img & stda.LF);
                ustr.Append (outs, INDENT & "JOBHOURS = " & v.JOBHOURS'Img & stda.LF);
                ustr.Append (outs, INDENT & "SSPSMPFG = " & v.SSPSMPFG'Img & stda.LF);
                ustr.Append (outs, INDENT & "UGRSPAY = " & v.UGRSPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "GRWAGPD = " & v.GRWAGPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "WHYNOU11 = " & v.WHYNOU11'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Maint_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "MAINTSEQ = " & v.MAINTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "M = " & v.M'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRAGE = " & v.MRAGE'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRAMT = " & v.MRAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY1 = " & v.MRCHWHY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY2 = " & v.MRCHWHY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY3 = " & v.MRCHWHY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY4 = " & v.MRCHWHY4'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY5 = " & v.MRCHWHY5'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY6 = " & v.MRCHWHY6'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY7 = " & v.MRCHWHY7'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY8 = " & v.MRCHWHY8'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCHWHY9 = " & v.MRCHWHY9'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRCT = " & v.MRCT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRKID = " & v.MRKID'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRPD = " & v.MRPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRR = " & v.MRR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRUAMT = " & v.MRUAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRUPD = " & v.MRUPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRUS = " & v.MRUS'Img & stda.LF);
                ustr.Append (outs, INDENT & "MRV = " & v.MRV'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : MortCont_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTSEQ = " & v.MORTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "CONTSEQ = " & v.CONTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "OUTSAMT = " & v.OUTSAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "OUTSINCL = " & v.OUTSINCL'Img & stda.LF);
                ustr.Append (outs, INDENT & "OUTSPAY = " & v.OUTSPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "OUTSPD = " & v.OUTSPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Mortgage_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTSEQ = " & v.MORTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "BORAMTDK = " & v.BORAMTDK'Img & stda.LF);
                ustr.Append (outs, INDENT & "BORRAMT = " & v.BORRAMT'Img & stda.LF);
                -- ustr.Append (outs, INDENT & "ENDWPRIN = " & v.ENDWPRIN'Img & stda.LF);
                ustr.Append (outs, INDENT & "EXRENT = " & v.EXRENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMINC1 = " & v.INCMINC1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMINC2 = " & v.INCMINC2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMINC3 = " & v.INCMINC3'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMP1 = " & v.INCMP1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMP2 = " & v.INCMP2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMP3 = " & v.INCMP3'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMPAM1 = " & v.INCMPAM1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMPAM2 = " & v.INCMPAM2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMPAM3 = " & v.INCMPAM3'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMPPD1 = " & v.INCMPPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMPPD2 = " & v.INCMPPD2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMPPD3 = " & v.INCMPPD3'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMSTY1 = " & v.INCMSTY1'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMSTY2 = " & v.INCMSTY2'Img & stda.LF);
                ustr.Append (outs, INDENT & "INCMSTY3 = " & v.INCMSTY3'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTPRPAY = " & v.INTPRPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTPRPD = " & v.INTPRPD'Img & stda.LF);
                --ustr.Append (outs, INDENT & "LENDER = " & v.LENDER'Img & stda.LF);
                ustr.Append (outs, INDENT & "LOAN2Y = " & v.LOAN2Y'Img & stda.LF);
                ustr.Append (outs, INDENT & "LOANYEAR = " & v.LOANYEAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MENPOL = " & v.MENPOL'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORINPAY = " & v.MORINPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORINPD = " & v.MORINPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTEND = " & v.MORTEND'Img & stda.LF);
                ----ustr.Append (outs, INDENT & "MORTFLEX = " & v.MORTFLEX'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTLEFT = " & v.MORTLEFT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTPROT = " & v.MORTPROT'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORTTYPE = " & v.MORTTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "MPCOVER1 = " & v.MPCOVER1'Img & stda.LF);
                ustr.Append (outs, INDENT & "MPCOVER2 = " & v.MPCOVER2'Img & stda.LF);
                ustr.Append (outs, INDENT & "MPCOVER3 = " & v.MPCOVER3'Img & stda.LF);
                ustr.Append (outs, INDENT & "MPOLNO = " & v.MPOLNO'Img & stda.LF);
                ustr.Append (outs, INDENT & "OUTSMORT = " & v.OUTSMORT'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTFROM = " & v.RENTFROM'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMAMT = " & v.RMAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMORT = " & v.RMORT'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMORTYR = " & v.RMORTYR'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR001 = " & v.RMPUR001'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR002 = " & v.RMPUR002'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR003 = " & v.RMPUR003'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR004 = " & v.RMPUR004'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR005 = " & v.RMPUR005'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR006 = " & v.RMPUR006'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR007 = " & v.RMPUR007'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDWPRI1 = " & v.ENDWPRI1'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDWPRI2 = " & v.ENDWPRI2'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDWPRI3 = " & v.ENDWPRI3'Img & stda.LF);
                ustr.Append (outs, INDENT & "ENDWPRI4 = " & v.ENDWPRI4'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTRU = " & v.INTRU'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTRUPD = " & v.INTRUPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "INTRUS = " & v.INTRUS'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORALL = " & v.MORALL'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORFLC = " & v.MORFLC'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORINUS = " & v.MORINUS'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORUPD = " & v.MORUPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MORUS = " & v.MORUS'Img & stda.LF);
                ustr.Append (outs, INDENT & "RMPUR008 = " & v.RMPUR008'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : OddJob_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "ODDTYPE = " & v.ODDTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "ODDSEQ = " & v.ODDSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "OJAMT = " & v.OJAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "OJNOW = " & v.OJNOW'Img & stda.LF);
                ustr.Append (outs, INDENT & "OJREG = " & v.OJREG'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Owner_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BUYYEAR = " & v.BUYYEAR'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHMORT1 = " & v.OTHMORT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHMORT2 = " & v.OTHMORT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHMORT3 = " & v.OTHMORT3'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR1 = " & v.OTHPUR1'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR2 = " & v.OTHPUR2'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR3 = " & v.OTHPUR3'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR31 = " & v.OTHPUR31'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR32 = " & v.OTHPUR32'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR33 = " & v.OTHPUR33'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR34 = " & v.OTHPUR34'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR35 = " & v.OTHPUR35'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR36 = " & v.OTHPUR36'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR37 = " & v.OTHPUR37'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR4 = " & v.OTHPUR4'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR5 = " & v.OTHPUR5'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR6 = " & v.OTHPUR6'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHPUR7 = " & v.OTHPUR7'Img & stda.LF);
                ustr.Append (outs, INDENT & "PURCAMT = " & v.PURCAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PURCLOAN = " & v.PURCLOAN'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : RentCont_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTSEQ = " & v.RENTSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCAMT = " & v.ACCAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCCHK = " & v.ACCCHK'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCPAY = " & v.ACCPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCPD = " & v.ACCPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Renter_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP01 = " & v.ACCJBP01'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP02 = " & v.ACCJBP02'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP03 = " & v.ACCJBP03'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP04 = " & v.ACCJBP04'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP05 = " & v.ACCJBP05'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP06 = " & v.ACCJBP06'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP07 = " & v.ACCJBP07'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP08 = " & v.ACCJBP08'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP09 = " & v.ACCJBP09'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP10 = " & v.ACCJBP10'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP11 = " & v.ACCJBP11'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP12 = " & v.ACCJBP12'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP13 = " & v.ACCJBP13'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJBP14 = " & v.ACCJBP14'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCJOB = " & v.ACCJOB'Img & stda.LF);
                ustr.Append (outs, INDENT & "ACCNONHH = " & v.ACCNONHH'Img & stda.LF);
                ustr.Append (outs, INDENT & "CTRACT = " & v.CTRACT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ELIGAMT = " & v.ELIGAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "ELIGPD = " & v.ELIGPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "FAIRRENT = " & v.FAIRRENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "FURNISH = " & v.FURNISH'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBENAMT = " & v.HBENAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBENCHK = " & v.HBENCHK'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBENEFIT = " & v.HBENEFIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBENPD = " & v.HBENPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBENWAIT = " & v.HBENWAIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "HBWEEKS = " & v.HBWEEKS'Img & stda.LF);
                ustr.Append (outs, INDENT & "LANDLORD = " & v.LANDLORD'Img & stda.LF);
                ustr.Append (outs, INDENT & "OTHWAY = " & v.OTHWAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "REBATE = " & v.REBATE'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENT = " & v.RENT'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTDK = " & v.RENTDK'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTDOC = " & v.RENTDOC'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTFULL = " & v.RENTFULL'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTHOL = " & v.RENTHOL'Img & stda.LF);
                ustr.Append (outs, INDENT & "RENTPD = " & v.RENTPD'Img & stda.LF);
                --ustr.Append (outs, INDENT & "RENTPD1 = " & v.RENTPD1'Img & stda.LF);
                ustr.Append (outs, INDENT & "RESLL = " & v.RESLL'Img & stda.LF);
                ustr.Append (outs, INDENT & "RESLL2 = " & v.RESLL2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SERINC1 = " & v.SERINC1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SERINC2 = " & v.SERINC2'Img & stda.LF);
                ustr.Append (outs, INDENT & "SERINC3 = " & v.SERINC3'Img & stda.LF);
                ustr.Append (outs, INDENT & "SERINC4 = " & v.SERINC4'Img & stda.LF);
                ustr.Append (outs, INDENT & "SERINC5 = " & v.SERINC5'Img & stda.LF);
                ustr.Append (outs, INDENT & "SHORT1 = " & v.SHORT1'Img & stda.LF);
                ustr.Append (outs, INDENT & "SHORT2 = " & v.SHORT2'Img & stda.LF);
                ustr.Append (outs, INDENT & "WEEKHOL = " & v.WEEKHOL'Img & stda.LF);
                ustr.Append (outs, INDENT & "WSINC = " & v.WSINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "WSINCAMT = " & v.WSINCAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "YSTARTR = " & v.YSTARTR'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "NIYSTART = " & v.NIYSTART'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Vehicle_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "VEHSEQ = " & v.VEHSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "VEHIC = " & v.VEHIC'Img & stda.LF);
                ustr.Append (outs, INDENT & "VEHOWN = " & v.VEHOWN'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : PenProv_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "STEMPPAY = " & v.STEMPPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "PROVSEQ = " & v.PROVSEQ'Img & stda.LF);
                --ustr.Append (outs, INDENT & "AVCTYPE1 = " & v.AVCTYPE1'Img & stda.LF);
                --ustr.Append (outs, INDENT & "AVCTYPE2 = " & v.AVCTYPE2'Img & stda.LF);
                --ustr.Append (outs, INDENT & "AVCTYPE3 = " & v.AVCTYPE3'Img & stda.LF);
                --ustr.Append (outs, INDENT & "EP1AVC = " & v.EP1AVC'Img & stda.LF);
                ustr.Append (outs, INDENT & "EPLONG = " & v.EPLONG'Img & stda.LF);
                ustr.Append (outs, INDENT & "EPTYPE = " & v.EPTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "KEEPPEN = " & v.KEEPPEN'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENAMT = " & v.PENAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENAMTPD = " & v.PENAMTPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENCON = " & v.PENCON'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENDAT = " & v.PENDAT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENGOV = " & v.PENGOV'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENHELP = " & v.PENHELP'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENMORT = " & v.PENMORT'Img & stda.LF);
                ustr.Append (outs, INDENT & "SPWHO = " & v.SPWHO'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "OPGOV = " & v.OPGOV'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String (v : Pension_Rec) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.Append (outs, INDENT & "SERNUM = " & String (v.SERNUM) & stda.LF);
                ustr.Append (outs, INDENT & "hh_sequence = " & v.hh_sequence'Img & stda.LF);
                ustr.Append (outs, INDENT & "BENUNIT = " & v.BENUNIT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PERSON = " & v.PERSON'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENSEQ = " & v.PENSEQ'Img & stda.LF);
                ustr.Append (outs, INDENT & "ANOTHER = " & v.ANOTHER'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENOTH = " & v.PENOTH'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENPAY = " & v.PENPAY'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENPD = " & v.PENPD'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENTAX = " & v.PENTAX'Img & stda.LF);
                ustr.Append (outs, INDENT & "PENTYPE = " & v.PENTYPE'Img & stda.LF);
                ustr.Append (outs, INDENT & "POAMT = " & v.POAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "POINC = " & v.POINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "POSOUR = " & v.POSOUR'Img & stda.LF);
                ustr.Append (outs, INDENT & "PTAMT = " & v.PTAMT'Img & stda.LF);
                ustr.Append (outs, INDENT & "PTINC = " & v.PTINC'Img & stda.LF);
                ustr.Append (outs, INDENT & "TRIGHTS = " & v.TRIGHTS'Img & stda.LF);
                ustr.Append (outs, INDENT & "MONTH = " & v.MONTH'Img & stda.LF);
                return ustr.To_String (outs);
        end To_String;

        function To_String( ad : Raw_Adult ) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.append ( outs, " numJobs = " & ad.numJobs'Img & stda.LF );
                for i in 1 .. ad.numJobs loop
                        ustr.append ( outs, " *** Job " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.jobs(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numAccounts = " & ad.numAccounts'Img & stda.LF );
                for i in 1 .. ad.numAccounts loop
                        ustr.append ( outs, " *** Job " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.accounts(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numAssets = " & ad.numAssets'Img & stda.LF );
                for i in 1 .. ad.numAssets loop
                        ustr.append ( outs, " *** asset " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.assets(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numBenefits = " & ad.numBenefits'Img & stda.LF );
                for i in 1 .. ad.numBenefits loop
                        ustr.append ( outs, " *** asset " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.benefits(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numGovPays = " & ad.numGovPays'Img & stda.LF );
                for i in 1 .. ad.numGovPays loop
                        ustr.append ( outs, " *** govpays " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.govPay(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numMaintenances = " & ad.numMaintenances'Img & stda.LF );
                for i in 1 .. ad.numMaintenances loop
                        ustr.append ( outs, " *** maintenance " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.maintenances(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numOddJobs = " & ad.numOddJobs'Img & stda.LF );
                for i in 1 .. ad.numoddJobs loop
                        ustr.append ( outs, " *** oddJobs " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.oddJobs(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numpensions = " & ad.numpensions'Img & stda.LF );
                for i in 1 .. ad.numpensions loop
                        ustr.append ( outs, " *** pensions " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.pensions(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, " numPenProvs = " & ad.numPenProvs'Img & stda.LF );
                for i in 1 .. ad.numpenProvs loop
                        ustr.append ( outs, " *** penProvs " &
                                     i'Img & " ********* " & stda.LF & To_String (ad.penProvs(i)) & stda.LF );
                end loop;
                ustr.append ( outs, stda.LF );
                ustr.append ( outs, stda.LF );
                return ustr.To_String (outs);
        end To_String;

        function To_String( ch : Raw_Child )
        return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.append( outs, To_String( ch.child ));
                return ustr.To_String (outs);
        end To_String;

        function To_String( bu : Raw_Benefit_Unit ) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.append ( outs, " *** BenUnit "  & stda.LF & To_String (bu.benUnit) & stda.LF );
                ustr.append ( outs, " *** num adults " & bu.numAdults'Img );
                for i in 1 .. bu.numAdults loop
                        ustr.append ( outs, " *** Adult " &
                                     i'Img & " ********* " & stda.LF & To_String (bu.adults(i)) & stda.LF );
                end loop;
                ustr.append ( outs, " *** num cares " & bu.numCares'Img );
                for i in 1 .. bu.numCares loop
                        ustr.append ( outs, " *** Care " &
                                     i'Img & " ********* " & stda.LF & To_String (bu.cares(i)) & stda.LF );
                end loop;
                ustr.append ( outs, " *** num ext. children " & bu.numExtChildren'Img );
                for i in 1 .. bu.numExtChildren loop
                        ustr.append ( outs, " *** ExtChild " &
                                     i'Img & " ********* " & stda.LF & To_String (bu.extChild(i)) & stda.LF );
                end loop;
                ustr.append ( outs, " *** num children " & bu.num_Children'Img );
                for i in 1 .. bu.num_Children loop
                        ustr.append ( outs, " *** child " &
                                     i'Img & " ********* " & stda.LF & To_String (bu.children(i)) & stda.LF );
                end loop;

	        return ustr.To_String (outs);
        end To_String;

        function To_String (hh : Raw_Household) return String is
                outs : ustr.Unbounded_String := ustr.To_Unbounded_String ("");
        begin
                ustr.append( outs, " Household ********* " & stda.LF & To_String(hh.household) & stda.LF & stda.LF );
                ustr.append( outs, " Renter ********* " & stda.LF & To_String(hh.renter) & stda.LF & stda.LF );
                ustr.append( outs, " Owner ********* " & stda.LF & To_String(hh.owner) & stda.LF & stda.LF );
                for i in 1 .. hh.numMortConts loop
                        ustr.append ( outs, " *** MortCont " &
                                     i'Img & " ********* " & stda.LF & To_String (hh.mortCont (i)) & stda.LF );
                end loop;
                for i in 1 .. hh.numMortgages loop
                        ustr.append ( outs, " *** Mortgage " &
                                     i'Img & " ********* " & stda.LF & To_String (hh.mortgages (i)) & stda.LF );
                end loop;
                for i in 1 .. hh.numVehicles loop
                        ustr.append ( outs, " *** Vehicles " &
                                     i'Img & " ********* " & stda.LF & To_String (hh.vehicles (i)) & stda.LF );
                end loop;
                for i in 1 .. hh.numRentConts loop
                        ustr.append ( outs, " *** RentCont " &
                                     i'Img & " ********* " & stda.LF & To_String (hh.rentCont (i)) & stda.LF );
                end loop;
                ustr.append ( outs, " *** Num Benefit Units " & hh.num_benefit_units'Img & stda.LF );
                for i in 1 .. hh.num_benefit_units loop
                        ustr.append ( outs, " *** RentCont " &
                                     i'Img & " ********* " & stda.LF & To_String (hh.benUnits(i)) & stda.LF );
                end loop;
                return ustr.To_String (outs);
        end To_String;

end raw_frs_printer;
