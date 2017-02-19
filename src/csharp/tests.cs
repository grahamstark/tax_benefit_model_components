using System;
using System.Collections;
using System.Collections.Generic;
// TODO using NUnit.Framework;
using PiecewiseLinearGenerator;

//
// simple test case: move this somewhere.. 
//
public class TBSys : NetIncome{
       
        private double it_allow = 500.0; 
        
        // FIXME: just discovered this breaks with rates > 100%
        private double[] it_rate = new double[8]{ 0.1, 0.25, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2 };
        private double[] it_band = new double[8]{ 2500, 4000, 5000, 8000, 9000, 10000, 12000, 9999999999999999999.99 };
        
        private double benefit = 150.0;
        
        private double CalculateTax( double gross ){
                double ia = gross - it_allow;
                if( ia < 0.0 ){
                        return 0.0;       
                }
                double due = 0.0;
                int i = 0;
                double remaining = ia;
                double last = 0.0;
                while( remaining > 0.0 ){
                        double gap = it_band[i] - last;
                        double t = Math.Min( remaining, gap );
                        due += t * it_rate[i];
                        remaining -= gap;
                        last = it_band[i];
                        i++;
                }
                return due;
        }
        
        // horizontal segment: give min 150 to everyone
        private double CalculateBenefit1( double gross ){
                return ( gross <= benefit ? benefit-gross : 0.0 );
        }
        
        // vertical segment : give 60 to everyone earning over 200.03 euros, cut to 30 at 300
        private double CalculateBenefit2( double gross ){
                double b = ( gross >= 200.03 ? 60.0 : 0.0 );
                if( gross > 300.0 ){ 
                        b = 30;
                }
                return b;
        }
        
        public double GetNet( double gross ){
                double tax = CalculateTax( gross );
                double benefit = CalculateBenefit1( gross-tax ) + CalculateBenefit2( gross );
                double net = gross - tax + benefit;
                return net;       
        }
        
}


class Test{
        
        public static int Main( string[] args ){
                TBSys sys = new TBSys();
                List<Point> bc = Generator.Generate( sys );
                for( int i = 0; i < bc.Count; i++ ){
                        Console.WriteLine( "Point[{0}] : Gross = {1} Net = {2} ", i, bc[i].X, bc[i].Y );
                }
                return 0;
        }

}
                
