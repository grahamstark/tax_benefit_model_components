from xml.parsers.xmlproc import xmlproc
from xml.parsers.xmlproc import xmlval
from xml.parsers.xmlproc import xmldtd
from xml.dom.minidom import parse
from XMLUtils import childrenOf, firstChildOf

from parameters_model import ParameterSystem, Description, Text, EnumValue, Descriptions, Parameter, ParameterSystemReference, EnumeratedType, EditInfo

# XML file and corresponding DTD definition
file = '../tests/policy_parameters_for_outputs.xml'
dtd  = '../dtds/parameters2.dtd'

print 'Start XML Parsing (With DTD)'
d = xmldtd.load_dtd(dtd)
p = xmlval.XMLValidator()
## p.set_application(MyApp())
xml = p.parse_resource(file)
print p
print 'End XML Parsing (With DTD)'

desc = Description()
print desc

text = Text() 
print text

enumv = EnumValue()  
print enumv

descs = Descriptions()
print descs

par = Parameter()
print par

psr = ParameterSystemReference()
print psr

et = EnumeratedType()
print et

ei = EditInfo()
print ei

f = {}
f['ve' ] = 10
f[ 'rr' ] = 11
f[ 192 ] = 11

for k in f.keys():
        print k
        
xml = parse(file)
params = xml.getElementsByTagName("Parameter")
for p in params:
        print p
        
s1 = firstChildOf( xml, 'ParameterSystem' )
print s1
s11 = firstChildOf( s1, 'ParameterSystem' )
s111 = firstChildOf( s11, 'ParameterSystem' )
print s11
p2 = childrenOf( s111, 'Parameter' )
for p in p2:
        print p
        param = Parameter()
        param.fromXML( p )
        print param

sys = ParameterSystem()
sys.fromXML( s1 )

print sys

xp = sys.toXMLDocument()

print xp.toprettyxml( "       " )
