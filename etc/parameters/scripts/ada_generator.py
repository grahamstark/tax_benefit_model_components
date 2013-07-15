from Cheetah.Template import Template
import datetime
from string import lower
from mpaths import WORKING_PATHS
from utils import INDENT, adafyName, Enum, makeCommentString
from parameters_model import ParameterSystem, Description, Text, EnumValue,\
     Descriptions, Parameter, ParameterSystemReference, EnumeratedType, EditInfo, iterate,\
     NameVariants, BasicVisitor


LogicalTypes = Enum().strs( 'rate share band allowance benefitAmount ageLimit expense capitalLimit incomeLimit povertyLine ratesAndBands' )
AdaTypes = Enum().strs( 'Rate Amount Counter_Type Integer Time Real Age_Limit Enum Boolean String One_Expense Rates_And_Bands' )
ParameterTypes = Enum().strs( 'real integer enumerated boolean string date decimal' )
Units = Enum().strs( 'timeless day week month year percent level counts' )

def adaTypeAndEdit( parameter ):
        """
        given one of my Parameter classes from parameter_model, return a map with
          'adaType': one of the AdaTypes enums listed above; and 
          'edit'   : an EditInfo class, possibly just the first one linked to the Parameter, or possibly a newly created one, if logical_type is set
        """
        adaType = AdaTypes.Real
        if( parameter.logicalType != '' ):
                ltype = LogicalTypes.match( parameter.logicalType )
                editInfo = EditInfo();
                editInfo.check = 'halt'
                if( ltype == LogicalTypes.rate ) or ( ltype == LogicalTypes.share ):
                        adaType = AdaTypes.Rate
                        editInfo.prec = 2
                        editInfo.length = 6
                        editInfo.treatAsPercentage = 1
                        editInfo.uprate = 'dont_uprate'
                        editInfo.min = 0.0
                        editInfo.max = 100.0
                elif ( ltype == LogicalTypes.band ) or ( ltype == LogicalTypes.allowance ) or ( ltype == LogicalTypes.capitalLimit ) or ( ltype == LogicalTypes.incomeLimit ):
                        adaType = AdaTypes.Amount
                        editInfo.prec = 2
                        editInfo.length = 12
                        editInfo.treatAsPercentage = 0
                        editInfo.uprate = 'rooker_wise'
                        editInfo.min = 0.0
                        editInfo.max = 10000000.0
                        if( ltype == LogicalTypes.band ) or ( ltype == LogicalTypes.capitalLimit ) or ( ltype == LogicalTypes.incomeLimit ):
                                editInfo.next = 100.0
                        elif( ltype == LogicalTypes.allowance ):
                                editInfo.next = 10.0
                elif ( ltype == LogicalTypes.benefitAmount ) or ( ltype == LogicalTypes.povertyLine ):
                        adaType = AdaTypes.Amount
                        editInfo.prec = 2
                        editInfo.length = 12
                        editInfo.treatAsPercentage = 0
                        editInfo.uprate = 'rooker_wise'
                        editInfo.min = 0.0
                        editInfo.max = 5000.0
                        editInfo.next = 1.0
                elif ( ltype == LogicalTypes.ageLimit ):
                        adaType = AdaTypes.Age_Limit
                        editInfo.prec = 0
                        editInfo.length = 6
                        editInfo.min = 0
                        editInfo.max = 140
                        editInfo.uprate = 'dont_uprate'
                elif( ltype == LogicalTypes.expense ):
                        adaType = AdaTypes.One_Expense
                        editInfo.prec = 2
                        editInfo.length = 12
                        editInfo.treatAsPercentage = 0
                        editInfo.uprate = 'rooker_wise'
                        editInfo.min = 0.0
                        editInfo.max = 10000000.0
                        editInfo.next = 10.0
                elif( ltype == LogicalTypes.ratesAndBands ):
                        adaType = AdaTypes.Rates_And_Bands
                        editInfo.prec = 2
                        editInfo.length = 12
                        editInfo.treatAsPercentage = 0
                        editInfo.uprate = 'rooker_wise'
                        editInfo.min = 0.0
                        editInfo.max = 10000000.0
                        editInfo.next = 10.0
                else:
                        print "unmatched " + ltype
        else:
                editInfo = parameter.editInfo()
                xtype = ParameterTypes.match( parameter.xtype ) 
                if( xtype == ParameterTypes.real ):
                        adaType = AdaTypes.Real
                elif ( xtype == ParameterTypes.integer ):
                        adaType = AdaTypes.Integer
                elif (xtype == ParameterTypes.enumerated ):
                        adaType = AdaTypes.Enum
                elif ( xtype == ParameterTypes.boolean ):
                        adaType = AdaTypes.Boolean
                elif ( xtype == ParameterTypes.string ):
                        adaType = AdaTypes.String
                elif ( xtype == ParameterTypes.date ):
                        adaType = AdaTypes.Time
                elif ( xtype == ParameterTypes.decimal ):
                        adaType = AdaTypes.Decimal
                elif ( xtype == ParameterTypes.decimal ):
                        adaType = AdaTypes.Decimal
                else:
                        print "unmatched " + xtype
        return { 'adaType': adaType, 'edit': editInfo }
        
