#!/bin/ruby
#
# $revision$
# $author$
#
# Script for code generation (Ada), data cleanups, and indexing for 
# the hierarchical FRS. 
#
require 'csv';

require 'jammed_on_reals';

INDENT='        ';

ADA_KEYWORD_TRANSLATIONS = { 'ACCESS'=>'X_ACCESS', 'OUT'=>'XXOUT' };

MISS = '-12345';
MISS_R = '-12345.0';

#
# ad hoc correction of things that appear reals in some years & ints in others.
#
#JAMMED_ON_REALS = [ 
#        'CHRINC', 'AMOUNT', 'OTAPAMT', 'REDAMT', 'ED1AMT', 'ADEMAAMT', 'APDAMT', 'COMBAMT', 'CVPAY', 
#        'REDAMT', 'CHRINC', 'CHRGAMT1', 'CHRGAMT2', 'CHRGAMT3', 'CHRGAMT4', 'CHRGAMT5', 'CHRGAMT6', 
#        'CHRGAMT7', 'CHRGAMT8', 'CHRGAMT9',
#        'BONAMT1', 'BONAMT2', 'BONAMT3', 'BONAMT4', 'BONAMT5', 'BONAMT6', 'UDEDUC1', 'UDEDUC2', 'MORTAR',
#        'UDEDUC3', 'UDEDUC4', 'UDEDUC5', 'UDEDUC6', 'UDEDUC7', 'UDEDUC8',
#        'USSPAMT', 'RENTFULL', 'USSPAMT', 'CHRINC', 'REDAMT', 'GROSS', 'GROSS', 'GROSS2', 'GROSS3', 'LODGER', 'HBENBU',
#        'EHBENBU', 'TBEN78BU',	'TBEN78', 'TBEN80BU', 'TBEN80', 'TTWCOST',
#        'TTWCODE1', 'TTWCODE2', 'TTWCODE3', 'TTWCOST', 'TTWFAR', 'TTWFRQ', 'TTWMOD', 'TTWPAY', 'TTWPSS', 
#        'TTWREC', 'HOWMUCH', 'HOWMUCHE', 'MORTLEFT', 'MORUS', 'BORRAMT' ]

JAMMED_ON_INTS = [ ];

#
## 8/01/2003 => 812003 so we can treat it as an integer
#
def dateConvert( s )
        if s =~ /(.*)\/(.*)\/(.+)/
                mon = $1
                day = $2
                year  = $3
                ## mon = '0' + mon if( mon.length == 1) 
                day = '0' + day if( day.length == 1 ) 
                return "#{mon}#{day}#{year}"
        else
                return s
        end
end

class NameAndType
        
        attr_reader :name, :type;
        attr_writer :type
        
        def initialize( _name, _type = 'Integer' )
                @name = _name;
                @type = _type;
        end
        
end


#
# For each household and each record type (adult, job, etc,)
# this accumulates the start position for each household and 
# a count of how many records you have for that hh. Puts (0,0) if
# there are none.
# 
class PositionIndicator

        def newRow() 
                out = Hash.new
                @recordNames.each{
                        |name|
                        out[ name ] = Array.new
                }
                return out;
        end
        
        #
        #
        #
        #
        def add( sernum, record, pos )
                if( ! @positions.has_key?( sernum ) )then
                        @positions[ sernum ] = newRow();
                end
                @positions[ sernum ][ record ] << pos;
        end;
        
        
        #
        # Dump out results seperated by blanks.
        # sernum is in pos 0, then pairs with (startpos,count) for each
        # record, in the order of recordNames.
        # filename - to dump to.
        # 
        def dump( filename )
               file = File.new( filename, 'w' ); 
               @positions.keys.sort.each{
                        |sernum|
                        file.write( "#{sernum} " )
                        @recordNames.each{
                                |rec|
                                indic = @positions[ sernum ][ rec ];
                                if( indic.size > 0 )then
                                        file.write( " #{indic[0]} #{indic.size}" )
                                else
                                        file.write(  " 0 0" )           
                                end
                        }
                        file.write( "\n" );
                }
                file.close();
        end
        
        def initialize( _recordNames )
                @recordNames = _recordNames
                @positions = Hash.new
        end
end;

