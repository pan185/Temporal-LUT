////////////////////////////////////////////////////////////////////////////
// Author       : Prajyot 
// Coursework   : ECE 751
// Module       : Multiplication test-bench
// Description  : Test bench. That's all.
////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns
`include "multiplication_baseline.sv"
module multiplication_baseline_tb ();
    //prajyotg :: Updating DEFs 
    parameter DIM_A = 8;
    parameter DIM_B = 1;
    parameter DIM_C = 1;
    parameter INPUT_WIDTH = 4;
    parameter WEIGHT_WIDTH = 8;
    //prajyotg :: updating ACC_WIDTH parameter ACC_WIDTH = 16;
    parameter ACC_WIDTH = 12;

    logic   clk;
    logic   rst_n;
    logic   enable;
    logic   [DIM_A-1:0][INPUT_WIDTH-1:0]input_bin;
    //logic   [DIM_A-1:0][INPUT_WIDTH-1:0]input_reg;
    logic   [DIM_C-1:0][WEIGHT_WIDTH-1:0]weight_bin;
    //logic   [DIM_C-1:0][WEIGHT_WIDTH-1:0]weight_reg;
    //prajyotg :: removing Blogic   [DIM_C-1:0][DIM_A-1:0][ACC_WIDTH+DIM_B-1:0]product;ACC_WIDTH
    logic   [DIM_C-1:0][DIM_A-1:0][ACC_WIDTH-1:0]product;
    integer i=0;

    //prajyotg :: Updated port names
	multiplication_baseline DUT_multiplication_baseline(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
	    .in(input_bin),
	    .weight(weight_bin),
	    .out(product)
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
	    //prajyotg : Input is [7:0]
	    input_bin = {4'd8,4'd9,4'd10,4'd11,4'd12,4'd13,4'd14,4'd15};
	    //prajyotg : Weight is [0:0] => 8'd1
	    //weight_bin = {8'd255, 8'd254, 8'd253, 8'd252, 8'd1};
	    weight_bin = {8'd1};
        
        #15;
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
