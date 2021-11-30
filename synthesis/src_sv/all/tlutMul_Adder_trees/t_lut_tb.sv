////////////////////////////////////////////////////////////////////////////
// Author       : Jeneel / Prajyot
// Coursework   : ECE 751
// Module       : TLUT test-bench
// Description  : Test bench for TLUT with adder trees
////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns
`include "simd_cell.sv"


module t_lut_tb ();
    //prajyotg :: Updating DEFs 
    localparam DIM_ROW1 = 3;
    localparam DIM_COL1 = 3;
    localparam DIM_ROW2 = 3;
    localparam DIM_COL2 = 3;
    localparam INPUT_WIDTH = 4;
    localparam WEIGHT_WIDTH = 4;
    //prajyotg :: updating ACC_WIDTH parameter ACC_WIDTH = 16;
    localparam ACC_WIDTH = 8;

    logic   clk;
    logic   rst_n;
    logic   enable;
    logic   [DIM_ROW1*DIM_COL1-1:0][INPUT_WIDTH-1:0]input_bin;
    logic   [DIM_ROW2*DIM_COL2-1:0][WEIGHT_WIDTH-1:0]weight_bin;
    logic   [DIM_ROW1*DIM_COL2-1:0][ACC_WIDTH-1:0]product;
    integer i=0;
    

    simd_cell t_lut
    (
        .clk(clk),    // Clock
        .rst_n(rst_n),  // Asynchronous reset active low
        .enable(enable),
        .input_bin(input_bin), // input in binary
        .weight_bin(weight_bin), // weight in binary
        .accumulated_mult(product)
    );

    always #5 clk = ~clk;

    initial
    begin
        clk = 1;
        rst_n = 0;
	    enable = 0;
	    input_bin  = {4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8};
	    weight_bin = {4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8};
        
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
