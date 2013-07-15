#!/usr/bin/ruby
#
# $revision$
# $author$
#
# Script for code generation (Ada), data cleanups, and indexing for 
# the hierarchical FRS. 
#
require 'csv';
require 'scripts/convert_libs.rb'

def makeDefinition( deffile, bodyfile, enumName, components );
        deffile.write( "   type #{enumName} is (  \n" );
        deffile.write( "      missing,\n" );
        components.each{
                |enum|
                deffile.write "      #{enum.enumname}"
                deffile.write( "," ) unless( enum == components.last )
                deffile.write( "            --  #{enum.coicop}\n")
        }
        deffile.write( "   );\n\n" );
        n = 0
        levelEnum = []
        n = components.length
        
        level4StartItem = ''
        level3StartItem = ''
        level2StartItem = ''
        level1StartItem = ''
        level4type = ''
        level3type = ''
        level2type = ''
        level1type = ''
        level1 = {}
        level2 = {}
        level3 = {}
        level4 = {}
        level1names = {}
        level2names = {}
        level3names = {}
        level4names = {}
        allEnumNames = {}
        n.times{
                |i|
                puts "i=#{i}"
                level1type = censor( components[i].coicoptypedesc ).capitalize + "_coi"
                level2type = censor( components[i].mainname ).capitalize + "_main" 
                level3type = censor( components[i].secondarygroupname ).capitalize + "_secondary" 
                level4type = censor( components[i].thirdgroupdesc ).capitalize + "_tertiary"
                level1names[ level1type ] = components[i].coicoptypedesc       
                level2names[ level2type ] = components[i].mainname        
                level3names[ level3type ] = components[i].secondarygroupname        
                level4names[ level4type ] = components[i].thirdgroupdesc     
                allEnumNames[ components[i].enumname ] = components[i].item
                if( i == 0 ) then
                        level4StartItem = components[i].enumname 
                        level3StartItem = components[i].enumname 
                        level2StartItem = components[i].enumname 
                        level1StartItem = components[i].enumname 
                        
                elsif( i == ( n - 1 ) )then
                        level4EndItem = components[i].enumname
                        level3EndItem = components[i].enumname
                        level2EndItem = components[i].enumname
                        level1EndItem = components[i].enumname
                        level1[ level1type ] = INDENT+"subtype #{level1type}_Range is #{enumName}_Range range #{level1StartItem} .. #{components[i].enumname};\n"
                        level2[ level2type ] = INDENT+"subtype #{level2type}_Range is #{level1type}_Range range #{level2StartItem} .. #{components[i].enumname};\n"
                        level3[ level3type ] = INDENT+"subtype #{level3type}_Range is #{level2type}_Range range #{level3StartItem} .. #{components[i].enumname};\n"
                        level4[ level4type ] = INDENT+"subtype #{level4type}_Range is #{level3type}_Range range #{level4StartItem} .. #{components[i].enumname};\n"
                else
                        if( components[i].coicoptype != components[i+1].coicoptype ) then
                                level1[ level1type ] = INDENT+"subtype #{level1type}_Range is #{enumName}_Range range #{level1StartItem} .. #{components[i].enumname};\n"
                                level1StartItem = components[i+1].enumname;
                                puts "level1StartItem #{level1StartItem}"
                        end
                        if( components[i].maingroup != components[i+1].maingroup ) then
                        level2 [ level2type ] = INDENT+"subtype #{level2type}_Range is #{level1type}_Range range #{level2StartItem} .. #{components[i].enumname};\n" 
                                level2StartItem = components[i+1].enumname;
                                puts "level2StartItem #{level2StartItem}"
                        end
                        if( components[i].secondarygroup != components[i+1].secondarygroup ) then
                                level3[ level3type ] = INDENT+"subtype #{level3type}_Range is #{level2type}_Range range #{level3StartItem} .. #{components[i].enumname};\n"
                                level3StartItem = components[i+1].enumname;
                                puts "level3StartItem #{level3StartItem}"
                        end
                        if( components[i].thirdgroup != components[i+1].thirdgroup ) then
                                level4[ level4type ] = INDENT+"subtype #{level4type}_Range is #{level3type}_Range range #{level4StartItem} .. #{components[i].enumname};\n"
                                level4StartItem = components[i+1].enumname;
                                puts "level4StartItem #{level4StartItem}"
                        end
                end
         }
         writeEnum( deffile, level1.keys, 'Coicop_Type' )
         writeEnum( deffile, level2.keys, 'Main_Group' )
         writeEnum( deffile, level3.keys, 'Secondary_Group' )
         writeEnum( deffile, level4.keys, 'Tertiary_Group' )
         deffile.write( INDENT + "---\n" + INDENT + "--- Level 1\n" + INDENT + "---\n" )
         level1.sort.each{
                 |key, l1|
                deffile.write( l1 );
         }
         deffile.write( INDENT + "---\n" + INDENT + "--- Level 2\n" + INDENT + "---\n" )
         level2.sort.each{
                 |key, l2|
                deffile.write( l2 );
         }
         deffile.write( INDENT + "---\n" + INDENT + "--- Level 3\n" + INDENT + "---\n" )
         level3.sort.each{
                 |key, l3|
                deffile.write( l3 );
         }
         deffile.write( INDENT + "---\n" + INDENT + "--- Level 4\n" + INDENT + "---\n" )
         level4.sort.each{
                 |key, l4|
                deffile.write( l4 );
         }
         writePrettyPrint( deffile, bodyfile, 'Coicop', allEnumNames )
         writePrettyPrint( deffile, bodyfile, 'Coicop_Type', level1names )
         writePrettyPrint( deffile, bodyfile, 'Main_Group', level2names )
         writePrettyPrint( deffile, bodyfile, 'Secondary_Group', level3names )
         writePrettyPrint( deffile, bodyfile, 'Tertiary_Group', level4names )
         
        deffile.write( "   function Convert_#{enumName.capitalize}( i : String ) return #{enumName.capitalize};\n" );
         
        bodyfile.write( "    function Convert_#{enumName.capitalize}( i : String ) return #{enumName.capitalize} is\n" );
        bodyfile.write( "    begin\n" );
        bodyfile.write( "        case i is \n" );
        components.each{
                |enum|
                bodyfile.write "            when \"#{enum.coicop}\" => return #{enum.enumname};\n"
        }
        bodyfile.write  "            when others => return missing;\n"
        bodyfile.write( "        end case;\n" );
        bodyfile.write( "    end Convert_#{enumName.capitalize};\n" );
        bodyfile.write( "\n\n" ) 
        #bodyfile.write( "    function get_#{enumName.downcase}_template return  Templates_Parser.Tag is\n" );
        #bodyfile.write( "       tag : Templates_Parser.Tag;\n")
        #bodyfile.write( "    begin\n")
        #bodyfile.write( "       tag := tag & \"Null or Missing\";\n" );
        #components.each{
        #        |enum|
        #        bodyfile.write "       tag := tag & \"#{enum.item}\";\n"
        #}
       # bodyfile.write( "       return tag;\n" );
        #bodyfile.write( "    end get_#{enumName.downcase}_template;\n\n" );
