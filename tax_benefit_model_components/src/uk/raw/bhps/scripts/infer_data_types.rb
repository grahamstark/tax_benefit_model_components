#!/usr/bin/ruby
require 'bhps_schema_utils'
require 'find'

dirname = ARGV[0]

# clearForAllWaves()

Find.find( dirname ) do
      |fname|
       if( fname =~ /.*\.tab$/) then
                puts "loading file #{fname}"
                tablename = File.basename( fname, ".tab" )
                if( not tablename =~ /x.*/ )then
                        inferDataType( fname )
                end 
       end
end


CONNECTION.disconnect
