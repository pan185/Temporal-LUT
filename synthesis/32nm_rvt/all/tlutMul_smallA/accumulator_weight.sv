`include "DEF.sv"
module accumulator_weight
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    input logic clear,
    input logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0]val, // input val to be accumulated
    output logic [`DIM_C-1:0][`ACC_WIDTH-1:0]sum
);
    logic[`DIM_C-1:0][`ACC_WIDTH-1:0] sum_;
    genvar i;
    generate
    for (i=0; i<`DIM_C; i = i+1) begin
    always_ff @(posedge clk or negedge rst_n) begin : proc_1
        if(~rst_n) begin
            sum_[i] <= 0;
	end else if (clear) begin
	    sum_[i] <= 0;
        end else begin
		if (enable) begin
			sum_[i] <= sum_[i]+val[i];
		end
		else begin
			sum_[i] <= sum_[i];
		end
        end
    end
    end
    endgenerate

    always_comb begin : proc_2
        sum <= sum_;
    end

endmodule