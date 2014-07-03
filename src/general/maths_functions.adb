pragma License( Modified_GPL );

with Ada.Assertions;
with Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Strings.Unbounded;
with GNATColl.Traces;
with Text_Utils;
with Ada.Numerics.Float_Random;  

package body Maths_Functions is
   
   use Ada.Assertions;
   use Ada.Text_IO;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MATHS_FUNCTIONS" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
   function Truncate_To( r : Real; prec : Natural ) return Real is
      type LR1 is digits 1;
      type LR2 is digits 2;
      type LR3 is digits 3;
      type LR4 is digits 4;
      type LR5 is digits 5;
      type LR6 is digits 6;
      type LR7 is digits 7;
      type LR8 is digits 8;
      type LR9 is digits 9;
      type LR10 is digits 10;
   begin
      case prec is
         when 1 => return Real( LR1( r ));
         when 2 => return Real( LR2( r ));
         when 3 => return Real( LR3( r ));
         when 4 => return Real( LR4( r ));
         when 5 => return Real( LR5( r ));
         when 6 => return Real( LR6( r ));
         when 7 => return Real( LR7( r ));
         when 8 => return Real( LR8( r ));
         when 9 => return Real( LR9( r ));
         when others => return Real( LR10( r ));
      end case;
   end Truncate_To;
      
   zero_one_random_generator : Ada.Numerics.Float_Random.Generator;

 
   L_DEBUG : Boolean := False;
   
   function Debug return Boolean is
   begin
      return L_DEBUG;
   end Debug;
   
   procedure Do_Debug( onoff : Boolean ) is
   begin
      L_DEBUG := onoff;
   end Do_Debug;
   
   type Local_Float is new Long_Long_Float;
   package R_Funcs is new Ada.Numerics.Generic_Elementary_Functions( Local_Float );
   use R_Funcs;
   
   type Local_Float_Array is array( Natural range <> ) of Local_Float;

   function To_String( m : Matrix ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;
   begin
      for i in m'Range( 1 ) loop
         for j in m'Range( 2 ) loop
            s := s & Real'Image( m( i, j )) & " ";
         end loop;
         s := s & LINE_BREAK;
      end loop;
      return TS( s );
   end To_String;
   
   function To_String( v : Vector ) return String is
   use Ada.Strings.Unbounded;
   use Text_Utils;
      s : Unbounded_String;
   begin
      for i in v'Range loop
         s := s & Real'Image( v( i )) & " ";
         s := s & LINE_BREAK;
      end loop;
      return TS( s );
   end To_String;

   function Extract_Row( m : Matrix; row : Integer ) return Vector is
      v : Vector( m'Range( 2 ));
   begin
      for col in m'Range( 2 ) loop
         v( col ) := m( row, col );
      end loop;
      return v;
   end Extract_Row;

   function Extract_Col( m : Matrix; col : Integer ) return Vector is
      v : Vector( m'Range( 1 ));
   begin
      for row in m'Range( 1 ) loop
         v( row ) := m( row, col );
      end loop;
      return v;
   end Extract_Col;
   
   procedure Set_Col( m : in out Matrix; col : Integer; v : Vector ) is
   begin
      for row in m'Range( 1 ) loop
         m( row, col ) := v( row );
      end loop;
   end Set_Col;
      
   procedure Set_Row( m : in out Matrix; row : Integer; v : Vector ) is
   begin
      for col in m'Range( 2 ) loop
         m( row, col ) := v( col );
      end loop;
   end Set_Row;

   function Sum( v : Vector ) return Real is
      s : Real := 0.0;
   begin
      for i in v'Range loop
         s := s + v( i );
      end loop;
      return s;
   end Sum;

   function Evaluate_Polynomial( a : Local_Float_Array; x : Local_Float ) return Local_Float is
     -- translation of devlpl.f from 
     -- http://www3.sympatico.ca/craymer/software/fortran/dcdflib/
     sum : Local_Float := a( a'Last );
   begin
     for i in reverse a'Last-1 .. a'First loop        
        sum := a( i ) + ( sum * x );
     end loop;
     return sum;
   end Evaluate_Polynomial;
  
   function Cumulative_Normal( x : Real ) return Real is
      -- From a Java version by Steve Verrill
      -- see: http://www1.fpl.fs.fed.us/covnorm.code.html
      rtwo  : constant Local_Float := 1.41421356237310E+00;
      trtwo : constant Local_Float := 2.82842712474619E+00;
      frtwo : constant Local_Float := 5.65685424949238E+00;
      srtwo : constant Local_Float := 8.48528137423857E+00;
     
      A1 : constant Local_Float_Array( 0 .. 20 ) := (
          2.94268192595158E-01,
         -1.20794002859252E-01,
         -5.38155411612267E-03,
          9.61245872309754E-03,
         -1.56928442055175E-03,
         -3.13379686339925E-04,
          1.34539944432857E-04,
         -2.01886311941572E-06,
         -6.02924420904726E-06,
          7.33514212717164E-07,
          1.68200375041707E-07,
         -4.21496636122487E-08,
         -2.34089537886964E-09,
          1.54397950861409E-09,
         -3.83910453258562E-11,
         -4.18791755643448E-11,
          3.66254323806330E-12,
          8.67662501706706E-13,
         -1.38490737068408E-13,
         -1.30609215123467E-14,
         3.76420840390550E-15 );  

      A2 : constant Local_Float_Array( 0 .. 22 ) := (
          3.93098827656776E-01,
          0.0,
         -5.72072868438617E-03,
          0.0,
          1.18630151591342E-04,
          0.0,
         -3.91103704629101E-06,
          0.0,
          1.72795234431416E-07,
          0.0,
         -9.42361518118889E-09,
          0.0,
          6.04595735693237E-10,
          0.0,
         -4.42225118426537E-11,
          0.0,
          3.60747153118711E-12,
          0.0,
         -3.22932023145379E-13,
          0.0,
          3.13323522258447E-14,
          0.0,
         -3.26302072101379E-15 );


      A3 : constant Local_Float_Array( 0 .. 16 ) := (
          2.66657721330163E-01,
          8.94380310492471E-03,
         -1.90087646908402E-03,
          3.48555717528185E-04,
         -5.81844230476253E-05,
          9.06838380458210E-06,
         -1.33859970500872E-06,
          1.88850668170541E-07,
         -2.56245596590501E-08,
          3.35935312400552E-09,
         -4.27010392442662E-10,
          5.27726756655456E-11,
         -6.35545872359585E-12,
          7.47249710210314E-13,
         -8.59121451944801E-14,
          9.67175305486972E-15,
         -1.06741339515971E-15 );

      p    : Local_Float;
      xx   : Local_Float;
      z    : Local_Float;
      tz   : Local_Float;
      b1   : Local_Float;
      b2   : Local_Float;
      temp : Local_Float;
      ans  : Local_Float;
      xs   : Local_Float;

      j    : Natural;

      n1 : constant := 21;
      n2 : constant := 23;
      n3 : constant := 17;
      m1 : constant := 19;
      m2 : constant := 21;
      m3 : constant := 15;

      elim : constant Local_Float := 2.303  * ( 1022.0 * 0.3010299957 - 3.0 );
      --  xlim is used to test for underflow
      xlim : constant Local_Float := -1.0 * sqrt( 2.0 * elim );
      
   begin
      xx := Local_Float( x );
      if( xx < xlim )then
         -- underflow
         return 0.0;
      end if;
      if( xx >= srtwo )then
         p := 1.0;
      elsif( xx > frtwo )then
         z := frtwo / xx;
         tz := z + z;
         j := n2 - 1;
         b1 := a2(j);
         b2 := 0.0;
         for i in 1 .. m2 loop
            j := j - 1;
            temp := b1;
            b1 := tz * b1 - b2 + a2(j);
            b2 := temp;
         end loop;
         ans := z*b1 - b2 + a2(0);
         p := ( Exp( -xx * xx * 0.5 ) / xx ) * ans;
         p := 1.0 - p;
      elsif( xx > trtwo )then
         xs := xx / rtwo;
         z  := xs - 3.0;
         tz := z + z;
         j  := n3 - 1;
         b1 := a3(j);
         b2 := 0.0;
         for i in 1 .. m3 loop
            j := j - 1;
            temp := b1;
            b1 := tz*b1 - b2 + a3(j);
            b2 := temp;
         end loop;
         ans := z*b1 - b2 + a3( 0 );
         p := Exp( -xs * xs ) * ans / xs;
         if( xx > 0.0 )then
            p := 1.0 - p;
         end if;
      elsif( xx >= -trtwo )then
         z := abs( xx ) / rtwo - 1.0;
         tz := z + z;
         j := n1 - 1;
         b1 := a1(j);
         b2 := 0.0;
         for i in 1 .. m1 loop
            j := j - 1;
            temp := b1;
            b1 := tz*b1 - b2 + a1(j);
            b2 := temp;
         end loop;
         p := xx * ( z*b1 - b2 + a1(0) ) + 0.5;
      elsif( xx <= -frtwo )then
         xx := -xx;
         z := frtwo/xx;
         tz := z + z;
         j := n2 - 1;
         b1 := a2(j);
         b2 := 0.0;
         for i in 1 .. m2 loop
            j := j - 1;
            temp := b1;
            b1 := tz*b1 - b2 + a2(j);
            b2 := temp;
         end loop;
         ans := z*b1 - b2 + a2(0);
         p := ( Exp( -xx * xx * 0.5 ) / xx ) * ans;
      else
         xs := -xx / rtwo;
         z := xs - 3.0;
         tz := z + z;
         j := n3 - 1;
         b1 := a3(j);
         b2 := 0.0;
         for i in 1 .. m3 loop
            j := j - 1;
            temp := b1;
            b1 := tz*b1 - b2 + a3(j);
            b2 := temp;
         end loop;
         ans := z*b1 - b2 + a3(0);
         p := Exp(-xs*xs)*ans/xs;
         if ( xx > 0.0 )then
            p := 1.0 - p;
         end if;
      end if;
      Assert( p >= -0.00000001 and p <= 1.000001, "Cumulative_Normal: p should be in range 0.0 .. 1.0 was " & Local_Float'Image( p ));
      return Real( p );
   end Cumulative_Normal;
   
   function Inverse_Cumulative_Normal( p : Real ) return Real is
      --
      -- from Delphi implementation from
      -- http://home.online.no/~pjacklam/notes/invnorm/impl/mccormick/icnorm.pas
      -- I have absolutely no idea how this works, but the unit tests come out fine.
      --
      A : constant Local_Float_Array( 1 .. 6 ) := (
          -3.969683028665376e+01,
           2.209460984245205e+02,
          -2.759285104469687e+02,
           1.383577518672690e+02,
          -3.066479806614716e+01,
           2.506628277459239e+00 );
           
      B : constant Local_Float_Array( 1 .. 5 ) := (
          -5.447609879822406e+01,
           1.615858368580409e+02,
          -1.556989798598866e+02,
           6.680131188771972e+01,
          -1.328068155288572e+01 );
          
      C : constant Local_Float_Array( 1 .. 6 ) := (
          -7.784894002430293e-03,
          -3.223964580411365e-01,
          -2.400758277161838e+00,
          -2.549732539343734e+00,
           4.374664141464968e+00,
           2.938163982698783e+00 );
   
      D : constant Local_Float_Array( 1 .. 4 ) := (
          7.784695709041462e-03,
          3.224671290700398e-01,
          2.445134137142996e+00,
          3.754408661907416e+00 );
   
      -- Define break-points.
      P_LOW  : constant Local_Float := 0.02425;
      P_HIGH : constant Local_Float := 1.0 - P_LOW;

      q      : Local_Float;
      r      : Local_Float;
      result : Local_Float;
      lp     : Local_Float;
   begin
      Assert( p >= 0.0 and p <= 1.0, "Inverse_Cumulative_Normal: p should be in range 0.0 .. 1.0 was " & Real'Image( p ));
      -- Rational approximation for lower region.
      
      lp := Local_Float( p );
      if lp < P_LOW then
         q := Sqrt( -2.0 * Log( lp ));
         result := ((((( c( 1 ) * q + c( 2 )) * q + c( 3 )) * q + c( 4 )) * q + c( 5 )) * q + c( 6 )) /
            ((((d( 1 ) * q + d( 2 )) * q + d( 3 )) * q + d( 4 )) * q + 1.0);
     -- Rational approximation for central region.
      elsif lp <= P_HIGH  then
         q := lp - 0.5 ;
         r := q ** 2 ;
         result := ((((( a( 1 ) * r + a( 2 )) * r + a( 3 )) * r + a( 4 )) * r + a( 5 )) * r + a( 6 )) * q /
           (((((b( 1 ) * r + b( 2 )) * r + b( 3 )) * r + b( 4 )) * r + b( 5 )) * r + 1.0) ;
      else
      -- Rational approximation for upper region.
         q := Sqrt( -2.0 * Log( 1.0 - lp ));
         result := -((((( c( 1 ) * q + c( 2 )) * q + c( 3 )) * q + c( 4 )) * q + c( 5 )) * q + c( 6 )) /
             ((((d( 1 ) * q + d( 2 )) * q + d( 3 )) * q + d( 4 )) * q + 1.0)  ;
      end if;
      return Real( result );
   end Inverse_Cumulative_Normal;

   function Random_0_To_1 return Real is
   begin
      return Real( Ada.Numerics.Float_Random.Random( zero_one_random_generator ));
   end Random_0_To_1;

   PI      : constant Local_Float := Local_Float( Ada.Numerics.PI );
   SQ_2_PI : constant Local_Float := Sqrt( 2.0 * PI );

   function Normal_PDF( x : Real; mean : Real; standard_deviation : Real ) return Real is
     lsd : constant Local_Float := Local_Float( standard_deviation );
     lm  : constant Local_Float := Local_Float( mean );
     lx  : constant Local_Float := Local_Float( x );
     p1  : constant Local_Float := 1.0 / (lsd * SQ_2_PI);
     p2  : constant Local_Float :=  Exp(-1.0 * (( lx - lm ) ** 2.0 ) / (2.0 * ( lsd ** 2.0 )));
   begin
     return Real( p1*p2 );
   end Normal_PDF;

   function Standard_Normal_PDF( x : Real ) return Real is
   begin
      return Normal_PDF( X => x, Mean => 0.0, Standard_Deviation => 1.0 );
   end Standard_Normal_PDF;

   function Evaluate_Probit( 
      v                    : Real; 
      threshold            : Real;
      add_random_component : Boolean := False ) return Boolean is
      local_thresh : Real  := threshold;
      prob         : Real;
      err          : Real := 0.0;
   begin
      if( add_random_component )then
         err := Random_Normal_Generator.Draw( mean => 0.0, standard_deviation => 1.0 );
      end if;
      prob := Cumulative_Normal( v + err );
      return prob >= local_thresh;
   end Evaluate_Probit;

   
   function Evaluate_Probit( 
      v                    : Real; 
      use_random_threshold : Boolean := False ) return Boolean is
      local_thresh : Real  := 0.50;
      prob         : Real  := Cumulative_Normal( v );
   begin
      if( use_random_threshold )then
         local_thresh := Random_0_To_1; 
      end if;
      return prob >= local_thresh;
   end Evaluate_Probit;
  
   procedure Solve_Non_Linear_Equation_System( 
      x          : in out Vector;
      num_trials : Natural; 
      tolx       : Real; 
      tolf       : Real;
      iterations : out Natural;
      error      : out Eval_Error_Type ) is
   use Matrix_Functions;
      hessian : Matrix( x'Range, x'Range ) := (others=>(others=>0.0 ));
      gradient    : Vector( x'Range ) := ( others => 0.0 );
      deltas  : Vector( x'Range ) := ( others => 0.0 );
   begin
      error := normal;
      iterations := 1;
      for k in 1 .. num_trials loop
         declare
            errf    : Real := 0.0; 
            errx    : Real := 0.0;
         begin            
            if( DEBUG ) then
               Log( "hessian size " & hessian'Last(1)'Img &  " x " & hessian'Last(2)'Img );
               Log( "gradient size " & gradient'Last'Img );
               Log( "gradient" );
               Log( To_String( gradient ));
               Log( "hessian" );
               Log( To_String( hessian ));
               Log( "X" );
               Log( To_String( x ));
            end if;
            Evaluate( x, hessian, gradient );
            for i in x'Range loop
               errf := errf + abs( gradient( i ));   
            end loop;
            if( errf <= tolf )then
               exit;
            end if;
            deltas := Matrix_Functions.Solve( hessian, gradient );
            x := x + deltas;
            for i in x'Range loop
               errx := errx + abs( deltas( i ));
            end loop;
            if( errx <= tolx )then
               exit;
            end if;
         end;
         iterations := iterations + 1;
      end loop;
      --
      -- set error flags
      --
      if( iterations = num_trials + 1 ) then
         error := iterations_exceeded;
      end if;
   end Solve_Non_Linear_Equation_System;
   
   function To_String( r : Real; width : Positive := 12; prec : Positive := 2 ) return String is
      s : String( 1 .. width ) := ( others => ' ' );
   begin
      begin
         FIO.Put( s, r, prec, 0 );
      exception
         when others => -- Layout_Error all that's possible?
            -- fall back on one with an exponent; should (??) always work
            return Real'Image( r );
      end;     
      return s;
   end To_String;

begin
   Ada.Numerics.Float_Random.Reset( zero_one_random_generator );
end Maths_Functions;
