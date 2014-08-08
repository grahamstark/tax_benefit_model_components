#!/usr/bin/ruby
require 'dbi'
require 'csv'
require_relative 'frs_schema_utils'


connection  = getConnection()
tableName = ARGV[0]
year = ARGV[1]
variableNames = ARGV[ 2 .. ARGV.length ]
table = loadTable( connection, tableName, year )
enums = makeGretlDummyList( table, variableNames )

enums.each{
        |enum|
        puts "#{enum}\n";

}

# connection.close