def makeOneEnumAds( enumXML ):
        """
        given an EnumeratedType class from parameters_model, return a string modelling an ada enumerated type, and possibly some
        ranges for it, if the enumXML contains some Subset elements, and the headers for To_String and From_Value functions
        """
        template = Template( file=WORKING_PATHS.templatesPath+"enumerated_type.ads.tmpl" )
        enumName = adafyName( enumXML.name )
        template.etype = enumName 
        template.ranges = []
        e_members = []
        for v in enumXML.getValues():
                e_members.append( v.name )
        template.e_members = ', '.join( e_members )
        for s in enumXML.subsets.values():
                ran = "subtype "+adafyName( s.id ) + " is " +  enumName + " range " + s.start + " .. " + s.stop
                template.ranges.append( ran )
        return str(template)

def makeOneEnumAdb( enumXML ):
        """
        given an EnumeratedType class from parameters_model, return a string with bodies to map from the enum to a String, and to and from
        numbers to the enum
        """
        template = Template( file=WORKING_PATHS.templatesPath+"enumerated_type.adb.tmpl" )
        template.etype = adafyName( enumXML.name )
        template.enum_assignments = []
        template.string_assignments = []
        template.int_assignments = []
        p  = 0
        for v in enumXML.getValues():
                template.string_assignments.append( 'when %(enum)s => return "%(string)s"' % { 'enum': v.name, 'string': v.text()} )
                template.int_assignments.append( "when %(enum)s => return %(val)d" % { 'enum': v.name, 'val': v.value })
                if( p > 0 ):
                        template.enum_assignments.append( "when %(val)s => return %(enum)s" % { 'enum': v.name, 'val': v.value })
                else:
                        template.default_assignment = "return %(enum)s" % { 'enum': v.name };
                p += 1
        return str(template)
        
def addToEnumAds( sysXML ):
        """
        sysXML is a ParameterSystem from parameters_model
        loop round all the enums in the system and return a list of strings representing them in an Ada definition module file,
        along with headers from mapping functions for them
        """
        enums = []
        for k in sysXML.enumeratedTypes.keys():
                enums.append( makeOneEnumAds( sysXML.enumeratedTypes[k] ))
        for k in sysXML.parameterSystemsOrder: 
                enums += addToEnumAds( sysXML.parameterSystems[k] )
        return enums
                
def addToEnumAdb( sysXML ):
        """
        sysXML is a ParameterSystem from parameters_model
        loop round all the enums in the system and return a list of strings representing some mapping functions for them
        """
        enums = []
        for k in sysXML.enumeratedTypes.keys():
                enums.append( makeOneEnumAdb( sysXML.enumeratedTypes[k] ))
        for k in sysXML.parameterSystemsOrder: 
                enums += addToEnumAdb( sysXML.parameterSystems[k] )
        return enums
       
