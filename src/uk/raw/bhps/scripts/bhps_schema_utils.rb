#!/usr/bin/ruby
require 'rubygems'
require 'dbi'
require 'csv'
require 'convert_libs'

TEST_MODE = false

SERNUM = 99
STRING = 10
AMOUNT = 5
ENUM   = 3
INT    = 1

def getConnection()
        if( TEST_MODE )then
                return DBI.connect('DBI:Mysql:bhps_testbed', '', '')
        else
                return DBI.connect('DBI:Mysql:bhps', '', '')
        end
end

CONNECTION = getConnection()

INSERT_WAVES_STMT = CONNECTION.prepare( "insert into waves( wave ) values( ? )" )
INSERT_TABLES_STMT = CONNECTION.prepare( "insert into tables( 
         wave, \
         name ) values( ?, ? )" )
INSERT_ENUM_STMT = CONNECTION.prepare( "insert into enums( \
         wave, \ 
         tables, \ 
         variable_name, \ 
         value, \ 
         label,
         enum_value ) values( ?, ?, ?, ?, ?, ? )" )
INSERT_VARIABLE_STMT = CONNECTION.prepare( "insert into variables( \
         wave, 
         tables,\ 
         name, \
         pos,
         var_fmt,\
         measurement_level,
         label,\
         ada_name,\
         type )\
         values( ?, ?, ?, ?, ?, ?, ?, ?, ? ) " )

LOAD_VARIABLE_STMT = CONNECTION.prepare( "select * from variable where wave=? and tables=? and name=?" )
SELECT_ALL_TABLES_STMT =  CONNECTION.prepare( "select distinct name from tables" );
SELECT_ALL_TABLES_AND_WAVES_STMT =  CONNECTION.prepare( "select name, wave from tables order by wave, name" );

SELECT_DUP_VARS_STMT = CONNECTION.prepare( "select ada_name, name from variables where wave = ? and tables = ? and ada_name = ?" )
ALREADY_DONE_TABLE_STMT    = CONNECTION.prepare( "select * from tables where ( wave=? and name=? )" )
ALREADY_DONE_WAVE_STMT    = CONNECTION.prepare( "select * from waves where ( wave=? )" )
UPDATE_TYPE_STMT = CONNECTION.prepare( "update variables set type = ? where wave=? and tables=? and name=? ")
FINAL_TYPE_STMT = CONNECTION.prepare( "select mtype from final_types where tables=? and name=?" )

