#!/usr/bin/ruby
#
# $revision$
# $author$
#
# Script for code generation (Ada), data cleanups, and indexing for 
# the hierarchical FRS. 
#
require 'csv';
require 'scripts/convert_libs.rb'

class ZAType < EnumeratedType
        
        attr_reader :length, :start_pos, :prec, :description, :type
        attr_writer :length, :start_pos, :prec, :description, :type
        
        def writeRead( bodyfile )
                vtype = self.type
                add = "rec.#{@name} := ";
                end_pos = @start_pos+@length-1;
                substr = "s( #{@start_pos} .. #{end_pos} )"
                if( vtype == 'Amount' ) then
                        add += "Lenient_Convert( #{substr} );\n";
                elsif( vtype == 'Integer' ) then
                        add += "#{vtype}'Value( #{substr} );\n";
                else
                        add += "Convert_#{@type.capitalize}( #{substr} );\n";
                end
                bodyfile.write( add );
        end
        
        
        def inferType
                iprec = 0
                iprec = @prec.to_i if( not @prec.nil? )
                puts "iprec #{iprec}"
                if( @enums.length != 0 )then
                        return "#{@name}_Type";
                elsif( 
                      ( iprec > 0 ) or 
                      (( @length > 3 ) and 
                       (( @name =~ /Value.*/ ) or (  @name =~ /Inkind.*/ ) or ( @name =~ /Income.*/))))then
                        return 'Amount'
                else
                        return 'Integer'
                end
        end
 
end


def readMetadata()
        mf = File.new( "docs/Metadata.txt" );
        lines = mf.readlines
        nl = lines.length;
        p = 0
        listOfTypes = []
        listOfVariables = []
        while p < nl
                l = lines[p]
                #                 1         2       3            4         5 
                if l =~ /.*?\. +(.*?) +\((.*?)\) *\(\@([0-9]+) +(.*?)\.(.*?) *\)/ or 
                   l =~ /(.*?) +\((.*?)\) *\(\@([0-9]+) +(.*?)\.(.*?) *\)/ then
                        puts "main line matched "
                        entry = ZAType.new( $2 )
                        entry.length = $4.to_i
                        entry.start_pos = $3.to_i
                        puts "prec #{$5}"
                        entry.prec = $5
                        entry.description = $1
                        while (not lines[p].nil?) and ( lines[p] != "\n")
                                puts "lines[#{p}] = |#{lines[p]}|"
                                if lines[p] =~ /^ *([0-9]+) +=* +(.*) *$/ then
                                   puts "v #{$1} k #{$2}"
                                   enum = EnumEntry.new( $1, $2 )
                                   entry.enums << enum
                                end
                                p += 1                        
                        end
                        entry.type = entry.inferType
                        puts "inferred type #{entry.type}"
                        if(( entry.type != 'Integer' ) and ( entry.type != 'Amount' )) then
                                i = listOfTypes.index( entry )
                                if( i.nil? )then
                                        listOfTypes << entry
                                 else
                                        type = listOfTypes[ i ].type
                                        entry.type = type
                                end
                        end
                        puts "final type #{entry.type}"
                        listOfVariables << entry
                end
                p += 1        
        end
        return { 'listOfTypes'=> listOfTypes, 'listOfVariables'=>listOfVariables }
end

rc = readMetadata()
listOfTypes = rc[ 'listOfTypes']
listOfVariables = rc[ 'listOfVariables']
deffile = File.new( 'src/eis_definitions.ads.tmp', 'w' );
bodyfile = File.new( 'src/eis_definitions.adb.tmp', 'w' );

listOfTypes.each{
        |entry|
        type = entry.type
        if(( type != 'Amount') and ( type != 'Integer' )) then
                entry.writeEnum( deffile)
                entry.writePrettyPrint( deffile, bodyfile )
                entry.writeConvert( deffile, bodyfile )
                bodyfile.write( "\n\n " );
                deffile.write( "\n\n " );
        end
}

listOfVariables.each{
        |entry|
        entry.writeRead( bodyfile )
}

listOfVariables.each{
        |v|
        deffile.write( "      #{v.name} : #{v.type};\n" )
}

