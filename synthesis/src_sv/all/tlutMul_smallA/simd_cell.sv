`include "DEF.sv"

`include "accumulator_weight.sv"
//`include "accumulator_prod.sv"

`include "cmp.sv"
`include "cntWithEn.sv"

//`include "register_bit1.sv"
//`include "register_bit2.sv"
`include "register_product.sv"

`include "rollover_cnt.sv"
`include "mux_enable.sv"
//`include "tng.sv"
module simd_cell 
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    input logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]input_bin, // input in binary
    input logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0]weight_bin, // weight in binary
    //output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH+`DIM_B-1:0]product_acc
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_reg;
);
    logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_;
    //logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] product_reg;
    logic [`DIM_A-1:0]temporal; //single bit
    logic [`DIM_C-1:0][`ACC_WIDTH-1:0] weight_acc;
    logic  rollover; //rollover signal for accumulating products
    //logic  rollover_reg; //one cycle delayed version of rollover signal
    //logic  rollover_reg2; //two cycle delayed version of rollover signal
    logic [`INPUT_WIDTH-1:0] cnt_unused;
    logic [`INPUT_WIDTH-1:0] cntOut;
    genvar i; // loop thru input (DIM_A)
    genvar j; // loop thru weight(DIM_C)

    // Convert input binary to temporal signal
    /*tng #(INPUT_WIDTH) U_tng[DIM_A-1:0](
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
	.binary(input_bin),
	.temporal(temporal)
        );*/
    cntWithEn U_cntWithEn(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .cntOut(cntOut)
        );

	cmp  U_cmp(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .rng(cntOut),
	.in(input_bin),
	.cmp_out(temporal)
        );

    // weight accumulators
    accumulator_weight U_accumulator(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
	.clear(rollover),
	.val(weight_bin),
	.sum(weight_acc)
        );
    // use temporal signal as pass through signal
    /*generate
	for (j = 0; j < `DIM_C; j = j+1) begin: test_gen_c
    		for (i = 0; i < `DIM_A; i = i+1) begin: test_gen_A
    			always_ff @(posedge clk or negedge rst_n) begin : proc_1
        			if(~rst_n) begin
            				product_[j][i] <= 0;
        			end else begin
					if (temporal[i]) begin
						product_[j][i] <= weight_acc[j];
					end
					else begin
						product_[j][i] <= product_[j][i];
					end
        			end
    			end
		end
	end
    endgenerate*/
    mux_enable U_mux_enable(
        .clk(clk),
        .rst_n(rst_n),
        .select(temporal),
	.in1(weight_acc),
	.in2(product_reg),
	.out(product_)
        );

        // product reg
	//generate
	//for (j = 0; j < DIM_C; j = j+1) begin: test_gen_c_product_reg
		register_product U_reg_product(//[DIM_C-1:0][DIM_A-1:0](
		.clk(clk),
		.rst_n(rst_n),//&(~rollover_reg2)),
		.in(product_),
		.out(product_reg)
		);
	//end
	//endgenerate

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
        .cntOut(cnt_unused),
	.rollover(rollover)
        );
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
