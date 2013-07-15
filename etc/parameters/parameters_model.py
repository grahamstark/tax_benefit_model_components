from string import upper
import re
from string import capwords
import xml
from xml.dom.minidom import parseString;
from xml import xpath
from XMLUtils import getText, getAttribute, getBoolAttribute, getFloatAttribute, getIntAttribute, firstChildOf, childrenOf
from XMLUtils import setBoolAttribute, setFloatAttribute, setIntAttribute

DEFAULT_LANGUAGE = 'en';
DEFAULT_COUNTRY  = 'GB'
DEFAULT_MIN = -99999999999.99
DEFAULT_MAX = 999999999999.99;
DEFAULT_CURRENCY = 'GBP'
MISSING_VALUE = -999

class Text:        
        def __init__( self ):
                self.text = {}
                
        def get( self, lang = DEFAULT_LANGUAGE ):
                if( self.text.has_key( lang ) ):
                        return self.text[ lang ]
                if( self.text.has_key( DEFAULT_LANGUAGE ) ):
                        return self.text[ DEFAULT_LANGUAGE ]
                if( len( self.text ) > 0 ):
                        return self.text[0]
                return ''
                
        def put( self, text, lang = DEFAULT_LANGUAGE ):
                self.text[ lang ] = text
                
                
        def fromXML( self, xml ):
                for t in childrenOf( xml, "Text" ):
                        lang = getAttribute( t, 'lang', DEFAULT_LANGUAGE );
                        text = getText( t )
                        self.put( text, lang );
                
                
        def toXML( self, document, parent ):
                for k in self.text.keys():
                        elem = document.createElement( 'Text' )
                        textElem = document.createTextNode( self.text[k] );
                        elem.appendChild( textElem );
                        elem.setAttribute( 'lang', k );
                        parent.appendChild( elem )

class Description:
        def __init__( self ):
                self.lang = DEFAULT_LANGUAGE
                self.country = DEFAULT_COUNTRY
                self.xtype = 'description'
                self.text = ''
                
        def toXML( self, document ):
                elem = document.createElement( 'Description' );
                elem.setAttribute( 'country', self.lang );
                elem.setAttribute( 'lang', self.lang );
                elem.setAttribute( 'type', self.xtype );
                text = document.createTextNode( self.text );
                elem.appendChild( text );
                return elem;
                
        def fromXML( self, xml ):
                self.lang = getAttribute( xml, 'lang', self.lang )
                self.country = getAttribute( xml, 'country', self.lang )
                self.xtype = getAttribute( xml, 'type', self.xtype )
                self.text = getText( xml )
                
        def __repr__( self ):
                return "lang %(lang)s country %(cou)s type %(type)s\n text %(text)s" % \
                {'lang': self.lang, 'cou':self.country, 'text': self.text, 'type': self.xtype }

class Descriptions:
        def __init__( self ):
                self.descriptions = {}
                
        def __repr__( self ):
                s = ''
                for key in self.descriptions.keys():
                        s += self.descriptions[key].__repr__();
                return s
                
        def toXML( self, document, parent ):
                """
                appends all the descriptions to the given parent node, which is
                part of the given document.
                """
                for key in self.descriptions.keys():
                        parent.appendChild( self.descriptions[ key ].toXML( document ))                 
                
        def fromXML( self, xml ):
                for t in childrenOf( xml, "Description" ):
                        ev = Description()
                        ev.fromXML( t )
                        key = ev.lang+"_"+ev.xtype
                        self.descriptions[ key ] = ev;
                        
        def description( self, lang=DEFAULT_LANGUAGE, xtype = 'description' ):
                key = lang+"_"+xtype
                if( self.descriptions.has_key( key )):
                        return self.descriptions[key].text
                for lang in ( lang, DEFAULT_LANGUAGE ):
                        for xtype in ( 'description', 'label', 'journalese' ):
                                key = lang+"_"+xtype
                                if( self.descriptions.has_key( key )):
                                        return self.descriptions[key].text
                if( len( self.descriptions ) > 0 ):
                        key = self.descriptions.keys()[0]
                        return self.descriptions[ key ].text
                return ''


