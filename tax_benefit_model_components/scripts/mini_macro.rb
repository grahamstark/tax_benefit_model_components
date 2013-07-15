#!/usr/bin/ruby
#
require "rexml/document";
require 'singleton';
require 'utils'


# 
# contains things extracted from the header data of an ET/ETAS database
# baseYear/Month are the base period where some index variable = 100, which needn't actually be a period in the data
# See the loadFromONSData on where we extract the fields here from.
#
class MetaData
 
        attr_writer :description, :units, :period, :baseYear, :baseMonth, :adjusted, :startYear, :startMonth, :id, :onsKey, :type; 
        attr_reader :description, :units, :period, :baseYear, :baseMonth, :adjusted, :startYear, :startMonth, :id, :onsKey, :type;
        
        def to_s
                "description #{@description} units #{@units} period #{@period}";
        end;
        
        def initialize()
                @description = "";
                @units = "";
                @id = '';
                @period = "";
                @baseYear = 0; 
                @baseMonth = 0; 
                @adjusted = 0; 
                @startYear = 0; 
                @startMonth = 0;
                @onsKey = ""
                @type = ""
        end
end

#
# An ONS database, modelled as a class. This version stores monthly data only.
#
class MiniMacro
       
        def getDataAsArray( key, startYear, startMonth, endYear, endMonth )
                v = Array.new
                y = startYear
                m = startMonth
                loop do
                       date = Date::new( y, m, 1 );
                       v << getByD( key, date );  
                       break if y == endYear and m == endMonth     
                       m += 1
                       if( m == 13 )then
                                m = 1
                                y += 1
                       end
                end
                return v                
        end

       #  
       # period = monthly|quarterly
       # type   = flow, annual_growth (others...) works only with annual_growth/others at present
       # values an array of data
       def appendData( key, startYear, startMonth, period, type, values )
               y = startYear
               m = startMonth
               values.each{
                       |value|  
                       if( period == 'monthly' )then
                                n = 1
                        elsif( period == 'quarterly' )then
                                n = 3
                        end
                        n.times{
                               if type != 'annual_growth' then
                                       setByM( key, y, m, value );  
                               else 
                                       date = Date::new( y - 1, m, 1 );
                                       last = getByD( key, date )
                                       new = last * ( 1 + value/100.0 )
                                       puts "y=#{y} m=#{m} last=#{last} new=#{new} value=#{value}"
                                       setByM( key, y, m, new );  
                               end
                               m += 1
                               if( m == 13 )then
                                        m = 1
                                        y += 1
                               end
                        }
               }
       end
       
       #
       # monthly data from the given period on is extrapolated from that period on
       #
       def extrapolateData( key,  startYear, startMonth, endYear, endMonth, annualGrowthRate )
               y = startYear
               m = startMonth
               # annual growth rate as monthly compound
               monthlyGrowthRate =( 1.0 + ( annualGrowthRate / 100.0 )) ** ( 1.0 / 12.0)
               puts "growth rate #{annualGrowthRate} monthlyGrowthRate #{monthlyGrowthRate}"
               loop do
                       tm = m - 1
                       ty = y
                       if( tm == 0 )then
                                tm = 12;
                                ty = ty - 1
                       end;
                       date = Date::new( ty, tm, 1 );
                       last = getByD( key, date )
                       new = last * monthlyGrowthRate
                       puts "y=#{y} m=#{m} last=#{last} new=#{new} growthRate=#{monthlyGrowthRate}"
                       setByM( key, y, m, new );  
                       break if y == endYear and m == endMonth     
                       m += 1
                       if( m == 13 )then
                                m = 1
                                y += 1
                       end
               end
       end

       #
       # return change between start and end dates as a ratio (1.2 for 100=>120, for example)
       # key - variable to extract
       # startDate - these need to be exact
       # endDate
       #
       def getChange( key, startDate, endDate )
               now_d = getByD( key, endDate );
               then_d = getByD( key, startDate );
               return now_d/then_d;
       end;
       
       #
       # return change between start and the latest date in the dataset for that variable 
       #     as a ratio (1.2 for 100=>120, for example)
       # key - variable to extract
       # startDate - these need to be exact
       # endDate
       #
       def getChangeFromLatest( key, startDate )
               endDate = lastDate( key )
               return getChange( key, startDate, endDate )
       end;
       
        #
        # extract a value of some variable on the given date. Dates are
        # matched exactly.
        #
        # @param key - variable to extract 
        # @param date - a Date class. Should have the day set to 1
        #
        def getByD( key, date )
                row = @data[ date ];
                col = @map[ key.downcase() ];
                return nil if( row.nil? ) 
                return row[ col ];
        end
        
        #
        # return a list of avialable data keys, in alphabetical order
        #
        def variableList
                return @map.keys.sort     
        end
        

        attr_reader :map;
        
        #
        # Extract the data for the 1st day in the given quarter 
        # key - varname
        # year
        # quarter
        def getByQ( key, year, quarter )
                month = 1 + (quarter-1)*3;
                date = Date.new( year, month, 1 ); 
                getByD( key, date );
        end;
        
        #
        # set a value in our database for the given date.
        # key - ONS variable id 
        # date - date to add for
        # val value to add.
        #
        def setByD( key, date, value )
                row = @data[ date ];
                dkey = key.downcase();
                if( row == nil )then
                        @data[ date ] = Array.new;
                        row = @data[ date ];
                end
                col = @map[ dkey ];
                if( col == nil ) then
                        col = @map.size();
                        puts "adding an entry for #{dkey} at position #{col} value is #{value}";
                        @map[ dkey ] = col;
                end
                row[ col ] = value;
        end;
        
        #
        # the first date, for any variable if key is nill, in the dataset
        # 
        def firstDate( key = nil )
                return @data.keys.min() if( key.nil? );
                sortDates();
                @sortedDates.each(){
                        |date|
                        return date if( ! getByD( key, date ).nil? ); 
                }
                return nil;
        end;
        
        #
        # the last date in the database, 
        # for any variable if key is nil, else for the specified var. 
        #
        def lastDate( key = nil )
                last = @data.keys.max();
                if( key == nil ) then
                         return last;
                end
                sortDates();
                @sortedDates.reverse_each(){
                        |date|
                        if( getByD( key, date ) != nil )then 
                                return date;
                        end;
                }
                return nil;
        end;
        
        #
        # set a value for a given year, month, and day 1
        #
        def setByM( key, y, m, val )
                date = Date.new( y, m, 1 );
                setByD( key, date, val )
        end;

        #
        # set a value on the first day of the given quarter
        #
        def setByQ( key, y, q, val )
                m = 1 + (q-1)*3;
                setByM( key, y, q, val );
        end;
        
        #
        # return the metadata's description for the given variable
        #
        def getDescription( key )
                meta = @metaData[ key ];
                if( meta != nil )then
                        return meta.description;
                end;
                return '';
        end;
        
        #
        # return the metadata's unit identifier for the given variable
        #
        def getUnits( key )
                meta = @metaData[ key ];
                if( meta != nil )then
                        return meta.units;
                end;
                return '';        
        end;
        
        def getMeta( key )
                return @metaData[ key ];
        end;
        
        #
        # add a metadata record for the given variable.
        #        
        def setMeta( key, metaData )
                @metaData[ key ] = metaData;
        end;
        
        #
        def initialize( )
                @data = Hash.new();
                @map = Hash.new();
                @metaData = Hash.new();
                @sortedDates = Array.new();
        end
        
        #
        #
        #
        def sortDates()
                @sortedDates = @data.keys.sort();
        end

