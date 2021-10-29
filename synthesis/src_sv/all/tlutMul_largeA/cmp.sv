`include "DEF.sv"
module cmp 
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    input logic [`INPUT_WIDTH-1:0]rng,
    input logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]in,
    output logic [`DIM_A-1:0]cmp_out
);

    genvar i;
    generate
    for (i=0; i < `DIM_A; i = i+1) begin
    always_comb begin : proc_comb
        cmp_out[i] <= ~(|(in[i] ^ rng));
    end
    end
    endgenerate

endmodule