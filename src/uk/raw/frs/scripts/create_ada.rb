        #!/usr/bin/ruby
require 'dbi'
require 'csv'
require 'frs_schema_utils'


connection  = getConnection()
readFile = file = File.open( 'convert_statements', 'w' )
recordsFile = File.open( 'record_declarations', 'w' )
loadStatementsFile = File.open( 'load_statements', 'w' )
printStatementsFile = File.open( 'print_statements', 'w' )
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
        readFile.write( createConvertProcedure( recordName, year, table ) )
        loadStatementsFile.write( makeLoadStatement("/mnt/data/frs/", recordName, table ))
}

tableNames.uniq.each{
        |tableName|
        table = tables[ tableName ]
        recordName = recordNameFromTableName( table.tableName )
        recordsFile.write(makeAdaRecord( recordName, table ) )
        printStatementsFile.write( createPrintFunction( recordName, table ) )
}

readFile.close
recordsFile.close
loadStatementsFile.close
printStatementsFile.close

connection.disconnect