#
# Make an Ada record to represent all fields for all years merged, with sernum and hhseq at the start. ,
# recname - string: Adult,Child, etc.
# variables - array of NameAndType classes, in the order they appear in the output record
#
def makeAdaRecord( recname, variables )
        record = INDENT+"type #{recname}_Rec is record\n";
        record += INDENT*2 + "SERNUM : SernumString := ( others =>' ' );\n";
        record += INDENT*2 + "hh_sequence : Integer := MISS;\n";
        variables .size.times{
                |p|
                if( p > 0 ) then ## 0 is sernum, which we have already.
                        if( variables[p].type == 'Integer' ) then
                                misstype = 'MISS' 
                        else 
                                misstype = 'MISS_R'
                        end
                        record += INDENT*2+"#{variables[p].name} : #{variables[p].type} := #{misstype};\n"
                end
        }
        record += INDENT+"end record;";                
        return record;
end


#
# This class takes an FRS dataset, makes 
# an Ada read statement, and a cleaned version of the data with a hh sequence 
# added and missing values inserted in place of blanks (need this as ada can't
# cope with blank values e.g. in csv).
#
class CSVParser

        attr_reader :variables;
        
        #
        # write an ADA load statement to read the cleaned up data from a text file.
        #
        def writeFromFileLoadLine()
                readStmt = INDENT + "function load#{@recname}( file : FILE_TYPE ) return #{@recname}_Rec is\n";
                readStmt += INDENT*2 + "tmp : #{@recname}_Rec;\n";
                readStmt += INDENT + "begin\n";
                ## two lines always there so jam them on manually.
                readStmt += INDENT*2 +"tmp.SERNUM := readSernum( file );\n";
                readStmt += INDENT*2 +"int_io.get( file, tmp.hh_sequence );\n\n";
                @variables.size.times{
                        |p|
                        if( p > 0 )then
                                type = @variables[p].type
                                case( type ) ## reals that look like ints
                                        when 'Rate' then  reader = 'Rate_io';
                                        when 'Integer' then reader = 'int_io';
                                        when 'SernumString' then reader = 'string_io';
                                 end ## case      
                                readStmt += INDENT*2 + "#{reader}.get( file, tmp.#{@variables[p].name} );\n";
                                readStmt += INDENT*2 + "text_io.put( \"tmp.#{@variables[p].name} = \" & tmp.#{@variables[p].name}'Img );\n";
                        end
                }
                readStmt += INDENT*2 + "return tmp;\n";
                readStmt += INDENT + "end  load#{@recname};\n";
                puts "writing line #{readStmt}";
                return readStmt;
        end


        #
        # Convert reals into the only format that ada likes (x.xx) with the point and a leading
        # number required. Replace nils, mv chanacters or blanks with missing value indicators. Replace dates
        # in the format dd/mm/yy with ddmmyy.
        # 
        def cleanupItem( item, type )
              if(( (not item.nil?) and ( item.length > 0) ) and ( item != 'A' ))then ## not just blanks or missing value indicator
                      if( type == 'Rate' )then ## reals that look like ints
                              if( item[0,1] == "." ) then
                                      item = '0' + item; ## ada needs a leading 0 in decimal numbers
                              elsif( item =~ /\-\.(.*)/ ) then ## a negative like "-.03" ; make it -0.03
                                      item = "-0."+$1;
                              elsif( not item =~ /[0-9]+\.[0-9]+/ ) then
                                      item += '.0'       ### .. and a trailing .0 if not othewise there.
                              end;
                      end
                      item = dateConvert( item );
              else 
                      item = (type == 'Integer') ? MISS : MISS_R;
              end
              return item
        end;
        
        #
        # Convert a data line into the only format I can persuade ADA to read it in.
        #
        # add a household reference indicator at pos 2, seperate with blanks, add missing value
        # indicators, add '.0' to real values where needed.
        # param - line as read in, split into fields by csv parser.
        # return - converted line as a string
        #
        def convertDataLine( line )
                loadLine = ''
                ## always have seqno and my translated hhreference as 0 and 1 elements.
                # 
                ival = @hhrefs[ line[ @sernumPos ] ]
                ival = MISS if( ival.nil? )
                loadLine += "#{line[ @sernumPos ]} #{ival} ";                
                @variables.size.times{
                        |p|
                        if( p != @sernumPos ) then
                                type = @variables[p].type;
                                item = line[p];
                                if( not item.nil? and (item.length > 0) ) then
                                        item.strip!();
                                end;
                                item = cleanupItem( item, type );
                                loadLine += item;
                                if( @variables.size - 1) > p then 
                                        loadLine += " "
                                end
                        end;
                }
                loadLine += "\n";
                puts "writing line #{loadLine}";
                return loadLine;
        end

        def writeLoadLines()
                out = ''
                @splitDataLines.each{
                        |line|
                        out += writeLoadLine( line );
                }
                return out;
        end

        def convertDataLines()
                out = ''
                @splitDataLines.each{
                        |line|
                        out += convertDataLine( line );
                }
                return out;
        end
        
        #
        # Load the entire dataset into memory, create:
        #    @variables - an array indexed from 0 of NameAndType claees
        #    @posIndicator - PositionIndicator - class declared above showing where to seek this household's records in the index file
        #    @splitDataLines - parsed data lines
        def load()
                pos = 0;
                file = File.open( @filename, 'rb' );
                puts "opened #{file}" ;
                CSV::Reader.parse( file, @sep ){
                        |elements|
                        print "on line #{pos}"
                        if( pos == 0 )then ## parse top line into an array of variable names
                                elements.each{
                                        |element|
                                        puts "on element #{element}" 
                                        varname = element.data;
                                        varname.strip! if( not varname.nil? );
                                        ## do some name cleanups so ADA is happy
                                        if( varname =~ /_(.*)_/ )then
                                                varname = $1
                                        end;
                                        varname.upcase!
                                        varname = 'MONTH' if varname == '@_MONTH'
                                        if( ADA_KEYWORD_TRANSLATIONS.has_key?( varname ))then
                                                varname = ADA_KEYWORD_TRANSLATIONS[ varname ];
                                        end
                                        @variables  << NameAndType.new( varname,'Integer' );
                                }
                        else            ## parse each line into a data buffer, and infer data types while we are at it.
                                elements.size.times{
                                        ## infer the type from a '.' in the field
                                        ## but override when (e.g.) this is inconsistent
                                        ## between years or if we know something should be real (e.g. GROSS2). 
                                        ## We should really fix this
                                        ## by parsing all the files into one big
                                        ## dictionary and merging that with the actual excel dictionary.
                                        |p|
                                        if(JAMMED_ON_REALS.include?(@variables[p].name))then
                                                @variables[p].type = 'Rate';
                                        elsif(JAMMED_ON_INTS.include?(@variables[p].name))then
                                                @variables[p].type = 'Integer';
                                        elsif( ! elements[p].nil? )then
                                                if( elements[p] =~  /.*\..*/ )then
                                                        @variables[p].type = 'Rate';
                                                end;
                                        end;                                        
                                }
                                @splitDataLines << elements;
                                puts " sernumPos #{@sernumPos}" ;
                                @posIndicator.add( elements[ @sernumPos ], @recname, pos )
                        end;
                        ## always have the sernum first
                        @variables[ 0 ].type = 'SernumString' 
                        pos += 1;       
                }
        end;

        ###
        #
        # filename - to read
        # recname - used in output definitions, Adult, Household, etc.
        # indexCount - used in making load statements use 1st 3,4 etc values as array indicators. Now redundant.
        # hhrefs map of hhval=>int for each household
        # posIndicator - PositionIndicator Class
        # sernumPos column (from 0) of the sernum field
        # _sep column separator - possibly only tabs and commas work
        ###
        def initialize( _filename, _recname, _indexCount, _hhrefs, _posIndicator, _sernumPos = 0, _sep="\t" );
                @variables = Array.new;
                @splitDataLines = Array.new;
                @filename = _filename;
                @recname = _recname;
                @indexCount = _indexCount;
                @hhrefs = _hhrefs;
                @posIndicator = _posIndicator;
                @sernumPos = _sernumPos
                @sep = _sep;
        end;
