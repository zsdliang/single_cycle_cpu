`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/24 15:24:03
// Design Name: 
// Module Name: exe
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


module exe(
    input wire [2:0] op_sel,
    input wire [1:0] branch_sel,
    input wire op_A_sel,
    input wire op_B_sel,
    input wire [31:0] pc,
    input wire [31:0] rD1,
    input wire [31:0] rD2,
    input wire [31:0] imm,
    output wire [31:0] out,
    output wire branch
    );

    wire [31:0] A;
    wire [31:0] B;
    reg [31:0] out_reg;
    reg branch_reg;

    assign A = op_A_sel?rD1:pc;
    assign B = op_B_sel?imm:rD2;

    always @(*) begin
        if(op_sel==3'b000)   out_reg = A+B; 
        else if(op_sel==3'b010)  out_reg = A - B;
        else if(op_sel==3'b111)  out_reg = A & B;
        else if(op_sel==3'b110)  out_reg = A | B;
        else if(op_sel==3'b001)  out_reg = A << B[4:0];
        else if(op_sel==3'b101)  out_reg = A >> B[4:0];
        else if(op_sel==3'b011)  out_reg = ($signed(A)) >>> B[4:0];
        else out_reg = A ^ B;
    end

    always @(*) begin
        if(branch_sel == 2'b00)  branch_reg = (rD1 == rD2)?1:0;
        else if(branch_sel == 2'b01)  branch_reg = (rD1 != rD2)?1:0;
        else if(branch_sel == 2'b10)  branch_reg = (($signed(rD1) < ($signed(rD2))))?1:0;
        else  branch_reg = (($signed(rD1) >= ($signed(rD2))))?1:0;
    end 

    assign out = out_reg;
    assign branch = branch_reg;


endmodule
