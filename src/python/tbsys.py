from piecewise_linear_generator import makeBudgetConstraint, printPoints

# class Adult:
        # def __init__( self ):
                # self.age = 40,      
                # self.sex = "FEMALE"
                # self.period = "MONTH",
                # self.married = 0  
                # self.serps = "IN" # are you contacted in our out of SERPS State Earnings Related Pension Scheme */
                # self.hours = 20
                # self.employment = "EMPLOYEE", # are you EMPLOYEE,SELF_EMP,RETIREDUNOCCUPIED }; */
                # self.earnings = 240.0  # what are your earnings per [week??] */
                # self.selfemp = 0.0  # what are your weekly self employment profits? */
                # self.savingsIncome = 0.0  # what is your [weekly] income from savings */
                # self.pensions = 0.0   
# 
# class Family:
        # def __init__( self ):
                # self.ads = [ Adult(), Adult() ]
                # self.title = ""
                # self.numAdults = 1
                # self.beer = 0  # pints */
                # self.wine = 0  #* xx cl bottles **/
                # self.spirits = 0  #* xx cl whisky bottles **/
                # self.petrol = 0   #* litres **/
                # self.fags = 0 
                # kids = []
                # 

	
class TBCalculator_Basic:

	def yFromX( self, earnings ):
	        ex = max( 0, earnings - 200 )
	        if( earnings < 200 ):
	                n = 200 # IS
	        elif( earnings < 400 ):
	                n = earnings - 0.2*ex;
	        elif( earnings < 600 ):
	                n = earnings - 0.25*ex;
	        else:
	                n = earnings - 0.3*ex;
	        return n;

calc = TBCalculator_Basic()

print calc.yFromX( 1000 );
start_pos = 0 
end_pos = 2000 
final_precision = 2
points = makeBudgetConstraint( calc, start_pos, end_pos, final_precision )
printPoints( points )
