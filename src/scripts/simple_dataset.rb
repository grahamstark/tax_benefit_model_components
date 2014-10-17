#
# simple thing that models a spreadsheet-like array of cells, with names for the colums, from
#  a file delimited by ",", tabs or similar
#
require 'csv'

class SimpleDataset
   
        attr_reader :colnames;
        
        def initialize( filename, delimiter = "," )
                @colnames = []
                @data = []
                self.read( filename, delimiter )
        end
        
        def colPos( name )
                return @colnames.index( name )     
        end

        def getRow( pos )
                return @data[pos]
        end
        
        def getCol( name )
                a = []
                pos = colPos( name )
                return a if pos.nil?
                r = 0
                @data.each{
                        |row|
                        a[r] = row[pos]
                        r += 1           
                }
                return a
        end
        
        def hasCol( name )
                return ( not self.colPos( name ).nil? )
        end
        
        def insertCol( name, before, newcol )
                @colnames.insert( before, name )
                @data.length.times(){
                        |r|
                        @data[ r ].insert( before, newcol[r] )
                }
        end
        
        def deleteCol( name )
                pos = self.colPos( name )
                return if pos.nil?
                @colnames.delete_at( pos )
                @data.length.times(){
                        |r|
                        @data[ r ].delete_at( pos )
                }
        end

        def insertRow( name, before, newrow )
                @data.insert( before, newrow )
        end
        
        def deleteRow( pos, data )
                @data.delete_at( pos )
        end
        
        def read( filename, delimiter = ',' )
                        row = 0
                        CSV.foreach( filename, { :col_sep => delimiter } ){
                                |elements|
                                if( row == 0 )then
                                        @colnames = elements
                                else
                                        @data[ row-1 ] = elements
                                end
                                row += 1
                        }                
        end
        
        def write( filename, delimiter = ',')
                f = File.new( filename, 'w' );
                f.write( @colnames.join( delimiter )+"\n" )
                @data.each{
                        |row|
                        f.write( row.join( delimiter )+"\n" )
                }                        
                f.close()
        end
        
        # see http://stackoverflow.com/questions/522720/passing-a-method-as-a-parameter-in-ruby
        def editData( editProc )
                @data.length.times{
                        |r|
                        @data[r].length.times{
                                |c|
                                @data[r][c] = editProc.call( @data[r][c] )
                        }
                }                        
                
        end
        
        # see http://stackoverflow.com/questions/522720/passing-a-method-as-a-parameter-in-ruby
        def editKeys( editProc )
                # puts @colnames
                @colnames.length.times{
                        |c|
                        @colnames[c] = editProc.call( @colnames[c] )
                        # puts "editKeys colnames[#{c}] = #{@colnames[c]}\n"
                }
        end
        
end
