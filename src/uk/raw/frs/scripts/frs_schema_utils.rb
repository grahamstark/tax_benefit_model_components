#!/usr/bin/ruby
require 'dbi'
require 'csv'

INDENT = '   '

ADA_KEYWORD_TRANSLATIONS = { 'ACCESS'=>'X_ACCESS', 'OUT'=>'XXOUT', "MONTH_"=>"MONTH" };

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
   procedure Create_#{record_name}_#{year}( 
      tab_file_name   : String; 
      out_file_name   : String; 
      index_file_name : String ) is
      
      use GNAT.String_Split;
      use Conversions.FRS;
      use FRS_Binary_Reads;
      use Raw_FRS;
      use Ada.Strings.Unbounded;
      package usut renames Ada.Strings.Unbounded.Text_IO;
     
      line        : Unbounded_String;
      tab_file    : Text_IO.File_Type;
      slices      : Slice_Set;
      index       : Index_Rec;      
      index_map   : FRS_Index;
      bin_file    : #{record_name}_IO.File_Type;
      rec         : #{record_name}_Rec;      
      line_number : Natural := 0; -- count 1st line (the header) as 0 and data lines from 1
   begin
      Restore_Complete_Index( index_file_name, index_map ); 
      Text_IO.Open( tab_file, Text_IO.In_File, tab_file_name );
      #{record_name}_IO.Create (bin_file, #{record_name}_IO.Out_File, out_file_name );
      while not( Text_IO.End_Of_File( tab_file ) ) loop
         usut.Get_Line( tab_file, line );
         if( line_number > 0 ) then
            slices := TDA_Tokenize( line );
';
      
LOAD_STATEMENT_TEMPLATE = 
'   Create_#{recordName}_#{year}( 
      \"#{tab_file_name}\", 
      \"#{out_file_name}\", 
      \"#{index_file_name}\");

'
         
