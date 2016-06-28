#
#
require 'tempfile'
require 'date'
require 'csv'

FOP_PATH = '/opt/fop/fop.sh'; 

LINEAR = 1
EXPONENTIAL = 2

def notNullOrBlank( s )
        return ( not ( s.nil? or s == '' )) 
end

def insertBetween( filename, startDelim, endDelim, newlines )
        inlines = File.open( filename ).read().split( "\n" )
        outlines = []
        startRE = Regexp.new( startDelim )
        endRE  = Regexp.new( endDelim )
        adding = true
        inlines.each{
                |line|
                header = false
                if adding then
                        outlines << line
                end
                if startRE =~ line then
                        adding = false
                        outlines << newlines
                elsif endRE =~ line then
                        adding = true
                        outlines << line
                end        
        }
        f = File.new( filename, "w" );
        f.write( outlines.join( "\n" ));
        f.close()
end

def readLinesBetween( filename, startDelim, endDelim )
        lines = File.open( filename ).read().split( "\n" )
        s = []
        startRE = Regexp.new( startDelim )
        endRE  = Regexp.new( endDelim )
        adding = false
        lines.each{
                |line|
                header = false
                if startRE =~ line then
                        adding = true
                        header = true
                elsif endRE =~ line then
                        adding = false
                        header = true
                end
                if adding and not header then
                        s << line
                end
        }
        return s    
end 

def moveInLineWith( v1, series )
   out = []     
   l = series.length()
   l.times{
        |p|
        out[p] = v1 * series[p]/series[0]
   }
   return out
end

#
# make an array periods long interpolating between two values
# @v1 - 1st value
# @v2 - final value
# @periods - including 1st and last
# @method - LINEAR/EXPONENTIAL (exp is very rough for small nos of periods)
# @return array with [0]-v1 - [periods-1] = v2 and periods in between filled in 
#
def interpolate( v1, v2, periods, method )
        out = []
        fv1 = v1.to_f()
        fv2 = v2.to_f()
        fp = periods.to_f() # force us to use floating point everywhere
        case method
        when EXPONENTIAL then
                growth = Math.log( fv2 / fv1 ) / ( fp - 1 )
                periods.times{
                      |p|
                      out[p] = fv1*(( 1.0 + growth ) ** p )
                }                
                out[periods-1] = v2;
                # fixme exacty growth interpolation
        when LINEAR then
                diff = ( fv2 - fv1 ) / ( fp - 1 )
                periods.times{
                        |p|
                        out[p] = v1 + (diff*p)
                }
        end
        return out
end

def extrapolate( a, growth, newPeriods )
        l = a.length()
        last = a[ l-1 ]
        newPeriods.times{
                |p|                        
                a[p+l-1] = last*(( 1.0 + growth ) ** p )
        }
        return a
end
#
def makeEnumArray( enum )
        out = Hash.new();
        enum.values().each{
                |v|
                out[ v ] = 0.0;                
        }
        return out;
end;

def mkdirSafe( name )
        Dir.mkdir( name ) if not Dir.exists?( name )   
end

def safeAdd( hash, key, amount )
       if( hash.has_key?( key ))then
              hash[ key ] += amount;
       else 
              hash[ key ] = amount;
       end;  
end;

def sum( a )
        x  = 0;
        a.each(){
                |v|
                if( v != nil ) then
                        x += v;
                end
        }
        return x;
end

#
# Fred->'fred' FredJoe -> fredJoe
#  
def nameToJavaVar( name )
    return '' if( name.nil? )
    RAILS_DEFAULT_LOGGER.debug "nameToJavaVar; name=#{name}"
    name.strip!;
    s = name[0,1].downcase!  
    RAILS_DEFAULT_LOGGER.debug "new 1st char |#{s}|";
    name[0]= s if( ! s.nil? ); 
    RAILS_DEFAULT_LOGGER.debug "output name |#{name}|";
    name;
end

