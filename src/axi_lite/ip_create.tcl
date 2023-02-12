set fp [open "program_file.txt" r]
set file_data [read $fp]
close $fp
set data [split $file_data "\n"]

set output_dir "./"
create_project -f harness_axi_ip $output_dir/harness_axi_ip -part xc7z020clg400-1

file mkdir $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new
file mkdir $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/imports
file copy -force $output_dir/src/axi_lite/harness_axi_ip_v1_0.v $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/harness_axi_ip_v1_0.v
file copy -force $output_dir/src/axi_lite/harness_axi_ip_v1_0_S00_AXI.v $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/harness_axi_ip_v1_0_S00_AXI.v
file copy -force $output_dir/riscv.sv $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/riscv.sv
file copy -force $output_dir/sp_verilog.vh $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/sp_verilog.vh
file copy -force $output_dir/sandpiper_gen.vh $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/sandpiper_gen.vh





foreach line $data {
    set line_stripped [string map {" " ""} $line]
    if {$line_stripped != ""} {
        file copy -force $output_dir/$line_stripped $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/imports/$line_stripped
    }
}
read_verilog $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/harness_axi_ip_v1_0.v
read_verilog $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/harness_axi_ip_v1_0_S00_AXI.v
read_verilog -sv $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/riscv.sv
read_verilog $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/sp_verilog.vh
read_verilog $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new/sandpiper_gen.vh

foreach line $data {
    set line_stripped [string map {" " ""} $line]
    if {$line_stripped != ""} {
        read_verilog $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/imports/$line_stripped
    }
}





update_compile_order -fileset sources_1
ipx::package_project -import_files -root_dir $output_dir/harness_axi_ip/harness_axi_ip.srcs/sources_1/new -vendor user.org -library user -taxonomy /UserIP
set_property core_revision 1 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
update_ip_catalog 


