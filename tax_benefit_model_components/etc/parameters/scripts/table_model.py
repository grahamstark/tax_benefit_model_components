# ////////////////////////////////
#
# copyrigh(c) 2007 Graham Stark (graham.stark@virtual-worlds.biz)
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
# 
# It is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this software; see the file docs/gpl_v3.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 
# /////////////////////////////
# 
# $Revision: 7751 $
# $Author: graham_s $
# $Date: 2009-07-23 07:29:40 +0100 (Thu, 23 Jul 2009) $
#
from string import upper
import re
from string import capwords
from xml.dom.minidom import parse

from XMLUtils import getAttribute

from paths import WORKING_PATHS

#
# this just tries to cover everything that's specific to 
#
class DatabaseAdapter:
        """
        Container for database - specific things like support for unicode, formats for timestamps
        """
        def __init__( self, doesUnicode, timestampDefault, tablePostText ):
                self.doesUnicode = doesUnicode;
                self.timestampDefault = timestampDefault
                self.tablePostText = tablePostText
                # next 2 not really needed as we can't handle blobs and clobs in 
                # odbc/ada anyway.
                self.longCharType = 'CLOB'
                self.longBinaryType = 'BLOB'
                self.databasePreamble = ''
                self.databasePostText = ''
                self.safeVariableNameLength = 60
                if( doesUnicode ):
                        self.supportedSqlCharType = 'SQL_C_WCHAR'
                else:
                        self.supportedSqlCharType = 'SQL_C_CHAR'

def getDatabaseAdapter( dataSource ):
        
        if( dataSource.databaseType == 'postgres' ):
                adapter = DatabaseAdapter( 0, "TIMESTAMP '1901-01-01 00:00:00.000000'", '' );
                adapter.databasePreamble += 'drop database if exists ' + dataSource.database+";\n"
                adapter.databasePreamble += "create database "+ dataSource.database +" with encoding 'UTF-8';\n\n"
                adapter.databasePreamble += "\c "+dataSource.database+";\n"
        elif( dataSource.databaseType == 'mysql' ):
                adapter = DatabaseAdapter( 0, "TIMESTAMP '0000-00-00 00:00:00.000000'", " type = InnoDB" );
                adapter.longBinaryType = 'LONGTEXT' 
                adapter.longCharType = 'LONGTEXT'
                
                adapter.databasePreamble += 'drop database if exists ' + dataSource.database+";\n"
                adapter.databasePreamble += "SET NAMES utf8;\n";
                adapter.databasePreamble += "create database "+ dataSource.database +" default charset=utf8;\n\n"
                adapter.databasePreamble += "use "+ dataSource.database + ";\n";
                adapter.databasePreamble += "SET FOREIGN_KEY_CHECKS = 0;"
                adapter.databasePostText += "SET FOREIGN_KEY_CHECKS = 1;\n"
                
        elif( dataSource.databaseType == 'db2' ):  ## note that DB2 does actually support unicode, but this version jams it off everywhere.
                adapter = DatabaseAdapter( 0, "'1901-01-01 00:00:00.000000'", '' );
                adapter.safeVariableNameLength = 18
                adapter.databasePreamble += "-- Disconnect from any existing database connection\n"
                adapter.databasePreamble += "CONNECT RESET;\n"
                adapter.databasePreamble += "DROP DATABASE " + dataSource.database+";\n"
                adapter.databasePreamble += "CREATE DATABASE " + dataSource.database + " USING CODESET UTF-8 TERRITORY UK;\n" 
                adapter.databasePreamble += "CONNECT TO "  + dataSource.database +";\n"
                
        elif( dataSource.databaseType == 'firebird' ):
                adapter = DatabaseAdapter( 0, "TIMESTAMP '1901-01-01 00:00:00'", '' );
                adapter.databasePreamble += "CREATE DATABASE '%(db)s.fdb' page_size 8192 user '%(user)s' password '%(pass)s' DEFAULT CHARACTER SET UTF8;" % { 'db' : dataSource.database, 'pass' : dataSource.password, 'user' : dataSource.username }
                adapter.databasePreamble += "CONNECT '%(db)s.fdb' user %(user)s password %(pass)s;" % { 'db' : dataSource.database, 'pass' : dataSource.password, 'user' : dataSource.username }
        return adapter

