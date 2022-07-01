`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/01 14:05:55
// Design Name: 
// Module Name: light
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


module light(
    input wire WE_light,
    input wire [32:0]data_in,
    output wire [23:0]light_out
    );
    assign light_out = data_in[23:0];
endmodule
