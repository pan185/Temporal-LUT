`include "DEF.sv"

`include "accumulator_weight.sv"
//`include "accumulator_prod.sv"

`include "cmp.sv"
//`include "cntWithEn.sv"

//`include "register_bit1.sv"
//`include "register_bit2.sv"
`include "register_product.sv"
`include "register_weight.sv"
`include "register_input.sv"
//`include "register_enable.sv"

`include "rollover_cnt.sv"
//`include "mux_enable.sv"
module simd_cell 
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    input logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]input_bin, // input in binary
    input logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0]weight_bin, // weight in binary
    //output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH+`DIM_B-1:0]product_acc
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_reg
);
    logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]input_reg;
    logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0]weight_reg;
    //logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_;
    logic [`DIM_A-1:0]temporal; //single bit
    //logic enable_reg;
    logic [`DIM_C-1:0][`ACC_WIDTH-1:0] weight_acc;
    logic  rollover; //rollover signal for accumulating products
    //logic  rollover_reg; //one cycle delayed version of rollover signal
    //logic  rollover_reg2; //two cycle delayed version of rollover signal
    //logic [`INPUT_WIDTH-1:0] cnt_unused;
    logic [`INPUT_WIDTH-1:0] cntOut;
    genvar i; // loop thru input (DIM_A)
    genvar j; // loop thru weight(DIM_C)

//input register
    register_input U_reg_input(
	.clk(clk),
	.rst_n(rst_n),
	.in(input_bin),
	.out(input_reg));
    //weight register
    register_weight U_reg_weight(
	.clk(clk),
	.rst_n(rst_n),
	.in(weight_bin),
	.out(weight_reg));

	cmp  U_cmp(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .rng(cntOut),
	.in(input_reg),
	.cmp_out(temporal)
        );

    // weight accumulators
    accumulator_weight U_accumulator(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
	.clear(rollover),
	.val(weight_reg),
	.sum(weight_acc)
        );

    /*mux_enable U_mux_enable(
        .clk(clk),
        .rst_n(rst_n),
        .select(temporal),
	.in1(weight_acc),
	.in2(product_reg),
	.out(product_)
        );*/


		register_product U_reg_product(//[DIM_C-1:0][DIM_A-1:0](
		.clk(clk),
		.rst_n(rst_n),//&(~rollover_reg2)),
		.enable(temporal),
		.in(weight_acc),
		.out(product_reg)
		);


    // product accumulators
    // note: use roll over counter of length=input bitwidth as enable signal
    // note: for early termination, use different enable signal
    //generate
	//for (j = 0; j < DIM_C; j = j+1) begin: test_gen_c_product_acc
	/*accumulator_prod U_accumulator_prod(//[DIM_C-1:0][DIM_A-1:0](
        .clk(clk),
        .rst_n(rst_n),
        .enable(rollover_reg2),
	.clear('0),
	.val(product_reg),
	.sum(product_acc)
        );*/
	//end
	//endgenerate

    // rollover counter
    rollover_cnt U_rollovercnt(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .cntOut(cntOut),
	.rollover(rollover)
        );
    //enable reg
    /*register_enable U_reg_enable(
        .clk(clk),
        .rst_n(rst_n),
        .in(enable),
        .out(enable_reg)
        );*/
    // rollover reg
    /*register_bit1 #(1) U_reg_rollover(
        .clk(clk),
        .rst_n(rst_n),
        .in(rollover),
        .out(rollover_reg)
        );
    // rollover reg
    register_bit2 #(1) U_reg_rollover2(
        .clk(clk),
        .rst_n(rst_n),
        .in(rollover_reg),
        .out(rollover_reg2)
        );*/


endmodule
