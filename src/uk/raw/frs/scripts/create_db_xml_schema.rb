require 'rexml/document'
require 'rexml/element'
require 'dbi'
require 'csv'
require 'frs_schema_utils'

def createTable( name, description )
        table = REXML::Element.new( 'table' );
        table.add_attribute( 'name', name );
        table.add_attribute( 'description', description )
        100.times(){
                |i|
                column = REXML::Element.new( "column" )
                column.add_attribute( 'name', "col#{i}" )
                column.add_attribute( 'type', "INTEGER" );
                table << column
        }
        return table
end

connection  = getConnection()
stmt = "select distinct year,name from tables"
rs = connection.execute( stmt )
tables = Hash.new
tableNames = Array.new

doc = REXML::Document.new();
dt = REXML::DocType.new('database PUBLIC "http://virtual-worlds.biz/Mill"  "http://www.virtual-worlds.biz/dtds/mill.dtd"');

#, "PUBLIC", "http://virtual-worlds.biz/Mill", "http://www.virtual-worlds.biz/dtds/mill.dtd" );
doc << dt
database = REXML::Element.new( 'database' )
database.add_attribute( "name", "frs" )
doc << database
100.times(){
        |i|
        database << createTable( "table#{i}", "table #{i}")
}
doc.write( $stdout, 8 ) 


connection.disconnect
