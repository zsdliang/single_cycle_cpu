`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 14:31:35
// Design Name: 
// Module Name: MEM_or_IO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM_or_IO(
    input wire clk_i,
    input wire WE,
    input wire [31:0] addr_from_cpu,
    input wire [31:0] data_from_cpu,
    input wire rst,

    output wire [31:0] data_from_out,

    output wire led0_en_o,
    output wire led1_en_o,
    output wire led2_en_o,
    output wire led3_en_o,
    output wire led4_en_o,
    output wire led5_en_o,
    output wire led6_en_o,
    output wire led7_en_o,
    output wire led_ca_o,
    output wire led_cb_o,
    output wire led_cc_o,
    output wire led_cd_o,
    output wire led_ce_o,
    output wire led_cf_o,
    output wire led_cg_o,
    output wire led_dp_o
    );

    wire [31:0] rdata_from_switch;
    wire [31:0] rdata_from_led;
    wire [31:0] wdata_to_led;
    wire [31:0] rdata_from_mem;
    wire [31:0] wdata_to_mem;
    wire [31:0] data_to_out;
    reg [31:0] wdata_to_led_reg;
    wire WE_mem;
    wire WE_led;

    assign WE_mem = (addr_from_cpu == 32'hfffff000 || addr_from_cpu == 32'hfffff060)?0:WE?1:0;
    assign wdata_to_led = wdata_to_led_reg;
    assign wdata_to_mem = data_from_cpu;
    

    wire [31:0] waddr_tmp = addr_from_cpu - 16'h4000;
    dram dmem(
        .clk(clk_i),
        .a(waddr_tmp[17:2]),
        .d(data_from_cpu),
        .spo(rdata_from_mem),
        .we(WE_mem)
    );

    assign data_from_out = WE?32'h0:(addr_from_cpu == 32'hfffff070)?rdata_from_switch:rdata_from_mem;

    assign WE_led = ~WE?0:(addr_from_cpu == 32'hfffff000)?1:0;

    always @(posedge clk_i) begin
        if(WE_led) wdata_to_led_reg <= data_from_cpu;
        else wdata_to_led_reg <= wdata_to_led_reg;
    end 

    led led_dis(
        .clk(clk_i),
        .data_to_led(wdata_to_led),
        .WE_led(WE_led),

        .led0_en_o(led0_en_o),
        .led1_en_o(led1_en_o),
        .led2_en_o(led2_en_o),
        .led3_en_o(led3_en_o),
        .led4_en_o(led4_en_o),
        .led5_en_o(led5_en_o),
        .led6_en_o(led6_en_o),
        .led7_en_o(led7_en_o),
        .led_ca_o(led_ca_o),
        .led_cb_o(led_cb_o),
        .led_cc_o(led_cc_o),
        .led_cd_o(led_cd_o),
        .led_ce_o(led_ce_o),
        .led_cf_o(led_cf_o),
        .led_cg_o(led_cg_o),
        .led_dp_o(led_dp_o)
    );

    switch SWITCH(
        .data_from_switch(rdata_from_switch)
    );

endmodule
