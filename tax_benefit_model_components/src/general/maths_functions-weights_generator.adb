pragma License( Modified_GPL );

with Ada.Assertions;
with Ada.Text_IO;

package body Maths_Functions.Weights_Generator is
   
   use Elementary_Functions;
   use Ada.Assertions;
   use Ada.Text_IO;

   L_DEBUG : Boolean := False;
   
   function Debug return Boolean is
   begin
      return L_DEBUG;
   end Debug;
   
   procedure Do_Debug( onoff : Boolean ) is
   begin
      L_DEBUG := onoff;
   end Do_Debug;
   
   --
   -- todo make this private
   --
   procedure Evaluate_Function_And_Hessian( 
      data               : in Dataset;
      lambdas            : in Row_Vector;
      which_function     : Distance_Function_Type;
      initial_weights    : in Col_Vector;
      target_populations : in Row_Vector;
      ru                 : Real;
      rl                 : Real;
      f_lambdas          : out Row_Vector;
      hessian            : out Hessian_Matrix ) is
   use Matrix_Functions;
      subtype Row_Vector is Vector( lambdas'Range );
      a : Row_Vector := target_populations - ( initial_weights * data );
      z : Row_Vector := ( others => 0.0 );
   begin
      hessian := ( others => ( others => 0.0 ));
      Each_Obs:
      for k in Col_Range loop
         declare
            r      : constant Row_Vector := Extract_Row( data, k );
            u      : constant Real := r * lambdas;
            d_g_m1 : Real;
            g_m1   : Real;
         begin
            --
            -- based on the table 3 of creedy wp 03/17
            --
            case which_function is
            when chi_square =>
                d_g_m1 := 1.0;
                g_m1 := 1.0 + u;
            when constrained_chi_square =>
                if( u < ( rl - 1.0 ))then    
                   g_m1 := rl;
                   d_g_m1 := 0.0;
                elsif( u > ( ru - 1.0 ))then    
                   g_m1 := ru;
                   d_g_m1 := 0.0;
                else
                   g_m1 := 1.0 + u;
                   d_g_m1 := 1.0;
                end if;
            when d_and_s_type_a =>
               g_m1 := ( 1.0 -  u/2.0 ) ** ( -2 );
               d_g_m1 := ( 1.0 - u/2.0 ) ** ( -3 );
            when d_and_s_type_b =>
               g_m1 := ( 1.0- u ) ** (-1 );
               d_g_m1 := ( 1.0 - u ) ** ( -2 );
            when d_and_s_constrained =>
               declare
                  alpha : constant Real := ( ru - rl ) / (( 1.0 - rl )*( ru - 1.0 ));  
               begin
                  g_m1 := rl*(ru-1.0)+ru*(1.0-rl)*Exp( alpha*u )/((ru-1.0)+(1.0-rl)*(Exp( alpha*u )));
                  d_g_m1 := g_m1 * ( ru - g_m1 ) * 
                           ((( 1.0 - rl )*alpha*Exp( alpha*u )) /
                            (( ru - 1.0 ) + (( 1.0 - rl ) * Exp( alpha*u ))));
               end;
            end case;
            if( DEBUG )then
               Put_Line( " u " & u'Img & " d_g_m1 " & d_g_m1'Img & " g_m1 " & g_m1'Img );
            end if;
            for i in Row_Range loop
               --
               -- function evaluation
               --
               z( i ) := z( i ) + ( initial_weights( k ) * data( k, i ) * ( g_m1 - 1.0 ));
               --
               -- the hessian
               --
               for l in Row_Range loop
                  declare
                     zz  : constant Real := initial_weights( k ) * data( k, i ) * data( k, l );
                  begin
                     hessian( i, l ) := hessian( i, l ) + ( zz * d_g_m1 );
                  end;
               end loop;
            end loop;
         end;
      end loop Each_Obs;

      for i in Row_Range loop
         f_lambdas( i ) := (a( i ) - z( i ));
      end loop;

   end Evaluate_Function_And_Hessian;

   procedure Do_Reweighting(
      data               : in Dataset;
      which_function     : in Distance_Function_Type;
      initial_weights    : in Col_Vector;
      target_populations : in Row_Vector;
      tolx               : in Real;
      tolf               : in Real;
      max_iterations     : in Positive;
      ru                 : in Real;
      rl                 : in Real;
      new_weights        : out Col_Vector;
      iterations         : out Natural;
      error              : out Eval_Error_Type ) is
       
      procedure Local_Evaluate(
         lambdas : in  Row_Vector;
         hessian : out Hessian_Matrix;
         beta    : out Row_Vector ) is
      begin
         if( Debug )then
            Put_Line( "Local evaluate called" );
         end if;
         Evaluate_Function_And_Hessian( 
            data               => data,
            lambdas            => lambdas,
            which_function     => which_function,
            initial_weights    => initial_weights,
            target_populations => target_populations,
            ru                 => ru,
            rl                 => rl,
            f_lambdas          => beta,
            hessian            => hessian );
         if( Debug )then
            Put_Line( "Local evaluate exiting" );
         end if;
      end Local_Evaluate;
      
      procedure Solve is new Solve_Non_Linear_Equation_System( Evaluate=>Local_Evaluate );
      
      lambdas    : Row_Vector := ( others => 0.0 ); -- FIXME
   begin
      --
      -- FIXME initial values for lambdas from inverting something?
      --
      Solve( lambdas, max_iterations, tolx, tolf, iterations, error );
      if( error = normal )then
         --
         -- FIXME put this in a function somewhere
         -- 
         Each_Obs:
         for k in Col_Range loop
            declare
            use Matrix_Functions;
               r      : constant Vector( lambdas'Range ) := Extract_Row( data, k );
               u      : constant Real := r * lambdas;
               g_m1   : Real;
            begin
               --
               -- based on the table 3 of creedy wp 03/17
               --
               case which_function is
               when chi_square =>
                   g_m1 := 1.0 + u;
               when constrained_chi_square =>
                   if( u < ( rl - 1.0 ))then    
                      g_m1 := rl;
                   elsif( u > ( ru - 1.0 ))then    
                      g_m1 := ru;
                   else
                      g_m1 := 1.0 + u;
                   end if;
               when d_and_s_type_a =>
                  g_m1 := ( 1.0 -  u/2.0 ) ** ( -2 );
               when d_and_s_type_b =>
                  g_m1 := ( 1.0- u ) ** (-1 );
               when d_and_s_constrained =>
                  declare
                     alpha : constant Real := ( ru - rl ) / (( 1.0 - rl )*( ru - 1.0 ));  
                  begin
                     g_m1 := rl*(ru-1.0)+ru*(1.0-rl)*Exp( alpha*u )/((ru-1.0)+(1.0-rl)*(Exp( alpha*u )));
                  end;
               end case;
               new_weights( k ) := initial_weights( k ) * g_m1;
            end;
         end loop Each_Obs;
      else
         new_weights := initial_weights;
      end if;
   end Do_Reweighting;


   function Do_Basic_Reweighting(
      data               : Dataset;
      initial_weights    : Col_Vector;
      target_populations : Row_Vector ) return Vector is
    --
    -- "Chi-Squqre" type with no checking for negatives
    -- from Creedy http://www.business.curtin.edu.au/files/creedy2.pdf
    -- 
    use Matrix_Functions;
      row, populations, lambdas : Row_Vector;
      weights : Col_Vector;
      m : Hessian_Matrix := ( others => ( others => 0.0 ));
    begin
      for k in Col_Range loop
         row := Extract_Row( data,  k ); -- no shortcut for this in the language if data is a true 2d array ...
         m := m + initial_weights( k ) * row * row; 
         for i in Row_Range loop
            populations( i ) := populations( i ) + ( row( i ) * initial_weights( k ));
         end loop;
      end loop;
      lambdas := Inverse( m ) * ( target_populations - populations );
      for k in Col_Range loop
         row := Extract_Row( data,  k );
         weights( k ) := initial_weights( k ) * ( 1.0 + ( row * lambdas ));
      end loop;
      return weights;
   end Do_Basic_Reweighting;
   
end  Maths_Functions.Weights_Generator;
