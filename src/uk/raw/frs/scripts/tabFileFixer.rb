require 'dbi'
require 'csv'
require 'frs_schema_utils'

def remakeLines( inf, outf, year )
        p = 0
        start = "1,1,#{year},"
        inf.each{
                |line|
                line.gsub!( /\t/, "," )
                line.gsub!( / /, '' )
                
                if( p == 0 )then
                        # postgres doesn't allow header lines when reading tab 
                        outf.write( "USER_ID,EDITION,YEAR," )
                        outf.write( line  )
                else
                        outf.write( start )
                        outf.write( line )
                end
                p += 1
        }
end 

def sameArray( a1, a2 )
        n1 = a1.length;
        n2 = a2.length;
        # puts "last #{a1.join( '|' )} now #{a2.join( '|' )}\n"                        
        return false if( n1 != n2 )
        n1.times{
                |i|
                return false if( a1[i] != a2[i] )
        }
        # puts "SAME"
        return true
end

def remakeLinesWithCounter( inf, outf, year, keyFields )
        lineNumber = 0
        numKeyFields = keyFields.length
        lastValues = []
        values = []
        positions = []
        numElements = 0
        start = [ 1, 1, year ]
        counter = 1                
        inf.each{
                |line|
                line.gsub!( /\t/, "," )
                line.gsub!( / /, '' )
                # puts line
                elements = line.split( "," )
                if( lineNumber == 0 )then
                        outf.write( "USER_ID,EDITION,YEAR,COUNTER," )
                        numElements = elements.length
                        numElements.times(){
                                |kp|
                                keyFields.each{
                                        |kf|
                                        if( elements[kp] == kf )then
                                                positions << kp                
                                        end 
                                }
                        }
                        outf.write( line )
                        puts "keyfields #{keyFields.join('|')} positions #{positions.join('|')}\n"
                else
                        numKeyFields.times{
                                |keyNumber|
                                pp = positions[keyNumber]                                
                                v = elements[pp].to_i
                                values[pp] = v
                        }
                        if sameArray( lastValues, values )then
                                counter += 1 
                        else
                                counter = 1
                        end
                        lastValues = values.clone()
                        start[3] = counter
                        outf.write( start.join( "," ) + "," )
                        outf.write( line )
                end
                lineNumber += 1
        }
        
end

connection  = getConnection()
stmt = "select distinct year,name from tables"
rs = connection.execute( stmt )


rs.fetch_hash{
        |res|
        year = res['year']
        tableName = res['name'].downcase()
        dataPath = "/mnt/data/frs/"
        infileName = "#{dataPath}#{year}/tab/#{tableName}.tab" 
        outfileName = "#{dataPath}#{year}/postgres_load_files/#{tableName}.csv"         
        inf = File.open( infileName, "rb")
        outf = File.open( outfileName, "w")        
        yearv = 2000 + year[ 0, 2 ].to_i()
        puts "opening #{infileName} and writing to #{outfileName}\n"
        if TABLES_THAT_NEED_COUNTERS.include?( tableName )then
                case tableName                     
                when 'care'
                        keyFields = ['SERNUM', 'BENUNIT' ]
                when 'nimigr', 'owner'
                        keyFields = ['SERNUM' ]
                else
                        keyFields = ['SERNUM', 'BENUNIT', 'PERSON' ]
                end
                remakeLinesWithCounter( inf, outf, yearv, keyFields )
        else
                remakeLines( inf, outf, yearv )
        end
        inf.close()
        outf.close()
}