class EnumValue:
        
        def __init__( self ):
                self.name = ''
                self.value = MISSING_VALUE
                self.default = 0
                self.textv = Text()
                
        def __repr__( self ):
                return "name %(name)s value %(value)d type %(default)d\n text %(text)s" % \
                {'name': self.name, 'value':self.value, 'default': self.default, 'text': self.textv.get() }

                
        def text( self, lang = DEFAULT_LANGUAGE ):
                return self.textv.get( lang )
                
        def fromXML( self, xml ):
                self.name = getAttribute( xml, 'name', '' )
                self.value = getIntAttribute( xml, 'value', self.value )
                self.default = getBoolAttribute( xml, 'default', self.default )
                self.textv.fromXML( xml )
                
                
        def toXML( self, document ):
                elem = document.createElement( 'EnumValue' );
                elem.setAttribute( 'name', self.name );
                setIntAttribute( elem, 'value', self.value );
                setBoolAttribute( elem, 'default', self.default );                
                self.textv.toXML( document, elem );
                return elem

class Subset:
        
        def __init__( self ):
                self.id = ''
                self.start = ''
                self.stop = ''
                self.descriptions = Descriptions()
                
        def fromXML( self, xml ):
                self.id = getAttribute( xml, 'id', self.id )
                self.start = getAttribute( xml, 'start', self.start )
                self.stop = getAttribute( xml, 'stop', self.stop )
                self.descriptions.fromXML( xml );
                
        def toXML( self, document ):
                elem = document.createElement( 'Subset' );
                elem.setAttribute( 'id', self.id );
                elem.setAttribute( 'start', self.start );
                elem.setAttribute( 'stop', self.stop );
                self.descriptions.toXML( document, elem );
                return elem
                

class EnumeratedType:
        
        def __init__( self ):
                self.id = ''
                self.name = ''
                self.values = []
                self.subsets = {}
                self.descriptions = Descriptions()
                
        def getValues( self, subsetId = None ):
                if( subsetId == None ):
                        return self.values
                values = []
                started = 0
                subset = self.subsets[ subsetId ]
                for v in self.values:
                        if( v.name == subset.start ):
                                started = true
                        if( started ):
                                values.append( v )
                        if( v.name == subset.stop ):
                                return values
                        
                
        def fixup_values( self ):
                highest = 0
                for v in self.values:
                        if( v.value > highest ):
                                highest = v.value
                for v in self.values:
                        if( v.value == MISSING_VALUE ):
                                v.value = highest
                                highest += 1
                                
                                
        def fromXML( self, xml ):
                self.id = getAttribute( xml, 'id' )
                self.name = getAttribute( xml, 'id', self.id )
                for t in childrenOf( xml, "EnumValue" ):
                        ev = EnumValue()
                        ev.fromXML( t )
                        self.values.append( ev )
                self.fixup_values()
                self.descriptions.fromXML( xml );
                for t in childrenOf( xml, "Subset" ):
                        s = Subset()
                        s.fromXML( t )
                        self.subsets[ s.id ] = s
                
        def toXML( self, document ):
                elem = document.createElement( 'EnumeratedType' );
                elem.setAttribute( 'id', self.id );
                elem.setAttribute( 'name', self.name );
                self.descriptions.toXML( document, elem );
                for s in self.subsets.values():
                        elem.appendChild( s.toXML( document ) )                        
                for v in self.values:
                        elem.appendChild( v.toXML( document ) )
                return elem
                        
        def __repr__( self ):
                s = self.id+"\n"
                for v in self.values:
                        s += v.__repr__()+"\n"
                return s
                
                
