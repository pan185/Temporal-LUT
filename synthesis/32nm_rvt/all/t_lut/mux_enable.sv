`include "DEF.sv"
module mux_enable
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active lo
    input logic [`DIM_A-1:0]select,
    input logic [`DIM_C-1:0][`ACC_WIDTH-1:0]in1, 
    input logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] in2,
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out 
);
    //logic [ADDR_WIDTH-1:0] out_;
    genvar i;
    genvar j;
    generate
	for (j = 0; j < `DIM_C; j = j+1) begin: test_gen_c
    		for (i = 0; i < `DIM_A; i = i+1) begin: test_gen_A
    			always_comb begin : proc_comb
				if (select[i]) begin
					out[j][i] = in1[j];
				end
				else begin
					out[j][i] = in2[j][i];
				end
        			
    			end
		end
	end
    endgenerate

endmodule
