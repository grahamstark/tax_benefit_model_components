#!/usr/bin/ruby
require 'dbi'
require 'csv'
require 'frs_schema_utils'


connection = getConnection()

filename = "/mnt/data/frs/0708/UKDA-6252-tab/mrdoc/excel/frs_2007_08_hierarchical_documentation.csv"
yearStr = '0708'
parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0708/tab/' )

filename = "/mnt/data/frs/0607/UKDA-6079-tab/mrdoc/excel/frs_2006_07_hierarchical_documentation.csv"
yearStr = '0607'
parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0607/tab/' )


filename = "/mnt/data/frs/0506/UKDA-5742-tab/mrdoc/excel/frs_2005_06_hierarchical_documentation.csv"
yearStr = '0506'
parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0506/tab/' )

filename = "/mnt/data/frs/0405/mrdoc/excel/frs_2004_05_hierarchical_documentation.csv"
yearStr = '0405'
parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0405/tab/' )

filename = "/mnt/data/frs/0304/mrdoc/excel/frs_2003_04_hierarchical_documentation.csv"
yearStr = '0304'
parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0304/tab/' )

parseHBAI( connection, '/mnt/data/frs/0304/mrdoc/excel/hbai_variable_list.csv', '0304', '/mnt/data/frs/0304/tab/' )
parseHBAI( connection, '/mnt/data/frs/0405/mrdoc/excel/hbai_variable_list.csv', '0405', '/mnt/data/frs/0405/tab/' )
parseHBAI( connection, '/mnt/data/frs/0506/UKDA-5742-tab/mrdoc/excel/hbai_variable_list.csv', '0506', '/mnt/data/frs/0506/tab/' )

connection.disconnect