class AdaRecordGenerator( BasicVisitor ):
        
        def createVariableDeclaration( self, parameter, adaType, adaName, recordTemplate ):
                """
                Handles a single Parameter instance from parameters_model
                
                Does several things
                        adds an Ada variable definition to the .parameter_declarations list in recordTemplate 
                        if the variable is an array
                                if the index type is integer add a counter variable to the parameters in recordTemplate
                                and add constants and range declarations to the main adsTemplate.
                                
                                if it's an enum 
                        in both cases add an array declaration to the main template
                        
                        
                """
        
                counterDeclaration = None
                lcAdaName = lower( adaName )
                if( parameter.collectionType == 'list' ):
                        if( parameter.indexType == 'integer' ):
                                if( parameter.collectionSize > 0 ):
                                        constant = adaName +"_Size : constant := %(sz)d" % { 'sz': parameter.collectionSize }
                                        arange = adaName +"_Range is Positive range( 1 .. " + adaName +"_Size )";
                                        if( ( adaType == AdaTypes.Rate ) or ( adaType == AdaTypes.Amount ) or ( adaType == AdaTypes.Counter_Type ) or ( adaType == AdaTypes.Boolean )or ( adaType == AdaTypes.Integer )):
                                                arrayDeclaration = "subtype "+adaName+"_Array is "+ adaType + "_Array( " + adaName +"_Range )"
                                        else:
                                                arrayDeclaration = "type "+adaName+"_Array is array( " + adaName +"_Range ) of " +  adaType
                                        self.adsTemplate.constants.append( constant )
                                        self.adsTemplate.ranges.append( arange )
                                        self.adsTemplate.array_declarations.append( arrayDeclaration );
                                        parameterDeclaration = lcAdaName + " : " + adaName+"_Array"
                                        # add a counter variable. Hack .. 
                                        counterDeclaration = lcAdaName + "_counter : " + adaName + "_Range";
                                else:
                                        parameterDeclaration = lcAdaName + " : " + adaType + "_Array";                
                        elif( parameter.indexType == 'enumerated' ):
                                enumName = adafyName( parameter.indexEnumTypeRef )
                                package = enumName +"_Package"
                                if( parameter.indexSubsetRef == '' ):
                                        parameterDeclaration = lcAdaName + " : " + package +"."+adaType+"_Array";
                                else:
                                        subsetName = adafyName( parameter.indexSubsetRef )
                                        arrayName = enumName + "_" + subsetName + "_" + adaType+"_Array";
                                        parameterDeclaration = lcAdaName + " : " + arrayName                                                
                                        if( not (arrayName in self.createdArrays )): 
                                                self.createdArrays.append( arrayName )
                                                arrayDeclaration = "subtype "+arrayName+" is "+  package +".Abs_"+adaType+"_Array( " + subsetName + ")"
                                                self.adsTemplate.array_declarations.append( arrayDeclaration );
                elif (parameter.collectionType == 'set' ):                        
                        parameterDeclaration = lcAdaName + " : " + adafyName( parameter.enumTypeRef )+"_Set"
                else:
                        parameterDeclaration = lcAdaName + " : " + adaType
                if( counterDeclaration != None ):
                        recordTemplate.parameter_declarations.append( counterDeclaration )
                recordTemplate.parameter_declarations.append( parameterDeclaration )
                
        def createSystemReferenceDeclaration( self, subsystem, adaType, adaName, recordTemplate ):
                """
                Needs cleaned up!!
                """
                lcAdaName = lower( adaName )
                if( subsystem.collectionType == 'list' ):
                        if( subsystem.indexType == 'integer' ):
                                if( subsystem.collectionSize > 0 ):
                                        constant = adaName +"_Size : constant := %(sz)d" % { 'sz': subsystem.collectionSize }
                                        arange = adaName +"_Range is Integer range( 1 .. " + adaName +"_Size )";
                                        array = "type "+adaName+"_Array is array( " + adaName +"_Range ) of " +  adaType
                                        self.adsTemplate.constants.append( constant )
                                        self.adsTemplate.ranges.append( arange )
                                        self.adsTemplate.array_declarations.append( array );
                                        subsystemDeclaration = lcAdaName + " : " + adaName+"_Array"
                                else:
                                        subsystemDeclaration = lcAdaName + " : " + adaType + "_Array";                
                        elif( subsystem.indexType == 'enumerated' ):
                                enum = adafyName( subsystem.indexEnumTypeRef )
                                arrayName = adaType+"_"+enum+"_Array";
                                if( not (arrayName in self.createdArrays )): 
                                        genericArray = "type Abs_"+ arrayName+" is array( " + enum +" range <> ) of " +  adaType                                        
                                        self.createdArrays.append( arrayName )
                                        self.adsTemplate.array_declarations.append( genericArray );
                                        allVarsArray = "subtype "+ arrayName+" is Abs_" + arrayName + "( " + enum +" )"
                                        self.adsTemplate.array_declarations.append( allVarsArray );
                                        subsystemDeclaration = lcAdaName + " : " + arrayName;
                                if(  subsystem.indexSubsetRef != '' ):
                                        adaRef = adafyName( subsystem.indexSubsetRef )
                                        qualifiedArrayName =  adaType+"_"+enum+"_" + adaRef + "_Array";
                                        rangeArray = "subtype "+ qualifiedArrayName+" is Abs_" + arrayName + "( " + adaRef +" )"
                                        if( not ( qualifiedArrayName in self.createdArrays )):
                                                self.createdArrays.append( qualifiedArrayName )
                                                self.adsTemplate.array_declarations.append( rangeArray );
                                                subsystemDeclaration = lcAdaName + " : " + qualifiedArrayName;
                                
                elif (subsystem.collectionType == 'set' ):                        
                        subsystemDeclaration = lcAdaName + " : " + adafyName( subsystem.enumTypeRef )+"_Set"
                else:
                        subsystemDeclaration = lcAdaName + " : " + adaType
                recordTemplate.record_declarations.append( subsystemDeclaration );
                
        def createSystemDeclaration( self, subsystem, adaType, adaName ):
                lcAdaName = lower( adaName )
                subsystemDeclaration = lcAdaName + " : " + adaType
                return subsystemDeclaration
                
        def operateOnSystemStart( self, completeSystem, currentSubsystem, depth ):
                if( depth == 1 ):
                        self.enumsAdsTemplate.enums = addToEnumAds( completeSystem )
                        self.adsTemplate.packageName = completeSystem.name;
                        self.enumsAdbTemplate.enums = addToEnumAdb( completeSystem )
                        self.adbTemplate.packageName = completeSystem.name;
                        self.systemName = lower( completeSystem.name )                        
                recordTemplate = Template( file=WORKING_PATHS.templatesPath+"record_declaration.ads.tmpl" )                                        
                recordTemplate.parameter_declarations = []
                recordTemplate.record_declarations = []
                recordTemplate.rtype = adafyName( currentSubsystem.name )
                recordTemplate.description = makeCommentString( 1, currentSubsystem.description(), 99999 )
                self.recordTemplates.append( recordTemplate )

        def operateOnSubsystemDeclaration( self, completeSystem, subsystem, depth ):
                xtype = adafyName( subsystem.name )
                adaName = adafyName( subsystem.instanceName )
                decl = self.createSystemDeclaration( subsystem, xtype, adaName )
                p = len(self.recordTemplates)-1
                self.recordTemplates[ p ].record_declarations.append( decl );
                
        def operateOnSystemReference( self, completeSystem, subsystem, systemReference, depth ):
                xtype = adafyName( subsystem.name )
                adaName = adafyName( systemReference.instanceName )
                p = len(self.recordTemplates)-1
                self.createSystemReferenceDeclaration( systemReference, xtype, adaName, self.recordTemplates[ p ] )
                
             
        def operateOnSystemEnd( self, completeSystem, currentSubsystem, depth ):
                recordTemplate = self.recordTemplates.pop()
                recstr = str( recordTemplate )
                self.adsTemplate.record_declarations.append( recstr ) 
   
        def operateOnParameter(  self, completeSystem, parameter, depth ):
                typeAndEdit = adaTypeAndEdit( parameter )
                adaType = typeAndEdit['adaType']
                adaName = adafyName( parameter.instanceName )
                p = len(self.recordTemplates)-1
                self.createVariableDeclaration( parameter, adaType, adaName, self.recordTemplates[p] )
                
        def __init__( self ):
                self.adsTemplate = Template( file=WORKING_PATHS.templatesPath+"parameters.ads.tmpl" )
                self.adbTemplate = Template( file=WORKING_PATHS.templatesPath+"parameters.adb.tmpl" )
                self.enumsAdbTemplate = Template( file=WORKING_PATHS.templatesPath+"enums.adb.tmpl" )
                self.enumsAdsTemplate = Template( file=WORKING_PATHS.templatesPath+"enums.ads.tmpl" )
                self.recordTemplates = [] #Template( file=WORKING_PATHS.templatesPath+"record_declaration.ads.tmpl" )
                self.adsTemplate.record_declarations = []
                self.adsTemplate.constants = []
                self.adsTemplate.array_declarations = []
                self.adsTemplate.ranges = []
                self.createdArrays = [] ## list to aviod duplicated array declarations
                self.systemName = ''
        
        def writeAds( self ):
                self.adsTemplate.date = datetime.datetime.now()
                outfile = file( WORKING_PATHS.srcDir + "model-parameters-" + self.systemName +".ads", 'w' );
                outfile.write( str(self.adsTemplate) )
                outfile.close()              
                
        def writeAdb( self ):
                self.adbTemplate.date = datetime.datetime.now()
                outfile = file( WORKING_PATHS.srcDir + "model-parameters-" + self.systemName +".adb", 'w' );
                outfile.write( str(self.adbTemplate) )
                outfile.close()              
                
        def writeEnumsAds( self ):
                self.enumsAdsTemplate.date = datetime.datetime.now()
                outfile = file( WORKING_PATHS.srcDir + "model-enums.ads", 'w' );
                outfile.write( str(self.enumsAdsTemplate) )
                outfile.close()              
                
        def writeEnumsAdb( self ):
                self.enumsAdbTemplate.date = datetime.datetime.now()
                outfile = file( WORKING_PATHS.srcDir + "model-enums.adb", 'w' );
                outfile.write( str(self.enumsAdbTemplate) )
                outfile.close()              
                                
