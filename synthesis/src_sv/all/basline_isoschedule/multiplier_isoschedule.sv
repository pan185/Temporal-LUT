////////////////////////////////////////////////////////////////////////////
// Author       : Aishwarya 
// Coursework   : ECE 751
// Module       : Multipier_isoschedule
// Description  : Multiplies one input and weight at a time.
////////////////////////////////////////////////////////////////////////////

`include "DEF.sv"
module multiplier_isoschedule(
	input  logic [`INPUT_WIDTH-1:0] in4,
	input  logic [`WEIGHT_WIDTH-1:0] in8,
	output logic [`ACC_WIDTH-1:0] out12
);

//Multiplier
	always_comb begin
		out12 = in4*in8;
	end

endmodule