class EditInfo:
        
        def __init__( self ):
                self.xtype = "default"
                self.output_index = ''
                self.uprate = "dont_uprate"
                self.country = DEFAULT_COUNTRY
                self.lang = DEFAULT_LANGUAGE
                self.currencyCode = DEFAULT_CURRENCY
                self.next = 0.0
                self.display = "normal"
                self.check = "dont_check"
                self.min = DEFAULT_MIN
                self.max = DEFAULT_MAX
                self.prec = 0
                self.format=''
                self.match=''
                self.length = 0
                self.asArray = 0
                self.topSet = 0
                self.order = "none"
                self.treatAsPercentage = 1
                self.sumsTo100 =  0
                self.macroVariableClass='' 
                self.levelChangePossible = 1
                self.isExogenous = 0
                self.outputFileStartPos = 0
                self.numVariables = 0
                self.percentChangePossible = 0
                self.realOutputFileStartPos = 0
                self.exceptions='' 


        def toXML( self, document ):
                elem = document.createElement( 'EditInfo' );
                elem.setAttribute( "xtype", self.xtype )
                elem.setAttribute( "uprate", self.uprate )
                elem.setAttribute( "country", self.country )
                elem.setAttribute( "lang", self.lang )
                elem.setAttribute( "currencyCode", self.currencyCode )
                setFloatAttribute( elem, 'next', self.next );
                elem.setAttribute( "display", self.display )
                elem.setAttribute( "check", self.check )
                setFloatAttribute( elem, 'min', self.min );
                setFloatAttribute( elem, 'max', self.max );
                setIntAttribute( elem, 'prec', self.prec );
                elem.setAttribute( "format", self.format )
                elem.setAttribute( "match", self.match )
                setIntAttribute( elem, 'length', self.length );
                setBoolAttribute( elem, "asArray", self.asArray )
                setBoolAttribute( elem, "topset", self.topSet )
                elem.setAttribute( "order", self.order )
                setBoolAttribute( elem, "treatAsPercentage", self.treatAsPercentage )
                setBoolAttribute( elem, "sumsTo100", self.sumsTo100 )
                elem.setAttribute( "macroVariableClass", self.macroVariableClass )
                setBoolAttribute( elem, "levelChangePossible", self.levelChangePossible )
                setBoolAttribute( elem, "isExogenous", self.isExogenous )
                setIntAttribute( elem, 'outputFileStartPos', self.outputFileStartPos );
                setIntAttribute( elem, 'numVariables', self.numVariables );
                setBoolAttribute( elem, "percentChangePossible", self.percentChangePossible )
                setIntAttribute( elem, 'outputFileStartPos', self.realOutputFileStartPos );
                elem.setAttribute( "exceptions", self.exceptions )
                elem.setAttribute( "output_index", self.output_index )
                return elem

        def fromXML( self, xml ):
                self.xtype = getAttribute( xml, "xtype", self.xtype )
                self.uprate = getAttribute( xml, "uprate", self.uprate )
                self.country = getAttribute( xml, "country", self.country )
                self.lang = getAttribute( xml, "lang", self.lang )
                self.currencyCode = getAttribute( xml, "currencyCode", self.currencyCode )
                self.next = getFloatAttribute( xml, 'next', self.next )
                self.display = getAttribute( xml, "display", self.display )
                self.check = getAttribute( xml, "check", self.check )
                self.min = getFloatAttribute( xml, 'min', self.min )
                self.max = getFloatAttribute( xml, 'max', self.max )
                self.prec = getIntAttribute( xml, 'prec', self.prec )
                self.format = getAttribute( xml, "format", self.format )
                self.match = getAttribute( xml, "match", self.match )
                self.length = getFloatAttribute( xml, 'length', self.length )
                self.asArray = getBoolAttribute( xml, "asArray", self.asArray )
                self.topSet = getBoolAttribute( xml, "topset", self.topSet )
                self.order = getAttribute( xml, "order", self.order )
                self.treatAsPercentage = getBoolAttribute( xml, "treatAsPercentage", self.treatAsPercentage )
                self.sumsTo100 = getBoolAttribute( xml, "sumsTo100", self.sumsTo100 )
                self.macroVariableClass = getAttribute( xml, "macroVariableClass", self.macroVariableClass )
                self.levelChangePossible = getBoolAttribute( xml, "levelChangePossible", self.levelChangePossible )
                self.isExogenous = getBoolAttribute( xml, "isExogenous", self.isExogenous )
                self.outputFileStartPos = getIntAttribute( xml, 'outputFileStartPos', self.outputFileStartPos );
                self.numVariables = getIntAttribute( xml, 'numVariables', self.numVariables );
                self.percentChangePossible = getBoolAttribute( xml, "percentChangePossible", self.percentChangePossible )
                self.realOutputFileStartPos = getIntAttribute( xml, 'outputFileStartPos', self.realOutputFileStartPos );
                self.exceptions = getAttribute( xml, "exceptions", self.exceptions )
                self.output_index = getAttribute( xml, "output_index", self.output_index )

        def __repr__( self ):
                #display = %(display)s check = %(check)s min = %(min)f max = %(max)f prec = %(prec)d format = %(format)s match = %(match)s length = %(length)d asArray = %(asArray)d topset = %(topset)d order = %(order)s treatAsPercentage = %(treatAsPercentage)d sumsTo100 = %(sumsTo100)d macroVariableClass = %(macroVariableClass)s levelChangePossible = %(levelChangePossible)d isExogenous = %(isExogenous)d outputFileStartPos = %(outputFileStartPos)d numVariables = %(numVariables)d percentChangePossible = %(percentChangePossible)d realOutputFileStartPos = %(realOutputFileStartPos)d exceptions = %(exceptions)s output_index = %(output_index)d " %\
                s = " type = %(type)s uprate = %(uprate)s country = %(country)s lang = %(lang)s currencyCode = %(currencyCode)s next = %(next)f " %\
                { "type": self.xtype, "uprate": self.uprate, "country": self.country, "lang": self.lang, "currencyCode": self.currencyCode, "next": self.next, "display": self.display, "check": self.check, "min": self.min, "max": self.max, "prec": self.prec, "format": self.format, "match": self.match, "length": self.length, "asArray": self.asArray, "topset": self.topSet, "order": self.order, "treatAsPercentage": self.treatAsPercentage, "sumsTo100": self.sumsTo100, "macroVariableClass": self.macroVariableClass, "levelChangePossible": self.levelChangePossible, "isExogenous": self.isExogenous, "outputFileStartPos": self.outputFileStartPos, "numVariables": self.numVariables, "percentChangePossible": self.percentChangePossible, "realOutputFileStartPos": self.realOutputFileStartPos, "exceptions": self.exceptions, "output_index": self.output_index }
                return s;

