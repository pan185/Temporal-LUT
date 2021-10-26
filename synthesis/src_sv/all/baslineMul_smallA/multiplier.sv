`include "DEF.sv"
module multiplier(
	input logic [`DIM_A-1:0][`INPUT_WIDTH-1:0] in4,
	input logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0] in8,
	output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] out12
);
	genvar i;
	genvar j;
	generate
	for (i = 0; i < `DIM_C; i = i+1) begin
        for (j = 0; j < `DIM_A; j = j+1) begin
	always_comb begin
		out12[i][j] = in4[j]*in8[i];
	end
	end
	end
	endgenerate
endmodule
