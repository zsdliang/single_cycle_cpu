`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/23 16:07:40
// Design Name: 
// Module Name: ID
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


module ID(
    input wire clk,
    input wire [31:0] pc,
    input wire [31:0] inst,
    input wire [1:0]  imm_sel,
    input wire [31:0] wdata,
    input wire [1:0] wD_sel,
    input wire we,
    
    output wire [31:0] jaddr,
    output wire [31:0] imm,
    output wire [31:0] rdata1,
    output wire [31:0] rdata2,
    output wire [31:0] wdata_out
    );

    reg  [31:0]Iimm;
    reg  [31:0]Simm;
    reg  [31:0]Uimm;
    reg  [31:0]Bimm;
    wire [4:0]addr1;
    wire [4:0]addr2;
    wire [4:0]waddr;
/*#################################### read or write reg*/

    reg [31:0] reg_array[31:0];

    assign addr1 = inst[19:15];
    assign addr2 = inst[24:20];
    assign waddr = inst[11:7];

    always @(posedge clk) begin
        if(we) reg_array[waddr] <= (wD_sel == 2'b1)?wdata:(wD_sel == 2'b0)?(pc+32'h4):imm;
    end
    
    assign wdata_out = (wD_sel == 2'b1)?wdata:(wD_sel == 2'b0)?(pc+32'h4):imm;
    assign rdata1 = (addr1 == 5'b0)? 32'b0:reg_array[addr1];
    assign rdata2 = (addr2 == 5'b0)? 32'b0:reg_array[addr2];
/*####################################*/
    always @(*) begin
      if(inst[31]==1) begin
            Iimm = {20'hfffff,inst[31:20]};
            Simm = {20'hfffff,inst[31:25],inst[11:7]};
            Uimm = inst[31:12] << 12;
            Bimm = pc+{19'h7ffff,inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
      end
        else begin
            Iimm = {20'h0,inst[31:20]};
            Simm = {20'h0,inst[31:25],inst[11:7]};
            Uimm = inst[31:12] << 12;
            Bimm = pc+{19'h0,inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
        end
    end
        
    assign jaddr = (inst[31] == 1)?(pc+{11'b11111111111,inst[31],inst[19:12],inst[20],inst[30:21],1'b0}):(pc+{11'b0,inst[31],inst[19:12],inst[20],inst[30:21],1'b0});
    assign imm = (imm_sel == 2'b00)?Iimm:((imm_sel == 2'b01)?Simm:((imm_sel == 2'b10)?Uimm:Bimm));
    




endmodule
