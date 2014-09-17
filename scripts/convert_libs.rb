#
#
#

require 'utils'

INDENT = '   '

ADA_KEYWORD_TRANSLATIONS = { 'ACCESS'=>'X_ACCESS', 'OUT'=>'XXOUT', "MONTH_"=>"MONTH", 
        "others" => "other", "all" => "every", "" => "blank",
        "separate" => "x_separate", "return" => "x_return", "private" => "x_private"};

class EnumEntry
        
        attr_reader :enumType, :string, :value
        
        def initialize( value, string )
                @value = value
                @string = string
                @enumType = censor( string )
        end
end

class EnumeratedType
        
        attr_reader :name, :desc, :enums
        attr_writer :name
        
        def eql?( o )
                return self == o
        end
        
        def == ( o )
                n = o.enums.length
                return true if o.equal?( self ) 
                return false if( o.nil? )
                return false if( not o.instance_of?( self.class ))
                return false if( n != @enums.length )
                n.times{
                        |i|
                        return false if( @enums[i].value != o.enums[i].value)
                        return false if( @enums[i].enumType != o.enums[i].enumType)
                }
                return true                
        end
        
        def initialize( string )
                @desc = string;
                @name = "#{censor( string ).capitalize}" 
                @enums = []
        end

        def writePrettyPrint( deffile, bodyfile )
                deffile.write( "   function Pretty_Print( i : #{@type} ) return String;\n" );
                bodyfile.write( "    function Pretty_Print( i : #{@type} ) return String is\n" );
                bodyfile.write( "    begin\n" );
                bodyfile.write( "         case i is\n" );        
                @enums.each{
                        |enum|
                        bodyfile.write( "             when #{enum.enumType} => return \"#{enum.string}\";\n" );
                }
                bodyfile.write( "             when missing => return \"Null or Missing\";\n" );
                bodyfile.write( "         end case;\n" );        
                bodyfile.write( "         return \"?\";\n" );
                bodyfile.write( "    end Pretty_Print;\n" );
        end
        
        
        def writeEnum( deffile )
                deffile.write( "   type #{@type} is (  \n" );
                deffile.write( "      missing,\n" );
                @enums.each{
                        |enum|
                        deffile.write( INDENT*2 + "#{enum.enumType}" );
                        deffile.write( ",\n" ) unless( enum == enums.last )
                }
                deffile.write( " );\n" );
        end
        
        def writeConvert( deffile, bodyfile )
                deffile.write( "   function Convert_#{@type}( i : String ) return #{@type};\n" );
                 
                bodyfile.write( "    function Convert_#{@type}( i : String ) return #{@type} is\n" );
                bodyfile.write( "    begin\n" );
                p = 0
                @enums.each{
                        |enum|
                        if( p == 0 ) then
                                bodyfile.write "         if i = \"#{enum.value}\" then\n"
                        else
                                bodyfile.write "         elseif i = \"#{enum.value}\" then\n"
                        end
                        bodyfile.write "            return #{enum.enumType};\n"
                        p += 1
                }
                bodyfile.write( "        end if;\n" );
                bodyfile.write  "        return missing;\n"
                bodyfile.write( "    end Convert_#{@type};\n" );
        end
        
end


def makeAdaVarname( varname )
        if( ADA_KEYWORD_TRANSLATIONS.has_key?( varname ))then
                varname = ADA_KEYWORD_TRANSLATIONS[ varname ];
        end
        # e.g.  Pay at 1.9.2007: previous job - we want just 'a year ago'
        if( varname =~ /(.*)\d{1,2}\.\d{1,2}\.\d{4}(.*)/)then
                varname = "#{$1}_a_year_ago_#{$2}"
        end
        
        return censor( varname )
end



