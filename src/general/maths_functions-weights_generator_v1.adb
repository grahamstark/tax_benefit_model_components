with Ada.Assertions;
with Ada.Text_IO;

package body Maths_Functions.Weights_Generator is
   
   use Elementary_Functions;
   use Ada.Assertions;
   use Ada.Text_IO;

   
   --
   -- todo make this private
   --
   procedure Evaluate_Function_And_Hessian( 
      data               : in Matrix;
      lambdas            : in Vector;
      which_function     : Distance_Function_Type;
      initial_weights    : in Vector;
      target_populations : in Vector;
      ru                 : Real;
      rl                 : Real;
      f_lambdas          : out Vector;
      hessian            : out Matrix ) is
   use Matrix_Functions;
      subtype LVector is Vector( lambdas'Range );
      a : LVector := target_populations - ( initial_weights * data );
      z : LVector := ( others => 0.0 );
   begin
      hessian := ( others => ( others => 0.0 ));
      Each_Obs:
      for k in data'Range( 1 ) loop
         declare
            r      : constant LVector := Extract_Row( data, k );
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
            for i in lambdas'Range loop
               --
               -- function evaluation
               --
               z( i ) := z( i ) + ( initial_weights( k ) * data( k, i ) * ( g_m1 - 1.0 ));
               --
               -- the hessian
               --
               for l in lambdas'Range loop
                  declare
                     z  : constant Real := initial_weights( k ) * data( k, i ) * data( k, l );
                  begin
                     hessian( i, l ) := hessian( i, l ) + ( z * d_g_m1 );
                  end;
               end loop;
            end loop;
         end;
      end loop Each_Obs;

      for i in lambdas'Range loop
         f_lambdas( i ) := (a( i ) - z( i ));
      end loop;

   end Evaluate_Function_And_Hessian;

   procedure Do_Reweighting(
      data               : in Matrix;
      which_function     : in Distance_Function_Type;
      initial_weights    : in Vector;
      target_populations : in Vector;
      tolx               : in Real;
      tolf               : in Real;
      max_iterations     : in Positive;
      ru                 : in Real;
      rl                 : in Real;
      new_weights        : out Vector;
      iterations         : out Natural;
      error              : out Eval_Error_Type ) is
         
      subtype Hessian_Matrix is Matrix( data'Range( 2 ), data'Range( 2 ));
      subtype Weights_Vector is Vector( data'Range( 1 ));
      subtype Lambdas_Vector is Vector( data'Range( 2 ));
      
      procedure Local_Evaluate(
         lambdas : in  Lambdas_Vector;
         hessian : out Hessian_Matrix;
         beta    : out Lambdas_Vector ) is
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
      
      procedure Solve is new Solve_Non_Linear_Equation_System(  Evaluate=>Local_Evaluate );
      
      lambdas    : Lambdas_Vector := ( others => 0.0 ); -- FIXME
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
         for k in data'Range( 1 ) loop
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
      data               : Matrix;
      initial_weights    : Vector;
      target_populations : Vector ) return Vector is
    --
    -- "Chi-Squqre" type with no checking for negatives
    -- from Creedy http://www.business.curtin.edu.au/files/creedy2.pdf
    -- 
    use Matrix_Functions;
    subtype Target_Vector is Vector( target_populations'Range );
    subtype Column is  Vector( initial_weights'Range );
    subtype My_Matrix is Matrix( target_populations'Range, target_populations'Range );
      row, populations, lambdas : Target_Vector;
      weights : Column;
      m : My_Matrix := ( others => ( others => 0.0 ));
    begin
      for k in data'Range( 1 ) loop
         row := Extract_Row( data,  k ); -- no shortcut for this in the language if data is a true 2d array ...
         m := m + initial_weights( k ) * row * row; 
         for i in data'Range( 2 ) loop
            populations( i ) := populations( i ) + ( row( i ) * initial_weights( k ));
         end loop;
      end loop;
      lambdas := Inverse( m ) * ( target_populations - populations );
      for k in data'Range( 1 ) loop
         row := Extract_Row( data,  k );
         weights( k ) := initial_weights( k ) * ( 1.0 + ( row * lambdas ));
      end loop;
      return weights;
   end Do_Basic_Reweighting;
   
   
end  Maths_Functions.Weights_Generator;