# fred_joe => Fred_Joe        
def adafyName( name ):
        return capwords( name, '_' ).replace( ' ', '_' )
 
def makePlural( w ):
        if( not w.endswith('s') ):
                w += 's'
        return w

## Supported types:
## CHAR VARCHAR (both mapped to varchar) DECIMAL REAL INTEGER DOUBLE BOOLEAN ENUM

def makeAdaDecimalTypeName( length, prec ):
        return 'Decimal_%(len)d_%(prec)d' % { 'len' : int(length), 'prec': int(prec) }                


        
def getDefaultSize( schemaType, size ):
        if( size != None ):
                return size
        return 1

def notNoneOrBlank( s ):
        return not ((s == None) or ( s == '' ))

def valIfNotNoneOrBlank( s, default ):
        if( notNoneOrBlank( s )):
                return s;
        return default;


class Variable:
        
        def getODBCType( self, databaseAdapter ):
                odbcType = self.schemaType.lower()
                if self.schemaType == 'DECIMAL' :
                        odbcType = 'Real' ## ocbc can handle extracting decimal cols as reals, which we can then cast into decimals
                elif self.schemaType == 'REAL' or self.schemaType == 'DOUBLE' or self.schemaType == 'FLOAT':
                        odbcType = 'Real'
                elif self.schemaType == 'CHAR' or self.schemaType == 'VARCHAR':
                        if databaseAdapter.doesUnicode :
                                odbcType = 'Wide_String';
                        else:
                                odbcType = 'String';
                elif ( self.isDateType() ):                                
                        odbcType = 'SQL_TIMESTAMP_STRUCT' 
                elif self.schemaType == 'ENUM' or self.schemaType == 'BOOLEAN' :
                        odbcType = 'Integer'
                return odbcType

        def getSQLType( self, databaseAdapter ):
                if( self.isFloatingPointType() ):
                        sqlType = 'DOUBLE PRECISION'
                elif( self.schemaType == 'CHAR' or self.schemaType == 'VARCHAR' ):
                        sqlType = 'VARCHAR('+self.size+')'
                elif self.schemaType == 'DECIMAL' :
                        sqlType = 'DECIMAL(' + self.size+', '+ self.scale + ')'
                elif self.schemaType == 'BOOLEAN' or self.schemaType == 'ENUM' :
                        sqlType = 'INTEGER'
                elif self.schemaType == 'CLOB':
                        sqlType = databaseAdapter.longCharType
                elif self.schemaType == 'BLOB':
                        sqlType = databaseAdapter.longBinaryType
                elif self.isDateType():
                        sqlType = 'TIMESTAMP'
                else:
                        sqlType = self.schemaType;
                return sqlType

        def getAdaType( self ):
                adaType = self.schemaType.lower()
                if self.schemaType == 'DECIMAL' :
                        adaType = makeAdaDecimalTypeName( self.size, self.scale )
                elif self.schemaType == 'REAL' or self.schemaType == 'DOUBLE' or self.schemaType == 'FLOAT':
                        adaType = 'Real'
                elif self.schemaType == 'CHAR' or self.schemaType == 'VARCHAR':
                        adaType = 'Unbounded_String';
                elif ( self.isDateType() ):                                
                        adaType = 'Ada.Calendar.Time' 
                elif self.schemaType == 'ENUM':
                        adaType = self.varname+"_Enum"
                return adaType

        

        # always as a String
        def getDefaultAdaValue( self ):
                default = 'FIXME';
                if( self.isPrimaryKey ):
                        if( self.schemaType == 'CHAR') or (self.schemaType == 'VARCHAR'):
                                ## fixme maybe string instead?
                                default = 'MISSING_W_KEY'
                        elif self.schemaType == 'INTEGER' :
                                default = 'MISSING_I_KEY'
                        elif self.isRealOrDecimalType() :
                                default = 'MISSING_R_KEY'
                        elif self.isDateType() :
                                default = 'MISSING_T_KEY'
                                
                else:
                        if( self.schemaType == 'CHAR') or (self.schemaType == 'VARCHAR'):
                                default = 'Ada.Strings.Unbounded.Null_Unbounded_String'
                        elif (self.schemaType == 'DECIMAL') or (self.schemaType == 'REAL') or (self.schemaType == 'DOUBLE'):
                                default = valIfNotNoneOrBlank( self.default, '0.0' )
                                if( not re.match( '[0-9]+\.[0-9]+', default ) ):
                                        default += ".0"
                        elif (self.schemaType == 'BOOLEAN'): 
                                if( int(self.default) == 1 ):
                                        default = 'true'
                                else:
                                        default = 'false'
                        elif (self.schemaType == 'ENUM'):
                                if( notNoneOrBlank( self.default ) ):
                                        default = self.values[ int( self.default ) ]
                                else:
                                        default = self.values[0]
                                        
                        elif (self.schemaType == 'INTEGER') :
                                default = valIfNotNoneOrBlank( self.default, '0' )
                        elif ( self.isDateType() ):                                
                                default = 'FIRST_DATE' 
                        else:
                                default = "'FIXME'";
                return default;        
        
        def getDefaultSQLValue( self, databaseAdapter ):
                if( self.default != None ) and ( self.default != '') and ( not self.isDateType()):
                        return self.default
                if( self.schemaType == 'CHAR') or (self.schemaType == 'VARCHAR'):
                        default = ''
                elif (self.schemaType == 'DECIMAL') or (self.schemaType == 'REAL') or (self.schemaType == 'DOUBLE'):
                        default = '0.0'
                elif (self.schemaType == 'BOOLEAN') or (self.schemaType == 'ENUM') or (self.schemaType == 'INTEGER') :
                        default = '0'
                elif ( self.isDateType() ):
                        default = databaseAdapter.timestampDefault
                else:
                        default = "''";
                return default
        
        def isRealOrDecimalType( self ):
                return ( self.schemaType == 'DECIMAL' ) or ( self.schemaType == 'REAL' ) or (self.schemaType == 'DOUBLE')
                
        def isDecimalType( self ):
                return ( self.schemaType == 'DECIMAL' ) 
        
        def isFloatingPointType( self ):
                return ( self.schemaType == 'REAL' ) or (self.schemaType == 'DOUBLE')   
      
        def isNumericType( self ):
                return ( self.schemaType == 'DECIMAL' ) or ( self.schemaType == 'INTEGER' ) or ( self.schemaType == 'REAL' ) or (self.schemaType == 'DOUBLE')   

        def isIntegerType( self ):
                return ( self.schemaType == 'INTEGER' )   
        
        def isIntegerTypeInODBC( self ):
                return ( self.schemaType == 'INTEGER' ) or ( self.schemaType == 'BOOLEAN' ) or ( self.schemaType == 'ENUM' )
        
        def isStringType( self ):
                return (self.schemaType == 'CHAR') or (self.schemaType == 'VARCHAR'); 
        
        def isDateType( self ):
                return (self.schemaType == 'TIMESTAMP') or (self.schemaType == 'TIME') or (self.schemaType == 'DATE')
        
        def __init__( self, databaseAdapter, varname, schemaType, default, size, scale, description, autoIncrement, notNull, isPrimaryKey ):
                self.varname = varname;
                self.adaName = adafyName( varname )
                self.schemaType = upper( schemaType)
                self.default = default
                self.size = getDefaultSize( schemaType, size )                
                self.scale = scale
                self.description = description
                self.autoIncrement = autoIncrement
                self.adaType = self.getAdaType();
                self.sqlType = self.getSQLType( databaseAdapter );
                self.odbcType = self.getODBCType( databaseAdapter )
                self.notNull = notNull
                self.isPrimaryKey = isPrimaryKey
                if( self.schemaType == 'ENUM' ):
                        self.values = []
                
        def __repr__( self ):
                return "varname |%(varname)s| schemaType |%(schemaType)s| default |%(def)s| size |%(size)s| " % \
                        { 'varname': self.varname, 'schemaType' : self.sqlType, 'def' : self.default,
                          'size': self.size }

