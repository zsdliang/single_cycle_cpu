-makelib ies_lib/xil_defaultlib -sv \
  "D:/vivado_/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/vivado_/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../single_cycle_cpu.srcs/sources_1/ip/clk_wiz/clk_wiz_clk_wiz.v" \
  "../../../../single_cycle_cpu.srcs/sources_1/ip/clk_wiz/clk_wiz.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

