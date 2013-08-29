require 'rexml/document'
require 'rexml/element'
require 'dbi'
require 'csv'
require 'frs_schema_utils'

def makePKCol( name )
        column = REXML::Element.new( "column" )
        column.add_attribute( 'primaryKey', 'true' );
        column.add_attribute( 'default', 0 );
        column.add_attribute( 'type', "INTEGER" );
        column.add_attribute( 'name', name )
        return column;
end

def makeFKRef( target )
        fk = REXML::Element.new( "reference" )
        fk.add_attribute( "foreign", target )
        fk.add_attribute( "local", target );
        return fk
end

def makeFK( target )
        fk = REXML::Element.new( "foreign-key" )
        fk.add_attribute( 'foreignTable', target );        
        fk << makeFKRef( "year")
        fk << makeFKRef( "user_id")
        fk << makeFKRef( "edition")
        fk << makeFKRef( "sernum")
        if( target == 'adult' or target == 'benunit' )then
                fk << makeFKRef( "benunit" )
        end
        if( target == 'adult' )then
                fk << makeFKRef( "person" )
        end
        return fk
end

def createMillTable( tableData )
        tableName = tableData.tableName.downcase()
        tableElem = REXML::Element.new( 'table' );
        tableElem.add_attribute( 'name', tableName );
        tableElem.add_attribute( 'description', tableName )
        tableElem << makePKCol( 'year' )
        tableElem << makePKCol( 'user_id' )
        tableElem << makePKCol( 'edition' )
        puts "tableName #{tableName}\n"
        puts "needed is #{TABLES_THAT_NEED_COUNTERS.join( "|")}\n"
        if( TABLES_THAT_NEED_COUNTERS.include?( tableName ))then
                puts "needs a counter\n"
                tableElem << makePKCol( 'counter' )                
        end
        hasADFK = false  
        hasBUFK = false
        tableData.variableNames.each{
                |vname|
                var = tableData.variables[vname]
                column = REXML::Element.new( "column" )
                column.add_attribute( "description", var.label )
                if( var.adaType == 'Integer' ) then
                        sqlVar = 'INTEGER'
                        default = '0'
                elsif ( var.adaType == 'Real' ) then
                        sqlVar = 'REAL'
                        default = '0'
                elsif( var.adaType == 'Sernum_Value' ) then
                        sqlVar = 'BIGINT'
                        column.add_attribute( 'adaTypeName', 'Sernum_Value' );
                        default = '0'
                        column.add_attribute( 'default', '0' );
                elsif( var.adaType == 'Ada.Calendar.Time' ) then
                        sqlVar = 'DATE'
                end
                vcu = vname.upcase()
                isPK = ( vcu == 'SERNUM' or 
                       vcu == 'BENUNIT' or 
                       vcu == 'PERSON' or
                       # vcu == 'ISSUE' or 
                       vcu == 'VEHSEQ' or 
                       vcu == 'RENTSEQ' or
                       vcu == 'PENSEQ' or
                       vcu == 'PROVSEQ' or
                       vcu == 'BENEFIT' or
                       # (tableData.tableName == 'OWNER' and vcu == 'ISSUE' ) or
                       (tableData.tableName == 'ASSETS' and vcu == 'ASSETYPE' ) or                       
                       vcu == 'ODDSEQ' or 
                       vcu == 'MORTSEQ' or 
                       vcu == 'CONTSEQ' or 
                       vcu == 'MAINTSEQ' or
                       vcu == 'JOBTYPE' or
                       vcu == 'EXTSEQ' or
                       vcu == 'MORTSEQ' or
                       vcu == 'ENDOWSEQ' or 
                       vcu == 'SEQ' or
                       vcu == 'INSSEQ' or
                       vcu == 'ACCOUNT' or
                       vcu == 'CHLOOK' ) 
                if( isPK )
                        column.add_attribute( 'primaryKey', 'true' );
                end
                # column.add_attribute( 'default', default );
                column.add_attribute( 'type', sqlVar );
                column.add_attribute( 'name', vname.downcase() )
                tableElem << column
                if( vcu == 'BENUNIT' and ( tableName != 'benunit' and tableName != 'hbai' ) then
                        hasBUFK = true
                end
                if( vcu == 'PERSON' and 
                        ( tableName != 'adult' and tableName != 'child' and 
                                tableName != 'prscrptn' and tableName != 'benefits' and 
                                tableName != 'chldcare' and tableName != 'hbai' ))then
                        # prscrptn, chldcare and benefits since 'person' 
                        # field can point to either adult or child records so a PK isn't really possible  
                        hasADFK = true                
                end
        }
        if( tableName != 'househol')then
                tableElem << makeFK( 'househol' )
        end
        if hasBUFK then
                tableElem << makeFK( 'benunit' )
        end
        if hasADFK then
                tableElem << makeFK( 'adult' )
        end
        return tableElem
end

loadStatementsFile = File.open( "postgres_load_statements.sql", "w")
loadStatementsFile.write( "SET datestyle='MDY';\n")
connection  = getConnection()
stmt = "select distinct year,name from tables"
rs = connection.execute( stmt )

tables = Hash.new
tableNames = Array.new
rs.fetch_hash{
        |res|
        year = res['year']
        tableName = res['name']
        recordName = recordNameFromTableName( tableName )
        table = loadTable( connection, tableName, year )
        
        tableNames << tableName
        puts "on table #{tableName} year #{year}"
        if( tables.has_key?( tableName )) then
                tables[ tableName ] = mergeTables( table, tables[ tableName ])
        else
                tables[ tableName ] = table;
        end
        # readFile.write( createConvertProcedure( recordName, year, table ) )
        loadStatementsFile.write( makePostgresLoadStatement("/mnt/data/frs/", recordName, table )+"\n")
}

millDoc = REXML::Document.new();
millDTD = REXML::DocType.new('database PUBLIC "http://virtual-worlds.biz/Mill"  "http://www.virtual-worlds.biz/dtds/mill.dtd"');
millDoc << millDTD
millDatabase = REXML::Element.new( 'database' )
millDatabase.add_attribute( "name", "frs" )
dpackage = REXML::Element.new( 'adaTypePackage' )
dpackage.add_attribute( "name", "Data_Constants" )
millDatabase << dpackage
millDoc << millDatabase
tableNames.uniq.each{
        |tableName|
        table = tables[ tableName ]
        millDatabase << createMillTable( table )
}
xmlFile = File.open( "schema.xml", "w")
millDoc.write( xmlFile, 8 ) 
xmlFile.close()
connection.disconnect()
loadStatementsFile.close()
