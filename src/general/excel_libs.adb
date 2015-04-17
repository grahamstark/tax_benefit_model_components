package body Excel_Libs is
   
   function PMT(
      r     : Long_Float;
      nper  : Integer;
      pv    : Long_Float;
      fv    : Long_Float := 1.0;
      itype : Integer := 1 ) return Long_Float is
      ft : Long_Float := Long_Float( itype );
   begin
      return -r * ( pv * ( 1.0 + r ) ** nper + fv ) / 
             (( 1.0 + r*ft ) * ("**"( 1.0 + r, nper ) - 1.0 ));
   end PMT;
   
   function FV( 
      r      : Long_Float;
      nper   : Integer;
      pmt    : Long_Float;
      pv     : Long_Float;
      itype  : Integer := 1 ) return Long_Float is
      ftype : Long_Float := Long_Float( itype );
   begin
       return -(pv * "**"(1.0 + r, nper) + pmt * (1.0+r*ftype) * ("**"(1.0 + r, nper) - 1.0) / r );
   end FV;
   
   function IPMT(
       r     : Long_Float;
       per   : Integer;
       nper  : Integer; 
       pv    : Long_Float;
       ffv   : Long_Float := 0.0; 
       itype : Integer := 0 ) return Long_Float is
       rpmt : constant Long_Float := PMT( r, nper, pv, ffv, itype );
       ipmt : Long_Float := FV( r, per - 1, rpmt, pv, itype ) * r;
   begin
       if itype = 1 then
          ipmt := ipmt / ( 1.0 + r );
       end if;
       return ipmt;
   end IPMT;

   function PPMT(       
      r     : Long_Float;
      per   : Integer;
      nper  : Integer; 
      pv    : Long_Float;
      ffv   : Long_Float := 0.0; 
      itype : Integer := 0
   ) return Long_Float is
   begin
       return pmt( r, nper, pv, ffv, itype ) - 
              ipmt( r, per, nper, pv, ffv, itype);
   end PPMT;

end Excel_Libs;
