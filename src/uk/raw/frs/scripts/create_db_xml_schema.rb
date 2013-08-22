require 'rexml/document'
require 'rexml/element'
require 'dbi'
require 'csv'
require 'frs_schema_utils'

def makePKCol( name )
        column = REXML::Element.new( "column" )
        column.add_attribute( 'primaryKey', 'True' );
        column.add_attribute( 'default', 0 );
        column.add_attribute( 'type', "INTEGER" );
        column.add_attribute( 'name', name )
        return column;
end

def createMillTable( tableData )
        tableName = tableData.tableName.downcase()
        tableElem = REXML::Element.new( 'table' );
        tableElem.add_attribute( 'name', tableName );
        tableElem.add_attribute( 'description', tableName )
        tableElem << makePKCol( 'year' )
        tableElem << makePKCol( 'user' )
        tableElem << makePKCol( 'edition' )
        tableData.variableNames.each{
                |vname|
                var = tableData.variables[vname]
                if( var.adaType == 'Integer' ) then
                        sqlVar = 'INTEGER'
                        default = '0'
                elsif ( var.adaType == 'Real' ) then
                        sqlVar = 'REAL'
                        default = '0'
                elsif( var.adaType == 'Sernum_Value' ) then
                        sqlVar = 'INTEGER'
                        default = '0'
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
                       (tableData.tableName == 'OWNER' and vcu == 'ISSUE' ) or
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
                       vcu == 'ACCOUNT' )
                column = REXML::Element.new( "column" )
                if( isPK )
                        column.add_attribute( 'primaryKey', 'True' );
                end
                column.add_attribute( 'default', default );
                column.add_attribute( 'type', sqlVar );
                column.add_attribute( 'name', vname.downcase() )
                tableElem << column
        }
        return tableElem
end

loadStatementsFile = File.open( "postgres_load_statements.sql", "w")
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
        loadStatementsFile.write( makePostgresLoadStatement("/mnt/data/frs/", recordName, table ))
}

millDoc = REXML::Document.new();
millDTD = REXML::DocType.new('database PUBLIC "http://virtual-worlds.biz/Mill"  "http://www.virtual-worlds.biz/dtds/mill.dtd"');
millDoc << millDTD
millDatabase = REXML::Element.new( 'database' )
millDatabase.add_attribute( "name", "frs" )
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
