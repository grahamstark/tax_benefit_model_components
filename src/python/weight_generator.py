"""
        Implements the weighting procedures from: 
        Creedy 2003 http://www.treasury.govt.nz/publications/research-policy/wp/2003/03-17/twp03-17.pdf
        and:
        Jean-Claude Deville and Carl-Erik Sarndal http://www.jstor.org/stable/2290268
        requires: scipy and numpy (but not much of them ... )

"""
from scipy import linalg
import numpy as np
import math

# possible function types
CHI_SQUARE             = 0 # note there's an easier way to do unconstrained CHI - see Creedy or the Ada version
D_AND_S_TYPE_A         = 1
D_AND_S_TYPE_B         = 2
CONSTRAINED_CHI_SQUARE = 3 
D_AND_S_CONSTRAINED    = 4

# error conditions
NORMAL                 = 0
UNDERFLOW              = 1
INTERATIONS_EXCEEDED   = 2 

DEBUG                  = False

def solve_non_linear_equation_system( func, x, num_trials, tolx, tolf ):
        """              
              func       :
              x          : in out Vector;
              num_trials : Natural; 
              tolx       : Real; 
              tolf       : Real;
              iterations : out Natural;
              error      : out Eval_Error_Type 
              @return [x vector, num_iterations, error_condition ]
        """
        if DEBUG:
                print "solve_non_linear_equation_system; num_trials %d" % num_trials
        x_range    = range( 0, x.size )
        hessian    = np.zeros( ( x.size, x.size ))
        beta       = np.zeros( x.size );
        deltas     = np.zeros( x.size );
        error      = NORMAL;
        iterations = 1;
        for k in range( 0, num_trials ):
                errf    = 0.0; 
                errx    = 0.0;
                out = func( x );
                beta = out[0]
                hessian = out[1]
                if DEBUG:
                        print "solve_non_linear_equation_system; hessian"; print hessian
                        print "solve_non_linear_equation_system; beta"; print beta
                        print "solve_non_linear_equation_system; x "; print x
                for i in x_range:
                        errf = errf + math.fabs( beta[ i ])   
                if( errf <= tolf ):
                        break;
                deltas = linalg.solve( hessian, beta )
                x += deltas;
                for i in x_range :
                        errx = errx + math.fabs( deltas[ i ])
                if( errx <= tolx ):
                        break
                iterations += 1;
        if iterations == num_trials + 1:
                error = ITERATIONS_EXCEEDED
        return [ x, error, iterations ];
        
def evaluate_function_and_hessian( data, lambdas, which_function, initial_weights, target_populations, ru, rl ):
        """
              @data               : in Dataset;
              @lambdas            : in Row_Vector;
              @which_function     : Distance_Function_Type;
              @initial_weights    : in Col_Vector;
              @target_populations : in Row_Vector;
              @ru                 : Real;
              @rl                 : Real;
              @return length 2 array with 0 = lambdas 1 = hessian [cols x cols]
        """
        n_rows = data.shape[0]
        n_cols = data.shape[1]
        ad = np.dot( initial_weights, data )
        a = target_populations - ad;

        z = np.zeros( n_cols )
        f_lambdas = np.zeros( n_cols )
        hessian = np.zeros(( n_cols, n_cols ))
        for k in range( 0, n_rows ):
                r = data[ k ]
                if DEBUG:
                        print "r = "; print r
                u = np.dot( r, lambdas )
                if which_function == CHI_SQUARE:
                        d_g_m1 = 1.0
                        g_m1 = 1.0 + u
                elif which_function == CONSTRAINED_CHI_SQUARE:
                        if( u < ( rl - 1.0 )):
                                g_m1 = rl;
                                d_g_m1 = 0.0;
                        elif( u > ( ru - 1.0 )):    
                                g_m1 = ru;
                                d_g_m1 = 0.0;
                        else:
                                g_m1 = 1.0 + u;
                                d_g_m1 = 1.0;
                elif which_function == D_AND_S_TYPE_A:
                        g_m1 = ( 1.0 -  u/2.0 ) ** ( -2 );
                        d_g_m1 = ( 1.0 - u/2.0 ) ** ( -3 );
                elif which_function == D_AND_S_TYPE_B:
                        g_m1 = ( 1.0- u ) ** (-1 );
                        d_g_m1 = ( 1.0 - u ) ** ( -2 );
                elif which_function == D_AND_S_CONSTRAINED:
                        alpha = ( ru - rl ) / (( 1.0 - rl )*( ru - 1.0 ));  
                        g_m1 = rl*(ru-1.0)+ru*(1.0-rl)*math.exp( alpha*u )/((ru-1.0)+(1.0-rl)*(math.exp( alpha*u )));
                        d_g_m1 = g_m1 * ( ru - g_m1 ) * ((( 1.0 - rl )*alpha*math.exp( alpha*u )) / (( ru - 1.0 ) + (( 1.0 - rl ) * math.exp( alpha*u ))));
                if DEBUG:
                        print " u %.2f d_g_m1 %.2f g_m1 %.2f " % ( u, d_g_m1, g_m1 )                         
                for i in range( 0, n_cols ):
                        z[ i ] += ( initial_weights[ k ] * data[ k, i ] * ( g_m1 - 1.0 ));               
                        if DEBUG:
                                print "z[%d] %.2f" % ( i, z[i] )
                        for l in range( 0, n_cols ):
                                iw = initial_weights[ k ]
                                dki = data[ k, i ]
                                dkl = data[ k, l ]
                                zz  = initial_weights[ k ] * dki * dkl;
                                hessian[ i, l ] = hessian[ i, l ] + ( zz * d_g_m1 );
        if DEBUG:
                print "A = ";print a
                print "Z = ";print z
        for i in range( 0, n_cols ):
                ai = a.item( i )
                zi = z[ i ]
                f_lambdas[ i ] = ai - zi
        return [ f_lambdas, hessian ]
                
