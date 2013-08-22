require 'dbi'
require 'csv'
require 'frs_schema_utils'

def remakeLines( inf, outf, year )
        p = 0
        start = "1\t1\t#{year}\t"
        inf.each{
                |line|
                if( p == 0 )then
                        outf.write( "USERID\tEDITION\tYEAR\t" )
                        outf.write( line+"\n" )
                else
                        outf.write( start )
                        outf.write( line+"\n" )
                end
                p += 1
        }
end 

def sameArray( a1, a2 )
        n1 = a1.length;
        n2 = a2.length;
        return false if( n1 != n2 )
        n1.times{
                |i|
                return false if( n1[i] != n2[i] )
        }
        return true
end

def remakeLinesWithCounter( inf, outf, year, keyFields )
        p = 0
        kn = keyFields.length
        lastValues = []
        lastValues = []
        positions = []
        ne = 0
        start = [ 1, 1, year ]
        inf.each{
                |line|
                elements = line.split( "\t" )
                counter = 1
                if( p == 0 )then
                        outf.write( "USERID\tEDITION\tYEAR\tCOUNTER\t" )
                        ne = elements.length
                        ne.times(){
                                |kp|
                                keyFields.each{
                                        |kf|
                                        if( elements[kp] == kf )then
                                                positions << kp                
                                        end 
                                }
                        }
                        outf.write( line+"\n" )
                else
                        ne.times{
                                p = positions[ne]
                                v = elements[p].to_i
                                values[p] = v
                        }
                        counter += 1 if( sameArray( values, lastValues )                
                        lastValues = values
                        start[3] = counter
                        outf.write( start.join( "\t" ) )
                        outf.write( line+"\n" )
                end
                p += 1
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
        outfileName = "#{dataPath}#{year}/postgres_load_files/#{tableName}.tab"         
        inf = File.open( infileName, "rb")
        outf = File.open( outfileName, "w")        
        yearv = 2000 + year[ 0, 2 ].to_i()
        puts "opening #{infileName} and writing to #{outfileName}\n"
        if( tableName != 'adult')
                remakeLines( inf, outf, yearv )
        else
                keyFields = ['SERNUM', 'BENUNIT']
                remakeLinesWithCounter( inf, outf, year, keyFields )
        end
        inf.close()
        outf.close()
}

