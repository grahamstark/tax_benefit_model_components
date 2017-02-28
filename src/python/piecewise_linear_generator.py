VERTICAL = 9999999999999.9999
TOLERANCE = 0.0001
INCREMENT = 0.0001
MAX_DEPTH = 100

class Line:
        def __init__( self, a, b ):
                self.a = a
                self.b = b

class Point:
        def __init__( self, x, y ):
                self.x = x
                self.y = y

def  printPoints( l ):
        for  i in range( 0, l.__len__() ): 
                print "l["+str(i)+"]: x=" + str( l[i].x ) + ' y=' + str( l[i].y ) 
        
def makeLine( point_1, point_2 ):
        l = Line( 0.0, 0.0 )
        if( point_1.x == point_2.x ):
                l.b = point_1.x
                l.a = VERTICAL
                return l
        l.b = (point_1.y - point_2.y)/(point_1.x - point_2.x )
        l.b = min( VERTICAL, l.b )
        l.a = point_1.y - point_1.x*l.b
        return l

def findIntersection( line_1, line_2 ):
        p = Point( 0, 0 )
        if( line_1.b != line_2.b ):
                p.x = (line_2.a - line_1.a) / (line_1.b - line_2.b)
                p.y = line_1.a + (p.x * line_1.b)
        else:
                p.x = 0.0
                p.y = line_1.a
        return p

def compareByX( p1, p2 ):
        return (( p1.x > p2.x ) or (( p1.x == p2.x ) and ( p1.y > p2.y )))       


def nearlySameLine( l1, l2 ):
        return ((( abs( l1.a-l2.a )) < TOLERANCE ) and (( abs( l1.b-l2.b )) < TOLERANCE ))


def nearlySamePoint( l1, l2 ):
        return ((( abs( l1.x-l2.x )) < TOLERANCE*10 ) and (( abs( l1.y-l2.y )) < TOLERANCE*10 ))

def censor( points_l ):
        #
        # deletes duplicates and all but the endpoints of vertical lines
        #
        lines = []
        points = []
        points_l = sorted( points_l, cmp=compareByX )
        if( points_l.__len__() <= 3 ):
                return points_l
        pos = 1
        for i in range( 0, 3 ):
                points.append( Point( 0, 0 ))
        for i in range( 0, 2 ):
                lines.append( Line( 0, 0 ))
        while( points_l.__len__() > ( pos+1 )):
                points[0] = points_l[pos-1]
                points[1] = points_l[pos]
                points[2] = points_l[pos+1]
                lines[0] = makeLine( points[0], points[1] )
                lines[1] = makeLine( points[1], points[2] )
                if( nearlySameLine( lines[0], lines[1] )):
                        del points_l[ pos ]
                elif( nearlySamePoint( points[1], points[2] )):
                        del points_l[ pos ]
                else:
                        pos += 1
        return points_l

def generate( calculator, points_l, depth, start_pos, end_pos ):
        anchor = Point( 0, 0 )
        points = []
        lines  = []
        if( abs(start_pos - end_pos) < TOLERANCE ):
                return depth      
        if( depth > MAX_DEPTH ):
                print "generate_points: depth exceeded max is " + MAX_DEPTH 
                return MAX_DEPTH
        for i in range( 0, 5 ):
                points.append( Point( 0, 0 ))
                lines.append( Line( 0, 0 ))
        #
        # left line in points 1,2 
        #
        points[0].x = start_pos
        points[0].y = calculator.yFromX( points[0].x )
        points[1].x = start_pos + INCREMENT
        points[1].y = calculator.yFromX( points[1].x )
        #
        # right line in 3,4
        #
        points[2].x = end_pos - INCREMENT
        points[2].y = calculator.yFromX( points[2].x )
        points[3].x = end_pos
        points[3].y = calculator.yFromX( points[3].x )
        lines[0] = makeLine( points[0], points[1] )
        lines[1] = makeLine( points[2], points[3] )
        if( nearlySameLine( lines[0], lines[1])):
                #
                # Same line, so the section we're testing represents a single straight segment.
                # We're done exploring this bit store the line endpoints and return,
                #
                points_l.append( points[0] )
                points_l.append( points[3] )
                return depth         
                
        #
        # If we're not done here, find where the lines meet and explore each side of there. 
        # If the meeting point is out range of the current section being tested, || exactly
        # at its edge, pick an arbitrary point between the line starts.
        # 
        points[4] = findIntersection( lines[0], lines[1] )
        if(( points[4].x <= start_pos ) or ( points[4].x >= end_pos )):
                anchor = start_pos + ( end_pos - start_pos ) / 2.0
        else:
                anchor = points[4].x
        depth +=1
        #
        # recursively explore to the left of our new anchor point
        #
        depth = generate( calculator, points_l, depth, start_pos, anchor )
        #
        # .. then to the right.
        #
        depth = generate( calculator, points_l, depth, anchor, end_pos )
        depth -= 1
        return depth

def makeBudgetConstraint( calculator, start_pos, end_pos, final_precision ):
        points = []
        depth = 0 
        depth = generate( calculator, points, depth, start_pos, end_pos )
        # 1st censor at high precision: this spots vertical lines and
        # points on same lines...
        points = censor( points )
        # .. then round everything to nearest 1p and censor again
        #for i in range( 0, points.__len__() ):
        #        points[ i ].x = round( points[ i ].x, final_precision )
        #        points[ i ].y = round( points[ i ].y, final_precision )
        # points = censor( points )
        return points