READ_FOOTER_TEMPLATE = 
'            index := Get_Index( index_map, rec.SERNUM );
            if( index.pointers( #{record_name}Rec ).startPos = 0 ) then
               index.pointers( #{record_name}Rec ).startPos := line_number;
               index.SERNUM := rec.SERNUM;
            end if;
            index.pointers( #{record_name}Rec ).counter := index.pointers( #{record_name}Rec ).counter + 1;
            Put_Index( index_map, index );
            #{record_name}_IO.Write( bin_file, rec );
         end if;
         line_number := line_number + 1;
      end loop;
      Text_IO.Close( tab_file );
      Store_Complete_Index( index_file_name, index_map );
      #{record_name}_IO.Close( bin_file );
   end Create_#{record_name}_#{year};

'



#
# Make an Ada record to represent all fields for all years merged, with sernum and hhseq at the start. ,
# recname - string: Adult,Child, etc.
# variables - array of NameAndType classes, in the order they appear in the output record
#
def makeAdaRecord( recname, table )
        record = INDENT+"type #{recname}_Rec is record\n";
        table.variableNames.each{
                |vname|
                var = table.variables[vname]
                misstype = ''
                if( var.adaType == 'Integer' ) then
                        misstype = ':= MISS;            '
                elsif ( var.adaType == 'Real' ) then
                        misstype = ':= MISS_R;          '
                elsif( var.adaType == 'Sernum_Value' ) then
                        misstype = ":= MISSING_SERNUM;  "
                elsif( var.adaType == 'Ada.Calendar.Time' ) then
                        misstype = ':= FRS_DEFAULT_DATE;'
                end
                paddedVarname = var.adaVarname.ljust(14)
                paddedVartype = var.adaType.ljust(14)
                if( var.adaVarname != "SERNUM") then
                        record += INDENT*2+"#{paddedVarname} : #{paddedVartype}#{misstype}  --  #{var.label}\n"
                end
        }
        record += INDENT+"end record;\n\n";                
        return record;
end

def makeAdaVarname( varname )
        if( ADA_KEYWORD_TRANSLATIONS.has_key?( varname ))then
                varname = ADA_KEYWORD_TRANSLATIONS[ varname ];
        end
        return varname.downcase
end

def makeLoadStatement( dataPath, recordName, table )
        tname = table.tableName.downcase
        year = table.year
        tab_file_name = "#{dataPath}#{year}/tab/#{tname}.tab" 
        out_file_name = "#{dataPath}#{year}/bin/#{tname}.bin" 
        index_file_name = "#{dataPath}#{year}/bin/index.bin"
        return eval( '"' + ::LOAD_STATEMENT_TEMPLATE + '"' );       
end



def createPrintFunction( record_name, table )
        procedure = ''
        procedure += eval( '"' + ::PRINT_HEADER_TEMPLATE + '"' );
        
        table.variableNames.each{
                |vname|
                var = table.variables[vname]
                if( var.adaType == 'Integer' ) then
                        procedure += INDENT*2+ "if( (a.#{var.adaVarname} /= MISS) or INCLUDE_MISSING ) then\n"
                elsif ( var.adaType == 'Real' ) then
                        procedure += INDENT*2+ "if( (a.#{var.adaVarname} /= MISS_R) or INCLUDE_MISSING ) then\n"
                elsif( var.adaType == 'Sernum_Value' ) then
                        procedure += INDENT*2+ "if( (a.#{var.adaVarname} /= MISSING_SERNUM) or INCLUDE_MISSING ) then\n"
                elsif( var.adaType == 'Ada.Calendar.Time' ) then
                        procedure += INDENT*2+ "if( (a.#{var.adaVarname} /= FRS_DEFAULT_DATE) or INCLUDE_MISSING ) then\n"
                end
                procedure += INDENT*3+"s := s & (num_indents*INDENT) & \"#{var.name} (#{var.label}) [#{var.adaVarname}] : \" & Format(a.#{var.adaVarname}) & LINE_BREAK;\n"
                procedure += INDENT*2+"end if;\n"                
        }
        procedure += eval( '"' + ::PRINT_FOOTER_TEMPLATE + '"' );
        return procedure
end

def createConvertProcedure( record_name, year, table )
        procedure = ''
        procedure += eval( '"' + ::READ_HEADER_TEMPLATE + '"' );
        table.variableNames.each{
                |vname|
                var = table.variables[vname]
                procedure += INDENT*4 + "rec.#{var.adaVarname} := Convert( slices, #{var.pos} );\n";
        }
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

def getPosInTable( labels, target )
        p = 1
        labels.each(){
                |label|
                return p if( label == target )
                p += 1
        }
        return -1
end        

def recordNameFromTableName( tableName )
        name = tableName.downcase
        return "Account" if( name == 'accounts' )
        return "Adult" if( name == 'adult' )
        return "Admin" if( name == 'admin' )
        return "Asset" if( name == 'assets' )
        return "Benefit" if( name == 'benefits' )
        return "Benunit" if( name == 'benunit' )
        return "Care" if( name == 'care' )
        return "Child" if( name == 'child' )
        return "Endowment" if( name == 'endowmnt' )
        return "ExtChild" if( name == 'extchild' )
        return "GovPay" if( name == 'govpay' )
        return "Household" if( name == 'househol' )
        return "Insurance" if( name == 'insuranc' )
        return "Job" if( name == 'job' )
        return "Maint" if( name == 'maint' )
        return "MortCont" if( name == 'mortcont' )
        return "Mortgage" if( name == 'mortgage' )
        return "OddJob" if( name == 'oddjob' )
        return "Owner" if( name == 'owner' )
        return "PenProv" if( name == 'penprov' )
        return "PenAmt" if( name == 'penamt' )
        return "Pension" if( name == 'pension' )
        return "RentCont" if( name == 'rentcont' )
        return "Renter" if( name == 'renter' )
        return "Vehicle" if ( name == 'vehicle' )
        return "ChildCare" if ( name == 'chldcare' )
        return tableName.capitalize;
end       


def getHBAIType( connection, varname, label )
        return 'Sernum_Value' if( varname == 'SERNUM' )
        typeStmt = "select max( type ) as mtype from variable where name='#{varname}'";        
        ers = connection.execute( typeStmt )
        type = ''
        ers.fetch_hash{
                |eres|
                type = eres['mtype']
                return type if not type.nil?    
        }
        return 'Integer' if( label =~ /.*number.*/)
        return 'Real'
end        


def parseHBAI( connection, filename, yearStr, datapath )
        delete = connection.prepare("delete FROM tables where year='#{yearStr}' and name='hbai'")
        delete.execute
        delete = connection.prepare("delete FROM variable where year='#{yearStr}' and tables='hbai'")
        delete.execute
        
        insert_tables_stmt = connection.prepare( "insert into tables(year, name) VALUES (?, ?)" )
        insert_tables_stmt.execute( yearStr, 'hbai' );
        file = File.open( filename, 'rb' )
        p = 0
        select_variable_stmt = connection.prepare( "insert into variable( year, tables, name, label, pos, type ) values( ?, 'hbai', ?, ?, ?, ? ) " )
        tableKeys = parseDataTopLine( datapath, 'hbai' )
        CSV::Reader.parse( file, "," ){ 
                |elements|
                table = 'hbai'
                name = elements[0]
                label = elements[1].gsub( /'/, '' )
                type = getHBAIType( connection, name, label )
                posInTable = getPosInTable( tableKeys, name )
                select_variable_stmt.execute( yearStr, name, label, posInTable, type ) 
        }
end

def parseOneYear( connection, filename , yearStr, datapath )
        file = File.open( filename, 'rb' )
        p = 0
        table = ''
        variable = ''
        insert_enum_stmt = connection.prepare( "insert into enum(year, tables, variable, frsvalue, fmtvalue ) VALUES (?, ?, ?, ?, ? )" )
        insert_tables_stmt = connection.prepare( "insert into tables(year, name) VALUES (?, ?)" )
        select_variable_stmt = connection.prepare( "insert into variable(year, tables,\ 
         name, \
         pos,
         var_fmt,\
         label,\
         minval,\
         maxval,\
         xkey,\
         derived,\
         per_var,\
         benefit,\
         question,\
         type,\
         block,\
         varseq,\
         xusage,\
         set_type )\
         values( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) " )
        
        query = connection.prepare("delete FROM tables where year='#{yearStr}'")
        query.execute()
        query = connection.prepare("delete FROM variable where year='#{yearStr}'")
        query.execute()
        query = connection.prepare("delete FROM enum where year='#{yearStr}'")
        query.execute()
        tableKeys = Array.new()
        
        
        CSV::Reader.parse( file, "," ){ ##"\t" ){
              |elements|
               p += 1
               if( p > 1 ) then
                       if( not elements[0].nil? )then
                                table = elements[0]
                                variable = elements[1]
                                variable = "MONTH_" if( variable == '_MONTH_') 
                                begin
                                        insert_tables_stmt.execute( yearStr, table );
                                        tableKeys = parseDataTopLine( datapath, table )
                                        print( "table keys " ); p tableKeys;print "\n"                                
                                rescue
                                        print "table: that was a duplicate"
                                end
                                posInTable = getPosInTable( tableKeys, variable )
                                puts "elements[13] |#{elements[13]}|\n"
                                if( elements[13] == '(I)' ) or ( elements[13] == '(L)' )then
                                        format = 'Integer'
                                elsif( elements[13] == '(F)' )then
                                        format = 'Real'
                                elsif( elements[13] == '(D)' )then
                                        format = 'Date'
                                end 
                                print "elements[13] #{elements[13]}"
                                select_variable_stmt.execute( yearStr, table, variable, posInTable, 
                                                elements[2],  
                                                elements[3],
                                                elements[6],
                                                elements[7],
                                                elements[8],
                                                elements[9],
                                                elements[10],
                                                elements[11],
                                                elements[12],
                                                format,
                                                elements[14],
                                                elements[15],
                                                elements[16],
                                                elements[17]
                                                );
                       end
                       if( not elements[4].nil?)
                                value = elements[4]
                                label = elements[5]
                                print "table #{table} variable #{variable} value #{value} label #{label}\n"
                                begin
                                        insert_enum_stmt.execute( yearStr, table, variable, 
                                                        elements[4],  
                                                        elements[5] );
                                rescue
                                        print "duplicate eunum #{variable} #{value} #{label}"     
                                end
                       end
               end
        }
        
end

class Enum
        attr_reader :frsvalue, :fmtvalue;
        attr_writer :frsvalue, :fmtvalue;
end

class Variable
        
        attr_writer :enums, :name, :var_fmt, :label, :minval, :maxval, :xkey, :derived, :per_var, :benefit, :question, :type, :block, :varseq, :xusage, :set_type, :pos, :adaVarname, :adaType; 
        attr_reader :enums, :name, :var_fmt, :label, :minval, :maxval, :xkey, :derived, :per_var, :benefit, :question, :type, :block, :varseq, :xusage, :set_type, :pos, :adaVarname, :adaType; 
        
        def initialize()
                @enums = Array.new   
                @name = ''
                @var_fmt = ''
                 @label = ''
                 @minval = ''
                 @maxval = ''
                 @xkey = ''
                 @derived = ''
                 @per_var = ''
                 @benefit = ''
                 @question = ''
                 @type = ''
                 @block = ''
                 @varseq = ''
                 @xusage = ''
                 @set_type = ''
                 @adaVarname = ''
                 @pos = -1
                 @adaType = ''
         end        
end

class Table
        attr_reader :year, :tableName, :variables, :variableNames;
        attr_writer :year, :tableName, :variables, :variableNames;
        
        def initialize( tableName, year )
                @variables = Hash.new   
                @variableNames = Array.new
                @tableName = tableName
                @year = year
        end        
end

def getAdaType( connection, tableName, var )
        return 'Ada.Calendar.Time' if( var.type == 'Date')
        return 'Sernum_Value' if( var.name == 'SERNUM' )
        typeStmt = "select max( type ) as mtype from variable where tables='#{tableName}' and name='#{var.name}'";
        print "typeStmt #{typeStmt}\n"
        ers = connection.execute( typeStmt )
        type = var.type
        ers.fetch_hash{
                |eres|
                type = eres['mtype']                
        }
        print "type is #{type}\n"
        return type
end

def mergeTables( t1, t2 )
        t3 = Table.new( t2.tableName, "" )
        t3.variableNames = (t1.variableNames + t2.variableNames).uniq
        t3.variableNames.each{
                |vname|
                if( t1.variables.has_key?(vname)) then
                        v1 = t1.variables[vname]
                        if(t2.variables.has_key?( vname ))then
                                v2 = t2.variables[vname]
                                if( v2.type >= v1.type )then
                                        t3.variables[ vname ] = v2
                                else
                                        t3.variables[ vname ] = v1
                                end
                        end
                        t3.variables[ vname ] = v1
                else
                        t3.variables[ vname ] = t2.variables[vname]
                end
        }
        return t3;
end

def loadTable( connection, tableName, year = nil )
        tab = Table.new( tableName, year )
        rs = nil;
        stmt = "select * from variable where tables='#{tableName}' and year='#{year}' and pos > 0 order by pos"
        print stmt
        rs = connection.execute( stmt )
        rs.fetch_hash{
                |res|
                var = Variable.new
                var.name = res['name']
                var.pos = res['pos']
                var.label = res['label']
                var.type = res['type']
                var.adaType = getAdaType( connection, tableName, var )
                var.adaVarname = makeAdaVarname( var.name )
                enumStmt = "select frsvalue, fmtvalue from enum where tables='#{tableName}' and variable = '#{var.name}' and year='#{year}' order by frsvalue"
                ers = connection.execute( enumStmt )
                ers.fetch_hash{
                        |eres|
                        enum = Enum.new
                        enum.frsvalue = eres['fssvalue']
                        enum.fmtvalue = eres['fmtvalue']
                        var.enums << enum
                }
                tab.variableNames << var.name
                tab.variables[ var.name ] = var
        }
        return tab
end

def getConnection()
        return DBI.connect('DBI:Mysql:frs_schema', '', '')
end
