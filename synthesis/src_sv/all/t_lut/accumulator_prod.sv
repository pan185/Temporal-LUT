`include "DEF.sv"
module accumulator_prod  
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    input logic clear,
    input logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]val, // input val to be accumulated
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH+`DIM_B-1:0]sum
);
    logic[`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH+`DIM_B-1:0] sum_;

    genvar i;
    genvar j;
    generate
    for (j= 0; j < `DIM_C; j = j+1) begin: test_gen_c_product_acc
    for (i= 0; i < `DIM_A; i = i+1) begin: test_gen_a_product_acc
    always_ff @(posedge clk or negedge rst_n) begin : proc_1
        if(~rst_n) begin
            sum_[j][i] <= 0;
	end else if (clear) begin
	    sum_[j][i] <= 0;
        end else begin
		if (enable) begin
			sum_[j][i] <= sum_[j][i]+val[j][i];
		end
		else begin
			sum_[j][i] <= sum_[j][i];
		end
        end
    end
    end
    end
    endgenerate

    always_comb begin : proc_2
        sum <= sum_;
    end

endmodule