end



class COICOP
      attr_reader :coicop, :item, :enumname,:coicoptype, :coicoptypedesc, :maingroup, :mainname,
                  :secondarygroup, :secondarygroupname, :thirdgroup, :thirdgroupdesc
      attr_writer :coicop, :item, :enumname,:coicoptype, :coicoptypedesc, :maingroup, :mainname,
                  :secondarygroup, :secondarygroupname, :thirdgroup, :thirdgroupdesc
     
end


pos = 0;
file = File.open( 'etc/coicop_code_list.csv', 'rb' );
puts "opened #{file}" ;
coi_entries = []
CSV::Reader.parse( file, @sep ){
        |elements|
        if( pos > 3 ) then
                #p elements
                coi = COICOP.new
                coi.coicop = elements[0].data
                coi.item = elements[1].data
                coi.enumname = censor( coi.item )
                coi.coicoptype = elements[2].data
                coi.coicoptypedesc = elements[3].data
                coi.maingroup = elements[4].data
                coi.mainname = elements[5].data
                coi.secondarygroup = elements[6].data
                coi.secondarygroupname = elements[7].data
                coi.thirdgroup = elements[8].data
                coi.thirdgroupdesc = elements[9].data
                coi_entries = coi_entries << coi
                puts "coicop #{coi.coicop} enumname #{coi.enumname}";
        end
        pos += 1
}

deffile = File.new( 'src/coicop_definitions.ads.tmp', 'w' );
bodyfile = File.new( 'src/coicop_definitions.adb.tmp', 'w' );

deffile.write(
"--
--
with Base_Model_Types; use Base_Model_Types;

package Coicop_Definitions is

")

p coi_entries
makeDefinition( deffile, bodyfile, "Coicop", coi_entries )
deffile.write( "\n\nend Coicop_Definitions; " )

deffile.close
bodyfile.close
