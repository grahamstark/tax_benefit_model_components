#!/usr/bin/ruby
require File.dirname(__FILE__) + '/../test_helper'

require 'mini_macro'
require 'pstore'
require 'utils'
require 'data_constants'
require 'sleepycat'
#
#
# $revision$
# $author$
# $date$
# 
# unit tests of our simple macro ONS database
#
class MacroTests < Test::Unit::TestCase
     ##
     # these are: employment stats, retail prices, economic trends
     ##
     DATABASES = [ 'EMP', 'MM23', 'ET' ]

     PATH = "/home/graham_s/VirtualWorlds/projects/ni_legal_aid/ada/data/macro/";
     
     Wages = 'lnnk'; ## Unit Wage Costs : whole economy SA: Index 2002=100: UK royj';
     OtherIncome = 'ihxs' ## Gross national income per head at current market prices: SA 
     Capital = 'ihxs'  ## Gross national income per head at current market prices: SA
     StateBenefits = 'cbzw'; ## All items exc mortgage int payments and indirect taxes (RPIY) (Jan 1987=100)
     Rent = 'dobp' ## RPI: housing: rent (Jan 1987=100)   
     Mortgages = 'dobq' ## RPI: housing: mortgage interest payments (Jan 1987=100) 
     CT = 'dobr' ## RPI: housing: council tax & rates (Jan 1987=100)
     Charges = 'dobs' ##RPI: housing: water & other charges (Jan 1987=100)  
     Repairs = 'dobt' ## RPI: housing: repairs & maintenance charges (Jan 1987=100) 
     
     def testPrintAdaDB
              [2002, 2003, 2004, 2005, 2006 ].each{
                      |year|
                      puts " on year #{year} ";
                      Range.new(1, 12).to_a.each{
                              |month|
                              ## puts " looking for month = #{month}"
                              date = Date::new( year, month, 1 );
                              wage = @macroDB.getByD( Wages, date );
                              other = @macroDB.getByD( OtherIncome, date );
                              capital = @macroDB.getByD( Capital, date );
                              bens = @macroDB.getByD( StateBenefits, date );
                              rent = @macroDB.getByD( Rent, date ); 
                              mortgages = @macroDB.getByD( Mortgages, date );
                              ct = @macroDB.getByD( CT, date );
                              charges = @macroDB.getByD( Charges, date );
                              repairs = @macroDB.getByD( Repairs, date );
                              puts "macro( #{year}, #{month} ) := ( #{wage}, #{other}, #{capital}, #{bens}, #{rent}, #{mortgages}, #{ct}, #{charges}, #{repairs} )";
                      }
              }
      end;
      

        
       def getInflation( date )
               return @macroDB.getChangeFromLatest('cbzw', @date1 );
       end;
       
       def testInflation()
              inf = getInflation( @date1 );
              puts " got inflation as #{inf}";
              assert_in_delta( inf, 1.815, 0.00001 );
       end
       
       def testOutput( )
                 firstDate = @macroDB.firstDate( 'a4ym' );
                 lastDate = @macroDB.lastDate( 'a4ym' );
                 puts "output rec[a4ym] last date = #{lastDate} first date #{firstDate}" 
                 assert_equal( firstDate, Date::new( 1959, 7, 1 ) )
                 assert_equal( lastDate, Date::new( 2005, 9, 1 ) )
                 assert_equal( @macroDB.getByD( 'a4ym', lastDate ), 104.2 )
                 assert_equal( @macroDB.getByD( 'a4ym', Date::new( 2005, 8, 1 )), 104.2 )
                 assert_equal( @macroDB.getByD( 'a4ym', firstDate ), 39.8 )
                 assert_equal( @macroDB.getByD( 'a4ym', Date::new( 1959, 8, 1 )), 39.8 )
       end
       
       def testDates()
               firstInfDate = @macroDB.firstDate( 'cbzw' );
               puts "got firstInfDate as #{firstInfDate}";
               assert_equal( firstInfDate, @date1 );
               lastInfDate = @macroDB.lastDate( 'cbzw' );
               puts "got lastInfDate as #{lastInfDate}";
               assert_equal( lastInfDate, @date2 );
      end
      
      def storeDB( db )
              dbEnv = dbEnvironment( BIN_DATA_DIR, false )
              handle = dbHandle( dbEnv, "et_ons_database_2" )
              handle[ 'combinedDB' ] = Marshal.dump( db )
      end
      
      def loadMultipleDatabases
              _macroDB = MiniMacro.new;
              DATABASES.each{
                        |file|
                        _macroDB = loadFromONSData( PATH+file, _macroDB );
                        puts "loadMultipleDatabases; loaded #{file}: variables now ";
                        p _macroDB.variableList;
              }
              
              return _macroDB;
      end
      
      def loadCombinedDatabase
              dbEnv = dbEnvironment( BIN_DATA_DIR, false )
              handle = dbHandle( dbEnv, "et_ons_database_2" )
              return Marshal.load( handle[ 'combinedDB' ] )
      end
      
      def setup()
              @date1 = Date::new( 1987, 1, 1 )
              @date2 = Date::new( 2005, 12, 1 )
              #
              _macroDB = loadMultipleDatabases;
              storeDB( _macroDB );
              ##  p @macroDB
              #@macroDB = _macroDB 
              @macroDB = loadCombinedDatabase
              p @macroDB.variableList
              @latestDate = @macroDB.lastDate( 'cbzw' );
       end
end