class Parameter:
        
        def __init__( self ):
                self.name = ""
                self.instanceName = ""
                self.indexType = 'none' 
                self.units = "timeless"
                self.xtype = "real"
                self.logicalType = ""
                self.enumTypeRef = ""
                self.indexEnumTypeRef = ""
                self.indexSubsetRef = ""
                self.collectionType = "singular"
                self.collectionSize = 0
                self.editInfos = {}
                self.descriptions = Descriptions()
                
        def toXML( self, document ):
                paramElem = document.createElement( 'Parameter' );
                paramElem.setAttribute( "name", self.name )
                paramElem.setAttribute( "instanceName", self.instanceName )
                paramElem.setAttribute( "indexType", self.indexType )
                paramElem.setAttribute( "units", self.units )
                paramElem.setAttribute( "type", self.xtype )
                paramElem.setAttribute( "logicalType", self.logicalType )
                paramElem.setAttribute( "enumTypeRef", self.enumTypeRef )
                paramElem.setAttribute( "indexEnumTypeRef", self.indexEnumTypeRef )
                paramElem.setAttribute( "collectionType", self.collectionType )
                paramElem.setAttribute( "indexSubsetRef", self.indexSubsetRef );
                setIntAttribute( paramElem, 'collectionSize', self.collectionSize );
                
                for k in self.editInfos.keys():
                        paramElem.appendChild( self.editInfos[k].toXML( document ) ) 
                self.descriptions.toXML( document, paramElem );
                return paramElem;
                
        def __repr__( self ):                
                s = " name = %(name)s instanceName = %(instanceName)s indexType = %(indexType)s units = %(units)s xtype = %(xtype)s logicalType = %(logicalType)s enumTypeRef = %(enumTypeRef)s indexEnumTypeRef = %(indexEnumTypeRef)s collectionType = %(collectionType)s" %\
                      {"name": self.name, "instanceName": self.instanceName,"indexType": self.indexType,"units": self.units,"xtype": self.xtype,"logicalType": self.logicalType,"enumTypeRef": self.enumTypeRef,"indexEnumTypeRef": self.indexEnumTypeRef,"collectionType": self.collectionType }
                for k in self.editInfos.keys():
                        s += self.editInfos[k].__repr__()+"\n"
                s += self.descriptions.__repr__()+"\n"
                return s
               
        def fromXML( self, xml ):
                self.name = getAttribute( xml, "name", self.name )
                self.instanceName = getAttribute( xml, "instanceName", self.instanceName )
                if( self.instanceName == '' ) and ( self.name != '' ):
                        self.instanceName = self.name;
                if( self.name == '' ) and ( self.instanceName != '' ):
                        self.name = self.instanceName;
                        
                self.indexType = getAttribute( xml, "indexType", self.indexType )
                self.units = getAttribute( xml, "units", self.units )
                self.xtype = getAttribute( xml, "type", self.xtype )
                self.logicalType = getAttribute( xml, "logicalType", self.logicalType )
                self.enumTypeRef = getAttribute( xml, "enumTypeRef", self.enumTypeRef )
                self.indexEnumTypeRef = getAttribute( xml, "indexEnumTypeRef", self.indexEnumTypeRef )
                self.collectionType = getAttribute( xml, "collectionType", self.collectionType )
                self.collectionSize = getIntAttribute( xml, 'collectionSize', self.collectionSize )
                self.indexSubsetRef = getAttribute( xml, "indexSubsetRef", self.indexSubsetRef );
                for t in childrenOf( xml, "EditInfo"):
                        ev = EditInfo()
                        ev.fromXML( t )
                        self.editInfos[ ev.xtype ] = ev
                self.descriptions.fromXML( xml );
                
        def editInfo( self, which = 'default' ):
                if( not self.editInfos.has_key(which) ):
                        return self.editInfos[ 'default' ]
                return self.editInfos[ which ]     
                
        def description( self, lang=DEFAULT_LANGUAGE, xtype = 'description' ):
                return self.descriptions.description( lang, xtype )

