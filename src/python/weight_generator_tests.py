from scipy import linalg
import numpy as np
import weight_generator
import math

"""
      reproduces the basic test case in Creedy NEW ZEALAND TREASURY WORKING PAPER 03/17 table 3
      Creedy 2003 http://www.treasury.govt.nz/publications/research-policy/wp/2003/03-17/twp03-17.pdf
"""

def simple_f( inputs, hessian, beta ):
        hession = np.zeros(( 2, 2 ));
        hessian[ 1, 0 ] = 1.0;
        hessian[ 0, 1 ] = 0.0;
        hessian[ 0, 0 ] = 0.0;
        hessian[ 0, 1 ] = -2.0 * inputs[ 1 ];
        beta[ 0 ] = inputs[ 0 ] - ( 10.0 - inputs[ 1 ] ** 2 );
        beta[ 1 ] =inputs[ 1 ] - ( 2.0 + inputs[ 0 ] );
      
      
      
def test_eq_finder():
        beta   = np.zeros( 2 )
        inputs = np.zeros( 2 )
        error  = weight_generator.NORMAL
        hessian = np.zeros(( 2, 2 ))
        iterations = 0
        inputs = np.zeros( 2 )
        simple_f( inputs, hessian, beta );
        print beta
        print hessian
        inputs = np.zeros( 2 );
        inputs[0] = 10
        inputs[1] = 10
        
        weight_generator.solve_non_linear_equation_system( simple_f, inputs, 500, 0.00001, 0.00001, iterations, error );
        print inputs
        
        
OBS = np.mat(      
                [[ 1.0, 1.0, 0.0, 0.0 ],
                [ 0.0, 1.0, 0.0, 0.0 ],
                [ 1.0, 0.0, 2.0, 0.0 ],
                [ 0.0, 0.0, 6.0, 1.0 ],
                [ 1.0, 0.0, 4.0, 1.0 ],
                [ 1.0, 1.0, 0.0, 0.0 ],
                [ 1.0, 0.0, 5.0, 0.0 ],
                [ 0.0, 0.0, 6.0, 1.0 ],
                [ 0.0, 1.0, 0.0, 0.0 ],
                [ 0.0, 0.0, 3.0, 1.0 ],
                [ 1.0, 0.0, 2.0, 0.0 ],
                [ 1.0, 1.0, 0.0, 1.0 ],
                [ 1.0, 0.0, 3.0, 1.0 ],
                [ 1.0, 0.0, 4.0, 0.0 ],
                [ 0.0, 0.0, 5.0, 0.0 ],
                [ 0.0, 1.0, 0.0, 1.0 ],
                [ 1.0, 0.0, 2.0, 1.0 ],
                [ 0.0, 0.0, 6.0, 0.0 ],
                [ 1.0, 0.0, 4.0, 1.0 ],
                [ 0.0, 1.0, 0.0, 0.0 ]]);

INITIAL_WEIGHTS = np.transpose( np.array( 
                      [ 3.0,
                        3.0,
                        5.0,
                        4.0,
                        2.0,
                        5.0,
                        5.0,
                        4.0,
                        3.0,
                        3.0,
                        5.0,
                        4.0,
                        4.0,
                        3.0,
                        5.0,
                        3.0,
                        4.0,
                        5.0,
                        4.0,
                        3.0 ] ));
      
ACTUAL_FINAL_WEIGHTS = np.transpose( np.array( 
                      [ 2.753,
                      2.109,
                      5.945,
                      4.005,
                      2.484,
                      4.589,
                      5.752,
                      4.005,
                      2.109,
                      3.120,
                      5.945,
                      3.985,
                      5.019,
                      3.490,
                      4.678,
                      2.345,
                      5.070,
                      4.614,
                      4.967,
                      2.109 ] ));

TARGET_POPULATIONS = np.array( [ 50.0, 20.0, 230.0, 35.0 ] );
        
        
def test_calmar():
        out_array = []
        tol_x = 0.001;
        tol_f = 0.001;
        max_iterations = 30
        
        for measure in range( 9 ):
                iterations = 0
                error = 0
                r_u = 0.0
                r_l = 0.0
                if( measure == 0 ):
                        ctype = weight_generator.D_AND_S_TYPE_A
                elif( measure == 1 ):
                        ctype = weight_generator.D_AND_S_TYPE_B
                elif( measure == 2 ):
                        ctype = weight_generator.CONSTRAINED_CHI_SQUARE
                        r_u = 3.0;
                        r_l = 0.2;
                elif( measure == 3 ):
                        ctype = weight_generator.CONSTRAINED_CHI_SQUARE
                        r_u = 1.3;
                        r_l = 0.8;
                elif( measure == 4 ):
                        ctype = weight_generator.CONSTRAINED_CHI_SQUARE
                        r_u = 1.25;
                        r_l = 0.8;
                elif( measure == 5 ):
                        ctype = weight_generator.CHI_SQUARE
                elif( measure == 6 ):
                        ctype = weight_generator.D_AND_S_CONSTRAINED
                        r_u = 4.0;
                        r_l = 0.2;
                elif( measure == 7 ):
                        ctype = weight_generator.D_AND_S_CONSTRAINED
                        r_u = 3.0;
                        r_l = 0.2;
                elif( measure == 8 ):
                        ctype = weight_generator.D_AND_S_CONSTRAINED
                        r_u = 2.0;
                        r_l = 0.3;

                out = weight_generator.do_reweighting(
                       OBS, 
                       ctype,
                       INITIAL_WEIGHTS,
                       TARGET_POPULATIONS,
                       tol_x,
                       tol_f,
                       max_iterations,
                       r_u,
                       r_l );   
                # print "new weights "; print out[2]
                # print "error %d " % out[0]
                # print "iterations %d " % out[1]
                out_array.append( out[2] )
        print "TABLE 3"                
        print "N,BASE WEIGHT,D&S TYPE A,D&S TYPE B,CHI (3.0/0.2),CHI (1.3/0.8),CHI (1.25/0.8),CHI,D&S CONSTRAINED (4/0.2),D&S CONSTRAINED (3/0.2),D&S CONSTRAINED (2/0.2)" 
        for row in range( 20 ):
                print "%d, %.2f," % ( row+1, INITIAL_WEIGHTS[ row ] ),
                for measure in range( 9 ):
                        print "%.4f," % out_array[ measure ][ row ],
                print ""
       
test_calmar()        