class DataSource:
        def __init__( self, id, databaseType, hostname, database, username, password ):
                self.id = id
                self.databaseType = databaseType
                self.hostname = hostname
                self.database = database
                self.username = username
                self.password = password                

        def __repr__( self ):
                return " id %(id)s databaseType %(databaseType)s hostname %(hostname)s, database %(database)s username %(username)s password %(password)s " % \
                       { 'id' : self.id, 'databaseType' : self.databaseType, 'hostname' : self.hostname, 'database' : self.database, 'username' : self.username, 'password': self.password }

class Table:
        def __init__( self, name, description ):
                self.variables = []
                self.primaryKey = []
                self.foreignKeys = []
                self.uniqueIndexes = []
                self.indexes = []
                self.name = name
                self.adaName = adafyName( name )
                self.adaNullName = 'Null_' + self.adaName 
                self.adaIOPackageName = adafyName( name+"_IO" );
                self.adaContainerName = self.adaName+"_List"
                self.adaListName = self.adaName+"_List.Vector"                
                self.decimalTypes = {}
                self.enumeratedTypes = {}
                self.description = description
                self.childRelations = {}
                
        def fixupNames( self, dataPackageName ):
                self.adaQualifiedOutputRecord = dataPackageName + "." + self.adaName
                self.adaQualifiedListName = dataPackageName+"."+self.adaListName
                self.adaQualifiedNullName = dataPackageName+"."+self.adaNullName
                self.adaQualifiedContainerName = dataPackageName+"."+self.adaContainerName

        def addChildRelation( self, fk, name ):
                self.childRelations[ name ] = fk
                
        def __repr__( self ):
                s = "table name %(name)s\n" % { 'name' : self.name }
                s += "variables \n";
                for var in self.variables:
                        s += "   %(var)s\n" % {'var' : var }
                s += "foreign keys \n";
                for k in self.foreignKeys:
                        s += "   %(k)s\n" % {'k' : k }
                s += "child relations \n";
                for k in self.childRelations:
                        s += "   %(k)s\n" % {'k' : k }
                s += "primary key\n";                
                for k in self.primaryKey:
                        s += "   %(k)s\n" % {'k' : k }
                        
                for d in self.decimalTypes:
                        s += "%(d)s\n" % { 'd' : d }
                return s;
                
        def hasPrimaryKey( self ):
                return len( self.primaryKey ) > 0;
                
        def hasForeignKeys( self ):
                return len( self.foreignKeys ) > 0;

        def hasUniqueIndexes( self ):
                return len( self.uniqueIndexes ) > 0;
                
        def hasIndexes( self ):
                return len( self.indexes ) > 0;
        
        def addVariable( self, varClass, isPrimary ):
                self.variables.append( varClass );
                if( varClass.schemaType == 'DECIMAL' ):
                        dtype = DecimalType( varClass.size, varClass.scale );
                        self.decimalTypes[ dtype.ada_name ] = dtype
                elif( varClass.schemaType == 'ENUM' ):
                        etype = EnumeratedType( varClass.varname, varClass.values )
                        self.enumeratedTypes[ varClass.varname ] = etype
                        ## fixme: short version only
                        
                if( isPrimary ):
                        self.primaryKey.append( varClass.varname )
                        
        def addForeignKey( self, key ):
                self.foreignKeys.append( key )
                key.isOneToOne = ( key.hasSameElementsAs( self.primaryKey ))
                
        def addIndex( self, index ):
                self.indexes.append( index )
                
        def addUniqueIndex( self, index ):                
                self.uniqueIndexes.append( index )
                
                
