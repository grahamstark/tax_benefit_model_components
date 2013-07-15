from Cheetah.Template import Template
import datetime
import os
import sys
import csv
import re
import string

from xml.parsers.xmlproc import xmlproc
from xml.parsers.xmlproc import xmlval
from xml.parsers.xmlproc import xmldtd
from xml.dom.minidom import parse

from parameters_model import \
        DEFAULT_MIN, DEFAULT_MAX, DEFAULT_LANGUAGE, DEFAULT_COUNTRY, DEFAULT_CURRENCY, \
        ParameterSystem, Description, Text, EnumValue, \
        Descriptions, Parameter, ParameterSystemReference, EnumeratedType, EditInfo

from XMLUtils import childrenOf, firstChildOf

from simple_templates import \
        HTML_TEMPLATE, EXISTS_TEMPLATE, DIFFERENCES_TEMPLATE, INSERT_TEMPLATE, \
        BOOLEAN_TEMPLATE, MONEY_TEMPLATE
        
def map_ada_type( param ):
        return 'Money'        
        
def make_one_input( sysname, param ):
        appTemplate_money = Template( MONEY_TEMPLATE )
        
        appTemplate_money.default_value = 'default'+sysname+"."+param.instanceName;
        appTemplate_money.qualified_varname = "edited"+sysname+"."+param.instanceName
        
        appTemplate_money.instance_name = param.instanceName
        appTemplate_money.description = param.description( 'label' )
        ada_type = map_ada_type( param )
        minstr = param.editInfo().min
        if( minstr == None ) or ( minstr == DEFAULT_MIN ):
                minstr = ada_type+"'Low"
        maxstr = param.editInfo().max
        if( maxstr == None ) or ( maxstr == DEFAULT_MAX ):
                maxstr = ada_type+"'High"
        appTemplate_money.min = minstr
        appTemplate_money.max = maxstr
        
        print str( appTemplate_money )
        
        
def create_ada( sysname, sys ):
        print "on system"; print sys
        sysname = sysname + "." + sys.instanceName;
        for sysName in sys.parameterSystemsOrder:
                create_ada( sysname, sys.parameterSystems[sysName] )
        for paramName in sys.parameterOrder:
                paramstr = make_one_input( sysname, sys.parameters[paramName] );
                print paramstr
        

# XML file and corresponding DTD definition
file = '../tests/policy_parameters_for_outputs.xml'
dtd  = '../dtds/parameters2.dtd'

print 'Start XML Parsing (With DTD)'
d = xmldtd.load_dtd(dtd)
p = xmlval.XMLValidator()
## p.set_application(MyApp())
#xml = p.parse_resource(file)
xml = parse( file )
sys = ParameterSystem()
s1 = firstChildOf( xml, 'ParameterSystem' )

sys.fromXML( s1 )
create_ada( "", sys )