class ParameterSystemReference:
        def __init__( self ):
                self.instanceName = ""
                self.indexType = "" 
                self.indexEnumTypeRef = ""
                self.indexSubsetRef = ""
                self.xtype = ''
                self.collectionSize = 0
                self.collectionType = ""
                self.descriptions = Descriptions()
                self.editInfos = {}
                
        def toXML( self, document ):
                refElem = document.createElement( 'ParameterSystemReference' );
                refElem.setAttribute( "instanceName", self.instanceName )
                refElem.setAttribute( "indexType", self.indexType )
                setIntAttribute( refElem, "collectionSize", self.collectionSize )
                refElem.setAttribute( "type", self.xtype )
                refElem.setAttribute( "indexEnumTypeRef", self.indexEnumTypeRef )
                refElem.setAttribute( "collectionType", self.collectionType )
                refElem.setAttribute( "indexSubsetRef", self.indexSubsetRef );
                for k in self.editInfos.keys():
                        refElem.appendChild( self.editInfos[k].toXML( document ) ) 
                self.descriptions.toXML( document, refElem );
                return refElem;
                
        def fromXML( self, xml ):
                self.instanceName = getAttribute( xml, "instanceName", self.instanceName )
                self.indexType = getAttribute( xml, "indexType", self.indexType ) 
                self.indexEnumTypeRef = getAttribute( xml, "indexEnumTypeRef", self.indexEnumTypeRef )
                self.indexSubsetRef = getAttribute( xml, "indexSubsetRef", self.indexSubsetRef );
                self.xtype = getAttribute( xml, "type", self.xtype )
                self.collectionSize = getIntAttribute( xml, "collectionSize", self.collectionSize )
                self.collectionType = getAttribute( xml, "collectionType", self.collectionType )
                self.descriptions.fromXML( xml );
                for t in childrenOf( xml, "EditInfo"):
                        ev = EditInfo()
                        ev.fromXML( t )
                        self.editInfos[ ev.xtype ] = ev
                
        def __repr__( self ):
                return "instanceName = %(instanceName)s indexType = %(indexType)s indexEnumTypeRef = %(indexEnumTypeRef)s xtype = %(xtype)s collectionSize = %(collectionSize)d collectionType = %(collectionType)s" % { "instanceName": self.instanceName, "indexType": self.indexType, "indexEnumTypeRef": self.indexEnumTypeRef, "xtype": self.xtype, "collectionSize": self.collectionSize, "collectionType": self.collectionType }

        def description( self, lang=DEFAULT_LANGUAGE, xtype = 'description' ):
                return self.descriptions.description( lang, xtype )
                
        def editInfo( self, which = 'default' ):
                if( not self.editInfos.has_key(which) ):
                        return self.editInfos[ 'default' ]
                return self.editInfos[ which ]     

