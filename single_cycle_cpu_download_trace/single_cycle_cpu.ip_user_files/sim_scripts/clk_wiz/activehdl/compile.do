vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" \
"D:/vivado_/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"D:/vivado_/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../single_cycle_cpu.srcs/sources_1/ip/clk_wiz/clk_wiz_clk_wiz.v" \
"../../../../single_cycle_cpu.srcs/sources_1/ip/clk_wiz/clk_wiz.v" \

vlog -work xil_defaultlib \
"glbl.v"