end;

# add one db record with monthly data
# min  -min macro class to ass this to 
# lines - the whole db parsed into lines
# pos star pos of this record
# if variable id
# period monthly always, I hope
#
def matchMonthly( mini, lines, pos, id, period, adjusted, baseYear, baseMonth )
        meta = MetaData.new();
        meta.period = period
        meta.adjusted = adjusted
        meta.id = id
        meta.baseYear = baseYear
        meta.baseMonth = baseMonth

        ## puts "on line #{pos} looking at line |#{lines[ pos ]}";
        ## puts "code = #$1 period = #$2 adjusted = #$3 base year #$5 base month=#$6 "
        pos += 1;   
        # next line starts '93' and contains a description
        if lines[ pos ] =~ /93(.*)/ then
                ## puts "description=#$1";
                meta.description = $1.strip();
                pos += 1;
                # next line starts '96MM' (MM is monthly indicator) and has some period information
                if( lines[ pos ] =~ /96MM([\d]{4,4}) ([\d ]{2,2})([\d]{4,4})([\d ]{2,2}).*/ ) then
                        ## puts  "start year #$1 start month #$2 end year #$3 end month #$4 ";
                        meta.startYear = $1.to_i;
                        meta.startMonth = $2.to_i(); #m2q( $2 );
                        ## puts "startYear #{meta.startYear} startMonth #{meta.startMonth}"
                        if( meta.startMonth > 12 ) then
                                ## puts  "!!! OUT OF RANGE QUARTER FOR #$0";
                        end
                        if( meta.period == 'Q' ) then
                                mini.setMeta( meta.id, meta );
                        end
                        pos += 1
                        m = meta.startMonth;
                        y = meta.startYear;
                        ## these are the data lines, starting with '97' and with usually 7 values seperated by spaces
                        re = /97(.*)/;
                        done = false;
                        while( lines[ pos ] =~ re )
                                # we're on matching data lines. Split them up and convert each value to a number. 
                                # The numbers each become the next month's value
                                ## puts  "matching data line #$1 ";
                                if( meta.period == 'M' ) then
                                        a = $1.scan( /([\d|\.]+)/ )
                                        puts  "split into #{a}" ;
                                        a.each {
                                                |sv|
                                                r = sv[0].to_f();
                                                ##puts  "adding value #{r} aty=#{y} m=#{m}";
                                                mini.setByM( meta.id, y, m, r );
                                                m += 1;
                                                if( m == 13 ) then
                                                        y += 1;
                                                        m = 1;
                                                end
                                        }
                                end;
                                pos += 1; #next line in data
                        end;    #while lines match '97 something'
                end;            #96: line preceeding data
        end;                    #93: description
        return pos