class ParameterSystem:
        
        def __init__( self ):
                self.enabled = 1
                self.name = ''
                self.instanceName = ''
                self.id = ''
                self.logicalType = ''
                self.descriptions = Descriptions()
                self.parameters = {}
                self.parameterOrder = []
                self.editInfos = {}
                self.parameterSystems = {}
                self.parameterSystemsOrder = []
                self.parameterSystemReferences = {}
                self.parameterSystemReferencesOrder = []
                self.enumeratedTypes = {}
                
        def getEnumWithId( self, id ):
                for k in self.enumeratedTypes.keys():
                        if( self.enumeratedTypes[k].id == id ):
                                return self.enumeratedTypes[k]
                for k in self.parameterSystemsOrder:
                        enum = self.parameterSystems[k].getEnumWithId( id )
                        if( enum != None ):
                                return enum
                
        def getSystemWithName( self, name ):
                if( self.name == name ):
                        return self
                for k in self.parameterSystemsOrder:
                        if( self.parameterSystems[k].name == name ):
                                return self.parameterSystems[k]
                        sys = self.parameterSystems[k].getSystemWithName( name )
                        if( sys != None ):
                                return sys
                
        def toXMLDocument( self ):
                DOM = xml.dom.getDOMImplementation()
                    # now create the doctype and the document element
                doctype = DOM.createDocumentType('ParameterSystem', 'SYSTEM', 'http://www.virtual-worlds.biz/dtds/parameters2.dtd')
                # document = DOM.createDocument( None, 'ParameterSystem', doctype)
                document = DOM.createDocument( None, None, None ); 
                document.appendChild( self.toXML( document ) )
                return document
                
        def toXML( self, document ):
                systemElem = document.createElement( 'ParameterSystem' );
                systemElem.setAttribute( "instanceName", self.instanceName )
                systemElem.setAttribute( "name", self.name )
                systemElem.setAttribute( "id", self.id )
                systemElem.setAttribute( "logicalType", self.logicalType )
                setBoolAttribute( systemElem, "enabled", self.enabled )
                self.descriptions.toXML( document, systemElem );
                for k in self.parameterOrder:
                        systemElem.appendChild( self.parameters[k].toXML( document ) ) 
                for k in self.editInfos.keys():
                        systemElem.appendChild( self.editInfos[k].toXML( document ) ) 
                for k in self.parameterSystemsOrder:
                        systemElem.appendChild( self.parameterSystems[k].toXML( document ) ) 
                for k in self.parameterSystemReferencesOrder:
                        systemElem.appendChild( self.parameterSystemReferences[k].toXML( document ) ) 
                for k in self.enumeratedTypes.keys():
                        systemElem.appendChild( self.enumeratedTypes[k].toXML( document ) ) 
                return systemElem;

        def description( self, lang=DEFAULT_LANGUAGE, xtype = 'description' ):
                return self.descriptions.description( lang, xtype )

        def fromXML( self , xml ):
                self.name = getAttribute( xml, "name", self.name )
                self.instanceName = getAttribute( xml, "instanceName", self.instanceName )
                self.id = getAttribute( xml, "id", self.id )
                self.logicalType = getAttribute( xml, "logicalType", "" )
                self.enabled = getBoolAttribute( xml, "enabled", self.enabled )
                if( self.instanceName == '' ) and ( self.name != '' ):
                        self.instanceName = self.name;
                if( self.name == '' ) and ( self.instanceName != '' ):
                        self.name = self.instanceName;
                if( self.id == '' ) and ( self.instanceName != '' ):
                        self.id = self.instanceName;
                for t in childrenOf( xml, "Parameter"):
                        p = Parameter()
                        p.fromXML( t )
                        self.parameters[ p.name ] = p                        
                        self.parameterOrder.append( p.name );
                for t in childrenOf( xml, "ParameterSystem"):
                        p = ParameterSystem()
                        p.fromXML( t )
                        self.parameterSystems[ p.name ] = p                        
                        self.parameterSystemsOrder.append( p.name )
                for t in childrenOf( xml, "ParameterSystemReference"):
                        p = ParameterSystemReference()
                        p.fromXML( t )
                        self.parameterSystemReferences[ p.instanceName ] = p                        
                        self.parameterSystemReferencesOrder.append( p.instanceName )
                
                for t in childrenOf( xml, "EnumeratedType"):
                        p = EnumeratedType()
                        p.fromXML( t )
                        self.enumeratedTypes[ p.id ] = p
                        
                self.descriptions.fromXML( xml );
                
                for t in childrenOf( xml, "EditInfo"):
                        ev = EditInfo()
                        ev.fromXML( t )
                        self.editInfos[ ev.xtype ] = ev                        
                        
                        
        def __repr__( self ):
                s = "name = %(name)s instanceName = %(instanceName)s id = %(id)s enabled = %(enabled)d" %\
                    {"name": self.name,"instanceName": self.instanceName,"id": self.id,"enabled": self.enabled}                
                for k in self.enumeratedTypes.keys():
                        s += self.enumeratedTypes[k].__repr__()+"\n"
                for k in self.parameterSystemsOrder:
                        s += self.parameterSystems[k].__repr__()+"\n"
                for k in self.parameterSystemReferencesOrder:
                        s += self.parameterSystemReferences[k].__repr__()+"\n"
                for k in self.enumeratedTypes.keys():
                        s += self.enumeratedTypes[k].__repr__()+"\n"
                return s
                
        def editInfo( self, which = 'default' ):
                if( not self.editInfos.has_key(which) ):
                        return self.editInfos[ 'default' ]
                return self.editInfos[ which ]     

