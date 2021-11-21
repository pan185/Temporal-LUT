////////////////////////////////////////////////////////////////////////////
// Author       : Aishwarya 
// Coursework   : ECE 751
// Module       : Multipication_baseline
// Description  : Iso-schedule baseline implementation.
////////////////////////////////////////////////////////////////////////////
`include "DEF.sv"
`include "register_input.sv"
`include "register_weight.sv"
`include "register_product_idx.sv"
`include "multiplier_isoschedule.sv"

module multiplication_baseline 
(
    input logic  clk,    // Clock
    input logic  rst_n,  // Asynchronous reset active lo
    //prajyot
    input logic  enable,
    input logic  [`DIM_A-1:0][`INPUT_WIDTH-1:0]in, // Val to be written to reg
    input logic  [`DIM_C-1:0][`WEIGHT_WIDTH-1:0] weight,
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out // Val read out
);
    //logic [`INPUT_WIDTH-1:0] out_;
    logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]in_reg;
    logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0] weight_reg;
    logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out_reg;
    //prajyotg :: making out_comb a 1-D vector
    logic [`ACC_WIDTH-1:0]out_comb;
    //prajyotg :: Updating counter to be a 3 bit value
    logic [2:0] cnt;

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 3'b0;
        end else begin
            cnt <= cnt + 3'b1;
        end
    end

    //input register
    register_input U_reg_input(
	.clk(clk),
	.rst_n(rst_n),
	.in(in),
	.out(in_reg));
    
    //weight register
    register_weight U_reg_weight(
	.clk(clk),
	.rst_n(rst_n),
	.in(weight),
	.out(weight_reg));

   //multiplier_isoschedule
    multiplier_isoschedule U_multipler_isoschedule(
	 .in4(in_reg[cnt]),
	 .in8(weight_reg),
     .out12(out_comb)
	);

    //output register
    register_product_idx U_reg_product_idx(
	.clk(clk),
	.rst_n(rst_n),
	//prajyotg :: .enable('1),
	.enable(enable),
	.in(out_comb),
	.idx(cnt),
	.out(out_reg));

   always_comb begin : proc_final_assign
        out <= out_reg;
    end
endmodule
