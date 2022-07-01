set_property SRC_FILE_INFO {cfile:f:/file/exp/cpu/single_cycle_cpu_download/single_cycle_cpu.srcs/sources_1/ip/clk_wiz/clk_wiz.xdc rfile:../single_cycle_cpu.srcs/sources_1/ip/clk_wiz/clk_wiz.xdc id:1 order:EARLY scoped_inst:CLK_WIZ/inst} [current_design]
set_property SRC_FILE_INFO {cfile:F:/file/exp/cpu/single_cycle_cpu_download/single_cycle_cpu.srcs/constrs_1/new/clock.xdc rfile:../single_cycle_cpu.srcs/constrs_1/new/clock.xdc id:2} [current_design]
current_instance CLK_WIZ/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
current_instance
set_property src_info {type:XDC file:2 line:1 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 10.000 -name clk [get_ports clk]
