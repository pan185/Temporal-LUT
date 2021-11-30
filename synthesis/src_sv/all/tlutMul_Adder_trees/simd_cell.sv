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
`include "adder_tree.sv" 
`include "rollover_cnt.sv"

module simd_cell 
(
    input  logic clk,    // Clock
    input  logic rst_n,  // Asynchronous reset active low
    input  logic enable,
    input  logic [`DIM_ROW1 * `DIM_COL1-1:0][`INPUT_WIDTH-1:0]input_bin,    // input in binary
    input  logic [`DIM_ROW2 * `DIM_COL2-1:0][`WEIGHT_WIDTH-1:0]weight_bin,  // weight in binary
    //prajyotg :: moving it from output to logic :: output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_reg
    output logic  [`DIM_ROW1 * `DIM_COL2-1:0][`ACC_WIDTH-1:0] accumulated_mult
);
    logic [`DIM_ROW1 * `DIM_COL1-1:0][`INPUT_WIDTH-1:0]input_reg;
    logic [`DIM_ROW2 * `DIM_COL2-1:0][`WEIGHT_WIDTH-1:0]weight_reg;
    logic [`DIM_ROW1 * `DIM_COL1-1:0]temporal; //single bit
    //logic enable_reg;
    logic [`DIM_ROW2 * `DIM_COL2-1:0][`ACC_WIDTH-1:0] weight_acc;
    logic  rollover; //rollover signal for accumulating products
    logic [`INPUT_WIDTH-1:0] cntOut;
    //prajyotg:: updated it to logic
    logic [`DIM_ROW2 * `DIM_COL2-1:0][`DIM_ROW1 * `DIM_COL1-1:0][`ACC_WIDTH-1:0] product_reg;

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

    // Temporal Signal Generator
	cmp  U_cmp(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .rng(cntOut),
	    .in(input_reg),
	    .cmp_out(temporal)
    );

    // Weight accumulators
    accumulator_weight U_accumulator(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
	    .clear(rollover),
	    .val(weight_reg),
	    .sum(weight_acc)
    );

    // Generates the product terms in TLUT
	register_product U_reg_product(//[DIM_C-1:0][DIM_A-1:0](
		.clk(clk),
		.rst_n(rst_n),//&(~rollover_reg2)),
		.enable(temporal),
		.in(weight_acc),
		.out(product_reg)
	);

    // Accumulate Data-flow
    // Sums the products to give final matrix 
    adder_tree U_adder_tree(
        .clk(clk),
        .rst_n(rst_n),
        .prod(product_reg),
        .mult(accumulated_mult)
    );

    // rollover counter
    rollover_cnt U_rollovercnt(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .cntOut(cntOut),
	    .rollover(rollover)
        );
    
endmodule
