`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/29 10:03:48
// Design Name: 
// Module Name: IF
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


module IF(
    input wire clk,
    input wire rst_n,
    input wire [31:0] npc,
    output reg [31:0] pc,
    output wire [31:0] pc4
    );
    
    reg temp = 0;
    always @(posedge clk) begin
        if(rst_n&& temp==0)begin
            temp <= 1;
        end 
        if(rst_n && temp) begin
            pc <= npc;
        end
        else pc <= 32'b0;
        if(~rst_n)begin
            temp <= 1'b0;
        end
    end
    
    assign pc4 = pc+4;
endmodule
