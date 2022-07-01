`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/27 14:03:37
// Design Name: 
// Module Name: control
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


module control(
    input wire [6:0] op,
    input wire [2:0] fun3,
    input wire [6:0] fun7,
    
    output wire [1:0] imm_sel,
    output wire [1:0] wD_sel,
    output wire wb_sel,
    output wire [1:0] pc_sel,
    output wire reg_WE,
    output wire WE,
    output wire Branch,
    output wire [2:0] ALU_op,
    output wire [1:0] B_sel,
    output wire op_A_sel,
    output wire op_B_sel
    );

    reg [1:0] imm_sel_reg;
    reg [1:0] wD_sel_reg;
    reg wb_sel_reg;
    reg [1:0] pc_sel_reg;
    reg WE_reg;
    reg reg_WE_reg;
    reg Branch_reg;
    reg [2:0] ALU_op_reg;
    reg [1:0] B_sel_reg;
    reg op_A_sel_reg;
    reg op_B_sel_reg;

    always @(*) begin
        case(op)
            7'b0110011:begin
                wD_sel_reg = 2'b1;
                wb_sel_reg = 1'b0;
                pc_sel_reg = 2'h3;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b1;
                Branch_reg = 1'b0;
                op_A_sel_reg = 1'b1;
                op_B_sel_reg = 1'b0;
                begin
                    case(fun7)
                        7'b0000000:
                        begin
                            case(fun3)
                                3'b000: ALU_op_reg = 3'b000;
                                3'b001: ALU_op_reg = 3'b001;
                                3'b100: ALU_op_reg = 3'b100;
                                3'b101: ALU_op_reg = 3'b101;
                                3'b110: ALU_op_reg = 3'b110;
                                3'b111: ALU_op_reg = 3'b111;
                            endcase
                        end
                        7'b0100000: 
                        begin
                            case(fun3)
                                3'b000: ALU_op_reg = 3'b010;
                                3'b101: ALU_op_reg = 3'b011;
                            endcase
                        end
                    endcase
                end

            end
            7'b0010011:begin
                imm_sel_reg = 2'b00;
                wD_sel_reg = 2'b1;
                wb_sel_reg = 1'b0;
                pc_sel_reg = 2'h3;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b1;
                Branch_reg = 1'b0;
                op_A_sel_reg = 1'b1;
                op_B_sel_reg = 1'b1;
                case(fun3)
                    3'b000: ALU_op_reg = 3'b000;
                    3'b111: ALU_op_reg = 3'b111;
                    3'b110: ALU_op_reg = 3'b110;
                    3'b100: ALU_op_reg = 3'b100;
                    3'b001: ALU_op_reg = 3'b001;
                    3'b101: begin
                        case(fun7)
                            7'b0000000: ALU_op_reg = 3'b101;
                            7'b0100000: ALU_op_reg = 3'b011;
                        endcase
                    end
                endcase
            end
            7'b0000011:begin
                imm_sel_reg = 2'b00;
                wD_sel_reg = 2'b1;
                wb_sel_reg = 1'b1;
                pc_sel_reg = 2'h3;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b1;
                Branch_reg = 1'b0;
                ALU_op_reg = 3'b000;
                op_A_sel_reg = 1'b1;
                op_B_sel_reg = 1'b1;
            end
            7'b1100111:begin
                imm_sel_reg = 2'b00;
                wD_sel_reg = 2'b0;
                pc_sel_reg = 2'b10;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b1;
                Branch_reg = 1'b0;
                ALU_op_reg = 3'b000;
                op_A_sel_reg = 1'b1;
                op_B_sel_reg = 1'b1;
            end
            7'b0100011: begin
                imm_sel_reg = 2'b01;
                wb_sel_reg = 1'b1;
                pc_sel_reg = 2'b11;
                WE_reg = 1'b1;
                reg_WE_reg = 1'b0;
                Branch_reg = 1'b0;
                ALU_op_reg = 3'b000;
                op_A_sel_reg = 1'b1;
                op_B_sel_reg = 1'b1;
            end
            7'b1100011: begin
                imm_sel_reg = 2'b11;
                pc_sel_reg = 2'b00;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b0;
                Branch_reg = 1'b1;
                case(fun3)
                    3'b000: B_sel_reg = 2'b00;
                    3'b001: B_sel_reg = 2'b01;
                    3'b100: B_sel_reg = 2'b10;
                    3'b101: B_sel_reg = 2'b11;
                endcase
            end
            7'b0110111: begin
                imm_sel_reg = 2'b10;
                wD_sel_reg = 2'b10;
                wb_sel_reg = 1'b0;
                pc_sel_reg = 2'b11;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b1;
                Branch_reg = 1'b0;
                ALU_op_reg = 3'b100;
                op_B_sel_reg = 1'b1;
            end
            7'b1101111: begin
                wD_sel_reg = 2'b0;
                pc_sel_reg = 2'b01;
                WE_reg = 1'b0;
                reg_WE_reg = 1'b1;
                Branch_reg = 1'b0;
            end
        endcase
    end

    assign imm_sel = imm_sel_reg;
    assign wD_sel = wD_sel_reg;
    assign wb_sel = wb_sel_reg;
    assign pc_sel = pc_sel_reg;
    assign reg_WE = reg_WE_reg;
    assign WE = WE_reg;
    assign Branch = Branch_reg;
    assign ALU_op = ALU_op_reg;
    assign B_sel = B_sel_reg;
    assign op_A_sel = op_A_sel_reg;
    assign op_B_sel = op_B_sel_reg;
endmodule