end #class

def makeHHrefs( filename )
        hhmap = Hash.new
        p = 0;
        file = File.open( filename, 'rb' );
        puts "opened #{file}" ;
        CSV::Reader.parse( file, "\t" ){ ##"\t" ){
               |elements|
               p += 1
               hhmap[ elements[0] ] = p
               puts " read #{p} hhlds ";
        }
        return hhmap
end

##
# remove dups by name from our merged variable lists.
# 
# variables : Array of NameAndType
# return array of NameAndType classes for all unique names, in original order
##
def removeVariableDups( variables )
        there = Array.new
        out = Array.new
        variables.each{
                |var|
                if( ! there.include?(var.name) )then
                        there << var.name
                        out << var 
                end
        }
        return out;
end;

#
# Parse one frs csv file for all the years we have it. Produce an ada record with
# the union of all the fields,
# per-year load statements and cleaned data. 
# Input files in ../<year>/tab/, output in ../<year>converted and <year>source and source/ for the record.
# 
# years - array as strings like '0203' ...
# filename - just that
# recordName - Adult, Child, etc.: we create the ADA record with that name
# indexSize: not really used at the mo
# hhrefs: mapping of sernums to our 1,2... household references (a hash, with years as key)
# posIndic : per years hash of PositionIndicators
# sernumPositions, for each year, position (from zero) of the sernum string
# sep : character seperator (defaults to tab).