def censor( s )
        s = s.
              strip.
              downcase.        
              gsub( /[ \-,\t–]/, '_' ).
              gsub( /[=\:\)\('’‘]/, '').
              gsub( /[";:\.\?\*”“]/, '' ).
              gsub( /\&/,'_and_').
              gsub( /\+/,'_plus_').
              gsub( /\//,'_or_' ).
              gsub( /__/,'_').
              gsub( /__/,'_').
              gsub( /__/,'_').
              gsub( /\%/,'pct').
              gsub( /_$/, '' ).
              gsub( />=/, '_ge_' ).
              gsub( /1st/, 'first' ).
              gsub( /2nd/, 'second' ).
              gsub( /3rd/, 'third' ).
              gsub( /4th/, 'fourth' ).
              gsub( /5th/, 'fifth' ).
              gsub( /6th/, 'sixth' ).
              gsub( /7th/, 'seventh' ).
              gsub( /8th/, 'eigth' ).
              gsub( /9th/, 'nineth' ).
              gsub( /10th/, 'tenth' ).
              gsub( /11th/, 'eleventh' ).
              gsub( /12th/, 'twelfth' ).
              gsub( /=</, '_le_' ).
              gsub( />/, 'gt_' ).
              gsub( /</, 'gt_' ).
              # gsub( /`/, '' ).              
              # gsub( /£/, 'GBP' ). ## FIXME some problem with encodings in ruby 1.9 here..
              # gsub( /Å�/, 'GBP' ).
              # gsub( /Ã´/, 'o' ).
              # gsub( /Ã©/, 'e' ).
              gsub( /^_/, '' ).
              gsub( /^_/, '' ).
              gsub( /_$/, '' ).
              gsub( /_$/, '' ).
              gsub( /_\$+$/, '' );
      if( s =~ /^[\d].*/ )then
              s = "v_#{s}" # leading digit
      end
      return s
end

def basicCensor( s )
        s = s.
        strip.
        downcase.        
        gsub( /[ \-,\t–]/, '_' ).
        gsub( /[=\:\)\('’‘]/, '').
        gsub( /[";:\.\?\*”“]/, '' ).
        gsub( /__/,'_').
        gsub( /__/,'_').
        gsub( /__/,'_').
        gsub( /_$/, '' ).
        gsub( /^_/, '' ).
        gsub( /^_/, '' ).
        gsub( /\//, '_or_' ).
        gsub( /\&/, '_and_' ).
        gsub( /\+/, '_plus_' ).
        gsub( /_\$+$/, '' );
        if( s =~ /^[\d].*/ )then
                s = "v_#{s}" # leading digit
        end
        return s
end



#
#
# @param includeThis - array of items from hash to include - all if nil
#
def safeSum( hash, includeThis=nil )
        x = 0.0;
        hash.each(){
                |k,v|
                if( (includeThis == nil) or ( includeThis.include?( k ) )) then 
                        # if v is number
                        # print "k=#{k} v=#{v} x=#{x}";
                        if( ( v != nil ))then 
                                x += v;
                        end;
                end;
        }
        # print "final x = #{x}\n\n";
        return x;
end;
#
#
# @param excludeThis - array of items from hash to include - all if nil
#
def sumExcluding( hash, excludeThis=nil )
        x = 0.0;
        hash.each(){
                |k,v|
                if( (excludeThis.nil?) || ( excludeThis.index( k ).nil? )) then 
                        # if v is number
                        if( ( v != nil ) and (v.instance_of? Numeric))then 
                                x += v;
                        end;
                end;
        }
        return x;
end;

#
# divides top by bottom unless top is zero or anything is null, in which case return zero.
# @param top
# @param bottom
# @return top divided by bottom unless top is zero or anything is null, in which case return zero
#
def safeDivide( top, bottom )
        if( (top == nil) or ( bottom == nil ) or ( bottom == 0.0 )) then
                return 0.0;
        end
        return top/bottom;
end;

        # 
        # see: http://onestepback.org/index.cgi/Tech/Ruby/RubyBindings.rdoc
        #
        def formatParamsxx( str, *params )
           begin
                   p = 0;
                   aa = nil
                   _0 = nil;
                   mybinding = binding();
                   RAILS_DEFAULT_LOGGER.debug "parameter #{aa} ";
                   params.each{
                           |aa|
                           if( aa.instance_of? Integer ) || (  aa.instance_of? Fixnum ) then
                                   eval "_#{p} = iformat( aa );" ,mybinding ;
                                   #puts "evaluated ";
                           elsif( aa.instance_of? Float ) then
                                   eval "_#{p} = nformat( aa );" ,mybinding;
                                   #puts "evaluated as fixnum";
                           elsif( aa.instance_of? Array ) then
                                   eval "_#{p} = commify_series( aa );" ,mybinding;
                                   #puts "p[#{p}] ; evaluated as "+commify_series( aa )
                           elsif( ! aa.nil? ) 
                                   eval "_#{p} = aa.to_s;" ,mybinding;
                           else
                                   eval "_#{p} = ''" ,mybinding;
                           end
                           p += 1;
                           #puts " p = #{p} #{aa.class}";
                   }
                   return eval( '"' + str + '"' ,mybinding );
           rescue
                return str;
           end
       end


class Message

        attr_reader :source, :priority, :type, :messageKey, :parameters;
        
        def to_s
               s = "source #{@source} priority #{@priority} messageKey #{@messageKey} params::";
               @parameters.each{
                       |param|
                       s += " |" + param.to_s+ "|";
               }
               s
        end
   
        #      
        # @param id - messages should considered identical to any other with the same id
        # @param source - the class/method whatever setting this message
        # @param priority
        # @param type
        # @param messageKey either the message itself or a key to the message in a resource file
        #
        def initialize( _source, _priority, _type, _messageKey, *_params )
                @source = _source; 
                @priority = _priority; 
                @type = _type; 
                @messageKey = _messageKey;
                @parameters = _params.clone(); 
        end;
        
        def getBinding 
                return binding() 
        end 
        
        def format()
                str = ''
                if( ! @messageKey.nil? ) then
                        str = _( @messageKey+'_text' ); 
                        if( ! @parameters.nil? )then
                             str = formatParams( str ) #, @parameters )
                        end
                end
                return str;
        end
        
        private
        
        #%q{"Miles Davis".sub(/iles/, '.')} 
        
        

        def formatParams( str )
           begin
                   p = 0;
                   aa = nil
                   _0 = nil;
                   RAILS_DEFAULT_LOGGER.debug "parameter #{aa} ";
                   @parameters.each{
                           |aa|
                           RAILS_DEFAULT_LOGGER.debug "parameter #{xx}";                  

                           if( aa.instance_of? Integer ) || (  aa.instance_of? Fixnum ) then
                                   eval "_#{p} = iformat( aa )" ;
                                   #puts "evaluated ";
                           elsif( aa.instance_of? Float ) then
                                   eval "_#{p} = nformat( aa )";
                                   #puts "evaluated as fixnum";
                           elsif( aa.instance_of? Array ) then
                                   eval "_#{p} = commify_series( aa );";
                                   #puts "p[#{p}] ; evaluated as "+commify_series( aa )
                           elsif( ! aa.nil? ) 
                                   eval "_#{p} = aa.to_s" ;
                           else
                                   RAILS_DEFAULT_LOGGER.debug "parameter is nil";                  
                                   eval "_#{p} = ''";
                           end
                           p += 1;
                           #puts " p = #{p} #{aa.class}";
                   }
                   return eval( %q{ str } );
           rescue
                return str;
           end
       end
end

class MessageList

        attr_reader :messages;
        
        def hasMessages
                (( ! @messages.nil? ) && ( @messages.size() > 0 ))
        end
        
        #
        # @return a list of formatted versions of all our messages, one per line.
        #
        def dump
                s = ''
                @messages.each{
                      |mess|
                      s += mess.format+"\n";  
                }
                s
        end

        #
        # @param sources array of sources to check
        # @param priorities
        # @param types
        # @return array of matching messages.
        def getMatchingMessages( sources=nil, priorities=nil, types=nil )
                matching = Array.new();
                @messages.each(){
                        |message|
                        if( (sources != nil ) && ( ! sources.include?( message.source ))) then
                                next;
                        end;
                        if( (priorities != nil ) && ( ! priorities.include?( message.priority ))) then
                                next;
                        end;
                        if( (types != nil ) && ( ! types.include?( message.type ))) then
                                next;
                        end;
                        matching << message;
                }
                return matching;
        end;

        def addMessage( source, priority, type, messageKey, *params )
                RAILS_DEFAULT_LOGGER.debug "addMessage; params = (#{ params.join( ',' )} )";
                @messages << Message.new( source, priority, type, messageKey, params );
        end;
        
        def initialize()
                @messages = Array.new();
        end;
        
        def clear
                @messages = Array.new(); 
        end
end;

#
# @param s string in the form 1992 Q1 (space, cap optional) or 199201
# @return this as Date
#
def qDate( s )
        date = nil
        if( s =~ /([0-9]{2,4}) *[Qq]([1-4])/) or
          ( s =~ /([0-9]{4,4})0([1-4])/) then
                m = 1 + ($2.to_i()-1)*3
                y = $1.to_i();
                date = Date.new( y, m, 1 );
        end
        return date;
end

def setToString( set )
        # eglish only
        s = '';
        set.size.times{
                |p|
                
        }
end


#
# add 3 months to a date
# @param date ==Date
# @return day 1 of month 3 months from start of month in Date.
def nextQuarter( date )
        m = date.month;
        y = date.year;
        m += 3;
        if( m > 12 ) then
                m -= 12;
                y += 1;
        end;
        return Date.new( y, m, 1 );
end

#
# subtract 3 months from a Date
# @param date ==Date
# @return day 1 of month 3 months before start of month in Date.
def prevQuarter( date )
        m = date.month;
        y = date.year;
        m -= 3;
        if( m < 1 ) then
                m += 12;
                y -= 1;
        end;
        return Date.new( y, m, 1 );
end

def quarterStartMonth( q )
      case q
        when 1 then 1
        when 2 then 4
        when 3 then 7
        when 4 then 10
      end
end

def getQuarter( date )
        q = 1
        case date.month
                when 1...3 then q = 1;
                when 4...6 then q = 2;
                when 7...9 then q = 3;
                when 10...12 then q = 4;
        end
        return q;
end

def quartersBetween( startY, startQ, endY, endQ )
        return 4*(endY - startY) + 1 + ( endQ - startQ );
end

#
# @param date - a Date
# @return for example, 2005 Q3 or 1992 Q1
# 
def dateToQString( date )
        q = getQuarter( date );
        "#{date.year} Q#{q}"        
end



def toIndex( anArray )
        out = Array.new();
        if( anArray[0] != 0.0 )then
                anArray.each(){
                        |v|
                        out << (v.to_f/anArray[0].to_f);
                }
        end
        return out;      
end;

#
# from: http://pleac.sourceforge.net/pleac_ruby/arrays.html
#
def commify_series(arr)
    return '' if not arr
    out = ''
    case arr.size
        when 0 then out = ''
        when 1 then out = arr[0]
        when 2 then out = arr.join(' and ')
        else out = arr[0..-2].join(', ') + ', and ' + arr[-1].to_s
    end
    return out
end

def min( *a )
        return a.min();
end;

def max( *a )
        return a.max();
end;


def saveObjectTo( filename, something )
        data = Marshal.dump( something );
        f = File.open( filename, 'w' );
        f << data;
        f.close();
end

def restoreObjectFrom( filename )
        f = File.open( filename, 'r' );
        data = f.read();
        f.close();
        return Marshal.load( data );
end


# make a pdf file using an external call to FOP.
# fop should be in FOP_PATH
#
#@param xml - xml text dump (for example xmlobj.to_s 
#@param stylesheetPath - the name of the ss you want to use.
#@return pdf output in binary
def makePDF( stylesheetPath, xml )
        pdfFile = Tempfile.new("pdf");
        xmlFile = Tempfile.new("xml");
        dmpFile = Tempfile.new("dump" );
        RAILS_DEFAULT_LOGGER.debug( " makePDF; xml is #{xml} " ); 
        xmlFile.write( xml );
        xmlFile.close();
        cmd = FOP_PATH+" -xml #{xmlFile.path} -xsl #{stylesheetPath} -pdf #{pdfFile.path} &> #{dmpFile.path}";
        RAILS_DEFAULT_LOGGER.debug( " makePDF; command is #{cmd} " );
        # see: file:/home/graham_s/ruby/docs/www.rubycentral.com/book/tut_threads.html
        IO.popen( cmd ) { 
                |f| 
                RAILS_DEFAULT_LOGGER.debug( "command output is #{f.gets}" ); 
        }
        pdf = pdfFile.read();
        pdfFile.close();
        RAILS_DEFAULT_LOGGER.debug( " output dump is " + dmpFile.read() );
        dmpFile.close();
        return pdf
end;

#
# format a number in the current locale and one dp (FIXME: UK jammed on!)
#
def nformat( n )
        # FIXME by locale
        return numberFormat( n, ',','.', 1 );
end

def pctFormat( n )
        s = '';
        if( n != nil )then
                s = numberFormat( 100.0*n, ',','.', 1 )+"%";
        end;
        return s;
end
#
# format a number in the current locale and one dp (FIXME: UK jammed on!)
#
def iformat( n )
        # FIXME by locale
        return numberFormat( n, ',', nil, nil );
end
 
#
# FIXME: must be in standard library somewhere? Or i8in code?
# stolen from 
def numberFormat( number, separator = ',', decimal_point = nil, prec=2 )
     prefix='';
     if( number < 0 )then
        number *= -1.0;
        prefix = '-';
     end
     if( (decimal_point == nil) or (prec == 0)) then
        num_parts = [ number.to_i.to_s ];
     else
        num_parts = sprintf( "%0.#{prec}f", number ).split('.')
     end
     x = num_parts[0].reverse.scan(/.{1,3}/).join(separator).reverse 
     x << decimal_point + num_parts[1] if num_parts.length == 2 
     return prefix+x 
end


def validateNumber( string, min=nil, max=nil )
        error = "This is not a valid number.";
        if( ! string.nil? ) and ( string.length() > 0) then
                string = string.strip();
                if( string =~ /^-?([0-9]*\.)?[0-9]+$/ )then
                        n = string.to_f();
                        error = nil;
                        error = "This should be at least #{min}." if(( ! min.nil? ) and ( n < min ));
                        error = "This should be no more than #{max}." if(( ! max.nil? ) and ( n > max ));
                end;
        end
        RAILS_DEFAULT_LOGGER.debug "validate number checked string #{string} created error #{error}"
        return error;
end


#
# restore a serialised class from a file. It should
# have been the only thing written there
#
def restoreSerialised( handle, key )
        obj = nil
        data = handle[ key ];
        obj = Marshal.load( data )
        return obj
end
#
# store a serialised class in a db
# handle - berkely handle
# key - key to store into
# klass thing to serialise
def storeSerialised( handle, key, klass )
       s = Marshal.dump( klass )
       handle[ key ] = s;
end

def zeroStruct( s )
        s.members.each{
                |k|
                s[k] = 0.0
        }
end


#
# print a structure with cols columns each of width 2xwidth
# return pretty printed cols
def structToS( struct, width=20, cols=4 )
        col = 0
        s = ''
        struct.members.each{
                |k|
                ks = k.to_s.ljust( width )
                vs = struct[k].to_s.rjust( width )
                s += ks+vs+"  "
                col += 1
                if( col == cols )
                        s += "\n"
                        col = 0
                end
        }     
        return s
end

#
# Convert reals into the only format that ada likes (x.xx) with the point and a leading
# number required. Replace nils, mv chanacters or blanks with missing value indicators. Replace dates
# in the format dd/mm/yy with ddmmyy.
# 
def cleanupRealNumberToAda( item )
      if(( (not item.nil? ) and ( item.length > 0 )))then ## not just blanks or missing value indicator
              if( item[0,1] == "." ) then
                      item = '0' + item; ## ada needs a leading 0 in decimal numbers
              elsif( item =~ /\-\.(.*)/ ) then ## a negative like "-.03" ; make it -0.03
                      item = "-0."+$1;
              elsif( not item =~ /[0-9]+\.[0-9]+/ ) then
                      item += '.0'       ### .. and a trailing .0 if not othewise there.
              end;
      else
              item = 0.0
      end
      return item.gsub( /,/, '_' );
end;

#
# if line = '1,2,3' and positionsToKeep = [0,2] then output '1,3'
# @param line - delimited line 
# @param positionsToKeep - array of integers
# @return string
#
def editDelimitedLine( line, positionsToKeep, delim = ',')
        a = CSV.parse_line( line )
        ac = []
        n = a.length()
        n.times{
                |i|
                if positionsToKeep.include?( i ) then
                        ac << a[i]
                end
        }
        return ac.join( delim )
end

#
# a little class which matches strings against a set of regular expressions
# each regexp is iterpreted as matching an entire string (^ and $ are added automatically
# and matches case-insensitively
#
class CRM114
                
        def reset( )
                @regeps = []
                @modes = []
        end
        
        # def switchMode()
                # @excludeMode = ( not @excludeMode )
        # end
        
        def length()
                return @regeps.length()       
        end
        
        #
        # load an array of strings, clearing any existing ones
        #
        def loadAll( lines )
                self.reset()
                mode = true
                lines.each{
                        |line|
                        if line =~ / *mode *= *([a-zA-Z]+) */ then
                                if $1 != 'include' and $1 != 'exclude' then
                                        raise "CRM114 mode non 'exclude' or 'include' was |#{$1}"
                                end
                                mode = $1 == 'include'
                        else
                                line.strip!
                                puts "CRM114.loadAll; adding |#{line}| as regexp\n"
                                @regexps << Regexp.new( '^'+line+'$', Regexp::IGNORECASE )
                                @modes << mode
                        end
                }
        end
        
        #
        # load from a file, clearing any existing regexps
        # file should have 1 regexp per line
        #
        def fromFile( filename )        
                lines =  IO.readlines( filename )
                loadAll( lines )
        end

        #
        # @param tokens - array of strings
        # @return a list of positions of tokens which match any of our regeps
        #
        def getPositions( tokens )
                a = []
                n = tokens.length()
                n.times{
                        |i|
                        a << i if self.matches( tokens[i] )

                }
                return a
        end
        
        #
        # @param keys an array of new regexps to the existing ones
        #
        def add( keys, mode = 'include' )
                bmode = mode == 'include'
                keys.each{
                        |key|
                        @regexps << Regexp.new( '^'+key.strip()+'$', Regexp::IGNORECASE )
                        @modes << bmode
                }        
        end
        
        def initialize( excludeMode = false )
                @regexps = []
        end
       
        def matches( target )
                return true if @regexps.length() == 0
                # see: https://www.ruby-forum.com/topic/171339
                n = @regexps.length
                if( @modes.length != n )then
                        raise "CRM114 num modes (#{@modes.length}) doesn't match num regexps |#{n}|"                
                end
                default_match = ! @modes[0] # i.e default to not match if mode=include, match if mode=exclude
                match = default_match
                n.times{
                        |p|
                        mode = @modes[p]
                        if mode != default_match 
                                default_match = match # default is what we've found so far
                        end
                        re = @regexps[p]
                        if target =~ re then
                                match = mode
                                found = true
                        end
                }
                #if not found then
                #        match = default_match
                #end
                #inc =  @regexps.any?{ |regexp| target =~ regexp }
                #return @excludeMode ^ inc # xor
                return match
        end
        
end

#
#@param infileName - rectangular file delimited by delim
#@parm outfileName - write to this with rows and cols reversed
#@param delim tab, comma, etc.. 
def transposeDelimitedFile( infileName, outfileName, delim )
        inf = File.new( infileName, "r" );
        outf = File.new( outfileName, "w" )
        row = 0
        data = []
        CSV.foreach( inf, { col_sep:delim } ){
                |elements|
                data[row] = elements;
                row += 1
        }
        nRows = row
        nCols = data[0].length()
        nCols.times{
                |col|
                nRows.times{
                        |row|
                        outf.write( data[row][col] );
                        outf.write( delim ) if row < (nRows - 1) 
                }
                outf.write( "\n" )
        }
        outf.close()
        inf.close()                
end

# a_var_this = A_Var_This
def capitalise( s )
        n = s.length
        s[0] = s[0].upcase
        n.times{
                |i|
                if ( s[i] == '_' or s == ' ' ) and i < n then
                        s[i+1] = s[i+1].upcase
                end
        }
        return s
end
