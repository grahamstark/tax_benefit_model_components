using System;
using System.Collections;
using System.Collections.Generic;
// TODO using NUnit.Framework;
using PiecewiseLinearGenerator;


public class Person{
        public double wage;
        public int age;
        
        public Person( int age ){
                this.age = age;        
        }
        
}

public class Params{
        
        public double it_allow = 500.0; 
        
        // FIXME: just discovered this breaks with rates > 100%
        public double[] it_rate = new double[8]{ 0.1, 0.25, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2 };
        public double[] it_band = new double[8]{ 2500, 4000, 5000, 8000, 9000, 10000, 12000, 9999999999999999999.99 };
        
        public double benefit1 = 150.0;
        public double benefit2 = 60.0;
        public double ben2_l_limit = 200.03;
        public double ben2_u_limit = 300.20;
        
        
}



//
// simple test case: move this somewhere.. 
//
public class TBSys : NetIncome{

        private Params Sys { get; set; }

        public Person Pers { get; set; }
        
        public TBSys( Params sys ){
                this.Sys = sys;       
        }
        
        private double CalculateTax( double gross ){
                double ia = gross - Sys.it_allow;
                if( ia < 0.0 ){
                        return 0.0;       
                }
                double due = 0.0;
                int i = 0;
                double remaining = ia;
                double last = 0.0;
                while( remaining > 0.0 ){
                        double gap = Sys.it_band[i] - last;
                        double t = Math.Min( remaining, gap );
                        due += t * Sys.it_rate[i];
                        remaining -= gap;
                        last = Sys.it_band[i];
                        i++;
                }
                return due;
        }
        
        // horizontal segment: give min 150 to everyone
        private double CalculateBenefit1( double gross ){
                return ( gross <= Sys.benefit1 ? Sys.benefit1-gross : 0.0 );
        }
        
        // vertical segments : give 60 to everyone earning over 200.03 euros, cut to 30 at 300
        private double CalculateBenefit2( double gross ){
                double b = ( gross >= Sys.ben2_l_limit ? Sys.benefit2 : 0.0 );
                if( gross > Sys.ben2_u_limit ){ 
                        b -= 30;
                }
                return b;
        }
        
        public double GetNet( double gross ){
                Pers.wage = gross;
                double tax = CalculateTax( Pers.wage );
                double benefit = CalculateBenefit1( Pers.wage-tax ) + CalculateBenefit2( Pers.wage );
                double net = Pers.wage - tax + benefit;
                return net;       
        }
        
}


class Test{
        
        public static int Main( string[] args ){
                Params sys = new Params();
                TBSys calc = new TBSys( sys );
		Person pers = new Person( 40 );
                calc.Pers = pers;
                List<Point> bc = Generator.Generate( calc );
                for( int i = 0; i < bc.Count; i++ ){
                        Console.WriteLine( "Point[{0}] : Gross = {1} Net = {2} ", i, bc[i].X, bc[i].Y );
                }
                return 0;
        }

}
                