#
def parseOneFile( years, filename, recordName, indexSize, hhrefs, posIndic, sernumPositions = [0,0,0], sep="\t" )
        variables = Array.new
        p = 0
        years.each{
                |year|
                p += 1
                puts "on year #{year} filename #{filename} recordName #{recordName} ";
                infile = "../#{year}/tab/#{filename}.tab";
                parser = CSVParser.new( infile,  recordName, indexSize, hhrefs[year], posIndic[year], sernumPositions[p-1], sep );
                parser.load();
        
                file = File.new( "../#{year}/source/#{recordName}.load" , 'w'); 
                file.write(parser.writeFromFileLoadLine() );
                file.close();
        
                file = File.new( "../#{year}/converted/#{recordName}.dat", 'w' ); 
                file.write( parser.convertDataLines() );
                file.close();
                variables = variables | parser.variables;                          
        }
        variables = removeVariableDups( variables )
        file = File.new( "../source/#{recordName}.record", 'w' );
        record =  makeAdaRecord( recordName, variables )
        file.write( record );
        file.close();
end

PATH = 

hhrefs = Hash.new
hhrefs['0304'] = makeHHrefs( '../0304/tab/househol.tab' )
hhrefs['0405'] = makeHHrefs( '../0405/tab/househol.tab' )
hhrefs['0506'] = makeHHrefs( '../0506/tab/househol.tab' )

posIndicator = Hash.new

#
# this contains the order that records are held in the index file. This MUST
# match exactly the entries in the enumerated type 
# RecordComponents enum in RawFRS.ads
#
INDEX_POSITIONS = [ "Adult", 
   "Account",  "Admin", "Asset", "Benefit", "Benunit","Care", "Child","Endowment",
   'ExtChild','GovPay', 'Household','Insurance',
   'Job', 'Maint', 'MortCont', 'Mortgage', 'OddJob', 'Owner', 'PenProv', 'PenAmt', 'Pension', 
   'RentCont', 'Renter', 'Vehicle' ]

posIndicator = Hash.new

posIndicator[ '0304' ] = PositionIndicator.new( INDEX_POSITIONS  )

#adult.dat     child.dat     job.dat       owner.dat     vehicle.dat
#assets.dat    endowmnt.dat  maint.dat     penprov.dat
#benefits.dat  govpay.dat    mortcont.dat  pension.dat
#benunit.dat   househol.dat  mortgage.dat  rentcont.dat
#care.dat      insuranc.dat  oddjob.dat    renter.dat
posIndicator[ '0405' ] = PositionIndicator.new( INDEX_POSITIONS )
posIndicator[ '0506' ] = PositionIndicator.new( INDEX_POSITIONS )

parseOneFile( ['0304','0405', '0506'],'accounts', "Account", 4, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'adult', "Adult", 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'admin', "Admin", 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'assets', "Asset", 5, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'benefits', "Benefit", 4, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'benunit', "Benunit", 2, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'care', "Care", 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'child', "Child", 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'endowmnt', "Endowment", 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'extchild', 'ExtChild', 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'govpay', 'GovPay', 4, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'househol', 'Household', 1,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'insuranc', 'Insurance', 2,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'job', 'Job', 4,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'maint', 'Maint', 4,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'mortcont', 'MortCont', 2,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'mortgage', 'Mortgage', 2,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'oddjob', 'OddJob', 5,  hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'owner', 'Owner', 1,  hhrefs , posIndicator)
parseOneFile( ['0304','0405', '0506'],'penprov', 'PenProv', 3, hhrefs, posIndicator )   
parseOneFile( ['0304','0405', '0506'],'penamt', 'PenAmt', 3, hhrefs, posIndicator )   
parseOneFile( ['0304','0405', '0506'],'pension', 'Pension', 3, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'rentcont', 'RentCont', 2, hhrefs, posIndicator )
parseOneFile( ['0304','0405', '0506'],'renter', 'Renter', 1, hhrefs, posIndicator )
parseOneFile( ['0304', '0506'],'vehicle', 'Vehicle', 1, hhrefs, posIndicator ) # '0405' not there


posIndicator.each{
        |year,indic|
        indic.dump( "../#{year}/converted/positions.dump" );
}



