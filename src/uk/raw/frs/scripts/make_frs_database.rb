#!/usr/bin/ruby
require 'dbi'
require 'csv'
require_relative 'frs_schema_utils'


connection = getConnection()

filename = "/mnt/data/frs/1112/mrdoc/excel/frs_2011_12_hierarchical_documentation.csv"
yearStr = '1112'
parseOneYear( connection, filename, yearStr, '/mnt/data/frs/1112/tab/' )

# filename = "/mnt/data/frs/0809/mrdoc/excel/frs_2008_09_hierarchical_documentation.csv"
# yearStr = '0809'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0809/tab/' )

# filename = "/mnt/data/frs/1011/mrdoc/excel/frs_2010_11_hierarchical_documentation.csv"
# yearStr = '1011'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/1011/tab/' )

#filename = "/mnt/data/frs/0910/mrdoc/excel/frs_2009_10_hierarchical_documentation.csv"
#yearStr = '0910'
#parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0910/tab/' )

# ['0304','0405','0506','0607',
# ['0607', '0708','0809','0910',
#['0910'].each{
#        |p|
#        parseHBAI( connection, "/mnt/data/frs/#{p}/mrdoc/excel/hbai_variable_list.csv", p, "/mnt/data/frs/#{p}/tab/" )        
#}

# 
# 
# filename = "/mnt/data/frs/0708/UKDA-6252-tab/mrdoc/excel/frs_2007_08_hierarchical_documentation.csv"
# yearStr = '0708'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0708/tab/' )
# 
# filename = "/mnt/data/frs/0607/mrdoc/excel/frs_2006_07_hierarchical_documentation.csv"
# yearStr = '0607'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0607/tab/' )
# 
# 
# filename = "/mnt/data/frs/0506/UKDA-5742-tab/mrdoc/excel/frs_2005_06_hierarchical_documentation.csv"
# yearStr = '0506'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0506/tab/' )
# 
# filename = "/mnt/data/frs/0405/mrdoc/excel/frs_2004_05_hierarchical_documentation.csv"
# yearStr = '0405'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0405/tab/' )
# 
# filename = "/mnt/data/frs/0304/mrdoc/excel/frs_2003_04_hierarchical_documentation.csv"
# yearStr = '0304'
# parseOneYear( connection, filename, yearStr, '/mnt/data/frs/0304/tab/' )
# 
# parseHBAI( connection, '/mnt/data/frs/0304/mrdoc/excel/hbai_variable_list.csv', '0304', '/mnt/data/frs/0304/tab/' )
# parseHBAI( connection, '/mnt/data/frs/0405/mrdoc/excel/hbai_variable_list.csv', '0405', '/mnt/data/frs/0405/tab/' )
# parseHBAI( connection, '/mnt/data/frs/0506/UKDA-5742-tab/mrdoc/excel/hbai_variable_list.csv', '0506', '/mnt/data/frs/0506/tab/' )

#parseHBAI( connection, '/mnt/data/frs/0304/mrdoc/excel/hbai_variable_list.csv', '0304', '/mnt/data/frs/0304/tab/' )

connection.disconnect
