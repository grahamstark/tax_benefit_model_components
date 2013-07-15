#!/usr/bin/ruby
# exe ='../bin/tb_harness'
# exe ='bin/convert_raw_frs_to_model_data'
# exe = 'bin/create_model_datasets'
# exe = 'bin/create_raw_ies_data'
 exe = 'bin/za_runner'
ARGV.each{
        |pos|
        command = "addr2line #{pos} --exe=#{exe} --demangle=gnat functions"
        system command
}
