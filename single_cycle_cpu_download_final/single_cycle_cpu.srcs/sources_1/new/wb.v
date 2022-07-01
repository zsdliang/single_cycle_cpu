`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/29 09:08:16
// Design Name: 
// Module Name: wb
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


module wb(
    input wire [31:0] alu_c,
    input wire [31:0] mem_dout,
    input wire Branch,
    input wire Branch_result,
    input wire [31:0] pc4,
    input wire [1:0] pc_sel,
    input wire [31:0] imm_B,
    input wire [31:0] imm_J,
    input wire wb_sel,
    output wire [31:0] npc,
    output wire [31:0] wb_data
    );


    assign npc = (pc_sel == 2'b11)?pc4:(pc_sel == 2'b10)?(alu_c&32'hfffffffe):(pc_sel == 2'b01)?imm_J:(Branch & Branch_result == 1'b1)?imm_B:pc4;
    assign wb_data = (wb_sel == 1'b1)?mem_dout:alu_c;
endmodule
