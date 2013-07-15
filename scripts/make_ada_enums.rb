#!/usr/bin/ruby

def makeOne( deffile, bodyfile, enumName );
        ens = Hash.new
        f = File.new( enumName+".rtf", 'r' );
        f.each_line{
                |line|
                puts "line #{line}"
                if( line =~ /\tValue = (.*?)\tLabel = (.*)/ ) then
                        val = $1.to_i
                        s = $2.strip
                        ##enum = s.tr_s( '-/,.():', '_' );
                        enum = s.gsub( /[ \-\/,\.\(\):]/, '_' );
                        enum = enum.gsub( /__/, '_' );
                        enum = enum.gsub( /__/, '_' );
                        enum = enum.gsub( /'/, '' );
                        enum = enum.gsub( /_$/, '' );
                        enum = enum.gsub( /\&/, 'and' );
                        enum = enum.gsub( /\+/, 'plus' );
                        enum = enum.gsub( /</, 'lt' );
                        enum = enum.gsub( />/, 'gt' );
                        enum = 'v'+enum if enum =~ /[0-9].*/
                        puts enum
                        ens[val] = [ enum.downcase, s ]
                end
        }
        f.close
        lastkey = ens.keys.sort.last
        deffile.write( "   type #{enumName} is (  \n" );
        deffile.write( "      missing,\n" );
        ens.sort.each{
                |ival,enum|
                deffile.write "      #{enum[0]}"
                puts " ival #{ival} ens.keys.last #{lastkey} \n";
                deffile.write( "," ) unless( ival == lastkey )
                deffile.write( "\n")
        }
        deffile.write( "   );\n\n" );
        deffile.write( "   function pretty_print( i : #{enumName} ) return String;\n" );
        deffile.write( "   function convert_#{enumName.downcase}( i : integer ) return #{enumName};\n" );
        deffile.write( "   function get_#{enumName.downcase}_template return  Templates_Parser.Tag;\n" );       
        deffile.write( "\n\n" );
        bodyfile.write( "    function pretty_print( i : #{enumName} ) return String is\n" );
        bodyfile.write( "    begin\n" );
        bodyfile.write( "         case i is\n" );        
        ens.sort.each{
                |ival,enum|
                bodyfile.write( "             when #{enum[0]} => return \"#{enum[1]}\";\n" );
        }
        bodyfile.write( "             when missing => return \"Null or Missing\";\n" );
        bodyfile.write( "         end case;\n" );        
        bodyfile.write( "         return \"?\";\n" );
        bodyfile.write( "    end pretty_print;\n" );
        bodyfile.write( "\n\n " );
        bodyfile.write( "    function convert_#{enumName.downcase}( i : integer ) return #{enumName} is\n" );
        bodyfile.write( "    begin\n" );
        bodyfile.write( "        case i is \n" );
        ens.sort.each{
                |ival,enum|
                bodyfile.write "            when #{ival} => return #{enum[0]};\n"
        }
        bodyfile.write  "            when others => return missing;\n"
        bodyfile.write( "        end case;\n" );
        bodyfile.write( "    end convert_#{enumName.downcase};\n" );
        bodyfile.write( "\n\n" ) 
        bodyfile.write( "    function get_#{enumName.downcase}_template return  Templates_Parser.Tag is\n" );
        bodyfile.write( "       tag : Templates_Parser.Tag;\n")
        bodyfile.write( "    begin\n")
        bodyfile.write( "       tag := tag & \"Null or Missing\";\n" );
        ens.sort.each{
                |ival,enum|
                bodyfile.write "       tag := tag & \"#{enum[1]}\";\n"
        }
        bodyfile.write( "       return tag;\n" );
        bodyfile.write( "    end get_#{enumName.downcase}_template;\n\n" );
end

deffile = File.new( "enums.ads", 'w' );
bodyfile = File.new( "enums.adb", 'w' );

makeOne( deffile, bodyfile, "Acorn" );
makeOne( deffile, bodyfile, "Adult_Employment_Status" );
makeOne( deffile, bodyfile, "Age_Group" );
makeOne( deffile, bodyfile, "Aggregated_Ethnic_Group" );
makeOne( deffile, bodyfile, "Benefit_Types" );
makeOne( deffile, bodyfile, "Benefit_Unit_Economic_Status" );
makeOne( deffile, bodyfile, "Benefit_Unit_Type" );
makeOne( deffile, bodyfile, "BU_Disabled_Indicator" );
makeOne( deffile, bodyfile, "Employment_Status" );
makeOne( deffile, bodyfile, "Ethnic_Group" );
makeOne( deffile, bodyfile, "HBAI_Benefit_Unit_Type" );
makeOne( deffile, bodyfile, "Household_Composition" );
makeOne( deffile, bodyfile, "Household_Income_Band" );
makeOne( deffile, bodyfile, "ILO_Employment_Status" );
makeOne( deffile, bodyfile, "Marital_Status" );
makeOne( deffile, bodyfile, "Non_Dependency_Class" );
makeOne( deffile, bodyfile, "Old_Region" );
makeOne( deffile, bodyfile, "Pension_Types" );
makeOne( deffile, bodyfile, "Regional_Stratifier" );
makeOne( deffile, bodyfile, "Relationship_To_Head_Of_Household" );
makeOne( deffile, bodyfile, "Standard_Region" );
makeOne( deffile, bodyfile, "Tenure_Type" );
makeOne( deffile, bodyfile, "Scottish_Regional_Stratifier" );
makeOne( deffile, bodyfile, "Gender" );
deffile.close
bodyfile.close