class ForeignKey:
        
        def hasSameElementsAs( self, pk ):
                if( pk == None ):
                        return False
                return set(self.localCols) == set( pk )
                
        def __init__( self, referencingTable, onDelete ):
                self.referencingTable = referencingTable
                self.onDelete = onDelete
                self.localCols = []
                self.foreignCols = []
                self.isOneToOne = False
        
        def addReference( self, localName, foreignName ):
                self.localCols.append(localName)
                self.foreignCols.append(foreignName)
                
        def __repr__( self ):
                s = "foreign key referencing table %(reftable)s onDelete %(onDelete)s " % { 'reftable' : self.referencingTable, 'onDelete' : self.onDelete }
                return s;
                
class Index:
        def __init__( self ):
                self.columns = []
                
class Unique:
        def __init__( self ):
                self.columns = []

class DecimalType:
        def __init__( self, length, prec ):
                self.length = int(length)
                self.prec = int(prec)
                self.delta = 1.0/(10**self.prec)
                self.ada_name = makeAdaDecimalTypeName( self.length, self.prec ) 
        
        def toAdaString( self ):
                return "type %(ada_name)s is delta %(delta)f digits %(digits)d" %\
                        { 'ada_name': self.ada_name, 'digits':self.length, 'delta': self.delta }
        
        def __repr__( self ):
                return "ada_name %(ada_name)s prec %(prec)d length %(length)d delta %(delta)f" %\
                        { 'ada_name': self.ada_name, 'prec':self.prec, 'length':self.length, 'delta': self.delta }   
     
