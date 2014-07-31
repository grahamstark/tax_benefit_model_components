#!/usr/bin/ruby
require 'dbi'
require 'csv'
require 'frs_schema_utils'


connection  = getConnection()
tableName = ARGV[1]
year = ARGV[2]
variableNames = ARGV[3:]
table = loadTable( connection, tableName, year )

connection.close
