-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Jun 29 20:29:36 2022
-- Host        : HDL running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               f:/file/exp/cpu/single_cycle_cpu/single_cycle_cpu.srcs/sources_1/ip/inst_mem/inst_mem_stub.vhdl
-- Design      : inst_mem
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inst_mem is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 15 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end inst_mem;

architecture stub of inst_mem is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[15:0],spo[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2018.3";
begin
end;
