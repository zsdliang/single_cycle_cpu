module top(
    input  wire clk_i,
    input  wire rst_i,
    
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
	
	wire clk;
    wire rst_n = !rst_i;
    wire locked;
    wire [31:0] pc;
    wire [31:0] pc4;
    wire [31:0] npc;
    wire [31:0] inst;
    wire [31:0] imm;
    wire [31:0] imm_J;
    wire [6:0] op;
    wire [2:0] fun3;
    wire [6:0] fun7;
    wire [4:0] rR1;
    wire [4:0] rR2;
    wire [31:0] wD_reg;
    wire [31:0] rD1;
    wire [31:0] rD2;
    wire [1:0] imm_sel;
    wire [1:0] wD_sel;
    wire wb_sel;
    wire [1:0] pc_sel;
    wire WE_mem;
    wire WE_reg;
    wire Branch;
    wire [1:0] Branch_sel;
    wire Branch_result;
    wire [2:0] alu_op;
    wire [1:0] B_sel;
    wire op_A_sel;
    wire op_B_sel;
    wire [31:0] alu_c;
    wire [31:0] dout_mem;
    wire [31:0] data_wb;

    clk_wiz CLK_WIZ(
        .clk_in1(clk_i),
        .clk_out1(clk),
        .locked(locked)
    );


    IF IF_exa(
        .clk(clk),
        .rst_n(rst_n),
        .npc(npc),
        .pc(pc),
        .pc4(pc4)
    );

    ID ID_exa(
        .clk(clk),
        .pc(pc),
        .inst(inst),
        .imm_sel(imm_sel),
        .wdata(data_wb),
        .wD_sel(wD_sel),
        .we(WE_reg),
        .jaddr(imm_J),
        .imm(imm),
        .rdata1(rD1),
        .rdata2(rD2)
    );

    exe EXE_exa(
        .op_sel(alu_op),
        .branch_sel(Branch_sel),
        .op_A_sel(op_A_sel),
        .op_B_sel(op_B_sel),
        .pc(pc),
        .rD1(rD1),
        .rD2(rD2),
        .imm(imm),
        .out(alu_c),
        .branch(Branch_result)
    );

    

    wb WB_exa(
        .alu_c(alu_c),
        .mem_dout(dout_mem),
        .Branch(Branch),
        .Branch_result(Branch_result),
        .pc4(pc4),
        .pc_sel(pc_sel),
        .imm_B(imm),
        .imm_J(imm_J),
        .wb_sel(wb_sel),
        .npc(npc),
        .wb_data(data_wb)
    );

    control CONTROL_exa(
        .op(inst[6:0]),
        .fun3(inst[14:12]),
        .fun7(inst[31:25]),
        .imm_sel(imm_sel),
        .wD_sel(wD_sel),
        .wb_sel(wb_sel),
        .pc_sel(pc_sel),
        .reg_WE(WE_reg),
        .WE(WE_mem),
        .Branch(Branch),
        .ALU_op(alu_op),
        .B_sel(Branch_sel),
        .op_A_sel(op_A_sel),
        .op_B_sel(op_B_sel)
    );
    // ��������ģ�飬ֻ��Ҫʵ���������ߣ�����Ҫ�����ļ�
    prgrom imem(
            .a(pc[17:2]),
            .spo(inst)
    );

    
    MEM_or_IO mem_or_io(
        .clk_i(clk),
        .addr_from_cpu(alu_c),
        .data_from_cpu(rD2),
        .data_from_out(dout_mem),
        .WE(WE_mem),

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

endmodule
