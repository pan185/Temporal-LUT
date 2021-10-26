`include "DEF.sv"
`include "register_input.sv"
`include "register_weight.sv"
`include "register_product.sv"
`include "multiplier.sv"

module multiplication_baseline 
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active lo
    input logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]in, // Val to be written to reg
    input logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0] weight,
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out // Val read out
);
    //logic [`INPUT_WIDTH-1:0] out_;
    logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]in_reg;
    logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0] weight_reg;
    logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out_reg;
    logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out_comb;

    //input register
    register_input U_reg_input(
	.clk(clk),
	.rst_n(rst_n),
	.in(in),
	.out(in_reg));
    //weight register
    register_input U_reg_weight(
	.clk(clk),
	.rst_n(rst_n),
	.in(weight),
	.out(weight_reg));
   //multiplier
   multiplier U_multipler(
	.in4(in_reg),
	.in8(weight_reg),
	.out12(out_comb)
	);

    //output register
    register_product U_reg_product(
	.clk(clk),
	.rst_n(rst_n),
	.in(out_comb),
	.out(out_reg));

   always_comb begin : proc_final_assign
        out <= out_reg;
    end
endmodule
