using System;
using System.Collections;
using System.Collections.Generic;
// TODO using NUnit.Framework;
using PiecewiseLinearGenerator;

public enum NetType{ NetIncome, TotalTaxes, BenefitsOnly };
        
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

public class Results : BCResult{
        
        public double Tax {get;set;}      
        public double[] Benefit {get;set;}      
        public double NetIncome {get;set;}  
        public double MR {get;set;}
        
        public double getY(){
                return this.NetIncome;
        }
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
        private double CalculateBenefit0( double gross ){
                return ( gross <= pars.benefit1 ? pars.benefit1-gross : 0.0 );
        }
        
        // vertical segments : give 60 to everyone earning over 200.03 euros, cut to 30 at 300
        private double CalculateBenefit1( double gross ){
                double b = ( gross >= pars.ben2_l_limit ? pars.benefit2 : 0.0 );
                if( gross > pars.ben2_u_limit ){ 
                        b -= 30;
                }
                return b;
        }
        
        public Results Calculate( Person pers ){ 
                Results r = new Results();
                r.Tax = CalculateTax( pers.wage );
                r.Benefit = new double[3];
                r.Benefit[0] = CalculateBenefit0( pers.wage-r.Tax ); 
                r.Benefit[1] = CalculateBenefit1( pers.wage );
                r.NetIncome = pers.wage - r.Tax + r.Benefit[0] + r.Benefit[1];
                return r;
        }
}

/// <summary>
/// simple test wrapper class: would be initialised with some parameters 
/// and then fed households
/// </summary>
///
public class BCWrapper : BCCalculator{

        private Calculator calculator;

        public Person Pers { get; set; }
        
        public NetType netType {get; set; }
        public int whichPerson;
        
        // other assumptions
        
        public BCWrapper( Parameters pars ){                
                calculator = new Calculator( pars );       
        }
        
        public List<String> GetEventsAt( Point baseP ){
                Person savedp = Pers;
                //
                // 4 points 0..3 from lowest X to highest with the base point as 3rd (p2)
                // mr below base point is from 2 points both below the base point
                // since the base point is 1 increment above the actual kink
                //
                List<String> events = new List<String>();
                
                Pers.wage = baseP.X - Generator.INCREMENT*2;
                Results r0 = calculator.Calculate( Pers );
                Point p0 = new Point();
                p0.X = Pers.wage;
                
                Pers.wage = baseP.X - Generator.INCREMENT;
                Results r1 = calculator.Calculate( Pers );
                Point p1 = new Point();
                p1.X = Pers.wage;                
                
                Pers.wage = baseP.X;
                Results r2 = calculator.Calculate( Pers );
                Point p2 = new Point();
                p2.X = Pers.wage;

                Pers.wage = baseP.X + Generator.INCREMENT;
                Results r3 = calculator.Calculate( Pers );
                Point p3 = new Point();
                p3.X = Pers.wage;
                for( int i = 0;i < 3; i++ ){
                        double d12Diff = Math.Abs( r2.Benefit[i] - r1.Benefit[i] );
                        if(( r1.Benefit[i] > 0 ) && ( r2.Benefit[i] == 0 )){
                                events.Add( "Benefit "+i+" ends" );      
                        } else if(( r1.Benefit[i] == 0 ) && ( r2.Benefit[i] > 0 )){
                                events.Add( "Benefit "+i+" starts" );      
                        } else if( d12Diff > Generator.INCREMENT ){
                                events.Add( String.Format( "Benefit " + i + " jumps by {0:F2}", d12Diff ));      
                        }
                }
                if(( r1.Tax == 0 ) && ( r2.Tax > 0 )){
                        events.Add( "Income Tax Starts" );
                }
                
                p0.Y = r0.Tax;
                p1.Y = r1.Tax;
                p2.Y = r2.Tax;
                p3.Y = r3.Tax;
                
                double taxMr1 = 100 - Generator.CalcMarginalRate( p0, p1 );
                double taxMr2 = 100 - Generator.CalcMarginalRate( p2, p3 );
                
                if( Math.Abs( taxMr1 - taxMr2 ) > Generator.TOLERANCE ){
                        events.Add( String.Format( "income tax MR changes from {0:F1}% to {1:F1}% ", taxMr1, taxMr2  ));       
                }
                // everything back the way it was
                Pers = savedp;
                // FIXME something to add chanding MR tax rates - needs 3 points, precomputed MRs??
                // and so on
                return events;
        }
        
