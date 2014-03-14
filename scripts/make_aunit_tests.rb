#!/usr/bin/ruby

require "erb"

@test_packages = []

def parseFile( outputdir, filename )
        @withs = []
        @procedures = []
        @procedureCalls = []
        @functions = []
        @functionCalls = []
        @package_name =  "mismatch"
        
        File.open( filename ).each{
                |line|
                if /^package +(.*?) +.*is/ =~ line then
                        @package_name = $1
                elsif /^ +function *(.*?) *(\(.*?\)*).*/ =~ line
                        @functions << $1
                        @functionCalls << $2
                elsif /^ +procedure *(.*?) *(\(.*?\)*).*/ =~ line
                        @procedures << $1
                        @procedureCalls << $2
                elsif /^ *with *(.*?);.*/ =~ line
                        @withs << $1
                end;
                
        }
        if( @package_name != 'mismatch' )then
                @package_name += ".Tests"
                @test_packages << @package_name;
                package_file_name = @package_name.downcase.gsub( ".", "-")
                header_text = ''
                header_string = 
"with AUnit.Test_Cases; 
with AUnit;

package <%= @package_name %> is

    use AUnit.Test_Cases;
    use AUnit;

    type Test_Case is new AUnit.Test_Cases.Test_Case with null record;
    
    --  Register routines to be run
    procedure Register_Tests( t : in out Test_Case);
    --  Returns name identifying the test case
    function Name( t : Test_Case ) return Message_String;
    --  Preparation performed before each routine:
    procedure Set_Up( t : in out Test_Case);

end <%= @package_name %>;"
                header_template = ERB.new header_string

                body_string = 
"with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with GNATColl.Traces;
with AUnit.Assertions;             
with AUnit.Test_Cases; 

<% for @with in @withs %>
with <%= @with %>;<% end %>

package body <%= @package_name %> is
<% for @with in @withs %>
   use <%= @with %>;<% end %>

   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use AUnit.Test_Cases.Registration;
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Calendar;
 
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( \"<%=@package_name%>\" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
<% for @proc in @procedures %>
   procedure Test_<%=@proc%>( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      null;
   end Test_<%=@proc%>;  
<% end %>   

<% for @func in @functions %>
   procedure Test_<%=@func%>( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      null;
   end Test_<%=@func%>;  
<% end %>   
   
   procedure Register_Tests( t : in out Test_Case ) is
   begin
<% for @proc in @procedures %>
      Register_Routine (T, Test_<%=@proc%>'Access, \"Test of procedure <%=@proc%> \" );<% end %>  
<% for @func in @functions %>
      Register_Routine (T, Test_<%=@func%>'Access, \"Test of function <%=@func%> \" );<% end %>  
   end Register_Tests; 

   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   --  Preparation performed after each routine:
   procedure Shut_Down( t : in out Test_Case ) is
   begin
      null;
   end Shut_Down;
  
   function Name( t : Test_Case ) return Message_String is
   begin
      return Format( \"@package Test Suite\" );
   end Name;
   
end <%= @package_name %>;"
                body_template = ERB.new body_string
                header_text = header_template.result
                body_text = body_template.result
                bf = File.new( outputdir + "/"+ package_file_name + '.adb', "w" )
                bf.write( body_text )
                bf.close
                hf = File.new( outputdir + "/"+ package_file_name + '.ads', "w" )
                hf.write( header_text )
                hf.close
        end 
end


targetdir = ARGV[0]
outputdir = ARGV[1]

Dir["#{targetdir}/*.ads"].sort().each{
        |filename|
        puts "#{filename}"
        parseFile( outputdir, filename )
}

suite_string = "with AUnit.Test_Suites; 
<% for @with in @test_packages %>
with <%= @with %>;<% end %>
   
use AUnit.Test_Suites;
   
function Suite return Access_Test_Suite is
   result : Access_Test_Suite := new Test_Suite;
begin
<% for @package in @test_packages %>
   Add_Test( result, new <%=@package%>.Test_Case );<%end %>
   return result;
end Suite;"

suite_template = ERB.new suite_string
suite_text = suite_template.result
bf = File.new( outputdir + '/suite.adb', "w" )
bf.write( suite_text )
bf.close
