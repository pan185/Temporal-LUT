////////////////////////////////////////////////////////////////////////////
// Author       : Jeneel / Prajyot
// Coursework   : ECE 751
// Module       : TLUT test-bench
// Description  : Test bench. That's all.
////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns
`include "simd_cell.sv"


module t_lut_tb ();
    //prajyotg :: Updating DEFs 
    parameter DIM_A = 9;
    //parameter DIM_B = 9;
    parameter DIM_C = 9;
    parameter INPUT_WIDTH = 4;
    parameter WEIGHT_WIDTH = 8;
    //prajyotg :: updating ACC_WIDTH parameter ACC_WIDTH = 16;
    parameter ACC_WIDTH = 13;

    logic   clk;
    logic   rst_n;
    logic   enable;
    logic   [DIM_A-1:0][INPUT_WIDTH-1:0]input_bin;
    //logic   [DIM_A-1:0][INPUT_WIDTH-1:0]input_reg;
    logic   [DIM_C-1:0][WEIGHT_WIDTH-1:0]weight_bin;
    //logic   [DIM_C-1:0][WEIGHT_WIDTH-1:0]weight_reg;
    //prajyotg :: removing Blogic   [DIM_C-1:0][DIM_A-1:0][ACC_WIDTH+DIM_B-1:0]product;ACC_WIDTH
    logic   [DIM_A-1:0][ACC_WIDTH-1:0]product;
    integer i=0;
    
    //logic [ACC_WIDTH-1:0] matP [2:0][2:0];
    
    //prajyotg :: Updated port names
	// multiplication_baseline DUT_multiplication_baseline(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .enable(enable),
	//     .in(input_bin),
	//     .weight(weight_bin),
	//     .out(product)
    // );

simd_cell t_lut
(
    .clk(clk),    // Clock
    .rst_n(rst_n),  // Asynchronous reset active low
    .enable(enable),
    .input_bin(input_bin), // input in binary
    .weight_bin(weight_bin), // weight in binary
    .product_acc(product)
);

	// input reg
//	register #(INPUT_WIDTH) U_reg_input[DIM_A-1:0](
//	    .clk(clk),
//	    .rst_n(rst_n),
//	    .in(input_bin),
//	    .out(input_reg)
//	);

//	// weight reg
//	register #(WEIGHT_WIDTH) U_reg_output[DIM_C-1:0](
//	    .clk(clk),
//	    .rst_n(rst_n),
//	    .in(weight_bin),
//	    .out(weight_reg)
//	);
    // clk define
    always #5 clk = ~clk;

    initial
    begin
        clk = 1;
        rst_n = 0;
	    enable = 0;
	    input_bin = {4'd8,4'd9,4'd10};
	    weight_bin = {8'd8,8'd9,8'd10};
        
        #30;
	    @(negedge clk);
        rst_n = 1;
	   
	    #5;
	    @(negedge clk);
	    enable = 1;
	    @(posedge clk);
	
        for (i=0; i<50; i=i+1)
   		@(posedge clk) ; 
	
        $finish;
    end
endmodule
