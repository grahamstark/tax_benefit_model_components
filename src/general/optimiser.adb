--
--  $Revision: 4997 $
--  $Date: 2008-04-13 16:18:43 +0100 (Sun, 13 Apr 2008) $
--  $Author: graham_s $
--
pragma License( Modified_GPL );

package body Optimiser is

   GOLDEN_RATIO    : constant := 0.3819660;
   NEARLY_ZERO     : constant := 1.0E-10;


   --
   --  implements brent's method for finding a miminum of an arbtrary function
   -- 
   --  from Numerical Recipies (Pascal) ch 10.,
   --  from Numerical Recipies (Pascal) ch 9.3,
   --
   --


   function Sign (a, b : real) return real is
   begin
      if b >= 0.0 then
         return abs (a);
      else
         return -1.0 * abs (a);
      end if;
   end Sign;

   procedure Optimise(
      control        : Control_Rec;
      optimum_x      : in out Real;
      optimum_y      : in out Real;
      err            : in out Error_Conditions ) is
      a     : Real := 0.0;
      ax    : Real := 0.0;
      b     : Real := 0.0;
      d     : Real := 0.0;
      bx    : Real := 0.0;
      cx    : Real := 0.0;
      e     : Real := 0.0;
      eTemp : Real := 0.0;
       
      fu    : Real := 0.0;
      fv    : Real := 0.0;
      fw    : Real := 0.0;
      fx    : Real := 0.0;
      p     : Real := 0.0;
      q     : Real := 0.0;
      r     : Real := 0.0;
       
      tol1  : Real := 0.0;
      tol2  : Real := 0.0;
      u     : Real := 0.0;
      v     : Real := 0.0;
      w     : Real := 0.0;
      x     : Real := 0.0;
      xm    : Real := 0.0;
      
      iter :Integer := 0;
      done   : Boolean := False;
   begin
      
      ax  := Start;
      cx  := Stop;
      x   := ax;
      bx  := (ax + cx) / 2.0;
      if ax < cx then
         a := ax;
      else
         a := cx;
      end if;
      if ax > cx then
         b := ax;
      else
         b := cx;
      end if;
      v    := bx;
      w    := v;
      e    := 0.0;
      fx   := Minimand( control, x );
      fv   := fx;
      fw   := fx;
      done := False;
      err  := NoError;
      iter := 0;
      while not done loop
         iter := iter + 1;
         xm   := (a + b) / 2.0;
         tol1 := (Tolerance * abs (x)) + NEARLY_ZERO;
         tol2 := 2.0 * tol1;
         if abs (x - xm) <= (tol2 - ((b - a) / 2.0)) then
            done := True;
            err  := NoError;
         elsif iter > MAX_ITERATIONS then
            done := True;
            err  := TooManyIterations;
         else
            if abs (e) > tol1 then
               r := (x - w) * (fx - fv);
               q := (x - v) * (fx - fw);
               p := ((x - v) * q) - ((x - w) * r);
               q := 2.0 * (q - r);
               if q < 0.0 then
                  p := -1.0 * p;
               end if;
               q     := abs (q);
               eTemp := e;
               e     := d;
               if (abs (p) >= abs ((q * eTemp) / 2.0)) or
                  (p <= (q * (a - x))) or
                  (p >= (q * (b - x)))
               then
                  if x >= xm then
                     e := a - x;
                  else
                     e := b - x;
                  end if;
                  d := GOLDEN_RATIO * e;
               else
                  d := p / q;
                  u := x + d;
                  if ((u - a) < tol2) or ((b - u) < tol2) then
                     d := Sign (tol1, (xm - x));
                  end if;
               end if; -- if abs( p ) *)
            else
               if x >= xm then
                  e := a - x;
               else
                  e := b - x;
               end if;
               d := GOLDEN_RATIO * e;
            end if;   
            if abs (d) >= tol1 then
               u := x + d;
            else        
               u := x + Sign (tol1, d);
            end if;
            fu := Minimand( control, u );
            if fu <= fx then
               if u >= x then
                  a := x;
               else
                  b := x;
               end if;
               v  := w;
               fv := fw;
               w  := x;
               fw := fx;
               x  := u;
               fx := fu;
            else
               if u < x then
                  a := u;
               else
                  b := u;
               end if;
               if (fu <= fw) or (w = x) then
                  v  := w;
                  fv := fw;
                  w  := u;
                  fw := fu;
               elsif (fu <= fv) or (v = x) or (v = w) then
                  v  := u;
                  fv := fu;
               end if; -- fu <= fv etc. *)
            end if;    -- fu > fx *)
         end if;       -- ABS( x - m ) *)
      end loop;        --  whilenot done *)
      optimum_x := x; 
      optimum_y := fx;
   end Optimise;

end Optimiser;
