#!/usr/bin/ruby
# expand Gnat Ada filenames

targetdir = ARGV[0]
outputdir = ARGV[1]

def parseFile( outputdir, filename )
        text = File.read( filename )
        ext = File.extname( filename );
        packagename =  "mismatch"
        if ext == '.adb' then
                if /^package body +(.*?) +.*is/ =~ text then
                     packagename = $1
                end;
        elsif ext == '.ads' then
                if /^package +(.*?) +.*is/ =~ text then
                     packagename = $1
                end;                
        end
        packagename = packagename.downcase.gsub( ".", "-")
        if( packagename != 'mismatch' )then
                f = File.new( outputdir + "/"+ packagename + ext, "w" )
                f.write( text )
                f.close
        end 
end

Dir["#{targetdir}/*.ad*"].each{
        |filename|
        puts "#{filename}"
        parseFile( outputdir, filename )
}