end

#
# add quartertly data 3 times, one for each month in the quarter
#
def matchQuarterly( mini, lines, pos, id, period, adjusted, baseYear, baseMonth )
        meta = MetaData.new();
        meta.period = period
        meta.adjusted = adjusted
        meta.id = id
        meta.baseYear = baseYear
        meta.baseMonth = baseMonth
        ## puts "on line #{pos} looking at line |#{lines[ pos ]}";
        ## puts "code = #$1 period = #$2 adjusted = #$3 base year #$5 base month=#$6 "
        pos += 1;                
        if lines[ pos ] =~ /93(.*)/ then
                meta.description = $1.strip();
                pos += 1;
                if( lines[ pos ] =~ /96..([\d]{4,4}) ([\d ]{2,2})([\d]{4,4})([\d ]{2,2}).*/ ) then
                        meta.startYear = $1.to_i;
                        startQuarter = $2.to_i();
                        meta.startMonth = quarterStartMonth( startQuarter ) #m2q( $2 );
                        if( meta.period == 'Q' ) then
                                mini.setMeta( meta.id, meta );
                        end
                        pos += 1
                        q = startQuarter;
                        y = meta.startYear;
                        re = /97(.*)/;#([ 0-9\.]{10})*([ 0-9\.]{10})*([ 0-9\.]{10})*([ 0-9\.]{10})*([ 0-9\.]{10})*([ 0-9\.]{10})*/;
                        done = false;
                        while( lines[ pos ] =~ re )
                                if( meta.period == 'Q' ) then
                                        a = $1.scan( /([\d|\.]+)/ )
                                        a.each {
                                                |sv|
                                                r = sv[0].to_f();
                                                ## as a hack, set the same value for each month in the quarter
                                                m = quarterStartMonth( q )
                                                3.times{
                                                        mini.setByM( meta.id, y, m, r );
                                                        m += 1
                                                }
                                                q += 1;
                                                if( q == 5 ) then
                                                        y += 1;
                                                        q = 1;
                                                end
                                        }
                                end;
                                pos += 1; #next line in data
                        end;    #while lines match '97 something'
                end;            #96: line preceeding data
        end; 
        return pos
end

# 
#
# create a mini-macro dataset by loading from a raw ONS
# macro dataset.
#
# This is jammed to add monthly data. Look at the file ET to see what we're parsing here.
# There's a mazegreen version jammed on to parse Quarterly data.
#
# filename - file to load (download these straight from ONS site)
# mini - you can pass in an existing MiniMacro class here; othwewise, one is created.
# return - a filled in MiniMacro class
def loadFromONSData( filename, mini = nil )
        lines = Array.new();
        puts "opened file #{filename}"
        ## singleton mini = MiniMacro.instance;
        if( mini.nil? ) then
                puts " creating a new minimacro "
                mini = MiniMacro.new ;
        end
        
        IO.foreach( filename ){
               |line|
               lines << line;
        }
        pos = 0;
        while not( lines[ pos ] =~ /92.*/ ) # skip 
              pos += 1;
        end
        pos -= 1  
        while pos < lines.length
                ## puts "starting block on lines[#{pos}] = #{lines[ pos ]} ";
                # match the header line, which lools like:
                ## 92CBZWMU   01987 1            ET  3.1                    1  0  0  1 33
                # there are annual, quarterly and monthly versions in the data. 
                # The (M) picks the header for the monthly one.
                # the monthly data follows two lines below
                if( lines[ pos ] =~ /92(\w{4,4})(M)([A|U])([\d| ]{4,4})([\d| ]{4,4})([\d| ]{2,2}).*/ ) then
                        puts "matched monthly line; 1 #{$1} 2 #{$2} 3 #{$3}"
                        id = $1.downcase();
                        period = $2;
                        adjusted = $3;
                        baseYear = $5; 
                        baseMonth = $6;
                        ## puts "matched 92 RE";
                        pos = matchMonthly( mini, lines, pos, id, period, adjusted, baseYear, baseMonth )
                elsif( lines[ pos ] =~ /92(\w{4,4})([A|Q])([A|U])([\d| ]{4,4})([\d| ]{4,4})([\d| ]{2,2}).*/ ) then
                        puts "matched 92 RE";
                        ## this is quarterly data. near duplicate of above... 
                        period = $2;
                        baseYear = $5;
                        baseMonth = $6;
                        adjusted = $3;
                        id = $1.downcase();
                        pos = matchQuarterly( mini, lines, pos, id, period, adjusted, baseYear, baseMonth )
                else
                        pos += 1                  ## skip to next line
                end;                            #92:header
        end;                                    #while not eofcg
        mini.sortDates();
        return mini;
end
