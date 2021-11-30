////////////////////////////////////////////////////////////////////////////
// Author       : Prajyot 
// Coursework   : ECE 751
// Module       : simd_cell.sv
// Description  : Complete TLUT with adder trees implemented
////////////////////////////////////////////////////////////////////////////

`include "DEF.sv"

`include "accumulator_weight.sv"
`include "cmp.sv"
`include "register_product.sv"
`include "register_weight.sv"
`include "register_input.sv"

`include "rollover_cnt.sv"

module simd_cell 
(
    input  logic clk,    // Clock
    input  logic rst_n,  // Asynchronous reset active low
    input  logic enable,
    input  logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]input_bin,    // input in binary
    input  logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0]weight_bin,  // weight in binary
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_reg
    //prajyotg :: updating the output dimensions :: output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_reg
    output logic  [`DIM_A-1:0][`ACC_WIDTH-1:0] accumulated_mult;
);
    logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]input_reg;
    logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0]weight_reg;
    logic [`DIM_A-1:0]temporal; //single bit
    //logic enable_reg;
    logic [`DIM_C-1:0][`ACC_WIDTH-1:0] weight_acc;
    logic  rollover; //rollover signal for accumulating products
    logic [`INPUT_WIDTH-1:0] cntOut;

    //input register
    register_input U_reg_input(
    	.clk(clk),
    	.rst_n(rst_n),
    	.in(input_bin),
    	.out(input_reg)
    );
        
    //weight register
    register_weight U_reg_weight(
	    .clk(clk),
	    .rst_n(rst_n),
	    .in(weight_bin),
	    .out(weight_reg)
    );

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

	register_product U_reg_product(//[DIM_C-1:0][DIM_A-1:0](
		.clk(clk),
		.rst_n(rst_n),//&(~rollover_reg2)),
		.enable(temporal),
		.in(weight_acc),
		.out(product_reg)
	);


    // rollover counter
    rollover_cnt U_rollovercnt(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .cntOut(cntOut),
	    .rollover(rollover)
        );
    
    register_bit2 #(1) U_reg_rollover2(
        .clk(clk),
        .rst_n(rst_n),
        .in(rollover_reg),
        .out(rollover_reg2)
        );*/

endmodule