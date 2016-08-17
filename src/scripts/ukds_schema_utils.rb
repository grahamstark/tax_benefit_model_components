#
# very basic thing to parse and store File-level information from UKDS data dictionaries.
# These are usually .rtf files stored in the mrdoc/allissue/ directory.
# 
require 'dbi'
require 'utils'
require 'csv'

def getConnection()
        return DBI.connect('DBI:Pg:msc:localhost', 'msc', 'msc' )
end



FRS_TABLES_THAT_NEED_COUNTERS = [ 'benefits', 'job', 'care', 'benefits', 'govpay', 'oddjob', 'penamt', 'penprov', 'nimigr', 'owner' ]
# note the last 2 are actually SQL keywords
KEYWORD_TRANSLATIONS = { 'access'=>'x_access', 'out'=>'xxout', "month_"=>"month", "grant" => "x_grant", "where" => "x_where", "case" => "x_case", 'both' => 'x_both', 'amount' => 'x_amount', 'type' => 'x_type' };
KEYWORD_TRANSLATIONS_REVERSE = KEYWORD_TRANSLATIONS.invert() 

CONNECTION = getConnection()

DATE   = 100
SERNUM = 99
STRING = 10
AMOUNT = 5
DECIMAL= 4
ENUM   = 3
INT    = 1

DEFAULT_DATE_FORMAT = Regexp.new( '^\s*\d+\/\d+\/\d+\s*$', Regexp::IGNORECASE )
DEFAULT_DATE = '01/01/1900'
# see: http://stackoverflow.com/questions/12117024/decimal-number-regular-expression
DECIMAL_FORMAT = Regexp.new( "^ *[+-]?((\d+(\.\d*)?)|(\.\d+)) *$", Regexp::IGNORECASE )

