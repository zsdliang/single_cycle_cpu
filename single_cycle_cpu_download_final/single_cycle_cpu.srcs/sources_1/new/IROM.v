`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 23:45:12
// Design Name: 
// Module Name: IROM
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


module IROM(
    input [15:0] a,
    output [31:0] spo
    );
    
    reg [31:0] inst_mem [0:255];
    
    initial $readmemh ( "F:/file/exp/cpu/single_cycle_cpu_download_3/inst_rom.data", inst_mem );
    
    assign spo = inst_mem[a[7:0]];
endmodule