class EnumeratedType:
        
        def __init__( self, name, values = None ):
                self.name = name
                self.values = []
                if( values != None ):
                        for value in values:
                                self.addValue( value )
           
        def toAdaString( self ):
                valueNames = []
                for v in self.values:
                        valueNames.append( v.value );
                valStr = ", ".join( valueNames );
                return "type "+self.name+"_Enum is ( " + valStr + " ) "; 
           
        def addValue( self, value, number = None, string = None ):
                if number == None:
                        number = len( self.values )
                if( string == None ):
                        string = value
                self.values.append( EnumeratedValue( value, number, string ))
                
                
class EnumeratedValue:
        def __init__( self, value, number, string ):
                self.value = value
                self.number = number
                self.string = string
     
class Database:
        def __init__( self, dataSource ):
                self.tables = []
                self.dataSource = dataSource;
                self.decimalTypes = {}
                self.enumeratedTypes = {}
                self.tableLocations = {}
                self.adaDataPackageName = adafyName( self.dataSource.database )+"_Data"; 
                self.description = ''
                self.databaseAdapter = getDatabaseAdapter( self.dataSource )
                
        def addTable( self, table ):
                self.tables.append( table )
                self.tableLocations[ table.name ] = len( self.tables )-1 
                self.decimalTypes.update( table.decimalTypes );
                self.enumeratedTypes.update( table.enumeratedTypes );
                        
                
        def fixUpForeignKeys( self ):
                for tab in self.tables:
                        for fk in tab.foreignKeys:
                                targetTable = self.tables[ self.tableLocations[ fk.referencingTable ] ]
                                targetTable.addChildRelation( fk, tab.name )
                
        def __repr__( self ):
                s = "============ DATASOURCE ==============\n";
                s += "%(ds)s " % { 'ds' : self.dataSource }
                s += "============ TABLES ==============\n";
                for t in self.tables:
                        s += "%(t)s\n" % { 't' : t }
                s += "============ DECIMALS ==============\n";
                for d in self.decimalTypes:
                        s += "%(d)s\n" % { 'd' : d }
                        
                return s
                
