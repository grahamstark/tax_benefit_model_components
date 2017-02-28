from piecewise_linear_generator import makeBudgetConstraint, printPoints


class Person:
        def __init__( self, age ):
                self.age = age
                self.wage = 0.0


class Parameters:
        def __init__( self ):
                self.it_allow = 500.0; 
                self.it_rate = [0.1, 0.25, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2 ]
                self.it_band = [2500, 4000, 5000, 8000, 9000, 10000, 12000, 9999999999999999999.99 ];
                
                self.benefit1 = 150.0;
                self.benefit2 = 60.0;
                self.ben2_l_limit = 200.03;
                self.ben2_u_limit = 300.20;

class Results:
        def __init__( self ):
                self.tax = 0.0
                self.benefit = []
                self.netIncome = 0.0

                
class Calculator:
        def __init__( self, pars ):
                self.pars = pars
        
        def calculateTax( self, gross ):
                ia = gross - self.pars.it_allow
                if ia < 0:
                        return 0.0
                due = 0.0
                i = 0
                remaining = ia
                last = 0.0
                while remaining > 0.0:
                        gap = self.pars.it_band[i] - last;
                        t = min( remaining, gap );
                        due += t * self.pars.it_rate[i];
                        remaining -= gap;
                        last = self.pars.it_band[i];
                        i+=1;                
                return due;
                
        def calculateBenefit0( self, gross ):
                if gross > pars.benefit1:
                        return 0.0
                else:
                        return self.pars.benefit1-gross;
        
        
        # vertical segments : give 60 to everyone earning over 200.03 euros, cut to 30 at 300
        def calculateBenefit1( self, gross ):
                b = pars.benefit2 if gross >= pars.ben2_l_limit else 0.0;
                if gross > pars.ben2_u_limit: 
                        b -= 30;
                return b;
                
        def calculate( self, pers ):
                r = Results();
                r.tax = self.calculateTax( pers.wage );
                #print "wage "+ `pers.wage` + " tax " + `r.tax`
                r.benefit.append( self.calculateBenefit0( pers.wage-r.tax )); 
                r.benefit.append( self.calculateBenefit1( pers.wage ));
                r.netIncome = pers.wage - r.tax + r.benefit[0] + r.benefit[1];
                #print "net " + `r.netIncome` + " ben0 " +`r.benefit[0]`+ " ben1 " + `r.benefit[1]`
                return r;
        
class BCWrapper:
        def __init__( self, pars, person ):
                self.calculator = Calculator( pars )
                self.person = person
                
        
        def yFromX( self, earnings ):
                self.person.wage = earnings;
                r = self.calculator.calculate( pers )
                return r.netIncome
	
start_pos = 0 
end_pos = 20000
final_precision = 2

pars = Parameters()
pers = Person( 45 )
pers.wage = 900
b = BCWrapper( pars, pers )


points = makeBudgetConstraint( b, start_pos, end_pos, final_precision )
printPoints( points )