def parseParametersSchema( filename ):
        print "opening " + filename
        f = open( filename, 'r')
        xmlData = f.read() 
        print xmlData
        xmlData.encode( "utf-8" )
       
        xml = parseString( xmlData )
        s1 = firstChildOf( xml, 'ParameterSystem' )
        sys = ParameterSystem()
        sys.fromXML( s1 )
        return sys

class BasicVisitor:
        def operateOnSystemStart( self, completeSystem, currentSubsystem, depth ):
                print "operateOnSystemStart" + `depth`
                
        def operateOnSystemEnd( self, completeSystem, currentSubsystem, depth ):
                print "operateOnSystemEnd" + `depth`

        def operateOnSubsystemDeclaration( self, completeSystem, currentSubsystem, depth ):
                print "operateOnSubsystemDeclaration "
                
        def operateOnParameter( self, completeSystem, currentParameter, depth ):
                print "   operate_on_parameter" + `depth`

        def operateOnEditInfo( self, completeSystem, editInfo, depth ):
                print "   operate_on_edit_info" + `depth`
                
        def operateOnSystemReference( self, completeSystem, systemReference, subsystem, depth ):
                print "   operate_on_system_references" + `depth`

class NameVariants:
        def __init__( self ):
                self.z = ''                     

def iterate( completeSystem, currentSubsystem, visitor, depth ):
        depth += 1
        visitor.operateOnSystemStart( completeSystem, currentSubsystem, depth );
        for k in currentSubsystem.editInfos.keys():
                visitor.operateOnEditInfo( completeSystem, currentSubsystem.editInfos[k], depth ) 
        for k in currentSubsystem.parameterSystemsOrder:
                visitor.operateOnSubsystemDeclaration( completeSystem, currentSubsystem.parameterSystems[k], depth ) 
                iterate( completeSystem, currentSubsystem.parameterSystems[k], visitor, depth )  
        for k in currentSubsystem.parameterSystemReferencesOrder:
                ref = currentSubsystem.parameterSystemReferences[k]
                subsys = completeSystem.getSystemWithName( ref.xtype )  
                visitor.operateOnSystemReference( completeSystem, subsys, ref, depth )
        for k in currentSubsystem.parameterOrder:
                visitor.operateOnParameter( completeSystem, currentSubsystem.parameters[k], depth ) 
        visitor.operateOnSystemEnd( completeSystem, currentSubsystem, depth );
        
