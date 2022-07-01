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
    
    input [23:0] s,
    output [23:0] light,
    output wire [7:0] led_ena,
    output wire [7:0] led,
    
    output wire [23:0] light_out
    );

    wire [31:0] rdata_from_switch;
    wire [31:0] rdata_from_led;
    wire [31:0] wdata_to_led;
    wire [31:0] wdata_to_light;
    wire [31:0] rdata_from_mem;
    wire [31:0] wdata_to_mem;
    wire [31:0] data_to_out;
    reg [31:0] wdata_to_led_reg;
    reg [23:0] wdata_to_light_reg;
    wire WE_mem;
    wire WE_led;
    wire WE_light;

    assign WE_mem = (addr_from_cpu == 32'hfffff000 || addr_from_cpu == 32'hfffff060)?0:WE?1:0;
    assign wdata_to_led = wdata_to_led_reg;
    assign wdata_to_mem = data_from_cpu;
    assign wdata_to_light = wdata_to_light_reg;
    

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
    assign WE_light = ~WE?0:(addr_from_cpu == 32'hfffff060)?1:0;
    
    always @(posedge clk_i) begin
        if(WE_light) wdata_to_light_reg <= data_from_cpu;
        else wdata_to_light_reg <= wdata_to_light_reg;
    end
    
    always @(posedge clk_i) begin
        if(WE_led) wdata_to_led_reg <= data_from_cpu;
        else wdata_to_led_reg <= wdata_to_led_reg;
    end 

    led led_dis(
        .clk(clk_i),
        .data_to_led(wdata_to_led),
        .WE_led(WE_led),
        .led_ena(led_ena),
        .led(led)
    );

    switch SWITCH(
        .s(s),
        .data_from_switch(rdata_from_switch)
    );

    light LIGHT(
        .WE_light(WE_light),
        .data_in(wdata_to_light),
        .light_out(light_out)
    );
endmodule