        // this implements the interface
        public BCResult getResult( double gross ){
                Pers.wage = gross;
                // double n = 0;
                Results r = calculator.Calculate( Pers );
                return r;
                /*
                switch( netType ){
                case NetType.NetIncome :
                        n = r.NetIncome;
                        break;
                case NetType.TotalTaxes :
                        n = r.Tax;
                        break;
                case NetType.BenefitsOnly :
                        n = r.Benefit[0] + r.Benefit[1];
                        break;
                }
                return n;
                */
        }
}


class Test{

        public static int Main( string[] args ){
                // feed the wrapper class with a parameter system
                // probably only need to this once]
                
                Point p = new Point();
                //p.Y = 212;
                Console.WriteLine( "p.Y " + p.Y );
                /*
                Parameters pars = new Parameters();
                BCWrapper wrapper = new BCWrapper( pars );
                
                // feed wrapper with a person 
                // .. this would likely be an entire household
                // likely be a household loop here ...
                // possibly loop round people in hhls/benunit
                Person pers = new Person( age: 40 );
                wrapper.Pers = pers;
                wrapper.netType = NetType.NetIncome;
                List<Point> bc = Generator.Generate( wrapper );
                Console.WriteLine( "p,gross,net" );
                for( int i = 0; i < bc.Count; i++ ){
                        Console.WriteLine( "{0},{1:F4},{2:F4} ", i, bc[i].X, bc[i].Y );
                }
                Console.WriteLine( "events" );
                Console.WriteLine( "p, gross,mr,event" );
                double mr = 0.0;
                for( int i = 0; i < bc.Count; i++ ){
                        if( i < bc.Count -1 ){
                                mr = Generator.CalcMarginalRate( bc[i], bc[i+1] );
                        }
                        List<String> events = wrapper.GetEventsAt( bc[i] );
                        if( i == 0 ){
                                events.Insert( 0, "bc starts");
                        }
                        if( i == bc.Count - 1){
                                events.Insert( 0, "bc ends");
                        }
                        
                        if( events.Count > 0 ){         
                                Console.WriteLine( "{0},{1:F4},{2:F2} : {3}", i, bc[i].X, mr, events[0] );
                        } else {
                                Console.WriteLine( "{0},{1:F4},{2:F2}", i, bc[i].X, mr );
                                
                        }
                }
                
                // taxes
                wrapper.netType = NetType.TotalTaxes;
                List<Point> taxes = Generator.Generate( wrapper );
                Console.WriteLine( "\n\np,gross,totalTax" );
                for( int i = 0; i < taxes.Count; i++ ){
                        if( i < taxes.Count-1 ){
                                mr = 100 - ( Generator.CalcMarginalRate( taxes[i], taxes[i+1] ));    
                        }    
                        Console.WriteLine( "{0},{1:F4},{2:F4},{3:F2}  ", i, taxes[i].X, taxes[i].Y, mr );
                }
                
                // benefits
                wrapper.netType = NetType.BenefitsOnly;
                List<Point> benefits = Generator.Generate( wrapper );
                Console.WriteLine( "\n\np,gross,benefits" );
                for( int i = 0; i < benefits.Count; i++ ){
                        if( i < benefits.Count-1 ){
                                mr = ( Generator.CalcMarginalRate( benefits[i], benefits[i+1] )) - 100;    
                        }    
                        Console.WriteLine( "{0},{1:F4},{2:F4},{3:F2}  ", i, benefits[i].X, benefits[i].Y, mr );
                }
                
                //
                // household loop would end here
                //
                */
                return 0;
        }
}