def do_reweighting( data, which_function, initial_weights, target_populations, tolx, tolf, max_iterations, ru, rl ):        
        """                   
              
              data : KxJ matrix where k is num observations and J is num constraints;
              see:
              Microdata Adjustment by the Minimum Information Loss Principle Joachim Merz; FFB Discussion Paper No. 10 July 1994
              for a good discussion on how to lay out the dataset
              
              intial_weights, new_weights : K length vector
              target_populations - J length vector;
              
              tolx, tolf, max_iterations : see Solve_Non_Linear_Equation_System
              ru/rl max/min acceptable values of ratio of final_weight/initial_weight (for constrained distance functions)
               
                @data               Dataset;
                @which_function     Distance_Function_Type, from constants above;
                @initial_weights    Col_Vector;
                @target_populations Row_Vector;
                @tolx               Real;
                @tolf               Real;
                @max_iterations     Positive;
                @ru                 Real;
                @rl                 Real;
                @return length 3 array with 0=error 1 = num iterations neeed; 2 = new_weights 
        """  
        
        def local_evaluate( lambdas ):
                """
                        local function for the equation solver above
                """
                out = evaluate_function_and_hessian( data, lambdas, which_function, initial_weights, target_populations, ru, rl )
                if DEBUG:
                        print "local evaluate; hessian back as "; print out[1]
                        print "local evaluate; beta back as "; print out[0]
                return out
                
                   
        n_rows = data.shape[0]
        n_cols = data.shape[1]
        lambdas = np.zeros( n_cols );     
        iterations = 0
        error = NORMAL
        if DEBUG:
                print "main routine; n_cols %d n_rows %d " % ( n_cols, n_rows )
                print "target populations "; print target_populations;
                print "intial_weights ";print initial_weights;
                print "data "; print data;
        returns = solve_non_linear_equation_system( local_evaluate, lambdas, max_iterations, tolx, tolf )
        lambdas = returns[0]
        error = returns[1]
        iterations = returns[2]
        if DEBUG:
                print "lambdas "; print lambdas
        new_weights = np.zeros( n_rows )
        if error == NORMAL:
                for k in range( 0, n_rows ):
                        r = data[ k ]
                        if DEBUG:
                                print "r "; print r;
                        u = np.dot( r, lambdas )
                        if which_function == CHI_SQUARE:
                                g_m1 = 1.0 + u;                           
                        elif which_function == CONSTRAINED_CHI_SQUARE:
                                if u < ( rl - 1.0 ):    
                                        g_m1 = rl;
                                elif u > ( ru - 1.0 ):   
                                        g_m1 = ru;
                                else:
                                        g_m1 = 1.0 + u;
                        elif which_function == D_AND_S_TYPE_A:
                                g_m1 = ( 1.0 -  u/2.0 ) ** ( -2 );
                        elif which_function == D_AND_S_TYPE_B:
                                g_m1 = ( 1.0- u ) ** (-1 );
                        elif which_function == D_AND_S_CONSTRAINED:
                                alpha = ( ru - rl ) / (( 1.0 - rl )*( ru - 1.0 ));  
                                g_m1 = rl*(ru-1.0)+ru*(1.0-rl)*math.exp( alpha*u )/((ru-1.0)+(1.0-rl)*(math.exp( alpha*u )));
                        new_weights[ k ] = initial_weights[ k ] * g_m1;  
                        if DEBUG:
                                print "new_weights( %d ) = " % ( k ); print new_weights[ k ]
                                print "g_m1 = %.2f" % (g_m1)
        return [ error, iterations, new_weights ]                