ALL_VARIABLES_WITH_ENUMS_STMT = CONNECTION.prepare("select distinct tables,variable_name from distinct_enums" );
ALL_VALUES_FOR_VARIABLE_STMT = CONNECTION.prepare("select * from distinct_enums where variable_name=?" );
ALL_FINAL_MAPPINGS_STMT = CONNECTION.prepare("select distinct enum_type_key, enum_type_name from final_enum_mappings" );
GET_MISSING_VALUES_STMT = CONNECTION.prepare( "select distinct value from enums where value < 0 and tables=? and variable_name=? order by value desc" )
EVERYTHING_FOR_TABLE_ALL_WAVES_STMT = CONNECTION.prepare(
"select 
        variables.pos, 
        variables.label,
        variables.ada_name,
        variables.name, 
        variables.type, 
        final_enum_mappings.enum_type_name, 
        final_enum_mappings.enum_type_key, 
        variables.pos 
from 
        variables 
left outer join 
        final_enum_mappings 
on 
        final_enum_mappings.variable_name = variables.name 
where 
        variables.tables=?
group by 
        variables.name 
order by pos" )

EVERYTHING_FOR_TABLE_ONE_WAVE_STMT = CONNECTION.prepare(
"select 
        variables.pos, 
        variables.label,
        variables.ada_name,
        variables.name, 
        variables.type, 
        final_enum_mappings.enum_type_name, 
        final_enum_mappings.enum_type_key, 
        variables.pos 
from 
        variables 
left outer join 
        final_enum_mappings 
on 
        final_enum_mappings.variable_name = variables.name 
where 
        variables.tables=?
and 
        variables.wave=? 
order by pos" )

PRINT_HEADER_DEF_TEMPLATE = '
   function To_String( a : #{record_name}_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String;
';
   

PRINT_HEADER_TEMPLATE = '
   function To_String( a : #{record_name}_Rec; num_indents : Natural; loop_count : Natural := 0 ) return String is
      s : Unbounded_String;
   begin
      s := s & (num_indents*INDENT) & \" ========== #{record_name}\";
      if( loop_count > 0 ) then
        s := s & \"[ \" & Format( loop_count ) & \" ] \";
      end if;
      s := s & \"=======\" & LINE_BREAK;
'

PRINT_FOOTER_TEMPLATE = '
      s := s & LINE_BREAK;
      return To_String( s );
   end To_String;
   
'

READ_HEADER_TEMPLATE = '
   procedure Create_#{record_name}_Wave_#{wave}( 
      tab_file_name   : String; 
      out_file_name   : String; 
      index_file_name : String ) is
      
      use GNAT.String_Split;
      use Conversions;
      use Ada.Strings.Unbounded;
      package usut renames Ada.Strings.Unbounded.Text_IO;
     
      line        : Unbounded_String;
      tab_file    : Ada.Text_IO.File_Type;
      slices      : Slice_Set;
      index       : #{x_or_not}Index_Rec;      
      index_map   : #{x_or_not}BHPS_Index;
      bin_file    : #{record_name}_IO.File_Type;
      rec         : #{record_name}_Rec;      
      line_number : Natural := 0; -- count 1st line (the header) as 0 and data lines from 1
   begin
      Restore_Complete_Index( index_file_name, index_map ); 
      Ada.Text_IO.Open( tab_file, Ada.Text_IO.In_File, tab_file_name );
      #{record_name}_IO.Create (bin_file, #{record_name}_IO.Out_File, out_file_name );
      while not( Ada.Text_IO.End_Of_File( tab_file ) ) loop
         usut.Get_Line( tab_file, line );
         if( line_number > 0 ) then
            slices := TDA_Tokenize( line );
';
      
LOAD_STATEMENT_TEMPLATE = 
'   Create_#{recordName}_Wave_#{wave}( 
      \"#{tab_file_name}\", 
      \"#{out_file_name}\", 
      \"#{index_file_name}\");
'
         
READ_FOOTER_TEMPLATE = 
'            index := Get_Index( index_map, rec.#{which_id} );
            if( index.pointers( #{record_name}_component ).start_pos = 0 ) then
               index.pointers( #{record_name}_component ).start_pos := line_number;
               index.SERNUM := rec.#{which_id};
            end if;
            index.pointers( #{record_name}_component ).counter := index.pointers( #{record_name}_component ).counter + 1;
            Put_Index( index_map, index );
            #{record_name}_IO.Write( bin_file, rec );
         end if;
         line_number := line_number + 1;
      end loop;
      Ada.Text_IO.Close( tab_file );
      Store_Complete_Index( index_file_name, index_map );
      #{record_name}_IO.Close( bin_file );
   end Create_#{record_name}_Wave_#{wave};

'



#
# Make an Ada record to represent all fields for all waves merged, with sernum and hhseq at the start. ,
# recname - string: Adult,Child, etc.
# variables - array of NameAndType classes, in the order they appear in the output record
#
def makeAdaRecord( recname, table )
        record = INDENT+"type #{recname}_Rec is record\n";
        maxVarWidth = -99;
        maxTypeWidth = -99
        table.variableNames.each{
                |vname|
                var = table.variables[vname]
                misstype = ''
                if( var.type == INT ) then
                        misstype = ':= MISS;            '
                elsif ( var.type == AMOUNT ) then
                        misstype = ':= MISS_R;          '
                elsif( var.type == SERNUM ) then
                        misstype = ":= MISSING_SERNUM;  "
                elsif ( var.type == ENUM )then
                        misstype = ":= #{var.adaType}'First;"
                elsif( var.adaType == 'Ada.Calendar.Time' ) then
                        misstype = ':= BHPS_DEFAULT_DATE;'
                end
                paddedVarname = var.name.ljust(40)
                paddedVartype = var.adaType.ljust(14)
                if( var.adaVarname != "SERNUM") then
                record += INDENT*2+"#{paddedVarname} : #{paddedVartype}#{misstype}  -- #{var.adaVarname} : #{var.label} \n"
                end
        }
        record += INDENT+"end record;\n\n";                
        return record;
end

def makeLoadCallStatement( dataPath, recordName, table )
        tname = table.tableName.downcase
        wave = table.wave
        tab_file_name = "#{dataPath}tab/#{wave}#{tname}.tab" 
        out_file_name = "#{dataPath}bin/#{wave}/#{tname}.bin" 
        index_file_name = "#{dataPath}bin/#{wave}/index.bin"
        return eval( '"' + ::LOAD_STATEMENT_TEMPLATE + '"' );       
end

def createPrintDef( record_name, table )
        return eval( '"' + ::PRINT_HEADER_DEF_TEMPLATE + '"' );
end 

def createPrintFunction( record_name, table )
        procedure = ''
        procedure += eval( '"' + ::PRINT_HEADER_TEMPLATE + '"' );
        
        table.variableNames.each{
                |vname|
                var = table.variables[vname]
                if( var.type == INT ) then
                        procedure += INDENT*2+ "if(( a.#{var.name} /= MISS) or INCLUDE_MISSING ) then\n"
                elsif ( var.type ==  AMOUNT ) then
                        procedure += INDENT*2+ "if(( a.#{var.name} /= MISS_R) or INCLUDE_MISSING ) then\n"
                elsif( var.type == SERNUM ) then
                        procedure += INDENT*2+ "if(( a.#{var.name} /= MISSING_SERNUM) or INCLUDE_MISSING ) then\n"
                elsif( var.adaType == 'Ada.Calendar.Time' ) then
                        procedure += INDENT*2+ "if(( a.#{var.name} /= BHPS_DEFAULT_DATE) or INCLUDE_MISSING ) then\n"
                elsif( var.type == ENUM )then
                        procedure += INDENT*2+ "if(( not Null_Or_Missing( a.#{var.name} )) or INCLUDE_MISSING )then\n"
                end
                procedure += INDENT*3+"s := s & (num_indents*INDENT) & \"#{var.name} (#{var.label}) [#{var.name}] : \"";
                if( var.type != ENUM )then
                       procedure += " & Format(a.#{var.name}) & LINE_BREAK;\n"
                else
                        procedure += " & Pretty_Print(a.#{var.name}) & LINE_BREAK;\n" 
                end       
                procedure += INDENT*2+"end if;\n"                
        }
        procedure += eval( '"' + ::PRINT_FOOTER_TEMPLATE + '"' );
        return procedure
end

def  makeMissingValueClause( var )
        return "" if( var.type > 90 ) or ( var.missingValues.size == 0 )
        mv = ", ( "
        if( var.type == INT )then
                if var.missingValues.size == 1 then
                        mv += " 1 .. 0 => #{var.missingValues[0]}" 
                else
                        mv += var.missingValues.join( ", " )
                end
        elsif( var.type == AMOUNT )then
                if( var.missingValues.size > 1 )then
                        var.missingValues.size.times{
                                |i|
                                s  = '%.1f' % var.missingValues[i]
                                mv += s
                                if( i < (var.missingValues.size-1))then
                                        mv += ", "
                                end
                        }
                else
                        s = '%.1f' % var.missingValues[0] 
                        mv += " 1 .. 0 => #{s}"                        
                end
        end
        mv += " )"
        return mv
end

def createConvertProcedure( record_name, wave, table )
        procedure = ''
        x_or_not = ''
        x_or_not = "X_" if wave == 'X'
        
        procedure += eval( '"' + ::READ_HEADER_TEMPLATE + '"' );
        table.variableNames.each{
                |vname|
                var = table.variables[vname]
                if( var.type != ENUM) then
                        missingValueClause = makeMissingValueClause( var )
                        procedure += '-- ' if( var.name == 'ivid') or ( var.name == 'ivnc'); # comment out code for interviewers which contain characters till we can make a proper fix
                        procedure += INDENT*4 + "rec.#{var.name} := Convert( slices, #{var.pos}#{missingValueClause} );\n";
                
                else
                        procedure += INDENT*4 + "rec.#{var.name} := Convert_#{var.adaType}( Get( slices, #{var.pos} ));\n";
                end                        
        }
        if( wave == 'X' )then # we're indexing by pid for the x-series files
                which_id = "pid"
        else
                which_id = "hid" # and hid otherwise
        end
        procedure += eval( '"' + ::READ_FOOTER_TEMPLATE + '"' );
        return procedure
end

def parseDataTopLine( datapath, tableName )
        filename = datapath+tableName.downcase()+".tab"
        print "opening  #{filename}\n"
        begin
                file = File.open( filename, 'rb' )
                
                CSV::Reader.parse( file, "\t" ){ 
                               |elements|
                               return elements;
                }
        rescue
                print "failed to open #{filename}"
        end
end  

def alreadyDoneThisFile( wave, table )
        ALREADY_DONE_TABLE_STMT.execute( wave, table )
        ALREADY_DONE_TABLE_STMT.fetch_hash{
                |res|
                return true
        }
        return false
end


def alreadyAddedWave( wave )
        ALREADY_DONE_WAVE_STMT.execute( wave )
        ALREADY_DONE_WAVE_STMT.fetch_hash{
                |res|
                return true
        }
        return false
end


def clearForAllWaves()
        query = CONNECTION.prepare("delete from waves" )
        query.execute()
end

# append the actual variable name in cases where making a varname from 
# the label results in a dup
def makeUniqueAdaName( wave, table, adaName, varname )
        SELECT_DUP_VARS_STMT.execute( wave, table, adaName )
        SELECT_DUP_VARS_STMT.fetch_hash{
                |res|
                return "#{adaName}_#{varname}";
        }
        return adaName
end


def inferDataType( filename )
        f = File.new( filename, 'r' );
        tablename = File.basename( filename, ".tab" )
        wave = tablename[ 0, 1 ]
        tablename = tablename[ 1, 99 ]
        names = Array.new
        types = Array.new
        change = Array.new
        row = 0;
        CSV::Reader.parse( f, "\t" ){ 
               |elements|
               col = 0
               elements.each{
                        |cell|
                        if( row == 0 )then
                                names[col] = cell[1,99].downcase
                                types[col] = INT # default to ints
                                change[col] = false
                        else
                                # if( types[col] != SERNUM ) and ( not cell =~ /.*9999.*/ ) and ( not cell[col] =~ /19[(\d]{2}/ )and ( not cell[col] =~ /20[(\d]{2}/ ) and ( not names[col] =~ /.*04/)then
                                        if( cell =~ /.*\..*/ )  then
                                                # or cell.to_f > 500
                                                puts "found float for variable|#{names[col]}| cell=|#{cell}|"
                                                types[col] = AMOUNT  # a float
                                                #elsif( cell =~ /.*[a=z][A-Z].*/)then todo
                                        #        types[col] = STRING
                                        end 
                                # end
                        end
                        col += 1
               }
               row += 1
               # break if row > 2000
        }
        f.close
        names.length.times{
                |col|
                if( types[col] == AMOUNT )then
                        UPDATE_TYPE_STMT.execute( types[col], wave, tablename, names[col] )
                end
        }
end



def getPosInTable( labels, target )
        p = 1
        labels.each(){
                |label|
                return p if( label == target )
                p += 1
        }
        return -1
end        

class EnumEntry

        attr_reader :values, :label, :enumValue;
 
        def initialize( value, label, enumValue )
                @values = Array.new()
                @values << value.to_i
                @label = label.gsub( /"/, "'") # avoid quotes in strings
                # note that these transformations should alread have been done
                # but are repeated simply becuase some were missed when creating the
                # db and loading the db is slow
                                  
                enumValue = makeAdaVarname( censor( enumValue ))
                if( enumValue =~ /^[\d_](.*)$/ )then
                        enumValue = "s_" + enumValue
                end
                @enumValue = enumValue
        end
        
        def addValue( value )
                @values << value.to_i    
        end
        
         def eql?( o )
                return true if o.equal?( self ) 
                return false if( o.nil? )
                return false if( not o.instance_of?( self.class ))
                # puts "eql? @enumValue #{@enumValue} == #{o.enumValue} = |#{@enumValue == o.enumValue }|\n"
                return @enumValue == o.enumValue                
        end
        
        def == ( o )
                return eql?( o )     
         end
        
         def hash
                 @enumValue.hash
                 #@value.hash ^ @label.hash
         end
end


class EnumeratedType
        
        attr_reader :type, :name, :enums
        
        def eql?( o )
                return true if o.equal?( self ) 
                return false if( o.nil? )
                return false if( not o.instance_of?( self.class ))
                n = o.enums.length
                return false if( n != @enums.length )
                n.times{
                        |i|
                        # puts "[#{i}]"
                        return false if( not @enums[i].eql?( o.enums[i] ))
                }
                return true                
        end
        
        def hash
                h = 0
                @enums.each{
                        |enum|
                        h ^= enum.hash               
                }
                return h
        end
        
        def == ( o )
                return eql?( o )
        end
        
        def initialize( name, adaName )
                @enums = []
                @name = name
                @type = adaName
        end

        def writePrettyPrint( deffile, bodyfile )
                deffile.write( "   function Pretty_Print( i : #{@type} ) return String;\n" );
                bodyfile.write( "    function Pretty_Print( i : #{@type} ) return String is\n" );
                bodyfile.write( "    begin\n" );
                bodyfile.write( "         case i is\n" );        
                @enums.each{
                        |enum|
                        bodyfile.write( "             when #{enum.enumValue} => return \"#{enum.label}\";\n" );
                }
                bodyfile.write( "         end case;\n" );        
                # bodyfile.write( "         return \"?\";\n" );
                bodyfile.write( "    end Pretty_Print;\n\n" );
        end
        
        def writeNullOrMissing( deffile, bodyfile )
                deffile.write( "   function Null_Or_Missing( i : #{@type} ) return Boolean;\n" );
                bodyfile.write( "    function Null_Or_Missing( i : #{@type} ) return Boolean is\n" );
                bodyfile.write( "    begin\n" );
                bodyfile.write( "         case i is\n" );        
                @enums.each{
                        |enum|
                        enum.values.each{
                                |value|
                                if( value < 0 )then
                                        bodyfile.write( "             when #{enum.enumValue} => return True;\n" );
                                        break;
                                end
                        }
                }
                bodyfile.write( "             when Others => return False;\n" );
                bodyfile.write( "         end case;\n" );        
                bodyfile.write( "    end Null_Or_Missing;\n\n" );
        end
        
        def writeEnum( deffile )
                deffile.write( "   type #{@type} is (  \n" );
                @enums.each{
                        |enum|
                        deffile.write( INDENT*2 + "#{enum.enumValue}" );
                        deffile.write( ",\n" ) unless( enum == enums.last )
                }
                deffile.write( " );\n\n" );
        end
        
        def writeConvert( deffile, bodyfile )
                deffile.write( "   function Convert_#{@type}( i : String ) return #{@type};\n" );
                bodyfile.write( "    function Convert_#{@type}( i : String ) return #{@type} is\n" );
                bodyfile.write( "    begin\n" );
                p = 0
                @enums.each{
                        |enum|
                        enum.values.each{
                                |value|
                                if( p == 0 ) then
                                        bodyfile.write "         if i = \"#{value}\" then\n"
                                else
                                        bodyfile.write "         elsif i = \"#{value}\" then\n"
                                end
                                bodyfile.write "            return #{enum.enumValue};\n"
                                p += 1
                        }
                }
                bodyfile.write( "        end if;\n" );
                # bodyfile.write( "        Assert( False, \"Convert_#{@type}: Unmatched string |\" & i & \"|\" );\n" ) 
                bodyfile.write( "        Puts( \"Convert_#{@type}: Unmatched string |\" & i & \"|\" );\n" ) 
                bodyfile.write( "        return #{@type}'First; -- never actually gets here; for compiler only\n" ) 
                bodyfile.write( "    end Convert_#{@type};\n\n" );
        end

        def addEnum( value, label, enumValue )
                e =  EnumEntry.new( value, label, enumValue ) 
                i = @enums.index( e )
                if( i.nil? )then
                        @enums << e
                else
                        @enums[i].addValue( value );
                end
        end
        
end


def createUniqueEnumsList()
        enums = Array.new
        enumsMappingToThisType = Hash.new
        ALL_VARIABLES_WITH_ENUMS_STMT.execute()
        ALL_VARIABLES_WITH_ENUMS_STMT.fetch_hash{
                |res|
                name = res['variable_name']
                type = res['variable_name'].capitalize + "_Type"
                enum = EnumeratedType.new( name, type )
                ALL_VALUES_FOR_VARIABLE_STMT.execute( res['variable_name'] ) 
                ALL_VALUES_FOR_VARIABLE_STMT.each{
                        |ev|
                        enum.addEnum( ev['value'], ev['label'], ev['enum_value'] )           
                }
                enums << enum
                if( enumsMappingToThisType[ enum ].nil? )then
                                enumsMappingToThisType[ enum ] = Array.new
                end 
                enumsMappingToThisType[ enum ] << name

                puts( "type = #{type}\n")
        }
        n = 0
        enums.uniq.each{
                |enum|
                n += 1
                puts "enum[ #{n} ] = #{enum.type}"
        } 
        
        f = File.new( "final_enum_mappings.sql", "w" );
        enumsMappingToThisType.each{
                |enum,list|
                list.each{
                        |q|
                        f.write( "( '#{q}', '#{enum.name}', '#{enum.type}' ),\n" )
                }
        }
        f.close
        return { 'enums'=>enums, 'enumsMappingToThisType' => enumsMappingToThisType }
end

def createEnumDeclarations()
        deffile = File.new( "../bhps-enums.ads", "w" );
        bodyfile = File.new( "../bhps-enums.adb", "w" );
        bodyfile.write(

"with Ada.Assertions;

package body BHPS_Enums is

    use Ada.Assertions;                      
\n\n" );
        deffile.write( "package BHPS_Enums is\n\n" )
        ALL_FINAL_MAPPINGS_STMT.execute()
        ALL_FINAL_MAPPINGS_STMT.fetch_hash{
                |res|
                name = res[ 'enum_type_key' ]
                type = res[ 'enum_type_name' ]
                enum = EnumeratedType.new( name, type )
                ALL_VALUES_FOR_VARIABLE_STMT.execute( res[ 'enum_type_key' ]) 
                ALL_VALUES_FOR_VARIABLE_STMT.each{
                        |ev|
                        enum.addEnum( ev['value'], ev['label'], ev['enum_value'])           
                }
                enum.writeEnum( deffile )
                enum.writePrettyPrint( deffile, bodyfile )
                enum.writeNullOrMissing( deffile, bodyfile )
                enum.writeConvert( deffile, bodyfile )
                deffile.write( "\n\n" )
                bodyfile.write( "\n\n" )                
        }
        deffile.write( "end BHPS_Enums;" )
        deffile.close
        bodyfile.write( "end BHPS_Enums;" )
        bodyfile.close
end

def hackVarname( adaVarname, basename, names_so_far )
        name = makeAdaVarname( censor( adaVarname ))
        basename.downcase!
        # vars with same question
        if( basename =~ /hsivw([\d])/ )then
                name += "_wave_#{$1}" 
        elsif( basename =~ /xhwght/ )then
                name += "_x"
        elsif( basename =~ /nipop([\d])/ )then
                name += "_northern_ireland"
        elsif( basename =~ /swpop([\d])/ )then
                name += "_scotland"
        end
        # p names_so_far
        # puts "name |#{name}|"
        if( not names_so_far.index( name ).nil? )then
                name += "_#{basename}"
        end
        return name
end

def getAdaTypeNum( tableName, name )
        FINAL_TYPE_STMT.execute( tableName, name )
        FINAL_TYPE_STMT.fetch_hash{
                |t|
                i = t['mtype'].to_i
                puts "i = #{i}"
                return i
        }
        puts "unmatched type table #{tableName} name #{name}"
        return INT
end

def getAdaType( tableName, var )
        atype = 'Unknown'
        t = getAdaTypeNum( tableName, var.name )
        atype = case t
                when 1 then 'Integer';
                when AMOUNT then 'Amount'
                when ENUM then var.name.capitalize+"_Type";
                when SERNUM then 'Sernum_Value'
                else "Unknown"
        end
        raise "unmatched type for #{tableName}-#{var.name}" if atype == 'Unknown'
        return atype
end

class Variable
        
        attr_reader :enum, :name, :label, :type, :pos, :adaVarname, :adaType, :enumKey, :missingValues; 
        attr_writer :enum, :missingValues;
        
        def initialize( tableName, name, varFmt, label, type, adaVarname, pos, adaType, enumKey, names_so_far )
                # @enum = Nil   
                @name = name
                @varFmt = varFmt
                @label = label
                # puts "type #{type}"
                @type = type.to_i; # getAdaTypeNum( tableName, name )
                @adaVarname = hackVarname( adaVarname, name, names_so_far )
                @pos = pos
                @enum = nil
                @enumKey = enumKey
                @missingValues = Array.new
                if( @type == INT )then
                        @adaType = 'Integer'
                elsif( @type == AMOUNT )then
                        @adaType = 'Amount'
                elsif( @type == SERNUM )then
                        @adaType = 'Sernum_Value'
                elsif( @type === ENUM )then
                        @adaType = adaType
                else
                        puts "type #{@type} unrecggnised"
                end
                # FIXME load enum here!
         end
         
         def addMissingValue( mv )
                 if( @type == INT )then
                         @missingValues << mv.to_i
                 elsif( @type == AMOUNT )then
                         @missingValues << mv.to_f
                 end  
         end
   
end

class Table
        attr_reader :wave, :tableName, :variables, :variableNames;
        attr_writer :wave, :tableName, :variables, :variableNames;
        
        def initialize( tableName, wave )
                @variables = Hash.new   
                @variableNames = Array.new
                @tableName = tableName
                @wave = wave
        end        
end


def loadTable( tableName, wave )
        tab = Table.new( tableName, wave )
        # if( wave )
        puts "on table #{tableName} wave #{wave}\n"
        rs = Array.new
        if( wave.nil? )
                EVERYTHING_FOR_TABLE_ALL_WAVES_STMT.execute( tableName )
                EVERYTHING_FOR_TABLE_ALL_WAVES_STMT.fetch_hash(){
                        |r|
                        rs << r
                }
        else
                EVERYTHING_FOR_TABLE_ONE_WAVE_STMT.execute( tableName, wave ) 
                EVERYTHING_FOR_TABLE_ONE_WAVE_STMT.fetch_hash(){
                        |r|
                        rs << r
                }
        end
        rs.each{
                |res|
                # puts "res = ";p  res
                var = Variable.new( 
                                     tableName,
                                     res[ 'name' ], 
                                     res[ 'var_fmt'], 
                                     res[ 'label' ], 
                                     res[ 'type' ], 
                                     res[ 'ada_name' ],
                                     res[ 'pos' ],
                                     res[ 'enum_type_name'],
                                     res[ 'enum_type_key'],
                                     tab.variableNames )
                tab.variableNames << var.name
                if( not tab.variables[ var.name ].nil? )then
                        puts "duplicate adaname #{var.name}; halting"
                        Process.exit
                end
                tab.variables[ var.name ] = var
                if( var.type == AMOUNT ) or ( var.type == INT ) then # numeric -- get missing values
                         GET_MISSING_VALUES_STMT.execute( tableName, res['name'] ) 
                         GET_MISSING_VALUES_STMT.fetch_hash{
                                 |m|
                                 var.addMissingValue( m['value'] )
                         }             
                end
        }
        return tab
end


def readOneRTF( filename )
        f = File.new( filename, 'r' );
        tablename = File.basename( filename, ".txt" )
        wave = tablename[ 0, 1 ]
        tablename = tablename[ 1, 99 ]
        
        return if alreadyDoneThisFile( wave, tablename )
        if not alreadyAddedWave( wave )then      
                INSERT_WAVES_STMT.execute( wave )
        end 
        INSERT_TABLES_STMT.execute( wave, tablename )
        type = INT
        varname = ''
        pos = 0
        varname = ''
        label = ''
        adaVarname = ''

        f.each_line{
                |line|
                
                if( line =~ /.*Pos\..*=[\s]*([\d]+)[\t ]*Variable.*=[\s]*([\w]+)[\s]*Variable.*label.*=(.*)/ ) then
                        puts "variable line |#{line}|"
                        #Pos. = 1	Variable = RPNO	Variable label = Person number   
                        pos = $1.to_i
                        label = $3.strip
                        varname = $2.strip.downcase
                        if( varname == 'pid' ) then
                                adaVarname = varname
                                type = SERNUM # flag for index type
                        elsif( varname =~ /([\w])hid/ )then # wave specific hid
                                test_wave = $1
                                # sometimes there are back-references to old hhids, so ahid might turn up in wave c; save as ahid in these cases,
                                # (i.e. when the 1st char wave is different to the file wave) otherwise treat it as hid
                                if( wave == test_wave )then 
                                        varname = 'hid'
                                end
                                adaVarname = varname
                                type = SERNUM # flag for index type
                         else
                                wave = varname[0,1]
                                varname = varname[ 1, varname.length ]
                                adaVarname = makeAdaVarname( label )
                                type = INT
                                adaVarname = makeUniqueAdaName( wave, tablename, adaVarname, varname )
                        end
                        puts "wave |#{wave}| varname=|#{varname}| pos |#{pos}| label=|#{label}| tablename |#{tablename}| adaVarname |#{adaVarname}|\n"
                elsif line =~ /.*This variable is[\s]*([\w]+).*the SPSS measurement level is[\s]*([\w]+)/
                        var_fmt = $1
                        measurement_level = $2
                        puts "var_fmt |#{var_fmt}| measurement_level |#{measurement_level}|\n"
                        INSERT_VARIABLE_STMT.execute( wave, tablename, varname, pos, var_fmt, measurement_level, label, adaVarname, type )
                elsif( line =~ /Value\s*=\s*([\d\-]+)+\s*Label\s*=(.*)/)
                        value = $1.to_i
                        label = $2.strip
                        enum_value  = censor( label )
                        puts "value = |#{$1}| label=|#{label}| enum_value=|#{enum_value}|\n"
                        INSERT_ENUM_STMT.execute( wave, tablename, varname, value, label, enum_value );
                end
        }
        f.close
end

def x_readOneRTF( filename )
        f = File.new( filename, 'r' );
        tablename = File.basename( filename, ".txt" )
        wave = "x"
        return if alreadyDoneThisFile( wave, tablename )
        INSERT_TABLES_STMT.execute( wave, tablename )
        type = INT
        varname = ''
        pos = 0
        varname = ''
        label = ''
        adaVarname = ''
        f.each_line{
                |line|
                if( line =~ /.*Pos\..*=[\s]*([\d]+)[\t ]*Variable.*=[\s]*([\w]+)[\s]*Variable.*label.*=(.*)/ ) then
                        puts "variable line |#{line}|"
                        #Pos. = 1	Variable = RPNO	Variable label = Person number   
                        pos = $1.to_i
                        label = $3.strip
                        varname = $2.strip.downcase
                        if( varname == 'pid' ) then
                                adaVarname = varname
                                type = SERNUM # flag for index type
                        else
                                adaVarname = makeAdaVarname( label )
                                type = INT
                                adaVarname = makeUniqueAdaName( wave, tablename, adaVarname, varname )
                        end
                        puts "wave |#{wave}| varname=|#{varname}| pos |#{pos}| label=|#{label}| tablename |#{tablename}| adaVarname |#{adaVarname}|\n"
                elsif line =~ /.*This variable is[\s]*([\w]+).*the SPSS measurement level is[\s]*([\w]+)/
                        var_fmt = $1
                        measurement_level = $2
                        puts "var_fmt |#{var_fmt}| measurement_level |#{measurement_level}|\n"
                        INSERT_VARIABLE_STMT.execute( wave, tablename, varname, pos, var_fmt, measurement_level, label, adaVarname, type )
                elsif( line =~ /Value\s*=\s*([\d\-]+)+\s*Label\s*=(.*)/)
                        value = $1.to_i
                        label = $2.strip
                        enum_value  = censor( label )
                        puts "value = |#{$1}| label=|#{label}| enum_value=|#{enum_value}|\n"
                        INSERT_ENUM_STMT.execute( wave, tablename, varname, value, label, enum_value );
                end
        }
        f.close()
end

def createOpenCloseStatements()
        SELECT_ALL_TABLES_AND_WAVES_STMT.execute()
        wave = '!'
        open = 
"   
   function Open( wave : Character ) return Record_Pointers is
      ptrs : Record_Pointers;
   begin
      case wave is\n"
        
       close = "
   procedure Close( ptrs : in out  Record_Pointers; wave : Character  ) is
   begin
      case wave is\n"
      
        SELECT_ALL_TABLES_AND_WAVES_STMT.fetch_hash{
                |rs|
                rec = rs['name']
                ioname = rec.capitalize + "_IO";
                fileh = "ptrs.#{rec}_file"
                filename = "BASE_DATA_DIR & wave & SEP & \"#{rec}.bin\""
                if( wave != rs[ 'wave' ])then
                        wave = rs[ 'wave' ]
                        open  += "         when '#{wave}' =>\n"
                        close += "         when '#{wave}' =>\n"
                end
                open  += "            #{ioname}.Open( #{fileh}, #{ioname}.In_File, #{filename} );\n"
                close += "            #{ioname}.Close( #{fileh} );\n"
        }
        close +="
         when others => null;
      end case;
      return ptrs;
   end Close;        
"
        open +="
         when others => null;
      end case;    
   end Open;        
"                   
        return open + "\n\n\n" + close;
end
