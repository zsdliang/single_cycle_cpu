`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 15:35:14
// Design Name: 
// Module Name: led
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


module led(
    input wire clk,
    input wire rst,
    input wire [31:0] data_to_led,
    input wire WE_led,
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

    wire rst_n = ~rst;
    reg [7:0]led_ena;
    reg [7:0]led;

    assign led0_en_o = led_ena[0];
    assign led1_en_o = led_ena[1];
    assign led2_en_o = led_ena[2];
    assign led3_en_o = led_ena[3];
    assign led4_en_o = led_ena[4];
    assign led5_en_o = led_ena[5];
    assign led6_en_o = led_ena[6];
    assign led7_en_o = led_ena[7];

    assign led_ca_o = led[7];
    assign led_cb_o = led[6];
    assign led_cc_o = led[5];
    assign led_cd_o = led[4];
    assign led_ce_o = led[3];
    assign led_cf_o = led[2];
    assign led_cg_o = led[1];
    assign led_dp_o = led[0];


    reg [12:0] cnt = 0;
    reg [12:0] cnt_end = 13'b1111111111111;
    // reg [1:0] cnt = 0;
    // reg [1:0] cnt_end = 2'b01;
    reg [2:0] counter = 0;  

    reg [7:0] led_display [0:15];

    always @ (*)
    begin
        if(~rst_n)
        begin
            led_display[0]  = 8'b00000011;//3
            led_display[1]  = 8'b10011111;//9f
            led_display[2]  = 8'b00100101;//25
            led_display[3]  = 8'b00001101;//d
            led_display[4]  = 8'b10011001;//99
            led_display[5]  = 8'b01001001;//49
            led_display[6]  = 8'b01000001;//41
            led_display[7]  = 8'b00011111;//1f
            led_display[8]  = 8'b00000001;//1
            led_display[9]  = 8'b00011001;//19
            led_display[10] = 8'b00010001;//11
            led_display[11] = 8'b11000001;//c1
            led_display[12] = 8'b11100101;//e5
            led_display[13] = 8'b10000101;
            led_display[14] = 8'b01100001;//61
            led_display[15] = 8'b01110001;//71
        end
    end

    always @ (posedge clk)
    begin
        if(cnt < cnt_end) cnt <= cnt + 1;
        else if(cnt == cnt_end) cnt <= 0; 
    end
    always @ (posedge clk)
    begin
        if(cnt == cnt_end) counter <= counter + 1;
    end

    //控制亮哪�?个数码管
    always @ (posedge clk)
    begin
        case(counter)
            'd0:led_ena <= 8'b11111110;
            'd1:led_ena <= 8'b11111101;
            'd2:led_ena <= 8'b11111011;
            'd3:led_ena <= 8'b11110111;
            'd4:led_ena <= 8'b11101111;
            'd5:led_ena <= 8'b11011111;
            'd6:led_ena <= 8'b10111111;
            'd7:led_ena <= 8'b01111111;
        endcase
    end

    //控制数码管具体亮的数�?
    always @ (posedge clk)
    begin
        case(counter)
            'd0:led <= led_display[data_to_led[3:0]]  ;
            'd1:led <= led_display[data_to_led[7:4]]  ;
            'd2:led <= led_display[data_to_led[11:8]] ;
            'd3:led <= led_display[data_to_led[15:12]];
            'd4:led <= led_display[data_to_led[19:16]];
            'd5:led <= led_display[data_to_led[23:20]];
            'd6:led <= led_display[data_to_led[27:24]];
            'd7:led <= led_display[data_to_led[31:28]];
        endcase
    end

endmodule