#
# I don't understand this xml dom model at all...
# this is one way that works to get text out of a node
#
def getText(node):
    rc = ""
    if( node.hasChildNodes() ):
        text = node.childNodes[0].data
        rc = rc + text # node.data
    return rc

def parseRuntimeSchema( xRuntime ):
        datasource = xRuntime.getElementsByTagName("datasources")[0]
        databaseType = getText(datasource.getElementsByTagName("adapter")[0])
        connection = datasource.getElementsByTagName("connection")[0]
        hostname = getText(connection.getElementsByTagName( 'hostspec' )[0])
        username = getText( connection.getElementsByTagName( 'username' )[0] )
        password = getText(connection.getElementsByTagName( 'password' )[0])
        database = getText(connection.getElementsByTagName( 'database' )[0])
        did = datasource.getAttribute("id")        
        return DataSource( did, databaseType, hostname, database, username, password )

def makeForeignKey( xfk ):
        referencingTable = xfk.getAttribute( 'foreignTable' )
        onDelete = xfk.getAttribute( 'onDelete' )
        if( onDelete == None ):
                onDelete = 'cascade'
        fk = ForeignKey( referencingTable, onDelete )
        references = xfk.getElementsByTagName("reference")
        for reference in references:
                fk.addReference( reference.getAttribute( 'local' ),
                                 reference.getAttribute( 'foreign' ) );
        return fk


def parseTable( xtable, databaseAdapter ):
        name = xtable.getAttribute( 'name' )
        description = xtable.getAttribute( 'description' )
        stable = Table( name, description )
        columns = xtable.getElementsByTagName("column")
        for column in columns:
                varname = column.getAttribute( 'name' )
                stype = column.getAttribute( 'type' )
                size = getAttribute( column, 'size', 1 );
                default = column.getAttribute( 'default' )
                isPrimary = column.getAttribute( 'primaryKey' ) == 'true'
                notNull = column.getAttribute( 'required' ) == 'true' or ( isPrimary )
                autoIncrement = getAttribute( column, 'autoIncrement', 0 );
                description = getAttribute( column, 'description', '' );
                scale = getAttribute( column, 'scale', '' );
                var = Variable( 
                        databaseAdapter,
                        varname,
                        stype,
                        default,
                        size,
                        scale,
                        description,
                        autoIncrement,
                        notNull,
                        isPrimary
                )
                if( stype == 'ENUM' ):
                        valuesStr = column.getAttribute( 'values' )
                        var.values = valuesStr.split()
                
                stable.addVariable( var, isPrimary )
        foreignKeys = xtable.getElementsByTagName("foreign-key")
        for fk in foreignKeys:
                stable.addForeignKey( makeForeignKey( fk ) )
        uniqueIndexes = xtable.getElementsByTagName("unique")
        for ui in uniqueIndexes:
                stable.addUniqueIndex( makeUniqueIndex(ui) )
        indexes = xtable.getElementsByTagName("index")
        for i in indexes:
                stable.addIndex( makeIndex(i) )
                
        return stable;


def makeUniqueIndex( xindex ):
        ind = Unique()
        cols = xindex.getElementsByTagName("unique-column")
        for col in cols:
                ind.columns.append( col.getAttribute( 'name' ))
        return ind;
        
def makeIndex( xindex ):
        ind = Unique()
        cols = xindex.getElementsByTagName("index-column")
        for col in cols:
                ind.columns.append( col.getAttribute( 'name' ))
        return ind;

def parseXMLFiles():
        runtimeSchema = parse( WORKING_PATHS.xmlDir+'runtime-conf.xml' )
        runtime = parseRuntimeSchema( runtimeSchema )
        database = Database( runtime );
        tablesSchema = parse( WORKING_PATHS.xmlDir+'database-schema.xml')
        tables = tablesSchema.getElementsByTagName("table")
        for table in tables:
                stable = parseTable( table, database.databaseAdapter )
                stable.fixupNames( database.adaDataPackageName )
                database.addTable( stable )
        database.fixUpForeignKeys()
        return database;
