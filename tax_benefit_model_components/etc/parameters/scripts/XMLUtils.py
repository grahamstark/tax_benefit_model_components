from xml import xpath;

def childrenOf( node, name ):
        expr = name
        #return node.xpathEval( name )
        return xpath.Evaluate( expr, node )

def firstChildOf( node, name ):
        expr = name
        l = xpath.Evaluate( expr, node )
        if( len( l ) > 0 ):
                return l[0]

def getAttribute( node, attr, default=None ):
        v = node.getAttribute( attr )
        if v == None or v == '':
                v = default
        return v

def setBoolAttribute( node, attr, b ):
        if( b ):
                s = 'true'
        else:
                s = 'false'
        node.setAttribute( attr, s )

def setIntAttribute( node, attr, b ):
        if( b == None ):
                return
        s = str( b )
        node.setAttribute( attr, s )

def setFloatAttribute( node, attr, b ):
        if( b == None ):
                return
        s = str(b)
        node.setAttribute( attr, s )


def getBoolAttribute( node, attr, default=None ):
        a = getAttribute( node, attr, default )
        return ((a == '1') or ( a == 'true' ))
       
#
# I don't understand this xml dom model at all...
# this is one way that works to get text out of a node
#
def getText( node ):
    rc = ""
    if( node.hasChildNodes() ):
        text = node.childNodes[0].data
        rc = rc + text 
    return rc

def getIntAttribute( node, attr, default=None ):
        a = getAttribute( node, attr, default )
        if( a == None ):
                return int(default)
        return int( a )
        
def getFloatAttribute( node, attr, default=None ):
        a = getAttribute( node, attr, default )
        if( a == None ):
                return float(default)
        return float( a )        
