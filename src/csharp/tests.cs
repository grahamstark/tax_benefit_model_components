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
        
        public double[] it_rate = new double[8]{ 0.1, 0.25, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2 };
        public double[] it_band = new double[8]{ 2500, 4000, 5000, 8000, 9000, 10000, 12000, 9999999999999999999.99 };
        
        public double benefit1 = 150.0;
        public double benefit2 = 60.0;
        public double ben2_l_limit = 200.03;
        public double ben2_u_limit = 300.20;
        
        
}

public struct Results{
        public double Tax {get;set;}      
        public double Benefit1 {get;set;}      
        public double Benefit2 {get;set;}      
        public double NetIncome {get;set;}      

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
        
        ///
        /// <summary>
        /// JSA type benefit that produces a horizontal BC segment: give min 150 to everyone
        /// </summary>
        /// <returns>a benefit amount</returns>
        ///
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
        
        public Results Calculate( Person pers ){ 
                Results r;
                r.Tax = CalculateTax( pers.wage );
                r.Benefit1 = CalculateBenefit1( pers.wage-r.Tax ); 
                r.Benefit2 = CalculateBenefit2( pers.wage );
                r.NetIncome = pers.wage - r.Tax + r.Benefit1 + r.Benefit2;
                return r;
        }

}

/// <summary>
/// simple test wrapper class: would be initialised with some parameters 
/// and then fed households
/// </summary>
///
public class BCWrapper : NetIncome{

        private Calculator calculator;

        public Person Pers { get; set; }
        
        public BCWrapper( Parameters pars ){                
                calculator = new Calculator( pars );       
        }
        
        public List<String> eventsAt( double gross1, double gross2 ){
                List<String> events = new List<String>();
                Pers.wage = gross1;
                Results r1 = calculator.Calculate( Pers );
                Pers.wage = gross2;
                Results r2 = calculator.Calculate( Pers );
                if(( r1.Benefit1 > 0 ) && ( r2.Benefit1 == 0 )){
                        events.Add( "Benefit 1 ends" );      
                } else if(( r1.Benefit1 == 0 ) && ( r1.Benefit1 > 0 )){
                        events.Add( "Benefit 1 starts" );      
                } else if(( r1.Benefit2 > 0 ) && ( r2.Benefit2 == 0 )){
                        events.Add( "Benefit 2 ends" );      
                } else if(( r2.Benefit2 > 0 ) && ( r1.Benefit2 == 0 )){
                        events.Add( "Benefit 2 starts" );      
                } if( Math.Abs( r2.Benefit2 - r1.Benefit2 ) > Generator.INCREMENT ){
                        events.Add( "Benefit 2 jumps" );      
                } 
                // and so on
                return events;
        }
        
        // this implements the interface
        public double GetNet( double gross ){
                Pers.wage = gross;
                return calculator.Calculate( Pers ).NetIncome;       
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
                Person pers = new Person( age: 40 );
                wrapper.Pers = pers;
                
                List<Point> bc = Generator.Generate( wrapper );
                Console.WriteLine( "p,gross,net" );
                for( int i = 0; i < bc.Count; i++ ){
                        Console.WriteLine( "{0},{1:F4},{2:F4} ", i, bc[i].X, bc[i].Y );
                }
                Console.WriteLine( "events" );
                for( int i = 0; i < bc.Count; i++ ){
                        List<String> events = wrapper.eventsAt( bc[i-1].X, bc[i].X );
                        
                        double mr = Generator.CalcMarginalRate( bc[i-1], bc[i] );
                                
                        if( events.Count > 0 ){         
                                Console.WriteLine( "{0},{1:F4},{2:F4} : {3}", i, bc[i].X, mr, events[0] );
                        } else {
                                Console.WriteLine( "{0},{1:F4},{2:F4}", i, bc[i].X, mr );
                                
                        }
                }
                //
                // household loop would end here
                //
                return 0;
        }

}