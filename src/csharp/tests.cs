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

public class Parameters{
        
        public double it_allow = 500.0; 
        
        // FIXME: just discovered this breaks with rates > 100%
        public double[] it_rate = new double[8]{ 0.1, 0.25, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2 };
        public double[] it_band = new double[8]{ 2500, 4000, 5000, 8000, 9000, 10000, 12000, 9999999999999999999.99 };
        
        public double benefit1 = 150.0;
        public double benefit2 = 60.0;
        public double ben2_l_limit = 200.03;
        public double ben2_u_limit = 300.20;
        
        
}

public class Calculator{
        
        private Parameters pars;
        
        public Calculator( Parameters pars ){
                this.pars = pars;        
        }
        
        private double CalculateTax( double gross ){
                double ia = gross - pars.it_allow;
                if( ia < 0.0 ){
                        return 0.0;       
                }
                double due = 0.0;
                int i = 0;
                double remaining = ia;
                double last = 0.0;
                while( remaining > 0.0 ){
                        double gap = pars.it_band[i] - last;
                        double t = Math.Min( remaining, gap );
                        due += t * pars.it_rate[i];
                        remaining -= gap;
                        last = pars.it_band[i];
                        i++;
                }
                return due;
        }
        
        // horizontal segment: give min 150 to everyone
        private double CalculateBenefit1( double gross ){
                return ( gross <= pars.benefit1 ? pars.benefit1-gross : 0.0 );
        }
        
        // vertical segments : give 60 to everyone earning over 200.03 euros, cut to 30 at 300
        private double CalculateBenefit2( double gross ){
                double b = ( gross >= pars.ben2_l_limit ? pars.benefit2 : 0.0 );
                if( gross > pars.ben2_u_limit ){ 
                        b -= 30;
                }
                return b;
        }
        
        public double netIncome( Person pers ){ 
                double tax = CalculateTax( pers.wage );
                double benefit = 
                        CalculateBenefit1( pers.wage-tax ) + 
                        CalculateBenefit2( pers.wage );
                return pers.wage - tax + benefit;
        }

}

//
// simple test wrapper class: would be initialised with some parameters 
// and then fed households
//
public class BCWrapper : NetIncome{

        private Calculator calculator;

        public Person Pers { get; set; }
        
        public BCWrapper( Parameters pars ){                
                calculator = new Calculator( pars );       
        }
        
        // this implements the interface
        public double GetNet( double gross ){
                Pers.wage = gross;
                return calculator.netIncome( Pers );       
        }
        
}


class Test{
        
        public static int Main( string[] args ){
                // feed the wrapper class with a parameter system
                // probably only need to this once
                Parameters pars = new Parameters();
                BCWrapper wrapper = new BCWrapper( pars );
                
                // feed wrapper with a person 
                // .. this would likely be an entire household
                // likely be a household loop here ...
                // possibly loop round people in hhls/benunit
		 Person pers = new Person( 40 );
                wrapper.Pers = pers;
                
                List<Point> bc = Generator.Generate( wrapper );
                for( int i = 0; i < bc.Count; i++ ){
                        Console.WriteLine( "Point[{0}] : Gross = {1} Net = {2} ", i, bc[i].X, bc[i].Y );
                }
                //
                // household loop would end here
                //
                return 0;
        }

}