INSERT_TABLES_STMT = CONNECTION.prepare( "insert into dictionaries.tables( \
        dataset, \
        year, \
        name ) select ?, ?, ?  \
        where not exists \ 
         ( \
            select dataset from dictionaries.tables where dataset = ? and year = ? and name = ? \
         )" )
INSERT_ENUM_STMT = CONNECTION.prepare( "insert into dictionaries.enums( \
        dataset,\
        year, \ 
        tables, \ 
        variable_name, \ 
        value, \ 
        label,
        enum_value ) select ?, ?, ?, ?, ?, ?, ?  \
        where not exists \ 
         ( \
            select dataset from dictionaries.enums where dataset =? and year = ? and tables = ? and 
            variable_name = ? and value = ? \
         )"  )
INSERT_VARIABLE_STMT = CONNECTION.prepare( "insert into dictionaries.variables( \
         dataset,\
         year,\
         tables,\ 
         name, \
         pos,
         var_fmt,\
         measurement_level,
         label,\
         data_type )\
         select ?, ?, ?, ?, ?, ?, ?, ?, ?  \
         where not exists \ 
         ( \
            select dataset from dictionaries.variables where dataset =? and year = ? and tables = ? \
            and name = ? \
         )" )

def fixupField( var, field )
        return '' if field.nil?
        field.strip!
        case var.data_type
        when DATE then
                if not field =~ DEFAULT_DATE_FORMAT then
                        field = DEFAULT_DATE
                end
        when SERNUM | ENUM | INT then
                if field == '' or field.nil? then
                        field = "-1"
                elsif not field =~ /\d+/ then
                        raise "fixupField mismatch - field is |#{field} ; type is #{var.data_type} varname #{var.name}"  
                end
        when STRING then
                # accept anything
        when AMOUNT | DECIMAL
                if field == '' or field.nil? or field == '.' then
                        field = '-1.0'
                else 
                        if field =~ /.*\.$/ then
                                field += ".0"
                        end
                        begin
                                f = Float( field )
                        rescue
                                raise "fixupField mismatch - field is |#{field} ; type is #{var.data_type} varname #{var.name}"  
                        end
                end
        end        
        return field
end

def fixupVariableLine( csvLine, table, varnames = nil, delim = ',' )
        elements = CSV.parse_line( csvLine, { col_sep:delim } )
        varnames = table.variableNames if varnames.nil?
        varnames.each{
                |vname|
                var = table.variables[ vname ]
                pos = var.pos - 1
                elements[ pos ] = fixupField( var, elements[ pos ] )
        }
        return elements.join( delim );
end

#

# 
# EVERYTHING_FOR_TABLE_ALL_YEARS_STMT = CONNECTION.prepare(
# "select 
        # dictionaries.variables.pos, 
        # dictionaries.variables.label,
        # dictionaries.variables.name, 
        # dictionaries.variables.type, 
        # dictionaries.enums.value, 
        # dictionaries.enums.enum_value, 
        # dictionaries.variables.pos 
# from 
        # dictionaries.variables 
# left outer join 
        # dictionaries.enums
# on 
        # dictionaries.enums.variable_name = dictionaries.variables.name 
# where 
        # dictionaries.variables.dataset=?
# and
        # dictionaries.variables.tables=?
# group by 
        # dictionaries.variables.name 
# order by pos" )
# 
# EVERYTHING_FOR_TABLE_ONE_YEAR_STMT = CONNECTION.prepare(
# "select 
        # dictionaries.variables.pos, 
        # dictionaries.variables.label,
        # dictionaries.variables.name, 
        # dictionaries.variables.type, 
        # dictionaries.enums.value, 
        # dictionaries.enums.enum_value, 
        # dictionaries.variables.pos 
# from 
        # dictionaries.variables 
# left outer join 
        # dictionaries.enums
# on 
        # dictionaries.enums.variable_name = dictionaries.variables.name 
# where 
        # dictionaries.variables.dataset=?
# and
        # dictionaries.variables.year=?
# and 
        # dictionaries.variables.tables=?
# order by pos" )
# 
# 
# LOAD_VARIABLE_STMT = CONNECTION.prepare( "select * from variable where dataset=? and year=? and tables=? and name=?" )
# SELECT_ALL_TABLES_STMT =  CONNECTION.prepare( "select distinct name from tables" );
# SELECT_ALL_TABLES_AND_WAVES_STMT =  CONNECTION.prepare( "select name, wave from tables order by wave, name" );

#
# Crude attempt to make a guess at the datatype of each field in a datafile by 
# reading the 1st 500 lines and matching it against '12/1/2014', '0.001', 'fred' 
# and so on. Very imperfect.
#
def inferDataTypes( dataset, year, filename, tablename, single_point_as_dec, nameEditor )
        file = File.new( filename, 'r' );
        line = 0
        maxvals = []
        n = 0
        topline = []
        CSV.foreach( file, { col_sep:"\t" } ){
                |elements|
                line += 1
                if( line == 1 )then
                        topline = elements
                        n = topline.length
                        n.times{
                                |i|
                                maxvals[i] = INT
                        }
                # elsif line >= 500 then
                #        break;
                else
                        i = 0
                        elements.each{
                                |cell|
                                colname = nameEditor.edit( topline[i].downcase() )
                                if colname =~ /.*sernum.*/i then
                                        maxvals[i] = SERNUM 
                                elsif cell =~ /.*\/.*/ then
                                        puts "infering DATE for #{colname}; cell is |#{cell}|\n"
                                        maxvals[i] = [ maxvals[i], DATE ].max()       
                                elsif cell =~ /.*["'`a-z].*/i then
                                        maxvals[i] = [ maxvals[i], STRING ].max()       
                                elsif cell =~ /[0-9]+\.[0-9]$/ and single_point_as_dec then 
                                        # FIXME exactly one point as decimal XX,1; 
                                        # this is in HSE for industry codes and so on but probably not general
                                        puts "infering DECIMAL for #{colname}; cell is |#{cell}|\n"
                                        maxvals[i] = [ maxvals[i], DECIMAL ].max()     
                                elsif cell =~ /[0-9]+\.[0-9]+/ or cell =~/^\.[0-9]+/ or cell =~ /^[0-9]\.$/ then
                                        puts "infering AMOUNT for #{colname}; cell is |#{cell}|\n"
                                        maxvals[i] = [ maxvals[i], AMOUNT ].max() 
                                        # FIXME should we blow up if remainder not obviously an integer?
                                else # int of some kind - check for extreme values
                                        x = cell.to_f()
                                        if( x > 2147483647.0 ) or ( x < -2147483648.0 )then # out of postgres integer range
                                                puts "inferring SERNUM for #{colname}; cell=|#{cell}|\n"
                                                maxvals[i] = [ maxvals[i], SERNUM ].max() 
                                        end
                                end # ignore enums for now
                                i += 1
                        } 
                end
        }
        file.close()
        connection = getConnection()
        n.times{
                |i|
                if maxvals[i] != INT then # since we default to INT anyway
                        colname = nameEditor.edit( topline[i].downcase() )
                        puts "changing #{} to #{maxvals[i]}\n"
                        puts "#{maxvals[i]} #{dataset}, #{tablename}, #{year}, #{colname}\n"
                        updateVarType( maxvals[i], dataset, tablename, year, colname, connection )                 
                        # statement.execute( maxvals[i], dataset, tablename, year, colname )                 
                end
        }
        connection.disconnect()
end

def updateVarType( dataType, dataset, tableName, year, colname, connection = nil )
        if connection.nil? then
                connection = getConnection() 
                local = true
        else
                local = false
        end
        statement = connection.prepare( "update dictionaries.variables set data_type=? where dataset=? and tables=? and year=? and name=? and data_type < ?" )
        statement.execute( dataType, dataset, tableName, year, colname, dataType ) 
        connection.disconnect() if local
end

#
# @param colpatt e.g. sic%
#
def updateVarGroup( dataType, dataset, tableName, colpatt, connection = nil )
        if connection.nil? then
                connection = getConnection() 
                local = true
        else
                local = false
        end
        statement = connection.prepare( "update dictionaries.variables set data_type=? where dataset=? and tables=? and name like ? and data_type < ?" )
        statement.execute( dataType, dataset, tableName, colpatt, dataType ) 
        if local then
                connection.disconnect()
        end
end 

# @nameEdit - a class with 1 method - edit( the varname )
#
def readOneRTF( dataset, year, filename, tablename, nameEdit = nil )
        f = File.new( filename, 'r' );
        # tablename = File.basename( filename, ".txt" )
        INSERT_TABLES_STMT.execute( dataset, year, tablename, dataset, year, tablename )
        data_type = INT
        inserted = []
        varname = ''
        pos = 0
        varname = ''
        label = ''
        f.each_line{
                |line|
                # \S = non whitespace \s=whitespace \d=digit
                if( line =~ /.*Pos\..*=[\s]*([0-9]+)[\t ]*Variable.*=[\s]*([\S]+)[\s]*Variable.*label.*=(.*)/i ) then
                        puts "variable line |#{line}|"
                        #Pos. = 1	Variable = RPNO	Variable label = Person number   
                        pos = $1.to_i
                        varname = basicCensor( $2 ) #.downcase
                        label = $3.strip
                        if not nameEdit.nil? then
                                puts "before name edit |#{varname}|"
                                varname = nameEdit.edit( varname ) 
                                puts "after name edit |#{varname}|\n"
                        end
                        if( varname == 'pid' )then
                                data_type = SERNUM # flag for index data_type
                        else
                                data_type = INT
                        end
                        puts "varname=|#{varname}| pos |#{pos}| label=|#{label}| tablename |#{tablename}\n"
                elsif line =~ /.*This variable is[\s]*([\w]+).*the SPSS measurement level is[\s]*([\w]+)/i then
                        var_fmt = $1
                        measurement_level = $2
                        puts "var_fmt |#{var_fmt}| measurement_level |#{measurement_level}|\n"
                        if not inserted.include?( varname )then                                
                                INSERT_VARIABLE_STMT.execute( dataset, year, tablename, varname, pos, var_fmt, measurement_level, label, data_type,
                                                              dataset, year, tablename, varname )
                                inserted << varname
                        end
                elsif line =~ /.*This variable is *'other'.*/i or line =~ /.*Value label information for.*/i then # this turns up in WAS e.g. DisType8W1 and elsa_data_v3
                        var_fmt = 'numeric'
                        measurement_level = 'scale'
                        if not inserted.include?( varname )then
                                INSERT_VARIABLE_STMT.execute( dataset, year, tablename, varname, pos, var_fmt, measurement_level, label, data_type,
                                        dataset, year, tablename, varname )
                                inserted << varname
                        end
                elsif line =~ /Value\s*=\s*([0-9\-]+)\.?[0-9]*+\s*Label\s*=(.*)/i then
                        value = $1.to_i
                        label = $2.strip
                        enum_value  = basicCensor( label )
                        puts "value = |#{$1}| label=|#{label}| enum_value=|#{enum_value}|\n"
                        INSERT_ENUM_STMT.execute( dataset, year, tablename, varname, value, label, enum_value, 
                                                  dataset, year, tablename, varname, value );
                end
        }
        f.close
end


class EnumEntry

        attr_reader :value, :label #, :enumValue;
 
        def initialize( value, label )
                @value = value
                @label = label.gsub( /"/, "'") # avoid quotes in strings
                # note that these transformations should alread have been done
                # but are repeated simply becuase some were missed when creating the
                # db and loading the db is slow
                #enumValue = basicCensor value )
                #if( enumValue =~ /^[0-9_](.*)$/i )then
                #        enumValue = "s_" + enumValue
                #end
                #@enumValue = enumValue
        end
        
end

#
# make any needed name changes (to avoid clashes with Ada or SQL) and downcase all names
#
def makeCensoredVarname( varname )
        varname = basicCensor( varname )
        if( KEYWORD_TRANSLATIONS.has_key?( varname ))then
                varname = KEYWORD_TRANSLATIONS[ varname ];
        end
        return varname
end

#
# make any needed name changes (to avoid clashes with Ada or SQL) and downcase all names
# @param csvString - csv demimited string
# @return a censored csv string
def makeCensoredVarList( csvString )
        a = CSV.parse_line( csvString );
        n = a.length()
        n.times{
                |i|
                a[i] = makeCensoredVarname( a[i] )
        }
        return a.join( ',' );
end

class Variable

        attr_reader :enums, :name, :label, :data_type, :pos, :measurementLevel, :missingValues, :varFmt, :adaVarname, :adaType; 
        attr_writer :enums, :missingValues, :adaType;
        
        def initialize( name, pos, varFmt, measurementLevel, label, data_type )
                # @name = makeSQLVarname( name )
                @varFmt = varFmt
                @label = label
                @measurementLevel = measurementLevel
                # puts "data_type #{data_type}"
                @data_type = data_type;
                @pos = pos
                @enums = []
                @missingValues = Array.new
                @name = makeCensoredVarname( name )
         end
         
         def enumsInSortOrder()
                return @enums.sort{ | a, b | a.value <=> b.value  }
         end
         
         def addEnum( value, label )
                e =  EnumEntry.new( value, label ) 
                i = @enums.index( e )
                if( i.nil? )then
                        @enums << e
                else
                        @enums[i].addValue( value );
                end
         end
         
         def addMissingValue( mv )
                 @missingValues << mv.to_i
         end
         
         def to_s()
                 "name = |#{@name}| label = |#{@label}| data_type = |#{@data_type}| pos = |#{@pos}| measurementLevel = |#{@measurementLevel}| missingValues = |#{@missingValues}| varFmt = #{@varFmt}\n" 
         end
         
         def to_str()
                 to_s()
         end
   
end

def getExtraFieldsForTable( dataset, tableName, includeKeyFields = false )
        ourVariables = []
        ourVariables += [ 'user_id', 'edition', 'year' ] if includeKeyFields
        case dataset 
        when'frs' then
                if FRS_TABLES_THAT_NEED_COUNTERS.include?( tableName )then
                        ourVariables << 'counter'
                end
        when 'elsa' then
                 
        when 'was' then
                ourVariables << 'combined_case'
                ourVariables << 'combined_person' if tableName == 'person'
        when 'hse' then
                
        end
        return ourVariables;
end



def makePostgresLoadStatement( dataPath, dataset, table, crm114 )
        tableName = table.tableName.downcase
        year = table.year
        ourVariables = getExtraFieldsForTable( dataset, tableName, true )
        ourVariables += table.getVariableNames( crm114 )
        variables = ourVariables.join( ",\n         " )
        tab_file_name = "#{dataPath}#{year}/postgres_load_files/#{tableName}.csv" 
        return "copy #{dataset}.#{tableName}( \n #{variables} \n ) from \n'#{tab_file_name}' with CSV header;\n"
end


def mergeTables( t1, t2 )
        t3 = Table.new( t2.dataset, t2.year, t2.tableName )
        t3.variableNames = ( t1.variableNames + t2.variableNames ).uniq()
        puts "mergeTables; got variable names as #{t3.variableNames}"
        t3.variableNames.each{
                |vname|
                if( t1.variables.has_key?( vname )) then
                        v1 = t1.variables[ vname ]
                        t3.variables[ vname ] = v1
                        if( t2.variables.has_key?( vname ) )then
                                v2 = t2.variables[vname]
                                if( v2.data_type >= v1.data_type )then
                                        t3.variables[ vname ] = v2
                                else
                                        t3.variables[ vname ] = v1
                                end
                        end
                else
                        t3.variables[ vname ] = t2.variables[ vname ]
                end
        }
        return t3;
end

class Table
        attr_reader :year, :dataset, :tableName, :variables, :variableNames;
        attr_writer :year, :dataset, :tableName, :variables, :variableNames;
        
        #
        # list of likely file columns (from zero, not 1 as in the dictionaries) 
        # in a ukds file for variables with given names (must match exactly)
        # @param varlist - list of variables to find
        # @return positions ( UKDS positions - 1 )
        def positions( varlist )
                positions = []
                varlist.each{
                        |vname|
                        positions << @variables[vname].pos - 1
                }
        end
        
        def getVariableNames( crm114 = nil )
                return @variableNames if crm114.nil? 
                varnames = []
                @variableNames.each{
                        |varname|
                        varnames << varname if crm114.matches( varname )        
                }
                return varnames
        end
        
        def highestDataType
                maxtype = INT
                @variables.each{
                        |var|
                if( var.data_type > maxtype )then
                maxtype = var.datatype
                end
                }
                return maxtype
        end
        
        def initialize( dataset, year, tableName )
                @year = year
                @dataset = dataset
                @variables = Hash.new   
                @variableNames = Array.new
                @tableName = tableName
        end        
end

def loadTable( dataset, year, tableName )
        tab = Table.new( dataset, year, tableName )
        puts "on table #{tableName}\n"
        stmt = "select * from dictionaries.variables where dataset='#{dataset}' and tables='#{tableName}' and year=#{year} and pos > 0 order by pos  "
        print stmt
        connection = getConnection()
        rs = connection.execute( stmt )
        rs.fetch_hash{
                |res|
                var = Variable.new( 
                        res['name'], 
                        res['pos'].to_i(), 
                        res['var_fmt'], 
                        res['measurement_level'], 
                        res['label'], 
                        res['data_type'] )
                # var.adaType = getAdaType( tableName, var )
                enumStmt = "select value, label from dictionaries.enums where dataset='#{dataset}' and year=#{year} and tables='#{tableName}' and variable_name = '#{var.name}'  order by value"
                ers = connection.execute( enumStmt )
                if( ers.rows() > 0 )then
                        ers.fetch_hash{
                                |eres|
                                value = eres['value'].to_i
                                if( value >= 0 )then
                                        label = eres['label'] 
                                        puts "add enum |#{value}| = |#{label}|\n"
                                        var.addEnum( value, label )
                                else
                                        puts "added #{value} as a missing value\n"
                                        var.addMissingValue( value )     
                                end
                                
                        }
                end
                puts "made variable #{var}\n"
                tab.variableNames << var.name
                tab.variables[ var.name ] = var
        }
        connection.disconnect
        return tab
end
# 
# def loadTable( dataset, year, tableName )
        # tab = Table.new( dataset, year, tableName )
        # puts "on table #{tableName}\n"
        # rs = Array.new
        # if( year.nil?)then
                # EVERYTHING_FOR_TABLE_ALL_YEARS_STMT.execute( dataset, tableName )
                # EVERYTHING_FOR_TABLE_ALL_YEARS_STMT.fetch_hash(){
                        # |r|
                        # rs << r
                # }
        # else
                # EVERYTHING_FOR_TABLE_ONE_YEAR_STMT.execute( dataset, year, tableName )
                # EVERYTHING_FOR_TABLE_ONE_YEAR_STMT.fetch_hash(){
                        # |r|
                        # rs << r
                # }
        # end
        # rs.each{
                # |res|
                # # puts "res = ";p  res
                # var = Variable.new( 
                                     # tableName,
                                     # res[ 'name' ], 
                                     # res[ 'var_fmt'], 
                                     # res[ 'label' ], 
                                     # res[ 'data_type' ], 
                                     # res[ 'pos' ],
                                     # tab.variableNames )
                # tab.variableNames << var.name
                # if( not tab.variables[ var.name ].nil? )then
                        # puts "duplicate name #{var.name}; halting"
                        # Process.exit
                # end
                # tab.variables[ var.name ] = var
                # if( var.data_type == AMOUNT ) or ( var.data_type == INT ) then # numeric -- get missing values
                         # GET_MISSING_VALUES_STMT.execute( tableName, res['name'] ) 
                         # GET_MISSING_VALUES_STMT.fetch_hash{
                                 # |m|
                                 # var.addMissingValue( m['value'] )
                         # }             
                # end
        # }
        # return tab
# end

def makeRecodingTemplate( var )
        mapStmts = []
        vname = var.name #.downcase      
        mapStmts << "#\n# -- Mapping for #{vname} (#{var.label})\n#\n"
        terms = []
        var.enums.each{
                |enum|
                terms << "(#{vname} == #{enum.value} )*XXX"
        }
        mapStmts << "series #{vname}_mapped = ( " + terms.join( " + ") + " )"
        mapStmts << "#{vname}_mapped = misszero( #{vname}_mapped )" 
        mapStmts << "setinfo #{vname}_mapped --description=\"Recoded Variable: #{var.name} : #{var.label}\" (NOTE: all missing values coded as zero)"
        return mapStmts
end

def makeAllMissingValues( dataset, year )
        stmt = "select distinct value from dictionaries.enums where dataset='#{dataset}' and year=#{year} and cast(value as integer ) < 0 ";
        connection = getConnection()
        rs = connection.execute( stmt )
        mvs = []
        rs.fetch_hash{
                |res|
                mv = res['value']
                mvs << "setmiss #{mv}"
        }
        return mvs        
end

def makeGretlDummies( var )
        enumStmts = []
        var.enums.each{
                |enum|
                p enum
                enumName = basicCensor( enum.label )
                vname = basicCensor( var.name ) #.downcase
                dummyName = "#{vname}_#{enumName}".slice( 0 .. 30 )
                enumStmts << "genr #{dummyName} = #{vname} == #{enum.value}"
                enumStmts << "setinfo #{dummyName} --description=\"Dummy Variable: #{var.name} : #{enum.label} (variable=#{var.name}, value=#{enum.value})\""
        }
        return enumStmts
end

def makeGretlDummyList( table )
        enumStmts = []
        p table
        table.variableNames.each{
                |varname|
                var = table.variables[varname]
                puts "on varname #{varname}\n"
                enumStmts << "#\n# -- Dummy Variables for #{varname} (#{var.label})\n#\n"
                enumStmts.concat( makeGretlDummies( var ))  
                enumStmts << "\n"
        }            
        return enumStmts
end

def writeAdaEnumHeader( deffile, table )
        deffile.write( "   --\n   -- derived from dataset: #{table.dataset} table: #{table.tableName}\n" ); 
end

#
# typedecs - set of 'amount' 'boolean' 'list' 'set'
#
def makeOneAdaEnum( deffile, bodyfile, var, typedecs, enumName = nil )
        if enumName.nil? then
                enumName = capitalise( basicCensor( var.name )) + "_Type"  
        else
                deffile.write( "   -- #{enumName} uses variable #{var.name}\n   --\n" )
        end
        deffile.write( "   type #{enumName} is (\n      " );
        entries = []
        var.enumsInSortOrder().each{
                |enum|
                enumItem = censor( enum.label )
                entries << enumItem
        }
        deffile.write( entries.join( ",\n      " ) )
        deffile.write( " );\n" );
        deffile.write( "   
   function To_String( i : #{enumName} ) return String;
   function Convert_#{enumName}( i : Integer ) return #{enumName};
   function Value_Of( i : #{enumName} ) return Integer;\n" )
        if( typedecs.length() > 0 )then
                deffile.write( "
   package #{enumName}_Package is new T_Utils( 
      T            => #{enumName},
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type =>Counter_Type );\n" );
   
                deffile.write( "   subtype #{enumName}_Set is #{enumName}_Package.Set;\n" ) if typedecs.include?( 'set' )
                deffile.write( "   subtype #{enumName}_List is #{enumName}_Package.List; " ) if typedecs.include?( 'list' )
                if typedecs.include?( 'amount' )then
                   deffile.write( "   subtype Abs_#{enumName}_Amount_Array is #{enumName}_Package.Abs_Amount_Array;\n" )
                   deffile.write( "   subtype #{enumName}_Amount_Array is  #{enumName}_Package.Amount_Array;\n" );
                end
                if typedecs.include?( 'boolean' )then
                   deffile.write( "   subtype Abs_#{enumName}_Boolean_Array is #{enumName}_Package.Abs_Boolean_Array;\n" )
                   deffile.write( "   subtype #{enumName}_Boolean_Array is  #{enumName}_Package.Boolean_Array;\n" );
                end
        end
        deffile.write( "\n" );
        bodyfile.write( "
   function To_String( i : #{enumName} ) return String is
   begin
      case i is\n" );        
        var.enumsInSortOrder().each{
                |enum|
                enumItem = censor( enum.label )
                bodyfile.write( "          when #{enumItem} => return \"#{enum.label}\";\n" );
        }
      bodyfile.write( "      end case;        
      return \"?\";
   end To_String;
                
   function Convert_#{enumName}( i : Integer ) return #{enumName} is
   begin
      case i is\n" );
        var.enumsInSortOrder().each{
                |enum|
                enumItem = censor( enum.label )
                bodyfile.write "         when #{enum.value} => return #{enumItem};\n"
        }
        bodyfile.write(  
"         when others => null;
      end case;
   end Convert_#{enumName};
   
   function Value_Of( i : #{enumName} ) return Integer is\
   begin
      case i is \n" );
        var.enumsInSortOrder().each{
                |enum|
                enumItem = censor( enum.label )
                bodyfile.write "         when #{enumItem} => return #{enum.value};\n"
        }
        bodyfile.write( "      end case;\n" );
        bodyfile.write( "   end Value_Of;\n" );        
end

