require 'bhps_schema_utils.rb';

body_convertf = File.new( "bits/conversion_inserts.adb", "w" );
def_convertf = File.new( "bits/conversion_inserts.ads", "w" )

SELECT_ALL_TABLES_AND_WAVES_STMT.execute()
SELECT_ALL_TABLES_AND_WAVES_STMT.fetch_hash{
        |rs|
        tableName = rs[ 'name' ] 
        wave = rs[ 'wave' ] 
        # if( not tableName =~ /x.*/)then # tmp till we've worked out what do do with the x-files
                table = loadTable( tableName, wave )
                p table.variableNames
                recname = tableName.capitalize;
                def_convertf.write( makeLoadCallStatement( '/mnt/data/bhps/', recname, table ))
                def_convertf.write( "\n\n")
                body_convertf.write( createConvertProcedure( recname, wave.upcase, table ));
                body_convertf.write( "\n\n")
        # end
}

body_convertf.close;
def_convertf.close;

def_body = File.new( "bits/bhps_body.ads", "w" )
def_print_stmts = File.new( "bits/bhps_print.ads", "w" )
body_print_stmts = File.new( "bits/bhps_print.adb", "w" )

SELECT_ALL_TABLES_STMT.execute()
SELECT_ALL_TABLES_STMT.fetch_hash{
        |rs|
        tableName = rs[ 'name' ] 
        table = loadTable( tableName, nil )
        p table.variableNames
        recname = tableName.capitalize;
        def_print_stmts.write( createPrintDef( recname, table ))
        body_print_stmts.write( "\n\n")
        
        body_print_stmts.write( createPrintFunction( recname, table ))
        body_print_stmts.write( "\n\n")
        
        def_body.write( makeAdaRecord( recname, table ))
        def_body.write( "\n\n")
}

def_body.close;
def_print_stmts.close
body_print_stmts.close

CONNECTION.disconnect
