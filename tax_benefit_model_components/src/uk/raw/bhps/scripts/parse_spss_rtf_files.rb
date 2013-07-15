#!/usr/bin/ruby
require 'bhps_schema_utils'
require 'find'

dirname = ARGV[0]

# clearForAllWaves()

if( true ) then
        Find.find( dirname ) do
              |fname|
              if( fname =~ /.*\.txt$/) then
                   puts( fname )
                   tablename = File.basename( fname, ".txt" )
                   if( not tablename =~ /x.*/ )then
                           readOneRTF( fname )
                   end 
              end
        end

end

if( true ) then
        Find.find( dirname ) do
              |fname|
              if( fname =~ /.*\.txt$/) then
                   puts( fname )
                   tablename = File.basename( fname, ".txt" )
                   if( tablename =~ /x.*/ )then
                           x_readOneRTF( fname )
                   end 
              end
        end
end

CONNECTION.disconnect
